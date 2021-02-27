**free

// DEBUG(*RETVAL)
ctl-opt debug(*RETVAL);


// REQPREXP - https://www.ibm.com/support/pages/node/6342897
ctl-opt reqprexp(*WARN);  // *NO, *REQUIRE


// EXPROPTS - https://www.ibm.com/support/pages/node/6342819
ctl-opt expropts(*ALWBLANKNUM);  // *USEDECEDIT

dcl-s num packed(5:2);
dcl-s str char(20);

str = *blanks;
num = %dec(str:63:5);  // num = 0


// %RANGE - https://www.ibm.com/support/pages/node/6342821
if %date() in %range(min_register_date: max_register_date);
  processRegistration();  // the date is in range
endif;


// %LIST - https://www.ibm.com/support/pages/node/6342821
dcl-s names varchar(20) dim(3);
names = %list('Mary': 'Jack': 'Alice');


// IN - https://www.ibm.com/support/pages/node/6342821
dcl-s sale_cities varchar(20) dim(10);
dcl-s num_sale_cities int(10);

if city in %subarr(sale_cities: 1: num_sale_cities);
  if cust_status in %list(STATUS_PREFERRED: STATUS_GOLD);
    subtract_discount();
  endif;
endif;


// FOR-EACH - https://www.ibm.com/support/pages/node/6342821
dcl-ds error likeds(error_t);
dcl-ds errors likeds(error_t) dim(100);
dcl-s num_errors int(10);
dcl-s error_type int(10);
dcl-s filename varchar(21);
dcl-f logfile extdesc('LOGFILE_T') extname(filename);

for-each filename in %list('CUR_ERRORS': 'ALL_ERRORS');
  open logfile;
  for-each error in %subarr(errors: 1: num_errors);
    log_error_message(error);
  endfor;
endfor;
