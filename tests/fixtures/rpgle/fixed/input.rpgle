     I*
     I* RPG IV input specification: record identification for program
     I* described and externally described files, and field descriptions
     I* for both.
     I*
     I*  7-16 file or record name    16-18 AND/OR    17-18 sequence
     I*    19 number      20 option      21-22 record identifying indicator
     I* 23-46 three record identification codes of eight characters each
     I* 31-34 data attributes  35 separator  36 data format
     I* 37-41 from   42-46 to   47-48 decimals   49-62 field name
     I* 63-64 control level   65-66 matching fields
     I* 67-68 field record relation    69-74 field indicators
     I*
     I* Member: RPGLEI   Compilable: no (declarations only, no cycle)
     I* Source: ILE RPG Reference SC09-2508, input specification.
     I* Retrieved: 2026-07-26
     I*
     I*  1         2         3         4         5         6         7         8
     I*8901234567890123456789012345678901234567890123456789012345678901234567890
      *
      * A comment line may leave position 6 blank.
     I*
     I* Program described file. An identification code is a position
     I* in 23-27, an optional N, C/Z/D, and the character to match.
     IORDHDR    AA1 01    1 CH
     I         OR   02    1 CD
     I         OR   03    1 CT    2NZ9   80ND*
     I*
     I* AND and OR relate identification codes across lines, in
     I* positions 16-18.
     IPAYTRN    011O10    1 CA
     I         OR   11    1 CB
     I         AND        2NCX
     I*
     I* Record identifying indicators, and ** for a look-ahead line.
     ICTLFILE       L1    1 C1
     I         OR   H1    1 C1
     I         OR   LR    1 C1
     I         OR   U1    1 C1
     I         OR   RT    1 C1
     I         OR   **    1 C1
     I*
     I* Field descriptions. Position 36 gives the data format and
     I* 37-46 the location; 47-48 hold the decimal positions.
     I                                  1    6  ORDNBR        L1
     I                                  7   26  CUSTNM
     I                             P   27   31 2ORDAMT              202122
     I                             B   32   35 0ORDQTY            01
     I                             L   36   42 2DISCNT                30
     I                             R   43   49 2FRIGHT
     I                             I   50   53 0COUNTER
     I                             U   54   57 0BIGNUM
     I                             F   58   65  RATE
     I                             S   66   72 0ZONFLD
     I                             A   73   82  CHRFLD
     I                             N   83   83  FLAG
     I                             C   84  103  UNIFLD
     I                             G  104  123  DBCSFLD
     I*
     I* Date, time and timestamp fields take their external format
     I* from 31-34 and a separator from 35.
     I                        *ISO D  124  133  ORDDAT
     I                        *MDY/D  134  141  SHPDAT
     I                        *HMS:T  142  149  ORDTIM
     I                        *ISO Z  150  175  ORDSTP
     I                        *VAR A  176  195  VARFLD
     I*
     I* Control level, matching fields and field record relation.
     I                                  1    3  STORE         L1
     I                                  4    9  ORDDAT          M1
     I                                 10   15  SHPDAT          M2MR
     I                                 16   16  STATUS            RT    99
     I                                 17   17  HALTFLD           H1H2
     I*
     I* Externally described file: the record format name in 7-16,
     I* and fields renamed from 21-30 into 49-62. A name may begin
     I* with RT or LR, which are also record identifying indicators,
     I* so these lines are told apart by columns 7-20 being blank.
     ICUSTREC       20
     I              CUSTOMERNM                  CUSTNM
     I              CUSTOMERBL                  CUSTBL        L2    404142
     I              CUSTOMERDT                  CUSTDT          M1
     I              RTNCODE                     RTNCD
     I              LRECLEN                     LRECL
     I*
     I* A page and line number in 1-5 does not disturb the columns.
     I* Positions 75-80 are reserved and must be blank; RPG IV has no
     I* comment area on any specification.
04010ISEQFILE       30    1 CS
04020I                                  1   10  SEQFLD
04030I                                 11   40  SEQNOTE                         numbered + comment
     I                                  1   10  NOTEFLD                         input spec comment
