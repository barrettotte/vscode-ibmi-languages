      * https://github.com/barrettotte/vscode-ibmi-languages/issues/24
      *
     davlchr           c                   'ABCDEFGHIJKLMNOPQRSTUVWXYZ-
     d                                     abcdefghijklmnopqrstuvwxyz-
     d                                     АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ-
     d                                     абвгдеёжзийклмнопрстуфхцчшщъыьэюя-
     d                                     1234567890\ '
      *
      * Notes:
      *  - Remove string escape highlighting in each file type
      *  - End string match regex at newline instead of ' 
      *      OR highlight specs on new line and assume string for the rest of the line?
      *  - However you fix this can be applied to DDS regex as well...
