# Contributing

This is a syntax-highlighting extension: it ships TextMate grammars and language configurations, and no runtime code.

```bash
npm ci
npm test              # tokenize every fixture, compare against its snapshot
npm run lint          # repository checks
npm run format:check  # prettier
```

Those three commands are what CI runs, and what the release workflow runs again before publishing.

## Trying a change

Press <kbd>F5</kbd> in VS Code to launch an Extension Development Host with the
extension loaded, then open a file from `tests/fixtures/`.

To see the scopes at the cursor, run **Developer: Inspect Editor Tokens and Scopes** from the command palette. 
That is the quickest way to tell a grammar problem from a theme that simply does not colour the scope you chose.

## Changing a grammar

Grammars live in `syntaxes/`. Two rules the linter enforces:

- **Every rule carrying a regular expression needs a `comment`, and it must be the first key.** Say what the rule matches in language terms, and record
  anything a reader would otherwise have to re-derive from IBM documentation: which source column a lookbehind anchors to, a scope name that looks wrong
  but is deliberate, why an alternation is ordered the way it is.
- **Scope names end in the language id** - `keyword.other.cl`, `constant.language.dds.pf` - and start with a [standard root](https://macromates.com/manual/en/language_grammars#naming_conventions), so themes colour them.

Then add a fixture that exercises it. `npm test` will fail with the snapshot diff; `npm run test:snap:update` accepts it once you have read the diff and agree with it.

### Things that have bitten us

Worth knowing before you write a rule:

- **`\b` does not work the way you expect in fixed-format languages.** In RPG a five-character operation butts straight against factor 2 - `CHAINSGSIAT05` -
  so a trailing `\b` never matches. In CL and CMD the variant characters `@ # $ § Æ Ø Å Ä Ö £ Ñ ¥` are valid in a name but are not word characters, so
  `\bQUAL\b` matches the first four characters of `qual@#$`. Spell out the character class instead of relying on a boundary.
- **A keyword alternation needs a trailing guard.** Without one, `*GE` matches the front of `*GENERIC`. 
  After editing any alternation, check that no longer name in the fixtures now has only its prefix highlighted.
- **Rule order decides which rule wins**, and a rule can be unreachable. A generic special-value rule reached before an operator rule will consume every
  operator, and the operator rule will never fire.

## Adding a fixture

Fixtures live in `tests/fixtures/<language>/` with a committed `.snap` beside them. See [tests/README.md](tests/README.md) for the snapshot format and
[tests/legacy/README.md](tests/legacy/README.md) for the historical samples.

- Write it from IBM documentation, and cite the document and the date in the member's own header comment.
- It should be **valid source for that language**. Where it cannot compile - an exhaustive keyword list, a deliberately malformed case - say so in the header.
- Keep constructs in the file type they belong to. For example in DDS: `RCDFMT` is a database and display keyword and not an ICF one
- If a fixture exposes a grammar bug, commit it first with the current, wrong snapshot, then fix the grammar separately. 
  The second diff is then exactly the correction.

Deliberately broken source belongs in `tests/legacy/`, not `tests/fixtures/`.
When a legacy sample exposes a defect, add an equivalent case to `fixtures/` as well - a case that lives only in `legacy/` is not a regression test.

## Releasing

See [docs/RELEASING.md](docs/RELEASING.md).
