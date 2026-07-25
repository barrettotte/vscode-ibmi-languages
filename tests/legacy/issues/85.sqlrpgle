**free

// haha wow I didn't notice this...

dcl-s tabName char(64) inz(*blanks);
tabName = 'OUTPUT_QUEUE_ENTRIES_BASIC';

exec sql
  select *
  from QSYS2.SYSTABLES
  where TABLE_OWNER='QSYS'
    and TABLE_NAME=:tabName
;