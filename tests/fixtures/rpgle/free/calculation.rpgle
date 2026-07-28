       //
       // Free-form calculations in a column-limited member. Statements are
       // written in columns 8-80 with 6 and 7 blank; anything past column 80
       // is a comment and must be preceded by //.
       //
       // Member: CLCALC   Compilable: no (calculations only)
       // Source: ILE RPG Reference SC09-2508, free-form statements.
       // Retrieved: 2026-07-27
       //
       //
       // Assignment and the operators an expression may use.
       total = qty * price;
       eval total = qty * price;
       eval(h) unit = amount / qty;
       evalr padded = text;
       eval-corr targetDs = sourceDs;
       callp calcTax(amount : rate);
       orderDs.customer = %trim(name);
       total += 1;
       total -= 1;
       total *= 2;
       total /= 2;
       total **= 2;
       //
       // Conditions, loops and the structured blocks.
       if qty > 0 and price >= 0 or not override;
         total = qty * price + freight - discount;
       elseif qty < minQty;
         total = 0;
       else;
         total = *zero;
       endif;
       dow not %eof(ORDHDR);
         read ORDHDR;
         if %error;
           leave;
         endif;
         iter;
       enddo;
       dou %eof(ORDDTL);
         reade ordKey ORDDTL;
       enddo;
       for idx = 1 to %elem(rates);
         subtotal += rates(idx);
       endfor;
       for idx = 10 downto 1 by 2;
       endfor;
       for-each item in items;
       endfor;
       select qty;
       when-is 0;
       when-in %range(5 : 20);
       other;
       endsl;
       monitor;
         chain ordKey ORDHDR;
       on-error *file;
       on-excp(c) 'RNX1211';
       on-exit;
       endmon;
       exsr totalsSr;
       begsr totalsSr;
         grandTotal += total;
         leavesr;
       endsr;
       //
       // File operations, with their extenders.
       chain(ehmr) ordKey ORDHDR ordDs;
       read(en) ORDHDR ordDs;
       reade(enhmr) ordKey ORDDTL;
       readpe(enhmr) ordKey ORDDTL;
       setll(ehmr) ordKey ORDHDR;
       update(e) ORDREC %fields(custNm : custBl);
       write(e) ORDREC;
       delete(ehmr) ordKey ORDREC;
       exfmt(e) SCREEN screenDs;
       in(e) *lock statusArea;
       test(edtz) *iso orderDate;
       sorta(d) rates;
       dealloc(en) basePtr;
       return(hmr) total;
       //
       // Assertions, indicators and the figurative constants.
       assert-t qty >= 0 %msg('Quantity cannot be negative');
       assert-f(a) custNm = *blanks %msg('Customer is required');
       *in01 = *on;
       *inlr = *on;
       *inh1 = *on;
       *inka = *on;
       *inu1 = *on;
       *inov = *on;
       *in1p = *on;
       flags = *in;
       *in(idx) = *on;
       value = *blanks;
       value = *zeros;
       value = *hival;
       value = *loval;
       value = *null;
       value = *omit;
       //
       // A statement ends at column 80. Anything past it must be
       // preceded by // and is a comment.
       total = qty * price;                                                       // a comment past column 80
       if total > maximumAllowedOrderValue;                                       // and another
       endif;
       //
       // A literal continued onto the next line. The continuation
       // character is the last non-blank of the specification, so no
       // text at all may follow it, not even a comment.
       msg = 'first half of-
         the literal';
       msg = 'carries on-
         to the next line';
       //
       // A /FREE block. The reference records the directive as no
       // longer needed, but the compiler still checks its syntax and
       // real source still carries it.
     C/FREE
       total = qty * price;
       if total > 0;
         except detail;
       endif;
     C/END-FREE
       //
       // Comments: a whole line, the end of one, and the // that falls
       // inside a literal and is not a comment at all.
       // a comment on its own line
       dcl-s string char(50); // at the end of a statement
       string = 'abc // not-comment  +
         def'; // a comment
       //
       // A closed literal followed by a plus is not a continued literal
       // at all: the quote ended it, so the plus joins two of them.
       string = 'ghi // not-comment ' +
         'jkl'; // a comment
       //
       // No directive may be written inside a single free-form
       // calculation statement. A line inside one that begins with what
       // looks like a directive is read as a slash followed by a name,
       // so the statement below divides by a variable called title.
       dcl-s title int(10) inz(2);
       x = y
         /title + 5;
