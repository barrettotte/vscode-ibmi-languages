**free

// https://github.com/barrettotte/vscode-ibmi-languages/issues/115

  dcl-ds custInfo qualified;
    id int(10);
    name varchar(50);
    city varchar(50);
    orders likeds(order_t) dim(100);
    numOrders int(10);
  end-ds custInfo;

  dcl-ds prtDs len(132) end-ds;

  dcl-ds *N;
     dcl-subf select char(10);  // subfield has reserved word as name, dcl-subf required
     name char(10);             //
     dcl-subf address char(25); // not required, still valid
  end-ds;
