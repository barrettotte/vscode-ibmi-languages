// https://github.com/barrettotte/vscode-ibmi-languages/issues/29
//
**free
  ctl-opt main(main);
  ctl-opt option(*srcstmt:*nodebugio:*nounref) dftactgrp(*no);
  ctl-opt datfmt(*iso) timfmt(*iso);

  dcl-pr main extpgm('TESTR') end-pr;

  dcl-proc main;
    dsply ('Hello world');

    on-exit;
      *inlr = *on;
      return;
  end-proc;
