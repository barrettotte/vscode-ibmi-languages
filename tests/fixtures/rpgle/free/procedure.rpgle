       //
       // The free-form procedure in a column-limited member: the statements
       // are the ones the fully free-form fixture carries, moved into
       // columns 8-80 so the two can be compared. They run through a
       // separate copy of the same rules.
       //
       // Member: CLPROC   Compilable: no (procedures only, no main)
       // Source: ILE RPG Reference SC09-2508, free-form procedure statement,
       //         procedure interface and prototype.
       // Retrieved: 2026-07-28
       //
       //
       // A prototype names a procedure the module calls. RETURN gives the
       // type of the value, and the parameters follow it.
       dcl-pr calcTax packed(11 : 2) extproc('CALCTAX');
         amount packed(11 : 2) const;
         rate packed(5 : 3) value;
       end-pr;
       //
       // A prototype may be written on one line when it takes no parameters,
       // and END-PR is then left off.
       dcl-pr startUp extproc('STARTUP') end-pr;
       dcl-pr getCount int(10) extproc('GETCOUNT') end-pr;
       //
       // The parameter keywords. CONST passes a read-only reference, VALUE a
       // copy, and OPTIONS carries a set of choices.
       dcl-pr writeLine extproc('WRITELINE');
         text varchar(100) const options(*varsize : *trim);
         count int(10) value options(*nopass);
         errorDs likeds(error_t) options(*omit : *nullind);
         rows int(10) dim(20) options(*varsize);
         handle pointer options(*string);
         result char(50) options(*noPass);
       end-pr;
       //
       // The smallest subprocedure: a procedure statement, an interface and
       // the end of the procedure. Nothing is exported.
       dcl-proc localSub;
         dcl-pi *n;
         end-pi;
         return;
       end-proc;
       //
       // Every procedure keyword. EXPORT makes the procedure callable from
       // outside the module, SERIALIZE serialises the calls to it, and
       // PGMINFO controls the generated program interface.
       dcl-proc calcTax export;
         dcl-pi *n packed(11 : 2);
           amount packed(11 : 2) const;
           rate packed(5 : 3) value;
         end-pi;
         dcl-s tax packed(11 : 2);
         tax = amount * rate;
         return tax;
       end-proc calcTax;
       dcl-proc orderLoad export serialize;
         dcl-pi *n ind;
           number packed(7 : 0) const;
         end-pi;
         return *on;
       end-proc;
       dcl-proc reportRun export pgminfo(*pcml : *module);
         dcl-pi *n;
         end-pi;
       end-proc;
       dcl-proc noProto reqproto(*no);
         dcl-pi *n;
         end-pi;
       end-proc;
       //
       // The procedure interface may name itself rather than use *N, and it
       // may carry the return keywords of its own.
       dcl-proc buildName;
         dcl-pi buildName varchar(60) rtnparm;
           first varchar(30) const;
           last varchar(30) const;
         end-pi;
         return %trim(first) + ' ' + %trim(last);
       end-proc;
       //
       // A main procedure, named by the MAIN keyword of the control
       // statement, takes the entry parameters of the program.
       dcl-proc balanceReport;
         dcl-pi *n;
           company char(3) const;
           asOf date(*iso) const;
         end-pi;
         dcl-s total packed(11 : 2) inz(0);
         total = calcTax(1000 : 0.075);
         return;
       end-proc balanceReport;
       //
       // A statement may be spread over several lines, and a comment may end
       // a line part way through one.
       dcl-proc splitProc     // the keywords continue below
           export
           serialize;
         dcl-pi *n int(10);
           first int(10)      // one parameter to a line
             const;
         end-pi;
         return first;
       end-proc;
