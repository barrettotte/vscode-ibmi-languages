       // https://github.com/barrettotte/vscode-ibmi-languages/issues/63
     C*
     C                   FOR       i = 1 to 6 by 2
     C                   FOR       j = 1 to 2
     C     myvar         DSPLY
     C                   ENDFOR
     C                   ENDFOR
       for i = 1 to 6 by 2;
         for j = 1 to 2;
           dsply (myvar);
         endfor;
       endfor;