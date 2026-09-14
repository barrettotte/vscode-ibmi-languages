**FREE
// Regression for #199: fully free-form literals have no column-80 boundary.
// Member: LONGSTR   Compilable: yes
// Source: IBM i ILE RPG Reference, Fully free-form statements; Continuation Rules.
// https://www.ibm.com/docs/en/i/7.5.0?topic=statements-fully-free-form
// https://www.ibm.com/docs/en/i/7.6.0?topic=entries-continuation-rules
// Retrieved: 2026-09-14
// https://github.com/barrettotte/vscode-ibmi-languages/issues/199
ctl-opt dftactgrp(*no) main(main);

dcl-proc main;
  dcl-s text varchar(1000);
  dcl-s bytes char(100);
  dcl-s initial varchar(1000) inz('A declaration literal also continues past column 80 without losing its string scope.');

  // Closing quotes in columns 80, 81 and 82.
  text = '012345678901234567890123456789012345678901234567890123456789012345678';
  text = '0123456789012345678901234567890123456789012345678901234567890123456789';
  text = '01234567890123456789012345678901234567890123456789012345678901234567890';

  // An escaped apostrophe straddles columns 80 and 81.
  text = '012345678901234567890123456789012345678901234567890123456789012345678''quoted text';

  // A literal can begin after column 80 as well.
  text =                                                                         'starts after column 80';

  // A plus or minus in column 80 is ordinary text when the line continues.
  text = '012345678901234567890123456789012345678901234567890123456789012345678+more text';
  text = '012345678901234567890123456789012345678901234567890123456789012345678-more text';

  // Padding to column 80 does not make an earlier plus a continuation.
  text = '01234567890123456789012345678901234567890123456789012345678901234+    more text';

  // Real continuations beyond column 80, including a comment with a quote.
  text = 'A long character literal reaches beyond column 80 before it continues with a +
    // An apostrophe in this comment mustn't end the continued literal.
    plus, then carries on past column 80 on this line before continuing again with a -
    minus on the final line';
  text = 'The statement after the continued literal is separate';

  // A plus exactly in column 80 still continues at the physical line end.
  text = '012345678901234567890123456789012345678901234567890123456789012345678+
    resumed at the first nonblank';

  // Hexadecimal literals use the same unlimited columns and continuations.
  bytes = x'0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF';
  bytes = x'0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF0123456789ABCDEF+
    // A comment's quote must not close the hexadecimal literal.
    FEDCBA9876543210-
    0123456789ABCDEF';
  text = 'The statement after the hex literal is separate';
end-proc;
