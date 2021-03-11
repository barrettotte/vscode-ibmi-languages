# vscode-ibmi-languages

Somewhat decent syntax highlighting for IBMi languages such as RPG, CL, DDS, MI, and RPGLE fixed/free.

**Please consider downloading [code-for-ibmi](https://github.com/halcyon-tech/code-for-ibmi) to edit RPG, RPGLE, and CL directly in VS Code!**

Pretty much all I did was crawl through various IBM documentation on my lunch breaks and throw some regular expressions in here when I got the chance.
The regex I made probably isn't too efficient and it does mess up sometimes, but I think it works for like 90% of cases I've come across.

By all means, I probably got a couple things wrong; submit a pull request or issue if you see something please!
(That goes for anything in here)


## Contributors

* [@barrettotte](https://github.com/barrettotte)
* [@worksofliam](https://github.com/worksofliam)
* [@chrjorgensen](https://github.com/chrjorgensen)


## Features
Last updated for Fall 2020: PTF enhancements for 7.3 and 7.4

- [x] Syntax highlighting for RPG III and RPG/400 - H,F,E,L,I,C,O specs
- [x] Syntax highlighting for Control Language (CL)
- [x] Syntax highlighting for Command Definition (CMD)
- [x] Syntax highlighting for DDS files - physical, logical, display, printer, and ICF
- [x] Syntax highlighting for some Machine Interface (MI) - **see below**
- [x] Syntax highlighting for RPGLE fixed - H,F,D,I,C,O,P specs
- [x] Syntax highlighting for RPGLE free
- [x] Syntax highlighting for embedded SQL in SQLRPG and SQLRPGLE
- [x] Support for a mix of RPGLE free and fixed format
- [x] Support for binder language
- [x] Support for DB2 SQL keywords in embedded SQL

**If anyone stumbles across this and has any awesome material for machine interface, please send me an email.**
I really only made the bare basics for MI and I'd love to add to it


## File Types (case insensitive)
For each source type, I lumped legacy(system/38) source types together with the regular source types.

| Extension(s)                  | Description        |
| ----------------------------- | ------------------ |
| .cl, .clp, .clp38 .clle       | Control Language (CL) |
| .dspf, .dspf38                | DDS Display file   |
| .icff                         | DDS ICF file       |
| .lf, .lf38                    | DDS Logical file   |
| .pf, .pf38, .dds              | DDS Physical file  |
| .prtf, .prtf38                | DDS Printer file   |
| .rpg, .rpg38, .sqlrpg         | RPG/400            |
| .rpgle, .sqlrpgle             | RPGLE and SQLRPGLE |
| .bnd                          | Binder Language    |
| .mi                           | Machine Interface (MI) |


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


## Featured In
- https://www.itjungle.com/2020/12/09/vs-code-provides-another-coding-option-for-ibm-i/
- https://www.anandk.dev/2020/11/VSCode-IBMi-AS400.html
- https://github.com/halcyon-tech/code-for-ibmi


## References
- Derived from an [existing RPG extension](https://github.com/NielsLiisberg/RPG-for-VSCode)
- [Repo used to test older RPG](https://github.com/worksofliam/flight400)
- [RPG/400](https://www.ibm.com/support/knowledgecenter/SSAE4W_9.6.0/com.ibm.etools.iseries.langref.doc/evferlsh02.htm#ToC)
- [RPG II, RPG III, and RPG/400](https://isbnsearch.org/isbn/0878352465)
- [Regex tool](https://regexr.com/)
- [VS Code Language extensions](https://code.visualstudio.com/api/language-extensions/overview)
