# Secure CaseTracker Operations Track Lernreihe / Secure CaseTracker Operations Track Learning Series

**Stand / Date:** 2026-07-05
**Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 3. Lehrjahr / IT specialist apprentices from the third training year onward
**Spezialisierung / Specialization:** SI - Systemintegration / System Integration
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** Der Operations Track betrachtet den CaseTracker als zu betreibendes System. Lernende planen Sandbox, Laufzeit, CI/CD, Secrets, Monitoring, Backup/Restore, Incident Response, Supply-Chain-Nachweise und Härtung.

**EN:** The Operations Track treats the CaseTracker as an operated system. Learners plan sandboxing, runtime, CI/CD, secrets, monitoring, backup/restore, incident response, supply-chain evidence, and hardening.

## Lernziele / Learning Goals

- Betriebsgrenzen und Verantwortlichkeiten definieren
- CI/CD und Release-Nachweise planen
- Secrets, Monitoring und Recovery sicher einordnen
- Betriebsrisiken auditfähig bewerten

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Schwerpunkt |
|---:|---|---|
| 01 | Betriebszielbild und Systemgrenzen | Betriebsziele, Systemgrenzen, Verantwortlichkeiten und Schutzbedarf werden für den betriebenen CaseTracker definiert. |
| 02 | Sandbox- und Laufzeitprofil | Sandbox, Laufzeit, Containerannahmen, Schreibgrenzen, Netzwerkgrenzen und Toolchain werden beschrieben. |
| 03 | CI/CD-Pipeline und Release-Nachweise | Pipeline-Schritte, Gates, Tests, Artefakte, Release-Nachweise und manuelle Freigaben werden geplant. |
| 04 | Secrets, Konfiguration und Least Privilege | Secrets, Konfiguration, Berechtigungen, sichere Defaults und Rotationsannahmen werden geprüft. |
| 05 | Logging, Monitoring und Alerting | Logs, Metriken, Alerts, Datenschutzgrenzen, Aussagegrenzen und Verantwortlichkeiten werden spezifiziert. |
| 06 | Backup, Restore und Recovery-Übung | Backup-Ziele, Restore-Ablauf, Recovery-Test, Datenverlustgrenzen und Nachweise werden geplant. |
| 07 | Incident Response und Betriebsdokumentation | Meldewege, Rollen, Erstmaßnahmen, Nachweise, Lessons Learned und Betriebsdokumentation werden strukturiert. |
| 08 | Dependency-, SBOM- und Supply-Chain-Nachweise | Dependencies, SBOM, VEX, SLSA, OpenSSF-Scorecard-Anwendbarkeit und N/A-Begründungen werden geprüft. |
| 09 | Härtungscheck gegen Richtlinie und Presets | Betrieb, Sandbox, CI, Logging, Secrets und Dokumentation werden gegen Richtlinie und Presets gehärtet. |
| 10 | Abschlussreview mit Betriebsrisiken und Übergabe | Betriebsrisiken, Nachweise, offene Punkte, Akzeptanz und Übergabeempfehlung werden dokumentiert. |

## Governance und Nachweise / Governance and Evidence

- Dieser Track nutzt `Secure CaseTracker` und `Secure CaseTracker v2` als fachliche Vorarbeit.
- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente werden als lokale Arbeitsgrundlage erwartet.
- Die acht Governance-Presets aus der zentralen Matrix sind Voraussetzung für spätere MSL-Level-2-Repos.
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert.
- Offene Punkte werden als `Open` mit Folgeaktion, Risiko und Priorität dokumentiert.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
