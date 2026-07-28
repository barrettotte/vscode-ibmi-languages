       //
       // The compiler directives in a member that mixes the two formats. A
       // directive may be written against a form type, the way fixed source
       // does it, or with position 6 blank, and both begin in column 7.
       //
       // Member: MIXDIR   Compilable: no (directives and declarations only)
       // Source: ILE RPG Reference SC09-2508, compiler directives.
       // Retrieved: 2026-07-28
       //
       //
       // Listing control, written both ways. The form type is the only
       // difference; the directive itself begins in column 7 either way.
     H/TITLE Order register - customer totals
      /TITLE the form type may be left blank
     C/EJECT
      /SPACE 2
       //
       // The columns after /EJECT, and after the count /SPACE takes, are
       // a comment. Real source puts a member identifier in 81-100.
     C/EJECT                                                                    MIXDIR
      /EJECT                                                                    MIXDIR
      /SPACE 3  and after the count as well
       //
       // Bringing in other members, against a form type and without.
     D/COPY QRPGLESRC,PROTOTYPES
      /INCLUDE MYLIB/QRPGLESRC,ORDERPR
     D/COPY QRPGLESRC,ERRORPR  a comment may follow the name
       //
       // Control keywords and the diagnostics.
      /SET DATFMT(*ISO) TIMFMT(*HMS)
      /RESTORE
     C/OVERLOAD DETAIL
     C/CHARCOUNT NATURAL
      /CHARCOUNT STDCHARSIZE
       //
       // A conditional block bracketing both formats at once, which is
       // what only a mixed member can show. The specifications and the
       // statements between the directives are ordinary ones.
      /DEFINE DEBUGMODE
     D/IF DEFINED(DEBUGMODE)
     DTRACELVL         S              5P 0 INZ(9)
       dcl-s traceText char(50) inz('debug');
     D/ELSEIF NOT DEFINED(PRODUCTION)
     DTRACELVL         S              5P 0 INZ(1)
     D/ELSE
       dcl-s traceLevel packed(5 : 0) inz(0);
     D/ENDIF
      /UNDEFINE DEBUGMODE
       //
       // The same around calculations, fixed and free together.
     C/IF DEFINED(*CRTBNDRPG)
     C                   EVAL      GRANDTOT = 0
       orderCount = 0;
     C/ENDIF
       //
       // Any source line except compile-time data may sit between the
       // directives of a block, which includes other directives and a
       // block nested inside this one.
      /IF DEFINED(QIBM_INCLUDED)
      /EOF
      /ENDIF
      /DEFINE QIBM_INCLUDED
      /IF NOT DEFINED(PRODUCTION)
     D/COPY QRPGLESRC,DEBUGPR
     D/IF DEFINED(*CRTBNDRPG)
      /INCLUDE QRPGLESRC,BINDPR
     D/ENDIF
      /EJECT
      /ENDIF
       //
       // A directive inside a /FREE block, which the block does not
       // change: the member is still column-limited.
     C/FREE
       total = qty * price;
      /IF DEFINED(DEBUGMODE)
       dsply total;
      /ENDIF
     C/END-FREE
       //
       // A directive may begin in column 7 or later, against a form
       // type or without one.
     C   /EJECT
            /SPACE 1
       //
       // /EOF stops the compiler reading the rest of the member, so it
       // comes last.
      /EOF
