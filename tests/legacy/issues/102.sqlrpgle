**free
// https://github.com/barrettotte/vscode-ibmi-languages/issues/102

if PRPLPR.Rcenrldays > 0 and Ee_Days >= PRPLPR.Rcenrldays;
  if PRPLPR.Rcenrlamt > 0;
    exec sql select 'Y' into :Eligible
    from PRPELVTB
      where ELEMP = :Empid and ELTYPE in ( 'X' )
      and ELLPID = :Leaveplanid and ELEFFDATE <= :Dates.Annv_Earned_Nxt
      -- ...
      order by ELEFFDATE desc
      fetch first 1 rows only;
    return Eligible;
  else;
    return 'Y';
  endif;
elseif PRPLPR.Rcenrldays > 0 and Ee_Days < PRPLPR.Rcenrldays;
  return 'N';
else;
  return 'Y';
endif
