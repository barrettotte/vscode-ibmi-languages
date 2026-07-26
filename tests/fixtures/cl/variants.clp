/* An OPM CL member. Same grammar as .cl.                             */
/* Member: CLPVAR   Compilable: yes (CRTCLPGM)                        */

             PGM
             DCLF       FILE(QGPL/MYFILE)
             RCVF
             MONMSG     MSGID(CPF0864) EXEC(GOTO CMDLBL(EOF))
             GOTO       CMDLBL(EOF)
EOF:         ENDPGM
