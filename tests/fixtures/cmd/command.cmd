/*                                                                           */
/* A whole command definition: the parameters an order report command         */
/* would take, the values they accept, the prompting that hides the           */
/* ones that do not apply, and the dependencies between them.                 */
/*                                                                           */
/* Member: PRTORDRPT   Compilable: yes (CRTCMD)                               */
/* Source: IBM i 7.5 Control Language, command definition statements.         */
/* Retrieved: 2026-07-28                                                      */
/*                                                                           */

/*  The command itself. PROMPT supplies the title of the prompt               */
/*  display; the rest of the attributes are set on CRTCMD.                    */
             CMD        PROMPT('Print order report')

/*  A qualified name, defined by a QUAL group named below.                    */
             PARM       KWD(FILE) TYPE(QUALFILE) MIN(1) +
                           PROMPT('Order file')

QUALFILE:    QUAL       TYPE(*NAME) LEN(10) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                           SPCVAL((*LIBL) (*CURLIB)) +
                           PROMPT('Library')

/*  A restricted parameter: only the listed values are accepted,              */
/*  and RSTD(*YES) is what makes the list a restriction rather                */
/*  than a set of suggestions.                                                */
             PARM       KWD(OUTPUT) TYPE(*CHAR) LEN(6) RSTD(*YES) +
                           DFT(*PRINT) VALUES(*PRINT *OUTFILE *BOTH) +
                           PROMPT('Output')

/*  A list of elements. Each ELEM defines one position in the                 */
/*  list, and MAX on the PARM sets how many entries are allowed.              */
             PARM       KWD(RANGE) TYPE(DATERANGE) MAX(4) +
                           PROMPT('Date ranges')

DATERANGE:   ELEM       TYPE(*DATE) MIN(1) PROMPT('From')
             ELEM       TYPE(*DATE) MIN(1) PROMPT('To')
             ELEM       TYPE(*CHAR) LEN(1) DFT(N) RSTD(*YES) +
                           VALUES(Y N) PROMPT('Include held')

/*  Numeric and character parameters, with the range and the                  */
/*  single value that stands for the whole of it.                             */
             PARM       KWD(CUSTOMER) TYPE(*DEC) LEN(6 0) +
                           RANGE(1 999999) SNGVAL((*ALL 0)) +
                           DFT(*ALL) PROMPT('Customer')

             PARM       KWD(MINAMT) TYPE(*DEC) LEN(11 2) DFT(0) +
                           PROMPT('Minimum amount')

             PARM       KWD(TITLE) TYPE(*CHAR) LEN(50) +
                           DFT(*BLANK) SPCVAL((*BLANK ' ')) +
                           CASE(*MIXED) PROMPT('Report title')

/*  The output file, prompted only when OUTPUT says one is                    */
/*  wanted. PMTCTL names the condition and the label on it is                 */
/*  what the PMTCTL parameter of another statement refers to.                 */
             PARM       KWD(OUTFILE) TYPE(QUALOUT) PMTCTL(WANTFILE) +
                           PROMPT('File to receive output')

QUALOUT:     QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                           SPCVAL((*LIBL) (*CURLIB))

WANTFILE:    PMTCTL     CTL(OUTPUT) COND((*EQ *OUTFILE) +
                           (*EQ *BOTH)) NBRTRUE(*GT 0)

/*  Prompt control that hides a parameter until the one before                */
/*  it has been answered.                                                     */
             PARM       KWD(MBROPT) TYPE(*CHAR) LEN(7) RSTD(*YES) +
                           DFT(*REPLACE) VALUES(*REPLACE *ADD) +
                           PMTCTL(WANTFILE) PROMPT('Member option')

/*  Dependencies. The first requires both dates when a range is               */
/*  given, the second forbids a minimum amount on a customer                  */
/*  report, and the third holds whenever the command is run.                  */
             DEP        CTL(RANGE) PARM(TITLE) NBRTRUE(*EQ 1) +
                           MSGID(USR0001)

             DEP        CTL(&CUSTOMER *NE *ALL) PARM((&MINAMT *EQ 0)) +
                           MSGID(USR0002)

             DEP        CTL(*ALWAYS) PARM((&OUTPUT *NE ' ')) +
                           MSGID(USR0003)

/*  The relational operators a condition may use, each once.                  */
             DEP        CTL(&MINAMT *GT 0) PARM(RANGE)
             DEP        CTL(&MINAMT *GE 0) PARM(RANGE)
             DEP        CTL(&MINAMT *LT 999) PARM(RANGE)
             DEP        CTL(&MINAMT *LE 999) PARM(RANGE)
             DEP        CTL(&TITLE *NE ' ') PARM(RANGE)
             DEP        CTL(&CUSTOMER *NG 0) PARM(RANGE)
             DEP        CTL(&CUSTOMER *NL 0) PARM(RANGE)
             DEP        CTL((&MINAMT *GT 0) *AND (&CUSTOMER *EQ 0)) +
                           PARM(RANGE)
             DEP        CTL((&MINAMT *GT 0) *OR (&CUSTOMER *EQ 0)) +
                           PARM(RANGE)
             DEP        CTL(*NOT (&MINAMT *EQ 0)) PARM(RANGE)
