**free

// Testing fully free RPGLE

// Test operators, literals, and constants
x = 2    1 + 2    1 - 2    1 * 2     1 / 2     1 ** 2
x += 1   x -= 1   x *= 1   x /= 1    x **= 2
x > 1    x < 1    x = 1    x <> 1    x <= 1    x >= 1
x=1 and y=1   x=1 or y=1   not x
. , :   2.5    x'AF'    'a string'    *ON    *OFF    *INLR=*ON;

/FREE
// Test control specifications
ctl-opt;

ctl-opt main(main);  //inline comment
/END-FREE

     H* Test control spec
     H DATFMT(*YMD) DATEDIT(*YMD) DEBUG(*YES) OPTION(*NODEBUGIO)                h spec comment

      ctl-opt option(*srcstmt:*noDebugIO:*nounref) dftActGrp(*no);

      ctl-opt datfmt(*iso) timfmt(*iso)
        alwnull(*usrctl);

      ctl-opt option(*srcstmt)ccsid(*char:*jobrun);

     H OPTION(*SRCSTMT :
     H        *NODEBUGIO)
     H ACTGRP(*NEW)
      CTL-OPT ALWNULL(*USRCTL)
           CCSID(*UCS2
                      :1200)
           CCSID(*CHAR:*JOBRUN);
     H DATFMT(*YMD) TIMFMT(*USA)


/FREE
// Test file specifications
DCL-F file1a;
DCL-F file1b DISK(*EXT) USAGE(*INPUT);
DCL-F file2 PRINTER;
/END-FREE

     F* Test file spec (externally described)
     FANOTHRFILEUPEADE     L     G SPECIAL INDDS(SOMEDS)                        f spec comment

      DCL-F file3 SEQ;  //inline comment
      DCL-F file4 WORKSTN;
      DCL-F file5 USAGE(*UPDATE) KEYED;

     F* Test file spec (externally described)
     FANOTHRFILEUPEADE     L     G SPECIAL INDDS(SOMEDS)                        f spec comment

      dcl-f CLS019B workstn indDs(dspf) usropn;



      // Test named constant definition
      DCL-C CON_1 CONST(1);    //inline comment
      DCL-C CON_2 2;

      DCL-C array_total_size
           %SIZE(array:*ALL);


      // Test standalone field definition
      DCL-S limit PACKED(5) INZ(100);     //inline comment

     D* Test definition spec
     DMYFIELD        ESS *OPCODE-12345 *12 NOOPT                                d spec comment

      DCL-S num INZ(0) LIKE(limit);


      // Test data structure definition
/FREE
dcl-ds resp      likeds(geoResponse);

DCL-DS address;
   num int(5);
   street VARCHAR(25);
   city VARCHAR(25);
   province VARCHAR(25);
   postcode VARCHAR(6);
END-DS address;

      DCL-DS person QUALIFIED;
         name VARCHAR(25);
         DCL-DS address;
            num int(5);
            street VARCHAR(25);
            city VARCHAR(25);
            province VARCHAR(25);
            postcode VARCHAR(6);
         END-DS address;
         age int(5);
      END-DS person;

      DCL-DS family QUALIFIED;
         num int(5);
         DCL-DS person DIM(10);
            name VARCHAR(25);
            age int(5);
            numPets int(5);
            DCL-DS pets DIM(5);
               name VARCHAR(25);
               type VARCHAR(25);
            END-DS pets;
         END-DS person;
      END-DS;


// Test prototypes and procedure interfaces
   DCL-PI *N EXTPGM;
      name CHAR(10) CONST;
   END-PI;

   DCL-PI *N;
      id INT(10) VALUE;
      quantity INT(10) CONST;
      price PACKED(7:2) CONST;
   END-PI;

   DCL-PI *N CHAR(10) END-PI; //inline comment

   DCL-PI *N;
      DCL-PARM select CHAR(10);
      name CHAR(10);
      DCL-PARM address CHAR(25);
   END-PI;

   DCL-PR myPgm EXTPGM;     //inline comment
      name CHAR(10) CONST;
   END-PR;

   DCL-PR addNewOrder;
      id INT(10) CONST;
      quantity INT(10) CONST;
      price PACKED(7:2) CONST;
   END-PR;

   DCL-PR getCurrentUser CHAR(10) END-PR;

   DCL-PR myProc;
      DCL-PARM select CHAR(10);
      name CHAR(10);
      DCL-PARM address CHAR(25);  //inline comment
   END-PR;


     // Testing general
         read  file;              // Get next record
         dow not %eof(file);      // Keep looping while we have
                                  // a record
             if %error;
                 dsply 'The read failed';
                 leave;
             else;
                 chain(n) name database data;
                 time = hours * num_employees
                          + overtime_saved;
                 pos = %scan (',': name);
                 name = %xlate(upper:lower:name);
                 exsr handle_record;
                 read file;
             endif;
         enddo;

      begsr handle_record;
         eval(h) time = time + total_hours_array (empno);
         temp_hours = total_hours - excess_hours;
         record_transaction();
      endsr;


      DCL-S name
       /IF DEFINED(TRUE)
         CHAR(10);
       /ELSEIF DEFINED(TRUE OR FALSE)
         VARCHAR(10);
       /ELSE
         CHAR(12);
       /ENDIF

      /COPY /something
      /INCLUDE /something/else


/copy mpkcorsrc,pr_f3gtrtd // comment
dcl-s RLBERRCNT packed(3); // issue #19
dcl-s i like(RLBERRCNT);

/charcount STDCHARSIZE

for x = 1 to 10 by 5;
endfor;

for y in %list( 'a' : 'b' : 'c');
endfor;

if (a < b) and (c > d);
endif;

// Fall 2024 RPGLE enhancements:

// New BIF's
max = %hival( i );
min = %loval( i );

// New CTL-OPT keyword DATEYY
ctl-opt dateyy(*warn);


// Issue #76
// - handle hyphenated opcodes and fields containing opcode words

dcl-s end1     int(10);
dcl-s endif_b  int(10);
dcl-s c_endif  int(10);
dcl-s endx     int(10);
dcl-s end#1    int(10);
dcl-s end@1    int(10);
dcl-s end$1    int(10);
dcl-s end£1    int(10);
dcl-s end§1    int(10);
dcl-s #end1    int(10);
dcl-s @end1    int(10);
dcl-s $end1    int(10);
dcl-s £end1    int(10);
dcl-s §end1    int(10);

monitor;       // Valid
on-error;      // Valid
endmon;        // Valid
end-mon;       // Invalid
end-monitor;   // Invalid
abc-monitor;   // Invalid

end1 = 1;
endif_b = 2;
c_endif = 3;
endx = 4;
end#1 = 5;
end@1 = 6;
end$1 = 7;
end£1 = 8;
end§1 = 9;
#end1 = 5;
@end1 = 6;
$end1 = 7;
£end1 = 8;
§end1 = 9;

endif;         // Valid
endif-abc;     // Invalid
endif-test;    // Invalid

acq;           // Valid
acq-test;      // Invalid
acquire;       // Invalid

Chain(N) CUSCOD CUSTOMERS;
Chain(EN) CUSCOD CUSTOMERS;


// Valid free format opcodes
ACQ;
ALLOC;
BEGSR;
CALLP;
CHAIN;
CLEAR;
CLOSE;
COMMIT;
DATA-GEN;
DATA-INTO;
DEALLOC;
DELETE;
DOU;
DOW;
DSPLY;
DUMP;
ELSE;
ELSEIF;
ENDDO;
ENDFOR;
ENDIF;
ENDMON;
ENDSL;
ENDSR;
EVAL;
EVALR;
EVAL-CORR;
EXCEPT;
EXFMT;
EXSR;
FEOD;
FOR;
FOR-EACH;
FORCE;
IF;
IN;
ITER;
LEAVE;
LEAVESR;
MONITOR;
NEXT;
ON-ERROR;
ON-EXCP;
ON-EXIT;
OPEN;
OTHER;
OUT;
POST;
READ;
READC;
READE;
READP;
READPE;
REL;
RESET;
RETURN;
ROLBK;
SELECT;
SETGT;
SETLL;
SHTDN;
SND-MSG;
SORTA;
TEST;
UNLOCK;
UPDATE;
WHEN;
WHEN-IN;
WHEN-IS;
WRITE;
XML-INTO;
XML-SAX;

// Opcodes not valid in free format
ADD;
ADDDUR;
ACQUIRE;
ANDEQ;
ANDGE;
ANDGT;
ANDLE;
ANDLT;
ANDNE;
BITOFF;
BITON;
CAB;
CABEQ;
CABGE;
CABGT;
CABLE;
CABLT;
CABNE;
CALL;
CALLB;
CAS;
CASEQ;
CASGE;
CASGT;
CASLE;
CASLT;
CASNE;
CAT;
CHECK;
CHECKR;
COMP;
DEFINE;
DIV;
DO;
DOUEQ;
DOUGE;
DOUGT;
DOULE;
DOULT;
DOUNE;
DOWEQ;
DOWGE;
DOWGT;
DOWLE;
DOWLT;
DOWNE;
END;
ENDCS;
EXTRCT;
GOTO;
IFEQ;
IFGE;
IFGT;
IFLE;
IFLT;
IFNE;
KFLD;
KLIST;
LOOKUP;
MHHZO;
MHLZO;
MLHZO;
MLLZO;
MOVE;
MOVEA;
MOVEL;
MULT;
MVR;
OCCUR;
OREQ;
ORGE;
ORGT;
ORLE;
ORLT;
ORNE;
PARM;
PLIST;
REALLOC;
SCAN;
SETOFF;
SETON;
SQRT;
SUB;
SUBDUR;
SUBST;
TAG;
TESTB;
TESTN;
TESTZ;
TIME;
WHGE;
WHGT;
WHLE;
WHLT;
WHNE;
XFOOT;
XLATE;
Z-ADD;
Z-SUB;

// TODO: what about the following?

sqlstate;
sqlcode;
TIME;

%biton();
%bitoff();


**CTDATA
Line 1 of program data
Line 2 of program data