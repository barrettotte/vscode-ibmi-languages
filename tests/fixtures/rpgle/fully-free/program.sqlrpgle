**FREE
//
// A whole program with embedded SQL. A temporary table is built from
// a common table expression, a cursor drives the report, the rows
// come back into a host structure, and the work is committed only if
// nothing went wrong.
//
// Member: SQLREGF   Compilable: complete program, but not built; its
//         tables and printer file are not defined here
// Source: IBM i 7.5 Embedded SQL programming, embedding SQL statements
//         in ILE RPG applications that use SQL.
// Retrieved: 2026-07-27
//
//
// Control statement and the printer file.
ctl-opt dftactgrp(*no) actgrp('QILE') main(balanceReport);
ctl-opt option(*srcstmt : *nodebugio) datfmt(*iso);
dcl-f BALPRT printer(132) oflind(*inof);
//
// Host variables. SQL reads into these by name, with a colon. A
// structure may be used in place of a list of them, and an array
// of structures receives a blocked fetch.
dcl-s custNbr packed(7 : 0);
dcl-s custBal packed(11 : 2);
dcl-s balInd int(5);
dcl-s grandTotal packed(13 : 2) inz(0);
dcl-s rowsRead int(10) inz(0);
dcl-s rowsUpd int(10) inz(0);
dcl-s runDate date(*iso);
dcl-s errText varchar(132);
dcl-c MIN_BALANCE 100.00;

dcl-ds custRow qualified;
  number packed(7 : 0);
  name char(30);
  balance packed(11 : 2);
  band char(1);
end-ds;

dcl-ds topRows qualified dim(10);
  number packed(7 : 0);
  balance packed(11 : 2);
end-ds;
//
// A prototype for the subprocedure below.
dcl-pr creditLimit packed(11 : 2);
  forCustomer packed(7 : 0) const;
end-pr;
//
// The main procedure. It takes the company and the as-of date as
// parameters. SQLCODE and SQLSTATE come from the SQLCA that the
// precompiler brings in.
dcl-proc balanceReport;
  dcl-pi *n;
    company char(3) const;
    asOfDate date(*iso) const;
  end-pi;

  dcl-s limit packed(11 : 2);
  dcl-s idx int(10);

  exec sql set option commit = *chg, closqlcsr = *endmod;
  exec sql whenever sqlerror continue;
  exec sql values current date into :runDate;
//
// A temporary table holds the working set, filled from a common
// table expression joined to the orders and grouped.
  exec sql
    declare global temporary table session.balwork (
      cusnbr decimal(7, 0) not null,
      cusnam char(30) not null,
      cusbal decimal(11, 2) not null default 0,
      bandcd char(1) not null
    ) with replace on commit preserve rows;

  exec sql
    insert into session.balwork
      with active as (
        select cusnbr, cusnam
          from custmast
         where cussts = 'A' and cuscmp = :company
      )
      select a.cusnbr,
             a.cusnam,
             sum(o.ordamt),
             case when sum(o.ordamt) >= 1000 then 'A'
                  when sum(o.ordamt) >= 100  then 'B'
                  else 'C'
             end
        from active a
             inner join orders o
                     on o.cusnbr = a.cusnbr
       where o.orddat <= :asOfDate
       group by a.cusnbr, a.cusnam
      having sum(o.ordamt) >= :MIN_BALANCE;

  if sqlcode < 0;
    exsr sqlFailed;
    return;
  endif;
  exec sql get diagnostics :rowsUpd = row_count;
//
// The cursor and its fetch loop. The row comes back into a
// structure rather than a list of separate variables.
  exec sql
    declare balCursor cursor for
      select cusnbr, cusnam, cusbal, bandcd
        from session.balwork
       order by cusbal desc
       for read only;

  exec sql open balCursor;
  if sqlcode < 0;
    exsr sqlFailed;
    return;
  endif;

  except heading;
  dow sqlcode = 0;
    exec sql fetch next from balCursor into :custRow;
    if sqlcode <> 0 or sqlstate = '02000';
      leave;
    endif;

    rowsRead += 1;
    custNbr = custRow.number;
    custBal = custRow.balance;
    limit = creditLimit(custNbr);
    grandTotal += custBal;

    exec sql
      update custmast
         set cusbnd = :custRow.band,
             cuschg = current timestamp
       where cusnbr = :custNbr;

    except detail;
  enddo;
  exec sql close balCursor;
//
// A blocked fetch brings ten rows back at once, into an array of
// structures. The union puts the two sources in one result.
  exec sql
    declare topCursor cursor for
      select cusnbr, cusbal from session.balwork
       where bandcd = 'A'
      union all
      select cusnbr, cusbal from session.balhist
       where bandcd = 'A' and hstyer = year(:asOfDate)
       order by 2 desc
       fetch first 10 rows only;

  exec sql open topCursor;
  exec sql fetch topCursor for 10 rows into :topRows;
  for idx = 1 to %min(10 : rowsRead);
    if topRows(idx).balance > 0;
      except toprow;
    endif;
  endfor;
  exec sql close topCursor;
//
// Tidying up: the empty rows go, a logging procedure is called,
// and the unit of work is committed or rolled back.
  exec sql delete from session.balwork where cusbal = 0;
  exec sql call logrun(:company, :rowsRead, :grandTotal);

  if sqlcode < 0;
    exec sql rollback;
    exsr sqlFailed;
  else;
    exec sql commit;
  endif;

  except totals;
  *inlr = *on;
  return;

  // The one place SQLCODE and SQLSTATE are turned into text.
  begsr sqlFailed;
    errText = 'SQLCODE ' + %char(sqlcode) +
              ' SQLSTATE ' + sqlstate;
    except sqlfail;
  endsr;
end-proc;
//
// A subprocedure with a single-row select of its own. Its host
// variables are local to it.
dcl-proc creditLimit;
  dcl-pi *n packed(11 : 2);
    forCustomer packed(7 : 0) const;
  end-pi;

  dcl-s result packed(11 : 2) inz(0);

  exec sql
    select coalesce(crdlmt, 0) into :result
      from mylib.custcredit
     where cusnbr = :forCustomer
       and cast(crdsts as char(1)) = 'A'
       fetch first 1 row only;

  if sqlcode <> 0;
    result = 0;
  endif;
  return result;
end-proc;
