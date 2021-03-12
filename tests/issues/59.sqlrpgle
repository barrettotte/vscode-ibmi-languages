     H* https://github.com/barrettotte/vscode-ibmi-languages/issues/59
     C*
     C* Embedded SQL fixed form
     C/EXEC SQL
     C* fixed-format comment
     C+     DECLARE MYCSR     CURSOR FOR
     C+       SELECT * FROM SOMETABLE
     C+           WHERE (COLUMNA = :COLUMNA
     C+           AND    COLUMNB = :COLUMNB
     C+                 )
     C+       ORDER BY  COLUMNA ASC,
     C+                 COLUMNB ASC
xxxx C+       -- SQL comment
     C/END-EXEC
     C*
XXXXXC/EXEC SQL
     C+   OPEN MYCSR
xx   C/END-EXEC
     C*
xxxxxC                   IF        SQLCOD = -502
     C/EXEC SQL
     C+   CLOSE MYCSR
     C/END-EXEC
     C                   ELSE
     C                   IF        SQLCOD < 0
     C                   EXSR      MYSUBR
     C                   ENDIF
     C                   ENDIF