**FREE
//
// The free-form definition statements. Each declaration begins with a
// DCL- operation code and ends in a semicolon; the ones that open a
// list are closed by their END- form.
//
// Member: FREEDCL   Compilable: no (declarations only)
// Source: ILE RPG Reference SC09-2508, free-form definition statement.
// Retrieved: 2026-07-26
//
//
// Standalone fields: every data-type keyword.
dcl-s fCHAR char(10);
dcl-s fVARCHAR varchar(50);
dcl-s fVARCHAR varchar(50 : 4);
dcl-s fGRAPH graph(10);
dcl-s fVARGRAPH vargraph(10 : 2);
dcl-s fUCS2 ucs2(10);
dcl-s fVARUCS2 varucs2(10 : 4);
dcl-s fIND ind;
dcl-s fINT int(10);
dcl-s fUNS uns(5);
dcl-s fPACKED packed(11 : 2);
dcl-s fZONED zoned(7 : 0);
dcl-s fBINDEC bindec(9 : 2);
dcl-s fFLOAT float(8);
dcl-s fDATE date;
dcl-s fDATE date(*iso);
dcl-s fTIME time;
dcl-s fTIME time(*hms.);
dcl-s fTIMESTAM timestamp;
dcl-s fTIMESTAM timestamp(6);
dcl-s fPOINTER pointer;
dcl-s fPOINTER pointer(*proc);
dcl-s fOBJECT object(*java : 'java.lang.String');
//
// Taking a type from somewhere else.
dcl-s likeFld like(baseFld);
dcl-s likeAdj like(baseFld : +5);
dcl-s likeExt like(*ext : CUSTNAME);
dcl-s likeObj like(objField);
dcl-s lenFld like(baseFld) len(30);
//
// Storage, initialisation and alignment.
dcl-s counter int(10) inz(0) static;
dcl-s shared int(10) static(*allthread);
dcl-s basedFld char(20) based(basePtr);
dcl-s alignFld int(10) align(*full);
dcl-s noOptFld char(10) noopt;
dcl-s nullable char(10) nullind(nullFlag);
dcl-s exported char(10) export('EXTNAME');
dcl-s imported char(10) import('EXTNAME');
dcl-s ccsidFld char(10) ccsid(*exact);
dcl-s ccsidNo  char(10) ccsid(*noexact);
dcl-s ucsFld ucs2(10) ccsid(13488);
//
// Arrays and tables.
dcl-s rates packed(5 : 3) dim(4) ctdata perrcd(1);
dcl-s autoArr char(10) dim(*auto : 100);
dcl-s varArr char(10) dim(*var : 50);
dcl-s ctArr char(10) dim(*ctdata);
dcl-s ascArr char(10) dim(10) ascend;
dcl-s descArr char(10) dim(10) descend;
dcl-s altArr char(10) dim(10) alt(mainArr);
dcl-s loaded char(10) dim(10) fromfile(ARRFILE)
      tofile(OUTFILE);
dcl-s seqArr char(10) dim(10) altseq(*none);
//
// Formats on the field itself.
dcl-s isoDate date datfmt(*iso);
dcl-s hmsTime time timfmt(*hms);
dcl-s packedIn packed(7 : 2) extfmt(p);
dcl-s varLen char(20) varying;
dcl-s varLen4 char(20) varying(4);
dcl-s evenPk packed(6 : 0) packeven;
dcl-s sqlHost sqltype(clob : 1000);
//
// Named constants.
dcl-c MAXTRY 12;
dcl-c TITLE const('Order register');
dcl-c PI_VALUE const(3.14159);
dcl-c HIBYTE const(x'FF');
//
// Enumerations. DFT names the default enumeration constant.
dcl-enum colours int(10);
  red 1;
  green 2;
  blue 3 dft;
end-enum;
//
// Data structures. A subfield may drop DCL-SUBF when its name is
// not also an operation code.
dcl-ds orderDs qualified;
  dcl-subf number packed(7 : 0);
  customer char(30);
  amount packed(11 : 2);
end-ds;

dcl-ds templDs qualified template;
  field1 char(10);
end-ds;

dcl-ds likeDs likeds(templDs);

dcl-ds multiDs occurs(20) qualified;
  slot char(10);
end-ds;

dcl-ds basedDs based(dsPtr) qualified;
  item char(10);
end-ds;

dcl-ds dtaaraDs dtaara('MYLIB/MYDTAARA') qualified;
  status char(1);
end-ds;

dcl-ds infoDs psds qualified;
  procName char(10) pos(1);
  statusCode zoned(5 : 0) pos(11);
end-ds;
//
// Overlaying and repositioning subfields.
dcl-ds overDs qualified;
  whole char(10);
  part1 char(4) overlay(whole);
  part2 char(6) overlay(whole : *next);
  part3 char(4) overlay(whole : 5);
  again char(4) samepos(part1);
end-ds;
//
// Externally described structures and records.
dcl-ds custDs extname('CUSTMAST') qualified end-ds;
dcl-ds inpDs extname('CUSTMAST' : *input) qualified end-ds;
dcl-ds outDs extname('CUSTMAST' : *output) qualified end-ds;
dcl-ds keyDs extname('CUSTMAST' : *key) qualified end-ds;
dcl-ds nulDs extname('CUSTMAST' : *null) qualified end-ds;

dcl-ds allDs extname('CUSTMAST' : CUSTREC : *all)
      qualified end-ds;

dcl-ds recDs likerec(ORDREC : *all) end-ds;
dcl-ds aliasDs extname('CUSTMAST') alias qualified end-ds;
dcl-ds pfxDs extname('CUSTMAST') prefix(C_ : 0)
      qualified end-ds;

dcl-ds fldDs qualified;
  renamed char(10) extfld(CUSTNAME);
end-ds;

dcl-s extFlag ind ext;
dcl-s fileLike likefile(ORDHDR);

//
// Prototypes and procedure interfaces. A parameter may drop
// DCL-PARM in the same way a subfield may drop DCL-SUBF.
dcl-pr calcTax packed(11 : 2) extproc('CALCTAX');
  dcl-parm amount packed(11 : 2) value;
  rate packed(5 : 3) const;
end-pr;

dcl-pr systemCall int(10) extproc(*dclcase);
  command pointer value options(*string);
end-pr;

dcl-pr optionsAll;
  p1 char(10) options(*nopass : *omit : *varsize);
  p2 char(10) options(*exact : *string : *trim);
  p3 char(10) options(*rightadj : *nullind);
end-pr;

dcl-pr legacyPgm extpgm('LEGACY');
  parm1 char(10);
end-pr;

dcl-pr cProc int(10) extproc(*cl : 'cfunc') opdesc;
  arg1 int(10) value;
end-pr;

dcl-pr widen int(10) extproc(*cwiden : 'wfunc');
end-pr;

dcl-pr nowiden int(10) extproc(*cnowiden : 'nfunc');
end-pr;

dcl-pr javaProc object(*java : 'java.lang.String')
      extproc(*java : 'java.lang.String' : 'trim');
end-pr;

dcl-pr javaClass class(*java : 'java.util.Date');
end-pr;

dcl-pr retParm char(100) rtnparm;
end-pr;

dcl-pr overloaded overload(calcTax : systemCall);

dcl-pr procPointer pointer procptr;
end-pr;

dcl-pr protoOff reqproto(*no);
end-pr;

//
// Procedures. Only a begin line carries keywords, and these four
// are the whole set.
dcl-proc calcTax export;
  dcl-pi *n packed(11 : 2);
    amount packed(11 : 2) value;
    rate packed(5 : 3) const;
  end-pi;
  return amount * rate;
end-proc;

dcl-proc infoProc export pgminfo(*yes);
  dcl-pi *n;
  end-pi;
end-proc;

dcl-proc noInfo pgminfo(*no);
end-proc;

dcl-proc noProto reqproto(*no);
end-proc;

dcl-proc oneAtATime serialize;
end-proc;
//
// A declaration may run over several lines, and a comment may end
// one part way through.
dcl-s splitFld       // the keywords continue below
      char(20)       // the type
      inz('start')   // and its initial value
      static;
