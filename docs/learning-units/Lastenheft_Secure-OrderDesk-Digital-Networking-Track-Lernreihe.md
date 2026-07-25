# Lastenheft: Secure OrderDesk Digital Networking Track Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den DV - Digitale Vernetzung-Track der Familie Secure OrderDesk als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden. Die inhaltliche Übersicht liegt in [`Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md`](Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md).

**EN:** This master intake describes the Digital Networking track of the Secure OrderDesk family as an overview map. It is not meant to be started as one large Spec Kit run. The narrative overview lives in [`Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md`](Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md).

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | DV - Digitale Vernetzung |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Referenzimplementierung / Reference | `SecureOrderDesk-CSharp` (C#) |
| Level-1-Sammelrepo / Level-1 umbrella | `SecureOrderDeskProjects` |
| Baseline-Tag / Baseline tag | `learning/year-2-complete` |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |
| Stand / Date | 2026-07-07 |

## Gesamtziel / Overall Goal

**DE:** Der Digital Networking Track betrachtet Secure OrderDesk als vernetzte, plattformübergreifende Handels-/Bestellplattform für Secure Trader. Lernende planen Systemkontext und Bestell-Pipeline-Netzbezüge, Schnittstellen und Kommunikationsflüsse zwischen Bestellannahme, Katalog und relationaler Ablage, Segmentierung und Vertrauenszonen, Transportsicherheit und Endpunkt-Authentifizierung, Verfügbarkeit mit Timeouts und Wiederholstrategien, verteilte Integration und Agentenkommunikation, Betriebs- und Netznachweise sowie Ausfallszenarien und Resilienz. Die Domäne bleibt sprachneutral; die C#-Referenz `SecureOrderDesk-CSharp` dient nur als Anschauung.

**EN:** The Digital Networking Track treats Secure OrderDesk as a networked, cross-platform trading/ordering platform for Secure Trader. Learners plan system context and order-pipeline network relations, interfaces and communication flows between order intake, catalog, and relational store, segmentation and trust zones, transport security and endpoint authentication, availability with timeouts and retry strategies, distributed integration and agent communication, operational and network evidence, and failure scenarios with resilience. The domain stays language-neutral; the C# reference `SecureOrderDesk-CSharp` serves only as illustration.

## Faden agentische KI und Spec Kit / AI and Spec Kit Thread

**DE:** Wie in der gesamten Familie Secure OrderDesk zieht sich der Faden agentische KI und Spec Kit durch den Track. Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` geplant, genutzt oder begründet abgegrenzt. Für DV ist besonders wichtig, Netzwerkzugriffe, Mounts, Schreibgrenzen und Abweichungen von der Sandbox ausdrücklich zu dokumentieren. Spec-Kit-Läufe sind begleitende SDD-Aufgaben und ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** As across the whole Secure OrderDesk family, the AI and Spec Kit thread runs through the track. From year 3 onward, AI-assisted write work is planned, used, or explicitly bounded in or with `absdd-image-sandbox`. For Digital Networking, network access, mounts, write boundaries, and deviations from the sandbox must be documented explicitly. Spec Kit runs are companion SDD tasks and do not replace vocational school, workplace training, the curriculum, or exam preparation.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei (Glob) | Thema |
|---:|---|---|
| 01 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_01_*.md` | Track-Baseline und Netzzielbild |
| 02 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_02_*.md` | Systemkontext und Bestell-Pipeline-Netzbezüge |
| 03 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_03_*.md` | Schnittstellen und Kommunikationsflüsse |
| 04 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_04_*.md` | Segmentierung und Vertrauenszonen |
| 05 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_05_*.md` | Transportsicherheit und Endpunkt-Authentifizierung |
| 06 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_06_*.md` | Verfügbarkeit, Timeouts und Wiederholstrategien |
| 07 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_07_*.md` | Verteilte Integration und Agentenkommunikation |
| 08 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_08_*.md` | Betriebs- und Netznachweise |
| 09 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_09_*.md` | Ausfallszenarien und Resilienz |
| 10 | `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_10_*.md` | Netz-Review, Trade-offs und Abschluss |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Kein Ersatz für Rahmenlehrplan, Berufsschule, betriebliche Ausbildung oder Prüfungsvorbereitung.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden DV - Digitale Vernetzung-Repo (Level-1 SecureOrderDeskProjects) das nächste konkrete Aufgaben-Lastenheft der Secure OrderDesk Digital Networking Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
