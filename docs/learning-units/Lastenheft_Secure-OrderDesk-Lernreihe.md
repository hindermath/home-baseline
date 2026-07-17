# Lastenheft: Secure OrderDesk Lernreihe

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Zielgruppe / Audience:** Fachinformatiker*innen und anschlussfähige IT-Berufe in Ausbildung, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices and related IT occupations, trainers, reviewers, AI agents
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Datenbasis / Data base:** klassische Northwind-Sample-Datenbank (Layout und Daten) inkl. Pflicht-Datensatz `ALFKI` / classic Northwind sample database (layout and data) incl. mandatory record `ALFKI`
- **Spec-Kit-Nutzung / Spec Kit use:** Dieses Lastenheft ist die Gesamtlandkarte der Basis-Reihe. Die einzelnen Aufgaben-Lastenhefte werden später separat als Spec-Kit-Intakes genutzt.
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox` ist das Zielbild für sichere, reproduzierbare Lern- und Agentenarbeit.
- **Operatives Zielmodell / Operational target model:** späteres privates Level-1-Workspace-Repo mit sechs privaten Level-2-Sprach-Repos.

## Lernziel / Learning Goal

**DE:** Lernende verstehen die Basis-Reihe der Familie Secure OrderDesk als strukturiertes Grundlagenprojekt im 1. Lehrjahr. Sie erkennen, wie Richtlinie Sichere Entwicklung, Checklisten, Spec Kit, MSL, Datenschutz, Informationssicherheit, Testbarkeit, Sandbox, eine relationale Bestell-/Handelsplattform und kundenorientierte Projektarbeit zusammenwirken. Der durchgehende Faden ist das verantwortliche Arbeiten mit agentischer KI und Spec-Driven Development. Wegen der relationalen Domäne stehen SQL-Sicherheit über parametrisierte Queries und der Schutz von Kunden- und Bestelldaten besonders im Vordergrund.

**EN:** Learners understand the base series of the Secure OrderDesk family as a structured foundational project in year 1. They see how the Secure Development Guideline, checklists, Spec Kit, MSL, privacy, information security, testability, sandboxing, a relational ordering/trading platform, and customer-oriented project work fit together. The continuous thread is responsible work with agentic AI and Spec-Driven Development. Because of the relational domain, SQL security through parameterized queries and the protection of customer and order data are especially prominent.

## Systemlandschaft / System Landscape

**DE:** Die fiktive Handelsfirma **Secure Trader** betreibt eine Bestell-/Handelsplattform auf Northwind-Datenbasis. Die didaktische Software-Schmiede **EuFPA** baut und betreut für Secure Trader drei ineinandergreifende, aber je eigenständig nutzbare Systeme: **Secure OrderDesk** (die Handels-/Bestellplattform selbst; Kunden, Produkte, Bestellungen inkl. `ALFKI`), **Secure ServiceHarvester** (erfasst System-/Bestandsdaten der Arbeitsplatz-PCs und Server) und **Secure CaseTracker** (Support-Plattform für Support-Cases). Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit. Das gemeinsame Universums- und Datenmodell steht in `Secure-Trader-Systemlandschaft.md`.

**EN:** The fictional trading company **Secure Trader** runs an ordering/trading platform on a Northwind data base. The didactic software house **EuFPA** builds and maintains three interlocking, yet individually usable systems for Secure Trader: **Secure OrderDesk** (the trading platform itself; customers, products, orders incl. `ALFKI`), **Secure ServiceHarvester** (collects system/inventory data of the workstation PCs and servers), and **Secure CaseTracker** (support platform for support cases). The coupling is deliberately light: enriching context, not a hard dependency. The shared world and data model is in `Secure-Trader-Systemlandschaft.md`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Die Reihe enthält Domänenmodell, Validierung, Berechtigungen, relationale Persistenz, parametrisierte Queries, Tests und sichere Implementierungsentscheidungen. |
| SI | Primär | Die Reihe enthält Sandbox, Datenbank-Betrieb, Toolchain, Secrets, Logging, Supply Chain und reproduzierbare Entwicklungsumgebung. |
| DPA | Primär | Die Reihe enthält Datenschutz, Datenqualität, Auswertungen, Kennzahlen und Grenzen der Aussagekraft. |
| DV | Primär | Die Reihe enthält Systemkontext, Schnittstellen zur Bestell-Pipeline, Trust Boundaries, Verfügbarkeit und sichere Vernetzung. |

**EN:** The series is primary material for all four IT specialist specializations because it connects relational domain behavior, secure data access, operational reporting, and system/network relations in one shared training project.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Reihe stützt die gemeinsamen IT-Lernfelder zu Kundenauftrag, Arbeitsplatz, Schutzbedarf, Datenverwaltung, relationaler Datenbank, systemübergreifender Datenbereitstellung sowie Netzwerken und Diensten. Die konkrete Lernfeldzuordnung je Einheit (00–12) steht in `Rahmenlehrplan-Lernfeld-Mapping.md`.

**EN:** The series supports the shared IT learning fields around customer tasks, workplace context, protection needs, data management, relational databases, cross-system data provisioning, and networks and services. The concrete learning-field mapping per unit (00–12) is documented in `Rahmenlehrplan-Lernfeld-Mapping.md`.

**DE:** Spec-Kit-Läufe sind begleitende SDD-Aufgaben innerhalb dieser Lernreihe. Sie ersetzen nicht das klassische Erlernen des jeweiligen Berufsbilds, den Berufsschulunterricht, die betriebliche Ausbildung, Ausbilderentscheidungen oder Prüfungsvorbereitung.

**EN:** Spec Kit runs are companion SDD tasks inside this learning series. They do not replace classical learning of the occupation, vocational school, workplace training, trainer decisions, or exam preparation.

## Datenbasis / Data Base

**DE:** Verbindliche Datenquelle ist die klassische Northwind-Traders-Sample-Datenbank mit Layout und Daten, inklusive Pflicht-Datensatz `ALFKI`. Die Original-Bestelldaten (~1996–1998) werden bis Juli 2026 mit plausiblen fiktiven Datensätzen erweitert. Details und Regeln stehen in `Secure-OrderDesk-Datensatzquelle.md`; zusammenhängende Beispieldaten in `Secure-Trader-Systemlandschaft.md`. Alle Daten sind fiktiv; die Northwind-Basis wird markenneutral und rein didaktisch genutzt. „Microsoft“ wird nur als historischer Quellhinweis auf den Ursprung der Northwind-Beispieldatenbank erwähnt.

**EN:** The binding data source is the classic Northwind Traders sample database with layout and data, including the mandatory record `ALFKI`. The original order data (~1996–1998) is extended up to July 2026 with plausible fictional records. Details and rules are in `Secure-OrderDesk-Datensatzquelle.md`; connected sample data in `Secure-Trader-Systemlandschaft.md`. All data is fictional; the Northwind base is used brand-neutrally and purely for teaching. "Microsoft" is mentioned only as a historical source note for the origin of the Northwind sample database.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Relevante Richtlinienprinzipien:** sichere Anforderungen, sichere Architektur, sichere Code-Erzeugung, sichere relationale Datenzugriffe (parametrisierte Queries), MSL-Präferenz, auditfähige Evidenz.
- **Relevante Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, Kompetenzprofile und Schulungsplan.
- **Spec-Kit-Presets:** alle sieben Governance-Presets als Bewertungsrahmen.
- **Evidenz:** Aufgaben-Lastenhefte, spätere `spec.md`, `plan.md`, `tasks.md`, Checklisten und Review-Notizen.
- **Level-2-Arbeitsbasis:** Jedes Sprachrepo führt die Richtlinie, alle 12 Einzel-Checklisten, den Checklistensammelband, die mitgeltenden Dokumente und die Preset-Verzahnung lokal unter `docs/secure-development/`. Die sieben Governance-Presets sind aus der zentralen Matrix installiert und mit `specify preset list` nachweisbar.
- **Selbstprüfung vor Härtung:** Jedes Sprachrepo führt `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` als separaten späteren Intake; MSL-Status ist dabei Prüfpunkt, aber keine Voraussetzung.

**EN:** The full guideline and the seven governance presets are the assessment frame for all later task intakes. Because the domain is relational, parameterized SQL access and privacy of customer and order data are checked in every unit.

## Operatives Arbeitsmodell / Operational Working Model

**DE:** Dieses Master-Lastenheft beschreibt die Gesamtlandkarte der Basis-Reihe. Die spätere praktische Bearbeitung soll in einer privaten Level-1-/Level-2-Struktur erfolgen:

- **Level 0:** `home-baseline-tmp` als zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, Presets und Intakes.
- **Level 1:** `SecureOrderDeskProjects` als privates Koordinations-Repo mit README, Statusmatrix und Abarbeitungsreihenfolge.
- **Level 2:** sechs private Sprach-Repos: `SecureOrderDesk-CSharp`, `SecureOrderDesk-Go`, `SecureOrderDesk-Java`, `SecureOrderDesk-Python`, `SecureOrderDesk-Rust`, `SecureOrderDesk-Swift`.

**DE:** Die Level-2-Namen bezeichnen die lokalen Ordner. Die Repository-Slugs werden durch den Bootstrap lowercase erzeugt, zum Beispiel `secureorderdesk-csharp`.

**EN:** This master intake describes the overall map of the base series. Later practical work should use a private Level 1 / Level 2 structure:

- **Level 0:** `home-baseline-tmp` as the central source for learning material, guideline, checklists, presets, and intakes.
- **Level 1:** `SecureOrderDeskProjects` as the private coordination repository with README, status matrix, and processing order.
- **Level 2:** six private language repositories: `SecureOrderDesk-CSharp`, `SecureOrderDesk-Go`, `SecureOrderDesk-Java`, `SecureOrderDesk-Python`, `SecureOrderDesk-Rust`, `SecureOrderDesk-Swift`.

**EN:** The Level 2 names identify the local folders. The repository slugs are created lowercase by the bootstrap, for example `secureorderdesk-csharp`.

**DE:** C# ist als erster manueller Referenzpfad vorgesehen. Go, Java, Python, Rust und Swift folgen als Vergleichs- und Vertiefungspfade. Ein KI-Agent bereitet diese Struktur nur vor; die Spec-Kit-Läufe starten später manuell durch Lehrende oder Lernende. Vor Aufgabe `01` gibt es den technischen Startlauf `00`; nach dem Abschluss von Jahr 2 gibt es den Baseline- und Track-Ableitungslauf `12`.

**EN:** C# is planned as the first manual reference path. Go, Java, Python, Rust, and Swift follow as comparison and deeper practice paths. An AI agent only prepares this structure; the Spec Kit runs are started later and manually by instructors or learners. Before task `01`, there is the technical scaffold run `00`; after year 2, there is the baseline and track derivation run `12`.

## Reihenfolge der Aufgaben / Order of Tasks

| Nr. | Aufgabe / Task | Schwerpunkt / Focus |
|---:|---|---|
| 00 | Sprachrepo- und Projekt-Scaffold / Language repo and project scaffold | Startpunkt schaffen / create a starting point |
| 01 | Kundenauftrag, Scope und Handelsdomäne / Customer task, scope, and trading domain | Auftrag klären / clarify task |
| 02 | Domänenmodell: Kunden, Produkte, Bestellungen und Positionen / Domain model: customers, products, orders, and lines | Fachmodell / business model |
| 03 | Eingabevalidierung und Trust Boundaries / Input validation and trust boundaries | Sicherheit an Grenzen / security at boundaries |
| 04 | Datenschutz und Audit-Logging / Privacy and audit logging | Daten und Nachvollziehbarkeit / data and traceability |
| 05 | Rollen und Berechtigungen / Roles and permissions | Least Privilege |
| 06 | Persistenz, SQL und sichere Datenzugriffe / Persistence, SQL, and secure data access | parametrisierte Queries / parameterized queries |
| 07 | Testbarkeit und Qualität / Testability and quality | Nachweise statt Behauptungen / evidence instead of claims |
| 08 | Lieferanten, Supply Chain und MSL-Bewertung / Suppliers, supply chain, and MSL assessment | Abhängigkeiten und Sprachen / dependencies and languages |
| 09 | Sandbox und agentische Entwicklung / Sandbox and agentic development | sichere Arbeitsumgebung / secure work environment |
| 10 | Auswertungen und Kennzahlen / Reports and metrics | Datenqualität und Betrieb / data quality and operation |
| 11 | Spec-Kit-Review und Abschluss / Spec Kit review and closure | Review und Präsentation / review and presentation |
| 12 | Jahr-2-Baseline und Track-Ableitung / Year 2 baseline and track derivation | Ausblick / outlook |

## Aufgabenstellung / Task

**DE:** Erstelle keine Implementierung. Nutze dieses Lastenheft als Gesamtlandkarte. Spätere Spec-Kit-Läufe starten jeweils mit einem der Aufgaben-Lastenhefte `00` bis `12`. `00` bereitet nur das Sprachrepo vor, `01` bis `11` bearbeiten die fachliche Jahr-1-Reihe, und `12` sichert später den Jahr-2-Stand als Grundlage für Jahr 3.

**EN:** Do not create an implementation from this intake. Use it as the overall map. Later Spec Kit runs start with one of the task intake files `00` to `12`. `00` only prepares the language repository, `01` through `11` cover the functional year-1 series, and `12` later preserves the year-2 state as the basis for year 3.

## Erwartete Artefakte / Expected Artifacts

- Übersicht in `docs/learning-units/Secure-OrderDesk-Lernreihe.md`.
- Einzelne Aufgaben-Intakes `docs/learning-units/Lastenheft_Secure-OrderDesk_00_*.md` bis `docs/learning-units/Lastenheft_Secure-OrderDesk_12_*.md`.
- Lernbegleiter je Einheit unter `docs/learning-units/lernbegleiter/`.
- Berufsbild-Mapping `docs/learning-units/IT-Berufe-Secure-OrderDesk-Mapping.md` als Zuordnungs- und Abgrenzungsdokument.
- Unterrichtsleitfäden für Lehrende (Basis und spätere Tracks): `docs/learning-units/Secure-OrderDesk*Unterrichtsleitfaden.md`.
- Systemlandschaft und Datensatzquelle `docs/learning-units/Secure-Trader-Systemlandschaft.md` und `docs/learning-units/Secure-OrderDesk-Datensatzquelle.md`.
- Späteres Level-1-Koordinations-Repo mit Statusmatrix und sechs Level-2-Sprach-Repos.
- Keine Feature-Branch-Erzeugung in diesem Schritt.

## Akzeptanzkriterien / Acceptance Criteria

- Alle dreizehn Aufgaben-Lastenhefte (00–12) existieren.
- Jedes Aufgaben-Lastenheft enthält Fachrichtungsbezug, Richtlinienbezug, Sicherheitsanforderungen inkl. parametrisierter SQL-Zugriffe, Datenschutzanforderungen, Tests, Evidenz und Copy-Paste-Prompt.
- Die Northwind-Datenbasis inkl. `ALFKI` ist in der fachlichen Reihe verbindlich referenziert.
- Deutsche Texte verwenden Umlaute und `ß`; Dateinamen bleiben ASCII.
- DE-first, EN-second ist sichtbar.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen in einem bereits vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure-OrderDesk-Basis-Reihe. Bei einem neuen oder leeren Sprachrepo beginne mit `00`; bei fachlicher Jahr-1-Arbeit beginne mit `01`; für die spätere Jahr-2-Baseline nutze `12`. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
