       //
       // The free-form file definition statement in a column-limited
       // member: the statements are the ones the fully free-form fixture
       // carries, moved into columns 8-80 so the two can be compared. They
       // run through a separate copy of the same rules.
       //
       // Member: CLFILE   Compilable: no (declarations only)
       // Source: ILE RPG Reference SC09-2508, free-form file definition
       //         statement, and the file-specification keywords.
       // Retrieved: 2026-07-28
       //
       //
       // A file defaults to an externally described DISK file. The
       // device keyword has to be the first keyword when it is given.
       dcl-f ORDHDR;
       dcl-f ORDDTL disk(*ext) usage(*input) keyed;
       dcl-f ORDDEL disk(*ext) usage(*delete);
       dcl-f ORDUPD disk(*ext) usage(*update : *output);
       dcl-f ORDSEQ seq(*ext) usage(*output);
       dcl-f ORDPRT printer(132) oflind(*inof);
       dcl-f ORDSCR workstn usage(*input : *output);
       dcl-f ORDSPC special pgmname('SPECPGM') plist(SPCPLIST);
       //
       // LIKEFILE takes its properties from a parent file, and like a
       // device keyword it has to come first.
       dcl-f ORDLIKE likefile(ORDHDR) usage(*update);
       dcl-f ORDTMPL template;
       dcl-f ORDQUAL qualified usage(*input);
       //
       // Opening and closing. USROPN leaves the file shut until OPEN.
       dcl-f ORDWORK usage(*input) usropn static;
       dcl-f ORDCMT usage(*update) commit(ordCommit);
       dcl-f ORDEXT usage(*input) extind(*inu1);
       dcl-f ORDEXT8 usage(*input) extind(*inu8);
       //
       // Naming the object at run time. EXTDESC is required when the
       // file name is longer than ten characters.
       dcl-f ORDLONGNAMEFILE extdesc('ORDERHEADER')
             extfile(*extdesc) usage(*input);
       dcl-f ORDMBR usage(*input) extfile('ORDARCH') extmbr('JAN');
       dcl-f ORDRAF usage(*input) rafdata('ORDADDR');
       //
       // Record formats and field names.
       dcl-f ORDREN usage(*input) rename(ORDREC : ORDERREC);
       dcl-f ORDPFX usage(*input) prefix(H_ : 0) alias;
       dcl-f ORDINC usage(*input) include(ORDREC : ORDDTL);
       dcl-f ORDIGN usage(*input) ignore(ORDOLD);
       //
       // Keys and relative record numbers.
       dcl-f ORDKEY usage(*input) keyed(20) keyloc(5);
       dcl-f ORDRRN usage(*update) recno(rrnField);
       //
       // Feedback, error handling and the blocking of records.
       dcl-f ORDFB usage(*input) infds(fileInfo) infsr(*pssr);
       dcl-f ORDBLK usage(*input) block(*yes) data(*nocvt);
       dcl-f ORDNBLK usage(*input) block(*no) data(*cvt);
       dcl-f ORDHDL usage(*input) handler('MYHANDLER' : commArea);
       //
       // Workstation files: subfiles, indicators and the device name.
       dcl-f ORDSFL workstn usage(*input : *output)
             sfile(SFLREC : sflRrn) indds(screenInds);
       dcl-f ORDONLY workstn maxdev(*only);
       dcl-f ORDMDEV workstn maxdev(*file) devid(devName)
             saveds(saveArea) saveind(20) pass(*noind) sln(4);
       //
       // Printer files: page geometry and the print control structure.
       dcl-f ORDPAGE printer(132) formlen(66) formofl(60)
             prtctl(printCtl : *compat) oflind(*in01);
       //
       // Formats and character counting on the file itself.
       dcl-f ORDFMT usage(*input) datfmt(*iso) timfmt(*hms)
             charcount(*stdcharsize);
       dcl-f ORDNAT usage(*input) charcount(*natural);
       //
       // A statement may run over several lines, and a comment may end
       // one part way through.
       dcl-f ORDSPLIT      // the keywords continue below
             disk(*ext)    // the device comes first
             usage(*input)
             keyed;
