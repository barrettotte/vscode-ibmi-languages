      * https://github.com/barrettotte/vscode-ibmi-languages/issues/82
      *
      * fixed comment
     // free comment

    /FREE
     // comment in /FREE
     // oh...nice
    /END-FREE

    /if not defined (SMS)
    /define SMS

    dcl-ds smsRequest qualified template;
      phone_to   varchar(16);
      phone_from varchar(16);
      msg        varchar(1600);
      account    varchar(64);
      auth       varchar(64);
    end-ds;

    /endif
