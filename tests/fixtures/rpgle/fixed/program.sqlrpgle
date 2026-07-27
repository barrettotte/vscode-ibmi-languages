      *
      * A whole program with embedded SQL in column-limited source. The same
      * customer balance report the fully free-form version prints, so the
      * two can be read side by side.
      *
      * Member: SQLREG    Compilable: complete program, but not built; its
      *         tables and printer file are not defined here
      * Source: IBM i 7.5 Embedded SQL programming, embedding SQL statements
      *         in ILE RPG applications that use SQL.
      * Retrieved: 2026-07-27
      *
      *
     H* Control and file specifications.
     HDFTACTGRP(*NO) ACTGRP('QILE')
     HOPTION(*SRCSTMT : *NODEBUGIO)
     FBALPRT    OF      132        PRINTER OFLIND(*INOF)
     D*
     D* Host variables and a named constant.
     DCUSTNBR          S              7P 0
     DCUSTNM           S             30A
     DCUSTBAL          S             11P 2
     DBALIND           S              5I 0
     DGRANDTOT         S             13P 2 INZ(0)
     DROWSREAD         S             10I 0 INZ(0)
     DMINBAL           C                   CONST(100.00)
     C*
     C* Options, then the cursor that drives the report.
     C/EXEC SQL SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD
     C/END-EXEC
     C/EXEC SQL WHENEVER SQLERROR CONTINUE
     C/END-EXEC
     C/EXEC SQL DECLARE BALCSR CURSOR FOR
     C+ SELECT CUSNBR, CUSNAM, CUSBAL
     C+ FROM CUSTMAST
     C+ WHERE CUSBAL >= :MINBAL
     C+ ORDER BY CUSBAL DESC
     C+ FOR READ ONLY
     C/END-EXEC
     C/EXEC SQL OPEN BALCSR
     C/END-EXEC
     C*
     C* The fetch loop. SQLCODE comes from the SQLCA.
     C                   IF        SQLCODE < 0
     C                   EXCEPT    SQLFAIL
     C                   RETURN
     C                   ENDIF
     C                   EXCEPT    HEADING
     C                   DOW       SQLCODE = 0
     C/EXEC SQL FETCH NEXT FROM BALCSR
     C+ INTO :CUSTNBR, :CUSTNM, :CUSTBAL :BALIND
     C/END-EXEC
     C                   IF        SQLCODE <> 0
     C                   LEAVE
     C                   ENDIF
     C                   EVAL      ROWSREAD = ROWSREAD + 1
     C                   EVAL      GRANDTOT = GRANDTOT + CUSTBAL
     C                   EXCEPT    DETAIL
     C                   ENDDO
     C/EXEC SQL CLOSE BALCSR
     C/END-EXEC
     C                   EXCEPT    TOTALS
     C                   SETON                                            LR
     O*
     O* Output specifications close the program.
     OBALPRT    HF   1P                     2
     O                                           40 'CUSTOMER BALANCES'
     OBALPRT    E            DETAIL         1
     O                       CUSTNM              30
     O                       CUSTBAL       1     48
     OBALPRT    E            TOTALS      2
     O                                           30 'GRAND TOTAL'
     O                       GRANDTOT      1     48
     OBALPRT    E            SQLFAIL        1
     O                                           40 'SQL OPEN FAILED'
