# Workspace Context: home-baseline (Root)

Dieses Repository ist die **oberste Ebene** der Workspace-Infrastruktur. Es dient als "Baseline" für die gesamte Entwicklungsumgebung und bietet Automatisierungswerkzeuge, um neue Projektverzeichnisse (Workspaces) standardisiert einzurichten.

## Überblick & Architektur / Project Overview & Architecture

Die "home-baseline" verfolgt einen **Multi-Repo-Ansatz**. Das Root-Verzeichnis selbst ist ein Git-Repository, das jedoch alle Unterverzeichnisse (die eigenen Git-Repositories enthalten) per `.gitignore` ignoriert.

- **Zweck:** Bereitstellung von Bootstrap-Skripten, Sicherheits-Hooks und globalen Konfigurationen.
- **Automatisierung:** Nutzung von Bash (macOS/Linux) und PowerShell Core (Windows) für plattformübergreifende Kompatibilität.
- **Sicherheit:** Integrierter Secret-Scan für KI-Agenten-Verzeichnisse (`.gemini`, `.claude`, `.vscode`, etc.).

## Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-tmp` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-tmp   # ← start Gemini CLI here
gemini
# → make changes, commit, push

# After push: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-tmp` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |

## Zentrale Abläufe & Befehle / Key Workflows & Commands

### Neuen Workspace einrichten / Create a New Workspace
Um ein neues Projektverzeichnis als standardisierten Workspace mit GitHub-Anbindung zu initialisieren:
```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Windows (PowerShell Core)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>
```
*Dieser Vorgang erstellt das Verzeichnis, initialisiert Git, kopiert die Baseline-Skripte, erstellt ein privates GitHub-Repo und installiert die Hooks.*

### Workspace entfernen / Remove a Workspace
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

### Sicherheit & Wartung / Security & Maintenance
- **Git-Hooks installieren (in jedem Workspace):**
  `bash scripts/install-hooks.sh`
- **Git-Identität prüfen und einrichten (einmalig nach Klonen):**
  `bash scripts/setup-git-identity.sh --check-only`  — prüfen / check
  `bash scripts/setup-git-identity.sh`               — einrichten / set
  `pwsh -NoProfile scripts/setup-git-identity.ps1 -CheckOnly`  — Windows prüfen
  `pwsh -NoProfile scripts/setup-git-identity.ps1`             — Windows einrichten
- **Manueller Secret-Scan:**
  `bash scripts/scan-agent-secrets.sh`
- **Lokales Agent-Audit fuer spaetere Herkunftsspur:**
  `bash scripts/audit-agent-changes.sh snapshot`
  `bash scripts/audit-agent-changes.sh report`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report`

Das Agent-Audit speichert eine lokale Baseline unter `~/.home-baseline/agent-audit/` und vergleicht spaetere Aenderungen in agentverwalteten Dateien gegen diese Baseline. Die Zuordnung zu Codex, Claude, Copilot oder Continue ist bewusst heuristisch und dient der lokalen Nachvollziehbarkeit, nicht als manipulationssicherer Beweis.

### Plattform-Test / Platform Test
Falls Terminal-Output nicht zwischen Maschinen copy-pastebaar ist, passende Test-Scripts verwenden:
```bash
bash ~/home-baseline-tmp/scripts/mac-test.sh     # macOS
bash ~/home-baseline-tmp/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1  # Windows
```
Ergebnisse landen als `mac-test-output.txt`, `linux-test-output.txt` bzw. `windows-test-output.txt` im Repo und können von jedem Gerät gelesen werden.

*Use the matching platform test script to collect results, commit and push them. Output files are in the repo and readable from any device.*

## OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

Zu Beginn jeder Session das Betriebssystem ermitteln und die passende Skript-Variante aufrufen:

| Betriebssystem | Shell | Endung | Erkennung |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Regel:** Auf Windows immer `pwsh scripts/xyz.ps1` aufrufen, auf macOS/Linux immer `bash scripts/xyz.sh`. Beide Varianten sind funktional äquivalent — nie mischen.

## Statistik-Pflege / Statistics Maintenance

- `docs/project-statistics.md` ist das lebende Statistik-Ledger dieses Repositories.
- Nach jedem abgeschlossenen Feature/Lastenheft, nach jeder abgeschlossenen Spec-Kit-Phase und auf explizite Anforderung aktualisieren.
- `## Fortschreibungsprotokoll` chronologisch halten: ältester Eintrag oben, neuester unten.
- `## Gesamtstatistik` bleibt immer der letzte Top-Level-Abschnitt.
- Direkt unter der Kennzahlen-Tabelle in `## Gesamtstatistik` kompakte ASCII-only-Diagramme pflegen: mindestens Artefaktmix, Phasenvolumen, konservative Referenz-Balken, Beschleunigungsfaktoren und Vergleich Erfahren/Thorsten-Solo/KI-sichtbar.
- Jedes ASCII-Diagramm bekommt eine kurze CEFR-B2-Erklärung in DE zuerst, EN danach.
- Textfreundlich bleiben: keine farbabhängigen Signale und keine Symbole, die auf Braille-Zeilen oder mit Screenreadern schlecht lesbar sind.
- Für dieses Repository gelten `80` Zeilen/Arbeitstag als konservative Referenz und `100` Zeilen/Arbeitstag als Thorsten-Solo-Basis für Scripting-Infrastruktur.
- Gemeinsame Default-Basis für C#/.NET-Repositories: `125` Zeilen/Arbeitstag, sofern das jeweilige Repo keinen abweichenden, begründeten Wert dokumentiert.
- TVöD-Basis: `7.8 h` pro Arbeitstag, `21.5` Arbeitstage pro Monat, 30 Urlaubstage bis Ende 2026 und 31 ab 2027.
- Änderungen an Statistikmethodik oder gemeinsamer Guidance immer gleichzeitig in `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` pflegen.

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` gilt repo-weit als verbindlicher Leitsatz.
- Alle nutzerseitigen Artefakte müssen barrierefrei gedacht und geprüft werden: CLI-Ausgaben, Dokumentation, HTML, UI und generierte Templates.
- WCAG 2.2 Level AA ist die praktische Standard-Basis, sobald die Kriterien auf das Artefakt anwendbar sind.
- Inhalte müssen in textorientierten Assistenz-Setups nutzbar bleiben, besonders mit Tastatur, Screenreadern, Braille-Zeilen und Textbrowsern.
- Gemeinsame Guidance und lernrelevante Doku folgen DE zuerst, EN danach; bei großen normativen Dokumenten ist eine synchron gepflegte `.EN.md`-Parallelfassung zulässig.
- Shared guidance nie nur hier ändern: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` werden gemeinsam gepflegt; Abweichungen müssen in derselben Änderung begründet werden.

## Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Gemini-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Gemini work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

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
  - **Supply-Chain-Evidenz / Supply Chain Evidence** (`supply-chain-evidence-template.md`) — SBOM, AI-SBOM, VEX, SLSA, OpenSSF Scorecard (Prinzip XVI, releasefähige Projekte MUST; AI-SBOM nur bei KI-Runtime-/Produktkomponenten)
  - **Zero-Trust-Anwendbarkeit / Zero Trust Applicability** (`zero-trust-applicability-template.md`) — NIST SP 800-207-Bewertung (Prinzip XVIII, verteilte Systeme SHOULD)
  - **SAMM-Bewertung / SAMM Assessment** (`samm-assessment-template.md`) — OWASP SAMM Reifegrad und Verbesserungsplan (Prinzip XVIII, langlebige Projekte SHOULD)
- Projektspezifische Instanzen werden in `docs/security/` gepflegt; S-ADRs als einzelne Dateien in `docs/security/adr/`.

*Every Level-2 project MUST maintain security documents based on templates in `.specify/templates/`: threat model (STRIDE+CAPEC), S-ADRs, arc42 Section 8 security concepts, security checklist, dependency audit, security quality scenarios (SHOULD), ASVS verification (web/API MUST), supply-chain evidence (release-capable MUST; AI-SBOM when AI runtime/product components apply), Zero Trust applicability note (distributed systems SHOULD), and SAMM assessment (long-lived projects SHOULD). Project-specific instances live in `docs/security/`; S-ADRs in `docs/security/adr/`. See `constitution.md`, Principles XII–XVIII for authoritative requirements.*

## Sicherheitsstandards & Anwendbarkeit / Security Standards & Applicability

- Vor jeder Level-2-Aufgabe die anwendbaren Sicherheitsstandards aus `constitution.md`, Prinzipien XIV-XVIII bestimmen und explizit benennen.
- `NIST SSDF` und `CWE Top 25` gelten immer für Level-2-Arbeit.
- `OWASP ASVS` gilt für Web-, API-, HTTP- und authentifizierte Dienste; der gewählte ASVS-Level muss benannt werden.
- `SBOM` gilt für releasefähige oder verteilbare Artefakte; `VEX`, wenn bekannte Schwachstellen in ausgelieferten oder geprüften Komponenten bewertet werden müssen.
- `AI-SBOM` gilt projektartabhängig bei KI-Modellen, KI-Diensten, Trainings-/Embedding-Daten, Inferenz-Infrastruktur oder KI-Runtime-Komponenten im ausgelieferten oder betriebenen System; reine Entwicklungswerkzeug-Nutzung wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `SLSA` gilt als Soll-Vorgabe für CI/CD- oder veröffentlichte Artefakte; `Zero Trust` ist für verteilte, servicebasierte, cloudnahe oder remote-verwaltete Systeme explizit zu prüfen.
- `CAPEC` soll in Bedrohungsmodellen für die risikoreichsten Angriffswege verwendet werden; `OWASP SAMM` soll für langlebige Projekte/Workspaces in Verbesserungspläne einfließen.
- `OWASP Cheat Sheet Series`, `OWASP Proactive Controls` und bei öffentlichen OSS-Repositories oder kritischen Abhängigkeiten `OpenSSF Scorecard` sind als ergänzende Referenzen zu berücksichtigen.
- Nichtanwendbarkeit immer als `N/A` mit kurzer Begründung dokumentieren; keine stillschweigende Auslassung.

*At the start of every Level-2 task, determine and name the applicable security standards from `constitution.md`, Principles XIV-XVIII. `NIST SSDF` and `CWE Top 25` always apply. `OWASP ASVS` applies to web/API/HTTP/auth-bearing services; `SBOM` applies to releasable or distributable artefacts; `AI-SBOM` applies when AI models, AI services, datasets, inference infrastructure, or AI runtime components are part of the released or operated system; `VEX` applies when known vulnerabilities in shipped/evaluated components need a disposition statement. `SLSA` is the target model for CI/CD and published artefacts; `Zero Trust` must be explicitly evaluated for distributed, service-based, cloud, or remotely managed systems. `CAPEC`, `OWASP SAMM`, `OWASP Cheat Sheet Series`, `OWASP Proactive Controls`, and `OpenSSF Scorecard` are supporting references where relevant. Record non-applicability as `N/A` with justification rather than omitting it silently.*

## Agentischer Security-Workflow / Agentic Security Workflow

- In `spec.md`, `plan.md` und `tasks.md` die anwendbaren Standards samt Evidenzpfad festhalten.
- Bei Bedrohungsmodellen `STRIDE` als Basis und bei risikoreichen Flows zusätzlich relevante `CAPEC`-Patterns verwenden.
- Bei Web/API-Features den `ASVS`-Level und den Verifikationsumfang in `docs/security/` oder gleichwertiger Projektdokumentation ablegen.
- KI-Nutzung explizit klassifizieren: Entwicklungswerkzeug, keine KI im ausgelieferten/betriebenen System, oder KI-Runtime-/Produktkomponente; `AI-SBOM` entsprechend als `N/A` begründen oder in der Supply-Chain-Evidenz dokumentieren.
- Bei Release-/Artefakt-Arbeit `SBOM`, `AI-SBOM`, `VEX`, Provenance/SLSA-Nachweise und gegebenenfalls `OpenSSF Scorecard` in Release- oder Sicherheitsdokumentation einplanen.
- Bei Architekturänderungen `Zero Trust`-Anwendbarkeit und bei langlebigen Projekten `SAMM`-Folgeaktionen prüfen.
- Default-Evidenzpfad: `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`; Abweichungen nur mit lokal dokumentierter Begründung.

*Capture the applicable standards and the evidence path in `spec.md`, `plan.md`, and `tasks.md`. Use `STRIDE` as the base for threat modeling and add relevant `CAPEC` patterns for the highest-risk flows. For web/API work, record the chosen `ASVS` level and verification scope in `docs/security/` or equivalent project documentation. Classify AI usage as development tooling, absent from the released/operated system, or AI runtime/product component; document `AI-SBOM` as `N/A` or as supply-chain evidence accordingly. For release and artefact work, plan `SBOM`, `AI-SBOM`, `VEX`, provenance/SLSA evidence, and `OpenSSF Scorecard` review where applicable. For architectural changes, evaluate `Zero Trust`; for long-lived projects, consider `OWASP SAMM` follow-up actions. The default evidence path is `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, and `docs/security/samm-assessment.md`, unless the repository documents a justified equivalent location.*

## Zentrale Verzeichnisse / Key Directories

- `~/scripts/`: Zentrale Automatisierungsskripte (Bootstrap, Secret-Scan, Hook-Installer).
- `~/`: Weitere Workspace-Verzeichnisse werden per `bootstrap-workspace` angelegt und hier eingetragen.
- `~/.gemini/`: Globale Gemini-Konfiguration und persistente Erinnerungen.

## Entwicklungskonventionen / Development Conventions

- **Plattformunabhängigkeit & Dokumentation:** Alle kritischen Skripte müssen sowohl als `.sh` (Bash) als auch als `.ps1` (PowerShell Core) vorliegen. Jedes Skript erfordert eine Unix man-Page (`.sh`, in `docs/man/`), eine vollständige PowerShell-Hilfe (`.ps1`) und muss zusätzlich als PowerShell Cmdlet (Advanced Function) im `Verb-Noun` Format verfügbar sein.
- **Sicherheits-Standard:** Jedes Projekt muss über einen `pre-push` Hook verfügen, der Secret-Scanning in Agenten-Verzeichnissen durchführt.
- **Git-Strategie:** Keine Submodules; stattdessen werden Sub-Repos durch die Baseline-Skripte in der `.gitignore` des übergeordneten Workspaces erfasst.

## Projektstatus / Repository Status

- **Sichtbarkeit:** Öffentliches **Template-Repo** — über „Use this template" nutzbar; kein Fork, keine History-Übertragung
- **Lizenz:** MIT
- **Branch-Schutz:** PR-Pflicht auf `main`; Admin (Eigentümer) kann direkt pushen (`enforce_admins: false`)
- **CI:** ✅ Ubuntu 22.04 · macOS 14 · Windows 2022
- **Compliance-Score:** 100 % (25/25 Checks)

## Bekannte Fallstricke / Known Pitfalls

### `gh auth login --web` bleibt hängen / `gh auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

### `glab auth login --web` bleibt hängen / `glab auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

### `gh`-Keyring ungültig (Windows) / `gh` Keyring Invalid (Windows)
Windows Credential Store korrupt.
`gh auth logout` + neu anmelden; danach `gh auth setup-git`.

### `ssh-agent` startet nicht (Windows) / `ssh-agent` Does Not Start (Windows)
Service deaktiviert, Admin nötig.
HTTPS + `gh auth setup-git` verwenden.

### `CursorPosition`-Fehler in PS-Subprocess / `CursorPosition` Error in PowerShell Subprocess
PowerShell-Profil (Oh-My-Posh) lädt im Subprozess.
`-NoProfile` zu `pwsh -File`-Aufrufen hinzufügen.

### `migrate-workspace.*` läuft parallel in Timeouts / `migrate-workspace.*` Times Out in Parallel
Jeder Migrationslauf startet `init-stats.*` und aktualisiert die Level-0/1/2-Statistiken global.
Mehrere parallele Läufe können sich gegenseitig ausbremsen. Erst Vorschau (`-WhatIf`/`--dry-run`),
dann echte Migrationen seriell pro Workspace mit längerem Timeout ausführen.

### `git pull` meldet divergierende Branches (Linux) / `git pull` Reports Divergent Branches (Linux)
Kein globales Rebase-Setup.
`git config --global pull.rebase true`.

### Push rejected: `fetch first` / Push Rejected: `fetch first`
Remote ist neuer als lokal.
`git pull --rebase --autostash && git push`.

### Test-Skript blockiert Pull / Test Script Blocks Pull
Output-Datei wird vor `pull` geschrieben.
`git pull --rebase --autostash origin main`.

### Lastenheft nach Feature-Abschluss nicht umbenannt / Lastenheft Not Renamed After Feature Completion
`tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben).
`bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` oder `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>`.

### Windows: `$env:HOME` ist leer, nicht `$null` / Windows: `$env:HOME` Is Empty, Not `$null`
```powershell
# Falsch (??-Operator fängt '' nicht ab):
$home = $env:HOME ?? $env:USERPROFILE
# Richtig:
$home = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }
```

### CI: Scanner-Verzeichnis / CI: Scanner Directory
```bash
# Falsch (CWD = Repo-Root, Dateien nicht gefunden):
bash scripts/check-homogeneity.sh home-baseline
# Richtig (aus dem Parent heraus):
cd "$(dirname "$GITHUB_WORKSPACE")"
bash "$(basename "$GITHUB_WORKSPACE")/scripts/check-homogeneity.sh" "$(basename "$GITHUB_WORKSPACE")"
```

### `.gitignore`-Whitelist / `.gitignore` Whitelist
Jede neue Datei muss explizit als `!DATEINAME` in `.gitignore` eingetragen werden, sonst wird `git add` lautlos ignoriert (z. B. `LICENSE`).

### `bootstrap-workspace`: GitHub-Username / `bootstrap-workspace`: GitHub Username
Früher hardcodiert. Jetzt dynamisch:
```bash
GH_USER=$(gh api user --jq '.login')
```

### Doppelte Überschriften in TOC / Duplicate heading anchors
Gleiche Heading-Texte → GitHub hängt `-1`, `-2` an. TOC-Links für zweite Vorkommen müssen den Suffix enthalten.

### Pflicht für bilinguale Headings / Bilingual Heading Requirement
Format: `## DE / EN` — immer. Nur-Deutsch verletzt WCAG 2.4.6 und bilinguales Konsistenzgebot.
Ausnahme: Eigennamen wie `### Homogeneity Guardian` oder `### Compliance-Check`.

### Code-Blöcke immer mit Sprach-Tag (WCAG 4.1.1) / Code Blocks Must Always Have a Language Tag (WCAG 4.1.1)
Bare ` ``` ` ohne Sprache ist ein A11Y-Fehler. Für ASCII/Dialog/Verzeichnisse: ` ```text `.

### CHANGELOG.md hinzugefügt / CHANGELOG.md Added
Dokumentiert Versionen v0.1.0–v0.3.0. Muss in `.gitignore`-Whitelist (`!CHANGELOG.md`) eingetragen sein.

### ASCII-Box-Drawing-Tabellen: Zeilenbreite / ASCII Box-Drawing Tables: Line Width
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen: PowerShell `$line.Length` oder `wc -m` (Bash) für jede Rahmen-Zeile.

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
Credentials und lokale Abhaengigkeiten bleiben ausgeschlossen.

Die Standard-Template-Quelle ist das oeffentliche `home-baseline`-Repo, aus dem
das Skript laeuft. Private Repos wie `RiderProjects/TuiVision` duerfen nur
bewusst mit `--template-source` / `-TemplateSource` als Override genutzt werden.

### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` bedeutet bei GitHub nur read-only, nicht unsichtbar. Public archived Repos bleiben ohne Anmeldung sichtbar.
Archivierte Repos sind API-seitig read-only; Sichtbarkeit ändern geht deshalb nur über:
`archived=false` → `private=true` → `archived=true`.

Öffentliche Forks lassen sich nicht einfach auf private setzen. Optionen: öffentlich archiviert lassen, löschen, oder als private Mirror-Repos neu anlegen. Vor Löschungen die Repo-Liste eng festlegen; `gh repo delete` benötigt ggf. `gh auth refresh -h github.com -s delete_repo`.

Für Aktivitätsbewertungen `pushedAt` statt `updatedAt` verwenden, weil `updatedAt` durch Metadatenänderungen springt. Stars sind kontogebundene Metadaten und können über `DELETE /user/starred/{owner}/{repo}` entfernt werden; danach `user/starred` gegenprüfen.

## Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

- Standard-Preset-Set: `security-governance` v0.3.0 prio 10, `architecture-governance` v0.2.0 prio 20, `isaqb-architecture-governance` v0.1.0 prio 30, `a11y-governance` v0.2.0 prio 40, `cross-platform-governance` v0.1.0 prio 50, `agent-parity-governance` v0.1.0 prio 60.
- `security-governance` v0.3.0 fuehrt `AI-SBOM` als bedingt anwendbare Supply-Chain-Evidenz ein: reine Entwicklungswerkzeug-Nutzung = `N/A`, KI-Runtime-/Produktkomponenten = Evidenz nach G7/BSI AI-SBOM-Clustern.
- Alle sechs Presets sind seit 2026-05-04 im `github/spec-kit` Community-Katalog enthalten und liegen zusätzlich als veröffentlichte Repos unter `https://github.com/hindermath/spec-kit-preset-*`.
- Neue Level-2-Projekte SOLLEN bei der Spec-Kit-Initialisierung die passende Preset-Teilmenge installieren; C#/.NET-Level-2-Projekte verwenden standardmäßig alle sechs Presets, sofern keine begründete Ausnahme dokumentiert ist.
- Referenz-Rollout für alle sechs Presets: `RiderProjects/TinyPl0`, `RiderProjects/TinyCalc`, `RiderProjects/TuiVision`, `RiderProjects/InventarWorkerService`.
- Installation bevorzugt über den Community-Katalog, wenn `specify` das unterstützt; für reproduzierbare Pins die versionierten GitHub-ZIP-URLs aus `constitution.md`/`README.md` verwenden.
- `.specify/presets/` und generierte Agenten-/Command-Dateien committen, wenn Presets Projekt-Policy sind; `.specify/presets/.cache/` nie committen.
- Nach Installation oder Update prüfen: `specify preset list`, mindestens ein `specify preset info <id>`, bei Template-Fragen zusätzlich `specify preset resolve <template>`.
- Die lokale Arbeitskopie der veröffentlichten Preset-Repos liegt unter `~/SpecKitPresetProjects/`; kanonische Scaffolds in diesem Repo liegen unter `specs/spec-kit-presets/` und `specs/spec-kit-preset-repos/`.
- Verbesserungen an Presets zuerst im `home-baseline`-Scaffold einarbeiten, dann in die passenden Repos unter `~/SpecKitPresetProjects/` übertragen, committen, pushen und mit GitHub-ZIP-URL smoke-testen.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `scripts/templates/*` ebenfalls aktualisiert werden müssen.
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Standard preset set: `security-governance` v0.3.0 prio 10, `architecture-governance` v0.2.0 prio 20, `isaqb-architecture-governance` v0.1.0 prio 30, `a11y-governance` v0.2.0 prio 40, `cross-platform-governance` v0.1.0 prio 50, and `agent-parity-governance` v0.1.0 prio 60. `security-governance` v0.3.0 adds conditional `AI-SBOM` evidence: development-tool-only AI usage is `N/A`, while AI runtime/product components require G7/BSI AI-SBOM cluster evidence. All six presets are in the `github/spec-kit` community catalog as of 2026-05-04 and are also published under `https://github.com/hindermath/spec-kit-preset-*`. New Level-2 projects should install the applicable subset; C#/.NET Level-2 projects default to all six unless a justified exception is documented. Commit `.specify/presets/` and generated agent command updates when presets are project policy, but never commit `.specify/presets/.cache/`. Verify installs with `specify preset list`, `specify preset info`, and where relevant `specify preset resolve`. Improve presets in the home-baseline scaffold first, propagate to standalone preset repos, then commit, push, and smoke-test via GitHub ZIP URL. Preset-rule changes require reviewing constitution, all agent guidance files, and relevant templates. Community/catalog coordination happens in `github/spec-kit#2362`.*

<!-- EN: GEMINI.md placeholder
[DE-Zusammenfassung: GEMINI.md enthält Anweisungen für den Gemini CLI Agenten im home-baseline Repository.]
-->

## Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (GitLab support), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf` in `~/.gitconfig`, `~/.gitconfig.d/` als workspace-spezifische Include-Fragmente; bootstrap-workspace, sync-home, check-homogeneity und pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: Added GitLab CLI support, self-hosted GitLab URL handling, and `glab auth login` pitfall guidance
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
