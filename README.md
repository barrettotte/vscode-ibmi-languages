# vscode-ibmi-languages

Somewhat decent syntax highlighting for IBMi languages such as RPG, CL, DDS, MI, and RPGLE fixed/free.

**WARNING**: The file extensions are probably pretty opinionated (read section below), I am fully open to pull requests.

I made this extension because I do a lot more reading than writing with IBMi languages and I always have VS Code open.
I also wanted to learn how to make a simple language extension for VS Code and get better with regular expressions.

I respect the legacy of the green screen, but sometimes I need some syntax highlighting in my life; my brain is too small.
Pretty much all I did was crawl through various IBM documentation on my lunch breaks and throw some regular expressions in here when I got the chance.
The regex I made probably isn't too efficient and it does mess up sometimes, but I think it works for like 75% of cases.

I wanted to add a lot of legacy syntax highlighting because I am always fascinated by old code.
For fixed format RPG, I had SEU pulled up and wrote regex to match based on column positions and format specification.

By all means, I probably got a couple things wrong; submit a pull request if you see something please!
(That goes for anything in here)


## Inspiration
This extension was inspired and derived from an existing RPG extension https://github.com/NielsLiisberg/RPG-for-VSCode .
Without this brilliant guy, I wouldn't have thought to start working on this.
Also check out his repository https://github.com/NielsLiisberg/RPG-vsCode-Getting-Started for an introduction to an RPG + VS Code workflow.


## Features

- [x] Syntax highlighting for RPG III and RPG/400 - H,F,E,L,I,C,O specs
- [x] Syntax highlighting for Control Language (CL)
- [x] Syntax highlighting for DDS files - physical, logical, display, printer, and ICF
- [x] Syntax highlighting for some Machine Interface (MI) - **see below**
- [ ] Syntax highlighting for RPGLE fixed - H,F,D,I,C,O,P specs
- [ ] Syntax highlighting for RPGLE free


**If anyone stumbles across this and has any awesome material for machine interface, please send me an email.**
I really only made the bare basics for MI and I'd love to add to it


## Stretch Features
Every side project starts out fun, but later becomes stale, we'll see if I get here.
- [ ] Syntax highlighting for embedded SQL


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
[![RPG/400](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/rpg400.png)](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/rpg400.png)


#### Control Language (CL)
[![CL](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/cl.png)](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/cl.png)


#### Data Description Specification - Physical File (DDS)
[![PF](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/pf.PNG)](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/pf.PNG)


#### Machine Interface (MI)
[![MI](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/mi.PNG)](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/screenshots/mi.PNG)


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


## Known Bugs

#### RPG/400:
C Spec, EQ field extends to comment space if comment starts with numeric.

Suggested: regex for numeric literal highlighting to not extend past column 60
```     
     C           PCVKEY    SETLLCP1107C                  8585=1 <==> FD
```


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
* Regex tool - https://rubular.com/
* VS Code Language extensions - https://code.visualstudio.com/api/language-extensions/overview
