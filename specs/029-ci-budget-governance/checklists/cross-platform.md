# Plattformnachweis / Cross-Platform Evidence

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: Stage-A Implementation Reviewer
**Restrisiko / Residual risk**: Native Linux- und Windows-Runs sind in Stage A nicht ausgeführt; portable Fixtures belegen nur die Semantik.
**Follow-up**: Native Plattformtokens nur nach tatsächlicher Ausführung ergänzen.
**Re-Evaluation**: Bei Wrapper-, Runtime-, Shell- oder Plattformänderungen.

## Nachweise / Evidence

- Designschema-Preflight: Pass — alle vier Designverträge wurden mit
  `python3 -m json.tool` aus der Repositorywurzel geparst.
- macOS Bash: Pass — `bash -n` und realer `--ci-gate --dry-run`-Aufruf mit
  Exitcode `0`, genau einem Engine-Prozess und ohne Evidence-Datei.
- macOS PowerShell 7: Pass — realer `-CiGate -WhatIf`-Aufruf mit unmittelbarer
  `$LASTEXITCODE`-Weitergabe, Exitcode `0`, genau einem Engine-Prozess und ohne
  Evidence-Datei.
- Linux-/Windows-Fixtures: Pass für semantische Normalisierung — gemeinsame
  Fixturewerte prüfen Leerzeichen, führende Bindestriche, Metazeichen, Unicode,
  Zeilenumbruch und NUL. Es wird kein nativer Linux-/Windows-Runner behauptet.
- Bash/PowerShell-Parität: Pass — gleiches Profil, gleiche Feldreihenfolge,
  gleicher Gate-Set-Hash und gleicher Exitcode auf macOS.
- Vorschau: Pass — `--dry-run` und `-WhatIf` verwenden denselben Engine-
  Einstieg und schreiben keine Evidence.
- Cmdlet/Hilfe: Pass — `Invoke-HBAgenticWorkspaceMaintenance` bleibt
  Verb-Noun-konform; die comment-based Help dokumentiert `-CiGate`, `-WhatIf`,
  Ausgabe, Exitcodes und Stufe-A-Grenze DE-first/EN-second.
- Manpages: Pass — `maintain-agentic-workspace.1.md` und `install-hooks.1.md`
  dokumentieren Gate, Evidence, Fehler, Reinstallation, Hash- und direkten
  Pass-/Block-Prüfpfad ohne Push.
- Quoting/Strict Mode: Pass — Bash nutzt `set -euo pipefail`, gequotete Arrays
  und kein `eval`; PowerShell nutzt Strict Mode, validierte Parameter und kein
  `Invoke-Expression`.
- Re-Evaluation: bei Wrapper-, Help-, Manpage-, Runtime-, Plattform-,
  Exitcode- oder Ausgabeänderung; dann native Plattformtokens nur nach echter
  Ausführung ergänzen.
