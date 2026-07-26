/* The six command definition statements.                            */
/* Member: CMDSTMT   Compilable: yes (CRTCMD)                        */
/* Source: IBM i 7.5 CL overview and concepts, command definition    */
/*   statements. Retrieved: 2026-07-26                               */

             CMD        PROMPT('Sample command')

             PARM       KWD(OBJ) TYPE(QUALOBJ) MIN(1) +
                          PROMPT('Qualified object')

             PARM       KWD(TEXT) TYPE(*CHAR) LEN(50) DFT(*BLANK) +
                          PROMPT('Description')

             PARM       KWD(LIST) TYPE(ELEMLIST) MAX(5) +
                          PROMPT('Element list')

QUALOBJ:     QUAL       TYPE(*NAME) LEN(10) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*CURLIB) (*LIBL)) PROMPT('Library')

ELEMLIST:    ELEM       TYPE(*CHAR) LEN(10) PROMPT('Name')
             ELEM       TYPE(*DEC) LEN(5 0) PROMPT('Count')

             DEP        CTL(OBJ) PARM(TEXT) NBRTRUE(*EQ 1) +
                          MSGID(CPF0001)

PMTYES:      PMTCTL     CTL(TEXT) COND((*EQ *BLANK))
