# Changelog

### 0.6.13

- Adds `.rpgleinc` to RPGLE file extensions, thanks to [@GajenderI](https://github.com/GajenderI). [128](https://github.com/barrettotte/vscode-ibmi-languages/issues/128)

### 0.6.12

- Enhance RPGLE syntax coloring, thanks to [@chrjorgensen](https://github.com/chrjorgensen). [127](https://github.com/barrettotte/vscode-ibmi-languages/issues/127)

### 0.6.11

- Adds Spring 2023 PTF enhancements for 7.4 and 7.5, thanks to [@chrjorgensen](https://github.com/chrjorgensen). [125](https://github.com/barrettotte/vscode-ibmi-languages/issues/125)
- Fixes PNLGRP regex as requested by Github linguist project. [124](https://github.com/barrettotte/vscode-ibmi-languages/issues/124)

### 0.6.10

- Adds additional support for PNGLGRP, thanks to [@chrjorgensen](https://github.com/chrjorgensen). [123](https://github.com/barrettotte/vscode-ibmi-languages/issues/123)

### 0.6.9

- Adds support for additional panel group tags, thanks to [@chrjorgensen](https://github.com/chrjorgensen). [121](https://github.com/barrettotte/vscode-ibmi-languages/issues/121)
- Fixes bug with `**` causing following text to highlight as compile time array in RPGLE free [120](https://github.com/barrettotte/vscode-ibmi-languages/issues/120)

### 0.6.8

- Adds Fall 2022 RPGLE Enhancements, thanks to [@chrjorgensen](https://github.com/chrjorgensen). [116](https://github.com/barrettotte/vscode-ibmi-languages/issues/116)

### 0.6.7

- Fix CL highlighting error with escaped characters [108](https://github.com/barrettotte/vscode-ibmi-languages/issues/108)
- Fix RPGLE fixed format issue with extended identifiers [110](https://github.com/barrettotte/vscode-ibmi-languages/issues/110)
- Fix `SUBDUR` missing from RPGLE keywords [113](https://github.com/barrettotte/vscode-ibmi-languages/issues/113)
- Fix RPGLE fixed format `INCLUDE` and `COPY` broken highlighting [114](https://github.com/barrettotte/vscode-ibmi-languages/issues/114)
- Adds missing `DCL-SUBF` keyword to RPGLE free format [115](https://github.com/barrettotte/vscode-ibmi-languages/issues/115)

### 0.6.6

- Add Spring 2022 RPG enhancements for 7.3, 7.4, and 7.5, thanks to [@chrjorgensen](https://github.com/chrjorgensen)

### 0.6.5

- Add missing RPGLE keywords `SAMEPOS`, `OVERLOAD` and `NULLIND` [104](https://github.com/barrettotte/vscode-ibmi-languages/issues/104), thanks to [@chrjorgensen](https://github.com/chrjorgensen)

### 0.6.4

- Fix RPGLE `/TITLE` preprocessor highlighting [90](https://github.com/barrettotte/vscode-ibmi-languages/issues/90)
- Fix SQLRPGLE host variable identifier regex [91](https://github.com/barrettotte/vscode-ibmi-languages/issues/91)
- Fix RPGLE fixed format identifier highlighting [93](https://github.com/barrettotte/vscode-ibmi-languages/issues/93)
- Fix SQLRPGLE qualified objects highlighting [94](https://github.com/barrettotte/vscode-ibmi-languages/issues/94)
- Fix Commented out `EXEC SQL` causing highlighting problems [96](https://github.com/barrettotte/vscode-ibmi-languages/issues/96)
- Fix CL identifier/label regex [97](https://github.com/barrettotte/vscode-ibmi-languages/issues/97)
- Fix CL `/*ALL` causing multiline comment highlighting [98](https://github.com/barrettotte/vscode-ibmi-languages/issues/98)
- Fix RPGLE free multiline string highlighting issue [101](https://github.com/barrettotte/vscode-ibmi-languages/issues/101)
- Fix `SELECT` control block matching in RPGLE [102](https://github.com/barrettotte/vscode-ibmi-languages/issues/102)

### 0.6.3

- Fix `QDATETIME` highlighting in CL, thanks to [@chrjorgensen](https://github.com/chrjorgensen)

### 0.6.2

- Add missing RPGLE Fixed "DX" spec [78](https://github.com/barrettotte/vscode-ibmi-languages/issues/78)
- Fix RPGLE fixed compile time array highlighting [80](https://github.com/barrettotte/vscode-ibmi-languages/issues/80)
- Fix RPGLE preprocessor comment highlighting [82](https://github.com/barrettotte/vscode-ibmi-languages/issues/82)
- Fix RPGLE `/FREE` preprocessor scope issue [83](https://github.com/barrettotte/vscode-ibmi-languages/issues/83)
- Fix RPGLE fixed: C-spec missing constant [84](https://github.com/barrettotte/vscode-ibmi-languages/issues/84)
- Fix SQLRPGLE free: exec SQL highlighting broken on col 1 [85](https://github.com/barrettotte/vscode-ibmi-languages/issues/85)

### 0.6.0

- Added new RPGLE enhancements for Fall 2021 (up to 7.3 TR11 and 7.4 TR5). Big thanks to [@chrjorgensen](https://github.com/chrjorgensen)!

### 0.5.9

- Add Online Help Panel Group (PNLGRP) syntax highlighting, thanks [@chrjorgensen](https://github.com/chrjorgensen)

### 0.5.8

- Add CMD syntax highlighting, thanks [@chrjorgensen](https://github.com/chrjorgensen)
- Fix RPGLE fixed format gutter breaking syntax highlighting [60](https://github.com/barrettotte/vscode-ibmi-languages/issues/60)
- Fix RPGLE fixed format ```/EJECT``` precompiler comment highlighting [72](https://github.com/barrettotte/vscode-ibmi-languages/issues/72)

### 0.5.7

- Fix ```in``` keyword in RPGLE [69](https://github.com/barrettotte/vscode-ibmi-languages/issues/69)

### 0.5.6

- Add new RPGLE keywords for Fall 2020 7.3/7.4 PTFS [57](https://github.com/barrettotte/vscode-ibmi-languages/issues/57)
- Add "bracket-matching" to RPG and RPGLE [61](https://github.com/barrettotte/vscode-ibmi-languages/issues/61)
- Add quick comment toggling to RPGLE, CL, and MI [67](https://github.com/barrettotte/vscode-ibmi-languages/issues/67)
- Fix RPG, RPGLE, and DDS "gutters" [52](https://github.com/barrettotte/vscode-ibmi-languages/issues/52), [60](https://github.com/barrettotte/vscode-ibmi-languages/issues/60)
- Fix some syntax highlighting issues for MI [58](https://github.com/barrettotte/vscode-ibmi-languages/issues/58)
- Fix embedded SQL highlighting in fixed-format RPGLE [59](https://github.com/barrettotte/vscode-ibmi-languages/issues/59)
- Fix RPGLE for loop syntax highlighting [63](https://github.com/barrettotte/vscode-ibmi-languages/issues/63)
- Fix embedded SQL highlighting in mixed-format RPGLE [66](https://github.com/barrettotte/vscode-ibmi-languages/issues/66)

### 0.5.5

- Fix bug with ```*n``` in RPGLE prototypes [41](https://github.com/barrettotte/vscode-ibmi-languages/issues/41)
- Fix bug with RPGLE I spec highlighting [48](https://github.com/barrettotte/vscode-ibmi-languages/issues/48)
- Add missing ```to``` keyword in RPGLE [49](https://github.com/barrettotte/vscode-ibmi-languages/issues/49)
- Add DB2 SQL grammar for embedded SQL [54](https://github.com/barrettotte/vscode-ibmi-languages/issues/54)
- Fix bug with RPGLE style comment in embedded SQL [55](https://github.com/barrettotte/vscode-ibmi-languages/issues/55)

### 0.5.4

- Add binder language support [43](https://github.com/barrettotte/vscode-ibmi-languages/issues/43)
- Fix bug with RPG C spec comments [40](https://github.com/barrettotte/vscode-ibmi-languages/issues/40)
- Fix bug with RPGLE ```/if``` [33](https://github.com/barrettotte/vscode-ibmi-languages/issues/33)
- Fix bug with RPGLE hex literals [42](https://github.com/barrettotte/vscode-ibmi-languages/issues/42)
- Fix bug with SQLRPGLE SQL style comment at end of statement [38](https://github.com/barrettotte/vscode-ibmi-languages/issues/38)
- Fix bug with RPG compile time arrays [44](https://github.com/barrettotte/vscode-ibmi-languages/issues/44)
- Fix bug with RPGLE compile time arrays [46](https://github.com/barrettotte/vscode-ibmi-languages/issues/46)
- Fix bug with fixed format RPGLE and RPG comments [45](https://github.com/barrettotte/vscode-ibmi-languages/issues/45)

### 0.5.3

- Fix bug with embedded SQL comments [30](https://github.com/barrettotte/vscode-ibmi-languages/issues/30)
- Fix bug with fixed format RPGLE comments in RPGLE free [29](https://github.com/barrettotte/vscode-ibmi-languages/issues/29)
- Fix bug with RPGLE fixed format comments [34](https://github.com/barrettotte/vscode-ibmi-languages/issues/34)
- Fix bug with physical file highlighting [36](https://github.com/barrettotte/vscode-ibmi-languages/issues/36)
- Fix bug with display file highlighting [35](https://github.com/barrettotte/vscode-ibmi-languages/issues/35)
- Fix bug with RPGLE ```ENDFOR``` highlighting [32](https://github.com/barrettotte/vscode-ibmi-languages/issues/32)
- Add '#' to identifier regex [31](https://github.com/barrettotte/vscode-ibmi-languages/issues/31)

### 0.5.2

- Fix bug with RPG fixed format [24](https://github.com/barrettotte/vscode-ibmi-languages/issues/24)
- Fix bug with multiline strings in DDS [26](https://github.com/barrettotte/vscode-ibmi-languages/issues/26)
- Fix bug with highlighting ```*ON, *OFF``` [25](https://github.com/barrettotte/vscode-ibmi-languages/issues/25)
- Add '#' to embedded SQL identifier regex [27](https://github.com/barrettotte/vscode-ibmi-languages/issues/27)
- Improve highlighting for RPGLE all free [23](https://github.com/barrettotte/vscode-ibmi-languages/issues/23)

### 0.5.1

- Fix bug with RPGLE full free highlighting [19](https://github.com/barrettotte/vscode-ibmi-languages/issues/19)
- Fix bug with RPGLE free precompiler statements [15](https://github.com/barrettotte/vscode-ibmi-languages/issues/15)
- Fix bug with RPGLE free inline comments [20](https://github.com/barrettotte/vscode-ibmi-languages/issues/20)
- Fix bug with MI label definition highlighting [13](https://github.com/barrettotte/vscode-ibmi-languages/issues/13)
- Add ```CMP``` value highlighting to DSPF and LF [14](https://github.com/barrettotte/vscode-ibmi-languages/issues/14)
- Fix bug with ```H/``` in RPGLE and RPG [17](https://github.com/barrettotte/vscode-ibmi-languages/issues/17)
- Fix bug with RPGLE fixed format comments [18](https://github.com/barrettotte/vscode-ibmi-languages/issues/18)

### 0.5.0 - CL Label Highlighting, DSPF constants, and misc RPGLE fixes

- Extension icon and README fixes
- RPG/400: Change precompiler commands to highlight as keywords
- RPGLE: Change precompiler commands to highlight as keywords
- RPGLE: False definition keyword highlighting fixed -> more robust regex
- RPGLE: Fixed up precompiler conditionals /IF,/ELSEIF,/ELSE,/ENDIF
- CL: Label definition highlighting
- DSPF: DSPF parms highlighted as constants for COMP, DSPATR, CHECK, and COLOR
- DSPF: Tokens starting with '*' now highlighted as constants 

### 0.4.0 - RPGLE Fixed and Free Format with Embedded SQL

- RPGLE: Added fixed format highlighting
- RPGLE: Added free format highlighting
- RPGLE: Added basic embedded SQL highlighting
- RPG/400: Added basic embedded SQL highlighting
- RPG/400: Fixed a handful of highlighting errors I missed

## 0.3.0 - DSPF, ICFF, basic MI, and more fixes

- Misc regular expression fixes for RPG/400 and CL
- Display and ICF DDS file highlighting
- Basic Machine Interface (MI) highlighting

### 0.2.0 - Physical/Logical files and misc fixes

- Logical and physical file highlighting
- Misc regular expression fixes to RPG/400

### 0.1.0 - Base extension

- Base RPG/400 and CL highlighting
