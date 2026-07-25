       // https://github.com/barrettotte/vscode-ibmi-languages/issues/61
       //
     C*******************************
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
     C*******************************
     C     1             DO        10
     C     1             DO        3
     C     myvar         DSPLY
     C                   ENDDO                   
     C                   ENDDO
     C*
     C     1             DOW       5
     C     1             DO        2
     C     myvar         DSPLY
     C                   ENDDO
     C                   ENDDO
     C*******************************
     C* IFs
     C                   IF         *IN12=*ON
     C                   IF         *IN13=*OFF
     C     myvar         DSPLY
     C                   ELSE       
     C     myvar         DSPLY
     C                   ENDIF
     C                   ELSE
     C     myvar         DSPLY
     C                   ENDIF