/* https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rbam6/datearith.htm */
/* Calculate new date from current system date.  Pass negative     */   
/* number to subtract, positive number to add                      */   
/*                                                                 */   
/* The first parameter is a character 8 date in YYYYMMDD format    */   
/* or the special value *CURRENT                                   */   
/*                                                                 */   
/* The second parameter is a decimal value for the number of days  */   
/* to adjust the first parameter by                                */   
/*                                                                 */   
/* Test cases:  CALL CALCDATE (*CURRENT -5)                        */   
/*              CALL CALCDATE (*CURRENT  5)                        */   
/*              CALL CALCDATE ('20030225' -90)                     */   
/*              CALL CALCDATE ('30020228' 90)                      */   
/*                                                                 */   
/* There is no error handling in this sample, so make sure the     */   
/* input dates are valid (that is, no 20031325).  The valid date   */  
/* date range is Oct 14 1582 to Dec 31 9999                        */  
/*                                                                 */  
             PGM        PARM(&curdate &DAYSTOCHG)                     
             DCL        VAR(&CURDATE) TYPE(*CHAR) LEN(8)              
             DCL        VAR(&DAYSTOCHG) TYPE(*DEC) LEN(15 5)          
             DCL        VAR(&DATETIME) TYPE(*CHAR) LEN(17)            
             DCL        VAR(&DATE) TYPE(*CHAR) LEN(8)                 
             DCL        VAR(&LILDATEINT) TYPE(*CHAR) LEN(4)           
             DCL        VAR(&LILDATEDEC) TYPE(*DEC) LEN(10 0)         
             DCL        VAR(&ERRCOD) TYPE(*CHAR) LEN(4) +             
                          VALUE(X'00000000')                          
             DCL        VAR(&MSG) TYPE(*CHAR) LEN(50)                 
             IF         COND(&CURDATE = '*CURRENT') THEN(DO)          
             CALL       PGM(QWCCVTDT) PARM('*CURRENT' ' ' '*YYMD' +   
                          &DATETIME &ERRCOD) /* Get current system +
                          date and time in YYYYMMDD */                  
             CHGVAR     VAR(&DATE) VALUE(%SST(&DATETIME 1 8)) /* Get + 
                           just the date portion */                     
             ENDDO                                                     
             ELSE       CMD(CHGVAR VAR(&DATE) VALUE(&CURDATE)) /* +    
                           Use the date provided */                     
             CALLPRC    PRC(CEEDAYS) PARM(&DATE 'YYYYMMDD' +           
                           &LILDATEINT *OMIT) /* Get Lilian date for +  
                           current date */                              
             CHGVAR     VAR(&LILDATEDEC) VALUE(%BIN(&LILDATEINT)) /* + 
                           Get Lilian date in decimal format */         
             CHGVAR     VAR(&LILDATEDEC) VALUE(&LILDATEDEC + +         
                           &DAYSTOCHG) /* Adjust specified number +     
                           of days */                                   
             CHGVAR     VAR(%BIN(&LILDATEINT)) VALUE(&LILDATEDEC) /* + 
                           Get Lilian date in integer format */         
             CALLPRC    PRC(CEEDATE) PARM(&LILDATEINT 'YYYYMMDD' +     
                          &DATE *OMIT) /* Return calculated date in +  
                          YYYYMMDD format */                           
             CHGVAR     VAR(&MSG) VALUE('The new date is ' *CAT &DATE) 
             SNDPGMMSG  MSG(&MSG) TOPGMQ(*EXT)                         
             ENDPGM  