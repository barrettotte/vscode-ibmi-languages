**FREE
//
// The free-form calculation statements: every operation code that
// free-form calculations accept, every built-in function, the
// operators, and the comment cases from the reference's own example.
//
// Member: FREECALC   Compilable: no (calculations only)
// Source: ILE RPG Reference SC09-2508, free-form calculation statement.
// Retrieved: 2026-07-26
//
//
// Assignment. EVAL may be left out unless the target is named
// after an operation code; EVALR right-adjusts and EVAL-CORR
// copies the subfields the two structures have in common.
total = qty * price;
eval total = qty * price;
eval(h) unit = amount / qty;
evalr padded = text;
eval-corr targetDs = sourceDs;
orderDs.customer = %trim(name);
total = orderDs.lines(idx).amount;
callp calcTax(amount : rate);
calcTax(amount : rate);
//
// Conditions and the operators an expression may use.
if qty > 0 and price >= 0 or not override;
  total = qty * price + freight - discount;
elseif qty = 0;
  total = 0;
elseif qty <> 0 and qty <= maxQty;
  total = qty ** 2;
elseif qty < minQty;
  total += 1;
  total -= 1;
  total *= 2;
  total /= 2;
  total **= 2;
else;
  total = *zero;
endif;
//
// Loops.
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
//
// SELECT. WHEN-IS compares the SELECT operand for equality and
// WHEN-IN tests it against a range or a list.
select;
when qty > 100;
  band = 'A';
when qty > 10;
  band = 'B';
other;
  band = 'C';
endsl;
select qty;
when-is 0;
when-in %range(5 : 20);
when-in %list(2 : 3 : 5);
other;
endsl;
//
// Error handling.
monitor;
  chain ordKey ORDHDR;
on-error *file;
on-error 1211 : 1218;
on-excp 'RNX1211';
on-excp(c) 'RNX1211';
on-exit;
endmon;
//
// Subroutines.
exsr totalsSr;
begsr totalsSr;
  grandTotal += total;
  leavesr;
endsr;
//
// File operations. The extender in parentheses is the same
// closed set the fixed-format calculations use.
chain(e) ordKey ORDHDR;
chain(ehmr) ordKey ORDHDR ordDs;
read(en) ORDHDR ordDs;
reade(enhmr) ordKey ORDDTL;
readp(en) ORDHDR;
readpe(enhmr) ordKey ORDDTL;
readc(e) SFLREC;
setll(ehmr) ordKey ORDHDR;
setgt(ehmr) ordKey ORDHDR;
update(e) ORDREC ordDs;
update(e) ORDREC %fields(custNm : custBl);
write(e) ORDREC;
delete(ehmr) ordKey ORDREC;
open(e) ORDHDR;
close(e) ORDHDR;
feod(en) ORDHDR;
force ORDHDR;
except detail;
exfmt(e) SCREEN screenDs;
post(e) devName ORDSCR;
next(e) devName ORDSCR;
rel(e) devName ORDSCR;
acq(e) devName ORDSCR;
unlock(e) ORDHDR;
in(e) *lock statusArea;
out(e) *lock statusArea;
commit(e) boundary;
rolbk(e);
//
// Data, storage and diagnostics.
clear *all orderDs;
clear *nokey ordKey;
reset(e) *all counters;
sorta(a) rates;
sorta(d) rates;
dealloc(en) basePtr;
dsply('Ready' : 'QSYSOPR' : reply);
dump(a) 'label';
test(edtz) *iso orderDate;
snd-msg(e) 'CPF9898' *escape target;
data-into(eh) ordDs %data(jsonBuf) %parser('YAJLINTO');
data-gen(eh) ordDs %data(jsonBuf) %gen('YAJLDTAGEN');
xml-into(eh) ordDs %xml(xmlBuf : 'case=any');
xml-sax(e) %handler(saxProc : parmDs) %xml(xmlBuf);
return(hmr) total;
//
// Assertions. The A extender always performs the assertion
// unless ASSERT(*CALL) mode is in effect.
assert-t qty >= 0 %msg('Quantity cannot be negative');
assert-f qty = *zero %msg('Quantity must be given');
assert-t(a) %upper(name) = name %msg('Name must be upper');
assert-f(a) custNm = *blanks %msg('Customer is required');
//
// Every built-in function.
result = %abs(value);
result = %addr(field);
result = %alloc(1024);
result = %bitand(maskA : maskB);
result = %bitnot(maskA);
result = %bitor(maskA : maskB);
result = %bitxor(maskA : maskB);
result = %char(amount);
result = %charcount(text);
result = %check(' ' : text);
result = %checkr(' ' : text);
result = %concat(first : last);
result = %concatarr(*none : parts);
result = %data(jsonBuf);
result = %date(stamp : *iso);
result = %days(3);
result = %dec(amount : 11 : 2);
result = %dech(amount : 11 : 2);
result = %decpos(amount);
result = %diff(endDate : startDate : *days);
result = %div(total : count);
result = %editc(amount : '1');
result = %editflt(rate);
result = %editw(amount : '   0. ');
result = %elem(rates);
result = %eof(ORDHDR);
result = %equal(ORDHDR);
result = %error;
result = %fields(custNm : custBl);
result = %float(amount);
result = %found(ORDHDR);
result = %gen('YAJLDTAGEN');
result = %graph(text);
result = %handler(saxProc : parmDs);
result = %hival;
result = %hours(2);
result = %int(amount);
result = %inth(amount);
result = %kds(keyDs);
result = %left(text : 5);
result = %len(text);
result = %list(1 : 2 : 3);
result = %lookup(key : arr);
result = %lookupge(key : arr);
result = %lookupgt(key : arr);
result = %lookuple(key : arr);
result = %lookuplt(key : arr);
result = %lookupne(key : arr);
result = %loval;
result = %lower(text);
result = %max(a : b);
result = %maxarr(rates);
result = %min(a : b);
result = %minarr(rates);
result = %minutes(30);
result = %months(6);
result = %mseconds(500);
result = %msg('MSG0001');
result = %nullind(custNm);
result = %occur(multiDs);
result = %omitted(parm3);
result = %open(ORDHDR);
result = %paddr('CALCTAX');
result = %parmnum(amount);
result = %parms;
result = %parser('YAJLINTO');
result = %passed(parm2);
result = %proc;
result = %range(5 : 20);
result = %realloc(basePtr : 2048);
result = %rem(total : count);
result = %replace('new' : text : 1 : 3);
result = %right(text : 5);
result = %scan(',' : text);
result = %scanr(',' : text);
result = %scanrpl('a' : 'b' : text);
result = %seconds(45);
result = %shtdn;
result = %size(orderDs);
result = %split(text : ',');
result = %sqrt(area);
result = %status;
result = %str(basePtr : 20);
result = %subarr(rates : 1 : 2);
result = %subdt(stamp : *years);
result = %subst(text : 1 : 5);
result = %target(orderDs);
result = %this;
result = %time;
result = %timestamp;
result = %tlookup(key : tbl);
result = %tlookupge(key : tbl);
result = %tlookupgt(key : tbl);
result = %tlookuple(key : tbl);
result = %tlookuplt(key : tbl);
result = %tlookupne(key : tbl);
result = %trim(text);
result = %triml(text);
result = %trimr(text);
result = %ucs2(text);
result = %uns(amount);
result = %unsh(amount);
result = %upper(text);
result = %xfoot(rates);
result = %xlate(low : upp : text);
result = %xml(xmlBuf : 'case=any');
result = %years(2);
//
// Indicators as data, and the figurative constants.
*in01 = *on;
*inlr = *off;
*inh1 = *on;
*inl1 = *on;
*inka = *on;
*inu1 = *on;
*inoa = *on;
*inov = *on;
*in1p = *on;
*inmr = *on;
*inrt = *on;
flags = *in;
*in(idx) = *on;
value = *blank;
value = *blanks;
value = *zero;
value = *zeros;
value = *hival;
value = *loval;
value = *all'X';
value = *allx'00';
value = *null;
value = *omit;
value = *date;
value = *day;
value = *month;
value = *year;
value = udate;
value = page;
//
// The reference's own comment example. Text after // is a
// comment unless the // falls inside a literal.
// comment 1
dcl-s string // comment 2
      char(50);
string = 'abc // not-comment 3  +
         def'; // comment 4
string = 'ghi // not-comment 5 ' +
         'jkl'; // comment 6
//
// A literal continued over several lines, with both continuation
// characters. A + resumes at the first non-blank of the next
// line and a - resumes at position 1, so the leading blanks are
// kept or dropped accordingly.
MySQLStmt = ' with +
P+
     new line added +
     duplicate of above +
     another line added -
     another duplication of above -
)';
//
// No directive may be written inside a single free-form
// calculation statement. A line inside one that begins with what
// looks like a directive is read as a slash followed by a name,
// so the statement below divides by a variable called title.
dcl-s title int(10) inz(2);
x = y
  /title + 5;
