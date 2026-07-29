      *
      *The same reference format serves the OPM COBOL/400 compiler: the
      *columns and the core language are those of Standard COBOL, and the
      *ILE additions are simply absent from members like this one.
      *
      *Member: ORDOPM   Compilable: yes (CRTCBLPGM), but the file it
      *        names is not defined here
      *Source: ILE COBOL Language Reference SC09-2539, reference format.
      *Retrieved: 2026-07-29
      *
000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. ORDOPM.
000300 ENVIRONMENT DIVISION.
000400 CONFIGURATION SECTION.
000500 DATA DIVISION.
000600 WORKING-STORAGE SECTION.
000700 77  WS-COUNT              PIC 9(5) VALUE ZERO.
000800 PROCEDURE DIVISION.
000900 MAIN-PARA.
001000     ADD 1 TO WS-COUNT                                            count
001100     IF WS-COUNT GREATER THAN 10
001200       DISPLAY "DONE"
001300       STOP RUN.
