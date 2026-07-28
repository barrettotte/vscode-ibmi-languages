     H option(*srcstmt : *nodebugio)
       
       // commeents mid string
     D sqlStatement    s           2000a

25001C                   eval      sqlStatement = 'delete +
M01  C*                                            testSchema/terstTable +
25001C                                             testSchema/testTable +
25001C                                             where flag <> ''Y'''