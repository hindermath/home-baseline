# Implementierungsplan: Workspace Homogeneity Guardian — Revision & Gap Fix
# Implementation Plan: Workspace Homogeneity Guardian — Revision & Gap Fix

**Branch**: `002-homogeneity-guardian-revision` | **Datum / Date**: 2026-04-02  
**Spec**: `specs/002-homogeneity-guardian-revision/spec.md`  
**Abhängig von / Depends on**: `001-workspace-homogeneity-guardian` (Parent-Feature)

## Zusammenfassung / Summary

18 Schwachstellen (SW-01–SW-18) wurden in der `home-baseline`-Umgebung identifiziert.
Dieser Plan liefert die vollständige Implementierungsroadmap: 7 neue Skript-Paare (Bash + PowerShell),
4 Template-Dateien, 1 CI/CD-Workflow, Korrekturen in `.gitignore` und bestehenden
Markdown-Dateien — alle in der von NFR-REV-01 vorgeschriebenen Reihenfolge.

*18 weaknesses (SW-01–SW-18) were identified in the `home-baseline` environment.
This plan delivers the full implementation roadmap: 7 new script pairs (Bash + PowerShell),
4 template files, 1 CI/CD workflow, fixes to `.gitignore` and existing markdown files —
all in the order prescribed by NFR-REV-01.*

## Technischer Kontext / Technical Context

**Language/Version**: Bash 5+ (primär / primary); PowerShell Core 7+ (Windows-Parität / parity)  
**Primary Dependencies**: `git` ≥ 2.30, `ripgrep (rg)` (alle Plattformen), `gh` CLI (optional, Bootstrap)  
**Storage**: Dateisystem / File system (`.md`, `.gitignore`, `STATS.md`, `constitution.md`, `.yml`)  
**Testing**: Manuell via `--dry-run` / `-WhatIf`; Post-run `check-homogeneity.sh` als Validierung  
**Target Platform**: macOS 14+, Ubuntu 22.04/24.04 LTS, Debian 12, Windows 10/11 (nativ + WSL2)  
**Project Type**: Infrastructure automation scripts (CLI-Tools)  
**Performance Goals**: Kein programmatisches Timeout (NFR-REV-06); Skripte laufen bis Abschluss  
**Constraints**: Nicht-destruktiv / Non-destructive (append-only, idempotent); kein Test-Framework (Constitution V)  
**Scale/Scope**: 7 neue Skript-Paare + 4 Templates + 1 CI-Workflow + N Datei-Modifikationen in 3+ Workspaces

## Verfassungs-Prüfung / Constitution Check

*GATE: Muss vor Phase 0 bestanden werden. Nach Phase 1 erneut prüfen.*  
*GATE: Must pass before Phase 0. Re-check after Phase 1.*

| Prinzip / Principle | Status | Begründung / Rationale |
|---------------------|:------:|------------------------|
| I. Security-First | ✅ PASS | FR-REV-A04: Pre-Push-Hook auf Level-2 wird geprüft/installiert; FR-REV-B02: constitution.md-Kopie; keine Secrets in Scripts; pre-push-Hook blockiert Credential-Patterns |
| II. Cross-Platform Parity | ✅ PASS | Alle 7 neuen Skripte haben .sh + .ps1-Variante (spec-erzwungen); Templates sind plattform-neutral |
| III. Bootstrap Automation | ✅ PASS | `bootstrap-project.sh` ist Kernlieferobjekt; CI-Workflow + constitution.md werden direkt erstellt |
| IV. Workspace Isolation | ✅ PASS | Keine Submodule; Level-2-Erkennung via `.git/`-Verzeichnis (Git als Wahrheitsquelle) |
| V. Manual-First Verification | ✅ PASS | `--dry-run`/`-WhatIf` in migrate, bootstrap, sync-constitution; kein Test-Framework |

**Ergebnis / Result**: Alle Gates bestanden. Keine Verletzungen — Complexity Tracking entfällt.

## Projektstruktur / Project Structure

### Spezifikations-Artefakte / Specification Artifacts (dieses Feature / this feature)

```text
specs/002-homogeneity-guardian-revision/
├── plan.md              # Dieses Dokument / This file
├── research.md          # Phase 0 Output
├── data-model.md        # Phase 1 Output
├── quickstart.md        # Phase 1 Output
├── contracts/           # Phase 1 Output
│   ├── check-homogeneity-cli.md
│   ├── init-stats-cli.md
│   ├── migrate-workspace-cli.md
│   ├── sync-constitution-cli.md
│   ├── bootstrap-project-cli.md
│   ├── rename-lastenheft-cli.md
│   ├── stats-md-format.md
│   └── homogeneity-check-yml.md
└── tasks.md             # Phase 2 Output (/speckit.tasks — NOT created by /speckit.plan)
```

### Quellcode / Source Code (Repository-Root `~/`)

```text
# Neue Skripte / New scripts
scripts/
├── migrate-workspace.sh / migrate-workspace.ps1    # FR-REV-A01–A06
├── check-homogeneity.sh / check-homogeneity.ps1    # FR-REV-B01
├── bootstrap-project.sh / bootstrap-project.ps1    # FR-REV-B02, B05
├── rename-lastenheft.sh / rename-lastenheft.ps1    # FR-REV-B03
├── init-stats.sh / init-stats.ps1                  # FR-REV-B04
├── sync-constitution.sh / sync-constitution.ps1    # FR-REV-F01–F02
├── templates/
│   ├── a11y-section.md                             # FR-REV-A01
│   ├── speckit-workflow-section.md                 # FR-REV-A01
│   ├── azubis-section.md                           # FR-REV-A01
│   └── readme-template.md                          # FR-REV-B02
└── hooks/
    └── pre-push                                    # bestehend / existing — Level-2-Install sicherstellen

# CI/CD-Workflow (Root-Level und je Workspace)
.github/workflows/
└── homogeneity-check.yml                           # FR-REV-G01–G03

# Bestehende Dateien (modifiziert, nicht neu) / Existing files (modified, not created)
.gitignore                                          # FR-REV-C01–C02 (Whitelist-Ergänzung)
README.md                                           # FR-REV-A01 (A11Y + Spec-kit + Azubis sections)
CLAUDE.md                                           # FR-REV-A01 (EN-Platzhalter)
GEMINI.md                                           # FR-REV-A01 (EN-Platzhalter)
AGENTS.md                                           # FR-REV-A01 (EN-Platzhalter)
.github/copilot-instructions.md                     # FR-REV-A01 (EN-Platzhalter)
STATS.md                                            # FR-REV-B04 (neu angelegt via init-stats.sh)
constitution.md                                     # bestehend — Quelle für sync-constitution.sh
```

**Strukturentscheidung / Structure Decision**: Single-repo CLI-Infrastruktur.
Alle Skripte liegen direkt in `scripts/`; keine Unterverzeichnisse außer `templates/` und `hooks/`.
Die Skripte sind die Lieferobjekte — kein `src/`-Verzeichnis.

## Umsetzungsreihenfolge / Implementation Order

Gemäß NFR-REV-01 (zwingend einzuhalten):

| Phase | Gruppe | Skript / Datei | SW-Fix |
|-------|--------|----------------|--------|
| 1 | REV-C | `.gitignore` korrigieren | SW-08, SW-09 |
| 2 | REV-B01 | `check-homogeneity.sh/.ps1` | SW-02 |
| 3 | REV-B04 | `init-stats.sh/.ps1` | SW-05 |
| 4 | REV-A | `migrate-workspace.sh/.ps1` + Templates | SW-03, SW-04, SW-06, SW-07, SW-10, SW-13, SW-14 |
| 5 | REV-B02 | `bootstrap-project.sh/.ps1` | SW-01 |
| 6 | REV-B03 | `rename-lastenheft.sh/.ps1` | SW-11 |
| 7 | REV-D | Agenten-CLI-Docs in bootstrap | SW-12 |
| 8 | REV-E | `.editorconfig` + C#-Check | SW-13 |
| 9 | REV-F | `sync-constitution.sh/.ps1` | SW-15 |
| 10 | REV-G | `homogeneity-check.yml` CI | SW-16 |
