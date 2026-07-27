**FREE
//
// The compiler directives. A directive begins with a slash and, unlike
// a statement, does not end in a semicolon.
//
// Member: FREEDIR   Compilable: no (directives and declarations only)
// Source: ILE RPG Reference SC09-2508, compiler directives.
// Retrieved: 2026-07-26
//
//
// Listing control. /TITLE takes the heading text, /SPACE a number
// of lines and /EJECT nothing at all.
/title Order register - customer totals
/eject
/space 2
//
// Bringing in other members. The two spellings mean the same,
// and the member may be qualified by its file.
/copy QRPGLESRC,PROTOTYPES
/include QRPGLESRC,CONSTANTS
/copy MYLIB/QRPGLESRC,ORDERPR
/copy QRPGLESRC,ERRORPR  a comment may follow the name
//
// /SET changes control keywords for the source that follows and
// /RESTORE puts back what was in force before it.
/set datfmt(*iso) timfmt(*hms)
/set ccsid(*char : *utf8)
/restore
//
// Diagnostics. Both of these carry a closed set of values.
/overload detail
/overload nodetail
/charcount natural
/charcount stdcharsize
//
// Conditional compilation. A condition is defined, tested with
// DEFINED or NOT DEFINED, and may be undefined again.
/define DEBUGMODE
/define PRODUCTION
/if defined(DEBUGMODE)
dcl-s traceLevel int(10) inz(9);
/elseif defined(PRODUCTION)
dcl-s traceLevel int(10) inz(0);
/elseif not defined(DEBUGMODE)
dcl-s traceLevel int(10) inz(1);
/else
dcl-s traceLevel int(10) inz(5);
/endif
/undefine DEBUGMODE
//
// Nesting, and the predefined conditions the compiler supplies.
/if defined(*CRTBNDRPG)
/if defined(*V7R5M0)
dcl-s onSevenFive ind inz(*on);
/endif
/endif
//
// /EOF stops the compiler reading the rest of the member, so it
// comes last.
/eof
