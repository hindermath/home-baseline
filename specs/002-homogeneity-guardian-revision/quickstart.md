# Schnellstart / Quickstart Guide
# Workspace Homogeneity Guardian — Revision & Gap Fix

**Feature**: `002-homogeneity-guardian-revision`  
**Datum / Date**: 2026-04-02

---

## Voraussetzungen / Prerequisites

```bash
# Prüfe / Check
bash --version          # Bash 5+
rg --version            # ripgrep
git --version           # git ≥ 2.30
gh --version            # gh CLI (optional, für Bootstrap)
```

---

## Szenario 1 — Bestehende Workspaces migrieren / Migrate existing workspaces

### Schritt 1: Ausgangslage messen / Measure current state

```bash
# STATS.md-Baseline anlegen (Ist-Zustand vor allen Fixes)
bash scripts/init-stats.sh
```

### Schritt 2: Einzelnen Workspace migrieren / Migrate a single workspace

```bash
# Vorschau (keine Änderungen) / Preview (no changes)
bash scripts/migrate-workspace.sh --dry-run RiderProjects

# Migration durchführen / Run migration
bash scripts/migrate-workspace.sh RiderProjects
```

### Schritt 3: Alle Workspaces auf einmal / Migrate all workspaces at once

```bash
# Vorschau aller Workspaces
bash scripts/migrate-workspace.sh --dry-run

# Alle migrieren (eine Bestätigung für alle)
bash scripts/migrate-workspace.sh
```

### Schritt 4: Compliance prüfen / Verify compliance

```bash
bash scripts/check-homogeneity.sh
# Erwartung: Score ≥ 40 pp höher als Baseline (SC-REV-07)
```

---

## Szenario 2 — Neues Projekt bootstrappen / Bootstrap a new project

```bash
# Vollständig kompliantes Projekt anlegen / Create fully compliant project
bash scripts/bootstrap-project.sh MyNewProject my-new-repo "Beschreibung"

# Sofort prüfen / Immediately verify
bash scripts/check-homogeneity.sh MyNewProject
# Erwartung: 100% — kein ✗-Befund (SC-001)
```

---

## Szenario 3 — Constitution propagieren / Propagate constitution update

```bash
# Vorschau / Preview
bash scripts/sync-constitution.sh --dry-run

# Alle Level-1-Workspaces aktualisieren
bash scripts/sync-constitution.sh
```

---

## Szenario 4 — Lastenheft umbenennen / Rename Lastenheft

```bash
# Aktuelle Branch-Name ermitteln / Get current branch name
git branch --show-current
# → 002-homogeneity-guardian-revision

# Datei umbenennen / Rename file
bash scripts/rename-lastenheft.sh Lastenheft_workspace-homogeneity-guardian.md 002-homogeneity-guardian-revision
# Ergebnis: Lastenheft_workspace-homogeneity-guardian.002-homogeneity-guardian-revision.md
```

---

## Szenario 5 — CI/CD-Status prüfen / Check CI status

Nach jedem Push auf einen Workspace-Branch:
1. GitHub Actions → Tab "Actions" öffnen
2. Workflow "Homogeneity Check" → alle 3 Matrix-Jobs prüfen (`ubuntu-22.04`, `macos-14`, `windows-latest`)
3. Job Summary: Markdown-Tabelle mit Check-Ergebnissen

---

## Vollständige Validation-Sequenz / Full Validation Sequence

```bash
# 1. .gitignore korrigieren (FR-REV-C01, C02)
#    → manuell oder via fix-Skript

# 2. check-homogeneity.sh implementieren (FR-REV-B01)
bash scripts/check-homogeneity.sh   # erwartet: erste Ausgabe

# 3. Baseline messen (FR-REV-B04)
bash scripts/init-stats.sh

# 4. Alle Workspaces migrieren (FR-REV-A01–A06)
bash scripts/migrate-workspace.sh

# 5. Post-Fix-Scan
bash scripts/check-homogeneity.sh
# → Score deutlich höher als Baseline (SC-REV-07)

# 6. SC-REV-01 bestätigen
bash scripts/check-homogeneity.sh
# → Exit-Code 0, alle ✓/WARN
```

---

## Nützliche Befehle / Useful Commands

```bash
# JSON-Ausgabe für Scripting
bash scripts/check-homogeneity.sh --json | python3 -m json.tool

# Nur einen Workspace prüfen
bash scripts/check-homogeneity.sh RiderProjects

# STATS.md-Trend ansehen
cat STATS.md

# PowerShell (Windows)
pwsh scripts/migrate-workspace.ps1 -WorkspaceName RiderProjects -WhatIf
pwsh scripts/check-homogeneity.ps1
pwsh scripts/sync-constitution.ps1 -WhatIf
```
