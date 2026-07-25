# Secure ServiceHarvester Application Track Lernreihe / Application Track Learning Series

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

**Stand / Date:** 2026-07-06
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen der Fachrichtung Anwendungsentwicklung ab dem 3. Lehrjahr / IT specialists in Application Development from the third training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Einordnung / Placement

**DE:** Dieser Track ist die AE-Spezialisierung der [Professional Tracks (Jahr 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md) der Familie Secure ServiceHarvester. Er baut auf [v2 (Jahr 2)](Secure-ServiceHarvester-v2-Lernreihe.md) auf.

**EN:** This track is the Application Development specialization of the [Professional Tracks (year 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md) of the Secure ServiceHarvester family. It builds on [v2 (year 2)](Secure-ServiceHarvester-v2-Lernreihe.md).

## Zielbild / Target Picture

**DE:** Der Application Track vertieft die sichere Feature- und Schnittstellenentwicklung: Der Dienst erhält gut geschnittene Funktionen, saubere Persistenz-Adapter, eine wartbare Oberfläche (Viewer oder CLI) und belastbare Tests. Im Mittelpunkt stehen Erweiterbarkeit, klare Verträge und begründete Entwurfsentscheidungen.

**EN:** The Application Track deepens secure feature and interface development: the service gains well-scoped functions, clean persistence adapters, a maintainable interface (viewer or CLI), and robust tests. The focus is extensibility, clear contracts, and justified design decisions.

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit |
|---:|---|
| 01 | Track-Baseline und Feature-Zielbild |
| 02 | API-Erweiterung und Ressourcenmodell |
| 03 | Persistenz-Adapter und Repository-Muster |
| 04 | Query-, Filter- und Paginierungslogik |
| 05 | Viewer- oder Client-Oberfläche (barrierefrei) |
| 06 | Fehlerbehandlung und Validierung vertieft |
| 07 | Erweiterbarkeit und Konfigurierbarkeit |
| 08 | Sichere Serialisierung und Schnittstellenverträge |
| 09 | Teststrategie: Unit, Integration und Contract-Tests |
| 10 | Feature-Review, Trade-offs und Abschluss |

## Governance und Nachweise / Governance and Evidence

- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente als lokale Nachweisbasis.
- Acht Governance-Presets aus der zentralen Matrix; Nachweis über `specify preset list`.
- Nicht anwendbare Punkte als `N/A` mit Begründung; offene Punkte als `Open` mit Folgeaktion.
- Positive Aussagen zu Sicherheit, Qualität oder Compliance nur mit konkreter Evidenz.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
