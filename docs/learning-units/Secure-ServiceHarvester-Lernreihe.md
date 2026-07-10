# Secure ServiceHarvester Lernreihe / Secure ServiceHarvester Learning Series

**Stand / Date:** 2026-07-06
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen in Ausbildung, Ausbilder*innen, Reviewer und KI-Agenten / IT specialist apprentices, trainers, reviewers, and AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

> **Start / Start:** Neue Lernende beginnen mit
> [`START-HERE-FUER-LERNENDE.md`](START-HERE-FUER-LERNENDE.md), bevor sie Unit 00
> oder einen KI-Agenten starten.

## Einordnung in die Familie / Placement in the Family

**DE:** Diese Datei beschreibt die **Basis-Reihe (1. Lehrjahr)** der Familie **Secure ServiceHarvester**. Die Familie begleitet die Ausbildung vom 1. bis zum 3. Lehrjahr: Basis (Jahr 1), [v2/Aufbau (Jahr 2)](Secure-ServiceHarvester-v2-Lernreihe.md) und [Professional Tracks (Jahr 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md). Das durchgehende Ziel ist, sicheres Entwickeln **und** das verantwortliche Arbeiten mit KI-Agenten und Spec-Driven Development (Spec Kit) einzuüben.

**EN:** This file describes the **base series (year 1)** of the **Secure ServiceHarvester** family. The family accompanies the apprenticeship from year 1 to year 3: base (year 1), [v2/advanced (year 2)](Secure-ServiceHarvester-v2-Lernreihe.md), and [Professional Tracks (year 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md). The continuous goal is to practice secure development **and** responsible work with AI agents and Spec-Driven Development (Spec Kit).

## Systemlandschaft / System Landscape

**DE:** Die fiktive Handelsfirma **Secure Trader** betreibt eine Bestell-/Handelsplattform auf Northwind-Datenbasis. Die didaktische Software-Schmiede **EuFPA** baut und betreut für Secure Trader drei ineinandergreifende, aber je **eigenständig nutzbare** Systeme:

- **Secure OrderDesk** — die Handels-/Bestellplattform selbst (Kunden, Produkte, Bestellungen; Northwind-Daten inkl. `ALFKI`).
- **Secure ServiceHarvester** — erfasst System-/Bestandsdaten der Arbeitsplatz-PCs und Server, auf denen die Systeme von Secure Trader laufen.
- **Secure CaseTracker** — Support-Plattform für Support-Cases von Kundinnen/Kunden (Angebot/Bestellung/Lieferung) und internen Mitarbeitenden.

Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit. Jede Lernreihe bleibt eigenständig bearbeitbar. Das gemeinsame Universums- und Datenmodell steht in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md).

**EN:** The fictional trading company **Secure Trader** runs an ordering/trading platform on a Northwind data base. The didactic software house **EuFPA** builds and maintains three interlocking, yet individually usable systems for Secure Trader: **Secure OrderDesk** (the trading platform itself), **Secure ServiceHarvester** (collects system/inventory data of the workstation PCs and servers that run Secure Trader’s systems), and **Secure CaseTracker** (support platform for support cases from customers and internal staff). The coupling is deliberately light: enriching context, not a hard dependency. Every series stays usable on its own. The shared world and data model is in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md).

## Zielbild / Target Picture

**DE:** Die Lernreihe führt Lernende schrittweise durch sichere Softwareentwicklung am Beispiel eines Hintergrund-/Worker-Dienstes. Das Beispielprogramm ist kein fertiges Produkt, sondern ein didaktisches Integrationsprojekt. Lernende üben, Anforderungen zu verstehen, sichere Entscheidungen zu treffen, Tests zu planen, Datenschutz zu beachten und ihre Entscheidungen so zu dokumentieren, dass andere sie prüfen können. Im 1. Lehrjahr bleibt der Dienst bewusst einfach; Hosting, Backend-Wechsel und API-Tiefe kommen erst in Jahr 2 und Jahr 3.

**EN:** The learning series guides learners step by step through secure software development using a background/worker service as the example. The example program is not a finished product but a didactic integration project. Learners practice understanding requirements, making secure decisions, planning tests, respecting privacy, and documenting decisions so others can review them. In year 1 the service stays deliberately simple; hosting, backend switching, and API depth come only in years 2 and 3.

## Projektidee / Project Idea

**DE:** EuFPA benötigt einen **Secure ServiceHarvester**. Der Dienst **sammelt** in regelmäßigen Abständen einfache Statusdaten verteilter Maschinen (zum Beispiel Name, Betriebssystem, letzter Kontakt), **legt** sie über eine austauschbare Ablage ab und **stellt** sie über eine kleine CLI oder API bereit. Die Lösung kann später als Dienst, CLI oder einfache lokale Anwendung umgesetzt werden. Wichtig ist, dass alle Zielsprachen dasselbe fachliche Verhalten abbilden. Als technische C#-Referenz dient das Projekt `InventarWorkerService`.

**EN:** EuFPA needs a **Secure ServiceHarvester**. The service periodically **collects** simple status data from distributed machines (for example name, operating system, last contact), **stores** it through a replaceable store, and **provides** it through a small CLI or API. The solution may later be implemented as a service, CLI, or simple local application. The important point is that all target languages implement the same functional behavior. The C# reference is the `InventarWorkerService` project.

## Gemeinsamer Kernvertrag / Shared Core Contract

**DE:** Jede spätere Implementierung muss mindestens diese Fähigkeiten bereitstellen:

- einen langlaufenden Sammel-Vorgang starten, stoppen und sauber beenden (Lebenszyklus, Graceful Shutdown).
- Statusdaten sammeln und sicher importieren; Importe gelten als nicht vertrauenswürdig.
- Daten über eine Ablage-Abstraktion speichern, die später austauschbar bleibt.
- Eingaben validieren und verständliche Fehlermeldungen ohne interne Details liefern.
- Rollen `learner`, `developer` und `reviewer` unterscheiden.
- Betriebs- und Audit-Log ohne Secrets und ohne unnötige personenbezogene Daten führen.
- Health/Status und einfache Kennzahlen berechnen: gesehene Maschinen, Alter des letzten Sammelns, Fehlerquote.
- Tests und Sicherheitsnachweise erzeugen.
- Sandbox-Nutzung, Spec-Kit-Artefakte und Richtlinienbezug dokumentieren.

**EN:** Each later implementation must provide at least these capabilities:

- Start, stop, and cleanly end a long-running collection run (lifecycle, graceful shutdown).
- Collect status data and import it safely; imports are treated as untrusted.
- Store data through a store abstraction that stays replaceable later.
- Validate input and provide understandable error messages without internal details.
- Distinguish the roles `learner`, `developer`, and `reviewer`.
- Keep an operations and audit log without secrets and without unnecessary personal data.
- Compute health/status and simple metrics: machines seen, age of last collection, error rate.
- Produce tests and security evidence.
- Document sandbox use, Spec Kit artifacts, and guideline relation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE – Anwendungsentwicklung | Domänenmodell, Eingabevalidierung, Berechtigungen, Persistenz, Tests und sichere Schnittstellen. |
| SI – Systemintegration | Sandbox, Laufzeit als Dienst, Konfiguration, Logging, Secrets, Supply Chain und Toolchain-Nachweise. |
| DPA – Daten- und Prozessanalyse | Datenschutz, Datenqualität, Kennzahlen, Betriebsauswertung und Grenzen der Aussagekraft. |
| DV – Digitale Vernetzung | Systemkontext, Maschinen- und Netzbezüge, Schnittstellen, Verfügbarkeit und Betriebsnachweise. |

**EN:** Application Development focuses on the domain model, validation, permissions, persistence, tests, and secure interfaces. System Integration focuses on sandboxing, service runtime, configuration, logging, secrets, supply chain, and toolchain evidence. Data and Process Analysis focuses on privacy, data quality, metrics, operational evaluation, and limits of interpretation. Digital Networking focuses on system context, machine and network relations, interfaces, availability, and operational evidence.

## Richtlinie Sichere Entwicklung / Secure Development Guideline

**DE:** Die Richtlinie Sichere Entwicklung ist der verbindliche Leitanker. Jede Lerneinheit verlangt sichtbare Bezüge zu Richtlinie, Checklisten, mitgeltenden Dokumenten und den sechs Spec-Kit-Governance-Presets. Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert; offene Punkte werden als `Open` mit Folgeaufgabe markiert.

**EN:** The Secure Development Guideline is the binding anchor. Each learning unit requires visible references to the guideline, checklists, related documents, and the six Spec Kit governance presets. Non-applicable points are documented as `N/A` with rationale; open points are marked as `Open` with follow-up work.

**DE:** Die Level-2-Sprachrepos führen diese Grundlage lokal unter `docs/secure-development/` mit: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und Preset-Verzahnung. Zusätzlich sind die sechs Governance-Presets aus der zentralen Matrix installiert und mit `specify preset list` nachweisbar. Dadurch können Lernende die in den Lastenheften genannten `CL_01` bis `CL_12` direkt bearbeiten und mit Spec-Kit-Artefakten verknüpfen.

**EN:** The level-2 language repositories carry this baseline locally under `docs/secure-development/`: guideline, 12 individual checklists, compendium, related documents, and preset alignment. The six governance presets from the central matrix are installed as well and can be evidenced with `specify preset list`. This lets learners work directly with `CL_01` through `CL_12` from the intake files and link them to Spec Kit artefacts.

## Sandbox-Einordnung / Sandbox Classification

**DE:** `absdd-image-sandbox` ist als öffentliches Referenz-Repository verfügbar: <https://github.com/hindermath/absdd-image-sandbox>. **Container-First-Gate:** Jeder KI-Agenten-Aufruf (z. B. Codex, Claude, Copilot, Gemini) erfolgt ab Unit 00 verbindlich im Container bzw. in der freigegebenen Sandbox — nie direkt auf dem Arbeitsplatz-Rechner der Auszubildenden. Diese Regel gilt, **bevor** der erste Agent gestartet wird. Verbindliche Grundlage ist [`Secure-Trader-Sandbox-Preflight.md`](Secure-Trader-Sandbox-Preflight.md). Lernende sollen zusätzlich verstehen, warum eine Sandbox KI-gestützte Entwicklung begrenzt, welche Daten nicht in Agentenläufe gehören und welche Nachweise später wichtig werden.

**EN:** `absdd-image-sandbox` is available as a public reference repository: <https://github.com/hindermath/absdd-image-sandbox>. **Container-first gate:** every AI-agent invocation (e.g. Codex, Claude, Copilot, Gemini) runs inside the container or approved sandbox from unit 00 onward — never directly on the apprentice's workstation. This rule applies **before** the first agent is started. The binding basis is [`Secure-Trader-Sandbox-Preflight.md`](Secure-Trader-Sandbox-Preflight.md). Learners should additionally understand why a sandbox limits AI-assisted development, which data must not enter agent runs, and which evidence will matter later.

**DE:** Die Grenze verläuft am Agenten-Aufruf: Lesen, Review und allgemeine Entwicklung **ohne Agenten** dürfen außerhalb der Sandbox erfolgen, zum Beispiel mit JetBrains IDEs, VS Code oder unter Windows mit Visual Studio. Sobald ein KI-Agent Dateien oder Befehle ausführt, geschieht das im Container. Was über die Jahre wächst, ist die Tiefe der eigenen Sandbox-Profilierung (Mounts, Egress, Nachweise), nicht die Frage, ob das Gate gilt.

**EN:** The boundary is the agent invocation: reading, review, and general development **without agents** may happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Visual Studio on Windows. As soon as an AI agent runs files or commands, it happens inside the container. What grows over the years is the depth of your own sandbox profiling (mounts, egress, evidence), not whether the gate applies.

## Empfohlene Repo-Struktur / Recommended Repository Structure

**DE:** Für die spätere praktische Bearbeitung ist die Reihe als Level-1-/Level-2-Struktur gedacht. `home-baseline-tmp` bleibt Level 0 und hält die generischen Materialien. Ein privates Level-1-Workspace-Repo `SecureServiceHarvesterProjects` koordiniert die Lernreihe. Darunter liegen sechs private Level-2-Repos, damit jede Sprache eigene Toolchain, Tests, Dependency-Audits, Spec-Kit-Artefakte und Sicherheitsnachweise erhält.

**EN:** For later practical work, the series is intended as a Level 1 / Level 2 structure. `home-baseline-tmp` remains Level 0 and keeps the generic material. A private Level 1 workspace repository `SecureServiceHarvesterProjects` coordinates the learning series. Six private Level 2 repositories sit below it so each language has its own toolchain, tests, dependency audits, Spec Kit artifacts, and security evidence.

| Rolle / Role | Lokaler Ordner / Local folder | Repository-Slug | Primärsprache / Primary language | Zweck / Purpose |
|---|---|---|---|---|
| Koordination / Coordination | `SecureServiceHarvesterProjects` | `secure-serviceharvester-baseline` | keine Implementierung / no implementation | Statusmatrix, Reihenfolge, Links und Vergleich der Sprachpfade |
| Referenz / Reference | `SecureServiceHarvester-CSharp` | `secureserviceharvester-csharp` | C# | erste manuelle Referenzimplementierung durch Lehrende |
| Vergleich / Comparison | `SecureServiceHarvester-Go` | `secureserviceharvester-go` | Go | MSL-Vergleich mit Go-Toolchain und Go-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureServiceHarvester-Java` | `secureserviceharvester-java` | Java | MSL-Vergleich mit Java-Toolchain und Java-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureServiceHarvester-Python` | `secureserviceharvester-python` | Python | MSL-Vergleich mit Python-Toolchain und Python-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureServiceHarvester-Rust` | `secureserviceharvester-rust` | Rust | MSL-Vergleich mit Rust-Toolchain und Rust-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureServiceHarvester-Swift` | `secureserviceharvester-swift` | Swift | MSL-Vergleich mit Swift-Toolchain und Apple-Plattform-Hinweisen |

**DE:** In jedem Level-2-Repo werden die gleichen fachlichen Intakes genutzt. Die fachlichen Regeln bleiben gleich; nur Umsetzung, Toolchain, Tests und sprachspezifische Sicherheitsprüfungen unterscheiden sich. Spec-Kit-Läufe werden nicht automatisch gestartet, sondern später manuell pro Repo und pro Aufgaben-Lastenheft.

**EN:** Each Level 2 repository uses the same functional intakes. The functional rules stay the same; only implementation, toolchain, tests, and language-specific security checks differ. Spec Kit runs are not started automatically but later run manually per repository and task intake.

## Technischer Startlauf 00 / Technical Scaffold Run 00

**DE:** Vor der ersten fachlichen Lerneinheit führt jedes Sprachrepo den technischen Startlauf `00` aus. Dieser Lauf erzeugt oder prüft nur das minimale Sprachprojekt, Build/Test-Befehle, Secure-Development-Basis und installierte Governance-Presets. Fachliche ServiceHarvester-Logik beginnt erst mit Aufgabe `01`.

**EN:** Before the first functional learning unit, each language repository runs the technical scaffold task `00`. This run only creates or verifies the minimal language project, build/test commands, the secure-development baseline, and installed governance presets. Functional ServiceHarvester logic starts with task `01`.

## Statusmatrix-Vorlage / Status Matrix Template

**DE:** Das spätere Level-1-Repo kann diese Matrix als Startpunkt verwenden:

**EN:** The later Level 1 repository can use this matrix as a starting point:

| Sprache / Language | Level-2-Repo | MSL | Intakes kopiert / Intakes copied | Spec-Kit-Stand / Spec Kit state | Reviewstatus / Review state | Rolle / Role |
|---|---|---|---|---|---|---|
| C# | `SecureServiceHarvester-CSharp` | ja / yes | offen / open | manuell offen / manually open | offen / open | Referenz / Reference |
| Go | `SecureServiceHarvester-Go` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Java | `SecureServiceHarvester-Java` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Python | `SecureServiceHarvester-Python` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Rust | `SecureServiceHarvester-Rust` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Swift | `SecureServiceHarvester-Swift` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |

## Reihenfolge der Lerneinheiten / Order of Learning Units

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 00 | Sprachrepo-Projekt-Scaffold | AE, SI, DPA, DV |
| 01 | Kundenauftrag, Scope und Dienstidee | AE, SI, DPA, DV |
| 02 | Domänenmodell: Maschinen, Snapshots und Zustände | AE |
| 03 | Eingabevalidierung und Trust Boundaries | AE |
| 04 | Datenschutz und Betriebs-/Audit-Logging | DPA |
| 05 | Rollen und Berechtigungen | AE |
| 06 | Persistenz, Import und Export | AE, DPA |
| 07 | Testbarkeit und Qualität | AE |
| 08 | Supply Chain und MSL-Bewertung | SI |
| 09 | Sandbox und agentische Entwicklung | SI, DV, Container-First-Gate ab Unit 00 verbindlich, hier vertieft |
| 10 | Betriebssicht und Kennzahlen | DPA, SI |
| 11 | Spec-Kit-Review und Abschluss | AE, SI, DPA, DV |
| 12 | Jahr-2-Baseline und Track-Ableitung | AE, SI, DPA, DV |

## Sprachspezifische Adapterhinweise / Language-Specific Adapter Notes

| Sprache | Sichere Umsetzungshinweise |
|---|---|
| C# | `IConfiguration`, sichere Serialisierung, parametrisierte Persistenz, `dotnet test`, Dependency-Audit; `BackgroundService`/`IHostedService` als Dienstmuster. |
| Go | `context`, HTTP-/I/O-Timeouts, `govulncheck`, sichere Pfade, klare Fehlerwerte; Goroutine mit sauberem Abbruch. |
| Java | Bean Validation, sichere Deserialisierung, JUnit, Maven-/Gradle-Audit, parametrisierte Persistenz; `ScheduledExecutorService` mit sauberem Shutdown. |
| Python | Pydantic oder explizite Validierung, keine unsichere Deserialisierung, `pip-audit`, sichere Dateipfade; sauberer Signal-/Loop-Abbruch. |
| Rust | Kein `unsafe` ohne Begründung, keine Panic-Pfade aus Eingaben, `cargo audit`, explizite Fehlerwerte; Task mit `CancellationToken`-Äquivalent. |
| Swift | Keine Force-Unwraps bei Eingaben, Keychain/CryptoKit/File-Scope, XCTest, klare Optional-Behandlung; strukturierte Nebenläufigkeit mit sauberem Abbruch. |

## Erwartete Unterrichtsergebnisse / Expected Teaching Results

**DE:** Nach Abschluss der Reihe sollen Lernende erklären können, warum MSL wichtig sind, warum MSL sichere Entwicklung nicht ersetzen, wie Spec Kit Anforderungen, Planung, Aufgaben und Reviews strukturiert, wie Datenschutz und Informationssicherheit zusammenhängen, wie ein langlaufender Dienst sicher startet und stoppt und wie eine Sandbox sichere KI-gestützte Entwicklung unterstützt.

**EN:** After completing the series, learners should be able to explain why MSL matter, why MSL do not replace secure development, how Spec Kit structures requirements, planning, tasks, and reviews, how privacy and information security relate, how a long-running service starts and stops safely, and how a sandbox supports secure AI-assisted development.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Das Master-Lastenheft beschreibt die Gesamtlandkarte und wird nicht als Sammellauf gestartet.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
