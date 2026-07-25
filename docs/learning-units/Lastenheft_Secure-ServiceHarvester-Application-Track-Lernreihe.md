# Lastenheft: Secure ServiceHarvester Application Track Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den AE - Anwendungsentwicklung-Track von Secure ServiceHarvester als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden.

**EN:** This master intake describes the Application Development track of Secure ServiceHarvester as an overview map. It is not meant to be started as one large Spec Kit run.

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | AE - Anwendungsentwicklung |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Referenz / Reference | C#-Referenz `InventarWorkerService`, Level-1 `SecureServiceHarvesterProjects` |
| Baseline-Bezug / Baseline | Tag `learning/year-2-complete` |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |

## Gesamtziel / Overall Goal

**DE:** Der Application Track vertieft die sichere Feature- und Schnittstellenentwicklung des Sammel- und Worker-Dienstes. Lernende planen gut geschnittene Funktionen, saubere Persistenz-Adapter, robuste Query- und Paginierungslogik, eine wartbare Oberfläche (Viewer oder CLI), sichere Serialisierung und eine belastbare Teststrategie.

**EN:** The Application Track deepens secure feature and interface development of the collector and worker service. Learners plan well-scoped functions, clean persistence adapters, robust query and pagination logic, a maintainable interface (viewer or CLI), secure serialization, and a robust test strategy.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md) | Track-Baseline und Feature-Zielbild |
| 02 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md) | API-Erweiterung und Ressourcenmodell |
| 03 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md) | Persistenz-Adapter und Repository-Muster |
| 04 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.md) | Query-, Filter- und Paginierungslogik |
| 05 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_05_Viewer-oder-Client-Oberflaeche.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_05_Viewer-oder-Client-Oberflaeche.md) | Viewer- oder Client-Oberfläche |
| 06 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.md) | Fehlerbehandlung und Validierung vertieft |
| 07 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_07_Erweiterbarkeit-und-Konfigurierbarkeit.md) | Erweiterbarkeit und Konfigurierbarkeit |
| 08 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md) | Sichere Serialisierung und Schnittstellenverträge |
| 09 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md) | Teststrategie: Unit, Integration und Contract-Tests |
| 10 | [`Lastenheft_Secure-ServiceHarvester-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.md`](Lastenheft_Secure-ServiceHarvester-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.md) | Feature-Review, Trade-offs und Abschluss |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden AE - Anwendungsentwicklung-Repo das nächste konkrete Aufgaben-Lastenheft der Secure ServiceHarvester Application Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
