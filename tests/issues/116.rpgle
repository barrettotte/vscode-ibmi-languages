**free

// Control option keywords CHARCOUNTTYPES and CHARCOUNT

ctl-opt charcounttypes(*utf8);
ctl-opt charcount(*natural);

// File definition keyword CHARCOUNT

dcl-f filename charcount(*natural);

// BIF %CHARCOUNT

n = %charcount(string);

// /CHARCOUNT directive

/charcount natural
/charcount stdcharsize

// %SUBST keywords *NATURAL and *STDCHARSIZE

string2 = %subst(string : 1 : 3 : *natural);
string2 = %subst(string : 1 : 3 : *stdcharsize);

// %CONCAT and %CONCATARR

string = %concat(', ' : 'Cow' : 'Moon' : 'Dish' : 'Spoon');
string = %concatarr(':' : array);