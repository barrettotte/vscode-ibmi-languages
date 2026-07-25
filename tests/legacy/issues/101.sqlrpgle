/free
// https://github.com/barrettotte/vscode-ibmi-languages/issues/101

MySQLStmt = ' with +
P+
     new line added +
     duplicate of above +
     another line added -
     another duplication of above -
)';
/end-free

     d* bug introduced in https://github.com/barrettotte/vscode-ibmi-languages/issues/23
     davlchr           c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ-
     d                                     abcdefghijklmnopqrstuvwxyz-
     d                                     АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ-
     d                                     абвгдеёжзийклмнопрстуфхцчшщъыьэюя-
     d                                     1234567890\ '
