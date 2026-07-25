# Secure CaseTracker v2 Lernreihe / Secure CaseTracker v2 Service Edition Learning Series

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

**Stand / Date:** 2026-07-05
**Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 2. Lehrjahr / IT specialist apprentices from the second training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** EuFPA möchte den bisherigen Secure CaseTracker zu einer Service Edition ausbauen. Die Reihe vertieft Architektur, Persistenz, API-/Service-Grenzen, Autorisierung, Audit-Logging, Tests, CI, Sandbox, Betrieb und MSL-Vergleich.

**EN:** EuFPA wants to extend the existing Secure CaseTracker into a service edition. The series deepens architecture, persistence, API/service boundaries, authorization, audit logging, tests, CI, sandbox, operation, and MSL comparison.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE - Anwendungsentwicklung | Architektur, Service-Vertrag, Persistenz, Validierung, Autorisierung und Tests. |
| SI - Systemintegration | Sandbox, CI, Konfiguration, Betriebsannahmen, Secrets, Toolchain- und Nachweispfade. |
| DPA - Daten- und Prozessanalyse | Datenmodell, Datenschutz, Auditdaten, Prozesskennzahlen und Aussagegrenzen. |
| DV - Digitale Vernetzung | Service-Grenzen, Schnittstellen, Kommunikationsflüsse, Betriebsannahmen, Sandbox und Verfügbarkeit. |

## Lernziele / Learning Goals

- Architekturentscheidungen als ADR-Kandidaten formulieren.
- Persistenz, API-Grenzen und Fehlerfälle sprachneutral planen.
- Tests, CI, Sandbox und Betriebsnachweise als prüfbare Evidenz verstehen.
- MSL-Sprachpfade vergleichen, ohne sichere Entwicklung durch MSL zu ersetzen.

*English summary: learners practice architecture, persistence, interfaces, tests, operation, and audit-ready documentation at second-year depth.*

## Arbeitsmodell / Working Model

**DE:** Diese Reihe wird jetzt nur als kanonisches Level-0-Lernmaterial vorbereitet. Level-1- und Level-2-Repositories werden später separat angelegt. Die späteren Level-2-Pfade nutzen C#, Go, Java, Python, Rust und Swift und führen die Secure-Development-Basis lokal mit.

**EN:** This series is currently prepared only as canonical level-0 learning material. Level-1 and level-2 repositories will be created later in a separate step. Later level-2 paths use C#, Go, Java, Python, Rust, and Swift and carry the secure-development baseline locally.

## Readiness vor Jahr 2 / Readiness Before Year 2

**DE:** Jahr 2 setzt auf einem bestehenden Jahr-1-Sprachrepo auf. Wenn ein Sprachrepo noch leer ist oder kein minimales Projekt enthält, wird zuerst der Secure-CaseTracker-Startlauf `00` ausgeführt. Die fachlichen Jahr-2-Intakes erzeugen kein Projektgerüst, sondern erweitern einen vorhandenen Sprachpfad. Der fertige Jahr-2-Stand soll später als Tag `learning/year-2-complete` gesichert werden.

**EN:** Year 2 builds on an existing year-1 language repository. If a language repository is still empty or has no minimal project, the Secure CaseTracker scaffold run `00` is executed first. The functional year-2 intakes do not create the project scaffold; they extend an existing language path. The completed year-2 state should later be preserved as the tag `learning/year-2-complete`.

## Sandbox-Readiness / Sandbox Readiness

**DE:** `absdd-image-sandbox` ist öffentlich verfügbar unter <https://github.com/hindermath/absdd-image-sandbox>. Im 2. Lehrjahr wird die Sandbox als Betriebs-, Toolchain- und Nachweiskonzept vorbereitet. Ein konkreter Lernlauf darf begründet außerhalb der Sandbox erfolgen, wenn die benötigten Technologien noch nicht ausreichend behandelt wurden. Die Entscheidung wird als `Applicable`, `N/A` oder `Open` dokumentiert.

**EN:** `absdd-image-sandbox` is publicly available at <https://github.com/hindermath/absdd-image-sandbox>. In the second training year, the sandbox is prepared as an operational, toolchain, and evidence concept. A concrete learning run may be justified outside the sandbox if the required technologies have not yet been covered deeply enough. The decision is documented as `Applicable`, `N/A`, or `Open`.

**DE:** IDE- und Editor-Arbeit bleibt zulässig außerhalb der Sandbox, insbesondere mit JetBrains IDEs, VS Code oder Windows-only Visual Studio. KI-gestützte Schreibarbeit wird jedoch so geplant, dass ab Jahr 3 eine sichere Sandbox-Nutzung möglich ist.

**EN:** IDE and editor work remains allowed outside the sandbox, especially with JetBrains IDEs, VS Code, or Windows-only Visual Studio. AI-assisted write work is planned so that secure sandbox use is possible from year 3 onward.

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 01 | Architekturzielbild und Systemgrenzen | AE, SI |
| 02 | Persistenzmodell und Migrationen | AE, DPA |
| 03 | API- und Service-Vertrag | AE, SI, DV |
| 04 | Fehler-, Validierungs- und Response-Modell | AE |
| 05 | Rollen- und Autorisierungsmatrix | AE, SI |
| 06 | Audit-Logging und Datenschutz | SI, DPA, DV |
| 07 | Import- und Export-Härtung | AE, DPA |
| 08 | Teststrategie und CI-Nachweise | AE, SI, DV |
| 09 | Sandbox- und Betriebsnachweise | SI, DV |
| 10 | MSL-Vergleich und Abschlussreview | AE, SI, DPA, DV |

## Governance und Nachweise / Governance and Evidence

- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente werden als lokale Arbeitsgrundlage erwartet.
- Die acht Governance-Presets aus der zentralen Matrix sind für spätere MSL-Level-2-Repos Voraussetzung.
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
