# Repository Guidelines

## Beschreibung / Description

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur. Diese Datei enthält Anweisungen für KI-Agenten wie Codex und GitHub Copilot.

*This repository is the **top-level** private workspace infrastructure. This file contains instructions for AI agents such as Codex and GitHub Copilot.*

## Project Structure & Module Organization
This repository is the top-level `home-baseline` workspace bootstrap. Keep changes focused on the root documentation and the reusable scripts under `scripts/`.

- `README.md`: bilingual usage and setup guide for the workspace baseline.
- `scripts/bootstrap-workspace.sh`: Bash bootstrap flow for macOS/Linux.
- `scripts/bootstrap-workspace.ps1`: PowerShell 7 bootstrap flow for Windows.
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

## Coding Style & Naming Conventions
Bash scripts use `#!/usr/bin/env bash` plus `set -euo pipefail`. PowerShell scripts require PowerShell 7, `Set-StrictMode -Version Latest`, and `$ErrorActionPreference = 'Stop'`. Match the existing style:

- Two-space indentation in Bash, four spaces in PowerShell.
- Script filenames use kebab-case, for example `bootstrap-workspace.sh`.
- PowerShell parameters use PascalCase, for example `-WorkspaceName`.
- Prefer clear German-facing user messages; keep README content bilingual when editing existing sections.

## Testing Guidelines
Manual verification is the current test strategy. For bootstrap changes, test both shells in safe mode: Bash with `--dry-run`, PowerShell with `-WhatIf`. For hook or scanning changes, run the relevant installer, then execute the scanner against the repo root and confirm expected exit codes.

## Commit & Pull Request Guidelines
Recent history follows Conventional Commit prefixes: `chore:`, `docs:`, `feat:`. Keep subjects short and imperative, for example `feat: bootstrap-workspace aktualisiert ~/README.md automatisch`.

Pull requests should include:

- a short description of the workflow change,
- affected scripts or docs,
- manual verification commands you ran,
- sample output or screenshots when user-visible console output changes.

## Security & Configuration Tips
Do not commit tokens, `.env` files, or local agent state. If you touch secret-scan behavior or hooks, mention the risk explicitly in the PR and re-run the scanner before pushing.

## Active Technologies
- Bash 5+ (primär), PowerShell Core 7+ (Windows-Parität) + `git`, `bash` ≥ 5, `ripgrep (rg)`, `sha256sum` (Linux/WSL) / (001-workspace-homogeneity-guardian)
- Plain-Markdown-Dateien — `STATS.md` (append-only), `memory-patch.md` (001-workspace-homogeneity-guardian)
- Bash 5+ (primär / primary); PowerShell Core 7+ (Windows-Parität / parity) + `git` ≥ 2.30, `ripgrep (rg)` (alle Plattformen), `gh` CLI (optional, Bootstrap) (002-homogeneity-guardian-revision)
- Dateisystem / File system (`.md`, `.gitignore`, `STATS.md`, `constitution.md`, `.yml`) (002-homogeneity-guardian-revision)

## Recent Changes
- 001-workspace-homogeneity-guardian: Added Bash 5+ (primär), PowerShell Core 7+ (Windows-Parität) + `git`, `bash` ≥ 5, `ripgrep (rg)`, `sha256sum` (Linux/WSL) /
- 003-public-template-prep: Repo auf Public Template umgestellt, MIT-Lizenz, Branch-Protection, alle persönlichen Daten entfernt, Bootstrap-Skripte dynamisch (kein hardcodierter Username mehr)
- 004-readme-ausbau-ci-fixes-sync: sync-home.sh/.ps1 hinzugefügt; README vollständig überarbeitet (2-stufiges TOC, Auszubildende, Spec-Kit, WCAG 2.2 AA); CHANGELOG.md angelegt; CI-Fixes (TARGET_DIR, windows-2022, -TargetDir)
- 005-readme-tabelle-specify-init: Workflow-Tabelle ausgerichtet (5 Zeilen 64→63 Zeichen); Abschnitt „Verzeichnis vorbereiten" auf `specify init --here --ai {agent}` umgestellt; `--ai-skill` als Codex-spezifisch dokumentiert

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

<!-- EN: AGENTS.md placeholder
[DE-Zusammenfassung: AGENTS.md enthält Anweisungen für den Codex Agenten im home-baseline Repository.]
-->
