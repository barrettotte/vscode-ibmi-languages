     H*
     H* RPG IV control specification. Position 6 holds H and positions
     H* 7-80 hold keywords; there are no positional entries.
     H*
     H* Member: RPGLEH   Compilable: no (control specification only)
     H* Source: ILE RPG Reference SC09-2508, control specification
     H*         keywords.
     H* Retrieved: 2026-07-26
     H*
     H*  1         2         3         4         5         6         7         8
     H*8901234567890123456789012345678901234567890123456789012345678901234567890
      *
      * A comment line may leave position 6 blank, or repeat the
      * form-type letter as the lines above and below do.
      *
     H*
     H* Compiler behaviour and defaults.
     HDFTACTGRP(*NO)
     HACTGRP('QILE')
     HBNDDIR('MYLIB/MYBNDDIR')
     HOPTION(*NODEBUGIO : *SRCSTMT)
     HDEBUG(*YES)
     HGENLVL(10)
     HOPTIMIZE(*FULL)
     HTRUNCNBR(*NO)
     HFIXNBR(*ZONED : *INPUTPACKED)
     H*
     H* Dates, times and decimal handling.
     HDATFMT(*ISO)
     HTIMFMT(*HMS)
     HDATEDIT(*YMD)
     HDECEDIT('0.')
     HCURSYM('$')
     HDECPREC(63)
     HDATEYY(*WARN)
     HALTSEQ(*EXT)
     HSRTSEQ(*LANGIDSHR)
     HLANGID('ENU')
     H*
     H* Program identity and storage.
     HDFTNAME(INVREG)
     HTEXT('Invoice register')
     HUSRPRF(*OWNER)
     HAUT(*USE)
     HCOPYRIGHT('(C) 2026')
     HSTGMDL(*TERASPACE)
     HTHREAD(*CONCURRENT)
     HMAIN(MAINPROC)
     HPGMINFO(*PCML : *MODULE)
     H*
     H* Prototypes, conversion and character counting.
     HREQPREXP(*REQUIRE)
     HCHARCOUNT(*STDCHARSIZE)
     HCCSID(*CHAR : *JOBRUN)
     HCCSIDCVT(*EXCP)
     HCVTOPT(*DATETIME)
     HALWNULL(*USRCTL)
     HEXTBININT(*YES)
     HINTPREC(20)
     HEXPROPTS(*RESDECPOS)
     H*
     H* Listing, diagnostics and runtime options.
     HALLOC(*TERASPACE)
     HCOPYNEST(20)
     HDCLOPT(*NOCHGDSLEN)
     HENBPFRCOL(*ENTRYEXIT)
     HFLTDIV(*YES)
     HFORMSALIGN(*YES)
     HFTRANS(*SRC)
     HINDENT('| ')
     HOPENOPT(*NOCVTDATA)
     HPRFDTA(*COL)
     HVALIDATE(*NODATETIME)
     H*
     H* ASSERT sets how assertion statements are processed. The four
     H* modes are a closed set: *EXCP fails immediately, *WARN records
     H* the failure in the joblog, *NONE disables the statements, and
     H* *CALL names a procedure to call for every assertion.
     HASSERT(*EXCP)
     HASSERT(*WARN)
     HASSERT(*NONE)
     HASSERT(*CALL : ASSERTPROC)
     H*
     H* NOMAIN takes no parameter. It cannot appear with MAIN, which
     H* is on its own line above.
     HNOMAIN
     H*
     H* Several keywords may share a line, and a line may be
     H* continued by leaving the last keyword unfinished.
     HDFTACTGRP(*NO) ACTGRP('QILE') BNDDIR('LIST')
     HOPTION(*NODEBUGIO :
     H        *SRCSTMT)
     H*
     H* A page and line number in 1-5 does not disturb the columns.
01010HDFTACTGRP(*NO)
01020HOPTION(*SRCSTMT)                                                          numbered + comment
     H*
     H* Positions 81-100 are a comment area.
     HDFTACTGRP(*NO)                                                            control spec comment
