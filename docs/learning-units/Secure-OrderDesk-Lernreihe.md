# Secure OrderDesk Lernreihe / Secure OrderDesk Learning Series

**Stand / Date:** 2026-07-07
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Fiktive Kundenfirma / Fictional client company:** Secure Trader
**Zielgruppe / Audience:** Fachinformatiker*innen in Ausbildung, Ausbilder*innen, Reviewer und KI-Agenten / IT specialist apprentices, trainers, reviewers, and AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Einordnung in die Familie / Placement in the Family

**DE:** Diese Datei beschreibt die **Basis-Reihe (1. Lehrjahr)** der Familie **Secure OrderDesk**. Die Familie begleitet die Ausbildung vom 1. bis zum 3. Lehrjahr: Basis (Jahr 1), [v2/Aufbau (Jahr 2)](Secure-OrderDesk-v2-Lernreihe.md) und [Professional Tracks (Jahr 3)](Secure-OrderDesk-Professional-Tracks-Lernreihe.md). Das durchgehende Ziel ist, sicheres Entwickeln **und** das verantwortliche Arbeiten mit KI-Agenten und Spec-Driven Development (Spec Kit) einzuüben. Der fachliche Schwerpunkt liegt auf relationaler Persistenz, SQL-Sicherheit und Auswertungen.

**EN:** This file describes the **base series (year 1)** of the **Secure OrderDesk** family. The family accompanies the apprenticeship from year 1 to year 3: base (year 1), [v2/advanced (year 2)](Secure-OrderDesk-v2-Lernreihe.md), and [Professional Tracks (year 3)](Secure-OrderDesk-Professional-Tracks-Lernreihe.md). The continuous goal is to practice secure development **and** responsible work with AI agents and Spec-Driven Development (Spec Kit). The functional focus is relational persistence, SQL security, and reporting.

## Systemlandschaft / System Landscape

**DE:** Die fiktive Handelsfirma **Secure Trader** betreibt eine Bestell-/Handelsplattform auf Northwind-Datenbasis. Die didaktische Software-Schmiede **EuFPA** baut und betreut für Secure Trader drei ineinandergreifende, aber je **eigenständig nutzbare** Systeme:

- **Secure OrderDesk** — die Handels-/Bestellplattform selbst (Kunden, Produkte, Bestellungen; Northwind-Daten inkl. `ALFKI`).
- **Secure ServiceHarvester** — erfasst System-/Bestandsdaten der Arbeitsplatz-PCs und Server, auf denen die Systeme von Secure Trader laufen.
- **Secure CaseTracker** — Support-Plattform für Support-Cases von Kundinnen/Kunden (Angebot/Bestellung/Lieferung) und internen Mitarbeitenden.

Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit. Jede Lernreihe bleibt eigenständig bearbeitbar. Das gemeinsame Universums- und Datenmodell steht in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md).

**EN:** The fictional trading company **Secure Trader** runs an ordering/trading platform on a Northwind data base. The didactic software house **EuFPA** builds and maintains three interlocking, yet individually usable systems for Secure Trader: **Secure OrderDesk** (the trading platform itself; customers, products, orders; Northwind data incl. `ALFKI`), **Secure ServiceHarvester** (collects system/inventory data of the workstation PCs and servers that run Secure Trader’s systems), and **Secure CaseTracker** (support platform for support cases from customers and internal staff). The coupling is deliberately light: enriching context, not a hard dependency. Every series stays usable on its own. The shared world and data model is in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md).

## Zielbild / Target Picture

**DE:** Die Lernreihe führt Lernende schrittweise durch sichere Softwareentwicklung am Beispiel einer relationalen Bestell-/Handelsplattform. Das Beispielprogramm ist kein fertiges Produkt, sondern ein didaktisches Integrationsprojekt. Lernende üben, Anforderungen zu verstehen, sichere Entscheidungen zu treffen, Tests zu planen, Datenschutz zu beachten, SQL sicher zu nutzen und ihre Entscheidungen so zu dokumentieren, dass andere sie prüfen können. Im 1. Lehrjahr bleibt die Plattform bewusst einfach; Architektur, Service-Verträge und API-Tiefe kommen erst in Jahr 2 und Jahr 3.

**EN:** The learning series guides learners step by step through secure software development using a relational ordering/trading platform as the example. The example program is not a finished product but a didactic integration project. Learners practice understanding requirements, making secure decisions, planning tests, respecting privacy, using SQL safely, and documenting decisions so others can review them. In year 1 the platform stays deliberately simple; architecture, service contracts, and API depth come only in years 2 and 3.

## Projektidee / Project Idea

**DE:** Die Handelsfirma Secure Trader benötigt eine **Secure OrderDesk**-Plattform. Sie **verwaltet** Kunden, Produkte und Bestellungen, **speichert** sie über eine austauschbare, relationale Ablage und **stellt** einfache Auswertungen bereit. Die verbindliche Datenbasis ist die klassische Northwind-Sample-Datenbank (Layout und Daten) inklusive des Pflicht-Datensatzes `ALFKI`. Die Lösung kann später als CLI, API oder einfache Anwendung umgesetzt werden. Wichtig ist, dass alle Zielsprachen dasselbe fachliche Verhalten und dasselbe Datenmodell abbilden.

**EN:** The trading company Secure Trader needs a **Secure OrderDesk** platform. It **manages** customers, products, and orders, **stores** them through a replaceable relational store, and **provides** simple reports. The binding data base is the classic Northwind sample database (layout and data) including the mandatory record `ALFKI`. The solution may later be implemented as a CLI, API, or simple application. The important point is that all target languages implement the same functional behavior and the same data model.

## Datensatzquelle / Dataset Source

**DE:** Verbindliche Datenquelle ist die klassische **Northwind-Traders-Sample-Datenbank mit Layout und Daten**, inklusive Pflicht-Datensatz `ALFKI`. Die Original-Bestelldaten (~1996–1998) werden bis Juli 2026 mit plausiblen fiktiven Datensätzen erweitert (pro Monat 1–2 neue Kund*innen und 8–16 Bestellungen, verteilt über alten und neuen Kundenstamm). Details und Regeln stehen in [`Secure-OrderDesk-Datensatzquelle.md`](Secure-OrderDesk-Datensatzquelle.md); zusammenhängende Beispieldaten in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md). Alle Daten sind fiktiv; die Northwind-Basis wird markenneutral und rein didaktisch genutzt.

**EN:** The binding data source is the classic **Northwind Traders sample database with layout and data**, including the mandatory record `ALFKI`. The original order data (~1996–1998) is extended up to July 2026 with plausible fictional records (1–2 new customers and 8–16 orders per month, spread over old and new customers). Details and rules are in [`Secure-OrderDesk-Datensatzquelle.md`](Secure-OrderDesk-Datensatzquelle.md); connected sample data in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md). All data is fictional; the Northwind base is used brand-neutrally and purely for teaching.

## Gemeinsamer Kernvertrag / Shared Core Contract

**DE:** Jede spätere Implementierung muss mindestens diese Fähigkeiten bereitstellen:

- Kunden, Produkte, Bestellungen und Bestellpositionen im Northwind-Layout führen (inkl. `ALFKI`).
- Bestell- und Kundeneingaben validieren; Eingaben gelten als nicht vertrauenswürdig.
- Daten über eine relationale Ablage-Abstraktion speichern, die später austauschbar bleibt; Datenzugriffe nur parametrisiert (keine SQL-Injection).
- Verständliche Fehlermeldungen ohne interne Details liefern.
- Rollen `learner`, `developer` und `reviewer` unterscheiden.
- Betriebs- und Audit-Log ohne Secrets und ohne unnötige personenbezogene Daten führen.
- Einfache Auswertungen berechnen: Umsatz je Kategorie, Top-Produkte, Bestellungen je Zeitraum.
- Tests und Sicherheitsnachweise erzeugen.
- Sandbox-Nutzung, Spec-Kit-Artefakte und Richtlinienbezug dokumentieren.

**EN:** Each later implementation must provide at least these capabilities: hold customers, products, orders, and order lines in Northwind layout (incl. `ALFKI`); validate order and customer input, treating input as untrusted; store data through a replaceable relational store abstraction with only parameterized data access (no SQL injection); provide understandable error messages without internal details; distinguish the roles `learner`, `developer`, and `reviewer`; keep an operations and audit log without secrets and without unnecessary personal data; compute simple reports (revenue per category, top products, orders per period); produce tests and security evidence; and document sandbox use, Spec Kit artifacts, and guideline relation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE – Anwendungsentwicklung | Domänenmodell, Eingabevalidierung, Berechtigungen, relationale Persistenz, parametrisierte Queries, Tests und sichere Schnittstellen. |
| SI – Systemintegration | Sandbox, Laufzeit, Konfiguration, Datenbank-Betrieb, Logging, Secrets, Supply Chain und Toolchain-Nachweise. |
| DPA – Daten- und Prozessanalyse | Datenschutz, Datenqualität, Auswertungen/Kennzahlen, Betriebsauswertung und Grenzen der Aussagekraft. |
| DV – Digitale Vernetzung | Systemkontext, Schnittstellen zur Bestell-Pipeline, Kommunikationswege, Verfügbarkeit und Betriebsnachweise. |

**EN:** Application Development focuses on the domain model, validation, permissions, relational persistence, parameterized queries, tests, and secure interfaces. System Integration focuses on sandboxing, runtime, configuration, database operation, logging, secrets, supply chain, and toolchain evidence. Data and Process Analysis focuses on privacy, data quality, reports/metrics, operational evaluation, and limits of interpretation. Digital Networking focuses on system context, interfaces to the order pipeline, communication paths, availability, and operational evidence.

## Richtlinie Sichere Entwicklung / Secure Development Guideline

**DE:** Die Richtlinie Sichere Entwicklung ist der verbindliche Leitanker. Jede Lerneinheit verlangt sichtbare Bezüge zu Richtlinie, Checklisten, mitgeltenden Dokumenten und den sechs Spec-Kit-Governance-Presets. Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert; offene Punkte werden als `Open` mit Folgeaufgabe markiert. Wegen der relationalen Domäne stehen SQL-Sicherheit (parametrisierte Statements) und Datenschutz besonders im Vordergrund.

**EN:** The Secure Development Guideline is the binding anchor. Each learning unit requires visible references to the guideline, checklists, related documents, and the six Spec Kit governance presets. Non-applicable points are documented as `N/A` with rationale; open points are marked as `Open` with follow-up work. Because of the relational domain, SQL security (parameterized statements) and privacy are especially prominent.

**DE:** Die Level-2-Sprachrepos führen diese Grundlage lokal unter `docs/secure-development/` mit: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und Preset-Verzahnung. Zusätzlich sind die sechs Governance-Presets aus der zentralen Matrix installiert und mit `specify preset list` nachweisbar.

**EN:** The level-2 language repositories carry this baseline locally under `docs/secure-development/`: guideline, 12 individual checklists, compendium, related documents, and preset alignment. The six governance presets from the central matrix are installed as well and can be evidenced with `specify preset list`.

## Sandbox-Einordnung / Sandbox Classification

**DE:** `absdd-image-sandbox` ist als öffentliches Referenz-Repository verfügbar: <https://github.com/hindermath/absdd-image-sandbox>. **Container-First-Gate:** Jeder KI-Agenten-Aufruf (z. B. Codex, Claude, Copilot, Gemini) erfolgt ab Unit 00 verbindlich im Container bzw. in der freigegebenen Sandbox — nie direkt auf dem Arbeitsplatz-Rechner der Auszubildenden. Diese Regel gilt, **bevor** der erste Agent gestartet wird. Verbindliche Grundlage ist [`Secure-Trader-Sandbox-Preflight.md`](Secure-Trader-Sandbox-Preflight.md). Lernende sollen zusätzlich verstehen, warum eine Sandbox KI-gestützte Entwicklung begrenzt, welche Daten nicht in Agentenläufe gehören und welche Nachweise später wichtig werden.

**EN:** `absdd-image-sandbox` is available as a public reference repository: <https://github.com/hindermath/absdd-image-sandbox>. **Container-first gate:** every AI-agent invocation (e.g. Codex, Claude, Copilot, Gemini) runs inside the container or approved sandbox from unit 00 onward — never directly on the apprentice's workstation. This rule applies **before** the first agent is started. The binding basis is [`Secure-Trader-Sandbox-Preflight.md`](Secure-Trader-Sandbox-Preflight.md). Learners should additionally understand why a sandbox limits AI-assisted development, which data must not enter agent runs, and which evidence will matter later.

**DE:** Die Grenze verläuft am Agenten-Aufruf: Lesen, Review und allgemeine Entwicklung **ohne Agenten** dürfen außerhalb der Sandbox erfolgen, zum Beispiel mit JetBrains IDEs, VS Code oder unter Windows mit Visual Studio. Sobald ein KI-Agent Dateien oder Befehle ausführt, geschieht das im Container. Was über die Jahre wächst, ist die Tiefe der eigenen Sandbox-Profilierung (Mounts, Egress, Nachweise), nicht die Frage, ob das Gate gilt.

**EN:** The boundary is the agent invocation: reading, review, and general development **without agents** may happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Visual Studio on Windows. As soon as an AI agent runs files or commands, it happens inside the container. What grows over the years is the depth of your own sandbox profiling (mounts, egress, evidence), not whether the gate applies.

## Empfohlene Repo-Struktur / Recommended Repository Structure

**DE:** Für die spätere praktische Bearbeitung ist die Reihe als Level-1-/Level-2-Struktur gedacht. `home-baseline-tmp` bleibt Level 0 und hält die generischen Materialien. Ein privates Level-1-Workspace-Repo `SecureOrderDeskProjects` koordiniert die Lernreihe. Darunter liegen sechs private Level-2-Repos, damit jede Sprache eigene Toolchain, Tests, Dependency-Audits, Spec-Kit-Artefakte und Sicherheitsnachweise erhält.

**EN:** For later practical work, the series is intended as a Level 1 / Level 2 structure. `home-baseline-tmp` remains Level 0 and keeps the generic material. A private Level 1 workspace repository `SecureOrderDeskProjects` coordinates the learning series. Six private Level 2 repositories sit below it so each language has its own toolchain, tests, dependency audits, Spec Kit artifacts, and security evidence.

| Rolle / Role | Lokaler Ordner / Local folder | GitHub-Slug | Primärsprache / Primary language | Zweck / Purpose |
|---|---|---|---|---|
| Koordination / Coordination | `SecureOrderDeskProjects` | `secure-orderdesk-baseline` | keine Implementierung / no implementation | Statusmatrix, Reihenfolge, Links und Vergleich der Sprachpfade |
| Referenz / Reference | `SecureOrderDesk-CSharp` | `secureorderdesk-csharp` | C# | erste manuelle Referenzimplementierung durch Lehrende |
| Vergleich / Comparison | `SecureOrderDesk-Go` | `secureorderdesk-go` | Go | MSL-Vergleich mit Go-Toolchain und Go-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureOrderDesk-Java` | `secureorderdesk-java` | Java | MSL-Vergleich mit Java-Toolchain und Java-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureOrderDesk-Python` | `secureorderdesk-python` | Python | MSL-Vergleich mit Python-Toolchain und Python-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureOrderDesk-Rust` | `secureorderdesk-rust` | Rust | MSL-Vergleich mit Rust-Toolchain und Rust-Sicherheitsprüfungen |
| Vergleich / Comparison | `SecureOrderDesk-Swift` | `secureorderdesk-swift` | Swift | MSL-Vergleich mit Swift-Toolchain und Apple-Plattform-Hinweisen |

**DE:** In jedem Level-2-Repo werden die gleichen fachlichen Intakes genutzt. Die fachlichen Regeln bleiben gleich; nur Umsetzung, Toolchain, Tests und sprachspezifische Sicherheitsprüfungen unterscheiden sich. Spec-Kit-Läufe werden nicht automatisch gestartet, sondern später manuell pro Repo und pro Aufgaben-Lastenheft.

**EN:** Each Level 2 repository uses the same functional intakes. The functional rules stay the same; only implementation, toolchain, tests, and language-specific security checks differ. Spec Kit runs are not started automatically but later run manually per repository and task intake.

## Technischer Startlauf 00 / Technical Scaffold Run 00

**DE:** Vor der ersten fachlichen Lerneinheit führt jedes Sprachrepo den technischen Startlauf `00` aus. Dieser Lauf erzeugt oder prüft nur das minimale Sprachprojekt, Build/Test-Befehle, Secure-Development-Basis und installierte Governance-Presets. Fachliche OrderDesk-Logik beginnt erst mit Aufgabe `01`.

**EN:** Before the first functional learning unit, each language repository runs the technical scaffold task `00`. This run only creates or verifies the minimal language project, build/test commands, the secure-development baseline, and installed governance presets. Functional OrderDesk logic starts with task `01`.

## Statusmatrix-Vorlage / Status Matrix Template

**DE:** Das spätere Level-1-Repo kann diese Matrix als Startpunkt verwenden:

**EN:** The later Level 1 repository can use this matrix as a starting point:

| Sprache / Language | Level-2-Repo | MSL | Intakes kopiert / Intakes copied | Spec-Kit-Stand / Spec Kit state | Reviewstatus / Review state | Rolle / Role |
|---|---|---|---|---|---|---|
| C# | `SecureOrderDesk-CSharp` | ja / yes | offen / open | manuell offen / manually open | offen / open | Referenz / Reference |
| Go | `SecureOrderDesk-Go` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Java | `SecureOrderDesk-Java` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Python | `SecureOrderDesk-Python` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Rust | `SecureOrderDesk-Rust` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |
| Swift | `SecureOrderDesk-Swift` | ja / yes | offen / open | manuell offen / manually open | offen / open | Vergleich / Comparison |

## Reihenfolge der Lerneinheiten / Order of Learning Units

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 00 | Sprachrepo-Projekt-Scaffold | AE, SI, DPA, DV |
| 01 | Kundenauftrag, Scope und Handelsdomäne | AE, DPA, SI |
| 02 | Domänenmodell: Kunden, Produkte, Bestellungen und Positionen | AE |
| 03 | Eingabevalidierung und Trust Boundaries | AE |
| 04 | Datenschutz und Audit-Logging | DPA |
| 05 | Rollen und Berechtigungen | AE |
| 06 | Persistenz, SQL und sichere Datenzugriffe | AE, DPA |
| 07 | Testbarkeit und Qualität | AE |
| 08 | Lieferanten, Supply Chain und MSL-Bewertung | SI |
| 09 | Sandbox und agentische Entwicklung | SI, DV, Container-First-Gate ab Unit 00 verbindlich, hier vertieft |
| 10 | Auswertungen und Kennzahlen | DPA, SI |
| 11 | Spec-Kit-Review und Abschluss | AE, SI, DPA, DV |
| 12 | Jahr-2-Baseline und Track-Ableitung | AE, SI, DPA, DV |

## Sprachspezifische Adapterhinweise / Language-Specific Adapter Notes

| Sprache | Sichere Umsetzungshinweise |
|---|---|
| C# | `IConfiguration`, parametrisierte Persistenz (ADO.NET/EF Core), sichere Serialisierung, `dotnet test`, Dependency-Audit; kein dynamisches SQL aus Eingaben. |
| Go | `database/sql` mit Platzhaltern, `context`, I/O-Timeouts, `govulncheck`, klare Fehlerwerte; kein String-konkateniertes SQL. |
| Java | Bean Validation, parametrisierte Persistenz (JDBC/JPA), sichere Deserialisierung, JUnit, Maven-/Gradle-Audit; keine dynamischen Queries aus Eingaben. |
| Python | Parametrisierte DB-API-Aufrufe, Pydantic oder explizite Validierung, keine unsichere Deserialisierung, `pip-audit`, sichere Dateipfade. |
| Rust | `sqlx`/parametrisierte Abfragen, kein `unsafe` ohne Begründung, keine Panic-Pfade aus Eingaben, `cargo audit`, explizite Fehlerwerte. |
| Swift | Parametrisierte Abfragen (z. B. SQLite mit Bindings), keine Force-Unwraps bei Eingaben, Keychain/CryptoKit/File-Scope, XCTest, klare Optional-Behandlung. |

## Erwartete Unterrichtsergebnisse / Expected Teaching Results

**DE:** Nach Abschluss der Reihe sollen Lernende erklären können, warum MSL wichtig sind, warum MSL sichere Entwicklung nicht ersetzen, warum SQL-Zugriffe parametrisiert werden müssen, wie Spec Kit Anforderungen, Planung, Aufgaben und Reviews strukturiert, wie Datenschutz und Informationssicherheit bei Kunden- und Bestelldaten zusammenhängen und wie eine Sandbox sichere KI-gestützte Entwicklung unterstützt.

**EN:** After completing the series, learners should be able to explain why MSL matter, why MSL do not replace secure development, why SQL access must be parameterized, how Spec Kit structures requirements, planning, tasks, and reviews, how privacy and information security relate for customer and order data, and how a sandbox supports secure AI-assisted development.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Das Master-Lastenheft beschreibt die Gesamtlandkarte und wird nicht als Sammellauf gestartet.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
