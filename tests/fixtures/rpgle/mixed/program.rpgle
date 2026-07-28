       //
       // A part-converted program, which is what mixed source is in practice:
       // the input and output specifications stay in columns because there is
       // no free-form spelling for them, while the declarations and the
       // calculations have moved.
       //
       // Prints an order register grouped by customer.
       //
       // Member: MIXREG    Compilable: complete program, but not built; its
       //         files are not defined here
       // Source: ILE RPG Reference SC09-2508, free-form statements.
       // Retrieved: 2026-07-27
       //
       //
       // Control statements, converted. The file specifications only
       // half converted, which is the usual state of a member part way
       // through: ORDDTL is program described and was left alone.
       ctl-opt dftactgrp(*no) actgrp('QILE');
       ctl-opt option(*srcstmt : *nodebugio) datfmt(*iso);
       dcl-f ORDHDR disk(*ext) usage(*input) keyed;
       dcl-f ORDPRT printer(132) oflind(*inof);
     FORDDTL    IF   F  120        DISK
       //
       // Declarations both ways. The totals structure and the month
       // names were never rewritten; everything added since is free.
     DTOTALS           DS
     D CUSTTOTAL                     11P 2
     D GRANDTOT                      13P 2
     DMONTHNM          S              9A   DIM(12) CTDATA PERRCD(1)
       dcl-s lineTotal packed(11 : 2);
       dcl-s custNm char(30);
       dcl-s prevCust packed(7 : 0) inz(0);
       dcl-s ordCount int(10) inz(0);
       dcl-s taxRate packed(5 : 3) dim(4) ctdata perrcd(1);
       dcl-s printLine char(132);
       //
       // A prototype for the subprocedure below.
       dcl-pr calcTax packed(11 : 2);
         amount packed(11 : 2) const;
         band packed(5 : 3) const;
       end-pr;
       //
       // Input specifications have no free-form spelling, so they stay.
       // ORDHDR is externally described and only renames its fields;
       // ORDDTL is program described and gives every field a position.
     IORDHDR        01
     I              CUSTOMERNM                  CUSTNM
     I              CUSTOMERNO                  CUSTNO
     I              ORDERAMT                    ORDAMT
     IORDDTL    AA1O02    1 CD
     I                                  1    7 0DTLCUST
     I                                  8   15  DTLITEM
     I                                 16   22 2DTLQTY
     I                                 23   31 2DTLPRICE      L1
       //
       // A key list, which free form also has no spelling for. The
       // calculations that use it were converted around it.
     C     ORDKEY        KLIST
     C                   KFLD                    CUSTNO
     C                   KFLD                    ORDNBR
       //
       // The main line, converted. It still calls into the two
       // subroutines and the subprocedure below.
       except heading;
       setll *loval ORDHDR;
       read ORDHDR;
       dow not %eof(ORDHDR);
         if custNo <> prevCust and prevCust > 0;
           exsr custBreak;
         endif;
         prevCust = custNo;
         chain ordKey ORDDTL;
         if %found(ORDDTL);
           lineTotal = dtlQty * dtlPrice;
         else;
           lineTotal = ordAmt;
         endif;
         lineTotal += calcTax(lineTotal : taxRate(1));
         custTotal += lineTotal;
         ordCount += 1;
         exsr formatLn;
         except detail;
         read ORDHDR;
       enddo;
       if prevCust > 0;
         exsr custBreak;
       endif;
       except totals;
       *inlr = *on;
       return;
       //
       // One subroutine was converted and the other was not. The
       // second keeps a TAG and a GOTO, which free form cannot write
       // and which the reference gives as a reason for mixed source.
       begsr custBreak;
         except custtot;
         grandTot += custTotal;
         custTotal = 0;
       endsr;
     C     FORMATLN      BEGSR
     C                   MOVEL     MONTHNM(1)    PRINTLINE
     C     RETRY         TAG
     C     DTLITEM       IFEQ      *BLANKS
     C                   MOVE      'UNKNOWN'     DTLITEM
     C                   GOTO      RETRY
     C                   ENDIF
     C                   ENDSR
       //
       // An old subprocedure whose begin and end lines are still
       // fixed, and whose body was converted in place.
     PCALCTAX          B                   EXPORT
       dcl-pi *n packed(11 : 2);
         amount packed(11 : 2) const;
         band packed(5 : 3) const;
       end-pi;
       if amount <= 0;
         return 0;
       endif;
       return %dech(amount * band : 11 : 2);
     PCALCTAX          E
       //
       // Output specifications, which stay for the same reason the
       // input ones do. Overflow reprints the heading.
     OORDPRT    H    1P                     2
     O                                           40 'ORDER REGISTER'
     O                       *DATE         Y     60
     O                       PAGE          1     70
     OORDPRT    H    OF                     2
     O                                           40 'ORDER REGISTER'
     OORDPRT    E            DETAIL         1
     O                       CUSTNM              30
     O                       DTLITEM             40
     O                       LINETOTAL     1     55
     OORDPRT    E            CUSTTOT     1  2
     O                                           30 'CUSTOMER TOTAL'
     O                       CUSTTOTAL     1     55
     OORDPRT    E            TOTALS         2
     O                                           30 'GRAND TOTAL'
     O                       GRANDTOT      1     55
     O                       ORDCOUNT      1     70
       //
       // Compile-time data closes the member.
**CTDATA taxRate
0.075
0.080
0.065
0.000
**CTDATA MONTHNM
JANUARY
FEBRUARY
MARCH
APRIL
MAY
JUNE
JULY
AUGUST
SEPTEMBER
OCTOBER
NOVEMBER
DECEMBER
