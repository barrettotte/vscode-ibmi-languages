     C*
     C* Embedded SQL in fixed-format RPG IV. The statement opens with
     C* C/EXEC SQL, continues on lines carrying C+ in positions 6-7 and
     C* closes with C/END-EXEC. Host variables carry a leading colon.
     C*
     C* Member: RPGLESQL  Compilable: no (calculations only, no files)
     C* Source: IBM i 7.5 Embedded SQL programming, embedding SQL
     C*         statements in ILE RPG applications that use SQL.
     C* Retrieved: 2026-07-27
     C*
     C*
     C* Options and the communications area.
     C/EXEC SQL SET OPTION COMMIT = *NONE, CLOSQLCSR = *ENDMOD
     C/END-EXEC
     C/EXEC SQL INCLUDE SQLCA
     C/END-EXEC
     C*
     C* A single-row select. An indicator variable follows the host
     C* variable it belongs to.
     C/EXEC SQL SELECT CUSNAM, CUSBAL
     C+ INTO :CUSTNM, :CUSTBL :NULLIND
     C+ FROM CUSTMAST
     C+ WHERE CUSNBR = :CUSNBR
     C/END-EXEC
     C*
     C* Names may be qualified by schema, with a dot or a slash.
     C/EXEC SQL SELECT COUNT(*) INTO :ROWCNT FROM MYLIB.CUSTMAST
     C/END-EXEC
     C/EXEC SQL SELECT COUNT(*) INTO :ROWCNT FROM MYLIB/CUSTMAST
     C/END-EXEC
     C*
     C* A cursor, declared through to closed.
     C/EXEC SQL DECLARE CUSTCSR CURSOR FOR
     C+ SELECT CUSNBR, CUSNAM, CUSBAL
     C+ FROM CUSTMAST
     C+ WHERE CUSBAL > :MINBAL
     C+ ORDER BY CUSBAL DESC
     C+ FOR READ ONLY
     C/END-EXEC
     C/EXEC SQL OPEN CUSTCSR
     C/END-EXEC
     C/EXEC SQL FETCH NEXT FROM CUSTCSR INTO :CUSNBR, :CUSTNM, :CUSTBL
     C/END-EXEC
     C/EXEC SQL CLOSE CUSTCSR
     C/END-EXEC
     C*
     C* Changing rows.
     C/EXEC SQL INSERT INTO CUSTMAST (CUSNBR, CUSNAM, CUSBAL)
     C+ VALUES (:CUSNBR, :CUSTNM, :CUSTBL)
     C/END-EXEC
     C/EXEC SQL UPDATE CUSTMAST SET CUSBAL = CUSBAL * 1.05
     C+ WHERE CUSNBR = :CUSNBR AND CUSBAL >= 100.00
     C/END-EXEC
     C/EXEC SQL DELETE FROM CUSTMAST WHERE CUSNBR = :CUSNBR
     C/END-EXEC
     C/EXEC SQL COMMIT
     C/END-EXEC
     C/EXEC SQL ROLLBACK
     C/END-EXEC
     C*
     C* Functions, literals and the operators an expression may use.
     C/EXEC SQL SELECT UPPER(TRIM(CUSNAM)), COALESCE(CUSBAL, 0)
     C+ INTO :CUSTNM, :CUSTBL
     C+ FROM CUSTMAST
     C+ WHERE CUSNAM LIKE 'A%'
     C+ AND CUSBAL <> 0 AND CUSBAL >= 10.5
     C+ AND STATUS IN ('A', 'B')
     C+ AND CODE = X'F1F2'
     C/END-EXEC
     C*
     C* The global variables the precompiler recognises.
     C/EXEC SQL SELECT JOB_NAME, CLIENT_IPADDR INTO :JOBNAM, :CLIIP
     C+ FROM SYSIBM.SYSDUMMY1
     C/END-EXEC
     C*
     C* Error handling.
     C/EXEC SQL WHENEVER SQLERROR GOTO SQLFAIL
     C/END-EXEC
     C/EXEC SQL WHENEVER NOT FOUND CONTINUE
     C/END-EXEC
     C*
     C* Comments inside a statement. In fixed form an ILE RPG comment
     C* is an asterisk in position 7, and SQL's own double hyphen
     C* works as well.
     C/EXEC SQL SELECT CUSNAM
     C* an RPG comment inside the statement
     C+ INTO :CUSTNM              -- and SQL's own
     C+ FROM CUSTMAST
     C+ WHERE CUSNBR = :CUSNBR
     C/END-EXEC
     C*
     C* A page and line number in 1-5 does not disturb the columns.
08010C/EXEC SQL SELECT CUSNAM INTO :CUSTNM FROM CUSTMAST
08020C/END-EXEC
