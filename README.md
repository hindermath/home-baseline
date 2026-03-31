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
| `~/RiderProjects/` | [riderprojects-baseline](https://github.com/hindermath/riderprojects-baseline) | manuell |
| `~/DataGripProjects/` | [datagrip-baseline](https://github.com/hindermath/datagrip-baseline) | manuell |
| `~/C64Projects/` | [c64projects-baseline](https://github.com/hindermath/c64projects-baseline) | manuell |
| `~/DataspellProjects/` | – | `bootstrap-workspace` |
| `~/WebstormProjects/` | – | `bootstrap-workspace` |

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

### 4. Empfohlene PowerShell-Module *(optional, einmalig / optional, once)*

```powershell
Install-Module -Name posh-git            -Scope CurrentUser -Force  # Git-Prompt + Tab-Completion
Install-Module -Name PowerShellForGitHub -Scope CurrentUser -Force  # GitHub API Cmdlets
Install-Module -Name GitAutomation       -Scope CurrentUser -Force  # Git als Cmdlets
```

---



### macOS / Linux

```bash
# Vollständige Einrichtung in einem Schritt:
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Beispiele:
bash ~/scripts/bootstrap-workspace.sh WebstormProjects
bash ~/scripts/bootstrap-workspace.sh DataspellProjects dataspell-baseline "DataSpell Workspace"

# Vorher testen (kein Schreibzugriff):
bash ~/scripts/bootstrap-workspace.sh --dry-run WebstormProjects
```

### Windows (PowerShell Core >= 7)

```powershell
# Vollständige Einrichtung in einem Schritt:
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>

# Beispiele:
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName WebstormProjects
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName DataspellProjects -RepoName dataspell-baseline -Description "DataSpell Workspace"

# Vorher testen (kein Schreibzugriff):
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName WebstormProjects -WhatIf
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
git clone https://github.com/hindermath/home-baseline.git home-baseline-tmp
cp -r home-baseline-tmp/scripts ~/scripts
cp home-baseline-tmp/.gitignore ~/.gitignore
bash ~/scripts/install-hooks.sh
rm -rf home-baseline-tmp
```

### Windows (PowerShell Core >= 7)

```powershell
Set-Location ~
git clone https://github.com/hindermath/home-baseline.git home-baseline-tmp
Copy-Item home-baseline-tmp/scripts ~/scripts -Recurse -Force
Copy-Item home-baseline-tmp/.gitignore ~/ -Force
pwsh ~/scripts/install-hooks.ps1
Remove-Item home-baseline-tmp -Recurse -Force
```

---

## Inhalt / Contents

| Datei / File | Beschreibung / Description |
|---|---|
| `scripts/bootstrap-workspace.sh` | Neues Workspace einrichten (Bash) |
| `scripts/bootstrap-workspace.ps1` | Neues Workspace einrichten (PowerShell Core) |
| `scripts/scan-agent-secrets.sh` | Secret-Scan für git-getrackte Dateien (Bash) |
| `scripts/scan-agent-secrets.ps1` | Secret-Scan für git-getrackte Dateien (PowerShell Core) |
| `scripts/install-hooks.sh` | Git-Hooks installieren (Bash) |
| `scripts/install-hooks.ps1` | Git-Hooks installieren (PowerShell Core) |
| `scripts/hooks/pre-push` | Pre-Push Hook: blockiert Push bei Secrets |

---

## Plattform-Übersicht / Platform overview

| Plattform | Unterstützt | Voraussetzung |
|---|---|---|
| macOS | ✅ nativ | – |
| Linux | ✅ nativ | – |
| Windows | ✅ PowerShell Core | Git for Windows + pwsh >= 7 |
