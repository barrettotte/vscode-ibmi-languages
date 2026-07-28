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
     HOPTION(*SRCSTMT : *NODEBUGIO) DATFMT(*ISO)
     FBALPRT    OF      132        PRINTER OFLIND(*INOF)
     D*
     D* Host variables, a named constant, and the two structures SQL
     D* fetches into: one row, and an array of ten for a blocked fetch.
     DCOMPANY          S              3A
     DASOFDATE         S               D   DATFMT(*ISO)
     DCUSTNBR          S              7P 0
     DCUSTBAL          S             11P 2
     DBALIND           S              5I 0
     DGRANDTOT         S             13P 2 INZ(0)
     DROWSREAD         S             10I 0 INZ(0)
     DROWSUPD          S             10I 0 INZ(0)
     DRUNDATE          S               D   DATFMT(*ISO)
     DERRTEXT          S            132A   VARYING
     DIDX              S             10I 0
     DMINBAL           C                   CONST(100.00)
     DCUSTROW          DS                  QUALIFIED
     D NUMBER                         7P 0
     D NAME                          30A
     D BALANCE                       11P 2
     D BAND                           1A
     DTOPROWS          DS                  QUALIFIED DIM(10)
     D NUMBER                         7P 0
     D BALANCE                       11P 2
     DLIMIT            S             11P 2
     DCREDITLIM        PR            11P 2
     DFORCUST                         7P 0 CONST
     C*
     C* The entry list, then the options and the working table.
     C     *ENTRY        PLIST
     C                   PARM                    COMPANY
     C                   PARM                    ASOFDATE
     C/EXEC SQL SET OPTION COMMIT = *CHG, CLOSQLCSR = *ENDMOD
     C/END-EXEC
     C/EXEC SQL WHENEVER SQLERROR CONTINUE
     C/END-EXEC
     C/EXEC SQL VALUES CURRENT DATE INTO :RUNDATE
     C/END-EXEC
     C/EXEC SQL DECLARE GLOBAL TEMPORARY TABLE SESSION.BALWORK (
     C+   CUSNBR DECIMAL(7, 0) NOT NULL,
     C+   CUSNAM CHAR(30) NOT NULL,
     C+   CUSBAL DECIMAL(11, 2) NOT NULL DEFAULT 0,
     C+   BANDCD CHAR(1) NOT NULL
     C+ ) WITH REPLACE ON COMMIT PRESERVE ROWS
     C/END-EXEC
     C*
     C* A common table expression feeds the insert, joined to the
     C* orders, grouped, and banded with a CASE expression.
     C/EXEC SQL INSERT INTO SESSION.BALWORK
     C+ WITH ACTIVE AS (
     C+   SELECT CUSNBR, CUSNAM
     C+     FROM CUSTMAST
     C+    WHERE CUSSTS = 'A' AND CUSCMP = :COMPANY
     C+ )
     C+ SELECT A.CUSNBR,
     C+        A.CUSNAM,
     C+        SUM(O.ORDAMT),
     C+        CASE WHEN SUM(O.ORDAMT) >= 1000 THEN 'A'
     C+             WHEN SUM(O.ORDAMT) >= 100  THEN 'B'
     C+             ELSE 'C'
     C+        END
     C+   FROM ACTIVE A
     C+        INNER JOIN ORDERS O
     C+                ON O.CUSNBR = A.CUSNBR
     C+  WHERE O.ORDDAT <= :ASOFDATE
     C+  GROUP BY A.CUSNBR, A.CUSNAM
     C+ HAVING SUM(O.ORDAMT) >= :MINBAL
     C/END-EXEC
     C                   IF        SQLCODE < 0
     C                   EXSR      SQLFAIL
     C                   RETURN
     C                   ENDIF
     C/EXEC SQL GET DIAGNOSTICS :ROWSUPD = ROW_COUNT
     C/END-EXEC
     C*
     C* The cursor and its fetch loop. The row comes back into a
     C* structure rather than a list of separate variables.
     C/EXEC SQL DECLARE BALCSR CURSOR FOR
     C+ SELECT CUSNBR, CUSNAM, CUSBAL, BANDCD
     C+   FROM SESSION.BALWORK
     C+  ORDER BY CUSBAL DESC
     C+  FOR READ ONLY
     C/END-EXEC
     C/EXEC SQL OPEN BALCSR
     C/END-EXEC
     C                   IF        SQLCODE < 0
     C                   EXSR      SQLFAIL
     C                   RETURN
     C                   ENDIF
     C                   EXCEPT    HEADING
     C                   DOW       SQLCODE = 0
     C/EXEC SQL FETCH NEXT FROM BALCSR INTO :CUSTROW
     C/END-EXEC
     C                   IF        SQLCODE <> 0 OR SQLSTATE = '02000'
     C                   LEAVE
     C                   ENDIF
     C                   EVAL      ROWSREAD = ROWSREAD + 1
     C                   EVAL      CUSTNBR = CUSTROW.NUMBER
     C                   EVAL      CUSTBAL = CUSTROW.BALANCE
     C                   EVAL      LIMIT = CREDITLIM(CUSTNBR)
     C                   EVAL      GRANDTOT = GRANDTOT + CUSTBAL
     C/EXEC SQL UPDATE CUSTMAST
     C+    SET CUSBND = :CUSTROW.BAND,
     C+        CUSCHG = CURRENT TIMESTAMP
     C+  WHERE CUSNBR = :CUSTNBR
     C/END-EXEC
     C                   EXCEPT    DETAIL
     C                   ENDDO
     C/EXEC SQL CLOSE BALCSR
     C/END-EXEC
     C*
     C* A blocked fetch brings ten rows back at once, into an array of
     C* structures. The union puts the two sources in one result.
     C/EXEC SQL DECLARE TOPCSR CURSOR FOR
     C+ SELECT CUSNBR, CUSBAL FROM SESSION.BALWORK
     C+  WHERE BANDCD = 'A'
     C+ UNION ALL
     C+ SELECT CUSNBR, CUSBAL FROM SESSION.BALHIST
     C+  WHERE BANDCD = 'A' AND HSTYER = YEAR(:ASOFDATE)
     C+  ORDER BY 2 DESC
     C+  FETCH FIRST 10 ROWS ONLY
     C/END-EXEC
     C/EXEC SQL OPEN TOPCSR
     C/END-EXEC
     C/EXEC SQL FETCH TOPCSR FOR 10 ROWS INTO :TOPROWS
     C/END-EXEC
     C                   FOR       IDX = 1 TO %MIN(10 : ROWSREAD)
     C                   IF        TOPROWS(IDX).BALANCE > 0
     C                   EXCEPT    TOPROW
     C                   ENDIF
     C                   ENDFOR
     C/EXEC SQL CLOSE TOPCSR
     C/END-EXEC
     C*
     C* Tidying up: the empty rows go, a logging procedure is called,
     C* and the unit of work is committed or rolled back.
     C/EXEC SQL DELETE FROM SESSION.BALWORK WHERE CUSBAL = 0
     C/END-EXEC
     C/EXEC SQL CALL LOGRUN(:COMPANY, :ROWSREAD, :GRANDTOT)
     C/END-EXEC
     C                   IF        SQLCODE < 0
     C/EXEC SQL ROLLBACK
     C/END-EXEC
     C                   EXSR      SQLFAIL
     C                   ELSE
     C/EXEC SQL COMMIT
     C/END-EXEC
     C                   ENDIF
     C                   EXCEPT    TOTALS
     C                   SETON                                            LR
     C                   RETURN
     C*
     C* The one place SQLCODE and SQLSTATE are turned into text.
     C     SQLFAIL       BEGSR
     C                   EVAL      ERRTEXT = 'SQLCODE ' + %CHAR(SQLCODE)
     C                   EVAL      ERRTEXT += ' SQLSTATE ' + SQLSTATE
     C                   EXCEPT    SQLFAILR
     C                   ENDSR
     O*
     O* Output specifications close the program.
     OBALPRT    HF   1P                     2
     O                                           40 'CUSTOMER BALANCES'
     O                       RUNDATE       Y     60
     OBALPRT    E            DETAIL         1
     O                       CUSTROW.NAME        30
     O                       CUSTBAL       1     48
     OBALPRT    E            TOPROW         1
     O                                           30 'TOP CUSTOMER'
     OBALPRT    E            TOTALS      2
     O                                           30 'GRAND TOTAL'
     O                       GRANDTOT      1     48
     O                       ROWSREAD      1     64
     OBALPRT    E            SQLFAILR       1
     O                       ERRTEXT             80
     P*
     P* A subprocedure with a single-row select of its own, which the
     P* fully free-form version also has. Its host variables are local.
     PCREDITLIM        B                   EXPORT
     DCREDITLIM        PI            11P 2
     DFORCUST                         7P 0 CONST
     DRESULT           S             11P 2 INZ(0)
     C/EXEC SQL SELECT COALESCE(CRDLMT, 0) INTO :RESULT
     C+   FROM MYLIB.CUSTCREDIT
     C+  WHERE CUSNBR = :FORCUST
     C+    AND CAST(CRDSTS AS CHAR(1)) = 'A'
     C+    FETCH FIRST 1 ROW ONLY
     C/END-EXEC
     C                   IF        SQLCODE <> 0
     C                   EVAL      RESULT = 0
     C                   ENDIF
     C                   RETURN    RESULT
     PCREDITLIM        E
