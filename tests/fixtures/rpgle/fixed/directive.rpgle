     H*
     H* The compiler directives in column-limited source. The form type sits
     H* in position 6, or is left blank, and the directive begins in 7.
     H*
     H* Member: RPGLEDIR  Compilable: no (directives and declarations only)
     H* Source: ILE RPG Reference SC09-2508, compiler directives.
     H* Retrieved: 2026-07-27
     H*
     H*
     H* Listing control, written against a form type.
     H/TITLE Order register - customer totals
      /TITLE the form type may be left blank
     C/EJECT
      /SPACE 2
     C*
     C* /EJECT takes no operand and /SPACE takes only a count, and the
     C* reference records the columns after either as a comment. Real
     C* source puts a member identifier there, in 81-100.
     C/EJECT  a comment may follow the directive
      /EJECT                                                                    TPBFVR
01010C/EJECT                                                                    numbered + comment
      /SPACE 3  and after the count as well
     C*
     C* A directive may begin in column 7 or later, so one written
     C* further in is still a directive.
         /EJECT
     D*
     D* Bringing in other members.
     D/COPY QRPGLESRC,PROTOTYPES
      /COPY MYLIB/QRPGLESRC,ORDERPR
     D/INCLUDE QRPGLESRC,CONSTANTS
     D/COPY QRPGLESRC,ERRORPR  a comment may follow the name
     H*
     H* Control keywords, changed and put back.
      /SET DATFMT(*ISO) TIMFMT(*HMS)
      /RESTORE
     C*
     C* Diagnostics, each with its closed set.
      /OVERLOAD DETAIL
      /OVERLOAD NODETAIL
      /CHARCOUNT NATURAL
      /CHARCOUNT STDCHARSIZE
     C*
     C* A conditional block. The specifications between the directives
     C* are ordinary ones and highlight as such.
      /DEFINE DEBUGMODE
     C/IF DEFINED(DEBUGMODE)
     C                   EVAL      TRACELVL = 9
     C/ELSEIF NOT DEFINED(PRODUCTION)
     C                   EVAL      TRACELVL = 1
     C/ELSE
     C                   EVAL      TRACELVL = 0
     C/ENDIF
      /UNDEFINE DEBUGMODE
     D*
     D* A conditional block may also bracket definitions.
     D/IF DEFINED(*CRTBNDRPG)
     DBOUNDPGM         S              1A   INZ('Y')
     D/ENDIF
     D*
     D* Any source line except compile-time data may sit between the
     D* directives of a conditional block, which includes other
     D* directives and a block nested inside this one.
      /IF DEFINED(QIBM_INCLUDED)
      /EOF
      /ENDIF
      /DEFINE QIBM_INCLUDED
      /IF NOT DEFINED(PRODUCTION)
      /COPY QRPGLESRC,DEBUGPR
      /IF DEFINED(*CRTBNDRPG)
      /INCLUDE QRPGLESRC,BINDPR
      /ENDIF
      /EJECT
      /ENDIF
     C*
     C* /FREE and /END-FREE are recorded as no longer used, but the
     C* compiler still checks their syntax, so they are still written.
     C/FREE
       TOTAL = QTY * PRICE;
     C/END-FREE
     C*
     C* /EOF stops the compiler reading the rest of the member.
      /EOF
