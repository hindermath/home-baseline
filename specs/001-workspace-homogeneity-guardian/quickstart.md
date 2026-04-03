# Schnellstart / Quickstart

**Workspace Homogeneity Guardian** — `001-workspace-homogeneity-guardian`

---

## Für Azubis / For Apprentices

### Voraussetzungen / Prerequisites

**Deutsch**: Stelle sicher, dass folgende Tools installiert sind:

| Tool | Mindestversion | Installation |
|------|---------------|--------------|
| `git` | 2.x | vorinstalliert auf macOS/Ubuntu |
| `bash` | 5.x | macOS: `brew install bash` · Linux: vorinstalliert |
| `ripgrep (rg)` | 13.x | `brew install ripgrep` · `sudo apt install ripgrep` |
| `gh` | 2.x (optional) | `brew install gh` · `sudo apt install gh` |
| `node` / `npx` | 18+ (optional) | `brew install node` · `sudo apt install nodejs npm` |

**English**: Ensure the following tools are installed (see table above).

---

### Schritt 1 — Compliance-Check ausführen / Run the Compliance Check

```bash
# Compliance-Check des gesamten Home-Verzeichnisses
bash ~/scripts/check-homogeneity.sh

# Nur Fehlschläge und Warnungen anzeigen (Standard)
bash ~/scripts/check-homogeneity.sh ~/

# Alle Dateien anzeigen (auch erfolgreiche Prüfungen)
bash ~/scripts/check-homogeneity.sh --verbose

# Maschinenlesbarer JSON-Output (für Scripting/CI)
bash ~/scripts/check-homogeneity.sh --json | jq .

# Vorschau ohne Schreibvorgänge
bash ~/scripts/check-homogeneity.sh --dry-run
```

**Was der Check prüft**:
- Sind alle Pflichtdateien vorhanden? (AGENTS.md, CLAUDE.md, GEMINI.md, README.md usw.)
- Stimmt der pre-push Hook mit dem kanonischen Master überein? (SHA-256)
- Ist jede Dokumentationsdatei zweisprachig (DE + EN)?
- Sind alle Markdown-Dateien barrierefrei? (Alt-Texte, Heading-Hierarchie)
- Enthält keine Datei versteckte Secrets?

**English**: The check verifies file presence, hook integrity (SHA-256), bilingual
content, accessibility, and absence of secrets across all three hierarchy levels.

---

### Schritt 2 — Neues Projekt bootstrappen / Bootstrap a New Project

```bash
# Neues Projekt im aktuellen Workspace anlegen
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects/

# Vorschau (keine Dateien werden erstellt)
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects/ --preview

# Bestehende Dateien ergänzen (fehlende hinzufügen, vorhandene nicht überschreiben)
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects/

# Alle Schritte erzwingen (bestehende Dateien überschreiben)
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects/ --force
```

**Was der Bootstrap anlegt**:
- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `copilot-instructions.md`
- `README.md` (zweisprachig, mit Azubi-Abschnitt)
- `STATS.md` (initiale leere Statistikdatei)
- `.gitignore` (Whitelist-Modell)
- `scripts/` (kopiert aus `~/scripts/`)
- `.git/hooks/pre-push` (kanonischer Secret-Scan-Hook)
- Remote GitHub-Repo (privat) via `gh repo create`
- KI-Agenten-Init (Claude automatisch; Codex/Gemini: manuelle Anweisung)
- Spec-kit (`npx speckit init`)

**English**: Bootstrap creates all required files, installs the secret-scanning hook,
initialises AI agents, and sets up Spec-kit — in a single command.

---

### Schritt 3 — Memory-Patch anwenden / Apply a Memory Patch

Nach einem Compliance-Check kann eine `memory-patch.md` entstehen, wenn das Tool
neue Erkenntnisse hat (neues Workspace, Score-Änderung ≥ 10 %, neuer FAIL-Typ).

```bash
# Patch anzeigen und interaktiv anwenden
bash ~/scripts/check-homogeneity.sh --apply-patch \
  ~/specs/001-workspace-homogeneity-guardian/memory-patch.md

# Patch ohne Bestätigung anwenden (Achtung: prüfe vorher den Inhalt!)
bash ~/scripts/check-homogeneity.sh --apply-patch memory-patch.md --yes
```

**Der Patch schlägt vor**:
- Ergänzungen für `CLAUDE.md`, `GEMINI.md`, `AGENTS.md` (Kontext-Facts)
- Ergänzungen für `README.md` (neue Azubi-Anleitungen)
- Ergänzungen für `~/.specify/memory/constitution.md` (neue projektweite Regeln)

**Wichtig**: Prüfe den Patch immer vor dem Anwenden! Kein Inhalt wird automatisch
committet — du musst explizit bestätigen.

**English**: The memory patch proposes additions to agent files, READMEs, and the
constitution. Always review before applying. Nothing is auto-committed.

---

### Schritt 4 — Windows (WSL2) / Windows with WSL2

Wenn du Windows mit WSL2 und Ubuntu 22.04 LTS verwendest, sind alle Bash-Skripte
identisch nutzbar:

```powershell
# WSL2 öffnen
wsl

# Dann in WSL:
bash ~/scripts/check-homogeneity.sh
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects/
```

Für native PowerShell (ohne WSL):
```powershell
pwsh ~/scripts/check-homogeneity.ps1
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/MyProjects/
```

**English**: On Windows, use WSL2 with Ubuntu 22.04 LTS for identical bash behaviour,
or use the PowerShell `.ps1` variants directly.

---

## Häufige Fragen / FAQ

**Frage**: Was bedeutet `WARN: bilingual section missing`?  
**Antwort**: Die Datei hat keinen deutschen oder englischen Abschnitts-Heading.
Füge einen `## Überblick` (DE) und einen `## Overview` (EN) Abschnitt hinzu.

**Question**: What does `FAIL: hook missing` mean?  
**Answer**: The `.git/hooks/pre-push` file is absent. Run:
```bash
bash ~/scripts/install-hooks.sh
```

**Frage**: Wie aktualisiere ich alle Workspaces auf den neuesten Hook?  
**Antwort**: Führe den Compliance-Check aus. Er zeigt veraltete Hooks an.
Danach reinstalliere mit `bash ~/scripts/install-hooks.sh` in jedem betroffenen Repo.

**Question**: Can I run the check without network access?  
**Answer**: Yes — all check operations are fully offline. Only the Spec-kit install
step (bootstrap) and remote push require network access.

---

## Fehlerbehebung / Troubleshooting

| Problem | Lösung / Solution |
|---------|-------------------|
| `rg: command not found` | `brew install ripgrep` (macOS) · `sudo apt install ripgrep` (Ubuntu/Debian) |
| `WARN: stats file locked` | Anderer Prozess schreibt gerade; warte 10 s und versuche erneut |
| `gh: command not found` | Verwende `--no-remote` um Remote-Schritte zu überspringen |
| `npx: command not found` | Verwende `--no-speckit` oder installiere Node.js |
| `git: command not found` | `sudo apt install git` (Ubuntu) · Xcode Command Line Tools auf macOS |
| `Permission denied` / keine Schreibrechte | Prüfe Eigentümer: `ls -la <verzeichnis>`; ggf. `chown -R $USER <dir>` |
| `sudo: command not found` oder sudo-Rechte fehlen | Wende dich an die IT/Ausbilder — Root-Rechte für `apt install` nötig |
| Exit-Code 2 | Fataler Fehler; prüfe die Fehlermeldung auf stderr |
