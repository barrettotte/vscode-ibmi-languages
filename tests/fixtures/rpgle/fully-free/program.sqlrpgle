**FREE
//
// A whole program with embedded SQL. A cursor drives the report, the
// rows come back into host variables declared above, and a
// subprocedure does a single-row select of its own.
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
ctl-opt option(*srcstmt : *nodebugio);
dcl-f BALPRT printer(132) oflind(*inof);
//
// Host variables. SQL reads into these by name, with a colon.
dcl-s custNbr packed(7 : 0);
dcl-s custNm char(30);
dcl-s custBal packed(11 : 2);
dcl-s balInd int(5);
dcl-s grandTotal packed(13 : 2) inz(0);
dcl-s rowsRead int(10) inz(0);
dcl-c MIN_BALANCE 100.00;
//
// A prototype for the subprocedure below.
dcl-pr creditLimit packed(11 : 2);
  forCustomer packed(7 : 0) const;
end-pr;
//
// The main procedure. SQLCODE and SQLSTATE come from the SQLCA that
// the precompiler brings in.
dcl-proc balanceReport;
  dcl-pi *n;
  end-pi;

  dcl-s limit packed(11 : 2);

  exec sql set option commit = *none, closqlcsr = *endmod;
  exec sql whenever sqlerror continue;

  exec sql
    declare balCursor cursor for
      select cusnbr, cusnam, cusbal
        from custmast
       where cusbal >= :MIN_BALANCE   -- only the ones that matter
       order by cusbal desc
       for read only;

  exec sql open balCursor;
  if sqlcode < 0;
    except sqlFail;
    return;
  endif;

  except heading;
  dow sqlcode = 0;
    exec sql
      fetch next from balCursor
       into :custNbr, :custNm, :custBal :balInd;
    if sqlcode <> 0;
      leave;
    endif;

    rowsRead += 1;
    limit = creditLimit(custNbr);
    grandTotal += custBal;
    except detail;
  enddo;

  exec sql close balCursor;
  except totals;
  return;
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
       fetch first 1 row only;

  if sqlcode <> 0;
    result = 0;
  endif;
  return result;
end-proc;
