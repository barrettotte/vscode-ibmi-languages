// Run in a VS Code Extension Development Host; see tests/README.md.
// These tests exercise the editor's bracket engine, which grammar snapshots cannot cover.
// The snippets isolate matching and omit program declarations.

const assert = require("node:assert/strict");
const vscode = require("vscode");

const delay = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const fixed = (language, opcode) => "     C".padEnd(language === "rpg" ? 27 : 25) + opcode;

async function checkPair(language, markedSource, label) {
  const first = markedSource.indexOf("|");
  const second = markedSource.indexOf("|", first + 1);
  assert.ok(first >= 0 && second > first, `Missing markers: ${label}`);

  const document = await vscode.workspace.openTextDocument({
    language,
    content: markedSource.replaceAll("|", ""),
  });
  const editor = await vscode.window.showTextDocument(document);
  const opening = document.positionAt(first);
  const closing = document.positionAt(second - 1);

  try {
    // Retry briefly while language configuration and tokenization reach the editor.
    // A missing pair must still fail after this bounded wait.
    let matched = false;
    for (let attempt = 0; attempt < 20; attempt++) {
      editor.selection = new vscode.Selection(opening, opening);
      await vscode.commands.executeCommand("editor.action.jumpToBracket");

      if (editor.selection.active.isEqual(closing)) {
        matched = true;
        break;
      }
      await delay(50);
    }
    assert.ok(matched, `Opening bracket did not match: ${label}`);

    editor.selection = new vscode.Selection(closing, closing);
    await vscode.commands.executeCommand("editor.action.jumpToBracket");
    assert.ok(editor.selection.active.isEqual(opening), `Closing bracket did not match: ${label}`);

  } finally {
    await vscode.commands.executeCommand("workbench.action.closeActiveEditor");
  }
}

exports.run = async () => {
  const cases = [
    ["rpgle", "**FREE\n", "", "if", "endif"],
    ["rpgle", "**FREE\n", "", "dow", "enddo"],
    ["rpgle", "**FREE\n", "", "dou", "enddo"],
    ["rpgle", "**FREE\n", "", "select", "endsl"],
    ["rpgle", "**FREE\n", "", "for", "endfor"],
    ["rpgle", "**FREE\n", "", "for-each", "endfor"],
    ["rpgle", "**FREE\n", "", "monitor", "endmon"],
    ["rpgle", "**FREE\n", "", "begsr", "endsr"],
    ["rpgle", "**FREE\n", "", "dcl-ds", "end-ds"],
    ["rpgle", "**FREE\n", "", "dcl-enum", "end-enum"],
    ["rpgle", "**FREE\n", "", "dcl-pr", "end-pr"],
    ["rpgle", "**FREE\n", "", "dcl-pi", "end-pi"],
    ["rpgle", "**FREE\n", "", "dcl-proc", "end-proc"],
    ["rpgle", "**FREE\n", "", "exec sql", ";"],
  ];

  // Traditional calculation opcodes begin in column 26 for RPGLE and 28 for RPG/400.
  for (const language of ["rpgle", "rpg"]) {
    for (const [open, close] of [
      ["ifeq", "endif"],
      ["ifne", "end"],
      ["doweq", "enddo"],
      ["doueq", "enddo"],
      ["doueq", "end"],
      ["do", "end"],
      [language === "rpg" ? "selec" : "select", "endsl"],
      [language === "rpg" ? "selec" : "select", "end"],
      ["begsr", "endsr"],
    ]) {
      cases.push([language, "", fixed(language, ""), open, close]);
    }
  }

  for (const language of ["rpgle", "rpg"]) {
    const prefix = language === "rpgle" ? "**FREE\n" : "";
    const column = language === "rpg" ? fixed(language, "") : "";
    await checkPair(language, `${prefix}${column}|(value|)`, `${language}: ()`);
  }

  let count = 2;
  for (const [language, header, column, open, close] of cases) {
    for (const [left, right] of [
      [open, close],
      [open.toUpperCase(), close.toUpperCase()],
      [open[0].toUpperCase() + open.slice(1), close.toUpperCase()],
    ]) {
      await checkPair(
        language,
        `${header}${column}|${left}\n${column}|${right}\n`,
        `${language}: ${left}/${right}`,
      );
      count++;
    }
  }

  await checkPair(
    "rpgle",
    "**FREE\n|If ready;\n  endifFlag = 1;\n  text = 'endif';\n  // ENDIF\n  if nested;\n  endif;\n|ENDIF;\n",
    "Nested blocks, identifiers, strings and comments",
  );
  count++;

  // IBM ILE RPG Reference: Enumerations, Conditional Compilation Directives,
  // and /FREE ... /END-FREE. Retrieved 2026-09-14.
  // https://www.ibm.com/docs/en/i/7.6.0?topic=definitions-enumerations
  // https://www.ibm.com/docs/it/ssw_ibm_i_76/pdf/sc092508.pdf
  const declarationCases = [
    [
      "Enumeration constants and comments cannot close the enumeration",
      [
        "**FREE",
        "|dcl-enum words qualified;",
        "  closing 'end-enum';",
        "  // end-enum;",
        "|end-enum words;",
      ],
    ],
    [
      "An enumeration does not interfere with its enclosing procedure",
      [
        "**FREE",
        "|dcl-proc process;",
        "  dcl-enum colours qualified;",
        "    red 1;",
        "    green 2;",
        "  end-enum;",
        "|end-proc;",
      ],
    ],
    [
      "Nested compilation directives still match their IF and ENDIF keywords",
      [
        "**FREE",
        "/|if defined(DEBUG)",
        "/if defined(NESTED)",
        "if ready;",
        "endif;",
        "/endif",
        "/|endif",
      ],
    ],
    [
      "An IF ending inside conditional branches keeps its existing match",
      [
        "**FREE",
        "|if ready;",
        "/if defined(DEBUG)",
        "endif;",
        "/else",
        "|endif;",
        "/endif",
      ],
    ],
    [
      "Directive operands retain parenthesis matching",
      ["      /set ccsid|(*char : *utf8|)", "      /restore ccsid(*char)"],
    ],
    [
      "Fully free directive operands retain parenthesis matching",
      ["**FREE", "/set ccsid|(*char : *utf8|)", "/restore ccsid(*char)"],
    ],
  ];
  for (const prefix of ["      ", "     C", "08010C"]) {
    declarationCases.push([
      "IF can span free and fixed sections without END-FREE closing it",
      [
        prefix + "/free",
        "       |if ready;",
        prefix + "/end-free",
        fixed("rpgle", "EVAL      value = 1"),
        prefix + "/free",
        "       |endif;",
        prefix + "/end-free",
      ],
    ]);
    declarationCases.push([
      "A fixed IF can contain a free section",
      [
        fixed("rpgle", "|IF        ready"),
        prefix + "/free",
        "       value = 1;",
        prefix + "/end-free",
        fixed("rpgle", "|ENDIF"),
      ],
    ]);
  }
  for (const [label, lines] of declarationCases) {
    const source = lines.join("\n") + "\n";
    for (const content of [source, source.toUpperCase()]) {
      await checkPair("rpgle", content, label);
      count++;
    }
  }

  const sqlCases = [
    [
      "RPG SELECT around SQL SELECT, subqueries and CASE END",
      [
        "**FREE",
        "|select;",
        "when ready;",
        "  exec sql select case when id > 0 then 1 else 0 end",
        "    into :result from items",
        "    where id in (select id from other_items);",
        "other;",
        "  exec sql values case when 1 = 1 then 1 else 0 end into :result;",
        "|endsl;",
      ],
    ],
    [
      "Nested RPG SELECT blocks with SQL between them",
      [
        "**FREE",
        "|select;",
        "when ready;",
        "  select;",
        "  when nested;",
        "    exec sql select count(*) into :result from items;",
        "  endsl;",
        "|endsl;",
      ],
    ],
    [
      "SQL CASE END cannot close an enclosing RPG IF",
      [
        "**FREE",
        "|if ready;",
        "  exec sql values case when 1 = 1 then 1 else 0 end into :result;",
        "|endif;",
      ],
    ],
    [
      "SQL SELECT and CASE END preserve EXEC SQL matching",
      [
        "**FREE",
        "|exec sql select case when id > 0 then 1 else 0 end",
        "  into :result from items|;",
      ],
    ],
    [
      "SQL host variables named SELECT and END are not RPG delimiters",
      ["**FREE", "|exec sql values :select into :end|;"],
    ],
    [
      "SQL parentheses still match around CASE END",
      [
        "**FREE",
        "exec sql select sum|(case when id > 0 then 1 else 0 end|)",
        "  into :result from items;",
      ],
    ],
    [
      "SQL parentheses still match around a SELECT subquery",
      [
        "**FREE",
        "exec sql select count(*) into :result from items",
        "  where id in |(select id from other_items|);",
      ],
    ],
    [
      "Column-limited free RPG SELECT around SQL SELECT",
      [
        "       |select;",
        "       when ready;",
        "         exec sql select count(*) into :result from items;",
        "       |endsl;",
      ],
    ],
  ];
  for (const [label, lines] of sqlCases) {
    await checkPair("rpgle", lines.join("\n") + "\n", label);
    count++;
  }

  // .sqlrpg uses the rpg grammar; .sqlrpgle uses rpgle. Exercise both SQL scope sets.
  for (const language of ["rpgle", "rpg"]) {
    const traditionalSqlCases = [
      [
        "RPG SELECT END around C/EXEC SQL",
        [
          fixed(language, language === "rpg" ? "|SELEC" : "|SELECT"),
          fixed(language, "OTHER"),
          "     C/EXEC SQL",
          "     C+ SELECT CASE WHEN ID > 0 THEN 1 ELSE 0 END",
          "     C+ INTO :RESULT FROM ITEMS",
          "     C/END-EXEC",
          fixed(language, "|END"),
        ],
      ],
      [
        "SQL terminators match their own opener",
        [
          "     C/|EXEC SQL",
          "     C+ SELECT CASE WHEN ID > 0 THEN 1 ELSE 0 END",
          "     C+ INTO :RESULT FROM ITEMS",
          "     C/|END-EXEC",
        ],
      ],
      [
        "SQL host variables named SELECT and END are not RPG delimiters",
        [
          "     C/|EXEC SQL VALUES :SELECT INTO :END",
          "     C/|END-EXEC",
        ],
      ],
      [
        "SQL parentheses match around a subquery containing CASE END",
        [
          "     C/EXEC SQL SELECT COUNT(*) INTO :RESULT FROM ITEMS",
          "     C+ WHERE ID IN |(SELECT CASE WHEN ID > 0 THEN 1 ELSE 0 END",
          "     C+ FROM OTHER_ITEMS|)",
          "     C/END-EXEC",
        ],
      ],
    ];
    for (const [label, lines] of traditionalSqlCases) {
      const source = lines.join("\n") + "\n";
      for (const content of [
        source,
        source.toLowerCase(),
        source.replaceAll("SELEC", "Selec").replaceAll("EXEC", "Exec"),
      ]) {
        await checkPair(language, content, `${language}: ${label}`);
        count++;
      }
    }
  }
  console.log(`Bracket matching: ${count} editor checks passed.`);

};
