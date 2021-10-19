      * Convert fields to external form
     C  N30
     CANN27              EXSR      MOCV#X
     C                   DOU       W0HLP = 'N'
     C                   MOVEL     'N'           W0HLP
     C                   MOVE      *IN25         HELP25
     C                   MOVE      *ALL'0'       ##OFF
     C                   MOVEA     ##OFF         *IN(1)
     C                   MOVE      HELP25        *IN25