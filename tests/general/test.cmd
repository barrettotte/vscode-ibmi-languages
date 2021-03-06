/*-----------------------------------------------------------------*/
/*                                                                 */
/*  Sample command definition.                                     */
/*                                                                 */
/*-----------------------------------------------------------------*/

cmd        prompt( 'Sample Command Definition' ) text( *cmdpmt ) +
             allow( *bpgm *ipgm *bmod *imod *brexx *irexx )

parm       Obj         QUALOBJ       min( 1 )                                        prompt( 'Qualified object' )
parm       YesNo1      *char      4  dft( *NO )  rstd( *yes )  values( *YES *NO ) +
                                                 expr( *yes )                        prompt( 'Yes or No value 1' )
parm       YesNo2      *char      4  dft( *YES ) rstd( *yes )  values( *YES *NO ) +
                                                 expr( *yes )                        prompt( 'Yes or No value 2' )
parm       PmtTest     *name     10  dft( *NONE )              spcval( ( *NONE ' ' ) ) +
                                                 expr( *yes )  pmtctl( YESNOYES)     prompt( 'Prompt testing' )

QUALOBJ:   qual        *name     10              expr( *yes )
           qual        *name     10  dft( *LIBL )              spcval( *CURLIB *LIBL ) +
                                                                                     prompt( 'Library' )

YESNOYES:  pmtctl      YesNo1 ( ( *eq *YES ) )

dep        ctl( YesNo1 )  parm( ( YesNo2 *ne YesNo1 ) )  msgid(CPF9898)
