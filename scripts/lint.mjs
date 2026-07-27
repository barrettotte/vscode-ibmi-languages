#!/usr/bin/env node
// Repository consistency checks.
// Run with `npm run lint`. Exits non-zero if any check fails.

import { readFileSync, existsSync, readdirSync } from "fs";
import { join, basename } from "path";
import { createRequire } from "module";

const require = createRequire(import.meta.url);

// Fatal findings. Anything pushed here fails the run.
const problems = [];

// Advisory findings, printed but not fatal. Used where a finding is real but
// fixing it safely depends on work that has not happened yet.
const warnings = [];

function fail(check, message) {
  problems.push({ check, message });
}

function warn(check, message) {
  warnings.push(`${check}: ${message}`);
}

/**
 * Parse JSON that may contain comments and trailing commas, which VS Code
 * permits in language configuration files.
 *
 * This walks the text character by character rather than stripping comments
 * with a regex, and the distinction matters: every language configuration in
 * this repository contains the literal pair ["/*", "*\/"], which a regex
 * stripper treats as the start of a comment and mangles.
 */
function parseJsonc(text, file) {
  let out = "";
  let inString = false;
  let escaped = false;

  for (let i = 0; i < text.length; i++) {
    const char = text[i];
    const next = text[i + 1];

    // Inside a string literal nothing is a comment, so copy it through.
    if (inString) {
      out += char;
      if (escaped) {
        escaped = false;
      } else if (char === "\\") {
        escaped = true;
      } else if (char === '"') {
        inString = false;
      }
      continue;
    }

    if (char === '"') {
      inString = true;
      out += char;
      continue;
    }

    // Block comment: skip to the closing delimiter.
    if (char === "/" && next === "*") {
      const end = text.indexOf("*/", i + 2);
      i = end < 0 ? text.length : end + 1;
      continue;
    }

    // Line comment: skip to the newline, but keep the newline so that
    // reported line numbers still line up with the original file.
    if (char === "/" && next === "/") {
      while (i < text.length && text[i] !== "\n") {
        i++;
      }
      out += "\n";
      continue;
    }

    out += char;
  }

  try {
    return JSON.parse(out.replace(/,(\s*[}\]])/g, "$1"));
  } catch (error) {
    fail("json", `${file}: ${error.message}`);
    return null;
  }
}

/** Read and parse a grammar, returning null if it could not be read. */
function readGrammar(path) {
  if (!existsSync(path)) {
    return null;
  }
  return parseJsonc(readFileSync(path, "utf8"), path);
}

const pkg = JSON.parse(readFileSync("package.json", "utf8"));
const languages = pkg.contributes?.languages ?? [];
const grammars = pkg.contributes?.grammars ?? [];

// ===================================== MANIFEST =====================================
//
// The manifest is the one file VS Code reads before anything else, and a wrong
// path in it fails silently: the extension loads, the language simply does not
// behave. This repository shipped for four years with the binder language
// pointing at a configuration file that was never created.

// Every path the manifest names must exist on disk.
for (const lang of languages) {
  if (lang.configuration && !existsSync(lang.configuration)) {
    fail(
      "manifest",
      `language "${lang.id}" points at a missing configuration: ${lang.configuration}`,
    );
  }
}

for (const grammar of grammars) {
  if (!existsSync(grammar.path)) {
    fail(
      "manifest",
      `grammar for "${grammar.language}" points at a missing file: ${grammar.path}`,
    );
  }
}

// Languages and grammars must correspond one to one. A language with no
// grammar gets no highlighting; a grammar for an undeclared language is dead.
const declaredLanguages = new Set(languages.map((lang) => lang.id));
const grammarLanguages = new Set(grammars.map((grammar) => grammar.language));

for (const id of declaredLanguages) {
  if (!grammarLanguages.has(id)) {
    fail("manifest", `language "${id}" has no grammar`);
  }
}

for (const id of grammarLanguages) {
  if (!declaredLanguages.has(id)) {
    fail("manifest", `grammar declares unknown language "${id}"`);
  }
}

// The scope name in the manifest must match the one inside the grammar file.
// If they disagree, VS Code loads the grammar under a name no theme rule and
// no test refers to.
for (const grammar of grammars) {
  const parsed = readGrammar(grammar.path);
  if (parsed && parsed.scopeName !== grammar.scopeName) {
    fail(
      "manifest",
      `${grammar.path}: scopeName is "${parsed.scopeName}" but the manifest says "${grammar.scopeName}"`,
    );
  }
}

// Grammar and configuration files that the manifest never references. These
// ship inside the package and are never loaded.
const referencedFiles = new Set([
  ...grammars.map((grammar) => basename(grammar.path)),
  ...languages
    .filter((lang) => lang.configuration)
    .map((lang) => basename(lang.configuration)),
]);

for (const dir of ["syntaxes", "configurations"]) {
  for (const file of readdirSync(dir)) {
    if (file.endsWith(".json") && !referencedFiles.has(file)) {
      fail("manifest", `${join(dir, file)} is not referenced by package.json`);
    }
  }
}

// ===================================== GRAMMAR ======================================
//
// Structural validation of each grammar. This is what a JSON schema would give
// us, done by hand to avoid the dependency and the network fetch.

// Keys TextMate recognises on a rule. Anything else is a typo, and a typo is
// silent: an unknown key is ignored, so a rule with "mach" instead of "match"
// simply never fires.
const RULE_KEYS = new Set([
  "comment",
  "name",
  "contentName",
  "match",
  "begin",
  "end",
  "while",
  "patterns",
  "captures",
  "beginCaptures",
  "endCaptures",
  "whileCaptures",
  "include",
  "applyEndPatternLast",
  "disabled",
  "repository",
]);

// Keys whose children are numbered capture groups rather than rules.
const CAPTURE_KEYS = [
  "captures",
  "beginCaptures",
  "endCaptures",
  "whileCaptures",
];

// Keys holding a regular expression.
const PATTERN_KEYS = ["match", "begin", "end", "while"];

// Compile regexes with the same engine VS Code uses, so "it compiles" means
// what it should. Oniguruma comes in with the grammar test runner.
const ONIGURUMA_PATH =
  "node_modules/textmate-grammar-test/node_modules/vscode-oniguruma";

let oniguruma = null;
try {
  oniguruma = require(`./../${ONIGURUMA_PATH}`);
  await oniguruma.loadWASM(readFileSync(`${ONIGURUMA_PATH}/release/onig.wasm`));
} catch {
  fail("setup", "could not load oniguruma; regex compilation was not checked");
}

for (const entry of grammars) {
  const grammar = readGrammar(entry.path);
  if (!grammar) {
    continue;
  }

  const file = basename(entry.path);
  const repository = grammar.repository ?? {};
  const includes = new Set();

  /**
   * Walk a grammar node.
   *
   * `kind` tells the walker what the node's own keys mean. Rule nodes have
   * TextMate keys; repository nodes have entry names the author chose; capture
   * nodes have group numbers. Only rule keys get validated.
   */
  const walk = (node, path, kind = "rule") => {
    if (Array.isArray(node)) {
      node.forEach((child, index) => walk(child, `${path}[${index}]`));
      return;
    }
    if (!node || typeof node !== "object") {
      return;
    }

    // Named or numbered containers: descend without validating their keys.
    if (kind === "repository" || kind === "captures") {
      for (const [name, child] of Object.entries(node)) {
        walk(child, `${path}.${name}`);
      }
      return;
    }

    // Flag unrecognised keys. The root object is skipped because it carries
    // grammar metadata such as $schema and scopeName rather than rule keys.
    for (const key of Object.keys(node)) {
      if (path !== "" && !RULE_KEYS.has(key)) {
        fail("grammar", `${file}: unrecognised key "${key}" at ${path}`);
      }
    }

    if (node.include?.startsWith("#")) {
      includes.add(node.include.slice(1));
    }

    // A begin/end rule needs a terminator, or it swallows the rest of the file.
    if (
      node.begin !== undefined &&
      node.end === undefined &&
      node.while === undefined
    ) {
      fail(
        "grammar",
        `${file}: rule at ${path} has "begin" but neither "end" nor "while"`,
      );
    }

    // A rule is either a single match or a begin/end pair, never both.
    if (node.match !== undefined && node.begin !== undefined) {
      fail("grammar", `${file}: rule at ${path} has both "match" and "begin"`);
    }

    if (oniguruma) {
      for (const key of PATTERN_KEYS) {
        if (typeof node[key] !== "string") {
          continue;
        }
        try {
          new oniguruma.OnigScanner([node[key]]);
        } catch (error) {
          fail(
            "grammar",
            `${file}: ${key} at ${path} does not compile: ${error.message}`,
          );
        }
      }
    }

    // Descend into the keys that hold further rules.
    for (const [key, value] of Object.entries(node)) {
      const childPath = path === "" ? key : `${path}.${key}`;
      if (key === "patterns") {
        walk(value, childPath);
      } else if (key === "repository") {
        walk(value, childPath, "repository");
      } else if (CAPTURE_KEYS.includes(key)) {
        walk(value, childPath, "captures");
      }
    }
  };

  walk(grammar, "");

  // A repository entry nothing includes is dead code, and dead code drifts
  // unnoticed: dds.pf carried an unreachable entry whose scope name referred
  // to dds.lf, having been copied from that grammar.
  for (const key of Object.keys(repository)) {
    if (!includes.has(key)) {
      fail("grammar", `${file}: repository entry "${key}" is never included`);
    }
  }

  // The reverse: an include naming an entry that does not exist.
  for (const key of includes) {
    if (!(key in repository)) {
      fail("grammar", `${file}: include "#${key}" has no repository entry`);
    }
  }
}

// ====================================== SCOPES ======================================
//
// A TextMate scope name must begin with a conventional root for any theme to
// colour it. A scope such as "rpgle.free.sql.end" matches no theme rule, so
// the token it names renders as plain text.
//
// Only leaf rules are checked. A begin/end container groups other rules and is
// deliberately uncoloured, so its name is free-form by design.
//
// These are advisory for now. The one grammar that still trips this, rpgle,
// has no fixtures, and renaming a scope there would change highlighting with
// no test to confirm the result. Set this to true once every grammar is
// covered by fixtures.
const SCOPES_ARE_FATAL = false;

const SCOPE_ROOTS = new Set([
  "comment",
  "constant",
  "entity",
  "invalid",
  "keyword",
  "markup",
  "meta",
  "punctuation",
  "source",
  "storage",
  "string",
  "support",
  "text",
  "variable",
]);

for (const entry of grammars) {
  const grammar = readGrammar(entry.path);
  if (!grammar) {
    continue;
  }

  const file = basename(entry.path);

  const walk = (node) => {
    if (Array.isArray(node)) {
      node.forEach(walk);
      return;
    }
    if (!node || typeof node !== "object") {
      return;
    }

    // A leaf rule is one that names a scope and matches text directly.
    if (typeof node.name === "string" && node.match !== undefined) {
      const root = node.name.split(".")[0];
      if (!SCOPE_ROOTS.has(root)) {
        const message = `${file}: leaf rule scope "${node.name}" has non-standard root "${root}"`;
        if (SCOPES_ARE_FATAL) {
          fail("scope", message);
        } else {
          warn("scope", message);
        }
      }
    }

    Object.values(node).forEach(walk);
  };

  walk(grammar.patterns);
  walk(grammar.repository);
}

// ===================================== PENDING ======================================
//
// Languages not yet worked through. The two checks below hold these to a lower
// standard so that unfinished work does not block the build: fixture coverage,
// and rule documentation.
//
// Remove a language from this list when its fixtures land. Doing so turns both
// checks on for it, which is the point: the list only ever shrinks, and a
// language cannot be called done while either check would fail.
const PENDING_LANGUAGES = new Set(["pnlgrp", "rpgle"]);

// =================================== DOCUMENTATION ==================================
//
// Every rule carrying a regular expression must have a "comment" saying what it
// matches.
//
// These patterns are dense, position-sensitive and frequently non-obvious. A
// lookbehind such as (?<=^.{5}(A|\s).{22}) is unreadable without a note saying
// it anchors to column 29 of a DDS specification. Absent the comment, the only
// way to understand a rule is to re-derive it from IBM documentation, which is
// the cost this project exists to remove.

for (const entry of grammars) {
  if (PENDING_LANGUAGES.has(entry.language)) {
    continue;
  }

  const grammar = readGrammar(entry.path);
  if (!grammar) {
    continue;
  }

  const file = basename(entry.path);

  const walk = (node, path) => {
    if (Array.isArray(node)) {
      node.forEach((child, index) => walk(child, `${path}[${index}]`));
      return;
    }
    if (!node || typeof node !== "object") {
      return;
    }

    const carriesRegex = PATTERN_KEYS.some(
      (key) => typeof node[key] === "string",
    );
    if (carriesRegex && typeof node.comment !== "string") {
      const scope = typeof node.name === "string" ? ` ("${node.name}")` : "";
      fail("documentation", `${file}: rule at ${path}${scope} has no comment`);
    }

    // The comment goes first so a rule reads as prose before regex. Editing a
    // grammar with a script appends new keys to the end, which is how rules
    // drift into carrying their explanation underneath the pattern it explains.
    if (
      typeof node.comment === "string" &&
      Object.keys(node)[0] !== "comment"
    ) {
      const scope = typeof node.name === "string" ? ` ("${node.name}")` : "";
      fail(
        "documentation",
        `${file}: rule at ${path}${scope} has "comment" after "${Object.keys(node)[0]}"; it must be the first key`,
      );
    }

    for (const [key, value] of Object.entries(node)) {
      walk(value, path === "" ? key : `${path}.${key}`);
    }
  };

  walk(grammar.patterns, "patterns");
  walk(grammar.repository, "repository");
}

// ==================================== EXTENSIONS ====================================
//
// Every declared file extension should have at least one fixture, otherwise a
// language can be declared and never exercised. The legacy System/38 variants
// went unexercised until this check was written.

const fixtureExtensions = new Set();

const collectExtensions = (dir) => {
  for (const entry of readdirSync(dir, { withFileTypes: true })) {
    const path = join(dir, entry.name);
    if (entry.isDirectory()) {
      collectExtensions(path);
      continue;
    }
    // Snapshots are generated output, not fixtures.
    if (entry.name.endsWith(".snap")) {
      continue;
    }
    const dot = entry.name.lastIndexOf(".");
    if (dot > 0) {
      fixtureExtensions.add(entry.name.slice(dot).toLowerCase());
    }
  }
};

if (existsSync("tests/fixtures")) {
  collectExtensions("tests/fixtures");
}

for (const lang of languages) {
  if (PENDING_LANGUAGES.has(lang.id)) {
    continue;
  }
  for (const extension of lang.extensions ?? []) {
    if (!fixtureExtensions.has(extension.toLowerCase())) {
      fail(
        "extensions",
        `no fixture uses "${extension}" (declared by language "${lang.id}")`,
      );
    }
  }
}

// ===================================== VERSION ======================================
//
// The version appears in three places and they drift apart quietly. The
// lockfile sat at 0.6.3 while the manifest read 0.6.26.

const lock = JSON.parse(readFileSync("package-lock.json", "utf8"));

if (lock.version !== pkg.version) {
  fail(
    "version",
    `package-lock.json is ${lock.version} but package.json is ${pkg.version}`,
  );
}

// The newest CHANGELOG heading should name the version being shipped.
const heading = readFileSync("CHANGELOG.md", "utf8").match(
  /^#{2,3}\s*(\S+)\s*$/m,
);

if (!heading) {
  fail("version", "no version heading found in CHANGELOG.md");
} else if (heading[1] !== pkg.version) {
  fail(
    "version",
    `CHANGELOG.md's newest entry is ${heading[1]} but package.json is ${pkg.version}`,
  );
}

// ====================================== REPORT ======================================

if (warnings.length > 0) {
  console.log("warnings (not fatal):");
  for (const warning of [...new Set(warnings)]) {
    console.log(`  ${warning}`);
  }
  console.log("");
}

if (problems.length === 0) {
  console.log("lint: no problems found");
  process.exit(0);
}

// Group by check so related findings read together.
const byCheck = new Map();
for (const problem of problems) {
  if (!byCheck.has(problem.check)) {
    byCheck.set(problem.check, []);
  }
  byCheck.get(problem.check).push(problem.message);
}

for (const [check, messages] of byCheck) {
  console.error(`\n${check}:`);
  for (const message of messages) {
    console.error(`  ${message}`);
  }
}

const count = problems.length;
console.error(`\nlint: ${count} problem${count === 1 ? "" : "s"}`);
process.exit(1);
