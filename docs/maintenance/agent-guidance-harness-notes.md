# Ergänzende Agentenhinweise / Additional agent guidance

DE: Lies zuerst die [gemeinsame Referenz](agent-guidance-reference.md). Die
folgenden Abschnitte erhalten zusätzliche Konventionen, Beispiele und
Fehlerbehebung aus den jeweiligen Agentendateien. Aktuelle Befehle und
Versionen sind vor Verwendung in den kanonischen Quellen zu prüfen.

EN: Read the [shared reference](agent-guidance-reference.md) first. The
sections below preserve additional conventions, examples and troubleshooting
from the individual agent files. Check current commands and versions against
their authoritative sources before use.

## Claude Code

### Beschreibung / Description

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur. Diese Datei enthält Anweisungen für den Claude Code Agenten.

*This repository is the **top-level** private workspace infrastructure. This file contains instructions for the Claude Code agent.*

### Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-source` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
# Correct: start Claude Code here
cd ~/home-baseline-source
claude
# → make changes, commit, push

# After runtime-distribution changes: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-source` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |

Der persönliche Fork unter `~/home-baseline-source` bleibt dauerhaft als
versionierte Level-0-Quelle erhalten. `sync-home.*` verteilt nur
`homeRuntime`: Skripte, gemeinsame Agent-Guidance und ausgewaehlte
Spec-Kit-Oberflaechen. Dokumentation, Specs, Preset-Quellen und Evidence werden
direkt im Klon gelesen; `STATS.md` und private Agentenzustaende bleiben lokal.
Nach reinen Source-only-Aenderungen ist kein Home-Sync erforderlich. Vor echten
Laeufen `--check-only` / `-CheckOnly` verwenden; `--force` / `-Force` nur nach
Pruefung der Konflikte. In der ABS-DD-Sandbox die eingebundene Referenz direkt
verwenden; der allgemeine schreibende Home-Sync bleibt gesperrt. Nur ein
ausdruecklich angeforderter `--runtime-only`-/`-RuntimeOnly`-Lauf darf
manifestgebundene `homeRuntime` in die Container-Betriebskopie verteilen, ohne
Pull, Commit, Git-Konfigurations- oder Identitaetsaenderung.

*Keep the personal fork at `~/home-baseline-source` permanently as the versioned
Level 0 source. `sync-home.*` distributes only `homeRuntime`: scripts, shared
agent guidance, and selected Spec Kit surfaces. Read documentation, specs,
preset sources, and evidence directly from the clone; `STATS.md` and private
agent state remain local. Source-only changes do not require Home sync. Use
`--check-only` / `-CheckOnly` before a real run and review conflicts before
using force. General writing Home sync remains host-only; only an explicitly
requested runtime-only run may distribute manifest-bound `homeRuntime` inside
the container without pull, commit, Git configuration, or identity changes.*

### Skriptreferenz und Quellpfad / Script Reference and Source Path

- Die vollstaendige Skriptinventur steht unter `docs/scripts/`; neue Skripte
  muessen genau einer Kategorie in `scripts/config/script-catalog.json`
  zugeordnet sein.
- Vor einem schreibenden Skriptlauf Hilfe und vorhandenen Check-, Dry-Run- oder
  WhatIf-Modus verwenden.
- Die Level-0-Quelle wird ueber den gemeinsamen Resolver ermittelt; neue
  Automationen duerfen den absoluten Pfad nicht fest eincodieren.

*The complete script inventory lives under `docs/scripts/`. New scripts must
match exactly one catalog category. Read help and use a check or preview mode
before writing. Resolve Level 0 through the shared contract rather than a
hard-coded absolute path.*

### Lernreihen-Governance / Learning Series Governance

#### Git-Hosting fuer Lernende / Git Hosting for Learners

Lernenden-Dokumentation darf kein GitHub-Konto pauschal voraussetzen. `origin`
ist der persoenliche Fork beziehungsweise das persoenliche Lernenden-Repository,
`upstream` die institutionell gepflegte Referenz. GitHub ist ein Profil neben
GitLab, Codeberg, Forgejo und anderen Git-faehigen Systemen. Ein GitHub-Konto
darf nur fuer den direkten GitHub-Pfad oder die optionale Copilot-Anmeldung
verlangt werden. Maintainer-Remotes und Produktnamen bleiben unberuehrt.

*Learner documentation must not assume a GitHub account universally. `origin`
is the personal fork or learner repository and `upstream` is the
institution-maintained reference. GitHub is one profile alongside GitLab,
Codeberg, Forgejo, and other Git-capable systems. A GitHub account may only be
required for the direct GitHub route or optional Copilot sign-in. Maintainer
remotes and product names remain unaffected.*

Neue Lernreihen fuer Fachinformatiker*innen und weitere IT-Ausbildungsberufe werden zuerst in `docs/learning-units/` als Level-0-Quelle vorbereitet. Der `Lernreihen-Blueprint`, das `Lernreihen-Register`, das IT-Berufe-Mapping und die Vorlagen unter `docs/learning-units/templates/` sind verbindlich, bevor eine konkrete Level-1-/Level-2-Struktur gespiegelt wird. KI-Agenten duerfen Lernreihen, Lastenhefte, Berufsbild-Mappings, Reihenfolgen und ZIP-Paketierung vorbereiten, starten aber keine Spec-Kit-Laeufe fuer Lernende ohne ausdruecklichen Auftrag. Spec-Kit-Laeufe sind begleitende SDD-Aufgaben und ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Pruefungsvorbereitung.

*New learning series for IT specialist apprentices and additional IT training occupations are prepared first in `docs/learning-units/` as the level-0 source. The Learning Series Blueprint, Learning Series Register, IT occupation mapping, and templates under `docs/learning-units/templates/` are binding before a concrete level-1/level-2 structure is mirrored. AI agents may prepare learning series, intake files, occupation mappings, ordering, and ZIP packaging, but must not start learner Spec Kit runs without an explicit instruction. Spec Kit runs are companion SDD tasks and do not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.*

### Repository-Zweck / Repository Purpose

This is the **home-baseline** repository — the top-level workspace infrastructure for `~`. It manages bootstrapping new project workspaces as private GitHub or GitLab repositories and enforces security across all projects.

### Skripte / Scripts

All scripts live in `~/scripts/` and come in paired Bash (`.sh`) and PowerShell Core (`.ps1`) variants for cross-platform support. **Each script requires a corresponding Unix man-page (for `.sh`, in `docs/man/`), complete bilingual comment-based help (for `.ps1`), and a corresponding PowerShell Cmdlet (using the `Verb-Noun` pattern).**

#### Neuen Workspace anlegen / Bootstrap a New Workspace

```bash
# macOS/Linux
bash ~/scripts/bootstrap-workspace.sh <WorkspaceName> [repo-name] [description]
bash ~/scripts/bootstrap-workspace.sh --dry-run <WorkspaceName>   # preview only

# Windows (pwsh >= 7)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Name> [-RepoName <r>] [-WhatIf]
```

The script: detects existing sub-repos → adds them to `.gitignore` → copies standard scripts → `git init` + initial commit → creates a private GitHub repo via `gh repo create` or a private GitLab repo via `glab repo create` → pushes → installs hooks → updates `~/README.md`.

#### Git-Hooks installieren / Install Git Hooks

```bash
bash ~/scripts/install-hooks.sh          # macOS/Linux
pwsh ~/scripts/install-hooks.ps1         # Windows
```

#### Git-Identität einrichten / Set Up Git Identity

```bash
bash ~/scripts/setup-git-identity.sh              # interaktiv mit Auto-Erkennung
bash ~/scripts/setup-git-identity.sh --check-only # nur prüfen; Exit 1 bei Platzhalter
bash ~/scripts/setup-git-identity.sh --auto       # automatisch ohne Dialog
bash ~/scripts/setup-git-identity.sh --dry-run    # Vorschau

pwsh ~/scripts/setup-git-identity.ps1             # Windows (interaktiv)
pwsh ~/scripts/setup-git-identity.ps1 -CheckOnly  # Windows (nur prüfen)
```

Erkennt Platzhalter-Werte (`Your Name` / `your@email.example`) in `~/.gitconfig` und
hilft beim dauerhaften Einrichten. Erkennungsquellen: `gh api user`, macOS `dscl`,
Linux `getent`, vorhandene Git-Commits. Wird automatisch von `bootstrap-workspace.*`
aufgerufen — Bootstrap schlägt fehl, wenn die Identität noch Platzhalter enthält.

*Detects placeholder values in `~/.gitconfig` and sets the real identity. Detection
sources: `gh api user`, macOS `dscl`, Linux `getent`, existing commits. Called
automatically by `bootstrap-workspace.*` — bootstrap fails on placeholder identity.*

#### KI-Agenten-Verzeichnisse auf Secrets prüfen / Scan AI Agent Directories for Secrets

```bash
bash ~/scripts/scan-agent-secrets.sh [--fail-on-high]
pwsh ~/scripts/scan-agent-secrets.ps1
```

Scans `.claude/`, `.codex/`, `.gemini/`, `.junie/`, `.opencode/` for leaked credentials. Outputs `high=N medium=M low=L total=T`. Use `--fail-on-high` as a CI gate.

Wenn `gitleaks` installiert ist, fuehren die Scanner zusaetzlich `gitleaks git --pre-commit` fuer den aktuellen Git-Diff aus. Der gemeinsame `pre-push`-Hook nutzt `gitleaks` fuer die zu pushenden Commit-Ranges und faellt bei fehlendem `gitleaks` auf den bestehenden Regex-Scanner zurueck.

*When `gitleaks` is installed, the scanners additionally run `gitleaks git --pre-commit` for the current git diff. The shared `pre-push` hook uses `gitleaks` for the commit ranges being pushed and falls back to the existing regex scanner when `gitleaks` is missing.*

#### Agentenverwaltete Dateiänderungen auditieren / Audit Agent-Managed File Changes

```bash
bash ~/scripts/audit-agent-changes.sh snapshot
bash ~/scripts/audit-agent-changes.sh report
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile ~/scripts/audit-agent-changes.ps1 -Action report
```

Creates a local baseline below `~/.home-baseline/agent-audit/` and later compares current agent-managed files against that baseline. The report correlates changes heuristically with recent Codex, Claude, Copilot, and Continue logs. This is local audit state, not repository content.

#### Plattformübergreifende Testausgabe (macOS / Linux / Windows) / Cross-Platform Test Output (macOS / Linux / Windows)

When terminal output cannot be copy-pasted between machines, use the matching platform test script to collect results, commit and push them, then read from any other device:

```bash
bash ~/home-baseline-source/scripts/mac-test.sh     # macOS
bash ~/home-baseline-source/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-source/scripts/windows-test.ps1  # Windows
```

Each script collects: OS version, architecture, tool versions (git, gh, brew/apt/winget, rg, gitleaks, pwsh, node, uv, Python, .NET, Go, Java/Javac, Rust/Cargo, Swift, syft, specify, code, hx), package manager versions, sync-home and compliance check result. Output files: `mac-test-output.txt`, `linux-test-output.txt`, `windows-test-output.txt`.

### OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them.

**Skriptsprachenwahl / Script language choice:** Nach der OS-Erkennung vorhandene PowerShell-7-Skripte oder Cmdlets bevorzugen, wenn sie die Aufgabe loesen und `pwsh` verfuegbar ist. Fuer strukturierte lokale Automationen ist C# ueber `.NET` oder `mono` ein zulaessiger zweiter Weg, wenn Typisierung, Dateiformate oder Wiederverwendbarkeit davon profitieren. Erst wenn PowerShell oder C# nicht sinnvoll passen, die OS-nahe vorhandene Repo-Variante nutzen, auf macOS/Linux typischerweise Bash. Keine neue Sprache nur aus Bequemlichkeit einfuehren, wenn ein bestehendes Repo-Skript denselben Zweck erfuellt.

### Statistik-Pflege / Statistics Maintenance

- Maintain `docs/project-statistics.md` as the living statistics ledger for this repository.
- Update it after each completed feature/Lastenheft, each completed Spec-Kit phase, or when explicitly requested.
- Keep the `## Fortschreibungsprotokoll` section chronological: oldest entry first, newest entry last.
- Keep `## Gesamtstatistik` as the final top-level section; do not append later top-level sections after it.
- Treat `docs/project-statistics.config.json` plus the marked Profile 2 block as the binding data and presentation contract; update it with `render-project-statistics.*`.
- Profile 2 includes KPIs, artifact mix, 52-week daily activity, weekly and cumulative volume, phase or monthly volume, speedup gauges, and the experienced/Thorsten-Solo/AI-visible comparison.
- Charts use ASCII only: heatmap digits `0..4`, `-` for days not elapsed, and `#`/`.` gauges. Do not use Unicode blocks, color-only signals, or `\ | /` as an intensity scale.
- Keep phase slots stable and split series into blocks of 16. If no reliable phase data exists, show monthly volume without inventing phases.
- Keep every chart at 100 characters or fewer and add exact values plus a CEFR-B2 text alternative in German first and English second.
- Methodology v2 uses Git-tracked text and gross changes from non-merge commits while excluding the ledger, `STATS.md`, and binaries.
- Manual references for this repository are `80` lines/workday (conservative) and `100` lines/workday (Thorsten-Solo, scripting infrastructure).
- Default C#/.NET Thorsten-Solo baseline is `125` lines/workday unless the individual repository documents a justified deviation.
- TVöD conversion basis: `7.8 h` (`7h 48m`) per workday, `21.5` workdays per month, 30 vacation days until the end of 2026, 31 from 2027 onward.
- Shared guidance or statistics-method changes must update all five shared agent surfaces, including `.github/agents/copilot-instructions.md`, together in the same change.

### Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` is mandatory shared guidance, not optional wording.
- All user-facing artefacts must be checked for inclusive use: CLI output, documentation, HTML, UI, and generated templates.
- Treat WCAG 2.2 Level AA as the default accessibility baseline wherever the criteria apply.
- Keep text-first usability visible for keyboard-only use, screen readers, Braille displays, and text browsers.
- Review new or changed non-trivial logic for didactic inline-comment need: comments explain why, trade-off, boundary condition, historical deviation, or proof limit, not obvious code behavior.
- Follow DE first, EN second for shared guidance and learner-facing documentation; for large normative documents, a synchronised `.EN.md` companion is acceptable.
- Shared guidance must stay aligned across `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`; document any intentional deviation in the same change.

### Selbstaktualisierende Skripte / Self-Updating Scripts

Bei Sync- oder Bootstrap-Skripten, die ihr eigenes Verzeichnis kopieren oder ersetzen, vor echten Läufen immer Syntaxcheck und Vorschau verwenden: `bash -n`, `--dry-run` und `-WhatIf`. Echte Läufe aus einer stabilen Repo-Kopie wie `~/home-baseline-source/scripts/` starten oder sicherstellen, dass das Skript dorthin delegiert.

*For sync or bootstrap scripts that copy or replace their own directory, always use syntax checks and previews before real runs: `bash -n`, `--dry-run`, and `-WhatIf`. Start real runs from a stable repository copy such as `~/home-baseline-source/scripts/`, or ensure the script delegates there.*

Bei erzeugten oder schnell angepassten PowerShell-Skripten Variablen in Strings vor angrenzender Interpunktion immer mit `${Name}` abgrenzen, z. B. `${Path}:`. So entstehen keine fehlerhaften Bereichsvariablen wie `$Path:`.

*In generated or quickly adapted PowerShell scripts, always delimit variables before adjacent punctuation with `${Name}`, for example `${Path}:`. This avoids invalid scoped-variable parsing such as `$Path:`.*

Bei Workspace-/Repo-Migrationen eine vorhandene oder remote neuere `README.md` nicht stillschweigend überschreiben. Wenn die Remote-README kanonisch ist oder ausdrücklich erhalten bleiben soll, vor dem Push `fetch`/Rebase ausführen und `README.md` aus `origin/main` bewahren oder wiederherstellen.

*During workspace/repository migrations, do not silently overwrite an existing or newer remote `README.md`. If the remote README is canonical or must be preserved, fetch/rebase before pushing and preserve or restore `README.md` from `origin/main`.*

### Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Claude-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Claude work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

### Sicherheitsarchitektur / Security Architecture

The `.gitignore` uses a **whitelist model** (`/*` ignores everything; only explicitly listed files are tracked). Never add AI agent directories (`.claude/`, `.junie/`, etc.), credentials files, or dotfiles containing secrets to the tracked whitelist.

The `scripts/hooks/pre-push` hook blocks pushes if `gitleaks` finds a secret in pushed commit ranges or if secret-like filenames or credential patterns are found in tracked files. It is installed into `.git/hooks/` by `install-hooks.sh`.

Secrets are stored in the system credential store (e.g. macOS Keychain, Windows Credential Manager), accessed via shell helpers in your shell profile.

### Workspace-Struktur / Workspace Structure

Each sub-directory is an **independent git repository** (not a submodule). They are excluded from home-baseline tracking via `.gitignore`. Example workspaces:

| Directory | GitHub Repo |
|---|---|
| `~/MyProjects/` | `YOUR_USERNAME/myprojects-baseline` |

When adding a new workspace to `~/README.md`, insert a table row before the `<!-- workspace-table-end -->` marker.

### README-Pflege / README Maintenance

`~/README.md` is auto-updated by `bootstrap-workspace.sh` when a new workspace is created. The workspace table uses `<!-- workspace-table-end -->` as an insertion anchor. If editing manually, preserve that marker.

### Projektstatus / Repository Status

- **Sichtbarkeit / Visibility**: öffentliches Template-Repo — Azubis/andere können über „Use this template" ein eigenes Repo erstellen, ohne die Commit-History zu erben
- **Lizenz / License**: MIT
- **Branch-Schutz / Branch protection**: `main` erfordert PR; `enforce_admins: false` (Eigentümer kann direkt pushen)
- **CI-Runner**: `ubuntu-22.04`, `macos-15`, `windows-2022`
- **Compliance-Score**: 100 % (25/25 Checks) bei letzter verifizierten Installation

### Bekannte Fallstricke / Known Pitfalls

#### Windows: `gh auth login` in Hintergrundprozessen / Windows: `gh auth login` in Background Processes
`gh auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `gh auth login` in an **interactive terminal window** directly.
After login run: `gh auth setup-git` to configure the git credential helper.

#### macOS/Linux/Windows: `glab auth login` in Hintergrundprozessen / macOS/Linux/Windows: `glab auth login` in Background Processes
`glab auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `glab auth login` in an **interactive terminal window** directly.

#### Windows: `ssh-agent` braucht Adminrechte — stattdessen HTTPS nutzen / Windows: `ssh-agent` Requires Admin Rights — Use HTTPS Instead
The OpenSSH Agent service is disabled by default (needs admin to enable).
Use HTTPS + `gh auth setup-git` for all git push operations on Windows.

#### Windows: `-NoProfile` für `pwsh`-Subprozesse / Windows: `-NoProfile` for `pwsh` Subprocesses
`pwsh -File script.ps1` loads the user profile (Oh-My-Posh etc.), causing:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: always add `-NoProfile` to `pwsh` subprocess calls.

#### Migration: `migrate-workspace.*` seriell ausführen / Migration: Run `migrate-workspace.*` Serially
Do not run several `migrate-workspace.*` commands in parallel. Each migration starts `init-stats.*`,
which updates the shared level 0/1/2 statistics across the whole environment; parallel runs can block
each other and hit timeouts. Run the preview first, then execute real migrations one workspace at a
time with a longer timeout.

#### Linux: `git pull` braucht Rebase-Konfiguration / Linux: `git pull` Needs Rebase Config
Run once: `git config --global pull.rebase true`

#### Linux: SSH für GitHub-Push / Linux: SSH for GitHub Push
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
```

#### Testskripte: `--autostash` erforderlich / Test Scripts: `--autostash` Required
Scripts write the output file before pushing — `--autostash` prevents unstaged-changes error.
All test scripts use: `git pull --rebase --autostash origin main`

#### Windows: `$env:HOME` ist ein leerer String, nicht `$null` / Windows: `$env:HOME` Is an Empty String, Not `$null`
Der `??`-Operator fängt leere Strings nicht ab. Immer verwenden:
`$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`

#### `Copy-Item`-Verzeichnisverhalten / `Copy-Item` Directory Behaviour
Wenn das Ziel bereits existiert, kopiert `Copy-Item src dst -Recurse` das Verzeichnis **in** dst (erzeugt `dst/src/`).
Korrekt: `Copy-Item src/* dst/ -Recurse -Force`. Bash-Äquivalent: `cp -r src/. dst/`.

#### CI: Scanner muss aus dem Parent-Verzeichnis von `$GITHUB_WORKSPACE` laufen / CI: Scanner Must Run from the Parent Directory of `$GITHUB_WORKSPACE`
`check-homogeneity.sh/ps1` erwartet `TARGET_DIR` als auflösbaren Pfad.
Bei `$(basename "$GITHUB_WORKSPACE")` aus dem Repo-Root gelten alle Dateien als fehlend.

#### Bash `${#array[@]+...}` auf Ubuntu 22.04 nicht unterstützt / Bash `${#array[@]+...}` Not Supported on Ubuntu 22.04
Verursacht `bad substitution`. Bash-3-sichere Alternative: `for`-Schleife zum Zählen.

#### `hg-a11y`: Falsch-Positive durch fenced code blocks / `hg-a11y`: False Positives from Fenced Code Blocks
`# comment`-Zeilen in ` ``` `-Blöcken wurden als h1 interpretiert → `heading-gap-h1-to-h3`.
Fix: `$inFencedBlock`-Toggle auf ` ``` `-Zeilen.

#### `.gitignore`-Whitelist und `LICENSE` / `.gitignore` Whitelist and `LICENSE`
`git add LICENSE` wird lautlos ignoriert, wenn `LICENSE` nicht explizit in der Whitelist steht (`!LICENSE`).

#### Doppelte Headings im TOC / Duplicate heading anchors
GitHub hängt `-1`, `-2` etc. an Anker wenn derselbe Heading-Text mehrfach vorkommt.
TOC-Links für zweite Vorkommen müssen diesen Suffix enthalten.

#### Bilinguale Überschriften-Pflicht / Bilingual heading requirement
Alle Headings MÜSSEN das Format `DE / EN` haben. Nur-Deutsch-Headings brechen die bilinguale Konsistenz und verletzen WCAG 2.4.6.
Ausnahme: Eigennamen / Toolnamen (z. B. `### Homogeneity Guardian`) sind sprachneutral.

#### Code-Block-Sprachmarkierung (WCAG 4.1.1) / Code Fence Language Tagging (WCAG 4.1.1)
Jeder Code-Block benötigt eine Sprach-Angabe. Für ASCII-Grafiken, Dialog-Beispiele oder Verzeichnisstrukturen: ` ```text `.
Bare ` ``` ` ohne Sprache verletzt WCAG 4.1.1 (Syntaxanalyse).

#### WCAG 2.2 Level AA — README-Compliance / WCAG 2.2 Level AA — README Compliance
Die README folgt WCAG 2.2 Level AA. Kriterien-Tabelle im Abschnitt `## Barrierefreiheit / Accessibility (A11Y)`.
Einzige Plattform-Einschränkung: WCAG 3.1.2 (`lang`-Attribute) — GitHub entfernt HTML-Attribute.

#### ASCII-Box-Drawing-Tabellen: Zeilenbreite / ASCII Box-Drawing Tables: Line Width
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen mit: `$line.Length` (PowerShell) — alle Rahmen-Zeilen müssen denselben Wert liefern.

#### Spec-Kit-Verzeichnis initialisieren / Initialize the Spec-Kit Directory
Nie manuell aus `~/home-baseline-source/` kopieren. Stattdessen:
`specify init --here --force --integration {agent}` je Agent für `agy`, `opencode`, `claude`, `copilot` und `codex` ausführen.

#### Spec-Kit-Updates repo-weit / Repository-Wide Spec-Kit Updates
Fuer Level 0, Level 1 und Level 2 nicht mehr per Hand in jedem Repo nachziehen.
Stattdessen zuerst `bash scripts/update-spec-kit.sh --dry-run` bzw.
`pwsh scripts/update-spec-kit.ps1 -WhatIf` ausfuehren, danach bei Bedarf
`--commit --push` / `-Commit -Push`.

Das Skript erkennt neue Repos dynamisch ueber `.git` plus `.specify/`, sichert
`.specify/memory/constitution.md`, legt die lokalen Governance-Templates wieder
auf und nimmt `RiderProjects/TuiVision` normal mit. OpenCode wird nur ueber
`.opencode/command/*.md` getrackt; `.opencode`-Caches, Sessions, Logs,
Credentials und lokale Abhängigkeiten bleiben ausgeschlossen.

Die Standard-Template-Quelle ist das oeffentliche `home-baseline`-Repo, aus dem
das Skript laeuft. Private Repos wie `RiderProjects/TuiVision` duerfen nur
bewusst mit `--template-source` / `-TemplateSource` als Override genutzt werden.

#### Git-Identität: Platzhalter-Autor in Commits / Git Identity: Placeholder Author in Commits
Commits mit `Your Name <your@email.example>` als Autor entstehen, wenn `~/.gitconfig`
nach dem Klonen des Template-Repos nicht angepasst wurde.
**Dauerhafte Lösung**: `setup-git-identity.sh` einmalig ausführen — es erkennt die echte
Identität automatisch aus `gh api user`, macOS `dscl`, Linux `getent` oder vorhandenen
Commits und schreibt sie in `~/.gitconfig`.
`bootstrap-workspace.*` schlägt jetzt bereits fehl, wenn Platzhalter erkannt werden.
```bash
bash ~/scripts/setup-git-identity.sh              # interaktiv, mit Auto-Erkennung
bash ~/scripts/setup-git-identity.sh --check-only # nur prüfen
pwsh ~/scripts/setup-git-identity.ps1             # Windows
```

#### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` bedeutet bei GitHub nur read-only, nicht unsichtbar. Public archived Repos bleiben ohne Anmeldung sichtbar.
Archivierte Repos sind API-seitig read-only; Sichtbarkeit ändern geht deshalb nur über:
`archived=false` → `private=true` → `archived=true`.

Öffentliche Forks lassen sich nicht einfach auf private setzen. Optionen: öffentlich archiviert lassen, löschen, oder als private Mirror-Repos neu anlegen. Vor Löschungen die Repo-Liste eng festlegen; `gh repo delete` benötigt ggf. `gh auth refresh -h github.com -s delete_repo`.

Für Aktivitätsbewertungen `pushedAt` statt `updatedAt` verwenden, weil `updatedAt` durch Metadatenänderungen springt. Stars sind kontogebundene Metadaten und können über `DELETE /user/starred/{owner}/{repo}` entfernt werden; danach `user/starred` gegenprüfen.

#### Lastenheft nach Feature-Abschluss umbenennen / Rename Lastenheft After Feature Completion
Nach vollständiger Implementierung eines Features MUSS das zugehörige `Lastenheft_*.md` umbenannt werden:
```bash
bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>   # macOS/Linux
pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>   # Windows
```
Beispiel: `Lastenheft_Foo.md` + Branch `003-feature` → `Lastenheft_Foo.003-feature.md`.
Dieser Schritt ist seit `constitution v1.1.1` als letzter Task der Polish-Phase in jeder `tasks.md` enthalten.
Fehlte bei Features 003, 005 und 006, weil das Template den Schritt nicht vorsah.

### Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

DE: Die Versionsangaben beschreiben den zentralen Release-Sollstand. Diese
Quellenpflege aktualisiert keine installierten Presets oder Home Runtime.
Rollout und Community-Einreichung brauchen getrennte Auftraege.
EN: Version references describe the central release target, not installation
state. Source binding updates install no presets and sync no Home Runtime.
Rollout and community submission require separate requests.

DE: Architecture v0.6.5 trennt C5 Typ 1 (Zeitpunkt), Typ 2 (Zeitraum und
Wirksamkeit) und Unknown. C3A v1.0 verlangt sichtbare 30 Kriteriengruppen mit
konkreten C-/AC-Kennungen; SI ist Erlaeuterung. Fehlende Evidence bleibt Open.
Authoring 0.3.10, Review 0.2.7 und Sequencing 0.2.13 teilen denselben
Konfigurationsvertrag fuer Active ohne Folge-Kandidat, leeres Idle und
verschachtelte Git-Repositories. Installation ist keine Laufberechtigung.

EN: Architecture v0.6.5 separates C5 Type 1/as-of-date, Type 2/period
effectiveness and Unknown. C3A v1.0 retains all 30 criterion groups and exact
C/AC identifiers; SI informs interpretation. Missing evidence stays Open.
The coordinated Intake versions share Active/no-next-candidate, empty Idle
and nested-Git-index rules. Installation grants no execution authority.

- Standard-Preset-Set: `security-governance` v0.7.5 prio 10, `architecture-governance` v0.6.6 prio 20, `isaqb-architecture-governance` v0.2.6 prio 30, `a11y-governance` v0.4.7 prio 40, `cross-platform-governance` v0.2.6 prio 50, `agent-parity-governance` v0.4.6 prio 60, `autonomous-run-governance` v0.4.12 prio 70, `parallel-autonomous-run-governance` v0.2.13 prio 80.
- Optionale Presets: `model-routing-governance` v0.2.9 prio 61 sowie Intake Authoring v0.3.14 prio 64, Intake Review v0.2.9 prio 65 und Intake Sequencing v0.2.14 prio 66 bleiben ausserhalb der Standard-Achtermatrix. Thorstens verwaltete Flotte installiert alle vier ueber `model-routing-twelve-governance-presets`; bestehende Neun-, Zehn- und Elf-Preset-Profile bleiben kompatibel, ersetzen aber nicht das Zwölfer-Flottenprofil. Konkrete Modelle werden pro Rechner erkannt und nie aus einem Remote-Repository uebernommen. *Optional Model Routing v**0.2.9** and the three Intake Governance presets remain outside the standard eight. Thorsten's managed fleet installs all four through `model-routing-twelve-governance-presets`; compatible nine-, ten-, and eleven-preset profiles do not replace that fleet profile. Concrete models are discovered per machine and never copied from a remote repository.*
- Intake Authoring trennt Create, Read, Update und Delete. Create schreibt nur neue Ziele; Update benoetigt aktuelle ausdrueckliche Autoritaet und archiviert den Vorgaenger; Delete verschiebt Ziel und Receipt in ein hashgebundenes Archiv und hinterlaesst einen Tombstone; Read bleibt standardmaessig eine read-only Summary. Oeffentliche Quellen sind auf statisches HTTPS mit begrenzten Antworten und SSRF-Schutz beschraenkt. Mehrere Intakes benoetigen einen vollstaendigen Series-Vorschlag und ausdrueckliche Freigabe; partielle Publikation ist unzulaessig. Materielle Fragen werden einzeln und hoechstens fuenfmal gestellt. `ReadyForReview` startet Review, Specify oder autonome Laeufe nie automatisch. *Intake Authoring separates Create, Read, Update, and Delete; protects updates and logical deletion with archived hash evidence; limits URL input to bounded public HTTPS; and requires explicit approval before publishing a complete intake series. It never infers overwrite, remote authority, or downstream execution.*
- Intake Review akzeptiert bei aktiver Projekt- oder Kampagnenpolicy nur aktuelle `Ready`- oder menschlich akzeptierte `ReadyWithAcceptedRisks`-Ergebnisse; Critical/High, offene materielle Fragen, Hash-Drift oder fehlende Worker-Coverage blockieren. Review und Status sind read-only, Repair benoetigt ausdrueckliche Aenderungsautoritaet. Series-Reviews verwenden Schema 1.1, binden den normalisierten Request-Hash und pruefen exakte Zielreihenfolge, explizite Roots sowie einen azyklischen Graphen; nicht belegbare Vorgaengerbeziehungen fuehren zu `NeedsClarification`. *Series reviews use schema 1.1, bind the normalized request hash, and verify exact target order, explicit roots, and an acyclic graph; unprovable predecessor relations result in `NeedsClarification`.*
- Intake Sequencing verwaltet nur Reihenfolge und Lifecycle bereits vorhandener Intakes. Create/Update/Delete benoetigen ausdrueckliche aktuelle Autoritaet; Read/Status/Next bleiben read-only. `next` meldet startfaehige Ziele oder konkrete Blocker, startet aber weder Review noch Specify noch autonome Laeufe. Bindende Kanten werden von reiner Liefer- oder Shared-Writer-Serialisierung unterschieden; unklare Graph- oder Abschlussfakten bleiben `NeedsClarification`. *Intake Sequencing manages only the order and lifecycle of existing intakes. It separates binding dependencies from delivery-only serialization, requires explicit write authority, and never starts downstream work.*
- `autonomous-run-governance` v0.4.12 prio 70 ist Teil der Standard-Achtermatrix. Ein vollständiger autonomer Lauf bleibt ausdrücklich delegationspflichtig; die Installation allein erteilt weder Ausführungsberechtigung noch Remote-, Merge-, Bypass- oder Provider-Rechte und `LocalImplementation` bleibt Default. Dokumentations-, Status-, Schema- oder Evidence-Änderungen gelten erst dann als testfrei, wenn keine ausführbaren Validatoren die geänderten Pfade, Marker, Schemas oder Zustandswerte konsumieren. Vor autorisierten Commits wird der exakt beabsichtigte Kandidat mit dem Delivery-Set-Validator im Staged-Modus einschließlich exakter Pfad- und Index-Hash-Bindung geprüft; fremde Änderungen bleiben unberührt. Vor einem Merge wird jeder Acceptance-Gate dem tatsächlich ausgeführten Workflow, Job, Runner beziehungsweise der Plattform und dem Befehl zugeordnet; grüne Namen oder ein Bypass ersetzen keinen technischen Nachweis. Bewusst pausierte Läufe werden als `PausedByUser` gespeichert und nur über `speckit.autonomous-resume` fortgesetzt; `speckit.autonomous-stop` wirkt kooperativ am nächsten sicheren Grenzpunkt, und ein gespeicherter Delivery-Modus ist keine aktuelle Berechtigung. Nach Preset- oder Governance-Drift werden neue zwingende Korrektheits-, Sicherheits-, Berechtigungs- und Evidenzregeln minimal mit akzeptierten Plan-, Task- und Checklist-Artefakten abgeglichen; reine Effizienzpräferenzen lösen keine rückwirkende Neugenerierung aus. Die lesbare Skill-Überschrift `Deliver` ist kein Run-State-Wert; für Remote-Closeout gelten ausschließlich `Publish`, `Review` oder `MergeAndSync`.
- `parallel-autonomous-run-governance` v0.2.13 prio 80 ist Teil der Standard-Achtermatrix. Die Installation startet keine Kampagne und erteilt keine zusaetzlichen Remote-, Merge-, Bypass-, Abbruch-, Secret- oder Provider-Rechte. Kampagnen bleiben ausdruecklich delegationspflichtig, verwenden getrennte Worktrees und maximal drei gleichzeitig aktive Worker. Schema 1.1 erlaubt ein `runnerProfile` je Worker mit Kampagnen-Fallback; Modell und Reasoning-Stufe sind optionale, nicht geheime Metadaten und werden ohne Deklaration nicht erraten. Konsolidierung verlangt exakten Head, aktuelle Review- und Check-Evidenz, ist nach Teilmerges fortsetzbar und setzt `Completed` erst nach Synchronisation, manifestdeklarierten idempotenten Post-Merge-Aktionen und Abschlussvalidierung.
- Reale Preset-8-Kampagnen setzen in jedem Worker-Repository ein installiertes und aktiviertes `autonomous-run-governance >=0.2.2` voraus. Preset 7 mit Prioritaet `70` liefert Lebenszyklus, Evidenz und Berechtigungsgrenzen; Preset 8 mit Prioritaet `80` koordiniert die Kampagne. Fehlt Preset 7, ist es deaktiviert oder zu alt, endet der Preflight vor dem Worker-Start. `requireAutonomousPreset: false` bleibt auf isolierte interne Fixtures begrenzt und ist kein Produktionsmodus. *Real Preset 8 campaigns require installed and enabled `autonomous-run-governance >=0.2.2` in every worker repository. Preset 7 at priority `70` supplies lifecycle, evidence, and authority boundaries; Preset 8 at priority `80` coordinates the campaign. Missing, disabled, or outdated Preset 7 fails preflight before worker start. `requireAutonomousPreset: false` remains limited to isolated internal fixtures and is not a production mode.*
- `a11y-governance` v0.4.7 ergänzt didaktische Inline-Code-Kommentar-Governance für neue oder geaenderte nicht-triviale Logik.
- `security-governance` v0.7.5 fuehrt `AI-SBOM` weiter als bedingt anwendbare Supply-Chain-Evidenz, ergänzt sprachspezifische Secure-Coding-Profile und ergänzt regulatorische Anwendbarkeit für DS-GVO, NIS2, CRA, EU AI Act und DORA. Reine Entwicklungswerkzeug-Nutzung bleibt `N/A`; KI-Runtime-/Produktkomponenten benoetigen Evidenz nach G7/BSI AI-SBOM-Clustern; Beispielprodukt, Entwicklungswerkzeuge und Organisation brauchen getrennte Anwendbarkeitsnachweise; Ausbildung ist keine pauschale Ausnahme.
- `architecture-governance` v0.6.6 ergänzt `BSI C3A` als bedingte Cloud-Autonomie-Evidenz und `BSI C5` als bedingte Cloud-Compliance-Assurance-Evidenz für Cloud-Service-Auswahl, Provider-Abhängigkeiten, Audit-/Nachweisstand, Shared Responsibility und Betriebsnachweise.
- Alle acht Presets enthalten ab diesem Release-Block audit-ready Spec-Kit-Run-Evidenz: `Applicable` / `N/A` / `Open`, Begründung, Evidenzpfad, Reviewer, Restrisiko und Follow-up muessen im aktuellen Spec-Kit-Lauf dokumentiert werden.
- Die ursprünglichen sechs Presets sind seit 2026-05-04 und `autonomous-run-governance` v0.2.2 ist seit 2026-07-17 im `github/spec-kit` Community-Katalog enthalten und liegen zusätzlich als veröffentlichte Repos unter `https://github.com/hindermath/spec-kit-preset-*`.
- `parallel-autonomous-run-governance` v0.2.13 ist eigenstaendig veroeffentlicht; v0.2.2 wurde mit `github/spec-kit#3591` fuer den Community-Katalog eingereicht.
- Registrierte Level-0-, Level-1- und Level-2-Repositories installieren bei vorhandener Spec-Kit-Integration standardmäßig alle acht Presets aus `scripts/config/spec-kit-governance-presets.json`, sofern keine begründete Ausnahme dokumentiert ist.
- Referenz-Rollout für alle acht Presets: `RiderProjects/TinyPl0`, `RiderProjects/TinyCalc`, `RiderProjects/TuiVision`, `RiderProjects/InventarWorkerService`.
- Installation erfolgt bevorzugt mit `install-spec-kit-governance-presets.*` aus der zentralen Matrix; die Skriptlogik enthaelt keine fest eingebauten Versionen. Bei neuen Preset-Releases zuerst die Matrix aktualisieren, dann bestehende Repos bewusst mit `--force` / `-Force` nachziehen.
- Flotten-Rollouts erfassen Level-0, Level-1 und Level-2 explizit. Eine reine Level-2-Registry beweist keine vollstaendige Abdeckung; jeder Zielstatus wird bis Installation, exakter Matrixvalidierung, Commit, Push und Remote-Synchronisation verfolgt.
- Vor dem Staging werden generierte Preset-/Agentenpfade mit dem gesamten Arbeitsbaum abgeglichen. Fremde Aenderungen bleiben unberuehrt; bei Konflikten wird ein sauberer Worktree statt eines erzwungenen Misch-Commits verwendet.
- Aktuelle normative Sechs-/Siebenerangaben werden auf die Achtermatrix migriert. Historische Statistik-, Changelog-, Feldnachweis- und Kompatibilitaetsangaben bleiben erhalten und werden durch einen dokumentierten Allowlist-Scan unterschieden.
- Provider-/Billing-Ablehnung, technischer Gate-Fehler und bestandener Gate sind getrennte Ergebnisse. Bypass oder gruene Sammelnamen ersetzen keinen exakten technischen Nachweis.
- `.specify/presets/` und generierte Agenten-/Command-Dateien committen, wenn Presets Projekt-Policy sind; `.specify/presets/.cache/` nie committen.
- Nach Installation oder Update prüfen: `specify preset list`, mindestens ein `specify preset info <id>`, bei Template-Fragen zusätzlich `specify preset resolve <template>`.
- Die veroeffentlichten `hindermath/spec-kit-preset-*`-Repositories sind die alleinigen Produktquellen; ihre Git-Arbeitskopien liegen unter `~/SpecKitPresetProjects/`. Home Baseline verwaltet Profile, gepinnte Release-Bezuege und Projektintegrationen, keine parallelen Produkt-Scaffolds.
- Preset-Verbesserungen direkt im jeweiligen eigenstaendigen Git-Repository entwickeln, pruefen und veroeffentlichen. Bestehende Installationen der zwoelf ausgerollten Presets und vorhandene Assurance-Installationen bleiben bei einer Quellenbereinigung unveraendert. Ueber jede weitere Verteilung des 13. Presets entscheidet Thorsten separat; Katalogaufnahme oder Quellenpflege erteilt keine Rollout-Autoritaet.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `scripts/templates/*` ebenfalls aktualisiert werden müssen.
- Bei jeder Preset-Version oder Prioritätsänderung zuerst `scripts/config/spec-kit-governance-presets.json` aktualisieren und danach README-Tabellen, Constitution, Agenten-Dateien, `scripts/templates/speckit-workflow-section.md` und Agenten-Templates gemeinsam prüfen.
- Community-Katalog-Einreichungen an `github/spec-kit` strikt einzeln erstellen und aktivieren: erst den erzeugten PR prüfen und mergen lassen sowie das Issue abschließen, dann das nächste Issue einreichen. Bei einer bereits vorhandenen Warteschlange nur den nächsten Kandidaten für `preset-submission` benennen; keine neuen Batch-Issues oder parallelen Label-Anfragen. Grundlage ist der Maintainer-Hinweis in `github/spec-kit#3679`; der Betriebsvertrag steht in `docs/maintenance/Preset-and-Fleet-Operations-Lessons-Learned.md`. *Submit and activate `github/spec-kit` community catalog updates strictly one at a time. Complete the generated PR and issue before filing the next issue; for an existing queue, name only the next label candidate. Do not create new batch issues or parallel label requests.*

*Fleet rollouts explicitly cover level 0, level 1, and level 2 and track each
target through installation, exact matrix validation, commit, push, and remote
synchronization. Separate generated paths from unrelated work before staging.
Migrate current normative six/seven references while preserving allowlisted
history and compatibility aliases. Provider refusal, technical gate failure,
and passing evidence are distinct; bypass is not technical proof.*
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Standard preset set: `security-governance` v0.7.5 prio 10, `architecture-governance` v0.6.6 prio 20, `isaqb-architecture-governance` v0.2.6 prio 30, `a11y-governance` v0.4.7 prio 40, `cross-platform-governance` v0.2.6 prio 50, `agent-parity-governance` v0.4.6 prio 60, `autonomous-run-governance` v0.4.12 prio 70, and `parallel-autonomous-run-governance` v0.2.13 prio 80. `a11y-governance` v0.4.7 adds didactic inline-code-comment governance for new or changed non-trivial logic. `architecture-governance` v0.6.6 adds conditional `BSI C3A` cloud-autonomy evidence and `BSI C5` cloud-compliance assurance evidence for cloud-service selection, provider dependencies, audit/assurance status, shared responsibility, and operational evidence. `security-governance` v0.7.5 keeps conditional `AI-SBOM` evidence, language-specific secure-coding profiles, and regulatory applicability screening for GDPR, NIS2, CRA, EU AI Act, and DORA: development-tool-only AI usage is `N/A`, AI runtime/product components require G7/BSI AI-SBOM cluster evidence, and record scoped legal applicability independently of educational purpose and AI-SBOM; unknown roles remain `Open`. All eight presets now include audit-ready Spec-Kit run evidence: `Applicable` / `N/A` / `Open`, rationale, evidence path, reviewer, residual risk, and follow-up must be documented for the current Spec-Kit run. The original six presets have been in the `github/spec-kit` community catalog since 2026-05-04, and `autonomous-run-governance` v0.2.2 was verified there on 2026-07-17. All eight are also published under `https://github.com/hindermath/spec-kit-preset-*`. `parallel-autonomous-run-governance` v0.2.13 was submitted to the community catalog as `github/spec-kit#3591`. Registered level-0, level-1, and level-2 repositories with Spec Kit default to all eight presets from `scripts/config/spec-kit-governance-presets.json` unless a justified exception is documented. Use `install-spec-kit-governance-presets.*` so preset versions stay centralized in the matrix. Commit `.specify/presets/` and generated agent command updates when presets are project policy, but never commit `.specify/presets/.cache/`. Verify installs with `specify preset list`, `specify preset info`, and where relevant `specify preset resolve`. The published hindermath preset repositories are the sole product sources; develop and release changes in their own Git working clones. Home Baseline maintains profiles, pinned release references, and integrations. Source cleanup preserves the twelve deployed presets and existing assurance installations. Thorsten decides any further distribution of the thirteenth preset separately; catalog acceptance never grants rollout authority. Preset-rule changes and preset version/priority changes require reviewing the central matrix, constitution, README tables/install snippets, all agent guidance files, and relevant templates together. Community/catalog coordination happens in `github/spec-kit#2362`.*

### Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI (existing, required), `glab` CLI (optional for GitLab), `tar` (system built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc`, `~/README.md`, `~/.gitignore` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (new) · `gh` ≥ 2.30 (existing) · `git` ≥ 2.30 (existing) (006-gitlab-support)
- N/A — file modifications to existing scripts and `~/README.md` (006-gitlab-support)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

### Letzte Änderungen / Recent Changes
- 003-git-config-scope: Added Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency)
- 006-gitlab-support: Added GitLab CLI support documentation, `glab auth login` pitfall guidance, and spec artifacts for GitLab bootstrap support
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking

## Gemini

### Überblick & Architektur / Project Overview & Architecture

Die "home-baseline" verfolgt einen **Multi-Repo-Ansatz**. Das Root-Verzeichnis selbst ist ein Git-Repository, das jedoch alle Unterverzeichnisse (die eigenen Git-Repositories enthalten) per `.gitignore` ignoriert.

- **Zweck:** Bereitstellung von Bootstrap-Skripten, Sicherheits-Hooks und globalen Konfigurationen.
- **Automatisierung:** Nutzung von Bash (macOS/Linux) und PowerShell Core (Windows) für plattformübergreifende Kompatibilität.
- **Sicherheit:** Integrierter Secret-Scan für KI-Agenten-Verzeichnisse (`.agents`, `.gemini`, `.claude`, etc.).

### Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-source` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-source   # start Antigravity CLI here
agy
# → make changes, commit, push

# After runtime-distribution changes: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-source` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |

Der persönliche Fork unter `~/home-baseline-source` bleibt dauerhaft als
versionierte Level-0-Quelle erhalten. `sync-home.*` verteilt nur
`homeRuntime`: Skripte, gemeinsame Agent-Guidance und ausgewaehlte
Spec-Kit-Oberflaechen. Dokumentation, Specs, Preset-Quellen und Evidence werden
direkt im Klon gelesen; `STATS.md` und private Agentenzustaende bleiben lokal.
Nach reinen Source-only-Aenderungen ist kein Home-Sync erforderlich. Vor echten
Laeufen `--check-only` / `-CheckOnly` verwenden; `--force` / `-Force` nur nach
Pruefung der Konflikte. In der ABS-DD-Sandbox die eingebundene Referenz direkt
verwenden; der allgemeine schreibende Home-Sync bleibt gesperrt. Nur ein
ausdruecklich angeforderter `--runtime-only`-/`-RuntimeOnly`-Lauf darf
manifestgebundene `homeRuntime` in die Container-Betriebskopie verteilen, ohne
Pull, Commit, Git-Konfigurations- oder Identitaetsaenderung.

*Keep the personal fork at `~/home-baseline-source` permanently as the versioned
Level 0 source. `sync-home.*` distributes only `homeRuntime`: scripts, shared
agent guidance, and selected Spec Kit surfaces. Read documentation, specs,
preset sources, and evidence directly from the clone; `STATS.md` and private
agent state remain local. Source-only changes do not require Home sync. Use
`--check-only` / `-CheckOnly` before a real run and review conflicts before
using force. General writing Home sync remains host-only; only an explicitly
requested runtime-only run may distribute manifest-bound `homeRuntime` inside
the container without pull, commit, Git configuration, or identity changes.*

### Zentrale Abläufe & Befehle / Key Workflows & Commands

#### Neuen Workspace einrichten / Create a New Workspace
Um ein neues Projektverzeichnis als standardisierten Workspace mit GitHub-Anbindung zu initialisieren:
```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Windows (PowerShell Core)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>
```
*Dieser Vorgang erstellt das Verzeichnis, initialisiert Git, kopiert die Baseline-Skripte, erstellt ein privates GitHub-Repo und installiert die Hooks.*

#### Workspace entfernen / Remove a Workspace
Workspace sicher entfernen (Remote, lokales Verzeichnis, Artefakte):
```bash
# macOS / Linux
bash ~/scripts/teardown-workspace.sh <WorkspaceName>
bash ~/scripts/teardown-workspace.sh <WorkspaceName> --backup      # Archiv vor Löschung
bash ~/scripts/teardown-workspace.sh <WorkspaceName> --keep-remote # Remote behalten
bash ~/scripts/teardown-workspace.sh -- <WorkspaceName>            # Name beginnt mit -
```
```powershell
# Windows
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name>
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name> -Backup
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name> -KeepRemote
```

#### Sicherheit & Wartung / Security & Maintenance
- **Git-Hooks installieren (in jedem Workspace):**
  `bash scripts/install-hooks.sh`
- **Git-Identität prüfen und einrichten (einmalig nach Klonen):**
  `bash scripts/setup-git-identity.sh --check-only`  — prüfen / check
  `bash scripts/setup-git-identity.sh`               — einrichten / set
  `pwsh -NoProfile scripts/setup-git-identity.ps1 -CheckOnly`  — Windows prüfen
  `pwsh -NoProfile scripts/setup-git-identity.ps1`             — Windows einrichten
- **Manueller Secret-Scan:**
  `bash scripts/scan-agent-secrets.sh`
  Wenn `gitleaks` installiert ist, prueft der manuelle Scan zusaetzlich den aktuellen Git-Diff mit `gitleaks git --pre-commit`.
- **Lokales Agent-Audit für spaetere Herkunftsspur:**
  `bash scripts/audit-agent-changes.sh snapshot`
  `bash scripts/audit-agent-changes.sh report`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report`

Das Agent-Audit speichert eine lokale Baseline unter `~/.home-baseline/agent-audit/` und vergleicht spaetere Aenderungen in agentverwalteten Dateien gegen diese Baseline. Die Zuordnung zu Codex, Claude, Copilot oder Continue ist bewusst heuristisch und dient der lokalen Nachvollziehbarkeit, nicht als manipulationssicherer Beweis.

#### Plattform-Test / Platform Test
Falls Terminal-Output nicht zwischen Maschinen copy-pastebaar ist, passende Test-Scripts verwenden:
```bash
bash ~/home-baseline-source/scripts/mac-test.sh     # macOS
bash ~/home-baseline-source/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-source/scripts/windows-test.ps1  # Windows
```
Ergebnisse landen als `mac-test-output.txt`, `linux-test-output.txt` bzw. `windows-test-output.txt` im Repo und können von jedem Gerät gelesen werden.

*Use the matching platform test script to collect results, commit and push them. Output files are in the repo and readable from any device.*

### OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

Zu Beginn jeder Session das Betriebssystem ermitteln und die passende Skript-Variante aufrufen:

| Betriebssystem | Shell | Endung | Erkennung |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Regel:** Auf Windows immer `pwsh scripts/xyz.ps1` aufrufen, auf macOS/Linux immer `bash scripts/xyz.sh`. Beide Varianten sind funktional äquivalent — nie mischen.

**Skriptsprachenwahl / Script language choice:** Nach der OS-Erkennung vorhandene PowerShell-7-Skripte oder Cmdlets bevorzugen, wenn sie die Aufgabe loesen und `pwsh` verfuegbar ist. Fuer strukturierte lokale Automationen ist C# ueber `.NET` oder `mono` ein zulaessiger zweiter Weg, wenn Typisierung, Dateiformate oder Wiederverwendbarkeit davon profitieren. Erst wenn PowerShell oder C# nicht sinnvoll passen, die OS-nahe vorhandene Repo-Variante nutzen, auf macOS/Linux typischerweise Bash. Keine neue Sprache nur aus Bequemlichkeit einfuehren, wenn ein bestehendes Repo-Skript denselben Zweck erfuellt.

### Statistik-Pflege / Statistics Maintenance

- `docs/project-statistics.md` ist das lebende Statistik-Ledger dieses Repositories.
- Nach jedem abgeschlossenen Feature/Lastenheft, nach jeder abgeschlossenen Spec-Kit-Phase und auf explizite Anforderung aktualisieren.
- `## Fortschreibungsprotokoll` chronologisch halten: ältester Eintrag oben, neuester unten.
- `## Gesamtstatistik` bleibt immer der letzte Top-Level-Abschnitt.
- `docs/project-statistics.config.json` und der markierte Profil-2-Block bilden den verbindlichen Vertrag; mit `render-project-statistics.*` aktualisieren.
- Profil 2 zeigt KPI, Artefaktmix, 52-Wochen-Tagesaktivität, Wochen- und kumulatives Volumen, Phasen- oder Monatsvolumen, Speedup-Gauges und den Vergleich Erfahren/Thorsten-Solo/KI-sichtbar.
- Nur ASCII verwenden: Heatmap `0..4`, `-` für noch nicht abgelaufene Tage, Gauges `#`/`.`. Keine Unicode-Blöcke, Farbcodierung oder `\ | /` als Intensitätsskala.
- Phasenslots stabil halten und ab 17 Einträgen in 16er-Blöcke teilen. Ohne belastbare Phasendaten Monatsvolumen zeigen und keine Phasen erfinden.
- Jedes Diagramm bleibt höchstens 100 Zeichen breit und erhält genaue Werte sowie eine CEFR-B2-Textalternative in DE zuerst, EN danach.
- Methodik v2 nutzt Git-getrackten Text und Bruttoänderungen aus Nicht-Merge-Commits; Ledger, `STATS.md` und Binärdaten bleiben ausgeschlossen.
- Für dieses Repository gelten `80` Zeilen/Arbeitstag als konservative Referenz und `100` Zeilen/Arbeitstag als Thorsten-Solo-Basis für Scripting-Infrastruktur.
- Gemeinsame Default-Basis für C#/.NET-Repositories: `125` Zeilen/Arbeitstag, sofern das jeweilige Repo keinen abweichenden, begründeten Wert dokumentiert.
- TVöD-Basis: `7.8 h` pro Arbeitstag, `21.5` Arbeitstage pro Monat, 30 Urlaubstage bis Ende 2026 und 31 ab 2027.
- Änderungen an Statistikmethodik oder gemeinsamer Guidance immer gleichzeitig in allen fünf Agentenflächen einschließlich `.github/agents/copilot-instructions.md` pflegen.

### Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` gilt repo-weit als verbindlicher Leitsatz.
- Alle nutzerseitigen Artefakte müssen barrierefrei gedacht und geprüft werden: CLI-Ausgaben, Dokumentation, HTML, UI und generierte Templates.
- WCAG 2.2 Level AA ist die praktische Standard-Basis, sobald die Kriterien auf das Artefakt anwendbar sind.
- Inhalte müssen in textorientierten Assistenz-Setups nutzbar bleiben, besonders mit Tastatur, Screenreadern, Braille-Zeilen und Textbrowsern.
- Neue oder geänderte nicht-triviale Logik wird auf didaktischen Inline-Kommentarbedarf geprüft: Kommentare erklären Warum, Trade-off, Randbedingung, historische Abweichung oder Proof-Grenze, nicht offensichtliches Was.
- Gemeinsame Guidance und lernrelevante Doku folgen DE zuerst, EN danach; bei großen normativen Dokumenten ist eine synchron gepflegte `.EN.md`-Parallelfassung zulässig.
- Shared guidance nie nur hier ändern: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` werden gemeinsam gepflegt; Abweichungen müssen in derselben Änderung begründet werden.

### Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Gemini-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Gemini work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

### Zentrale Verzeichnisse / Key Directories

- `~/scripts/`: Zentrale Automatisierungsskripte (Bootstrap, Secret-Scan, Hook-Installer).
- `~/`: Weitere Workspace-Verzeichnisse werden per `bootstrap-workspace` angelegt und hier eingetragen.
- `~/.gemini/`: Globale Gemini-Konfiguration und persistente Erinnerungen.

### Entwicklungskonventionen / Development Conventions

- **Plattformunabhängigkeit & Dokumentation:** Alle kritischen Skripte müssen sowohl als `.sh` (Bash) als auch als `.ps1` (PowerShell Core) vorliegen. Jedes Skript erfordert eine Unix man-Page (`.sh`, in `docs/man/`), eine vollständige PowerShell-Hilfe (`.ps1`) und muss zusätzlich als PowerShell Cmdlet (Advanced Function) im `Verb-Noun` Format verfügbar sein.
- **Sicherheits-Standard:** Jedes Projekt muss über einen `pre-push` Hook verfügen, der `gitleaks` für zu pushende Commit-Ranges nutzt, wenn verfügbar, und zusätzlich den bestehenden Regex-Fallback für Secret-Scanning ausführt.
- **Git-Strategie:** Keine Submodules; stattdessen werden Sub-Repos durch die Baseline-Skripte in der `.gitignore` des übergeordneten Workspaces erfasst.

### Projektstatus / Repository Status

- **Sichtbarkeit:** Öffentliches **Template-Repo** — über „Use this template" nutzbar; kein Fork, keine History-Übertragung
- **Lizenz:** MIT
- **Branch-Schutz:** PR-Pflicht auf `main`; Admin (Eigentümer) kann direkt pushen (`enforce_admins: false`)
- **CI-Runner:** Ubuntu 22.04 · macOS 15 · Windows 2022
- **Compliance-Score:** 100 % (25/25 Checks)

### Bekannte Fallstricke / Known Pitfalls

#### `gh auth login --web` bleibt hängen / `gh auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

#### `glab auth login --web` bleibt hängen / `glab auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

#### `gh`-Keyring ungültig (Windows) / `gh` Keyring Invalid (Windows)
Windows Credential Store korrupt.
`gh auth logout` + neu anmelden; danach `gh auth setup-git`.

#### `ssh-agent` startet nicht (Windows) / `ssh-agent` Does Not Start (Windows)
Service deaktiviert, Admin nötig.
HTTPS + `gh auth setup-git` verwenden.

#### `CursorPosition`-Fehler in PS-Subprocess / `CursorPosition` Error in PowerShell Subprocess
PowerShell-Profil (Oh-My-Posh) lädt im Subprozess.
`-NoProfile` zu `pwsh -File`-Aufrufen hinzufügen.

#### `migrate-workspace.*` läuft parallel in Timeouts / `migrate-workspace.*` Times Out in Parallel
Jeder Migrationslauf startet `init-stats.*` und aktualisiert die Level-0/1/2-Statistiken global.
Mehrere parallele Läufe können sich gegenseitig ausbremsen. Erst Vorschau (`-WhatIf`/`--dry-run`),
dann echte Migrationen seriell pro Workspace mit längerem Timeout ausführen.

#### `git pull` meldet divergierende Branches (Linux) / `git pull` Reports Divergent Branches (Linux)
Kein globales Rebase-Setup.
`git config --global pull.rebase true`.

#### Push rejected: `fetch first` / Push Rejected: `fetch first`
Remote ist neuer als lokal.
`git pull --rebase --autostash && git push`.

#### Test-Skript blockiert Pull / Test Script Blocks Pull
Output-Datei wird vor `pull` geschrieben.
`git pull --rebase --autostash origin main`.

#### Lastenheft nach Feature-Abschluss nicht umbenannt / Lastenheft Not Renamed After Feature Completion
`tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben).
`bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` oder `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>`.

#### Windows: `$env:HOME` ist leer, nicht `$null` / Windows: `$env:HOME` Is Empty, Not `$null`
```powershell
# Falsch (??-Operator fängt '' nicht ab):
$home = $env:HOME ?? $env:USERPROFILE
# Richtig:
$home = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }
```

#### CI: Scanner-Verzeichnis / CI: Scanner Directory
```bash
# Falsch (CWD = Repo-Root, Dateien nicht gefunden):
bash scripts/check-homogeneity.sh home-baseline
# Richtig (aus dem Parent heraus):
cd "$(dirname "$GITHUB_WORKSPACE")"
bash "$(basename "$GITHUB_WORKSPACE")/scripts/check-homogeneity.sh" "$(basename "$GITHUB_WORKSPACE")"
```

#### `.gitignore`-Whitelist / `.gitignore` Whitelist
Jede neue Datei muss explizit als `!DATEINAME` in `.gitignore` eingetragen werden, sonst wird `git add` lautlos ignoriert (z. B. `LICENSE`).

#### `bootstrap-workspace`: GitHub-Username / `bootstrap-workspace`: GitHub Username
Früher hardcodiert. Jetzt dynamisch:
```bash
GH_USER=$(gh api user --jq '.login')
```

#### Doppelte Überschriften in TOC / Duplicate heading anchors
Gleiche Heading-Texte → GitHub hängt `-1`, `-2` an. TOC-Links für zweite Vorkommen müssen den Suffix enthalten.

#### Pflicht für bilinguale Headings / Bilingual Heading Requirement
Format: `## DE / EN` — immer. Nur-Deutsch verletzt WCAG 2.4.6 und bilinguales Konsistenzgebot.
Ausnahme: Eigennamen wie `### Homogeneity Guardian` oder `### Compliance-Check`.

#### Code-Blöcke immer mit Sprach-Tag (WCAG 4.1.1) / Code Blocks Must Always Have a Language Tag (WCAG 4.1.1)
Bare ` ``` ` ohne Sprache ist ein A11Y-Fehler. Für ASCII/Dialog/Verzeichnisse: ` ```text `.

#### CHANGELOG.md hinzugefügt / CHANGELOG.md Added
Dokumentiert Versionen v0.1.0–v0.4.0. Muss in `.gitignore`-Whitelist (`!CHANGELOG.md`) eingetragen sein.

#### ASCII-Box-Drawing-Tabellen: Zeilenbreite / ASCII Box-Drawing Tables: Line Width
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen: PowerShell `$line.Length` oder `wc -m` (Bash) für jede Rahmen-Zeile.

#### Spec-Kit-Verzeichnis initialisieren / Initialize the Spec-Kit Directory
Nie manuell aus `~/home-baseline-source/` kopieren. Stattdessen:
`specify init --here --force --integration {agent}` je Agent für `agy`, `opencode`, `claude`, `copilot` und `codex` ausführen.

#### Spec-Kit-Updates repo-weit / Repository-Wide Spec-Kit Updates
Fuer Level 0, Level 1 und Level 2 nicht mehr per Hand in jedem Repo nachziehen.
Stattdessen zuerst `bash scripts/update-spec-kit.sh --dry-run` bzw.
`pwsh scripts/update-spec-kit.ps1 -WhatIf` ausfuehren, danach bei Bedarf
`--commit --push` / `-Commit -Push`.

Das Skript erkennt neue Repos dynamisch ueber `.git` plus `.specify/`, sichert
`.specify/memory/constitution.md`, legt die lokalen Governance-Templates wieder
auf und nimmt `RiderProjects/TuiVision` normal mit. OpenCode wird nur ueber
`.opencode/command/*.md` getrackt; `.opencode`-Caches, Sessions, Logs,
Credentials und lokale Abhängigkeiten bleiben ausgeschlossen.

Die Standard-Template-Quelle ist das oeffentliche `home-baseline`-Repo, aus dem
das Skript laeuft. Private Repos wie `RiderProjects/TuiVision` duerfen nur
bewusst mit `--template-source` / `-TemplateSource` als Override genutzt werden.

#### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` bedeutet bei GitHub nur read-only, nicht unsichtbar. Public archived Repos bleiben ohne Anmeldung sichtbar.
Archivierte Repos sind API-seitig read-only; Sichtbarkeit ändern geht deshalb nur über:
`archived=false` → `private=true` → `archived=true`.

Öffentliche Forks lassen sich nicht einfach auf private setzen. Optionen: öffentlich archiviert lassen, löschen, oder als private Mirror-Repos neu anlegen. Vor Löschungen die Repo-Liste eng festlegen; `gh repo delete` benötigt ggf. `gh auth refresh -h github.com -s delete_repo`.

Für Aktivitätsbewertungen `pushedAt` statt `updatedAt` verwenden, weil `updatedAt` durch Metadatenänderungen springt. Stars sind kontogebundene Metadaten und können über `DELETE /user/starred/{owner}/{repo}` entfernt werden; danach `user/starred` gegenprüfen.

### Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (GitLab support), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

### Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf` in `~/.gitconfig`, `~/.gitconfig.d/` als workspace-spezifische Include-Fragmente; bootstrap-workspace, sync-home, check-homogeneity und pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: Added GitLab CLI support, self-hosted GitLab URL handling, and `glab auth login` pitfall guidance
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking

## GitHub Copilot

### Repository-Zweck / Repository Purpose

`home-baseline` manages workspace initialisation: it provides scripts that turn a plain directory into a private GitHub or GitLab repo with `.gitignore`, standard scripts, and a `pre-push` secret-scanning hook installed. It does **not** contain application source code.

### Arbeitsverzeichnis / Working Directory

**IMPORTANT:** Always work in `~/home-baseline-source` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-source   # ← start Copilot CLI here
copilot
# → make changes, commit, push

# After runtime-distribution changes: sync to ~/
bash ~/scripts/sync-home.sh --no-pull   # macOS/Linux
pwsh ~/scripts/sync-home.ps1 -NoPull   # Windows
```

| Directory | Git-Remote | Purpose |
|---|---|---|
| `~/home-baseline-source` | ✅ `origin` → GitHub | Development, commits, push |
| `~/` | ❌ no remote | Local copy for scripts & hooks |

Der persönliche Fork unter `~/home-baseline-source` bleibt dauerhaft als
versionierte Level-0-Quelle erhalten. `sync-home.*` verteilt nur
`homeRuntime`: Skripte, gemeinsame Agent-Guidance und ausgewaehlte
Spec-Kit-Oberflaechen. Dokumentation, Specs, Preset-Quellen und Evidence werden
direkt im Klon gelesen; `STATS.md` und private Agentenzustaende bleiben lokal.
Nach reinen Source-only-Aenderungen ist kein Home-Sync erforderlich. Vor echten
Laeufen `--check-only` / `-CheckOnly` verwenden; `--force` / `-Force` nur nach
Pruefung der Konflikte. In der ABS-DD-Sandbox die eingebundene Referenz direkt
verwenden; der allgemeine schreibende Home-Sync bleibt gesperrt. Nur ein
ausdruecklich angeforderter `--runtime-only`-/`-RuntimeOnly`-Lauf darf
manifestgebundene `homeRuntime` in die Container-Betriebskopie verteilen, ohne
Pull, Commit, Git-Konfigurations- oder Identitaetsaenderung.

*Keep the personal fork at `~/home-baseline-source` permanently as the versioned
Level 0 source. `sync-home.*` distributes only `homeRuntime`: scripts, shared
agent guidance, and selected Spec Kit surfaces. Read documentation, specs,
preset sources, and evidence directly from the clone; `STATS.md` and private
agent state remain local. Source-only changes do not require Home sync. Use
`--check-only` / `-CheckOnly` before a real run and review conflicts before
using force. General writing Home sync remains host-only; only an explicitly
requested runtime-only run may distribute manifest-bound `homeRuntime` inside
the container without pull, commit, Git configuration, or identity changes.*

### Validierungsbefehle / Validation Commands

There is no build step. Validate changes by running scripts directly.

```bash
# Bash (macOS / Linux)
bash scripts/bootstrap-workspace.sh --dry-run FlutterProjects   # preview, no writes
bash scripts/install-hooks.sh
bash scripts/setup-git-identity.sh --check-only  # check for placeholder identity
bash scripts/setup-git-identity.sh               # set git identity interactively
bash scripts/scan-agent-secrets.sh --fail-on-high .
bash scripts/audit-agent-changes.sh snapshot
bash scripts/audit-agent-changes.sh report
bash scripts/update-spec-kit.sh --dry-run

# PowerShell 7+ (Windows)
pwsh scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
pwsh scripts/install-hooks.ps1 -Verbose
pwsh -NoProfile scripts/setup-git-identity.ps1 -CheckOnly  # check for placeholder identity
pwsh -NoProfile scripts/setup-git-identity.ps1             # set git identity interactively
pwsh scripts/scan-agent-secrets.ps1 -FailOnHigh
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report
pwsh -NoProfile scripts/update-spec-kit.ps1 -WhatIf
```

Always use `--dry-run` / `-WhatIf` before changing bootstrap logic. Reinstall hooks after editing anything under `scripts/hooks/`.

#### Plattformübergreifende Testausgabe (macOS / Linux / Windows) / Cross-Platform Test Output (macOS / Linux / Windows)

When terminal output cannot be copy-pasted between machines, use the matching platform test script:

```bash
# On the Mac — collects info, commits and pushes results automatically:
bash ~/home-baseline-source/scripts/mac-test.sh

# On Linux / WSL:
bash ~/home-baseline-source/scripts/linux-test.sh
```
```powershell
# On Windows:
pwsh ~/home-baseline-source/scripts/windows-test.ps1
```

Results land in `mac-test-output.txt`, `linux-test-output.txt`, or `windows-test-output.txt` in the repo. Read from Windows:
```powershell
git -C "$HOME\home-baseline-source" pull
Get-Content "$HOME\home-baseline-source\windows-test-output.txt"  # oder mac-test-output.txt, linux-test-output.txt
```

### OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them. Validate changes by running the variant that matches the current OS.

**Skriptsprachenwahl / Script language choice:** Nach der OS-Erkennung vorhandene PowerShell-7-Skripte oder Cmdlets bevorzugen, wenn sie die Aufgabe loesen und `pwsh` verfuegbar ist. Fuer strukturierte lokale Automationen ist C# ueber `.NET` oder `mono` ein zulaessiger zweiter Weg, wenn Typisierung, Dateiformate oder Wiederverwendbarkeit davon profitieren. Erst wenn PowerShell oder C# nicht sinnvoll passen, die OS-nahe vorhandene Repo-Variante nutzen, auf macOS/Linux typischerweise Bash. Keine neue Sprache nur aus Bequemlichkeit einfuehren, wenn ein bestehendes Repo-Skript denselben Zweck erfuellt.

### Statistik-Pflege / Statistics Maintenance

- Maintain `docs/project-statistics.md` as the living statistics ledger for this repository.
- Update it after each completed feature/Lastenheft, each completed Spec-Kit phase, or when explicitly requested.
- Keep `## Fortschreibungsprotokoll` chronological: oldest entry first, newest entry last.
- Keep `## Gesamtstatistik` as the final top-level section.
- Treat `docs/project-statistics.config.json` and the marked Profile 2 block as the binding contract; update it with `render-project-statistics.*`.
- Profile 2 includes KPIs, artifact mix, 52-week daily activity, weekly and cumulative volume, phase or monthly volume, speedup gauges, and the experienced/Thorsten-Solo/AI-visible comparison.
- Use ASCII only: heatmap digits `0..4`, `-` for days not elapsed, and `#`/`.` gauges. Do not use Unicode blocks, color-only signals, or `\ | /` as intensity levels.
- Keep phase slots stable and split series into blocks of 16. Without reliable phase data, show monthly volume and do not invent phases.
- Keep charts at 100 characters or fewer and provide exact values plus a CEFR-B2 text alternative in German first and English second.
- Methodology v2 uses Git-tracked text and gross changes from non-merge commits while excluding the ledger, `STATS.md`, and binaries.
- Manual references for this repository are `80` lines/workday (conservative) and `100` lines/workday (Thorsten-Solo, scripting infrastructure).
- Default C#/.NET Thorsten-Solo baseline is `125` lines/workday unless the repository documents a justified deviation.
- Shared guidance and statistics-method changes must update all five shared agent surfaces, including `.github/agents/copilot-instructions.md`, together in the same change.

### Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` is binding shared guidance across the workspace family.
- All user-facing artefacts must be reviewed for inclusive use: CLI output, documentation, HTML, UI, and generated templates.
- Treat WCAG 2.2 Level AA as the default accessibility baseline wherever the criteria apply.
- Keep text-first usability visible for keyboard-only use, screen readers, Braille displays, and text browsers.
- Review new or changed non-trivial logic for didactic inline-comment need: comments explain why, trade-off, boundary condition, historical deviation, or proof limit, not obvious code behavior.
- Shared guidance and learner-facing documentation follow DE first, EN second; for large normative documents, a synchronised `.EN.md` companion file is acceptable.
- Do not update only this file when a shared rule changes; keep `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md` aligned and document any intentional deviation in the same change.

### Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Copilot-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Copilot work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

### Architektur / Architecture

#### Bootstrap-Ablauf (`bootstrap-workspace.sh` / `.ps1`) / Bootstrap Flow (`bootstrap-workspace.sh` / `.ps1`)

1. Detect existing sub-repos (`.git/` directories) inside the target directory → add them to `.gitignore`
2. Copy `scripts/` (secret scanner, hook installer, `pre-push` hook) into workspace
3. `git init` + initial commit + apply local git settings (`git config --local`)
4. `gh repo create` or `glab repo create` (private) + push
5. `bash scripts/install-hooks.sh` — copies `scripts/hooks/pre-push` → `.git/hooks/pre-push`
6. If `~/.gitconfig.d/` exists: append `[includeIf "gitdir:~/WorkspaceName/"]` block to `~/.gitconfig` pointing to `~/.gitconfig.d/<workspacename>.inc` (idempotent — no duplicate if already present)
7. Append a row to `~/README.md` workspace table and commit/push `home-baseline`

**`bootstrap-project` vs. `bootstrap-workspace` git config scope**: `bootstrap-project` applies settings only via `git config --local` inside the new project repo — it MUST NOT and does not touch `~/.gitconfig` or `~/.gitconfig.d/`. Only `bootstrap-workspace` writes `includeIf` blocks.

#### Teardown-Ablauf (`teardown-workspace.sh` / `.ps1`) / Teardown Flow (`teardown-workspace.sh` / `.ps1`)

Reverses the bootstrap in a safe, ordered sequence:
1. Create backup archive (if `--backup` / `-Backup`)
2. Safety checks — abort on uncommitted changes or unpushed commits (unless `--force`)
3. Delete remote repo via `gh repo delete` or `glab repo delete` (auto-detected from remote URL); skip if `--keep-remote`
4. Delete local workspace directory
5. Clean up artifacts: remove row from `~/README.md`, entry from `~/.gitignore`, `[includeIf]` block from `~/.gitconfig`, and `~/.gitconfig.d/<name>.inc`
6. Atomic commit of all artifact changes in `~/`

Alias: `bootstrap-workspace.sh --teardown <WorkspaceName>` delegates to `teardown-workspace.sh`.
The workspace name `home-baseline` is explicitly protected (exit 2).

#### Secret-Scan-Infrastruktur / Secret-Scanning Infrastructure

- **`scripts/hooks/pre-push`** — runs on every `git push`; uses `gitleaks` for the commit ranges being pushed when available, then scans changed git-tracked files from those ranges (`.gitignore` respected) with the regex fallback; blocks push with exit 2 on HIGH findings.
- **`scripts/scan-agent-secrets.sh` / `.ps1`** — manual scanner; uses `gitleaks git --pre-commit` for the current git diff when available, then runs the existing regex checks; accepts `--fail-on-high` / `-FailOnHigh` for CI use; requires `rg` (ripgrep), while `gitleaks` is preferred but optional.
- **`scripts/audit-agent-changes.sh` / `.ps1`** — local baseline/report workflow for agent-managed files. It stores local audit state under `~/.home-baseline/agent-audit/`, lists later file drift, and searches recent Codex, Claude, Copilot, and Continue logs for path-based hints. This is heuristic correlation, not proof of authorship.

#### `.gitignore`-Whitelist-Muster / `.gitignore` Whitelist Pattern

The root `.gitignore` denies everything (`/*` and `/.*`) then explicitly allows safe entries only:
```
!.gitignore
!.gitconfig
!scripts/
!README.md
```
Credential directories (`.aws/`, `.ssh/`, `.kube/`, `.docker/`, `.gnupg/`) and agent state (`.claude/`, `.codex/`, `.gemini/`, `.junie/`) are never tracked.

#### Vererbung in Child-Workspaces / Child Workspace Inheritance

Each bootstrapped workspace (e.g. `~/MyProjects/`, `~/WorkProjects/`) is an independent Git repo. It inherits a copy of `scripts/` and the `pre-push` hook but has its own `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`. Changes to home-baseline do **not** auto-propagate; workspaces must manually sync.

### Code-Konventionen / Code Conventions

#### Shell-Skripte / Shell Scripts
- Bash: `#!/usr/bin/env bash` + `set -euo pipefail`
- PowerShell: `#Requires -Version 7` + `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'`
- Indentation: 2 spaces (Bash), 4 spaces (PowerShell)
- Filenames: kebab-case (`bootstrap-workspace.sh`)
- PowerShell parameters: PascalCase (`-WorkspaceName`, `-WhatIf`)
- **PowerShell naming**: Functions and Cmdlets MUST use the `Verb-Noun` pattern (e.g. `New-HBWorkspace`).
- Bash variables: lowercase_underscore
- **Documentation mandatory**: Every new script MUST have a Unix man-page (for `.sh`) in `docs/man/` and complete bilingual comment-based help (for `.ps1`). Help switches (`-h`, `--help`) MUST point to the documentation.

#### Nutzerseitige Meldungen / User-Facing Messages
German primary (`Fehler:`, `Verzeichnis nicht gefunden`), English acceptable in code comments. Box-drawing characters (╔, ║, ╚, ✓, →) used for visual output blocks.

#### Commits / Commits
Follow Conventional Commits: `chore:`, `docs:`, `feat:`, `fix:`. Subjects are short and imperative (example from history: `feat: bootstrap-workspace aktualisiert ~/README.md automatisch`). Always include the trailer:
```
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

#### Pull Requests / Pull Requests
Include: affected scripts/docs, manual verification commands run (`--dry-run` output), and sample console output when user-visible output changes. For any change touching secret-scan or hook logic, explicitly state the risk and include scanner output.

### Sicherheitsregeln / Security Rules

- Never commit tokens, `.env` files, or local agent state (`.claude/`, `.codex/`, `.gemini/`).
- Run `bash scripts/scan-agent-secrets.sh --fail-on-high .` before pushing any change that touches hook or scanner logic; this uses `gitleaks` for the current diff when available.
- The pre-push hook runs `gitleaks` on pushed commit ranges when available and then applies the regex fallback to changed tracked files for patterns like `ghp_*`, `sk-*`, `AKIA*`, `AIza*`, PEM private key headers, and secret-named files (`.env*`, `*secret*`, `*.key`, `*.pem`).

### Repository-Status / Repository Status

- **Visibility**: public template repository (GitHub "Use this template" enabled)
- **License**: MIT
- **Branch protection**: `main` requires PR review; `enforce_admins: false` (owner can push directly)
- **CI runners**: `ubuntu-22.04`, `macos-15`, `windows-2022` via `.github/workflows/homogeneity-check.yml`
- **Compliance score**: 100 % (25/25 checks) as of last verified installation

### Bekannte Fallstricke & technische Entscheidungen / Known Pitfalls & Technical Decisions

#### Windows: `$env:HOME` ist ein leerer String, nicht `$null` / Windows: `$env:HOME` Is an Empty String, Not `$null`
PowerShell 7's `??` null-coalescing operator does **not** catch an empty string.
Always use: `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`

#### `Copy-Item`-Verzeichnisverhalten / `Copy-Item` Directory Behaviour
When the destination already exists, `Copy-Item src dst -Recurse` copies `src` **into** `dst` (creates `dst/src/`).
Use `Copy-Item src/* dst/ -Recurse -Force` to copy contents, not the container.
Bash equivalent: `cp -r src/. dst/` instead of `cp -r src dst`.

#### CI: Scanner muss aus dem Parent von `$GITHUB_WORKSPACE` laufen / CI: Scanner Must Run from the Parent of `$GITHUB_WORKSPACE`
`check-homogeneity.sh/ps1` expects `TARGET_DIR` to be a relative or absolute path it can enter.
If called with just `$(basename "$GITHUB_WORKSPACE")` while `CWD` is the repo root, all files appear missing.
Correct approach:
```bash
PARENT="$(dirname "$GITHUB_WORKSPACE")"; REPO="$(basename "$GITHUB_WORKSPACE")"
cd "$PARENT" && bash "${REPO}/scripts/check-homogeneity.sh" "${REPO}"
```
PowerShell equivalent: `Set-Location (Split-Path $env:GITHUB_WORKSPACE -Parent)` then `& "${repo}/scripts/check-homogeneity.ps1" -TargetDir $repo`.

#### Migrationen seriell ausführen / Run Migrations Serially
Do not run several `migrate-workspace.*` commands in parallel. Each migration invokes `init-stats.*`,
which updates the shared level 0/1/2 statistics across the whole environment. Parallel migration runs
can block each other and time out. First run `-WhatIf`/`--dry-run`, then execute real migrations one
workspace at a time with a longer timeout.

#### Bash-Array `${#array[@]+...}` auf Ubuntu 22.04 nicht unterstützt / Bash Array `${#array[@]+...}` Not Supported on Ubuntu 22.04
`${#FAILURES[@]+"${#FAILURES[@]}"}` causes a `bad substitution` error on older bash.
Use the Bash-3-safe for-loop: `count=0; for _ in "${arr[@]+"${arr[@]}"}"; do count=$((count+1)); done`

#### `hg-a11y`: Falsch-Positive bei fenced code blocks / `hg-a11y`: Fenced Code Block False Positives
`# comment` lines inside ` ``` ` blocks were parsed as h1 headings → false `heading-gap-h1-to-h3`.
Fix: track an `$inFencedBlock` toggle on lines matching ` ``` `.

#### `hg-a11y`: Falsch-Positive bei nichtssagenden Links / `hg-a11y`: Non-Descriptive Link False Positives
`[hier](...)` and `[here](...)` inside backtick spans (documentation examples) triggered the link check.
Fix: strip inline code spans (`'`[^`]+`'`) from each line before pattern-matching links.

#### `.gitignore`-Whitelist und `LICENSE` / `.gitignore` Whitelist and `LICENSE`
The whitelist `.gitignore` (`/*` blocks everything) silently ignores `git add LICENSE`.
Always add `!LICENSE` to the allowlist; use `git add -f LICENSE` if needed retroactively.

#### `bootstrap-workspace`: dynamischer GitHub-Benutzername / `bootstrap-workspace`: Dynamic GitHub Username
Both scripts previously had `hindermath` hardcoded. Fixed to detect current user:
- Bash: `GH_USER=$(gh api user --jq '.login')`
- PowerShell: `$ghUser = (gh api user --jq '.login')`

#### Branch-Schutz auf GitHub Free / Branch Protection on GitHub Free
The `restrictions` field (who can push directly) requires a paid plan.
On a free personal account only `required_pull_request_reviews` is effective.
Set `enforce_admins: false` to allow the owner to bypass the PR requirement.

#### ANSI-Falsch-Positive in `check-homogeneity` / ANSI False Positive in `check-homogeneity`
The scanner itself contains `\033[` literals in comments → self-triggers the ANSI check.
Exclude via: `--glob '!check-homogeneity.*'` (rg) / `Where-Object { $_.Name -notmatch '^check-homogeneity\.(ps1|sh)$' }` (PS).

#### `<!-- workspace-table-end -->`-Anker darf nicht entfernt werden / `<!-- workspace-table-end -->` Anchor Must Not Be Removed
`bootstrap-workspace.sh/ps1` and `bootstrap-project.sh/ps1` use this comment as an insertion anchor in `README.md`. Removing it breaks automated workspace-table updates.

#### Doppelte Heading-Anker in GitHub-Markdown / Duplicate Heading Anchors in GitHub Markdown
When the same heading text appears more than once, GitHub appends `-1`, `-2` etc. to the anchor.
TOC links for second/third occurrences must include this suffix (e.g. `#macos--linux-1`).
Avoid duplicates by making heading text unique where possible.

#### Pflicht für bilinguale Überschriften (WCAG 2.4.6) / Bilingual Heading Requirement (WCAG 2.4.6)
All headings **must** follow the `DE / EN` pattern. German-only headings break bilingual consistency and violate WCAG 2.4.6.
Exception: tool names / proper nouns (e.g. `### Homogeneity Guardian`, `### Compliance-Check`).

#### Sprach-Tags für Code-Blöcke (WCAG 4.1.1) / Code Fence Language Tags (WCAG 4.1.1)
Every code block **must** have a language specifier. Use `text` for ASCII art, dialog examples, and directory trees.
Bare ` ``` ` without a language violates WCAG 4.1.1 (Parsing).

#### WCAG 2.2 Level AA — README-Compliance / WCAG 2.2 Level AA — README Compliance
The README follows WCAG 2.2 Level AA. See `## Barrierefreiheit / Accessibility (A11Y)` for the full criteria table.
Only known gap: WCAG 3.1.2 (`lang` attributes) — GitHub strips HTML attributes, cannot be implemented.

#### README-TOC-Struktur / README TOC Structure
The TOC is 2-level: `##` headings as top-level items, `###` headings as nested items (2-space indent).
`####` headings are excluded from the TOC (too granular, too many platform-specific duplicates).

#### CHANGELOG.md / CHANGELOG.md
`CHANGELOG.md` documents versions v0.1.0–v0.4.0 following Keep a Changelog format.
Must be listed in `.gitignore` whitelist as `!CHANGELOG.md`.

#### Ausrichtung von ASCII-Box-Drawing-Tabellen / ASCII Box-Drawing Table Alignment
All rows in a `text` code block table must have identical character width. A single trailing space before the closing `│` makes a row 1 char too long and breaks the visual frame.
Verify with: `$line.Length` (PowerShell) — all frame characters count as 1 char regardless of UTF-8 byte width.

#### `specify init` — Spec-Kit-Verzeichnisaufbau / `specify init` — Spec-Kit Directory Setup
Never copy from `~/home-baseline-source/` manually. The correct command is:
Run `specify init --here --force --integration {agent}` once per agent for `agy`, `opencode`, `claude`, `copilot`, and `codex`.

#### Spec-Kit-Updates repo-weit / Repository-Wide Spec-Kit Updates
Do not refresh Level 0, Level 1, and Level 2 repositories by hand. Run
`bash scripts/update-spec-kit.sh --dry-run` or
`pwsh scripts/update-spec-kit.ps1 -WhatIf` first, then use `--commit --push` /
`-Commit -Push` when the preview is correct.

The script dynamically discovers new repositories via `.git` plus `.specify/`,
backs up and restores `.specify/memory/constitution.md`, reapplies the local
governance templates, and includes `RiderProjects/TuiVision` in normal update
runs. OpenCode support is tracked only through `.opencode/command/*.md`;
`.opencode` caches, sessions, logs, credentials, and local dependencies remain
excluded.

The default template source is the public `home-baseline` repository that runs
the script. Private repositories such as `RiderProjects/TuiVision` may only be
used deliberately with `--template-source` / `-TemplateSource`.

#### Workspace-Name beginnt mit `-` (z. B. `-h`, `-t`) / Workspace Name Starts with `-` (e.g. `-h`, `-t`)
Bash option parsing interprets `-h` as a flag, causing scripts to show help or hang waiting for stdin.
Use the `--` end-of-options sentinel: `teardown-workspace.sh -- -h`. Applies to all scripts accepting positional workspace/project names (`bootstrap-project.sh`, `bootstrap-workspace.sh`, `init-stats.sh`, `migrate-workspace.sh`, `teardown-workspace.sh`).

#### Lastenheft-Umbenennung nach Feature-Abschluss / Lastenheft Rename on Feature Completion
When a feature's implementation is fully merged, rename the corresponding `Lastenheft_*.md` using:
```bash
bash scripts/rename-lastenheft.sh <LH-file> <branch-name>   # macOS/Linux
pwsh scripts/rename-lastenheft.ps1 -File <LH-file> -BranchName <branch-name>   # Windows
```
This stamps the branch name onto the filename (e.g. `Lastenheft_Foo.003-feature.md`) to mark it as archived.
The rename task is now included as the last step of every feature's Polish phase in `tasks.md` (constitution v1.1.1).
Missing this step was the root cause of 003, 005, and 006 Lastenhefte remaining unrenamed.

#### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` on GitHub means read-only, not hidden. Public archived repositories remain visible to signed-out visitors.
Archived repositories are read-only through the API; changing visibility requires:
`archived=false` → `private=true` → `archived=true`.

Public forks cannot simply be changed to private. Options are: keep them public archived, delete them, or recreate them as private mirror repositories. Keep deletion target lists explicit and narrow; `gh repo delete` may require `gh auth refresh -h github.com -s delete_repo`.

For activity-based housekeeping, use `pushedAt` instead of `updatedAt`, because metadata updates change `updatedAt`. Stars are account metadata and can be removed via `DELETE /user/starred/{owner}/{repo}`; verify afterwards with `user/starred`.

#### Windows: `gh auth login` in Hintergrund-/Async-Prozessen / Windows: `gh auth login` in Background/Async Processes
`gh auth login --web` does NOT detect browser confirmation when run in a background or async process (e.g. Copilot CLI async shell). The browser callback never arrives.
Always run `gh auth login` in an **interactive terminal window** directly.

#### macOS / Linux / Windows: `glab auth login` in Hintergrund-/Async-Prozessen / macOS / Linux / Windows: `glab auth login` in Background/Async Processes
`glab auth login --web` does NOT detect browser confirmation when run in a background or async process. The browser callback never arrives.
Always run `glab auth login` in an **interactive terminal window** directly.

#### Windows: `gh`-Keyring wird ungültig / Windows: `gh` Keyring Becomes Invalid
Symptom: `Failed to log in to github.com account (keyring)` from `gh auth status`.
Fix: `gh auth logout -h github.com -u hindermath` then `gh auth login --web -p ssh` in a real terminal.

#### Windows: `ssh-agent`-Dienst standardmäßig deaktiviert / Windows: `ssh-agent` Service Disabled by Default
The Windows OpenSSH Agent service is `Disabled` and requires admin rights to enable.
Use HTTPS + `gh auth setup-git` for git push instead of SSH on Windows.
After `gh auth login`, run `gh auth setup-git` once to configure git credential helper.

#### Linux: `git pull` mit divergierenden Branches / Linux: `git pull` Divergent Branches
On Linux, `git pull` without config fails with "Need to specify how to reconcile divergent branches".
Fix once: `git config --global pull.rebase true`
Or per-call: `git pull --rebase`

#### Linux: SSH für GitHub-Push / Linux: SSH for GitHub Push
`gh auth setup-git` may not work if credential cache has stale entries.
Reliable fix: generate SSH key, add to GitHub, set remote to SSH:
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
ssh -T git@github.com   # test
```

#### Testskripte: `git pull --rebase --autostash` vor dem Push / Test Scripts: `git pull --rebase --autostash` Before Push
The `*-test.sh/ps1` scripts write the output file **before** pushing. Without `--autostash`, `git pull --rebase` fails with "unstaged changes".
All test scripts use: `git pull --rebase --autostash origin main`

#### Windows: `-NoProfile` für `pwsh`-Subprozesse / Windows: `-NoProfile` for `pwsh` Subprocesses
When calling `pwsh -File script.ps1` as a subprocess, PowerShell loads the user profile.
If the profile contains Oh-My-Posh or cursor-positioning code, it throws:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: always add `-NoProfile` to subprocess calls in `windows-test.ps1`.

### Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (new), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

### Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf`, `~/.gitconfig.d/`, bootstrap-workspace, sync-home, check-homogeneity, pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab auto-detected), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`; `--` end-of-options für Workspace-Namen mit `-`-Präfix
- 006-gitlab-support: GitLab-CLI-Support für `bootstrap-workspace.*` und `bootstrap-project.*`, `--platform gitlab`, Self-hosted `--gitlab-url`, bilinguale Fehlerpfade
- 007-gitlab-release-automation: `setup-gitlab-release.*`, GitLab-Release-Templates und non-blocking manueller `release`-Job ergänzt; mit echten Releases in `sysinfotool` (`v0.1.0`) und `inventarworkerservice2` (`v0.0.1`) validiert; Detached-HEAD- und CHANGELOG-Refresh-Fixes eingearbeitet
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking
