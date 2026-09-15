// Run in a VS Code Extension Development Host; see tests/README.md.
// Snippets isolate editor matching and omit program declarations.

const assert = require("node:assert/strict");
const vscode = require("vscode");

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const fixed = (language, text) => "     C".padEnd(language === "rpg" ? 27 : 25) + text;

async function checkBrackets(language, markedSource, label, shouldMatch) {
  const first = markedSource.indexOf("|");
  const second = markedSource.indexOf("|", first + 1);
  assert.ok(first >= 0 && second > first, `Missing markers: ${label}`);

  const document = await vscode.workspace.openTextDocument({
    language,
    content: markedSource.replaceAll("|", ""),
  });
  const editor = await vscode.window.showTextDocument(document);
  const positions = [document.positionAt(first), document.positionAt(second - 1)];

  try {
    // Positive cases warm up each language before the negative cases run.
    // Let tokenization settle before checking that a position has no match.
    if (!shouldMatch) {
      await delay(200);
    }

    for (const [index, position] of positions.entries()) {
      const expected = shouldMatch ? positions[1 - index] : position;
      let passed = false;

      for (let attempt = 0; attempt < (shouldMatch ? 20 : 1); attempt++) {
        editor.selection = new vscode.Selection(position, position);
        await vscode.commands.executeCommand("editor.action.jumpToBracket");

        if (editor.selection.active.isEqual(expected)) {
          passed = true;
          break;
        }
        await delay(50);
      }
      assert.ok(passed, `${label}: unexpected jump from ${index === 0 ? "first" : "second"} marker`);
    }
  } finally {
    await vscode.commands.executeCommand("workbench.action.closeActiveEditor");
  }
}

exports.run = async () => {
  let count = 0;
  const check = async (language, source, label, shouldMatch) => {
    await checkBrackets(language, source, label, shouldMatch);
    count++;
  };

  // Exercise each punctuation pair in fully free, column-limited and fixed source.
  for (const [language, header, prefix] of [
    ["rpgle", "**FREE\n", ""],
    ["rpgle", "", "       "],
    ["rpgle", "", fixed("rpgle", "EVAL      ")],
    ["rpg", "", fixed("rpg", "")],
  ]) {
    for (const [open, close] of [["(", ")"], ["[", "]"], ["{", "}"]]) {
      await check(language, `${header}${prefix}|${open}value|${close}`, `${language}: ${open}${close}`, true);
    }
  }

  for (const [label, source] of [
    ["Nested expressions", "**FREE\nresult = |(1 + (2 * 3)|);"],
    ["Strings and comments", "**FREE\nresult = %trim|(')' +\n  // )\n  text|);"],
    ["LIKEDS declaration", "**FREE\ndcl-ds order likeds|(order_t|);"],
    ["LIKEREC declaration", "       dcl-ds order likerec|(ORDREC : *input|);"],
    ["Prototype declaration", "**FREE\ndcl-pr choose int|(10|) overload(first : second);"],
    ["Fully free directive", "**FREE\n/set ccsid|(*char : *utf8|)"],
    ["Column-limited directive", "      /set ccsid|(*char : *utf8|)"],
    ["SQL CASE expression", "**FREE\nexec sql select sum|(case when id > 0 then 1 else 0 end|)\n  into :result from items;"],
    ["SQL subquery", "       exec sql select id into :result from items\n         where id in |(select id from other_items|);"],
    ["Mixed source with file flags", "     FORDDTL    IF   F  120        DISK\n       result = |(1 + 2|);"],
  ]) {
    await check("rpgle", source, label, true);
  }

  for (const language of ["rpg", "rpgle"]) {
    await check(language, [
      "     C/EXEC SQL SELECT COUNT(*) INTO :RESULT FROM ITEMS",
      "     C+ WHERE ID IN |(SELECT CASE WHEN ID > 0 THEN 1 ELSE 0 END",
      "     C+ FROM OTHER_ITEMS|)",
      "     C/END-EXEC",
    ].join("\n"), `${language}: fixed SQL subquery`, true);
  }

  // Keywords must not participate in the native matcher, even when paired.
  // Keep these snippets free of punctuation pairs so Go to Bracket has no fallback.
  for (const [open, close] of [
    ["if", "endif"], ["if", "end"], ["dow", "enddo"], ["dou", "enddo"],
    ["select", "endsl"], ["for", "endfor"], ["for-each", "endfor"],
    ["monitor", "endmon"], ["begsr", "endsr"], ["dcl-ds", "end-ds"],
    ["dcl-enum", "end-enum"], ["dcl-pr", "end-pr"], ["dcl-pi", "end-pi"],
    ["dcl-proc", "end-proc"], ["exec sql", ";"],
  ]) {
    for (const [header, prefix] of [["**FREE\n", ""], ["", "       "]]) {
      const source = `${header}${prefix}|${open}\n${prefix}|${close}\n`;
      await check("rpgle", source, `RPGLE keywords: ${open}/${close}`, false);
    }
  }

  for (const language of ["rpg", "rpgle"]) {
    for (const [open, close] of [
      ["IFEQ", "ENDIF"], ["IFNE", "END"], ["DOWLT", "ENDDO"],
      ["DOUGE", "END"], ["DO", "END"],
      [language === "rpg" ? "SELEC" : "SELECT", "ENDSL"], ["BEGSR", "ENDSR"],
    ]) {
      await check(language, [
        fixed(language, "|" + open),
        fixed(language, "|" + close),
      ].join("\n"), `${language} fixed keywords: ${open}/${close}`, false);
    }
    await check(language,
      "     C/|EXEC SQL VALUES 1 INTO :RESULT\n     C/|END-EXEC",
      `${language}: SQL delimiters`, false);
  }

  for (const [language, label, source] of [
    ["rpgle", "Mixed program file flags", "     FORDDTL    |IF   F  120        DISK\n       |ENDIF;"],
    ["rpgle", "Mixed transitions file flags", "     FORDHDR    |IF   E           K DISK\n       |ENDIF;"],
    ["rpg", "RPG/400 file flags", "     FORDDTL  |IF   F 120        DISK\n" + fixed("rpg", "|ENDIF")],
    ["rpgle", "Fixed definition name", fixed("rpgle", "|IF") + "\n     D|END#1            S              5A"],
    ["rpgle", "Compiler directives", "**FREE\n/|IF DEFINED\n/|ENDIF"],
    ["rpgle", "Format directives", "     C/|FREE\n     C/|END-FREE"],
    ["rpgle", "String punctuation", "**FREE\ntext = '|(value|)';"],
    ["rpgle", "Comment punctuation", "**FREE\n// |(value|)"],
    ["rpg", "Fixed comment punctuation", "     C* |(value|)"],
  ]) {
    await check(language, source, label, false);
  }

  console.log(`Bracket matching: ${count} editor checks passed.`);
};
