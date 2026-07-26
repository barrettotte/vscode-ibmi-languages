/* PARM keyword parameters and their special values.                 */
/* Member: CMDPARM                                                   */
/* Compilable: no - an exhaustive keyword list, not a working file.  */
/* Source: IBM i 7.5 CL overview and concepts. Retrieved: 2026-07-26 */

             CMD        PROMPT('Parameter attributes')

/* Data types accepted by TYPE.                                      */
             PARM       KWD(P01) TYPE(*CHAR)  LEN(10)
             PARM       KWD(P02) TYPE(*NAME)  LEN(10)
             PARM       KWD(P03) TYPE(*SNAME) LEN(10)
             PARM       KWD(P04) TYPE(*CNAME) LEN(10)
             PARM       KWD(P05) TYPE(*PNAME) LEN(32)
             PARM       KWD(P06) TYPE(*GENERIC) LEN(10)
             PARM       KWD(P07) TYPE(*DEC)   LEN(15 5)
             PARM       KWD(P08) TYPE(*LGL)   LEN(1)
             PARM       KWD(P09) TYPE(*DATE)  LEN(7)
             PARM       KWD(P10) TYPE(*TIME)  LEN(6)
             PARM       KWD(P11) TYPE(*HEX)   LEN(8)
             PARM       KWD(P12) TYPE(*ZEROELEM)
             PARM       KWD(P13) TYPE(*NULL)
             PARM       KWD(P14) TYPE(*CMDSTR) LEN(256)
             PARM       KWD(P15) TYPE(*CMD)
             PARM       KWD(P16) TYPE(*INT2)
             PARM       KWD(P17) TYPE(*INT4)
             PARM       KWD(P18) TYPE(*UINT2)
             PARM       KWD(P19) TYPE(*UINT4)
             PARM       KWD(P20) TYPE(*X)     LEN(4)
             PARM       KWD(P21) TYPE(*VARY)  LEN(20)

/* Attribute keywords.                                               */
             PARM       KWD(A01) TYPE(*CHAR) LEN(10) MIN(1) MAX(3)
             PARM       KWD(A02) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          VALUES(*YES *NO)
             PARM       KWD(A03) TYPE(*CHAR) LEN(10) DFT(*NONE) +
                          SPCVAL((*NONE ' ') (*ALL '*'))
             PARM       KWD(A04) TYPE(*CHAR) LEN(10) SNGVAL(*ALL)
             PARM       KWD(A05) TYPE(*DEC) LEN(5 0) RANGE(1 999)
             PARM       KWD(A06) TYPE(*CHAR) LEN(10) EXPR(*YES) +
                          VARY(*YES *INT2)
             PARM       KWD(A07) TYPE(*CHAR) LEN(10) CASE(*MIXED) +
                          FULL(*YES) PASSATR(*YES) PASSVAL(*NULL)
             PARM       KWD(A08) TYPE(*CHAR) LEN(10) CHOICE(*VALUES) +
                          CHOICEPGM(MYLIB/MYPGM) PMTCTLPGM(MYLIB/MYCTL)
             PARM       KWD(A09) TYPE(*CHAR) LEN(10) INLPMTLEN(20) +
                          DSPINPUT(*NO) ALWUNPRT(*NO) ALWVAR(*NO)
             PARM       KWD(A10) TYPE(*CHAR) LEN(10) KEYPARM(*YES) +
                          PROMPT('Prompt text' 10)
