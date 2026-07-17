# Secure ServiceHarvester Operations Track Lernreihe / Operations Track Learning Series

**Stand / Date:** 2026-07-06
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen der Fachrichtung Systemintegration ab dem 3. Lehrjahr / IT specialists in System Integration from the third training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Einordnung / Placement

**DE:** Dieser Track ist die SI-Spezialisierung der [Professional Tracks (Jahr 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md) der Familie Secure ServiceHarvester. Er baut auf [v2 (Jahr 2)](Secure-ServiceHarvester-v2-Lernreihe.md) auf.

**EN:** This track is the System Integration specialization of the [Professional Tracks (year 3)](Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md) of the Secure ServiceHarvester family. It builds on [v2 (year 2)](Secure-ServiceHarvester-v2-Lernreihe.md).

## Zielbild / Target Picture

**DE:** Der Operations Track vertieft den sicheren Betrieb des Dienstes: plattformgerechtes Deployment, gehärtete Konfiguration, Beobachtbarkeit, reproduzierbare Builds, Backup und Wiederherstellung sowie belastbare Betriebsnachweise. Im Mittelpunkt stehen Verfügbarkeit, Nachvollziehbarkeit und begründete Betriebsentscheidungen.

**EN:** The Operations Track deepens secure operation of the service: platform-appropriate deployment, hardened configuration, observability, reproducible builds, backup and recovery, and robust operational evidence. The focus is availability, traceability, and justified operational decisions.

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit |
|---:|---|
| 01 | Track-Baseline und Betriebszielbild |
| 02 | Dienst-Deployment (Windows-Service, systemd, launchd) |
| 03 | Konfiguration, Secrets und sichere Defaults |
| 04 | Härtung und Angriffsflächen-Reduktion |
| 05 | Observability: Logging, Health und Metriken |
| 06 | CI/CD-Pipeline und reproduzierbare Builds |
| 07 | Backup, Recovery und Datenmigration |
| 08 | Supply Chain, SBOM und Dependency-Audit |
| 09 | Sandbox, Isolation und Betriebsnachweise |
| 10 | Betriebs-Review, Runbook und Abschluss |

## Governance und Nachweise / Governance and Evidence

- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente als lokale Nachweisbasis.
- Sieben Governance-Presets aus der zentralen Matrix; Nachweis über `specify preset list`.
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
