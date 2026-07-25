**free

// Parameter built-in functions %PASSED and %OMITTED

// p1 is required, but *OMIT could be passed
if %passed(p1);
  dsply ('Parameter p1 = ' + %char(p1));
elseif %omitted(p1);
  dsply ('*OMIT was passed for parameter p1');
else;
  snd-msg *escape 'p1 is a required parameter but '
                + 'no parameter was passed';
endif;

// SELECT statement with an operand

select i + 1;
  when-in %list(1 : 3 : 5 : 7);
    dsply ('i+1 is one of 3, 5, 5, 7 ... i = ' + %char(i));
  when-is n;
    dsply ('i+1 = n, so this block is chosen ... n = ' + %char(n));
  when-in arr1;
    dsply ('i+1 is equal to an element of arr1 ' + %char(i));
  other;
    dsply ('i+1 has some other value');
endsl;
