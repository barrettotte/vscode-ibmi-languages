******************************
      * https://github.com/barrettotte/vscode-ibmi-languages/issues/120
      *
      *
      ***************************************
       //
       // test
       //
       //************************************
        ctl-opt NoMain;
        
       /copy *LIBL/QptypeSrc,Sla2upr

       dcl-s ArraySize int(10) inz(500);
       dcl-ds CntryArray Qualified Dim(500);
         dcl-subf Code char(4);
         dcl-subf Country char(30);
       end-ds;

       dcl-ds StateArray Qualified Dim(500);
         dcl-subf CrCode char(4);
         dcl-Subf StCode char(2);
       end-ds;

       // test compile time array
** COVERAGES ARRAY
MED EXP                      1
INC LOSS                     2
FUN EXP                      3
ACC DEATH                    4
COMB-FPB                     5
PIP LIMIT                    6
DED/INCOME                   7
SEC                          8
PIP DED                      9
PIP                         10
DEDUCTIBLE                  11
DED/CO-ORD                  12
