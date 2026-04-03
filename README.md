# home-baseline

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur.
Es enthält die Bootstrap-Scripts, mit denen jedes neue Projektverzeichnis in wenigen
Sekunden als synchronisiertes privates GitHub-Repository eingerichtet werden kann.

*This repository is the **top level** of the private workspace infrastructure.
It contains bootstrap scripts to set up any new project directory as a synchronised
private GitHub repository within seconds.*

---

## Inhaltsverzeichnis / Table of Contents

- [Workspace-Übersicht](#workspace-übersicht--workspace-overview)
- [Was ist dieses Template-Repo?](#was-ist-dieses-template-repo--what-is-this-template-repo)
- [Voraussetzungen](#voraussetzungen--prerequisites)
- [Neuen Workspace einrichten](#neuen-workspace-einrichten--create-new-workspace)
- [Ersteinrichtung auf einem neuen Gerät](#ersteinrichtung-dieses-repos-auf-einem-neuen-gerät--initial-setup-on-a-new-device)
- [Template-Entwickler-Workflow](#template-entwickler-workflow--template-developer-workflow)
- [Inhalt / Dateien](#inhalt--contents)
- [Homogeneity Guardian — Kurzreferenz](#workspace-homogeneity-guardian--kurzreferenz--quick-reference)
- [Plattform-Übersicht](#plattform-übersicht--platform-overview)
- [Für Auszubildende der Fachinformatik](#für-auszubildende-der-fachinformatik--for-it-apprentices)
- [Barrierefreiheit (A11Y)](#barrierefreiheit--accessibility-a11y)
- [Spec-kit-Workflow](#spec-kit-workflow--spec-kit-workflow)

---

## Workspace-Übersicht / Workspace overview

| Verzeichnis | GitHub-Repo | Eingerichtet mit |
|---|---|---|
<!-- workspace-table-end -->

---

## Was ist dieses Template-Repo? / What is this template repo?

Dieses Repository ist ein **GitHub Template-Repository**. Das bedeutet: Anstelle eines
klassischen Forks kann jeder, der dieses Repo als Ausgangsbasis nutzen möchte, über den
Button **„Use this template"** ein eigenes, vollständig unabhängiges Repository erstellen —
ohne die Commit-History des Originals zu erben und ohne eine dauerhafte Verbindung zum
Original-Repository.

*This repository is a **GitHub Template Repository**. Instead of a classic fork, anyone who
wants to use this as a starting point can click **"Use this template"** to create their own
fully independent repository — without inheriting the original commit history and without
any permanent connection to the source.*

### Unterschied Fork vs. Template / Fork vs. Template

| | Fork | Template (dieses Repo) |
|---|---|---|
| Git-History | wird mitkopiert | **nicht** kopiert — frischer Start |
| Verbindung zum Original | bleibt bestehen | **keine** Verbindung |
| PRs zum Original möglich | ja | nein (bewusst getrennt) |
| Eigener Namespace | fork-URL | frei wählbar |
| Typischer Einsatz | Mitarbeit am Original | Eigene unabhängige Instanz |

### So nutzt du dieses Template / How to use this template

1. Auf [github.com/YOUR_USERNAME/home-baseline](https://github.com/YOUR_USERNAME/home-baseline) gehen
2. Button **„Use this template"** → **„Create a new repository"** klicken
3. Eigenen Repository-Namen und Sichtbarkeit (Private empfohlen) wählen
4. Repo klonen und die [Ersteinrichtung](#ersteinrichtung-dieses-repos-auf-einem-neuen-gerät--initial-setup-on-a-new-device) durchführen

> **Hinweis für Auszubildende:** Ihr erhaltet vom Ausbilder die URL des Template-Repos.
> Erstellt euer eigenes Repo über „Use this template" — ihr seid dann vollständig unabhängig
> und könnt nichts am Original kaputtmachen.
>
> *Note for apprentices: You will receive the template repo URL from your trainer.
> Create your own repo via "Use this template" — you are then completely independent
> and cannot break anything in the original.*

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

## Template-Entwickler-Workflow / Template Developer Workflow

Dieser Abschnitt richtet sich an Personen, die **dieses Repo selbst weiterentwickeln** — also neue Scripts, Checks oder Dokumentation hinzufügen möchten.

*This section is for people who want to **contribute to this template repo** — adding new scripts, checks, or documentation.*

### Einmalig auf jeder neuen Maschine / One-time setup per machine

```bash
# macOS / Linux / Ubuntu
git clone https://github.com/YOUR_USERNAME/home-baseline.git ~/home-baseline-tmp
bash ~/home-baseline-tmp/scripts/sync-home.sh --no-pull
```

```powershell
# Windows (PowerShell Core >= 7)
git clone https://github.com/YOUR_USERNAME/home-baseline.git ~/home-baseline-tmp
pwsh ~/home-baseline-tmp/scripts/sync-home.ps1 -NoPull
```

> **Hinweis / Note:** `--no-pull` / `-NoPull` überspringt `git pull`, da der Klon gerade frisch erstellt wurde.

---

### Täglich / nach Änderungen synchronisieren / Daily sync

```bash
# macOS / Linux / Ubuntu — pull + kopieren + Commit in ~/
bash ~/scripts/sync-home.sh
```

```powershell
# Windows
pwsh ~/scripts/sync-home.ps1
```

---

### Änderungen am Template entwickeln / Develop template changes

```bash
# 1. In den Klon wechseln
cd ~/home-baseline-tmp

# 2. Änderungen vornehmen (z. B. SDD via specs/ + .specify/)

# 3. Compliance prüfen
bash scripts/check-homogeneity.sh .     # macOS / Linux
# pwsh scripts/check-homogeneity.ps1   # Windows

# 4. Committen und pushen
git add -A
git commit -m "feat: ..."
git push

# 5. Sofort in ~/ übernehmen (kein erneutes pull nötig)
bash ~/scripts/sync-home.sh --no-pull
# pwsh ~/scripts/sync-home.ps1 -NoPull  # Windows
```

---

### Optionen sync-home / sync-home options

| Flag (Bash / PowerShell)       | Bedeutung / Meaning                          |
|-------------------------------|----------------------------------------------|
| `--no-pull` / `-NoPull`       | Kein `git pull` — nur kopieren / Skip pull   |
| `--no-commit` / `-NoCommit`   | Nur kopieren, kein Commit in `~/` / Copy only |
| `--dry-run` / `-WhatIf`       | Nur anzeigen, nichts schreiben / Preview only |

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

## Für Auszubildende der Fachinformatik / For IT Apprentices

Willkommen! Dieser Abschnitt führt dich als **Auszubildende/r der Fachinformatik**
Schritt für Schritt durch die Einrichtung deiner Entwicklungsumgebung — ohne Vorkenntnisse
und nur mit freien, kostenlosen Tools.

*Welcome! This section guides you as an **IT apprentice** through setting up your
development environment step by step — no prior knowledge required, free tools only.*

---

### Was passiert hier überhaupt? / What is this about?

Bevor du mit der eigentlichen Programmierung beginnst, richtest du dein **Home-Verzeichnis**
(`~/` — das ist dein persönliches Benutzerverzeichnis auf dem Computer) als Git-Repository ein.
Das klingt komplizierter als es ist. Konkret bedeutet es:

- Alle wichtigen Konfigurationsdateien und Scripts liegen an einem zentralen Ort
- Du kannst deine Konfiguration jederzeit wiederherstellen, falls etwas schiefgeht
- Der **Workspace Homogeneity Guardian** prüft automatisch, ob alles korrekt eingerichtet ist

*Before you start actual programming, you set up your **home directory** (`~/` — your personal
user directory) as a Git repository. This sounds more complicated than it is. Concretely it means:
your configuration files and scripts are in one central place, you can restore them at any time,
and the Homogeneity Guardian automatically checks that everything is set up correctly.*

---

### Schritt 0: Werkzeuge installieren / Step 0: Install tools

Diese Programme brauchst du. Installiere sie in dieser Reihenfolge.

*You need these programs. Install them in this order.*

#### Ubuntu / Linux

```bash
# Git — Versionsverwaltung (speichert Änderungen an Dateien)
sudo apt update && sudo apt install -y git

# ripgrep — schnelle Textsuche (wird vom Compliance-Scanner benötigt)
sudo apt install -y ripgrep

# GitHub CLI — kommuniziert mit GitHub von der Kommandozeile aus
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
  sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
sudo apt update && sudo apt install -y gh

# Einmalig bei GitHub anmelden (Browser öffnet sich automatisch)
gh auth login
```

#### macOS

```bash
# Homebrew installieren (falls noch nicht vorhanden)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Tools installieren
brew install git ripgrep gh

# Einmalig bei GitHub anmelden
gh auth login
```

#### Windows (PowerShell als Administrator)

```powershell
# Git, ripgrep und GitHub CLI installieren
winget install --id Git.Git
winget install --id BurntSushi.ripgrep.MSVC
winget install --id GitHub.cli

# PowerShell Core 7 installieren (Windows braucht das für die ps1-Scripts)
winget install --id Microsoft.PowerShell

# Neues Terminal öffnen, dann bei GitHub anmelden
gh auth login
```

> **Was macht `gh auth login`?** Es verbindet dein Terminal mit deinem GitHub-Account.
> Ein Browser-Fenster öffnet sich, du meldest dich an und bestätigst. Danach können
> die Scripts automatisch GitHub-Repositories für dich erstellen.
>
> *What does `gh auth login` do? It connects your terminal to your GitHub account.
> A browser window opens, you log in and confirm. After that, scripts can automatically
> create GitHub repositories for you.*

---

### Schritt 1: Template-Repo auf GitHub kopieren / Step 1: Copy template repo on GitHub

1. Öffne die URL, die du von deinem Ausbilder erhalten hast (z. B. `https://github.com/AUSBILDER/home-baseline`)
2. Klicke auf den grünen Button **„Use this template"** → **„Create a new repository"**
3. Wähle einen Namen (z. B. `home-baseline`) und stelle die Sichtbarkeit auf **Private**
4. Klicke **„Create repository"**

Du hast jetzt dein eigenes Repo! Die URL lautet: `https://github.com/DEIN_USERNAME/home-baseline`

*You now have your own repo! The URL is: `https://github.com/YOUR_USERNAME/home-baseline`*

---

### Schritt 2: Repo auf dem Computer einrichten / Step 2: Set up repo on your computer

Öffne ein Terminal (macOS/Linux: **Terminal**-App; Windows: **PowerShell 7**).

*Open a terminal (macOS/Linux: Terminal app; Windows: PowerShell 7).*

#### Ubuntu / macOS

```bash
# In dein Home-Verzeichnis wechseln
cd ~

# Repo klonen (DEIN_USERNAME ersetzen!)
git clone https://github.com/DEIN_USERNAME/home-baseline.git home-baseline-tmp

# Sync-Script ausführen — kopiert alles an die richtigen Stellen
bash ~/home-baseline-tmp/scripts/sync-home.sh --no-pull

# Compliance-Check — zeigt dir, ob alles korrekt ist
bash ~/scripts/check-homogeneity.sh ~/
```

#### Windows (PowerShell 7)

```powershell
# In dein Home-Verzeichnis wechseln
Set-Location ~

# Repo klonen (DEIN_USERNAME ersetzen!)
git clone https://github.com/DEIN_USERNAME/home-baseline.git home-baseline-tmp

# Sync-Script ausführen
pwsh ~/home-baseline-tmp/scripts/sync-home.ps1 -NoPull

# Compliance-Check
pwsh ~/scripts/check-homogeneity.ps1
```

> **Was passiert gerade?** Das `sync-home`-Script kopiert alle wichtigen Dateien aus
> dem geklonten Repo an die richtigen Stellen in deinem Home-Verzeichnis und erstellt
> automatisch einen Git-Commit. Der anschließende `check-homogeneity`-Aufruf prüft,
> ob alles korrekt vorhanden ist.
>
> *What is happening? The `sync-home` script copies all important files from the
> cloned repo to the correct places in your home directory and automatically creates
> a Git commit. The `check-homogeneity` call then checks that everything is correctly present.*

**Ziel:** Score ≥ 90 % / *Goal: Score ≥ 90 %*

---

### Schritt 3: Ersten Workspace anlegen / Step 3: Create your first workspace

Ein **Workspace** ist ein Verzeichnis für eine Gruppe verwandter Projekte, z. B. alle
Projekte deiner Ausbildung. Das Script richtet es automatisch als GitHub-Repo ein.

*A **workspace** is a directory for a group of related projects, e.g. all projects of
your apprenticeship. The script sets it up automatically as a GitHub repo.*

```bash
# macOS / Linux / Ubuntu
bash ~/scripts/bootstrap-workspace.sh AusbildungsProjekte

# Windows
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName AusbildungsProjekte
```

Das Script erledigt automatisch:
1. Verzeichnis `~/AusbildungsProjekte/` erstellen
2. `git init` — Git-Versionsverwaltung aktivieren
3. Privates Repo auf GitHub erstellen
4. Scripts und Hooks kopieren
5. Ersten Commit und Push zu GitHub

*The script automatically: creates the directory, initialises Git, creates a private GitHub
repo, copies scripts and hooks, makes the first commit and pushes to GitHub.*

---

### Schritt 4: Compliance prüfen / Step 4: Check compliance

```bash
# macOS / Linux / Ubuntu
bash ~/scripts/check-homogeneity.sh ~/

# Windows
pwsh ~/scripts/check-homogeneity.ps1
```

Die Ausgabe zeigt dir für jede Datei und jeden Check, ob alles in Ordnung ist:
- `✓` — alles gut
- `WARN` — Warnung, sollte behoben werden
- `✗ FAIL` — Fehler, muss behoben werden

Am Ende siehst du einen **Score in Prozent**. Ziel ist ≥ 90 %.

*The output shows you for each file and check whether everything is in order.
At the end you see a score in percent. Goal is ≥ 90 %.*

---

### Häufige Fehler und Lösungen / Common errors and fixes

| Fehler / Error | Ursache / Cause | Lösung / Fix |
|---|---|---|
| `FAIL: file missing` | Pflichtdatei fehlt | `sync-home.sh` erneut ausführen |
| `WARN: bilingual-section-missing` | Kein DE+EN-Heading in Markdown | Abschnitt `## Überblick / Overview` eintragen |
| `WARN: hook-missing` | pre-push Hook nicht installiert | `bash ~/scripts/install-hooks.sh` |
| `rg: command not found` | ripgrep nicht installiert | `sudo apt install ripgrep` |
| `git: command not found` | Git nicht installiert | `sudo apt install git` |
| `Permission denied` | Berechtigungsproblem | `chown -R $USER .` ausführen |
| `gh: command not found` | GitHub CLI fehlt | Schritt 0 wiederholen |
| `fatal: not a git repository` | `git init` wurde nicht ausgeführt | `git init` im Verzeichnis ausführen |

---

### Neues Projekt anlegen / Create a new project

Wenn du ein konkretes Programmierprojekt starten möchtest:

```bash
# macOS / Linux / Ubuntu
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/AusbildungsProjekte

# Windows
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -WorkspaceDir ~/AusbildungsProjekte
```

Danach Compliance prüfen / Then check compliance:

```bash
bash ~/scripts/check-homogeneity.sh ~/AusbildungsProjekte
```

---

### Glossar / Glossary

| Begriff / Term | Erklärung / Explanation |
|---|---|
| **Repository / Repo** | Ein Verzeichnis unter Git-Versionsverwaltung — speichert alle Versionen deiner Dateien |
| **Commit** | Ein gespeicherter Snapshot deiner Änderungen mit einer Beschreibung |
| **Push** | Commits vom lokalen Computer zu GitHub hochladen |
| **Pull** | Änderungen von GitHub auf den lokalen Computer herunterladen |
| **Branch** | Ein paralleler Entwicklungszweig — Änderungen ohne den Hauptzweig zu berühren |
| **Hook** | Ein Script das automatisch bei bestimmten Git-Aktionen ausgeführt wird (z. B. vor einem Push) |
| **Compliance-Score** | Prozentualer Wert wie gut deine Umgebung den Standards entspricht |
| **Template-Repo** | Ein GitHub-Repo das als Vorlage dient — „Use this template" erstellt ein unabhängiges Kopie |
| **~/** | Kürzel für dein Home-Verzeichnis (z. B. `/home/deinname/` auf Linux) |

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
