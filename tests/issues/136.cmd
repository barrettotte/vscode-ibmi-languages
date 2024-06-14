cmd             prompt( 'Variant characters in identifiers' )

parm            &@te@st@     *char      1
parm            &#te#st#     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qual@#$        prompt( 'Object' )
qual@#$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* note: double click doesn't select full identifier */
/*   but, single clicking highlights full identifier */
/* I guess that's the correct behavior?              */

/* Additional variants: https://docs.google.com/spreadsheets/d/1J4yEGkfhtmACfdDVyD2XNJe0jjrIK77Um6-wsvW0etM/edit?usp=sharing */

/* CCSID 273 (Austria and Germany) */
parm            &@te@st@     *char      1
parm            &#te#st#     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qual@#$        prompt( 'Object' )
qual@#$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 277 (Denmark and Norway) */
parm            &ØteØstØ     *char      1
parm            &ÆteÆstÆ     *char      1
parm            &ÅteÅstÅ     *char      1

parm            &qualified   qualØÆÅ        prompt( 'Object' )
qualØÆÅ:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 278 (Finland and Sweden) */
parm            &ÖteÖstÖ     *char      1
parm            &ÄteÄstÄ     *char      1
parm            &ÅteÅstÅ     *char      1

parm            &qualified   qualÖÄÅ        prompt( 'Object' )
qualÖÄÅ:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 280 (Italy) */
parm            &§te§st§     *char      1
parm            &£te£st£     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qual§£$        prompt( 'Object' )
qual§£$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 284 (Spain and Latin America) */
parm            &@te@st@     *char      1
parm            &ÑteÑstÑ     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qual@Ñ$        prompt( 'Object' )
qual@Ñ$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 285 (Ireland and the United Kingdom) */
parm            &@te@st@     *char      1
parm            &#te#st#     *char      1
parm            &£te£st£     *char      1

parm            &qualified   qual@#£        prompt( 'Object' )
qual@#£:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 290 (Japan (katakana)) */
parm            &@te@st@     *char      1
parm            &#te#st#     *char      1
parm            &¥te¥st¥     *char      1

parm            &qualified   qual@#¥        prompt( 'Object' )
qual@#¥:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 297 (France) */
parm            &àteàstà     *char      1
parm            &£te£st£     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qualà£$        prompt( 'Object' )
qualà£$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 423 (Greece) */
parm            &§te§st§     *char      1
parm            &£te£st£     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qual§£$        prompt( 'Object' )
qual§£$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 871 (Iceland) */
parm            &ÐteÐstÐ     *char      1
parm            &#te#st#     *char      1
parm            &$te$st$     *char      1

parm            &qualified   qualÐ#$        prompt( 'Object' )
qualÐ#$:        qual         *name     10
                qual         *name     10   prompt( 'Library' )

/* CCSID 905 (Turkey - Latin-3) */
parm            &ŞteŞstŞ     *char      1
parm            &ÖteÖstÖ     *char      1
parm            &İteİstİ     *char      1

parm            &qualified   qualŞÖİ        prompt( 'Object' )
qualŞÖİ:        qual         *name     10
                qual         *name     10   prompt( 'Library' )
