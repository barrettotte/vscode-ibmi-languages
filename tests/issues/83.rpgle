      // I think this was fixed "by accident" in issue 82
  
      begsr testSubr1;
        dcl-s x int(10) inz(*zero);

      /FREE
        dsply ('FREE!');
      /END-FREE
     C                   ADD       1             X
        x += 1;
      /FREE
        x += 1;
     C                   ADD       1             X
      endsr;

      begsr testSubr2;
        dcl-s x int(10) inz(*zero);
     C                   ADD       1             X
        // previous FREE directive should've been closed
        //   at end of testSubr1
      endsr;