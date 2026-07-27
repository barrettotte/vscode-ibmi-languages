      *
      * A whole RPG IV program rather than a single specification: the main
      * source section in the order the compiler requires, two subprocedures
      * with their own local files and definitions, and compile-time data.
      *
      * Prints an order register grouped by customer, taking the tax rate
      * from a compile-time array and the line total from a subprocedure.
      *
      * Member: ORDREG   Compilable: complete program, but not built; its
      *         files are not defined here
      * Source: ILE RPG Reference SC09-2508, RPG IV specification types.
      * Retrieved: 2026-07-26
      *
      *
      * Main source section: the control specification comes first.
     HDFTACTGRP(*NO) ACTGRP('QILE')
     HOPTION(*SRCSTMT : *NODEBUGIO) DEBUG(*YES)
      *
      * File and definition specifications may be intermixed, which is
      * the only place in the source where two form types share a
      * section without an order between them.
     FORDHDR    IF   E           K DISK    USROPN
     DORDCOUNT         S              5I 0
     FORDDTL    IF   E           K DISK
     DGRANDTOT         S             11P 2
     FORDPRT    OF   F  132        PRINTER OFLIND(*INOF)
     DTAXRATE          S              5P 3 DIM(4) CTDATA PERRCD(1)
      *
      * A prototype for each subprocedure, so the calls below are
      * checked. The subprocedures themselves come after the main
      * section.
     DlineTotal        PR            11P 2
     Dqty                             5P 0 VALUE
     Dprice                           9P 2 VALUE
     DbandFor          PR             1A
     Damount                         11P 2 VALUE
      *
      * Input specifications rename the externally described fields.
     IORDHDR        01
     I              CUSTOMERNAME                CUSTNM
     IORDDTL        02
     I              LINEQTY                     ORDQTY
      *
      * Calculations. The cycle reads ORDHDR; the detail loop calls
      * the subprocedures defined further down.
     C                   OPEN      ORDHDR
     C   01              EVAL      ORDCOUNT = ORDCOUNT + 1
     C     ORDNBR        SETLL     ORDDTL
     C     ORDNBR        READE     ORDDTL                                 90
     C                   DOW       NOT *IN90
     C                   EVAL      LINETOT = lineTotal(ORDQTY : ORDPRC)
     C                   EVAL      GRANDTOT = GRANDTOT + LINETOT
     C                   EVAL      BAND = bandFor(LINETOT)
     C                   EXCEPT    DETAIL
     C     ORDNBR        READE     ORDDTL                                 90
     C                   ENDDO
     C   LR              EXCEPT    TOTALS
     C                   CLOSE     ORDHDR
     C                   SETON                                            LR
      *
      * Output specifications close the main source section.
     OORDPRT    HF   1P                     2
     O                                           40 'ORDER REGISTER'
     OORDPRT    E            DETAIL         1
     O                       CUSTNM              30
     O                       LINETOT       1     48
     O                       BAND                52
     OORDPRT    E            TOTALS      2
     O                                           30 'GRAND TOTAL'
     O                       GRANDTOT      1     48
      *
      * Subprocedure section. Each procedure is bracketed by a pair of
      * procedure specifications and may carry its own files and
      * definitions, which are local to it.
     PlineTotal        B                   EXPORT
     DlineTotal        PI            11P 2
     Dqty                             5P 0 VALUE
     Dprice                           9P 2 VALUE
     Dgross            S             11P 2
     C                   EVAL      gross = qty * price
     C                   RETURN    gross + (gross * TAXRATE(1))
     PlineTotal        E
      *
      * The second subprocedure opens a file of its own. A file
      * defined here is not visible to the main source section.
     PbandFor          B                   EXPORT
     DbandFor          PI             1A
     Damount                         11P 2 VALUE
     FBANDREF   IF   E           K DISK    STATIC
     Dresult           S              1A   INZ('C')
     C                   IF        amount >= 1000
     C                   EVAL      result = 'A'
     C                   ELSEIF    amount >= 100
     C                   EVAL      result = 'B'
     C                   ENDIF
     C                   RETURN    result
     PbandFor          E
      *
      * Program data. The ** form names what follows; the records
      * after it load the compile-time array declared above.
**CTDATA TAXRATE
0.075
0.080
0.065
0.000
