# vscode-ibmi-languages

Somewhat decent syntax highlighting for IBMi languages such as RPG, CL, DDS, and MI.

**WARNING**: The file extensions are probably pretty opinionated (read section below), I am fully open to pull requests.

I made this extension because I do a lot more reading than writing with IBMi languages and I always have VS Code open.
I also wanted to learn how to make a simple language extension for VS Code and get better with regular expressions.

I respect the legacy of the green screen, but sometimes I need some syntax highlighting in my life; my brain is too small.
Pretty much all I did was crawl through various IBM documentation on my lunch breaks and throw some regular expressions in here when I got the chance.
The regex I made isn't too great and probably messes up a good bit, but I think it works for like 75% of cases.

I wanted to add a lot of legacy syntax highlighting because I am fascinated by old code.
By all means, I probably got a couple things wrong; submit a pull request if you see something please!
(That goes for anything in here)


## Inspiration
This extension was inspired and derived from an existing RPG extension https://github.com/NielsLiisberg/RPG-for-VSCode .
Without this brilliant guy, I wouldn't have thought to start working on this.
Also check out his repository https://github.com/NielsLiisberg/RPG-vsCode-Getting-Started for an introduction to an RPG + VS Code workflow.


## Features
- [ ] Syntax highlighting for RPG II, RPG III, RPG/400
- [ ] Syntax highlighting for Control Language (CL) - CL/CLLE
- [ ] Syntax highlighting for RPGLE fixed/free
- [ ] Syntax highlighting for Machine Interface (MI)
- [ ] Syntax highlighting for physical and logical files


## Stretch Features
Every side project starts out fun, but later becomes stale, we'll see if I get here.

- [ ] Syntax highlighting for display files (.dspf)
- [ ] Syntax highlighting for printer files (.prtf)
- [ ] Syntax highlighting for cmd ? I dont know...maybe as an optional language


## File Types (case insensitive)
Generally I lumped legacy file types together out of convenience.
If you want different syntax highlighting for a CL vs CLLE file, you've come to the wrong place.

| Extension(s)      | Description                |
| ----------------- | -------------------------- |
| .cl, .clp, .clle  | Control Language           |
| .cmd              | Command                    |
| .dspf             | DDS Display file           |
| .lf               | DDS Logical file           |
| .pf, .dds         | DDS Physical file          |
| .prtf             | DDS Printer file           |
| .rpg, .sqlrpg     | RPG II + RPG III + RPG/400 |
| .rpgle, .sqlrpgle | RPGLE and SQLRPGLE         |


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


## Known Issues

Calling out known issues can help limit users opening duplicate issues against your extension.

## Release Notes
See CHANGELOG.md
