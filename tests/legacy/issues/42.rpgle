**free

    fptr = fopen(fpath: fmode);
    line = fgets(%addr(buffer): %size(buffer): fptr);

    dow (line <> *NULL);
      buffer = %xlate(x'00250D' : '   ': buffer); // CR,LF,NULL
    enddo;