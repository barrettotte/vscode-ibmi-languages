     C* https://github.com/barrettotte/vscode-ibmi-languages/issues/96
     C*
     C                   exsr      DltClaims
     C                   exsr      DltAr
       ///free
       // some commented out SQLRPGLE
       // exec sql select count(*) from QSYS2.SYSTABLES;
       ///end-free

     C                   IF        POLTP2='PA' or POLTP2='AC' or
     C                             POLTP2='GP'
      *  xxxxxxxxxxxxxxxxxxx
     C                   CALL      'PGM068'      MyParms