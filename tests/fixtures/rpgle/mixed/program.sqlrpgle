       //
       // A part-converted program with embedded SQL. Because the member is
       // column-limited it may write SQL either way, and a member part way
       // through conversion does both: the statements nobody touched keep the
       // C/EXEC SQL form, and the rewritten ones use EXEC SQL as a free-form
       // statement ending in a semicolon.
       //
       // Prints a customer balance report driven by a cursor.
       //
       // Member: MIXSQL    Compilable: complete program, but not built; its
       //         tables and printer file are not defined here
       // Source: IBM i 7.5 Embedded SQL programming, embedding SQL statements
       //         in ILE RPG applications that use SQL.
       // Retrieved: 2026-07-27
       //
       //
       // Control converted, the printer file left in columns.
       ctl-opt dftactgrp(*no) actgrp('QILE');
       ctl-opt option(*srcstmt : *nodebugio) datfmt(*iso);
     FBALPRT    OF   F  132        PRINTER OFLIND(*INOF)
       //
       // Host variables, declared both ways. SQL reads into either.
     DCUSTNBR          S              7P 0
     DCUSTNM           S             30A
     DCUSTBAL          S             11P 2
     DBALIND           S              5I 0
       dcl-s grandTotal packed(13 : 2) inz(0);
       dcl-s rowsRead int(10) inz(0);
       dcl-s stmtText varchar(500);
       dcl-s creditLim packed(11 : 2);
       dcl-c MIN_BALANCE 100.00;
       dcl-ds custDs qualified;
         number packed(7 : 0);
         name char(30);
       end-ds;
       //
       // A prototype for the subprocedure below.
       dcl-pr getLimit packed(11 : 2);
         forCustomer packed(7 : 0) const;
       end-pr;
       //
       // Options and error handling were never rewritten, so they keep
       // the traditional form. A C* comment may sit inside a statement
       // and SQL's own -- comment may end one of its lines.
     C/EXEC SQL SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD
     C/END-EXEC
     C/EXEC SQL WHENEVER SQLERROR CONTINUE
     C/END-EXEC
     C/EXEC SQL DECLARE BALCSR CURSOR FOR
     C* the cursor the report is driven by
     C+ SELECT CUSNBR, CUSNAM, CUSBAL      -- three columns
     C+ FROM CUSTMAST
     C+ WHERE CUSBAL >= :MIN_BALANCE
     C+ ORDER BY CUSBAL DESC
     C+ FOR READ ONLY
     C/END-EXEC
       //
       // The fetch loop was rewritten, so its SQL is free-form: EXEC
       // SQL introduces the statement and a semicolon ends it.
       except heading;
       exec sql open balCsr;
       if sqlcode < 0;
         except sqlfail;
         *inlr = *on;
         return;
       endif;
       dow sqlcode = 0;
         exec sql
           fetch next from balCsr
             into :custNbr, :custNm, :custBal :balInd;
         if sqlcode <> 0 or sqlstate = '02000';
           leave;
         endif;
         creditLim = getLimit(custNbr);
         grandTotal += custBal;
         rowsRead += 1;
         except detail;
       enddo;
       //
       // A calculation nobody rewrote sits between the two SQL forms.
     C                   Z-ADD     0             CUSTBAL
       //
       // Closing the cursor and writing the audit row kept the old
       // form, including a statement continued over several lines.
     C/EXEC SQL CLOSE BALCSR
     C/END-EXEC
     C/EXEC SQL INSERT INTO AUDITLOG
     C+ (RUNDATE, RUNPGM, ROWCNT, TOTAL)
     C+ VALUES (CURRENT DATE, 'MIXSQL', :ROWSREAD, :GRANDTOTAL)
     C/END-EXEC
       //
       // Dynamic SQL, rewritten. The statement text is built in a host
       // variable, prepared, and run with a parameter marker.
       stmtText = 'update custmast set cusflg = ? ' +
           'where cusnbr = ?';
       exec sql prepare updStmt from :stmtText;
       exec sql execute updStmt using :custNm, :custNbr;
       exec sql
         select count(*) into :rowsRead
           from mylib.custmast
           where cusbal > :MIN_BALANCE;
       except totals;
       *inlr = *on;
       return;
       //
       // A subprocedure whose begin and end lines are still fixed and
       // whose body holds a free-form single-row select.
     PGETLIMIT         B                   EXPORT
       dcl-pi *n packed(11 : 2);
         forCustomer packed(7 : 0) const;
       end-pi;
       dcl-s result packed(11 : 2) inz(0);
       exec sql
         select coalesce(crdlmt, 0) into :result
           from mylib/custcredit
           where cusnbr = :forCustomer
             fetch first 1 row only;
       if sqlcode <> 0;
         result = 0;
       endif;
       return result;
     PGETLIMIT         E
       //
       // Output specifications, which SQL does not replace.
     OBALPRT    H    1P                     2
     O                                           40 'CUSTOMER BALANCES'
     O                       *DATE         Y     60
     OBALPRT    E            DETAIL         1
     O                       CUSTNM              30
     O                       CUSTBAL       1     48
     O                       CREDITLIM     1     64
     OBALPRT    E            TOTALS         2
     O                                           30 'GRAND TOTAL'
     O                       GRANDTOTAL    1     48
     O                       ROWSREAD      1     64
     OBALPRT    E            SQLFAIL        1
     O                                           40 'SQL OPEN FAILED'
     O                       SQLCODE       1     52
