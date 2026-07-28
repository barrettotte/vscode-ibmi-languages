**FREE
//
// The free-form control statement. CTL-OPT carries the keywords that
// the fixed-format control specification carried in its own columns.
// A keyword with a documented closed set of values appears once per
// value.
//
// Member: FREECTL   Compilable: no (declarations only)
// Source: ILE RPG Reference SC09-2508, free-form control statement.
// Retrieved: 2026-07-26
//
//
// Activation, storage and binding.
ctl-opt actgrp(*stgmdl);
ctl-opt actgrp(*new);
ctl-opt actgrp(*caller);
ctl-opt actgrp('QILE');
//
ctl-opt alloc(*stgmdl);
ctl-opt alloc(*teraspace);
ctl-opt alloc(*snglvl);
//
ctl-opt stgmdl(*inherit);
ctl-opt stgmdl(*snglvl);
ctl-opt stgmdl(*teraspace);
//
ctl-opt dftactgrp(*yes);
ctl-opt dftactgrp(*no);
//
ctl-opt thread(*concurrent);
ctl-opt thread(*serialize);
ctl-opt bnddir('MYBNDDIR' : 'OTHERDIR');
//
// Program identity and authority.
ctl-opt aut(*librcrtaut);
ctl-opt aut(*all);
ctl-opt aut(*change);
ctl-opt aut(*use);
ctl-opt aut(*exclude);
ctl-opt aut('AUTLIST');
//
ctl-opt usrprf(*user);
ctl-opt usrprf(*owner);
//
ctl-opt text(*blank);
ctl-opt text(*srcmbrtxt);
ctl-opt text('Order register');
ctl-opt dftname(ORDREG) copyright('(C) Example Ltd 2026');
//
// The main entry point. NOMAIN takes no parameter, and a module
// carries one of these two rather than both.
ctl-opt main(startUp);
ctl-opt nomain;
//
// Dates, times and the decimal edit.
ctl-opt dateyy(*allow);
ctl-opt dateyy(*warn);
ctl-opt dateyy(*noallow);
ctl-opt datfmt(*iso) timfmt(*hms) datedit(*ymd/);
//
ctl-opt decedit(*jobrun);
ctl-opt decedit('0,');
ctl-opt cursym('$');
//
// Numeric behaviour.
ctl-opt decprec(30);
ctl-opt decprec(31);
ctl-opt decprec(63);
//
ctl-opt expropts(*maxdigits);
ctl-opt expropts(*resdecpos);
ctl-opt expropts(*alwblanknum);
ctl-opt expropts(*usedecedit);
ctl-opt intprec(20) truncnbr(*no) fltdiv(*yes);
ctl-opt fixnbr(*zoned : *inputpacked);
ctl-opt fixnbr(*nozoned : *noinputpacked);
ctl-opt extbinint(*yes);
//
// CCSID takes a data type and then the value for it, except for
// *EXACT which stands alone.
ctl-opt ccsid(*exact);
ctl-opt ccsid(*char : *jobrun);
ctl-opt ccsid(*char : *jobrunmix);
ctl-opt ccsid(*char : *utf8);
ctl-opt ccsid(*char : *hex);
ctl-opt ccsid(*char : 1208);
ctl-opt ccsid(*graph : *jobrun);
ctl-opt ccsid(*graph : *src);
ctl-opt ccsid(*graph : *hex);
ctl-opt ccsid(*graph : *ignore);
ctl-opt ccsid(*graph : 835);
ctl-opt ccsid(*ucs2 : *utf16);
ctl-opt ccsid(*ucs2 : 13488);
//
// Character data and sequences.
ctl-opt ccsidcvt(*excp);
ctl-opt ccsidcvt(*list);
//
ctl-opt charcount(*natural);
ctl-opt charcount(*stdcharsize);
ctl-opt charcounttypes(*utf8 *utf16 *jobrun
        *mixedebcdic *mixedascii);
//
ctl-opt srtseq(*hex);
ctl-opt srtseq(*job);
ctl-opt srtseq(*langidunq);
ctl-opt srtseq(*langidshr);
//
ctl-opt langid(*job);
ctl-opt langid('ENU');
//
ctl-opt alwnull(*no);
ctl-opt alwnull(*inputonly);
ctl-opt alwnull(*usrctl);
ctl-opt altseq(*src) ftrans(*src);
ctl-opt cvtopt(*datetime *graphic *varchar *vargraphic);
ctl-opt cvtopt(*nodatetime *nographic *novarchar
        *novargraphic);
//
// Compilation, listing and diagnostics.
ctl-opt optimize(*none);
ctl-opt optimize(*basic);
ctl-opt optimize(*full);
//
ctl-opt enbpfrcol(*pep);
ctl-opt enbpfrcol(*entryexit);
ctl-opt enbpfrcol(*full);
//
ctl-opt prfdta(*nocol);
ctl-opt prfdta(*col);
//
ctl-opt pgminfo(*no);
ctl-opt pgminfo(*pcml);
ctl-opt pgminfo(*dclcase);
ctl-opt pgminfo(*pcml : *module);
ctl-opt pgminfo(*pcml : *module : *v8);
//
ctl-opt indent(*none);
ctl-opt indent('| ');
ctl-opt option(*xref *gen *seclvl *showcpy *expdds *ext
        *srcstmt *debugio);
ctl-opt option(*noxref *nogen *noseclvl *noshowcpy
        *noexpdds *noext *nosrcstmt *nodebugio);
ctl-opt genlvl(10) copynest(20) debug(*yes);
//
ctl-opt validate(*nodatetime);
//
// Files, prototypes and null handling.
ctl-opt openopt(*cvtdata);
ctl-opt openopt(*nocvtdata);
ctl-opt openopt(*inzofl);
ctl-opt openopt(*noinzofl);
ctl-opt formsalign(*yes) dclopt(*nochgdslen);
ctl-opt reqprexp(*require);
//
// ASSERT sets how assertion statements are processed: *EXCP
// fails at once, *WARN records the failure, *NONE disables
// them and *CALL names a procedure to call for every one.
ctl-opt assert(*excp);
ctl-opt assert(*warn);
ctl-opt assert(*none);
ctl-opt assert(*call : assertHandler);
//
// A statement may be spread over several lines, and a comment may
// end a line part way through one.
ctl-opt              // the keywords continue below
    option(*nodebugio)
    text('spread over four lines');
