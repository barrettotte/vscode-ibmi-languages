# vscode-ibmi-languages

Syntax highlighting for IBMi languages such as RPG, CL, DDS, MI, and RPGLE fixed/free.

**Please consider downloading [Code for IBM i](https://github.com/codefori/vscode-ibmi) to edit RPG, RPGLE, and CL directly in VS Code!**

There are probably a few syntax bugs left. Please open an issue or a pull request if you see something amiss.

## Contributors

* [@barrettotte](https://github.com/barrettotte)
* [@worksofliam](https://github.com/worksofliam)
* [@chrjorgensen](https://github.com/chrjorgensen)
* [@GajenderI](https://github.com/GajenderI)
* [@lildude](https://github.com/lildude)
* [@richardm90](https://github.com/richardm90)
* [@JH-JTBaldwin](https://github.com/JH-JTBaldwin)

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

Last updated to **July 2026 PTF enhancements for 7.6 and 7.5**

## File Types (case insensitive)

For each source type, I lumped legacy (system/38) source types together with the regular source types.

| Extension(s)                  | Description        |
| ----------------------------- | ------------------ |
| .cl, .clp, .clp38, .clle      | Control Language (CL) |
| .cmd                          | Command Definition (CMD) |
| .pnlgrp                       | UIM Panel Group (PNLGRP) |
| .dspf, .dspf38                | DDS Display file   |
| .icff                         | DDS ICF file       |
| .lf, .lf38                    | DDS Logical file   |
| .pf, .pf38, .dds              | DDS Physical file  |
| .prtf, .prtf38                | DDS Printer file   |
| .rpg, .rpg38, .sqlrpg         | RPG/400            |
| .rpgle, .rpgleinc, .sqlrpgle  | RPGLE and SQLRPGLE |
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

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to build, test and change a
grammar, and [tests/README.md](tests/README.md) for how the snapshot tests
work.

```bash
npm ci
npm test              # tokenize every fixture, compare against its snapshot
npm run lint          # repository checks
npm run format:check  # prettier
```

## Hints & Tips

### tmLanguage Scope Names

The colours used in VS Code are determined by the scope names assigned in the
relevant tmLanguage file, which are then mapped to colors by the active colours
theme.

To see the actual scope at a cursor position:

1. Place your cursor on the word (e.g. TIME)
1. Press Ctrl+Shift+P (or Cmd+Shift+P on Mac)
1. Type and select: Developer: Inspect Editor Tokens and Scopes
1. This shows you the exact scope name and the colours applied by your theme

## Releasing

Publishing a GitHub release packages the extension and publishes it to the
VS Code Marketplace and to [Open VSX](https://open-vsx.org/extension/barrettotte/ibmi-languages). 
See [docs/RELEASING.md](docs/RELEASING.md).

## Changelog

See [CHANGELOG.md](https://github.com/barrettotte/vscode-ibmi-languages/blob/master/CHANGELOG.md)

## Known Bugs / Future Improvements

See [issues](https://github.com/barrettotte/vscode-ibmi-languages/issues).

## References

### IBM language references

The grammars are built from these. Each is the authoritative keyword and
positional reference for one of the languages this extension highlights. The PDF
editions are linked because they are complete in one file and can be searched
offline, which is how the keyword lists are checked for omissions.

| Language | IBM reference (7.5) |
| -------- | ------------------- |
| DDS physical and logical files (`.dds`, `.pf`, `.pf38`, `.lf`, `.lf38`) | [DDS for physical and logical files](https://www.ibm.com/docs/en/i/7.5?topic=files-dds-physical-logical) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzakb/rzakbpdf.pdf) |
| DDS display files (`.dspf`, `.dspf38`) | [DDS for display files](https://www.ibm.com/docs/en/i/7.5?topic=files-dds-display) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzakc/rzakcpdf.pdf) |
| DDS printer files (`.prtf`, `.prtf38`) | [DDS for printer files](https://www.ibm.com/docs/en/i/7.5?topic=files-dds-printer) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzakd/rzakdpdf.pdf) |
| DDS ICF files (`.icff`) | [DDS for ICF files](https://www.ibm.com/docs/en/i/7.5?topic=files-dds-icf) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzake/rzakepdf.pdf) |
| DDS concepts (all DDS types) | [DDS concepts](https://www.ibm.com/docs/en/i/7.5?topic=dds-concepts) |
| Binder language (`.bnd`) | [Binder language](https://www.ibm.com/docs/en/i/7.5?topic=concepts-binder-language) &middot; [ILE Concepts PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/ilec/sc415606.pdf) |
| Control Language (`.cl`, `.clle`, `.clp`, `.clp38`) | [CL overview and concepts](https://www.ibm.com/docs/en/i/7.5?topic=programming-control-language) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rbam6/rbam6pdf.pdf) &middot; [CL commands](https://www.ibm.com/docs/en/i/7.5?topic=concepts-cl-commands) |
| Command definition (`.cmd`) | [Command definition statements](https://www.ibm.com/docs/en/i/7.5?topic=programming-control-language) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rbam6/rbam6pdf.pdf) |
| Machine Interface (`.mi`) | [Machine interface instructions](https://www.ibm.com/docs/en/i/7.5?topic=programming-machine-interface-instructions) &middot; [Machine Interface introduction](https://www.ibm.com/docs/en/i/7.5?topic=interface-machine-introduction) |
| ILE RPG (`.rpgle`, `.rpgleinc`) | [ILE RPG Reference](https://www.ibm.com/docs/en/i/7.5?topic=rpg-ile-reference) (SC09-2508) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzasd/sc092508.pdf) &middot; [Operation codes](https://www.ibm.com/docs/ssw_ibm_i_75/rzasd/opcode.htm), whose first table is the set free-form accepts and whose second is the traditional syntax |
| Embedded SQL in ILE RPG (`.sqlrpgle`) | [Embedding SQL statements in ILE RPG applications](https://www.ibm.com/docs/en/i/7.5.0?topic=cssiira-embedding-sql-statements-in-ile-rpg-applications-that-use-sql) &middot; [Embedded SQL programming PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/pdf/rzajppdf.pdf) |
| SQL, all embedded dialects | [Db2 for i SQL reference](https://www.ibm.com/docs/en/i/7.5?topic=reference-sql) &middot; [PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/pdf/rbafzpdf.pdf) &middot; [Reserved words](https://www.ibm.com/docs/ssw_ibm_i_75/db2/rbafzwordsre.htm), whose Table 1 is the keyword list the SQL rules match |
| UIM panel groups (`.pnlgrp`) | Application Display Programming SC41-5715, appendix A, which holds the UIM tag reference. IBM stopped publishing it after V6R1 and it has no topic on IBM Documentation, so the manual itself is the citation: [V6R1 PDF](https://public.dhe.ibm.com/systems/power/docs/systemi/v6r1/en_US/sc415715.pdf) |
| RPG/400 (`.rpg`, `.rpg38`) | RPG/400 Reference (SC09-1817). IBM no longer hosts this book; its own [related information](https://www.ibm.com/docs/en/i/7.5?topic=esp-related-information) page points at the Publications Center. Mirrors: [RPG400 Reference.pdf](https://jss-grp.com/attachfile/RPG400%20Reference.pdf) (text extracts cleanly, so it is the one to search) &middot; [archived copy](https://www.dropbox.com/s/tuy7qdkf3kwsibw/rpg400_reference.pdf?dl=0). For the operations RPG IV inherited, see the [ILE RPG Reference PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/rzasd/sc092508.pdf) |
| RPG/400 User's Guide (`.rpg`, `.rpg38`) | RPG/400 User's Guide (SC09-1816), also unhosted; [mirror](http://astradyne.net/manuals/im020305.pdf) |
| Embedded SQL in RPG/400 (`.sqlrpg`) | [Embedding SQL statements in RPG/400 applications](https://www.ibm.com/docs/en/i/7.5.0?topic=cssira-embedding-sql-statements-in-rpg400-applications-that-use-sql) &middot; [Embedded SQL programming PDF](https://www.ibm.com/docs/en/ssw_ibm_i_75/pdf/rzajppdf.pdf) |
| RPG II, RPG III background | [RPG II, RPG III, and RPG/400](https://isbnsearch.org/isbn/0878352465) |

### Other

* Derived from an [existing RPG extension](https://github.com/NielsLiisberg/RPG-for-VSCode)
* [Repo used to test older RPG](https://github.com/worksofliam/flight400)
* [Regex tool](https://regexr.com/)
* [VS Code Language extensions](https://code.visualstudio.com/api/language-extensions/overview)

