       //
       // Fixed-format specifications and free-form statements alternating
       // line by line. A form type in position 6 makes a line fixed; blanks
       // in 6 and 7 make it free, and nothing else marks the change.
       //
       // Member: MIXTRAN   Compilable: no (declarations and calculations)
       // Source: ILE RPG Reference SC09-2508, free-form statements.
       // Retrieved: 2026-07-27
       //
       //
       // Control: the fixed specification, then the free statement.
     HDFTACTGRP(*NO) ACTGRP('QILE')
       ctl-opt option(*srcstmt : *nodebugio);
       //
       // Files: the same file both ways.
     FORDHDR    IF   E           K DISK
       dcl-f ORDDTL disk(*ext) usage(*input) keyed;
     FORDPRT    OF   F  132        PRINTER OFLIND(*INOF)
       //
       // Definitions, alternating.
     DGRANDTOT         S             13P 2 INZ(0)
       dcl-s orderCount int(10) inz(0);
     DORDERDS          DS                  QUALIFIED
     D NUMBER                         7P 0
       dcl-s custName varchar(30);
       //
       // Input and output specifications have no free-form spelling, so
       // they stay in columns even in a converted program.
     IORDHDR        01
     I              CUSTOMERNM                  CUSTNM
       //
       // Calculations: fixed, free, and back again.
     C                   EVAL      GRANDTOT = 0
       orderCount = 0;
     C     ORDKEY        CHAIN(E)  ORDHDR
       if %found(ORDHDR);
         orderCount += 1;
       endif;
     C                   EXCEPT    DETAIL
       //
       // A /FREE block, which a column-limited member may still carry.
     C/FREE
       grandTotal += ordAmount;
       if grandTotal > 1000;
         except totals;
       endif;
     C/END-FREE
     C                   SETON                                        LR
       //
       // Output specifications, which also stay fixed.
     OORDPRT    E            DETAIL         1
     O                       CUSTNM              30
     OORDPRT    E            TOTALS         2
     O                       GRANDTOT      1     48
       //
       // A subprocedure whose begin and end lines stayed fixed while
       // its interface and body moved to free form. Only a begin line
       // carries keywords, and a keyword field too long for one line
       // continues on a line with P in 6 and 7-43 blank.
     PCALCTAX          B                   EXPORT
     P                                     SERIALIZE
       dcl-pi *n packed(11 : 2);
         amount packed(11 : 2) value;
         rate packed(5 : 3) const;
       end-pi;
       return amount * rate;
     PCALCTAX          E
       //
       // Past column 80 a free-form line needs // before its comment;
       // a fixed line does not, 81-100 being its own comment area.
       orderCount += 1;                                                           // on a free-form line
     C                   EVAL      GRANDTOT = 0                                   a fixed-format comment area
