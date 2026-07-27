     P*
     P* RPG IV procedure specification: the begin and end lines that
     P* bracket a subprocedure, every procedure keyword, and the two
     P* kinds of continuation line.
     P*
     P*  7-21 name       24 B begins the subprocedure, E ends it
     P* 44-80 keywords, which only a begin line may carry
     P*
     P* Member: RPGLEP   Compilable: no (subprocedures only, no main)
     P* Source: ILE RPG Reference SC09-2508, procedure specifications.
     P* Retrieved: 2026-07-26
     P*
     P*  1         2         3         4         5         6         7         8
     P*8901234567890123456789012345678901234567890123456789012345678901234567890
      *
      * A comment line may leave position 6 blank.
     P*
     P* The smallest subprocedure: a begin line, a procedure
     P* interface, and an end line. Nothing is exported.
     PLOCALSUB         B
     D                 PI
     C                   RETURN
     PLOCALSUB         E
     P*
     P* Every procedure keyword. EXPORT makes the subprocedure
     P* callable from outside the module, PGMINFO controls the
     P* generated program interface, REQPROTO(*NO) waives the
     P* prototype requirement and SERIALIZE serialises the calls.
     PCALCTAX          B                   EXPORT
     D                 PI             7P   2
     DAMOUNT                          7P   2 VALUE
     DRATE                            5P   3 CONST
     C                   RETURN    AMOUNT * RATE
     PCALCTAX          E
     PPROCPGMI         B                   PGMINFO(*YES)
     D                 PI
     PPROCPGMI         E
     PPROCPGMI         B                   PGMINFO(*NO)
     D                 PI
     PPROCPGMI         E
     PPROCREQP         B                   REQPROTO(*NO)
     D                 PI
     PPROCREQP         E
     PPROCSERI         B                   SERIALIZE
     D                 PI
     PPROCSERI         E
     P*
     P* More than one keyword may appear on the same begin line.
     PMANYKW           B                   EXPORT SERIALIZE PGMINFO(*NO)
     D                 PI
     PMANYKW           E
     P*
     P* A keyword field too long for one line continues on a line
     P* with P in 6 and 7-43 blank, resuming on or past 44.
     PCONTKW           B                   EXPORT
     P                                     SERIALIZE
     D                 PI
     PCONTKW           E
     P*
     P* A name longer than 15 positions, or any name the programmer
     P* chooses to split, is written on continued name lines ending
     P* in an ellipsis. The name entry of the line that follows may
     P* be left blank.
     PVERYLONGPROCED...
     PURENAME          B                   EXPORT
     D                 PI
     PVERYLONGPROCED...
     PURENAME          E
     PSPLITNAME...
     P                 B
     D                 PI
     P                 E
     P*
     P* A page and line number in 1-5 does not disturb the columns.
     P* Positions 81-100 are a comment area.
07010PNUMBERED         B                   EXPORT
07020D                 PI
07030PNUMBERED         E
     PNOTED            B                   EXPORT                               begin procedure
     D                 PI
     PNOTED            E                                                        end procedure
