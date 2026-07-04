# Secure CaseTracker Lernreihe / Secure CaseTracker Learning Series

**Stand / Date:** 2026-07-03
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen in Ausbildung, Ausbilder*innen, Reviewer und KI-Agenten / IT specialist apprentices, trainers, reviewers, and AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** Die Lernreihe führt Lernende schrittweise durch sichere Softwareentwicklung. Das Beispielprogramm ist kein fertiges Produkt, sondern ein didaktisches Abschluss- und Integrationsprojekt. Lernende üben, Anforderungen zu verstehen, sichere Entscheidungen zu treffen, Tests zu planen, Datenschutz zu beachten und ihre Entscheidungen so zu dokumentieren, dass andere sie prüfen können.

**EN:** The learning series guides learners step by step through secure software development. The example program is not a finished product but a didactic final and integration project. Learners practice understanding requirements, making secure decisions, planning tests, respecting privacy, and documenting decisions so others can review them.

## Projektidee / Project Idea

**DE:** EuFPA benötigt einen **Secure CaseTracker**. Das System verwaltet Kundenanfragen, betroffene Assets, Bearbeitungsnotizen und einfache Prozesskennzahlen. Die Lösung kann später als CLI, kleine API oder einfache lokale Anwendung umgesetzt werden. Wichtig ist, dass alle Zielsprachen dasselbe fachliche Verhalten abbilden.

**EN:** EuFPA needs a **Secure CaseTracker**. The system manages customer requests, affected assets, work notes, and simple process metrics. The solution may later be implemented as a CLI, small API, or simple local application. The important point is that all target languages implement the same functional behavior.

## Gemeinsamer Kernvertrag / Shared Core Contract

**DE:** Jede spätere Implementierung muss mindestens diese Fähigkeiten bereitstellen:

- Fälle anlegen, ändern und schließen.
- Kundendaten datensparsam speichern.
- Eingaben validieren und verständliche Fehlermeldungen liefern.
- Rollen `learner`, `developer` und `reviewer` unterscheiden.
- Audit-Log ohne Secrets und ohne unnötige personenbezogene Daten führen.
- Daten sicher importieren und exportieren.
- einfache Kennzahlen berechnen: offene Fälle, geschlossene Fälle, Durchlaufzeit, Fehlerquote.
- Tests und Sicherheitsnachweise erzeugen.
- Sandbox-Nutzung, Spec-Kit-Artefakte und Richtlinienbezug dokumentieren.

**EN:** Each later implementation must provide at least these capabilities:

- Create, update, and close cases.
- Store customer data sparingly.
- Validate input and provide understandable error messages.
- Distinguish the roles `learner`, `developer`, and `reviewer`.
- Keep an audit log without secrets and without unnecessary personal data.
- Import and export data safely.
- Calculate simple metrics: open cases, closed cases, throughput time, error rate.
- Produce tests and security evidence.
- Document sandbox use, Spec Kit artifacts, and guideline relation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE – Anwendungsentwicklung | Domänenmodell, Eingabevalidierung, Berechtigungen, Persistenz, Tests und sichere APIs. |
| SI – Systemintegration | Sandbox, Laufzeit, Konfiguration, Logging, Secrets, Supply Chain und Toolchain-Nachweise. |
| DPA – Daten- und Prozessanalyse | Datenschutz, Datenqualität, Kennzahlen, Prozessauswertung und Grenzen der Aussagekraft. |
| DV – Digitale Vernetzung | Systemkontext, Schnittstellen, Kommunikationsflüsse, Segmentierung, Verfügbarkeit und Betriebsnachweise. |

**EN:** Application Development focuses on the domain model, validation, permissions, persistence, tests, and secure APIs. System Integration focuses on sandboxing, runtime, configuration, logging, secrets, supply chain, and toolchain evidence. Data and Process Analysis focuses on privacy, data quality, metrics, process evaluation, and limits of interpretation. Digital Networking focuses on system context, interfaces, communication flows, segmentation, availability, and operational evidence.

## Richtlinie Sichere Entwicklung / Secure Development Guideline

**DE:** Die Richtlinie Sichere Entwicklung ist der verbindliche Leitanker. Jede Lerneinheit verlangt sichtbare Bezüge zu Richtlinie, Checklisten, mitgeltenden Dokumenten und den sechs Spec-Kit-Governance-Presets. Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert; offene Punkte werden als `Open` mit Folgeaufgabe markiert.

**EN:** The Secure Development Guideline is the binding anchor. Each learning unit requires visible references to the guideline, checklists, related documents, and the six Spec Kit governance presets. Non-applicable points are documented as `N/A` with rationale; open points are marked as `Open` with follow-up work.

**DE:** Die Level-2-Sprachrepos führen diese Grundlage lokal unter `docs/secure-development/` mit: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und Preset-Verzahnung. Zusätzlich sind die sechs Governance-Presets aus der zentralen Matrix installiert und mit `specify preset list` nachweisbar. Dadurch können Lernende die in den Lastenheften genannten `CL_01` bis `CL_12` direkt bearbeiten und mit Spec-Kit-Artefakten verknüpfen.

**EN:** The level-2 language repositories carry this baseline locally under `docs/secure-development/`: guideline, 12 individual checklists, compendium, related documents, and preset alignment. The six governance presets from the central matrix are installed as well and can be evidenced with `specify preset list`. This lets learners work directly with `CL_01` through `CL_12` from the intake files and link them to Spec Kit artefacts.

**DE:** Vor einer spaeteren Haertung fuehren die Level-2-Sprachrepos einen eigenstaendigen RL-SE-/Checklist-Selbstpruefungs-Intake. Er erzeugt keine Umsetzung, sondern prueft Anwendbarkeit, Evidenz, `N/A`, offene Punkte, Owner, Follow-up und Re-Evaluation-Trigger gegen Richtlinie und CLs.

**EN:** Before later hardening, the level-2 language repositories carry a dedicated RL-SE/checklist self-assessment intake. It does not implement changes; it reviews applicability, evidence, `N/A`, open points, owner, follow-up, and re-evaluation triggers against the guideline and checklists.

## Sandbox-Einordnung / Sandbox Classification

**DE:** `absdd-image-sandbox` ist als öffentliches Referenz-Repository verfügbar: <https://github.com/hindermath/absdd-image-sandbox>. Im 1. Lehrjahr ist die Sandbox ein Lern- und Zielbild, aber keine Pflicht für jeden praktischen Arbeitsschritt. Lernende sollen verstehen, warum eine Sandbox KI-gestützte Entwicklung begrenzt, welche Daten nicht in Agentenläufe gehören und welche Nachweise später wichtig werden.

**EN:** `absdd-image-sandbox` is available as a public reference repository: <https://github.com/hindermath/absdd-image-sandbox>. In the first training year, the sandbox is a learning target and reference picture, but not mandatory for every practical work step. Learners should understand why a sandbox limits AI-assisted development, which data must not enter agent runs, and which evidence will matter later.

**DE:** Allgemeine Entwicklung, Lesen, Review und Bedienung der Werkzeuge können außerhalb der Sandbox erfolgen, zum Beispiel mit JetBrains IDEs, VS Code oder unter Windows mit Visual Studio. Die Sandbox wird dort genutzt oder geplant, wo KI-Agenten, reproduzierbare Toolchains, riskantere Experimente oder klare Schreib- und Netzwerkgrenzen wichtig sind.

**EN:** General development, reading, review, and tool operation may happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Visual Studio on Windows. The sandbox is used or planned where AI agents, reproducible toolchains, higher-risk experiments, or clear write and network boundaries matter.

## Empfohlene Repo-Struktur / Recommended Repository Structure

**DE:** Für die spätere praktische Bearbeitung ist die Reihe als Level-1-/Level-2-Struktur gedacht. `home-baseline-tmp` bleibt Level 0 und hält die generischen Materialien. Ein privates Level-1-Workspace-Repo `SecureCaseTrackerProjects` koordiniert die Lernreihe. Darunter liegen sechs private Level-2-Repos, damit jede Sprache eigene Toolchain, Tests, Dependency-Audits, Spec-Kit-Artefakte und Sicherheitsnachweise erhält.

**EN:** For later practical work, the series is intended as a Level 1 / Level 2 structure. `home-baseline-tmp` remains Level 0 and keeps the generic material. A private Level 1 workspace repository `SecureCaseTrackerProjects` coordinates the learning series. Six private Level 2 repositories sit below it so each language has its own toolchain, tests, dependency audits, Spec Kit artifacts, and security evidence.

| Rolle / Role | Lokaler Ordner / Local folder | GitHub-Slug | Primärsprache / Primary language | Zweck / Purpose |
|---|---|---|---|---|
| Koordination / Coordination | `SecureCaseTrackerProjects` | `secure-casetracker-baseline` | keine Implementierung / no implementation | Statusmatrix, Reihenfolge, Links und Vergleich der Sprachpfade |
| Referenz / Reference | `SecureCaseTracker-CSharp` | `securecasetracker-csharp` | C# | erste manuelle Referenzimplementierung durch Lehrende |
| Vergleich / Comparison | `SecureCaseTracker-Go` | `securecasetracker-go` | Go | MSL-Vergleich mit Go-Toolchain und Go-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureCaseTracker-Java` | `securecasetracker-java` | Java | MSL-Vergleich mit Java-Toolchain und Java-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureCaseTracker-Python` | `securecasetracker-python` | Python | MSL-Vergleich mit Python-Toolchain und Python-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureCaseTracker-Rust` | `securecasetracker-rust` | Rust | MSL-Vergleich mit Rust-Toolchain und Rust-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureCaseTracker-Swift` | `securecasetracker-swift` | Swift | MSL-Vergleich mit Swift-Toolchain und Apple-Plattform-Hinweisen |

**DE:** In jedem Level-2-Repo werden die gleichen fachlichen Intakes genutzt. Die fachlichen Regeln bleiben gleich; nur Umsetzung, Toolchain, Tests und sprachspezifische Sicherheitsprüfungen unterscheiden sich. Spec-Kit-Läufe werden nicht automatisch gestartet, sondern später manuell pro Repo und pro Aufgaben-Lastenheft.

**EN:** Each Level 2 repository uses the same functional intakes. The functional rules stay the same; only implementation, toolchain, tests, and language-specific security checks differ. Spec Kit runs are not started automatically but later run manually per repository and task intake.

## Technischer Startlauf 00 / Technical Scaffold Run 00

**DE:** Vor der ersten fachlichen Lerneinheit führt jedes Sprachrepo den technischen Startlauf `00` aus. Dieser Lauf erzeugt oder prüft nur das minimale Sprachprojekt, Build/Test-Befehle, Secure-Development-Basis und installierte Governance-Presets. Fachliche CaseTracker-Logik beginnt erst mit Aufgabe `01`.

**EN:** Before the first functional learning unit, each language repository runs the technical scaffold task `00`. This run only creates or verifies the minimal language project, build/test commands, the secure-development baseline, and installed governance presets. Functional CaseTracker logic starts with task `01`.

## Statusmatrix-Vorlage / Status Matrix Template

**DE:** Das spätere Level-1-Repo kann diese Matrix als Startpunkt verwenden:

**EN:** The later Level 1 repository can use this matrix as a starting point:

| Sprache / Language | Level-2-Repo | MSL | Intakes kopiert / Intakes copied | Spec-Kit-Stand / Spec Kit state | Reviewstatus / Review state | Rolle / Role |
|---|---|---|---|---|---|---|
| C# | `SecureCaseTracker-CSharp` | ja / yes | offen / open | manuell offen / manually open | offen / open | Referenz / Reference |
| Go | `SecureCaseTracker-Go` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Java | `SecureCaseTracker-Java` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Python | `SecureCaseTracker-Python` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Rust | `SecureCaseTracker-Rust` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Swift | `SecureCaseTracker-Swift` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |

## Reihenfolge der Lerneinheiten / Order of Learning Units

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 00 | Sprachrepo-Projekt-Scaffold | AE, SI, DPA, DV |
| 01 | Kundenauftrag und Scope | AE |
| 02 | Domänenmodell und Zustände | AE |
| 03 | Eingabevalidierung und Trust Boundaries | AE |
| 04 | Datenschutz und Audit-Logging | DPA |
| 05 | Rollen und Berechtigungen | AE |
| 06 | Persistenz, Import und Export | AE, DPA |
| 07 | Testbarkeit und Qualität | AE |
| 08 | Supply Chain und MSL-Bewertung | SI |
| 09 | Sandbox und agentische Entwicklung | SI, DV, im 1. Lehrjahr vorbereitend |
| 10 | Prozessanalyse und Kennzahlen | DPA |
| 11 | Spec-Kit-Review und Abschluss | AE, SI, DPA, DV |
| 12 | Jahr-2-Baseline und Track-Ableitung | AE, SI, DPA, DV |

## Sprachspezifische Adapterhinweise / Language-Specific Adapter Notes

| Sprache | Sichere Umsetzungshinweise |
|---|---|
| C# | `IConfiguration`, sichere Serialisierung, parametrisierte Persistenz, `dotnet test`, Dependency-Audit. |
| Go | `context`, HTTP-/I/O-Timeouts, `govulncheck`, sichere Pfade, klare Fehlerwerte. |
| Java | Bean Validation, sichere Deserialisierung, JUnit, Maven-/Gradle-Audit, parametrisierte Persistenz. |
| Python | Pydantic oder explizite Validierung, keine unsichere Deserialisierung, `pip-audit`, sichere Dateipfade. |
| Rust | Kein `unsafe` ohne Begründung, keine Panic-Pfade aus Eingaben, `cargo audit`, explizite Fehlerwerte. |
| Swift | Keine Force-Unwraps bei Eingaben, Keychain/CryptoKit/File-Scope, XCTest, klare Optional-Behandlung. |

## Erwartete Unterrichtsergebnisse / Expected Teaching Results

**DE:** Nach Abschluss der Reihe sollen Lernende erklären können, warum MSL wichtig sind, warum MSL sichere Entwicklung nicht ersetzen, wie Spec Kit Anforderungen, Planung, Aufgaben und Reviews strukturiert, wie Datenschutz und Informationssicherheit zusammenhängen und wie eine Sandbox sichere KI-gestützte Entwicklung unterstützt.

**EN:** After completing the series, learners should be able to explain why MSL matter, why MSL do not replace secure development, how Spec Kit structures requirements, planning, tasks, and reviews, how privacy and information security relate, and how a sandbox supports secure AI-assisted development.
