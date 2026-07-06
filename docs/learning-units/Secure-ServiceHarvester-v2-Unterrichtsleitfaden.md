# Secure ServiceHarvester v2 Unterrichtsleitfaden / Secure ServiceHarvester v2 Service Edition Teaching Guide

**Stand / Date:** 2026-07-06

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung der Lernreihe ab dem 2. Lehrjahr. Er erklärt Reihenfolge, didaktische Tiefe, Fachrichtungsbezug, typische Fehler und erwartete Nachweise. Die Reihenübersicht steht in [`Secure-ServiceHarvester-v2-Lernreihe.md`](Secure-ServiceHarvester-v2-Lernreihe.md), die Gesamtlandkarte im [Master-Lastenheft](Lastenheft_Secure-ServiceHarvester-v2-Lernreihe.md).

**EN:** This guide supports instructors when using the learning series from the second training year onward. It explains order, depth, specialization fit, common mistakes, and expected evidence. The series overview lives in [`Secure-ServiceHarvester-v2-Lernreihe.md`](Secure-ServiceHarvester-v2-Lernreihe.md), the overview map in the [master intake](Lastenheft_Secure-ServiceHarvester-v2-Lernreihe.md).

## Didaktische Einordnung / Didactic Position

**DE:** Lernende sollen nicht nur Funktionen beschreiben. Sie sollen Architekturentscheidungen begründen, Backend-Varianten vergleichen, Import-Härtung planen, Betriebsannahmen dokumentieren und Sicherheitsnachweise auditfähig ablegen. Die Aufgaben bleiben geführt, lassen aber mehr Eigenentscheidung zu als die Reihe ab dem 1. Lehrjahr. Als C#-Referenz für einen langlaufenden Dienst dient `InventarWorkerService`.

**EN:** Learners should not only describe functions. They should justify architecture decisions, compare backend variants, plan import hardening, document operation assumptions, and store security evidence in an audit-ready way. The tasks stay guided but allow more independent decisions than the first-year series. The C# reference for a long-running service is `InventarWorkerService`.

## Lernlogik / Learning Logic

**DE:** Die Reihe geht vom Groben zum Feinen: Zuerst werden Systemgrenzen und Hosting geklärt, dann die Datenschicht abstrahiert und der Harvester gehärtet. Darauf folgen der äußere Vertrag (API, Fehler-/Response-Modell) und die Querschnittsthemen Autorisierung, Audit-Logging und Betrieb. Sichere Konfiguration und der MSL-Vergleich schließen die Reihe ab. Jede Einheit baut auf den Nachweisen der vorigen auf.

**EN:** The series moves from coarse to fine: first system boundaries and hosting, then the data layer abstraction and harvester hardening. The outer contract (API, error/response model) and the cross-cutting topics of authorization, audit logging, and operation follow. Secure configuration and the MSL comparison close the series. Each unit builds on the evidence of the previous one.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Fachrichtungsbezug | Lehrhinweis |
|---:|---|---|---|
| 01 | Architekturzielbild und Systemgrenzen | AE, SI, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 02 | Plattformübergreifendes Dienst-Hosting und Lebenszyklus | SI, DV, AE | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 03 | Persistenzmodell und Backend-Abstraktion | AE, SI, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 04 | Harvester: Zeitplanung, Idempotenz und Import-Härtung | AE, DPA, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 05 | API- und Service-Vertrag und OpenAPI | AE, DV, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 06 | Fehler-, Validierungs- und Response-Modell | AE, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 07 | Rollen-, Autorisierung und Audit-Logging | SI, AE, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 08 | Betrieb, Logging, Health und Monitoring | SI, DV, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 09 | Sichere Konfiguration, Secrets und Betriebsnachweise | SI, AE | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 10 | MSL-Vergleich und Abschlussreview | AE, SI, DPA, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |

## Fachrichtungsnutzung / Specialization Use

**DE:** AE-Lernende führen bei Architektur, Backend-Abstraktion, API-Vertrag und Fehler-/Response-Modell. SI-Lernende führen bei Dienst-Hosting, Konfiguration, Secrets, Logging, Health und Monitoring. DPA-Lernende führen bei Datenqualität im Harvester, Kennzahlen und Aussagegrenzen. DV-Lernende führen bei Systemgrenzen, Schnittstellen, Kommunikationsflüssen und Verfügbarkeit. Gemischte Gruppen tauschen bewusst die Führungsrolle je Einheit.

**EN:** Application Development learners lead on architecture, backend abstraction, API contract, and error/response model. System Integration learners lead on service hosting, configuration, secrets, logging, health, and monitoring. Data and Process Analysis learners lead on harvester data quality, metrics, and limits of interpretation. Digital Networking learners lead on system boundaries, interfaces, communication flows, and availability. Mixed groups deliberately rotate the lead role per unit.

## Typische Fehler / Common Mistakes

**DE:**

- Der Worker, der Harvester und die Ablage werden vermischt, statt sie als getrennte Systemgrenzen zu behandeln.
- Persistenz wird direkt gegen eine konkrete Datenbank programmiert, ohne austauschbare Abstraktion.
- Der Import ist nicht idempotent: doppelte Läufe erzeugen doppelte oder inkonsistente Datensätze.
- Fehlerantworten geben interne Details preis (Stack-Traces, Pfade, Verbindungszeichenketten).
- Secrets landen in Konfigurationsdateien oder Logs statt im plattformgeeigneten Secret-Store.
- MSL-Vorteile werden behauptet, ersetzen aber die Prüfung von API, I/O, Auth, Crypto, Logging und Dependencies nicht.

**EN:**

- Worker, harvester, and store are mixed instead of treated as separate system boundaries.
- Persistence is coded directly against a concrete database without a replaceable abstraction.
- The import is not idempotent: repeated runs create duplicate or inconsistent records.
- Error responses leak internal details (stack traces, paths, connection strings).
- Secrets end up in configuration files or logs instead of a platform-appropriate secret store.
- MSL benefits are claimed but do not replace review of API, I/O, auth, crypto, logging, and dependencies.

## Erwartete Nachweise / Expected Evidence

- Entscheidungen sind begründet und nicht nur behauptet.
- `Applicable`, `N/A` und `Open` werden konsequent genutzt.
- Nachweise nennen konkrete Pfade, Tests, Dokumente oder Spec-Kit-Artefakte.
- Die Sprache bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich.
- MSL-Vorteile werden sichtbar, ohne sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung zu ersetzen.
- Sandbox-Nutzung wird im 2. Lehrjahr als Betriebs- und Nachweiskonzept vorbereitet und nicht unreflektiert als Pflicht behauptet.

## Sandbox im 2. Lehrjahr / Sandbox in Year 2

**DE:** `absdd-image-sandbox` ist öffentlich verfügbar unter <https://github.com/hindermath/absdd-image-sandbox>. Im 2. Lehrjahr wird die Sandbox als Betriebs-, Toolchain- und Evidenzkonzept vorbereitet. Praktische Nutzung ist möglich, aber nicht zwingend, wenn die Lerngruppe die nötigen Technologien noch nicht sicher beherrscht.

**EN:** `absdd-image-sandbox` is publicly available at <https://github.com/hindermath/absdd-image-sandbox>. In year 2, the sandbox is prepared as an operational, toolchain, and evidence concept. Practical use is possible but not mandatory if the learner group does not yet handle the required technologies confidently.

**DE:** JetBrains IDEs, VS Code und Windows-only Visual Studio bleiben zulässige Arbeitswerkzeuge außerhalb der Sandbox. KI-gestützte Schreibarbeit wird jedoch so vorbereitet, dass ab Jahr 3 eine sichere Sandbox-Nutzung erwartet werden kann.

**EN:** JetBrains IDEs, VS Code, and Windows-only Visual Studio remain valid work tools outside the sandbox. AI-assisted write work is prepared so that secure sandbox use can be expected from year 3 onward.

## Grenzen / Boundaries

**DE:** Der Leitfaden ist kein Spec-Kit-Intake. Die späteren Spec-Kit-Läufe werden manuell pro Aufgaben-Lastenheft und pro späterem Level-2-Repo gestartet.

**EN:** This guide is not a Spec Kit intake. Later Spec Kit runs are started manually per task intake and per later level-2 repository.

**DE:** Spec-Kit-Läufe begleiten die Aufgaben. Sie ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** Spec Kit runs accompany the tasks. They do not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
