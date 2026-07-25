/* https://github.com/barrettotte/vscode-ibmi-languages/issues/108 */

READ_DSD:
        RCVF       RCDFMT(EMLDSDRF) OPNID(DSD)
        MONMSG     MSGID(CPF0000) EXEC(GOTO CMDLBL(EOF_DSD))

        IF         COND(&DSD_EDFILE *NE ' ') THEN(DO)

        CHGVAR     VAR(&TOFILE) VALUE(&DSD_EDFILE *TCAT '.' *TCAT +
                        &DSD_EDFILETYP)

        IF         (&DSD_EDFILEPATH *EQ '*USER') THEN(DO)
            CHGVAR     VAR(&FILEPATH) VALUE('/home/' *TCAT &USER)
            CHGVAR     VAR(&FILEPATH2) VALUE('\\' *CAT &NETSHR +
                        *TCAT '\home\' *TCAT &USER)
        ENDDO
        ELSE       CMD(DO)
            CHGVAR     VAR(&FILEPATH) VALUE(&DSD_EDFILEPATH)
            CHGVAR     VAR(&SCANVAR) VALUE(&DSD_EDFILEPATH)
            SCNUPDVAR  UPDVAR(&SCANVAR) PATTERN('/') RPLVALUE('\') +
                        MULTSCAN(*YES)
            CHGVAR     VAR(&FILEPATH2) VALUE('\\' *CAT &NETSHR +
                        *TCAT &SCANVAR)
        ENDDO

        IF         (&FILEPATH *GT '              ') THEN(DO)
            MD         DIR(&FILEPATH)
            MONMSG     MSGID(CPFA0A0)
            MONMSG     MSGID(CPF0000) EXEC(DO)
                CLOF       OPNID(EMLDSDPF)
                CALLSUBR   SUBR(STDERR)
            ENDDO
        ENDDO

        CHGVAR     VAR(&FILENAME) VALUE(&FILEPATH *TCAT '/' *TCAT +
                        &TOFILE)
        CHGVAR     VAR(&FILENAME2) VALUE(&FILEPATH2 *TCAT '\' +
                        *TCAT &TOFILE)

        CHGVAR     VAR(&LOCKEDFILE) VALUE('N')