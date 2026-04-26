# Copilot Instructions – home-baseline

This is the top-level workspace bootstrap for `~/`.
It tracks only safe infrastructure files via a whitelist `.gitignore` and distributes reusable scripts to child workspaces.

## Repository-Zweck / Repository Purpose

`home-baseline` manages workspace initialisation: it provides scripts that turn a plain directory into a private GitHub or GitLab repo with `.gitignore`, standard scripts, and a `pre-push` secret-scanning hook installed. It does **not** contain application source code.

## Arbeitsverzeichnis / Working Directory

**IMPORTANT:** Always work in `~/home-baseline-tmp` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-tmp   # ← start Copilot CLI here
gh copilot
# → make changes, commit, push

# After push: sync to ~/
bash ~/scripts/sync-home.sh --no-pull   # macOS/Linux
pwsh ~/scripts/sync-home.ps1 -NoPull   # Windows
```

| Directory | Git-Remote | Purpose |
|---|---|---|
| `~/home-baseline-tmp` | ✅ `origin` → GitHub | Development, commits, push |
| `~/` | ❌ no remote | Local copy for scripts & hooks |

## Validierungsbefehle / Validation Commands

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

# PowerShell 7+ (Windows)
pwsh scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
pwsh scripts/install-hooks.ps1 -Verbose
pwsh -NoProfile scripts/setup-git-identity.ps1 -CheckOnly  # check for placeholder identity
pwsh -NoProfile scripts/setup-git-identity.ps1             # set git identity interactively
pwsh scripts/scan-agent-secrets.ps1 -FailOnHigh
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report
```

Always use `--dry-run` / `-WhatIf` before changing bootstrap logic. Reinstall hooks after editing anything under `scripts/hooks/`.

### Plattformübergreifende Testausgabe (macOS / Linux / Windows) / Cross-Platform Test Output (macOS / Linux / Windows)

When terminal output cannot be copy-pasted between machines, use the matching platform test script:

```bash
# On the Mac — collects info, commits and pushes results automatically:
bash ~/home-baseline-tmp/scripts/mac-test.sh

# On Linux / WSL:
bash ~/home-baseline-tmp/scripts/linux-test.sh
```
```powershell
# On Windows:
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1
```

Results land in `mac-test-output.txt`, `linux-test-output.txt`, or `windows-test-output.txt` in the repo. Read from Windows:
```powershell
git -C "$HOME\home-baseline-tmp" pull
Get-Content "$HOME\home-baseline-tmp\windows-test-output.txt"  # oder mac-test-output.txt, linux-test-output.txt
```

## OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them. Validate changes by running the variant that matches the current OS.

## Statistik-Pflege / Statistics Maintenance

- Maintain `docs/project-statistics.md` as the living statistics ledger for this repository.
- Update it after each completed feature/Lastenheft, each completed Spec-Kit phase, or when explicitly requested.
- Keep `## Fortschreibungsprotokoll` chronological: oldest entry first, newest entry last.
- Keep `## Gesamtstatistik` as the final top-level section.
- Include compact ASCII-only diagrams directly below the metrics table: artefact mix, phase volume, conservative reference bars, acceleration factors, and the experienced/Thorsten-Solo/AI-visible comparison.
- Add a short CEFR-B2 explanation below every diagram in German first and English second.
- Use text-friendly output only: no color-dependent signalling and no symbols that break Braille or screen-reader readability.
- Manual references for this repository are `80` lines/workday (conservative) and `100` lines/workday (Thorsten-Solo, scripting infrastructure).
- Default C#/.NET Thorsten-Solo baseline is `125` lines/workday unless the repository documents a justified deviation.
- Shared guidance and statistics-method changes must update `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md` together in the same change.

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` is binding shared guidance across the workspace family.
- All user-facing artefacts must be reviewed for inclusive use: CLI output, documentation, HTML, UI, and generated templates.
- Treat WCAG 2.2 Level AA as the default accessibility baseline wherever the criteria apply.
- Keep text-first usability visible for keyboard-only use, screen readers, Braille displays, and text browsers.
- Shared guidance and learner-facing documentation follow DE first, EN second; for large normative documents, a synchronised `.EN.md` companion file is acceptable.
- Do not update only this file when a shared rule changes; keep `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md` aligned and document any intentional deviation in the same change.

## Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Copilot-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Copilot work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

## Memory-Safe Languages (MSL) / Speichersichere Sprachen

- Level-2-Projekte SOLLEN eine speichersichere Sprache (Memory-Safe Language, MSL) als primäre Laufzeit verwenden, wenn die Zielplattform es erlaubt.
- Verbindliche MSL-Erlaubnisliste, Regeln und Begründungspflicht: siehe `constitution.md`, Prinzip XI.
- MSL-Kurzliste: Rust, Swift, C#, F#, Java, Kotlin, Scala, Go, Dart, Python, Ruby, JavaScript, TypeScript, Haskell, OCaml, Erlang, Elixir, Ada, SPARK.
- **Nicht** MSL (Begründung im Level-2-`constitution.md` erforderlich): C, C++, klassisches Objective-C, Assembly, `cc65`-C89, Zig (pre-1.0), Nim (manual), D ohne GC.
- In Nicht-MSL-Repositories (z. B. `C64Projects/cc65`) die im Level-2-`constitution.md` hinterlegte Begründung im Plan- und Task-Kontext erwähnen.
- `speckit.constitution` und `speckit.specify` SOLLEN bei Nicht-MSL-Primärsprache einen **nicht blockierenden** Hinweis ausgeben (Tooling-Aufgabe, separate Umsetzung).
- Änderungen an dieser Empfehlung erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*Level-2 projects SHOULD use a memory-safe language (MSL) as their primary runtime when the target platform allows. Authoritative rules: `constitution.md`, Principle XI. MSL short list: Rust, Swift, C#/F#, Java/Kotlin/Scala, Go, Dart, Python, Ruby, JavaScript/TypeScript, Haskell, OCaml, Erlang/Elixir, Ada/SPARK. Non-MSL languages (C, C++, Assembly, `cc65`, Zig pre-1.0, …) require a documented justification in the Level-2 `constitution.md`. In non-MSL repositories (e.g. `C64Projects/cc65`), surface the documented justification in plans and tasks. `speckit.constitution` and `speckit.specify` SHOULD emit a non-blocking advisory warning when the primary language is not an MSL — tracked as a separate tooling task. Changes to this recommendation require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

## Sichere Code-Erzeugung / Secure Code Generation (ISO 27001/27002 A.8.28)

- KI-generierter Code MUSS den etablierten Secure-Coding-Best-Practices der Zielsprache und des Frameworks folgen. LLMs erzeugen nicht zuverlässig sicheren Code; explizite Durchsetzung ist erforderlich.
- Verbindliche Regeln und sprachspezifische Anforderungen: siehe `constitution.md`, Prinzip XII.
- Sprachspezifische Kurzregeln:
  - **C / C89**: Bounds-Checking, kein `gets()`, kein ungeprüftes `sprintf()`/`strcpy()`, CERT C.
  - **C# / .NET**: parametrisierte Queries, Output-Encoding gegen XSS, Anti-Forgery-Tokens, sichere Deserialisierung, Microsoft Secure Coding Guidelines.
  - **SQL**: nur parametrisierte Statements, kein dynamisches SQL aus nicht vertrauenswürdigem Input.
  - **Bash**: Variable in Anführungszeichen (`"$var"`), kein `eval` auf nicht vertrauenswürdigem Input, `--` End-of-Options.
  - **PowerShell**: `Set-StrictMode -Version Latest`, validierte Parameter, kein `Invoke-Expression` auf nicht vertrauenswürdigem Input.
- Kryptografie: aktuelle Algorithmen (AES-256, RSA >= 3072, SHA-256+, Ed25519); veraltete (MD5, SHA-1 für Signaturen, DES, RC4) nur mit expliziter Risikobegründung.
- Fehlerbehandlung darf keine internen Zustände, Stack-Traces oder Verbindungszeichenketten an Endbenutzer preisgeben.
- Hinzugefügte Abhängigkeiten müssen aktiv gepflegt sein und dürfen keine bekannten kritischen CVEs aufweisen.
- Code-Reviews MÜSSEN eine Sicherheitsperspektive für Eingabeverarbeitung, Authentifizierung, Autorisierung, Kryptografie und Datei-/Netzwerk-I/O enthalten.
- Änderungen an dieser Regel erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*AI-generated code MUST follow the secure-coding best practices of the target language and framework. Authoritative rules: `constitution.md`, Principle XII. Language-specific short rules: C/C89 — bounds checking, no `gets()`, CERT C; C#/.NET — parameterised queries, output encoding, anti-forgery tokens, Microsoft Secure Coding Guidelines; SQL — parameterised statements only; Bash — quoted variables, no `eval` on untrusted input, `--` sentinel; PowerShell — `Set-StrictMode`, no `Invoke-Expression` on untrusted input. Cryptography: use current algorithms (AES-256, SHA-256+, Ed25519); deprecated (MD5, SHA-1 for signatures, DES, RC4) only with explicit risk acknowledgement. Error handling must not expose internals. Dependencies must have no known critical CVEs. Code reviews must include a security perspective for input handling, auth, crypto, and I/O. Changes require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

## Sichere Software-Architektur / Secure Software Architecture (ISO 27001/27002 A.8.27)

- KI-generierte und menschlich geschriebene Software-Architektur MUSS etablierten sicheren Architekturprinzipien folgen. Sicherer Code (Prinzip XII) ohne sichere Architektur reicht nicht aus — beide Ebenen müssen zusammenwirken.
- Verbindliche Regeln und sprachspezifische Architekturvorgaben: siehe `constitution.md`, Prinzip XIII.
- Verbindliche Architekturprinzipien:
  - **Trust Boundaries**: Explizite Vertrauensgrenzen definieren; alle Eingaben an Vertrauensgrenzen validieren und bereinigen.
  - **Defense in Depth**: Mindestens zwei unabhängige Sicherheitsschichten für kritische Assets.
  - **Least Privilege**: Jede Komponente, jeder Dienst und Prozess arbeitet mit minimalen Berechtigungen.
  - **Fail-Safe Defaults**: Zugriff standardmäßig verweigern, explizit gewähren; Fehlerpfade fallen in sicheren Zustand zurück.
  - **Angriffsfläche reduzieren**: Ungenutzte Endpunkte, Dienste und Debug-Funktionen deaktivieren oder entfernen.
  - **Separation of Concerns**: Authentifizierung, Autorisierung, Logging und Eingabevalidierung als Cross-Cutting Concerns implementieren, nicht ad-hoc verstreuen.
  - **Sichere Konfiguration**: Secrets in plattformgeeigneten Secret-Stores (z. B. Azure Key Vault, macOS Keychain), nie im Quellcode oder in Git-tracked Config-Dateien.
  - **Supply-Chain-Sicherheit**: Abhängigkeiten aus verifizierten Registries; Lock-Files committen; verwundbare Abhängigkeiten vor Release ersetzen.
- Änderungen an dieser Regel erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*AI-generated and human-written software architecture MUST follow secure-architecture principles. Authoritative rules: `constitution.md`, Principle XIII. Core principles: trust boundaries (validate all input at system boundaries), defense in depth (at least two independent security layers), least privilege (minimum required permissions), fail-safe defaults (deny by default), attack surface reduction (disable unused features), separation of concerns (auth/logging/validation as cross-cutting concerns), secure configuration (secrets in secret stores, never in code or Git), supply-chain security (verified registries, lock files, no known-vulnerable dependencies). Principles XII + XIII together form the complete secure-development approach: XII = tactical code-level security, XIII = strategic architecture-level security. Changes require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

## Sicherheitsdokumentation / Security Documentation (XII–XVIII Extensions)

- Jedes Level-2-Projekt MUSS die folgenden Sicherheitsdokumente pflegen, basierend auf den Templates in `.specify/templates/`:
  - **Bedrohungsmodell / Threat Model** (`threat-model-template.md`) — STRIDE-Methodik, Trust Boundaries, Risikobewertung, CAPEC-Referenzen (Prinzip XIII + XVII)
  - **Security Architecture Decision Records (S-ADR)** (`adr-template.md`) — architektonische Sicherheitsentscheidungen mit Compliance-Nachweis (Prinzip XIII)
  - **arc42 Section 8 Sicherheits-Querschnittskonzepte** (`arc42-security-template.md`) — Authentifizierung, Autorisierung, Verschlüsselung, Eingabevalidierung, Fehlerbehandlung, Logging, Abhängigkeiten, Deployment (Prinzip XIII)
  - **Sicherheits-Checkliste / Security Checklist** (`security-checklist-template.md`) — sprachspezifische Code-Review-Checkliste (Prinzip XII)
  - **Abhängigkeits-Audit / Dependency Audit** (`dependency-audit-template.md`) — CVE-Tracking, Lizenz-Compliance, Supply-Chain-Sicherheit (Prinzip XII)
  - **Sicherheits-Qualitätsszenarien / Security Quality Scenarios** (`security-quality-scenarios-template.md`) — iSAQB CPSA-F Qualitätsszenario-Methodik (Prinzip XII + XIII, SHOULD)
  - **ASVS-Verifikation / ASVS Verification** (`asvs-verification-template.md`) — OWASP ASVS Level, Scope und Evidenz (Prinzip XV, Web-/API-Projekte MUST)
  - **Supply-Chain-Evidenz / Supply Chain Evidence** (`supply-chain-evidence-template.md`) — SBOM, VEX, SLSA, OpenSSF Scorecard (Prinzip XVI, releasefähige Projekte MUST)
  - **Zero-Trust-Anwendbarkeit / Zero Trust Applicability** (`zero-trust-applicability-template.md`) — NIST SP 800-207-Bewertung (Prinzip XVIII, verteilte Systeme SHOULD)
  - **SAMM-Bewertung / SAMM Assessment** (`samm-assessment-template.md`) — OWASP SAMM Reifegrad und Verbesserungsplan (Prinzip XVIII, langlebige Projekte SHOULD)
- Projektspezifische Instanzen werden in `docs/security/` gepflegt; S-ADRs als einzelne Dateien in `docs/security/adr/`.

*Every Level-2 project MUST maintain security documents based on templates in `.specify/templates/`: threat model (STRIDE+CAPEC), S-ADRs, arc42 Section 8 security concepts, security checklist, dependency audit, security quality scenarios (SHOULD), ASVS verification (web/API MUST), supply-chain evidence (release-capable MUST), Zero Trust applicability note (distributed systems SHOULD), and SAMM assessment (long-lived projects SHOULD). Project-specific instances live in `docs/security/`; S-ADRs in `docs/security/adr/`. See `constitution.md`, Principles XII–XVIII for authoritative requirements.*

## Sicherheitsstandards & Anwendbarkeit / Security Standards & Applicability

- Vor jeder Level-2-Aufgabe die anwendbaren Sicherheitsstandards aus `constitution.md`, Prinzipien XIV-XVIII bestimmen und explizit benennen.
- `NIST SSDF` und `CWE Top 25` gelten immer für Level-2-Arbeit.
- `OWASP ASVS` gilt für Web-, API-, HTTP- und authentifizierte Dienste; der gewählte ASVS-Level muss benannt werden.
- `SBOM` gilt für releasefähige oder verteilbare Artefakte; `VEX`, wenn bekannte Schwachstellen in ausgelieferten oder geprüften Komponenten bewertet werden müssen.
- `SLSA` gilt als Soll-Vorgabe für CI/CD- oder veröffentlichte Artefakte; `Zero Trust` ist für verteilte, servicebasierte, cloudnahe oder remote-verwaltete Systeme explizit zu prüfen.
- `CAPEC` soll in Bedrohungsmodellen für die risikoreichsten Angriffswege verwendet werden; `OWASP SAMM` soll für langlebige Projekte/Workspaces in Verbesserungspläne einfließen.
- `OWASP Cheat Sheet Series`, `OWASP Proactive Controls` und bei öffentlichen OSS-Repositories oder kritischen Abhängigkeiten `OpenSSF Scorecard` sind als ergänzende Referenzen zu berücksichtigen.
- Nichtanwendbarkeit immer als `N/A` mit kurzer Begründung dokumentieren; keine stillschweigende Auslassung.

*At the start of every Level-2 task, determine and name the applicable security standards from `constitution.md`, Principles XIV-XVIII. `NIST SSDF` and `CWE Top 25` always apply. `OWASP ASVS` applies to web/API/HTTP/auth-bearing services; `SBOM` applies to releasable or distributable artefacts; `VEX` applies when known vulnerabilities in shipped/evaluated components need a disposition statement. `SLSA` is the target model for CI/CD and published artefacts; `Zero Trust` must be explicitly evaluated for distributed, service-based, cloud, or remotely managed systems. `CAPEC`, `OWASP SAMM`, `OWASP Cheat Sheet Series`, `OWASP Proactive Controls`, and `OpenSSF Scorecard` are supporting references where relevant. Record non-applicability as `N/A` with justification rather than omitting it silently.*

## Agentischer Security-Workflow / Agentic Security Workflow

- In `spec.md`, `plan.md` und `tasks.md` die anwendbaren Standards samt Evidenzpfad festhalten.
- Bei Bedrohungsmodellen `STRIDE` als Basis und bei risikoreichen Flows zusätzlich relevante `CAPEC`-Patterns verwenden.
- Bei Web/API-Features den `ASVS`-Level und den Verifikationsumfang in `docs/security/` oder gleichwertiger Projektdokumentation ablegen.
- Bei Release-/Artefakt-Arbeit `SBOM`, `VEX`, Provenance/SLSA-Nachweise und gegebenenfalls `OpenSSF Scorecard` in Release- oder Sicherheitsdokumentation einplanen.
- Bei Architekturänderungen `Zero Trust`-Anwendbarkeit und bei langlebigen Projekten `SAMM`-Folgeaktionen prüfen.
- Default-Evidenzpfad: `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`; Abweichungen nur mit lokal dokumentierter Begründung.

*Capture the applicable standards and the evidence path in `spec.md`, `plan.md`, and `tasks.md`. Use `STRIDE` as the base for threat modeling and add relevant `CAPEC` patterns for the highest-risk flows. For web/API work, record the chosen `ASVS` level and verification scope in `docs/security/` or equivalent project documentation. For release and artefact work, plan `SBOM`, `VEX`, provenance/SLSA evidence, and `OpenSSF Scorecard` review where applicable. For architectural changes, evaluate `Zero Trust`; for long-lived projects, consider `OWASP SAMM` follow-up actions. The default evidence path is `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, and `docs/security/samm-assessment.md`, unless the repository documents a justified equivalent location.*

## Architektur / Architecture

### Bootstrap-Ablauf (`bootstrap-workspace.sh` / `.ps1`) / Bootstrap Flow (`bootstrap-workspace.sh` / `.ps1`)

1. Detect existing sub-repos (`.git/` directories) inside the target directory → add them to `.gitignore`
2. Copy `scripts/` (secret scanner, hook installer, `pre-push` hook) into workspace
3. `git init` + initial commit + apply local git settings (`git config --local`)
4. `gh repo create` or `glab repo create` (private) + push
5. `bash scripts/install-hooks.sh` — copies `scripts/hooks/pre-push` → `.git/hooks/pre-push`
6. If `~/.gitconfig.d/` exists: append `[includeIf "gitdir:~/WorkspaceName/"]` block to `~/.gitconfig` pointing to `~/.gitconfig.d/<workspacename>.inc` (idempotent — no duplicate if already present)
7. Append a row to `~/README.md` workspace table and commit/push `home-baseline`

**`bootstrap-project` vs. `bootstrap-workspace` git config scope**: `bootstrap-project` applies settings only via `git config --local` inside the new project repo — it MUST NOT and does not touch `~/.gitconfig` or `~/.gitconfig.d/`. Only `bootstrap-workspace` writes `includeIf` blocks.

### Teardown-Ablauf (`teardown-workspace.sh` / `.ps1`) / Teardown Flow (`teardown-workspace.sh` / `.ps1`)

Reverses the bootstrap in a safe, ordered sequence:
1. Create backup archive (if `--backup` / `-Backup`)
2. Safety checks — abort on uncommitted changes or unpushed commits (unless `--force`)
3. Delete remote repo via `gh repo delete` or `glab repo delete` (auto-detected from remote URL); skip if `--keep-remote`
4. Delete local workspace directory
5. Clean up artifacts: remove row from `~/README.md`, entry from `~/.gitignore`, `[includeIf]` block from `~/.gitconfig`, and `~/.gitconfig.d/<name>.inc`
6. Atomic commit of all artifact changes in `~/`

Alias: `bootstrap-workspace.sh --teardown <WorkspaceName>` delegates to `teardown-workspace.sh`.
The workspace name `home-baseline` is explicitly protected (exit 2).

### Secret-Scan-Infrastruktur / Secret-Scanning Infrastructure

- **`scripts/hooks/pre-push`** — runs on every `git push`; scans only git-tracked files (`.gitignore` respected); blocks push with exit 2 on HIGH findings (secret-like filenames or content patterns).
- **`scripts/scan-agent-secrets.sh` / `.ps1`** — manual scanner targeting AI-agent directories (`.claude/`, `.codex/`, `.gemini/`, `.junie/`, `.opencode/`); accepts `--fail-on-high` / `-FailOnHigh` for CI use; requires `rg` (ripgrep).
- **`scripts/audit-agent-changes.sh` / `.ps1`** — local baseline/report workflow for agent-managed files. It stores local audit state under `~/.home-baseline/agent-audit/`, lists later file drift, and searches recent Codex, Claude, Copilot, and Continue logs for path-based hints. This is heuristic correlation, not proof of authorship.

### `.gitignore`-Whitelist-Muster / `.gitignore` Whitelist Pattern

The root `.gitignore` denies everything (`/*` and `/.*`) then explicitly allows safe entries only:
```
!.gitignore
!.gitconfig
!scripts/
!README.md
```
Credential directories (`.aws/`, `.ssh/`, `.kube/`, `.docker/`, `.gnupg/`) and agent state (`.claude/`, `.codex/`, `.gemini/`, `.junie/`) are never tracked.

### Vererbung in Child-Workspaces / Child Workspace Inheritance

Each bootstrapped workspace (e.g. `~/MyProjects/`, `~/WorkProjects/`) is an independent Git repo. It inherits a copy of `scripts/` and the `pre-push` hook but has its own `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`. Changes to home-baseline do **not** auto-propagate; workspaces must manually sync.

## Code-Konventionen / Code Conventions

### Shell-Skripte / Shell Scripts
- Bash: `#!/usr/bin/env bash` + `set -euo pipefail`
- PowerShell: `#Requires -Version 7` + `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'`
- Indentation: 2 spaces (Bash), 4 spaces (PowerShell)
- Filenames: kebab-case (`bootstrap-workspace.sh`)
- PowerShell parameters: PascalCase (`-WorkspaceName`, `-WhatIf`)
- **PowerShell naming**: Functions and Cmdlets MUST use the `Verb-Noun` pattern (e.g. `New-HBWorkspace`).
- Bash variables: lowercase_underscore
- **Documentation mandatory**: Every new script MUST have a Unix man-page (for `.sh`) in `docs/man/` and complete bilingual comment-based help (for `.ps1`). Help switches (`-h`, `--help`) MUST point to the documentation.

### Nutzerseitige Meldungen / User-Facing Messages
German primary (`Fehler:`, `Verzeichnis nicht gefunden`), English acceptable in code comments. Box-drawing characters (╔, ║, ╚, ✓, →) used for visual output blocks.

### Commits / Commits
Follow Conventional Commits: `chore:`, `docs:`, `feat:`, `fix:`. Subjects are short and imperative (example from history: `feat: bootstrap-workspace aktualisiert ~/README.md automatisch`). Always include the trailer:
```
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

### Pull Requests / Pull Requests
Include: affected scripts/docs, manual verification commands run (`--dry-run` output), and sample console output when user-visible output changes. For any change touching secret-scan or hook logic, explicitly state the risk and include scanner output.

## Sicherheitsregeln / Security Rules

- Never commit tokens, `.env` files, or local agent state (`.claude/`, `.codex/`, `.gemini/`).
- Run `bash scripts/scan-agent-secrets.sh --fail-on-high .` before pushing any change that touches hook or scanner logic.
- The pre-push hook detects patterns like `ghp_*`, `sk-*`, `AKIA*`, `AIza*`, PEM private key headers, and secret-named files (`.env*`, `*secret*`, `*.key`, `*.pem`).

## Repository-Status / Repository Status

- **Visibility**: public template repository (GitHub "Use this template" enabled)
- **License**: MIT
- **Branch protection**: `main` requires PR review; `enforce_admins: false` (owner can push directly)
- **CI**: green on `ubuntu-22.04`, `macos-14`, `windows-2022` via `.github/workflows/homogeneity-check.yml`
- **Compliance score**: 100 % (25/25 checks) as of last verified installation

## Bekannte Fallstricke & technische Entscheidungen / Known Pitfalls & Technical Decisions

### Windows: `$env:HOME` ist ein leerer String, nicht `$null` / Windows: `$env:HOME` Is an Empty String, Not `$null`
PowerShell 7's `??` null-coalescing operator does **not** catch an empty string.
Always use: `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`

### `Copy-Item`-Verzeichnisverhalten / `Copy-Item` Directory Behaviour
When the destination already exists, `Copy-Item src dst -Recurse` copies `src` **into** `dst` (creates `dst/src/`).
Use `Copy-Item src/* dst/ -Recurse -Force` to copy contents, not the container.
Bash equivalent: `cp -r src/. dst/` instead of `cp -r src dst`.

### CI: Scanner muss aus dem Parent von `$GITHUB_WORKSPACE` laufen / CI: Scanner Must Run from the Parent of `$GITHUB_WORKSPACE`
`check-homogeneity.sh/ps1` expects `TARGET_DIR` to be a relative or absolute path it can enter.
If called with just `$(basename "$GITHUB_WORKSPACE")` while `CWD` is the repo root, all files appear missing.
Correct approach:
```bash
PARENT="$(dirname "$GITHUB_WORKSPACE")"; REPO="$(basename "$GITHUB_WORKSPACE")"
cd "$PARENT" && bash "${REPO}/scripts/check-homogeneity.sh" "${REPO}"
```
PowerShell equivalent: `Set-Location (Split-Path $env:GITHUB_WORKSPACE -Parent)` then `& "${repo}/scripts/check-homogeneity.ps1" -TargetDir $repo`.

### Migrationen seriell ausführen / Run Migrations Serially
Do not run several `migrate-workspace.*` commands in parallel. Each migration invokes `init-stats.*`,
which updates the shared level 0/1/2 statistics across the whole environment. Parallel migration runs
can block each other and time out. First run `-WhatIf`/`--dry-run`, then execute real migrations one
workspace at a time with a longer timeout.

### Bash-Array `${#array[@]+...}` auf Ubuntu 22.04 nicht unterstützt / Bash Array `${#array[@]+...}` Not Supported on Ubuntu 22.04
`${#FAILURES[@]+"${#FAILURES[@]}"}` causes a `bad substitution` error on older bash.
Use the Bash-3-safe for-loop: `count=0; for _ in "${arr[@]+"${arr[@]}"}"; do count=$((count+1)); done`

### `hg-a11y`: Falsch-Positive bei fenced code blocks / `hg-a11y`: Fenced Code Block False Positives
`# comment` lines inside ` ``` ` blocks were parsed as h1 headings → false `heading-gap-h1-to-h3`.
Fix: track an `$inFencedBlock` toggle on lines matching ` ``` `.

### `hg-a11y`: Falsch-Positive bei nichtssagenden Links / `hg-a11y`: Non-Descriptive Link False Positives
`[hier](...)` and `[here](...)` inside backtick spans (documentation examples) triggered the link check.
Fix: strip inline code spans (`'`[^`]+`'`) from each line before pattern-matching links.

### `.gitignore`-Whitelist und `LICENSE` / `.gitignore` Whitelist and `LICENSE`
The whitelist `.gitignore` (`/*` blocks everything) silently ignores `git add LICENSE`.
Always add `!LICENSE` to the allowlist; use `git add -f LICENSE` if needed retroactively.

### `bootstrap-workspace`: dynamischer GitHub-Benutzername / `bootstrap-workspace`: Dynamic GitHub Username
Both scripts previously had `hindermath` hardcoded. Fixed to detect current user:
- Bash: `GH_USER=$(gh api user --jq '.login')`
- PowerShell: `$ghUser = (gh api user --jq '.login')`

### Branch-Schutz auf GitHub Free / Branch Protection on GitHub Free
The `restrictions` field (who can push directly) requires a paid plan.
On a free personal account only `required_pull_request_reviews` is effective.
Set `enforce_admins: false` to allow the owner to bypass the PR requirement.

### ANSI-Falsch-Positive in `check-homogeneity` / ANSI False Positive in `check-homogeneity`
The scanner itself contains `\033[` literals in comments → self-triggers the ANSI check.
Exclude via: `--glob '!check-homogeneity.*'` (rg) / `Where-Object { $_.Name -notmatch '^check-homogeneity\.(ps1|sh)$' }` (PS).

### `<!-- workspace-table-end -->`-Anker darf nicht entfernt werden / `<!-- workspace-table-end -->` Anchor Must Not Be Removed
`bootstrap-workspace.sh/ps1` and `bootstrap-project.sh/ps1` use this comment as an insertion anchor in `README.md`. Removing it breaks automated workspace-table updates.

### Doppelte Heading-Anker in GitHub-Markdown / Duplicate Heading Anchors in GitHub Markdown
When the same heading text appears more than once, GitHub appends `-1`, `-2` etc. to the anchor.
TOC links for second/third occurrences must include this suffix (e.g. `#macos--linux-1`).
Avoid duplicates by making heading text unique where possible.

### Pflicht für bilinguale Überschriften (WCAG 2.4.6) / Bilingual Heading Requirement (WCAG 2.4.6)
All headings **must** follow the `DE / EN` pattern. German-only headings break bilingual consistency and violate WCAG 2.4.6.
Exception: tool names / proper nouns (e.g. `### Homogeneity Guardian`, `### Compliance-Check`).

### Sprach-Tags für Code-Blöcke (WCAG 4.1.1) / Code Fence Language Tags (WCAG 4.1.1)
Every code block **must** have a language specifier. Use `text` for ASCII art, dialog examples, and directory trees.
Bare ` ``` ` without a language violates WCAG 4.1.1 (Parsing).

### WCAG 2.2 Level AA — README-Compliance / WCAG 2.2 Level AA — README Compliance
The README follows WCAG 2.2 Level AA. See `## Barrierefreiheit / Accessibility (A11Y)` for the full criteria table.
Only known gap: WCAG 3.1.2 (`lang` attributes) — GitHub strips HTML attributes, cannot be implemented.

### README-TOC-Struktur / README TOC Structure
The TOC is 2-level: `##` headings as top-level items, `###` headings as nested items (2-space indent).
`####` headings are excluded from the TOC (too granular, too many platform-specific duplicates).

### CHANGELOG.md / CHANGELOG.md
`CHANGELOG.md` documents versions v0.1.0–v0.3.0 following Keep a Changelog format.
Must be listed in `.gitignore` whitelist as `!CHANGELOG.md`.

### Ausrichtung von ASCII-Box-Drawing-Tabellen / ASCII Box-Drawing Table Alignment
All rows in a `text` code block table must have identical character width. A single trailing space before the closing `│` makes a row 1 char too long and breaks the visual frame.
Verify with: `$line.Length` (PowerShell) — all frame characters count as 1 char regardless of UTF-8 byte width.

### `specify init` — Spec-Kit-Verzeichnisaufbau / `specify init` — Spec-Kit Directory Setup
Never copy from `~/home-baseline-tmp/` manually. The correct command is:
`specify init --here --ai {agent}` — `--ai-skill` is required **only for Codex** (installs `.agents/skills/`).

### Workspace-Name beginnt mit `-` (z. B. `-h`, `-t`) / Workspace Name Starts with `-` (e.g. `-h`, `-t`)
Bash option parsing interprets `-h` as a flag, causing scripts to show help or hang waiting for stdin.
Use the `--` end-of-options sentinel: `teardown-workspace.sh -- -h`. Applies to all scripts accepting positional workspace/project names (`bootstrap-project.sh`, `bootstrap-workspace.sh`, `init-stats.sh`, `migrate-workspace.sh`, `teardown-workspace.sh`).

### Lastenheft-Umbenennung nach Feature-Abschluss / Lastenheft Rename on Feature Completion
When a feature's implementation is fully merged, rename the corresponding `Lastenheft_*.md` using:
```bash
bash scripts/rename-lastenheft.sh <LH-file> <branch-name>   # macOS/Linux
pwsh scripts/rename-lastenheft.ps1 -File <LH-file> -BranchName <branch-name>   # Windows
```
This stamps the branch name onto the filename (e.g. `Lastenheft_Foo.003-feature.md`) to mark it as archived.
The rename task is now included as the last step of every feature's Polish phase in `tasks.md` (constitution v1.1.1).
Missing this step was the root cause of 003, 005, and 006 Lastenhefte remaining unrenamed.

### Windows: `gh auth login` in Hintergrund-/Async-Prozessen / Windows: `gh auth login` in Background/Async Processes
`gh auth login --web` does NOT detect browser confirmation when run in a background or async process (e.g. Copilot CLI async shell). The browser callback never arrives.
Always run `gh auth login` in an **interactive terminal window** directly.

### macOS / Linux / Windows: `glab auth login` in Hintergrund-/Async-Prozessen / macOS / Linux / Windows: `glab auth login` in Background/Async Processes
`glab auth login --web` does NOT detect browser confirmation when run in a background or async process. The browser callback never arrives.
Always run `glab auth login` in an **interactive terminal window** directly.

### Windows: `gh`-Keyring wird ungültig / Windows: `gh` Keyring Becomes Invalid
Symptom: `Failed to log in to github.com account (keyring)` from `gh auth status`.
Fix: `gh auth logout -h github.com -u hindermath` then `gh auth login --web -p ssh` in a real terminal.

### Windows: `ssh-agent`-Dienst standardmäßig deaktiviert / Windows: `ssh-agent` Service Disabled by Default
The Windows OpenSSH Agent service is `Disabled` and requires admin rights to enable.
Use HTTPS + `gh auth setup-git` for git push instead of SSH on Windows.
After `gh auth login`, run `gh auth setup-git` once to configure git credential helper.

### Linux: `git pull` mit divergierenden Branches / Linux: `git pull` Divergent Branches
On Linux, `git pull` without config fails with "Need to specify how to reconcile divergent branches".
Fix once: `git config --global pull.rebase true`
Or per-call: `git pull --rebase`

### Linux: SSH für GitHub-Push / Linux: SSH for GitHub Push
`gh auth setup-git` may not work if credential cache has stale entries.
Reliable fix: generate SSH key, add to GitHub, set remote to SSH:
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
ssh -T git@github.com   # test
```

### Testskripte: `git pull --rebase --autostash` vor dem Push / Test Scripts: `git pull --rebase --autostash` Before Push
The `*-test.sh/ps1` scripts write the output file **before** pushing. Without `--autostash`, `git pull --rebase` fails with "unstaged changes".
All test scripts use: `git pull --rebase --autostash origin main`

### Windows: `-NoProfile` für `pwsh`-Subprozesse / Windows: `-NoProfile` for `pwsh` Subprocesses
When calling `pwsh -File script.ps1` as a subprocess, PowerShell loads the user profile.
If the profile contains Oh-My-Posh or cursor-positioning code, it throws:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: always add `-NoProfile` to subprocess calls in `windows-test.ps1`.

## Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

- Die veröffentlichten Presets liegen unter `https://github.com/hindermath/spec-kit-preset-*`.
- Die lokale Arbeitskopie der veröffentlichten Preset-Repos liegt unter `~/SpecKitPresetProjects/`.
- Die kanonischen Scaffolds in diesem Repo liegen unter `specs/spec-kit-presets/` und `specs/spec-kit-preset-repos/`.
- Verbesserungen an Presets zuerst im `home-baseline`-Scaffold einarbeiten, dann in die passenden Repos unter `~/SpecKitPresetProjects/` übertragen.
- Danach je betroffenem Preset committen, pushen und mit `specify preset add --from https://github.com/hindermath/<repo>/archive/refs/heads/main.zip` smoke-testen.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` ebenfalls aktualisiert werden müssen.
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Published presets live under `https://github.com/hindermath/spec-kit-preset-*`. Local working clones live under `~/SpecKitPresetProjects/`. Canonical scaffolds in this repository live under `specs/spec-kit-presets/` and `specs/spec-kit-preset-repos/`. Improve presets in the home-baseline scaffold first, propagate to the affected standalone preset repos, then commit, push, and smoke-test via the GitHub ZIP URL. For preset-rule changes, review constitution and all agent guidance files for required updates. Community/catalog coordination happens in `github/spec-kit#2362`.*

<!-- EN: copilot-instructions.md placeholder
[DE-Zusammenfassung: copilot-instructions.md enthält Anweisungen für GitHub Copilot im home-baseline Repository.]
-->

## Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (new), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf`, `~/.gitconfig.d/`, bootstrap-workspace, sync-home, check-homogeneity, pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab auto-detected), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`; `--` end-of-options für Workspace-Namen mit `-`-Präfix
- 006-gitlab-support: GitLab-CLI-Support für `bootstrap-workspace.*` und `bootstrap-project.*`, `--platform gitlab`, Self-hosted `--gitlab-url`, bilinguale Fehlerpfade
- 007-gitlab-release-automation: `setup-gitlab-release.*`, GitLab-Release-Templates und non-blocking manueller `release`-Job ergänzt; mit echten Releases in `sysinfotool` (`v0.1.0`) und `inventarworkerservice2` (`v0.0.1`) validiert; Detached-HEAD- und CHANGELOG-Refresh-Fixes eingearbeitet

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
