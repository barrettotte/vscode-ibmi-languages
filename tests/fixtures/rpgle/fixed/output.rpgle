     O*
     O* RPG IV output specification: record identification and control
     O* entries for program described and externally described files,
     O* and the field description entries that follow each of them.
     O*
     O*  7-16 file or record name   16-18 AND/OR    17 type H/D/T/E
     O* 18-20 ADD or DEL      18 fetch overflow F or release R
     O* 21-29 three output indicators     30-39 EXCEPT name
     O* 40-42 space before   43-45 space after
     O* 46-48 skip before    49-51 skip after
     O*
     O* A field description line leaves 7-20 blank and reads
     O* 30-43 field name  44 edit code  45 blank after
     O* 47-51 end position   52 data format   53-80 constant or edit word
     O*
     O* Member: RPGLEO   Compilable: no (declarations only, no cycle)
     O* Source: ILE RPG Reference SC09-2508, output specifications.
     O* Retrieved: 2026-07-26
     O*
     O*  1         2         3         4         5         6         7         8
     O*8901234567890123456789012345678901234567890123456789012345678901234567890
      *
      * A comment line may leave position 6 blank.
     O*
     O* The four record types. Position 17 must have an entry on every
     O* record identification line.
     OPRINT     H    1P                     1
     OPRINT     D    01                     1
     OPRINT     T    LR                     2
     OPRINT     E            HEADING        1
     O*
     O* Position 18 holds F to fetch the overflow routine or R to
     O* release a workstation after output. ADD and DEL occupy 18-20
     O* instead, so they cannot appear on the same line as F or R.
     OPRINT     DF   01                     1
     OSCREEN    DR   50
     OORDFILE   DADD 20
     OORDFILE   DDEL 21
     O*
     O* AND and OR relate conditioning indicators across lines in
     O* positions 16-18. An N in the first position negates.
     OPRINT     D    01 02N03               1
     O         OR    04N05
     O         AND   06
     O*
     O* The indicators accept the same names as elsewhere: numbered,
     O* halt, control level, matching record, last record, return,
     O* first page, external, command key and overflow.
     OPRINT     D    H1 L1 MR
     OPRINT     D    LR RT 1P
     OPRINT     D    U1 OA OV
     OPRINT     D    KA KN KP
     OPRINT     D    KY OG 99
     O*
     O* EXCEPT names an exception record for the EXCEPT operation.
     O* Space and skip take three positions each.
     OPRINT     E            DETAIL      1  2
     OPRINT     E            TOTALS           12  6
     OPRINT     H                        3  1  1 60
     O*
     O* Field description lines. Positions 7-20 are reserved and
     O* blank, which is what tells them from the lines above.
     OPRINT     D    01                     1
     O                       CUSTNM              30
     O                       ORDNBR         B    40
     O               02      ORDDAT              52
     O               03N04   STATUS              60
     O*
     O* Every edit code. 1-4 are the plain combinations, A-D add CR,
     O* J-M a trailing minus and N-Q a leading minus; 5-9 are the
     O* user-defined codes; X forces a hexadecimal F sign, Y edits a
     O* date and Z suppresses leading zeros.
     O                       ORDAMT        1     72
     O                       ORDAMT        2     72
     O                       ORDAMT        3     72
     O                       ORDAMT        4     72
     O                       ORDAMT        A     72
     O                       ORDAMT        B     72
     O                       ORDAMT        C     72
     O                       ORDAMT        D     72
     O                       ORDAMT        J     72
     O                       ORDAMT        K     72
     O                       ORDAMT        L     72
     O                       ORDAMT        M     72
     O                       ORDAMT        N     72
     O                       ORDAMT        O     72
     O                       ORDAMT        P     72
     O                       ORDAMT        Q     72
     O                       ORDAMT        5     72
     O                       ORDAMT        6     72
     O                       ORDAMT        7     72
     O                       ORDAMT        8     72
     O                       ORDAMT        9     72
     O                       ORDAMT        X     72
     O                       ORDAMT        Y     72
     O                       ORDAMT        Z     72
     O*
     O* Every data format in position 52. Blank writes a numeric
     O* field as zoned decimal and a character field as stored.
     O                       CHRFLD              80A
     O                       UNIFLD              80C
     O                       DBCSFLD             80G
     O                       BINFLD              80B
     O                       FLTFLD              80F
     O                       INTFLD              80I
     O                       LFTSGN              80L
     O                       INDFLD              80N
     O                       PCKFLD              80P
     O                       RGTSGN              80R
     O                       ZONFLD              80S
     O                       UNSFLD              80U
     O                       DATFLD              80D
     O                       TIMFLD              80T
     O                       STPFLD              80Z
     O*
     O* Positions 53-80 hold a constant, an edit word, a data
     O* attribute or a record format name.
     O                                           30 'CUSTOMER ORDER REPORT'
     O                                           45 'PAGE'
     O                       ORDAMT              62 '$ ,  0. &CR'
     O                       ORDDAT              72 '  /  /  '
     O                       VARFLD              80 *VAR
     O                       ORDDS               80 ORDREC
     O*
     O* *PLACE repeats the preceding fields, PAGE and PAGE1-PAGE7
     O* number pages, and the user date reserved words supply the
     O* job date. *IN reaches the indicator array.
     O                       *PLACE              60
     O                       PAGE          Z     72
     O                       PAGE1         Z     72
     O                       PAGE2         Z     72
     O                       PAGE3         Z     72
     O                       PAGE4         Z     72
     O                       PAGE5         Z     72
     O                       PAGE6         Z     72
     O                       PAGE7         Z     72
     O                       UDATE         Y     80
     O                       UMONTH        Y     80
     O                       UDAY          Y     80
     O                       UYEAR         Y     80
     O                       *DATE         Y     80
     O                       *MONTH        Y     80
     O                       *DAY          Y     80
     O                       *YEAR         Y     80
     O                       *IN                 40
     O                       *IN01               42
     O                       *IN(01)             44
     O*
     O* An externally described file names a record format in 7-16.
     O* Position 18 may release the device, and 18-20 may add.
     OCUSTREC   D    30
     O                       CUSTNM
     O                       CUSTBL         B
     OORDREC    DADD 31
     O                       ORDNBR
     ODSPREC    DR   32
     O*
     O* A page and line number in 1-5 does not disturb the columns.
     O* Positions 81-100 are a comment area.
06010OPRINT     D    01
06020O                       CUSTNM              30
06030O                       SEQNOTE             60                             numbered + comment
     OPRINT     D    01                                                         output spec comment
     O                       ORDNBR              40                             field line comment
