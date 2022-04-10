**free

dcl-ds *n;
  var1  int;
  var2  char samepos( var1 );
end-ds;

dcl-pr format_date varchar(100);
  dateparm date(*iso) const;
end-pr;
dcl-pr retrieve_message varchar(100);
  msgid char(7) const;
  replacement_text varchar(100) const;
end-pr;

dcl-pr format varchar(100) overload(format_date : retrieve_message);

dcl-s dueDate date nullind;
