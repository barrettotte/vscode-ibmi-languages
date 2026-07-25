**free
// https://github.com/barrettotte/vscode-ibmi-languages/issues/94

          Exec SQL
            select count(*)
               into :FailedCount INDICATOR :NFFlag
               from somelib/request a, somelib/response b
             where a.wasd = b.wasd
               and trans_date = :TodayTest
               and substring(trans_time, 1, 2) = :ThisHour;