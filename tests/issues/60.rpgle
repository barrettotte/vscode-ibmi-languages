
     H* https://github.com/barrettotte/vscode-ibmi-languages/issues/60
      *
      ***** Case One *****
10011 * Don't write Audit for GetMemberAttendanceList unless logging is on
10011C                   if        e#wsName  <> 'GetMemberAttendanceList'
10011C                             or (e#wsName = 'GetMemberAttendanceList'
10011C                             and loge00 = 'Y')
     C
     C                   clear     *all          tc023r
     C                   eval      user23 = userid
     C                   eval      pgmd23 = prognm
     C*
     C*
     C*
     C*
     C***** Case Two *****
z3319C* Frontend uses counts to control loop by don't count for 
z3319 * Moved here as the....
z3319 * and p#total were reset incorrectly
z3319C                   if        %eof(py015l4)
z3319C                   eval      p#last = p#totl
z3319C                   else
z3319C                   eval      p#last = p#total - 1
z3319C                   endif
         endif;
         endsr;
      /end-free
z0200 *****************************************************