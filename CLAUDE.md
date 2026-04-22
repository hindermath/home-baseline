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

## Repository-Zweck / Repository Purpose

This is the **home-baseline** repository — the top-level workspace infrastructure for `~`. It manages bootstrapping new project workspaces as private GitHub or GitLab repositories and enforces security across all projects.

## Skripte / Scripts

All scripts live in `~/scripts/` and come in paired Bash (`.sh`) and PowerShell Core (`.ps1`) variants for cross-platform support. **Each script requires a corresponding Unix man-page (for `.sh`, in `docs/man/`), complete bilingual comment-based help (for `.ps1`), and a corresponding PowerShell Cmdlet (using the `Verb-Noun` pattern).**

### Neuen Workspace anlegen / Bootstrap a New Workspace

```bash
# macOS/Linux
bash ~/scripts/bootstrap-workspace.sh <WorkspaceName> [repo-name] [description]
bash ~/scripts/bootstrap-workspace.sh --dry-run <WorkspaceName>   # preview only

# Windows (pwsh >= 7)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Name> [-RepoName <r>] [-WhatIf]
```

The script: detects existing sub-repos → adds them to `.gitignore` → copies standard scripts → `git init` + initial commit → creates a private GitHub repo via `gh repo create` or a private GitLab repo via `glab repo create` → pushes → installs hooks → updates `~/README.md`.

### Git-Hooks installieren / Install Git Hooks

```bash
bash ~/scripts/install-hooks.sh          # macOS/Linux
pwsh ~/scripts/install-hooks.ps1         # Windows
```

### KI-Agenten-Verzeichnisse auf Secrets prüfen / Scan AI Agent Directories for Secrets

```bash
bash ~/scripts/scan-agent-secrets.sh [--fail-on-high]
pwsh ~/scripts/scan-agent-secrets.ps1
```

Scans `.claude/`, `.codex/`, `.gemini/`, `.junie/`, `.opencode/` for leaked credentials. Outputs `high=N medium=M low=L total=T`. Use `--fail-on-high` as a CI gate.

### Agentenverwaltete Dateiänderungen auditieren / Audit Agent-Managed File Changes

```bash
bash ~/scripts/audit-agent-changes.sh snapshot
bash ~/scripts/audit-agent-changes.sh report
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action report
```

Creates a local baseline below `~/.home-baseline/agent-audit/` and later compares current agent-managed files against that baseline. The report correlates changes heuristically with recent Codex, Claude, Copilot, and Continue logs. This is local audit state, not repository content.

### Plattformübergreifende Testausgabe (macOS / Linux / Windows) / Cross-Platform Test Output (macOS / Linux / Windows)

When terminal output cannot be copy-pasted between machines, use the matching platform test script to collect results, commit and push them, then read from any other device:

```bash
bash ~/home-baseline-tmp/scripts/mac-test.sh     # macOS
bash ~/home-baseline-tmp/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1  # Windows
```

Each script collects: OS version, architecture, tool versions (git, gh, brew/apt/winget, rg, node, uv, specify, pwsh), package manager versions, sync-home and compliance check result. Output files: `mac-test-output.txt`, `linux-test-output.txt`, `windows-test-output.txt`.

## OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them.

## Statistik-Pflege / Statistics Maintenance

- Maintain `docs/project-statistics.md` as the living statistics ledger for this repository.
- Update it after each completed feature/Lastenheft, each completed Spec-Kit phase, or when explicitly requested.
- Keep the `## Fortschreibungsprotokoll` section chronological: oldest entry first, newest entry last.
- Keep `## Gesamtstatistik` as the final top-level section; do not append later top-level sections after it.
- Place compact ASCII-only diagrams directly below the metrics table inside `## Gesamtstatistik`; include at least artefact mix, phase volume, conservative reference bars, acceleration factors, and the experienced/Thorsten-Solo/AI-visible comparison.
- Add a short CEFR-B2 explanation below every ASCII diagram in German first and English second.
- Use text-friendly presentation only: no color-dependent signalling and no symbols that are unreadable on Braille displays or screen readers.
- Manual references for this repository are `80` lines/workday (conservative) and `100` lines/workday (Thorsten-Solo, scripting infrastructure).
- Default C#/.NET Thorsten-Solo baseline is `125` lines/workday unless the individual repository documents a justified deviation.
- TVöD conversion basis: `7.8 h` (`7h 48m`) per workday, `21.5` workdays per month, 30 vacation days until the end of 2026, 31 from 2027 onward.
- Shared guidance or statistics-method changes must update `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md` together in the same change.

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` is mandatory shared guidance, not optional wording.
- All user-facing artefacts must be checked for inclusive use: CLI output, documentation, HTML, UI, and generated templates.
- Treat WCAG 2.2 Level AA as the default accessibility baseline wherever the criteria apply.
- Keep text-first usability visible for keyboard-only use, screen readers, Braille displays, and text browsers.
- Follow DE first, EN second for shared guidance and learner-facing documentation; for large normative documents, a synchronised `.EN.md` companion is acceptable.
- Shared guidance must stay aligned across `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`; document any intentional deviation in the same change.

## Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Claude-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Claude work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

## Sicherheitsarchitektur / Security Architecture

The `.gitignore` uses a **whitelist model** (`/*` ignores everything; only explicitly listed files are tracked). Never add AI agent directories (`.claude/`, `.junie/`, etc.), credentials files, or dotfiles containing secrets to the tracked whitelist.

The `scripts/hooks/pre-push` hook blocks pushes if secret-like filenames or credential patterns are found in tracked files. It is installed into `.git/hooks/` by `install-hooks.sh`.

Secrets are stored in the system credential store (e.g. macOS Keychain, Windows Credential Manager), accessed via shell helpers in your shell profile.

## Workspace-Struktur / Workspace Structure

Each sub-directory is an **independent git repository** (not a submodule). They are excluded from home-baseline tracking via `.gitignore`. Example workspaces:

| Directory | GitHub Repo |
|---|---|
| `~/MyProjects/` | `YOUR_USERNAME/myprojects-baseline` |

When adding a new workspace to `~/README.md`, insert a table row before the `<!-- workspace-table-end -->` marker.

## README-Pflege / README Maintenance

`~/README.md` is auto-updated by `bootstrap-workspace.sh` when a new workspace is created. The workspace table uses `<!-- workspace-table-end -->` as an insertion anchor. If editing manually, preserve that marker.

## Projektstatus / Repository Status

- **Sichtbarkeit / Visibility**: öffentliches Template-Repo — Azubis/andere können über „Use this template" ein eigenes Repo erstellen, ohne die Commit-History zu erben
- **Lizenz / License**: MIT
- **Branch-Schutz / Branch protection**: `main` erfordert PR; `enforce_admins: false` (Eigentümer kann direkt pushen)
- **CI**: grün auf `ubuntu-22.04`, `macos-14`, `windows-2022`
- **Compliance-Score**: 100 % (25/25 Checks) bei letzter verifizierten Installation

## Bekannte Fallstricke / Known Pitfalls

### Windows: `gh auth login` in Hintergrundprozessen / Windows: `gh auth login` in Background Processes
`gh auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `gh auth login` in an **interactive terminal window** directly.
After login run: `gh auth setup-git` to configure the git credential helper.

### macOS/Linux/Windows: `glab auth login` in Hintergrundprozessen / macOS/Linux/Windows: `glab auth login` in Background Processes
`glab auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `glab auth login` in an **interactive terminal window** directly.

### Windows: `ssh-agent` braucht Adminrechte — stattdessen HTTPS nutzen / Windows: `ssh-agent` Requires Admin Rights — Use HTTPS Instead
The OpenSSH Agent service is disabled by default (needs admin to enable).
Use HTTPS + `gh auth setup-git` for all git push operations on Windows.

### Windows: `-NoProfile` für `pwsh`-Subprozesse / Windows: `-NoProfile` for `pwsh` Subprocesses
`pwsh -File script.ps1` loads the user profile (Oh-My-Posh etc.), causing:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: always add `-NoProfile` to `pwsh` subprocess calls.

### Linux: `git pull` braucht Rebase-Konfiguration / Linux: `git pull` Needs Rebase Config
Run once: `git config --global pull.rebase true`

### Linux: SSH für GitHub-Push / Linux: SSH for GitHub Push
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
```

### Testskripte: `--autostash` erforderlich / Test Scripts: `--autostash` Required
Scripts write the output file before pushing — `--autostash` prevents unstaged-changes error.
All test scripts use: `git pull --rebase --autostash origin main`

### Windows: `$env:HOME` ist ein leerer String, nicht `$null` / Windows: `$env:HOME` Is an Empty String, Not `$null`
Der `??`-Operator fängt leere Strings nicht ab. Immer verwenden:
`$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`

### `Copy-Item`-Verzeichnisverhalten / `Copy-Item` Directory Behaviour
Wenn das Ziel bereits existiert, kopiert `Copy-Item src dst -Recurse` das Verzeichnis **in** dst (erzeugt `dst/src/`).
Korrekt: `Copy-Item src/* dst/ -Recurse -Force`. Bash-Äquivalent: `cp -r src/. dst/`.

### CI: Scanner muss aus dem Parent-Verzeichnis von `$GITHUB_WORKSPACE` laufen / CI: Scanner Must Run from the Parent Directory of `$GITHUB_WORKSPACE`
`check-homogeneity.sh/ps1` erwartet `TARGET_DIR` als auflösbaren Pfad.
Bei `$(basename "$GITHUB_WORKSPACE")` aus dem Repo-Root gelten alle Dateien als fehlend.

### Bash `${#array[@]+...}` auf Ubuntu 22.04 nicht unterstützt / Bash `${#array[@]+...}` Not Supported on Ubuntu 22.04
Verursacht `bad substitution`. Bash-3-sichere Alternative: `for`-Schleife zum Zählen.

### `hg-a11y`: Falsch-Positive durch fenced code blocks / `hg-a11y`: False Positives from Fenced Code Blocks
`# comment`-Zeilen in ` ``` `-Blöcken wurden als h1 interpretiert → `heading-gap-h1-to-h3`.
Fix: `$inFencedBlock`-Toggle auf ` ``` `-Zeilen.

### `.gitignore`-Whitelist und `LICENSE` / `.gitignore` Whitelist and `LICENSE`
`git add LICENSE` wird lautlos ignoriert, wenn `LICENSE` nicht explizit in der Whitelist steht (`!LICENSE`).

### Doppelte Headings im TOC / Duplicate heading anchors
GitHub hängt `-1`, `-2` etc. an Anker wenn derselbe Heading-Text mehrfach vorkommt.
TOC-Links für zweite Vorkommen müssen diesen Suffix enthalten.

### Bilinguale Überschriften-Pflicht / Bilingual heading requirement
Alle Headings MÜSSEN das Format `DE / EN` haben. Nur-Deutsch-Headings brechen die bilinguale Konsistenz und verletzen WCAG 2.4.6.
Ausnahme: Eigennamen / Toolnamen (z. B. `### Homogeneity Guardian`) sind sprachneutral.

### Code-Block-Sprachmarkierung (WCAG 4.1.1) / Code Fence Language Tagging (WCAG 4.1.1)
Jeder Code-Block benötigt eine Sprach-Angabe. Für ASCII-Grafiken, Dialog-Beispiele oder Verzeichnisstrukturen: ` ```text `.
Bare ` ``` ` ohne Sprache verletzt WCAG 4.1.1 (Syntaxanalyse).

### WCAG 2.2 Level AA — README-Compliance / WCAG 2.2 Level AA — README Compliance
Die README folgt WCAG 2.2 Level AA. Kriterien-Tabelle im Abschnitt `## Barrierefreiheit / Accessibility (A11Y)`.
Einzige Plattform-Einschränkung: WCAG 3.1.2 (`lang`-Attribute) — GitHub entfernt HTML-Attribute.

### ASCII-Box-Drawing-Tabellen: Zeilenbreite / ASCII Box-Drawing Tables: Line Width
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen mit: `$line.Length` (PowerShell) — alle Rahmen-Zeilen müssen denselben Wert liefern.

### Spec-Kit-Verzeichnis initialisieren / Initialize the Spec-Kit Directory
Nie manuell aus `~/home-baseline-tmp/` kopieren. Stattdessen:
`specify init --here --ai {agent}` — der Parameter `--ai-skill` ist **nur für Codex** erforderlich.

### Lastenheft nach Feature-Abschluss umbenennen / Rename Lastenheft After Feature Completion
Nach vollständiger Implementierung eines Features MUSS das zugehörige `Lastenheft_*.md` umbenannt werden:
```bash
bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>   # macOS/Linux
pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>   # Windows
```
Beispiel: `Lastenheft_Foo.md` + Branch `003-feature` → `Lastenheft_Foo.003-feature.md`.
Dieser Schritt ist seit `constitution v1.1.1` als letzter Task der Polish-Phase in jeder `tasks.md` enthalten.
Fehlte bei Features 003, 005 und 006, weil das Template den Schritt nicht vorsah.

<!-- EN: CLAUDE.md placeholder
[DE-Zusammenfassung: CLAUDE.md enthält Anweisungen für den Claude Code Agenten im home-baseline Repository.]
-->

## Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI (existing, required), `glab` CLI (optional for GitLab), `tar` (system built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc`, `~/README.md`, `~/.gitignore` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (new) · `gh` ≥ 2.30 (existing) · `git` ≥ 2.30 (existing) (006-gitlab-support)
- N/A — file modifications to existing scripts and `~/README.md` (006-gitlab-support)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Added Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency)
- 006-gitlab-support: Added GitLab CLI support documentation, `glab auth login` pitfall guidance, and spec artifacts for GitLab bootstrap support
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
