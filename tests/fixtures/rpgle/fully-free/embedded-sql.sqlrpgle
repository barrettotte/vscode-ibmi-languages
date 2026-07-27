**FREE
//
// Embedded SQL in fully free-form RPG. EXEC SQL opens the statement,
// a semicolon closes it, and host variables carry a leading colon.
//
// Member: FREESQL   Compilable: no (calculations only, no files)
// Source: IBM i 7.5 Embedded SQL programming, embedding SQL statements
//         in ILE RPG applications that use SQL.
// Retrieved: 2026-07-27
//
//
// Options and the communications area.
exec sql set option commit = *none, closqlcsr = *endmod;
exec sql include sqlca;
//
// Host variables and structures carry a colon.
dcl-s custNbr packed(7 : 0);
dcl-s custNm char(30);
dcl-s custBal packed(11 : 2);
dcl-s nullInd int(5);
dcl-ds custRow qualified;
  name char(30);
  balance packed(11 : 2);
end-ds;
//
// A single-row select. An indicator variable follows the host
// variable it belongs to.
exec sql
  select cusnam, cusbal
    into :custNm, :custBal :nullInd
    from custmast
   where cusnbr = :custNbr;
//
// Selecting into a host structure.
exec sql
  select cusnam, cusbal into :custRow
    from custmast where cusnbr = :custNbr;
//
// Names may be qualified by schema, with either a dot or a slash.
exec sql select count(*) into :rowCount from mylib.custmast;
exec sql select count(*) into :rowCount from mylib/custmast;
//
// A cursor, from declaration through to close.
exec sql
  declare custCursor cursor for
    select cusnbr, cusnam, cusbal
      from custmast
     where cusbal > :minBalance
     order by cusbal desc
     for read only;
exec sql open custCursor;
dow sqlcode = 0;
  exec sql fetch next from custCursor
    into :custNbr, :custNm, :custBal;
  if sqlcode <> 0;
    leave;
  endif;
enddo;
exec sql close custCursor;
//
// Changing rows.
exec sql
  insert into custmast (cusnbr, cusnam, cusbal)
       values (:custNbr, :custNm, :custBal);
exec sql
  update custmast set cusbal = cusbal * 1.05
   where cusnbr = :custNbr and cusbal >= 100.00;
exec sql delete from custmast where cusnbr = :custNbr;
exec sql commit;
exec sql rollback;
//
// Functions, literals and the operators an expression may use.
exec sql
  select upper(trim(cusnam)), coalesce(cusbal, 0)
    into :custNm, :custBal
    from custmast
   where cusnam like 'A%'
     and cusbal <> 0 and cusbal >= 10.5
     and status in ('A', 'B')
     and code = x'F1F2';
//
// The global variables the precompiler recognises.
exec sql
  select job_name, client_ipaddr into :jobName, :clientIp
    from sysibm.sysdummy1;
//
// Error handling. WHENEVER sets what happens on a condition.
exec sql whenever sqlerror goto sqlFail;
exec sql whenever not found continue;
exec sql whenever sqlwarning continue;
//
// All three comment forms are allowed inside a statement: SQL's
// own double hyphen, the ordinary // of free-form RPG, and a
// bracketed comment, which may span lines.
exec sql
  select cusnam            -- the customer name
    into :custNm           // an RPG comment reads too
    from custmast          /* and a bracketed one,
                              running over two lines */
   where cusnbr = :custNbr;
//
// A statement may also be written on one line.
exec sql select cusnam into :custNm from custmast; // after
