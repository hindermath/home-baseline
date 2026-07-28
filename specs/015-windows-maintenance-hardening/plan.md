# Implementation Plan: Windows-Härtung der Ein-Kommando-Wartung

**Branch**: `015-windows-maintenance-hardening` | **Date**: 2026-07-28 | **Spec**: `specs/015-windows-maintenance-hardening/spec.md`

## Summary

Die bestehende Windows-Orchestrierung wird um eine einzige Modusableitung,
validierte Python-Launcher, frühe Toolchain-Gates, begrenzte Git-/WinGet-
Prozesse, atomare Resume-Evidence und kanonische Statusableitung erweitert.
Die bestehende Python-Standardbibliothekskomponente bleibt für Flottenvertrag
und JSON-Bericht zuständig; Windows-Prozess- und UAC-Grenzen bleiben in
PowerShell.

## Technical Context

**Language/Version**: PowerShell 7+, Python 3 Standardbibliothek
**Primary Dependencies**: Git CLI, WinGet, PowerShellGet/PSResourceGet,
PSScriptAnalyzer 1.25.0; keine neue Produktabhängigkeit
**Storage**: lokale atomare JSON-Evidence unter `~/.home-baseline/`; getrackte
JSON-Verträge und Feature-Evidence
**Testing**: Python `unittest`, PowerShell-Fixtures, Parser,
PSScriptAnalyzer, vorhandene Windows-/Statistik-/Homogeneity-Gates
**Target Platform**: Windows 10/11 mit PowerShell 7; gemeinsame Verträge
werden auf macOS/Linux revalidiert
**Project Type**: CLI-/Skript-Infrastruktur
**Performance Goals**: Retry- und Prozesswartezeiten sind konfigurierbar und
hart begrenzt; Zielermittlung bleibt linear zur Flottengröße
**Constraints**: kein UAC-Bypass, keine Zielcommits/-pushes, keine destruktive
Git-Reparatur, keine Secrets oder privaten Interpreterpfade in Evidence
**Scale/Scope**: Level 0, 44 Flottenziele, 32 Registry-Ziele, Elf-Preset-Profil

## Constitution Check

- **Level 2**: `N/A`; implementiert wird Level 0.
- **MSL**: PowerShell/.NET und Python sind speichersicher.
- **Secure coding**: Validierte Parameter, Argumentlisten statt
  Befehlsstrings, kein `Invoke-Expression`, kanonische Pfade und fail-closed
  Hashprüfung.
- **Secure architecture**: Dateisystem, Git, Python, WinGet/UAC und
  Paketquellen sind explizite Trust Boundaries. Frühe Gates, Retry-
  Klassifikation, Timeout plus Prozessbaum-Cleanup und Hash-gebundenes Resume
  bilden Defense in Depth.
- **Security standards**: NIST SSDF, CWE Top 25, CAPEC, SAMM und OpenSSF sind
  anwendbar. ASVS, SBOM/VEX/SLSA, AI-SBOM, Zero Trust, BSI C3A/C5 und
  regulatorische Profile sind mit den in der Spec genannten Triggern `N/A`.
- **Security evidence**: feature-lokal in Plan, Gate-Anforderungen,
  Checklisten und `autonomous-run-evidence.md`; kein neuer dauerhafter
  Security-Dokumentvertrag.
- **Presets**: das nachgewiesene Elf-Preset-Profil ist anwendbar. Intake
  Authoring, Intake Review und Autonomous Run liefern die Eingabe- und
  Lieferungsevidence. Parallel Autonomous ist `N/A`.
- **A11Y/Bilingual**: CLI und Dokumentation text-first, nicht farbabhängig,
  DE-first/EN-second und CEFR B2.
- **Statistics**: `docs/project-statistics.md` wird mit Profil 2 gerendert;
  Referenzen 80/100 Zeilen je Arbeitstag.
- **Agent guidance parity**: keine neue dauerhafte Agentenregel geplant; alle
  gepflegten Oberflächen werden als unverändert geprüft.
- **Documentation Impact**: `UpdateRequired` für PowerShell-Hilfe,
  Wartungs-Manpage, Feature-Artefakte und Statistik.

## Project Structure

```text
specs/015-windows-maintenance-hardening/
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── autonomous-run-evidence.md
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── maintenance-mode.md
│   ├── process-result.md
│   └── resume-evidence.md
├── checklists/
│   ├── requirements.md
│   └── governance.md
└── tasks.md

scripts/
├── maintain-agentic-workspace.ps1
├── maintain-agentic-winget-apps.ps1
├── sync-home.ps1
├── lib/agentic_workspace_fleet.py
├── tests/test_windows_maintenance_hardening.py
└── config/
docs/
├── man/maintain-agentic-workspace.1.md
└── project-statistics.md
```

**Structure Decision**: Die öffentlichen Skripte bleiben bestehen. Gemeinsame
testbare Windows-Verträge liegen im internen Modul
`scripts/lib/windows-maintenance-hardening.psm1` und werden von den
öffentlichen PowerShell-Oberflächen importiert. Der Python-Kern bleibt auf
Flotten- und Reportverträge begrenzt.

## Design and Delivery Phases

1. Vertrags- und Negativtests für Modus, Python, Retry, Resume, WinGet und
   Statusableitung zuerst rot nachweisen.
2. Modus-, Python- und frühe Gate-Verträge implementieren.
3. Resume-/Drift-/Profilverträge implementieren.
4. Retry-, WinGet-Prozess- und Paketstatusverträge implementieren.
5. Windows-Harness, Dokumentation und Statistik schließen.
6. Exakten gestagten Kandidaten lokal und auf allen Pflicht-Runnern prüfen,
   PR-Head und Review konvergieren, regelkonform mergen und `main`
   synchronisieren.

## Validation Strategy

- Parser- und PSScriptAnalyzer-Gates vor jeder echten Wartung.
- Isolierte Mocks statt echter WinGet-/UAC-Mutation.
- Temporäre Git- und HOME-Fixtures; keine Flottenmutation in Tests.
- Modus- und Exitcode-Matrix einschließlich Drift, Partial, Failed und
  Deferred.
- `git diff --check`, Secret-Scan, Homogeneity, Agent-Parität,
  Statistik-Fixtures und Check-only/WhatIf.
- Providerneutrale Exact-Head-Evidence für Windows, macOS und Linux.

## Post-Design Constitution Check

Bestanden. Es entstehen keine neuen Abhängigkeiten, Dienste, Release-
Artefakte, Cloud-Grenzen oder KI-Runtime-Komponenten. Die Implementierung
reduziert Privileg- und Prozessrisiken und bewahrt die bestehenden
Schnittstellen.

## Complexity Tracking

Keine Verfassungsabweichung.
