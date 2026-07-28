       //
       // Embedded SQL in a member that mixes the two formats. The
       // fixed-format form opens with C/EXEC SQL and continues on C+ lines,
       // ending at C/END-EXEC; the free-form one opens with EXEC SQL in
       // columns 8-80 and ends at a semicolon. Both appear here.
       //
       // Member: MIXSQL   Compilable: no (calculations only, no files)
       // Source: IBM i 7.5 Embedded SQL programming, embedding SQL
       //         statements in ILE RPG applications that use SQL.
       // Retrieved: 2026-07-28
       //
       //
       // Host variables, declared both ways.
     DCUSTNBR          S              7P 0
       dcl-s custNm char(30);
     DCUSTBAL          S             11P 2
       dcl-s balInd int(5);
       //
       // The communications area, brought in each way. The fixed form
       // needs no continuation when it fits on the one line.
     C/EXEC SQL INCLUDE SQLCA
     C/END-EXEC
       exec sql set option commit = *none;
       //
       // A single-row select, written the fixed way. The statement
       // continues on C+ lines and closes at C/END-EXEC.
     C/EXEC SQL SELECT CUSNAM, CUSBAL
     C+ INTO :CUSTNM, :CUSTBAL :BALIND
     C+ FROM CUSTMAST
     C+ WHERE CUSNBR = :CUSTNBR
     C/END-EXEC
       //
       // The same statement the free way, ended by a semicolon.
       exec sql
         select cusnam, cusbal
           into :custNm, :custBal :balInd
           from custmast
          where cusnbr = :custNbr;
       //
       // A cursor opened the fixed way and fetched the free way, which
       // is what a part-converted program looks like.
     C/EXEC SQL DECLARE CUSTCURSOR CURSOR FOR
     C+ SELECT CUSNBR, CUSNAM FROM CUSTMAST
     C+ WHERE CUSBAL > :MINBALANCE
     C+ ORDER BY CUSBAL DESC
     C/END-EXEC
       exec sql open custCursor;
       exec sql fetch next from custCursor
         into :custNbr, :custNm;
       dow sqlcode = 0;
     C                   EXSR      PRINTLINE
         exec sql fetch next from custCursor
           into :custNbr, :custNm;
       enddo;
       exec sql close custCursor;
       //
       // Changing rows, and the transaction boundary.
     C/EXEC SQL UPDATE CUSTMAST
     C+ SET CUSBAL = CUSBAL * 1.05
     C+ WHERE CUSNBR = :CUSTNBR
     C/END-EXEC
       exec sql delete from custmast where cusnbr = :custNbr;
       exec sql commit;
       //
       // Comments. The fixed form has the comment area in 81-100 and
       // SQL's own -- inside the statement; the free form needs // for
       // anything past column 80.
     C/EXEC SQL SELECT CUSNAM                                                     a fixed comment area
     C+ INTO :CUSTNM              -- and SQL's own
     C+ FROM CUSTMAST
     C/END-EXEC
       exec sql
         select cusnam          -- SQL's own comment
           into :custNm           // and the RPG one
           from custmast;
       //
       // A conditional directive may bracket either form.
      /IF DEFINED(*CRTBNDRPG)
     C/EXEC SQL SET OPTION NAMING = *SQL
     C/END-EXEC
      /ELSE
       exec sql set option naming = *sys;
      /ENDIF
