     D*
     D* RPG IV definition specification: standalone fields, named
     D* constants, data structures and their subfields, prototypes and
     D* procedure interfaces, and every definition keyword.
     D*
     D*  7-21 name      22 external    23 data structure type
     D* 24-25 definition type          26-32 from position
     D* 33-39 to position or length    40 internal data type
     D* 41-42 decimal positions        44-80 keywords
     D*
     D* Member: RPGLED   Compilable: no (declarations only, no cycle)
     D* Source: ILE RPG Reference SC09-2508, definition specification
     D*         and its keywords.
     D* Retrieved: 2026-07-26
     D*
     D*  1         2         3         4         5         6         7         8
     D*8901234567890123456789012345678901234567890123456789012345678901234567890
      *
      * A comment line may leave position 6 blank.
     D*
     D* Standalone fields. S in 24-25, the length in 33-39, the
     D* internal data type in 40 and decimal positions in 41-42.
     DCUSTNM           S             30A
     DORDAMT           S              9P 2
     DORDQTY           S              7S 0
     DCOUNTER          S             10I 0
     DBIGNUM           S             20U 0
     DBINFLD           S              4B 0
     DRATE             S              8F
     DORDDAT           S               D
     DORDTIM           S               T
     DORDSTP           S               Z
     DFLAG             S               N
     DBASEPTR          S               *
     DDBCSFLD          S             10G
     DUNIFLD           S             10C
     DJAVAOBJ          S               O   CLASS(*JAVA:'java.lang.String')
     D*
     D* Named constants. C in 24, with the value as a keyword.
     DTITLE            C                   CONST('INVOICE REGISTER')
     DMAXTRY           C                   CONST(12)
     DPI               C                   CONST(3.14159)
     DHIBYTE           C                   CONST(X'FF')
     DSHORTC           C                   'A LITERAL WITHOUT CONST'
     D*
     D* A literal too long for one line is continued: a hyphen resumes
     D* at the first position of the continued field, a plus at the
     D* first non-blank character. A continuation line carries the
     D* form type in 6 and is blank through 43.
     DALPHA            C                   CONST('ABCDEFGHIJKLMNOP-
     D                                     QRSTUVWXYZ')
     DLONGTXT          C                   CONST('The quick brown +
     D                                     fox jumps over the lazy dog')
     DHEXCONT          C                   CONST(X'C1C2C3-
     D                                     C4C5C6')
     D*
     D* Only blank lines, empty specification lines and comment lines
     D* may come between two halves of a continued literal. The
     D* literal carries on past them.
     DSPLITTXT         C                   CONST('first half of-
     D* a comment between the two halves
     D                                     the literal')
     D*
     D* The continuation character is the last non-blank of the
     D* specification, so a comment in 81-100 sits to its right and
     D* does not end the literal.
     DNOTECONT         C                   CONST('carries on-                   and a comment
     D                                     to the next line')
     D*
     D* A specification may fill all of 7-80 with no comment area
     D* after it.
     DEXACT80          C                   CONST('xxxxxxxxxxxxxxxxxxxxxxxxxxxx')
     D*
     D* Data structures. DS in 24-25; subfields follow with blank
     D* 24-25. From and to positions place a subfield explicitly.
     DORDDS            DS
     DDSORD                    1      6A
     DDSCUST                   7     26A
     DDSAMT                   27     31P 2
     DDSQTY                           5S 0
     D*
     D* A seven digit from position is valid: the reference allows
     D* 1 to 9999999 right adjusted in 26-32.
     DBIGDS            DS       9999999
     DFARFLD             99999909999999A
     DMIDFLD               10000  10009A
     D*
     D* A length adjustment for LIKE is the second parameter of the
     D* keyword. The reference documents no signed entry in 33-39.
     DMODERNNM         S                   LIKE(CUSTNM : +5)
     D*
     D* Qualified, externally described and specially typed data
     D* structures. E in 22, S or U in 23.
     DQUALDS           DS                  QUALIFIED
     DSUBA                           10A
     DEXTDS          E DS                  EXTNAME('CUSTMAST')
     DPSDS            SDS
     DPSPGM                    1     10A
     DLDADS           UDS                  DTAARA('MYLIB/MYDTAARA')
     DMULTDS           DS                  OCCURS(12)
     DTMPLDS           DS                  TEMPLATE QUALIFIED
     DLIKEDSX          DS                  LIKEDS(QUALDS)
     DRECDS          E DS                  LIKEREC(CUSTREC : *INPUT)
     DFILEDS           DS                  LIKEFILE(CUSTMAST)
     D*
     D* Prototypes and procedure interfaces. PR and PI in 24-25,
     D* with parameters on the lines that follow.
     DCALCTAX          PR             9P 2
     DINAMT                           9P 2 CONST
     DINRATE                          5P 4 VALUE
     DINFLAG                           N   OPTIONS(*NOPASS : *OMIT)
     DCALCTAX          PI             9P 2
     DINAMT                           9P 2 CONST
     DEXTPGMPR         PR                  EXTPGM('PAYCALC')
     DEXTPRCPR         PR                  EXTPROC('c_strlen')
     DOVERPR           PR                  OVERLOAD(CALCTAX : EXTPGMPR)
     DMAINPI           PI                  REQPROTO(*NO)
     D*
     D* A name longer than fifteen characters is continued with
     D* three dots and carries on down the next line.
     DVERYLONGFIELDNAME...
     D                 S             10A
     D*
     D* A name may contain $ # and @, and in some code pages
     D* £ and §. A digit after one of those is part of the name,
     D* not a number.
     DEND#1            S             10I 0
     DEND@1            S             10I 0
     DEND$1            S             10I 0
     D#END1            S             10I 0
     D$TOTAL           S             10I 0
     D@FLAG9           S             10I 0
     D*
     D* Data type keywords, one to a line.
     DTYPEFLD          S                   CHAR(30)
     DTYPEFLD          S                   VARCHAR(30)
     DTYPEFLD          S                   VARCHAR(30 : 4)
     DTYPEFLD          S                   UCS2(10)
     DTYPEFLD          S                   VARUCS2(10)
     DTYPEFLD          S                   GRAPH(10)
     DTYPEFLD          S                   VARGRAPH(10)
     DTYPEFLD          S                   PACKED(9 : 2)
     DTYPEFLD          S                   ZONED(7 : 0)
     DTYPEFLD          S                   BINDEC(9 : 2)
     DTYPEFLD          S                   INT(10)
     DTYPEFLD          S                   UNS(20)
     DTYPEFLD          S                   FLOAT(8)
     DTYPEFLD          S                   IND
     DTYPEFLD          S                   DATE(*ISO)
     DTYPEFLD          S                   TIME(*HMS)
     DTYPEFLD          S                   TIMESTAMP(6)
     DTYPEFLD          S                   POINTER
     DTYPEFLD          S                   POINTER(*PROC)
     DTYPEFLD          S                   PROCPTR
     DTYPEFLD          S                   OBJECT(*JAVA:'java.lang.String')
     DTYPEFLD          S                   LEN(30)
     DTYPEFLD          S                   VARYING(4)
     D*
     D* Array, table and storage keywords.
     DARRFLD           S             10A   DIM(50)
     DARRFLD           S             10A   DIM(*AUTO : 100)
     DARRFLD           S             10A   DIM(*CTDATA : 5)
     DARRFLD           S             10A   DIM(*VAR : 20)
     DARRFLD           S             10A   PERRCD(12)
     DARRFLD           S             10A   CTDATA
     DARRFLD           S             10A   FROMFILE(TAXFILE)
     DARRFLD           S             10A   TOFILE(TAXOUT)
     DARRFLD           S             10A   ASCEND
     DARRFLD           S             10A   DESCEND
     DARRFLD           S             10A   ALT(TAXCDE)
     DARRFLD           S             10A   ALTSEQ(*NONE)
     DARRFLD           S             10A   SAMEPOS(DSORD)
     DARRFLD           S             10A   OVERLAY(ORDDS : 3)
     DARRFLD           S             10A   OVERLAY(ORDDS : *NEXT)
     DARRFLD           S             10A   POS(5)
     DARRFLD           S             10A   OCCURS(12)
     DARRFLD           S             10A   ALIGN(*FULL)
     DARRFLD           S             10A   PACKEVEN
     DARRFLD           S             10A   BASED(BASEPTR)
     D*
     D* Initialisation, scope and interface keywords.
     DSCOPEFLD         S             10A   INZ
     DSCOPEFLD         S             10A   INZ('PENDING')
     DSCOPEFLD         S             10A   INZ(*BLANKS)
     DSCOPEFLD         S             10A   CONST
     DSCOPEFLD         S             10A   CONST('X')
     DSCOPEFLD         S             10A   STATIC
     DSCOPEFLD         S             10A   STATIC(*ALLTHREAD)
     DSCOPEFLD         S             10A   EXPORT
     DSCOPEFLD         S             10A   EXPORT('EXTNAME')
     DSCOPEFLD         S             10A   IMPORT
     DSCOPEFLD         S             10A   IMPORT('EXTNAME')
     DSCOPEFLD         S             10A   VALUE
     DSCOPEFLD         S             10A   OPDESC
     DSCOPEFLD         S             10A   NOOPT
     DSCOPEFLD         S             10A   RTNPARM
     DSCOPEFLD         S             10A   TEMPLATE
     DSCOPEFLD         S             10A   QUALIFIED
     DSCOPEFLD         S             10A   ALIAS
     DSCOPEFLD         S             10A   NULLIND(NULLFLD)
     DSCOPEFLD         S             10A   OPTIONS(*NOPASS)
     DSCOPEFLD         S             10A   DFT(1)
     D*
     D* External description keywords.
     DEXTFLDX          S             10A   EXT
     DEXTFLDX          S             10A   EXTFLD('CUSTOMERNAME')
     DEXTFLDX          S             10A   EXTFMT(B)
     DEXTFLDX          S             10A   EXTFMT(C)
     DEXTFLDX          S             10A   EXTFMT(I)
     DEXTFLDX          S             10A   EXTFMT(L)
     DEXTFLDX          S             10A   EXTFMT(R)
     DEXTFLDX          S             10A   EXTFMT(P)
     DEXTFLDX          S             10A   EXTFMT(S)
     DEXTFLDX          S             10A   EXTFMT(U)
     DEXTFLDX          S             10A   EXTFMT(F)
     DEXTFLDX          S             10A   EXTNAME('CUSTMAST')
     DEXTFLDX          S             10A   EXTNAME('CUSTMAST':'CUSTREC':*INPUT)
     DEXTFLDX          S             10A   EXTPGM('PAYCALC')
     DEXTFLDX          S             10A   EXTPROC('c_strlen')
     DEXTFLDX          S             10A   EXTPROC(*CL : 'MYPROC')
     DEXTFLDX          S             10A   PREFIX(CUS_)
     DEXTFLDX          S             10A   PREFIX(CUS_ : 2)
     DEXTFLDX          S             10A   LIKE(CUSTNM)
     DEXTFLDX          S             10A   LIKE(CUSTNM : 10)
     DEXTFLDX          S             10A   LIKEDS(QUALDS)
     DEXTFLDX          S             10A   LIKEREC(CUSTREC)
     DEXTFLDX          S             10A   LIKEFILE(CUSTMAST)
     DEXTFLDX          S             10A   CCSID(*EXACT)
     DEXTFLDX          S             10A   DATFMT(*ISO)
     DEXTFLDX          S             10A   TIMFMT(*HMS)
     DEXTFLDX          S             10A   CLASS(*JAVA:'C')
     DEXTFLDX          S             10A   PSDS
     DEXTFLDX          S             10A   DTAARA('MYDTAARA')
     D*
     D* A keyword list may be continued onto the following lines.
     DLONGKW           S             10A   INZ('A VALUE')
     D                                     STATIC
     D                                     EXPORT
     D*
     D* A page and line number in 1-5 does not disturb the columns.
03010DSEQFLD           S             10A
     D*
     D* A name may begin in any position of 7-21, and a name too
     D* long for the field is continued with three dots.
     D* Positions 81-100 are a comment area.
     D STREAM_NEW_LINE...
     D                 S              1A
     DNOTEFLD          S             10A                                        definition comment
