# Lastenheft: Secure OrderDesk Operations Track Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den SI - Systemintegration-Track der Familie Secure OrderDesk als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden. Die inhaltliche Übersicht liegt in [`Secure-OrderDesk-Operations-Track-Lernreihe.md`](Secure-OrderDesk-Operations-Track-Lernreihe.md).

**EN:** This master intake describes the System Integration track of the Secure OrderDesk family as an overview map. It is not meant to be started as one large Spec Kit run. The narrative overview lives in [`Secure-OrderDesk-Operations-Track-Lernreihe.md`](Secure-OrderDesk-Operations-Track-Lernreihe.md).

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | SI - Systemintegration |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Referenzimplementierung / Reference | `SecureOrderDesk-CSharp` (C#) |
| Level-1-Sammelrepo / Level-1 umbrella | `SecureOrderDeskProjects` |
| Baseline-Tag / Baseline tag | `learning/year-2-complete` |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |
| Stand / Date | 2026-07-07 |

## Gesamtziel / Overall Goal

**DE:** Der Operations Track betrachtet Secure OrderDesk als plattformübergreifend zu betreibende relationale Handels-/Bestellplattform für Secure Trader. Lernende planen relationalen Datenbank-Betrieb, plattformgerechtes Deployment, gehärtete Konfiguration, Observability, reproduzierbare Builds, Backup und Wiederherstellung der Northwind-Daten inkl. `ALFKI`, Supply-Chain-Nachweise sowie belastbare Betriebsnachweise. Die Domäne bleibt sprachneutral; die C#-Referenz `SecureOrderDesk-CSharp` dient nur als Anschauung.

**EN:** The Operations Track treats Secure OrderDesk as a cross-platform relational trading/ordering platform for Secure Trader to be operated. Learners plan relational database operation, platform-appropriate deployment, hardened configuration, observability, reproducible builds, backup and recovery of the Northwind data incl. `ALFKI`, supply-chain evidence, and robust operational evidence. The domain stays language-neutral; the C# reference `SecureOrderDesk-CSharp` serves only as illustration.

## Faden agentische KI und Spec Kit / AI and Spec Kit Thread

**DE:** Wie in der gesamten Familie Secure OrderDesk zieht sich der Faden agentische KI und Spec Kit durch den Track. Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` geplant, genutzt oder begründet abgegrenzt. Spec-Kit-Läufe sind begleitende SDD-Aufgaben und ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** As across the whole Secure OrderDesk family, the AI and Spec Kit thread runs through the track. From year 3 onward, AI-assisted write work is planned, used, or explicitly bounded in or with `absdd-image-sandbox`. Spec Kit runs are companion SDD tasks and do not replace vocational school, workplace training, the curriculum, or exam preparation.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei (Glob) | Thema |
|---:|---|---|
| 01 | `Lastenheft_Secure-OrderDesk-Operations-Track_01_*.md` | Track-Baseline und Betriebszielbild |
| 02 | `Lastenheft_Secure-OrderDesk-Operations-Track_02_*.md` | Datenbank-Deployment (Windows-Service, systemd, launchd) |
| 03 | `Lastenheft_Secure-OrderDesk-Operations-Track_03_*.md` | Konfiguration, Secrets und sichere Defaults |
| 04 | `Lastenheft_Secure-OrderDesk-Operations-Track_04_*.md` | Härtung und Angriffsflächen-Reduktion |
| 05 | `Lastenheft_Secure-OrderDesk-Operations-Track_05_*.md` | Observability: Logging, Health und Metriken |
| 06 | `Lastenheft_Secure-OrderDesk-Operations-Track_06_*.md` | CI/CD-Pipeline und reproduzierbare Builds |
| 07 | `Lastenheft_Secure-OrderDesk-Operations-Track_07_*.md` | Backup, Recovery und Datenmigration |
| 08 | `Lastenheft_Secure-OrderDesk-Operations-Track_08_*.md` | Supply Chain, SBOM und Dependency-Audit |
| 09 | `Lastenheft_Secure-OrderDesk-Operations-Track_09_*.md` | Sandbox, Isolation und Betriebsnachweise |
| 10 | `Lastenheft_Secure-OrderDesk-Operations-Track_10_*.md` | Betriebs-Review, Runbook und Abschluss |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden SI - Systemintegration-Repo (Level-1 SecureOrderDeskProjects) das nächste konkrete Aufgaben-Lastenheft der Secure OrderDesk Operations Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
