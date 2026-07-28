     F*
     F* RPG IV file description specification.
     F*
     F* 7-16 file name   17 type      18 designation  19 end of file
     F* 20 addition      21 sequence  22 format       23-27 record length
     F* 28 limits        29-33 key    34 address type 35 organization
     F* 36-42 device     43 reserved  44-80 keywords
     F*
     F* Member: RPGLEF   Compilable: no (declarations only, no cycle)
     F* Source: ILE RPG Reference SC09-2508, file description
     F*         specification and its keywords.
     F* Retrieved: 2026-07-26
     F*
     F*  1         2         3         4         5         6         7         8
     F*8901234567890123456789012345678901234567890123456789012345678901234567890
     F*
     F* Externally described files. E in position 22, K in 34 for a
     F* keyed file.
     FCUSTMAST  IF   E           K DISK
     FORDHDR    UF A E           K DISK
     FCUSTDSP   CF   E             WORKSTN
     FINVRPT    O    E             PRINTER
     F*
     F* Program described files. F in position 22, with the record
     F* length in 23-27 and the key length in 29-33.
     FORDDTL    IPE AF  256     8AIDISK
     FPARTMAST  IF   F  200L   10PIDISK
     FQSYSPRT   O    F  132        PRINTER
     FTAPEOUT   O    F   80        SEQ
     FSPCLIN    IF   F   80        SPECIAL PLIST(SPCPL)
     F*
     F* Every record address type: A character, P packed, G graphic,
     F* K key, D date, T time, Z timestamp, F float.
     FIDXAFILE  IF   F  100    10AIDISK
     FIDXPFILE  IF   F  100    10PIDISK
     FIDXGFILE  IF   F  100    10GIDISK
     FIDXDFILE  IF   F  100    10DIDISK
     FIDXTFILE  IF   F  100    10TIDISK
     FIDXZFILE  IF   F  100    10ZIDISK
     FIDXFFILE  IF   F  100    10FIDISK
     FKEYEDEXT  IF   E           K DISK
     F*
     F* Record address and array files, and a table file.
     FPARTRAF   IR   F   10      A DISK
     FTAXTBL    IT   F   10        DISK
     FORDSEC    IS   E           K DISK
     F*
     F* Keywords in positions 44-80.
     FCUSTMAST  IF   E           K DISK    USROPN
     FORDHDR    UF   E           K DISK    COMMIT
     FCUSTDSP   CF   E             WORKSTN INFDS(DSPFDS)
     FCUSTDSP   CF   E             WORKSTN SFILE(SFLREC : SFLRRN)
     FORDDTL    IF   E           K DISK    RENAME(ORDDTLR : ORDREC)
     FORDDTL    IF   E           K DISK    IGNORE(ORDTRLR)
     FORDDTL    IF   E           K DISK    PREFIX(ORD_)
     FRPTPRT    O    F  132        PRINTER PRTCTL(PRTDS)
     FORDHDR    UF   E             DISK    RECNO(RRN)
     FCUSTMAST  IF   E           K DISK    EXTFILE('MYLIB/CUSTMAST')
     FCUSTMAST  IF   E           K DISK    EXTMBR('MBR1') STATIC
     FLIKEFIL                              LIKEFILE(CUSTMAST)
     FQSYSPRT   O    F  132        PRINTER OFLIND(*INOF)
     FORDHDR    UF   E           K DISK    INFSR(*PSSR) INFDS(ORDFDS)
     FCUSTDSP   CF   E             WORKSTN MAXDEV(*FILE) DEVID(DEVICE)
     FCUSTDSP   CF   E             WORKSTN INDDS(DSPIND) SLN(STRLIN)
     FDATAQ     IF   F  100        SPECIAL DATFMT(*ISO) TIMFMT(*HMS)
     F*
     F* Keywords taking no parameter.
     FCUSTMAST  IF   E           K DISK    ALIAS
     FCUSTMAST  IF   E           K DISK    QUALIFIED
     FTMPLFILE  IF   E           K DISK    TEMPLATE
     F*
     F* Externally described file control.
     FCUSTMAST  IF   E           K DISK    EXTDESC('MYLIB/CUSTMAST')
     FCUSTMAST  IF   E           K DISK    INCLUDE(CUSTREC)
     FCUSTMAST  IF   E           K DISK    EXTIND(*INU1)
     FCUSTMAST  IF   E           K DISK    HANDLER('MYLIB/MYHDLR' : COMMAREA)
     F*
     F* Program described file control.
     FORDDTL    IF   F  256     8AIDISK    KEYLOC(1)
     FORDDTL    IF   F  256        DISK    BLOCK(*YES)
     FPARTRAF   IR   F   10      A DISK    RAFDATA(PARTMAST)
     FDATAQ     IF   F  100        SPECIAL DATA(*NOCVT) CHARCOUNT(*STDCHARSIZE)
     FSPCLIN    IF   F   80        SPECIAL PGMNAME('SPCPGM') PASS(*NOIND)
     F*
     F* Printer and workstation control.
     FQSYSPRT   O    F  132        PRINTER FORMLEN(66) FORMOFL(60)
     FCUSTDSP   CF   E             WORKSTN SAVEDS(SAVEAREA) SAVEIND(99)
     F*
     F* A keyword list may be continued onto the following lines.
     FCUSTDSP   CF   E             WORKSTN SFILE(SFLREC : SFLRRN)
     F                                     INFDS(DSPFDS)
     F                                     INDDS(DSPIND)
     F*
     F* A page and line number in 1-5 does not disturb the columns.
02010FSEQFILE   IF   E           K DISK
02020FSEQNOTE   OF   F  132        PRINTER                                      numbered + comment
     F*
     F* Positions 81-100 are a comment area. A keyword list may run to
     F* column 80, so a comment there still begins at 81.
     FNOTEFILE  IF   E           K DISK                                         file spec comment
     FCUSTDSP   CF   E             WORKSTN SFILE(SFLREC : SFLRRN) INFDS(DSPFDS) after a keyword
