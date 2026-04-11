# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Beschreibung / Description

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur. Diese Datei enthält Anweisungen für den Claude Code Agenten.

*This repository is the **top-level** private workspace infrastructure. This file contains instructions for the Claude Code agent.*

## Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-tmp` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
# Correct: start Claude Code here
cd ~/home-baseline-tmp
claude
# → make changes, commit, push

# After push: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-tmp` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |

## Repository Purpose

This is the **home-baseline** repository — the top-level workspace infrastructure for `~`. It manages bootstrapping new project workspaces as private GitHub repositories and enforces security across all projects.

## Scripts

All scripts live in `~/scripts/` and come in paired Bash (`.sh`) and PowerShell Core (`.ps1`) variants for cross-platform support.

### Bootstrap a new workspace

```bash
# macOS/Linux
bash ~/scripts/bootstrap-workspace.sh <WorkspaceName> [repo-name] [description]
bash ~/scripts/bootstrap-workspace.sh --dry-run <WorkspaceName>   # preview only

# Windows (pwsh >= 7)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Name> [-RepoName <r>] [-WhatIf]
```

The script: detects existing sub-repos → adds them to `.gitignore` → copies standard scripts → `git init` + initial commit → creates private GitHub repo via `gh repo create` → pushes → installs hooks → updates `~/README.md`.

### Install Git hooks

```bash
bash ~/scripts/install-hooks.sh          # macOS/Linux
pwsh ~/scripts/install-hooks.ps1         # Windows
```

### Scan AI agent directories for secrets

```bash
bash ~/scripts/scan-agent-secrets.sh [--fail-on-high]
pwsh ~/scripts/scan-agent-secrets.ps1
```

Scans `.claude/`, `.codex/`, `.gemini/`, `.junie/`, `.opencode/` for leaked credentials. Outputs `high=N medium=M low=L total=T`. Use `--fail-on-high` as a CI gate.

### Cross-platform test output (macOS / Linux / Windows)

When terminal output cannot be copy-pasted between machines, use the matching platform test script to collect results, commit and push them, then read from any other device:

```bash
bash ~/home-baseline-tmp/scripts/mac-test.sh     # macOS
bash ~/home-baseline-tmp/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1  # Windows
```

Each script collects: OS version, architecture, tool versions (git, gh, brew/apt/winget, rg, node, uv, specify, pwsh), package manager versions, sync-home and compliance check result. Output files: `mac-test-output.txt`, `linux-test-output.txt`, `windows-test-output.txt`.

## OS-Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them.

## Known Pitfalls

### Windows: `gh auth login` in background processes
`gh auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `gh auth login` in an **interactive terminal window** directly.
After login run: `gh auth setup-git` to configure the git credential helper.

### macOS/Linux/Windows: `glab auth login` in background processes
`glab auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `glab auth login` in an **interactive terminal window** directly.

### Windows: `ssh-agent` requires admin rights — use HTTPS instead
The OpenSSH Agent service is disabled by default (needs admin to enable).
Use HTTPS + `gh auth setup-git` for all git push operations on Windows.

### Windows: `-NoProfile` for `pwsh` subprocesses
`pwsh -File script.ps1` loads the user profile (Oh-My-Posh etc.), causing:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: always add `-NoProfile` to `pwsh` subprocess calls.

### Linux: `git pull` needs rebase config
Run once: `git config --global pull.rebase true`

### Linux: SSH for GitHub push
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
```

### Test scripts: `--autostash` required
Scripts write the output file before pushing — `--autostash` prevents unstaged-changes error.
All test scripts use: `git pull --rebase --autostash origin main`

## Security Architecture

The `.gitignore` uses a **whitelist model** (`/*` ignores everything; only explicitly listed files are tracked). Never add AI agent directories (`.claude/`, `.junie/`, etc.), credentials files, or dotfiles containing secrets to the tracked whitelist.

The `scripts/hooks/pre-push` hook blocks pushes if secret-like filenames or credential patterns are found in tracked files. It is installed into `.git/hooks/` by `install-hooks.sh`.

Secrets are stored in the system credential store (e.g. macOS Keychain, Windows Credential Manager), accessed via shell helpers in your shell profile.

## Workspace Structure

Each sub-directory is an **independent git repository** (not a submodule). They are excluded from home-baseline tracking via `.gitignore`. Example workspaces:

| Directory | GitHub Repo |
|---|---|
| `~/MyProjects/` | `YOUR_USERNAME/myprojects-baseline` |

When adding a new workspace to `~/README.md`, insert a table row before the `<!-- workspace-table-end -->` marker.

## README Maintenance

`~/README.md` is auto-updated by `bootstrap-workspace.sh` when a new workspace is created. The workspace table uses `<!-- workspace-table-end -->` as an insertion anchor. If editing manually, preserve that marker.

## Projektstatus / Repository Status

- **Sichtbarkeit / Visibility**: öffentliches Template-Repo — Azubis/andere können über „Use this template" ein eigenes Repo erstellen, ohne die Commit-History zu erben
- **Lizenz / License**: MIT
- **Branch-Schutz / Branch protection**: `main` erfordert PR; `enforce_admins: false` (Eigentümer kann direkt pushen)
- **CI**: grün auf `ubuntu-22.04`, `macos-14`, `windows-2022`
- **Compliance-Score**: 100 % (25/25 Checks) bei letzter verifizierten Installation

## Bekannte Fallstricke / Known Pitfalls

### Windows: `$env:HOME` ist ein leerer String, nicht `$null`
Der `??`-Operator fängt leere Strings nicht ab. Immer verwenden:
`$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`

### `Copy-Item` Verzeichnis-Verhalten
Wenn das Ziel bereits existiert, kopiert `Copy-Item src dst -Recurse` das Verzeichnis **in** dst (erzeugt `dst/src/`).
Korrekt: `Copy-Item src/* dst/ -Recurse -Force`. Bash-Äquivalent: `cp -r src/. dst/`.

### CI: Scanner muss aus dem Parent-Verzeichnis von `$GITHUB_WORKSPACE` laufen
`check-homogeneity.sh/ps1` erwartet `TARGET_DIR` als auflösbaren Pfad.
Bei `$(basename "$GITHUB_WORKSPACE")` aus dem Repo-Root gelten alle Dateien als fehlend.

### bash `${#array[@]+...}` nicht auf Ubuntu 22.04 unterstützt
Verursacht `bad substitution`. Bash-3-sichere Alternative: `for`-Schleife zum Zählen.

### `hg-a11y`: Falsch-Positive durch Fenced Code Blocks
`# comment`-Zeilen in ` ``` `-Blöcken wurden als h1 interpretiert → `heading-gap-h1-to-h3`.
Fix: `$inFencedBlock`-Toggle auf ` ``` `-Zeilen.

### `.gitignore`-Whitelist und `LICENSE`
`git add LICENSE` wird lautlos ignoriert, wenn `LICENSE` nicht explizit in der Whitelist steht (`!LICENSE`).

### Doppelte Headings im TOC / Duplicate heading anchors
GitHub hängt `-1`, `-2` etc. an Anker wenn derselbe Heading-Text mehrfach vorkommt.
TOC-Links für zweite Vorkommen müssen diesen Suffix enthalten.

### Bilinguale Überschriften-Pflicht / Bilingual heading requirement
Alle Headings MÜSSEN das Format `DE / EN` haben. Nur-Deutsch-Headings brechen die bilinguale Konsistenz und verletzen WCAG 2.4.6.
Ausnahme: Eigennamen / Toolnamen (z. B. `### Homogeneity Guardian`) sind sprachneutral.

### Code-Block Sprachmarkierung (WCAG 4.1.1)
Jeder Code-Block benötigt eine Sprach-Angabe. Für ASCII-Grafiken, Dialog-Beispiele oder Verzeichnisstrukturen: ` ```text `.
Bare ` ``` ` ohne Sprache verletzt WCAG 4.1.1 (Syntaxanalyse).

### WCAG 2.2 Level AA — README-Compliance
Die README folgt WCAG 2.2 Level AA. Kriterien-Tabelle im Abschnitt `## Barrierefreiheit / Accessibility (A11Y)`.
Einzige Plattform-Einschränkung: WCAG 3.1.2 (`lang`-Attribute) — GitHub entfernt HTML-Attribute.

### ASCII-Box-Drawing-Tabellen: Zeilenbreite
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen mit: `$line.Length` (PowerShell) — alle Rahmen-Zeilen müssen denselben Wert liefern.

### Spec-Kit-Verzeichnis initialisieren
Nie manuell aus `~/home-baseline-tmp/` kopieren. Stattdessen:
`specify init --here --ai {agent}` — der Parameter `--ai-skill` ist **nur für Codex** erforderlich.

<!-- EN: CLAUDE.md placeholder
[DE-Zusammenfassung: CLAUDE.md enthält Anweisungen für den Claude Code Agenten im home-baseline Repository.]
-->

## Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI (existing, required), `glab` CLI (optional for GitLab), `tar` (system built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc`, `~/README.md`, `~/.gitignore` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (new) · `gh` ≥ 2.30 (existing) · `git` ≥ 2.30 (existing) (006-gitlab-support)
- N/A — file modifications to existing scripts and `~/README.md` (006-gitlab-support)

## Recent Changes
- 003-git-config-scope: Added Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency)
- 006-gitlab-support: Added GitLab CLI support documentation, `glab auth login` pitfall guidance, and spec artifacts for GitLab bootstrap support
