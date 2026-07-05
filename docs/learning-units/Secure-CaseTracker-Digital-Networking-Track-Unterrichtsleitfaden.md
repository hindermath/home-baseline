# Secure CaseTracker Digital Networking Track Unterrichtsleitfaden / Secure CaseTracker Digital Networking Track Teaching Guide

**Stand / Date:** 2026-07-05

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung des DV - Digitale Vernetzung-Tracks im 3. Lehrjahr. Er legt Spezialisierung, erwartete Tiefe, typische Fehler und Nachweisanforderungen fest.

**EN:** This guide supports instructors when using the Digital Networking track in the third training year. It defines specialization, expected depth, common mistakes, and evidence needs.

## Didaktische Einordnung / Didactic Position

**DE:** Lernende arbeiten im 3. Lehrjahr stärker eigenständig. Im DV-Track geht es nicht nur um "Netz funktioniert", sondern um nachvollziehbare Systemgrenzen, sichere Kommunikation, Verfügbarkeit, Monitoring, Datenschutzgrenzen und begründete Restrisiken.

**EN:** In the third training year, learners work more independently. In the Digital Networking track, the goal is not merely "the network works" but traceable system boundaries, secure communication, availability, monitoring, privacy boundaries, and justified residual risks.

## Sandbox-Erwartung / Sandbox Expectation

**DE:** Ab dem 3. Lehrjahr wird erwartet, dass Lernende KI-gestützte Entwicklung in oder mit `absdd-image-sandbox` planen, nutzen oder begründet abgrenzen können. Für DV ist besonders wichtig, Netzwerkzugriffe, Mounts, Schreibgrenzen und Abweichungen von der Sandbox ausdrücklich zu dokumentieren.

**EN:** From year 3 onward, learners are expected to plan, use, or explicitly bound AI-assisted development in or with `absdd-image-sandbox`. For Digital Networking, network access, mounts, write boundaries, and deviations from the sandbox must be documented explicitly.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Lehrhinweis |
|---:|---|---|
| 01 | Vernetzungszielbild und Systemkontext | Erst Kontext und Nicht-Ziele klären, bevor technische Topologie entsteht. |
| 02 | Topologie, Schnittstellen und Kommunikationsflüsse | Richtungen, Protokolle und Datenklassen getrennt dokumentieren lassen. |
| 03 | Trust Boundaries und Segmentierung | Sichtbar machen, wo Vertrauen endet und welche Übergänge erlaubt sind. |
| 04 | Identitäten, Zugriff und Netzwerkrechte | Rollen, technische Konten und Least Privilege prüfen. |
| 05 | Verfügbarkeit, Resilienz und Fallbacks | Ausfälle, Timeouts und sichere Degradation konkret begründen. |
| 06 | Telemetrie, Monitoring und Datenschutzgrenzen | Monitoring darf nicht heimlich personenbezogene Daten sammeln. |
| 07 | Konfiguration, Secrets und Rollout-Pfade | Konfiguration als Sicherheitsoberfläche behandeln. |
| 08 | Threat Model für Netzpfade und Missbrauchsfälle | STRIDE und relevante CAPEC-Muster für die wichtigsten Pfade nutzen. |
| 09 | Sandbox-Integration und Betriebsnachweise | Sandbox-Nutzung oder Abweichung mit Evidenz dokumentieren. |
| 10 | Abschlussreview mit Vernetzungsrisiken und Übergabe | Ergebnisse, offene Risiken und Übergabeempfehlung zusammenführen. |

## Bewertung / Assessment

- Prüfe, ob die Arbeit klar zur Spezialisierung DV passt.
- Prüfe, ob Systemkontext, Schnittstellen und Trust Boundaries nachvollziehbar sind.
- Prüfe, ob Entscheidungen mit Alternativen, Trade-offs und Evidenz begründet werden.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob Spec-Kit als begleitende SDD-Struktur genutzt wird und nicht als Ersatz für das Berufsbild dargestellt wird.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
