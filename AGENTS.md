# Repository Guidelines

## Einstieg / Getting started

DE: Home Baseline verwaltet die gemeinsame Workspace-Infrastruktur. Arbeite
in `~/home-baseline-source`. Die Kopie unter `~/` ist die Home Runtime.
Lies vor Änderungen die [Constitution](constitution.md), die lokalen
Projektregeln und unten die Vertiefung zur betroffenen Aufgabe.

EN: Home Baseline manages shared workspace infrastructure. Work in
`~/home-baseline-source`. The copy under `~/` is the Home Runtime. Before making
changes, read the [constitution](constitution.md), the project's local rules
and the reference for your task below.

## Arbeitsregeln / Working rules

- DE: Erkenne zuerst das Betriebssystem. Nutze `.sh` auf macOS/Linux und
  `.ps1` mit PowerShell 7 auf Windows. Lies die Hilfe und verwende vor
  schreibenden Läufen den passenden Prüfmodus. Prüfe selbstaktualisierende
  Skripte zusätzlich auf Syntax und starte sie aus der stabilen Quellkopie.
  EN: Detect the OS first. Use `.sh` on macOS/Linux and `.ps1` with PowerShell 7
  on Windows. Read help and preview writes. Syntax check self-updating scripts
  and run them from the stable source checkout.
- DE: Halte Änderungen eng am Auftrag. Verwende für GitHub und GitLab zuerst
  authentifiziertes `gh` bzw. `glab`. Trenne Commit, Push, Merge, Veröffentlichung,
  Installation, Home Sync und Flottenrollout nach der erteilten Autorität.
  EN: Keep changes within scope. Prefer authenticated `gh` or `glab`. Keep commit,
  push, merge, publication, installation, Home sync and rollout within their
  respective authority.
- DE: Prüfe vor einer autorisierten Lieferung Ziel, exakten Head und dessen
  Pflichtchecks. Technische Evidence ersetzt keine Freigabe für Produkt,
  Barrierefreiheit, Plattform oder Rollout.
  EN: Before authorized delivery, verify the target, exact head and its required
  checks. Technical evidence is separate from product, accessibility, platform
  and rollout approval.
- DE: `sync-home.*` verteilt nur `homeRuntime`. Prüfe zuerst mit
  `--check-only` / `-CheckOnly` und kläre Konflikte vor einem Force-Lauf.
  In ABS-DD bleibt schreibender Home Sync auf ausdrücklich angefordertes
  `--runtime-only` / `-RuntimeOnly` nach Manifest begrenzt.
  EN: `sync-home.*` distributes only `homeRuntime`. Run the check first and
  review conflicts before force. ABS-DD allows only an explicitly requested,
  manifest-bound runtime-only write.
- DE: Keine Tokens, `.env`-Dateien oder privaten Agentenzustände committen.
  Bei Hook-Änderungen Hooks neu installieren und den Secret-Scan prüfen.
  EN: Keep tokens, `.env` files and private agent state out of Git. Reinstall
  modified hooks and verify the secret scan.
- DE: Bei neuen Skripten den Skriptkatalog pflegen. Bash nutzt `set -euo pipefail`
  und eine Manpage. PowerShell nutzt Strict Mode, `Verb-Noun` und zweisprachige
  Hilfe. Prüfe die native Plattform zuerst und dokumentiere Nachweisgrenzen.
  EN: Register new scripts in the catalog. Bash uses `set -euo pipefail` and
  a man page. PowerShell uses strict mode, `Verb-Noun` and bilingual help.
  Verify on the native platform first and record evidence limits.

## Governance, Sicherheit und Barrierefreiheit / Governance, security and accessibility

- DE: Für Level 2 gelten die passende Registry-Zeile der Constitution,
  deren Regeln für speichersichere Sprachen und sichere Entwicklung sowie
  die anwendbaren Sicherheitsnachweise. Nenne Standards und begründe `N/A`.
  EN: Use the Level 2 environment registry row, the constitution's memory
  safety and secure development rules, and the applicable security evidence.
  Name applicable standards and justify `N/A`.
- DE: Agentenarbeit an Secure OrderDesk, Secure ServiceHarvester und Secure
  CaseTracker läuft ausschließlich in der freigegebenen Sandbox. Dieses Gate
  gilt ab Unit 00. Lies den [Sandbox-Preflight](docs/learning-units/Secure-Trader-Sandbox-Preflight.md).
  EN: Agent work on those Secure Trader systems requires the approved sandbox
  from Unit 00. Read the [sandbox preflight](docs/learning-units/Secure-Trader-Sandbox-Preflight.md).
- DE: Bereite neue Lernreihen im Level-0-Klon vor. Lernenden-Repositories
  verwenden persönliches `origin` und institutionelles `upstream`. Beginne
  Spec-Kit-Läufe für Lernende nur mit ausdrücklichem Auftrag.
  EN: Prepare learning series in the Level 0 clone. Learners use a personal
  `origin` and an institutional `upstream`. Start learner Spec Kit runs only
  with an explicit request.
- DE: Prüfe anwendbare WCAG 2.2 AA Kriterien, Tastaturbedienung und Nutzbarkeit
  mit textorientierten Hilfsmitteln. Dokumentiere fehlende Nachweise. Halte
  gemeinsame Regeln Deutsch zuerst und Englisch danach synchron.
  EN: Check applicable WCAG 2.2 AA criteria, keyboard use and compatibility
  with text-oriented assistive tools. Record gaps in evidence. Keep shared
  guidance in sync, German first and English second.
  Gemeinsame Änderungen betreffen `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md`.
  Dokumentiere beabsichtigte Abweichungen mit der Änderung.
  Shared changes cover all five files above. Document intentional differences
  with the change.
- DE: Erfasse pro Änderung genau eine Dokumentationsauswirkung und pflege das
  Statistik-Ledger bei Abschluss eines Features oder einer Spec-Kit-Phase.
  EN: Record exactly one documentation impact decision for each change and
  update the statistics ledger after a feature or Spec Kit phase closes.

## Vertiefung / References

DE: In einer Home-Runtime-Kopie öffnest du `docs/` im Level-0-Quellklon.
EN: From a Home Runtime copy, open `docs/` in the Level 0 source checkout.

- [Arbeitsabläufe und Regeln / Workflows and rules](docs/maintenance/agent-guidance-reference.md)
- [Agentenspezifische Hinweise / Harness notes](docs/maintenance/agent-guidance-harness-notes.md)
- [Skriptinventur / Script inventory](docs/scripts/)
- [Dokumentations-Governance / Documentation governance](docs/documentation-governance.md)
- [Statistik-Ledger / Statistics ledger](docs/project-statistics.md)
- [Betrieb und Wartung / Operations and maintenance](docs/maintenance/README.md)

DE: Die erforderlichen VS Code Erweiterungen umfassen `ms-vscode.powershell`
und `myriad-dreamin.tinymist`. Die vollständige Liste steht im
[Erweiterungsregister](scripts/config/vscode-extensions-registry.json).
EN: Required VS Code extensions include `ms-vscode.powershell` and
`myriad-dreamin.tinymist`. See the
[extension registry](scripts/config/vscode-extensions-registry.json) for the full list.

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
  - **Regulatorische Anwendbarkeit / Regulatory Applicability** (`regulatory-applicability-template.md`) — DS-GVO, NIS2, CRA, EU AI Act und DORA als Scope-/N/A-Prüfung mit ausdrücklicher Begründung für private Ausbildungsprojekte (Prinzip XIX, projektartabhängig)
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
- `NIS2`, `CRA`, `EU AI Act` und `DORA` werden als regulatorische Anwendbarkeitsmatrix geprüft; Beispielprodukt, Entwicklungswerkzeuge und Organisation getrennt pruefen; Ausbildung und AI-SBOM `N/A` sind keine allgemeine Ausnahme; unbekannter Scope bleibt `Open`.
- `CAPEC` soll in Bedrohungsmodellen für die risikoreichsten Angriffswege verwendet werden; `OWASP SAMM` soll für langlebige Projekte/Workspaces in Verbesserungspläne einfließen.
- `OWASP Cheat Sheet Series`, `OWASP Proactive Controls` und bei öffentlichen OSS-Repositories oder kritischen Abhängigkeiten `OpenSSF Scorecard` sind als ergänzende Referenzen zu berücksichtigen.
- Nichtanwendbarkeit immer als `N/A` mit kurzer Begründung dokumentieren; keine stillschweigende Auslassung.

*At the start of every Level-2 task, determine and name the applicable security standards from `constitution.md`, Principles XIV-XIX. `NIST SSDF` and `CWE Top 25` always apply. `OWASP ASVS` applies to web/API/HTTP/auth-bearing services; `SBOM` applies to releasable or distributable artefacts; `AI-SBOM` applies when AI models, AI services, datasets, inference infrastructure, or AI runtime components are part of the released or operated system; `VEX` applies when known vulnerabilities in shipped/evaluated components need a disposition statement. `SLSA` is the target model for CI/CD and published artefacts; `Zero Trust` must be explicitly evaluated for distributed, service-based, cloud, or remotely managed systems. `BSI C3A` applies when cloud services, SaaS/PaaS/IaaS, managed services, artifact hosting, or provider-dependent deployments are part of the released or operated system; development infrastructure alone is `N/A` with a toolchain rationale. `BSI C5` applies when cloud-service selection, cloud operation, managed services, artifact hosting, provider-dependent deployments, or cloud assurance reviews are in scope; development infrastructure alone is `N/A` with the same toolchain rationale. `NIS2`, `CRA`, `EU AI Act`, and `DORA` are screened through a regulatory applicability matrix; assess sample product, development tools and operating organisation separately; education and AI-SBOM `N/A` are not blanket regulatory exemptions; unknown scope remains `Open`. `CAPEC`, `OWASP SAMM`, `OWASP Cheat Sheet Series`, `OWASP Proactive Controls`, and `OpenSSF Scorecard` are supporting references where relevant. Record non-applicability as `N/A` with justification rather than omitting it silently.*

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

## Gemeinsame Workflow-Regeln / Shared workflow rules

DE: Beachte für die folgenden Workflows die jeweils benannten Voraussetzungen.
EN: Follow the stated prerequisites for each workflow below.

<!-- learner-a11y-baseline:start -->
## Hinweise zur Lernenden- und A11Y-Basis / Notes on the Learner and A11Y Baseline

- Verbindliche Zielgruppen ab dem ersten Ausbildungsjahr sind
  Fachinformatiker*innen, IT-System-Elektroniker*innen, Kaufleute für
  IT-System-Management und Kaufleute für Digitalisierungsmanagement.
- Lern-, Bedien-, Governance- und Spec-Kit-Inhalte stehen auf Deutsch zuerst
  und Englisch danach, verwenden ungefähr CEFR B2 und erklären Fachbegriffe
  beim ersten Auftreten.
- Spec-Kit-Erfahrung wird nicht vorausgesetzt. Befehle, Artefakte, Zustände und
  Übergänge werden beim ersten Gebrauch verständlich eingeführt.
- Abhängigkeiten, Zustände und Entscheidungen erhalten eine vollständige
  textorientierte Erklärung; eine ausschließlich visuelle Darstellung genügt
  nicht.
- `Programmierung #include<everyone>` und WCAG 2.2 Level AA gelten als
  verbindliche Prüfbasis, soweit die Kriterien auf das Artefakt anwendbar sind.

*The binding audience starts in the first training year and includes IT
specialist apprentices, IT systems electronics technician apprentices, and
both IT management occupations. Learner, usage, governance, and Spec Kit
content is German-first/English-second at about CEFR B2, explains technical
terms at first use, assumes no prior Spec Kit experience, and never relies on
visual-only dependency, state, or decision information. `Programmierung
#include<everyone>` and WCAG 2.2 Level AA are the review baseline wherever
applicable.*
<!-- learner-a11y-baseline:end -->

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->

<!-- BEGIN spec-kit-diagrams-completion -->
## Mermaid und Spec-Kit-Abschlussbericht / Mermaid and Spec Kit completion report

Neue Lastenhefte enthalten bei hilfreichen Abläufen, Zuständen oder Abhängigkeiten
lesbaren Mermaid-Quelltext im Markdown und eine gleichwertige Textalternative.
Bei einfachen Inhalten die Nichtanwendung kurz begründen. Diagramme bilden die
verbindlichen Text-/Manifestquellen ab; Farbe allein trägt keine Bedeutung.
Nach jedem vollständig abgeschlossenen Spec-Kit-Feature-Lauf den vollständigen
Ergebnisbericht im Chat anzeigen und im Feature-Verzeichnis als
`completion-report.md` versionieren. Einzelne Planungs-/Status-/Review-Kommandos
lösen keinen solchen Bericht aus; blockierte oder pausierte Läufe als
Zwischenbericht kennzeichnen. Vorlage: `.specify/templates/completion-report-template.md`;
Regel: `docs/spec-kit-diagrams-and-completion-reports.md`.
Ergebnis, Tests, Dokumentation, Git-gebundene Umfangszahlen, Verlauf und Restpunkte
belegen. Programmlogik von generierter Evidence, Git-Wandzeit von aktiver
Arbeitszeit und bestandene von ausgefallenen Prüfungen unterscheiden. Finale
Merge-/Sync-Evidence im Chat und bestehenden Closeout-Nachweis ergänzen; keine
zusätzlichen Commits allein für selbstreferenzielle Berichts-/Statistikwerte.
Diese Projektregel und lokale Vorlagen bei Spec-Kit-Updates erhalten.

*New intakes use readable Mermaid Markdown and equivalent text alternatives for
useful workflows, states or dependencies; justify omission for simple content.
Diagrams reflect authoritative text/manifests and never rely on color alone.
After each completed feature run, show the full outcome report in chat and
version completion-report.md in the feature directory using the shared template
and rule above. Individual planning/status/review commands do not trigger it;
paused/blocked runs receive interim reports. Evidence outcomes, tests, docs,
Git-bound counts, delivery history and remaining work. Distinguish code from
volume generated as evidence, elapsed from active time, and passed from failed
checks. Add final merge/sync proof in chat and existing closeout evidence, without
commits solely for self-referential counts or IDs. Preserve local rules/templates
across Spec Kit updates.*
<!-- END spec-kit-diagrams-completion -->

<!-- project-statistics-pilot:begin -->
## Optionaler Statistik-Pilot / Optional Statistics Pilot

Dieses Projekt verwendet im ausdruecklich freigegebenen Profil das Profil
`project-statistics-fourteen-governance-presets`: unveraenderte 13er-Basis plus
`project-statistics-governance` v0.1.4, aktiviert mit Prioritaet 90.
Das Preset dient reproduzierbarer Projekttransparenz, nicht der Bewertung von
Lernenden, Qualitaet oder KI-Zeitersparnis. Die bestehende Statistik bleibt
kanonisch. Der kuenftige getrennte Kontext ist `docs/project-statistics-pilot/`;
Referenz-Modellrechnungen bleiben ausgeschaltet. Installation startet weder
Messung noch Spec-Kit-Feature und erteilt keine Commit-/Push-/Mergefreigabe.
Integrationsnachweis: `docs/maintenance/project-statistics-installation-v010.md`
relativ zur Repository-Wurzel. Kein impliziter Home-Runtime-Sync und keine globale
Default-Aenderung. Operative Profilzuordnung erst nach gepruefter Lieferung.

This project's explicitly authorized profile opts into fourteen presets: the unchanged
thirteen-preset base plus Project Statistics Governance v0.1.2 at priority 90.
It provides reproducible project transparency, not learner ratings, quality
scores or AI time-savings measurements. Existing statistics remain canonical;
the future pilot context is separate and reference estimates remain off.
Installation starts no measurement or Spec Kit feature and grants no delivery
authority. See the integration record relative to the repository root.
No implicit Home Runtime sync or global default change; operational assignment follows
reviewed delivery.
<!-- project-statistics-pilot:end -->

<!-- BEGIN stable-msl-host-toolchains -->
## Stabile MSL-Host-Toolchains / Stable MSL host toolchains

DE: Die sechs Host-Toolchains C#/.NET, Go, Java/Javac, Python, Rust/Cargo und
Swift folgen den neuesten stabilen Hersteller-Releases einschliesslich neuer
Hauptversionen. CLI-Registry und Paketregister bestimmen Quellen und Zuordnung.
Paketstand, gestartete CLI und Herstellerstand werden getrennt geprueft.
`--msl-only` / `-MslOnly` begrenzt Wartung auf diese Toolchains und ihre
Abhaengigkeiten; zuerst Vergleich und Vorschau lesen. Paketquellen-Rueckstand,
PATH-Drift und unbekannte Aktualitaet bleiben Pflichtbefunde. Kein automatischer
Installer-Fallback. Swiftly verwaltet Swift-CLI auf macOS/Linux; Windows nutzt
WinGet. Apples Werkzeuge und Projekt-Pins bleiben eigenstaendige Vertraege.
Eine zentrale Skriptaenderung autorisiert keinen Lauf auf anderen Rechnern.
Details im Level-0-Klon: `docs/maintenance/msl-toolchains.md`.

EN: The six host toolchains follow the latest stable upstream releases,
including new major versions. CLI and package registries define sources and
mapping. Package, active CLI and upstream versions are checked separately.
Use `--msl-only` / `-MslOnly` for bounded maintenance after comparison and
preview. Package source lag, PATH drift and unknown currency remain required
findings; no automatic installer fallback. Swiftly manages Swift CLI on
macOS/Linux; Windows uses WinGet. Apple tools and project pins retain their
own contracts. Central script changes do not authorize runs on other hosts.
Read `docs/maintenance/msl-toolchains.md` in the Level-0 source clone.
<!-- END stable-msl-host-toolchains -->
