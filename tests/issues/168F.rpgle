**FREE

ctl-opt option(*srcstmt : *nodebugio);

// commeents mid string
dcl-s sqlStatement char(2000);

sqlStatement = 'delete +                        
                //M01 testSchema/terstTable +      
                testSchema/testTable +          
                where flag <> ''Y''';           

*inlr = *on ;
