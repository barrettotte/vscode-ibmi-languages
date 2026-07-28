       //
       // Free-form control, file and definition statements in a
       // column-limited member: columns 8-80, with 6 and 7 blank.
       //
       // Member: CLDCL   Compilable: no (declarations only)
       // Source: ILE RPG Reference SC09-2508, free-form statements.
       // Retrieved: 2026-07-27
       //
       //
       // The control statement.
       ctl-opt dftactgrp(*no) actgrp('QILE');
       ctl-opt option(*srcstmt : *nodebugio) debug(*yes);
       ctl-opt datfmt(*iso) timfmt(*hms) decedit('0.');
       ctl-opt ccsid(*char : *jobrun) alwnull(*usrctl);
       ctl-opt assert(*excp);
       //
       // File statements. The device keyword comes first.
       dcl-f ORDHDR disk(*ext) usage(*input) keyed usropn;
       dcl-f ORDPRT printer(132) oflind(*inof) formlen(66);
       dcl-f ORDSCR workstn usage(*input : *output)
             sfile(SFLREC : sflRrn) indds(screenInds);
       dcl-f ORDLIKE likefile(ORDHDR) usage(*update);
       dcl-f ORDPFX usage(*input) prefix(H_ : 0) alias;
       //
       // Standalone fields and named constants.
       dcl-s counter int(10) inz(0) static;
       dcl-s text varchar(50) ccsid(*exact);
       dcl-s stamp timestamp(6);
       dcl-s basePtr pointer(*proc);
       dcl-s rates packed(5 : 3) dim(4) ctdata perrcd(1);
       dcl-s likeExt like(*ext : CUSTNAME);
       dcl-s shared int(10) static(*allthread);
       dcl-c MAXTRY 12;
       dcl-c TITLE const('Order register');
       dcl-c HIBYTE const(x'FF');
       dcl-s packedIn packed(7 : 2) extfmt(p);
       //
       // Data structures. A subfield line is not itself a DCL-
       // statement, so its keywords are reached by a top-level rule.
       dcl-ds orderDs qualified;
         dcl-subf number packed(7 : 0);
         customer char(30);
         part1 char(4) overlay(customer);
         part2 char(6) overlay(customer : *next);
         again char(4) samepos(part1);
         procName char(10) pos(1);
         renamed char(10) extfld(CUSTNAME);
       end-ds;
       dcl-ds custDs extname('CUSTMAST' : *input) qualified
             end-ds;
       dcl-ds infoDs psds qualified;
         status zoned(5 : 0) pos(11);
       end-ds;
       dcl-s loaded char(10) dim(10) fromfile(ARRFILE)
             tofile(OUTFILE);
       //
       // Enumerations, prototypes and procedures.
       dcl-enum colours int(10);
         red 1;
         blue 3 dft;
       end-enum;
       dcl-pr calcTax packed(11 : 2) extproc('CALCTAX');
         dcl-parm amount packed(11 : 2) value;
         rate packed(5 : 3) const;
       end-pr;
       dcl-pr optionsAll;
         p1 char(10) options(*nopass : *omit : *varsize);
       end-pr;
       dcl-proc calcTax export;
         dcl-pi *n packed(11 : 2);
           amount packed(11 : 2) value;
         end-pi;
         return amount * 1.05;
       end-proc;
       dcl-proc oneAtATime serialize;
       end-proc;
       //
       // A declaration may carry a comment past column 80, and may run
       // over several lines.
       dcl-s noted char(20) inz('start');                                         // past column 80
       dcl-s split char(20)      // the keywords continue
             inz('value')              // and here
             static;
