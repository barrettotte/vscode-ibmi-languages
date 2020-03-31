# vscode-ibmi-languages

Somewhat decent syntax highlighting for IBMi languages such as RPG, CL, DDS, MI, and RPGLE fixed/free.


![Visual Studio Marketplace Version](https://img.shields.io/visual-studio-marketplace/v/barrettotte.ibmi-languages.svg)
![Visual Studio Marketplace Downloads](https://img.shields.io/visual-studio-marketplace/d/barrettotte.ibmi-languages.svg)
![Visual Studio Marketplace Rating](https://img.shields.io/visual-studio-marketplace/r/barrettotte.ibmi-languages.svg)
![GitHub](https://img.shields.io/github/license/barrettotte/vscode-ibmi-languages.svg)


I made this extension because I do a lot more reading than writing with IBMi languages at work and I always have VS Code open.
I also wanted to learn how to make a simple language extension for VS Code and get better with regular expressions.

I respect the legacy of the green screen, but sometimes I need some syntax highlighting in my life; my brain is too small.
Pretty much all I did was crawl through various IBM documentation on my lunch breaks and throw some regular expressions in here when I got the chance.
The regex I made probably isn't too efficient and it does mess up sometimes, but I think it works for like 75% of cases.

I wanted to add a lot of legacy syntax highlighting because I am always fascinated by old code.
For fixed format RPG(LE), I had SEU pulled up and wrote regex to match based on column positions and format specification.

By all means, I probably got a couple things wrong; submit a pull request if you see something please!
(That goes for anything in here)

Since I've made the basics for this extension I've used it every day at work and its probably one of the most useful things I've made for myself (not saying a lot).
I hope to eventually use this as part of the "frontend" for my IBMi editor API I've been working on.


## Inspiration
This extension was inspired and derived from an existing RPG extension https://github.com/NielsLiisberg/RPG-for-VSCode .
Without this brilliant guy, I wouldn't have thought to start working on this.
Also check out his repository https://github.com/NielsLiisberg/RPG-vsCode-Getting-Started for an introduction to an RPG + VS Code workflow.


## Features
- [x] Syntax highlighting for RPG III and RPG/400 - H,F,E,L,I,C,O specs
- [x] Syntax highlighting for Control Language (CL)
- [x] Syntax highlighting for DDS files - physical, logical, display, printer, and ICF
- [x] Syntax highlighting for some Machine Interface (MI) - **see below**
- [x] Syntax highlighting for RPGLE fixed - H,F,D,I,C,O,P specs
- [x] Syntax highlighting for RPGLE free
- [x] Syntax highlighting for embedded SQL in SQLRPG and SQLRPGLE
- [x] Support for a mix of RPGLE free and fixed format


**If anyone stumbles across this and has any awesome material for machine interface, please send me an email.**
I really only made the bare basics for MI and I'd love to add to it


## Stretch Features
Every side project starts out fun, but later becomes stale, we'll see if I get here.
- [ ] Syntax highlighting for embedded SQL using actual DB2 grammar


## File Types (case insensitive)
Generally I lumped legacy file types together out of convenience.
If you want different syntax highlighting for a CLP vs CLLE file, I'm sorry to disappoint you.

| Extension(s)                  | Description        |
| ----------------------------- | ------------------ |
| .cl, .clp, .clp38 .clle       | Control Language   |
| .dspf, .dspf38                | DDS Display file   |
| .icff                         | DDS ICF file       |
| .lf, .lf38                    | DDS Logical file   |
| .pf, .pf38, .dds              | DDS Physical file  |
| .prtf, .prtf38                | DDS Printer file   |
| .rpg, .rpg38, .sqlrpg         | RPG/400            |
| .rpgle, .sqlrpgle             | RPGLE and SQLRPGLE |


## Screenshots
See **screenshots/** for more examples of syntax highlighting.


#### RPG/400
![RPG/400](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/rpg400.png)


#### RPGLE Fixed Format
![RPGLE Fixed](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/rpglefixed.PNG)


#### RPGLE Free Format
![RPGLE Free](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/rpglefree.PNG)


#### RPGLE Free with Embedded SQL
![SQLRPGLE](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/sqlrpgle.PNG)


#### Control Language (CL)
![CL](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/cl.png)


#### Data Description Specification - Physical File (DDS)
![PF](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/pf.PNG)


#### Machine Interface (MI)
![MI](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/mi.PNG)


## Publishing
* ```npm install -g vsce```
* ```vsce package```
* ```vsce publish```


## Changelog

#### 0.1.0 - Base extension
* Base RPG/400 and CL highlighting


#### 0.2.0 - Physical/Logical files and misc fixes
* Logical and physical file highlighting
* Misc regular expression fixes to RPG/400


#### 0.3.0 - DSPF, ICFF, basic MI, and more fixes
* Misc regular expression fixes for RPG/400 and CL
* Display and ICF DDS file highlighting
* Basic Machine Interface (MI) highlighting


#### 0.4.0 - RPGLE Fixed and Free Format with Embedded SQL
* RPGLE: Added fixed format highlighting
* RPGLE: Added free format highlighting
* RPGLE: Added basic embedded SQL highlighting
* RPG/400: Added basic embedded SQL highlighting
* RPG/400: Fixed a handful of highlighting errors I missed


#### 0.5.0 - CL Label Highlighting, DSPF constants, and misc RPGLE fixes
* Extension icon and README fixes
* RPG/400: Change precompiler commands to highlight as keywords
* RPGLE: Change precompiler commands to highlight as keywords
* RPGLE: False definition keyword highlighting fixed -> more robust regex
* RPGLE: Fixed up precompiler conditionals /IF,/ELSEIF,/ELSE,/ENDIF
* CL: Label definition highlighting
* DSPF: DSPF parms highlighted as constants for COMP, DSPATR, CHECK, and COLOR
* DSPF: Tokens starting with '*' now highlighted as constants 


## Known Bugs / Future Improvements
See [issues](https://github.com/barrettotte/vscode-ibmi-languages/issues).
**Please add any features you would like to see and I'll see if I can get around to implementing them!**


## References
* Liam's Flight400 project (great for testing) - https://github.com/worksofliam/flight400
* RPG/400 - https://www.ibm.com/support/knowledgecenter/SSAE4W_9.6.0/com.ibm.etools.iseries.langref.doc/evferlsh02.htm#ToC
* RPG for VS Code - https://github.com/NielsLiisberg/RPG-for-VSCode
* RPG II, RPG III, and RPG/400 - https://isbnsearch.org/isbn/0878352465
* Textmate
  * Dart syntax example - https://github.com/Dart-Code/Dart-Code/blob/master/syntaxes/dart.json
  * Naming Conventions - https://macromates.com/manual/en/language_grammars#naming_conventions
  * TextMate Grammar - https://www.apeth.com/nonblog/stories/textmatebundle.html
  * https://stackoverflow.com/questions/23463803/are-there-any-standards-for-tmlanguage-keyword-types
* Regex tool - https://regexr.com/
* VS Code Language extensions - https://code.visualstudio.com/api/language-extensions/overview
