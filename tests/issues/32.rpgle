       // https://github.com/barrettotte/vscode-ibmi-languages/issues/32
       //
       // If error during update, exit:
     C     *IN99         CABEQ     *ON           DAEXIT
     C                   ENDIF                                                  WKIPIN
     C                   ENDFOR