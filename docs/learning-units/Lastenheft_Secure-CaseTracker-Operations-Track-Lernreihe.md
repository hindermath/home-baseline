# Lastenheft: Secure CaseTracker Operations Track Lernreihe

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den SI - Systemintegration-Track als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden.

**EN:** This master intake describes the System Integration track as an overview map. It is not meant to be started as one large Spec Kit run.

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | SI - Systemintegration |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |

## Gesamtziel / Overall Goal

**DE:** Der Operations Track betrachtet den CaseTracker als zu betreibendes System. Lernende planen Sandbox, Laufzeit, CI/CD, Secrets, Monitoring, Backup/Restore, Incident Response, Supply-Chain-Nachweise und Härtung.

**EN:** The Operations Track treats the CaseTracker as an operated system. Learners plan sandboxing, runtime, CI/CD, secrets, monitoring, backup/restore, incident response, supply-chain evidence, and hardening.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md`](Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md) | Betriebszielbild und Systemgrenzen |
| 02 | [`Lastenheft_Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.md`](Lastenheft_Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.md) | Sandbox- und Laufzeitprofil |
| 03 | [`Lastenheft_Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.md`](Lastenheft_Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.md) | CI/CD-Pipeline und Release-Nachweise |
| 04 | [`Lastenheft_Secure-CaseTracker-Operations-Track_04_Secrets-Konfiguration-und-Least-Privilege.md`](Lastenheft_Secure-CaseTracker-Operations-Track_04_Secrets-Konfiguration-und-Least-Privilege.md) | Secrets, Konfiguration und Least Privilege |
| 05 | [`Lastenheft_Secure-CaseTracker-Operations-Track_05_Logging-Monitoring-und-Alerting.md`](Lastenheft_Secure-CaseTracker-Operations-Track_05_Logging-Monitoring-und-Alerting.md) | Logging, Monitoring und Alerting |
| 06 | [`Lastenheft_Secure-CaseTracker-Operations-Track_06_Backup-Restore-und-Recovery-Uebung.md`](Lastenheft_Secure-CaseTracker-Operations-Track_06_Backup-Restore-und-Recovery-Uebung.md) | Backup, Restore und Recovery-Übung |
| 07 | [`Lastenheft_Secure-CaseTracker-Operations-Track_07_Incident-Response-und-Betriebsdokumentation.md`](Lastenheft_Secure-CaseTracker-Operations-Track_07_Incident-Response-und-Betriebsdokumentation.md) | Incident Response und Betriebsdokumentation |
| 08 | [`Lastenheft_Secure-CaseTracker-Operations-Track_08_Dependency-SBOM-und-Supply-Chain-Nachweise.md`](Lastenheft_Secure-CaseTracker-Operations-Track_08_Dependency-SBOM-und-Supply-Chain-Nachweise.md) | Dependency-, SBOM- und Supply-Chain-Nachweise |
| 09 | [`Lastenheft_Secure-CaseTracker-Operations-Track_09_Haertungscheck-gegen-Richtlinie-und-Presets.md`](Lastenheft_Secure-CaseTracker-Operations-Track_09_Haertungscheck-gegen-Richtlinie-und-Presets.md) | Härtungscheck gegen Richtlinie und Presets |
| 10 | [`Lastenheft_Secure-CaseTracker-Operations-Track_10_Abschlussreview-mit-Betriebsrisiken-und-Uebergabe.md`](Lastenheft_Secure-CaseTracker-Operations-Track_10_Abschlussreview-mit-Betriebsrisiken-und-Uebergabe.md) | Abschlussreview mit Betriebsrisiken und Übergabe |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Operations-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden SI - Systemintegration-Repo das nächste konkrete Aufgaben-Lastenheft der Secure CaseTracker Operations Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
