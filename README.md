# home-baseline

<!-- include-everyone-guiding-principle -->
> **Leitsatz:** `Programmierung #include<everyone>`.
>
> **Guiding principle:** `Programming #include<everyone>`.
>
> **DE:** Wir gestalten Software, Dokumentation und Lernwege inklusiv und
> barrierefrei. WCAG 2.2 AA, Tastaturbedienung, Screenreader- und
> Texttauglichkeit werden von Anfang an beruecksichtigt und geprueft.
>
> **EN:** We design software, documentation, and learning paths to be inclusive
> and accessible. WCAG 2.2 AA, keyboard operation, screen-reader support, and
> text usability are considered and verified from the start.

<!-- learner-a11y-baseline:start -->
Die verbindliche Zielgruppen-, Sprach- und A11Y-Basis für Home Baseline,
ABS-DD-Sandbox, TuiVision, TinyPl0, TinyCalc und InventarWorkerService steht in
[`docs/learning-units/LERNENDEN-UND-A11Y-BASIS.md`](docs/learning-units/LERNENDEN-UND-A11Y-BASIS.md).
Sie richtet alle Lern- und Bedieninhalte ab dem ersten Ausbildungsjahr aus und
setzt keine Spec-Kit-Erfahrung voraus.

*The binding audience, language, and accessibility baseline for Home Baseline,
the ABS-DD sandbox, TuiVision, TinyPl0, TinyCalc, and InventarWorkerService is
defined in
[`docs/learning-units/LERNENDEN-UND-A11Y-BASIS.md`](docs/learning-units/LERNENDEN-UND-A11Y-BASIS.md).
It targets learners from their first training year and assumes no prior Spec
Kit experience.*
<!-- learner-a11y-baseline:end -->

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur.
Es enthält die Bootstrap-Scripts, mit denen jedes neue Projektverzeichnis in wenigen
Sekunden als synchronisiertes privates Repository auf GitHub, GitLab, Codeberg,
Forgejo oder einem manuell angebundenen Git-System eingerichtet werden kann.

*This repository is the **top level** of the private workspace infrastructure.
It contains bootstrap scripts to set up any new project directory as a synchronised
private repository on GitHub, GitLab, Codeberg, Forgejo, or a manually connected
Git system within seconds.*

> **Hinweis zur Erstellung / Creation notice:** Diese agentische
> Unterstützungs-Umgebung und wesentliche Dokumentations-, Lern- und
> Skriptinhalte wurden menschlich kuratiert, geprüft und fortgeschrieben; Teile
> wurden mit Hilfe und Unterstützung agentischer KI erstellt oder generiert.
> Menschliche Verantwortung, Prüfung und Freigabe bleiben maßgeblich.
>
> *This agentic support environment and substantial documentation, learning, and
> script content were human-curated, reviewed, and maintained; parts were created
> or generated with help and support from agentic AI. Human responsibility,
> review, and approval remain authoritative.*

> **Start fuer Lernende / Start for learners:** Beginne mit
> [`START-HERE-FUER-LERNENDE.md`](docs/learning-units/START-HERE-FUER-LERNENDE.md).
> Die Anleitung fuehrt vom persoenlichen Fork oder institutionell
> bereitgestellten Lernenden-Repository ueber die Required-Werkzeuge und
> die Podman-Sandbox bis zum ersten kontrollierten Agentenlauf.
>
> *Start with [`START-HERE-FUER-LERNENDE.md`](docs/learning-units/START-HERE-FUER-LERNENDE.md).
> It leads from your personal fork or institution-provided learner repository
> through the required tools and Podman sandbox
> to the first controlled agent run.*

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
  - [Generischer Leitfaden Sichere Entwicklung / Generic Secure Development Guide](#generischer-leitfaden-sichere-entwicklung--generic-secure-development-guide)
  - [Sicherheit / Security](#sicherheit--security)
  - [Einrichtung der KI-Agenten / AI Agent Setup](#einrichtung-der-ki-agenten--ai-agent-setup)
    - [GitHub Copilot CLI / GitHub Copilot CLI](#github-copilot-cli--github-copilot-cli)
    - [Claude Code / Claude Code](#claude-code--claude-code)
    - [Codex CLI / Codex CLI](#codex-cli--codex-cli)
    - [Google Antigravity / Google Antigravity](#google-antigravity--google-antigravity)
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
  - [Schritt 1: Deinen persoenlichen Fork anlegen / Step 1: Create Your Personal Fork](#schritt-1-deinen-persoenlichen-fork-anlegen--step-1-create-your-personal-fork)
  - [Schritt 2: Deinen Computer mit dem Git-Hosting verbinden / Step 2: Connect to Git hosting](#schritt-2-deinen-computer-mit-dem-git-hosting-verbinden--step-2-connect-to-git-hosting)
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
  - [Governance-Presets einbinden / Install governance presets](#governance-presets-einbinden--install-governance-presets)
  - [Der Workflow Schritt für Schritt / The workflow step by step](#der-workflow-schritt-für-schritt--the-workflow-step-by-step)
  - [Beispiel: Erstes Feature anlegen / Example: Creating your first feature](#beispiel-erstes-feature-anlegen--example-creating-your-first-feature)
  - [Artefakte und Verzeichnisstruktur / Artefacts and directory structure](#artefakte-und-verzeichnisstruktur--artefacts-and-directory-structure)
- [Barrierefreiheit / Accessibility (A11Y)](#barrierefreiheit--accessibility-a11y)

---

## Workspace-Übersicht / Workspace overview

| Verzeichnis / Directory | Remote-Repository | Eingerichtet mit / Set up with |
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

> **Hinweis für Auszubildende:** Fuer den betreuten Lernendenpfad wird kein
> unabhaengiges Template-Repository erzeugt. Lege einen persoenlichen **Fork**
> der von deiner Institution bereitgestellten Referenz an. Nur im direkten
> GitHub-Profil ist dies `hindermath/home-baseline`. `origin` zeigt auf dein
> persoenliches Repository, `upstream` auf die institutionelle oder oeffentliche
> Referenz. Folge danach der
> [Startanleitung fuer Lernende](docs/learning-units/START-HERE-FUER-LERNENDE.md).
>
> *For the guided learner path, do not create an independent template repository.
> Create a personal **fork** of the reference provided by your institution. Only
> the direct GitHub profile uses `hindermath/home-baseline`. `origin` points to
> your personal repository and `upstream` to the institutional or public
> reference. Then follow the
> [learner start guide](docs/learning-units/START-HERE-FUER-LERNENDE.md).*

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

Wird für die Installation von **Codex CLI** und weiteren npm-basierten Werkzeugen benötigt. Antigravity CLI wird nicht über npm installiert. Claude Code hat einen eigenen nativen Installer und benötigt Node.js **nicht** mehr. Node.js 18 ist end-of-life — bitte mindestens **Node.js 22 LTS** (aktiv gewartet) oder **Node.js 24 LTS** verwenden.

*Required to install **Codex CLI** and other npm-based tools. Antigravity CLI is not installed through npm. Claude Code has its own native installer and no longer requires Node.js. Node.js 18 is end-of-life — use at least **Node.js 22 LTS** (actively maintained) or **Node.js 24 LTS**.*

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

### 6. Erforderliches PowerShell-Analysemodul / Required PowerShell analysis module

PSScriptAnalyzer ist auf macOS, Linux und Windows ein Required-Modul. Die
zentrale Registry legt Version `1.25.0` fest. Die normale Host-Wartung
installiert sie im `CurrentUser`-Bereich; das Analyse-Gate prueft alle mit Git
getrackten repo-eigenen `.ps1`, `.psm1` und `.psd1`-Dateien. Von GitHub Spec Kit
erzeugte Upstream-Dateien unter `.specify/scripts/` und `.specify/extensions/`
werden ueber `update-spec-kit.*` gepflegt und sind begruendet ausgenommen.

*PSScriptAnalyzer is a required module on macOS, Linux, and Windows. The central
registry pins version `1.25.0`. Normal host maintenance installs it in
`CurrentUser` scope; the analysis gate checks every Git-tracked,
repository-owned `.ps1`, `.psm1`, and `.psd1` file. Generated upstream GitHub
Spec Kit files below `.specify/scripts/` and `.specify/extensions/` are
maintained through `update-spec-kit.*` and are excluded with a recorded
rationale.*

```powershell
pwsh -NoProfile -File scripts/maintain-powershell-modules.ps1 -CompareOnly
pwsh -NoProfile -File scripts/maintain-powershell-modules.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-powershell-modules.ps1
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
```

Die bewusst ausgeschlossenen Regeln betreffen etablierte CLI-Ausgabe,
UTF-8-ohne-BOM, stabile Funktionsnamen und vorhandene Vorschau-Semantik.
Korrektheits- und Sicherheitswarnungen bleiben blockierend.

*Intentional exclusions cover established CLI output, UTF-8 without BOM,
stable function names, and existing preview semantics. Correctness and security
warnings remain blocking.*

### 7. Empfohlene PowerShell-Module *(optional, einmalig / optional, once)*

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
bash ~/scripts/bootstrap-workspace.sh Ausbildung --platform codeberg
bash ~/scripts/bootstrap-workspace.sh Ausbildung --platform forgejo --forgejo-url https://git.institution.example
bash ~/scripts/bootstrap-workspace.sh Ausbildung --no-remote

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
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung -Platform codeberg
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung -Platform forgejo -ForgejoUrl https://git.institution.example
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung -NoRemote

# Vorher testen (kein Schreibzugriff):
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
```

Der Bootstrap-Vorgang erledigt automatisch:
1. Bestehende Sub-Repos erkennen und in `.gitignore` eintragen
2. Standard-Scripts (`scan-agent-secrets`, `install-hooks`, `pre-push`-Hook) kopieren
3. `git init` + initialer Commit
4. Privates Remote-Repo auf der gewaehlten Plattform erstellen oder `no-remote` respektieren
5. `origin` setzen und pushen
6. Git-Hooks installieren

The bootstrap process automatically handles:
1. Detecting existing sub-repos and adding them to `.gitignore`
2. Copying standard scripts (`scan-agent-secrets`, `install-hooks`, `pre-push` hook)
3. `git init` + initial commit
4. Creating a private remote repository on the selected platform or respecting `no-remote`
5. Setting `origin` and pushing
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

[includeIf "gitdir:~/home-baseline-source/"]
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
git -C ~/home-baseline-source config user.email   # → work@company.example
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
# git clone https://gitlab.com/YOUR_USERNAME/home-baseline.git home-baseline-source
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
gh auth status
gh repo fork hindermath/home-baseline --clone=false
GH_USER="$(gh api user --jq .login)"
gh repo clone "${GH_USER}/home-baseline" ~/home-baseline-source
git -C ~/home-baseline-source remote add upstream https://github.com/hindermath/home-baseline.git
git -C ~/home-baseline-source remote -v
git -C ~/home-baseline-source fetch upstream
git -C ~/home-baseline-source merge --ff-only upstream/main
git -C ~/home-baseline-source push origin main
bash ~/home-baseline-source/scripts/install-hooks.sh
bash ~/home-baseline-source/scripts/sync-home.sh --no-pull
```

`origin` muss auf den persoenlichen Fork zeigen; `upstream` muss
`hindermath/home-baseline` sein. Der Klon `~/home-baseline-source` bleibt dauerhaft
bestehen. `~/` ist die lokale Betriebskopie ohne Remote.

### Windows (PowerShell Core >= 7) / Windows (PowerShell Core >= 7)

```powershell
Set-Location ~
gh auth status
gh repo fork hindermath/home-baseline --clone=false
$GitHubUser = gh api user --jq '.login'
gh repo clone "${GitHubUser}/home-baseline" "$HOME/home-baseline-source"
git -C "$HOME/home-baseline-source" remote add upstream https://github.com/hindermath/home-baseline.git
git -C "$HOME/home-baseline-source" remote -v
git -C "$HOME/home-baseline-source" fetch upstream
git -C "$HOME/home-baseline-source" merge --ff-only upstream/main
git -C "$HOME/home-baseline-source" push origin main
pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/install-hooks.ps1"
pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/sync-home.ps1" -NoPull
```

`origin` must point to the personal fork; `upstream` must point to
`hindermath/home-baseline`. Keep `~/home-baseline-source` permanently. `~/` remains
the local runtime copy without a remote.

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
bash ~/scripts/bootstrap-workspace.sh FlutterProjects --platform codeberg
bash ~/scripts/bootstrap-workspace.sh FlutterProjects --platform forgejo --forgejo-url https://git.institution.example
bash ~/scripts/bootstrap-workspace.sh FlutterProjects --no-remote
bash ~/scripts/check-homogeneity.sh ~/FlutterProjects
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -Platform gitlab
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -Platform gitlab -GitLabUrl https://gitlab.example.com
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -Platform codeberg
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -Platform forgejo -ForgejoUrl https://git.institution.example
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -NoRemote
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/FlutterProjects
```

> Das Script erledigt automatisch / The script handles automatically:
> `git init` · initialer Commit · privates Remote ueber `gh`, `glab` oder die Forgejo-API anlegen · Remote `origin` setzen · `git push`
>
> *Without `--platform`, GitHub remains the default. `gitlab`, `forgejo`, and `codeberg` select other supported forges; `--no-remote` keeps the repository local.*

**2 — Projekt anlegen / Create a project**

```bash
# macOS / Linux
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform gitlab
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform gitlab --no-remote
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform gitlab --gitlab-url https://gitlab.example.com --preview
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform codeberg --preview
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/FlutterProjects --platform forgejo --forgejo-url https://git.institution.example --preview
bash ~/scripts/check-homogeneity.sh ~/FlutterProjects
```

```powershell
# Windows
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform gitlab
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform gitlab -NoRemote
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform gitlab -GitLabUrl https://gitlab.example.com -Preview
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform codeberg -Preview
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/FlutterProjects -Platform forgejo -ForgejoUrl https://git.institution.example -Preview
pwsh ~/scripts/check-homogeneity.ps1 -TargetDir ~/FlutterProjects
```

> Das Script erledigt automatisch / The script handles automatically:
> `git init` · initialer Commit · privates Remote ueber `gh`, `glab` oder die Forgejo-API anlegen · Remote `origin` setzen · `git push`
>
> *For self-hosted GitLab or Forgejo, pass the matching base URL. Codeberg uses `https://codeberg.org`. Forgejo and Codeberg use HTTPS credentials from the configured Git credential helper.*

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

Installiere mindestens einen KI-Agenten (GitHub Copilot CLI, Claude Code, Codex, Antigravity CLI, OpenCode) nach der jeweiligen Anleitung.

*Install at least one AI agent (GitHub Copilot CLI, Claude Code, Codex, Antigravity CLI, OpenCode) following the respective instructions.*

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

**3d — Antigravity CLI haerten / Harden Antigravity CLI** *(recommended)*

```bash
# macOS / Linux
bash ~/scripts/setup-antigravity-settings.sh
```

```powershell
# Windows
pwsh -NoProfile ~/scripts/setup-antigravity-settings.ps1
```

Setzt in `~/.gemini/antigravity-cli/settings.json` strikte Werkzeugfreigaben, Artefaktprüfung, Terminal-Sandbox, Workspace-Isolation und deaktivierte Telemetrie. Zusätzlich wird eine ASCII-only-Statuszeile ohne Identitätsdaten installiert.

*Sets strict tool approval, artifact review, terminal sandboxing, workspace isolation, and disabled telemetry in `~/.gemini/antigravity-cli/settings.json`. It also installs an ASCII-only status line without identity data.*

---

### Fehlerbehebung mit KI-Unterstützung / Troubleshooting with AI support

Sollte ein Skript mit einem Fehler abbrechen, kannst du deinen installierten KI-Agenten direkt im Terminal bitten, das Problem zu analysieren oder den Vorgang abzuschließen.

*If a script fails, you can ask your AI agent directly in the terminal to analyze the issue or complete the process.*

| Agent / Agent | Kommando / Command |
|---|---|
| **GitHub Copilot** | `copilot -p "Skript X ist bei Schritt Y abgebrochen. Bitte pruefe den Status und schliesse die Einrichtung ab. / Script X failed at step Y. Please check the status and finish the setup."` |
| **Claude Code** | `claude "Der Push zu GitHub ist fehlgeschlagen. Bitte pruefe die Remotes und hole den Push nach. / The push to GitHub failed. Please check the remotes and complete the push."` |
| **Codex CLI** | `codex "Analysiere den letzten Fehler im Terminal und schlage eine Loesung vor. / Analyse the last terminal error and suggest a fix."` |
| **Google Antigravity** | `agy` auf macOS beziehungsweise die Antigravity-App auf Windows starten und den letzten Terminalfehler zur Analyse uebergeben. |
| **OpenCode** | `opencode --prompt "Pruefe, ob alle Git-Hooks und .inc-Dateien korrekt angelegt wurden. / Check whether all Git hooks and .inc files were created correctly."` |

> **Tipp / Tip:** Nutze das Flag `--help` (z. B. `claude --help`, `agy --help` oder `opencode --help`), um weitere Informationen zu den verfügbaren Befehlen deines Agenten zu erhalten.
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
git clone https://github.com/hindermath/home-baseline.git ~/home-baseline-source
# Alternativ mit gh CLI (falls installiert und angemeldet / alternatively with gh CLI):
# gh repo clone hindermath/home-baseline ~/home-baseline-source
bash ~/home-baseline-source/scripts/install-hooks.sh   # pre-push Hook im Klon installieren
bash ~/home-baseline-source/scripts/sync-home.sh --no-pull
```

```powershell
# Windows (PowerShell Core >= 7)
# Mit git:
git clone https://github.com/hindermath/home-baseline.git ~/home-baseline-source
# Alternativ mit gh CLI (falls installiert und angemeldet / alternatively with gh CLI):
# gh repo clone hindermath/home-baseline ~/home-baseline-source
pwsh ~/home-baseline-source/scripts/install-hooks.ps1   # pre-push Hook im Klon installieren
pwsh ~/home-baseline-source/scripts/sync-home.ps1 -NoPull
```

> **Hinweis / Note:** `--no-pull` / `-NoPull` überspringt `git pull`, da der Klon gerade frisch erstellt wurde. `install-hooks` installiert den `pre-push`-Hook in `home-baseline-source/.git/hooks/` — ohne diesen Schritt meldet `check-homogeneity` ein WARN.

---

### Plattform-Test / Platform test

Da Outputs zwischen verschiedenen Maschinen nicht direkt ins Terminal kopiert werden können, gibt es plattformspezifische Test-Scripts — sie sammeln System-Info und Compliance-Ergebnisse, committen und pushen die Ergebnisse direkt ins Repo.

*Since outputs cannot easily be copy-pasted between machines, platform-specific test scripts collect system info and compliance results, then commit and push them directly to the repo.*

| Plattform / Platform | Skript / Script | Ausgabe / Output |
|---|---|---|
| macOS | `bash ~/home-baseline-source/scripts/mac-test.sh` | `mac-test-output.txt` |
| Linux / WSL | `bash ~/home-baseline-source/scripts/linux-test.sh` | `linux-test-output.txt` |
| Windows | `pwsh ~/home-baseline-source/scripts/windows-test.ps1` | `windows-test-output.txt` |

Jedes Script erfasst / Each script collects:
- OS-Version, Architektur
- Installierte Tools (`git`, `gh`, `glab`, `rg`, `gitleaks`, `pwsh`, `node`, `npm`, `uv`, `python3`/`python`, `dotnet`, `go`, `java`, `javac`, `cargo`, `rustc`, `swift`, `syft`, `specify`, `podman`, `codex`, `claude`, `agy`/Antigravity, `copilot`, `code`, `hx`)
- Paketmanager (`brew` / `apt`/`dnf` / `winget`)
- Paketlisten und Registry-Vergleiche fuer `brew-apps-registry.json`, `winget-apps-registry.json`, `vscode-extensions-registry.json`, `required-cli-tools-registry.json` und `npm-agent-cli-registry.json`
- Read-only-orientierter Repository-/Registry-/Propagationscheck des Workspace-Orchestrators / Read-oriented repository, registry, and propagation check from the workspace orchestrator
- Ergebnis von `sync-home` und `check-homogeneity`

Danach liegt die Ausgabedatei im Repo und kann von jedem anderen Gerät direkt gelesen und ausgewertet werden — z. B. von Copilot CLI unter Windows:

*After running, the output file is in the repo and can be read and evaluated from any other device — e.g. by Copilot CLI on Windows:*

```powershell
git -C "$HOME\home-baseline-source" pull
Get-Content "$HOME\home-baseline-source\windows-test-output.txt"  # oder mac-test-output.txt, linux-test-output.txt
```

---

### Täglich / nach Änderungen synchronisieren / Daily sync

```bash
# macOS / Linux / Ubuntu — pull + kopieren + Commit in ~/
bash ~/scripts/sync-home.sh
# Das Script erkennt ~/home-baseline-source automatisch als Quelle.

# Optional: Compliance prüfen / Optional: check compliance
bash ~/scripts/check-homogeneity.sh ~/
```

```powershell
# Windows — pull + kopieren + Commit in ~/
pwsh ~/scripts/sync-home.ps1
# Das Script erkennt ~/home-baseline-source automatisch als Quelle.

# Optional: Compliance prüfen / Optional: check compliance
pwsh ~/scripts/check-homogeneity.ps1
```

---

### Änderungen am Template entwickeln / Develop template changes

**Mit KI-Agent / With AI agent:**

```bash
# 1. In den Klon wechseln
cd ~/home-baseline-source

# 2. KI-Agent starten — der Agent macht Änderungen, committet und pusht selbst
claude      # Claude Code
# agy       # Google Antigravity CLI auf macOS
# codex     # OpenAI Codex
# opencode  # OpenCode

# 3. Nach dem Push des Agenten: ~/ synchronisieren
bash ~/scripts/sync-home.sh --no-pull
# pwsh ~/scripts/sync-home.ps1 -NoPull  # Windows
```

**Manuell / Manually:**

```bash
# 1. In den Klon wechseln
cd ~/home-baseline-source

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

**Skriptsprachenwahl fuer Agenten / Script language choice for agents**

Vor jeder Automationsaufgabe zuerst das Betriebssystem pruefen. Wenn ein
passendes PowerShell-7-Skript oder Cmdlet vorhanden ist und `pwsh` verfuegbar
ist, soll diese Variante bevorzugt werden. Fuer strukturierte lokale
Automationen kann C# ueber `.NET` oder `mono` genutzt werden, wenn Typisierung,
Dateiformate oder Wiederverwendbarkeit dadurch klar besser werden. Erst wenn
PowerShell oder C# nicht sinnvoll passen, soll die OS-nahe vorhandene
Repo-Variante genutzt werden, auf macOS/Linux also typischerweise Bash. Eine
neue Sprache wird nicht nur aus Bequemlichkeit eingefuehrt, wenn ein
vorhandenes Repo-Skript denselben Zweck erfuellt.

*Before each automation task, detect the operating system first. If a matching
PowerShell 7 script or cmdlet exists and `pwsh` is available, prefer that
variant. For structured local automation, C# via `.NET` or `mono` may be used
when type safety, file formats, or reuse clearly benefit from it. Only when
PowerShell or C# is not a good fit, use the existing OS-native repository
variant, typically Bash on macOS/Linux. Do not introduce a new language merely
for convenience when an existing repository script already solves the task.*

---

### Optionen sync-home / sync-home options

| Flag (Bash / PowerShell)       | Bedeutung / Meaning                          |
|-------------------------------|----------------------------------------------|
| `--no-pull` / `-NoPull`       | Kein `git pull` — nur kopieren / Skip pull   |
| `--no-commit` / `-NoCommit`   | Nur kopieren, kein Commit in `~/` / Copy only |
| `--dry-run` / `-WhatIf`       | Nur anzeigen, nichts schreiben / Preview only |
| `--check-only` / `-CheckOnly` | Pull-frei auf Drift und Konflikte pruefen / Check drift and conflicts without pulling |
| `--force` / `-Force`          | Gepruefte Konflikte verwalteter Dateien ueberschreiben / Overwrite reviewed managed-file conflicts |

`~/home-baseline-source` bleibt dauerhaft der versionierte Level-0-Klon mit
`origin`, `upstream` und nachvollziehbarer Historie. `~/` ist nur die lokale
Betriebskopie. Home Sync v2 verteilt deshalb nur noch Host-Runtime-Dateien:
Skripte samt Configs und Templates, gemeinsame Agent-Guidance sowie ausgewaehlte
`speckit-*`-Oberflaechen. Kanonische Dokumentation, Specs, Lastenhefte,
Preset-Quellen und Kampagnen-Evidence werden direkt aus dem Level-0-Klon gelesen
und nicht mehr nach `~/` gespiegelt. `STATS.md`, private Agentenzustaende,
globale Skills und installierte `.specify/presets/` bleiben maschinenlokal.

*`~/home-baseline-source` permanently remains the versioned level-0 clone with
`origin`, `upstream`, and auditable history. Home Sync v2 distributes only host
runtime files: scripts with their configs and templates, shared agent guidance,
and selected `speckit-*` surfaces. Canonical documentation, specs, intakes,
preset sources, and campaign evidence are read directly from the Level 0 clone.
`STATS.md`, private agent state, global skills, and installed presets remain
machine-local.*

Ein Sync ist nach Aenderungen an diesen Runtime-Oberflaechen erforderlich, nicht
nach reinen Dokumentations-, Spec-, Preset-Quell- oder Evidence-Commits. Beim
ersten v2-Lauf werden nicht mehr verwaltete v1-Pfade nur freigegeben und niemals
automatisch geloescht. Ausschliesslich `legacyCleanupPaths` duerfen eine
gepruefte Entfernung ausloesen. Freigegebene Pfade bleiben im lokalen
Sync-State als Provenienz vermerkt.

*Sync is required after runtime-surface changes, not after documentation,
specification, preset-source, or evidence-only commits. The first v2 run releases
former v1 targets without deleting them. Only explicit `legacyCleanupPaths` may
trigger reviewed removal. Released paths remain recorded as provenance in the
local sync state.*

Der letzte erfolgreiche Stand steht lokal in
`~/.home-baseline/home-sync-state.json` mit Quell-Commit, SHA-256 und
Dateimodus. Weicht eine verwaltete Zieldatei lokal ab, bricht der Sync vor dem
ersten Schreibzugriff ab. `--force` beziehungsweise `-Force` darf erst nach
Pruefung des Konfliktberichts verwendet werden. Automatische Commits enthalten
nur die vom Sync geaenderten Pfade und gegebenenfalls die lokal gepflegte
`.gitconfig`, niemals pauschal alle Home-Aenderungen.

*The last successful state is recorded locally in
`~/.home-baseline/home-sync-state.json` with source commit, SHA-256, and file
mode. If a managed target file was changed locally, sync stops before its first
write. Use `--force` or `-Force` only after reviewing the conflict report.
Automatic commits contain only paths changed by sync and, when needed, the
locally maintained `.gitconfig`, never every Home change.*

`sync-home` kopiert `.gitconfig` bewusst nicht mehr blind aus dem Repository nach `~/`. Stattdessen stellt es die Baseline-Werte (`init.defaultBranch`, `core.autocrlf`, `pull.rebase`, `includeIf`) sicher und prüft danach die globale Git-Identität per `setup-git-identity.*` im Auto-Modus. So bleiben `user.name` und `user.email` dauerhaft echte lokale Werte.

*`sync-home` intentionally no longer copies `.gitconfig` blindly from the repository into `~/`. Instead, it ensures the baseline values (`init.defaultBranch`, `core.autocrlf`, `pull.rebase`, `includeIf`) and then checks the global git identity via `setup-git-identity.*` in auto mode. This keeps `user.name` and `user.email` as real local values permanently.*

Da die Quellmenge aus `git ls-files` entsteht, werden `.DS_Store`,
verschachtelte `.git`-Verzeichnisse, Caches und andere unversionierte Artefakte
nicht kopiert.

*Because the source set comes from `git ls-files`, `.DS_Store`, nested `.git`
directories, caches, and other untracked artifacts are never copied.*

Wenn `sync-home` aus `~/scripts/` gestartet wird, delegiert es automatisch an die Repo-Kopie in `~/home-baseline-source/scripts/`. Dadurch kann es `~/scripts/` aktualisieren, ohne das gerade laufende Skript zu überschreiben.

*When `sync-home` is started from `~/scripts/`, it automatically delegates to the repository copy in `~/home-baseline-source/scripts/`. This lets it update `~/scripts/` without overwriting the script that is currently running.*

In der ABS-DD-Sandbox wird die Level-0-Referenz direkt unter
`~/home-baseline-source` gelesen. Schreibende `sync-home`-Laeufe nach
`/home/adedev` sind gesperrt; der Home-Sync wird immer auf dem Host ausgefuehrt.

*Inside the ABS-DD sandbox, read the level-0 reference directly at
`~/home-baseline-source`. Writing `sync-home` runs targeting `/home/adedev` are
blocked; always run Home sync on the host.*

---

### Releases und Versionierung / Releases & Versioning

GitHub- und GitLab-Releases folgen beide den [Conventional Commits](https://www.conventionalcommits.org/), verwenden aber unterschiedliche Automationspfade.

*GitHub and GitLab releases both follow [Conventional Commits](https://www.conventionalcommits.org/), but they use different automation paths. Forgejo/Codeberg release automation requires a separately reviewed institutional Actions configuration.*

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

Release-Please-Workflows pinnen voruebergehend einen konkreten
`googleapis/release-please-action`-SHA, dessen `action.yml` bereits `node24`
nutzt. Sobald ein getaggtes v4-Release ebenfalls `node24` verwendet, kann die
Workflow-Referenz wieder auf einen normalen `@v4.x`-Tag umgestellt werden.

*Release Please workflows temporarily pin a concrete
`googleapis/release-please-action` SHA whose `action.yml` already uses `node24`.
Once a tagged v4 release also targets `node24`, the workflow reference can move
back to a normal `@v4.x` tag.*

**GitLab / GitLab**

GitLab-Repositories verwenden `scripts/setup-gitlab-release.sh` bzw. `scripts/setup-gitlab-release.ps1` als GitLab-native Alternative.

1. Release-Basis in das Repo einhaengen:

```bash
bash ~/home-baseline-source/scripts/setup-gitlab-release.sh ~/RiderProjects/MyGitLabRepo --gitlab-url https://gitlab-ce.gwdg.de
```

```powershell
pwsh ~/home-baseline-source/scripts/setup-gitlab-release.ps1 -TargetRepository ~/RiderProjects/MyGitLabRepo -GitLabUrl https://gitlab-ce.gwdg.de
```

2. Danach laeuft auf dem Default-Branch ein manueller `release`-Job in GitLab CI
3. Beim Start dieses Jobs werden `CHANGELOG.md`, Git-Tag und GitLab Release automatisch erzeugt
4. Der `release`-Job bleibt bewusst manuell, blockiert aber den Gesamtstatus der Pipeline nicht

*GitLab repositories use `setup-gitlab-release.*` as a GitLab-native replacement: install the baseline once, then trigger the manual `release` job on the default branch to create `CHANGELOG.md`, tag, and GitLab Release. The job stays manual by design, but it does not block the overall pipeline status.*

---

## Inhalt / Contents

Die vollstaendige, aus dem Git-Index erzeugte Skriptdokumentation steht unter
[`docs/scripts/`](docs/scripts/README.md). Sie inventarisiert alle kanonischen
Skriptdateien und alle eingebetteten Kopien, nennt Voraussetzungen und
Nebenwirkungen und zeigt sichere Beispiele. Die folgenden Abschnitte bleiben
als aufgabenorientierte Einfuehrung bestehen.

*The complete script documentation generated from the Git index is available
under [`docs/scripts/`](docs/scripts/README.md). It inventories every canonical
script file and every embedded copy, lists prerequisites and side effects, and
provides safe examples. The following sections remain as task-oriented
guidance.*

### Dauerhaften Level-0-Checkout migrieren / Migrate the permanent Level 0 checkout

Bestehende Installationen mit `~/home-baseline-tmp` werden kontrolliert auf
`~/home-baseline-source` migriert. Der Preflight verlangt einen sauberen
`main`-Branch, `HEAD == origin/main`, genau einen Worktree und ein freies Ziel.

```bash
bash scripts/migrate-level0-source-checkout.sh --check-only
bash scripts/migrate-level0-source-checkout.sh --dry-run
bash ~/scripts/migrate-level0-source-checkout.sh
```

```powershell
pwsh -NoProfile -File scripts/migrate-level0-source-checkout.ps1 -CheckOnly
pwsh -NoProfile -File scripts/migrate-level0-source-checkout.ps1 -WhatIf
pwsh -NoProfile -File "$HOME/scripts/migrate-level0-source-checkout.ps1"
```

Der echte Lauf wird aus der stabilen Home-Kopie gestartet, schreibt
`~/.home-baseline/source-repository.json` und behaelt voruebergehend einen
Kompatibilitaetslink. Erst nach plattformgerechter Validierung entfernt
`--finalize` beziehungsweise `-Finalize` diesen Link.

*Existing `~/home-baseline-tmp` installations migrate to
`~/home-baseline-source` through a strict preflight. Run the writing operation
from the stable Home copy. It records local discovery state and retains a
temporary compatibility link until explicit finalization.*

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

Die Rollen der wichtigsten Skripte sind bewusst unterschiedlich: `check-homogeneity.*` ist das Diagnose-Werkzeug und beantwortet die Frage **"Ist der aktuelle Zustand compliant?"**. `migrate-workspace.*` ist das Nachruest-Werkzeug und beantwortet **"Wie bringe ich einen vorhandenen Workspace auf die aktuelle Baseline?"**. `init-stats.*` initialisiert den Compliance-Nachweis in `STATS.md`; `render-project-statistics.*` berechnet und rendert dagegen den markierten ASCII-Profil-2-Block in `docs/project-statistics.md`. `sync-constitution.*` verteilt die gemeinsame Verfassung in bestehende Level-1-Workspaces. `propagate-security-guidance.sh --only-environment-registry` synchronisiert gezielt nur das gemeinsame Level-2-Umgebungsregister in beiden Constitution-Dateien. `rename-lastenheft.*` haelt die Benennung von Lastenheften nach einem Feature-Abschluss konsistent.

*The roles of the main scripts are intentionally different: `check-homogeneity.*` diagnoses compliance. `migrate-workspace.*` retrofits an existing workspace. `init-stats.*` initializes the compliance record in `STATS.md`, while `render-project-statistics.*` calculates and renders the marked ASCII Profile 2 block in `docs/project-statistics.md`. `sync-constitution.*` distributes the shared constitution into existing level-1 workspaces. `propagate-security-guidance.sh --only-environment-registry` selectively synchronizes only the shared level-2 environment registry in both constitution files. `rename-lastenheft.*` keeps requirement filenames consistent after a feature is completed.*

Als praktische Kurzregel gilt: **neu anlegen = Bootstrap**, **vorhandenen Bestand angleichen = Migration**, **nur bewerten = Check**, **nur Statistik initialisieren = init-stats**. Genau diese Trennung hilft dabei, Skripte nicht versehentlich fuer den falschen Zweck zu verwenden.

*A practical short rule is: **create new = bootstrap**, **align existing estate = migration**, **only evaluate = check**, **only initialize statistics = init-stats**. This exact separation helps you avoid using the scripts for the wrong purpose by accident.*

Die Basishierarchie dieses Setups ist bewusst generisch aufgebaut, aber aus zwei Blickwinkeln zu lesen: Fuer Maintainer dieses Repositories ist `~/home-baseline-source` das Arbeits-Repository, in dem die **Level-0 home-baseline** entwickelt wird. Fuer Nutzende, Azubis und alle bereits gebootstrappten Umgebungen ist dagegen `~/` das eigentliche Root der Arbeitsumgebung. Direkt darunter liegen die **Level-1 workspaces** als fachliche oder toolbezogene Sammelcontainer, und darin liegen die eigentlichen **Level-2 projects**. Diese Benennung ist absichtlich neutral gehalten, damit sie nicht von bestimmten IDEs, Programmiersprachen oder persoenlichen Workspace-Namen abhaengt.

*The base hierarchy of this setup is intentionally generic, but it needs to be read from two perspectives: for maintainers of this repository, `~/home-baseline-source` is the working repository in which the **level-0 home baseline** is developed. For end users, apprentices, and already bootstrapped environments, however, `~/` is the actual root of the working environment. Directly below it sit the **level-1 workspaces** as domain- or tool-oriented containers, and inside them live the actual **level-2 projects**. This naming is intentionally neutral so it does not depend on specific IDEs, programming languages, or personal workspace names.*

Ein typischer Grenzfall ist deshalb ein bereits vorhandenes **Level-2 project** innerhalb eines bestehenden **Level-1 workspace**. Auch dafuer ist **nicht** `bootstrap-project.*`, sondern `migrate-workspace.*` fuer den uebergeordneten Workspace die richtige Wahl, weil die Migration die enthaltenen Level-2-Repositories automatisch mit betrachtet und angleicht.

*A common edge case is therefore an already existing **level-2 project** inside an existing **level-1 workspace**. Even in that case, the correct tool is **not** `bootstrap-project.*`, but `migrate-workspace.*` for the parent workspace, because the migration automatically inspects and aligns the contained level-2 repositories as well.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/check-homogeneity.sh` | Compliance-Scanner Level 0-2, JSON-Ausgabe, STATS.md-Update / Compliance scanner level 0-2, JSON output, STATS.md update (Bash) |
| `scripts/check-homogeneity.ps1` | Compliance-Scanner mit Paritaet zur Bash-Version / Compliance scanner with Bash parity (PowerShell Core) |
| `scripts/init-stats.sh` | STATS.md-Baseline-Eintrag erzeugen / Create a STATS.md baseline entry (Bash) |
| `scripts/init-stats.ps1` | STATS.md-Baseline-Eintrag erzeugen / Create a STATS.md baseline entry (PowerShell Core) |
| `scripts/render-project-statistics.sh` | ASCII-Statistikprofil 2 pruefen, vorschauen oder rendern / Check, preview, or render ASCII Statistics Profile 2 (Bash) |
| `scripts/render-project-statistics.ps1` | Kanonischer Profil-2-Renderer mit JSON-Status / Canonical Profile 2 renderer with JSON status (PowerShell 7) |
| `scripts/test-render-project-statistics.ps1` | Deterministische Profil-2-Fixtures und Bash-/PowerShell-Paritaet / Deterministic Profile 2 fixtures and Bash/PowerShell parity |
| `scripts/migrate-workspace.sh` | Bestehende Workspaces auf Homogeneity-Baseline migrieren / Migrate existing workspaces to the homogeneity baseline (Bash) |
| `scripts/migrate-workspace.ps1` | Workspace-Migration / Workspace migration (PowerShell Core) |
| `scripts/sync-constitution.sh` | `constitution.md` in alle Level-1-Workspaces synchronisieren / Sync `constitution.md` into all level-1 workspaces (Bash) |
| `scripts/sync-constitution.ps1` | Constitution-Sync / Constitution sync (PowerShell Core) |
| `scripts/propagate-security-guidance.sh` | Security-Guidance oder gezielt das Level-2-Umgebungsregister propagieren / Propagate security guidance or only the level-2 environment registry (Bash) |
| `scripts/propagate-security-guidance.ps1` | PowerShell-/WSL-Wrapper fuer die Security-Guidance-Propagation / PowerShell/WSL wrapper for security-guidance propagation |
| `scripts/rename-lastenheft.sh` | Lastenheft-Datei umbenennen: `git mv` + Commit / Rename requirement file: `git mv` + commit (Bash) |
| `scripts/rename-lastenheft.ps1` | Lastenheft umbenennen / Rename requirement file (PowerShell Core) |
| `scripts/prepare-secure-development-hardening.sh` | MSL-Level-2-Repos fuer spaetere Secure-Development-Haertung vorbereiten / Prepare MSL level-2 repos for later secure-development hardening (Bash) |
| `scripts/prepare-secure-development-hardening.ps1` | Secure-Development-Hardening vorbereiten / Prepare secure-development hardening (PowerShell Core) |
| `scripts/prepare-rl-se-checklist-selbstpruefung.sh` | Repos fuer spaetere RL-SE-/Checklist-Selbstpruefung vorbereiten / Prepare repos for later RL-SE/checklist self-assessment (Bash) |
| `scripts/prepare-rl-se-checklist-selbstpruefung.ps1` | RL-SE-/Checklist-Selbstpruefung vorbereiten / Prepare RL-SE/checklist self-assessment (PowerShell Core) |
| `scripts/build-secure-development-docs.sh` | Manifest, 157 CL-IDs und generierten Sammelband bauen/pruefen / Build/check manifest, 157 CL IDs, and generated compendium (Bash) |
| `scripts/build-secure-development-docs.ps1` | Funktionsgleiche PowerShell-Pruefung / Functionally equivalent PowerShell check |
| `scripts/register-level2-repository.sh` | Level-1-/Level-2-Repo in der GSDB-Registry eintragen / Register a level-1/level-2 repo in the GSDB registry (Bash) |
| `scripts/register-level2-repository.ps1` | GSDB-Registry aktualisieren / Update the GSDB registry (PowerShell Core) |
| `scripts/check-gsdb-self-assessment.sh` | GSDB-Preflight und Spec-Kit-Intake vorbereiten / Prepare GSDB preflight and Spec Kit intake (Bash) |
| `scripts/check-gsdb-self-assessment.ps1` | GSDB-Preflight und Spec-Kit-Intake vorbereiten / Prepare GSDB preflight and Spec Kit intake (PowerShell Core) |
| `scripts/maintain-agentic-brew-apps.sh` | Homebrew-/apt-Toolchain fuer agentische Entwicklung pflegen / Maintain Homebrew/apt toolchain for agentic development (Bash) |
| `scripts/maintain-agentic-winget-apps.ps1` | WinGet-Toolchain fuer agentische Entwicklung pflegen / Maintain WinGet toolchain for agentic development (PowerShell Core) |
| `scripts/maintain-powershell-modules.ps1` | Required-PowerShell-Module versionsgebunden pflegen / Maintain pinned required PowerShell modules |
| `scripts/invoke-psscriptanalyzer.ps1` | Getrackte PowerShell-Dateien statisch pruefen / Statically analyze tracked PowerShell files |
| `scripts/maintain-agentic-workspace.sh` | Vollstaendige Level-0/1/2- und Toolchain-Wartung orchestrieren / Orchestrate complete Level-0/1/2 and toolchain maintenance (Bash) |
| `scripts/maintain-agentic-workspace.ps1` | Funktionsgleiche Windows-Orchestrierung / Functionally equivalent Windows orchestration (PowerShell Core) |
| `scripts/propagate-agentic-toolchain-maintenance.sh` | Kanonisches Wartungspaket in Level-1/Level-2 propagieren / Propagate the canonical maintenance package to Level-1/Level-2 (Bash) |
| `scripts/propagate-agentic-toolchain-maintenance.ps1` | Funktionsgleiche PowerShell-Propagation / Functionally equivalent PowerShell propagation |
| `scripts/config/brew-apps-registry.json` | Versionierte Homebrew-Registry fuer agentische Entwicklung / Versioned Homebrew registry for agentic development |
| `scripts/config/winget-apps-registry.json` | Versionierte WinGet-Registry fuer agentische Entwicklung / Versioned WinGet registry for agentic development |
| `scripts/config/vscode-extensions-registry.json` | Versionierte VS-Code-Extension-Registry fuer sechs MSL-Pfade / Versioned VS Code extension registry for six MSL paths |
| `scripts/config/required-cli-tools-registry.json` | Versionierte Required-CLI-Pruefregistry fuer sechs MSL-Pfade, SBOM, Spec Kit und Agenten-CLIs / Versioned required CLI check registry for six MSL paths, SBOM, Spec Kit, and agent CLIs |
| `scripts/config/npm-agent-cli-registry.json` | Versionierte npm-Registry fuer global installierte Agenten-CLIs / Versioned npm registry for globally installed agent CLIs |
| `scripts/config/agentic-toolchain-maintenance-files.json` | Kanonische Dateiliste des propagierten Wartungspakets / Canonical file list for the propagated maintenance package |
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

### Generischer Leitfaden Sichere Entwicklung / Generic Secure Development Guide

Der Ordner [`docs/secure-development/`](docs/secure-development/README.md) enthaelt einen generischen, zweisprachigen Leitfaden fuer sichere Entwicklung. Er richtet sich besonders an Fachinformatik-Auszubildende, Entwicklerinnen und Entwickler, Reviewer und KI-Agenten in Level-2-Projekten. Die Dokumente sind organisationsneutral formuliert, behalten aber die fachliche Schaerfe der ISO/IEC-27001-/27002-orientierten sicheren Entwicklung bei.

*The folder [`docs/secure-development/`](docs/secure-development/README.md) contains a generic, bilingual guide for secure development. It is aimed especially at IT specialist apprentices, developers, reviewers, and AI agents in level-2 projects. The documents are organization-neutral while preserving the rigor of ISO/IEC 27001/27002-oriented secure development.*

Der Bereich besteht aus Richtlinie, zwölf kanonischen Einzelchecklisten mit 157 stabilen CL-IDs, einem daraus generierten Sammelband, einem Lernpfad für Lehrjahr 1 bis 3 und vertieften mitgeltenden Dokumenten. `docs/secure-development/baseline-manifest.json` steuert Dateien und Versionen. Die Verzahnungsdatei verbindet Richtlinie, Checklisten, Dokumente und die acht Governance-Presets. Projektnachweise liegen getrennt unter `docs/security/secure-development/<datum>-<scope>/` und verwenden die Statusachsen Anwendbarkeit und Umsetzung. Sicherheit beginnt mit dem ersten Repository-Zugriff und der ersten Programmieraufgabe.

*The area contains the guideline, twelve canonical individual checklists with 157 stable CL IDs, a generated compendium, a year 1-to-3 learning path, and expanded related documents. `baseline-manifest.json` controls files and versions. Project evidence is stored separately under `docs/security/secure-development/<date>-<scope>/` and uses separate applicability and implementation axes. Security starts with the first repository access and coding task.*

Die Kurzform **GSDB** steht in diesem Repository fuer diese **Generische Secure-Development Basis**. Die operative lokale Merkliste der GSDB-relevanten Repositories liegt ausserhalb des public Repos unter `~/.home-baseline/level2-repository-registry.json`. Im Repo bleibt nur `scripts/config/level2-repository-registry.example.json` als public-safe Vorlage. Level-2-Repositories werden beim Bootstrap standardmaessig unabhaengig vom MSL-Status als GSDB-pflichtig mit dem Acht-Preset-Profil registriert; begruendete Ausnahmen muessen explizit gesetzt werden. Bestehende Repositories koennen mit demselben Werkzeug nachgetragen werden.

*The short form **GSDB** means this **Generic Secure Development Baseline** in this repository. The local operational registry of GSDB-relevant repositories lives outside the public repo at `~/.home-baseline/level2-repository-registry.json`. The repository only keeps `scripts/config/level2-repository-registry.example.json` as a public-safe seed. Level-2 repositories default to GSDB-required with the eight-preset profile independently of MSL status; justified exceptions must be explicit. Existing repositories can be added later with the same tool.*

Der GSDB-Preflight ohne Spec-Kit-Lauf erfolgt mit `check-gsdb-self-assessment.*`. `--check-only` / `-CheckOnly` prueft rein lesend. Ein normaler Lauf schreibt `docs/security/gsdb-self-assessment.md`, erzeugt oder aktualisiert `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md` und nimmt dieses Lastenheft in `Lastenheft_Abarbeitungsreihenfolge.md` auf. Der Preflight startet keinen Spec-Kit-Lauf; das erzeugte Lastenheft ist Intake fuer einen spaeter manuell gestarteten `/speckit-specify`-Lauf.

*The GSDB preflight without a Spec Kit run is performed with `check-gsdb-self-assessment.*`. `--check-only` / `-CheckOnly` is read-only. A normal run writes `docs/security/gsdb-self-assessment.md`, creates or updates `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md`, and adds that requirements document to `Lastenheft_Abarbeitungsreihenfolge.md`. The preflight does not start a Spec Kit run; the generated requirements document is intake for a later manually started `/speckit-specify` run.*

Eine bewusst manuell gestartete Kandidatensuche kann
`register-level2-repository.* --scan-root` / `-ScanRoot` verwenden, um eine
bekannte Level-1-Wurzel nach neuen Git-Repositories zu durchsuchen. Das
Ein-Kommando-Wartungsskript verwendet diese breite Suche absichtlich nicht:
Es registriert nur aktive `canonical-fleet`-Ziele des Fleet-Manifests. Neue
Level-2-Repos werden daher erst nach ausdruecklicher Sollzustandsentscheidung
in Manifest und lokaler Registry Teil der Wartungsflotte. Eindeutige
Sprachsuffixe gelten bei vorbereiteten Lernrepos bereits vor dem
Runtime-Scaffold. Manuelle Scans bewahren bekannte Sprach-, MSL-, GSDB- und
Preset-Metadaten; explizite Parameter bleiben der einzige Weg fuer eine
begruendete Herabstufung oder Ausnahme.

*A deliberately initiated manual candidate search may use
`register-level2-repository.* --scan-root` / `-ScanRoot` to scan a known
level-1 root for new Git repositories. The one-command maintenance script
intentionally does not use this broad discovery. It registers only active
`canonical-fleet` targets from the fleet manifest. A new level-2 repository
therefore joins the maintenance fleet only after an explicit desired-state
decision updates the manifest and local registry. Unambiguous language suffixes
apply to prepared learning repositories before their runtime scaffold exists.
Manual scans preserve known language, MSL, GSDB, and preset metadata; explicit
parameters are the only way to record a justified downgrade or exception.*

```bash
bash scripts/register-level2-repository.sh --repo ~/RiderProjects/TuiVision --dry-run
bash scripts/register-level2-repository.sh --scan-root ~/RiderProjects --dry-run
bash scripts/check-gsdb-self-assessment.sh --repo ~/RiderProjects/TuiVision --check-only
bash scripts/check-gsdb-self-assessment.sh --repo ~/RiderProjects/TuiVision --dry-run
```

```powershell
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -Repo ~/RiderProjects/TuiVision -WhatIf
pwsh -NoProfile -File scripts/register-level2-repository.ps1 -ScanRoot ~/RiderProjects -WhatIf
pwsh -NoProfile -File scripts/check-gsdb-self-assessment.ps1 -Repo ~/RiderProjects/TuiVision -CheckOnly
pwsh -NoProfile -File scripts/check-gsdb-self-assessment.ps1 -Repo ~/RiderProjects/TuiVision -WhatIf
```

#### Wiederkehrende Level-2-Wartungsrunde / Recurring Level-2 Maintenance Round

Eine vollstaendige Level-2-Wartungsrunde fuer bestehende Umgebungen laeuft immer
vom Bestand zur Evidenz: zuerst Repositories und Toolchains aktualisieren, dann
Registrierung und Baseline angleichen, zuletzt GSDB, Statistik und lokale
Synchronisierung abschliessen.

*A complete level-2 maintenance round for existing environments always moves
from estate state to evidence: first update repositories and toolchains, then
align registration and baseline, and finally close GSDB, statistics, and local
synchronization.*

1. Level-0-, Level-1- und Level-2-Repositories aus ihren Remotes pullen. Fehlende
   Repositories nur dann klonen, wenn sie lokal noch nicht vorhanden sind.
2. Die drei Secure-Trader-Lernreihen-Level-1-Repositories fuer Secure
   CaseTracker, Secure OrderDesk und Secure ServiceHarvester sowie jeweils die
   sechs MSL-Sprachen-Level-2-Repositories fuer C#, Go, Java, Python, Rust und
   Swift bei Bedarf klonen oder, wenn vorhanden, pullen.
3. Den Level-1-Workspace `container-images` und darin das
   `absdd-image-sandbox`-Level-2-Repository bei Bedarf klonen oder pullen.
4. Die sechs MSL-CLI-Toolchains pruefen: `.NET`, Go, Java/Javac, Python,
   Rust/Cargo und Swift. Auf macOS fehlende Homebrew-verfuegbare Toolchains mit
   `brew install` nachziehen; Swift ueber die installierte Apple-Toolchain
   pruefen.
5. Die GSDB-Registry gegen die aktiven `canonical-fleet`-Ziele des
   Fleet-Manifests pruefen. Eine zusaetzliche manuelle Kandidatensuche mit
   `register-level2-repository.* --scan-root` / `-ScanRoot` erfolgt nur bei
   ausdruecklichem Bedarf; neue Ziele werden erst nach Bestaetigung in Manifest
   und `~/.home-baseline/level2-repository-registry.json` aufgenommen. Die
   public-safe Vorlage bleibt
   `scripts/config/level2-repository-registry.example.json`.
6. `constitution.md` und `.specify/memory/constitution.md` nur aktualisieren,
   wenn sich verbindliche Level-2-Umgebungsdaten wie Runtime, Build/Test,
   A11Y-, Statistik- oder Agentenflaechen aendern.
7. Spec-Kit und Governance bewusst ausrollen: erst `update-spec-kit.*` im
   Trockenlauf, dann bei Bedarf mit Commit/Push; fehlende Governance-Presets mit
   `install-spec-kit-governance-presets.*` nachziehen.
8. Secure-Development-Intakes fuer bestehende Repos mit
   `prepare-rl-se-checklist-selbstpruefung.*` und
   `prepare-secure-development-hardening.*` vorbereiten, jeweils zuerst mit
   `--dry-run` / `-WhatIf`.
9. GSDB mit `check-gsdb-self-assessment.* --check-only` pruefen, offene Punkte
   beheben und den normalen GSDB-Preflight nur ausfuehren, wenn die
   Intake-Artefakte aktualisiert werden sollen. Abschlussziel ist
   `Offene Punkte gesamt: 0`.
10. Den Abschluss in `docs/project-statistics.md` dokumentieren, betroffene
    Repositories committen/pushen oder bewusst lokal begruenden, und nach
    Level-0-Aenderungen `bash ~/scripts/sync-home.sh --no-pull` ausfuehren.

1. Pull level-0, level-1, and level-2 repositories from their remotes. Clone
   missing repositories only when they are not present locally yet.
2. Clone or pull the three Secure Trader learning-series level-1 repositories
   for Secure CaseTracker, Secure OrderDesk, and Secure ServiceHarvester plus
   their six MSL language level-2 repositories for C#, Go, Java, Python, Rust,
   and Swift.
3. Clone or pull the `container-images` level-1 workspace and its
   `absdd-image-sandbox` level-2 repository as needed.
4. Check the six MSL CLI toolchains: `.NET`, Go, Java/Javac, Python, Rust/Cargo,
   and Swift. On macOS, install missing Homebrew-available toolchains with
   `brew install`; verify Swift through the installed Apple toolchain.
5. Check the GSDB registry against active `canonical-fleet` targets in the
   fleet manifest. Run an additional manual candidate scan with
   `register-level2-repository.* --scan-root` / `-ScanRoot` only when
   explicitly needed; new targets join the manifest and
   `~/.home-baseline/level2-repository-registry.json` only after confirmation.
   The public-safe seed remains
   `scripts/config/level2-repository-registry.example.json`.
6. Update `constitution.md` and `.specify/memory/constitution.md` only when
   binding level-2 environment facts change, such as runtime, build/test, A11Y,
   statistics, or agent surfaces.
7. Roll out Spec Kit and governance deliberately: run `update-spec-kit.*` as a
   dry run first, then with commit/push when needed; add missing governance
   presets with `install-spec-kit-governance-presets.*`.
8. Prepare secure-development intakes for existing repositories with
   `prepare-rl-se-checklist-selbstpruefung.*` and
   `prepare-secure-development-hardening.*`, each with `--dry-run` / `-WhatIf`
   first.
9. Check GSDB with `check-gsdb-self-assessment.* --check-only`, fix open items,
   and run the normal GSDB preflight only when intake artefacts should be
   updated. The closeout target is `Offene Punkte gesamt: 0`.
10. Record the closeout in `docs/project-statistics.md`, commit/push affected
    repositories or document why they remain local, and after level-0 changes
    run `bash ~/scripts/sync-home.sh --no-pull`.

#### Wiederkehrende agentische Toolchain-Wartung / Recurring Agentic Toolchain Maintenance

Die agentische Toolchain-Wartung haelt die Programme stabil, die fuer Arbeiten
in Level-0-, Level-1- und Level-2-Repositories gebraucht werden. Fuer
Auszubildende ist der Mindeststandard bewusst zweigleisig: VS Code ist die
grafische Quasi-IDE, Helix (`hx`) ist der terminalbasierte A11Y-/CLI-Editor.
Die maschinelle Quelle fuer macOS/Linux ist
[`scripts/config/brew-apps-registry.json`](scripts/config/brew-apps-registry.json),
die Quelle fuer Windows ist
[`scripts/config/winget-apps-registry.json`](scripts/config/winget-apps-registry.json).
Die offiziellen VS-Code-MSL-Extensions und die Container-Tools-Extension werden separat in
[`scripts/config/vscode-extensions-registry.json`](scripts/config/vscode-extensions-registry.json)
gefuehrt. Die Required-CLI-Pruefungen fuer die sechs MSL-Pfade, `syft`,
GitHub Spec Kit (`specify`) und die erforderlichen Agenten-CLIs liegen in
[`scripts/config/required-cli-tools-registry.json`](scripts/config/required-cli-tools-registry.json).
Global installierte npm-Agenten-CLIs werden in
[`scripts/config/npm-agent-cli-registry.json`](scripts/config/npm-agent-cli-registry.json)
gefuehrt.
Die Paketmanager-Registries unterscheiden `required` und `optional`;
Standardlaeufe installieren nur `required`. `xquartz` ist lokal erlaubt, aber
bewusst aus der Brew-Registry ausgeschlossen.

Level-0 unter `~/home-baseline-source` ist zugleich die kanonische Quelle fuer das
Wartungspaket in bestehenden Level-1-/Level-2-Repositories. Die kontrollierte
Dateiliste steht in
[`scripts/config/agentic-toolchain-maintenance-files.json`](scripts/config/agentic-toolchain-maintenance-files.json).
Das Propagationswerkzeug aktualisiert nur diese Dateien, ueberschreibt keine
lokal veraenderte verwaltete Datei und fuehrt selbst keine Git-Commits oder
Pushes aus.

*Recurring agentic toolchain maintenance keeps the programs stable that are
needed for work in level-0, level-1, and level-2 repositories. For apprentices,
the minimum standard deliberately has two editor paths: VS Code is the graphical
quasi-IDE, while Helix (`hx`) is the terminal-native A11Y/CLI editor. The
machine source for macOS/Linux is
[`scripts/config/brew-apps-registry.json`](scripts/config/brew-apps-registry.json),
and the Windows source is
[`scripts/config/winget-apps-registry.json`](scripts/config/winget-apps-registry.json).
The official VS Code MSL extensions and the Container Tools extension are maintained separately in
[`scripts/config/vscode-extensions-registry.json`](scripts/config/vscode-extensions-registry.json).
Required CLI checks for the six MSL paths, `syft`, GitHub Spec Kit
(`specify`), and the required agent CLIs live in
[`scripts/config/required-cli-tools-registry.json`](scripts/config/required-cli-tools-registry.json).
Globally installed npm agent CLIs are maintained in
[`scripts/config/npm-agent-cli-registry.json`](scripts/config/npm-agent-cli-registry.json).
The package-manager registries distinguish `required` from `optional`; default
runs install only `required`. `xquartz` may be installed locally, but is
intentionally excluded from the Brew registry.*

*Level-0 under `~/home-baseline-source` is also the canonical source for the
maintenance package in existing Level-1/Level-2 repositories. The controlled
file list lives in
[`scripts/config/agentic-toolchain-maintenance-files.json`](scripts/config/agentic-toolchain-maintenance-files.json).
The propagation tool updates only these files, never overwrites a locally
modified managed file, and performs no Git commits or pushes itself.*

Wenn ein bekannter KI-Agent in `~` oder `~/home-baseline-source` startet und keine
strengere Read-only-Aufgabe im Vordergrund steht, soll er einmal nachfragen, ob
die wiederkehrende Workspace-Wartung ausgefuehrt werden soll. Die vier Optionen
sind: nur pruefen; pruefen und fehlende Required-Tools installieren; vollstaendig
inklusive GSDB-Preflight vorbereiten; oder ueberspringen. Fehlende
Required-Tools aus `--compare-only` / `-CompareOnly` werden bei freigegebener
Wartung installiert. Optionale Tools bleiben zustimmungspflichtig.

*When a known AI agent starts in `~` or `~/home-baseline-source` and no stricter
read-only task is in focus, it should ask once whether recurring workspace
maintenance should run. The four options are: check only; check and install
missing required tools; full maintenance including GSDB preflight preparation;
or skip. Missing required tools reported by `--compare-only` / `-CompareOnly`
are installed when maintenance is approved. Optional tools still require
explicit approval.*

### Ein Wartungsbefehl pro Betriebssystem / One maintenance command per OS

Fuer die normale Gesamtwartung ist nur noch der passende Orchestrator noetig.
Ohne Optionen aktualisiert er Level-0, synchronisiert `~/`, aktualisiert alle
aktiven `canonical-fleet`-Ziele des Fleet-Manifests per Fast-forward, pflegt
die lokale GSDB-Registry, prueft die Wartungspaket-Verteilung und wartet danach
die Maschinen-Toolchain. Nicht deklarierte Legacy-Ordner werden weder erneut
registriert noch in die Propagation aufgenommen. Vor dem ersten echten Lauf
auf einem weiteren System sind `--check-only` / `-CheckOnly` und anschliessend
die Vorschau empfohlen.

*Normal full maintenance now needs only the matching orchestrator. Without
options it updates Level-0, synchronizes `~/`, fast-forwards all declared
active `canonical-fleet` Level-1/Level-2 targets, maintains the local
GSDB registry, checks maintenance-package distribution, and then maintains the
machine toolchain. Undeclared legacy directories are neither re-registered nor
included in propagation. On another machine, run check-only and then preview
before the first actual run.*

```bash
# macOS / Linux
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
bash scripts/maintain-agentic-workspace.sh
```

```powershell
# Windows
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1
```

Mit `--scripts-only` / `-ScriptsOnly` bleibt die Maschinen-Toolchain
unveraendert. Wartungspaket-Drift wird standardmaessig nur gemeldet und nur mit
`--repair-drift` / `-RepairDrift` lokal korrigiert. Dieser Reparaturmodus
commitet oder pusht nie: Exit `3` fordert zur separaten Pruefung der betroffenen
Repositories auf. Dirty Worktrees, fehlende Upstreams, Ahead-/Diverged-Zustaende
und detached HEAD werden nicht automatisch aufgeloest. Ein Lock verhindert
parallele Laeufe; Logs liegen lokal unter `~/.home-baseline/logs/`.

Die Preset-Profilpruefung behandelt einen ausgecheckten Feature-Branch nicht
als fehlende Spec-Kit-Initialisierung, wenn `origin/HEAD` bereits initialisiert
ist. In diesem Fall wird die kanonische Revision in einem temporaeren detached
Worktree nur gelesen und geprueft. Der aktive Branch und unversionierte Dateien
bleiben unveraendert; eine dort gefundene Drift wird nicht temporaer repariert.

*Use `--scripts-only` / `-ScriptsOnly` to leave the machine toolchain unchanged.
Maintenance-package drift is reported by default and repaired locally only with
`--repair-drift` / `-RepairDrift`. Repair mode never commits or pushes; exit `3`
requests separate review of affected repositories. Dirty worktrees, missing
upstreams, ahead/diverged states, and detached HEAD are never resolved
automatically. A lock prevents parallel runs; local logs are stored below
`~/.home-baseline/logs/`. Preset checks use an isolated detached worktree when
the active checkout differs from `origin/HEAD`, preserving the active branch
and all untracked files.*

```bash
bash scripts/maintain-agentic-brew-apps.sh --dry-run
bash scripts/maintain-agentic-brew-apps.sh --compare-only
bash scripts/maintain-agentic-brew-apps.sh
```

Required-Homebrew-Formulae koennen in der Registry mit `ensureLinked: true`
markiert werden. Der Wartungslauf stellt ihren Link nach Upgrades wieder her;
`--compare-only` meldet stattdessen schreibfrei `LINK-DRIFT`. PowerShell wird
als Required-Formula gepflegt, nicht als Cask. Die bewusst vorhandenen
Formulae MongoDB Community 8.0, Mono, SQLite und Telnet sind optional und
werden ohne `--include-optional` nicht auf weiteren Rechnern installiert.

*Required Homebrew formulae may use `ensureLinked: true`. Maintenance restores
their link after upgrades, while `--compare-only` reports read-only
`LINK-DRIFT`. PowerShell is maintained as the required formula rather than a
cask. MongoDB Community 8.0, Mono, SQLite, and Telnet are optional and are not
installed on additional machines without `--include-optional`.*

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -CompareOnly
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1
```

PSScriptAnalyzer `1.25.0` wird nicht als Brew-/WinGet-Paket, sondern als
Required-PowerShell-Modul aus der PowerShell Gallery gepflegt. Beide
Host-Wartungspfade rufen denselben Modulpfleger auf. Fuer einen direkten
Vergleich oder Analyselauf:

*PSScriptAnalyzer `1.25.0` is maintained as a required PowerShell module from
PowerShell Gallery, not as a Brew or WinGet package. Both host-maintenance paths
invoke the same module maintainer. For a direct comparison or analysis run:*

```powershell
pwsh -NoProfile -File scripts/maintain-powershell-modules.ps1 -CompareOnly
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
```

Vor und nach Aenderungen am Wartungspaket wird dessen Repository-Verteilung
zuerst als Vorschau, danach als reiner Drift-Check ausgefuehrt.

*Before and after changing the maintenance package, preview its repository
distribution first and finish with a drift-only check.*

```bash
bash scripts/propagate-agentic-toolchain-maintenance.sh --dry-run
bash scripts/propagate-agentic-toolchain-maintenance.sh
bash scripts/propagate-agentic-toolchain-maintenance.sh --check-only
```

```powershell
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1 -WhatIf
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1
pwsh -NoProfile -File scripts/propagate-agentic-toolchain-maintenance.ps1 -CheckOnly
```

1. macOS/Linux zuerst mit `maintain-agentic-brew-apps.sh --dry-run` pruefen.
   Wenn `brew` vorhanden ist, fuehrt der echte Lauf `brew update`,
   `brew upgrade` und fehlende Required-Installationen aus. Auf Ubuntu/Linux
   ohne `brew` nutzt das Skript den dokumentierten apt-Fallback mit
   `sudo apt update`, `sudo apt upgrade` und explizit gemappten Paketen.
2. Windows zuerst mit `maintain-agentic-winget-apps.ps1 -WhatIf` pruefen. Der
   echte Lauf nutzt `winget update`, faellt bei Bedarf auf
   `winget source update` zurueck, fuehrt `winget upgrade --all` aus und
   installiert fehlende Required-Pakete mit `winget install --id <Id> --exact`.
3. `gitleaks`, `syft` und GitHub Spec Kit (`specify`) sind Required.
   `gitleaks` und `syft` werden ueber die Paketmanager-Registries gepflegt;
   `specify` wird bei Bedarf ueber `uv tool install specify-cli --from
   git+https://github.com/github/spec-kit.git` installiert.
4. Die eigenstaendigen Agenten-CLIs `codex`, `claude` und `copilot` sind
   plattformuebergreifend Required und nutzen bei Bedarf die npm-Registry als
   Fallback. Google Antigravity ersetzt Gemini CLI: macOS nutzt den Required-
   Cask `antigravity-cli` mit dem Kommando `agy`, Windows das Required-WinGet-
   Paket `Google.AntigravityCLI`. Linux nutzt den offiziellen Installer nur
   nach erfolgreicher Prüfung gegen die in der CLI-Registry hinterlegte
   SHA-256-Prüfsumme.
   `gh copilot` gilt nicht als Installationsnachweis fuer die eigenstaendige
   Copilot CLI.
5. VS Code ist Required: macOS per Cask `visual-studio-code`, Windows per
   WinGet-ID `Microsoft.VisualStudioCode`. Die Required-Extensions fuer C#,
   Go, Java, Python, Rust und Swift sowie Microsoft Container Tools fuer
   Docker-/Podman-Workflows werden mit `code --install-extension` gepflegt. Die
   veraltete Swift-Extension `sswg.swift-lang` wird nur gemeldet, nicht
   automatisch entfernt. Auf macOS erfuellt ein vorhandenes App-Bundle unter
   `/Applications/Visual Studio Code.app` oder `~/Applications/Visual Studio Code.app`
   den Required-Cask auch ohne Homebrew-Cask-Installation.
6. Helix ist Required als terminalbasierter A11Y-/CLI-Editor: macOS/Linux per
   Formula `helix`, Windows per WinGet-ID `Helix.Helix`. `msedit` bleibt ein
   optionaler einfacher Terminal-Editor.
7. Podman CLI und Compose-Unterstuetzung sowie die sechs MSL-CLI-Toolchains sind
   Required: `.NET`, Go, Java/Javac,
   Python, Rust/Cargo und Swift. Swift wird auf macOS ueber die Apple-Toolchain
   geprueft; Windows nutzt die WinGet-Toolchain; Linux ohne Homebrew meldet
   nicht nativ verfuegbare Tools transparent als offene manuelle Luecke.
8. Linux ohne Homebrew richtet keine zusaetzlichen Microsoft-APT-Quellen ein.
   `code` und `helix` werden im apt-Fallback nur installiert, wenn sie in den
   bereits konfigurierten apt-Quellen verfuegbar sind; andernfalls wird dies
   klar gemeldet.
9. PSScriptAnalyzer `1.25.0` ist als Required-PowerShell-Modul festgelegt. Die
   Host-Wartung installiert oder prueft es im Benutzerkontext; der gemeinsame
   Analyselauf muss fuer alle getrackten repo-eigenen PowerShell-Dateien gruen
   sein; die in der Modul-Registry dokumentierten Spec-Kit-Upstream-Pfade sind
   ausgenommen.
10. Zweitgeraete werden ueber `mac-test.sh`, `linux-test.sh` und
   `windows-test.ps1` verglichen. Die Testausgaben enthalten Paketlisten und
   Registry-Diffs; bewusst installierte Top-Level-Tools werden danach in die
   passende Registry uebernommen.
11. Abschlusskriterien: `--compare-only` meldet
   `missing_on_machine.required.*: none`,
   `gitleaks version`, `syft version`, `specify --version`,
   `podman --version`, `codex --version`, `claude --version`,
   `agy --version`, `copilot --version`, die sechs MSL-CLI-Pruefungen,
   `code --version` und
   `hx --version` funktionieren, die
   Registry-Dateien sind gueltiges JSON, und der Abschluss wird in
   `docs/project-statistics.md` dokumentiert.

1. Check macOS/Linux first with `maintain-agentic-brew-apps.sh --dry-run`.
   When `brew` exists, the real run executes `brew update`, `brew upgrade`,
   and missing required installations. On Ubuntu/Linux without `brew`, the
   script uses the documented apt fallback with `sudo apt update`,
   `sudo apt upgrade`, and explicitly mapped packages.
2. Check Windows first with `maintain-agentic-winget-apps.ps1 -WhatIf`. The
   real run uses `winget update`, falls back to `winget source update` when
   needed, runs `winget upgrade --all`, and installs missing required packages
   with `winget install --id <Id> --exact`.
3. `gitleaks`, `syft`, and GitHub Spec Kit (`specify`) are required.
   `gitleaks` and `syft` are maintained through the package-manager
   registries; `specify` is installed through `uv tool install specify-cli
   --from git+https://github.com/github/spec-kit.git` when missing.
4. The standalone `codex`, `claude`, and `copilot` agent CLIs are required
   across platforms and use the npm registry as a fallback when needed. Google
   Antigravity replaces Gemini CLI: macOS uses required cask
   `antigravity-cli` and command `agy`, while Windows uses required WinGet
   package `Google.AntigravityCLI`. Linux uses the official installer only
   after verification against the SHA-256 digest stored in the CLI registry. `gh copilot`
   does not count as proof that the standalone Copilot CLI is installed.
5. VS Code is required: macOS via cask `visual-studio-code`, Windows via WinGet
   ID `Microsoft.VisualStudioCode`. The required extensions for C#, Go, Java,
   Python, Rust, and Swift plus Microsoft Container Tools for Docker/Podman
   workflows are maintained with `code --install-extension`. The deprecated
   Swift extension `sswg.swift-lang` is reported only, not removed
   automatically. On macOS, an existing app bundle under
   `/Applications/Visual Studio Code.app` or `~/Applications/Visual Studio Code.app`
   satisfies the required cask even without a Homebrew cask install.
6. Helix is required as the terminal-native A11Y/CLI editor: macOS/Linux via
   formula `helix`, Windows via WinGet ID `Helix.Helix`. `msedit` remains an
   optional simple terminal editor.
7. The Podman CLI and Compose support plus the six MSL CLI toolchains are
   required: `.NET`, Go, Java/Javac, Python,
   Rust/Cargo, and Swift. Swift is checked through the Apple toolchain on
   macOS; Windows uses the WinGet toolchain; Linux without Homebrew reports
   tools that are not natively available as explicit manual gaps.
8. Linux without Homebrew does not configure additional Microsoft apt sources.
   In the apt fallback, `code` and `helix` are installed only when available
   from the already configured apt sources; otherwise this is reported clearly.
9. PSScriptAnalyzer `1.25.0` is pinned as a required PowerShell module. Host
   maintenance installs or checks it in user scope; the shared analysis run
   must pass for every tracked, repository-owned PowerShell file; the Spec Kit
   upstream paths documented in the module registry are excluded.
10. Compare second machines through `mac-test.sh`, `linux-test.sh`, and
   `windows-test.ps1`. Their test outputs include package lists and registry
   diffs; intentionally installed top-level tools are then added to the matching
   registry.
11. Closeout criteria: `--compare-only` reports
   `missing_on_machine.required.*: none`,
   `gitleaks version`, `syft version`, `specify --version`,
   `podman --version`, `codex --version`, `claude --version`,
   `agy --version`, `copilot --version`, the six MSL CLI checks,
   `code --version`, and
   `hx --version` work, the registry files are valid JSON, and the closeout is
   documented in `docs/project-statistics.md`.

Die mitgeltende [Leitlinie Sichere Entwicklungs-Sandbox](docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md) beschreibt das Referenzprofil für sichere Entwicklung mit KI-Agenten in einer Sandbox. `absdd-image-sandbox` ist als öffentliches Ausbildungs- und Referenz-Repository verfügbar: <https://github.com/hindermath/absdd-image-sandbox>. `home-baseline` liefert Richtlinien, Checklisten, Presets und Intake; die Sandbox liefert die ausführbare Lern- und Arbeitsumgebung; Level-2-Repositories liefern die konkreten Entwicklungs- und Härtungsziele.

*The related [Secure Development Sandbox Guideline](docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md) describes the reference profile for secure development with AI agents in a sandbox. `absdd-image-sandbox` is available as a public training and reference repository: <https://github.com/hindermath/absdd-image-sandbox>. `home-baseline` provides guidelines, checklists, presets, and intake; the sandbox provides the executable learning and work environment; level-2 repositories provide the concrete development and hardening targets.*

Fuer alle drei Secure-Trader-Lernreihen gilt ab Unit 00 eine klare Grenze: Wird
kein KI-Agent verwendet, darf die Sandbox-Nutzung begruendet als `N/A`
dokumentiert werden. Jeder Agentenaufruf fuer Secure CaseTracker, Secure
OrderDesk oder Secure ServiceHarvester erfolgt dagegen verbindlich in der
freigegebenen Podman-Sandbox. Normale agentenlose Entwicklung, Lesen und Review
duerfen weiterhin ausserhalb der Sandbox stattfinden.

*A clear boundary applies to all three Secure Trader learning series from unit
00 onward: when no AI agent is used, sandbox use may be documented as justified
`N/A`. Every agent invocation for Secure CaseTracker, Secure OrderDesk, or Secure
ServiceHarvester, however, must run inside the approved Podman sandbox. Normal
agent-free development, reading, and review may continue outside the sandbox.*

Die Lernmaterialien unter [`docs/learning-units/`](docs/learning-units/README.md) übertragen diese Grundlagen in ausführliche, DE-first/EN-second aufgebaute Lerneinheiten. Der Bereich ist die Level-0-Quelle fuer wiederverwendbare Lernreihen ab dem 1., 2. und 3. Lehrjahr. Der [Lernreihen-Blueprint](docs/learning-units/Lernreihen-Blueprint.md), das [Lernreihen-Register](docs/learning-units/Lernreihen-Register.md), das [IT-Berufe-Mapping](docs/learning-units/IT-Berufe-Secure-CaseTracker-Mapping.md) und die Vorlagen unter [`docs/learning-units/templates/`](docs/learning-units/templates/) definieren das generische Muster fuer neue Reihen.

*The learning material under [`docs/learning-units/`](docs/learning-units/README.md) turns this baseline into detailed DE-first/EN-second learning units. This area is the level-0 source for reusable learning series from the first, second, and third training year onward. The [Learning Series Blueprint](docs/learning-units/Lernreihen-Blueprint.md), the [Learning Series Register](docs/learning-units/Lernreihen-Register.md), the [IT occupation mapping](docs/learning-units/IT-Berufe-Secure-CaseTracker-Mapping.md), and the templates under [`docs/learning-units/templates/`](docs/learning-units/templates/) define the generic pattern for new series.*

Die erste Reihe ist **Secure CaseTracker** für die fiktive Übungsfirma **EuFPA – Europäische Firma Programmiert Alles**. Sie ist sprachneutral für C#, Go, Java, Python, Rust und Swift angelegt und ordnet jede Aufgabe sichtbar den Fachrichtungen Anwendungsentwicklung, Systemintegration, Daten- und Prozessanalyse sowie Digitale Vernetzung zu.

*The first series is **Secure CaseTracker** for the fictional training company **EuFPA – European Company Programs Everything**. It is language-neutral for C#, Go, Java, Python, Rust, and Swift and visibly maps each task to Application Development, System Integration, Data and Process Analysis, and Digital Networking.*

Für Lernende ab dem 2. Lehrjahr sind zusätzlich **Secure CaseTracker v2** und **Secure InventoryHub** vorbereitet. CaseTracker v2 vertieft die vorhandene Reihe in Richtung Architektur, Persistenz, Service-Verträge, Autorisierung, Audit-Logging, CI, Sandbox, Betrieb und MSL-Vergleich. InventoryHub ist ein eigenständiger Praxisfall zu Inventar, Softwareständen, Rollen, Datenqualität, Patch-/Wartungsstatus, SBOM-Bezug, Tests und Betriebsnachweisen.

*For learners from the second training year onward, **Secure CaseTracker v2** and **Secure InventoryHub** are prepared as additional series. CaseTracker v2 deepens the existing series toward architecture, persistence, service contracts, authorization, audit logging, CI, sandbox, operation, and MSL comparison. InventoryHub is a standalone practical case about inventory, software versions, roles, data quality, patch/maintenance state, SBOM relation, tests, and operational evidence.*

Für Lernende ab dem 3. Lehrjahr ist **Secure CaseTracker Professional Tracks** vorbereitet. Die Reihe nutzt den bekannten CaseTracker-Fall weiter, trennt aber die Spezialisierungen: Application Track für AE, Operations Track für SI, Data & Process Track für DPA und Digital Networking Track für DV. Jeder Track enthält eigene Aufgaben-Intakes, Unterrichtsleitfäden und Präsentationen.

*For learners from the third training year onward, **Secure CaseTracker Professional Tracks** is prepared. The series continues the known CaseTracker case but separates the specializations: Application Track for Application Development, Operations Track for System Integration, Data & Process Track for Data and Process Analysis, and Digital Networking Track for Digital Networking. Each track contains its own task intakes, teaching guides, and presentations.*

Die zugehörigen Markdown-Präsentationen liegen unter [`docs/learning-units/presentations/`](docs/learning-units/presentations/) und sind für eine spätere Pandoc-Umwandlung nach PowerPoint vorbereitet. Sie dienen als Einführung in EuFPA, Secure CaseTracker, MSL, Sandbox, Spec Kit und die manuell gestarteten Level-2-Läufe. Die neutrale [Spec-Kit-SDD-Auftaktinformation](docs/learning-units/SPEC-KIT-SDD-AUFTAKT.md) erklärt Spec-Driven Development ohne organisationsspezifische Workshop-Bezüge.

*The related Markdown presentations live under [`docs/learning-units/presentations/`](docs/learning-units/presentations/) and are prepared for later Pandoc conversion to PowerPoint. They introduce EuFPA, Secure CaseTracker, MSL, sandboxing, Spec Kit, and the manually started Level 2 runs. The neutral [Spec Kit SDD kickoff](docs/learning-units/SPEC-KIT-SDD-AUFTAKT.md) explains spec-driven development without organization-specific workshop references.*

Spec-Kit-Läufe in Lernreihen sind begleitende SDD-Aufgaben pro Lehrjahr, Track, Sprachpfad und Aufgaben-Lastenheft. Sie ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

*Spec Kit runs in learning series are companion SDD tasks per training year, track, language path, and task intake. They do not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.*

Die zentralen Spec-Kit-Intakes der Lernreihe liegen ebenfalls unter [`docs/learning-units/`](docs/learning-units/) als `Lastenheft_Secure-CaseTracker*.md`. Dadurch stehen Einführung, Unterrichtsleitfaden, Präsentationen und ausführbare Intake-Dateien an einem gemeinsamen, didaktisch auffindbaren Ort.

*The central Spec Kit intake files of the learning series also live under [`docs/learning-units/`](docs/learning-units/) as `Lastenheft_Secure-CaseTracker*.md`. This keeps the introduction, teaching guide, presentations, and runnable intake files in one didactically discoverable place.*

Für die spätere praktische Bearbeitung ist Secure CaseTracker als Level-1-/Level-2-Struktur vorgesehen: `home-baseline-source` bleibt die Level-0-Quelle, ein privates Level-1-Repo `SecureCaseTrackerProjects` koordiniert Status und Reihenfolge, und sechs private Level-2-Repos bilden die getrennten MSL-Pfade für C#, Go, Java, Python, Rust und Swift. Die Spec-Kit-Läufe werden dort später manuell durch Lehrende oder Lernende gestartet; C# ist als erster Referenzpfad vorgesehen.

*For later practical work, Secure CaseTracker is intended as a Level 1 / Level 2 structure: `home-baseline-source` remains the Level 0 source, a private Level 1 repository `SecureCaseTrackerProjects` coordinates status and order, and six private Level 2 repositories provide the separate MSL paths for C#, Go, Java, Python, Rust, and Swift. The Spec Kit runs are started there later and manually by instructors or learners; C# is planned as the first reference path.*

Die lokalen Level-2-Ordner nutzen CamelCase, z. B. `SecureCaseTracker-CSharp`. Die Repository-Slugs werden durch `bootstrap-project.sh` lowercase erzeugt, z. B. `securecasetracker-csharp`.

*The local Level 2 folders use CamelCase, for example `SecureCaseTracker-CSharp`. The repository slugs are created lowercase by `bootstrap-project.sh`, for example `securecasetracker-csharp`.*

Lernreihen koennen fuer die Weitergabe mit `package-learning-series.*` als ZIP ohne `.git`-Verzeichnisse, ohne urspruengliche Remote-URLs und ohne lokale Build-/IDE-Artefakte gepackt werden. Die generische Startanleitung [`docs/learning-units/GIT-START-FUER-LERNENDE.md`](docs/learning-units/GIT-START-FUER-LERNENDE.md) erklaert Lernenden danach den eigenen Git-Start.

*Learning series can be packaged for distribution with `package-learning-series.*` as a ZIP without `.git` directories, original remote URLs, or local build/IDE artefacts. The generic start guide [`docs/learning-units/GIT-START-FUER-LERNENDE.md`](docs/learning-units/GIT-START-FUER-LERNENDE.md) then explains how learners start their own Git history.*

```bash
bash scripts/package-learning-series.sh --source-dir ~/SecureCaseTrackerProjects --series-name "Secure CaseTracker" --package-prefix secure-casetracker --dry-run
```

```powershell
pwsh -NoProfile -File scripts/package-learning-series.ps1 -SourceDir ~/SecureCaseTrackerProjects -SeriesName 'Secure CaseTracker' -PackagePrefix secure-casetracker -WhatIf
```

Neue Level-2-Projekte erhalten beim Bootstrap einen RL-SE-/Checklist-Selbstpruefungs-Intake unabhaengig von MSL. Wenn ihre Primaersprache als MSL deklariert oder erkannt wird, wird zusaetzlich der Secure-Development-Hardening-Intake vorbereitet:

```bash
bash ~/scripts/bootstrap-project.sh MeinProjekt ~/RiderProjects --primary-language C#
```

```powershell
pwsh ~/scripts/bootstrap-project.ps1 -ProjectName MeinProjekt -TargetWorkspace ~/RiderProjects -PrimaryLanguage C#
```

Bei MSL-Level-2-Projekten installiert `bootstrap-project.*` nach der
Spec-Kit-Initialisierung auch die Governance-Presets aus der zentralen Matrix
[`scripts/config/spec-kit-governance-presets.json`](scripts/config/spec-kit-governance-presets.json).
Die Matrix ist die einzige Stelle fuer aktuelle Preset-Versionen und
Prioritaeten. Soll ein Projekt bewusst ohne diese Presets entstehen, kann
`--no-governance-presets` / `-NoGovernancePresets` gesetzt werden.

*New level-2 projects receive an RL-SE/checklist self-assessment intake during
bootstrap independently of MSL. For MSL level-2 projects, `bootstrap-project.*`
also installs the governance
presets from the central matrix
[`scripts/config/spec-kit-governance-presets.json`](scripts/config/spec-kit-governance-presets.json)
after Spec Kit initialization. The matrix is the single source for current preset
versions and priorities. Use `--no-governance-presets` /
`-NoGovernancePresets` only for a documented exception.*

Fuer bestehende Level-2-Repositories synchronisiert `prepare-secure-development-hardening.*` dieselbe Basis, erzeugt bei Bedarf `Lastenheft_Secure-Development-Hardening.md` und pflegt `Lastenheft_Abarbeitungsreihenfolge.md` anhand des strikten Suchmusters `Lastenheft*.md`. Vorhandene Reihenfolge-Dateien werden geschuetzt: nur der markierte generierte Abschnitt wird aktualisiert, manuelle Begruendungen bleiben erhalten.

*For existing level-2 repositories, `prepare-secure-development-hardening.*` synchronizes the same baseline, creates `Lastenheft_Secure-Development-Hardening.md` when needed, and maintains `Lastenheft_Abarbeitungsreihenfolge.md` from the strict `Lastenheft*.md` pattern. Existing order files are protected: only the marked generated section is updated, while manual rationale remains preserved.*

Vor der eigentlichen Haertung kann `prepare-rl-se-checklist-selbstpruefung.*` eine eigenstaendige RL-SE-/Checklist-Selbstpruefung vorbereiten. Standardmäßig liest das Skript die Level-2-Ziele mit `gsdbRequired: true` aus der lokalen Registry; `--discover`/`-Discover` aktiviert bewusst die breite Suche. `--baseline-only`/`-BaselineOnly` synchronisiert nur manifestverwaltete Dokumente und verändert weder Lastenhefte noch Projektnachweise. Das Intake verlangt getrennt Anwendbarkeit (`Applicable`, `N/A`, `Open`) und Umsetzung (`Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, `Not Assessed`) sowie Begründung, Evidenzpfad, Owner, Follow-up, Re-Evaluation-Trigger und Restrisiko.

*Before actual hardening, `prepare-rl-se-checklist-selbstpruefung.*` can prepare a dedicated self-assessment. By default it reads GSDB-required level-2 targets from the local registry. Baseline-only mode changes neither Lastenhefte nor project evidence. The intake requires separate applicability and implementation axes plus rationale, evidence path, owner, follow-up, re-evaluation trigger, and residual risk.*

Fuer dieses Level-0-Repository dokumentiert [`Lastenheft_Abarbeitungsreihenfolge.md`](Lastenheft_Abarbeitungsreihenfolge.md) die sichtbare Reihenfolge spaeterer Spec-Kit-Intakes. Lastenhefte mit Feature-Branch-Kennung im Dateinamen, zum Beispiel `001-workspace-homogeneity-guardian`, gelten dort als historischer Kontext und werden nicht erneut ausgefuehrt.

*For this Level-0 repository, [`Lastenheft_Abarbeitungsreihenfolge.md`](Lastenheft_Abarbeitungsreihenfolge.md) documents the visible order of later Spec Kit intakes. Lastenhefte with a feature-branch marker in the file name, for example `001-workspace-homogeneity-guardian`, are treated as historical context and are not executed again.*

Swift ist als Memory-Safe Language (MSL) beruecksichtigt. Das ist besonders fuer Apple-Zielplattformen relevant. Swift-Projekte muessen trotzdem die Swift-spezifischen Secure-Coding-Regeln pruefen; MSL-Status ersetzt keine API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Pruefung.

*Swift is considered a memory-safe language (MSL), especially for Apple target platforms. Swift projects still need Swift-specific secure-coding review; MSL status does not replace API, I/O, auth, crypto, logging, or dependency review.*

Gezielte Repositories koennen mit `--repo <Pfad>` / `-Repo <Pfad>` vorbereitet werden; das ist fuer bewusst begrenzte Propagationen in einzelne Level-2-Repos vorgesehen.

*Specific repositories can be prepared with `--repo <path>` / `-Repo <path>`; this is intended for deliberately bounded propagation into selected level-2 repos.*

Wichtig: Diese Vorbereitung startet keinen Spec-Kit-Lauf, erzeugt keinen Feature-Branch und befuellt keine `docs/security/`-Nachweise. Sie legt nur Intake- und Ordnungsartefakte fuer spaetere, separat gestartete Haertungslaeufe an.

*Important: this preparation does not start a Spec Kit run, does not create a feature branch, and does not populate `docs/security/` evidence. It only creates intake and ordering artefacts for later hardening runs started separately.*

### Sicherheit / Security

Dieser Block deckt den Schutz vor versehentlich eingecheckten Geheimnissen ab. Die Secret-Scan-Skripte pruefen typische Agenten-, Tool- und Projektverzeichnisse auf riskante Dateien oder Inhalte, waehrend `install-hooks.*` den gemeinsamen `pre-push`-Hook in ein Repository einhaengt. Wenn `gitleaks` installiert ist, wird es als bevorzugter zusaetzlicher Scanner genutzt: manuell fuer den aktuellen Git-Diff und im `pre-push`-Hook fuer die zu pushenden Commit-Ranges. Fehlt `gitleaks`, bleibt der bestehende Regex-Scanner als Fallback aktiv. Dadurch wird der Schutz moeglichst frueh aktiv: idealerweise schon vor dem Push und nicht erst nach einem CI-Fehler oder einem geleakten Token.

*This block covers protection against secrets being committed by accident. The secret-scan scripts inspect common agent, tool, and project directories for risky files or contents, while `install-hooks.*` installs the shared `pre-push` hook into a repository. When `gitleaks` is installed, it is used as the preferred additional scanner: manually for the current git diff and in the `pre-push` hook for the commit ranges being pushed. If `gitleaks` is missing, the existing regex scanner remains active as a fallback. This makes the protection active as early as possible: ideally before a push, and not only after a CI failure or a leaked token.*

Die Rollen sind auch hier getrennt: `scan-agent-secrets.*` ist das eigentliche Pruefwerkzeug, `install-hooks.*` bringt die Pruefung in den Alltag, und `scripts/hooks/pre-push` ist die gemeinsam genutzte Durchsetzungslogik. Als Kurzregel gilt also: **manuell pruefen = scan-agent-secrets plus gitleaks-Diff**, **dauerhaft absichern = install-hooks**, **beim Push blockieren = pre-push mit gitleaks-Range-Scan plus Regex-Fallback fuer geaenderte getrackte Dateien**.

*The roles are separated here as well: `scan-agent-secrets.*` is the actual inspection tool, `install-hooks.*` brings that inspection into day-to-day work, and `scripts/hooks/pre-push` is the shared enforcement logic. So the short rule is: **manual inspection = scan-agent-secrets plus gitleaks diff scan**, **persistent protection = install-hooks**, **block on push = pre-push with gitleaks range scan plus regex fallback for changed tracked files**.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/scan-agent-secrets.sh` | Secret-Scan fuer KI-Agenten-Verzeichnisse / Secret scan for AI agent directories (Bash) |
| `scripts/scan-agent-secrets.ps1` | Secret-Scan / Secret scan (PowerShell Core) |
| `scripts/audit-antigravity-migration.sh` | Antigravity-Migration ueber Level 0/1/2 pruefen / Audit Antigravity migration across Level 0/1/2 |
| `scripts/audit-antigravity-migration.ps1` | Windows-/PowerShell-Pendant des Migrationsaudits / Windows and PowerShell migration audit counterpart |
| `scripts/install-hooks.sh` | Git-Hooks installieren / Install Git hooks (Bash) |
| `scripts/install-hooks.ps1` | Git-Hooks installieren / Install Git hooks (PowerShell Core) |
| `scripts/hooks/pre-push` | Pre-Push-Hook, blockiert Push bei Secrets / Pre-push hook, blocks pushes when secrets are found |

### Einrichtung der KI-Agenten / AI Agent Setup

Dieser Block dokumentiert die **vorbereiteten lokalen Konfigurations-Skripte** fuer die vier Agenten, fuer die dieses Repository bereits wiederverwendbare Setup-Helfer mitliefert: GitHub Copilot CLI, Claude Code, Codex CLI und Antigravity CLI. Diese Skripte installieren den Agenten nicht selbst, sondern richten nach der Installation und Anmeldung die lokalen Konfigurationsdateien so ein, dass Statuszeilen, Anzeigeoptionen oder uebertragbare Standardwerte konsistent gesetzt werden.

*This block documents the **prepared local configuration scripts** for the four agents for which this repository already ships reusable setup helpers: GitHub Copilot CLI, Claude Code, Codex CLI, and Antigravity CLI. These scripts do not install the agent itself. Instead, after installation and sign-in, they configure the local settings files so that status lines, display options, or transferable defaults are applied consistently.*

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

#### Antigravity CLI / Antigravity CLI

Die Antigravity-Skripte pflegen `~/.gemini/antigravity-cli/settings.json` strukturiert, erhalten unbekannte Schlüssel und setzen die gehärtete Sicherheitsbaseline. Die plattformspezifischen Statusline-Helfer geben nur technische Workspace-Daten aus.

*The Antigravity scripts maintain `~/.gemini/antigravity-cli/settings.json` structurally, preserve unknown keys, and apply the hardened security baseline. The platform-specific status line helpers output technical workspace data only.*

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/setup-antigravity-settings.sh` | Antigravity CLI haerten und Statuszeile einrichten / Harden Antigravity CLI and configure status line (Bash) |
| `scripts/setup-antigravity-settings.ps1` | Antigravity CLI haerten und Statuszeile einrichten / Harden Antigravity CLI and configure status line (PowerShell Core) |
| `scripts/templates/antigravity-statusline.*` | Plattformgerechte ASCII-only-Statuszeilen / Platform-specific ASCII-only status lines |

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

Beide Varianten laden das vollstaendige `scripts/lib/hg-*`-Hilfspaket. Fehlt
eine benoetigte Funktion, brechen sie vor dem Scan mit Exitcode `2` ab; ein
unvollstaendiges Paket kann deshalb nicht als bestandener Check erscheinen.
Der Runtime-Vertrag kann gezielt mit den folgenden Kommandos geprueft werden:

*Both variants load the complete `scripts/lib/hg-*` helper package. If a
required function is missing, they stop before scanning with exit code `2`, so
an incomplete package cannot appear as a passing check. Use these commands to
validate the runtime contract directly:*

```bash
bash scripts/test-homogeneity-runtime-closure.sh .
pwsh -NoProfile -File scripts/test-homogeneity-runtime-closure.ps1 -RepoRoot .
```

Fuer einen begrenzten Fleet-Abgleich enthaelt
`scripts/config/homogeneity-runtime-files.json` nur die beiden Wrapper und ihre
21 Bibliotheken. Andere Wartungsdateien werden dabei nicht nebenbei verteilt.

*For a bounded fleet alignment,
`scripts/config/homogeneity-runtime-files.json` contains only the two wrappers
and their 21 libraries. It does not propagate unrelated maintenance files.*

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

Die folgenden Kommandos kannst du technisch von **jedem** Verzeichnis aus starten, weil der Skriptpfad explizit ist und `migrate-workspace.*` den Ziel-Workspace ueber `~/<WorkspaceName>` aufloest. Praktisch haengt der beste Startpunkt vom Blickwinkel ab: Wenn du die Baseline selbst weiterentwickelst, ist `~/home-baseline-source` sinnvoll. Wenn du die Skripte als Nutzender oder Azubi auf deine bestehende Umgebung anwendest, ist `~/` der natuerlichere Ausgangspunkt, weil dort die Level-1-Workspaces direkt sichtbar sind.

*You can technically start the following commands from **any** directory, because the script path is explicit and `migrate-workspace.*` resolves the target workspace via `~/<WorkspaceName>`. In practice, the best starting point depends on perspective: if you are evolving the baseline itself, `~/home-baseline-source` is sensible. If you are using the scripts as an end user or apprentice on your existing environment, `~/` is the more natural starting point because the level-1 workspaces are directly visible there.*

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
3.  **Git-Hosting:** GitHub, GitLab, Codeberg, Forgejo oder ein institutionelles Git-System speichern deine Repositories zentral. Du verwendest nur das System und das Konto, das deine Institution vorgibt.

**Wichtig für dich:** Dein **Home-Verzeichnis** (auf dem Mac/Linux als `~/` abgekürzt) ist dein persönlicher Bereich auf dem Computer. Wir richten diesen Bereich jetzt so ein, dass er sich „selbst verwaltet“.

*In IT, we often work with many different projects. To help you stay organised and keep your work safely stored, we use an **automated infrastructure**.*

*Here are the three main concepts you will learn today:*

*1. **The terminal (command line):** your main tool. Instead of clicking with the mouse, you give the computer direct text commands. This is faster, more precise, and easy to automate.*
*2. **Git (version control):** like a time machine for your code. You save checkpoints (commits). If something goes wrong, you can return to a working state at any time.*
*3. **Git hosting:** GitHub, GitLab, Codeberg, Forgejo, or an institutional Git system stores your repositories centrally. You only use the system and account selected by your institution.*

***Important:** your **home directory** (shortened to `~/` on macOS/Linux) is your personal area on the computer. We now set it up so that it largely manages itself.*

---

### Schritt 0: Deine Werkzeuge vorbereiten / Step 0: Preparing your tools

Die vollstaendige, verbindliche Reihenfolge steht in
[`START-HERE-FUER-LERNENDE.md`](docs/learning-units/START-HERE-FUER-LERNENDE.md).
Beginne dort mit Betriebssystem, Shell, Git und ripgrep. Eine Hosting-CLI wird
nur fuer das tatsaechlich verwendete Profil angemeldet. Danach
werden die weiteren Required-Werkzeuge ueber das passende Wartungsskript zuerst
in der Vorschau und anschliessend im echten Lauf eingerichtet.

*The complete binding sequence is in
[`START-HERE-FUER-LERNENDE.md`](docs/learning-units/START-HERE-FUER-LERNENDE.md).
Start there with your operating system, shell, Git, and ripgrep. A hosting CLI
is only signed in for the profile actually in use.
Then set up the remaining required tools through the matching maintenance script,
first as a preview and then as a real run.*

---

### Schritt 1: Deinen persoenlichen Fork anlegen / Step 1: Create Your Personal Fork

Lege einen persoenlichen Fork der institutionell bereitgestellten
`home-baseline`-Referenz an. Nur beim direkten GitHub-Profil ist diese Referenz
`hindermath/home-baseline`. Ein Fork behaelt die Verbindung zur Quelle. Dadurch
kann dein lokaler Klon spaeter
`origin` fuer eigene Pushes und `upstream` fuer freigegebene Aktualisierungen
verwenden. Ein unabhaengiges Repository ueber **Use this template** ist fuer
diesen betreuten Lernendenpfad nicht vorgesehen.

*Create a personal fork of the institution-provided `home-baseline` reference.
Only the direct GitHub profile uses `hindermath/home-baseline`. A fork keeps its
connection to the source. Your local clone can therefore use `origin`
for your own pushes and `upstream` for approved updates. An independent
repository created through **Use this template** is not used for this guided
learner path.*

Die genauen institutionellen und direkten GitHub-Wege stehen in den Schritten 3
bis 5 der Startanleitung. Ausbildende beginnen mit
[`INSTITUTIONELLES-GIT-HOSTING.md`](docs/learning-units/INSTITUTIONELLES-GIT-HOSTING.md).

---

### Schritt 2: Deinen Computer mit dem Git-Hosting verbinden / Step 2: Connect to Git Hosting

Klone deinen persoenlichen Fork dauerhaft als `~/home-baseline-source`, richte
`upstream` ein und pruefe beide Remotes. Loesche diesen Ordner nicht: Er ist deine
mit deinem Git-Hosting verbundene Wartungs- und Entwicklungsarbeitskopie. `~/` bleibt die
lokale Betriebskopie ohne Remote. Die genauen macOS/Linux- und Windows-Befehle
stehen in den Schritten 5 bis 10 der
[Startanleitung](docs/learning-units/START-HERE-FUER-LERNENDE.md#5-persoenlichen-fork-dauerhaft-klonen--clone-your-fork-permanently).

*Clone your personal fork permanently as `~/home-baseline-source`, configure
`upstream`, and verify both remotes. Do not delete this directory: it is your
Git-hosting-connected maintenance and development checkout. `~/` remains the local
runtime copy without a remote. The exact macOS/Linux and Windows commands are in
steps 5 through 10 of the
[start guide](docs/learning-units/START-HERE-FUER-LERNENDE.md#5-persoenlichen-fork-dauerhaft-klonen--clone-your-fork-permanently).*

---

### Schritt 3: Deinen ersten "Workspace" anlegen / Step 3: Create your first workspace

Ein **Workspace** ist wie ein großer Aktenordner für ein bestimmtes Thema (z. B. „Berufsschule“ oder „C-Sharp-Kurs“). Der Bootstrap kann ein passendes privates Repository auf GitHub, GitLab, Codeberg oder Forgejo erstellen. Fuer andere Git-Systeme verwendest du `--no-remote` und verbindest das bereitgestellte Repository danach manuell.

*A workspace is like a large folder for a specific topic. The bootstrap can create a matching private repository on GitHub, GitLab, Codeberg, or Forgejo. For other Git systems, use `--no-remote` and connect the provided repository afterwards.*

**Befehl ausführen:**
```bash
# Erstellt einen Workspace für deine Ausbildungsprojekte
bash ~/scripts/bootstrap-workspace.sh Ausbildung
```
*(Auf Windows nutzt du `pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName Ausbildung`)*

**Was ist gerade passiert?**
1.  Ein Ordner `~/Ausbildung` wurde erstellt.
2.  Ein privates Repo namens `ausbildung-baseline` wurde auf der gewaehlten Plattform angelegt.
3.  Wichtige Schutz-Scripte (Git-Hooks) wurden installiert, damit du keine Passwörter aus Versehen hochlädst.

*What just happened?*
*1. A directory `~/Ausbildung` was created.*
*2. A private repo named `ausbildung-baseline` was created on the selected platform.*
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

Die Wartung installiert und prueft Codex, Claude Code, Antigravity CLI und die
eigenstaendige GitHub Copilot CLI. Fuer Secure-Trader-Projekte startest du diese
Agenten nicht auf dem Host. Arbeite zuerst den Sandbox-Preflight durch und folge
dem dokumentierten
[ersten kontrollierten Agentenlauf](docs/learning-units/START-HERE-FUER-LERNENDE.md#17-erster-kontrollierter-agentenlauf--first-controlled-agent-run).

*Maintenance installs and checks Codex, Claude Code, Antigravity CLI, and the
standalone GitHub Copilot CLI. For Secure Trader projects, do not start these
agents on the host. Complete the sandbox preflight first and follow the documented
[first controlled agent run](docs/learning-units/START-HERE-FUER-LERNENDE.md#17-erster-kontrollierter-agentenlauf--first-controlled-agent-run).*

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
| Konto im verwendeten Git-System / Account on the selected Git system | ✅ | Repository-Hosting; GitHub nur im direkten GitHub-Profil / repository hosting; GitHub only for the direct GitHub profile |
| KI-Agent (mind. einer) / AI agent (at least one) | ✅ | Fuehrt die Spec-Kit-Skills aus / Runs the Spec-Kit skills |
| `uv` (Python) | ✅ | Installiert `specify-cli` (das Spec-Kit-CLI) / Installs `specify-cli` (the Spec-Kit CLI) |
| Node.js ≥ 22 LTS | fuer npm-Agenten / for npm-based agents | Codex CLI und weitere npm-Werkzeuge installieren / Install Codex CLI and other npm tools |
| `gh` CLI | empfohlen / recommended | GitHub Copilot CLI; Issues aus Tasks anlegen / create issues from tasks |

Alle Voraussetzungen werden beim ersten Aufruf von `check-prerequisites.sh` geprüft.

---

### KI-Agenten einrichten / Set up AI agents

Je nachdem welchen KI-Agenten du bevorzugst, sind unterschiedliche Schritte nötig.
Dieses Repo unterstützt alle fünf nachfolgend beschriebenen Agenten.

*Depending on which AI agent you prefer, different setup steps are needed. This repo supports all five agents described below.*

Der Zweck dieses Abschnitts ist zweigeteilt: Erstens sollst du den Agenten technisch zum Laufen bringen, zweitens soll klar werden, **wie Spec-Kit den jeweiligen Agenten integriert**. Nicht jeder Agent arbeitet mit demselben Mechanismus. Manche lesen Projektdateien wie `AGENTS.md` oder `GEMINI.md` direkt als Kontext, andere entdecken Kommandos oder Skills in agentenspezifischen Verzeichnissen wie `.claude/commands/` oder `.agents/skills/`.

*This section has a two-part purpose: first, to get the agent running technically; second, to make clear **how Spec-Kit integrates with that specific agent**. Not every agent works through the same mechanism. Some read project files such as `AGENTS.md` or `GEMINI.md` directly as context, while others discover commands or skills from agent-specific directories such as `.claude/commands/` or `.agents/skills/`.*

Praktisch bedeutet das: Du waehlst nicht nur nach Geschmack, sondern auch nach deinem lokalen Setup und deinem Arbeitsstil. GitHub Copilot CLI passt gut zu einem `gh`-zentrierten Workflow, Claude Code ist stark fuer dialogische Codearbeit mit eigener Kommando-Struktur, Antigravity CLI und Codex CLI sind tastaturorientierte Terminal-Agenten mit guter Repo-Orientierung, und OpenCode ist eine native Alternative mit aehnlichem `AGENTS.md`-Kontextmodell wie Codex.

*In practice, this means you are not choosing only by taste, but also by your local setup and working style. GitHub Copilot CLI fits well into a `gh`-centric workflow, Claude Code is strong for conversational coding with its own command structure, Antigravity CLI and Codex CLI are keyboard-oriented terminal agents with good repository orientation, and OpenCode is a native alternative with a similar `AGENTS.md` context model to Codex.*

Wichtig fuer den Ablauf: Nach der Agenten-Installation solltest du **nicht sofort `specify init` starten**, sondern zuerst den Abschnitt `Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory` lesen. Dort wird `uv`, `specify-cli` und der korrekte Initialisierungsweg eingerichtet. Dieser Schritt ist Voraussetzung dafuer, dass die nachfolgenden Spec-Kit-Befehle ueberhaupt sauber funktionieren.

*One workflow detail matters especially: after installing the agent, you should **not jump directly to `specify init`**, but first read the section `Verzeichnis fuer Spec-Kit vorbereiten / Prepare a directory`. That is where `uv`, `specify-cli`, and the correct initialization path are set up. This step is a prerequisite for the later Spec-Kit commands to work properly at all.*

#### GitHub Copilot CLI (empfohlen / recommended)

Spec-Kit-Skills in `.agents/skills/` werden von der Copilot CLI automatisch erkannt — keine weitere Einrichtung nötig.

*Spec-Kit skills in `.agents/skills/` are automatically discovered by the Copilot CLI — no further setup needed.*

Copilot CLI ist ein eigenstaendiges Kommando und keine Erweiterung der GitHub CLI.
Es passt weiterhin zu einem GitHub-zentrierten Workflow mit Repositories, Issues
und Terminal-Aufrufen. Fuer Spec Kit ist besonders wichtig, dass vorhandene
Skills in `.agents/skills/` direkt gefunden werden koennen.

*Copilot CLI is a standalone command, not a GitHub CLI extension. It still fits
a GitHub-centred workflow with repositories, issues, and terminal commands. For
Spec Kit, the key point is that existing skills in `.agents/skills/` can be
discovered directly.*

> **Voraussetzung / Prerequisite:** GitHub-Konto mit Copilot-Berechtigung sowie
> Node.js/npm oder die plattformspezifische Paketmanager-Installation.

```bash
# Alle Plattformen: gemeinsamer npm-Fallback / all platforms: common npm fallback
npm install -g @github/copilot
copilot --version
copilot
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

#### Google Antigravity / Google Antigravity

Google Antigravity ersetzt in der Required-Toolchain die veraltete Homebrew-
Formel Gemini CLI. Auf macOS installiert die Wartung `antigravity-cli`; das
Kommando lautet `agy`. Windows nutzt das WinGet-Paket
`Google.AntigravityCLI`. Linux nutzt den offiziellen Installer nach einer
Prüfung seiner SHA-256-Prüfsumme gegen die zentrale CLI-Registry.

*Google Antigravity replaces the deprecated Gemini CLI Homebrew formula in the
required toolchain. On macOS, maintenance installs `antigravity-cli` and the
command is `agy`. Windows uses WinGet package `Google.AntigravityCLI`.
Linux uses the official installer after its SHA-256 digest has been verified
against the central CLI registry.*

| Plattform / Platform | Installation / Installation |
|---|---|
| macOS | `brew install --cask antigravity-cli` |
| Linux | `bash scripts/maintain-agentic-brew-apps.sh` (verifizierter Vendor-Installer / verified vendor installer) |
| Windows | `winget install --id Google.AntigravityCLI --exact` |

```bash
# macOS
brew install --cask antigravity-cli
agy --version
```

Die vorhandene `GEMINI.md` bleibt als von Antigravity unterstützte
Projekt-Kontextdatei erhalten. Die frühere `.gemini/commands/`-Integration
wird entfernt; Spec Kit verwendet für Antigravity `.agents/skills/`.

*The existing `GEMINI.md` remains as a project context file supported by
Antigravity. The former `.gemini/commands/` integration is removed; Spec Kit
uses `.agents/skills/` for Antigravity.*

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
specify init --here --force --integration agy
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

Die Update-Skripte pruefen nicht selbst, ob `specify` die neueste Spec-Kit-
Version ist. Aktualisiere `specify` deshalb bewusst vorher manuell und fuehre
danach erst den Trockenlauf und den Repo-Rollout aus.

*The update scripts do not check whether `specify` is the latest Spec-Kit
version. Update `specify` manually first, then run the dry-run and repository
rollout.*

```bash
# 1. specify manuell aktualisieren / manually update specify
uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git

# 2. Repos pruefen und aktualisieren / preview and update repositories
bash scripts/update-spec-kit.sh --dry-run
bash scripts/update-spec-kit.sh --commit --push
```

```powershell
# 1. specify manuell aktualisieren / manually update specify
uv tool install specify-cli --force --from git+https://github.com/github/spec-kit.git

# 2. Repos pruefen und aktualisieren / preview and update repositories
pwsh scripts/update-spec-kit.ps1 -WhatIf
pwsh scripts/update-spec-kit.ps1 -Commit -Push
```

Die Skripte erkennen Repos dynamisch ueber `.git` plus `.specify/`, sichern
`.specify/memory/constitution.md`, legen die lokalen Governance-Templates wieder
auf und tracken fuer OpenCode nur `.opencode/command/*.md`. Die kanonische
Template-Quelle ist standardmaessig das `home-baseline`-Repo, aus dem das
Skript ausgefuehrt wird; externe Nutzer brauchen deshalb kein privates
`TuiVision`-Repository. Eine andere Referenz kann bei Bedarf explizit mit
`--template-source PATH` bzw. `-TemplateSource PATH` gesetzt werden.

*The scripts dynamically discover repositories via `.git` plus `.specify/`,
preserve `.specify/memory/constitution.md`, reapply the local governance
templates, and track only `.opencode/command/*.md` for OpenCode. By default,
the canonical template source is the `home-baseline` repository that runs the
script, so external users do not need the private `TuiVision` repository. A
different reference can be selected explicitly with `--template-source PATH` or
`-TemplateSource PATH`.*

---

### Governance-Presets einbinden / Install governance presets

Nach `specify init` kannst du Spec-Kit-Presets installieren. Presets erweitern
die Standard-Templates von Spec-Kit, ohne das Projekt komplett zu ersetzen. Sie
liefern zusätzliche Governance-Regeln, Addenda und Template-Bausteine für
Sicherheit, Architektur, Barrierefreiheit, Agenten-Parität und
plattformübergreifende Arbeit.

*After `specify init`, you can install Spec-Kit presets. Presets extend the
standard Spec-Kit templates without replacing the whole project. They provide
additional governance rules, addenda, and template building blocks for security,
architecture, accessibility, agent parity, and cross-platform work.*

Die versionierten
[Erkenntnisse fuer Preset-Entwicklung und Flottenbetrieb](docs/maintenance/Preset-and-Fleet-Operations-Lessons-Learned.md)
beschreiben den gemeinsamen Betriebsvertrag fuer State, Autoritaet,
Unterbrechung, Evidence, Konvergenz, Promotion und Kampagnenabschluss. Neue
Preset-Regeln brauchen weiterhin reproduzierbare Feld-Evidence.

*The versioned
[preset and fleet operations lessons](docs/maintenance/Preset-and-Fleet-Operations-Lessons-Learned.md)
define the shared operating contract for state, authority, interruption,
evidence, convergence, promotion, and campaign closeout. New preset rules still
require reproducible field evidence.*

Die offizielle Spec-Kit-Dokumentation zu Presets steht hier:

*The official Spec-Kit preset documentation is available here:*

- [Spec-Kit Presets Reference](https://github.github.com/spec-kit/reference/presets.html)
- [Community Presets Table](https://github.com/github/spec-kit/blob/main/docs/community/presets.md)
- [Community Presets Catalog JSON](https://github.com/github/spec-kit/blob/main/presets/catalog.community.json)

Community-Preset-Updates fuer `github/spec-kit` werden nach dem
[Maintainer-Hinweis zu Issue #3679](https://github.com/github/spec-kit/issues/3679#issuecomment-5060400721)
strikt einzeln eingereicht und aktiviert: erst den erzeugten PR pruefen und
mergen lassen sowie das Issue abschliessen, dann das naechste Issue einreichen.
Bei einer bereits vorhandenen Warteschlange wird nur der naechste Kandidat fuer
`preset-submission` benannt. Neue Batch-Einreichungen und parallele
Label-Anfragen sind zu vermeiden.

*Community preset updates for `github/spec-kit` are submitted and activated
strictly one at a time: wait until the generated PR has been reviewed and
merged and its issue is complete before filing the next issue. If a queue
already exists, name only the next candidate for `preset-submission`. Avoid new
batch submissions and parallel label requests.*

Die ursprünglichen sechs Governance-Presets sind seit 2026-05-04 im Spec-Kit
Community-Katalog enthalten; `autonomous-run-governance` v0.2.2 wurde dort am
2026-07-17 verifiziert. Die aktuellen eigenstaendigen Releases sind
`autonomous-run-governance` v0.3.3 und
`parallel-autonomous-run-governance` v0.2.4. Das optionale
`intake-authoring-governance` v0.2.1 ist nach
[Issue #3720](https://github.com/github/spec-kit/issues/3720) und
[Katalog-PR #3721](https://github.com/github/spec-kit/pull/3721) ebenfalls im
Community-Katalog enthalten. Das optionale
`intake-review-governance` v0.1.2 wird separat mit Prioritaet `65` angeboten;
Preset 8 wurde mit
`github/spec-kit#3591` fuer den Community-Katalog eingereicht. Die direkte
Installation über
versionierte ZIP-URLs bleibt die bevorzugte Variante, wenn ein Projekt einen
exakt reproduzierbaren Preset-Stand pinnen soll.

*The original six governance presets have been in the Spec-Kit community
catalog since 2026-05-04; `autonomous-run-governance` v0.2.2 was verified there
on 2026-07-17. The current standalone releases are
`autonomous-run-governance` v0.3.3 and
`parallel-autonomous-run-governance` v0.2.4. Optional
`intake-authoring-governance` v0.2.1 is also available from the community
catalog after
[issue #3720](https://github.com/github/spec-kit/issues/3720) and
[catalog PR #3721](https://github.com/github/spec-kit/pull/3721). Optional
`intake-review-governance` v0.1.2 is offered separately at priority `65`;
Preset 8 was submitted to the
community catalog as `github/spec-kit#3591`. Direct
installation via versioned ZIP URLs is still the preferred variant when a
project should pin one exactly reproducible preset state.*

#### Welche Presets gibt es? / Which presets exist?

Die folgende kompakte Übersicht ist die nutzerseitige Spiegelung der
konstitutionellen Preset-Matrix. Bei jeder neuen Preset-Version oder
Prioritätsänderung müssen diese Tabelle, die Installationsbefehle und die
zugehörigen Guidance-/Template-Stellen gemeinsam aktualisiert werden.

*The following compact overview mirrors the constitutional preset matrix for
users. Whenever a preset version or priority changes, this table, the
installation commands, and the related guidance/template locations must be
updated together.*

| Preset-ID | Name | Version | Priorität / Priority |
|---|---|---:|---:|
| `security-governance` | Security Governance | `v0.6.1` | `10` |
| `architecture-governance` | Architecture Governance | `v0.5.1` | `20` |
| `isaqb-architecture-governance` | iSAQB Architecture Governance | `v0.2.1` | `30` |
| `a11y-governance` | A11Y Governance | `v0.4.2` | `40` |
| `cross-platform-governance` | Cross-Platform Governance | `v0.2.1` | `50` |
| `agent-parity-governance` | Agent Parity Governance | `v0.4.1` | `60` |
| `autonomous-run-governance` | Autonomous Run Governance | `v0.3.3` | `70` |
| `parallel-autonomous-run-governance` | Parallel Autonomous Run Governance | `v0.2.4` | `80` |

Hinweis: Alle acht Presets erzeugen bzw. verlangen audit-ready Spec-Kit-Run-Evidenz mit `Applicable` / `N/A` / `Open`, Begründung, Evidenzpfad, Reviewer, Restrisiko und Follow-up.

*Note: All eight presets generate or require audit-ready Spec-Kit run evidence with `Applicable` / `N/A` / `Open`, rationale, evidence path, reviewer, residual risk, and follow-up.*

`intake-authoring-governance` v0.2.1 ist ein optionales Preset mit Prioritaet
`64`. Es trennt die Befehle Create, Read, Update und Delete. Create schreibt
nur neue Ziele. Update benoetigt aktuelle ausdrueckliche Autoritaet, behaelt die
stabile Intake-Identitaet und archiviert den Vorgaenger. Delete ist logisch:
Ziel und Receipt werden hashgebunden archiviert und ein Tombstone bleibt
erhalten. Read ist standardmaessig eine kurze, read-only Summary; Detailed und
JSON sind ausdruecklich waehlbar.

Schema 2.0 ergaenzt oeffentliche, statische HTTPS-Quellen mit
SSRF-Schutz, Antwort- und Redirect-Grenzen sowie Snapshot-Evidence. Ein
begrenzter Same-Origin-Crawl und mehrere Intakes werden erst nach einem
vollstaendigen Vorschlag und ausdruecklicher Freigabe ausgefuehrt. Die
Publikation ist transaktional; ein Teilstand darf nicht als Erfolg gelten.
Schema 1.0 und 1.1 bleiben fuer bestehende Receipts lesbar. Kein
Authoring-Befehl startet Review, Specify oder einen autonomen Lauf.

`intake-review-governance` v0.1.2 bleibt als getrenntes optionales Preset mit
Prioritaet `65` bestehen. Es prueft einzelne Intakes, Reihen und Kampagnen vor
Feature-Erstellung. Review und Status sind read-only. Repair braucht
ausdrueckliche Aenderungsautoritaet. `ReadyForReview` aus Intake Authoring ist
keine Review-Freigabe.

Reihen verwenden ab v0.1.2 einen hashgebundenen Request-/Result-Vertrag nach
Schema 1.1. Zielrollen, exakte Reihenfolge, Roots, Kanten und Zyklen werden
gemeinsam geprüft; nicht eindeutig belegbare Vorgängerbeziehungen führen zu
`NeedsClarification`.

Thorstens registrierte Level-0-/Level-1-/Level-2-Flotte waehlt alle drei
optionalen Intake-Presets ueber
`intake-sequencing-eleven-governance-presets`. Die bisherigen Neun- und
Zehn-Preset-Profile bleiben kompatibel verfuegbar. Keine dieser lokalen
Profilwahlen aendert die oeffentliche Standard-Achtermatrix.

`intake-sequencing-governance` v0.1.1 ist eine dritte optionale
Intake-Schicht mit Prioritaet `66`. Das getrennte
`intake-sequencing-eleven-governance-presets`-Profil verwaltet Reihenfolge,
typisierte Abhaengigkeiten, Lifecycle und naechste Kandidaten. Es aendert keine
Intake-Inhalte und startet keinen nachgelagerten Spec-Kit-Befehl.

*`intake-authoring-governance` v0.2.1 is an optional preset at priority `64`.
It provides separate Create, read-only Read, explicitly authorized Update, and
archive-and-tombstone Delete commands. Schema 2.0 adds bounded public HTTPS
snapshot evidence and explicitly approved, transactional intake series while
schemas 1.0 and 1.1 remain readable. No authoring command starts downstream
review or execution. `intake-review-governance` v0.1.2 remains a separate optional preset
at priority `65`; authoring evidence is not review acceptance. Thorsten's
managed fleet selects both through the explicit ten-preset profile, while the
public standard eight remain unchanged. Series mode uses schema 1.1 and binds
the normalized request hash while validating target roles, exact order, roots,
edges, and acyclicity; ambiguous predecessors result in
`NeedsClarification`.*

`autonomous-run-governance` v0.3.3 mit Priorität `70` ist Teil der
Standard-Achtermatrix. Es ergänzt
`speckit.autonomous`, `speckit.autonomous-status`,
`speckit.autonomous-stop`, `speckit.autonomous-resume` und
`speckit.autonomous-retrospective`. Ergänzt werden konvergente
Clarify-/Checklist-/Analyze-Gates, Evidence-first, validierte Lauf-Checkpoints
und ein berechtigungsgebundener Remote-Closeout. Beim Resume gleicht es neue
zwingende Korrektheits-, Sicherheits-, Berechtigungs- und Evidenzregeln minimal
mit akzeptierten Plan-/Task-/Checklist-Artefakten ab. Vollständige autonome
Läufe bleiben ausdrücklich delegationspflichtig. `LocalImplementation` bleibt
der sichere Default; die Installation erteilt keine Remote-, Merge-, Bypass-
oder Provider-Rechte. Die
optionale Intake-Pruefung ist ohne installiertes Preset 9 oder aktive Policy
`N/A`; bei Aktivierung wird ihr Ergebnis als akzeptiertes Artefakt gebunden.
lesbare Skill-Überschrift `Deliver` ist kein Run-State-Wert; für Remote-Closeout
gelten `Publish`, `Review` oder `MergeAndSync`. Der bisherige Pfad
[`scripts/config/spec-kit-autonomous-governance-presets.json`](scripts/config/spec-kit-autonomous-governance-presets.json)
bleibt vorübergehend als deprecated Kompatibilitätsalias erhalten.
Das Registrierungsprofil `standard-eight-governance-presets` ist der aktuelle
Name. Die früheren Profilnamen `standard-six-governance-presets` und
`standard-seven-governance-presets` werden beim erneuten Registrieren als
Kompatibilitätsaliase auf dieselbe aktuelle Achtermatrix migriert.

*`autonomous-run-governance` v0.3.3 at priority `70` is part of the standard
eight-preset matrix. It adds
`speckit.autonomous`, `speckit.autonomous-status`,
`speckit.autonomous-stop`, `speckit.autonomous-resume`, and
`speckit.autonomous-retrospective`. It adds convergence-based
Clarify/checklist/Analyze gates, evidence-first execution, validated run
checkpoints, and a permission-bounded remote closeout. On resume, it minimally
reconciles new mandatory correctness, security, permission, and evidence rules
with accepted Plan, Tasks, and checklist artifacts. Complete autonomous runs
still require explicit delegation. `LocalImplementation` remains the safe default; installation
grants no remote, merge, bypass, or provider rights. The readable generated
skill heading `Deliver` is not a run-state value; remote closeout uses
`Publish`, `Review`, or `MergeAndSync`. The former
[`scripts/config/spec-kit-autonomous-governance-presets.json`](scripts/config/spec-kit-autonomous-governance-presets.json)
path remains temporarily as a deprecated compatibility alias.*
*The current registry profile is `standard-eight-governance-presets`. On
re-registration, the former profile names `standard-six-governance-presets`
and `standard-seven-governance-presets` are compatibility aliases migrated to
the same current eight-preset matrix.*

`parallel-autonomous-run-governance` v0.2.4 mit Prioritaet `80` koordiniert
ausdruecklich delegierte Kampagnen mit getrennten Worktrees und maximal drei
gleichzeitig aktiven Workern. Schema `1.2` ergaenzt ein optionales
`intakeReview`-Gate; Schema `1.1` liefert weiterhin `runnerProfile` je Worker,
agentenneutrale optionale Modell-/Reasoning-Metadaten, barrierearme Text- und
JSON-Statusausgabe, Stop/Resume waehrend Konsolidierung, exakte
Head-/Review-/Check-Preflights, fortsetzbare Teilmerges und deklarierte
Post-Merge-Aktionen. Reale Kampagnen setzen in jedem Worker-Repository ein
installiertes und aktiviertes `autonomous-run-governance >=0.2.2` voraus:
Preset 7 mit Prioritaet `70` liefert den Worker-Lebenszyklus, Preset 8 mit
Prioritaet `80` die Kampagnenkoordination. Ein fehlendes, deaktiviertes oder zu
altes Preset 7 beendet den Preflight vor dem Worker-Start. Installation allein
startet keine Kampagne und erteilt keine zusaetzlichen Rechte. Das ausfuehrliche
[Preset-8-Handbuch](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/tree/v0.2.4/docs)
erklaert Topologien, Scheduling, Konsolidierung und Recovery.

*`parallel-autonomous-run-governance` v0.2.4 at priority `80` coordinates
explicitly delegated campaigns with separate worktrees and at most three
active workers. Schema `1.2` adds an optional `intakeReview` gate; schema
`1.1` continues to provide per-worker `runnerProfile`, optional
agent-neutral model/reasoning metadata, accessible text and JSON status,
stop/resume during consolidation, exact-head/review/check preflights, resumable
partial merges, and declared post-merge actions. Real campaigns require
installed and enabled `autonomous-run-governance >=0.2.2` in every worker
repository: Preset 7 at priority `70` provides the worker lifecycle, while
Preset 8 at priority `80` provides campaign coordination. A missing, disabled,
or outdated Preset 7 fails preflight before any worker starts. Installation
alone starts no campaign and grants no additional authority. The detailed
[Preset 8 manual](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/tree/v0.2.4/docs)
explains topologies, scheduling, consolidation, and recovery.*

| Preset | Zweck / Purpose | Empfehlung / Recommendation |
|---|---|---|
| `security-governance` | Sichere Entwicklung, NIST SSDF, CWE Top 25, ASVS, SBOM/AI-SBOM/VEX/SLSA, CAPEC, OpenSSF Scorecard, Regulatory Applicability (NIS2/CRA/EU AI Act/DORA). / Secure development, NIST SSDF, CWE Top 25, ASVS, SBOM/AI-SBOM/VEX/SLSA, CAPEC, OpenSSF Scorecard, regulatory applicability (NIS2/CRA/EU AI Act/DORA). | Für alle produktionsnahen Projekte installieren. / Install for all production-like projects. |
| `architecture-governance` | Sichere Architektur, Threat Modeling, Zero Trust, BSI C3A Cloud-Autonomie, BSI C5 Cloud-Compliance-Assurance, OWASP SAMM, Security-ADRs. / Secure architecture, threat modeling, Zero Trust, BSI C3A cloud autonomy, BSI C5 cloud compliance assurance, OWASP SAMM, security ADRs. | Für Projekte mit Services, Datenflüssen, Schnittstellen, Cloud-Abhängigkeiten oder Sicherheitsrisiken installieren. / Install for projects with services, data flows, interfaces, cloud dependencies, or security risks. |
| `isaqb-architecture-governance` | Allgemeine Softwarearchitektur nach iSAQB/arc42: Sichten, Qualitätsszenarien, Entscheidungen, Risiken. / General software architecture based on iSAQB/arc42: views, quality scenarios, decisions, risks. | Für Projekte installieren, bei denen Architekturarbeit dauerhaft nachvollziehbar sein soll. / Install when architectural work should stay traceable over time. |
| `a11y-governance` | Barrierefreiheit nach WCAG 2.2 Level AA für UI, HTML, CLI, Doku, Templates und didaktische Inline-Code-Kommentare. / Accessibility based on WCAG 2.2 Level AA for UI, HTML, CLI, docs, templates, and didactic inline-code comments. | Für alle nutzerseitigen Artefakte und Lern-/Referenzprojekte installieren. / Install for all user-facing artefacts and learning/reference projects. |
| `cross-platform-governance` | macOS/Linux/Windows-Parität, Shell-Auswahl, Pfadregeln, Testhinweise. / macOS/Linux/Windows parity, shell choice, path rules, test guidance. | Für Skripte, CLIs, Tooling und Workspace-Infrastruktur installieren. / Install for scripts, CLIs, tooling, and workspace infrastructure. |
| `agent-parity-governance` | Gemeinsame Pflege von Agent-Guidance plus agentenneutrales Spec-Kit-Modell-Routing. / Joint maintenance of agent guidance plus agent-neutral Spec-Kit model routing. | Für Repos mit mehreren KI-Agenten-Oberflächen installieren. / Install for repos with multiple AI-agent surfaces. |
| `intake-authoring-governance` | Erzeugt aus Prompt, eingefuegter Planung und geordneten UTF-8-Dateien einen nachvollziehbaren Intake mit sicheren Specify-/Autonomous-Prompts. / Creates one traceable intake with safe Specify and Autonomous prompts from raw planning sources. | Optional installieren, wenn Rohplanung vor Review oder Specify strukturiert und gespeichert werden soll. / Install optionally when raw planning should be structured and stored before review or Specify. |
| `intake-review-governance` | Hashgebundener Review einzelner Intakes, Reihen und Kampagnen vor Specify oder Worker-Start. / Hash-bound review of single intakes, series, and campaigns before Specify or worker scheduling. | Optional installieren, wenn Intake-Qualitaet ein verbindliches Gate sein soll. / Install optionally when intake quality must be a binding gate. |
| `autonomous-run-governance` | Berechtigungsgebundene, evidenzbasierte Steuerung ausdrücklich delegierter autonomer Spec-Kit-Läufe. / Permission-bounded, evidence-first control for explicitly delegated autonomous Spec Kit runs. | Standardmäßig installieren; einen Lauf nur nach ausdrücklicher Delegation starten. / Install by default; start a run only after explicit delegation. |
| `parallel-autonomous-run-governance` | Isolierte, begrenzte Multi-Worker-Kampagnen mit fortsetzbarer Konsolidierung und Closeout. / Isolated bounded multi-worker campaigns with resumable consolidation and closeout. | Standardmäßig installieren; parallele Kampagnen nur nach ausdrücklicher Delegation starten. / Install by default; start parallel campaigns only after explicit delegation. |

Das registrierte Standardprofil dieser Workspace-Familie umfasst auf Level 0,
Level 1 und Level 2 alle acht Presets. Eine Teilmenge bleibt nur als bewusst
dokumentierte Projektausnahme zulässig. Für externe, nicht registrierte kleine
Lern- oder Experimentierprojekte kann diese Startkombination sinnvoll sein:

*The registered standard profile for this workspace family includes all eight
presets at level 0, level 1, and level 2. A subset is allowed only as a
deliberately documented project exception. For external, unregistered small
learning or experimental projects, this starting combination can be useful:*

- `security-governance`
- `architecture-governance`
- `a11y-governance`

Für C#/.NET-Level-2-Projekte ist die Standardentscheidung in dieser
Workspace-Familie: alle acht Presets installieren, sofern das Projekt keine
begründete Ausnahme dokumentiert. Die Referenz-Rollouts sind `TinyPl0`,
`TinyCalc`, `TuiVision` und `InventarWorkerService`.

*For C#/.NET Level-2 projects, the default decision in this workspace family is
to install all eight presets unless the project documents a justified exception.
The reference rollouts are `TinyPl0`, `TinyCalc`, `TuiVision`, and
`InventarWorkerService`.*

Wenn das Projekt zusätzlich allgemeine Architekturarbeit nach iSAQB/arc42
dokumentieren soll, kommt `isaqb-architecture-governance` dazu. Wenn Skripte
oder CLI-Artefakte auf mehreren Betriebssystemen laufen müssen, kommt
`cross-platform-governance` dazu. Wenn mehrere Agenten-Dateien parallel gepflegt
werden, kommt `agent-parity-governance` dazu.

*If the project should also document general architecture work using iSAQB/arc42,
add `isaqb-architecture-governance`. If scripts or CLI artefacts must work across
multiple operating systems, add `cross-platform-governance`. If multiple agent
instruction files are maintained in parallel, add `agent-parity-governance`.*

#### Installation pro Projekt / Per-project installation

Die empfohlene Installation nutzt die zentrale Matrix
[`scripts/config/spec-kit-governance-presets.json`](scripts/config/spec-kit-governance-presets.json).
Führe den Installer im jeweiligen Projekt-Repository aus, also dort, wo bereits
`.specify/` liegt. Die Installation ist bewusst projektlokal: Ein Projekt kann
andere Presets oder Prioritäten haben als ein anderes Projekt. Neue
Preset-Versionen werden nicht im Installer-Code gepflegt, sondern durch ein
Update der Matrix.

*The recommended installation uses the central matrix
[`scripts/config/spec-kit-governance-presets.json`](scripts/config/spec-kit-governance-presets.json).
Run the installer inside the target project repository, where `.specify/`
already exists. Installation is intentionally project-local: one project may use
different presets or priorities than another project. New preset versions are
maintained in the matrix, not in installer code.*

```bash
cd ~/Pfad/zu/deinem/Projekt

# Falls noch nicht geschehen / if not done yet:
specify init --here --force --integration codex

# Governance-Presets aus der zentralen Matrix installieren
bash ~/scripts/install-spec-kit-governance-presets.sh --repo .
```

```powershell
pwsh ~/scripts/install-spec-kit-governance-presets.ps1 -Repo .
```

Fuer das explizite neunte Intake-Review-Preset dieselben Installer mit
`scripts/config/spec-kit-intake-review-governance-presets.json` aufrufen. Fuer
Authoring plus Review gilt das getrennte Zehnerprofil
`scripts/config/spec-kit-intake-authoring-governance-presets.json`. Beide
Auswahlen verwenden `--preset-config` beziehungsweise `-PresetConfig`; ohne
Auswahl bleibt die Standard-Achtermatrix unveraendert.

Die lokale Registry kann `defaultPresetProfile` setzen. Der Wartungslauf prueft
dann jedes registrierte Repository gegen die zugeordnete exakte Matrix. Das
Profil `intake-review-nine-governance-presets` verweist auf die oben genannte
Neunermatrix. `intake-authoring-ten-governance-presets` verweist auf die
Zehnermatrix mit Authoring `64` und Review `65`; unbekannte Profile brechen
fail-closed ab.

*To select optional Intake Review only, use
`scripts/config/spec-kit-intake-review-governance-presets.json`. To select
Intake Authoring plus Review, use
`scripts/config/spec-kit-intake-authoring-governance-presets.json`. Pass either
through `--preset-config` or `-PresetConfig`; the standard eight remain
unchanged without an explicit selection.*

*A local registry may set `defaultPresetProfile`. Workspace maintenance then
checks every registered repository against its assigned exact matrix. Unknown
profiles fail closed.*

Wenn eine neue Preset-Version freigegeben wird, zuerst die Matrix aktualisieren.
Neue registrierte Level-0-, Level-1- und Level-2-Repositories nutzen danach
automatisch die neuere Version. Bestehende Repositories werden bewusst
aktualisiert:

*When a new preset version is released, update the matrix first. New registered
level-0, level-1, and level-2 repositories then use the newer version
automatically. Existing repositories are updated deliberately:*

```bash
bash ~/scripts/install-spec-kit-governance-presets.sh --repo . --force
```

`architecture-governance` v0.5.1 ergaenzt `BSI C3A` (Criteria enabling Cloud
Computing Autonomy) als bedingte Cloud-Autonomie-Pruefung und `BSI C5` als
bedingte Cloud-Compliance-Assurance-Pruefung. Bei Cloud-Service-Auswahl,
Cloud-Betrieb, SaaS/PaaS/IaaS, Managed Services, Container-/Artefakt-Hosting
oder providerabhaengigen Deployments werden `docs/security/cloud-autonomy-applicability.md`
und `docs/security/cloud-compliance-assurance.md` oder gleichwertige
Evidenzpfade gepflegt. Reine Entwicklungsinfrastruktur ohne ausgelieferte oder
betriebene Cloud-Runtime kann mit kurzer Toolchain-Begruendung `N/A` sein.

`security-governance` v0.6.1 behandelt `AI-SBOM` bewusst bedingt, ergaenzt
sprachspezifische Secure-Coding-Profile und fuehrt eine regulatorische
Anwendbarkeitsmatrix fuer `NIS2`, `CRA`, `EU AI Act` und `DORA` ein. Wenn KI
nur als Entwicklungswerkzeug genutzt wird, ist `AI-SBOM` mit kurzer
Toolchain-Begruendung `N/A`. Wenn KI-Modelle, KI-Dienste, Datensaetze,
Inferenz-Infrastruktur oder KI-Runtime-Komponenten Teil des ausgelieferten oder
betriebenen Systems sind, wird die Supply-Chain-Evidenz um die G7/BSI
AI-SBOM-Cluster erweitert. Private Ausbildungsprojekte dokumentieren
regulatorische Nichtanwendbarkeit mit kurzer Begruendung, wenn kein regulierter
Scope vorliegt.
`a11y-governance` v0.4.2 ergaenzt didaktische Inline-Code-Kommentar-Governance:
nicht-triviale neue oder geaenderte Logik wird auf Kommentarbedarf geprueft,
wenn Lernverstaendnis oder Wartbarkeit betroffen sind.

*`architecture-governance` v0.5.1 adds `BSI C3A` (Criteria enabling Cloud
Computing Autonomy) as a conditional cloud-autonomy check and `BSI C5` as a
conditional cloud-compliance assurance check. Cloud-service selection, cloud
operation, SaaS/PaaS/IaaS, managed services, container/artifact hosting, or
provider-dependent deployments maintain `docs/security/cloud-autonomy-applicability.md`
and `docs/security/cloud-compliance-assurance.md` or equivalent evidence
paths. Pure development infrastructure without a released or operated cloud
runtime can be `N/A` with a short toolchain rationale.*

*`security-governance` v0.6.1 treats `AI-SBOM` as conditional, adds
language-specific secure-coding profiles, and introduces regulatory
applicability screening for `NIS2`, `CRA`, `EU AI Act`, and `DORA`. When AI is
used only as development tooling, `AI-SBOM` is `N/A` with a short toolchain
rationale. When AI models, AI services, datasets, inference infrastructure, or
AI runtime components are part of the released or operated system, supply-chain
evidence is extended with the G7/BSI AI-SBOM clusters. Private training
projects record regulatory `N/A` with a short rationale when no regulated
scope exists. `a11y-governance` v0.4.2 adds didactic inline-code-comment
governance: new or changed non-trivial logic is reviewed for comment need when
learning comprehension or maintainability is affected.*

#### Preset-Prioritäten verstehen / Understanding preset priorities

Die Priorität steuert, welches aktivierte Preset bei gleichnamigen Templates,
Befehlen oder Addenda zuerst berücksichtigt wird. Bei Spec Kit gilt:
**kleinere Zahl = höhere Priorität**. Projektlokale Overrides stehen weiterhin
vor installierten Presets.

Die Priorität wirkt zusammen mit der Kompositionsstrategie. Bei `replace`
gewinnt der höchst priorisierte Inhalt vollständig. `prepend`, `append` und
`wrap` kombinieren dagegen geordnete Schichten. Gleiche Prioritätszahlen werden
deterministisch nach Preset-ID aufgelöst, sollten für eine verständliche
Projekt-Policy aber vermieden werden.

Die Zahl startet keinen Befehl, installiert oder aktiviert kein Preset und
erteilt keine Commit-, Push-, PR-, Merge- oder Bypass-Rechte. Die Folge
`64 → 65 → 66 → 70 → 80` beschreibt die Schichtung von Intake Authoring,
Intake Review, Intake Sequencing, autonomem Einzel-Lauf und paralleler
Koordination. Sie ist keine
automatische Befehlskette.

Gemeinsam können diese fünf Presets eine hashgebundene Qualitätskette bilden:
Authoring erzeugt Intake und Receipt mit `ReadyForReview`; Review entscheidet
unabhängig über `Ready`, menschlich akzeptiertes `ReadyWithAcceptedRisks` oder
einen blockierenden Zustand. Sequencing verwaltet danach Reihenfolge, bindende
Vorgaenger und startfaehige Kandidaten, ohne Arbeit zu starten. Preset 7 kann das aktuelle Review vor Branch,
Feature und Specify als Start-Gate verlangen. Preset 8 prüft bei einer
Kampagne zusätzlich jeden eindeutigen Intake, die Worker-Zuordnung und den DAG,
bevor Worktrees entstehen. Preset 8 koordiniert die Kampagne, während Preset 7
weiterhin jeden Worker-Lebenszyklus steuert.

Die ausführliche Anleitung
[Spec-Kit-Preset-Prioritäten verstehen](docs/maintenance/Spec-Kit-Preset-Priorities.md)
erklärt die Strategien, die vollständige Matrix, den Artefakt- und
Gate-Fluss, praktische Beispiele, Fehlannahmen und die sichere Änderung einer
Priorität.

*Priority controls which enabled preset is considered first when templates,
commands, or addenda overlap. In Spec Kit, a lower number means higher
precedence; project-local overrides still come first. `replace` selects the
highest-precedence content, while `prepend`, `append`, and `wrap` compose
ordered layers. Priority starts no command and grants no delivery authority.
Together, the five workflow presets can form a hash-bound quality chain:
Authoring prepares the intake, Review accepts or blocks it, Sequencing manages
order and candidates, Preset 7 governs one run, and Preset 8 coordinates
multiple Preset-7 workers. See the detailed
guide for artifact flow, gates, examples, diagnostics, and safe
reprioritisation.*

#### Installation prüfen / Verify installation

Nach der Installation prüfst du die registrierten Presets und die aufgelösten
Template-Bausteine:

*After installation, verify the registered presets and resolved template
building blocks:*

```bash
specify preset list
specify preset info security-governance
specify preset info a11y-governance
specify preset resolve constitution-template.md
specify preset resolve agent-guidance-addendum-template.md
```

Prüfe danach mit `git status`, welche `.specify/`- und Agenten-Dateien geändert
wurden. Wenn das Projekt dauerhaft mit diesen Presets arbeiten soll, committe
`.specify/presets/` und die erzeugten Agenten-/Command-Dateien zusammen mit den
daraus bewusst übernommenen Template- oder Dokumentationsänderungen.
`.specify/presets/.cache/` ist nur lokaler Katalog-Cache und wird nicht
committed.

*Then check with `git status` which `.specify/` and agent files changed. If the
project should keep using these presets, commit `.specify/presets/` and the
generated agent/command files together with the template or documentation changes
that you intentionally adopted. `.specify/presets/.cache/` is only local catalog
cache and is not committed.*

```bash
git status --short
git add .specify/presets .agents .claude .github .opencode
git commit -m "chore: configure spec-kit governance presets"
```

#### Community-Katalog oder direkte URL? / Community catalog or direct URL?

Für diese Workspace-Familie ist die zentrale Matrix der Standardweg. Sie nutzt
versionierte ZIP-URLs und hält Preset-ID, Version, Priorität und Quelle an einer
Stelle zusammen. Community-Katalog oder einzelne direkte URLs bleiben nützlich
für Diagnose, Smoke-Tests oder ein einzelnes Preset, ersetzen aber nicht die
Matrixpflege.

*For this workspace family, the central matrix is the standard path. It uses
versioned ZIP URLs and keeps preset ID, version, priority, and source together
in one place. The community catalog or individual direct URLs are still useful
for diagnostics, smoke tests, or one single preset, but they do not replace
matrix maintenance.*

```bash
# Standardweg / standard path
bash ~/scripts/install-spec-kit-governance-presets.sh --repo .

# Katalog durchsuchen / search catalog, if needed
specify preset search governance

# Einzelinstallation, falls vom lokalen specify unterstützt
# Single-preset install, if supported by the local specify version
specify preset add security-governance --priority 10

# Einzelner ZIP-Smoke-Test / single ZIP smoke test
specify preset add --from https://github.com/hindermath/spec-kit-preset-security-governance/archive/refs/tags/v0.6.1.zip --priority 10
```

#### Presets aktualisieren oder entfernen / Update or remove presets

Für ein Update wird zuerst `scripts/config/spec-kit-governance-presets.json`
aktualisiert. Danach werden bestehende Projekte bewusst mit `--force` /
`-Force` aus der Matrix nachgezogen und anschließend mit `specify preset list`,
`specify preset info <id>` und `specify preset resolve <template>` geprüft. Wenn
ein Preset für ein Projekt nicht passt, deaktiviere es zuerst statt es sofort zu
löschen. So bleibt die Entscheidung nachvollziehbar.
Bei jeder neuen Preset-Version müssen Matrix, kompakte Übersicht,
`constitution.md`, `.specify/memory/constitution.md`, die vier Agenten-Dateien
und die entsprechenden `scripts/templates/*`-Vorlagen gemeinsam geprüft und
aktualisiert werden.

*To update presets, update `scripts/config/spec-kit-governance-presets.json`
first. Existing projects are then deliberately refreshed from the matrix with
`--force` / `-Force` and verified with `specify preset list`, `specify preset
info <id>`, and `specify preset resolve <template>`. If a preset does not fit a
project, disable it first instead of deleting it immediately. This keeps the
decision traceable. For every new preset version, review and update the matrix,
compact overview, `constitution.md`, `.specify/memory/constitution.md`, the four
agent guidance files, and the matching `scripts/templates/*` templates together.*

```bash
# Aus der aktualisierten Matrix nachziehen / refresh from updated matrix
bash ~/scripts/install-spec-kit-governance-presets.sh --repo . --force

# Vorübergehend deaktivieren / temporarily disable
specify preset disable agent-parity-governance

# Wieder aktivieren / enable again
specify preset enable agent-parity-governance

# Entfernen, wenn dauerhaft nicht passend / remove if permanently not suitable
specify preset remove agent-parity-governance
```

#### Was danach im SDD-Workflow passiert / What changes in the SDD workflow

Die Presets ändern nicht den Grundablauf. Du nutzt weiterhin `speckit.specify`,
`speckit.plan`, `speckit.tasks`, `speckit.analyze` und `speckit.implement`.
Der Unterschied ist, dass die erzeugten oder geprüften Artefakte zusätzliche
Governance-Punkte berücksichtigen:

*The presets do not change the basic workflow. You still use `speckit.specify`,
`speckit.plan`, `speckit.tasks`, `speckit.analyze`, and `speckit.implement`.
The difference is that generated or reviewed artefacts include additional
governance points:*

- Sicherheitsstandards werden nicht stillschweigend ausgelassen, sondern als anwendbar oder `N/A` begründet. / Security standards are not silently omitted, but marked as applicable or justified as `N/A`.
- Architekturentscheidungen werden als ADRs oder gleichwertige Doku nachvollziehbar. / Architecture decisions become traceable as ADRs or equivalent documentation.
- Barrierefreiheit wird für UI, HTML, CLI, Dokumentation und Templates geprüft. / Accessibility is checked for UI, HTML, CLI, documentation, and templates.
- Plattformunterschiede werden früh im Plan berücksichtigt. / Platform differences are considered early in the plan.
- Gemeinsame Agenten-Regeln werden nicht nur in einer Datei aktualisiert. / Shared agent rules are not updated in one file only.

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
| PowerShell-String mit `$Path:` scheitert / PowerShell string with `$Path:` fails | In doppelt quotierten Strings kann PowerShell `:` als Teil einer Bereichsvariable interpretieren und meldet dann `Variable reference is not valid`. / In double-quoted strings, PowerShell can interpret `:` as part of scoped variable syntax and then reports `Variable reference is not valid`. | Variablen vor angrenzender Interpunktion mit Klammern abgrenzen, z. B. `${Path}:`, oder Formatstrings verwenden. / Delimit variables before adjacent punctuation, for example `${Path}:`, or use format strings. |
| `LICENSE` von `.gitignore` ignoriert / ignored by `.gitignore` | Bei einem Whitelist-Modell kann `LICENSE` unabsichtlich mit ausgefiltert werden, wenn die ausdrueckliche Ausnahme fehlt. Dann wirkt die Datei lokal vorhanden, wird aber nicht versioniert. / In a whitelist model, `LICENSE` can accidentally be filtered out if the explicit exception is missing. The file then appears locally present but is not actually versioned. | `!LICENSE` explizit in `.gitignore` aufnehmen, damit die Datei trotz uebergeordneter Ignore-Regeln immer wieder freigeschaltet wird. / Add `!LICENSE` explicitly to `.gitignore` so the file is always re-included despite broader ignore rules. |
| ANSI-Falsch-Positive im Scanner / ANSI false positives in scanner | Der Scanner enthaelt selbst Escape-Sequenzen wie `\\033[` als Literal. Ohne Ausnahme wuerde er also seine eigene Implementierung als problematischen ANSI-Inhalt markieren. / The scanner itself contains escape sequences such as `\\033[` as literals. Without an exception, it would flag its own implementation as problematic ANSI content. | `check-homogeneity.*` gezielt vom ANSI-Scan ausnehmen, damit nur gescannte Zieldateien und nicht die Scanner-Implementierung bewertet werden. / Exclude `check-homogeneity.*` specifically from the ANSI scan so that only scanned target files, not the scanner implementation itself, are evaluated. |
| Bootstrap hardcodierter Username / hard-coded username | Ein fest eingebauter Login wie `hindermath` funktioniert nur fuer genau eine Identitaet und macht das Template sofort unbrauchbar fuer andere Nutzer oder Accounts. / A built-in login such as `hindermath` works for exactly one identity and immediately makes the template unusable for other users or accounts. | Den GitHub-Login immer dynamisch ueber `gh api user --jq '.login'` abfragen und daraus Namen oder Remotes ableiten. / Always resolve the GitHub login dynamically via `gh api user --jq '.login'` and derive names or remotes from that value. |
| `gh auth login --web` bleibt haengen / hangs | In Hintergrund- oder Async-Prozessen kommt der Browser-Callback nicht sauber zum CLI-Prozess zurueck. Das Login wirkt dann eingefroren, obwohl der Browser schon geoefnet wurde. / In background or async processes, the browser callback does not return cleanly to the CLI process. The login then appears frozen even though the browser was already opened. | `gh auth login --web` nur in einem echten interaktiven Terminalfenster ausfuehren, nicht aus einem Hintergrundprozess oder Agenten-Subprozess heraus. / Run `gh auth login --web` only in a real interactive terminal window, not from a background process or agent subprocess. |
| `glab auth login` bleibt haengen / hangs | Gleiches Muster wie bei `gh`: die Web-Authentifizierung verlaesst sich auf einen Rueckkanal zum interaktiven Prozess, der im Hintergrund oft fehlt oder blockiert ist. / Same pattern as with `gh`: web authentication relies on a callback to the interactive process, which is often missing or blocked in background execution. | `glab auth login` ebenfalls nur interaktiv starten, damit Browser-Callback und Token-Speicherung sauber abgeschlossen werden koennen. / Start `glab auth login` interactively as well so browser callback handling and token storage can complete correctly. |
| `gh` keyring invalid (Windows) | Der Windows Credential Store oder der gespeicherte `gh`-Eintrag ist inkonsistent oder beschaedigt. Dann scheitert `gh` trotz eigentlich gueltigem Konto an der lokalen Secret-Ablage. / The Windows Credential Store or the saved `gh` entry is inconsistent or corrupted. In that case `gh` fails at the local secret store even though the account itself may still be valid. | Den gespeicherten Eintrag mit `gh auth logout` entfernen, danach `gh auth login` erneut ausfuehren und zum Schluss `gh auth setup-git` zur sauberen Git-Integration nachziehen. / Remove the stored entry with `gh auth logout`, then run `gh auth login` again, and finally run `gh auth setup-git` to restore clean git integration. |
| `ssh-agent` startet nicht / does not start (Windows) | Der OpenSSH-Agent-Dienst ist auf vielen Windows-Systemen standardmaessig deaktiviert und laesst sich oft nur mit Admin-Rechten aktivieren. / The OpenSSH agent service is disabled by default on many Windows systems and often requires admin rights to enable. | Fuer diesen Workflow lieber HTTPS plus `gh auth setup-git` verwenden, statt sich auf einen lokal aktivierten SSH-Agenten zu verlassen. / Prefer HTTPS plus `gh auth setup-git` for this workflow instead of relying on a locally enabled SSH agent. |
| `CursorPosition`-Fehler in PS-Subprozessen / `CursorPosition` error in PS subprocesses | Subprozesse laden ohne Schutz das normale PowerShell-Profil mit Oh-My-Posh oder anderer TUI-Logik. In nicht interaktiven Kontexten ist das Konsolen-Handle dann oft ungueltig. / Subprocesses load the normal PowerShell profile unless prevented, including Oh-My-Posh or other TUI logic. In non-interactive contexts the console handle is then often invalid. | `pwsh`-Subprozesse grundsaetzlich mit `-NoProfile` starten, wenn sie nur Skripte ausfuehren sollen und keine interaktive Shell brauchen. / Start `pwsh` subprocesses with `-NoProfile` by default when they only need to run scripts and do not require an interactive shell profile. |
| Parallele `migrate-workspace.*`-Laeufe laufen in Timeouts / parallel `migrate-workspace.*` runs time out | Jeder Migrationslauf startet `init-stats.*`, das die Level-0/1/2-Statistiken global aktualisiert. Mehrere parallele Laeufe koennen sich gegenseitig ausbremsen oder Dateien gleichzeitig anfassen. / Each migration starts `init-stats.*`, which updates level 0/1/2 statistics globally. Several parallel runs can slow each other down or touch the same files at the same time. | Erst Vorschau mit `-WhatIf`/`--dry-run`, dann echte Migrationen seriell pro Workspace ausfuehren und bei Bedarf laengere Timeouts verwenden. / First run a preview with `-WhatIf`/`--dry-run`, then execute real migrations serially per workspace and use longer timeouts when needed. |
| `sync-home` bricht beim Aktualisieren von `scripts/` ab / fails while updating `scripts/` | Ein Lauf aus `~/scripts/` kann sein eigenes Skript waehrend des Kopierens ueberschreiben. / A run started from `~/scripts/` can overwrite its own running script while copying. | `sync-home.*` delegiert an die Repo-Kopie in `~/home-baseline-source/scripts/`; bei Aenderungen immer `bash -n`, `--dry-run` und `-WhatIf` pruefen. / `sync-home.*` delegates to the repository copy in `~/home-baseline-source/scripts/`; after changes, always check `bash -n`, `--dry-run`, and `-WhatIf`. |
| `git pull` „divergent branches" (Linux) | Ohne globale Rebase-Strategie weiss Git bei bestimmten Abweichungen nicht, ob Merge oder Rebase der gewuenschte Standard sein soll, und stoppt mit Rueckfrage. / Without a global rebase strategy, Git may not know whether merge or rebase should be the default for certain branch divergences and stops with a prompt. | Einmalig `git config --global pull.rebase true` setzen, damit `git pull` fuer diesen Workflow konsistent auf Rebase ausgerichtet ist. / Set `git config --global pull.rebase true` once so `git pull` follows a consistent rebase-based workflow. |
| Push rejected: `fetch first` | Der Remote-Branch ist inzwischen weiter als der lokale Branch. Ein direkter Push wuerde fremde oder spaetere Commits ueberschreiben und wird deshalb abgelehnt. / The remote branch has moved ahead of the local branch. A direct push would overwrite foreign or later commits and is therefore rejected. | Erst mit `git pull --rebase --autostash` den Remote-Stand sauber einarbeiten und danach erneut `git push` ausfuehren. / First integrate the remote state cleanly with `git pull --rebase --autostash`, then run `git push` again. |
| Remote-`README.md` wird bei Migration ueberschrieben / Remote `README.md` overwritten during migration | Lokale Migrationscommits wurden auf einem aelteren Stand erstellt, waehrend `origin/main` eine neuere oder kanonische README enthaelt. / Local migration commits were created on an older state while `origin/main` contains a newer or canonical README. | Vor dem finalen Push `fetch`/Rebase ausfuehren und die README aus `origin/main` bewusst erhalten oder wiederherstellen, wenn sie kanonisch ist. / Before the final push, fetch/rebase and deliberately preserve or restore the README from `origin/main` when it is canonical. |
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
