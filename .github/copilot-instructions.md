# Copilot Instructions – home-baseline

This is the top-level workspace bootstrap for `~/`.
It tracks only safe infrastructure files via a whitelist `.gitignore` and distributes reusable scripts to child workspaces.

## Repository-Zweck / Repository Purpose

`home-baseline` manages workspace initialisation: it provides scripts that turn a plain directory into a private GitHub or GitLab repo with `.gitignore`, standard scripts, and a `pre-push` secret-scanning hook installed. It does **not** contain application source code.

## Arbeitsverzeichnis / Working Directory

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
verwenden; schreibender Home-Sync laeuft nur auf dem Host.

*Keep the personal fork at `~/home-baseline-source` permanently as the versioned
Level 0 source. `sync-home.*` distributes only `homeRuntime`: scripts, shared
agent guidance, and selected Spec Kit surfaces. Read documentation, specs,
preset sources, and evidence directly from the clone; `STATS.md` and private
agent state remain local. Source-only changes do not require Home sync. Use
`--check-only` / `-CheckOnly` before a real run and review conflicts before
using force. Writing Home sync runs remain host-only.*

## GitHub/GitLab CLI First / GitHub/GitLab CLI zuerst

Für GitHub-Repositories zuerst die authentifizierte `gh` CLI für mögliche Schreibaktionen und Live-Repository-Operationen verwenden, einschließlich PR-/Issue-Kommentaren, PR-Statusprüfungen, Review-Follow-up, Workflow-Prüfung und Merge-/Statusabfragen. GitHub-Connector-Tools hauptsächlich für strukturierte Read-only-Inspektion oder Fälle nutzen, in denen die CLI nicht geeignet ist.

Für GitLab-Repositories die authentifizierte `glab` CLI zuerst für gleichwertige Aktionen verwenden. Bekanntermaßen fehlschlagende Connector-Schreibwege nicht wiederholt versuchen, wenn `gh`/`glab` die Aufgabe direkt erledigen kann.

For GitHub repositories, use the authenticated `gh` CLI first for feasible write actions and live repository operations, including PR/issue comments, PR status checks, review follow-up, workflow inspection, and merge/status queries. Use GitHub connector tools mainly for structured read-only inspection or when the CLI is not suitable.

For GitLab repositories, use the authenticated `glab` CLI first for equivalent actions. Do not repeatedly try connector write paths that are known to fail when `gh`/`glab` can perform the task directly.

## Skriptreferenz und Quellpfad / Script Reference and Source Path

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

## Lernreihen-Governance / Learning Series Governance

### Git-Hosting fuer Lernende / Git Hosting for Learners

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

## Container-First fuer KI-Agenten / Container-First for AI Agents

Jeder KI-Agenten-Aufruf fuer Arbeit an einem Secure-Trader-System (Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker) erfolgt in einer freigegebenen Sandbox bzw. einem Container (Referenz: `absdd-image-sandbox`), nie direkt auf dem Arbeitsplatz-Rechner der Auszubildenden, auf gemeinsam genutzten Servern oder in produktionsnahen Umgebungen. In den Lernreihen ist diese Regel ein Gate ab dem 1. Lehrjahr (Unit 00) und gilt, bevor der erste Agent gestartet wird. Nur agentenlose Taetigkeit (Lesen, Review, allgemeine Entwicklung) darf ausserhalb der Sandbox erfolgen. In ISO/IEC-27001-zertifizierten (oder gleichwertigen) Organisationen ist dies ein pruefbarer Kontrollpunkt (u. a. A.5.23, A.8.25, A.8.28, A.8.31). Verbindliche Grundlagen: `docs/learning-units/Secure-Trader-Sandbox-Preflight.md`, `docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md` und `docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`.

*Every AI-agent invocation for work on a Secure Trader system (Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker) runs in an approved sandbox/container (reference: `absdd-image-sandbox`), never directly on the apprentice's workstation, on shared servers, or in production-near environments. In the learning series this rule is a gate from year 1 (unit 00) and applies before the first agent is started. Only agent-free work (reading, review, general development) may happen outside the sandbox. In ISO/IEC 27001-certified (or equivalent) organizations this is an auditable control point (e.g. A.5.23, A.8.25, A.8.28, A.8.31). Authoritative basis: `docs/learning-units/Secure-Trader-Sandbox-Preflight.md`, `docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md`, and `docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`.*

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

### Plattformübergreifende Testausgabe (macOS / Linux / Windows) / Cross-Platform Test Output (macOS / Linux / Windows)

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

## OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them. Validate changes by running the variant that matches the current OS.

**Skriptsprachenwahl / Script language choice:** Nach der OS-Erkennung vorhandene PowerShell-7-Skripte oder Cmdlets bevorzugen, wenn sie die Aufgabe loesen und `pwsh` verfuegbar ist. Fuer strukturierte lokale Automationen ist C# ueber `.NET` oder `mono` ein zulaessiger zweiter Weg, wenn Typisierung, Dateiformate oder Wiederverwendbarkeit davon profitieren. Erst wenn PowerShell oder C# nicht sinnvoll passen, die OS-nahe vorhandene Repo-Variante nutzen, auf macOS/Linux typischerweise Bash. Keine neue Sprache nur aus Bequemlichkeit einfuehren, wenn ein bestehendes Repo-Skript denselben Zweck erfuellt.

## Statistik-Pflege / Statistics Maintenance

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

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` is binding shared guidance across the workspace family.
- All user-facing artefacts must be reviewed for inclusive use: CLI output, documentation, HTML, UI, and generated templates.
- Treat WCAG 2.2 Level AA as the default accessibility baseline wherever the criteria apply.
- Keep text-first usability visible for keyboard-only use, screen readers, Braille displays, and text browsers.
- Review new or changed non-trivial logic for didactic inline-comment need: comments explain why, trade-off, boundary condition, historical deviation, or proof limit, not obvious code behavior.
- Shared guidance and learner-facing documentation follow DE first, EN second; for large normative documents, a synchronised `.EN.md` companion file is acceptable.
- Do not update only this file when a shared rule changes; keep `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md` aligned and document any intentional deviation in the same change.

## Selbstaktualisierende Skripte / Self-Updating Scripts

Bei Sync- oder Bootstrap-Skripten, die ihr eigenes Verzeichnis kopieren oder ersetzen, vor echten Läufen immer Syntaxcheck und Vorschau verwenden: `bash -n`, `--dry-run` und `-WhatIf`. Echte Läufe aus einer stabilen Repo-Kopie wie `~/home-baseline-source/scripts/` starten oder sicherstellen, dass das Skript dorthin delegiert.

*For sync or bootstrap scripts that copy or replace their own directory, always use syntax checks and previews before real runs: `bash -n`, `--dry-run`, and `-WhatIf`. Start real runs from a stable repository copy such as `~/home-baseline-source/scripts/`, or ensure the script delegates there.*

Bei erzeugten oder schnell angepassten PowerShell-Skripten Variablen in Strings vor angrenzender Interpunktion immer mit `${Name}` abgrenzen, z. B. `${Path}:`. So entstehen keine fehlerhaften Bereichsvariablen wie `$Path:`.

*In generated or quickly adapted PowerShell scripts, always delimit variables before adjacent punctuation with `${Name}`, for example `${Path}:`. This avoids invalid scoped-variable parsing such as `$Path:`.*

Bei Workspace-/Repo-Migrationen eine vorhandene oder remote neuere `README.md` nicht stillschweigend überschreiben. Wenn die Remote-README kanonisch ist oder ausdrücklich erhalten bleiben soll, vor dem Push `fetch`/Rebase ausführen und `README.md` aus `origin/main` bewahren oder wiederherstellen.

*During workspace/repository migrations, do not silently overwrite an existing or newer remote `README.md`. If the remote README is canonical or must be preserved, fetch/rebase before pushing and preserve or restore `README.md` from `origin/main`.*

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

- **`scripts/hooks/pre-push`** — runs on every `git push`; uses `gitleaks` for the commit ranges being pushed when available, then scans changed git-tracked files from those ranges (`.gitignore` respected) with the regex fallback; blocks push with exit 2 on HIGH findings.
- **`scripts/scan-agent-secrets.sh` / `.ps1`** — manual scanner; uses `gitleaks git --pre-commit` for the current git diff when available, then runs the existing regex checks; accepts `--fail-on-high` / `-FailOnHigh` for CI use; requires `rg` (ripgrep), while `gitleaks` is preferred but optional.
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
- Run `bash scripts/scan-agent-secrets.sh --fail-on-high .` before pushing any change that touches hook or scanner logic; this uses `gitleaks` for the current diff when available.
- The pre-push hook runs `gitleaks` on pushed commit ranges when available and then applies the regex fallback to changed tracked files for patterns like `ghp_*`, `sk-*`, `AKIA*`, `AIza*`, PEM private key headers, and secret-named files (`.env*`, `*secret*`, `*.key`, `*.pem`).

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
`CHANGELOG.md` documents versions v0.1.0–v0.4.0 following Keep a Changelog format.
Must be listed in `.gitignore` whitelist as `!CHANGELOG.md`.

### Ausrichtung von ASCII-Box-Drawing-Tabellen / ASCII Box-Drawing Table Alignment
All rows in a `text` code block table must have identical character width. A single trailing space before the closing `│` makes a row 1 char too long and breaks the visual frame.
Verify with: `$line.Length` (PowerShell) — all frame characters count as 1 char regardless of UTF-8 byte width.

### `specify init` — Spec-Kit-Verzeichnisaufbau / `specify init` — Spec-Kit Directory Setup
Never copy from `~/home-baseline-source/` manually. The correct command is:
Run `specify init --here --force --integration {agent}` once per agent for `agy`, `opencode`, `claude`, `copilot`, and `codex`.

### Spec-Kit-Updates repo-weit / Repository-Wide Spec-Kit Updates
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

### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` on GitHub means read-only, not hidden. Public archived repositories remain visible to signed-out visitors.
Archived repositories are read-only through the API; changing visibility requires:
`archived=false` → `private=true` → `archived=true`.

Public forks cannot simply be changed to private. Options are: keep them public archived, delete them, or recreate them as private mirror repositories. Keep deletion target lists explicit and narrow; `gh repo delete` may require `gh auth refresh -h github.com -s delete_repo`.

For activity-based housekeeping, use `pushedAt` instead of `updatedAt`, because metadata updates change `updatedAt`. Stars are account metadata and can be removed via `DELETE /user/starred/{owner}/{repo}`; verify afterwards with `user/starred`.

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


## Agentische Toolchain-Wartung / Agentic Toolchain Maintenance

- Wiederkehrende Toolchain-Wartungsrunden sind im README unter `Wiederkehrende agentische Toolchain-Wartung / Recurring Agentic Toolchain Maintenance` dokumentiert.
- Wenn ein bekannter KI-Agent in `~` oder `~/home-baseline-source` startet und keine strengere Read-only-Aufgabe im Vordergrund steht, fragt er einmal nach: nur pruefen, pruefen und fehlende Required-Tools installieren, vollstaendig inklusive GSDB-Preflight vorbereiten oder ueberspringen.
- macOS/Linux nutzen `scripts/maintain-agentic-brew-apps.sh` und `scripts/config/brew-apps-registry.json`; Windows nutzt `scripts/maintain-agentic-winget-apps.ps1` und `scripts/config/winget-apps-registry.json`; VS-Code-Extensions werden ueber `scripts/config/vscode-extensions-registry.json`, Required-CLI-Pruefungen ueber `scripts/config/required-cli-tools-registry.json`, npm-Agenten-CLIs ueber `scripts/config/npm-agent-cli-registry.json` gepflegt.
- PSScriptAnalyzer `1.25.0` ist ein Required-PowerShell-Modul aus `scripts/config/powershell-modules-registry.json`; alle getrackten repo-eigenen `.ps1`, `.psm1` und `.psd1` muessen den gemeinsamen Analyselauf bestehen. Nur die dort begruendet dokumentierten, von GitHub Spec Kit erzeugten Upstream-Pfade sind ausgenommen. / PSScriptAnalyzer `1.25.0` is a required module; every tracked, repository-owned PowerShell file must pass the shared analysis run. Only generated GitHub Spec Kit upstream paths documented there with a rationale are excluded.
- Level-0 unter `~/home-baseline-source` ist die kanonische Quelle fuer diese Wartungsdateien. Bestehende Level-1-/Level-2-Kopien mit `propagate-agentic-toolchain-maintenance.*` zuerst als Vorschau, danach schreibend und abschliessend mit `--check-only` / `-CheckOnly` synchronisieren; das Werkzeug commitet oder pusht nicht.
- Fuer komplette Wartungslaeufe `maintain-agentic-workspace.sh` auf macOS/Linux beziehungsweise `maintain-agentic-workspace.ps1` auf Windows verwenden. Ohne Optionen aktualisieren sie Level-0/1/2 und die Required-Toolchain; `--check-only` / `-CheckOnly` prueft, Vorschau zeigt Schreibschritte, und Drift-Reparatur bleibt mit `--repair-drift` / `-RepairDrift` ausdruecklich zustimmungspflichtig. Die Orchestratoren wechseln keine Branches und committen oder pushen keine Ziel-Repositories.
- VS Code ist der grafische Required-Editor fuer Auszubildende; Helix (`hx`) ist der Required-A11Y-/CLI-Editor. Fuer die sechs MSL-Pfade C#, Go, Java, Python, Rust und Swift sind die offiziellen minimalen VS-Code-Extensions required; Microsoft Container Tools ist zusaetzlich required fuer Podman-Workflows.
- Podman CLI und Compose-Unterstuetzung sowie die sechs MSL-CLI-Toolchains `.NET`, Go, Java/Javac, Python, Rust/Cargo und Swift sind Required; `syft` fuer SBOM-Nachweise und GitHub Spec Kit (`specify`) fuer SDD sind ebenfalls Required. `specify` wird bei Bedarf ueber `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git` installiert.
- Die Agenten-CLI-Oberflaechen `codex`, `claude` und `copilot` sind plattformuebergreifend Required und nutzen bei Bedarf die npm-Registry als Fallback. Google Antigravity ersetzt Gemini CLI; `agy` ist plattformuebergreifend Required: macOS nutzt Homebrew, Windows `Google.AntigravityCLI` per WinGet und Linux den pruefsummengeprueften offiziellen Installer.
- Standardlaeufe installieren nur `required`; `optional` dient als dokumentierter Komfort-/Projektkontext. `xquartz` bleibt bewusst aus der Brew-Registry ausgeschlossen.
- Fehlende Required-Programme aus `--compare-only` / `-CompareOnly` werden bei freigegebener Wartung installiert; optionale Tools nur nach ausdruecklicher Zustimmung.
- `gitleaks`, `syft`, `specify`, die MSL-CLI-Toolchains und die Required-Agenten-CLIs muessen nach Paketmanager-Wartung pruefbar sein.
- Zweitgeraete ueber `mac-test.sh`, `linux-test.sh` und `windows-test.ps1` vergleichen; bewusst installierte Top-Level-Tools danach in die passende Registry uebernehmen.

*Recurring toolchain maintenance rounds are documented in the README section `Wiederkehrende agentische Toolchain-Wartung / Recurring Agentic Toolchain Maintenance`. macOS/Linux use `scripts/maintain-agentic-brew-apps.sh` with `scripts/config/brew-apps-registry.json`; Windows uses `scripts/maintain-agentic-winget-apps.ps1` with `scripts/config/winget-apps-registry.json`; VS Code extensions are maintained through `scripts/config/vscode-extensions-registry.json`, required CLI checks through `scripts/config/required-cli-tools-registry.json`, and npm agent CLIs through `scripts/config/npm-agent-cli-registry.json`. VS Code is the required graphical editor for apprentices; Helix (`hx`) is the required A11Y/CLI editor. The official minimal VS Code extensions are required for the six MSL paths C#, Go, Java, Python, Rust, and Swift; Microsoft Container Tools is also required for Podman workflows. Podman CLI and Compose support plus the six MSL CLI toolchains `.NET`, Go, Java/Javac, Python, Rust/Cargo, and Swift are required; `syft` for SBOM evidence and GitHub Spec Kit (`specify`) for SDD are required as well. The `codex`, `claude`, and `copilot` agent CLI surfaces are required across platforms and use the npm registry as a fallback when needed. Google Antigravity replaces Gemini CLI; `agy` is required cross-platform: macOS uses Homebrew, Windows uses `Google.AntigravityCLI` through WinGet, and Linux uses the checksum-verified official installer. `specify` is installed through `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git` when missing. Default runs install only `required`; `optional` records convenience/project context. `xquartz` stays intentionally excluded from the Brew registry. `gitleaks`, `syft`, `specify`, the MSL CLI toolchains, and the required agent CLIs must be verifiable after package-manager maintenance; compare second machines through the platform test scripts and then update the matching registry for intentional top-level tools.*

*Level-0 under `~/home-baseline-source` is the canonical source for these maintenance files. Synchronize existing Level-1/Level-2 copies with `propagate-agentic-toolchain-maintenance.*`: preview first, apply second, and finish with `--check-only` / `-CheckOnly`. The tool performs no commits or pushes.*

*Use `maintain-agentic-workspace.sh` on macOS/Linux or `maintain-agentic-workspace.ps1` on Windows for complete maintenance. With no options they update Level-0/1/2 and the required toolchain; check-only reports state, preview shows mutating steps, and drift repair requires explicit `--repair-drift` / `-RepairDrift`. The orchestrators never switch branches or commit/push target repositories.*

*At startup in `~` or `~/home-baseline-source`, known AI agents ask once whether to check only, check and install missing required tools, prepare full maintenance including GSDB preflight, or skip. Missing required tools from compare mode may be installed after approval; optional tools require explicit approval.*


## Secure-Development-Hardening Intake / Secure Development Hardening Intake

- Level-2-Repositories SOLLEN die zentrale sichere-Entwicklung-Basis aus `docs/secure-development/` enthalten; MSL-Status ist ein Pruefpunkt, aber keine Voraussetzung fuer die RL-SE-/Checklist-Selbstpruefung.
- Dazu gehoeren Richtlinie, Checklisten, Sammelband, `docs/secure-development/mitgeltende-dokumente/` und die zentrale Verzahnungsdatei `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`.
- `docs/secure-development/baseline-manifest.json` ist die kanonische Dateiliste fuer Basis 3.1.0; die Einzelchecklisten sind Quelle und der Sammelband wird mit `build-secure-development-docs.*` erzeugt und geprueft.
- Projektnachweise liegen getrennt unter `docs/security/secure-development/<datum>-<scope>/`; Sicherheit beginnt ab dem ersten Ausbildungs- und Entwicklungsauftrag gemaess dem Lernpfad Lehrjahr 1 bis 3.
- Die mitgeltende `Leitlinie_Sichere-Entwicklungs-Sandbox.md` beschreibt das Sandbox-Referenzprofil fuer KI-Agenten, Spec Kit, MSL-basierte Level-2-Projekte und die oeffentlichkeitsfaehige `absdd-image-sandbox`.
- Neue Level-2-Projekte koennen diese Basis beim Bootstrap ueber `bootstrap-project.* --primary-language <Sprache>` / `-PrimaryLanguage <Sprache>` erhalten. Level-2-Repos werden standardmaessig unabhaengig vom MSL-Status als GSDB-pflichtig mit dem Acht-Preset-Profil in der lokalen Registry `~/.home-baseline/level2-repository-registry.json` registriert; begruendete Ausnahmen muessen explizit gesetzt werden. Bei Lern-Sprachrepos gilt die vorgesehene Sprache aus dem eindeutigen Repo-Suffix oder einem expliziten Sprachparameter bereits vor dem Runtime-Scaffold.
- Fuer GSDB-Zielmengen zuerst diese lokale Registry lesen; manuelle Repo-Listen sind nur ein bewusster Override. Bestehende Repos koennen mit `register-level2-repository.*` nachgetragen werden.
- Wiederkehrende Wartung prueft GSDB-Registry-Drift mit `register-level2-repository.* --scan-root` / `-ScanRoot` zuerst im Trockenlauf. Wartungsscans duerfen bekannte Sprach-, MSL-, GSDB- oder Preset-Metadaten nicht auf `unknown`, `false` oder `none` herabstufen; neu erkannte Level-2-Repositories werden nach Bestaetigung in der lokalen Registry gemerkt.
- Wiederkehrende Level-2-Wartungsrunden sind im README unter `Wiederkehrende Level-2-Wartungsrunde / Recurring Level-2 Maintenance Round` dokumentiert; dort die Reihenfolge fuer Toolchain-Pruefung, Klonen/Pullen, Registry, Spec-Kit/Governance, GSDB und Statistikabschluss verwenden.
- Bestehende Level-2-Projekte werden registry-basiert mit `prepare-rl-se-checklist-selbstpruefung.*` vor der Haertung und mit `prepare-secure-development-hardening.*` fuer den spaeteren Haertungs-Intake vorbereitet; zuerst `--dry-run` / `-WhatIf` nutzen.
- Die Vorbereitung erzeugt nur Intake- und Ordnungsartefakte: `docs/secure-development/`, `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`, `Lastenheft_Secure-Development-Hardening.md` und `Lastenheft_Abarbeitungsreihenfolge.md`.
- `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` verlangt getrennt Anwendbarkeit (`Applicable`, `N/A`, `Open`) und Umsetzung (`Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, `Not Assessed`) sowie Begruendung, Evidenzpfad, Owner, Follow-up, Re-Evaluation-Trigger und Restrisiko.
- Das Suchmuster fuer die automatische Reihenfolge ist strikt `Lastenheft*.md`; `Lastenheft_Abarbeitungsreihenfolge.md` wird selbst nicht als Arbeitspaket einsortiert.
- Vorhandene Reihenfolge-Dateien werden geschuetzt: nur der markierte generierte Abschnitt wird aktualisiert; manuelle Begruendungen bleiben erhalten.
- `check-gsdb-self-assessment.*` prueft die GSDB ohne Spec-Kit-Lauf als Self-Assessment/Preflight. `--check-only` / `-CheckOnly` bleibt rein lesend. Ein normaler Lauf schreibt `docs/security/gsdb-self-assessment.md`, erzeugt oder aktualisiert `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md` und nimmt dieses Lastenheft in `Lastenheft_Abarbeitungsreihenfolge.md` auf.
- Diese Vorbereitung startet keinen Spec-Kit-Lauf, erzeugt keinen Feature-Branch und befuellt ausser dem GSDB-Preflight-Bericht keine weiteren `docs/security/`-Nachweise. Die eigentlichen Haertungs- und Intensivpruefungslaeufe werden separat gestartet.
- Aktive Lastenhefte fuer spaetere Spec-Kit-Laeufe SOLLEN als Intake-Dateien eine klare Mindeststruktur enthalten: Zweck, Ausgangslage, Zielbild, Scope, Nicht-Ziele, Anforderungen, erwartete Artefakte, Akzeptanzkriterien und einen kopierbaren `/speckit-specify`-Prompt. Lastenhefte mit Feature-Branch-Suffix gelten als historisch und werden nicht erneut gestartet.

*Level-2 repositories SHOULD contain the central secure-development baseline from `docs/secure-development/`, including guideline, checklists, compendium, `docs/secure-development/mitgeltende-dokumente/`, and the related-documents alignment file `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`. MSL status is a checkpoint, not a prerequisite for GSDB scope. Level-2 repositories default to GSDB-required with the eight-preset profile; justified exceptions must be explicit. A learning-language repository's intended language is valid from its unambiguous suffix or an explicit parameter before a runtime scaffold exists. Maintenance scans must not downgrade known language, MSL, GSDB, or preset metadata to `unknown`, `false`, or `none`. Existing projects are prepared with `prepare-rl-se-checklist-selbstpruefung.*` before hardening and with `prepare-secure-development-hardening.*` for the later hardening intake; use `--dry-run` / `-WhatIf` first. Read the local registry before using manual target lists. Recurring level-2 maintenance rounds are documented in the README section `Wiederkehrende Level-2-Wartungsrunde / Recurring Level-2 Maintenance Round`; use that order for toolchain checks, clone/pull, registry, Spec Kit/governance, GSDB, and statistics closeout. `check-gsdb-self-assessment.*` performs a GSDB preflight without starting Spec Kit, can run read-only with `--check-only` / `-CheckOnly`, and in normal mode writes `docs/security/gsdb-self-assessment.md`, creates or updates `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md`, and updates `Lastenheft_Abarbeitungsreihenfolge.md`. The generated intake is for a later manually started Spec Kit run; the preflight itself does not create a feature branch or claim formal hardening.*

*Secure-development baseline 3.1.0 is controlled by `docs/secure-development/baseline-manifest.json`; individual checklists are canonical and the compendium is generated. Project evidence stays under `docs/security/secure-development/<date>-<scope>/`. Every item uses separate applicability and implementation axes. Security learning starts with the first training and development task. Registry-based baseline-only propagation does not modify Lastenhefte or start Spec Kit.*

*Recurring maintenance checks GSDB registry drift with `register-level2-repository.* --scan-root` / `-ScanRoot` first as a dry run. Newly detected level-2 repositories are remembered after confirmation without downgrading stronger existing metadata.*

## Spec-Kit-Modell-Routing / Spec Kit Model Routing

- Modellwahl ist operative Agenten-Routing-Guidance, keine Feature-Anforderung. Modellnamen nicht in `spec.md`, `plan.md`, `tasks.md` oder einzelne Feature-Specs schreiben; diese Artefakte muessen reproduzierbar bleiben, auch wenn Modellnamen wechseln oder ein anderer KI-Agent verwendet wird.
- Der jeweilige Agent soll diese Empfehlungen auf seine aktuell verfuegbaren Modelle abbilden; keine feste Anbieter- oder Modellbindung ableiten.
- Fuer Spec-Kit-Spezifikation, Klaerung, Planung, Tasks und Analyse (`/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-analyze`; je nach Agent auch `/speckit.specify` usw.) das staerkste verfuegbare Frontier-Reasoning-/Coding-Modell bevorzugen.
- Fuer vollstaendige, lang laufende `/speckit-implement`-Laeufe das staerkste verfuegbare Long-Running-Agent-Modell bevorzugen; das Frontier-Modell nutzen, wenn maximale Urteilsguete wichtiger ist als Laufzeitstabilitaet.
- Fuer fokussierte Reviews oder CI-Fixes ein coding-optimiertes Modell bevorzugen.
- Fuer triviale Bereinigung, Formatierung oder risikoarme mechanische Edits ist ein schnelles kleines Coding-Modell akzeptabel.

*Model choice is operational agent-routing guidance, not a feature requirement. Do not pin model names in `spec.md`, `plan.md`, `tasks.md`, or individual feature specs; those artifacts must stay reproducible even when model names change or another AI agent is used. Each agent should map these recommendations to its currently available models; do not derive a fixed vendor or model requirement. For Spec-Kit specification, clarification, planning, task generation, and analysis (`/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-analyze`; or `/speckit.specify` etc. depending on the agent surface), prefer the strongest available frontier reasoning/coding model. For complete long-running `/speckit-implement` runs, prefer the strongest available long-running agent model; use the frontier model when maximum judgment quality is more important than runtime stability. For focused review or CI fixes, prefer a coding-optimized model. For trivial cleanup, formatting, or low-risk mechanical edits, a fast small coding model is acceptable.*

## Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

- Standard-Preset-Set: `security-governance` v0.6.1 prio 10, `architecture-governance` v0.5.1 prio 20, `isaqb-architecture-governance` v0.2.1 prio 30, `a11y-governance` v0.4.1 prio 40, `cross-platform-governance` v0.2.1 prio 50, `agent-parity-governance` v0.4.0 prio 60, `autonomous-run-governance` v0.3.2 prio 70, `parallel-autonomous-run-governance` v0.2.3 prio 80.
- Optionale Intake-Presets: `intake-authoring-governance` v0.1.1 prio 64 und `intake-review-governance` v0.1.1 prio 65 bleiben ausserhalb der Standard-Achtermatrix. Die verwaltete Thorsten-Flotte waehlt beide ueber `intake-authoring-ten-governance-presets`; das bisherige Neunerprofil bleibt kompatibel verfuegbar. Neue registrierte Flotten-Repositories erben `defaultPresetProfile`. *Optional intake presets: Authoring v0.1.1 at priority 64 and Review v0.1.1 at priority 65 remain outside the standard eight. Thorsten's managed fleet selects both through the explicit ten-preset profile; the prior nine-preset profile remains available.*
- Intake Authoring erzeugt aus ausdruecklich benannten, geordneten UTF-8-Quellen genau einen Intake und ein hashgebundenes Receipt. Materielle Fragen werden einzeln und hoechstens fuenfmal pro Durchgang gestellt; offene Fragen erzeugen `NeedsClarification` mit `BLOCKED - DO NOT RUN`. Bestehende Ziele benoetigen ausdrueckliche Update-Autoritaet. Alt-Intakes ohne Receipt verwenden nur mit aktueller Autoritaet `LegacyAdoption` samt Git-Blob- oder Snapshot-Proof; ein Vorgaenger-Receipt darf nicht erfunden werden. `ReadyForReview` ist keine Review-Freigabe. Der naechste Schritt wird als `speckit.intake-review` gemeldet, aber nie automatisch gestartet. Ohne ausdrueckliche Remote-Autoritaet verwendet der erzeugte Autonomous-Prompt `LocalImplementation`. Lernreihen duerfen Intakes vorbereiten und paketieren, starten aber keinen Lernendenlauf ohne ausdruecklichen Auftrag. *Intake Authoring creates one intake and hash-bound receipt from explicitly named ordered UTF-8 sources. Legacy adoption requires current authority and Git-blob or bounded snapshot proof. It never starts review or execution, never infers overwrite or remote authority, and learner runs still require explicit authorization.*
- Intake Review akzeptiert bei aktiver Projekt- oder Kampagnenpolicy nur aktuelle `Ready`- oder menschlich akzeptierte `ReadyWithAcceptedRisks`-Ergebnisse; Critical/High, offene materielle Fragen, Hash-Drift oder fehlende Worker-Coverage blockieren. Review und Status sind read-only, Repair benoetigt ausdrueckliche Aenderungsautoritaet. Series-Reviews verwenden Schema 1.1, binden den normalisierten Request-Hash und pruefen exakte Zielreihenfolge, explizite Roots sowie einen azyklischen Graphen; nicht belegbare Vorgaengerbeziehungen fuehren zu `NeedsClarification`. *Series reviews use schema 1.1, bind the normalized request hash, and verify exact target order, explicit roots, and an acyclic graph; unprovable predecessor relations result in `NeedsClarification`.*
- `autonomous-run-governance` v0.3.2 prio 70 ist Teil der Standard-Achtermatrix. Ein vollständiger autonomer Lauf bleibt ausdrücklich delegationspflichtig; die Installation allein erteilt weder Ausführungsberechtigung noch Remote-, Merge-, Bypass- oder Provider-Rechte und `LocalImplementation` bleibt Default. Dokumentations-, Status-, Schema- oder Evidence-Änderungen gelten erst dann als testfrei, wenn keine ausführbaren Validatoren die geänderten Pfade, Marker, Schemas oder Zustandswerte konsumieren. Vor autorisierten Commits wird der exakt beabsichtigte Kandidat mit `git diff --cached --check` und Statusabgleich geprüft; fremde Änderungen bleiben unberührt. Vor einem Merge wird jeder Acceptance-Gate dem tatsächlich ausgeführten Workflow, Job, Runner beziehungsweise der Plattform und dem Befehl zugeordnet; grüne Namen oder ein Bypass ersetzen keinen technischen Nachweis. Bewusst pausierte Läufe werden als `PausedByUser` gespeichert und nur über `speckit.autonomous-resume` fortgesetzt; `speckit.autonomous-stop` wirkt kooperativ am nächsten sicheren Grenzpunkt, und ein gespeicherter Delivery-Modus ist keine aktuelle Berechtigung. Nach Preset- oder Governance-Drift werden neue zwingende Korrektheits-, Sicherheits-, Berechtigungs- und Evidenzregeln minimal mit akzeptierten Plan-, Task- und Checklist-Artefakten abgeglichen; reine Effizienzpräferenzen lösen keine rückwirkende Neugenerierung aus. Die lesbare Skill-Überschrift `Deliver` ist kein Run-State-Wert; für Remote-Closeout gelten ausschließlich `Publish`, `Review` oder `MergeAndSync`.
- `parallel-autonomous-run-governance` v0.2.3 prio 80 ist Teil der Standard-Achtermatrix. Die Installation startet keine Kampagne und erteilt keine zusaetzlichen Remote-, Merge-, Bypass-, Abbruch-, Secret- oder Provider-Rechte. Kampagnen bleiben ausdruecklich delegationspflichtig, verwenden getrennte Worktrees und maximal drei gleichzeitig aktive Worker. Schema 1.1 erlaubt ein `runnerProfile` je Worker mit Kampagnen-Fallback; Modell und Reasoning-Stufe sind optionale, nicht geheime Metadaten und werden ohne Deklaration nicht erraten. Konsolidierung verlangt exakten Head, aktuelle Review- und Check-Evidenz, ist nach Teilmerges fortsetzbar und setzt `Completed` erst nach Synchronisation, manifestdeklarierten idempotenten Post-Merge-Aktionen und Abschlussvalidierung.
- Reale Preset-8-Kampagnen setzen in jedem Worker-Repository ein installiertes und aktiviertes `autonomous-run-governance >=0.2.2` voraus. Preset 7 mit Prioritaet `70` liefert Lebenszyklus, Evidenz und Berechtigungsgrenzen; Preset 8 mit Prioritaet `80` koordiniert die Kampagne. Fehlt Preset 7, ist es deaktiviert oder zu alt, endet der Preflight vor dem Worker-Start. `requireAutonomousPreset: false` bleibt auf isolierte interne Fixtures begrenzt und ist kein Produktionsmodus. *Real Preset 8 campaigns require installed and enabled `autonomous-run-governance >=0.2.2` in every worker repository. Preset 7 at priority `70` supplies lifecycle, evidence, and authority boundaries; Preset 8 at priority `80` coordinates the campaign. Missing, disabled, or outdated Preset 7 fails preflight before worker start. `requireAutonomousPreset: false` remains limited to isolated internal fixtures and is not a production mode.*
- `a11y-governance` v0.4.1 ergänzt didaktische Inline-Code-Kommentar-Governance für neue oder geaenderte nicht-triviale Logik.
- `security-governance` v0.6.1 fuehrt `AI-SBOM` weiter als bedingt anwendbare Supply-Chain-Evidenz, ergänzt sprachspezifische Secure-Coding-Profile und ergänzt regulatorische Anwendbarkeit für NIS2, CRA, EU AI Act und DORA. Reine Entwicklungswerkzeug-Nutzung bleibt `N/A`; KI-Runtime-/Produktkomponenten benoetigen Evidenz nach G7/BSI AI-SBOM-Clustern; private Ausbildungsprojekte dokumentieren regulatorische Nichtanwendbarkeit mit kurzer Begründung.
- `architecture-governance` v0.5.1 ergänzt `BSI C3A` als bedingte Cloud-Autonomie-Evidenz und `BSI C5` als bedingte Cloud-Compliance-Assurance-Evidenz für Cloud-Service-Auswahl, Provider-Abhängigkeiten, Audit-/Nachweisstand, Shared Responsibility und Betriebsnachweise.
- Alle acht Presets enthalten ab diesem Release-Block audit-ready Spec-Kit-Run-Evidenz: `Applicable` / `N/A` / `Open`, Begründung, Evidenzpfad, Reviewer, Restrisiko und Follow-up muessen im aktuellen Spec-Kit-Lauf dokumentiert werden.
- Die ursprünglichen sechs Presets sind seit 2026-05-04 und `autonomous-run-governance` v0.2.2 ist seit 2026-07-17 im `github/spec-kit` Community-Katalog enthalten und liegen zusätzlich als veröffentlichte Repos unter `https://github.com/hindermath/spec-kit-preset-*`.
- `parallel-autonomous-run-governance` v0.2.3 ist eigenstaendig veroeffentlicht; v0.2.2 wurde mit `github/spec-kit#3591` fuer den Community-Katalog eingereicht.
- Registrierte Level-0-, Level-1- und Level-2-Repositories installieren bei vorhandener Spec-Kit-Integration standardmäßig alle acht Presets aus `scripts/config/spec-kit-governance-presets.json`, sofern keine begründete Ausnahme dokumentiert ist.
- Referenz-Rollout für alle acht Presets: `RiderProjects/TinyPl0`, `RiderProjects/TinyCalc`, `RiderProjects/TuiVision`, `RiderProjects/InventarWorkerService`.
- Installation erfolgt bevorzugt mit `install-spec-kit-governance-presets.*` aus der zentralen Matrix; die Skriptlogik enthaelt keine fest eingebauten Versionen. Bei neuen Preset-Releases zuerst die Matrix aktualisieren, dann bestehende Repos bewusst mit `--force` / `-Force` nachziehen.
- Flotten-Rollouts erfassen Level-0, Level-1 und Level-2 explizit. Eine reine Level-2-Registry beweist keine vollstaendige Abdeckung; jeder Zielstatus wird bis Installation, exakter Matrixvalidierung, Commit, Push und Remote-Synchronisation verfolgt.
- Vor dem Staging werden generierte Preset-/Agentenpfade mit dem gesamten Arbeitsbaum abgeglichen. Fremde Aenderungen bleiben unberuehrt; bei Konflikten wird ein sauberer Worktree statt eines erzwungenen Misch-Commits verwendet.
- Aktuelle normative Sechs-/Siebenerangaben werden auf die Achtermatrix migriert. Historische Statistik-, Changelog-, Feldnachweis- und Kompatibilitaetsangaben bleiben erhalten und werden durch einen dokumentierten Allowlist-Scan unterschieden.
- Provider-/Billing-Ablehnung, technischer Gate-Fehler und bestandener Gate sind getrennte Ergebnisse. Bypass oder gruene Sammelnamen ersetzen keinen exakten technischen Nachweis.
- `.specify/presets/` und generierte Agenten-/Command-Dateien committen, wenn Presets Projekt-Policy sind; `.specify/presets/.cache/` nie committen.
- Nach Installation oder Update prüfen: `specify preset list`, mindestens ein `specify preset info <id>`, bei Template-Fragen zusätzlich `specify preset resolve <template>`.
- Die lokale Arbeitskopie der veröffentlichten Preset-Repos liegt unter `~/SpecKitPresetProjects/`; kanonische Scaffolds in diesem Repo liegen unter `specs/spec-kit-presets/` und `specs/spec-kit-preset-repos/`.
- Verbesserungen an Presets zuerst im `home-baseline`-Scaffold einarbeiten, dann in die passenden Repos unter `~/SpecKitPresetProjects/` übertragen, committen, pushen und mit GitHub-ZIP-URL smoke-testen.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `scripts/templates/*` ebenfalls aktualisiert werden müssen.
- Bei jeder Preset-Version oder Prioritätsänderung zuerst `scripts/config/spec-kit-governance-presets.json` aktualisieren und danach README-Tabellen, Constitution, Agenten-Dateien, `scripts/templates/speckit-workflow-section.md` und Agenten-Templates gemeinsam prüfen.

*Fleet rollouts explicitly cover level 0, level 1, and level 2 and track each
target through installation, exact matrix validation, commit, push, and remote
synchronization. Separate generated paths from unrelated work before staging.
Migrate current normative six/seven references while preserving allowlisted
history and compatibility aliases. Provider refusal, technical gate failure,
and passing evidence are distinct; bypass is not technical proof.*
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Standard preset set: `security-governance` v0.6.1 prio 10, `architecture-governance` v0.5.1 prio 20, `isaqb-architecture-governance` v0.2.1 prio 30, `a11y-governance` v0.4.1 prio 40, `cross-platform-governance` v0.2.1 prio 50, `agent-parity-governance` v0.4.0 prio 60, `autonomous-run-governance` v0.3.2 prio 70, and `parallel-autonomous-run-governance` v0.2.3 prio 80. `a11y-governance` v0.4.1 adds didactic inline-code-comment governance for new or changed non-trivial logic. `architecture-governance` v0.5.1 adds conditional `BSI C3A` cloud-autonomy evidence and `BSI C5` cloud-compliance assurance evidence for cloud-service selection, provider dependencies, audit/assurance status, shared responsibility, and operational evidence. `security-governance` v0.6.1 keeps conditional `AI-SBOM` evidence, language-specific secure-coding profiles, and regulatory applicability screening for NIS2, CRA, EU AI Act, and DORA: development-tool-only AI usage is `N/A`, AI runtime/product components require G7/BSI AI-SBOM cluster evidence, and private training projects record regulatory `N/A` when no regulated scope exists. All eight presets now include audit-ready Spec-Kit run evidence: `Applicable` / `N/A` / `Open`, rationale, evidence path, reviewer, residual risk, and follow-up must be documented for the current Spec-Kit run. The original six presets have been in the `github/spec-kit` community catalog since 2026-05-04, and `autonomous-run-governance` v0.2.2 was verified there on 2026-07-17. All eight are also published under `https://github.com/hindermath/spec-kit-preset-*`. `parallel-autonomous-run-governance` v0.2.2 was submitted to the community catalog as `github/spec-kit#3591`. Registered level-0, level-1, and level-2 repositories with Spec Kit default to all eight presets from `scripts/config/spec-kit-governance-presets.json` unless a justified exception is documented. Use `install-spec-kit-governance-presets.*` so preset versions stay centralized in the matrix. Commit `.specify/presets/` and generated agent command updates when presets are project policy, but never commit `.specify/presets/.cache/`. Verify installs with `specify preset list`, `specify preset info`, and where relevant `specify preset resolve`. Improve presets in the home-baseline scaffold first, propagate to standalone preset repos, then commit, push, and smoke-test via GitHub ZIP URL. Preset-rule changes and preset version/priority changes require reviewing the central matrix, constitution, README tables/install snippets, all agent guidance files, and relevant templates together. Community/catalog coordination happens in `github/spec-kit#2362`.*

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
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf`, `~/.gitconfig.d/`, bootstrap-workspace, sync-home, check-homogeneity, pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab auto-detected), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`; `--` end-of-options für Workspace-Namen mit `-`-Präfix
- 006-gitlab-support: GitLab-CLI-Support für `bootstrap-workspace.*` und `bootstrap-project.*`, `--platform gitlab`, Self-hosted `--gitlab-url`, bilinguale Fehlerpfade
- 007-gitlab-release-automation: `setup-gitlab-release.*`, GitLab-Release-Templates und non-blocking manueller `release`-Job ergänzt; mit echten Releases in `sysinfotool` (`v0.1.0`) und `inventarworkerservice2` (`v0.0.1`) validiert; Detached-HEAD- und CHANGELOG-Refresh-Fixes eingearbeitet
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
