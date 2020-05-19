**free

  exec sql
    GROUP BY RRCLTP,rrclm#,
      poltp2,
      raplcy
    HAVING sum(rrpaym) >=500; -- Only payments exceeding $500