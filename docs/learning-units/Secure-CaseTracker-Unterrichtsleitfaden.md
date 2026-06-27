# Secure CaseTracker Unterrichtsleitfaden / Secure CaseTracker Teaching Guide

**Stand / Date:** 2026-06-27
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 1. Lehrjahr, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices from year 1 onward, trainers, reviewers, AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Zweck / Purpose

**DE:** Dieser Unterrichtsleitfaden erklärt, wie die Secure-CaseTracker-Lernreihe eingesetzt werden kann. Die Lastenhefte sind die späteren Spec-Kit-Intakes. Dieses Dokument ist die didaktische Begleitung: Es erklärt Reihenfolge, Lernlogik, typische Fehler, erwartete Nachweise und den Bezug zu den Fachrichtungen.

**EN:** This teaching guide explains how the Secure CaseTracker learning series can be used. The intake files are the later Spec Kit intakes. This document is the didactic companion: it explains order, learning logic, common mistakes, expected evidence, and the relation to the specializations.

## Didaktische Grundidee / Didactic Idea

**DE:** Lernende sollen nicht nur Code schreiben. Sie sollen verstehen, warum sichere Entwicklung aus vielen kleinen Entscheidungen besteht. Jede Entscheidung muss fachlich, technisch und sicherheitlich erklärbar sein. Deshalb beginnt die Reihe mit Auftrag und Scope, geht dann über Modell, Eingaben, Datenschutz, Rechte, Persistenz, Tests, Supply Chain und Sandbox bis zum Review.

**EN:** Learners should not only write code. They should understand that secure development consists of many small decisions. Each decision must be explainable from a functional, technical, and security perspective. The series therefore starts with task and scope, then moves through model, input, privacy, permissions, persistence, tests, supply chain, and sandboxing to the review.

## Reihenfolge und Lernlogik / Order and Learning Logic

| Schritt | Was gelernt wird | Warum diese Stelle |
|---:|---|---|
| 01 | Auftrag, Scope, Rollen, erste Datenschutzannahmen | Ohne klaren Auftrag werden Sicherheitsprüfungen beliebig. |
| 02 | Domänenmodell und Zustände | Ein sicheres Programm braucht ein klares fachliches Modell. |
| 03 | Eingabevalidierung und Trust Boundaries | Viele Sicherheitsfehler beginnen an ungeprüften Eingaben. |
| 04 | Datenschutz und Audit-Logging | Nachvollziehbarkeit darf nicht zu Datensammlung ohne Zweck werden. |
| 05 | Rollen und Berechtigungen | Sichere Defaults und Least Privilege müssen früh sichtbar sein. |
| 06 | Persistenz, Import und Export | Dateien und Datenbanken sind typische Fehler- und Datenabflussstellen. |
| 07 | Testbarkeit und Qualität | Sicherheit ohne Tests bleibt Behauptung. |
| 08 | Supply Chain und MSL-Bewertung | Speichersichere Sprachen helfen, ersetzen aber keine Lieferkettenprüfung. |
| 09 | Sandbox und agentische Entwicklung | KI-Agenten brauchen klare technische und organisatorische Grenzen. |
| 10 | Prozessanalyse und Kennzahlen | Kennzahlen brauchen Datenqualität, Datenschutz und Aussagegrenzen. |
| 11 | Spec-Kit-Review und Abschluss | Ergebnisse müssen prüfbar und kundenverständlich zusammengeführt werden. |

## Fachrichtungsnutzung / Use by Specialization

**DE:** Die Reihe kann gemeinsam unterrichtet werden. Je nach Klasse oder Lerngruppe können Aufgaben stärker gewichtet werden.

| Fachrichtung | Besonders wichtige Aufgaben | Begründung |
|---|---|---|
| Anwendungsentwicklung | 01, 02, 03, 05, 06, 07, 11 | Diese Aufgaben behandeln Anforderungen, Modell, Validierung, Berechtigungen, Persistenz, Tests und Review. |
| Systemintegration | 01, 07, 08, 09, 11 | Diese Aufgaben behandeln reproduzierbare Umgebung, Toolchains, Supply Chain, Sandbox, Secrets und Nachweise. |
| Daten- und Prozessanalyse | 01, 02, 04, 06, 10, 11 | Diese Aufgaben behandeln Datenarten, Datenschutz, Datenqualität, Auswertung und Aussagegrenzen. |

**EN:** The series can be taught jointly. Depending on the class or learner group, tasks can be weighted differently.

## Erwartete Nachweise / Expected Evidence

**DE:** Jede Aufgabe erzeugt kleine, prüfbare Nachweise. Die Nachweise müssen nicht perfekt sein, aber sie müssen ehrlich sein. Ein sauber begründetes `N/A` ist besser als ein still ausgelassener Prüfpunkt. Ein sichtbares `Open` ist besser als ein verstecktes Risiko.

**EN:** Each task produces small, reviewable evidence. The evidence does not need to be perfect, but it must be honest. A clearly justified `N/A` is better than a silently skipped checkpoint. A visible `Open` is better than a hidden risk.

| Nachweistyp | Beispiel |
|---|---|
| Fachlicher Nachweis | Scope-Liste, Modell, Rollenmatrix, Kennzahlenkatalog |
| Sicherheitsnachweis | Trust-Boundary-Liste, negative Tests, Abhängigkeitsprüfung |
| Datenschutznachweis | Datenarten, Zweck, Minimierung, Audit-Log-Regeln |
| Spec-Kit-Nachweis | `spec.md`, `plan.md`, `tasks.md`, Checkliste, Review-Ergebnis |
| Sandbox-Nachweis | Mount-Liste, Secret-Regel, Netzwerkentscheidung, Toolchain-Status |

## Typische Fehler / Common Mistakes

- **DE:** Zu früh implementieren, bevor Scope und Datenarten klar sind.
  **EN:** Implementing too early before scope and data types are clear.
- **DE:** MSL als vollständige Sicherheitsgarantie missverstehen.
  **EN:** Misunderstanding MSL as a complete security guarantee.
- **DE:** Datenschutz nur als juristischen Zusatz betrachten.
  **EN:** Treating privacy only as a legal add-on.
- **DE:** Tests nur für Erfolgspfade planen.
  **EN:** Planning tests only for success paths.
- **DE:** KI-Agenten ohne Schreibgrenzen, Sandbox-Regeln oder Review nutzen.
  **EN:** Using AI agents without write boundaries, sandbox rules, or review.

## Vorschlag für Unterrichtsablauf / Suggested Teaching Flow

**DE:** Eine kompakte Variante kann pro Aufgabe eine Unterrichtseinheit nutzen. Eine vertiefte Variante kann jede Aufgabe in Analyse, Spec-Kit-Spezifikation, Planung, Testentwurf und Review aufteilen.

**EN:** A compact variant can use one lesson per task. A deeper variant can split each task into analysis, Spec Kit specification, planning, test design, and review.

| Variante | Umfang | Nutzung |
|---|---|---|
| Kompakt | 11 Einheiten | Orientierung, Grundlagen, erste Reviews |
| Standard | 11 Aufgaben plus Reviewblöcke | vollständige Spec-Kit-Vorbereitung |
| Vertieft | Aufgaben je Sprache wiederholen | Vergleich von C#, Go, Java, Python, Rust und Swift |

## Rolle von Spec Kit / Role of Spec Kit

**DE:** Spec Kit ist in dieser Reihe nicht nur Werkzeug, sondern Lernstruktur. Lernende sehen, dass professionelle Entwicklung nicht direkt mit Code beginnt. Sie beginnt mit einer Spezifikation, geht über Plan und Aufgaben in Tests und Review. Die Governance-Presets sorgen dafür, dass Sicherheit, Architektur, Barrierefreiheit, Plattformen und Agentenregeln nicht vergessen werden.

**EN:** In this series, Spec Kit is not only a tool but a learning structure. Learners see that professional development does not start directly with code. It starts with a specification, then moves through plan and tasks into tests and review. The governance presets help ensure that security, architecture, accessibility, platforms, and agent rules are not forgotten.

## Rolle der sechs Zielsprachen / Role of the Six Target Languages

**DE:** C#, Go, Java, Python, Rust und Swift sind hier Zielsprachen, weil sie sich gut für MSL-orientierte Ausbildung eignen. Die Reihe bleibt sprachneutral: Die fachlichen Regeln sind gleich, die technische Umsetzung unterscheidet sich. Dadurch können Lernende erkennen, welche Sicherheitsentscheidungen sprachunabhängig sind und welche in einer Sprache besonders beachtet werden müssen.

**EN:** C#, Go, Java, Python, Rust, and Swift are target languages here because they work well for MSL-oriented training. The series remains language-neutral: the functional rules are the same, while technical implementation differs. This helps learners see which security decisions are language-independent and which need special attention in a language.

## Abschluss / Closure

**DE:** Am Ende sollen Lernende nicht nur ein mögliches Programm verstehen, sondern auch erklären können, welche Sicherheitsentscheidungen getroffen wurden, welche Nachweise vorliegen, welche Punkte `N/A` sind und welche Risiken offen bleiben.

**EN:** At the end, learners should not only understand a possible program. They should also be able to explain which security decisions were made, which evidence exists, which points are `N/A`, and which risks remain open.
