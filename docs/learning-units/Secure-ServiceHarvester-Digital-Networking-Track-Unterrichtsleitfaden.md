# Secure ServiceHarvester Digital Networking Track Unterrichtsleitfaden / Secure ServiceHarvester Digital Networking Track Teaching Guide

**Stand / Date:** 2026-07-06

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung des DV - Digitale Vernetzung-Tracks der Familie Secure ServiceHarvester im 3. Lehrjahr. Er legt Spezialisierung, erwartete Tiefe, typische Fehler und Nachweisanforderungen für den vernetzten, plattformübergreifenden Sammel- und Worker-Dienst fest.

**EN:** This guide supports instructors when using the Digital Networking track of the Secure ServiceHarvester family in the third training year. It defines specialization, expected depth, common mistakes, and evidence needs for the networked, cross-platform collector and worker service.

## Didaktische Einordnung / Didactic Position

**DE:** Lernende arbeiten im 3. Lehrjahr stärker eigenständig. Im DV-Track geht es nicht nur um "Verbindung steht", sondern um nachvollziehbare Systemgrenzen, klare Vertrauenszonen, gesicherte Transportwege, verlässliche Verfügbarkeit und begründete Resilienzentscheidungen für das verteilte Sammeln. Der Track baut auf dem Stand `learning/year-2-complete` auf und bleibt sprachneutral; die C#-Referenz `InventarWorkerService` dient nur der Anschauung.

**EN:** In the third training year, learners work more independently. In the Digital Networking track, the goal is not merely "the connection is up" but traceable system boundaries, clear trust zones, secured transport paths, reliable availability, and justified resilience decisions for the distributed collection. The track builds on the `learning/year-2-complete` baseline and stays language-neutral; the C# reference `InventarWorkerService` serves only as illustration.

## Sandbox-Erwartung / Sandbox Expectation

**DE:** Ab dem 3. Lehrjahr wird erwartet, dass Lernende KI-gestützte Entwicklung in oder mit `absdd-image-sandbox` planen, nutzen oder begründet abgrenzen können. Das öffentliche Referenz-Repo ist <https://github.com/hindermath/absdd-image-sandbox>. Für DV ist besonders wichtig, Netzwerkzugriffe, Mounts, Schreibgrenzen und Abweichungen von der Sandbox ausdrücklich zu dokumentieren. Normale IDE-Arbeit, Lesen und Review dürfen weiterhin außerhalb der Sandbox stattfinden, zum Beispiel mit JetBrains IDEs, VS Code oder Windows-only Visual Studio.

**EN:** From year 3 onward, learners are expected to plan, use, or explicitly bound AI-assisted development in or with `absdd-image-sandbox`. The public reference repository is <https://github.com/hindermath/absdd-image-sandbox>. For Digital Networking, network access, mounts, write boundaries, and deviations from the sandbox must be documented explicitly. Normal IDE work, reading, and review may still happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Windows-only Visual Studio.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Lehrhinweis |
|---:|---|---|
| 01 | Track-Baseline und Netzzielbild | Erst Netzzielbild, Systemgrenzen und Nicht-Ziele klären, bevor Topologie entsteht. |
| 02 | Systemkontext und Maschinen-/Netzbezüge | Beteiligte Maschinen, Netze und Datenklassen sauber trennen lassen. |
| 03 | Schnittstellen und Kommunikationsflüsse | Richtungen, Protokolle und Datenklassen je Fluss getrennt dokumentieren. |
| 04 | Segmentierung und Vertrauenszonen | Sichtbar machen, wo Vertrauen endet und welche Übergänge erlaubt sind. |
| 05 | Transportsicherheit und Endpunkt-Authentifizierung | TLS-Defaults, Zertifikate und beidseitige Authentifizierung belegen. |
| 06 | Verfügbarkeit, Timeouts und Wiederholstrategien | Timeouts, Backoff und sichere Degradation konkret begründen. |
| 07 | Verteilte Sammlung und Agentenkommunikation | Agenten-Registrierung, Idempotenz und Nachrichtengrenzen prüfen. |
| 08 | Betriebs- und Netznachweise | Netzpfade, Metriken und Nachweise ohne Datenschutzverletzung planen. |
| 09 | Ausfallszenarien und Resilienz | Ausfälle durchspielen; Wiederanlauf und Grenzen dokumentieren. |
| 10 | Netz-Review, Trade-offs und Abschluss | Ergebnisse, offene Netzrisiken und Übergabeempfehlung zusammenführen. |

## Bewertung / Assessment

- Prüfe, ob die Arbeit klar zur Spezialisierung DV passt.
- Prüfe, ob Systemkontext, Schnittstellen, Kommunikationsflüsse und Vertrauenszonen nachvollziehbar sind.
- Prüfe, ob Vernetzungsentscheidungen mit Alternativen, Trade-offs und Evidenz begründet werden.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob MSL-Vorteile sichtbar werden, aber keine Secure-Coding-Prüfung ersetzen.
- Prüfe, ob Spec-Kit als begleitende SDD-Struktur genutzt wird und nicht als Ersatz für das Berufsbild dargestellt wird.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.
- Prüfe, ob KI-gestützte Schreibarbeit einen Sandbox-Bezug oder eine begründete Abweichung dokumentiert.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
