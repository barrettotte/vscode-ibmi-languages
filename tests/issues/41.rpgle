// https://github.com/barrettotte/vscode-ibmi-languages/issues/41

**free 

dcl-pr openFile pointer extproc('_C_IFS_fopen');
  *n pointer value; // file name
  *n pointer value; // file mode
end-pr;

dcl-pr main extpgm('IFSREAD');
  *n char(127);
  *n char(4096);
end-pr;
