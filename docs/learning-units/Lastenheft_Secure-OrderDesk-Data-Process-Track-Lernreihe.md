# Lastenheft: Secure OrderDesk Data & Process Track Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den DPA - Daten- und Prozessanalyse-Track von Secure OrderDesk als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden. Die begleitende Übersicht bleibt [`Secure-OrderDesk-Data-Process-Track-Lernreihe.md`](Secure-OrderDesk-Data-Process-Track-Lernreihe.md).

**EN:** This master intake describes the Data and Process Analysis track of Secure OrderDesk as an overview map. It is not meant to be started as one large Spec Kit run. The accompanying overview stays [`Secure-OrderDesk-Data-Process-Track-Lernreihe.md`](Secure-OrderDesk-Data-Process-Track-Lernreihe.md).

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | DPA - Daten- und Prozessanalyse |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Referenz / Reference | C#-Referenz `SecureOrderDesk-CSharp`, Level-1 `SecureOrderDeskProjects` |
| Baseline-Bezug / Baseline | Tag `learning/year-2-complete` |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |
| Stand / Date | 2026-07-07 |

## Gesamtziel / Overall Goal

**DE:** Der Data & Process Track vertieft den verantwortlichen Umgang mit den Bestell- und Handelsdaten von Secure Trader auf der relationalen Handels-/Bestellplattform. Lernende planen Datenqualität in Bestellungen und Positionen, aussagekräftige Umsatz- und Bestell-Kennzahlen sowie Betriebsmetriken, barrierefreies Reporting auf der Northwind-Datenbasis inkl. `ALFKI`, vertieften Datenschutz, die Erkennung von Anomalien und Lücken sowie die ehrliche Benennung von Aussagegrenzen. Im Mittelpunkt stehen belastbare Auswertungen und die Frage, was die Daten wirklich aussagen können und was nicht. Agentische KI und Spec Kit begleiten die Arbeit als durchgehender Faden.

**EN:** The Data & Process Track deepens the responsible handling of Secure Trader's order and trading data on the relational trading/ordering platform. Learners plan data quality in orders and line items, meaningful revenue and order metrics as well as operational measurements, accessible reporting on the Northwind data base incl. `ALFKI`, deepened privacy, the detection of anomalies and gaps, and the honest naming of interpretation limits. The focus is robust evaluation and the question of what the data can and cannot really say. Agentic AI and Spec Kit accompany the work as a continuous thread.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei (Glob) | Thema |
|---:|---|---|
| 01 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_01_*.md` | Track-Baseline und Datenzielbild |
| 02 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_02_*.md` | Datenqualität in Bestellungen und Positionen |
| 03 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_03_*.md` | Umsatz-Kennzahlen und Betriebsmetriken |
| 04 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_04_*.md` | Datenschutz und Datenminimierung vertieft |
| 05 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_05_*.md` | Reporting und Aggregationsansichten (barrierefrei) |
| 06 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_06_*.md` | Aussagegrenzen und Datenunsicherheit |
| 07 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_07_*.md` | Anomalie- und Lückenerkennung |
| 08 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_08_*.md` | Prozessfeedback und Verbesserung |
| 09 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_09_*.md` | Test- und Nachweisstrategie für Datenaussagen |
| 10 | `Lastenheft_Secure-OrderDesk-Data-Process-Track_10_*.md` | Daten-Review, Trade-offs und Abschluss |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden DPA - Daten- und Prozessanalyse-Repo das nächste konkrete Aufgaben-Lastenheft der Secure OrderDesk Data & Process Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
