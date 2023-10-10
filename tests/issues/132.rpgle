**free

// %LEFT

// Built-in function %LEFT(parameter_name) returns the leftmost characters in a string.

dcl-s string char(10) inz('abcdefghij');
dcl-s string2 varchar(10);

string2 = %LEFT(string : 3);
// string2 = "abc"

// %RIGHT

// Built-in function %RIGHT(parameter_name) returns the rightmost characters in a string.

dcl-s string char(10) inz('abcdefghij');
dcl-s string2 varchar(10);

string2 = %RIGHT(string : 3);
// string2 = "hij"

// ENUMERATION

// Defining an enumeration

dcl-enum colorCodes qualified;
    blue 1;
    green 2;
    yellow 3;
  end-enum;

  dcl-enum boolean;
    true '1';
    false '0';
  end-enum;

  dcl-enum nameSize qualified;
    system 10;
    path 5000;
    dcl-c dsply 52; // Name "DSPLY" needs DCL-C
  end-enum;

  dcl-s ifsFile varchar(nameSize.path);  // Use the enum value in a definition

  dcl-s color int(10);
  dcl-s isValid ind;

  color = colorCodes.blue;   // Use the qualified enum value
  isValid = true;            // Use the unqualified enum value

