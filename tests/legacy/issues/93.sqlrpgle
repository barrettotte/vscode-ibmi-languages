      * https://github.com/barrettotte/vscode-ibmi-languages/issues/93
      *
     C     NameTif       BEGSR
      * Determine IR image name
     C                   EXSR      POP                                          Get next number
     C                   MOVE      'UNDR'        @IRDRW            4
     CSR   POP           BEGSR
      *
     C* Pop next tif file number from the queue
     C                   CALL      'ARRT511A'
     C                   PARM                    RTRN              7
     C                   PARM      'TIF'         TYPE              3
     C                   PARM                    NXTTIF            9 0
     C                   MOVEL     NXTTIF        UNIQUE           10
     C                   ENDSR
      *-------------------------DefineCursor
     C     DefineCursor  BEGSR