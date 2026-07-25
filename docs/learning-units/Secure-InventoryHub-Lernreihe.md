# Secure InventoryHub Lernreihe / Secure InventoryHub Learning Series

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

**DE:** EuFPA benötigt einen Secure InventoryHub, um Geräte, Software, Versionen, Verantwortliche, Wartungsstatus und einfache Risikoansichten nachvollziehbar zu verwalten.

**EN:** EuFPA needs a Secure InventoryHub to manage devices, software, versions, owners, maintenance status, and simple risk views in a traceable way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE - Anwendungsentwicklung | Datenmodell, Rollen, Suche, Import/Export, Tests und sichere Schnittstellen. |
| SI - Systemintegration | Inventar, Betrieb, Patchstand, Wartung, Toolchain, SBOM und Betriebsnachweise. |
| DPA - Daten- und Prozessanalyse | Datenqualität, Kennzahlen, Aussagegrenzen, Datenschutz und Risikoansichten. |
| DV - Digitale Vernetzung | Geräte- und Systembezüge, Schnittstellen, Netzpfade, Wartungsstatus, Risikoansichten und Betriebsnachweise. |

## Lernziele / Learning Goals

- Inventardaten fachlich und datenschutzbewusst modellieren.
- Verantwortlichkeiten, Rollen und Statusübergänge sicher planen.
- Import, Export, Audit, Patch- und Risikoansichten mit Nachweisen verbinden.
- Supply-Chain-, SBOM- und Betriebsbezug didaktisch sauber einordnen.

*English summary: learners practice architecture, persistence, interfaces, tests, operation, and audit-ready documentation at second-year depth.*

## Arbeitsmodell / Working Model

**DE:** Diese Reihe wird jetzt nur als kanonisches Level-0-Lernmaterial vorbereitet. Level-1- und Level-2-Repositories werden später separat angelegt. Die späteren Level-2-Pfade nutzen C#, Go, Java, Python, Rust und Swift und führen die Secure-Development-Basis lokal mit.

**EN:** This series is currently prepared only as canonical level-0 learning material. Level-1 and level-2 repositories will be created later in a separate step. Later level-2 paths use C#, Go, Java, Python, Rust, and Swift and carry the secure-development baseline locally.

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 01 | Kundenauftrag, Scope und Inventarobjekte | AE, SI, DPA, DV |
| 02 | Asset- und Software-Datenmodell und Status | AE, DPA, DV |
| 03 | Verantwortlichkeiten und Rollen | AE, SI, DV |
| 04 | Suche, Filter und Datenqualität | AE, DPA, DV |
| 05 | Import, Export und Datenbereinigung | AE, DPA |
| 06 | Audit-Logging und Datenschutz | SI, DPA, DV |
| 07 | Patch-, Wartungs- und Risikoansicht | SI, DPA, DV |
| 08 | Supply Chain, SBOM und Dependency-Bezug | SI, AE, DV |
| 09 | Teststrategie, Sandbox und Betriebsnachweise | AE, SI, DV |
| 10 | Review, Kennzahlen und Abschlussbewertung | AE, SI, DPA, DV |

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
