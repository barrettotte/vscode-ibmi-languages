       //
       // The compiler directives in a column-limited member whose statements
       // are free-form. A directive begins in column 7, so it sits one column
       // ahead of a statement, and positions 6 and 7 are blank on a statement.
       //
       // Member: CLDIR   Compilable: no (directives and declarations only)
       // Source: ILE RPG Reference SC09-2508, compiler directives.
       // Retrieved: 2026-07-28
       //
       //
       // Listing control. /TITLE takes the heading text, /SPACE a count
       // and /EJECT nothing at all.
      /TITLE Order register - customer totals
      /EJECT
      /SPACE 2
       //
       // The columns after /EJECT, and after the count /SPACE takes, are
       // a comment. Real source puts a member identifier in 81-100.
      /EJECT  a comment may follow the directive
      /EJECT                                                                    CLDIR
      /SPACE 3  and after the count as well
       //
       // Bringing in other members. Anything after the member name is a
       // comment, so it needs no // even though this is a free-form
       // member.
      /COPY QRPGLESRC,PROTOTYPES
      /INCLUDE MYLIB/QRPGLESRC,ORDERPR
      /COPY QRPGLESRC,ERRORPR  a comment may follow the name
       //
       // Control keywords, changed and put back, and the diagnostics.
      /SET DATFMT(*ISO) TIMFMT(*HMS)
      /RESTORE
      /OVERLOAD DETAIL
      /OVERLOAD NODETAIL
      /CHARCOUNT NATURAL
      /CHARCOUNT STDCHARSIZE
       //
       // A conditional block between statements. The statements it
       // brackets are ordinary free-form ones and highlight as such.
      /DEFINE DEBUGMODE
      /IF DEFINED(DEBUGMODE)
       traceLevel = 9;
      /ELSEIF NOT DEFINED(PRODUCTION)
       traceLevel = 1;
      /ELSE
       traceLevel = 0;
      /ENDIF
      /UNDEFINE DEBUGMODE
       //
       // Any source line except compile-time data may sit between the
       // directives of a block, which includes other directives and a
       // block nested inside this one.
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
       //
       // The conditional directives are the only ones that may be
       // written inside a single statement, and only inside a control,
       // file, definition or procedure statement.
       ctl-opt dftactgrp(*no)
      /IF DEFINED(*CRTBNDRPG)
               actgrp('QILE')
      /ENDIF
               option(*srcstmt);
       dcl-f ORDHDR disk(*ext)
      /IF DEFINED(DEBUGMODE)
             usage(*input)
      /ELSE
             usage(*update)
      /ENDIF
             keyed;
       dcl-s traceLevel
      /IF DEFINED(DEBUGMODE)
             packed(7 : 2);
      /ELSE
             int(10);
      /ENDIF
       dcl-proc calcTax
      /IF DEFINED(*CRTBNDRPG)
             export
      /ENDIF
             ;
       end-proc;
       //
       // A directive inside a /FREE block, which is still a
       // column-limited member and takes them the same way.
     C/FREE
       total = qty * price;
      /IF DEFINED(DEBUGMODE)
       dsply total;
      /ENDIF
     C/END-FREE
       //
       // A directive may begin in column 7 or later, so one written
       // further in is still a directive.
         /EJECT
            /SPACE 1
       //
       // /EOF stops the compiler reading the rest of the member, so it
       // comes last.
      /EOF
