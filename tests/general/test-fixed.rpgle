     H/TITLE Testing syntax highlighting
      *
     H* Test control spec
     H DATFMT(*YMD) DATEDIT(*YMD) DEBUG(*YES) OPTION(*NODEBUGIO)                h spec comment
      *
     F* Test file spec (program described)
     FSOMEFILE  OTEAAF12345L12345ZIWORKSTN EXTDESC(FILE123)                     f spec comment
      *
     F* Test file spec (externally described)
     FANOTHRFILEUPEADE     L     G SPECIAL INDDS(SOMEDS)                        f spec comment
      *
     I* Test input spec
     IMYFILE    A1NO**11111NCX22222NZY33333NDZ                                  i spec comment
      *
     D* Test definition spec
     DMYFIELD        ESS *OPCODE-12345 *12 NOOPT                                d spec comment
      *
     D* Test definition extended (DX) spec
     D STREAM_NEW_LINE...                                                       dx spec comment
      *
     C* Test calculation spec
     CSRNH4FACTOR1       ADD       FACTOR2       RESULT        1234533KCU7OV    c spec comment
      *
     CL4 KPMYFIELD       IF        ANOTHERFIELD = 'something'                   c spec comment
      *
     C/COPY /something
      *
     O* Test ouput spec
     OMYFILE    TF  N02 OGN1PSOMERECRDS123222100105                             o spec comment
      *
     P* Test procedure spec
     PMYPROC           B                   EXPORT                               p spec - begin procedure
     PMYPROC           E                                                        p spec - end procedure
      *
      /EJECT

      * Test /TITLE for all line line types

     H/title title text
     F/title title text
     I/title title text
     D/title title text
     C/title title text
     O/title title text
     P/title title text
      /title title text

      * Test /EJECT for all line line types

     H/eject
     F/eject
     I/eject
     D/eject
     C/eject
     O/eject
     P/eject
      /eject

      * Test /IF and /ENDIF

     H/if defined something
     H DECFMT('J')
     H/endif

      * Test /COPY and /INCLUDE

     H/copy lib/file.member
     H/include lib/file.member


      * Issue #76
      * - handle hyphenated opcodes and fields containing opcode words

     D end1            S             10i 0
     D endif_b         S             10i 0
     D c_endif         S             10i 0
     D endx            S             10i 0
     D end#1           S             10i 0
     D end@1           S             10i 0
     D end$1           S             10i 0
     D end£1           S             10i 0
     D end§1           S             10i 0

     C                   monitor                                                Valid
     C                   on-error                                               Valid
     C                   endmon                                                 Valid
     C                   end-mon                                                Invalid
     C                   end-monitor                                            Invalid
     C                   abc-monitor                                            Invalid

     C                   Eval      end1 = 1
     C                   Eval      endif_b = 2
     C                   Eval      c_endif = 3
     C                   Eval      endx = 4
     C                   Eval      end#1 = 5
     C                   Eval      end@1 = 6
     C                   Eval      end$1 = 7
     C                   Eval      end£1 = 8
     C                   Eval      end§1 = 9

     C                   endif                                                  Valid
     C                   endif-abc                                              Invalid
     C                   endif-test                                             Invalid

     C                   acq                                                    valid
     C                   acq-test                                               Invalid
     C                   acquire                                                Invalid

     C     CUSCOD        Chain(N)  CUSTOMERS                          21
     C     CUSCOD        Chain(EN) CUSTOMERS                          21

