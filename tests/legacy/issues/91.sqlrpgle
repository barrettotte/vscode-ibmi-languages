           EXEC SQL
                DECLARE CSR CURSOR FOR
                  SELECT * FROM SOME_TABLE
                      WHERE (RMPCDE       >  :X@PCDE
                      OR    (RMPCDE       =  :X@PCDE    AND
                             RMCRIT       >  :X@CRIT       )
                      OR    (RMPCDE       =  :X@PCDE    AND
                             RMCRIT       =  :X@CRIT    AND
                             RMSQ##       >= :X@SQ##       )
                            )
                  ORDER BY  RMPCDE        ASC,
                            RMCRIT        ASC,
                            RMSQ##        ASC;
           EXEC SQL
              OPEN CSR;
