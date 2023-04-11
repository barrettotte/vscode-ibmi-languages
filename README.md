# vscode-ibmi-languages

Syntax highlighting for IBMi languages such as RPG, CL, DDS, MI, and RPGLE fixed/free.

**Please consider downloading [code-for-ibmi](https://github.com/halcyon-tech/code-for-ibmi) to edit RPG, RPGLE, and CL directly in VS Code!**

There's probably a few syntax bugs. Please submit a pull request or issue if you see something amiss.

## Contributors

* [@barrettotte](https://github.com/barrettotte)
* [@worksofliam](https://github.com/worksofliam)
* [@chrjorgensen](https://github.com/chrjorgensen)

## Features

* Syntax highlighting for RPG III and RPG/400 - H,F,E,L,I,C,O specs
* Syntax highlighting for Control Language (CL)
* Syntax highlighting for Command Definition (CMD)
* Syntax highlighting for UIM Panel Group (PNLGRP)
* Syntax highlighting for DDS files - physical, logical, display, printer, and ICF
* Syntax highlighting for Machine Interface (MI)
* Syntax highlighting for RPGLE fixed - H,F,D,I,C,O,P specs
* Syntax highlighting for RPGLE free
* Syntax highlighting for embedded SQL in SQLRPG and SQLRPGLE
* Support for a mix of RPGLE free and fixed format
* Support for binder language
* Support for DB2 SQL keywords in embedded SQL

Last updated to **Spring 2023: PTF Enhancements for 7.4 and 7.5**

## File Types (case insensitive)

For each source type, I lumped legacy (system/38) source types together with the regular source types.

| Extension(s)                  | Description        |
| ----------------------------- | ------------------ |
| .cl, .clp, .clp38 .clle       | Control Language (CL) |
| .cmd                          | Command Definition (CMD) |
| .pnlgrp                       | UIM Panel Group (PNLGRP) |
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

### RPG/400

![RPG/400](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/rpg400.png)

### RPGLE Fixed Format

![RPGLE Fixed](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/rpglefixed.PNG)

### RPGLE Free Format

![RPGLE Free](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/rpglefree.PNG)

### RPGLE Free with Embedded SQL

![SQLRPGLE](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/sqlrpgle.PNG)

### Control Language (CL)

![CL](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/cl.png)

### Command (CMD)

![CL](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/cmd.png)

### UIM Panel Group (PNLGRP)

![CL](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/pnlgrp.png)

### Data Description Specification - Physical File (DDS)

![PF](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/pf.PNG)

### Machine Interface (MI)

![MI](https://raw.githubusercontent.com/barrettotte/vscode-ibmi-languages/master/screenshots/mi.PNG)

## Publishing

### VS Code Marketplace

* `npm install -g vsce`
* `vsce package`
* `vsce publish -p VSCE_SECRET`

### OpenVSX

This extension is also deployed to [Open VSX](https://open-vsx.org/extension/barrettotte/ibmi-languages)

* `npx ovsx publish -p OPEN_VSX_SECRET`

## Changelog

See [CHANGELOG.md](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/CHANGELOG.md)

## Known Bugs / Future Improvements

See [issues](https://github.com/barrettotte/vscode-ibmi-languages/issues).

## Featured In

* <https://www.itjungle.com/2020/12/09/vs-code-provides-another-coding-option-for-ibm-i/>
* <https://www.anandk.dev/2020/11/VSCode-IBMi-AS400.html>
* <https://github.com/halcyon-tech/code-for-ibmi>

## References

* Derived from an [existing RPG extension](https://github.com/NielsLiisberg/RPG-for-VSCode)
* [Repo used to test older RPG](https://github.com/worksofliam/flight400)
* [RPG/400](https://www.ibm.com/support/knowledgecenter/SSAE4W_9.6.0/com.ibm.etools.iseries.langref.doc/evferlsh02.htm#ToC)
* [RPG II, RPG III, and RPG/400](https://isbnsearch.org/isbn/0878352465)
* [Regex tool](https://regexr.com/)
* [VS Code Language extensions](https://code.visualstudio.com/api/language-extensions/overview)
