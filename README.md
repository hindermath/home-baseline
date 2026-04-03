# home-baseline

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur.
Es enthält die Bootstrap-Scripts, mit denen jedes neue Projektverzeichnis in wenigen
Sekunden als synchronisiertes privates GitHub-Repository eingerichtet werden kann.

*This repository is the **top level** of the private workspace infrastructure.
It contains bootstrap scripts to set up any new project directory as a synchronised
private GitHub repository within seconds.*

---

## Workspace-Übersicht / Workspace overview

| Verzeichnis | GitHub-Repo | Eingerichtet mit |
|---|---|---|
<!-- workspace-table-end -->

---

## Voraussetzungen / Prerequisites

Diese Tools müssen auf jedem Gerät **vor** dem ersten Clonen installiert und eingerichtet sein.

*These tools must be installed and configured on every device **before** the first clone.*

### 1. Git

| Plattform | Installation |
|---|---|
| macOS | `brew install git` oder [git-scm.com](https://git-scm.com/download/mac) |
| Linux | `sudo apt install git` / `sudo dnf install git` |
| Windows | [git-scm.com/download/win](https://git-scm.com/download/win) |

### 2. GitHub CLI (`gh`)

| Plattform | Installation |
|---|---|
| macOS | `brew install gh` |
| Linux | [cli.github.com](https://cli.github.com) → Installationsanleitung |
| Windows | `winget install --id GitHub.cli` oder [cli.github.com](https://cli.github.com) |

Nach der Installation einmalig anmelden / After installation, log in once:

```bash
gh auth login
```

### 3. PowerShell Core >= 7 *(nur Windows / Windows only)*

```powershell
winget install --id Microsoft.PowerShell
```

Oder: [github.com/PowerShell/PowerShell/releases](https://github.com/PowerShell/PowerShell/releases)

### 4. ripgrep (`rg`)

`check-homogeneity` benötigt ripgrep für den Compliance-Scan.

*`check-homogeneity` requires ripgrep for compliance scanning.*

| Plattform | Installation |
|---|---|
| macOS | `brew install ripgrep` |
| Linux | `sudo apt install ripgrep` / `sudo dnf install ripgrep` |
| Windows | `winget install --id BurntSushi.ripgrep.MSVC` |

### 5. Empfohlene PowerShell-Module *(optional, einmalig / optional, once)*

```powershell
Install-Module -Name posh-git            -Scope CurrentUser -Force  # Git-Prompt + Tab-Completion
Install-Module -Name PowerShellForGitHub -Scope CurrentUser -Force  # GitHub API Cmdlets
Install-Module -Name GitAutomation       -Scope CurrentUser -Force  # Git als Cmdlets
```

---

## Neuen Workspace einrichten / Create new workspace

### macOS / Linux

```bash
# Vollständige Einrichtung in einem Schritt:
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Beispiele:
bash ~/scripts/bootstrap-workspace.sh FlutterProjects
bash ~/scripts/bootstrap-workspace.sh GoProjects go-baseline "Go-Workspace"

# Vorher testen (kein Schreibzugriff):
bash ~/scripts/bootstrap-workspace.sh --dry-run FlutterProjects
```

### Windows (PowerShell Core >= 7)

```powershell
# Vollständige Einrichtung in einem Schritt:
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>

# Beispiele:
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName GoProjects -RepoName go-baseline -Description "Go-Workspace"

# Vorher testen (kein Schreibzugriff):
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
```

Der Bootstrap-Vorgang erledigt automatisch:
1. Bestehende Sub-Repos erkennen und in `.gitignore` eintragen
2. Standard-Scripts (`scan-agent-secrets`, `install-hooks`, `pre-push`-Hook) kopieren
3. `git init` + initialer Commit
4. Privates GitHub-Repo erstellen (`gh repo create`)
5. Push zu GitHub
6. Git-Hooks installieren

---

## Ersteinrichtung dieses Repos auf einem neuen Gerät / Initial setup on a new device

### macOS / Linux

```bash
cd ~
git clone https://github.com/YOUR_USERNAME/home-baseline.git home-baseline-tmp

# Scripts und Konfiguration einrichten
cp -r home-baseline-tmp/scripts/. ~/scripts/
cp home-baseline-tmp/.gitignore ~/.gitignore

# Level-0-Dateien ins Home-Verzeichnis kopieren
cp home-baseline-tmp/AGENTS.md home-baseline-tmp/CLAUDE.md home-baseline-tmp/GEMINI.md \
   home-baseline-tmp/README.md home-baseline-tmp/STATS.md home-baseline-tmp/constitution.md ~/
cp -r home-baseline-tmp/.github ~/

git init
bash ~/scripts/install-hooks.sh
rm -rf home-baseline-tmp

# Initialen Commit erstellen
git add -A
git commit -m "chore: initialer Commit — Level-0-Baseline"

# Compliance prüfen
bash ~/scripts/check-homogeneity.sh ~/
```

### Windows (PowerShell Core >= 7)

```powershell
Set-Location ~
git clone https://github.com/YOUR_USERNAME/home-baseline.git home-baseline-tmp

# Scripts und Konfiguration einrichten
Copy-Item home-baseline-tmp/scripts/* ~/scripts/ -Recurse -Force
Copy-Item home-baseline-tmp/.gitignore ~/ -Force

# Level-0-Dateien ins Home-Verzeichnis kopieren
foreach ($f in @('AGENTS.md','CLAUDE.md','GEMINI.md','README.md','STATS.md','constitution.md')) {
    Copy-Item "home-baseline-tmp/$f" ~/ -Force
}
Copy-Item home-baseline-tmp/.github ~/ -Recurse -Force

git init
pwsh ~/scripts/install-hooks.ps1
Remove-Item home-baseline-tmp -Recurse -Force

# Initialen Commit erstellen
git add -A
git commit -m "chore: initialer Commit — Level-0-Baseline"

# Compliance prüfen
pwsh ~/scripts/check-homogeneity.ps1
```

### Nächste Schritte / Next steps

Neuen Workspace anlegen und verifizieren / Create a new workspace and verify:

```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh FlutterProjects
bash ~/scripts/check-homogeneity.sh ~/FlutterProjects
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/FlutterProjects
```

---

## Inhalt / Contents

### Workspace-Bootstrap / Workspace Bootstrap

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/bootstrap-workspace.sh` | Neues Workspace einrichten (Bash) |
| `scripts/bootstrap-workspace.ps1` | Neues Workspace einrichten (PowerShell Core) |
| `scripts/bootstrap-project.sh` | Neues Projekt in einem Workspace anlegen (Bash) |
| `scripts/bootstrap-project.ps1` | Neues Projekt in einem Workspace anlegen (PowerShell Core) |

### Homogeneity Guardian

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/check-homogeneity.sh` | Compliance-Scanner Level 0–2, JSON-Ausgabe, STATS.md-Update (Bash) |
| `scripts/check-homogeneity.ps1` | Compliance-Scanner — Parität zu Bash-Version (PowerShell Core) |
| `scripts/init-stats.sh` | STATS.md Baseline-Eintrag erzeugen (Bash) |
| `scripts/init-stats.ps1` | STATS.md Baseline-Eintrag erzeugen (PowerShell Core) |
| `scripts/migrate-workspace.sh` | Bestehende Workspaces auf Homogeneity-Baseline migrieren (Bash) |
| `scripts/migrate-workspace.ps1` | Workspace-Migration (PowerShell Core) |
| `scripts/sync-constitution.sh` | `constitution.md` in alle Level-1-Workspaces synchronisieren (Bash) |
| `scripts/sync-constitution.ps1` | Constitution-Sync (PowerShell Core) |
| `scripts/rename-lastenheft.sh` | Lastenheft-Datei umbenennen: `git mv` + Commit (Bash) |
| `scripts/rename-lastenheft.ps1` | Lastenheft umbenennen (PowerShell Core) |
| `constitution.md` | Workspace-Verfassung — Sync-Quelle für alle Workspaces |
| `scripts/templates/readme-template.md` | Bilinguale README-Vorlage mit A11Y-, Spec-kit- und Azubis-Abschnitt |
| `scripts/templates/a11y-section.md` | Barrierefreiheits-Abschnitt (Template) |
| `scripts/templates/speckit-workflow-section.md` | Spec-kit-Workflow-Abschnitt (Template) |
| `scripts/templates/azubis-section.md` | Azubi-Einstiegsleitfaden-Abschnitt (Template) |
| `.github/workflows/homogeneity-check.yml` | CI/CD-Workflow: Compliance-Check auf Ubuntu, macOS, Windows |

### Sicherheit / Security

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/scan-agent-secrets.sh` | Secret-Scan für KI-Agenten-Verzeichnisse (Bash) |
| `scripts/scan-agent-secrets.ps1` | Secret-Scan (PowerShell Core) |
| `scripts/install-hooks.sh` | Git-Hooks installieren (Bash) |
| `scripts/install-hooks.ps1` | Git-Hooks installieren (PowerShell Core) |
| `scripts/hooks/pre-push` | Pre-Push Hook: blockiert Push bei Secrets |

---

## Workspace Homogeneity Guardian — Kurzreferenz / Quick Reference

### Compliance-Check

```bash
# Gesamte Umgebung prüfen / Check entire environment
bash ~/scripts/check-homogeneity.sh

# Einzelnen Workspace prüfen / Check single workspace
bash ~/scripts/check-homogeneity.sh ~/MyProjects

# JSON-Ausgabe (für CI) / JSON output (for CI)
bash ~/scripts/check-homogeneity.sh --json
```

```powershell
# Windows (PowerShell Core)
pwsh ~/scripts/check-homogeneity.ps1
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/MyProjects
pwsh ~/scripts/check-homogeneity.ps1 -Json
```

### STATS.md Baseline erzeugen / Generate STATS.md baseline

```bash
bash ~/scripts/init-stats.sh
```

```powershell
pwsh ~/scripts/init-stats.ps1
pwsh ~/scripts/init-stats.ps1 -WorkspaceName MyProjects
```

### Bestehenden Workspace migrieren / Migrate existing workspace

```bash
# Vorschau / Preview
bash ~/scripts/migrate-workspace.sh --dry-run MyProjects

# Alle Workspaces migrieren / Migrate all workspaces
bash ~/scripts/migrate-workspace.sh --yes
```

```powershell
pwsh ~/scripts/migrate-workspace.ps1 -WorkspaceName MyProjects -WhatIf
pwsh ~/scripts/migrate-workspace.ps1 -Force
```

### Constitution synchronisieren / Sync constitution

```bash
bash ~/scripts/sync-constitution.sh --dry-run   # Vorschau
bash ~/scripts/sync-constitution.sh --yes        # Ausführen
```

```powershell
pwsh ~/scripts/sync-constitution.ps1 -WhatIf
pwsh ~/scripts/sync-constitution.ps1 -Force
```

### Lastenheft umbenennen / Rename Lastenheft

```bash
bash ~/scripts/rename-lastenheft.sh Lastenheft_foo.md 002-feature-branch
# → Lastenheft_foo.002-feature-branch.md
```

```powershell
pwsh ~/scripts/rename-lastenheft.ps1 -File Lastenheft_foo.md -BranchName 002-feature-branch
```

---

## Plattform-Übersicht / Platform overview

| Plattform | Unterstützt | Voraussetzung |
|---|---|---|
| macOS | ✅ nativ | – |
| Linux | ✅ nativ | – |
| Windows | ✅ PowerShell Core | Git for Windows + pwsh >= 7 + ripgrep |

> **Hinweis Windows / Windows note**: `$HOME` muss nicht gesetzt sein — die Scripts
> verwenden automatisch `$env:USERPROFILE` als Fallback.
>
> *`$HOME` does not need to be set — scripts automatically fall back to `$env:USERPROFILE`.*

---

## Für Azubis / For Apprentices

Willkommen! Diese Anleitung führt dich Schritt für Schritt durch den Aufbau eines neuen C#-Projekts
mit dem **Workspace Homogeneity Guardian** — ohne Senior-Hilfe und nur mit freien Tools.

Welcome! This guide walks you through setting up a new C# project with the **Workspace Homogeneity
Guardian** step by step — without senior help and using only free tools.

### Voraussetzungen prüfen / Check Prerequisites

| Tool | Version | Installation (Ubuntu 22.04) |
|------|---------|-----------------------------|
| `git` | ≥ 2.x | `sudo apt install git` |
| `bash` | ≥ 5.x | `sudo apt install bash` (oder vorinstalliert) |
| `ripgrep` | aktuell | `sudo apt install ripgrep` |
| `gh` (optional) | aktuell | [cli.github.com](https://cli.github.com) |

> **Hinweis / Note**: Wenn `sudo` fehlt, frage deine IT-Abteilung.
> If `sudo` is unavailable, contact your IT department.

### Schritt-für-Schritt / Step by Step

**Schritt 1 / Step 1**: Dieses Repository auf dem neuen Gerät einrichten:

```bash
cd ~
git clone https://github.com/YOUR_USERNAME/home-baseline.git home-baseline-tmp

# Scripts und Konfiguration einrichten
cp -r home-baseline-tmp/scripts/. ~/scripts/
cp home-baseline-tmp/.gitignore ~/.gitignore

# Level-0-Dateien ins Home-Verzeichnis kopieren
cp home-baseline-tmp/AGENTS.md home-baseline-tmp/CLAUDE.md home-baseline-tmp/GEMINI.md \
   home-baseline-tmp/README.md home-baseline-tmp/STATS.md home-baseline-tmp/constitution.md ~/
cp -r home-baseline-tmp/.github ~/

git init
bash ~/scripts/install-hooks.sh
rm -rf home-baseline-tmp
```

**Schritt 1b / Step 1b**: Compliance des Home-Verzeichnisses prüfen:

```bash
bash ~/scripts/check-homogeneity.sh ~/
```

**Schritt 2 / Step 2**: Ersten Workspace bootstrappen (z. B. MyProjects):

```bash
bash ~/scripts/bootstrap-workspace.sh MyProjects
```

**Schritt 3 / Step 3**: Neues C#-Projekt bootstrappen:

```bash
# Beispiel: neues Projekt "MeinProjekt" im MyProjects-Workspace
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects --no-remote --no-agents
```

**Schritt 4 / Step 4**: Compliance prüfen:

```bash
bash ~/scripts/check-homogeneity.sh ~/
```

**Schritt 5 / Step 5**: WARNs beheben — typische Probleme:

| Fehler / Error | Ursache / Cause | Lösung / Fix |
|----------------|-----------------|--------------|
| `FAIL: file missing` | Pflichtdatei fehlt | Bootstrap erneut ausführen mit `--force` |
| `WARN: bilingual-section-missing` | Kein DE+EN-Heading | Abschnitt `## Überblick / Overview` hinzufügen |
| `WARN: hook-missing` | pre-push Hook nicht installiert | `bash ~/scripts/install-hooks.sh` |
| `rg: command not found` | ripgrep fehlt | `sudo apt install ripgrep` |
| `Permission denied` | Dateisystemproblem | `chown -R $USER .` |
| `git: command not found` | Git fehlt | `sudo apt install git` |

**Schritt 6 / Step 6**: Ziel erreicht — Score ≥ 90% bedeutet alles ist korrekt konfiguriert.

Goal reached — score ≥ 90% means everything is correctly configured.

### Neues Projekt mit Compliance-Gate / New Project with Compliance Gate

```bash
# Bootstrap + sofortiger Compliance-Check
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/MyProjects --no-remote --no-agents && \
  bash ~/scripts/check-homogeneity.sh ~/MyProjects/MeinProjekt
```

<!-- EN: README.md placeholder
[DE-Zusammenfassung: Vollständige bilinguale README für home-baseline mit Workspace-Tabelle, Scripts, A11Y-, Spec-kit- und Azubis-Abschnitten.]
-->
## Barrierefreiheit / Accessibility (A11Y)

Dieses Projekt folgt grundlegenden Barrierefreiheitsstandards für alle
dokumentierten Inhalte und Benutzeroberflächen.

Richtlinien für Markdown-Dokumentation:

- Überschriften folgen einer klaren Hierarchie (h1 → h2 → h3 — keine Ebene überspringen)
- Alle Bilder haben aussagekräftige Alt-Texte (`![Beschreibung](bild.png)`)
- Linkbeschriftungen sind beschreibend (`[Installationsanleitung](...)` statt `[hier](...)`)
- Code-Blöcke geben die Sprache an (` ```bash `, ` ```powershell `)
- Tabellen haben Kopfzeilen für alle Spalten
- Keine Informationen werden ausschließlich über Farbe vermittelt

---

This project follows basic accessibility standards for all documented
content and user interfaces.

Guidelines for Markdown documentation:

- Headings follow a clear hierarchy (h1 → h2 → h3 — no level skipped)
- All images have meaningful alt texts (`![Description](image.png)`)
- Link labels are descriptive (`[Installation guide](...)` instead of `[here](...)`)
- Code blocks specify the language (` ```bash `, ` ```powershell `)
- Tables have header rows for all columns
- No information is conveyed through colour alone

## Spec-kit-Workflow / Spec-kit Workflow

Neue Features in diesem Workspace werden nach dem **Specification-Driven Development (SDD)**-Workflow entwickelt.
Der Workflow verwendet das `speckit`-CLI-Tool (GitHub Copilot Skill).

Schritte für ein neues Feature:

1. **Spezifikation erstellen** — `speckit specify "Feature-Name"` → `specs/{branch}/spec.md`
2. **Klärungsfragen** — `speckit clarify` → offene Fragen in `spec.md` beantworten
3. **Implementierungsplan** — `speckit plan` → `specs/{branch}/plan.md`
4. **Aufgabenliste** — `speckit tasks` → `specs/{branch}/tasks.md`
5. **Implementieren** — `speckit implement` → Aufgaben aus `tasks.md` abarbeiten
6. **Validieren** — `bash scripts/check-homogeneity.sh` → Compliance-Score prüfen

Alle Spec-Artefakte werden im Branch-Verzeichnis `specs/{branch}/` gespeichert und versioniert.

---

New features in this workspace are developed following the **Specification-Driven Development (SDD)** workflow.
The workflow uses the `speckit` CLI tool (GitHub Copilot Skill).

Steps for a new feature:

1. **Create specification** — `speckit specify "Feature Name"` → `specs/{branch}/spec.md`
2. **Clarification questions** — `speckit clarify` → answer open questions in `spec.md`
3. **Implementation plan** — `speckit plan` → `specs/{branch}/plan.md`
4. **Task list** — `speckit tasks` → `specs/{branch}/tasks.md`
5. **Implement** — `speckit implement` → work through tasks in `tasks.md`
6. **Validate** — `bash scripts/check-homogeneity.sh` → check compliance score

All spec artefacts are stored and versioned in the branch directory `specs/{branch}/`.
