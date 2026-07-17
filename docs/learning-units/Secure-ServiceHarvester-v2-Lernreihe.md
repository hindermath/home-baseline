# Secure ServiceHarvester v2 Lernreihe / Secure ServiceHarvester v2 Learning Series

**Stand / Date:** 2026-07-06
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 2. Lehrjahr / IT specialist apprentices from the second training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Einordnung in die Familie / Placement in the Family

**DE:** Diese Datei beschreibt die **Aufbaureihe v2 (2. Lehrjahr)** der Familie **Secure ServiceHarvester**. Sie setzt die [Basis-Reihe (Jahr 1)](Secure-ServiceHarvester-Lernreihe.md) fort und bereitet die [Professional Tracks (Jahr 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md) vor. Das Arbeiten mit KI-Agenten und Spec Kit bleibt der durchgehende methodische Faden.

**EN:** This file describes the **advanced series v2 (year 2)** of the **Secure ServiceHarvester** family. It continues the [base series (year 1)](Secure-ServiceHarvester-Lernreihe.md) and prepares the [Professional Tracks (year 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md). Working with AI agents and Spec Kit remains the continuous methodical thread.

## Zielbild / Target Picture

**DE:** v2 vertieft den Secure ServiceHarvester vom einfachen Sammel-Programm zu einem sauber geschnittenen Dienst: klare Systemgrenzen zwischen Worker, Harvester, Ablage und Schnittstelle, plattformübergreifendes Dienst-Hosting, eine austauschbare Backend-Abstraktion, gehärteter Import und beobachtbarer Betrieb. Der fachliche Kernvertrag aus der Basis-Reihe bleibt gültig und wird technisch tiefer umgesetzt.

**EN:** v2 deepens the Secure ServiceHarvester from a simple collection program into a cleanly separated service: clear system boundaries between worker, harvester, store, and interface, cross-platform service hosting, a replaceable backend abstraction, hardened import, and observable operation. The shared core contract from the base series stays valid and is implemented at greater technical depth.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE – Anwendungsentwicklung | Architektur, Backend-Abstraktion, API-Vertrag, Fehler-/Response-Modell, Tests. |
| SI – Systemintegration | Dienst-Hosting, Konfiguration, Secrets, Logging, Health, Monitoring und Betriebsnachweise. |
| DPA – Daten- und Prozessanalyse | Datenqualität im Harvester, Kennzahlen, Aussagegrenzen und Datenschutz. |
| DV – Digitale Vernetzung | Systemgrenzen, Schnittstellen, Kommunikationsflüsse und Verfügbarkeit. |

**EN:** Application Development focuses on architecture, backend abstraction, API contract, error/response model, and tests. System Integration focuses on service hosting, configuration, secrets, logging, health, monitoring, and operational evidence. Data and Process Analysis focuses on harvester data quality, metrics, limits of interpretation, and privacy. Digital Networking focuses on system boundaries, interfaces, communication flows, and availability.

## Lernziele / Learning Goals

- Einen langlaufenden Dienst plattformübergreifend hosten und sicher durch seinen Lebenszyklus führen.
- Persistenz hinter einer Abstraktion kapseln und Backends bewusst wechseln (SQLite, PostgreSQL, MongoDB).
- Import und Sammeln idempotent, validiert und gehärtet gestalten.
- Einen klaren API-/Service-Vertrag mit sauberer Fehlerbehandlung ohne interne Details anbieten.
- Betrieb beobachtbar machen: strukturiertes Logging, Health/Status, einfache Metriken, keine Secrets.

*English summary: learners practice hosting, persistence abstraction, hardened import, API contracts, and observable operation at second-year depth, with Spec Kit as the companion method.*

## Arbeitsmodell / Working Model

**DE:** Diese Reihe wird jetzt nur als kanonisches Level-0-Lernmaterial vorbereitet. Level-1- und Level-2-Repositories werden später separat angelegt. Die späteren Level-2-Pfade nutzen C#, Go, Java, Python, Rust und Swift und führen die Secure-Development-Basis lokal mit. Der empfohlene Startpunkt ist ein abgeschlossener Jahr-1-Stand (Tag `learning/year-1-complete`).

**EN:** This series is currently prepared only as canonical level-0 learning material. Level-1 and level-2 repositories will be created later in a separate step. Later level-2 paths use C#, Go, Java, Python, Rust, and Swift and carry the secure-development baseline locally. The recommended starting point is a completed year-1 state (tag `learning/year-1-complete`).

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 01 | Architekturzielbild und Systemgrenzen | AE, SI, DV |
| 02 | Plattformübergreifendes Dienst-Hosting und Lebenszyklus | SI, DV, AE |
| 03 | Persistenzmodell und Backend-Abstraktion | AE, SI, DPA |
| 04 | Harvester: Zeitplanung, Idempotenz und Import-Härtung | AE, DPA, SI |
| 05 | API- und Service-Vertrag und OpenAPI | AE, DV, SI |
| 06 | Fehler-, Validierungs- und Response-Modell | AE, DPA |
| 07 | Rollen-, Autorisierung und Audit-Logging | SI, AE, DPA |
| 08 | Betrieb, Logging, Health und Monitoring | SI, DV, DPA |
| 09 | Sichere Konfiguration, Secrets und Betriebsnachweise | SI, AE |
| 10 | MSL-Vergleich und Abschlussreview | AE, SI, DPA, DV |

## Governance und Nachweise / Governance and Evidence

- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente werden als lokale Arbeitsgrundlage erwartet.
- Die sieben Governance-Presets aus der zentralen Matrix sind für spätere MSL-Level-2-Repos Voraussetzung.
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert.
- Offene Punkte werden als `Open` mit Folgeaktion, Risiko und Priorität dokumentiert.
- Jede positive Aussage zur Einhaltung verweist auf konkrete Evidenz.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Das Master-Lastenheft beschreibt die Gesamtlandkarte und wird nicht als Sammellauf gestartet.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
