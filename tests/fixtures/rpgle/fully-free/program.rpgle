**FREE
//
// A whole fully free-form program rather than one kind of statement:
// the control statement, files and globals, prototypes, a linear main
// procedure and two subprocedures with their own local declarations.
//
// Prints an order register grouped by customer, taking the tax rate
// from a compile-time array and the line total from a subprocedure.
// The fixed-format program fixture tells the same story in columns.
//
// Member: ORDREGF   Compilable: complete program, but not built; its
//         files are not defined here
// Source: ILE RPG Reference SC09-2508, free-form statements.
// Retrieved: 2026-07-27
//
//
// The control statement comes first. MAIN names the procedure the
// program starts in, which replaces the cycle.
ctl-opt dftactgrp(*no) actgrp('QILE');
ctl-opt main(orderRegister) option(*srcstmt : *nodebugio);
ctl-opt datfmt(*iso) timfmt(*hms) decedit('0.');
//
// Files and globals. Free form has no rule about definition and
// file statements being intermixed, so they simply follow.
dcl-f ORDHDR disk(*ext) usage(*input) keyed usropn;
dcl-f ORDDTL disk(*ext) usage(*input) keyed;
dcl-f ORDPRT printer(132) oflind(*inof);

dcl-c REPORT_TITLE 'ORDER REGISTER';
dcl-s grandTotal packed(11 : 2) inz(0);
dcl-s orderCount int(10) inz(0);
dcl-s taxRate packed(5 : 3) dim(4) ctdata perrcd(1);

dcl-ds orderInfo qualified;
  number packed(7 : 0);
  customer char(30);
  lineTotal packed(11 : 2);
  band char(1);
end-ds;
//
// Prototypes for the subprocedures below, so the calls in the main
// procedure are checked.
dcl-pr lineTotal packed(11 : 2);
  qty packed(5 : 0) const;
  price packed(9 : 2) const;
end-pr;

dcl-pr bandFor char(1);
  amount packed(11 : 2) const;
end-pr;
//
// The main procedure. Its interface takes no parameters, so
// DCL-PI *N with nothing between it and END-PI is enough.
dcl-proc orderRegister;
  dcl-pi *n;
  end-pi;

  dcl-s savedKey packed(7 : 0);

  open ORDHDR;
  except heading;

  read ORDHDR;
  dow not %eof(ORDHDR);
    orderCount += 1;
    savedKey = ordNumber;
    orderInfo.number = ordNumber;
    orderInfo.customer = %trim(ordCustomer);

    setll savedKey ORDDTL;
    reade savedKey ORDDTL;
    dow not %eof(ORDDTL);
      orderInfo.lineTotal = lineTotal(ordQty : ordPrice);
      orderInfo.band = bandFor(orderInfo.lineTotal);
      grandTotal += orderInfo.lineTotal;
      except detail;
      reade savedKey ORDDTL;
    enddo;

    read ORDHDR;
  enddo;

  except totals;
  close ORDHDR;
  return;
end-proc;
//
// A subprocedure with its own local variable. The tax rate comes
// from the compile-time array declared at the top.
dcl-proc lineTotal;
  dcl-pi *n packed(11 : 2);
    qty packed(5 : 0) const;
    price packed(9 : 2) const;
  end-pi;

  dcl-s gross packed(11 : 2);

  gross = qty * price;
  return gross + (gross * taxRate(1));
end-proc;
//
// The second subprocedure declares a file of its own. A file
// declared here is local to it and the main procedure cannot see
// it.
dcl-proc bandFor;
  dcl-pi *n char(1);
    amount packed(11 : 2) const;
  end-pi;

  dcl-f BANDREF disk(*ext) usage(*input) keyed static;
  dcl-s result char(1) inz('C');

  monitor;
    chain(e) amount BANDREF;
    if %found(BANDREF);
      result = bandCode;
    elseif amount >= 1000;
      result = 'A';
    elseif amount >= 100;
      result = 'B';
    endif;
  on-error;
    result = '?';
  endmon;

  return result;
end-proc;
//
// Compile-time data closes the member. The ** form names the
// array the records below it load.
**CTDATA taxRate
0.075
0.080
0.065
0.000
