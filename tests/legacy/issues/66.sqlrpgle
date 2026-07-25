     H* https://github.com/barrettotte/vscode-ibmi-languages/issues/66
     H*
YIKESH/TITLE Messing around with fixed and free format              
     H*                                                             
OH NO   ctl-opt option(*srcstmt:*noDebugIO:*nounref) dftActGrp(*no);
     D*                                                             
XXXXXDCvtScore         S             10A
        dcl-s myvar char(1) inz('X');

        exec SQL
          select * from someTable limit 1;