/* A plain .cl member. Same grammar as .clle; this fixture exists so   */
/* the declared extension is exercised.                               */
/* Member: CLVAR   Compilable: yes (CRTBNDCL)                         */

             PGM        PARM(&NAME)
             DCL        VAR(&NAME) TYPE(*CHAR) LEN(10)
             SNDPGMMSG  MSG('Hello ' *BCAT &NAME) MSGTYPE(*INFO)
             ENDPGM
