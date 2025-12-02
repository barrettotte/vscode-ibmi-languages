**free

dcl-s myvar1 char(1);

dcl-ds pgm_stat psds;
  status *status;
  routine *routine;
  library char(10) pos(81);
end-ds;

dcl-ds myds1 qualified;
  mysubf1 char(1);
  mysubf2 varchar(30);
  mysubf3 int(10);
end-ds;

dcl-ds myds2 likeds(myds1);

dcl-ds person qualified;
  name varchar(25);
  dcl-ds address;
    num int(5);
    street varchar(25);
    city varchar(25);
    province varchar(25);
    postcode varchar(6);
  end-ds address;
  age int(5);
end-ds person;

dcl-ds family qualified;
  num int(5);
  dcl-ds person dim(10);
    name varchar(25);
    age int(5);
    numpets int(5);
    dcl-ds pets dim(5);
      name varchar(25);
      type varchar(25);
    end-ds pets;
  end-ds person;
end-ds;

dcl-pr myproc1 int(5);
  myparam1 likeds(myds) options(*exact) const;
end-pr;

dcl-pr myproc3 int(5) end-pr;

dcl-pr mypgm1 extpgm;
  name char(10) options(*exact)const;
end-pr;

dcl-s colour_t varchar(11) template;

dcl-proc myproc1;
  dcl-pi myproc1 int(5);
    myparam1 likeds(myds) options(*exact) const;
  end-pi;

  dcl-s myvar2 int(5);
  dcl-c STATUS_NEW const('N');
  dcl-c STATUS_COMPLETE const('C');

  if myds1.mysubf1 = STATUS_NEW;
    myvar2 = 10;
  elseif myds1.mysubf1 = STATUS_COMPLETE;
    myvar2 = 90;
  else;
    myvar2 = 0;
  endif;

  return myvar2;
end-proc;

dcl-proc myproc2;
  dcl-pi *n int(5);
    myparam1 likeds(myds) options(*exact) const;
  end-pi;

  dcl-ds extds1 extname('QIWS/QCUSTCDT');

  dcl-s myvar3 int(5);

  return myvar3;
end-proc;

dcl-proc myproc3;
  dcl-pi *n like(colour_t) end-pi;

  dcl-s myvar3 like(colour_t);

  dcl-enum colours qualified;
    green '0,255,0';
    red '255,0,0';
    blue '0,0,255';
  end-enum;

  myvar3 = colours.green;

  return myvar3;
end-proc;
