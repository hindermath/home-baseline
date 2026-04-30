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
  - [Node.js ≥ 22 LTS](#5-nodejs--22-lts-für-npm-basierte-ki-agenten--for-npm-based-ai-agents)
- [Neuen Workspace einrichten / Create new workspace](#neuen-workspace-einrichten--create-new-workspace)
  - [macOS / Linux](#macos--linux)
  - [Windows (PowerShell Core ≥ 7)](#windows-powershell-core--7--windows-powershell-core--7)
- [Git Scope-Isolierung / Git Scope Isolation](#git-scope-isolierung--git-scope-isolation)
- [Ersteinrichtung dieses Repos auf einem neuen Gerät / Initial setup on a new device](#ersteinrichtung-dieses-repos-auf-einem-neuen-gerät--initial-setup-on-a-new-device)
  - [GitHub / GitLab-Authentifizierung / Authentication](#github--gitlab-authentifizierung--authentication)
  - [macOS / Linux](#macos--linux-1)
  - [Windows (PowerShell Core ≥ 7)](#windows-powershell-core--7--windows-powershell-core--7-1)
  - [Nächste Schritte / Next steps](#nächste-schritte--next-steps)
- [Template-Entwickler-Workflow / Template Developer Workflow](#template-entwickler-workflow--template-developer-workflow)
  - [Einmalig auf jeder neuen Maschine / One-time setup per machine](#einmalig-auf-jeder-neuen-maschine--one-time-setup-per-machine)
  - [Täglich / nach Änderungen synchronisieren / Daily sync](#täglich--nach-änderungen-synchronisieren--daily-sync)
  - [Änderungen am Template entwickeln / Develop template changes](#änderungen-am-template-entwickeln--develop-template-changes)
  - [Optionen sync-home / sync-home options](#optionen-sync-home--sync-home-options)
  - [Releases und Versionierung / Releases & Versioning](#releases-und-versionierung--releases--versioning)
- [Inhalt / Contents](#inhalt--contents)
  - [Workspace-Bootstrap / Workspace Bootstrap](#workspace-bootstrap--workspace-bootstrap)
  - [Homogeneity Guardian / Check, Migration & Stats](#homogeneity-guardian--check-migration--stats)
  - [Sicherheit / Security](#sicherheit--security)
  - [Einrichtung der KI-Agenten / AI Agent Setup](#einrichtung-der-ki-agenten--ai-agent-setup)
    - [GitHub Copilot CLI / GitHub Copilot CLI](#github-copilot-cli--github-copilot-cli)
    - [Claude Code / Claude Code](#claude-code--claude-code)
    - [Codex CLI / Codex CLI](#codex-cli--codex-cli)
    - [Gemini CLI / Gemini CLI](#gemini-cli--gemini-cli)
  - [Versionierung / Versioning](#versionierung--versioning)
- [Workspace Homogeneity Guardian — Kurzreferenz / Quick Reference](#workspace-homogeneity-guardian--kurzreferenz--quick-reference)
  - [Compliance-Check / Compliance check](#compliance-check--compliance-check)
  - [Agent-Audit / Agent audit](#agent-audit--agent-audit)
  - [STATS.md Baseline erzeugen / Generate STATS.md baseline](#statsmd-baseline-erzeugen--generate-statsmd-baseline)
  - [Bestehenden Workspace migrieren / Migrate existing workspace](#bestehenden-workspace-migrieren--migrate-existing-workspace)
  - [Constitution synchronisieren / Sync constitution](#constitution-synchronisieren--sync-constitution)
  - [Lastenheft umbenennen / Rename Lastenheft](#lastenheft-umbenennen--rename-lastenheft)
- [Plattform-Übersicht / Platform overview](#plattform-übersicht--platform-overview)
- [Für Auszubildende der Fachinformatik / For IT Apprentices](#für-auszubildende-der-fachinformatik--for-it-apprentices)
  - [Was machen wir hier eigentlich? / What is this all about?](#was-machen-wir-hier-eigentlich--what-is-this-all-about)
  - [Schritt 0: Deine Werkzeuge vorbereiten / Step 0: Preparing your tools](#schritt-0-deine-werkzeuge-vorbereiten--step-0-preparing-your-tools)
  - [Schritt 1: Dein eigenes Template erstellen / Step 1: Create your own template](#schritt-1-dein-eigenes-template-erstellen--step-1-create-your-own-template)
  - [Schritt 2: Deinen Computer mit der Cloud verbinden / Step 2: Connect your computer](#schritt-2-deinen-computer-mit-der-cloud-verbinden--step-2-connect-your-computer)
  - [Schritt 3: Deinen ersten "Workspace" anlegen / Step 3: Create your first workspace](#schritt-3-deinen-ersten-workspace-anlegen--step-3-create-your-first-workspace)
  - [Schritt 4: Dein erstes Projekt starten / Step 4: Start your first project](#schritt-4-dein-erstes-projekt-starten--step-4-start-your-first-project)
  - [Bestehende Projekte integrieren / Integrating existing projects](#bestehende-projekte-integrieren--integrating-existing-projects)
  - [Schritt 5: Arbeiten mit der KI (Dein Mentor) / Step 5: Working with AI (Your Mentor)](#schritt-5-arbeiten-mit-der-ki-dein-mentor--step-5-working-with-ai-your-mentor)
  - [Häufige Begriffe für den Start / Common terms for beginners](#häufige-begriffe-für-den-start--common-terms-for-beginners)
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

| Verzeichnis / Directory | GitHub-Repo / GitHub repo | Eingerichtet mit / Set up with |
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

| Kriterium / Criterion | Fork | Template / Template (this repo) |
|---|---|---|
| Git-History / Git history | wird mitkopiert / copied with the fork | **nicht** kopiert / **not** copied — frischer Start / fresh start |
| Verbindung zum Original / Connection to original | bleibt bestehen / remains linked | **keine** Verbindung / **no** connection |
| PRs zum Original möglich / PRs back to original | ja / yes | nein / no (bewusst getrennt / intentionally separate) |
| Eigener Namespace / Own namespace | fork-URL / fork URL | frei wählbar / freely chosen |
| Typischer Einsatz / Typical use | Mitarbeit am Original / contributing to the original | Eigene unabhängige Instanz / own independent instance |

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

| Plattform / Platform | Installation / Installation |
|---|---|
| macOS | `brew install git` oder [git-scm.com](https://git-scm.com/download/mac) |
| Linux | `sudo apt install git` / `sudo dnf install git` |
| Windows | [git-scm.com/download/win](https://git-scm.com/download/win) |

### 2. GitHub CLI (`gh`)

| Plattform / Platform | Installation / Installation |
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

| Plattform / Platform | Installation / Installation |
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

| Plattform / Platform | Installation / Installation |
|---|---|
| macOS | `brew install ripgrep` |
| Linux | `sudo apt install ripgrep` / `sudo dnf install ripgrep` |
| Windows | `winget install --id BurntSushi.ripgrep.MSVC` |

### 5. Node.js ≥ 22 LTS *(für npm-basierte KI-Agenten / for npm-based AI agents)*

Wird für die Installation von **Gemini CLI** und **Codex CLI** via `npm` benötigt. Claude Code hat einen eigenen nativen Installer und benötigt Node.js **nicht** mehr. Node.js 18 ist end-of-life — bitte mindestens **Node.js 22 LTS** (aktiv gewartet) oder **Node.js 24 LTS** verwenden.

*Required to install **Gemini CLI** and **Codex CLI** via `npm`. Claude Code has its own native installer and no longer requires Node.js. Node.js 18 is end-of-life — use at least **Node.js 22 LTS** (actively maintained) or **Node.js 24 LTS**.*

| Plattform / Platform | Installation / Installation |
|---|---|
| macOS | `brew install node` oder [nodejs.org](https://nodejs.org/en/download) |
| Linux | `sudo apt install nodejs npm` / `sudo dnf install nodejs` |
| Windows | `winget install --id OpenJS.NodeJS.LTS` oder [nodejs.org](https://nodejs.org/en/download) |

Nach der Installation prüfen / Verify installation:

```bash
node --version   # ≥ 22 erwartet (22 LTS oder 24 LTS)
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

### Windows (PowerShell Core >= 7) / Windows (PowerShell Core >= 7)

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
# ~/.gitconfig (global — lokal verwaltet, sync-home prüft Baseline-Werte)
[user]
    name  = Thorsten Hindermann
    email = hindermath@googlemail.com

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

### Windows (PowerShell Core >= 7) / Windows (PowerShell Core >= 7)

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

**3a — GitHub Copilot CLI Einstellungen einrichten / Set up GitHub Copilot CLI settings** *(optional)*

```bash
# macOS / Linux
bash ~/scripts/setup-copilot-settings.sh
```

```powershell
# Windows
pwsh -NoProfile ~/scripts/setup-copilot-settings.ps1
```

Setzt uebertragbare Copilot-Einstellungen in `~/.copilot/config.json`, zum Beispiel `effortLevel`, `banner`, `renderMarkdown` und `theme`, ohne Login-Daten oder vertrauenswuerdige Ordner zu ueberschreiben. Auf weiteren Geraeten erneut ausfuehren (`--force` / `-Force` zum Ueberschreiben, `--effort` / `-EffortLevel` und `--theme` / `-Theme` fuer gezielte Anpassungen).

*Sets transferable Copilot settings in `~/.copilot/config.json`, such as `effortLevel`, `banner`, `renderMarkdown`, and `theme`, without overwriting login data or trusted folders. Re-run on additional devices (`--force` / `-Force` to overwrite, `--effort` / `-EffortLevel` and `--theme` / `-Theme` for targeted adjustments).*

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

| Agent / Agent | Kommando / Command |
|---|---|
| **GitHub Copilot** | `gh copilot -p "Skript X ist bei Schritt Y abgebrochen. Bitte pruefe den Status und schliesse die Einrichtung ab. / Script X failed at step Y. Please check the status and finish the setup."` |
| **Claude Code** | `claude "Der Push zu GitHub ist fehlgeschlagen. Bitte pruefe die Remotes und hole den Push nach. / The push to GitHub failed. Please check the remotes and complete the push."` |
| **Codex CLI** | `codex "Analysiere den letzten Fehler im Terminal und schlage eine Loesung vor. / Analyse the last terminal error and suggest a fix."` |
| **Gemini CLI** | `gemini -p "Vervollstaendige die Git-Konfiguration, da das Bootstrap-Skript vorzeitig beendet wurde. / Complete the Git configuration because the bootstrap script ended early."` |
| **OpenCode** | `opencode --prompt "Pruefe, ob alle Git-Hooks und .inc-Dateien korrekt angelegt wurden. / Check whether all Git hooks and .inc files were created correctly."` |

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

| Plattform / Platform | Skript / Script | Ausgabe / Output |
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

`sync-home` kopiert `.gitconfig` bewusst nicht mehr blind aus dem Repository nach `~/`. Stattdessen stellt es die Baseline-Werte (`init.defaultBranch`, `core.autocrlf`, `pull.rebase`, `includeIf`) sicher und prüft danach die globale Git-Identität per `setup-git-identity.*` im Auto-Modus. So bleiben `user.name` und `user.email` dauerhaft echte lokale Werte.

*`sync-home` intentionally no longer copies `.gitconfig` blindly from the repository into `~/`. Instead, it ensures the baseline values (`init.defaultBranch`, `core.autocrlf`, `pull.rebase`, `includeIf`) and then checks the global git identity via `setup-git-identity.*` in auto mode. This keeps `user.name` and `user.email` as real local values permanently.*

---

### Releases und Versionierung / Releases & Versioning

GitHub- und GitLab-Releases folgen beide den [Conventional Commits](https://www.conventionalcommits.org/), verwenden aber unterschiedliche Automationspfade.

*GitHub and GitLab releases both follow [Conventional Commits](https://www.conventionalcommits.org/), but they use different automation paths.*

| Commit-Präfix / Prefix | Versions-Bump / Version bump |
|---|---|
| `fix:`, `docs:`, `chore:` | Patch: `0.3.1 → 0.3.2` |
| `feat:` | Minor: `0.3.1 → 0.4.0` |
| `feat!:` oder / or `BREAKING CHANGE` | Major: `0.3.x → 1.0.0` |

**GitHub / GitHub**

GitHub-Repositories verwenden **[Release Please](https://github.com/googleapis/release-please-action)**.

1. Commits auf `main` pushen
2. Release Please oeffnet oder aktualisiert automatisch einen Release PR
3. PR mergen -> Git-Tag + GitHub Release werden erstellt

*GitHub repositories use **Release Please**: push to `main`, let Release Please open or update the release PR, then merge the PR to create tag and GitHub Release.*

**GitLab / GitLab**

GitLab-Repositories verwenden `scripts/setup-gitlab-release.sh` bzw. `scripts/setup-gitlab-release.ps1` als GitLab-native Alternative.

1. Release-Basis in das Repo einhaengen:

```bash
bash ~/home-baseline-tmp/scripts/setup-gitlab-release.sh ~/RiderProjects/MyGitLabRepo --gitlab-url https://gitlab-ce.gwdg.de
```

```powershell
pwsh ~/home-baseline-tmp/scripts/setup-gitlab-release.ps1 -TargetRepository ~/RiderProjects/MyGitLabRepo -GitLabUrl https://gitlab-ce.gwdg.de
```

2. Danach laeuft auf dem Default-Branch ein manueller `release`-Job in GitLab CI
3. Beim Start dieses Jobs werden `CHANGELOG.md`, Git-Tag und GitLab Release automatisch erzeugt
4. Der `release`-Job bleibt bewusst manuell, blockiert aber den Gesamtstatus der Pipeline nicht

*GitLab repositories use `setup-gitlab-release.*` as a GitLab-native replacement: install the baseline once, then trigger the manual `release` job on the default branch to create `CHANGELOG.md`, tag, and GitLab Release. The job stays manual by design, but it does not block the overall pipeline status.*

---

## Inhalt / Contents

### Workspace-Bootstrap / Workspace Bootstrap

Die Bootstrap-Skripte sind fuer den **Start eines neuen Scopes** gedacht. `bootstrap-workspace.*` legt einen neuen Level-1-Workspace an, richtet die Baseline-Dateien ein, kopiert die wiederverwendbaren Skripte, initialisiert Git und erstellt optional direkt das passende Remote-Repository. `bootstrap-project.*` macht dasselbe eine Ebene tiefer fuer ein neues Level-2-Projekt innerhalb eines bestehenden Workspaces. Die Teardown-Skripte gehoeren in denselben Block, weil sie den Lebenszyklus eines Workspaces wieder sauber beenden.

*The bootstrap scripts are meant for the **start of a new scope**. `bootstrap-workspace.*` creates a new level-1 workspace, sets up the baseline files, copies the reusable scripts, initializes Git, and can optionally create the matching remote repository right away. `bootstrap-project.*` does the same one level deeper for a new level-2 project inside an existing workspace. The teardown scripts belong to the same block because they cleanly end the lifecycle of a workspace again.*

Wichtig ist die Abgrenzung: Bootstrap ist **nicht** dafuer da, einen bereits existierenden Workspace nachtraeglich an eine neue Baseline anzupassen oder nur den Ist-Zustand zu bewerten. Wenn ein Workspace schon existiert, aber auf einen neueren Standard gebracht werden soll, ist `migrate-workspace.*` das richtige Werkzeug. Wenn du nur wissen willst, ob die aktuelle Struktur compliant ist, nutzt du `check-homogeneity.*`.

*The important distinction is this: bootstrap is **not** meant to retrofit an already existing workspace to a newer baseline or to only evaluate the current state. If a workspace already exists but needs to be brought to a newer standard, `migrate-workspace.*` is the right tool. If you only want to know whether the current structure is compliant, use `check-homogeneity.*`.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/bootstrap-workspace.sh` | Neues Workspace einrichten / Create a new workspace (Bash) |
| `scripts/bootstrap-workspace.ps1` | Neues Workspace einrichten / Create a new workspace (PowerShell Core) |
| `scripts/bootstrap-project.sh` | Neues Projekt in einem Workspace anlegen / Create a new project inside a workspace (Bash) |
| `scripts/bootstrap-project.ps1` | Neues Projekt in einem Workspace anlegen / Create a new project inside a workspace (PowerShell Core) |
| `scripts/teardown-workspace.sh` | Workspace sicher entfernen: Remote, lokales Verzeichnis, Artefakte / Safely remove a workspace: remote, local directory, artifacts (Bash) |
| `scripts/teardown-workspace.ps1` | Workspace-Teardown / Workspace teardown (PowerShell Core) |

### Homogeneity Guardian / Check, Migration & Stats

Der Homogeneity-Guardian-Block deckt die **Pflege eines bestehenden Bestands** ab. Hier geht es nicht mehr um das erstmalige Anlegen, sondern um pruefen, angleichen und nachweisen. Die Skripte in diesem Abschnitt helfen dir also dabei, vorhandene Workspaces und Projekte auf Konsistenz zu kontrollieren, fehlende Baseline-Bausteine nachzuziehen und den sichtbaren Fortschritt in `STATS.md` oder `docs/project-statistics.md` zu dokumentieren.

*The Homogeneity Guardian block covers the **maintenance of an existing estate**. At this point the focus is no longer on first-time creation, but on checking, aligning, and documenting. The scripts in this section therefore help you inspect existing workspaces and projects for consistency, add missing baseline building blocks, and document visible progress in `STATS.md` or `docs/project-statistics.md`.*

Die Rollen der wichtigsten Skripte sind bewusst unterschiedlich: `check-homogeneity.*` ist das Diagnose-Werkzeug und beantwortet die Frage **"Ist der aktuelle Zustand compliant?"**. `migrate-workspace.*` ist das Nachruest-Werkzeug und beantwortet **"Wie bringe ich einen vorhandenen Workspace auf die aktuelle Baseline?"**. `init-stats.*` ist kein Compliance-Fix, sondern initialisiert oder ergaenzt nur den Statistik-Nachweis. `sync-constitution.*` verteilt die gemeinsame Verfassung in bestehende Level-1-Workspaces, und `rename-lastenheft.*` haelt die Benennung von Lastenheften nach einem Feature-Abschluss konsistent.

*The roles of the main scripts are intentionally different: `check-homogeneity.*` is the diagnostic tool and answers the question **"Is the current state compliant?"**. `migrate-workspace.*` is the retrofit tool and answers **"How do I bring an existing workspace to the current baseline?"**. `init-stats.*` is not a compliance fix, but only initializes or extends the statistics record. `sync-constitution.*` distributes the shared constitution into existing level-1 workspaces, and `rename-lastenheft.*` keeps the naming of requirement files consistent after a feature has been completed.*

Als praktische Kurzregel gilt: **neu anlegen = Bootstrap**, **vorhandenen Bestand angleichen = Migration**, **nur bewerten = Check**, **nur Statistik initialisieren = init-stats**. Genau diese Trennung hilft dabei, Skripte nicht versehentlich fuer den falschen Zweck zu verwenden.

*A practical short rule is: **create new = bootstrap**, **align existing estate = migration**, **only evaluate = check**, **only initialize statistics = init-stats**. This exact separation helps you avoid using the scripts for the wrong purpose by accident.*

Die Basishierarchie dieses Setups ist bewusst generisch aufgebaut, aber aus zwei Blickwinkeln zu lesen: Fuer Maintainer dieses Repositories ist `~/home-baseline-tmp` das Arbeits-Repository, in dem die **Level-0 home-baseline** entwickelt wird. Fuer Nutzende, Azubis und alle bereits gebootstrappten Umgebungen ist dagegen `~/` das eigentliche Root der Arbeitsumgebung. Direkt darunter liegen die **Level-1 workspaces** als fachliche oder toolbezogene Sammelcontainer, und darin liegen die eigentlichen **Level-2 projects**. Diese Benennung ist absichtlich neutral gehalten, damit sie nicht von bestimmten IDEs, Programmiersprachen oder persoenlichen Workspace-Namen abhaengt.

*The base hierarchy of this setup is intentionally generic, but it needs to be read from two perspectives: for maintainers of this repository, `~/home-baseline-tmp` is the working repository in which the **level-0 home baseline** is developed. For end users, apprentices, and already bootstrapped environments, however, `~/` is the actual root of the working environment. Directly below it sit the **level-1 workspaces** as domain- or tool-oriented containers, and inside them live the actual **level-2 projects**. This naming is intentionally neutral so it does not depend on specific IDEs, programming languages, or personal workspace names.*

Ein typischer Grenzfall ist deshalb ein bereits vorhandenes **Level-2 project** innerhalb eines bestehenden **Level-1 workspace**. Auch dafuer ist **nicht** `bootstrap-project.*`, sondern `migrate-workspace.*` fuer den uebergeordneten Workspace die richtige Wahl, weil die Migration die enthaltenen Level-2-Repositories automatisch mit betrachtet und angleicht.

*A common edge case is therefore an already existing **level-2 project** inside an existing **level-1 workspace**. Even in that case, the correct tool is **not** `bootstrap-project.*`, but `migrate-workspace.*` for the parent workspace, because the migration automatically inspects and aligns the contained level-2 repositories as well.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/check-homogeneity.sh` | Compliance-Scanner Level 0-2, JSON-Ausgabe, STATS.md-Update / Compliance scanner level 0-2, JSON output, STATS.md update (Bash) |
| `scripts/check-homogeneity.ps1` | Compliance-Scanner mit Paritaet zur Bash-Version / Compliance scanner with Bash parity (PowerShell Core) |
| `scripts/init-stats.sh` | STATS.md-Baseline-Eintrag erzeugen / Create a STATS.md baseline entry (Bash) |
| `scripts/init-stats.ps1` | STATS.md-Baseline-Eintrag erzeugen / Create a STATS.md baseline entry (PowerShell Core) |
| `scripts/migrate-workspace.sh` | Bestehende Workspaces auf Homogeneity-Baseline migrieren / Migrate existing workspaces to the homogeneity baseline (Bash) |
| `scripts/migrate-workspace.ps1` | Workspace-Migration / Workspace migration (PowerShell Core) |
| `scripts/sync-constitution.sh` | `constitution.md` in alle Level-1-Workspaces synchronisieren / Sync `constitution.md` into all level-1 workspaces (Bash) |
| `scripts/sync-constitution.ps1` | Constitution-Sync / Constitution sync (PowerShell Core) |
| `scripts/rename-lastenheft.sh` | Lastenheft-Datei umbenennen: `git mv` + Commit / Rename requirement file: `git mv` + commit (Bash) |
| `scripts/rename-lastenheft.ps1` | Lastenheft umbenennen / Rename requirement file (PowerShell Core) |
| `constitution.md` | Workspace-Verfassung, Sync-Quelle fuer alle Workspaces / Workspace constitution, sync source for all workspaces |
| `scripts/templates/readme-template.md` | Bilinguale README-Vorlage mit A11Y-, Spec-Kit- und Azubi-Abschnitt / Bilingual README template with A11Y, Spec-Kit, and apprentice section |
| `scripts/templates/a11y-section.md` | Barrierefreiheits-Abschnitt / Accessibility section template |
| `scripts/templates/speckit-workflow-section.md` | Spec-Kit-Workflow-Abschnitt / Spec-Kit workflow section template |
| `scripts/templates/azubis-section.md` | Azubi-Einstiegsleitfaden-Abschnitt / Apprentice onboarding guide section |
| `.github/workflows/homogeneity-check.yml` | CI/CD-Workflow: Compliance-Check auf Ubuntu, macOS, Windows / CI/CD workflow: compliance check on Ubuntu, macOS, Windows |

### Versionierung / Versioning

Dieser Block beschreibt, wie aus Commits nachvollziehbare Releases und Changelog-Eintraege werden. Fuer GitHub-Repositories ist `release-please` der automatische Standardpfad: Bei Pushes auf `main` entstehen Release-PRs, die Version, Changelog und Release-Tag kontrolliert fortschreiben. Fuer GitLab-Repositories uebernehmen `setup-gitlab-release.*` und die zugehoerigen Templates denselben Zweck mit einem GitLab-nativen, bewusst manuellen `release`-Job.

*This block explains how commits become traceable releases and changelog entries. For GitHub repositories, `release-please` is the standard automated path: pushes to `main` produce release pull requests that update version, changelog, and release tags in a controlled way. For GitLab repositories, `setup-gitlab-release.*` and the related templates serve the same purpose with a GitLab-native, intentionally manual `release` job.*

Die Abgrenzung ist wichtig: Diese Dateien legen **nicht** den normalen Entwicklungsablauf fest, sondern den Weg von abgeschlossener Arbeit zu einer veroeffentlichten Version. Wenn du also an Features oder Baseline-Skripten arbeitest, brauchst du meist nur die normale Commit-Disziplin. Die Dateien in diesem Abschnitt werden relevant, sobald Versionen, Tags, Releases und `CHANGELOG.md` konsistent und reproduzierbar gepflegt werden sollen.

*The distinction matters: these files do **not** define the normal development flow, but the path from finished work to a published version. So when you work on features or baseline scripts, you usually only need normal commit discipline. The files in this section become relevant once versions, tags, releases, and `CHANGELOG.md` need to be maintained consistently and reproducibly.*

| Datei / File | Beschreibung / Description |
|---|---|
| `.github/workflows/release-please.yml` | Release Please, erstellt Release-PRs automatisch bei jedem Push auf `main` / Release Please, automatically opens release PRs on every push to `main` |
| `release-please-config.json` | Konfiguration: `release-type: simple`, bilinguale Changelog-Sektionen / Config: `release-type: simple`, bilingual changelog sections |
| `.release-please-manifest.json` | Aktuell getrackte Version, automatisch von Release Please aktualisiert / Currently tracked version, automatically updated by Release Please |
| `scripts/setup-gitlab-release.sh` | GitLab-Release-Automation in bestehendes Repo einhaengen / Attach GitLab release automation to an existing repo (Bash) |
| `scripts/setup-gitlab-release.ps1` | GitLab-Release-Automation in bestehendes Repo einhaengen / Attach GitLab release automation to an existing repo (PowerShell Core) |
| `scripts/templates/release-gitlab.sh.tmpl` | Generisches GitLab-Release-Skript fuer SemVer, CHANGELOG, Tag und Release / Generic GitLab release script for SemVer, changelog, tag, and release |
| `scripts/templates/gitlab-release-job.yml.tmpl` | GitLab-CI-Job-Block fuer den manuellen `release`-Job / GitLab CI job block for the manual `release` job |
| `scripts/templates/changelog-template.md` | Initiale CHANGELOG-Vorlage fuer GitLab-Repos / Initial changelog template for GitLab repos |
| `CHANGELOG.md` | Versionsverlauf nach [Keep a Changelog](https://keepachangelog.com/), verwaltet durch Release Please oder GitLab-Release-Job / Version history following Keep a Changelog, managed by Release Please or the GitLab release job |

### Sicherheit / Security

Dieser Block deckt den Schutz vor versehentlich eingecheckten Geheimnissen ab. Die Secret-Scan-Skripte pruefen typische Agenten-, Tool- und Projektverzeichnisse auf riskante Dateien oder Inhalte, waehrend `install-hooks.*` den gemeinsamen `pre-push`-Hook in ein Repository einhaengt. Dadurch wird der Schutz moeglichst frueh aktiv: idealerweise schon vor dem Push und nicht erst nach einem CI-Fehler oder einem geleakten Token.

*This block covers protection against secrets being committed by accident. The secret-scan scripts inspect common agent, tool, and project directories for risky files or contents, while `install-hooks.*` installs the shared `pre-push` hook into a repository. This makes the protection active as early as possible: ideally before a push, and not only after a CI failure or a leaked token.*

Die Rollen sind auch hier getrennt: `scan-agent-secrets.*` ist das eigentliche Pruefwerkzeug, `install-hooks.*` bringt die Pruefung in den Alltag, und `scripts/hooks/pre-push` ist die gemeinsam genutzte Durchsetzungslogik. Als Kurzregel gilt also: **manuell pruefen = scan-agent-secrets**, **dauerhaft absichern = install-hooks**, **beim Push blockieren = pre-push**.

*The roles are separated here as well: `scan-agent-secrets.*` is the actual inspection tool, `install-hooks.*` brings that inspection into day-to-day work, and `scripts/hooks/pre-push` is the shared enforcement logic. So the short rule is: **manual inspection = scan-agent-secrets**, **persistent protection = install-hooks**, **block on push = pre-push**.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/scan-agent-secrets.sh` | Secret-Scan fuer KI-Agenten-Verzeichnisse / Secret scan for AI agent directories (Bash) |
| `scripts/scan-agent-secrets.ps1` | Secret-Scan / Secret scan (PowerShell Core) |
| `scripts/install-hooks.sh` | Git-Hooks installieren / Install Git hooks (Bash) |
| `scripts/install-hooks.ps1` | Git-Hooks installieren / Install Git hooks (PowerShell Core) |
| `scripts/hooks/pre-push` | Pre-Push-Hook, blockiert Push bei Secrets / Pre-push hook, blocks pushes when secrets are found |

### Einrichtung der KI-Agenten / AI Agent Setup

Dieser Block dokumentiert die **vorbereiteten lokalen Konfigurations-Skripte** fuer die vier Agenten, fuer die dieses Repository bereits wiederverwendbare Setup-Helfer mitliefert: GitHub Copilot CLI, Claude Code, Codex CLI und Gemini CLI. Diese Skripte installieren den Agenten nicht selbst, sondern richten nach der Installation und Anmeldung die lokalen Konfigurationsdateien so ein, dass Statuszeilen, Anzeigeoptionen oder uebertragbare Standardwerte konsistent gesetzt werden.

*This block documents the **prepared local configuration scripts** for the four agents for which this repository already ships reusable setup helpers: GitHub Copilot CLI, Claude Code, Codex CLI, and Gemini CLI. These scripts do not install the agent itself. Instead, after installation and sign-in, they configure the local settings files so that status lines, display options, or transferable defaults are applied consistently.*

Die Trennung ist wichtig: Die eigentliche Agenten-Installation und Anmeldung gehoert in den spaeteren Abschnitt `KI-Agenten einrichten / Set up AI agents`. Die Skripte hier sind der zweite Schritt fuer Maschinenkonsistenz. Als Kurzregel gilt deshalb: **Agent installieren = spaeterer Setup-Abschnitt**, **lokale Agenten-Konfiguration vereinheitlichen = `setup-*-settings.*` in diesem Block**.

*The distinction matters: the actual agent installation and sign-in belong to the later section `KI-Agenten einrichten / Set up AI agents`. The scripts here are the second step for machine consistency. So the short rule is: **install the agent = later setup section**, **standardise the local agent configuration = `setup-*-settings.*` in this block**.*

#### GitHub Copilot CLI / GitHub Copilot CLI

Die Copilot-Skripte schreiben uebertragbare Einstellungen nach `~/.copilot/config.json`, ohne maschinenspezifische Daten wie Login-Status oder `trusted_folders` zu zerstoeren. Das ist vor allem sinnvoll, wenn Reasoning-Tiefe, Banner-Verhalten, Markdown-Rendering und Theme auf mehreren Geraeten gleich konfiguriert werden sollen.

*The Copilot scripts write transferable settings to `~/.copilot/config.json` without destroying machine-specific data such as login state or `trusted_folders`. This is mainly useful when reasoning depth, banner behaviour, markdown rendering, and theme should be configured consistently across multiple devices.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-copilot-settings.sh` | GitHub-Copilot-CLI-Einstellungen in `~/.copilot/config.json` setzen / Set GitHub Copilot CLI settings in `~/.copilot/config.json` (Bash) |
| `scripts/setup-copilot-settings.ps1` | GitHub-Copilot-CLI-Einstellungen in `~/.copilot/config.json` setzen / Set GitHub Copilot CLI settings in `~/.copilot/config.json` (PowerShell Core) |

#### Claude Code / Claude Code

Die Claude-Skripte setzen die `statusLine` in `~/.claude/settings.json` beziehungsweise `%APPDATA%\\Claude\\settings.json`. Ziel ist eine kompakte Statuszeile mit Modell, Arbeitsverzeichnis, Git-Branch sowie Context- und Rate-Limit-Informationen, damit Claude Code auf allen Maschinen aehnlich lesbar arbeitet.

*The Claude scripts set the `statusLine` in `~/.claude/settings.json` or `%APPDATA%\\Claude\\settings.json`. The goal is a compact status line with model, working directory, git branch, and context or rate-limit information so that Claude Code behaves similarly across machines.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-claude-settings.sh` | Claude Code `statusLine` in `~/.claude/settings.json` einrichten / Configure Claude Code `statusLine` in `~/.claude/settings.json` (Bash) |
| `scripts/setup-claude-settings.ps1` | Claude Code `statusLine` in `%APPDATA%\\Claude\\settings.json` einrichten / Configure Claude Code `statusLine` in `%APPDATA%\\Claude\\settings.json` (PowerShell Core) |

#### Codex CLI / Codex CLI

Die Codex-Skripte setzen die TUI-`status_line` in `~/.codex/config.toml` oder `${CODEX_HOME}/config.toml`, basierend auf der zentralen Vorlage `scripts/templates/codex-statusline.toml`. Dadurch wird die Statuszeile als wiederverwendbare Repo-Baseline gepflegt und nicht auf jeder Maschine separat von Hand zusammengesetzt.

*The Codex scripts set the TUI `status_line` in `~/.codex/config.toml` or `${CODEX_HOME}/config.toml`, based on the central template `scripts/templates/codex-statusline.toml`. This keeps the status line as a reusable repository baseline instead of rebuilding it manually on every machine.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-codex-settings.sh` | Codex CLI `status_line` in `~/.codex/config.toml` einrichten / Configure Codex CLI `status_line` in `~/.codex/config.toml` (Bash) |
| `scripts/setup-codex-settings.ps1` | Codex CLI `status_line` in `~/.codex/config.toml` einrichten / Configure Codex CLI `status_line` in `~/.codex/config.toml` (PowerShell Core) |
| `scripts/templates/codex-statusline.toml` | Zentrale Vorlage fuer die Codex-Statuszeile / Central template for the Codex status line |

#### Gemini CLI / Gemini CLI

Die Gemini-Skripte arbeiten analog zu Codex, aber fuer `~/.gemini/config.toml` beziehungsweise `${GEMINI_HOME}/config.toml` und mit der Vorlage `scripts/templates/gemini-statusline.toml`. So bleiben die angezeigten TUI-Elemente fuer Gemini ebenfalls zentral gepflegt und ueber mehrere Geraete hinweg konsistent.

*The Gemini scripts work analogously to Codex, but for `~/.gemini/config.toml` or `${GEMINI_HOME}/config.toml` and with the template `scripts/templates/gemini-statusline.toml`. This keeps the displayed TUI items for Gemini centrally maintained and consistent across multiple devices as well.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-gemini-settings.sh` | Gemini CLI `status_line` in `~/.gemini/config.toml` einrichten / Configure Gemini CLI `status_line` in `~/.gemini/config.toml` (Bash) |
| `scripts/setup-gemini-settings.ps1` | Gemini CLI `status_line` in `~/.gemini/config.toml` einrichten / Configure Gemini CLI `status_line` in `~/.gemini/config.toml` (PowerShell Core) |
| `scripts/templates/gemini-statusline.toml` | Zentrale Vorlage fuer die Gemini-Statuszeile / Central template for the Gemini status line |

---

## Workspace Homogeneity Guardian — Kurzreferenz / Quick Reference

Die Kurzreferenz ist fuer den schnellen Zugriff gedacht: `check-homogeneity.*` prueft nur den aktuellen Zustand, `migrate-workspace.*` zieht fehlende Baseline-Bausteine in bestehende Workspaces nach, und `init-stats.*` initialisiert oder ergaenzt nur den Statistik-Nachweis. Wenn du also nichts neu anlegen willst, aber unsicher bist, welches Skript du brauchst, gilt hier dieselbe Kurzregel wie oben: **pruefen = check**, **angleichen = migrate**, **Statistik starten oder fortschreiben = init-stats**.

*The quick reference is meant for fast access: `check-homogeneity.*` only inspects the current state, `migrate-workspace.*` adds missing baseline building blocks to existing workspaces, and `init-stats.*` only initializes or extends the statistics record. So if you do not want to create anything new but are unsure which script you need, the same short rule applies here: **inspect = check**, **align = migrate**, **start or extend statistics = init-stats**.*

### Compliance-Check / Compliance check

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

### Agent-Audit / Agent audit

Wenn lokale Agent-Dateien spaeter nachvollziehbar bleiben sollen, erstelle zuerst eine Baseline und vergleiche dann spaetere Aenderungen gegen diese Baseline. `audit-agent-changes.*` speichert die lokale Audit-State-Datei unter `~/.home-baseline/agent-audit/`, listet geaenderte Dateien auf und sucht anschliessend in lokalen Codex-, Claude-, Copilot- und Continue-Logs nach pfadbasierten Hinweisen. Das ist bewusst eine Heuristik und kein manipulationssicherer Herkunftsnachweis.

*If you want later local agent-file changes to remain traceable, first create a baseline and then compare future changes against that baseline. `audit-agent-changes.*` stores local audit state under `~/.home-baseline/agent-audit/`, lists changed files, and then searches local Codex, Claude, Copilot, and Continue logs for path-based hints. This is intentionally a heuristic, not a tamper-proof proof of origin.*

```bash
# Baseline fuer die aktuelle Maschine anlegen / Create a baseline for this machine
bash ~/scripts/audit-agent-changes.sh snapshot

# Spaetere Aenderungen berichten / Report later changes
bash ~/scripts/audit-agent-changes.sh report

# Report erzeugen und aktuellen Zustand als neue Baseline akzeptieren / Report and accept current state as new baseline
bash ~/scripts/audit-agent-changes.sh report --refresh-baseline
```

```powershell
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action report
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action report -RefreshBaseline
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

Die folgenden Kommandos kannst du technisch von **jedem** Verzeichnis aus starten, weil der Skriptpfad explizit ist und `migrate-workspace.*` den Ziel-Workspace ueber `~/<WorkspaceName>` aufloest. Praktisch haengt der beste Startpunkt vom Blickwinkel ab: Wenn du die Baseline selbst weiterentwickelst, ist `~/home-baseline-tmp` sinnvoll. Wenn du die Skripte als Nutzender oder Azubi auf deine bestehende Umgebung anwendest, ist `~/` der natuerlichere Ausgangspunkt, weil dort die Level-1-Workspaces direkt sichtbar sind.

*You can technically start the following commands from **any** directory, because the script path is explicit and `migrate-workspace.*` resolves the target workspace via `~/<WorkspaceName>`. In practice, the best starting point depends on perspective: if you are evolving the baseline itself, `~/home-baseline-tmp` is sensible. If you are using the scripts as an end user or apprentice on your existing environment, `~/` is the more natural starting point because the level-1 workspaces are directly visible there.*

Wenn du ein bereits vorhandenes **Level-2 project** in einen bestehenden **Level-1 workspace** integrieren willst, migrierst du den **Level-1 workspace**, nicht das einzelne Unterverzeichnis. Die empfohlene Reihenfolge ist also immer: erst `check-homogeneity.*` fuer den Workspace-Pfad, dann `migrate-workspace.* --dry-run <WorkspaceName>`, und erst danach die echte Migration.

*If you want to integrate an already existing **level-2 project** into an existing **level-1 workspace**, migrate the **level-1 workspace**, not the individual subdirectory. The recommended order is therefore always: first run `check-homogeneity.*` for the workspace path, then `migrate-workspace.* --dry-run <WorkspaceName>`, and only then run the real migration.*

```bash
# Vorher den Ist-Zustand des Level-1 workspace pruefen / Inspect the current state of the level-1 workspace first
bash ~/scripts/check-homogeneity.sh ~/MyWorkspace

# Bestehenden Level-1 workspace inklusive enthaltener Level-2 projects pruefend migrieren / Preview migration for an existing level-1 workspace including contained level-2 projects
bash ~/scripts/migrate-workspace.sh MyWorkspace --dry-run

# Vorschau / Preview
bash ~/scripts/migrate-workspace.sh --dry-run MyProjects

# Reale Migration fuer den ausgewaehlten Level-1 workspace / Real migration for the selected level-1 workspace
bash ~/scripts/migrate-workspace.sh MyWorkspace --yes

# Alle Workspaces migrieren / Migrate all workspaces
bash ~/scripts/migrate-workspace.sh --yes
```

```powershell
# Windows-Beispiel fuer einen Level-1 workspace / Windows example for a level-1 workspace
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/MyWorkspace
pwsh ~/scripts/migrate-workspace.ps1 -WorkspaceName MyWorkspace -WhatIf
pwsh ~/scripts/migrate-workspace.ps1 -WorkspaceName MyWorkspace -Force

pwsh ~/scripts/migrate-workspace.ps1 -WorkspaceName MyProjects -WhatIf
pwsh ~/scripts/migrate-workspace.ps1 -Force
```

Im Dry-Run solltest du besonders auf vier Dinge achten: Erstens muss dein Zielprojekt als `Level-2: <ProjectName>/` oder mit dem passenden Namen auftauchen. Zweitens sollten nur die erwarteten Workspace- und Projektdateien als `WOULD CREATE`, `WOULD UPDATE` oder `WOULD COPY` erscheinen, zum Beispiel `.gitignore`, `constitution.md`, `.editorconfig` oder `homogeneity-check.yml`. Drittens sind Warnungen zu uncommitteten Aenderungen ein Signal, vor der echten Migration den Git-Zustand bewusst zu sichern. Viertens solltest du abbrechen, wenn unerwartete Unterverzeichnisse als Level-2-Repositories erkannt werden, denn dann wuerde die echte Migration mehr anfassen als beabsichtigt.

*During the dry run, pay special attention to four things: first, your target project should appear as `Level-2: <ProjectName>/` or with the matching name. Second, only the expected workspace and project files should appear as `WOULD CREATE`, `WOULD UPDATE`, or `WOULD COPY`, for example `.gitignore`, `constitution.md`, `.editorconfig`, or `homogeneity-check.yml`. Third, warnings about uncommitted changes are a signal to secure the Git state intentionally before the real migration. Fourth, stop if unexpected subdirectories are detected as level-2 repositories, because the real migration would then touch more than intended.*

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

| Plattform / Platform | Unterstuetzt / Supported | Voraussetzung / Requirement |
|---|---|---|
| macOS | ✅ nativ / native | - |
| Linux | ✅ nativ / native | - |
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

*In IT, we often work with many different projects. To help you stay organised and keep your work safely stored, we use an **automated infrastructure**.*

*Here are the three main concepts you will learn today:*

*1. **The terminal (command line):** your main tool. Instead of clicking with the mouse, you give the computer direct text commands. This is faster, more precise, and easy to automate.*
*2. **Git (version control):** like a time machine for your code. You save checkpoints (commits). If something goes wrong, you can return to a working state at any time.*
*3. **GitHub / GitLab (the cloud):** this is where your code is stored safely online. It lets you work from different computers and share your work with others.*

***Important:** your **home directory** (shortened to `~/` on macOS/Linux) is your personal area on the computer. We now set it up so that it largely manages itself.*

---

### Schritt 0: Deine Werkzeuge vorbereiten / Step 0: Preparing your tools

Bevor wir starten, müssen wir die „Handwerker-Kiste“ füllen. Wir installieren Programme, die im Hintergrund arbeiten.

*Before we start, we need to fill the "toolbox". We install programs that work in the background.*

#### Welches Betriebssystem nutzt du? / Which operating system do you use?

| Windows (PowerShell 7) | macOS (Terminal) | Linux / Ubuntu |
|---|---|---|
| Nutze die **PowerShell 7**. Sie ist viel maechtiger als die alte Eingabeaufforderung (CMD). / Use **PowerShell 7**. It is much more capable than the old Command Prompt (CMD). | Nutze die **Terminal-App**. / Use the **Terminal app**. | Nutze das Standard-Terminal deiner Distribution. / Use your distribution's default terminal. |

#### Installation der Werkzeuge / Install the tools

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

*We use a "template". It is like a pre-filled form that you copy for your own use.*

1.  Öffne im Browser die Vorlage, die dein Ausbilder dir gegeben hat (z. B. `hindermath/home-baseline`).
2.  Klicke oben rechts auf den grünen Button **„Use this template“** → **„Create a new repository“**.
3.  **Name:** Gib ihm einen Namen (z. B. `meine-it-umgebung`).
4.  **Sichtbarkeit:** Wähle **Private**. Das ist wichtig, damit nur du deinen Code sehen kannst.
5.  Klicke auf **„Create repository“**.

Du hast nun deine eigene Kopie in der Cloud! Die Adresse (URL) sieht so aus: `https://github.com/DEIN_NAME/meine-it-umgebung`.

*You now have your own copy in the cloud. The URL looks like this: `https://github.com/YOUR_NAME/my-it-environment`.*

---

### Schritt 2: Deinen Computer mit der Cloud verbinden / Step 2: Connect your computer

Jetzt bringen wir die Dateien aus der Cloud auf deinen Computer und richten alles ein.

*Now we bring the files from the cloud to your computer and set everything up.*

**Erklärung der Befehle:**
- `cd ~`: „Change Directory to Home“ — Wir gehen in dein persönliches Verzeichnis.
- `git clone ...`: Wir laden eine Kopie deines Repos herunter.
- `bash` / `pwsh`: Wir führen ein Skript aus, das die ganze Arbeit für uns macht.

*Explanation of the commands:*
- `cd ~`: "Change Directory to Home" - we move into your personal directory.
- `git clone ...`: we download a copy of your repository.
- `bash` / `pwsh`: we run a script that does the setup work for us.

#### Fuer macOS / Linux / For macOS / Linux
```bash
cd ~
# Lade dein Repo (Ersetze DEIN_NAME und REPO_NAME!)
git clone https://github.com/DEIN_NAME/REPO_NAME.git home-baseline-tmp

# Starte die Einrichtung (sync-home kopiert alle Scripte)
bash ~/home-baseline-tmp/scripts/sync-home.sh --no-pull

# Aufräumen (wir brauchen den temporären Ordner nicht mehr)
rm -rf home-baseline-tmp
```

#### Fuer Windows / For Windows
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

*What just happened?*
*1. A directory `~/Ausbildung` was created.*
*2. A private repo named `ausbildung-baseline` was created for you on GitHub.*
*3. Important protection scripts (Git hooks) were installed so that you do not upload passwords by accident.*

---

### Schritt 4: Dein erstes Projekt starten / Step 4: Start your first project

Innerhalb deines Workspaces legst du nun deine eigentlichen Programmier-Projekte an.

```bash
# Ein Projekt namens "HalloWelt" im Workspace "Ausbildung" erstellen
bash ~/scripts/bootstrap-project.sh HalloWelt ~/Ausbildung
```

Ab jetzt arbeitest du in diesem Ordner: `cd ~/Ausbildung/HalloWelt`. Hier schreibst du deinen Code.

*From now on, you work in this directory: `cd ~/Ausbildung/HalloWelt`. This is where you write your code.*

---

### Bestehende Projekte integrieren / Integrating existing projects

Vielleicht hast du schon Ordner mit Code auf deinem Computer, die du in dein neues System aufnehmen möchtest. Das geht ganz einfach mit demselben Befehl.

*Maybe you already have folders with code on your computer that you want to include in your new system. This is easily done using the same command.*

**So gehst du vor:**
1.  Verschiebe deinen vorhandenen Projektordner in den passenden Workspace (z. B. nach `~/Ausbildung/MeinAltesProjekt`).
2.  Führe das Bootstrap-Skript für diesen Ordner aus.

**Beispiel:**
```bash
# Integriert den bestehenden Ordner "MeinAltesProjekt" in den Workspace "Ausbildung"
bash ~/scripts/bootstrap-project.sh MeinAltesProjekt ~/Ausbildung
```

**Was das Skript macht:**
- Es erkennt, dass der Ordner schon da ist.
- Es macht daraus ein Git-Repository (falls es noch keins war).
- Es erstellt ein passendes privates Repository auf GitHub.
- Es fügt alle Standard-Dateien (README, .gitignore, KI-Agenten-Setup) hinzu.

#### Sicherheit und Schutz deiner Dateien / Safety and protection of your files

Du musst keine Angst haben, dass deine Arbeit überschrieben wird. Das Skript folgt dem Prinzip **„Safety First“**:

*   **Kein automatisches Überschreiben:** Wenn eine Datei (z. B. deine `README.md` oder dein Quellcode) bereits existiert, rührt das Skript sie **nicht** an. Es ergänzt lediglich die Dateien, die für die neue Infrastruktur noch fehlen.
*   **Idempotenz:** Du kannst das Skript beliebig oft auf denselben Ordner anwenden. Es wird jedes Mal nur das tun, was noch nötig ist.
*   **Der `--force`-Flag:** Nur wenn du ganz bewusst den Zusatz `--force` am Ende des Befehls eingibst, werden bestehende Dateien durch die neuen Vorlagen ersetzt. Ohne diesen Zusatz ist dein Code absolut sicher.

*The script follows a "Safety First" approach. It will **not** touch or overwrite any existing files (like your source code or README) unless you explicitly use the `--force` flag. It only adds the infrastructure files that are currently missing.*
---

### Schritt 5: Arbeiten mit der KI (Dein Mentor) / Step 5: Working with AI (Your Mentor)

Du bist nicht allein! Wir haben KI-Agenten installiert, die dir helfen können. Wie du diese Werkzeuge **bewusst und zielgerichtet** einsetzt, erfährst du im ausführlichen Abschnitt:

→ **[Arbeiten mit agentischer KI / Working with Agentic AI](#arbeiten-mit-agentischer-ki--working-with-agentic-ai)**

Hier ein paar schnelle Beispiele für den Start:
...
`gh copilot -p "Ich habe eine Fehlermeldung bei git push erhalten. Was bedeutet das?"`

Oder wenn ein Skript abgebrochen ist:
`claude "Das bootstrap-workspace Skript ist hängengeblieben. Kannst du prüfen, ob alles fertig ist?"`

*You are not alone. We installed AI agents that can help you. You can learn how to use these tools consciously and with a clear goal in the detailed section below:*

*See: **[Arbeiten mit agentischer KI / Working with Agentic AI](#arbeiten-mit-agentischer-ki--working-with-agentic-ai)**.*

*Here are two quick starter examples:*

`gh copilot -p "I got an error during git push. What does it mean?"`

*Or if a script stopped unexpectedly:*

`claude "The bootstrap-workspace script stopped early. Can you check whether everything is complete?"`

---

### Häufige Begriffe für den Start / Common terms for beginners

- **Pfad (Path):** Die Adresse einer Datei auf dem Computer (z. B. `C:\Users\Name\Projekt` oder `~/Projekt`). / The address of a file on your computer (for example `C:\Users\Name\Projekt` or `~/Projekt`).
- **Skript (Script):** Eine Textdatei mit Befehlen, die der Computer nacheinander ausführt. / A text file with commands that the computer runs one after another.
- **Commit:** Ein „Speicherpunkt“. Wie bei einem Videospiel, bevor du gegen einen Boss kämpfst. / A saved checkpoint, like before a difficult level in a game.
- **Push:** Deine lokalen Speicherpunkte ins Internet (GitHub) hochladen. / Upload your local checkpoints to the internet (GitHub).
- **Root:** Die oberste Ebene (das „Wurzelverzeichnis“). / The top level, also called the root directory.

---

## Spec-kit-Workflow / Spec-kit Workflow

### Was ist Specification-Driven Development (SDD)? / What is Specification-Driven Development (SDD)?

**Specification-Driven Development (SDD)** ist ein Arbeitsansatz, bei dem du *bevor* du eine Zeile Code schreibst eine strukturierte Spezifikation erstellst - unterstützt von einem KI-Agenten. Der Agent hilft dir dabei:

1. Die Anforderungen klar zu formulieren (`spec.md`)
2. Offene Fragen zu identifizieren und zu klären (`clarify`)
3. Einen konkreten Implementierungsplan zu erstellen (`plan.md`)
4. Die Implementierung in handhabbare Aufgaben aufzuteilen (`tasks.md`)
5. Die Aufgaben Schritt für Schritt umzusetzen (`implement`)

> **Warum SDD?**
> Ohne Spezifikation entstehen oft Missverständnisse, unfertige Features und unnötiger Code. Mit SDD weißt du immer, was als Nächstes zu tun ist - und warum.

*Specification-Driven Development (SDD) is a way of working where you create a structured specification before writing a single line of code, supported by an AI agent. The agent helps you describe requirements clearly (`spec.md`), identify and resolve open questions (`clarify`), create a concrete implementation plan (`plan.md`), split the work into manageable tasks (`tasks.md`), and then implement those tasks step by step (`implement`).*

> **Why SDD?**
> *Without a specification, teams often create misunderstandings, unfinished features, and unnecessary code. With SDD, you always know what to do next - and why.*

---

### Was ist Spec-Kit? / What is Spec-Kit?

**Spec-Kit** ist ein KI-Agenten-Skill-System, das den SDD-Workflow automatisiert. Es ist in diesem Repository bereits vollständig vorkonfiguriert und unterstützt mehrere KI-Agenten (GitHub Copilot, Claude, Gemini, Codex, OpenCode).

Die Spec-Kit-Skills befinden sich unter `.agents/skills/` und werden beim Klonen des Repos automatisch mitgeliefert.
**Eine separate Installation ist nicht nötig** — du brauchst nur deinen bevorzugten KI-Agenten.

*Spec-Kit is an AI agent skill system that automates the SDD workflow. It is fully pre-configured in this repository. No separate download is needed — you only need your preferred AI agent.*

---

### Voraussetzungen / Prerequisites

| Voraussetzung / Requirement | Pflicht? / Required? | Wozu / Why |
|---|:---:|---|
| `git` ≥ 2.30 | ✅ | Feature-Branches; Spec-Artefakte werden versioniert / Feature branches; spec artefacts are versioned |
| GitHub-Account / GitHub account | ✅ | Repo-Hosting / Repository hosting |
| KI-Agent (mind. einer) / AI agent (at least one) | ✅ | Fuehrt die Spec-Kit-Skills aus / Runs the Spec-Kit skills |
| `uv` (Python) | ✅ | Installiert `specify-cli` (das Spec-Kit-CLI) / Installs `specify-cli` (the Spec-Kit CLI) |
| Node.js ≥ 22 LTS | fuer npm-Agenten / for npm-based agents | Gemini CLI und Codex CLI installieren (Claude Code: nicht noetig) / Install Gemini CLI and Codex CLI (Claude Code: not needed) |
| `gh` CLI | empfohlen / recommended | GitHub Copilot CLI; Issues aus Tasks anlegen / create issues from tasks |

Alle Voraussetzungen werden beim ersten Aufruf von `check-prerequisites.sh` geprüft.

---

### KI-Agenten einrichten / Set up AI agents

Je nachdem welchen KI-Agenten du bevorzugst, sind unterschiedliche Schritte nötig.
Dieses Repo unterstützt alle fünf nachfolgend beschriebenen Agenten.

*Depending on which AI agent you prefer, different setup steps are needed. This repo supports all five agents described below.*

Der Zweck dieses Abschnitts ist zweigeteilt: Erstens sollst du den Agenten technisch zum Laufen bringen, zweitens soll klar werden, **wie Spec-Kit den jeweiligen Agenten integriert**. Nicht jeder Agent arbeitet mit demselben Mechanismus. Manche lesen Projektdateien wie `AGENTS.md` direkt als Kontext, andere entdecken Kommandos oder Skills in agentenspezifischen Verzeichnissen wie `.claude/commands/`, `.gemini/commands/` oder `.agents/skills/`.

*This section has a two-part purpose: first, to get the agent running technically; second, to make clear **how Spec-Kit integrates with that specific agent**. Not every agent works through the same mechanism. Some read project files such as `AGENTS.md` directly as context, while others discover commands or skills from agent-specific directories such as `.claude/commands/`, `.gemini/commands/`, or `.agents/skills/`.*

Praktisch bedeutet das: Du waehlst nicht nur nach Geschmack, sondern auch nach deinem lokalen Setup und deinem Arbeitsstil. GitHub Copilot CLI passt gut zu einem `gh`-zentrierten Workflow, Claude Code ist stark fuer dialogische Codearbeit mit eigener Kommando-Struktur, Gemini CLI und Codex CLI sind npm-basierte Terminal-Agenten mit guter Repo-Orientierung, und OpenCode ist eine native Alternative mit aehnlichem `AGENTS.md`-Kontextmodell wie Codex.

*In practice, this means you are not choosing only by taste, but also by your local setup and working style. GitHub Copilot CLI fits well into a `gh`-centric workflow, Claude Code is strong for conversational coding with its own command structure, Gemini CLI and Codex CLI are npm-based terminal agents with good repository orientation, and OpenCode is a native alternative with a similar `AGENTS.md` context model to Codex.*

Wichtig fuer den Ablauf: Nach der Agenten-Installation solltest du **nicht sofort `specify init` starten**, sondern zuerst den Abschnitt `Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory` lesen. Dort wird `uv`, `specify-cli` und der korrekte Initialisierungsweg eingerichtet. Dieser Schritt ist Voraussetzung dafuer, dass die nachfolgenden Spec-Kit-Befehle ueberhaupt sauber funktionieren.

*One workflow detail matters especially: after installing the agent, you should **not jump directly to `specify init`**, but first read the section `Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory`. That is where `uv`, `specify-cli`, and the correct initialization path are set up. This step is a prerequisite for the later Spec-Kit commands to work properly at all.*

#### GitHub Copilot CLI (empfohlen / recommended)

Spec-Kit-Skills in `.agents/skills/` werden von der Copilot CLI automatisch erkannt — keine weitere Einrichtung nötig.

*Spec-Kit skills in `.agents/skills/` are automatically discovered by the Copilot CLI — no further setup needed.*

Copilot CLI ist in diesem Repository der am niedrigsten reibende Einstieg, wenn `gh` ohnehin schon benutzt wird. Der Vorteil liegt nicht nur in der Installation, sondern auch darin, dass Copilot CLI gut zu einem GitHub-zentrierten Workflow mit Repos, Issues und Terminal-Aufrufen passt. Fuer Spec-Kit ist besonders wichtig, dass die vorhandenen Skills in `.agents/skills/` direkt gefunden werden koennen, ohne dass du zusaetzliche Integrationsdateien erzeugen musst.

*In this repository, Copilot CLI is the lowest-friction entry point if you already use `gh` anyway. The advantage is not only installation, but also that Copilot CLI fits naturally into a GitHub-centred workflow with repositories, issues, and terminal commands. For Spec-Kit, the key point is that the existing skills in `.agents/skills/` can be discovered directly without creating additional integration files first.*

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

Wenn du zusaetzlich auf mehreren Maschinen dieselbe Copilot-CLI-Darstellung oder dieselben Reasoning-Defaults haben willst, kannst du danach optional noch `setup-copilot-settings.*` aus dem frueheren Abschnitt `Einrichtung der KI-Agenten / AI Agent Setup` verwenden. Das ist fuer Spec-Kit nicht zwingend, aber fuer eine konsistente Arbeitsumgebung sinnvoll.

*If you also want the same Copilot CLI appearance or the same reasoning defaults across several machines, you can optionally apply `setup-copilot-settings.*` afterwards from the earlier section `Einrichtung der KI-Agenten / AI Agent Setup`. That is not required for Spec-Kit itself, but useful for a consistent working environment.*

→ Nächster Schritt / Next step: [Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory](#verzeichnis-für-spec-kit-vorbereiten--prepare-a-directory)

---

#### Claude Code / Claude Code

Claude erkennt Spec-Kit-Kommandos über das `.claude/commands/`-Verzeichnis automatisch.

*Claude automatically discovers Spec-Kit commands via `.claude/commands/`.*

Claude Code eignet sich besonders dann, wenn du einen stark dialogorientierten Agenten suchst, der Kommandos und Kontext eng mit dem aktuellen Projekt verbindet. Fuer Spec-Kit ist die eingebaute Kommandostruktur wichtig: Die benoetigten Befehle werden aus `.claude/commands/` erkannt, sodass du im Chat gezielt durch den SDD-Workflow gehen kannst, ohne die Integrationsdateien selbst manuell vorbereiten zu muessen.

*Claude Code is especially useful if you want a strongly dialogue-oriented agent that ties commands and context closely to the current project. For Spec-Kit, the built-in command structure is the important part: the necessary commands are discovered from `.claude/commands/`, so you can move through the SDD workflow in chat without having to prepare the integration files manually yourself.*

> **Voraussetzung / Prerequisite:** Anthropic-Account (Pro, Max, Teams oder Enterprise) — kein Node.js nötig.
>
> *An Anthropic account (Pro, Max, Teams or Enterprise) is required — Node.js is not needed.*

| Plattform / Platform | Installation / Installation |
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

Optional kannst du danach noch `setup-claude-settings.*` aus dem weiter oben dokumentierten Agenten-Setup-Block ausfuehren, wenn du auf allen Geraeten dieselbe `statusLine` mit Modell-, Branch- und Limit-Anzeige haben willst. Die eigentliche Spec-Kit-Integration funktioniert aber bereits ueber `.claude/commands/`.

*Afterwards, you can optionally run `setup-claude-settings.*` from the agent setup block documented earlier if you want the same `statusLine` with model, branch, and limit display on all devices. The actual Spec-Kit integration, however, already works via `.claude/commands/`.*

→ Nächster Schritt / Next step: [Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory](#verzeichnis-für-spec-kit-vorbereiten--prepare-a-directory)

---

#### Gemini CLI / Gemini CLI

Gemini erkennt Spec-Kit-Kommandos über das `.gemini/commands/`-Verzeichnis automatisch.

*Gemini automatically discovers Spec-Kit commands via `.gemini/commands/`.*

Gemini CLI ist vor allem dann passend, wenn du bereits mit einer npm-basierten Toolchain arbeitest und einen schlanken Terminal-Agenten mit direkter Projektanbindung willst. Innerhalb dieses Repositories wird Spec-Kit ueber `.gemini/commands/` eingebunden, also aehnlich klar strukturiert wie bei Claude, aber mit dem typischen Gemini-CLI-Workflow.

*Gemini CLI is especially suitable if you already work with an npm-based toolchain and want a lean terminal agent with direct project integration. In this repository, Spec-Kit is integrated via `.gemini/commands/`, so the structure is similarly clear to Claude, but with the typical Gemini CLI workflow.*

> **Voraussetzung / Prerequisite:** Node.js ≥ 22 LTS, Google-Account

| Plattform / Platform | Installation / Installation |
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

Wenn du die TUI-Darstellung auf mehreren Maschinen vereinheitlichen willst, kannst du anschliessend noch `setup-gemini-settings.*` aus dem frueheren Setup-Abschnitt verwenden. Fuer die Spec-Kit-Kommandos selbst ist das optional; entscheidend ist, dass `gemini` installiert und im Projekt lauffaehig ist.

*If you want to standardise the TUI display across multiple machines, you can then also use `setup-gemini-settings.*` from the earlier setup section. That is optional for the Spec-Kit commands themselves; what matters is that `gemini` is installed and working inside the project.*

→ Nächster Schritt / Next step: [Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory](#verzeichnis-für-spec-kit-vorbereiten--prepare-a-directory)

---

#### Codex CLI (OpenAI) / Codex CLI (OpenAI)

Codex liest `AGENTS.md` als Kontext-Datei; alle Spec-Kit-Artefakte (`spec.md`, `plan.md`, `tasks.md`) stehen als Eingabe zur Verfügung.

*Codex reads `AGENTS.md` as project context; all Spec-Kit artefacts are available as input.*

Codex CLI ist in diesem Setup besonders stark, wenn du repo-nahe Arbeit mit klarer Projektkontext-Datei bevorzugst. Die Spec-Kit-Integration wird heute wie die anderen Agenten ueber `specify init --here --force --integration codex` eingerichtet.

*Codex CLI is especially strong in this setup if you prefer repository-close work with an explicit project context file. Spec-Kit integration is now initialized like the other agents via `specify init --here --force --integration codex`.*

> **Voraussetzung / Prerequisite:** Node.js ≥ 22 LTS, OpenAI-Account (API-Key **oder** ChatGPT Plus/Pro/Business/Enterprise)

| Plattform / Platform | Installation / Installation |
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

Wenn du ausserdem eine konsistente TUI-Statuszeile willst, ist `setup-codex-settings.*` der passende zweite Schritt aus dem frueheren Agenten-Setup-Block. Fuer Spec-Kit selbst ist wichtiger, dass du spaeter die agentenweise Initialisierung mit `--force --integration` verwendest.

*If you also want a consistent TUI status line, `setup-codex-settings.*` is the right second step from the earlier agent setup block. For Spec-Kit itself, the more important point is to use the per-agent initialization with `--force --integration`.*

→ Nächster Schritt / Next step: [Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory](#verzeichnis-für-spec-kit-vorbereiten--prepare-a-directory)

---

#### OpenCode / OpenCode

OpenCode liest ebenfalls `AGENTS.md` und unterstützt damit denselben Kontext wie Codex.

*OpenCode also reads `AGENTS.md` and therefore supports the same project context as Codex.*

OpenCode ist die native Alternative in dieser Liste und passt gut, wenn du keinen npm-basierten Agenten installieren willst. Fuer Spec-Kit ist der wichtige Punkt, dass OpenCode ebenso mit `AGENTS.md` als Projektkontext arbeitet. Dadurch ist die Arbeitsweise konzeptionell nah an Codex, auch wenn Installation und Laufzeitmodell unterschiedlich sind.

*OpenCode is the native alternative in this list and fits well if you do not want to install an npm-based agent. For Spec-Kit, the important point is that OpenCode also works with `AGENTS.md` as project context. That makes the overall working model conceptually close to Codex even though installation and runtime differ.*

> **Voraussetzung / Prerequisite:** Kein Node.js nötig — natives Binary / No Node.js required — native binary

| Plattform / Platform | Installation / Installation |
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

→ Nächster Schritt / Next step: [Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory](#verzeichnis-für-spec-kit-vorbereiten--prepare-a-directory)

---

### Verzeichnis für Spec-Kit vorbereiten / Prepare a directory

#### `uv` und `specify-cli` installieren / Install `uv` and `specify-cli`

`specify` benötigt den Python-Paketmanager `uv`. Installiere zuerst `uv`, dann `specify-cli`:

*`specify` requires the Python package manager `uv`. Install `uv` first, then `specify-cli`:*

| Plattform / Platform | `uv` installieren / Install `uv` |
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
uvx --from git+https://github.com/github/spec-kit.git@vX.Y.Z specify init --here --force --integration copilot

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
specify init MeinProjekt --integration copilot

# In bestehendem Verzeichnis initialisieren / Initialize in existing directory
cd ~/MeinProjekt

# Alle Agenten-Integrationen nacheinander / All agent integrations in sequence
specify init --here --force --integration gemini
specify init --here --force --integration opencode
specify init --here --force --integration claude
specify init --here --force --integration copilot
specify init --here --force --integration codex
```

> **Hinweis / Note:**
> Fuer bestehende home-baseline-Repos bevorzugt `scripts/update-spec-kit.*` die neue Spec-Kit-Integration: `specify init --here --force --integration <agent>`. Die alte `--ai`-Form ist nur noch ein Kompatibilitaets-Fallback in den Update-Skripten.
> *For existing home-baseline repositories, `scripts/update-spec-kit.*` prefers the new Spec-Kit integration form: `specify init --here --force --integration <agent>`. The old `--ai` form is only kept as a compatibility fallback in the update scripts.*

> **Tipp / Tip:** `bootstrap-workspace.sh` / `bootstrap-workspace.ps1` richtet all das automatisch ein.
> *Using `bootstrap-workspace.sh` / `bootstrap-workspace.ps1` sets everything up automatically.*

Repo-weite Spec-Kit-Aktualisierungen ueber alle Level-0-, Level-1- und
Level-2-Repositories laufen ueber:

*Repository-wide Spec-Kit updates across all Level-0, Level-1, and Level-2
repositories use:*

```bash
bash scripts/update-spec-kit.sh --dry-run
bash scripts/update-spec-kit.sh --commit --push
```

```powershell
pwsh scripts/update-spec-kit.ps1 -WhatIf
pwsh scripts/update-spec-kit.ps1 -Commit -Push
```

Die Skripte erkennen Repos dynamisch ueber `.git` plus `.specify/`, sichern
`.specify/memory/constitution.md`, legen die lokalen Governance-Templates wieder
auf und tracken fuer OpenCode nur `.opencode/command/*.md`.

*The scripts dynamically discover repositories via `.git` plus `.specify/`,
preserve `.specify/memory/constitution.md`, reapply the local governance
templates, and track only `.opencode/command/*.md` for OpenCode.*

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

| Kommando / Command | Beschreibung / Description |
|---|---|
| `speckit.specify` | Erstellt aus einer natuerlichen Feature-Beschreibung die erste fachliche Spezifikation in `spec.md` und legt in typischen Setups auch den zugehoerigen Branch oder Feature-Kontext an. Das ist fast immer der fachliche Einstiegspunkt in den SDD-Workflow. / Creates the first functional specification in `spec.md` from a natural-language feature description and, in typical setups, also creates the related branch or feature context. This is almost always the functional entry point into the SDD workflow. |
| `speckit.clarify` | Liest die vorhandene Spezifikation und identifiziert offene, mehrdeutige oder unterbestimmte Punkte. Ziel ist nicht Implementierung, sondern saubere fachliche Klaerung, bevor Entwurf und Tasks gebaut werden. / Reads the existing specification and identifies open, ambiguous, or underspecified points. The goal is not implementation, but clean functional clarification before design and task generation begin. |
| `speckit.plan` | Erzeugt den technischen Umsetzungsplan in `plan.md`, typischerweise mit Architektur, betroffenen Bereichen, Risiken, Datenmodell- oder Schnittstellenueberlegungen. Dieser Schritt uebersetzt die fachliche Spezifikation in einen technischen Entwurf. / Produces the technical implementation plan in `plan.md`, typically including architecture, affected areas, risks, and data model or interface considerations. This step translates the functional specification into a technical design. |
| `speckit.checklist` | Generiert eine individuelle Checkliste fuer das konkrete Feature, zum Beispiel fuer Akzeptanzkriterien, Randfaelle, Testpunkte oder Qualitaetsfragen. Das ist besonders nuetzlich, wenn vor der Implementierung noch einmal explizit auf Vollstaendigkeit geschaut werden soll. / Generates a custom checklist for the specific feature, for example for acceptance criteria, edge cases, test points, or quality questions. This is especially useful when you want an explicit completeness pass before implementation starts. |
| `speckit.tasks` | Zerlegt den Plan in eine geordnete, abhaengige Task-Liste in `tasks.md`. Das Ergebnis ist die operative Arbeitsgrundlage fuer die eigentliche Umsetzung. / Breaks the plan down into an ordered task list with dependencies in `tasks.md`. The result is the operational working basis for the actual implementation. |
| `speckit.analyze` | Fuehrt einen Konsistenz-Check ueber die vorhandenen Artefakte wie `spec.md`, `plan.md` und `tasks.md` aus. Dabei werden Luecken, Widersprueche oder schwach gekoppelte Stellen sichtbar, bevor Code geschrieben wird. / Runs a consistency check across existing artefacts such as `spec.md`, `plan.md`, and `tasks.md`. This exposes gaps, contradictions, or weak handoffs before code is written. |
| `speckit.implement` | Arbeitet die in `tasks.md` definierten Aufgaben schrittweise ab und fuehrt damit den Uebergang von Planung zu realer Umsetzung aus. In der Praxis ist das der Schritt, in dem der Agent beginnt, Aenderungen im Projekt vorzunehmen. / Processes the tasks defined in `tasks.md` step by step and performs the transition from planning to real implementation. In practice, this is the step where the agent begins to make changes inside the project. |
| `speckit.constitution` | Erstellt oder aktualisiert die Projekt-Verfassung `constitution.md`, also die uebergreifenden Regeln und Prinzipien, die kuenftige Features, Tasks und Agentenentscheidungen rahmen. Das ist eher ein Governance- als ein Feature-Befehl. / Creates or updates the project constitution `constitution.md`, meaning the higher-level rules and principles that frame future features, tasks, and agent decisions. This is more of a governance command than a feature command. |
| `speckit.taskstoissues` | Ueberfuehrt die Aufgaben aus `tasks.md` in GitHub Issues. Das ist dann sinnvoll, wenn aus dem internen Plan ein sichtbarer, teamfaehiger Arbeits-Backlog werden soll. / Converts the tasks from `tasks.md` into GitHub issues. This is useful when the internal plan should become a visible, team-ready work backlog. |

---

### Beispiel: Erstes Feature anlegen / Example: Creating your first feature

Das folgende Beispiel zeigt den vollständigen Ablauf für ein Login-Feature.

*The following example shows the complete flow for a login feature.*

Der Sinn dieses Beispiels ist nicht nur zu zeigen, **welche Befehle** nacheinander aufgerufen werden, sondern auch, **warum diese Reihenfolge sinnvoll ist**. Jeder Schritt reduziert eine andere Art von Unsicherheit: `specify` klärt das Ziel, `clarify` schließt Lücken, `plan` macht daraus einen technischen Entwurf, `tasks` erzeugt eine operative Arbeitsliste und `analyze` prüft noch einmal, ob die Artefakte wirklich zusammenpassen, bevor `implement` produktiv wird.

*The purpose of this example is not only to show **which commands** are run in sequence, but also **why that order makes sense**. Each step reduces a different kind of uncertainty: `specify` clarifies the goal, `clarify` closes gaps, `plan` turns the result into a technical design, `tasks` creates an operational work list, and `analyze` checks once more that the artefacts actually fit together before `implement` becomes productive.*

Gerade fuer das erste eigene Feature ist diese Reihenfolge wichtig, weil man sonst leicht direkt in Implementierungsdetails springt und spaeter feststellt, dass Anforderungen, Randfaelle oder Architekturannahmen noch gar nicht sauber geklaert waren. Das Beispiel zeigt deshalb bewusst einen **vollstaendigen** SDD-Durchlauf und nicht nur einen einzelnen Prompt.

*This order is especially important for your first real feature, because otherwise it is easy to jump straight into implementation details and only later realise that requirements, edge cases, or architectural assumptions were never clarified properly. The example therefore shows a deliberately **complete** SDD pass, not just a single prompt.*

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

Was man an diesem Beispiel gut sehen kann:

- Nach `speckit.specify` existiert noch **kein** fertiger technischer Entwurf, sondern zunaechst nur die fachliche Zielbeschreibung. Genau das ist gewollt: In diesem Schritt geht es darum, das Feature sauber zu umreissen, den gewuenschten Nutzen zu benennen und erste Akzeptanzkriterien sichtbar zu machen, ohne sich schon zu frueh auf eine technische Loesung festzulegen.
- Nach `speckit.clarify` sollte die Spezifikation belastbarer sein, weil unklare Punkte aktiv in Fragen verwandelt wurden. Gute Klaerungsfragen verhindern spaeter teure Richtungswechsel, weil Randbedingungen, Sicherheitsannahmen, UX-Erwartungen oder Integrationsdetails frueh explizit gemacht werden.
- Nach `speckit.plan` ist aus der Fachbeschreibung ein technisches Arbeitsmodell geworden. In diesem Schritt entsteht typischerweise die Bruecke zwischen "Was soll das Feature koennen?" und "Welche Komponenten, Dateien, Schnittstellen und Risiken sind dafuer relevant?".
- Nach `speckit.checklist` gibt es einen zusaetzlichen Qualitaetsblick auf das Feature selbst. Dieser Schritt ist besonders nuetzlich, wenn Teams oder Einzelentwickler sicherstellen wollen, dass Akzeptanzkriterien, Testpunkte, Randfaelle und nicht-funktionale Erwartungen nicht stillschweigend vergessen werden.
- Nach `speckit.tasks` gibt es nicht nur "Ideen", sondern eine geordnete Reihenfolge fuer die Umsetzung. Das ist wichtig, weil gute Aufgabenlisten Abhaengigkeiten sichtbar machen, Arbeit in sinnvolle Einheiten zerlegen und dadurch sowohl manuelle Umsetzung als auch agentische Umsetzung deutlich robuster machen.
- Nach `speckit.analyze` liegt idealerweise ein letzter Qualitaetsfilter vor, bevor echter Code geschrieben wird. Der Wert dieses Schritts liegt vor allem darin, dass Widersprueche zwischen `spec.md`, `plan.md` und `tasks.md` jetzt noch billig zu beheben sind - spaeter im Code waeren dieselben Widersprueche deutlich teurer.
- Erst `speckit.implement` ist der Schritt, in dem der Agent wirklich mit produktiven Code-Aenderungen beginnt. Das ist bewusst der spaeteste Schritt in der Kette, weil die vorherigen Artefakte dafuer sorgen sollen, dass Implementierung nicht mehr als unscharfes Experiment startet, sondern als nachvollziehbarer Arbeitsauftrag.

*What this example shows especially well:*

- *After `speckit.specify`, there is **not yet** a finished technical design, only the functional target description. That is intentional: this step is about defining the feature cleanly, naming its expected value, and making early acceptance criteria visible without locking into a technical solution too early.*
- *After `speckit.clarify`, the specification should be more robust because unclear points were actively turned into explicit questions. Good clarification questions prevent expensive direction changes later by making constraints, security assumptions, UX expectations, or integration details explicit early on.*
- *After `speckit.plan`, the functional description has become a technical working model. This is usually the bridge between "What should the feature do?" and "Which components, files, interfaces, and risks matter for implementing it?".*
- *After `speckit.checklist`, there is an additional quality lens on the feature itself. This step is especially useful when a team or individual wants to make sure that acceptance criteria, test points, edge cases, and non-functional expectations are not silently forgotten.*
- *After `speckit.tasks`, you no longer only have "ideas", but an ordered implementation sequence. This matters because good task lists make dependencies visible, break work into meaningful units, and thereby make both manual execution and agentic execution much more robust.*
- *After `speckit.analyze`, there is ideally a final quality filter before real code is written. The value of this step is that contradictions between `spec.md`, `plan.md`, and `tasks.md` are still cheap to fix now, whereas the same contradictions would become much more expensive once they are baked into code.*
- *Only `speckit.implement` is the step where the agent actually starts making productive code changes. It is intentionally the last step in the chain, because the previous artefacts are meant to ensure that implementation no longer starts as a vague experiment, but as a traceable work order.*

Als praktische Faustregel gilt: Wenn sich ein Schritt "zu frueh" anfuehlt, ist das oft ein Signal, dass der vorherige Artefaktschritt noch nicht sauber genug ist. Wenn also `implement` zu riskant wirkt, fehlt haeufig noch Schaerfe in `spec.md`, `plan.md` oder `tasks.md` - nicht unbedingt mehr Programmieraufwand.

*A practical rule of thumb is: if a step feels "too early", that is often a signal that the previous artefact step is not clean enough yet. So if `implement` feels too risky, what is often missing is sharper work in `spec.md`, `plan.md`, or `tasks.md` - not necessarily more coding effort.*

---

### Artefakte und Verzeichnisstruktur / Artefacts and directory structure

Nach einem vollständigen Spec-Kit-Workflow sieht das `specs/`-Verzeichnis so aus:

Dieser Abschnitt ist wichtig, weil Spec-Kit nicht nur "irgendwelche Dateien" erzeugt, sondern eine **strukturierte Entscheidungs- und Arbeitskette**. Die Dateien im `specs/`-Verzeichnis haben unterschiedliche Rollen: Einige beschreiben fachliche Anforderungen, andere den technischen Entwurf, andere wieder die konkrete Ausführungsreihenfolge. Wer diese Rollen versteht, kann sehr viel schneller beurteilen, ob ein Feature schon sauber vorbereitet ist oder ob noch Lücken zwischen Idee, Plan und Umsetzung bestehen.

*This section matters because Spec-Kit does not just generate "some files", but a **structured chain of decisions and work artefacts**. The files inside `specs/` play different roles: some describe functional requirements, others the technical design, and others the concrete execution order. If you understand these roles, you can judge much faster whether a feature is already well prepared or whether gaps still exist between idea, plan, and implementation.*

Als Faustregel kann man die Artefakte so lesen: `spec.md` beantwortet vor allem **was** gebaut werden soll, `plan.md` beschreibt **wie** man es technisch denkt, `tasks.md` organisiert **in welcher Reihenfolge** gearbeitet wird. Die optionalen Dateien wie `research.md`, `data-model.md`, `quickstart.md` oder `contracts/` sind Vertiefungen fuer spezielle Fragestellungen und helfen dabei, Entscheidungen aus dem Hauptfluss auszulagern, statt `spec.md` oder `plan.md` zu ueberladen.

*A useful rule of thumb is to read the artefacts like this: `spec.md` mainly answers **what** should be built, `plan.md` describes **how** it is approached technically, and `tasks.md` organises **in which order** the work should happen. The optional files such as `research.md`, `data-model.md`, `quickstart.md`, or `contracts/` are deepening artefacts for specific concerns and help move detail out of the main flow instead of overloading `spec.md` or `plan.md`.*

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

Die Verzeichnisstruktur ist deshalb nicht nur Dokumentation, sondern auch ein Qualitaetssignal. Wenn zum Beispiel `tasks.md` schon existiert, aber `plan.md` noch sehr duenn oder widerspruechlich ist, deutet das oft darauf hin, dass die Aufgabenliste zu frueh erstellt wurde. Umgekehrt ist ein Feature meist gut vorbereitet, wenn die Artefakte sichtbar aufeinander aufbauen und die optionalen Dateien nur dort auftauchen, wo sie wirklich zusaetzlichen Erkenntniswert liefern.

*The directory structure is therefore not only documentation, but also a quality signal. For example, if `tasks.md` already exists while `plan.md` is still thin or contradictory, that often means the task list was created too early. Conversely, a feature is usually well prepared when the artefacts visibly build on one another and the optional files appear only where they add real extra insight.*

Alle Artefakte werden automatisch in Git versioniert — du kannst jederzeit nachvollziehen, wie eine Entscheidung entstanden ist.

*All artefacts are automatically versioned in Git — you can always trace back how a decision was made.*

---

<!-- EN: README.md placeholder
[DE-Zusammenfassung: Vollständige bilinguale README für home-baseline mit Workspace-Tabelle, Scripts, A11Y-, Spec-kit- und Azubis-Abschnitten.]
-->

## Bekannte Fallstricke / Known Pitfalls

Dieser Abschnitt sammelt die **haeufigsten wiederkehrenden Fehlerbilder**, die bei Bootstrap, Migration, Sync, CI und Agenten-Setup in der Praxis bereits aufgetreten sind. Er ist bewusst nicht als vollstaendige Fehlerdokumentation gedacht, sondern als schneller Diagnoseblock fuer die typischen Stellen, an denen Plattformunterschiede, Shell-Eigenheiten oder Tooling-Defaults zu unerwartetem Verhalten fuehren.

*This section collects the **most common recurring failure patterns** that have already appeared in practice during bootstrap, migration, sync, CI, and agent setup. It is intentionally not meant to be a complete error catalog, but a fast diagnostic block for the places where platform differences, shell quirks, or tooling defaults most often lead to unexpected behaviour.*

Als Leseregel gilt: Die Spalte `Ursache / Cause` erklaert den eigentlichen technischen Ausloeser, nicht nur das Symptom. Die Spalte `Fix / Fix` nennt deshalb moeglichst den kleinsten robusten Eingriff, mit dem der Fehler reproduzierbar beseitigt oder kuenftig vermieden wird.

*The reading rule is: the `Ursache / Cause` column explains the actual technical trigger, not just the symptom. The `Fix / Fix` column therefore tries to name the smallest robust intervention that reproducibly removes the problem or prevents it in the future.*

| Problem / Problem | Ursache / Cause | Fix / Fix |
|---|---|---|
| `$env:HOME` leer / empty (Windows) | In PowerShell 7 behandelt der Null-Coalescing-Operator `??` nur `$null`, aber nicht den leeren String `''`. Einige Windows-Umgebungen liefern fuer `HOME` genau diesen leeren Wert und brechen dadurch spaetere Pfadauflosungen. / In PowerShell 7, the null-coalescing operator `??` handles only `$null`, not the empty string `''`. Some Windows environments provide exactly that empty value for `HOME`, which then breaks later path resolution. | Home immer explizit auf Inhalt pruefen und sonst auf `$env:USERPROFILE` fallen, z. B. `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`. / Always test whether Home actually contains a value and otherwise fall back to `$env:USERPROFILE`, for example `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`. |
| CI: Dateien „missing" / files "missing" | Der Scanner bekommt relative Pfade, waehrend der Runner effektiv im Repo-Root steht. Dadurch werden Dateien an der falschen Stelle gesucht, obwohl sie im Checkout vorhanden sind. / The scanner receives relative paths while the runner is effectively located at the repository root. As a result, files are looked up in the wrong place even though they exist in the checkout. | Vor dem Scanner-Aufruf bewusst in das erwartete Arbeitsverzeichnis wechseln, z. B. `cd "$(dirname $GITHUB_WORKSPACE)"`, damit relative Pfade wieder zur Repo-Struktur passen. / Move into the expected working directory before running the scanner, for example `cd "$(dirname $GITHUB_WORKSPACE)"`, so relative paths match the repository structure again. |
| `bash` bad substitution | Die Array-Kurzform `${#arr[@]+...}` ist nicht auf allen Zielsystemen gleich gut nutzbar; insbesondere aeltere oder konservative Bash-Varianten auf Ubuntu 22.04 reagieren hier empfindlich. / The short array form `${#arr[@]+...}` is not equally portable across target systems; older or more conservative Bash variants on Ubuntu 22.04 are especially sensitive here. | Statt kompakter Spezialsyntax eine Bash-3-sichere `for`-Schleife oder eine explizite Zaehllogik verwenden. Das ist etwas laenger, aber plattformstabiler. / Use a Bash-3-safe `for` loop or explicit counting logic instead of compact special syntax. It is a bit longer, but much more stable across platforms. |
| `Copy-Item` kopiert Verzeichnis in Verzeichnis / copies directory into directory | Wenn das Zielverzeichnis bereits existiert, legt `Copy-Item` standardmaessig oft einen zusaetzlichen Unterordner an, statt nur den Inhalt hineinzukopieren. / When the target directory already exists, `Copy-Item` often creates an extra nested directory instead of copying only the contents into it. | Den Inhalt statt des Verzeichnisses selbst kopieren, z. B. `Copy-Item src/* dst/ -Recurse -Force`, damit die Zielstruktur exakt erhalten bleibt. / Copy the contents instead of the directory object itself, for example `Copy-Item src/* dst/ -Recurse -Force`, so the target structure stays exact. |
| `LICENSE` von `.gitignore` ignoriert / ignored by `.gitignore` | Bei einem Whitelist-Modell kann `LICENSE` unabsichtlich mit ausgefiltert werden, wenn die ausdrueckliche Ausnahme fehlt. Dann wirkt die Datei lokal vorhanden, wird aber nicht versioniert. / In a whitelist model, `LICENSE` can accidentally be filtered out if the explicit exception is missing. The file then appears locally present but is not actually versioned. | `!LICENSE` explizit in `.gitignore` aufnehmen, damit die Datei trotz uebergeordneter Ignore-Regeln immer wieder freigeschaltet wird. / Add `!LICENSE` explicitly to `.gitignore` so the file is always re-included despite broader ignore rules. |
| ANSI-Falsch-Positive im Scanner / ANSI false positives in scanner | Der Scanner enthaelt selbst Escape-Sequenzen wie `\\033[` als Literal. Ohne Ausnahme wuerde er also seine eigene Implementierung als problematischen ANSI-Inhalt markieren. / The scanner itself contains escape sequences such as `\\033[` as literals. Without an exception, it would flag its own implementation as problematic ANSI content. | `check-homogeneity.*` gezielt vom ANSI-Scan ausnehmen, damit nur gescannte Zieldateien und nicht die Scanner-Implementierung bewertet werden. / Exclude `check-homogeneity.*` specifically from the ANSI scan so that only scanned target files, not the scanner implementation itself, are evaluated. |
| Bootstrap hardcodierter Username / hard-coded username | Ein fest eingebauter Login wie `hindermath` funktioniert nur fuer genau eine Identitaet und macht das Template sofort unbrauchbar fuer andere Nutzer oder Accounts. / A built-in login such as `hindermath` works for exactly one identity and immediately makes the template unusable for other users or accounts. | Den GitHub-Login immer dynamisch ueber `gh api user --jq '.login'` abfragen und daraus Namen oder Remotes ableiten. / Always resolve the GitHub login dynamically via `gh api user --jq '.login'` and derive names or remotes from that value. |
| `gh auth login --web` bleibt haengen / hangs | In Hintergrund- oder Async-Prozessen kommt der Browser-Callback nicht sauber zum CLI-Prozess zurueck. Das Login wirkt dann eingefroren, obwohl der Browser schon geoefnet wurde. / In background or async processes, the browser callback does not return cleanly to the CLI process. The login then appears frozen even though the browser was already opened. | `gh auth login --web` nur in einem echten interaktiven Terminalfenster ausfuehren, nicht aus einem Hintergrundprozess oder Agenten-Subprozess heraus. / Run `gh auth login --web` only in a real interactive terminal window, not from a background process or agent subprocess. |
| `glab auth login` bleibt haengen / hangs | Gleiches Muster wie bei `gh`: die Web-Authentifizierung verlaesst sich auf einen Rueckkanal zum interaktiven Prozess, der im Hintergrund oft fehlt oder blockiert ist. / Same pattern as with `gh`: web authentication relies on a callback to the interactive process, which is often missing or blocked in background execution. | `glab auth login` ebenfalls nur interaktiv starten, damit Browser-Callback und Token-Speicherung sauber abgeschlossen werden koennen. / Start `glab auth login` interactively as well so browser callback handling and token storage can complete correctly. |
| `gh` keyring invalid (Windows) | Der Windows Credential Store oder der gespeicherte `gh`-Eintrag ist inkonsistent oder beschaedigt. Dann scheitert `gh` trotz eigentlich gueltigem Konto an der lokalen Secret-Ablage. / The Windows Credential Store or the saved `gh` entry is inconsistent or corrupted. In that case `gh` fails at the local secret store even though the account itself may still be valid. | Den gespeicherten Eintrag mit `gh auth logout` entfernen, danach `gh auth login` erneut ausfuehren und zum Schluss `gh auth setup-git` zur sauberen Git-Integration nachziehen. / Remove the stored entry with `gh auth logout`, then run `gh auth login` again, and finally run `gh auth setup-git` to restore clean git integration. |
| `ssh-agent` startet nicht / does not start (Windows) | Der OpenSSH-Agent-Dienst ist auf vielen Windows-Systemen standardmaessig deaktiviert und laesst sich oft nur mit Admin-Rechten aktivieren. / The OpenSSH agent service is disabled by default on many Windows systems and often requires admin rights to enable. | Fuer diesen Workflow lieber HTTPS plus `gh auth setup-git` verwenden, statt sich auf einen lokal aktivierten SSH-Agenten zu verlassen. / Prefer HTTPS plus `gh auth setup-git` for this workflow instead of relying on a locally enabled SSH agent. |
| `CursorPosition`-Fehler in PS-Subprozessen / `CursorPosition` error in PS subprocesses | Subprozesse laden ohne Schutz das normale PowerShell-Profil mit Oh-My-Posh oder anderer TUI-Logik. In nicht interaktiven Kontexten ist das Konsolen-Handle dann oft ungueltig. / Subprocesses load the normal PowerShell profile unless prevented, including Oh-My-Posh or other TUI logic. In non-interactive contexts the console handle is then often invalid. | `pwsh`-Subprozesse grundsaetzlich mit `-NoProfile` starten, wenn sie nur Skripte ausfuehren sollen und keine interaktive Shell brauchen. / Start `pwsh` subprocesses with `-NoProfile` by default when they only need to run scripts and do not require an interactive shell profile. |
| Parallele `migrate-workspace.*`-Laeufe laufen in Timeouts / parallel `migrate-workspace.*` runs time out | Jeder Migrationslauf startet `init-stats.*`, das die Level-0/1/2-Statistiken global aktualisiert. Mehrere parallele Laeufe koennen sich gegenseitig ausbremsen oder Dateien gleichzeitig anfassen. / Each migration starts `init-stats.*`, which updates level 0/1/2 statistics globally. Several parallel runs can slow each other down or touch the same files at the same time. | Erst Vorschau mit `-WhatIf`/`--dry-run`, dann echte Migrationen seriell pro Workspace ausfuehren und bei Bedarf laengere Timeouts verwenden. / First run a preview with `-WhatIf`/`--dry-run`, then execute real migrations serially per workspace and use longer timeouts when needed. |
| `git pull` „divergent branches" (Linux) | Ohne globale Rebase-Strategie weiss Git bei bestimmten Abweichungen nicht, ob Merge oder Rebase der gewuenschte Standard sein soll, und stoppt mit Rueckfrage. / Without a global rebase strategy, Git may not know whether merge or rebase should be the default for certain branch divergences and stops with a prompt. | Einmalig `git config --global pull.rebase true` setzen, damit `git pull` fuer diesen Workflow konsistent auf Rebase ausgerichtet ist. / Set `git config --global pull.rebase true` once so `git pull` follows a consistent rebase-based workflow. |
| Push rejected: `fetch first` | Der Remote-Branch ist inzwischen weiter als der lokale Branch. Ein direkter Push wuerde fremde oder spaetere Commits ueberschreiben und wird deshalb abgelehnt. / The remote branch has moved ahead of the local branch. A direct push would overwrite foreign or later commits and is therefore rejected. | Erst mit `git pull --rebase --autostash` den Remote-Stand sauber einarbeiten und danach erneut `git push` ausfuehren. / First integrate the remote state cleanly with `git pull --rebase --autostash`, then run `git push` again. |
| Test-Script: unstaged changes blockieren pull / unstaged changes block pull | Die Test-Skripte erzeugen ihre Output-Datei schon vor dem Pull. Dadurch sieht Git lokale Aenderungen, die ohne Schutz den nachfolgenden Rebase oder Pull blockieren koennen. / The test scripts generate their output file before the pull happens. Git therefore sees local changes which can block the following rebase or pull unless they are handled explicitly. | In den Test-Skripten `git pull --rebase --autostash origin main` verwenden, damit die temporaeren Ausgabedateien waehrend des Pulls automatisch zwischengespeichert und wiederhergestellt werden. / Use `git pull --rebase --autostash origin main` inside the test scripts so temporary output files are stashed and restored automatically during the pull. |


## Barrierefreiheit / Accessibility (A11Y)

Dieses Dokument richtet sich nach **WCAG 2.2 Level AA** für alle statischen Inhalte.

*This document follows **WCAG 2.2 Level AA** guidelines for all static content.*

Der Abschnitt dokumentiert keine abstrakte Selbstverpflichtung, sondern die **konkreten redaktionellen Regeln**, nach denen diese README gepflegt wird. Ziel ist vor allem, dass Inhalte in GitHub Markdown auch ohne visuelle Hervorhebung, ohne Farbinformation und mit Screenreader oder reiner Tastaturnutzung moeglichst robust lesbar bleiben.

*This section does not describe an abstract intention, but the **concrete editorial rules** used to maintain this README. The main goal is that content remains robustly readable in GitHub Markdown even without visual emphasis, without colour cues, and with screen readers or keyboard-only navigation.*

Wichtig ist ausserdem die Grenze des Mediums: GitHub rendert kein vollwertiges barrierefreies HTML aus beliebigem Markdown, sondern eine Plattform mit festen Render-Regeln. Deshalb bedeutet A11Y hier vor allem: klare Struktur, beschreibende Texte, konsistente Sprachfuehrung, korrekt markierte Code-Bloecke und moeglichst semantisch saubere Tabellen statt visuell "schicker" Sonderloesungen.

*It is also important to understand the boundary of the medium: GitHub does not render arbitrary Markdown as fully accessible custom HTML, but as a platform with fixed rendering rules. In this context, accessibility mainly means clear structure, descriptive text, consistent bilingual language flow, correctly tagged code blocks, and semantically clean tables instead of visually "fancier" special formatting.*

| WCAG-Kriterium / Criterion | Umsetzung / Implementation |
|---|---|
| **1.1.1** Nicht-Text-Inhalt / Non-text content | Aktuell werden keine Bilder oder eingebetteten Grafiken verwendet. Falls spaeter visuelle Artefakte hinzukommen, muessen sie mit aussagekraeftigem Alternativtext oder textlicher Begleiterklaerung eingefuehrt werden. / There are currently no images or embedded graphics. If visual artefacts are added later, they must be introduced with meaningful alt text or an accompanying textual explanation. |
| **1.3.1** Info und Beziehungen / Info and relationships | Die README nutzt eine saubere Ueberschriftenhierarchie (`h1 -> h2 -> h3 -> h4`) ohne Ebenenspruenge. Tabellen werden bewusst mit Kopfzeilen gepflegt, damit Beziehungen auch fuer assistive Technologien nachvollziehbar bleiben. / The README uses a clean heading hierarchy (`h1 -> h2 -> h3 -> h4`) without skipping levels. Tables are deliberately maintained with header rows so structural relationships remain understandable for assistive technologies. |
| **1.3.2** Sinnvolle Reihenfolge / Meaningful sequence | Die Inhalte sind in einer logischen Reihenfolge aufgebaut: Orientierung, Voraussetzungen, Arbeitsablaeufe, Referenzbloecke, Fallstricke und A11Y. Zweisprachige Abschnitte folgen dabei konsequent dem Muster Deutsch zuerst, Englisch direkt danach. / Content follows a logical order: orientation, prerequisites, workflows, reference blocks, pitfalls, and accessibility. Bilingual sections also follow a consistent pattern: German first, English immediately afterwards. |
| **1.4.1** Verwendung von Farbe / Use of colour | Es wird keine Information ausschliesslich ueber Farbe, Emoji-Farbwirkung oder visuelle Hervorhebung transportiert. Bedeutungen werden immer durch Text, Struktur oder Beschriftung erklaert. / No information is conveyed through colour alone, emoji colour effects, or purely visual emphasis. Meaning is always explained through text, structure, or explicit labels. |
| **2.4.2** Seite mit Titel / Page titled | Der Dokumenttitel ist klar als `# home-baseline` gesetzt und beschreibt die Seite eindeutig. Dadurch bleibt die Seite in Browser-Tabs, Verlauf und Screenreader-Kontexten besser orientierbar. / The document title is clearly set as `# home-baseline` and identifies the page unambiguously. This improves orientation in browser tabs, history, and screen-reader contexts. |
| **2.4.4** Linkzweck / Link purpose | Links werden mit beschreibenden Texten formuliert, zum Beispiel `[Installationsanleitung](...)` statt generischer Marker wie `[hier](...)`. So bleibt das Linkziel auch ausserhalb des Fliesstexts verstaendlich. / Links use descriptive labels, for example `[Installationsanleitung](...)` instead of generic markers such as `[here](...)`. This keeps the destination understandable even outside the surrounding prose. |
| **2.4.6** Ueberschriften und Bezeichnungen / Headings and labels | Ueberschriften benennen Abschnitte moeglichst konkret und durchgaengig bilingual. Dadurch koennen Nutzer schneller scannen, in der TOC navigieren und Abschnittszwecke ohne Ratespiel erkennen. / Headings name sections as concretely as possible and remain consistently bilingual. This lets users scan faster, navigate the table of contents more reliably, and understand section purpose without guesswork. |
| **3.1.1** Sprache der Seite / Language of page | Die Hauptfuehrung ist Deutsch, englische Pendants folgen parallel und in wiederkehrendem Muster. Das verbessert Verstaendlichkeit fuer deutschsprachige Hauptnutzer und reduziert zugleich Sprachwechsel ohne Orientierung. / The primary flow is German, with English counterparts provided in parallel and in a recurring pattern. This improves clarity for German-speaking primary users while also reducing disorienting language switching. |
| **4.1.1** Syntaxanalyse / Parsing | Markdown-Elemente werden strukturiert und parserfreundlich gehalten: korrekt geschlossene Code-Bloecke, konsistente Tabellen, keine absichtlich kaputten HTML-Konstrukte und moeglichst wenig Render-Sonderfaelle. / Markdown elements are kept structured and parser-friendly: properly closed code blocks, consistent tables, no intentionally broken HTML constructs, and as few rendering edge cases as possible. |

> **Plattformeinschränkung / Platform limitation:** WCAG 3.1.2 (Sprache von Teilen) erfordert `lang`-Attribute
> an zweisprachigen Textstellen. GitHub Markdown entfernt HTML-Attribute — dies kann nicht implementiert werden.
>
> *WCAG 3.1.2 (Language of parts) requires `lang` attributes on bilingual passages.
> GitHub Markdown strips HTML attributes — this cannot be implemented on this platform.*

---

Regeln fuer neue Inhalte / Rules for new content:

- Code-Bloecke immer mit Sprachmarkierung anlegen, zum Beispiel ` ```bash `, ` ```powershell ` oder ` ```text `.
  Ohne Sprachmarkierung verlieren Syntax-Highlighting, Lesbarkeit und Parser-Stabilitaet schnell an Qualitaet.
  *Always add a language tag to code blocks, for example ` ```bash `, ` ```powershell `, or ` ```text `.
  Without a language tag, syntax highlighting, readability, and parser stability degrade quickly.*

- Tabellen immer mit Kopfzeile und Trennzeile schreiben, also nicht nur optisch, sondern semantisch als echte Markdown-Tabelle pflegen.
  Wenn eine Information nicht sauber tabellarisch ist, ist oft eine Liste oder ein kurzer Abschnitt die bessere und barriereaermere Form.
  *Always write tables with a header row and separator row, not just as something that looks tabular, but as a semantically valid Markdown table.
  If information is not truly tabular, a list or a short prose section is often the better and more accessible form.*

- Neue Abschnitte konsequent bilingual anlegen: zuerst der deutsche Absatz, direkt danach das englische Pendant in Kursiv.
  Das Ziel ist nicht perfekte literarische Uebersetzung, sondern stabile Parallelitaet, damit beide Sprachversionen denselben Informationsgehalt haben.
  *Create new sections consistently in bilingual form: first the German paragraph, then the English counterpart in italics directly afterwards.
  The goal is not literary perfection, but stable parallelism so both language versions carry the same information.*

- Die Ueberschriften-Hierarchie strikt einhalten: `h2 -> h3 -> h4`, ohne Ebenen zu ueberspringen.
  Eine visuell "passende" kleinere oder groessere Ueberschrift ist kein Grund, die semantische Struktur zu brechen.
  *Keep the heading hierarchy strict: `h2 -> h3 -> h4`, without skipping levels.
  A visually tempting smaller or larger heading is not a reason to break the semantic structure.*

- Linkbeschriftungen immer beschreibend formulieren und nie nur generisch als `[hier](...)`, `[here](...)` oder aehnlich.
  Der Linktext soll auch dann noch verstaendlich sein, wenn er von Screenreadern isoliert vorgelesen oder in einer Linkliste angezeigt wird.
  *Always phrase link labels descriptively and never as generic markers like `[here](...)` or similar.
  The link text should still make sense when read in isolation by a screen reader or shown in a link list.*

- Visuelle Sonderformen sparsam einsetzen.
  ASCII-Boxen, dekorative Trenner oder sehr dichte Tabellen sind nur dann sinnvoll, wenn sie den Informationswert wirklich erhoehen und nicht nur "schicker" aussehen.
  *Use visual special formatting sparingly.
  ASCII boxes, decorative separators, or very dense tables are only useful when they truly improve information value instead of merely looking "nicer".*

- Bei Beispielen und Kommandos moeglichst den realen Anwendungskontext mitgeben.
  Ein kurzer Kommentar wie `# macOS / Linux`, `# Windows`, `# Dry Run` oder `# Beispiel` hilft Lesern deutlich mehr als ein nackter Befehl ohne Einordnung.
  *For examples and commands, provide the real usage context whenever possible.
  A short comment like `# macOS / Linux`, `# Windows`, `# Dry Run`, or `# Example` helps readers much more than a bare command without context.*

- Wenn Plattformgrenzen oder GitHub-Rendering-Einschraenkungen bekannt sind, diese offen benennen statt sie durch fragiles Markdown zu kaschieren.
  Eine dokumentierte Grenze ist wartbarer und ehrlicher als ein scheinbar cleverer Workaround, der nur zufaellig im aktuellen Renderer funktioniert.
  *If platform limits or GitHub rendering constraints are known, state them openly instead of hiding them behind fragile Markdown tricks.
  A documented limitation is more maintainable and more honest than an apparently clever workaround that only happens to work in the current renderer.*
