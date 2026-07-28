       //
       // A whole program written free-form in a column-limited member: the
       // control statement, files and globals, prototypes, a main procedure
       // taking the program parameters, and two subprocedures with their own
       // local declarations.
       //
       // Prints an order register grouped by customer, bands each line and
       // logs anything that looks stale. fully-free/program.rpgle tells the
       // same story with no column limit at all.
       //
       // Member: CLPROG   Compilable: complete program, but not built; its
       //         files are not defined here
       // Source: ILE RPG Reference SC09-2508, free-form statements.
       // Retrieved: 2026-07-28
       //
       //
       // Control statements. MAIN names the procedure the program
       // starts in, which replaces the cycle.
       ctl-opt dftactgrp(*no) actgrp('QILE');
       ctl-opt main(orderReport) option(*srcstmt : *nodebugio);
       ctl-opt datfmt(*iso) timfmt(*hms) decedit('0.');
       //
       // Files. INFDS names a structure the file keeps its feedback
       // in, and a keyword field too long for one line carries on
       // down the next.
       dcl-f ORDHDR disk(*ext) usage(*input) keyed usropn
             infds(ordHdrInfo);
       dcl-f ORDDTL disk(*ext) usage(*input) keyed;
       dcl-f ORDAUD disk(*ext) keyed
             usage(*input : *output : *update : *delete);
       dcl-f ORDPRT printer(132) oflind(*inof);
       //
       // Named constants, then the compile-time arrays.
       dcl-c REPORT_TITLE 'ORDER REGISTER';
       dcl-c BAND_A_FLOOR 1000.00;
       dcl-c BAND_B_FLOOR 100.00;
       dcl-c STALE_DAYS 90;
       dcl-c FLAG_BYTE const(x'5A');
       dcl-s taxRate packed(5 : 3) dim(4) ctdata perrcd(1);
       dcl-s qtyBreak packed(5 : 0) dim(4) ctdata perrcd(1);
       //
       // Globals.
       dcl-s grandTotal packed(13 : 2) inz(0);
       dcl-s orderCount int(10) inz(0);
       dcl-s errMsg char(80);
       //
       // A structure for the line being printed, then the two the
       // system fills in: the program status and the file feedback.
       dcl-ds orderInfo qualified;
         number packed(7 : 0);
         customer char(30);
         lineTotal packed(11 : 2);
         band char(1);
       end-ds;
       dcl-ds pgmStatus psds qualified;
         procName char(10) pos(1);
         statusCode zoned(5 : 0) pos(11);
         routine char(8) pos(29);
         pgmName char(10) pos(334);
         userName char(10) pos(358);
       end-ds;
       dcl-ds ordHdrInfo qualified;
         fileName char(8) pos(1);
         openInd ind pos(9);
         status zoned(5 : 0) pos(11);
       end-ds;
       //
       // Prototypes. The first two are the subprocedures below; the
       // last two name a program and a bound procedure to call.
       dcl-pr lineTotal packed(11 : 2);
         qty packed(5 : 0) const;
         price packed(9 : 2) const;
       end-pr;
       dcl-pr bandFor char(1);
         amount packed(11 : 2) const;
       end-pr;
       dcl-pr logError extpgm('ERRLOG');
         message char(80) const;
         fromPgm char(10) const;
       end-pr;
       dcl-pr toUpper char(30) extproc('CVTUPPER');
         text char(30) const;
       end-pr;
       //
       // The main procedure. A program started through MAIN receives
       // its parameters here rather than through an entry list.
       dcl-proc orderReport;
         dcl-pi *n;
           companyCode char(3) const;
           reportDate date(*iso) const;
         end-pi;
         dcl-s savedKey packed(7 : 0);
         dcl-s daysOld int(10);
         dcl-s heading varchar(70);
         // Opening a USROPN file can fail, so it is guarded.
         monitor;
           open ORDHDR;
         on-error;
           errMsg = 'Open failed, status ' + %char(%status);
           logError(errMsg : pgmStatus.pgmName);
           *inlr = *on;
           return;
         endmon;
         // A statement too long for one line carries on down
         // the next, which is where the column limit shows.
         heading = REPORT_TITLE + ' - ' + companyCode +
                   ' - ' + %char(reportDate : *iso);
         except headings;
         // The order loop.
         read ORDHDR;
         dow not %eof(ORDHDR);
           orderCount += 1;
           savedKey = ordNumber;
           orderInfo.number = ordNumber;
           orderInfo.customer = toUpper(%trim(ordCustomer));
           daysOld = %diff(reportDate : ordDate : *days);
           if daysOld > STALE_DAYS;
             exsr staleOrder;
           endif;
           setll savedKey ORDDTL;
           reade savedKey ORDDTL;
           dow not %eof(ORDDTL);
             orderInfo.lineTotal = lineTotal(ordQty : ordPrice);
             orderInfo.band = bandFor(orderInfo.lineTotal);
             grandTotal += orderInfo.lineTotal;
             if *inof;
               except headings;
               *inof = *off;
             endif;
             except detail;
             reade savedKey ORDDTL;
           enddo;
           exsr writeAudit;
           read ORDHDR;
         enddo;
         except totals;
         close ORDHDR;
         *inlr = *on;
         return;
         // Subroutines see the local variables of the procedure
         // they are declared in, which a subprocedure could not.
         begsr staleOrder;
           errMsg = 'Order ' + %char(savedKey) + ' is stale';
           logError(errMsg : pgmStatus.pgmName);
         endsr;
         begsr writeAudit;
           chain(e) savedKey ORDAUD;
           if %error;
             logError('Audit chain failed' : pgmStatus.pgmName);
           elseif %found(ORDAUD);
             audTotal = grandTotal;
             if audTotal = 0;
               delete ORDAUDR;
             else;
               update ORDAUDR %fields(audTotal);
             endif;
           else;
             audOrder = savedKey;
             audTotal = grandTotal;
             write ORDAUDR;
           endif;
         endsr;
       end-proc;
       //
       // A subprocedure with its own local variables. The quantity
       // break is searched for in one array and the rate taken from
       // another.
       dcl-proc lineTotal;
         dcl-pi *n packed(11 : 2);
           qty packed(5 : 0) const;
           price packed(9 : 2) const;
         end-pi;
         dcl-s gross packed(11 : 2);
         dcl-s idx int(10);
         gross = qty * price;
         idx = %lookupge(qty : qtyBreak);
         if idx = 0;
           idx = %elem(taxRate);
         endif;
         return gross + (gross * taxRate(idx));
       end-proc;
       //
       // The second declares a file of its own, which is local to it.
       // A SELECT group picks the band and ON-ERROR separates a file
       // error from any other.
       dcl-proc bandFor;
         dcl-pi *n char(1);
           amount packed(11 : 2) const;
         end-pi;
         dcl-f BANDREF disk(*ext) usage(*input) keyed static;
         dcl-s result char(1) inz('C');
         monitor;
           chain(e) amount BANDREF;
           select;
             when %found(BANDREF);
               result = bandCode;
             when amount >= BAND_A_FLOOR;
               result = 'A';
             when amount >= BAND_B_FLOOR;
               result = 'B';
             other;
               result = 'C';
           endsl;
         on-error *file;
           result = '?';
         on-error;
           result = '!';
         endmon;
         return result;
       end-proc;
       //
       // The column boundary, which only a column-limited member has.
       // A statement ends at 80; anything past it is a comment and
       // must be preceded by //.
       orderCount = 0;                                                            // counted again for the trailer
       grandTotal = 0;                                                            // and so is the total
       //
       // A literal continued onto the next line. The continuation
       // character is the last non-blank of the specification, so no
       // text at all may follow it, not even a comment.
       errMsg = 'Report finished for company -
                   ' + companyCode;
       errMsg = 'and carries on-
                   to the next line';
       //
       // Compile-time data closes the member, and is written from
       // column 1 whatever the source mode.
**CTDATA taxRate
0.075
0.080
0.065
0.000
**CTDATA qtyBreak
00010
00050
00100
00500
