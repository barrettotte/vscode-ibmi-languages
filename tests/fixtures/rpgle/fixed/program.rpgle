      *
      * A whole RPG IV program rather than a single specification: the main
      * source section in the order the compiler requires, three
      * subprocedures with their own local files and definitions, and
      * compile-time data.
      *
      * Prints an order register grouped by customer, bands each line,
      * writes an audit row per order and logs anything that looks stale.
      * fully-free/program.rpgle tells the same story in free form.
      *
      * Member: ORDREG   Compilable: complete program, but not built; its
      *         files are not defined here
      * Source: ILE RPG Reference SC09-2508, RPG IV specification types.
      * Retrieved: 2026-07-27
      *
      *
      * Main source section: the control specification comes first.
     HDFTACTGRP(*NO) ACTGRP('QILE')
     HOPTION(*SRCSTMT : *NODEBUGIO) DEBUG(*YES)
     HDATFMT(*ISO) TIMFMT(*HMS) DECEDIT('0.')
     HBNDDIR('ORDBND') COPYRIGHT('(C) Example Corp')
      *
      * File and definition specifications may be intermixed, which is
      * the only place in the source where two form types share a
      * section without an order between them. A keyword field too
      * long for one line continues with F in 6 and 7-43 blank.
     FORDHDR    IF   E           K DISK    USROPN
     F                                     INFDS(ORDHDRIN)
     DORDCOUNT         S              5I 0
     FORDDTL    IF   E           K DISK
     DGRANDTOT         S             11P 2
     FORDAUD    UF A E           K DISK
     DERRMSG           S             80A
     FORDPRT    OF   F  132        PRINTER OFLIND(*INOF)
      *
      * The two parameters the program is called with, and the work
      * fields the calculations use.
     DCOMPANY          S              3A
     DRPTDATE          S               D   DATFMT(*ISO)
     DSAVEDKEY         S              7P 0
     DDAYSOLD          S             10I 0
      *
      * Named constants, then the three compile-time arrays.
     DRPTTITLE         C                   CONST('ORDER REGISTER')
     DBANDAFLR         C                   CONST(1000.00)
     DBANDBFLR         C                   CONST(100.00)
     DSTALEDAY         C                   CONST(90)
     DTAXRATE          S              5P 3 DIM(4) CTDATA PERRCD(1)
     DQTYBREAK         S              5P 0 DIM(4) CTDATA PERRCD(1)
     DBANDNAME         S             10A   DIM(3) CTDATA PERRCD(1)
      *
      * A qualified structure for the line being printed, then the two
      * the system fills in. S in 23 with DS in 24-25 marks the program
      * status structure, whose subfields are given by position.
     DORDINFO          DS                  QUALIFIED
     D NUMBER                         7P 0
     D CUSTOMER                      30A
     D LINETOT                       11P 2
     D BAND                           1A
     DPGMSTAT         SDS
     D PROCNAM                 1     10A
     D STATCD                 11     15S 0
     D ROUTINE                29     36A
     D PARMCNT                37     39S 0
     D EXCPID                 40     46A
     D PGMNAM                334    343A
     D USRNAM                358    367A
     DORDHDRIN         DS
     D FILENAME                1      8A
     D OPENIND                 9      9N
     D FSTATUS                11     15S 0
     D FOPCODE                38     43A
      *
      * A prototype for each subprocedure, so the calls below are
      * checked, then one for a program and one for a bound procedure
      * called by name.
     DlineTotal        PR            11P 2
     Dqty                             5P 0 VALUE
     Dprice                           9P 2 VALUE
     DbandFor          PR             1A
     Damount                         11P 2 VALUE
     DfmtAmount        PR            20A   VARYING
     Damount                         11P 2 VALUE
     DwithSign                        1N   VALUE OPTIONS(*NOPASS)
     DlogError         PR                  EXTPGM('ERRLOG')
     Dmessage                        80A   CONST
     DfromPgm                        10A   CONST
     DtoUpper          PR            30A   EXTPROC('CVTUPPER')
     Dtext                           30A   CONST
      *
      * Input specifications rename the externally described fields.
     IORDHDR        01
     I              CUSTOMERNM                  ORDCUST
     I              ORDERDATE                   ORDDATE
     IORDDTL        02
     I              LINEQTY                     ORDQTY
      *
      * Calculations. The entry list names the parameters the program
      * is called with, and the key list is the composite key the
      * audit file is read by. Neither has a free-form spelling.
     C     *ENTRY        PLIST
     C                   PARM                    COMPANY
     C                   PARM                    RPTDATE
     C     AUDKEY        KLIST
     C                   KFLD                    COMPANY
     C                   KFLD                    SAVEDKEY
      *
      * Opening a USROPN file can fail, so it is guarded. %STATUS
      * reports what went wrong and the program gives up cleanly.
     C                   MONITOR
     C                   OPEN      ORDHDR
     C                   ON-ERROR
     C                   EVAL      ERRMSG = 'Open failed: ' + %CHAR(%STATUS)
     C                   CALLP     logError(ERRMSG : PGMSTAT.PGMNAM)
     C                   SETON                                            LR
     C                   RETURN
     C                   ENDMON
     C                   EXCEPT    HEADINGS
      *
      * The order loop. Each header is read, its details are totalled
      * and banded, and an audit row is written for the order.
     C                   READ      ORDHDR                                 90
     C                   DOW       NOT *IN90
     C   01              EVAL      ORDCOUNT = ORDCOUNT + 1
     C                   EVAL      SAVEDKEY = ORDNBR
     C                   EVAL      ORDINFO.NUMBER = ORDNBR
     C                   EVAL      ORDINFO.CUSTOMER = toUpper(ORDCUST)
     C                   EVAL      DAYSOLD = %DIFF(RPTDATE : ORDDATE : *D)
     C                   IF        DAYSOLD > STALEDAY
     C                   EXSR      STALEORD
     C                   ENDIF
     C     SAVEDKEY      SETLL     ORDDTL
     C     SAVEDKEY      READE     ORDDTL                                 91
     C                   DOW       NOT *IN91
     C                   EVAL      ORDINFO.LINETOT = lineTotal(ORDQTY : ORDPRC)
     C                   EVAL      ORDINFO.BAND = bandFor(ORDINFO.LINETOT)
     C                   EVAL      GRANDTOT = GRANDTOT + ORDINFO.LINETOT
     C                   IF        *INOF
     C                   EXCEPT    HEADINGS
     C                   EVAL      *INOF = *OFF
     C                   ENDIF
     C                   EXCEPT    DETAIL
     C     SAVEDKEY      READE     ORDDTL                                 91
     C                   ENDDO
     C                   EXSR      WRITEAUD
     C                   READ      ORDHDR                                 90
     C                   ENDDO
     C                   EXCEPT    TOTALS
     C                   CLOSE     ORDHDR
     C                   SETON                                            LR
     C                   RETURN
      *
      * Subroutines. They are part of the main source section and see
      * everything declared in it.
     C     STALEORD      BEGSR
     C                   EVAL      ERRMSG = 'Stale order ' + %CHAR(SAVEDKEY)
     C                   CALLP     logError(ERRMSG : PGMSTAT.PGMNAM)
     C                   ENDSR
     C     WRITEAUD      BEGSR
     C     AUDKEY        CHAIN     ORDAUD                             99
     C   99              EVAL      ERRMSG = 'Audit chain failed'
     C                   IF        NOT *IN99 AND %FOUND(ORDAUD)
     C                   EVAL      AUDTOTAL = GRANDTOT
     C                   IF        AUDTOTAL = 0
     C                   DELETE    ORDAUDR
     C                   ELSE
     C                   UPDATE    ORDAUDR
     C                   ENDIF
     C                   ELSE
     C                   EVAL      AUDORDER = SAVEDKEY
     C                   EVAL      AUDTOTAL = GRANDTOT
     C                   WRITE     ORDAUDR
     C                   ENDIF
     C                   ENDSR
      *
      * Output specifications close the main source section. The
      * overflow indicator reprints the heading on a new page.
     OORDPRT    HF   1P                     2
     O                                           40 'ORDER REGISTER'
     O                       *DATE         Y     60
     O                       PAGE          1     70
     OORDPRT    H    OF                     2
     O                                           40 'ORDER REGISTER'
     OORDPRT    E            DETAIL         1
     O                       CUSTOMER            30
     O                       LINETOT       1     48
     O                       BAND                52
     OORDPRT    E            TOTALS      2
     O                                           30 'GRAND TOTAL'
     O                       GRANDTOT      1     48
     O                       ORDCOUNT      1     64
      *
      * Subprocedure section. Each procedure is bracketed by a pair of
      * procedure specifications and may carry its own files and
      * definitions, which are local to it.
     PlineTotal        B                   EXPORT
     DlineTotal        PI            11P 2
     Dqty                             5P 0 VALUE
     Dprice                           9P 2 VALUE
     Dgross            S             11P 2
     Didx              S             10I 0
     C                   EVAL      gross = qty * price
     C                   EVAL      idx = %LOOKUPGE(qty : QTYBREAK)
     C                   IF        idx = 0
     C                   EVAL      idx = %ELEM(TAXRATE)
     C                   ENDIF
     C                   RETURN    gross + (gross * TAXRATE(idx))
     PlineTotal        E
      *
      * The second subprocedure opens a file of its own. A file
      * defined here is not visible to the main source section. A
      * SELECT group picks the band.
     PbandFor          B                   EXPORT
     DbandFor          PI             1A
     Damount                         11P 2 VALUE
     FBANDREF   IF   E           K DISK    STATIC
     Dresult           S              1A   INZ('C')
     C                   MONITOR
     C     amount        CHAIN(E)  BANDREF
     C                   SELECT
     C                   WHEN      %FOUND(BANDREF)
     C                   EVAL      result = BANDCODE
     C                   WHEN      amount >= BANDAFLR
     C                   EVAL      result = 'A'
     C                   WHEN      amount >= BANDBFLR
     C                   EVAL      result = 'B'
     C                   OTHER
     C                   EVAL      result = 'C'
     C                   ENDSL
     C                   ON-ERROR  *FILE
     C                   EVAL      result = '?'
     C                   ON-ERROR
     C                   EVAL      result = '!'
     C                   ENDMON
     C                   RETURN    result
     PbandFor          E
      *
      * The third takes an optional parameter, so it has to ask
      * whether it was passed before reading it.
     PfmtAmount        B                   EXPORT
     DfmtAmount        PI            20A   VARYING
     Damount                         11P 2 VALUE
     DwithSign                        1N   VALUE OPTIONS(*NOPASS)
     Dedited           S             20A
     Dsigned           S              1N   INZ(*OFF)
     C                   IF        %PARMS >= %PARMNUM(withSign)
     C                   EVAL      signed = withSign
     C                   ENDIF
     C                   EVAL      edited = %EDITC(amount : '1')
     C                   IF        signed AND amount < 0
     C                   EVAL      edited = '-' + %TRIML(edited)
     C                   ENDIF
     C                   IF        %SCAN('.' : edited) = 0
     C                   EVAL      edited = %TRIMR(edited) + '.00'
     C                   ENDIF
     C                   RETURN    %TRIM(edited)
     PfmtAmount        E
      *
      * Program data. The ** form names what follows; the records
      * after it load the compile-time array declared above.
**CTDATA TAXRATE
0.075
0.080
0.065
0.000
**CTDATA QTYBREAK
00010
00050
00100
00500
**CTDATA BANDNAME
PREMIUM
STANDARD
BASIC
