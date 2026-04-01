# Feature Specification: Workspace Homogeneity Guardian

**Feature Branch**: `001-workspace-homogeneity-guardian`
**Created**: 2026-04-01
**Status**: Draft
**Input**: Erstelle eine Spezifikation aus der Datei Lastenheft_workspace-homogeneity-guardian.md

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Developer runs a workspace compliance check (Priority: P1)

A developer (or apprentice / Azubi) wants to know immediately whether every
directory level — home, workspace, and project — is consistent: required files
present, secret-scanning hooks active, bilingual content in place, and
accessibility sections included.

**Why this priority**: Without a reliable check, no targeted fix is possible.
This story delivers standalone value as a read-only audit tool even before any
remediation scripts exist.

**Independent Test**: Run the check tool against the live environment. It
produces a report with pass/fail/warn status per file per level and exits with
code 0 (all OK) or 1 (gaps found). No write access to any repo is needed.

**Acceptance Scenarios**:

1. **Given** the home environment with multiple workspaces and projects,
   **When** the compliance check tool is executed,
   **Then** it outputs a tabular report listing every required file per level
   with status ✓ / ✗ / WARN, followed by an ASCII compliance bar chart.

2. **Given** a workspace where `GEMINI.md` is missing,
   **When** the compliance check runs,
   **Then** the report shows `✗ GEMINI.md` for that workspace and the tool
   exits with code 1.

3. **Given** all required files are present but none contain bilingual sections,
   **When** the compliance check runs with content-inspection enabled,
   **Then** each affected file is flagged `WARN: bilingual section missing`.

4. **Given** a git repository where the installed pre-push hook differs from
   the canonical master hook,
   **When** the compliance check runs,
   **Then** the report flags `WARN: hook outdated` for that repository.

---

### User Story 2 — Developer bootstraps a new project (Priority: P2)

A developer (or apprentice) wants to create a new project and receive — with a
single command — a fully configured workspace: all AI agent guidance files,
secret-scanning hook, bilingual documentation scaffold, accessibility sections,
initial statistics, and all four AI agents (Claude, Codex, Gemini, Copilot)
initialised together with Spec-kit.

**Why this priority**: Without automated bootstrapping, new projects are created
inconsistently. This story ensures homogeneity from the very first commit and is
the primary tool for the apprenticeship use case.

**Independent Test**: Bootstrap a fresh empty directory. Immediately afterwards
the compliance check tool reports 100 % for that project without any manual
follow-up steps.

**Acceptance Scenarios**:

1. **Given** an empty target directory,
   **When** the bootstrap tool is executed for that directory,
   **Then** all required files are created (agent guidance files, hook, README,
   statistics file, Spec-kit scaffolding), all four AI agents are initialised,
   and an initial Spec-kit specification scaffold is generated.

2. **Given** Spec-kit is not yet installed on the machine,
   **When** the bootstrap tool runs,
   **Then** Spec-kit is installed automatically before the scaffolding steps proceed.

3. **Given** one or more AI agent CLIs are not installed,
   **When** the bootstrap tool runs,
   **Then** the missing agents are skipped with a clear warning, and the
   bootstrap does not abort — all other steps complete successfully.

4. **Given** a `--preview` / dry-run invocation,
   **When** the bootstrap tool runs,
   **Then** it lists every planned action without creating or modifying any file.

5. **Given** a successful bootstrap,
   **When** Spec-kit subsequently completes a specify run and assigns a feature
   branch (e.g. `001-feature-name`),
   **Then** the Lastenheft file is automatically renamed to append the branch
   name as a suffix, and a git commit documents the rename.

---

### User Story 3 — Developer reads statistics and tracks compliance over time (Priority: P3)

A developer or team lead wants to see how compliance evolves across runs —
not just the current state but a historical trend — presented as ASCII
visualisations that work in any terminal or plain-text viewer.

**Why this priority**: Trend data turns a one-off audit into a continuous
improvement instrument. It can be shared with apprentices and line managers
without requiring any special tooling.

**Independent Test**: Run the compliance check three times in sequence. After
the third run, the statistics file at the home level contains three timestamped
entries and an ASCII bar chart showing the score for each workspace.

**Acceptance Scenarios**:

1. **Given** the compliance check has run at least once,
   **Then** a statistics file exists at the home level containing a timestamp,
   total workspace count, total project count, and overall compliance score.

2. **Given** multiple compliance check runs over time,
   **Then** each run appends a new timestamped entry; historical entries are
   never modified or deleted.

3. **Given** a workspace with existing project-level statistics (e.g. test
   coverage, line counts from C# projects),
   **When** the compliance check aggregates data,
   **Then** those project statistics appear in the workspace-level statistics
   file alongside the compliance data.

4. **Given** the statistics output,
   **Then** it includes an ASCII bar chart of compliance per workspace and a
   file-presence matrix table, both readable without any rendering tool.

---

### User Story 4 — Apprentice sets up their first project on Linux (Priority: P3)

An apprentice using Ubuntu 22.04 LTS or 24.04 LTS (or Windows with WSL2) wants
clear, step-by-step guidance — in German first, with English translation — to
set up their first project from scratch, without needing to buy any software.

**Why this priority**: The entire toolchain must be learnable and cost-free for
apprentices. Clear bilingual documentation in every README is what makes this
possible without hand-holding from a senior developer.

**Independent Test**: An apprentice with no prior context follows only the
"Für Azubis / For Apprentices" section of the workspace README and successfully
bootstraps a C# CLI project that passes the compliance check.

**Acceptance Scenarios**:

1. **Given** a fresh Ubuntu 22.04 LTS installation with .NET 10 SDK,
   **When** an apprentice follows the README "Für Azubis" section,
   **Then** they can bootstrap a new C# CLI project, run the compliance check,
   and receive a 100 % score — using only free tools.

2. **Given** a Windows machine with WSL2 and Ubuntu 22.04 LTS installed,
   **When** an apprentice follows the same README section inside WSL2,
   **Then** the bash scripts run identically and produce the same outcome.

3. **Given** all generated documentation files,
   **Then** every README contains both a German and an English section, the
   heading hierarchy is unbroken, all images have alt text, and no information
   is conveyed by colour alone.

---

### Edge Cases

- What happens when a directory has no `.git` folder?
  → The tool skips hook checks for that directory, reports `WARN: not a git
  repository`, and continues scanning all other directories.

- What happens when an agent file exists but is completely empty?
  → The file is treated as `WARN: file empty`, not as a passing check.

- What happens when a Spec-kit-driven project is missing `spec.md`?
  → The project is flagged `✗ spec.md missing` and counts as non-compliant.

- What happens when the bootstrap tool is run on an already-bootstrapped directory?
  → Without an explicit override flag the tool halts with
  `WARN: already bootstrapped — use --force to re-apply`.

- What happens if the bootstrap tool is interrupted mid-run (e.g., after files
  are created but before the hook is installed)?
  → The partial state is left in place. A subsequent run without `--force`
  detects already-present files (skips them) and completes only the missing
  steps — idempotent re-run is the recovery mechanism.

- What happens when no network connection is available during bootstrap?
  → All local steps complete; the remote repository creation step is skipped
  with `WARN: no network — remote push deferred`.

- What happens when a C# project references a paid GUI component library?
  → The compliance check flags `WARN: potentially non-free dependency detected`
  and lists the package name for manual review.

- What happens when two compliance check runs execute concurrently and both
  attempt to write to the same `STATS.md`?
  → The second run detects the lock file (`STATS.md.lock`), waits up to 5
  seconds, then exits with `WARN: stats file locked — try again` without
  modifying the file. The lock is always cleaned up after a successful write.

- What happens when `STATS.md` reaches 500 run entries?
  → The file is automatically renamed to `STATS-archive-YYYY.md` (current year)
  and a fresh `STATS.md` is created. The archive file is tracked by git and
  listed in the `.gitignore` whitelist. The compliance check reports the
  archival in the first entry of the new `STATS.md`.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST scan all three hierarchy levels — home (`~/`),
  workspace directories, and project directories — and report the presence of
  every required file at each level. **The scan depth is fixed at exactly 3
  levels; directories nested deeper than Level 2 are silently ignored.**
  A Level-1 directory is treated as a **Workspace** only if it contains a
  `.git` subdirectory; all other Level-1 directories are silently skipped.
  Similarly, a Level-2 directory is treated as a **Project** only if it
  contains a `.git` subdirectory.

- **FR-002**: The system MUST verify that a secret-scanning pre-push hook is
  installed in every git repository at all three levels and that it matches the
  canonical master hook exactly. The canonical master hook is located at
  `~/scripts/hooks/pre-push`; comparison is performed via SHA-256 checksum.

- **FR-003**: The system MUST detect and report the following classes of
  potential secret exposure in tracked files: authentication tokens, private key
  headers, and credential-named files. **The matched value MUST be replaced with
  `[REDACTED]` in all tool output; only the filename and line number are shown.**
  This applies to both the compliance check tool and the pre-push hook output.

- **FR-004**: The system MUST check that every agent guidance file and README
  contains both a German primary section and an English section at CEFR B2
  level, and report any file that fails this check.

- **FR-005**: The system MUST check documentation accessibility in every
  generated or scanned Markdown file: unbroken heading hierarchy, alt text on
  all images, non-empty link descriptions, and no information conveyed by colour
  alone.

- **FR-006**: The system MUST check code-level accessibility hints in
  Spec-kit-driven projects with a user interface component: ARIA role
  annotations, colour-contrast requirements, and keyboard navigation coverage
  noted in the project specification.

- **FR-007**: The system MUST generate and maintain a statistics file (`STATS.md`)
  at every level (home, workspace, project) in append-only mode, preserving all
  historical entries. Each run appends a new section using the fixed schema:
  `## Run YYYY-MM-DD HH:MM`, followed by a compliance table, an ASCII bar chart,
  and a file-presence matrix (see FR-008). Existing entries are never modified.
  **Concurrent write protection**: before writing, the tool creates
  `STATS.md.lock`; a second concurrent run waits up to 5 seconds for the lock
  to clear, then exits with `WARN: stats file locked — try again` without
  modifying the file. The lock file is removed after a successful write.
  **Archival**: when a `STATS.md` file contains 500 or more `## Run` entries,
  the tool automatically moves it to `STATS-archive-YYYY.md` (where YYYY is
  the current year) and starts a fresh `STATS.md` for subsequent runs.

- **FR-008**: Each `STATS.md` run section MUST include:
  1. A Markdown table with columns `Level | Directory | Score %`
  2. An ASCII horizontal bar chart (`[████░░] 72 %`) with one bar per workspace
  3. A file-presence matrix table listing every required filename as a column
     and each scanned directory as a row, with `✓` / `✗` / `–` cells

- **FR-009**: The system MUST provide a project bootstrap tool that creates all
  required files, installs the secret-scanning hook, initialises all four AI
  agents (Claude, Codex, Gemini, Copilot), installs Spec-kit for each agent,
  and generates an initial Spec-kit specification scaffold — in a single
  invocation.

- **FR-010**: The bootstrap tool MUST install Spec-kit automatically if it is
  not already present on the machine.

- **FR-011**: The bootstrap tool MUST support a dry-run / preview mode that
  shows all planned actions without making any changes.

- **FR-017**: The compliance check tool MUST support a `--verbose` flag. When
  omitted, the output is compact: only failures, warnings, and the final
  compliance score are shown. When `--verbose` is set, every checked file and
  its individual status (✓ / ✗ / WARN) is included in the output.

- **FR-019**: The compliance check tool MUST support a `--json` flag that
  outputs a single JSON object to stdout:
  `{ "score": <0–100>, "failures": [{"path": "...", "check": "..."}],
  "warnings": [{"path": "...", "check": "..."}] }`.
  All secret matches in JSON output MUST use `[REDACTED]` for the matched value.
  When `--json` is set, no human-readable ASCII/Markdown output is produced.

- **FR-018**: The compliance check tool MUST detect when an active `spec.md`
  file was created with an older Spec-kit template version and report
  `WARN: spec template version outdated` for that file. No automatic migration
  is performed; the developer decides when to update manually.

- **FR-012**: After a successful Spec-kit specify run that assigns a feature
  branch, the system MUST rename the associated Lastenheft file to append the
  branch name as a suffix, at all three hierarchy levels where Lastenhefts are
  maintained.

- **FR-013**: All files generated by the bootstrap tool MUST be bilingual:
  German first, English second at CEFR B2 level.

- **FR-014**: Every generated README MUST include a dedicated section for
  apprentices ("Für Azubis / For Apprentices") with step-by-step setup
  instructions.

- **FR-015**: The system MUST operate on macOS 14+, Ubuntu 22.04/24.04 LTS,
  Debian 12, Windows 10/11 (native and via WSL2) — using only free, open-source
  tooling.

- **FR-020**: After every compliance check run, the system MUST generate a
  `memory-patch.md` file in the feature directory (or a configurable output
  path). This file contains proposed additions for agent files
  (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `copilot-instructions.md`),
  README files, and the constitution (`~/.specify/memory/constitution.md`),
  based on new findings from the current run. A patch entry is generated
  **only** when one of the following trigger conditions is met:
  (1) a Workspace or Project is detected for the first time (not present in
  any prior STATS.md entry), (2) the overall compliance score for any
  directory changes by 10 percentage points or more compared to the previous
  run, or (3) a new category of WARN or FAIL appears that has not been
  recorded in any previous patch. If no trigger fires, no `memory-patch.md`
  is generated and the run exits normally. The patch MUST be reviewed and
  explicitly applied by the developer via `--apply-patch` before any agent
  file or constitution is modified.

- **FR-021**: The `memory-patch.md` MUST distinguish between three target
  categories using a strict routing schema:
  (1) **Constitution** (`~/.specify/memory/constitution.md`) — receives only
  new project-wide conventions or security rules that apply to all future
  features and all agents (e.g., "all hooks must use SHA-256 comparison");
  (2) **Agent Files** (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`,
  `copilot-instructions.md` at the appropriate level) — receive tool-specific
  context facts about the current workspace state (e.g., "RiderProjects
  contains 3 SDD projects, last compliance score 87 %");
  (3) **README sections** — receive step-by-step guidance additions targeted
  at apprentices, triggered when a new setup step or correction is discovered.
  Each proposed change MUST include the target file path, the proposed content,
  and a one-line rationale explaining which routing rule applies.

### Key Entities

- **Level**: A hierarchy tier in the workspace tree. Level 0 = home directory,
  Level 1 = workspace directory, Level 2 = project directory.
- **Workspace**: A Level-1 directory that contains a `.git` subdirectory.
  Directories without `.git` at Level 1 are silently ignored by the scanner.
- **Project**: A Level-2 directory (inside a Workspace) that contains a `.git`
  subdirectory. Directories without `.git` at Level 2 are silently ignored.
- **Agent File**: One of four AI-agent configuration files associated with
  Claude, Codex, Gemini, or Copilot.
- **Compliance Score**: The percentage of required files and content checks
  that pass for a given directory or level.
- **Hook**: A git pre-push script that intercepts pushes and blocks any that
  contain recognised secret patterns.
- **Statistics File**: An append-only Markdown file per level that records
  compliance scores, file counts, and ASCII visualisations over time.
- **SDD Project**: A Spec-kit-Driven Development project containing at minimum
  a `spec.md` file.
- **Lastenheft**: A bilingual requirements document for a feature; its filename
  gains a branch-name suffix after the Spec-kit specify step completes.
- **Memory Patch**: A `memory-patch.md` file generated after each compliance
  check run, containing proposed additions for agent files, READMEs, and the
  constitution. Must be reviewed and explicitly applied by the developer via
  `--apply-patch`; never written automatically.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: After the bootstrap tool runs on an empty directory, the
  compliance check tool immediately reports 100 % for that directory — with
  no manual follow-up steps required.

- **SC-002**: The compliance check tool completes a full scan of an environment
  with up to 10 workspaces and 50 projects in under 30 seconds.

- **SC-003**: A test push containing a recognisable fake secret token is blocked
  by the pre-push hook before any data leaves the local machine.

- **SC-004**: After three consecutive compliance check runs, the home-level
  statistics file contains three timestamped entries and correctly reflects
  any score changes between runs.

- **SC-005**: An apprentice with no prior context can follow only the
  "Für Azubis" README section on Ubuntu 22.04 LTS and successfully bootstrap
  a compliant C# CLI project using exclusively free tools.

- **SC-006**: All documentation files generated by the bootstrap tool pass the
  built-in accessibility check with no warnings (no missing alt text, no
  heading-level gaps, no empty link descriptions).

- **SC-007**: Running the bootstrap tool or compliance check tool multiple times
  on the same environment produces the same end state each time — no
  duplication, no data loss.

- **SC-008**: After a Spec-kit specify run, the Lastenheft filename is updated
  with the correct branch suffix and a git commit records the rename — at every
  hierarchy level where the operation is triggered.

---

## Assumptions

- The home environment runs macOS 14+ or one of the two supported Linux LTS
  distributions (Ubuntu 22.04/24.04 or Debian 12); Windows users operate via
  WSL2 with Ubuntu 22.04 LTS.
- `git`, `bash` ≥ 5, ripgrep (`rg`), and a SHA-256 hashing utility are already
  present in the execution environment.
- GitHub CLI (`gh`) and the four AI agent CLIs (claude, codex, gemini, copilot)
  are optional; their absence triggers warnings but does not abort any operation.
- Spec-kit can be installed automatically if missing (network access assumed for
  this step only; all other operations are fully offline).
- Existing files in bootstrapped or migrated directories are never overwritten;
  the tools add missing sections and files only.
- macOS and Windows machines are typically provided by the employer; Linux
  (including WSL2 on Windows) is the self-managed option for apprentices.
- C# projects in this workspace are CLI or TUI applications; no paid GUI
  component licences are required or permitted.
- The four AI agents and Spec-kit are used for guidance and scaffolding only;
  no AI-generated content is committed without developer review.

---

## Out of Scope

The following areas are explicitly excluded from this feature to prevent scope
creep. They may be addressed in separate features if needed.

- **Git submodules**: Directories managed as git submodules are not scanned or
  configured by this system.
- **Remote repository content**: The system does not clone, fetch, or inspect
  content from remote GitHub/GitLab repositories.
- **Docker environments**: Container image builds, Dockerfiles, and
  container-specific configurations are not covered.
- **External CI/CD systems**: GitHub Actions workflows, Jenkins pipelines, and
  similar external automation are not in scope.
- **Non-Markdown file formats**: Only `.md` files are inspected for bilingual
  content, A11Y, and heading structure. Source code files are checked only for
  dependency licences (FR-016).
- **Directories deeper than Level 2**: Any directory nested more than two
  levels below `~/` is silently ignored by the scanner.


## Clarifications

### Session 2026-04-01 — Runde 1

- Q: Was soll passieren, wenn der Bootstrap-Prozess nach einigen Schritten abbricht? → A: Teilzustand belassen; erneuter Aufruf ohne `--force` ergänzt nur noch Fehlendes (idempotent re-run)
- Q: Ist die 3-Ebenen-Struktur eine feste Grenze oder soll der Scanner tiefer scannen? → A: 3 Ebenen fix — tiefer liegende Verzeichnisse werden ignoriert
- Q: Was liegt explizit außerhalb des Scope? → A: Git-Submodule, Remote-Repo-Inhalte, Docker-Umgebungen, externe CI/CD-Systeme, Nicht-Markdown-Dateiformate
- Q: Hat das Compliance-Tool einen Verbose-/Debug-Modus? → A: `--verbose` als optionales Flag; Standard-Output ist kompakt (nur Fehler/Warnungen + Score)
- Q: Was passiert bei Spec-kit Template-Versionsdrift? → A: Kein automatisches Upgrade; das Compliance-Tool meldet `WARN: spec template version outdated`; Migration ist manuell

### Session 2026-04-01 — Runde 3

- Q: Soll das System Fakten/Erkenntnisse automatisch in KI-Agenten-Dateien, README und Verfassung schreiben? → A: Halbautomatisch — Tool generiert `memory-patch.md` mit vorgeschlagenen Ergänzungen; Entwickler prüft, übernimmt per Befehl, committet
- Q: Welche Ereignisse lösen einen Eintrag in memory-patch.md aus? → A: (1) Neues Workspace/Projekt erstmals gefunden, (2) Score-Änderung ≥10% ggü. letztem Run, (3) neuer WARN/FAIL-Typ der noch nicht im Patch stand
- Q: Nach welchem Prinzip entscheidet das Tool, wohin ein Fakt gehört? → A: Striktes Schema: Constitution=neue projektweite Konvention/Sicherheitsregel; Agent Files=werkzeugspezifische Kontext-Facts; README=Azubi-Anleitungsergänzungen
- Q: Wie sollen gleichzeitige Schreibvorgänge auf STATS.md verhindert werden? → A: Lock-File `STATS.md.lock`; zweiter Run wartet max. 5s, dann `WARN: stats file locked` und Abbruch
- Q: Was passiert, wenn STATS.md durch viele Runs zu groß wird? → A: Automatische Archivierung nach 500 Runs: aktive Datei wird nach `STATS-archive-YYYY.md` verschoben, neue leere STATS.md angelegt

### Session 2026-04-01 — Runde 2

- Q: Welches Schema soll die Statistics-Datei (STATS.md) verwenden? → A: Festes Markdown-Schema: `## Run YYYY-MM-DD HH:MM` → Tabelle `Level | Dir | Score %` → ASCII-Balkendiagramm → Datei-Präsenz-Matrix
- Q: Was macht ein Level-1-Verzeichnis zu einem scanfähigen Workspace? → A: Ein `.git`-Unterverzeichnis ist Pflichtmerkmal; Verzeichnisse ohne `.git` werden auf Level 1 übersprungen
- Q: Zeigt das Compliance-Tool gefundene Secret-Inhalte im Output an? → A: Nein — gematchter Wert wird als `[REDACTED]` ausgegeben; nur Dateiname + Zeilennummer sind sichtbar
- Q: Soll das Compliance-Tool maschinenlesbaren Output für CI unterstützen? → A: Ja — optionales `--json` Flag gibt `{ "score": N, "failures": [...], "warnings": [...] }` aus
- Q: Wo liegt der kanonische Master-Hook für den SHA-256-Vergleich? → A: `~/scripts/hooks/pre-push` ist die kanonische Referenz

