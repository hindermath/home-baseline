# Secure OrderDesk Application Track Unterrichtsleitfaden / Secure OrderDesk Application Track Teaching Guide

**Stand / Date:** 2026-07-08

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung des AE - Anwendungsentwicklung-Tracks im 3. Lehrjahr für die relationale Handels-/Bestellplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. `ALFKI`). Er legt die Spezialisierung, erwartete Tiefe, typische Fehler und Nachweisanforderungen fest.

**EN:** This guide supports instructors when using the Application Development track in the third training year for the relational trading/ordering platform Secure OrderDesk (client company Secure Trader, Northwind data base incl. `ALFKI`). It defines specialization, expected depth, common mistakes, and evidence needs.

## Didaktische Einordnung / Didactic Position

**DE:** Lernende arbeiten im 3. Lehrjahr stärker eigenständig. Sie starten aus dem Jahr-2-Stand (Tag `learning/year-2-complete`), begründen Entscheidungen, benennen Risiken, geben Evidenzpfade an und dokumentieren die Grenzen ihrer Aussagen. KI-Agenten und Spec Kit begleiten die Arbeit; sie ersetzen keine fachliche Bewertung.

**EN:** In the third training year, learners work more independently. They start from the year-2 state (tag `learning/year-2-complete`), justify decisions, name risks, provide evidence paths, and document the boundaries of their statements. AI agents and Spec Kit accompany the work; they do not replace professional judgement.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Lehrhinweis |
|---:|---|---|
| 01 | Track-Baseline und Feature-Zielbild | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 02 | API-Erweiterung und Ressourcenmodell | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 03 | Persistenz-Adapter und Repository-Muster | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 04 | Query-, Filter- und Paginierungslogik | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 05 | Viewer- oder Client-Oberfläche (barrierefrei) | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 06 | Fehlerbehandlung und Validierung vertieft | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 07 | Erweiterbarkeit und Konfigurierbarkeit | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 08 | Sichere Serialisierung und Schnittstellenverträge | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 09 | Teststrategie: Unit, Integration und Contract-Tests | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 10 | Feature-Review, Trade-offs und Abschluss | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |

## Bewertung / Assessment

- Prüfe, ob die Arbeit klar zur Spezialisierung AE passt.
- Prüfe, ob Entscheidungen mit Alternativen, Trade-offs und Evidenz begründet werden.
- Prüfe, ob parametrisierte SQL-Zugriffe und der Pflicht-Datensatz `ALFKI` sichtbar bleiben.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob MSL-Vorteile sichtbar werden, aber keine Secure-Coding-Prüfung ersetzen.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
