      // https://github.com/barrettotte/vscode-ibmi-languages/issues/114
      *
      /copy qrpglesrc,cpy_good
     c/copy qrpglesrc,cpy_good
     d/copy qrpglesrc,cpy_bad
      *
      /include qrpglesrc,inc_good
     c/include qrpglesrc,inc_good
     d/include qrpglesrc,inc_bad

      * fixing up another bug I saw in 34.rpgle, TPBFVR should be commented
     C                   ENDSR                                                              *INZSR
      /EJECT                                                                                TPBFVR
      /COPY EQCPYLESRC,PSSR_B                    Program error control sub (on-line)     IL EQTPBFVR
     C/EJECT                                                                                TPBFVR
      /COPY EQCPYLESRC,NUMEDT                    Edit number without leading zeros        C EQTPBFVR