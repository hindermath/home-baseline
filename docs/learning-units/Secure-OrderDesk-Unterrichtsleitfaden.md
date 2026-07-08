# Secure OrderDesk Unterrichtsleitfaden / Secure OrderDesk Teaching Guide

**Stand / Date:** 2026-07-07
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Kundenfirma / Customer company:** Secure Trader – fiktive Handelsfirma / fictional trading company
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 1. Lehrjahr, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices from year 1 onward, trainers, reviewers, AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Zweck / Purpose

**DE:** Dieser Unterrichtsleitfaden erklärt, wie die Basis-Reihe (Jahr 1) der Familie Secure OrderDesk eingesetzt werden kann. EuFPA baut die Bestell- und Handelsplattform für die fiktive Kundenfirma Secure Trader. Die Lastenhefte sind die späteren Spec-Kit-Intakes. Dieses Dokument ist die didaktische Begleitung: Es erklärt Reihenfolge, Lernlogik, typische Fehler, erwartete Nachweise und den Bezug zu den Fachrichtungen. Der fachliche Kern ruht auf einer relationalen Bestelldomäne mit Kunden, Produkten, Bestellungen und Bestellpositionen auf Northwind-Datenbasis.

**EN:** This teaching guide explains how the base series (year 1) of the Secure OrderDesk family can be used. EuFPA builds the ordering and trading platform for the fictional customer company Secure Trader. The intake files are the later Spec Kit intakes. This document is the didactic companion: it explains order, learning logic, common mistakes, expected evidence, and the relation to the specializations. The functional core rests on a relational ordering domain with customers, products, orders, and order items on a Northwind data basis.

## Didaktische Grundidee / Didactic Idea

**DE:** Lernende sollen nicht nur Code schreiben. Sie sollen verstehen, warum sichere Entwicklung aus vielen kleinen Entscheidungen besteht und wie KI-Agenten und Spec Kit diese Entscheidungen strukturieren. Am Beispiel einer einfachen Bestell- und Handelsplattform beginnt die Reihe mit Kundenauftrag und Scope, geht über Domänenmodell, Eingaben, Datenschutz, Rechte, relationale Persistenz und SQL-Sicherheit, Tests, Supply Chain und Sandbox bis zu Auswertungen und zum Review. Die Plattform bleibt im 1. Lehrjahr bewusst einfach; der Pflicht-Datensatz `ALFKI` dient als durchgehendes, reproduzierbares Beispiel.

**EN:** Learners should not only write code. They should understand that secure development consists of many small decisions and how AI agents and Spec Kit structure those decisions. Using a simple ordering and trading platform as an example, the series starts with customer order and scope, then moves through domain model, input, privacy, permissions, relational persistence and SQL security, tests, supply chain, and sandboxing to reporting and the review. The platform stays deliberately simple in year 1; the mandatory record `ALFKI` serves as a continuous, reproducible example.

## Reihenfolge und Lernlogik / Order and Learning Logic

| Schritt | Was gelernt wird | Warum diese Stelle |
|---:|---|---|
| 00 | Sprachrepo-Projekt-Scaffold | Ohne lauffähige Projekt-, Build-, Test- und Preset-Basis starten spätere Aufgaben unsauber; hier gilt das Container-First-Gate: KI-Agenten nur im Container starten (siehe `Secure-Trader-Sandbox-Preflight.md`). |
| 01 | Kundenauftrag, Scope und Handelsdomäne | Ohne klaren Auftrag von Secure Trader werden Sicherheitsprüfungen beliebig. |
| 02 | Domänenmodell: Kunden, Produkte, Bestellungen und Positionen | Eine sichere Plattform braucht ein klares relationales Fachmodell. |
| 03 | Eingabevalidierung und Trust Boundaries | Viele Sicherheitsfehler beginnen an ungeprüften Bestell- und Kundendaten-Eingaben. |
| 04 | Datenschutz und Audit-Logging | Nachvollziehbarkeit darf nicht zu Sammlung von Kundendaten ohne Zweck werden. |
| 05 | Rollen und Berechtigungen | Sichere Defaults und Least Privilege müssen früh sichtbar sein. |
| 06 | Persistenz, SQL und sichere Datenzugriffe | Relationale Zugriffe sind typische Stelle für SQL-Injection und Datenabfluss. |
| 07 | Testbarkeit und Qualität | Sicherheit ohne Tests bleibt Behauptung. |
| 08 | Lieferanten, Supply Chain und MSL-Bewertung | Speichersichere Sprachen helfen, ersetzen aber keine Lieferkettenprüfung. |
| 09 | Sandbox und agentische Entwicklung | KI-Agenten brauchen klare technische und organisatorische Grenzen; das Container-First-Gate aus Unit 00 wird hier zur vollständigen Sandbox-Profilierung vertieft. |
| 10 | Auswertungen und Kennzahlen | Reporting und Kennzahlen brauchen Datenqualität, Datenschutz und Aussagegrenzen. |
| 11 | Spec-Kit-Review und Abschluss | Ergebnisse müssen prüfbar und kundenverständlich zusammengeführt werden. |
| 12 | Jahr-2-Baseline und Track-Ableitung | Jahr 3 soll aus einem belastbaren Jahr-2-Stand starten, nicht aus einem leeren Projekt. |

## Fachrichtungsnutzung / Use by Specialization

**DE:** Die Reihe kann gemeinsam unterrichtet werden. Je nach Klasse oder Lerngruppe können Aufgaben stärker gewichtet werden.

| Fachrichtung | Besonders wichtige Aufgaben | Begründung |
|---|---|---|
| Anwendungsentwicklung | 00, 01, 02, 03, 05, 06, 07, 11, 12 | Projektbasis, Anforderungen, Domänenmodell, Validierung, Berechtigungen, relationale Persistenz, Tests, Review und spätere Track-Ableitung. |
| Systemintegration | 00, 01, 07, 08, 09, 10, 11, 12 | Reproduzierbare Umgebung, Toolchains, Supply Chain, Sandbox, Secrets, Auswertungssicht, Nachweise und Baseline-Fähigkeit. |
| Daten- und Prozessanalyse | 00, 01, 02, 04, 06, 10, 11, 12 | Projektbasis, Datenarten, Datenschutz, relationale Datenqualität, Kennzahlen, Aussagegrenzen und spätere Track-Ableitung. |
| Digitale Vernetzung | 00, 01, 03, 08, 09, 10, 11, 12 | Projektbasis, Systemgrenzen, Trust Boundaries, Toolchain, Sandbox, Betriebs-/Vernetzungsperspektive und spätere Track-Ableitung. |

**EN:** The series can be taught jointly. Depending on the class or learner group, tasks can be weighted differently.

## Erwartete Nachweise / Expected Evidence

**DE:** Jede Aufgabe erzeugt kleine, prüfbare Nachweise. Die Nachweise müssen nicht perfekt sein, aber sie müssen ehrlich sein. Ein sauber begründetes `N/A` ist besser als ein still ausgelassener Prüfpunkt. Ein sichtbares `Open` ist besser als ein verstecktes Risiko.

**EN:** Each task produces small, reviewable evidence. The evidence does not need to be perfect, but it must be honest. A clearly justified `N/A` is better than a silently skipped checkpoint. A visible `Open` is better than a hidden risk.

| Nachweistyp | Beispiel |
|---|---|
| Fachlicher Nachweis | Scope-Liste, Domänenmodell (Kunden, Produkte, Bestellungen, Positionen), Rollenmatrix, Kennzahlenkatalog |
| Sicherheitsnachweis | Trust-Boundary-Liste, negative Tests, parametrisierte Queries, Abhängigkeitsprüfung |
| Datenschutznachweis | Datenarten der Kundendaten, Zweck, Minimierung, Audit-Log-Regeln |
| Spec-Kit-Nachweis | `spec.md`, `plan.md`, `tasks.md`, Checkliste, Review-Ergebnis |
| Sandbox-Nachweis | Mount-Liste, Secret-Regel, Netzwerkentscheidung, Toolchain-Status |

## Typische Fehler / Common Mistakes

- **DE:** Zu früh implementieren, bevor Scope und Datenarten der Handelsdomäne klar sind.
  **EN:** Implementing too early before scope and data types of the trading domain are clear.
- **DE:** Die Plattform im 1. Lehrjahr technisch überfrachten (Hosting, Multi-DB, API), statt sie einfach zu halten.
  **EN:** Overloading the year-1 platform technically (hosting, multi-DB, API) instead of keeping it simple.
- **DE:** Bestell- und Kundendaten als vertrauenswürdig behandeln und SQL dynamisch zusammensetzen.
  **EN:** Treating order and customer data as trustworthy and building SQL dynamically.
- **DE:** Tests nur für Erfolgspfade planen.
  **EN:** Planning tests only for success paths.
- **DE:** KI-Agenten ohne Schreibgrenzen, Sandbox-Regeln oder Review nutzen.
  **EN:** Using AI agents without write boundaries, sandbox rules, or review.
- **DE:** Einen KI-Agenten direkt auf dem Arbeitsplatz-Rechner starten statt im Container (Container-First-Gate ab Unit 00, siehe `Secure-Trader-Sandbox-Preflight.md`).
  **EN:** Starting an AI agent directly on the workstation instead of inside the container (container-first gate from unit 00, see `Secure-Trader-Sandbox-Preflight.md`).

## Durchführung mit Level 1 und Level 2 / Execution with Level 1 and Level 2

**DE:** Für die spätere praktische Durchführung wird ein privates Level-1-Workspace-Repo `SecureOrderDeskProjects` empfohlen. Es koordiniert die Reihe, enthält aber keine eigene Fachimplementierung. Die Implementierungen entstehen getrennt in sechs Level-2-Repos. Die Spec-Kit-Läufe werden später pro Level-2-Repo manuell gestartet; C# ist als erster Referenzpfad vorgesehen, danach folgen Go, Java, Python, Rust und Swift als Vergleichspfade.

**EN:** A private Level 1 workspace repository `SecureOrderDeskProjects` is recommended for later practical execution. It coordinates the series but contains no functional implementation itself. The implementations are created separately in six Level 2 repositories. The Spec Kit runs are started later and manually per Level 2 repository; C# is planned as the first reference path, followed by Go, Java, Python, Rust, and Swift as comparison paths.

**DE:** Wichtig: Eine vorbereitete Struktur ist noch kein ausgeführter Spec-Kit-Lauf. Neue oder leere Sprachrepos beginnen mit `00`; fachliche Jahr-1-Arbeit beginnt mit `01`; `12` gehört zur späteren Jahr-2-Baseline vor Jahr 3. Spec-Kit-Läufe sind begleitende SDD-Aufgaben. Sie ersetzen nicht das klassische Erlernen des Berufsbildes, die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder Prüfungsvorbereitung.

**EN:** Important: A prepared structure is not yet an executed Spec Kit run. New or empty language repositories start with `00`; functional year-1 work starts with `01`; `12` belongs to the later year-2 baseline before year 3. Spec Kit runs are companion SDD tasks. They do not replace learning the occupation, vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

## Rolle von Spec Kit und agentischer KI / Role of Spec Kit and Agentic AI

**DE:** Spec Kit ist in dieser Familie nicht nur Werkzeug, sondern Lernstruktur. Lernende sehen, dass professionelle Entwicklung nicht direkt mit Code beginnt, sondern mit einer Spezifikation, über Plan und Aufgaben in Tests und Review. Der durchgehende Faden vom 1. bis 3. Lehrjahr ist das verantwortliche Arbeiten mit KI-Agenten: Aufgaben klar fassen, Grenzen setzen, Ergebnisse prüfen und Nachweise führen. Die Governance-Presets sorgen dafür, dass Sicherheit, Architektur, Barrierefreiheit, Plattformen und Agentenregeln nicht vergessen werden.

**EN:** In this family, Spec Kit is not only a tool but a learning structure. Learners see that professional development does not start directly with code but with a specification, moving through plan and tasks into tests and review. The continuous thread from year 1 to year 3 is responsible work with AI agents: framing tasks clearly, setting boundaries, reviewing results, and keeping evidence. The governance presets help ensure that security, architecture, accessibility, platforms, and agent rules are not forgotten.

## Abschluss / Closure

**DE:** Am Ende sollen Lernende nicht nur eine mögliche Bestellplattform verstehen, sondern auch erklären können, welche Sicherheitsentscheidungen getroffen wurden, welche Nachweise vorliegen, welche Punkte `N/A` sind und welche Risiken offen bleiben.

**EN:** At the end, learners should not only understand a possible ordering platform. They should also be able to explain which security decisions were made, which evidence exists, which points are `N/A`, and which risks remain open.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Reihe selbst ist in der [Secure-OrderDesk-Lernreihe](Secure-OrderDesk-Lernreihe.md) beschrieben. Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Der Northwind-Datensatz ist ein historisch von Microsoft stammender Beispieldatensatz und wird hier nur als fachneutrale Datenbasis genutzt. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The series itself is described in the [Secure OrderDesk learning series](Secure-OrderDesk-Lernreihe.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. The Northwind data set is a historical sample data set originally from Microsoft and is used here only as a domain-neutral data basis. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
