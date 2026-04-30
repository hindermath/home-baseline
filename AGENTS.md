# Repository Guidelines

## Beschreibung / Description

Dieses Repository ist die **oberste Ebene** der privaten Workspace-Infrastruktur. Diese Datei enthält Anweisungen für KI-Agenten wie Codex und GitHub Copilot.

*This repository is the **top-level** private workspace infrastructure. This file contains instructions for AI agents such as Codex and GitHub Copilot.*

## Projektstruktur & Modulorganisation / Project Structure & Module Organization
This repository is the top-level `home-baseline` workspace bootstrap. Keep changes focused on the root documentation and the reusable scripts under `scripts/`.

- `README.md`: bilingual usage and setup guide for the workspace baseline.
- `scripts/bootstrap-workspace.sh`: Bash bootstrap flow for macOS/Linux.
- `scripts/bootstrap-workspace.ps1`: PowerShell 7 bootstrap flow for Windows.
- `scripts/teardown-workspace.sh`: removes a workspace — remote repo, local directory, and artifacts (`~/README.md`, `~/.gitignore`, `~/.gitconfig`).
- `scripts/teardown-workspace.ps1`: PowerShell 7 equivalent of teardown.
- `scripts/install-hooks.*`: installs Git hooks into `.git/hooks/`.
- `scripts/setup-git-identity.*`: detects and fixes placeholder git identity (`Your Name` / `your@email.example`) in `~/.gitconfig`; called automatically by `bootstrap-workspace.*`.
- `scripts/scan-agent-secrets.*`: manual or hook-driven secret scanning.
- `scripts/audit-agent-changes.*`: local baseline/report workflow to correlate agent-managed file changes with recent local agent logs.
- `scripts/update-spec-kit.*`: dynamically refreshes Spec-Kit integrations across Level-0, Level-1, and Level-2 repos while preserving local governance templates.
- `scripts/hooks/pre-push`: shared hook copied into target repositories.

There is no `src/` or formal test tree; the scripts themselves are the product.

## Build-, Test- und Entwicklungsbefehle / Build, Test, and Development Commands
There is no build step. Validate changes by running the scripts directly.

```bash
bash scripts/bootstrap-workspace.sh --dry-run FlutterProjects
bash scripts/install-hooks.sh
bash scripts/setup-git-identity.sh --check-only    # Git-Identität prüfen / check identity
bash scripts/setup-git-identity.sh                 # Git-Identität einrichten / set identity
bash scripts/scan-agent-secrets.sh --fail-on-high .
bash scripts/audit-agent-changes.sh snapshot
bash scripts/audit-agent-changes.sh report
bash scripts/update-spec-kit.sh --dry-run
pwsh scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
pwsh scripts/install-hooks.ps1 -Verbose
pwsh scripts/setup-git-identity.ps1 -CheckOnly     # Git-Identität prüfen / check identity
pwsh scripts/setup-git-identity.ps1                # Git-Identität einrichten / set identity
pwsh scripts/scan-agent-secrets.ps1 -FailOnHigh
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report
pwsh -NoProfile scripts/update-spec-kit.ps1 -WhatIf
```

Use `--dry-run` and `-WhatIf` before changing bootstrap logic. Reinstall hooks after editing files in `scripts/hooks/`.

Use `audit-agent-changes.*` when agent-managed files under `~/` should stay locally traceable across later updates. The workflow is: create a baseline once with `snapshot`, then compare later state with `report`. The audit state is stored locally under `~/.home-baseline/agent-audit/` and is not intended to be committed.

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

## Testleitlinien / Testing Guidelines
Manual verification is the current test strategy. For bootstrap changes, test both shells in safe mode: Bash with `--dry-run`, PowerShell with `-WhatIf`. For hook or scanning changes, run the relevant installer, then execute the scanner against the repo root and confirm expected exit codes.

### Plattformübergreifendes Testen (macOS / Linux / Windows) / Cross-Platform Testing (macOS / Linux / Windows)
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
- Gemeinsame Default-Referenz für C#/.NET-Projekte: `125` Zeilen/Arbeitstag (Thorsten-Solo), sofern das jeweilige Repo keinen abweichenden, begründeten Wert dokumentiert.
- Beim Umrechnen in Stunden: `7.8` Stunden (`7h 48m`) pro Arbeitstag (TVöD-Basis).
- Beim Umrechnen in Monate: `21.5` Arbeitstage/Monat; Urlaubstage: 30 Tage bis Ende 2026, ab 2027 dann 31 Tage pro Jahr (TVöD, 5-Tage-Woche).
- Beschleunigungsfaktoren vergleichen die manuelle Referenz gegen sichtbare Git-Aktivtage — keine Stoppuhrmessung, sondern blended repository speedup.
- Shared guidance darf nicht nur in einer der Agenten-Dateien aktualisiert werden; intentionale Abweichungen müssen in derselben Änderung dokumentiert sein.

*Maintain `docs/project-statistics.md` as the living statistics ledger for this repository. Update after each completed feature/Lastenheft, Spec-Kit phase, or on explicit request. Keep the Fortschreibungsprotokoll in chronological order (oldest first). Keep `## Gesamtstatistik` as the final top-level section. Manual references: `80` lines/workday (conservative) and `100` lines/workday (Thorsten-Solo, scripting infra). Default C#/.NET Thorsten-Solo baseline: `125` lines/workday unless the repo documents a justified deviation. TVöD workday: `7.8 h`. Acceleration factors compare manual reference against observable Git active days — not stopwatch time.*

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` ist Leitspruch und Pflicht zugleich.
- Alle nutzerseitigen Artefakte müssen barrierefrei gedacht und überprüft werden: CLI-Ausgaben, Dokumentation, HTML, UI und generierte Templates.
- WCAG 2.2 Level AA ist die Standard-Basis, sobald die Kriterien auf das Artefakt anwendbar sind.
- Inhalte müssen in textorientierten Hilfsmittel-Setups nutzbar bleiben, insbesondere mit Tastatur, Screenreadern, Braille-Zeilen und Textbrowsern.
- Für gemeinsame Guidance gilt DE zuerst, EN danach; bei großen normativen Dokumenten ist alternativ eine synchron gepflegte `.EN.md`-Parallelfassung zulässig.
- Shared guidance wird immer gemeinsam in `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` aktualisiert. Intentionale Abweichungen müssen in derselben Änderung dokumentiert sein.

## Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Agentenarbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and agent work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

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

## Commit- & Pull-Request-Leitlinien / Commit & Pull Request Guidelines
Recent history follows Conventional Commit prefixes: `chore:`, `docs:`, `feat:`. Keep subjects short and imperative, for example `feat: bootstrap-workspace aktualisiert ~/README.md automatisch`.

Pull requests should include:

- a short description of the workflow change,
- affected scripts or docs,
- manual verification commands you ran,
- sample output or screenshots when user-visible console output changes.

## Sicherheits- & Konfigurationstipps / Security & Configuration Tips
Do not commit tokens, `.env` files, or local agent state. If you touch secret-scan behavior or hooks, mention the risk explicitly in the PR and re-run the scanner before pushing.

## Aktive Technologien / Active Technologies
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
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30, optional `gh`/`glab` push remotes (008-spec-kit-update-automation)
- File system — dynamic Level-0/Level-1/Level-2 discovery via `.git` + `.specify/`; Spec-Kit templates, `.opencode/command/*.md`, `.specify/memory/constitution.md` (008-spec-kit-update-automation)

## Letzte Änderungen / Recent Changes
- 001-workspace-homogeneity-guardian: Added Bash 5+ (primär), PowerShell Core 7+ (Windows-Parität) + `git`, `bash` ≥ 5, `ripgrep (rg)`, `sha256sum` (Linux/WSL) /
- 003-public-template-prep: Repo auf Public Template umgestellt, MIT-Lizenz, Branch-Protection, alle persönlichen Daten entfernt, Bootstrap-Skripte dynamisch (kein hardcodierter Username mehr)
- 004-readme-ausbau-ci-fixes-sync: sync-home.sh/.ps1 hinzugefügt; README vollständig überarbeitet (2-stufiges TOC, Auszubildende, Spec-Kit, WCAG 2.2 AA); CHANGELOG.md angelegt; CI-Fixes (TARGET_DIR, windows-2022, -TargetDir)
- 005-readme-tabelle-specify-init: Workflow-Tabelle ausgerichtet (5 Zeilen 64→63 Zeichen); Abschnitt „Verzeichnis vorbereiten" auf agentenweise `specify init --here --force --integration {agent}` umgestellt
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf`, `~/.gitconfig.d/`, bootstrap-workspace, sync-home, check-homogeneity, pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` neu — Backup, Remote-Löschung (GitHub/GitLab auto-detected), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: GitLab-CLI-Support für `bootstrap-workspace.*` und `bootstrap-project.*`, Self-hosted `--gitlab-url`, bilinguale Fehlerpfade und GitLab-Dokumentation ergänzt
- 007-gitlab-release-automation: `setup-gitlab-release.*`, GitLab-Release-Templates und non-blocking manueller `release`-Job ergänzt; mit echten Releases in `sysinfotool` (`v0.1.0`) und `inventarworkerservice2` (`v0.0.1`) validiert; Detached-HEAD- und CHANGELOG-Refresh-Fixes eingearbeitet
- 008-spec-kit-update-automation: `update-spec-kit.sh/.ps1` ergänzt; dynamische Level-0/1/2-Erkennung, `specify init --here --force --integration <agent>` für Claude/OpenCode/Gemini/Copilot/Codex, Constitution-/Template-Erhalt und `.opencode/command`-Tracking automatisiert

## Projektstatus / Repository Status

- **Template-Repo**: öffentlich — via „Use this template" nutzbar (keine History-Übertragung, kein Upstream-Link)
- **Lizenz**: MIT | **CI**: ✅ ubuntu-22.04, macos-14, windows-2022 | **Score**: 100 %

## Bekannte Fallstricke / Known Pitfalls

| Problem | Ursache | Fix |
|---|---|---|
| Windows `$env:HOME` leer | PS7 `??` fängt `''` nicht ab | `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` |
| `gh auth login --web` bleibt hängen | Browser-Callback kommt in Hintergrund-/Async-Prozessen nicht an | In interaktivem Terminal ausführen; nicht aus Copilot-CLI-Async-Shell |
| `glab auth login --web` bleibt hängen | Browser-Callback kommt in Hintergrund-/Async-Prozessen nicht an | In interaktivem Terminal ausführen |
| Windows `gh`-Keyring ungültig | Windows Credential Store korrupt oder veraltet | `gh auth logout -h github.com -u hindermath`, dann interaktiv neu anmelden und `gh auth setup-git` |
| Windows `ssh-agent` braucht Adminrechte | OpenSSH-Agent-Dienst standardmäßig deaktiviert | HTTPS + `gh auth setup-git` statt SSH verwenden |
| `pwsh -File` scheitert mit `CursorPosition` | Profil lädt im Subprozess | `-NoProfile` zu allen `pwsh`-Subprozessaufrufen hinzufügen |
| Parallele `migrate-workspace.*`-Läufe laufen in Timeouts | Jeder Migrationslauf startet `init-stats.*`, das global Level 0/1/2-Statistiken aktualisiert und sich parallel gegenseitig ausbremst | Workspaces seriell migrieren; bei mehreren Workspaces erst `-WhatIf`/`--dry-run`, dann echte Läufe nacheinander mit längerem Timeout |
| CI: Dateien „missing" | Relativer Pfad als CWD=Repo-Root | `cd "$(dirname $GITHUB_WORKSPACE)"` vor Scanner-Aufruf |
| bash `bad substitution` | `${#arr[@]+...}` auf Ubuntu 22.04 | Bash-3-sichere `for`-Schleife zum Zählen |
| Linux `git pull` meldet divergierende Branches | Kein globales Rebase-Setup | `git config --global pull.rebase true` |
| Linux HTTPS-Credential-Cache unzuverlässig | Push über HTTPS verliert Auth-Kontext | SSH für GitHub-Push einrichten und Remote auf `git@github.com:...` umstellen |
| `Copy-Item` kopiert Verzeichnis in Verzeichnis | Ziel existiert bereits | `Copy-Item src/* dst/ -Recurse -Force` |
| `LICENSE` von `.gitignore` ignoriert | Whitelist-Modell | `!LICENSE` in `.gitignore` eintragen |
| ANSI-Falsch-Positive im Scanner | Scanner enthält `\033[` als Literal | `check-homogeneity.*` aus ANSI-Scan ausschließen |
| `hg-a11y` h1 in Code-Blöcken | `# comment` in ` ``` ` als Heading geparst | `$inFencedBlock`-Toggle |
| Bootstrap hardcodierter Username | `hindermath` war fest eingebaut | `gh api user --jq '.login'` dynamisch |
| GitHub `archived` Repo bleibt öffentlich sichtbar | Archivieren macht ein Repo nur read-only, nicht unsichtbar | Public Source-Repos bei Bedarf auf `private` setzen; Forks separat behandeln |
| GitHub blockiert Sichtbarkeitsänderung bei archivierten Repos | Archivierte Repos sind API-seitig read-only | Ablauf: `archived=false` → `private=true` → `archived=true` |
| Öffentliche GitHub-Forks lassen sich nicht privat setzen | Fork-Sichtbarkeit folgt GitHub-Fork-Regeln | Öffentlich archiviert lassen, löschen oder als privates Mirror-Repo neu anlegen |
| `gh repo delete` schlägt mit fehlendem Scope fehl | CLI-Token hat keinen `delete_repo`-Scope | `gh auth refresh -h github.com -s delete_repo`, dann Löschung eng auf bestätigte Repos begrenzen |
| Repo-Aktivität falsch bewertet | `updatedAt` springt auch bei Metadatenänderungen | Für Housekeeping `pushedAt` verwenden; z. B. nach letzter Push-Aktivität klassifizieren |
| GitHub-Stars sollen bereinigt werden | Stars sind kontogebundene Metadaten | Über `DELETE /user/starred/{owner}/{repo}` entfernen und mit `user/starred` gegenprüfen |
| Doppelte Überschriften im TOC | GitHub hängt `-1`, `-2` an gleiche Texte | Ankertexte im TOC mit Suffix verwenden oder Headings umbenennen |
| Nicht-bilinguale Überschriften | Heading nur auf Deutsch | Alle Headings müssen `DE / EN`-Format haben |
| Code-Block ohne Sprach-Tag | Bare ` ``` ` verletzt WCAG 4.1.1 | Immer Sprache angeben — ` ```text ` für ASCII/Dialog |
| WCAG 3.1.2 `lang`-Attribute | GitHub entfernt HTML-Attribute | Platform-Einschränkung — in Barrierefreiheit-Abschnitt dokumentiert |
| ASCII-Box-Drawing-Tabellen falsch ausgerichtet | Ein überzähliges Leerzeichen vor dem schließenden `│` macht eine Zeile 1 Zeichen zu lang | Alle Zeilen auf exakt gleiche Zeichenbreite prüfen (PS: `$line.Length`) |
| `*-test.sh/ps1` blockiert `git pull --rebase` | Output-Datei wird vor dem Push geschrieben | `git pull --rebase --autostash origin main` vor dem Push verwenden |
| Spec-Kit-Verzeichnis manuell kopiert | `cp -r ~/home-baseline-tmp/` setzt lokalen Klon voraus | `bash scripts/update-spec-kit.sh` / `pwsh scripts/update-spec-kit.ps1` oder agentenweise `specify init --here --force --integration {agent}` verwenden |
| Lastenheft nach Feature-Abschluss nicht umbenannt | `tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben) | `bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` (macOS/Linux) · `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>` (Windows) |
| Workspace-Name beginnt mit `-` (z.B. `-h`) | Shell interpretiert ihn als Flag | `teardown-workspace.sh -- -h` (doppeltes Minus vor dem Namen); gilt analog für alle Skripte mit Positionsargumenten |

## Spec-Kit-Update-Pflege / Spec Kit Update Maintenance

- Fuer repo-weite Spec-Kit-Aktualisierungen zuerst `bash scripts/update-spec-kit.sh --dry-run` bzw. `pwsh scripts/update-spec-kit.ps1 -WhatIf` ausfuehren.
- Echte Laeufe laufen ueber `bash scripts/update-spec-kit.sh --commit --push` oder `pwsh scripts/update-spec-kit.ps1 -Commit -Push`; manuelle Massenkopien aus `~/home-baseline-tmp` sind nicht zulaessig.
- Das Skript erkennt Level 0 (`~/home-baseline-tmp`), Level-1-Workspaces und Level-2-Projekte dynamisch ueber `.git` plus `.specify/`; neue Repos werden automatisch aufgenommen.
- `RiderProjects/TuiVision` gehoert zur normalen Zielmenge und darf nur uebersprungen werden, wenn es bereits sauber und aktuell ist.
- Lokale Governance in `.specify/memory/constitution.md`, `spec-template.md`, `plan-template.md` und `tasks-template.md` muss nach `specify init --force` erhalten bleiben.
- Die Standard-Template-Quelle ist das oeffentliche `home-baseline`-Repo, aus dem das Skript laeuft. Private Repos wie `RiderProjects/TuiVision` sind keine implizite Voraussetzung und duerfen nur bewusst mit `--template-source` / `-TemplateSource` als Override genutzt werden.
- OpenCode wird ueber `.opencode/command/*.md` getrackt. Das `.opencode/`-Root, Caches, Sessions, Logs, Credentials und lokale Abhaengigkeiten bleiben ausgeschlossen.

*For repository-wide Spec-Kit updates, run the dry-run first, then use the paired update scripts with `--commit --push` / `-Commit -Push`. The scripts dynamically discover Level 0, Level 1, and Level 2 repositories, keep TuiVision in scope, preserve local governance templates and constitution memory, use public `home-baseline` as the default template source, and track only `.opencode/command/*.md` for OpenCode.*

## Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

- Die veröffentlichten Presets liegen unter `https://github.com/hindermath/spec-kit-preset-*`.
- Die lokale Arbeitskopie der veröffentlichten Preset-Repos liegt unter `~/SpecKitPresetProjects/`.
- Die kanonischen Scaffolds in diesem Repo liegen unter `specs/spec-kit-presets/` und `specs/spec-kit-preset-repos/`.
- Verbesserungen an Presets zuerst im `home-baseline`-Scaffold einarbeiten, dann in die passenden Repos unter `~/SpecKitPresetProjects/` übertragen.
- Danach je betroffenem Preset committen, pushen und mit `specify preset add --from https://github.com/hindermath/<repo>/archive/refs/heads/main.zip` smoke-testen.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` ebenfalls aktualisiert werden müssen.
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Published presets live under `https://github.com/hindermath/spec-kit-preset-*`. Local working clones live under `~/SpecKitPresetProjects/`. Canonical scaffolds in this repository live under `specs/spec-kit-presets/` and `specs/spec-kit-preset-repos/`. Improve presets in the home-baseline scaffold first, propagate to the affected standalone preset repos, then commit, push, and smoke-test via the GitHub ZIP URL. For preset-rule changes, review constitution and all agent guidance files for required updates. Community/catalog coordination happens in `github/spec-kit#2362`.*

<!-- EN: AGENTS.md placeholder
[DE-Zusammenfassung: AGENTS.md enthält Anweisungen für den Codex Agenten im home-baseline Repository.]
-->

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
