# invoke-psscriptanalyzer(1)

## Name

`invoke-psscriptanalyzer` - prueft getrackte PowerShell-Dateien statisch

*statically analyzes tracked PowerShell files*

## Synopsis

```powershell
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1 [-RepositoryRoot PATH] [-Registry PATH] [-Settings PATH]
```

## Beschreibung / Description

Das Skript ermittelt mit `git ls-files` alle getrackten `.ps1`, `.psm1` und
`.psd1`-Dateien. Es importiert die in der Modul-Registry festgelegte
PSScriptAnalyzer-Version und verwendet die zentrale Regelkonfiguration. Jeder
nicht ausgeschlossene Error- oder Warning-Befund fuehrt zu Exitcode `1`.

*The script uses `git ls-files` to discover every tracked `.ps1`, `.psm1`, and
`.psd1` file. It imports the PSScriptAnalyzer version pinned in the module
registry and applies the central rule configuration. Every non-excluded Error
or Warning finding results in exit code `1`.*

Die ausgeschlossenen Regeln sind auf etablierte CLI-Ausgabe, UTF-8 ohne BOM,
stabile oeffentliche Funktionsnamen und vorhandene Preview-Semantik begrenzt.
Korrektheits- und Sicherheitsregeln bleiben aktiv.

*Excluded rules are limited to established CLI output, UTF-8 without BOM,
stable public function names, and existing preview semantics. Correctness and
security rules remain active.*

## Abschlusskriterien / Closeout Criteria

```powershell
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
```

Der Befehl meldet `OK` und beendet sich mit Exitcode `0`.

*The command reports `OK` and exits with code `0`.*
