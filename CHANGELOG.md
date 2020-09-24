# Changelog

---
### 0.5.5
- Fix bug with ```*n``` in RPGLE prototypes [41](https://github.com/barrettotte/vscode-ibmi-languages/issues/41)
- Fix bug with RPGLE I spec highlighting [48](https://github.com/barrettotte/vscode-ibmi-languages/issues/48)
- Add missing ```to``` keyword in RPGLE [49](https://github.com/barrettotte/vscode-ibmi-languages/issues/49)
- Add DB2 SQL grammar for embedded SQL [54](https://github.com/barrettotte/vscode-ibmi-languages/issues/54)
- Fix bug with RPGLE style comment in embedded SQL [55](https://github.com/barrettotte/vscode-ibmi-languages/issues/55)


---
### 0.5.4
- Add binder language support [43](https://github.com/barrettotte/vscode-ibmi-languages/issues/43)
- Fix bug with RPG C spec comments [40](https://github.com/barrettotte/vscode-ibmi-languages/issues/40)
- Fix bug with RPGLE ```/if``` [33](https://github.com/barrettotte/vscode-ibmi-languages/issues/33)
- Fix bug with RPGLE hex literals [42](https://github.com/barrettotte/vscode-ibmi-languages/issues/42)
- Fix bug with SQLRPGLE SQL style comment at end of statement [38](https://github.com/barrettotte/vscode-ibmi-languages/issues/38)
- Fix bug with RPG compile time arrays [44](https://github.com/barrettotte/vscode-ibmi-languages/issues/44)
- Fix bug with RPGLE compile time arrays [46](https://github.com/barrettotte/vscode-ibmi-languages/issues/46)
- Fix bug with fixed format RPGLE and RPG comments [45](https://github.com/barrettotte/vscode-ibmi-languages/issues/45)


---
### 0.5.3
- Fix bug with embedded SQL comments [30](https://github.com/barrettotte/vscode-ibmi-languages/issues/30)
- Fix bug with fixed format RPGLE comments in RPGLE free [29](https://github.com/barrettotte/vscode-ibmi-languages/issues/29)
- Fix bug with RPGLE fixed format comments [34](https://github.com/barrettotte/vscode-ibmi-languages/issues/34)
- Fix bug with physical file highlighting [36](https://github.com/barrettotte/vscode-ibmi-languages/issues/36)
- Fix bug with display file highlighting [35](https://github.com/barrettotte/vscode-ibmi-languages/issues/35)
- Fix bug with RPGLE ```ENDFOR``` highlighting [32](https://github.com/barrettotte/vscode-ibmi-languages/issues/32)
- Add '#' to identifier regex [31](https://github.com/barrettotte/vscode-ibmi-languages/issues/31)


---
### 0.5.2
- Fix bug with RPG fixed format [24](https://github.com/barrettotte/vscode-ibmi-languages/issues/24)
- Fix bug with multiline strings in DDS [26](https://github.com/barrettotte/vscode-ibmi-languages/issues/26)
- Fix bug with highlighting ```*ON, *OFF``` [25](https://github.com/barrettotte/vscode-ibmi-languages/issues/25)
- Add '#' to embedded SQL identifier regex [27](https://github.com/barrettotte/vscode-ibmi-languages/issues/27)
- Improve highlighting for RPGLE all free [23](https://github.com/barrettotte/vscode-ibmi-languages/issues/23)


---
### 0.5.1
- Fix bug with RPGLE full free highlighting [19](https://github.com/barrettotte/vscode-ibmi-languages/issues/19)
- Fix bug with RPGLE free precompiler statements [15](https://github.com/barrettotte/vscode-ibmi-languages/issues/15)
- Fix bug with RPGLE free inline comments [20](https://github.com/barrettotte/vscode-ibmi-languages/issues/20)
- Fix bug with MI label definition highlighting [13](https://github.com/barrettotte/vscode-ibmi-languages/issues/13)
- Add ```CMP``` value highlighting to DSPF and LF [14](https://github.com/barrettotte/vscode-ibmi-languages/issues/14)
- Fix bug with ```H/``` in RPGLE and RPG [17](https://github.com/barrettotte/vscode-ibmi-languages/issues/17)
- Fix bug with RPGLE fixed format comments [18](https://github.com/barrettotte/vscode-ibmi-languages/issues/18)


---
### 0.5.0 - CL Label Highlighting, DSPF constants, and misc RPGLE fixes
- Extension icon and README fixes
- RPG/400: Change precompiler commands to highlight as keywords
- RPGLE: Change precompiler commands to highlight as keywords
- RPGLE: False definition keyword highlighting fixed -> more robust regex
- RPGLE: Fixed up precompiler conditionals /IF,/ELSEIF,/ELSE,/ENDIF
- CL: Label definition highlighting
- DSPF: DSPF parms highlighted as constants for COMP, DSPATR, CHECK, and COLOR
- DSPF: Tokens starting with '*' now highlighted as constants 


---
### 0.4.0 - RPGLE Fixed and Free Format with Embedded SQL
- RPGLE: Added fixed format highlighting
- RPGLE: Added free format highlighting
- RPGLE: Added basic embedded SQL highlighting
- RPG/400: Added basic embedded SQL highlighting
- RPG/400: Fixed a handful of highlighting errors I missed


--
## 0.3.0 - DSPF, ICFF, basic MI, and more fixes
- Misc regular expression fixes for RPG/400 and CL
- Display and ICF DDS file highlighting
- Basic Machine Interface (MI) highlighting


---
### 0.2.0 - Physical/Logical files and misc fixes
- Logical and physical file highlighting
- Misc regular expression fixes to RPG/400


---
### 0.1.0 - Base extension
- Base RPG/400 and CL highlighting
