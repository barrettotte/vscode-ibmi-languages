**FREE
// Regression for #199: long RPG strings in an SQLRPGLE member.
// Member: SQLLONGSTR   Compilable: yes (SQL precompile required)
// Source: IBM i ILE RPG Reference, Fully free-form statements.
// https://www.ibm.com/docs/en/i/7.5.0?topic=statements-fully-free-form
// Retrieved: 2026-09-14
// https://github.com/barrettotte/vscode-ibmi-languages/issues/199
ctl-opt dftactgrp(*no) main(main);

dcl-proc main;
  dcl-s status varchar(200);
  exec sql set option commit = *none, closqlcsr = *endmod;
  exec sql values '00000' into :status;

  if sqlstate = '00000';
    write_joblog('Si è verificato un errore nell''estrazione della configurazione della flashcopy');
  endif;

  write_joblog('ciao come ti chiami? andrea buzzi grazie, e tu? io mi chiamo gennaro ');
  write_joblog('A later call must still highlight normally');

  // SQL strings have their own rules, including quotes after column 80.
  exec sql values 'An SQL literal also reaches beyond column 80, and this apostrophe isn''t a terminator'
    into :status;
end-proc;

dcl-proc write_joblog;
  dcl-pi *n;
    message varchar(1000) const;
  end-pi;
end-proc;
