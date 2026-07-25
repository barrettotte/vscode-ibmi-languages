**free
  // https://github.com/barrettotte/vscode-ibmi-languages/issues/55

  Exec SQL
    select max(amt) into :CurrentAmt
    from some_table
    // where something something something <=
    ;