# Repository Guidelines

## Beschreibung / Description

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur. Diese Datei enthält Anweisungen für KI-Agenten wie Codex und GitHub Copilot.

*This repository is the **top-level** private workspace infrastructure. This file contains instructions for AI agents such as Codex and GitHub Copilot.*

## Project Structure & Module Organization
This repository is the top-level `home-baseline` workspace bootstrap. Keep changes focused on the root documentation and the reusable scripts under `scripts/`.

- `README.md`: bilingual usage and setup guide for the workspace baseline.
- `scripts/bootstrap-workspace.sh`: Bash bootstrap flow for macOS/Linux.
- `scripts/bootstrap-workspace.ps1`: PowerShell 7 bootstrap flow for Windows.
- `scripts/teardown-workspace.sh`: removes a workspace — remote repo, local directory, and artifacts (`~/README.md`, `~/.gitignore`, `~/.gitconfig`).
- `scripts/teardown-workspace.ps1`: PowerShell 7 equivalent of teardown.
- `scripts/install-hooks.*`: installs Git hooks into `.git/hooks/`.
- `scripts/scan-agent-secrets.*`: manual or hook-driven secret scanning.
- `scripts/hooks/pre-push`: shared hook copied into target repositories.

There is no `src/` or formal test tree; the scripts themselves are the product.

## Build, Test, and Development Commands
There is no build step. Validate changes by running the scripts directly.

```bash
bash scripts/bootstrap-workspace.sh --dry-run FlutterProjects
bash scripts/install-hooks.sh
bash scripts/scan-agent-secrets.sh --fail-on-high .
pwsh scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
pwsh scripts/install-hooks.ps1 -Verbose
pwsh scripts/scan-agent-secrets.ps1 -FailOnHigh
```

Use `--dry-run` and `-WhatIf` before changing bootstrap logic. Reinstall hooks after editing files in `scripts/hooks/`.

## OS-Detection — Skript-Auswahl / OS Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Never mix — both variants are functionally equivalent. When validating changes, run the variant matching the current OS first, then cross-check the other if relevant.

## Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-tmp` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
# Correct: start agent here
cd ~/home-baseline-tmp
# → make changes, commit, push

# After push: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-tmp` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |


Bash scripts use `#!/usr/bin/env bash` plus `set -euo pipefail`. PowerShell scripts require PowerShell 7, `Set-StrictMode -Version Latest`, and `$ErrorActionPreference = 'Stop'`. Match the existing style:

- Two-space indentation in Bash, four spaces in PowerShell.
- Script filenames use kebab-case, for example `bootstrap-workspace.sh`.
- PowerShell parameters use PascalCase, for example `-WorkspaceName`.
- **PowerShell naming**: Functions and Cmdlets MUST use the `Verb-Noun` pattern (e.g., `New-HBWorkspace`).
- **Documentation mandatory**: Every new script MUST have a Unix man-page (for `.sh`) in `docs/man/` and complete bilingual comment-based help (for `.ps1`).
- Prefer clear German-facing user messages; keep README content bilingual when editing existing sections.

## Testing Guidelines
Manual verification is the current test strategy. For bootstrap changes, test both shells in safe mode: Bash with `--dry-run`, PowerShell with `-WhatIf`. For hook or scanning changes, run the relevant installer, then execute the scanner against the repo root and confirm expected exit codes.

### Cross-Platform Testing (macOS / Linux / Windows)
When testing on a machine where copy-pasting terminal output to this session is not possible, use the matching platform test script — it commits and pushes `*-test-output.txt` to the repo:
```bash
bash ~/home-baseline-tmp/scripts/mac-test.sh     # macOS
bash ~/home-baseline-tmp/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1  # Windows
```
Read results from any device:
```bash
gh api repos/hindermath/home-baseline/contents/mac-test-output.txt --jq '.content' | base64 -d
```
Or view at: `https://github.com/hindermath/home-baseline/blob/main/`

## Statistik-Pflege / Statistics Maintenance

- Führe `docs/project-statistics.md` als lebendes Statistik-Ledger dieses Repositories.
- Aktualisiere die Datei nach jedem abgeschlossenen Feature/Lastenheft, nach jeder abgeschlossenen Spec-Kit-Implementierungsphase und wenn explizit angefordert.
- Im `## Fortschreibungsprotokoll`-Abschnitt gilt: ältester Eintrag oben, neuester Eintrag unten; Einträge mit gleichem Datum behalten ihre Reihenfolge.
- Halte den `## Gesamtstatistik`-Abschnitt als letzten Top-Level-Abschnitt; hänge danach keine weiteren Top-Level-Abschnitte an.
- Innerhalb von `## Gesamtstatistik` stehen kompakte ASCII-Only-Diagramme direkt unter der Kennzahlen-Tabelle; zeige mindestens Artefaktmix, Phasenvolumen, konservative Referenz-Balken, Beschleunigungsfaktoren und den Vergleich Erfahren/Thorsten-Solo/KI-sichtbar.
- Jedes ASCII-Diagramm erhält eine kurze CEFR-B2-Erklärung direkt darunter (deutsch und englisch).
- Halte die Statistik textfreundlich: keine Farben, keine Symbole, die auf Braille-Zeilen oder Screenreadern nicht lesbar sind.
- Manuelle Referenzen für dieses Repository: `80` Zeilen/Arbeitstag (konservative Untergrenze) und `100` Zeilen/Arbeitstag (Thorsten-Solo, Scripting-Infra).
- Beim Umrechnen in Stunden: `7.8` Stunden (`7h 48m`) pro Arbeitstag (TVöD-Basis).
- Beim Umrechnen in Monate: `21.5` Arbeitstage/Monat; Urlaubstage: 30 Tage bis Ende 2026, ab 2027 dann 31 Tage pro Jahr (TVöD, 5-Tage-Woche).
- Beschleunigungsfaktoren vergleichen die manuelle Referenz gegen sichtbare Git-Aktivtage — keine Stoppuhrmessung, sondern blended repository speedup.
- Shared guidance darf nicht nur in einer der Agenten-Dateien aktualisiert werden; intentionale Abweichungen müssen in derselben Änderung dokumentiert sein.

*Maintain `docs/project-statistics.md` as the living statistics ledger for this repository. Update after each completed feature/Lastenheft, Spec-Kit phase, or on explicit request. Keep the Fortschreibungsprotokoll in chronological order (oldest first). Keep `## Gesamtstatistik` as the final top-level section. Manual references: `80` lines/workday (conservative) and `100` lines/workday (Thorsten-Solo, scripting infra). TVöD workday: `7.8 h`. Acceleration factors compare manual reference against observable Git active days — not stopwatch time.*

## Commit & Pull Request Guidelines
Recent history follows Conventional Commit prefixes: `chore:`, `docs:`, `feat:`. Keep subjects short and imperative, for example `feat: bootstrap-workspace aktualisiert ~/README.md automatisch`.

Pull requests should include:

- a short description of the workflow change,
- affected scripts or docs,
- manual verification commands you ran,
- sample output or screenshots when user-visible console output changes.

## Security & Configuration Tips
Do not commit tokens, `.env` files, or local agent state. If you touch secret-scan behavior or hooks, mention the risk explicitly in the PR and re-run the scanner before pushing.

## Known Pitfalls (Platform-specific)

### Windows: `gh auth login` in background processes
`gh auth login --web` does NOT detect browser confirmation when run in a background/async process.
Always run `gh auth login` in an **interactive terminal window** — not from within Copilot CLI async shell.

### macOS / Linux / Windows: `glab auth login` in background processes
`glab auth login --web` does NOT detect browser confirmation when run in a background/async process.
Always run `glab auth login` in an **interactive terminal window** — not from within Copilot CLI async shell.

### Windows: `gh` keyring becomes invalid
Symptom: `Failed to log in to github.com account (keyring)`.
Fix: `gh auth logout -h github.com -u hindermath` then re-login interactively.
After login: run `gh auth setup-git` once to configure the git credential helper.

### Windows: `ssh-agent` requires admin rights
The OpenSSH Agent service is disabled by default and needs admin to enable.
Use HTTPS + `gh auth setup-git` instead of SSH on Windows.

### Windows: `-NoProfile` for `pwsh` subprocesses
Calling `pwsh -File script.ps1` loads the user profile (Oh-My-Posh etc.), which may fail with:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: add `-NoProfile` to all `pwsh` subprocess calls.

### Linux: `git pull` needs rebase config
Run once: `git config --global pull.rebase true` — prevents "divergent branches" error.

### Linux: SSH for GitHub push (HTTPS credential cache unreliable)
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
```

### Test scripts: unstaged output file blocks `git pull --rebase`
The `*-test.sh/ps1` scripts write the output file before pushing.
All test scripts use `git pull --rebase --autostash origin main` to avoid this.

## Active Technologies
- Bash 5+ (primär), PowerShell Core 7+ (Windows-Parität) + `git`, `bash` ≥ 5, `ripgrep (rg)`, `sha256sum` (Linux/WSL) / (001-workspace-homogeneity-guardian)
- Plain-Markdown-Dateien — `STATS.md` (append-only), `memory-patch.md` (001-workspace-homogeneity-guardian)
- Bash 5+ (primär / primary); PowerShell Core 7+ (Windows-Parität / parity) + `git` ≥ 2.30, `ripgrep (rg)` (alle Plattformen), `gh` CLI (optional, Bootstrap) (002-homogeneity-guardian-revision)
- Dateisystem / File system (`.md`, `.gitignore`, `STATS.md`, `constitution.md`, `.yml`) (002-homogeneity-guardian-revision)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/` (local dir), remote repo (GitHub/GitLab), `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (GitLab support), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)

## Recent Changes
- 001-workspace-homogeneity-guardian: Added Bash 5+ (primär), PowerShell Core 7+ (Windows-Parität) + `git`, `bash` ≥ 5, `ripgrep (rg)`, `sha256sum` (Linux/WSL) /
- 003-public-template-prep: Repo auf Public Template umgestellt, MIT-Lizenz, Branch-Protection, alle persönlichen Daten entfernt, Bootstrap-Skripte dynamisch (kein hardcodierter Username mehr)
- 004-readme-ausbau-ci-fixes-sync: sync-home.sh/.ps1 hinzugefügt; README vollständig überarbeitet (2-stufiges TOC, Auszubildende, Spec-Kit, WCAG 2.2 AA); CHANGELOG.md angelegt; CI-Fixes (TARGET_DIR, windows-2022, -TargetDir)
- 005-readme-tabelle-specify-init: Workflow-Tabelle ausgerichtet (5 Zeilen 64→63 Zeichen); Abschnitt „Verzeichnis vorbereiten" auf `specify init --here --ai {agent}` umgestellt; `--ai-skill` als Codex-spezifisch dokumentiert
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf`, `~/.gitconfig.d/`, bootstrap-workspace, sync-home, check-homogeneity, pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` neu — Backup, Remote-Löschung (GitHub/GitLab auto-detected), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: GitLab-CLI-Support für `bootstrap-workspace.*` und `bootstrap-project.*`, Self-hosted `--gitlab-url`, bilinguale Fehlerpfade und GitLab-Dokumentation ergänzt
- 007-gitlab-release-automation: `setup-gitlab-release.*`, GitLab-Release-Templates und non-blocking manueller `release`-Job ergänzt; mit echten Releases in `sysinfotool` (`v0.1.0`) und `inventarworkerservice2` (`v0.0.1`) validiert; Detached-HEAD- und CHANGELOG-Refresh-Fixes eingearbeitet

## Projektstatus / Repository Status

- **Template-Repo**: öffentlich — via „Use this template" nutzbar (keine History-Übertragung, kein Upstream-Link)
- **Lizenz**: MIT | **CI**: ✅ ubuntu-22.04, macos-14, windows-2022 | **Score**: 100 %

## Bekannte Fallstricke / Known Pitfalls

| Problem | Ursache | Fix |
|---|---|---|
| Windows `$env:HOME` leer | PS7 `??` fängt `''` nicht ab | `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` |
| CI: Dateien „missing" | Relativer Pfad als CWD=Repo-Root | `cd "$(dirname $GITHUB_WORKSPACE)"` vor Scanner-Aufruf |
| bash `bad substitution` | `${#arr[@]+...}` auf Ubuntu 22.04 | Bash-3-sichere `for`-Schleife zum Zählen |
| `Copy-Item` kopiert Verzeichnis in Verzeichnis | Ziel existiert bereits | `Copy-Item src/* dst/ -Recurse -Force` |
| `LICENSE` von `.gitignore` ignoriert | Whitelist-Modell | `!LICENSE` in `.gitignore` eintragen |
| ANSI-Falsch-Positive im Scanner | Scanner enthält `\033[` als Literal | `check-homogeneity.*` aus ANSI-Scan ausschließen |
| `hg-a11y` h1 in Code-Blöcken | `# comment` in ` ``` ` als Heading geparst | `$inFencedBlock`-Toggle |
| Bootstrap hardcodierter Username | `hindermath` war fest eingebaut | `gh api user --jq '.login'` dynamisch |
| Doppelte Überschriften im TOC | GitHub hängt `-1`, `-2` an gleiche Texte | Ankertexte im TOC mit Suffix verwenden oder Headings umbenennen |
| Nicht-bilinguale Überschriften | Heading nur auf Deutsch | Alle Headings müssen `DE / EN`-Format haben |
| Code-Block ohne Sprach-Tag | Bare ` ``` ` verletzt WCAG 4.1.1 | Immer Sprache angeben — ` ```text ` für ASCII/Dialog |
| WCAG 3.1.2 `lang`-Attribute | GitHub entfernt HTML-Attribute | Platform-Einschränkung — in Barrierefreiheit-Abschnitt dokumentiert |
| ASCII-Box-Drawing-Tabellen falsch ausgerichtet | Ein überzähliges Leerzeichen vor dem schließenden `│` macht eine Zeile 1 Zeichen zu lang | Alle Zeilen auf exakt gleiche Zeichenbreite prüfen (PS: `$line.Length`) |
| Spec-Kit-Verzeichnis manuell kopiert | `cp -r ~/home-baseline-tmp/` setzt lokalen Klon voraus | `specify init --here --ai {agent}` verwenden; `--ai-skill` nur für Codex |
| Lastenheft nach Feature-Abschluss nicht umbenannt | `tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben) | `bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` (macOS/Linux) · `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>` (Windows) |
| Workspace-Name beginnt mit `-` (z.B. `-h`) | Shell interpretiert ihn als Flag | `teardown-workspace.sh -- -h` (doppeltes Minus vor dem Namen); gilt analog für alle Skripte mit Positionsargumenten |

<!-- EN: AGENTS.md placeholder
[DE-Zusammenfassung: AGENTS.md enthält Anweisungen für den Codex Agenten im home-baseline Repository.]
-->
