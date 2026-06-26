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

## GitHub/GitLab CLI First / GitHub/GitLab CLI zuerst

Für GitHub-Repositories zuerst die authentifizierte `gh` CLI für mögliche Schreibaktionen und Live-Repository-Operationen verwenden, einschließlich PR-/Issue-Kommentaren, PR-Statusprüfungen, Review-Follow-up, Workflow-Prüfung und Merge-/Statusabfragen. GitHub-Connector-Tools hauptsächlich für strukturierte Read-only-Inspektion oder Fälle nutzen, in denen die CLI nicht geeignet ist.

Für GitLab-Repositories die authentifizierte `glab` CLI zuerst für gleichwertige Aktionen verwenden. Bekanntermaßen fehlschlagende Connector-Schreibwege nicht wiederholt versuchen, wenn `gh`/`glab` die Aufgabe direkt erledigen kann.

For GitHub repositories, use the authenticated `gh` CLI first for feasible write actions and live repository operations, including PR/issue comments, PR status checks, review follow-up, workflow inspection, and merge/status queries. Use GitHub connector tools mainly for structured read-only inspection or when the CLI is not suitable.

For GitLab repositories, use the authenticated `glab` CLI first for equivalent actions. Do not repeatedly try connector write paths that are known to fail when `gh`/`glab` can perform the task directly.

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

### Git-Identität einrichten / Set Up Git Identity

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

**Skriptsprachenwahl / Script language choice:** Nach der OS-Erkennung vorhandene PowerShell-7-Skripte oder Cmdlets bevorzugen, wenn sie die Aufgabe loesen und `pwsh` verfuegbar ist. Fuer strukturierte lokale Automationen ist C# ueber `.NET` oder `mono` ein zulaessiger zweiter Weg, wenn Typisierung, Dateiformate oder Wiederverwendbarkeit davon profitieren. Erst wenn PowerShell oder C# nicht sinnvoll passen, die OS-nahe vorhandene Repo-Variante nutzen, auf macOS/Linux typischerweise Bash. Keine neue Sprache nur aus Bequemlichkeit einfuehren, wenn ein bestehendes Repo-Skript denselben Zweck erfuellt.

## Statistik-Pflege / Statistics Maintenance

- Maintain `docs/project-statistics.md` as the living statistics ledger for this repository.
- Update it after each completed feature/Lastenheft, each completed Spec-Kit phase, or when explicitly requested.
- Keep the `## Fortschreibungsprotokoll` section chronological: oldest entry first, newest entry last.
- Keep `## Gesamtstatistik` as the final top-level section; do not append later top-level sections after it.
- Place compact ASCII-only diagrams directly below the metrics table inside `## Gesamtstatistik`; include at least artefact mix, phase volume, conservative reference bars, acceleration factors, and the experienced/Thorsten-Solo/AI-visible comparison.
- ASCII X/Y charts must use fixed-width X slots: every documented phase keeps its slot, missing values stay blank, and overly wide series are split into labelled blocks such as `0..15`, `16..31`, and `32..47`.
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
- Review new or changed non-trivial logic for didactic inline-comment need: comments explain why, trade-off, boundary condition, historical deviation, or proof limit, not obvious code behavior.
- Follow DE first, EN second for shared guidance and learner-facing documentation; for large normative documents, a synchronised `.EN.md` companion is acceptable.
- Shared guidance must stay aligned across `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`; document any intentional deviation in the same change.

## Selbstaktualisierende Skripte / Self-Updating Scripts

Bei Sync- oder Bootstrap-Skripten, die ihr eigenes Verzeichnis kopieren oder ersetzen, vor echten Läufen immer Syntaxcheck und Vorschau verwenden: `bash -n`, `--dry-run` und `-WhatIf`. Echte Läufe aus einer stabilen Repo-Kopie wie `~/home-baseline-tmp/scripts/` starten oder sicherstellen, dass das Skript dorthin delegiert.

*For sync or bootstrap scripts that copy or replace their own directory, always use syntax checks and previews before real runs: `bash -n`, `--dry-run`, and `-WhatIf`. Start real runs from a stable repository copy such as `~/home-baseline-tmp/scripts/`, or ensure the script delegates there.*

Bei erzeugten oder schnell angepassten PowerShell-Skripten Variablen in Strings vor angrenzender Interpunktion immer mit `${Name}` abgrenzen, z. B. `${Path}:`. So entstehen keine fehlerhaften Bereichsvariablen wie `$Path:`.

*In generated or quickly adapted PowerShell scripts, always delimit variables before adjacent punctuation with `${Name}`, for example `${Path}:`. This avoids invalid scoped-variable parsing such as `$Path:`.*

Bei Workspace-/Repo-Migrationen eine vorhandene oder remote neuere `README.md` nicht stillschweigend überschreiben. Wenn die Remote-README kanonisch ist oder ausdrücklich erhalten bleiben soll, vor dem Push `fetch`/Rebase ausführen und `README.md` aus `origin/main` bewahren oder wiederherstellen.

*During workspace/repository migrations, do not silently overwrite an existing or newer remote `README.md`. If the remote README is canonical or must be preserved, fetch/rebase before pushing and preserve or restore `README.md` from `origin/main`.*

## Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Claude-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Claude work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

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

- KI-generierter und menschlich geschriebener Code MUSS den etablierten Secure-Coding-Best-Practices der Zielsprache und des Frameworks folgen. LLMs erzeugen nicht zuverlässig sicheren Code; explizite Durchsetzung ist erforderlich.
- Verbindliche Regeln und sprachspezifische Anforderungen: siehe `constitution.md`, Prinzip XII.
- Sprachspezifische Kurzregeln (Detailprofil: `.specify/templates/secure-coding-language-rules-template.md`):
  - **C / C89**: Bounds-Checking, kein `gets()`, kein ungeprueftes `sprintf()`/`strcpy()`, CERT C.
  - **C# / .NET**: parametrisierte Queries, Output-Encoding gegen XSS, Anti-Forgery-Tokens, sichere Deserialisierung, Microsoft Secure Coding Guidelines.
  - **Rust**: `unsafe` isolieren und begruenden, keine Panic-Pfade aus nicht vertrauenswuerdigem Input, Deserialisierung validieren, `cargo audit` oder gleichwertig verwenden.
  - **Go**: HTTP-/Client-Timeouts setzen, `context` propagieren, SSRF pruefen, `crypto/rand` nutzen, `govulncheck` oder gleichwertig verwenden.
  - **Swift**: keine Force-Unwraps auf nicht vertrauenswuerdigen Daten, dekodierte Eingaben validieren, Keychain/CryptoKit/TLS-Defaults nutzen, Datei-URLs einschraenken.
  - **Java / Kotlin**: DTOs validieren, Persistence-Zugriffe parametrisieren, Deserialisierung beschraenken, Auth/CSRF/CORS/Session-Defaults pruefen.
  - **Python**: Boundary-Input validieren, keine unsichere Deserialisierung oder dynamische Ausfuehrung, `subprocess`/Dateipfade einschraenken, Dependency-Audit nutzen.
  - **TypeScript / JavaScript**: Runtime-Input validieren, XSS/Prototype-Pollution/SSRF pruefen, keine dynamische Code-Ausfuehrung, Lockfiles auditieren.
  - **SQL**: nur parametrisierte Statements, kein dynamisches SQL aus nicht vertrauenswuerdigem Input.
  - **Bash**: Variable in Anfuehrungszeichen (`"$var"`), kein `eval` auf nicht vertrauenswuerdigem Input, `--` End-of-Options.
  - **PowerShell**: `Set-StrictMode -Version Latest`, validierte Parameter, kein `Invoke-Expression` auf nicht vertrauenswuerdigem Input.
- Kryptografie: aktuelle Algorithmen (AES-256, RSA >= 3072, SHA-256+, Ed25519); veraltete (MD5, SHA-1 für Signaturen, DES, RC4) nur mit expliziter Risikobegründung.
- Fehlerbehandlung darf keine internen Zustände, Stack-Traces oder Verbindungszeichenketten an Endbenutzer preisgeben.
- Hinzugefügte Abhängigkeiten müssen aktiv gepflegt sein und dürfen keine bekannten kritischen CVEs aufweisen.
- Code-Reviews MÜSSEN eine Sicherheitsperspektive für Eingabeverarbeitung, Authentifizierung, Autorisierung, Kryptografie und Datei-/Netzwerk-I/O enthalten.
- Änderungen an dieser Regel erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*AI-generated and human-written code MUST follow the secure-coding best practices of the target language and framework. Authoritative rules: `constitution.md`, Principle XII, and `.specify/templates/secure-coding-language-rules-template.md`. Language-specific short rules cover C/C89, C#/.NET, Rust, Go, Swift, Java/Kotlin, Python, TypeScript/JavaScript, SQL, Bash, and PowerShell. MSL status does not replace secure API, I/O, auth, SQL, crypto, logging, or dependency review. Cryptography: use current algorithms (AES-256, SHA-256+, Ed25519); deprecated (MD5, SHA-1 for signatures, DES, RC4) only with explicit risk acknowledgement. Error handling must not expose internals. Dependencies must have no known critical CVEs. Code reviews must include a security perspective for input handling, auth, crypto, and I/O. Changes require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

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

## Sicherheitsdokumentation / Security Documentation (XII–XIX Extensions)

- Jedes Level-2-Projekt MUSS die folgenden Sicherheitsdokumente pflegen, basierend auf den Templates in `.specify/templates/`:
  - **Bedrohungsmodell / Threat Model** (`threat-model-template.md`) — STRIDE-Methodik, Trust Boundaries, Risikobewertung, CAPEC-Referenzen (Prinzip XIII + XVII)
  - **Security Architecture Decision Records (S-ADR)** (`adr-template.md`) — architektonische Sicherheitsentscheidungen mit Compliance-Nachweis (Prinzip XIII)
  - **arc42 Section 8 Sicherheits-Querschnittskonzepte** (`arc42-security-template.md`) — Authentifizierung, Autorisierung, Verschlüsselung, Eingabevalidierung, Fehlerbehandlung, Logging, Abhängigkeiten, Deployment (Prinzip XIII)
  - **Sicherheits-Checkliste / Security Checklist** (`security-checklist-template.md`) — sprachspezifische Code-Review-Checkliste (Prinzip XII)
  - **Abhängigkeits-Audit / Dependency Audit** (`dependency-audit-template.md`) — CVE-Tracking, Lizenz-Compliance, Supply-Chain-Sicherheit (Prinzip XII)
  - **Sicherheits-Qualitätsszenarien / Security Quality Scenarios** (`security-quality-scenarios-template.md`) — iSAQB CPSA-F Qualitätsszenario-Methodik (Prinzip XII + XIII, SHOULD)
  - **ASVS-Verifikation / ASVS Verification** (`asvs-verification-template.md`) — OWASP ASVS Level, Scope und Evidenz (Prinzip XV, Web-/API-Projekte MUST)
  - **Supply-Chain-Evidenz / Supply Chain Evidence** (`supply-chain-evidence-template.md`) — SBOM, AI-SBOM, VEX, SLSA, OpenSSF Scorecard (Prinzip XVI, releasefähige Projekte MUST; AI-SBOM nur bei KI-Runtime-/Produktkomponenten)
  - **Zero-Trust-Anwendbarkeit / Zero Trust Applicability** (`zero-trust-applicability-template.md`) — NIST SP 800-207-Bewertung (Prinzip XVIII, verteilte Systeme SHOULD)
  - **SAMM-Bewertung / SAMM Assessment** (`samm-assessment-template.md`) — OWASP SAMM Reifegrad und Verbesserungsplan (Prinzip XVIII, langlebige Projekte SHOULD)
  - **Cloud-Autonomie / Cloud Autonomy** (`cloud-autonomy-applicability-template.md`) — BSI C3A-Anwendbarkeit für Cloud-Service-Auswahl, Provider-Abhängigkeiten, Audit-/Nachweisstand und Autonomie-Risiken (Prinzip XVIII, cloudnahe Projekte MUST)
  - **Cloud-Compliance-Assurance** (`cloud-compliance-assurance-template.md`) — BSI C5-Anwendbarkeit für Cloud-Testate, Assurance-Scope, Shared Responsibility, Provider-/Subprocessor-Abhängigkeiten, Datenstandort, Logging, Backup und Incident-Evidence (Prinzip XVIII, cloudnahe Projekte SHOULD)
  - **Regulatorische Anwendbarkeit / Regulatory Applicability** (`regulatory-applicability-template.md`) — NIS2, CRA, EU AI Act und DORA als Scope-/N/A-Prüfung mit ausdrücklicher Begründung für private Ausbildungsprojekte (Prinzip XIX, projektartabhängig)
- Projektspezifische Instanzen werden in `docs/security/` gepflegt; S-ADRs als einzelne Dateien in `docs/security/adr/`.

*Every Level-2 project MUST maintain security documents based on templates in `.specify/templates/`: threat model (STRIDE+CAPEC), S-ADRs, arc42 Section 8 security concepts, security checklist, dependency audit, security quality scenarios (SHOULD), ASVS verification (web/API MUST), supply-chain evidence (release-capable MUST; AI-SBOM when AI runtime/product components apply), Zero Trust applicability note (distributed systems SHOULD), SAMM assessment (long-lived projects SHOULD), cloud autonomy applicability record (cloud-dependent projects MUST), cloud compliance assurance record (cloud-dependent projects SHOULD), and regulatory applicability record (project-type-dependent). Project-specific instances live in `docs/security/`; S-ADRs in `docs/security/adr/`. See `constitution.md`, Principles XII–XIX for authoritative requirements.*

## Sicherheitsstandards & Anwendbarkeit / Security Standards & Applicability

- Vor jeder Level-2-Aufgabe die anwendbaren Sicherheitsstandards aus `constitution.md`, Prinzipien XIV-XVIII bestimmen und explizit benennen.
- `NIST SSDF` und `CWE Top 25` gelten immer für Level-2-Arbeit.
- `OWASP ASVS` gilt für Web-, API-, HTTP- und authentifizierte Dienste; der gewählte ASVS-Level muss benannt werden.
- `SBOM` gilt für releasefähige oder verteilbare Artefakte; `VEX`, wenn bekannte Schwachstellen in ausgelieferten oder geprüften Komponenten bewertet werden müssen.
- `AI-SBOM` gilt projektartabhängig bei KI-Modellen, KI-Diensten, Trainings-/Embedding-Daten, Inferenz-Infrastruktur oder KI-Runtime-Komponenten im ausgelieferten oder betriebenen System; reine Entwicklungswerkzeug-Nutzung wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `SLSA` gilt als Soll-Vorgabe für CI/CD- oder veröffentlichte Artefakte; `Zero Trust` ist für verteilte, servicebasierte, cloudnahe oder remote-verwaltete Systeme explizit zu prüfen.
- `BSI C3A` gilt projektartabhängig bei Cloud-Service-Auswahl, Cloud-Betrieb, SaaS/PaaS/IaaS, Managed Services, Container-/Artefakt-Hosting oder providerabhängigen Deployments; reine Entwicklungsinfrastruktur wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `BSI C5` gilt projektartabhängig bei Cloud-Service-Auswahl, Cloud-Betrieb, SaaS/PaaS/IaaS, Managed Services, Container-/Artefakt-Hosting, providerabhängigen Deployments oder Cloud-Assurance-Prüfungen; reine Entwicklungsinfrastruktur wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `NIS2`, `CRA`, `EU AI Act` und `DORA` werden als regulatorische Anwendbarkeitsmatrix geprüft; private Ausbildungsprojekte sind standardmäßig `N/A`, wenn kein regulierter Dienst, kein Marktprodukt, kein regulierter Kunde und keine regulierte Lieferkettenrolle vorliegt.
- `CAPEC` soll in Bedrohungsmodellen für die risikoreichsten Angriffswege verwendet werden; `OWASP SAMM` soll für langlebige Projekte/Workspaces in Verbesserungspläne einfließen.
- `OWASP Cheat Sheet Series`, `OWASP Proactive Controls` und bei öffentlichen OSS-Repositories oder kritischen Abhängigkeiten `OpenSSF Scorecard` sind als ergänzende Referenzen zu berücksichtigen.
- Nichtanwendbarkeit immer als `N/A` mit kurzer Begründung dokumentieren; keine stillschweigende Auslassung.

*At the start of every Level-2 task, determine and name the applicable security standards from `constitution.md`, Principles XIV-XIX. `NIST SSDF` and `CWE Top 25` always apply. `OWASP ASVS` applies to web/API/HTTP/auth-bearing services; `SBOM` applies to releasable or distributable artefacts; `AI-SBOM` applies when AI models, AI services, datasets, inference infrastructure, or AI runtime components are part of the released or operated system; `VEX` applies when known vulnerabilities in shipped/evaluated components need a disposition statement. `SLSA` is the target model for CI/CD and published artefacts; `Zero Trust` must be explicitly evaluated for distributed, service-based, cloud, or remotely managed systems. `BSI C3A` applies when cloud services, SaaS/PaaS/IaaS, managed services, artifact hosting, or provider-dependent deployments are part of the released or operated system; development infrastructure alone is `N/A` with a toolchain rationale. `BSI C5` applies when cloud-service selection, cloud operation, managed services, artifact hosting, provider-dependent deployments, or cloud assurance reviews are in scope; development infrastructure alone is `N/A` with the same toolchain rationale. `NIS2`, `CRA`, `EU AI Act`, and `DORA` are screened through a regulatory applicability matrix; private training projects default to `N/A` when no regulated service, market product, regulated customer, or regulated supply-chain role exists. `CAPEC`, `OWASP SAMM`, `OWASP Cheat Sheet Series`, `OWASP Proactive Controls`, and `OpenSSF Scorecard` are supporting references where relevant. Record non-applicability as `N/A` with justification rather than omitting it silently.*

## Agentischer Security-Workflow / Agentic Security Workflow

- In `spec.md`, `plan.md` und `tasks.md` die anwendbaren Standards samt Evidenzpfad festhalten.
- Bei Bedrohungsmodellen `STRIDE` als Basis und bei risikoreichen Flows zusätzlich relevante `CAPEC`-Patterns verwenden.
- Bei Web/API-Features den `ASVS`-Level und den Verifikationsumfang in `docs/security/` oder gleichwertiger Projektdokumentation ablegen.
- KI-Nutzung explizit klassifizieren: Entwicklungswerkzeug, keine KI im ausgelieferten/betriebenen System, oder KI-Runtime-/Produktkomponente; `AI-SBOM` entsprechend als `N/A` begründen oder in der Supply-Chain-Evidenz dokumentieren.
- Bei Release-/Artefakt-Arbeit `SBOM`, `AI-SBOM`, `VEX`, Provenance/SLSA-Nachweise und gegebenenfalls `OpenSSF Scorecard` in Release- oder Sicherheitsdokumentation einplanen.
- Bei Architekturänderungen `Zero Trust`-Anwendbarkeit und bei langlebigen Projekten `SAMM`-Folgeaktionen prüfen.
- Bei Cloud-Service-Auswahl oder providerabhängigen Deployments `BSI C3A`-Anwendbarkeit prüfen und den Evidenzpfad dokumentieren.
- Bei Cloud-Service-Auswahl, providerabhängigen Deployments oder Cloud-Assurance-Prüfungen `BSI C5`-Anwendbarkeit prüfen und den Evidenzpfad dokumentieren.
- Bei Release, Marktbereitstellung, Kundenübergabe, Cloud-Betrieb, KI-Runtime-/Produktkomponenten, Finanzsektor-ICT-Abhängigkeiten oder regulierten Kunden/Lieferketten `NIS2`, `CRA`, `EU AI Act` und `DORA` als Anwendbarkeitsmatrix prüfen.
- Default-Evidenzpfad: `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`, `docs/security/cloud-autonomy-applicability.md`, `docs/security/cloud-compliance-assurance.md`, `docs/security/regulatory-applicability.md`; Abweichungen nur mit lokal dokumentierter Begründung.

*Capture the applicable standards and the evidence path in `spec.md`, `plan.md`, and `tasks.md`. Use `STRIDE` as the base for threat modeling and add relevant `CAPEC` patterns for the highest-risk flows. For web/API work, record the chosen `ASVS` level and verification scope in `docs/security/` or equivalent project documentation. Classify AI usage as development tooling, absent from the released/operated system, or AI runtime/product component; document `AI-SBOM` as `N/A` or as supply-chain evidence accordingly. For release and artefact work, plan `SBOM`, `AI-SBOM`, `VEX`, provenance/SLSA evidence, and `OpenSSF Scorecard` review where applicable. For architectural changes, evaluate `Zero Trust`; for long-lived projects, consider `OWASP SAMM` follow-up actions. The default evidence path is `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`, `docs/security/cloud-autonomy-applicability.md`, `docs/security/cloud-compliance-assurance.md`, and `docs/security/regulatory-applicability.md`, unless the repository documents a justified equivalent location.*

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

### Migration: `migrate-workspace.*` seriell ausführen / Migration: Run `migrate-workspace.*` Serially
Do not run several `migrate-workspace.*` commands in parallel. Each migration starts `init-stats.*`,
which updates the shared level 0/1/2 statistics across the whole environment; parallel runs can block
each other and hit timeouts. Run the preview first, then execute real migrations one workspace at a
time with a longer timeout.

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
`specify init --here --force --integration {agent}` je Agent für `gemini`, `opencode`, `claude`, `copilot` und `codex` ausführen.

### Spec-Kit-Updates repo-weit / Repository-Wide Spec-Kit Updates
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

### Git-Identität: Platzhalter-Autor in Commits / Git Identity: Placeholder Author in Commits
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

### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` bedeutet bei GitHub nur read-only, nicht unsichtbar. Public archived Repos bleiben ohne Anmeldung sichtbar.
Archivierte Repos sind API-seitig read-only; Sichtbarkeit ändern geht deshalb nur über:
`archived=false` → `private=true` → `archived=true`.

Öffentliche Forks lassen sich nicht einfach auf private setzen. Optionen: öffentlich archiviert lassen, löschen, oder als private Mirror-Repos neu anlegen. Vor Löschungen die Repo-Liste eng festlegen; `gh repo delete` benötigt ggf. `gh auth refresh -h github.com -s delete_repo`.

Für Aktivitätsbewertungen `pushedAt` statt `updatedAt` verwenden, weil `updatedAt` durch Metadatenänderungen springt. Stars sind kontogebundene Metadaten und können über `DELETE /user/starred/{owner}/{repo}` entfernt werden; danach `user/starred` gegenprüfen.

### Lastenheft nach Feature-Abschluss umbenennen / Rename Lastenheft After Feature Completion
Nach vollständiger Implementierung eines Features MUSS das zugehörige `Lastenheft_*.md` umbenannt werden:
```bash
bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>   # macOS/Linux
pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>   # Windows
```
Beispiel: `Lastenheft_Foo.md` + Branch `003-feature` → `Lastenheft_Foo.003-feature.md`.
Dieser Schritt ist seit `constitution v1.1.1` als letzter Task der Polish-Phase in jeder `tasks.md` enthalten.
Fehlte bei Features 003, 005 und 006, weil das Template den Schritt nicht vorsah.


## Secure-Development-Hardening Intake / Secure Development Hardening Intake

- MSL-basierte Level-2-Repositories SOLLEN die zentrale sichere-Entwicklung-Basis aus `docs/secure-development/` enthalten.
- Dazu gehoeren Richtlinie, Checklisten, Sammelband, `docs/secure-development/mitgeltende-dokumente/` und die zentrale Verzahnungsdatei `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`.
- Die mitgeltende `Leitlinie_Sichere-Entwicklungs-Sandbox.md` beschreibt das Sandbox-Referenzprofil fuer KI-Agenten, Spec Kit, MSL-basierte Level-2-Projekte und die oeffentlichkeitsfaehige `absdd-image-sandbox`.
- Neue Level-2-Projekte koennen diese Basis beim Bootstrap ueber `bootstrap-project.* --primary-language <Sprache>` / `-PrimaryLanguage <Sprache>` erhalten.
- Bestehende Level-2-Projekte werden mit `prepare-secure-development-hardening.*` vorbereitet; zuerst `--dry-run` / `-WhatIf` nutzen.
- Die Vorbereitung erzeugt nur Intake- und Ordnungsartefakte: `docs/secure-development/`, `Lastenheft_Secure-Development-Hardening.md` und `Lastenheft_Abarbeitungsreihenfolge.md`.
- Das Suchmuster fuer die automatische Reihenfolge ist strikt `Lastenheft*.md`; `Lastenheft_Abarbeitungsreihenfolge.md` wird selbst nicht als Arbeitspaket einsortiert.
- Vorhandene Reihenfolge-Dateien werden geschuetzt: nur der markierte generierte Abschnitt wird aktualisiert; manuelle Begruendungen bleiben erhalten.
- Diese Vorbereitung startet keinen Spec-Kit-Lauf, erzeugt keinen Feature-Branch und befuellt keine `docs/security/`-Nachweise. Die eigentlichen Haertungslaeufe werden separat gestartet.
- Aktive Lastenhefte fuer spaetere Spec-Kit-Laeufe SOLLEN als Intake-Dateien eine klare Mindeststruktur enthalten: Zweck, Ausgangslage, Zielbild, Scope, Nicht-Ziele, Anforderungen, erwartete Artefakte, Akzeptanzkriterien und einen kopierbaren `/speckit-specify`-Prompt. Lastenhefte mit Feature-Branch-Suffix gelten als historisch und werden nicht erneut gestartet.

*MSL-based level-2 repositories SHOULD contain the central secure-development baseline from `docs/secure-development/`, including guideline, checklists, compendium, `docs/secure-development/mitgeltende-dokumente/`, and the related-documents alignment file `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`. The related `Leitlinie_Sichere-Entwicklungs-Sandbox.md` describes the sandbox reference profile for AI agents, Spec Kit, MSL-based level-2 projects, and the public-ready `absdd-image-sandbox`. New projects can receive it via `bootstrap-project.* --primary-language <language>` / `-PrimaryLanguage <language>`. Existing projects are prepared with `prepare-secure-development-hardening.*`; use `--dry-run` / `-WhatIf` first. The preparation only creates intake and ordering artefacts: `docs/secure-development/`, `Lastenheft_Secure-Development-Hardening.md`, and `Lastenheft_Abarbeitungsreihenfolge.md`. The automatic order uses the strict `Lastenheft*.md` pattern and excludes the order file itself. Existing order files are protected by updating only the marked generated section. This preparation does not start a Spec Kit run, create a feature branch, or populate `docs/security/` evidence; hardening runs are started separately. Active Lastenhefte for later Spec Kit runs should contain a clear intake structure and a copyable `/speckit-specify` prompt; branch-suffixed Lastenhefte are historical and must not be started again.*

## Spec-Kit-Modell-Routing / Spec Kit Model Routing

- Modellwahl ist operative Agenten-Routing-Guidance, keine Feature-Anforderung. Modellnamen nicht in `spec.md`, `plan.md`, `tasks.md` oder einzelne Feature-Specs schreiben; diese Artefakte muessen reproduzierbar bleiben, auch wenn Modellnamen wechseln oder ein anderer KI-Agent verwendet wird.
- Der jeweilige Agent soll diese Empfehlungen auf seine aktuell verfuegbaren Modelle abbilden; keine feste Anbieter- oder Modellbindung ableiten.
- Fuer Spec-Kit-Spezifikation, Klaerung, Planung, Tasks und Analyse (`/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-analyze`; je nach Agent auch `/speckit.specify` usw.) das staerkste verfuegbare Frontier-Reasoning-/Coding-Modell bevorzugen.
- Fuer vollstaendige, lang laufende `/speckit-implement`-Laeufe das staerkste verfuegbare Long-Running-Agent-Modell bevorzugen; das Frontier-Modell nutzen, wenn maximale Urteilsguete wichtiger ist als Laufzeitstabilitaet.
- Fuer fokussierte Reviews oder CI-Fixes ein coding-optimiertes Modell bevorzugen.
- Fuer triviale Bereinigung, Formatierung oder risikoarme mechanische Edits ist ein schnelles kleines Coding-Modell akzeptabel.

*Model choice is operational agent-routing guidance, not a feature requirement. Do not pin model names in `spec.md`, `plan.md`, `tasks.md`, or individual feature specs; those artifacts must stay reproducible even when model names change or another AI agent is used. Each agent should map these recommendations to its currently available models; do not derive a fixed vendor or model requirement. For Spec-Kit specification, clarification, planning, task generation, and analysis (`/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-analyze`; or `/speckit.specify` etc. depending on the agent surface), prefer the strongest available frontier reasoning/coding model. For complete long-running `/speckit-implement` runs, prefer the strongest available long-running agent model; use the frontier model when maximum judgment quality is more important than runtime stability. For focused review or CI fixes, prefer a coding-optimized model. For trivial cleanup, formatting, or low-risk mechanical edits, a fast small coding model is acceptable.*

## Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

- Standard-Preset-Set: `security-governance` v0.6.0 prio 10, `architecture-governance` v0.5.0 prio 20, `isaqb-architecture-governance` v0.2.0 prio 30, `a11y-governance` v0.4.0 prio 40, `cross-platform-governance` v0.2.0 prio 50, `agent-parity-governance` v0.3.0 prio 60.
- `a11y-governance` v0.4.0 ergänzt didaktische Inline-Code-Kommentar-Governance für neue oder geaenderte nicht-triviale Logik.
- `security-governance` v0.6.0 fuehrt `AI-SBOM` weiter als bedingt anwendbare Supply-Chain-Evidenz, ergänzt sprachspezifische Secure-Coding-Profile und ergänzt regulatorische Anwendbarkeit für NIS2, CRA, EU AI Act und DORA. Reine Entwicklungswerkzeug-Nutzung bleibt `N/A`; KI-Runtime-/Produktkomponenten benoetigen Evidenz nach G7/BSI AI-SBOM-Clustern; private Ausbildungsprojekte dokumentieren regulatorische Nichtanwendbarkeit mit kurzer Begründung.
- `architecture-governance` v0.5.0 ergänzt `BSI C3A` als bedingte Cloud-Autonomie-Evidenz und `BSI C5` als bedingte Cloud-Compliance-Assurance-Evidenz für Cloud-Service-Auswahl, Provider-Abhängigkeiten, Audit-/Nachweisstand, Shared Responsibility und Betriebsnachweise.
- Alle sechs Presets enthalten ab diesem Release-Block audit-ready Spec-Kit-Run-Evidenz: `Applicable` / `N/A` / `Open`, Begründung, Evidenzpfad, Reviewer, Restrisiko und Follow-up muessen im aktuellen Spec-Kit-Lauf dokumentiert werden.
- Alle sechs Presets sind seit 2026-05-04 im `github/spec-kit` Community-Katalog enthalten und liegen zusätzlich als veröffentlichte Repos unter `https://github.com/hindermath/spec-kit-preset-*`.
- Neue Level-2-Projekte SOLLEN bei der Spec-Kit-Initialisierung die passende Preset-Teilmenge installieren; C#/.NET-Level-2-Projekte verwenden standardmäßig alle sechs Presets, sofern keine begründete Ausnahme dokumentiert ist.
- Referenz-Rollout für alle sechs Presets: `RiderProjects/TinyPl0`, `RiderProjects/TinyCalc`, `RiderProjects/TuiVision`, `RiderProjects/InventarWorkerService`.
- Installation bevorzugt über den Community-Katalog, wenn `specify` das unterstützt; für reproduzierbare Pins die versionierten GitHub-ZIP-URLs aus `constitution.md`/`README.md` verwenden.
- `.specify/presets/` und generierte Agenten-/Command-Dateien committen, wenn Presets Projekt-Policy sind; `.specify/presets/.cache/` nie committen.
- Nach Installation oder Update prüfen: `specify preset list`, mindestens ein `specify preset info <id>`, bei Template-Fragen zusätzlich `specify preset resolve <template>`.
- Die lokale Arbeitskopie der veröffentlichten Preset-Repos liegt unter `~/SpecKitPresetProjects/`; kanonische Scaffolds in diesem Repo liegen unter `specs/spec-kit-presets/` und `specs/spec-kit-preset-repos/`.
- Verbesserungen an Presets zuerst im `home-baseline`-Scaffold einarbeiten, dann in die passenden Repos unter `~/SpecKitPresetProjects/` übertragen, committen, pushen und mit GitHub-ZIP-URL smoke-testen.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `scripts/templates/*` ebenfalls aktualisiert werden müssen.
- Bei jeder Preset-Version oder Prioritätsänderung die kompakte Preset-Tabelle und ZIP-Installationsbefehle in `README.md`, die Matrix in `constitution.md`/`.specify/memory/constitution.md`, die vier Agenten-Dateien, `scripts/templates/speckit-workflow-section.md` und die Agenten-Templates gemeinsam aktualisieren.
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Standard preset set: `security-governance` v0.6.0 prio 10, `architecture-governance` v0.5.0 prio 20, `isaqb-architecture-governance` v0.2.0 prio 30, `a11y-governance` v0.4.0 prio 40, `cross-platform-governance` v0.2.0 prio 50, and `agent-parity-governance` v0.3.0 prio 60. `a11y-governance` v0.4.0 adds didactic inline-code-comment governance for new or changed non-trivial logic. `architecture-governance` v0.5.0 adds conditional `BSI C3A` cloud-autonomy evidence and `BSI C5` cloud-compliance assurance evidence for cloud-service selection, provider dependencies, audit/assurance status, shared responsibility, and operational evidence. `security-governance` v0.6.0 keeps conditional `AI-SBOM` evidence, language-specific secure-coding profiles, and regulatory applicability screening for NIS2, CRA, EU AI Act, and DORA: development-tool-only AI usage is `N/A`, AI runtime/product components require G7/BSI AI-SBOM cluster evidence, and private training projects record regulatory `N/A` when no regulated scope exists. All six presets now include audit-ready Spec-Kit run evidence: `Applicable` / `N/A` / `Open`, rationale, evidence path, reviewer, residual risk, and follow-up must be documented for the current Spec-Kit run. All six presets are in the `github/spec-kit` community catalog as of 2026-05-04 and are also published under `https://github.com/hindermath/spec-kit-preset-*`. New Level-2 projects should install the applicable subset; C#/.NET Level-2 projects default to all six unless a justified exception is documented. Commit `.specify/presets/` and generated agent command updates when presets are project policy, but never commit `.specify/presets/.cache/`. Verify installs with `specify preset list`, `specify preset info`, and where relevant `specify preset resolve`. Improve presets in the home-baseline scaffold first, propagate to standalone preset repos, then commit, push, and smoke-test via GitHub ZIP URL. Preset-rule changes and preset version/priority changes require reviewing constitution, README tables/install snippets, all agent guidance files, and relevant templates together. Community/catalog coordination happens in `github/spec-kit#2362`.*

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
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Added Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency)
- 006-gitlab-support: Added GitLab CLI support documentation, `glab auth login` pitfall guidance, and spec artifacts for GitLab bootstrap support
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
