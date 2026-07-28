       //
       // Embedded SQL in a column-limited member. EXEC SQL is written in
       // columns 8-80 like any other free-form statement and ends with a
       // semicolon; host variables carry a leading colon.
       //
       // Member: CLSQL   Compilable: no (calculations only, no files)
       // Source: IBM i 7.5 Embedded SQL programming, embedding SQL
       //         statements in ILE RPG applications that use SQL.
       // Retrieved: 2026-07-27
       //
       //
       // Options and the communications area.
       exec sql set option commit = *none;
       exec sql include sqlca;
       //
       // Host variables and structures carry a colon.
       dcl-s custNbr packed(7 : 0);
       dcl-s custNm char(30);
       dcl-s custBal packed(11 : 2);
       dcl-s balInd int(5);
       dcl-ds custRow qualified;
         name char(30);
         balance packed(11 : 2);
       end-ds;
       //
       // A single-row select, spread over several lines.
       exec sql
         select cusnam, cusbal
           into :custNm, :custBal :balInd
           from custmast
          where cusnbr = :custNbr;
       //
       // Selecting into a host structure.
       exec sql
         select cusnam, cusbal into :custRow
           from custmast where cusnbr = :custNbr;
       //
       // Schema-qualified names, with a dot and with a slash.
       exec sql select count(*) into :n from mylib.custmast;
       exec sql select count(*) into :n from mylib/custmast;
       //
       // A cursor.
       exec sql
         declare custCursor cursor for
           select cusnbr, cusnam from custmast
            where cusbal > :minBalance
            order by cusbal desc
            for read only;
       exec sql open custCursor;
       exec sql fetch next from custCursor
         into :custNbr, :custNm;
       dow sqlcode = 0;
         if sqlstate <> '00000';
           leave;
         endif;
       enddo;
       exec sql close custCursor;
       //
       // Changing rows, and the transaction boundary.
       exec sql
         insert into custmast (cusnbr, cusnam)
            values (:custNbr, :custNm);
       exec sql update custmast set cusbal = cusbal * 1.05
           where cusnbr = :custNbr;
       exec sql delete from custmast where cusnbr = :custNbr;
       exec sql commit;
       exec sql rollback;
       //
       // Functions, literals and operators.
       exec sql
         select upper(trim(cusnam)), coalesce(cusbal, 0)
           into :custNm, :custBal
           from custmast
          where cusnam like 'A%'
            and cusbal <> 0 and cusbal >= 10.5
            and code = x'F1F2';
       //
       // The global variables the precompiler recognises.
       exec sql
         select job_name into :jobName from sysibm.sysdummy1;
       //
       // Error handling.
       exec sql whenever sqlerror continue;
       exec sql whenever not found continue;
       //
       // All three comment forms are allowed inside a statement, and a
       // comment may also sit past column 80.
       exec sql
         select cusnam          -- SQL's own comment
           into :custNm           // and the RPG one
           from custmast          /* and a bracketed one,
               running over two lines */
       where cusnbr = :custNbr;                                                   // and one past column 80
       //
       // A statement may also be written on one line.
       exec sql select cusnam into :custNm from custmast; // after
       //
       // Grouping, with the column list broken over several lines and
       // an SQL comment on the last clause. A -- comment is only an SQL
       // comment inside the statement, so the terminator goes on its own
       // line; written after the ; it would be two minus signs in RPG.
       exec sql
         SELECT my_id
         FROM MY_TABLE
         GROUP BY RRCLTP,rrclm#,
           poltp2,
           raplcy
         HAVING sum(rrpaym) >=500  -- Only payments exceeding $500
         ;
