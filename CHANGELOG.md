# Changelog / Änderungsprotokoll

Alle wesentlichen Änderungen werden hier dokumentiert.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · Versionsschema: [Semantic Versioning](https://semver.org/)

*All notable changes are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · Versioning: [Semantic Versioning](https://semver.org/)*

---

## [Unreleased]

### Fixed / Behoben

- `README.md`: 5 Zeilen der SDD-Workflow-Tabelle von 64 auf 63 Zeichen korrigiert (ein überzähliges Leerzeichen vor dem schließenden `│` je Zeile)
- `README.md`: Abschnitt „Verzeichnis für Spec-Kit vorbereiten" von manuellem `cp -r ~/home-baseline-tmp/` auf `specify init --here --ai {agent}` umgestellt; `--ai-skill` als Codex-spezifisch dokumentiert

---

## [0.3.0] — 2026-04-03

### Added / Hinzugefügt

- `scripts/sync-home.sh` und `scripts/sync-home.ps1` — synchronisiert `home-baseline-tmp` → `~/`
  Flags: `--no-pull` / `-NoPull`, `--no-commit` / `-NoCommit`, `--dry-run` / `-WhatIf`
- `CHANGELOG.md` — diese Datei; dokumentiert alle Versionen ab v0.1.0
- README: zweistufiges Inhaltsverzeichnis — alle `##` und `###` Überschriften direkt verlinkt
- README: Abschnitt „Was ist dieses Template-Repo?" mit Fork-vs.-Template-Vergleich
- README: vollständige Umschreibung des Auszubildenden-Abschnitts (Schritt 0–4, Fehler-Tabelle, Glossar)
- README: Template-Entwickler-Workflow mit sync-home-Optionen-Tabelle
- README: ausführlicher Spec-kit-Abschnitt — SDD-Konzept, Einrichtung für 5 KI-Agenten, Beispiel, Artefakt-Struktur
- README: Barrierefreiheit-Abschnitt auf WCAG 2.2 Level AA aktualisiert (Kriterien-Tabelle, Plattform-Einschränkung)

### Changed / Geändert

- README: Spec-kit-Abschnitt verschoben — jetzt nach Auszubildende, vor Barrierefreiheit
- README: Alle Code-Blöcke ohne Sprachmarkierung nachträglich mit `text` versehen (WCAG 4.1.1)
- Alle 4 KI-Agenten-Dateien mit Session-Erkenntnissen, Known-Pitfalls-Tabelle und Repository-Status aktualisiert

### Fixed / Behoben

- CI (`homogeneity-check.yml`): korrekte TARGET_DIR-Berechnung — `cd "$(dirname $GITHUB_WORKSPACE)"` vor Scanner-Aufruf
- CI: `windows-latest` → `windows-2022` fixiert (windows-2025 instabil, git.exe-Step timing out)
- CI: PowerShell-Parameter `-WorkspaceName` → `-TargetDir` korrigiert
- `check-homogeneity.sh`: `${#FAILURES[@]+"${#FAILURES[@]}"}` entfernt (bad substitution auf Ubuntu 22.04 bash)

---

## [0.2.0] — 2026-04-03

### Added / Hinzugefügt

- Workspace Homogeneity Guardian (`scripts/check-homogeneity.sh` und `.ps1`)
  — 25 Compliance-Checks, JSON-Ausgabe, STATS.md-Update, CI/CD-Support
- `scripts/init-stats.sh/.ps1` — STATS.md-Baseline-Eintrag erzeugen
- `scripts/migrate-workspace.sh/.ps1` — bestehende Workspaces zur Baseline migrieren
- `scripts/sync-constitution.sh/.ps1` — `constitution.md` in alle Level-1-Workspaces synchronisieren
- `scripts/rename-lastenheft.sh/.ps1` — Lastenheft-Dateien per `git mv` umbenennen
- MIT `LICENSE`
- `.github/workflows/homogeneity-check.yml` — CI auf ubuntu-22.04, macos-14, windows-2022
- README: Homogeneity-Guardian-Kurzreferenz mit allen Kommandos
- README: Inhalt/Contents-Tabelle für alle Scripts

### Changed / Geändert

- Repository als öffentliches GitHub Template-Repo gesetzt (via „Use this template" nutzbar)
- `bootstrap-workspace.sh/.ps1`: GitHub-Username jetzt dynamisch (`gh api user --jq '.login'`) — kein hardcodierter Username mehr
- `check-homogeneity.sh`: vom eigenen ANSI-Scan ausgeschlossen (`--glob '!check-homogeneity.*'`)

---

## [0.1.0] — 2026-03-31

### Added / Hinzugefügt

- Initiale Bootstrap-Infrastruktur:
  - `scripts/bootstrap-workspace.sh/.ps1` — vollständige Workspace-Einrichtung in einem Schritt
  - `scripts/install-hooks.sh/.ps1` — Git-Hooks installieren
  - `scripts/scan-agent-secrets.sh/.ps1` — Secret-Scanner für KI-Agenten-Verzeichnisse
  - `scripts/hooks/pre-push` — blockiert Push bei HIGH-Severity Secret-Befunden
  - `scripts/bootstrap-project.sh/.ps1` — neues Projekt innerhalb eines Workspace anlegen
- Projekt-Verfassung `constitution.md` (v1.0.0)
- KI-Agenten-Kontext-Dateien: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`
- Spec-Kit-Integration: `.specify/`, `.agents/skills/`, `.claude/commands/`, `.gemini/commands/`
- `.gitignore`-Whitelist-Modell (blockiert standardmäßig alles; nur explizit erlaubte Dateien getrackt)
- `STATS.md` für Workspace-Compliance-Tracking
- Bilinguale `README.md` mit Installations-Anleitung (DE + EN)
- `bootstrap-workspace.sh`: aktualisiert automatisch `~/README.md`-Workspace-Tabelle

---

[Unreleased]: https://github.com/hindermath/home-baseline/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/hindermath/home-baseline/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/hindermath/home-baseline/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/hindermath/home-baseline/releases/tag/v0.1.0
