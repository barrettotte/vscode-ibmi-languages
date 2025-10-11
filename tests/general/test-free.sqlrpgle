**free

ctl-opt actgrp(*new);

dcl-s cusNum packed(7:0);
dcl-s lstNam char(50);
dcl-s cusCity char(30);
dcl-s message varchar(100);


// Main logic
cusNum = 593029;

// Execute SQL SELECT statement
EXEC SQL
  SELECT LSTNAM, CITY
  INTO :lstNam, :cusCity
  FROM QIWS.QCUSTCDT
  WHERE CUSNUM = :cusNum;

// Check SQLSTATE for errors
if SQLSTATE = '00000';

  // Success - display customer information
  snd-msg ('Customer: ' + %trim(lstNam));
  snd-msg ('City: ' + %trim(cusCity));

elseif SQLSTATE = '02000';

  // No data found
  message = 'Customer ' + %char(cusNum) + ' not found';
  snd-msg message;

else;

  // Other SQL error
  message = 'SQL Error - SQLSTATE: ' + SQLSTATE +
              ' SQLCODE: ' + %char(SQLCODE);
  snd-msg message;
endif;


snd-msg 'SQL Communication Area (SQLCA). ' +
            'SQLCODE: '     + %char(SQLCODE) +
          ', SQLCOD: '      + %char(SQLCOD) +
          ', SQLERRML: '    + %char(SQLERRML) +
          ', SQLERL: '      + %char(SQLERL) +
          ', SQLERRMC: '    + %trimr(SQLERRMC) +
          ', SQLERM: '      + %trimr(SQLERM) +
          ', SQLERRP: '     + SQLERRP +
          ', SQLERP: '      + SQLERP +
          ', SQLERR: '      + SQLERR +
          ', SQLER1: '      + %char(SQLER1) +
          ', SQLER2: '      + %char(SQLER2) +
          ', SQLER3: '      + %char(SQLER3) +
          ', SQLER4: '      + %char(SQLER4) +
          ', SQLER5: '      + %char(SQLER5) +
          ', SQLER6: '      + %char(SQLER6) +
          ', SQLERRD(1): '  + %char(SQLERRD(1)) +
          ', SQLERRD(2): '  + %char(SQLERRD(2)) +
          ', SQLERRD(3): '  + %char(SQLERRD(3)) +
          ', SQLERRD(4): '  + %char(SQLERRD(4)) +
          ', SQLERRD(5): '  + %char(SQLERRD(5)) +
          ', SQLERRD(6): '  + %char(SQLERRD(6)) +
          ', SQLWRN: '      + SQLWRN +
          ', SQLWN0: '      + SQLWN0 +
          ', SQLWN1: '      + SQLWN1 +
          ', SQLWN2: '      + SQLWN2 +
          ', SQLWN3: '      + SQLWN3 +
          ', SQLWN4: '      + SQLWN4 +
          ', SQLWN5: '      + SQLWN5 +
          ', SQLWN6: '      + SQLWN6 +
          ', SQLWN7: '      + SQLWN7 +
          ', SQLWN8: '      + SQLWN8 +
          ', SQLWN9: '      + SQLWN9 +
          ', SQLWNA: '      + SQLWNA +
          ', SQLWARN(1): '  + SQLWARN(1) +
          ', SQLWARN(2): '  + SQLWARN(2) +
          ', SQLWARN(3): '  + SQLWARN(3) +
          ', SQLWARN(4): '  + SQLWARN(4) +
          ', SQLWARN(5): '  + SQLWARN(5) +
          ', SQLWARN(6): '  + SQLWARN(6) +
          ', SQLWARN(7): '  + SQLWARN(7) +
          ', SQLWARN(8): '  + SQLWARN(8) +
          ', SQLWARN(9): '  + SQLWARN(9) +
          ', SQLWARN(10): ' + SQLWARN(10) +
          ', SQLWARN(11): ' + SQLWARN(11) +
          ', SQLSTATE: '    + SQLSTATE +
          ', SQLSTT: '      + SQLSTT ;


*inlr = *on;
return;