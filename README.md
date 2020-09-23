# vscode-ibmi-languages

Somewhat decent syntax highlighting for IBMi languages such as RPG, CL, DDS, MI, and RPGLE fixed/free.


![Visual Studio Marketplace Version](https://img.shields.io/visual-studio-marketplace/v/barrettotte.ibmi-languages.svg)
![Visual Studio Marketplace Downloads](https://img.shields.io/visual-studio-marketplace/d/barrettotte.ibmi-languages.svg)
![Visual Studio Marketplace Rating](https://img.shields.io/visual-studio-marketplace/r/barrettotte.ibmi-languages.svg)
![GitHub](https://img.shields.io/github/license/barrettotte/vscode-ibmi-languages.svg)


I made this extension because I do a lot more reading than writing with IBMi languages at work and I always have VS Code open.
I also wanted to learn how to make a simple language extension for VS Code and get better with regular expressions.

Pretty much all I did was crawl through various IBM documentation on my lunch breaks and throw some regular expressions in here when I got the chance.
The regex I made probably isn't too efficient and it does mess up sometimes, but I think it works for like 90% of cases I've come across.

By all means, I probably got a couple things wrong; submit a pull request or issue if you see something please!
(That goes for anything in here)


## Development in VS Code
This extension is really only useful for reading code, not writing. See [Issue 50](https://github.com/barrettotte/vscode-ibmi-languages/issues/50) for more details.

Also check out https://github.com/NielsLiisberg/RPG-vsCode-Getting-Started for an introduction to an RPG + VS Code workflow.


## Features
- [x] Syntax highlighting for RPG III and RPG/400 - H,F,E,L,I,C,O specs
- [x] Syntax highlighting for Control Language (CL)
- [x] Syntax highlighting for DDS files - physical, logical, display, printer, and ICF
- [x] Syntax highlighting for some Machine Interface (MI) - **see below**
- [x] Syntax highlighting for RPGLE fixed - H,F,D,I,C,O,P specs
- [x] Syntax highlighting for RPGLE free
- [x] Syntax highlighting for embedded SQL in SQLRPG and SQLRPGLE
- [x] Support for a mix of RPGLE free and fixed format
- [x] Support for binder language
- [ ] Support for actual DB2 SQL in embedded SQL (currently using generic SQL grammar)


**If anyone stumbles across this and has any awesome material for machine interface, please send me an email.**
I really only made the bare basics for MI and I'd love to add to it



## File Types (case insensitive)
For each source type, I lumped legacy(system/38) source types together with the regular source types.

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
| .bnd                          | Binder Language    |


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
See [CHANGELOG.md](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/CHANGELOG.md)


## Known Bugs / Future Improvements
See [issues](https://github.com/barrettotte/vscode-ibmi-languages/issues).


## References
- Derived from an existing RPG extension https://github.com/NielsLiisberg/RPG-for-VSCode
- Liam's Flight400 project (great for testing) - https://github.com/worksofliam/flight400
- RPG/400 - https://www.ibm.com/support/knowledgecenter/SSAE4W_9.6.0/com.ibm.etools.iseries.langref.doc/evferlsh02.htm#ToC
- RPG for VS Code - https://github.com/NielsLiisberg/RPG-for-VSCode
- RPG II, RPG III, and RPG/400 - https://isbnsearch.org/isbn/0878352465
- Textmate
  - Dart syntax example - https://github.com/Dart-Code/Dart-Code/blob/master/syntaxes/dart.json
  - Naming Conventions - https://macromates.com/manual/en/language_grammars#naming_conventions
  - TextMate Grammar - https://www.apeth.com/nonblog/stories/textmatebundle.html
  - https://stackoverflow.com/questions/23463803/are-there-any-standards-for-tmlanguage-keyword-types
- Regex tool - https://regexr.com/
- VS Code Language extensions - https://code.visualstudio.com/api/language-extensions/overview
