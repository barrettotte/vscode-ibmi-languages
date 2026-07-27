     C*
     C* RPG IV calculation specification: both layouts, every operation
     C* code, the operation extenders, and the comparison suffixes.
     C*
     C*  7-8  control level    9-11 indicators    12-25 factor 1
     C* 26-35 operation and extender
     C* 36-49 factor 2   50-63 result   64-68 length   69-70 decimals
     C* 71-76 resulting indicators, or 36-80 extended factor 2
     C*
     C* Member: RPGLEC   Compilable: no (calculations only, no files)
     C* Source: ILE RPG Reference SC09-2508, calculation specification
     C*         and the operation codes chapter.
     C* Retrieved: 2026-07-26
     C*
     C*  1         2         3         4         5         6         7         8
     C*8901234567890123456789012345678901234567890123456789012345678901234567890
      *
      * A comment line may leave position 6 blank.
     C*
     C* Control level: L0 total time, L1-L9 control break, LR last
     C* record, SR subroutine, AN and OR continuation.
     CL0   GRAND         ADD       PAGE          GRAND
     CL1   LVLTOT        ADD       AMOUNT        LVLTOT
     CLR                 EXSR      FINAL
     CSR   *BLANKS       MOVE                    MSG
     C*
     C* Conditioning indicators, N in 9 to test for off.
     C   01'Y'           MOVE                    FOUND
     C  N01'N'           MOVE                    FOUND
     C   LR              SETON                                            RT
     C   U1              EXCEPT
     C   KA              SETOFF                                       20
     CAN 02'X'           MOVE                    FLAG
     COR 03'Z'           MOVE                    FLAG
     C*
     C* Every resulting indicator: 01-99, KA-KN and KP-KY, H1-H9,
     C* L1-L9, LR, MR, OA-OG and OV, U1-U8, and RT.
     C                   SETON                                        0199MR
     C                   SETON                                        KAKNKP
     C                   SETON                                        KYH1H9
     C                   SETON                                        L1L9LR
     C                   SETON                                        OAOGOV
     C                   SETON                                        U1U8RT
     C*
     C* Arithmetic and move operations.
     C     QTYORD        ADD       QTYSHP        QTYTOT            7 0202122
     C     QTYORD        SUB       QTYSHP        QTYBAK
     C     QTYTOT        MULT(H)   PRICE         AMOUNT
     C     AMOUNT        DIV(H)    QTYTOT        UNIT
     C*
     C* The reference allows blanks inside the extender for
     C* readability, so all three of these are the same operation.
     C     QTYTOT        MULT (H)  PRICE         AMOUNT
     C     QTYTOT        MULT ( H )PRICE         AMOUNT
     C*
     C                   MVR                     REMAIN
     C                   Z-ADD     *ZERO         AMOUNT
     C                   Z-SUB     AMOUNT        CREDIT
     C                   SQRT      AREA          SIDE
     C                   XFOOT     TOTALS        GRAND
     C     *BLANKS       MOVE                    CUSTNM
     C     'PENDING'     MOVEL(P)                STATUS
     C     FLAGS         MOVEA                   HOLD
     C     ZONEA         MHHZO                   ZONEB
     C     ZONEA         MHLZO                   ZONEB
     C     ZONEA         MLHZO                   ZONEB
     C     ZONEA         MLLZO                   ZONEB
     C*
     C* Field names that are also definition keywords. These are
     C* operands here, not keywords, and must stay unhighlighted.
     C     *BLANKS       MOVE                    DATE
     C     *BLANKS       MOVE                    TIME
     C     *BLANKS       MOVE                    STATUS
     C     *BLANKS       MOVE                    VALUE
     C     *BLANKS       MOVE                    LEN
     C     *BLANKS       MOVE                    POS
     C     *BLANKS       MOVE                    PREFIX
     C     *BLANKS       MOVE                    CONST
     C     LEN           ADD       POS           DIM
     C*
     C* String, bit and test operations.
     C     FIRST         CAT(P)    LAST:1        FULLNM
     C     6             SUBST(P)  FULLNM:1      PREFIX
     C     ','           SCAN      FULLNM        POSN                     30
     C     '01234'       CHECK     DIGITS        POSN                     31
     C     ' '           CHECKR    FULLNM        POSN                     32
     C     LOW:UPP       XLATE(P)  FULLNM        FULLNM
     C                   BITON     '01234567'    MASK
     C                   BITOFF    '07'          MASK
     C                   TESTB     '0'           MASK                 404142
     C                   TESTN                   NUMFLD               434445
     C                   TESTZ                   ALPFLD               464748
     C     *ISO          TEST(DE)  ORDDAT                                 49
     C*
     C* The comparison suffix is GT LT EQ NE GE or LE.
     C     QTYORD        IFEQ      MAXQTY
     C     QTYORD        ANDLE     MAXQTY
     C     QTYORD        ORNE      MAXQTY
     C     QTYORD        DOWLT     MAXQTY
     C     QTYORD        DOUGE     MAXQTY
     C     QTYORD        WHENGT    MAXQTY
     C     QTYORD        CASEQ     MAXQTY
     C     QTYORD        CABNE     MAXQTY        OVER
     C     QTYORD        COMP      QTYSHP                             505152
     C     1             DO        10            IDX
     C                   ENDDO
     C                   ENDIF
     C                   ENDDO
     C                   ENDCS
     C                   ENDSL
     C                   ENDFOR
     C                   ENDMON
     C                   END
     C*
     C* File operations, with the E extender.
     C     ORDKEY        CHAIN(E)  ORDHDR
     C                   READ(E)   ORDHDR                               6162
     C     ORDKEY        READE(E)  ORDDTL                                 63
     C                   READP     ORDHDR                                 64
     C     ORDKEY        READPE    ORDDTL                                 65
     C                   READC     SFLREC                                 66
     C     ORDKEY        SETLL     ORDHDR                             676869
     C     ORDKEY        SETGT     ORDHDR                             70
     C                   WRITE(E)  ORDDTL
     C                   UPDATE(E) ORDHDR
     C     ORDKEY        DELETE(E) ORDHDR
     C                   EXCEPT    HEADNG
     C                   EXFMT(E)  CUSTFMT
     C                   OPEN(E)   ORDHDR
     C                   CLOSE(E)  ORDHDR
     C                   FEOD(E)   ORDHDR
     C                   FORCE     ORDSEC
     C     DEVICE        NEXT(E)   CUSTDSP
     C     DEVICE        POST(E)   CUSTDSP
     C     DEVICE        ACQ(E)    CUSTDSP
     C     DEVICE        REL(E)    CUSTDSP
     C                   UNLOCK(E) ORDHDR
     C     BOUNDRY       COMMIT(E)
     C                   ROLBK(E)
     C*
     C* Calls, lists and pointers.
     C                   CALL(E)   'PAYCALC'     SPCPLS
     C                   CALLB(D)  'PAYBIND'
     C     FROMFL        PARM      TOFLD         PARM1
     C     *ENTRY        PLIST
     C     ORDKEY        KLIST
     C                   KFLD                    ORDCO
     C                   ALLOC(E)  1024          BASEPTR
     C                   REALLOC(E)2048          BASEPTR
     C                   DEALLOC(N)              BASEPTR
     C*
     C* Subroutines, monitors and error handling.
     CSR   ACTSR         BEGSR
     C                   LEAVESR
     CSR                 ENDSR
     C                   MONITOR
     C                   ON-ERROR  *FILE
     C                   ON-EXCP   'CPF4131'
     C                   ON-EXIT                 ENDFLG
     C                   ITER
     C                   LEAVE
     C                   GOTO      ENDTAG
     C     ENDTAG        TAG
     C                   EXSR      ACTSR
     C                   SELECT
     C                   OTHER
     C                   ELSE
     C*
     C* Dates, times and durations.
     C     ORDDAT        ADDDUR    30:*DAYS      DUEDAT
     C     DUEDAT        SUBDUR    ORDDAT        AGE:*DAYS
     C     ORDDAT        EXTRCT    *YEARS        ORDYR
     C                   TIME                    NOWTIM
     C*
     C* Data area, occurrence and other operations.
     C     *LIKE         DEFINE    ORDAMT        WRKAMT
     C     *LOCK         IN(E)     LDADS
     C                   OUT(E)    LDADS
     C     IDX           OCCUR(E)  MULTDS        CUROCC
     C                   CLEAR     ORDDS
     C                   RESET(E)  ORDDS
     C                   SETON                                        2021LR
     C                   SETOFF                                       202122
     C     'GO?'         DSPLY(E)  *EXT          ANSWER
     C     'DMP1'        DUMP(A)
     C                   SHTDN                                        94
     C     SRCHKY        LOOKUP    TABPRT                             95  96
     C                   SORTA     TOTALS
     C                   SORTA(A)  TOTALS
     C                   SORTA(D)  TOTALS
     C     QTYORD        ASSERT-T  *ZERO
     C     QTYORD        ASSERT-F  MAXQTY
     C     *INFO         SND-MSG(E)'Done'
     C*
     C* The extended factor 2 layout: the expression runs 36-80.
     C                   EVAL      AMOUNT = QTYORD * PRICE
     C                   EVAL(H)   UNIT = AMOUNT / QTYTOT
     C                   EVALR     PADDED = %TRIMR(CUSTNM)
     C                   EVAL-CORR TARGET = SOURCE
     C                   IF        QTYORD > *ZERO AND STATUS = 'A'
     C                   ELSEIF    QTYORD = *ZERO
     C                   DOW       IDX <= %ELEM(TOTALS)
     C                   DOU       IDX > MAXIDX
     C                   FOR       IDX = 1 TO 10 BY 2
     C                   FOR-EACH  ELEM IN TOTALS
     C                   WHEN      STATUS = 'A'
     C                   WHEN-IS   'A'
     C                   WHEN-IN   %RANGE('A' : 'M')
     C                   RETURN    %TRIM(CUSTNM)
     C                   CALLP(E)  CALCTAX(ORDAMT : TAXRAT)
     C                   ON-ERROR  *ALL
     C                   DATA-INTO ORDDS %DATA(JSONBUF) %PARSER('YAJLINTO')
     C                   DATA-GEN  ORDDS %DATA(JSONBUF) %GEN('YAJLDTAGEN')
     C                   XML-INTO  ORDDS %XML(XMLBUF : 'case=any')
     C                   XML-SAX(E)%HANDLER(SAXPROC : PARMDS)
     C*
     C* Positions 81-100 are a comment area.
     C                   EVAL                                                   calculation comment
     C                   EVAL      TOTAL = TOTAL + 1                            after an expression
     C*
     C* An extended factor 2 literal continues on the next line, and
     C* a comment line between the two halves does not end it.
     C                   EVAL      MSG = 'first half of-
     C* a comment between the two halves
     C                             the literal'
     C*
     C* A page and line number in 1-5 does not disturb the columns.
05010C                   SETON                                            LR
