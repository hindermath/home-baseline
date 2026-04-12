# home-baseline

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur.
Es enthält die Bootstrap-Scripts, mit denen jedes neue Projektverzeichnis in wenigen
Sekunden als synchronisiertes privates GitHub- oder GitLab-Repository eingerichtet werden kann.

*This repository is the **top level** of the private workspace infrastructure.
It contains bootstrap scripts to set up any new project directory as a synchronised
private GitHub or GitLab repository within seconds.*

---

## Inhaltsverzeichnis / Table of Contents

- [Workspace-Übersicht / Workspace overview](#workspace-übersicht--workspace-overview)
- [Was ist dieses Template-Repo? / What is this template repo?](#was-ist-dieses-template-repo--what-is-this-template-repo)
  - [Unterschied Fork vs. Template / Fork vs. Template](#unterschied-fork-vs-template--fork-vs-template)
  - [So nutzt du dieses Template / How to use this template](#so-nutzt-du-dieses-template--how-to-use-this-template)
  - [Template-Updates übernehmen / Syncing updates from the template](#template-updates-übernehmen--syncing-updates-from-the-template)
- [Voraussetzungen / Prerequisites](#voraussetzungen--prerequisites)
  - [Node.js ≥ 18](#5-nodejs--18-für-npm-basierte-ki-agenten--for-npm-based-ai-agents)
- [Neuen Workspace einrichten / Create new workspace](#neuen-workspace-einrichten--create-new-workspace)
  - [macOS / Linux](#macos--linux)
  - [Windows (PowerShell Core ≥ 7)](#windows-powershell-core--7)
- [Git Scope-Isolierung / Git Scope Isolation](#git-scope-isolierung--git-scope-isolation)
- [Ersteinrichtung dieses Repos auf einem neuen Gerät / Initial setup on a new device](#ersteinrichtung-dieses-repos-auf-einem-neuen-gerät--initial-setup-on-a-new-device)
  - [GitHub / GitLab-Authentifizierung / Authentication](#github--gitlab-authentifizierung--authentication)
  - [macOS / Linux](#macos--linux-1)
  - [Windows (PowerShell Core ≥ 7)](#windows-powershell-core--7-1)
  - [Nächste Schritte / Next steps](#nächste-schritte--next-steps)
- [Template-Entwickler-Workflow / Template Developer Workflow](#template-entwickler-workflow--template-developer-workflow)
  - [Einmalig auf jeder neuen Maschine / One-time setup per machine](#einmalig-auf-jeder-neuen-maschine--one-time-setup-per-machine)
  - [Täglich / nach Änderungen synchronisieren / Daily sync](#täglich--nach-änderungen-synchronisieren--daily-sync)
  - [Änderungen am Template entwickeln / Develop template changes](#änderungen-am-template-entwickeln--develop-template-changes)
  - [Optionen sync-home / sync-home options](#optionen-sync-home--sync-home-options)
  - [Releases und Versionierung / Releases & Versioning](#releases-und-versionierung--releases--versioning)
- [Inhalt / Contents](#inhalt--contents)
  - [Workspace-Bootstrap / Workspace Bootstrap](#workspace-bootstrap--workspace-bootstrap)
  - [Homogeneity Guardian](#homogeneity-guardian)
  - [Sicherheit / Security](#sicherheit--security)
  - [Versionierung / Versioning](#versionierung--versioning)
- [Workspace Homogeneity Guardian — Kurzreferenz / Quick Reference](#workspace-homogeneity-guardian--kurzreferenz--quick-reference)
  - [Compliance-Check](#compliance-check)
  - [STATS.md Baseline erzeugen / Generate STATS.md baseline](#statsmd-baseline-erzeugen--generate-statsmd-baseline)
  - [Bestehenden Workspace migrieren / Migrate existing workspace](#bestehenden-workspace-migrieren--migrate-existing-workspace)
  - [Constitution synchronisieren / Sync constitution](#constitution-synchronisieren--sync-constitution)
  - [Lastenheft umbenennen / Rename Lastenheft](#lastenheft-umbenennen--rename-lastenheft)
- [Plattform-Übersicht / Platform overview](#plattform-übersicht--platform-overview)
- [Für Auszubildende der Fachinformatik / For IT Apprentices](#für-auszubildende-der-fachinformatik--for-it-apprentices)
  - [Was passiert hier überhaupt? / What is this about?](#was-passiert-hier-überhaupt--what-is-this-about)
  - [Schritt 0: Werkzeuge installieren / Step 0: Install tools](#schritt-0-werkzeuge-installieren--step-0-install-tools)
  - [Schritt 1: Template-Repo auf GitHub kopieren / Step 1: Copy template repo on GitHub](#schritt-1-template-repo-auf-github-kopieren--step-1-copy-template-repo-on-github)
  - [Schritt 2: Repo auf dem Computer einrichten / Step 2: Set up repo on your computer](#schritt-2-repo-auf-dem-computer-einrichten--step-2-set-up-repo-on-your-computer)
  - [Schritt 3: Ersten Workspace anlegen / Step 3: Create your first workspace](#schritt-3-ersten-workspace-anlegen--step-3-create-your-first-workspace)
  - [Schritt 4: Compliance prüfen / Step 4: Check compliance](#schritt-4-compliance-prüfen--step-4-check-compliance)
  - [Schritt 5: KI-Agenten einrichten / Step 5: Set up AI agents](#schritt-5-ki-agenten-einrichten--step-5-set-up-ai-agents)
  - [Schritt 6: Spec-Kit einrichten / Step 6: Set up Spec-Kit](#schritt-6-spec-kit-einrichten--step-6-set-up-spec-kit)
  - [Häufige Fehler und Lösungen / Common errors and fixes](#häufige-fehler-und-lösungen--common-errors-and-fixes)
  - [Neues Projekt anlegen / Create a new project](#neues-projekt-anlegen--create-a-new-project)
  - [Glossar / Glossary](#glossar--glossary)
- [Spec-kit-Workflow / Spec-kit Workflow](#spec-kit-workflow--spec-kit-workflow)
  - [Was ist Specification-Driven Development (SDD)? / What is Specification-Driven Development (SDD)?](#was-ist-specification-driven-development-sdd--what-is-specification-driven-development-sdd)
  - [Was ist Spec-Kit? / What is Spec-Kit?](#was-ist-spec-kit--what-is-spec-kit)
  - [Voraussetzungen / Prerequisites](#voraussetzungen--prerequisites-1)
  - [KI-Agenten einrichten / Set up AI agents](#ki-agenten-einrichten--set-up-ai-agents)
  - [Verzeichnis für Spec-Kit vorbereiten / Prepare a directory](#verzeichnis-für-spec-kit-vorbereiten--prepare-a-directory)
  - [Der Workflow Schritt für Schritt / The workflow step by step](#der-workflow-schritt-für-schritt--the-workflow-step-by-step)
  - [Beispiel: Erstes Feature anlegen / Example: Creating your first feature](#beispiel-erstes-feature-anlegen--example-creating-your-first-feature)
  - [Artefakte und Verzeichnisstruktur / Artefacts and directory structure](#artefakte-und-verzeichnisstruktur--artefacts-and-directory-structure)
- [Barrierefreiheit / Accessibility (A11Y)](#barrierefreiheit--accessibility-a11y)

---

## Workspace-Übersicht / Workspace overview

| Verzeichnis | GitHub-Repo | Eingerichtet mit |
|---|---|---|
| `~/C64Projects/` | [c64-baseline](https://github.com/hindermath/c64-baseline) | `bootstrap-workspace` |
| `~/RiderProjects/` | [rider-baseline](https://github.com/hindermath/rider-baseline) | `bootstrap-workspace` |
| `~/DataGripProjects/` | [datagrip-baseline](https://github.com/hindermath/datagrip-baseline) | `bootstrap-workspace` |
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

*Git history: copied vs. not copied (fresh start) · Original connection: stays vs. none · PRs to original: yes vs. no · Namespace: fork-URL vs. freely chosen · Typical use: contribute to original vs. own independent instance.*

### So nutzt du dieses Template / How to use this template

**🇩🇪 Deutsch:**

1. Auf [github.com/hindermath/home-baseline](https://github.com/hindermath/home-baseline) gehen
2. Button **„Use this template"** → **„Create a new repository"** klicken
3. Eigenen Repository-Namen und Sichtbarkeit (Private empfohlen) wählen
4. Repo klonen und die [Ersteinrichtung](#ersteinrichtung-dieses-repos-auf-einem-neuen-gerät--initial-setup-on-a-new-device) durchführen

**🇬🇧 English:**

1. Go to [github.com/hindermath/home-baseline](https://github.com/hindermath/home-baseline)
2. Click **"Use this template"** → **"Create a new repository"**
3. Choose your repository name and visibility (Private recommended)
4. Clone the repo and follow the [initial setup](#ersteinrichtung-dieses-repos-auf-einem-neuen-gerät--initial-setup-on-a-new-device)

> **Hinweis für Auszubildende:** Ihr erhaltet vom Ausbilder die URL des Template-Repos.
> Erstellt euer eigenes Repo über „Use this template" — ihr seid dann vollständig unabhängig
> und könnt nichts am Original kaputtmachen.
>
> *Note for apprentices: You will receive the template repo URL from your trainer.
> Create your own repo via "Use this template" — you are then completely independent
> and cannot break anything in the original.*

---

### Template-Updates übernehmen / Syncing updates from the template

Da „Use this template" ein **unabhängiges Repo** ohne Upstream-Verbindung erstellt, gibt es keinen automatischen Update-Mechanismus. Updates (z. B. neue Scripts, CI-Fixes) müssen manuell übernommen werden.

*Since "Use this template" creates an **independent repo** with no upstream link, there is no automatic update mechanism. Updates (e.g. new scripts, CI fixes) must be pulled in manually.*

```bash
# 1. Template einmalig als Remote hinzufügen (one-time)
git remote add upstream https://github.com/hindermath/home-baseline.git

# 2. Änderungen vom Template holen
git fetch upstream

# 3. Beim ersten Mal: --allow-unrelated-histories nötig (keine gemeinsame History)
git merge upstream/main --allow-unrelated-histories

# 4. Bei späteren Updates (gemeinsame History vorhanden)
git merge upstream/main
```

> **Achtung / Warning:** Beim Merge können Konflikte in `README.md` oder Agenten-Dateien entstehen,
> die du bereits angepasst hast. Drei Strategien:
>
> *Conflicts may occur in `README.md` or agent files you have customised. Three strategies:*

**Strategie 1 / Strategy 1: Nur `scripts/` selektiv übernehmen (empfohlen / recommended)**

```bash
git fetch upstream

# Nur scripts/ aus dem Template übernehmen — eigene Dateien bleiben unangetastet
# Only take scripts/ from template — your own files stay untouched
git checkout upstream/main -- scripts/

# Änderungen prüfen und committen / Review and commit
git diff --staged
git commit -m "chore: scripts/ vom Template aktualisiert"
```

**Strategie 2 / Strategy 2: Vorher schauen was sich geändert hat**

```bash
git fetch upstream

# Was hat sich im Template geändert? / What changed in the template?
git log upstream/main --oneline --not HEAD

# Diff nur für scripts/ anzeigen / Show diff for scripts/ only
git diff HEAD upstream/main -- scripts/

# Diff für README anzeigen / Show diff for README
git diff HEAD upstream/main -- README.md
```

**Strategie 3 / Strategy 3: Einzelne Commits cherry-picken**

```bash
git fetch upstream

# Commit-History des Templates ansehen / View template commit history
git log upstream/main --oneline

# Nur einen bestimmten Commit übernehmen / Cherry-pick a specific commit
git cherry-pick <commit-sha>
```

> Dateien mit eigenen Anpassungen (`README.md`, `AGENTS.md`, `CLAUDE.md` usw.) am besten
> **nicht** per `git checkout upstream/main -- README.md` überschreiben, sondern manuell
> vergleichen und gewünschte Passagen herauskopieren.
>
> *Files with your own customisations (`README.md`, agent files etc.) should **not** be
> overwritten with `git checkout upstream/main -- README.md`. Instead compare manually
> and copy over only the desired passages.*

---

## Voraussetzungen / Prerequisites



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

### 2b. GitLab CLI (`glab`) *(optional — nur für GitLab-Platform / only for GitLab platform)*

Wird nur benötigt, wenn du `--platform gitlab` verwendest.

*Only required when using `--platform gitlab`.*

| Plattform | Installation |
|---|---|
| macOS | `brew install glab` |
| Linux | [gitlab.com/gitlab-org/cli](https://gitlab.com/gitlab-org/cli) → Installationsanleitung |
| Windows | `winget install --id GitLab.GLAB` |

Nach der Installation einmalig anmelden / After installation, log in once:

```bash
glab auth login
```

> ⚠️ `glab auth login` muss in einem **interaktiven Terminalfenster** gestartet werden — nicht aus einem Hintergrund- oder Async-Prozess heraus.
>
> *Must be run in an interactive terminal window — not from a background or async process.*

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

### 5. Node.js ≥ 18 *(für npm-basierte KI-Agenten / for npm-based AI agents)*

Wird für die Installation von **Gemini CLI** und **Codex CLI** via `npm` benötigt. Claude Code hat einen eigenen nativen Installer und benötigt Node.js **nicht** mehr.

*Required to install **Gemini CLI** and **Codex CLI** via `npm`. Claude Code has its own native installer and no longer requires Node.js.*

| Plattform | Installation |
|---|---|
| macOS | `brew install node` oder [nodejs.org](https://nodejs.org/en/download) |
| Linux | `sudo apt install nodejs npm` / `sudo dnf install nodejs` |
| Windows | `winget install --id OpenJS.NodeJS.LTS` oder [nodejs.org](https://nodejs.org/en/download) |

Nach der Installation prüfen / Verify installation:

```bash
node --version   # ≥ 18 erwartet
npm --version
```

> **Tipp / Tip:** Bei einer systemweiten Node.js-Installation unter Linux (via `apt`/`dnf`) ist `sudo` für globale npm-Pakete erforderlich. Alternativ empfiehlt sich [nvm](https://github.com/nvm-sh/nvm) — damit entfällt `sudo`:
> ```bash
> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
> nvm install --lts
> ```
> *On Linux with a system-wide Node.js installation, `sudo` is required for global npm packages. Alternatively, use [nvm](https://github.com/nvm-sh/nvm) to avoid `sudo`.*

### 6. Empfohlene PowerShell-Module *(optional, einmalig / optional, once)*

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

The bootstrap process automatically handles:
1. Detecting existing sub-repos and adding them to `.gitignore`
2. Copying standard scripts (`scan-agent-secrets`, `install-hooks`, `pre-push` hook)
3. `git init` + initial commit
4. Creating a private GitHub repo (`gh repo create`)
5. Pushing to GitHub
6. Installing Git hooks

---

## Git Scope-Isolierung / Git Scope Isolation

<!-- EN: Git Scope Isolation -->

Jeder Workspace erhält seine eigene Git-Konfigurationsdatei unter `~/.gitconfig.d/`. Die globale `~/.gitconfig` enthält nur noch allgemeine Einstellungen und `[includeIf]`-Verweise auf diese workspace-spezifischen Dateien.

*Each workspace gets its own git configuration fragment under `~/.gitconfig.d/`. The global `~/.gitconfig` contains only general settings and `[includeIf]` pointers to these workspace-specific files.*

### Mechanismus / Mechanism

Git's `includeIf "gitdir:..."` Direktive lädt automatisch die passende `.inc`-Datei, wenn git in einem bestimmten Verzeichnis ausgeführt wird:

```ini
# ~/.gitconfig (global — von sync-home verwaltet / managed by sync-home)
[user]
    name  = Your Name
    email = your@global.example

[includeIf "gitdir:~/home-baseline-tmp/"]
    path = ~/.gitconfig.d/home-baseline.inc

[includeIf "gitdir:~/MyProjects/"]
    path = ~/.gitconfig.d/myprojects.inc
```

```ini
# ~/.gitconfig.d/home-baseline.inc (workspace-spezifisch / workspace-specific)
[user]
    email = work@company.example
```

### Globale vs. workspace-spezifische Einstellungen / Global vs. workspace-specific settings

| Einstellung / Setting | Speicherort / Location |
|---|---|
| `user.name`, `user.email` (global) | `~/.gitconfig` |
| `init.defaultBranch`, `pull.rebase`, `core.autocrlf` | `~/.gitconfig` |
| `user.email` (workspace-spezifisch / workspace-specific) | `~/.gitconfig.d/<workspace>.inc` |
| `core.sshCommand`, Workspace-Aliases | `~/.gitconfig.d/<workspace>.inc` |

### Einrichtung / Setup

```bash
# macOS / Linux — sync-home erstellt ~/.gitconfig.d/ automatisch:
bash ~/scripts/sync-home.sh --no-pull

# Workspace-E-Mail überschreiben / Override workspace email:
nano ~/.gitconfig.d/home-baseline.inc
# [user]
#   email = work@company.example

# Verifikation / Verification:
git -C ~/home-baseline-tmp config user.email   # → work@company.example
git config --show-origin user.email             # → zeigt ~/.gitconfig.d/home-baseline.inc
git -C ~/MyProjects config user.email           # → globaler Default / global default
```

### Untracked — Sicherheitsmodell / Security model

`~/.gitconfig.d/` wird **nicht** von home-baseline getrackt — nur du hast Zugriff. Der `pre-push`-Hook prüft diese Dateien auf Credential-Muster und blockiert Pushes bei Fund.

*`~/.gitconfig.d/` is **not** tracked by home-baseline — only you have access. The `pre-push` hook scans these files for credential patterns and blocks pushes if found.*

---

## Ersteinrichtung dieses Repos auf einem neuen Gerät / Initial setup on a new device

> **Für wen?** Dieser Abschnitt richtet sich an **Auszubildende und End-User**, die das Template genutzt haben und ihr eigenes Repo auf einem neuen Gerät einrichten möchten. Als Template-Entwickler (`hindermath`) nutze stattdessen den [Template-Entwickler-Workflow](#template-entwickler-workflow--template-developer-workflow).
>
> *Who is this for? This section is for **apprentices and end-users** who used the template and want to set up their own repo on a new device. As the template author (`hindermath`), use the [Template Developer Workflow](#template-entwickler-workflow--template-developer-workflow) instead.*

### GitHub / GitLab-Authentifizierung / Authentication

Stelle auf dem neuen Gerät sicher, dass du bei deinem Git-Hoster authentifiziert bist, **bevor** du klonst.

*On the new device, make sure you are authenticated with your Git hosting provider **before** cloning.*

**GitHub:**

```bash
# macOS / Linux
gh auth login        # GitHub.com → HTTPS → Browser auswählen
gh auth setup-git    # git Credential-Helper konfigurieren
```

```powershell
# Windows — in einem interaktiven Terminalfenster ausführen (NICHT im Hintergrundprozess!)
gh auth login        # GitHub.com → HTTPS → Browser auswählen
gh auth setup-git    # git Credential-Helper konfigurieren
```

> ⚠️ **Windows:** `gh auth login` muss in einem **interaktiven Terminalfenster** gestartet werden — nicht aus Copilot CLI oder einem anderen Hintergrundprozess heraus.
>
> *Must be run in an interactive terminal window — not from Copilot CLI or any background process.*

**GitLab:**

```bash
# Option A — glab CLI (falls installiert / if installed):
glab auth login

# Option B — Personal Access Token (PAT) direkt beim Klonen eingeben:
# git clone https://gitlab.com/YOUR_USERNAME/home-baseline.git home-baseline-tmp
# → Benutzername / username:  YOUR_USERNAME
# → Passwort / password:      DEIN_PAT  (Scope: read_repository + write_repository)
```

> ⚠️ **macOS / Linux / Windows:** `glab auth login` muss in einem **interaktiven Terminalfenster** gestartet werden — nicht aus einem Hintergrund- oder Async-Prozess heraus.
>
> *Must be run in an interactive terminal window — not from a background or async process.*

---

### macOS / Linux

```bash
cd ~
# Mit git:
git clone https://github.com/YOUR_USERNAME/home-baseline.git home-baseline-tmp
# Alternativ mit gh CLI (falls installiert und angemeldet / alternatively with gh CLI):
# gh repo clone YOUR_USERNAME/home-baseline home-baseline-tmp

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

# Remote-Repo verbinden / Connect remote repo
git remote add origin https://github.com/YOUR_USERNAME/home-baseline.git
# GitLab-Alternative / GitLab alternative:
# git remote add origin https://gitlab.com/YOUR_USERNAME/home-baseline.git
# Self-hosted GitLab / self-hosted GitLab:
# git remote add origin https://gitlab.example.com/YOUR_USERNAME/home-baseline.git
git push -u origin main

# Compliance prüfen
bash ~/scripts/check-homogeneity.sh ~/
```

### Windows (PowerShell Core >= 7)

```powershell
Set-Location ~
# Mit git:
git clone https://github.com/YOUR_USERNAME/home-baseline.git home-baseline-tmp
# Alternativ mit gh CLI (falls installiert und angemeldet / alternatively with gh CLI):
# gh repo clone YOUR_USERNAME/home-baseline home-baseline-tmp

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

# Remote-Repo verbinden / Connect remote repo
git remote add origin https://github.com/YOUR_USERNAME/home-baseline.git
# GitLab-Alternative / GitLab alternative:
# git remote add origin https://gitlab.com/YOUR_USERNAME/home-baseline.git
# Self-hosted GitLab / self-hosted GitLab:
# git remote add origin https://gitlab.example.com/YOUR_USERNAME/home-baseline.git
git push -u origin main

# Compliance prüfen
pwsh ~/scripts/check-homogeneity.ps1
```

### Workspaces auf neuem Gerät wiederherstellen / Restoring workspaces on a new device

Wenn du deine Umgebung auf einem zweiten Gerät (z. B. Wechsel von macOS zu Windows) einrichtest, fehlen dort zunächst die lokalen Git-Scope-Einstellungen (`.inc`-Dateien in `~/.gitconfig.d/`). Da diese Dateien aus Sicherheitsgründen nicht synchronisiert werden, musst du sie einmalig regenerieren.

*When setting up your environment on a second device, the local Git scope settings (`.inc` files) are missing. Since these are not synchronized for security reasons, you must regenerate them once.*

**Ablauf / Procedure:**

1.  **Workspaces klonen / Clone workspaces:**
    Klone deine bestehenden Workspace-Repositories (z. B. `c64-baseline`, `rider-baseline`) manuell in die entsprechenden Ordner in deinem Home-Verzeichnis (z. B. `~/C64Projects`, `~/RiderProjects`).
    
    *Clone your existing workspace repositories manually into their respective folders in your home directory.*

2.  **Migration ausführen / Run migration:**
    Starte das Migrations-Skript. Es erkennt automatisch alle vorhandenen Workspace-Ordner, legt die fehlenden `.inc`-Dateien an und trägt die `includeIf`-Verweise in deine globale `.gitconfig` ein.

    *Run the migration script. It automatically detects all existing workspace folders, creates the missing `.inc` files, and adds the `includeIf` entries to your global `.gitconfig`.*

    ```bash
    # macOS / Linux
    bash ~/scripts/migrate-workspace.sh --yes
    ```

    ```powershell
    # Windows (PowerShell Core)
    pwsh ~/scripts/migrate-workspace.ps1 -Force
    ```

3.  **Verifikation / Verification:**
    Prüfe mit dem Homogeneity Guardian, ob alle Scopes korrekt erkannt wurden.

    *Use the Homogeneity Guardian to verify that all scopes have been correctly identified.*

    ```bash
    bash ~/scripts/check-homogeneity.sh ~/
    ```

### Nächste Schritte / Next steps

Die Einrichtung ist abgeschlossen. Hier ist die empfohlene Reihenfolge für eine vollständige Entwicklungsumgebung.

*Setup is complete. Here is the recommended sequence for a full development environment.*

**1 — Workspace anlegen / Create a workspace**

```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh FlutterProjects
bash ~/scripts/bootstrap-workspace.sh FlutterProjects --platform gitlab
bash ~/scripts/bootstrap-workspace.sh FlutterProjects --platform gitlab --gitlab-url https://gitlab.example.com
bash ~/scripts/check-homogeneity.sh ~/FlutterProjects
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -Platform gitlab
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -Platform gitlab -GitLabUrl https://gitlab.example.com
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/FlutterProjects
```

> Das Script erledigt automatisch / The script handles automatically:
> `git init` · initialer Commit · `gh repo create` **oder** `glab repo create` (privates Remote-Repo) · Remote `origin` setzen · `git push`
>
> *Without `--platform`, GitHub remains the default. With `--platform gitlab`, the same bootstrap flow targets GitLab instead.*

**2 — Projekt anlegen / Create a project**

```bash
# macOS / Linux
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform gitlab
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform gitlab --no-remote
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform gitlab --gitlab-url https://gitlab.example.com --preview
bash ~/scripts/check-homogeneity.sh ~/FlutterProjects
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform gitlab
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform gitlab -NoRemote
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform gitlab -GitLabUrl https://gitlab.example.com -Preview
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/FlutterProjects
```

> Das Script erledigt automatisch / The script handles automatically:
> `git init` · initialer Commit · `gh repo create` **oder** `glab repo create` (privates Remote-Repo) · Remote `origin` setzen · `git push`
>
> *For self-hosted GitLab, pass `--gitlab-url` / `-GitLabUrl` so the remote URL, summary output, and `~/README.md` entry all point to the custom host.*

**2b — Workspace oder Projekt entfernen / Remove a workspace or project** *(bei Bedarf / when needed)*

```bash
# macOS / Linux
bash ~/scripts/teardown-workspace.sh FlutterProjects
bash ~/scripts/teardown-workspace.sh FlutterProjects --backup        # Archiv vor Löschung
bash ~/scripts/teardown-workspace.sh FlutterProjects --keep-remote   # Remote behalten
bash ~/scripts/teardown-workspace.sh FlutterProjects --recursive     # inkl. Level-2-Projekte
bash ~/scripts/teardown-workspace.sh FlutterProjects --dry-run       # Vorschau
# Kurzform via bootstrap-workspace / shorthand via bootstrap-workspace:
bash ~/scripts/bootstrap-workspace.sh --teardown FlutterProjects
```

```powershell
# Windows
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName FlutterProjects
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName FlutterProjects -Backup
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName FlutterProjects -KeepRemote
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName FlutterProjects -Recursive
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
```

> Reihenfolge der destruktiven Aktionen: Backup → Sicherheitsprüfung → Remote löschen → Verzeichnis löschen → Artefakte bereinigen (`~/README.md`, `~/.gitignore`, `~/.gitconfig`).
> Workspace-Name `home-baseline` ist geschützt und kann nicht entfernt werden.
>
> *Order of destructive actions: backup → safety check → delete remote → delete directory → clean artifacts (`~/README.md`, `~/.gitignore`, `~/.gitconfig`).
> The workspace name `home-baseline` is protected and cannot be removed.*

**3 — KI-Agenten einrichten / Set up AI agents**

→ [KI-Agenten einrichten / Set up AI agents](#ki-agenten-einrichten--set-up-ai-agents)

Installiere mindestens einen KI-Agenten (GitHub Copilot CLI, Claude Code, Codex, Gemini CLI, OpenCode) nach der jeweiligen Anleitung.

*Install at least one AI agent (GitHub Copilot CLI, Claude Code, Codex, Gemini CLI, OpenCode) following the respective instructions.*

**3b — Claude Code statusLine einrichten / Set up Claude Code status line** *(optional)*

```bash
# macOS / Linux
bash ~/scripts/setup-claude-settings.sh
```

```powershell
# Windows
pwsh ~/scripts/setup-claude-settings.ps1
```

Zeigt Modell, Arbeitsverzeichnis, Git-Branch und Rate-Limits in der Claude Code Statuszeile an. Auf weiteren Geräten erneut ausführen (`--force` / `-Force` zum Überschreiben).

*Displays model, working directory, git branch and rate limits in the Claude Code status bar. Re-run on additional devices (`--force` / `-Force` to overwrite).*

**3c — Codex CLI status_line einrichten / Set up Codex CLI status_line** *(optional)*

```bash
# macOS / Linux
bash ~/scripts/setup-codex-settings.sh
```

```powershell
# Windows
pwsh -NoProfile ~/scripts/setup-codex-settings.ps1
```

Setzt die Codex-TUI-Statuszeile in `~/.codex/config.toml` aus einer zentralen Vorlage im Repo. Auf weiteren Geräten erneut ausführen (`--force` / `-Force` zum Überschreiben).

*Sets the Codex TUI status line in `~/.codex/config.toml` from a central template in the repository. Re-run on additional devices (`--force` / `-Force` to overwrite).*

**3d — Gemini CLI status_line einrichten / Set up Gemini CLI status_line** *(optional)*

```bash
# macOS / Linux
bash ~/scripts/setup-gemini-settings.sh
```

```powershell
# Windows
pwsh -NoProfile ~/scripts/setup-gemini-settings.ps1
```

Setzt die Gemini-TUI-Statuszeile in `~/.gemini/config.toml` aus einer zentralen Vorlage im Repo. Auf weiteren Geräten erneut ausführen (`--force` / `-Force` zum Überschreiben).

*Sets the Gemini TUI status line in `~/.gemini/config.toml` from a central template in the repository. Re-run on additional devices (`--force` / `-Force` to overwrite).*

---

### Fehlerbehebung mit KI-Unterstützung / Troubleshooting with AI support

Sollte ein Skript mit einem Fehler abbrechen, kannst du deinen installierten KI-Agenten direkt im Terminal bitten, das Problem zu analysieren oder den Vorgang abzuschließen.

*If a script fails, you can ask your AI agent directly in the terminal to analyze the issue or complete the process.*

| Agent | Kommando / Command |
|---|---|
| **GitHub Copilot** | `gh copilot -p "Skript X ist bei Schritt Y abgebrochen. Bitte prüfe den Status und schließe die Einrichtung ab."` |
| **Claude Code** | `claude "Der Push zu GitHub ist fehlgeschlagen. Bitte prüfe die Remotes und hole den Push nach."` |
| **Codex CLI** | `codex "Analysiere den letzten Fehler im Terminal und schlage eine Lösung vor."` |
| **Gemini CLI** | `gemini -p "Vervollständige die Git-Konfiguration, da das Bootstrap-Skript vorzeitig beendet wurde."` |
| **OpenCode** | `opencode --prompt "Prüfe, ob alle Git-Hooks und .inc-Dateien korrekt angelegt wurden."` |

> **Tipp / Tip:** Nutze das Flag `--help` (z. B. `claude --help`, `gemini --help` oder `opencode --help`), um weitere Informationen zu den verfügbaren Befehlen deines Agenten zu erhalten.
>
> *Use the `--help` flag to learn more about the available commands for your specific agent.*

---

**4 — Spec-Kit einrichten / Set up Spec-Kit**

→ [Spec-kit-Workflow](#spec-kit-workflow--spec-kit-workflow)

Spec-Kit strukturiert die Zusammenarbeit mit KI-Agenten per Specification-Driven Development (SDD). Einrichten mit `specify init`, sobald mindestens ein Agent installiert ist.

*Spec-Kit structures collaboration with AI agents via Specification-Driven Development (SDD). Set up with `specify init` once at least one agent is installed.*

---

## Template-Entwickler-Workflow / Template Developer Workflow

Dieser Abschnitt richtet sich an **`hindermath`** — also die Person, die dieses Template-Repo selbst weiterentwickelt und auf mehreren Geräten (z. B. Windows + WSL Ubuntu) arbeitet.

*This section is for **`hindermath`** — the person maintaining this template repo across multiple machines (e.g. Windows + WSL Ubuntu).*

### Einmalig auf jeder neuen Maschine / One-time setup per machine

```bash
# macOS / Linux / Ubuntu (auch WSL)
# Mit git:
git clone https://github.com/hindermath/home-baseline.git ~/home-baseline-tmp
# Alternativ mit gh CLI (falls installiert und angemeldet / alternatively with gh CLI):
# gh repo clone hindermath/home-baseline ~/home-baseline-tmp
bash ~/home-baseline-tmp/scripts/install-hooks.sh   # pre-push Hook im Klon installieren
bash ~/home-baseline-tmp/scripts/sync-home.sh --no-pull
```

```powershell
# Windows (PowerShell Core >= 7)
# Mit git:
git clone https://github.com/hindermath/home-baseline.git ~/home-baseline-tmp
# Alternativ mit gh CLI (falls installiert und angemeldet / alternatively with gh CLI):
# gh repo clone hindermath/home-baseline ~/home-baseline-tmp
pwsh ~/home-baseline-tmp/scripts/install-hooks.ps1   # pre-push Hook im Klon installieren
pwsh ~/home-baseline-tmp/scripts/sync-home.ps1 -NoPull
```

> **Hinweis / Note:** `--no-pull` / `-NoPull` überspringt `git pull`, da der Klon gerade frisch erstellt wurde. `install-hooks` installiert den `pre-push`-Hook in `home-baseline-tmp/.git/hooks/` — ohne diesen Schritt meldet `check-homogeneity` ein WARN.

---

### Plattform-Test / Platform test

Da Outputs zwischen verschiedenen Maschinen nicht direkt ins Terminal kopiert werden können, gibt es plattformspezifische Test-Scripts — sie sammeln System-Info und Compliance-Ergebnisse, committen und pushen die Ergebnisse direkt ins Repo.

*Since outputs cannot easily be copy-pasted between machines, platform-specific test scripts collect system info and compliance results, then commit and push them directly to the repo.*

| Plattform / Platform | Script | Ausgabe / Output |
|---|---|---|
| macOS | `bash ~/home-baseline-tmp/scripts/mac-test.sh` | `mac-test-output.txt` |
| Linux / WSL | `bash ~/home-baseline-tmp/scripts/linux-test.sh` | `linux-test-output.txt` |
| Windows | `pwsh ~/home-baseline-tmp/scripts/windows-test.ps1` | `windows-test-output.txt` |

Jedes Script erfasst / Each script collects:
- OS-Version, Architektur
- Installierte Tools (`git`, `gh`, `rg`, `pwsh`, `node`, `uv`, `python3`, `specify`)
- Paketmanager (`brew` / `apt`/`dnf` / `winget`)
- Ergebnis von `sync-home` und `check-homogeneity`

Danach liegt die Ausgabedatei im Repo und kann von jedem anderen Gerät direkt gelesen und ausgewertet werden — z. B. von Copilot CLI unter Windows:

*After running, the output file is in the repo and can be read and evaluated from any other device — e.g. by Copilot CLI on Windows:*

```powershell
git -C "$HOME\home-baseline-tmp" pull
Get-Content "$HOME\home-baseline-tmp\windows-test-output.txt"  # oder mac-test-output.txt, linux-test-output.txt
```

---

### Täglich / nach Änderungen synchronisieren / Daily sync

```bash
# macOS / Linux / Ubuntu — pull + kopieren + Commit in ~/
bash ~/scripts/sync-home.sh
# Das Script erkennt ~/home-baseline-tmp automatisch als Quelle.

# Optional: Compliance prüfen / Optional: check compliance
bash ~/scripts/check-homogeneity.sh ~/
```

```powershell
# Windows — pull + kopieren + Commit in ~/
pwsh ~/scripts/sync-home.ps1
# Das Script erkennt ~/home-baseline-tmp automatisch als Quelle.

# Optional: Compliance prüfen / Optional: check compliance
pwsh ~/scripts/check-homogeneity.ps1
```

---

### Änderungen am Template entwickeln / Develop template changes

**Mit KI-Agent / With AI agent:**

```bash
# 1. In den Klon wechseln
cd ~/home-baseline-tmp

# 2. KI-Agent starten — der Agent macht Änderungen, committet und pusht selbst
claude      # Claude Code
# gemini    # Gemini CLI
# codex     # OpenAI Codex
# opencode  # OpenCode

# 3. Nach dem Push des Agenten: ~/ synchronisieren
bash ~/scripts/sync-home.sh --no-pull
# pwsh ~/scripts/sync-home.ps1 -NoPull  # Windows
```

**Manuell / Manually:**

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

### Releases und Versionierung / Releases & Versioning

Releases werden automatisch durch **[Release Please](https://github.com/googleapis/release-please-action)** erstellt — Grundlage sind die [Conventional Commits](https://www.conventionalcommits.org/).

*Releases are created automatically by **[Release Please](https://github.com/googleapis/release-please-action)** based on [Conventional Commits](https://www.conventionalcommits.org/).*

| Commit-Präfix / Prefix | Versions-Bump |
|---|---|
| `fix:`, `docs:`, `chore:` | Patch: `0.3.1 → 0.3.2` |
| `feat:` | Minor: `0.3.1 → 0.4.0` |
| `feat!:` oder `BREAKING CHANGE` | Major: `0.3.x → 1.0.0` |

**Ablauf / Flow:**

1. Commits auf `main` pushen
2. Release Please öffnet automatisch einen **Release PR** (`chore(main): release X.Y.Z`) und aktualisiert `CHANGELOG.md` sowie `.release-please-manifest.json`
3. PR mergen → Git-Tag + GitHub Release werden erstellt

*1. Push commits to `main`. 2. Release Please opens or updates a Release PR automatically. 3. Merge the PR → Git tag + GitHub Release are created.*

---

## Inhalt / Contents

### Workspace-Bootstrap / Workspace Bootstrap

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/bootstrap-workspace.sh` | Neues Workspace einrichten (Bash) |
| `scripts/bootstrap-workspace.ps1` | Neues Workspace einrichten (PowerShell Core) |
| `scripts/bootstrap-project.sh` | Neues Projekt in einem Workspace anlegen (Bash) |
| `scripts/bootstrap-project.ps1` | Neues Projekt in einem Workspace anlegen (PowerShell Core) |
| `scripts/teardown-workspace.sh` | Workspace sicher entfernen: Remote, lokales Verzeichnis, Artefakte (Bash) |
| `scripts/teardown-workspace.ps1` | Workspace-Teardown (PowerShell Core) |

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

### Versionierung / Versioning

| Datei / File | Beschreibung / Description |
|---|---|
| `.github/workflows/release-please.yml` | Release Please — erstellt Release PRs automatisch bei jedem Push auf `main` |
| `release-please-config.json` | Konfiguration: `release-type: simple`, bilinguale Changelog-Sektionen |
| `.release-please-manifest.json` | Aktuell getrackte Version — wird von Release Please automatisch aktualisiert |
| `CHANGELOG.md` | Versionsverlauf nach [Keep a Changelog](https://keepachangelog.com/) — von Release Please verwaltet |

### Sicherheit / Security

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/scan-agent-secrets.sh` | Secret-Scan für KI-Agenten-Verzeichnisse (Bash) |
| `scripts/scan-agent-secrets.ps1` | Secret-Scan (PowerShell Core) |
| `scripts/install-hooks.sh` | Git-Hooks installieren (Bash) |
| `scripts/install-hooks.ps1` | Git-Hooks installieren (PowerShell Core) |
| `scripts/hooks/pre-push` | Pre-Push Hook: blockiert Push bei Secrets |

### Claude Code Einrichtung / Claude Code Setup

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-claude-settings.sh` | Claude Code statusLine in `~/.claude/settings.json` einrichten (Bash) |
| `scripts/setup-claude-settings.ps1` | Claude Code statusLine in `%APPDATA%\Claude\settings.json` einrichten (PowerShell Core) |

### Codex CLI Einrichtung / Codex CLI Setup

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-codex-settings.sh` | Codex CLI `status_line` in `~/.codex/config.toml` einrichten (Bash) |
| `scripts/setup-codex-settings.ps1` | Codex CLI `status_line` in `~/.codex/config.toml` einrichten (PowerShell Core) |
| `scripts/templates/codex-statusline.toml` | Zentrale Vorlage fuer die Codex-Statuszeile |
| `scripts/setup-gemini-settings.sh` | Gemini CLI `status_line` in `~/.gemini/config.toml` einrichten (Bash) |
| `scripts/setup-gemini-settings.ps1` | Gemini CLI `status_line` in `~/.gemini/config.toml` einrichten (PowerShell Core) |
| `scripts/templates/gemini-statusline.toml` | Zentrale Vorlage fuer die Gemini-Statuszeile |

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

Herzlich willkommen in deiner Ausbildung! Dieser Abschnitt ist speziell für dich geschrieben. Er führt dich Schritt für Schritt durch die Einrichtung deiner professionellen Entwicklungsumgebung. Wir fangen ganz vorne an — du brauchst kein Vorwissen.

*Welcome to your apprenticeship! This section is written specifically for you. It guides you step by step through setting up your professional development environment. We start from scratch — no prior knowledge required.*

---

### Was machen wir hier eigentlich? / What is this all about?

In der IT arbeiten wir oft mit vielen verschiedenen Projekten. Damit du nicht den Überblick verlierst und deine Arbeit sicher gespeichert ist, nutzen wir eine **automatisierte Infrastruktur**.

Hier sind die drei wichtigsten Konzepte, die du heute lernst:

1.  **Das Terminal (die Kommandozeile):** Dein wichtigstes Werkzeug. Anstatt mit der Maus zu klicken, gibst du dem Computer direkte Textbefehle. Das ist schneller, präziser und lässt sich automatisieren.
2.  **Git (Versionsverwaltung):** Wie eine „Zeitmaschine“ für deinen Code. Du speicherst Zwischenstände (Commits). Wenn etwas schiefgeht, kannst du jederzeit zu einem funktionierenden Stand zurückkehren.
3.  **GitHub / GitLab (Die Cloud):** Hier wird dein Code sicher im Internet gespeichert. So kannst du von verschiedenen Computern daran arbeiten und deine Arbeit mit anderen teilen.

**Wichtig für dich:** Dein **Home-Verzeichnis** (auf dem Mac/Linux als `~/` abgekürzt) ist dein persönlicher Bereich auf dem Computer. Wir richten diesen Bereich jetzt so ein, dass er sich „selbst verwaltet“.

---

### Schritt 0: Deine Werkzeuge vorbereiten / Step 0: Preparing your tools

Bevor wir starten, müssen wir die „Handwerker-Kiste“ füllen. Wir installieren Programme, die im Hintergrund arbeiten.

*Before we start, we need to fill the "toolbox". We install programs that work in the background.*

#### Welches Betriebssystem nutzt du?

| Windows (PowerShell 7) | macOS (Terminal) | Linux / Ubuntu |
|---|---|---|
| Nutze die **PowerShell 7**. Sie ist viel mächtiger als die alte Eingabeaufforderung (CMD). | Nutze die **Terminal-App** (in den Dienstprogrammen). | Nutze das Standard-Terminal deiner Distribution. |

#### Installation der Werkzeuge

**1. Git:** Die Zeitmaschine für deinen Code.
**2. GitHub CLI (`gh`):** Ein Werkzeug, mit dem du GitHub direkt aus dem Terminal steuern kannst.
**3. ripgrep (`rg`):** Ein extrem schneller Suchdienst für Texte in Dateien.

> **Anleitung für Windows (PowerShell als Administrator):**
> ```powershell
> winget install --id Git.Git
> winget install --id GitHub.cli
> winget install --id BurntSushi.ripgrep.MSVC
> winget install --id Microsoft.PowerShell
> ```
> *Nach der Installation: Schließe das Fenster und öffne eine neue **PowerShell 7**.*

> **Anleitung für macOS (Terminal):**
> ```bash
> # Installiert Homebrew (den "App Store" für Entwickler)
> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
> # Installiert die Tools
> brew install git gh ripgrep
> ```

**Wichtig: Bei GitHub anmelden!**
Gib diesen Befehl ein und folge den Anweisungen im Browser:
```bash
gh auth login
```
*Wähle: GitHub.com → HTTPS → Yes (Authenticate Git) → Login with a web browser.*

---

### Schritt 1: Dein eigenes Template erstellen / Step 1: Create your own template

Wir nutzen ein „Template“ (eine Vorlage). Das ist wie ein vorgefertigtes Formular, das du für dich kopierst.

1.  Öffne im Browser die Vorlage, die dein Ausbilder dir gegeben hat (z. B. `hindermath/home-baseline`).
2.  Klicke oben rechts auf den grünen Button **„Use this template“** → **„Create a new repository“**.
3.  **Name:** Gib ihm einen Namen (z. B. `meine-it-umgebung`).
4.  **Sichtbarkeit:** Wähle **Private**. Das ist wichtig, damit nur du deinen Code sehen kannst.
5.  Klicke auf **„Create repository“**.

Du hast nun deine eigene Kopie in der Cloud! Die Adresse (URL) sieht so aus: `https://github.com/DEIN_NAME/meine-it-umgebung`.

---

### Schritt 2: Deinen Computer mit der Cloud verbinden / Step 2: Connect your computer

Jetzt bringen wir die Dateien aus der Cloud auf deinen Computer und richten alles ein.

*Now we bring the files from the cloud to your computer and set everything up.*

**Erklärung der Befehle:**
- `cd ~`: „Change Directory to Home“ — Wir gehen in dein persönliches Verzeichnis.
- `git clone ...`: Wir laden eine Kopie deines Repos herunter.
- `bash` / `pwsh`: Wir führen ein Skript aus, das die ganze Arbeit für uns macht.

#### Für macOS / Linux:
```bash
cd ~
# Lade dein Repo (Ersetze DEIN_NAME und REPO_NAME!)
git clone https://github.com/DEIN_NAME/REPO_NAME.git home-baseline-tmp

# Starte die Einrichtung (sync-home kopiert alle Scripte)
bash ~/home-baseline-tmp/scripts/sync-home.sh --no-pull

# Aufräumen (wir brauchen den temporären Ordner nicht mehr)
rm -rf home-baseline-tmp
```

#### Für Windows:
```powershell
Set-Location ~
# Lade dein Repo
git clone https://github.com/DEIN_NAME/REPO_NAME.git home-baseline-tmp

# Starte die Einrichtung
pwsh ~/home-baseline-tmp/scripts/sync-home.ps1 -NoPull

# Aufräumen
Remove-Item home-baseline-tmp -Recurse -Force
```

---

### Schritt 3: Deinen ersten "Workspace" anlegen / Step 3: Create your first workspace

Ein **Workspace** ist wie ein großer Aktenordner für ein bestimmtes Thema (z. B. „Berufsschule“ oder „C-Sharp-Kurs“). Jedes Mal, wenn du einen neuen Workspace anlegst, erstellt das System automatisch ein passendes, privates Repository auf GitHub für dich.

*A workspace is like a large folder for a specific topic. The system automatically creates a matching private repo on GitHub for you.*

**Befehl ausführen:**
```bash
# Erstellt einen Workspace für deine Ausbildungsprojekte
bash ~/scripts/bootstrap-workspace.sh Ausbildung
```
*(Auf Windows nutzt du `pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung`)*

**Was ist gerade passiert?**
1.  Ein Ordner `~/Ausbildung` wurde erstellt.
2.  Ein privates Repo namens `ausbildung-baseline` wurde auf GitHub für dich angelegt.
3.  Wichtige Schutz-Scripte (Git-Hooks) wurden installiert, damit du keine Passwörter aus Versehen hochlädst.

---

### Schritt 4: Dein erstes Projekt starten / Step 4: Start your first project

Innerhalb deines Workspaces legst du nun deine eigentlichen Programmier-Projekte an.

```bash
# Ein Projekt namens "HalloWelt" im Workspace "Ausbildung" erstellen
bash ~/scripts/bootstrap-project.sh HalloWelt ~/Ausbildung
```

Ab jetzt arbeitest du in diesem Ordner: `cd ~/Ausbildung/HalloWelt`. Hier schreibst du deinen Code.

---

### Schritt 5: Arbeiten mit der KI (Dein Mentor) / Step 5: Working with AI (Your Mentor)

Du bist nicht allein! Wir haben KI-Agenten installiert, die dir helfen können. Wenn ein Befehl nicht funktioniert oder du eine Frage zum Code hast, frag sie einfach direkt im Terminal.

**Beispiel für eine Frage:**
`gh copilot -p "Ich habe eine Fehlermeldung bei git push erhalten. Was bedeutet das?"`

Oder wenn ein Skript abgebrochen ist:
`claude "Das bootstrap-workspace Skript ist hängengeblieben. Kannst du prüfen, ob alles fertig ist?"`

---

### Häufige Begriffe für den Start / Common terms for beginners

- **Pfad (Path):** Die Adresse einer Datei auf dem Computer (z. B. `C:\Users\Name\Projekt` oder `~/Projekt`).
- **Skript (Script):** Eine Textdatei mit Befehlen, die der Computer nacheinander ausführt.
- **Commit:** Ein „Speicherpunkt“. Wie bei einem Videospiel, bevor du gegen einen Boss kämpfst.
- **Push:** Deine lokalen Speicherpunkte ins Internet (GitHub) hochladen.
- **Root:** Die oberste Ebene (das „Wurzelverzeichnis“).

---

## Spec-kit-Workflow / Spec-kit Workflow

### Was ist Specification-Driven Development (SDD)? / What is Specification-Driven Development (SDD)?

**Specification-Driven Development (SDD)** ist ein Arbeitsansatz, bei dem du *bevor* du eine Zeile Code schreibst eine strukturierte Spezifikation erstellst — unterstützt von einem KI-Agenten. Der Agent hilft dir dabei:

1. Die Anforderungen klar zu formulieren (`spec.md`)
2. Offene Fragen zu identifizieren und zu klären (`clarify`)
3. Einen konkreten Implementierungsplan zu erstellen (`plan.md`)
4. Die Implementierung in handhabbare Aufgaben aufzuteilen (`tasks.md`)
5. Die Aufgaben Schritt für Schritt umzusetzen (`implement`)

> **Warum SDD?**  
> Ohne Spezifikation entstehen oft Missverständnisse, unfertige Features und unnötiger Code. Mit SDD weißt du immer, was als Nächstes zu tun ist — und warum.

*SDD is a workflow where you create a structured specification — supported by an AI agent — before writing a single line of code.*

---

### Was ist Spec-Kit? / What is Spec-Kit?

**Spec-Kit** ist ein KI-Agenten-Skill-System, das den SDD-Workflow automatisiert. Es ist in diesem Repository bereits vollständig vorkonfiguriert und unterstützt mehrere KI-Agenten (GitHub Copilot, Claude, Gemini, Codex, OpenCode).

Die Spec-Kit-Skills befinden sich unter `.agents/skills/` und werden beim Klonen des Repos automatisch mitgeliefert.  
**Eine separate Installation ist nicht nötig** — du brauchst nur deinen bevorzugten KI-Agenten.

*Spec-Kit is an AI agent skill system that automates the SDD workflow. It is fully pre-configured in this repository. No separate download is needed — you only need your preferred AI agent.*

---

### Voraussetzungen / Prerequisites

| Voraussetzung | Pflicht? | Wozu / Why |
|---|:---:|---|
| `git` ≥ 2.30 | ✅ | Feature-Branches; Spec-Artefakte werden versioniert |
| GitHub-Account | ✅ | Repo-Hosting |
| KI-Agent (mind. einer) | ✅ | Führt die Spec-Kit-Skills aus |
| `uv` (Python) | ✅ | Installiert `specify-cli` (das Spec-Kit-CLI) |
| Node.js ≥ 18 | für npm-Agenten | Gemini CLI, Codex CLI installieren (Claude Code: nicht nötig) |
| `gh` CLI | empfohlen | GitHub Copilot CLI; Issues aus Tasks anlegen |

Alle Voraussetzungen werden beim ersten Aufruf von `check-prerequisites.sh` geprüft.

---

### KI-Agenten einrichten / Set up AI agents

Je nachdem welchen KI-Agenten du bevorzugst, sind unterschiedliche Schritte nötig.  
Dieses Repo unterstützt alle fünf nachfolgend beschriebenen Agenten.

*Depending on which AI agent you prefer, different setup steps are needed. This repo supports all five agents described below.*

#### GitHub Copilot CLI (empfohlen / recommended)

Spec-Kit-Skills in `.agents/skills/` werden von der Copilot CLI automatisch erkannt — keine weitere Einrichtung nötig.

*Spec-Kit skills in `.agents/skills/` are automatically discovered by the Copilot CLI — no further setup needed.*

> **Voraussetzung / Prerequisite:** GitHub CLI `gh` (s. Abschnitt [§ 2. GitHub CLI](#2-github-cli-gh))

```bash
# Alle Plattformen / All platforms
# 1. Copilot-Extension installieren (einmalig / one-time)
gh extension install github/gh-copilot

# 2. Anmelden (falls noch nicht geschehen / if not already done)
gh auth login

# 3. Copilot CLI in deinem Projektverzeichnis starten
gh copilot
```

> Skills werden automatisch aus `.agents/skills/` geladen.  
> Aufruf im Chat: `/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, …

→ Nächster Schritt / Next step: [Spec-Kit initialisieren / Initialize Spec-Kit](#spec-kit-initialisieren--initialize-spec-kit)

---

#### Claude Code

Claude erkennt Spec-Kit-Kommandos über das `.claude/commands/`-Verzeichnis automatisch.

*Claude automatically discovers Spec-Kit commands via `.claude/commands/`.*

> **Voraussetzung / Prerequisite:** Anthropic-Account (Pro, Max, Teams oder Enterprise) — kein Node.js nötig.
>
> *An Anthropic account (Pro, Max, Teams or Enterprise) is required — Node.js is not needed.*

| Plattform | Installation |
|---|---|
| macOS / Linux / WSL | `curl -fsSL https://claude.ai/install.sh \| bash` |
| macOS / Linux (Homebrew) | `brew install --cask claude-code` |
| Windows PowerShell | `irm https://claude.ai/install.ps1 \| iex` |
| Windows (WinGet) | `winget install Anthropic.ClaudeCode` |

```bash
# 1. Claude Code installieren
# macOS / Linux / WSL (nativer Installer / native installer):
curl -fsSL https://claude.ai/install.sh | bash
# macOS / Linux (Homebrew, falls installiert / if Homebrew is installed):
# brew install --cask claude-code
# Windows PowerShell:
# irm https://claude.ai/install.ps1 | iex
# Windows (WinGet / alternativ):
# winget install Anthropic.ClaudeCode

# 2. Anmelden (Browser öffnet sich beim ersten Start automatisch)
claude

# 3. In deinem Projektverzeichnis starten
claude
```

Weitere Infos: [code.claude.com/docs/de/setup](https://code.claude.com/docs/de/setup)

→ Nächster Schritt / Next step: [Spec-Kit initialisieren / Initialize Spec-Kit](#spec-kit-initialisieren--initialize-spec-kit)

---

#### Gemini CLI

Gemini erkennt Spec-Kit-Kommandos über das `.gemini/commands/`-Verzeichnis automatisch.

*Gemini automatically discovers Spec-Kit commands via `.gemini/commands/`.*

> **Voraussetzung / Prerequisite:** Node.js ≥ 18, Google-Account

| Plattform | Installation |
|---|---|
| macOS | `npm install -g @google/gemini-cli` |
| Linux | `sudo npm install -g @google/gemini-cli` |
| Windows | `npm install -g @google/gemini-cli` |

```bash
# 1. Gemini CLI installieren
# macOS / Windows:
npm install -g @google/gemini-cli
# Linux:
sudo npm install -g @google/gemini-cli

# 2. Authentifizieren (Browser öffnet sich automatisch)
gemini auth login

# 3. In deinem Projektverzeichnis starten
gemini
```

Weitere Infos: [github.com/google-gemini/gemini-cli](https://github.com/google-gemini/gemini-cli)

→ Nächster Schritt / Next step: [Spec-Kit initialisieren / Initialize Spec-Kit](#spec-kit-initialisieren--initialize-spec-kit)

---

#### Codex CLI (OpenAI)

Codex liest `AGENTS.md` als Kontext-Datei; alle Spec-Kit-Artefakte (`spec.md`, `plan.md`, `tasks.md`) stehen als Eingabe zur Verfügung.

*Codex reads `AGENTS.md` as project context; all Spec-Kit artefacts are available as input.*

> **Voraussetzung / Prerequisite:** Node.js ≥ 18, OpenAI-Account (API-Key **oder** ChatGPT Plus/Pro/Business/Enterprise)

| Plattform | Installation |
|---|---|
| macOS | `npm install -g @openai/codex` |
| Linux | `sudo npm install -g @openai/codex` |
| Windows | `npm install -g @openai/codex` |

```bash
# 1. Codex CLI installieren
# macOS / Windows:
npm install -g @openai/codex
# Linux:
sudo npm install -g @openai/codex

# 2. Anmelden mit ChatGPT (Plus, Pro, Business oder Enterprise)
#    Browser öffnet sich automatisch / Browser opens automatically:
codex --login

# 3. Alternativ: API-Key setzen / Alternative: set API key (einmalig / one-time)
# macOS / Linux:
export OPENAI_API_KEY="sk-..."
# Windows (PowerShell):
$env:OPENAI_API_KEY = "sk-..."

# 4. In deinem Projektverzeichnis starten
codex
```

```bash
# 5. Optional: Codex status_line einrichten
# macOS / Linux:
bash ~/scripts/setup-codex-settings.sh
# Windows (PowerShell):
# pwsh -NoProfile ~/scripts/setup-codex-settings.ps1
```

Setzt `tui.status_line` in `~/.codex/config.toml` aus `scripts/templates/codex-statusline.toml`. Auf weiteren Geraeten erneut ausfuehren (`--force` / `-Force` zum Ueberschreiben).

*Sets `tui.status_line` in `~/.codex/config.toml` from `scripts/templates/codex-statusline.toml`. Re-run on additional devices (`--force` / `-Force` to overwrite).*

> **Hinweis Linux / Note Linux:** Beim ersten Start kann folgende Meldung erscheinen:
> `Codex could not find system bubblewrap on PATH. Please install bubblewrap with your package manager. Codex will use the vendored bubblewrap in the meantime.`
> Codex funktioniert trotzdem — zur Unterdrückung der Meldung: `sudo apt install bubblewrap` (Debian/Ubuntu) bzw. `sudo dnf install bubblewrap` (Fedora/RHEL).

> Tipp / Tip: Den API-Key dauerhaft in `~/.zshrc`, `~/.bashrc` oder dem Windows-Benutzerprofil eintragen, nicht im Repo speichern.

Weitere Infos: [github.com/openai/codex](https://github.com/openai/codex)

→ Nächster Schritt / Next step: [Spec-Kit initialisieren / Initialize Spec-Kit](#spec-kit-initialisieren--initialize-spec-kit)

---

#### OpenCode

OpenCode liest ebenfalls `AGENTS.md` und unterstützt damit denselben Kontext wie Codex.

*OpenCode also reads `AGENTS.md` and therefore supports the same project context as Codex.*

> **Voraussetzung / Prerequisite:** Kein Node.js nötig — natives Binary / No Node.js required — native binary

| Plattform | Installation |
|---|---|
| macOS | `brew install anomalyco/tap/opencode` |
| Linux (brew) | `brew install anomalyco/tap/opencode` |
| Linux (curl) | `curl -fsSL https://opencode.ai/install \| sh` |
| Windows | `iwr https://opencode.ai/install.ps1 \| iex` (PowerShell) |

```bash
# macOS / Linux (wenn Homebrew installiert ist / if Homebrew is installed)
brew install anomalyco/tap/opencode

# Linux (ohne Homebrew / without Homebrew)
curl -fsSL https://opencode.ai/install | sh

# In deinem Projektverzeichnis starten / Start in your project directory
opencode
```

```powershell
# Windows (PowerShell 7+)
iwr https://opencode.ai/install.ps1 | iex

# Starten
opencode
```

Weitere Infos: [opencode.ai](https://opencode.ai)  
GitHub: [github.com/sst/opencode](https://github.com/sst/opencode)

→ Nächster Schritt / Next step: [Spec-Kit initialisieren / Initialize Spec-Kit](#spec-kit-initialisieren--initialize-spec-kit)

---

### Verzeichnis für Spec-Kit vorbereiten / Prepare a directory

#### `uv` und `specify-cli` installieren / Install `uv` and `specify-cli`

`specify` benötigt den Python-Paketmanager `uv`. Installiere zuerst `uv`, dann `specify-cli`:

*`specify` requires the Python package manager `uv`. Install `uv` first, then `specify-cli`:*

| Plattform | `uv` installieren |
|---|---|
| macOS | `brew install uv` |
| Linux | `curl -LsSf https://astral.sh/uv/install.sh \| sh` |
| Windows | `winget install --id astral-sh.uv` (oder `pip install uv`) |

```bash
# Option 1: Persistente Installation (empfohlen / recommended)
# vX.Y.Z durch den aktuellen Release-Tag ersetzen / replace vX.Y.Z with the latest tag
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@vX.Y.Z

# Upgrade auf neue Version / Upgrade to new version
uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git@vX.Y.Z

# Option 2: Einmalige Nutzung ohne Installation / One-time usage without installing
uvx --from git+https://github.com/github/spec-kit.git@vX.Y.Z specify init --here --ai copilot

# Installation prüfen / Verify installation
specify check
```

> Den aktuellen Release-Tag findest du unter: [github.com/github/spec-kit/releases](https://github.com/github/spec-kit/releases)  
> Dokumentation: [github.github.io/spec-kit](https://github.github.io/spec-kit/)

---

#### Spec-Kit initialisieren / Initialize Spec-Kit

Initialisiere Spec-Kit in einem **bestehenden** Projektverzeichnis (`--here`) oder lege ein **neues** Verzeichnis an:

*Initialize Spec-Kit in an **existing** directory (`--here`) or create a **new** project directory:*

```bash
# Neues Projektverzeichnis anlegen / Create new project directory
specify init MeinProjekt --ai copilot

# In bestehendem Verzeichnis initialisieren / Initialize in existing directory
cd ~/MeinProjekt

# GitHub Copilot CLI
specify init --here --ai copilot

# Claude Code
specify init --here --ai claude

# Gemini CLI
specify init --here --ai gemini

# Codex  (--ai-skill nur für Codex nötig / --ai-skill required for Codex only)
specify init --here --ai codex --ai-skill

# OpenCode
specify init --here --ai opencode
```

> **Hinweis zu `--ai-skill`:**  
> Dieser Parameter installiert Spec-Kit-Skills in `.agents/skills/` und ist derzeit **nur für Codex** erforderlich. Alle anderen Agenten richten ihre Integrationspfade automatisch ein.  
> *The `--ai-skill` flag installs Spec-Kit skills into `.agents/skills/` and is currently required **only for Codex**. Other agents set up their paths automatically.*

> **Tipp / Tip:** `bootstrap-workspace.sh` / `bootstrap-workspace.ps1` richtet all das automatisch ein.  
> *Using `bootstrap-workspace.sh` / `bootstrap-workspace.ps1` sets everything up automatically.*

---

### Der Workflow Schritt für Schritt / The workflow step by step

Alle Kommandos werden im **Chat-Interface** deines KI-Agenten eingegeben (nicht im Terminal).

*All commands are entered in the chat interface of your AI agent (not in the terminal).*

```text
┌─────────────────────────────────────────────────────────────┐
│  SDD-Workflow mit Spec-Kit                                  │
├─────┬───────────────────────────────────────────────────────┤
│  1  │  speckit.specify "Feature-Beschreibung"               │
│     │  → Erstellt specs/{branch}/spec.md + Git-Branch       │
├─────┼───────────────────────────────────────────────────────┤
│  2  │  speckit.clarify                                      │
│     │  → Identifiziert Lücken, stellt Klärungsfragen        │
├─────┼───────────────────────────────────────────────────────┤
│  3  │  speckit.plan                                         │
│     │  → Erstellt specs/{branch}/plan.md                    │
├─────┼───────────────────────────────────────────────────────┤
│  4  │  speckit.checklist                                    │
│     │  → Erstellt individuelle Feature-Checkliste           │
├─────┼───────────────────────────────────────────────────────┤
│  5  │  speckit.tasks                                        │
│     │  → Erstellt specs/{branch}/tasks.md                   │
├─────┼───────────────────────────────────────────────────────┤
│  6  │  speckit.analyze                                      │
│     │  → Prüft Konsistenz: spec.md, plan.md, tasks.md       │
├─────┼───────────────────────────────────────────────────────┤
│  7  │  speckit.implement                                    │
│     │  → Führt alle Tasks aus tasks.md aus                  │
├─────┼───────────────────────────────────────────────────────┤
│  8  │  bash scripts/check-homogeneity.sh .                  │
│     │  → Exit 0 = keine FAILs (100 % Pflicht-Checks)        │
└─────┴───────────────────────────────────────────────────────┘
```

#### Weitere Spec-Kit-Kommandos / Additional commands

| Kommando | Beschreibung / Description |
|---|---|
| `speckit.analyze` | Konsistenz-Check über alle Artefakte (spec.md, plan.md, tasks.md) |
| `speckit.checklist` | Individuelle Feature-Checkliste generieren |
| `speckit.constitution` | Projekt-Verfassung (`constitution.md`) erstellen oder aktualisieren |
| `speckit.taskstoissues` | Tasks als GitHub Issues anlegen |

---

### Beispiel: Erstes Feature anlegen / Example: Creating your first feature

Das folgende Beispiel zeigt den vollständigen Ablauf für ein Login-Feature.

*The following example shows the complete flow for a login feature.*

```text
Du (im Copilot-Chat):
  speckit.specify "Login-Funktion mit GitHub OAuth"

Copilot:
  → Erstellt Branch:  001-login-github-oauth
  → Erstellt Datei:   specs/001-login-github-oauth/spec.md
  → Öffnet spec.md zur gemeinsamen Bearbeitung

Du:
  speckit.clarify

Copilot:
  → Analysiert spec.md
  → Stellt 3 Klärungsfragen, z. B.:
     "Welche OAuth-Scopes soll die App anfordern?"
     "Soll Refresh-Token-Rotation aktiviert sein?"

Du: (beantwortest die Fragen im Chat)

Du:
  speckit.plan

Copilot:
  → Erstellt: specs/001-login-github-oauth/plan.md
  → Enthält: Architektur, Dateistruktur, Abhängigkeiten

Du:
  speckit.checklist

Copilot:
  → Erstellt individuelle Checkliste für das Feature
  → Enthält: Akzeptanzkriterien, Testpunkte, Randfälle

Du:
  speckit.tasks

Copilot:
  → Erstellt: specs/001-login-github-oauth/tasks.md
  → Enthält: geordnete Task-Liste mit Abhängigkeiten

Du:
  speckit.analyze

Copilot:
  → Prüft Konsistenz zwischen spec.md, plan.md und tasks.md
  → Meldet Lücken oder Widersprüche vor der Implementierung

Du:
  speckit.implement

Copilot:
  → Arbeitet alle Tasks ab, erstellt Code und Commits
```

---

### Artefakte und Verzeichnisstruktur / Artefacts and directory structure

Nach einem vollständigen Spec-Kit-Workflow sieht das `specs/`-Verzeichnis so aus:

```text
specs/
└── 001-login-github-oauth/
    ├── spec.md          ← Anforderungen und Akzeptanzkriterien
    ├── plan.md          ← Implementierungsplan und Architektur
    ├── tasks.md         ← Geordnete Task-Liste
    ├── research.md      ← Recherche-Ergebnisse (optional)
    ├── data-model.md    ← Datenmodell (optional)
    ├── quickstart.md    ← Schnellstart-Guide (optional)
    └── contracts/       ← API-/CLI-Kontrakte (optional)
        └── api.md
```

Alle Artefakte werden automatisch in Git versioniert — du kannst jederzeit nachvollziehen, wie eine Entscheidung entstanden ist.

*All artefacts are automatically versioned in Git — you can always trace back how a decision was made.*

---

<!-- EN: README.md placeholder
[DE-Zusammenfassung: Vollständige bilinguale README für home-baseline mit Workspace-Tabelle, Scripts, A11Y-, Spec-kit- und Azubis-Abschnitten.]
-->

## Bekannte Fallstricke / Known Pitfalls

| Problem | Ursache | Fix |
|---|---|---|
| `$env:HOME` leer (Windows) | PS7 `??` fängt `''` nicht ab | `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` |
| CI: Dateien „missing" | Relativer Pfad als CWD=Repo-Root | `cd "$(dirname $GITHUB_WORKSPACE)"` vor Scanner-Aufruf |
| `bash` bad substitution | `${#arr[@]+...}` auf Ubuntu 22.04 | Bash-3-sichere `for`-Schleife zum Zählen |
| `Copy-Item` kopiert Verzeichnis in Verzeichnis | Ziel existiert bereits | `Copy-Item src/* dst/ -Recurse -Force` |
| `LICENSE` von `.gitignore` ignoriert | Whitelist-Modell | `!LICENSE` in `.gitignore` eintragen |
| ANSI-Falsch-Positive im Scanner | Scanner enthält `\033[` als Literal | `check-homogeneity.*` aus ANSI-Scan ausschließen |
| Bootstrap hardcodierter Username | `hindermath` war fest eingebaut | `gh api user --jq '.login'` dynamisch |
| `gh auth login --web` bleibt hängen | Browser-Callback kommt in Hintergrundprozessen nicht an | In **interaktivem Terminal** ausführen |
| `glab auth login` bleibt hängen | Gleiche Ursache wie `gh` — Browser-Callback im Hintergrund nicht möglich | In **interaktivem Terminal** ausführen |
| `gh` keyring invalid (Windows) | Windows Credential Store korrupt | `gh auth logout` + `gh auth login` neu; dann `gh auth setup-git` |
| `ssh-agent` startet nicht (Windows) | Service deaktiviert, Admin-Rechte nötig | HTTPS + `gh auth setup-git` statt SSH verwenden |
| `CursorPosition`-Fehler in PS-Subprozessen | PowerShell-Profil (Oh-My-Posh) lädt im Subprocess | `-NoProfile` zu `pwsh -File`-Aufrufen hinzufügen |
| `git pull` „divergent branches" (Linux) | Kein globales rebase-Config | `git config --global pull.rebase true` |
| Push rejected: `fetch first` | Remote ist neuer als local | `git pull --rebase --autostash && git push` |
| Test-Script: unstaged changes blockieren pull | Output-Datei wird vor pull geschrieben | `git pull --rebase --autostash origin main` in Test-Scripts |


## Barrierefreiheit / Accessibility (A11Y)

Dieses Dokument richtet sich nach **WCAG 2.2 Level AA** für alle statischen Inhalte.

*This document follows **WCAG 2.2 Level AA** guidelines for all static content.*

| WCAG-Kriterium / Criterion | Umsetzung / Implementation |
|---|---|
| **1.1.1** Nicht-Text-Inhalt / Non-text content | Keine Bilder vorhanden; Alt-Text-Pflicht für zukünftige Grafiken |
| **1.3.1** Info und Beziehungen / Info and relationships | Überschriften h1→h2→h3→h4 ohne Sprung; Tabellen mit Kopfzeilen |
| **1.3.2** Sinnvolle Reihenfolge / Meaningful sequence | Inhalt in logischer Lesereihenfolge strukturiert |
| **1.4.1** Verwendung von Farbe / Use of colour | Keine ausschließlich farbbasierte Information |
| **2.4.2** Seite mit Titel / Page titled | Dokumenttitel: `# home-baseline` |
| **2.4.4** Linkzweck / Link purpose | Beschreibende Link-Texte (`[Installationsanleitung](...)` — nicht `[hier](...)`) |
| **2.4.6** Überschriften und Bezeichnungen / Headings and labels | Alle Überschriften beschreibend und bilingual |
| **3.1.1** Sprache der Seite / Language of page | Hauptsprache Deutsch; alle Abschnitte parallel auf Englisch |
| **4.1.1** Syntaxanalyse / Parsing | Markdown-Elemente korrekt strukturiert; Code-Blöcke mit Sprachmarkierung |

> **Plattformeinschränkung / Platform limitation:** WCAG 3.1.2 (Sprache von Teilen) erfordert `lang`-Attribute
> an zweisprachigen Textstellen. GitHub Markdown entfernt HTML-Attribute — dies kann nicht implementiert werden.
>
> *WCAG 3.1.2 (Language of parts) requires `lang` attributes on bilingual passages.
> GitHub Markdown strips HTML attributes — this cannot be implemented on this platform.*

---

Regeln für neue Inhalte / Rules for new content:

- Code-Blöcke immer mit Sprachmarkierung: ` ```bash `, ` ```powershell `, ` ```text `
- Tabellen immer mit Kopfzeile und Trennzeile (`| Spalte |\n|---|`)
- Neue Abschnitte bilingual anlegen (DE-Absatz → EN-Absatz in Kursiv)
- Überschriften-Hierarchie einhalten: h2 → h3 → h4 — keine Ebene überspringen
- Linkbeschriftungen beschreibend wählen — nicht `[hier](...)` oder `[here](...)`

