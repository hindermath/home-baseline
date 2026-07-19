# Secure CaseTracker Digital Networking Track Lernreihe / Secure CaseTracker Digital Networking Track Learning Series

**Stand / Date:** 2026-07-05
**Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 3. Lehrjahr / IT specialist apprentices from the third training year onward
**Spezialisierung / Specialization:** DV - Digitale Vernetzung / Digital Networking
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** Der Digital Networking Track betrachtet den Secure CaseTracker als Teil einer vernetzten Umgebung. Lernende planen Schnittstellen, Kommunikationsflüsse, Netzwerksegmente, Identitäten, Verfügbarkeit, Telemetrie, sichere Konfiguration, Missbrauchsfälle und nachvollziehbare Betriebsnachweise.

**EN:** The Digital Networking Track treats the Secure CaseTracker as part of a networked environment. Learners plan interfaces, communication flows, network segments, identities, availability, telemetry, secure configuration, abuse cases, and traceable operational evidence.

## Lernziele / Learning Goals

- vernetzte Systeme und Kommunikationsflüsse sicher abgrenzen
- Trust Boundaries, Segmentierung und Zugriffswege dokumentieren
- Verfügbarkeit, Monitoring und Datenschutz zusammen bewerten
- Netzwerk- und Integrationsrisiken auditfähig begründen

## Aufgabenstruktur / Task Structure

| Nr. | Lerneinheit | Schwerpunkt |
|---:|---|---|
| 01 | Vernetzungszielbild und Systemkontext | Systemkontext, Beteiligte, Knoten, Schnittstellen und Nicht-Ziele werden für den vernetzten CaseTracker abgegrenzt. |
| 02 | Topologie, Schnittstellen und Kommunikationsflüsse | Topologie, Protokolle, Datenflüsse, Ports, Richtungen und Datenklassen werden nachvollziehbar beschrieben. |
| 03 | Trust Boundaries und Segmentierung | Vertrauensgrenzen, Netzwerksegmente, Schutzbedarf und erlaubte Übergänge werden sichtbar gemacht. |
| 04 | Identitäten, Zugriff und Netzwerkrechte | Identitäten, technische Konten, Rollen, Servicezugriffe und Least-Privilege-Regeln werden spezifiziert. |
| 05 | Verfügbarkeit, Resilienz und Fallbacks | Ausfallannahmen, Wiederanlauf, Degradation, Timeouts und Resilienzgrenzen werden geplant. |
| 06 | Telemetrie, Monitoring und Datenschutzgrenzen | Metriken, Logs, Traces, Warnungen, Datenschutzgrenzen und Aussagegrenzen werden getrennt dokumentiert. |
| 07 | Konfiguration, Secrets und Rollout-Pfade | Konfigurationsquellen, Secret-Grenzen, Rollout, Rückfallpfade und Änderungsnachweise werden festgelegt. |
| 08 | Threat Model für Netzpfade und Missbrauchsfälle | STRIDE-orientierte Risiken, CAPEC-Bezüge, Missbrauchsfälle und Gegenmaßnahmen werden bewertet. |
| 09 | Sandbox-Integration und Betriebsnachweise | Sandbox-Bezug, Netzwerkgrenzen, Toolchain-Nachweise und abweichende Arbeitsweisen werden begründet. |
| 10 | Abschlussreview mit Vernetzungsrisiken und Übergabe | Vernetzungsrisiken, Evidenz, offene Punkte, Restrisiko und Übergabeempfehlung werden zusammengeführt. |

## Governance und Nachweise / Governance and Evidence

- Dieser Track nutzt `Secure CaseTracker` und `Secure CaseTracker v2` als fachliche Vorarbeit.
- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband und mitgeltende Dokumente werden als lokale Arbeitsgrundlage erwartet.
- Die acht Governance-Presets aus der zentralen Matrix sind Voraussetzung für spätere MSL-Level-2-Repos.
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert.
- Offene Punkte werden als `Open` mit Folgeaktion, Risiko und Priorität dokumentiert.

## Grenzen / Boundaries

- Diese Datei startet keinen Spec-Kit-Lauf.
- Einzelne Aufgaben-Lastenhefte werden später manuell mit `/speckit-specify` gestartet.
- Spec-Kit begleitet die Aufgaben, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.
- Es werden in diesem Schritt keine Level-1- oder Level-2-Repositories angelegt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
