# Lastenheft: Secure ServiceHarvester Operations Track Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den SI - Systemintegration-Track der Familie Secure ServiceHarvester als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden. Die inhaltliche Übersicht liegt in [`Secure-ServiceHarvester-Operations-Track-Lernreihe.md`](Secure-ServiceHarvester-Operations-Track-Lernreihe.md).

**EN:** This master intake describes the System Integration track of the Secure ServiceHarvester family as an overview map. It is not meant to be started as one large Spec Kit run. The narrative overview lives in [`Secure-ServiceHarvester-Operations-Track-Lernreihe.md`](Secure-ServiceHarvester-Operations-Track-Lernreihe.md).

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | SI - Systemintegration |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Referenzimplementierung / Reference | `InventarWorkerService` (C#) |
| Level-1-Sammelrepo / Level-1 umbrella | `SecureServiceHarvesterProjects` |
| Baseline-Tag / Baseline tag | `learning/year-2-complete` |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |
| Stand / Date | 2026-07-06 |

## Gesamtziel / Overall Goal

**DE:** Der Operations Track betrachtet den ServiceHarvester als plattformübergreifend zu betreibenden Sammel- und Worker-Dienst. Lernende planen Deployment als Systemdienst, gehärtete Konfiguration, Observability, reproduzierbare Builds, Backup und Wiederherstellung, Supply-Chain-Nachweise sowie belastbare Betriebsnachweise. Die Domäne bleibt sprachneutral; die C#-Referenz `InventarWorkerService` dient nur als Anschauung.

**EN:** The Operations Track treats the ServiceHarvester as a cross-platform collector and worker service to be operated. Learners plan deployment as a system service, hardened configuration, observability, reproducible builds, backup and recovery, supply-chain evidence, and robust operational evidence. The domain stays language-neutral; the C# reference `InventarWorkerService` serves only as illustration.

## Faden agentische KI und Spec Kit / AI and Spec Kit Thread

**DE:** Wie in der gesamten Familie Secure ServiceHarvester zieht sich der Faden agentische KI und Spec Kit durch den Track. Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` geplant, genutzt oder begründet abgegrenzt. Spec-Kit-Läufe sind begleitende SDD-Aufgaben und ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** As across the whole Secure ServiceHarvester family, the AI and Spec Kit thread runs through the track. From year 3 onward, AI-assisted write work is planned, used, or explicitly bounded in or with `absdd-image-sandbox`. Spec Kit runs are companion SDD tasks and do not replace vocational school, workplace training, the curriculum, or exam preparation.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md) | Track-Baseline und Betriebszielbild |
| 02 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.md) | Dienst-Deployment (Windows-Service, systemd, launchd) |
| 03 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_03_Konfiguration-Secrets-und-sichere-Defaults.md) | Konfiguration, Secrets und sichere Defaults |
| 04 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_04_Haertung-und-Angriffsflaechen-Reduktion.md) | Härtung und Angriffsflächen-Reduktion |
| 05 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.md) | Observability: Logging, Health und Metriken |
| 06 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md) | CI/CD-Pipeline und reproduzierbare Builds |
| 07 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.md) | Backup, Recovery und Datenmigration |
| 08 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md) | Supply Chain, SBOM und Dependency-Audit |
| 09 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_09_Sandbox-Isolation-und-Betriebsnachweise.md) | Sandbox, Isolation und Betriebsnachweise |
| 10 | [`Lastenheft_Secure-ServiceHarvester-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.md`](Lastenheft_Secure-ServiceHarvester-Operations-Track_10_Betriebs-Review-Runbook-und-Abschluss.md) | Betriebs-Review, Runbook und Abschluss |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden SI - Systemintegration-Repo (Level-1 SecureServiceHarvesterProjects) das nächste konkrete Aufgaben-Lastenheft der Secure ServiceHarvester Operations Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
