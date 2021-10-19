      * https://github.com/barrettotte/vscode-ibmi-languages/issues/78
      *
      * Define LARGE_FILES to get 64-bit version

      /IF DEFINED(QIBM_IFS_INCLUDED)
      /EOF
      /ENDIF
      /DEFINE QIBM_IFS_INCLUDED

      /COPY QSYSINC/QRPGLESRC,SYSTYPES
      /COPY QSYSINC/QRPGLESRC,SYSSTAT
      /COPY QSYSINC/QRPGLESRC,FCNTL
      /COPY QSYSINC/QRPGLESRC,UNISTD
      /COPY QSYSINC/QRPGLESRC,ERRNO
    
     D STREAM_NEW_LINE...                                                       xxxxxx
     D                 C                   X'15'

     D STREAM_LINE_FEED...
     D                 C                   X'25'

     D STREAM_CARRIAGE_RETURN...
     D                 C                   X'0D'

      * ...
      *
      * Notes:
      *   this is an example of a "DX" prompt
      *   I think its triggered via '...'
      *
      *   Prompt:
      *     Name    - size 74
      *     Comment - size 20
