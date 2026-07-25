     H option(*srcstmt : *nodebugio) bnddir('QC2LE')

25001  // 07/07/26 Dev2 #5555.55 - Update
M01    // 04/25/16 Dev1 #12345 - Changes

       // This example focuses on left and right side comments when not using **FREE

M01  FMYFILE    if   e           k disk    usropn extfile(pathFILE)             LIB/MYFILE
       // Program status data structure
M01  D pgmDS          SDS                  QUALIFIED
M01  D  Library               81     90                                         Pgm Library
M01  D  JOB_NAME             244    253                                         Job name
M01  D  USER                 254    263                                         User name
     D  JOB_NUM              264    269S 0                                      Job number
25001D  JOB_NUMc             264    269                                         Job number
     D  Program              334    343                                         Program Name

         exec sql
           Declare csrTheCursor Cursor for
M01         select A.FIELD1, A.FIELD2
             from MYFILE A
             join YOURFILE B
                  ON A.KEY1     = B.KEY1  AND
                     A.KEY2     = B.KEY2
25001       where A.KEY1 = :MasterKey
25001         and A.KEY2 not in ('MONDAY', 'FRIDAY')
M01           and A.STATUS <> 'I'
25001       order by MONTH(A.KEY1), A.KEY2;
         Exec SQL Open csrTheCursor;

       //-------------------------------------------------------------
       //Begin Subroutine - Contacts
       //-------------------------------------------------------------
       begsr $Contacts;
M01
M01                                                                             Comment
                                                                                Program Name
25001      dou $ChkSQLState(SQLSTT);
25001        Exec SQL select CKEY, NKEY,
25001                        RMCNAM1, RMCPHO1, RMCEMA1,                         Comment in SQL
25001                        RMCNAM2, RMCPHO2, RMCEMA2,
25001                        RMCNAM3, RMCPHO3, RMCEMA3
25001                   into :dsContact
25001                   from CONTACTS
25001                  where CKEY = :@1CKEY
25001                    and NKEY = :@1NKEY;
25001      enddo;
25001
M01
       exec SQL insert into library/testa                                       values
        values('X', 'Y', 'Z');
       endsr;
25001  //-------------------------------------------------------------
25001  //$BuildEmail - Build Email
25001  //-------------------------------------------------------------
25001  dcl-proc $BuildEmail;
M01
25001    dcl-s message char(1000);
25001    dcl-s contacts char(100);
25001    dcl-s emails char(200);
25001    dcl-s count int(20);
25001    dcl-s missingemail ind;
25001
25001    dcl-ds dsEmailContacts;
25001      FIRST1  char(30);
25001      RMCNAM1 char(30);
25001      RMCEMA1 char(50);
25001      FIRST2  char(30);
25001      RMCNAM2 char(30);
25001      RMCEMA2 char(50);
25001      FIRST3  char(30);
25001      RMCNAM3 char(30);
25001      RMCEMA3 char(50);
25001    END-DS;
M01
25001    dcl-c cmd_STRPCCMD 'STRPCCMD PCCMD(''%'') PAUSE(*NO)';
25001    dcl-c msg_HEADER 'start outlook.exe /c ipm.note /m "%+
25001                      ?Subject=% - % &Body=%,%';
25001    dcl-c msg_SUBJECTA 'Event 1';
25001    dcl-c msg_SUBJECTR 'Event 2';
25001    dcl-c msg_AFTER '%0A%0AAs this is a very long message that, +
25001                     I would like to send to you about the +
25001                     process that is happening soon. Please let me +       Comment
25001                     know if you are ready to proceed.%0A%0ASincerely,"';
25001
25001    sqlStatement = 'delete +
M01                     // testSchema/terstTable +
25001                   testSchema/testTable +
25001                   where flag <> ''Y''';
25001
25001
25001  end-proc;
25001

M01

TEST

25001 /end-free
