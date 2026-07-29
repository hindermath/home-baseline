# Secure CaseTracker Unterrichtsleitfaden / Secure CaseTracker Teaching Guide

**Stand / Date:** 2026-07-05
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 1. Lehrjahr, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices from year 1 onward, trainers, reviewers, AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

> **Lernenden-Einstieg / Learner entry:** Fuehre neue Lernende zuerst durch
> [`START-HERE-FUER-LERNENDE.md`](START-HERE-FUER-LERNENDE.md). Unit 00 setzt den
> dort beschriebenen Fork-, Podman- und Preflight-Stand voraus.

## Zweck / Purpose

**DE:** Dieser Unterrichtsleitfaden erklärt, wie die Secure-CaseTracker-Lernreihe eingesetzt werden kann. Die Lastenhefte sind die späteren Spec-Kit-Intakes. Dieses Dokument ist die didaktische Begleitung: Es erklärt Reihenfolge, Lernlogik, typische Fehler, erwartete Nachweise und den Bezug zu den Fachrichtungen.

**EN:** This teaching guide explains how the Secure CaseTracker learning series can be used. The intake files are the later Spec Kit intakes. This document is the didactic companion: it explains order, learning logic, common mistakes, expected evidence, and the relation to the specializations.

## Didaktische Grundidee / Didactic Idea

**DE:** Lernende sollen nicht nur Code schreiben. Sie sollen verstehen, warum sichere Entwicklung aus vielen kleinen Entscheidungen besteht. Jede Entscheidung muss fachlich, technisch und sicherheitlich erklärbar sein. Deshalb beginnt die Reihe mit Auftrag und Scope, geht dann über Modell, Eingaben, Datenschutz, Rechte, Persistenz, Tests, Supply Chain und Sandbox bis zum Review.

**EN:** Learners should not only write code. They should understand that secure development consists of many small decisions. Each decision must be explainable from a functional, technical, and security perspective. The series therefore starts with task and scope, then moves through model, input, privacy, permissions, persistence, tests, supply chain, and sandboxing to the review.

## Reihenfolge und Lernlogik / Order and Learning Logic

| Schritt | Was gelernt wird | Warum diese Stelle |
|---:|---|---|
| 00 | Sprachrepo-Projekt-Scaffold | Ohne lauffähige Projekt-, Build-, Test- und Preset-Basis starten spätere Aufgaben unsauber; hier gilt das Container-First-Gate: KI-Agenten nur im Container starten (siehe `Secure-Trader-Sandbox-Preflight.md`). |
| 01 | Auftrag, Scope, Rollen, erste Datenschutzannahmen | Ohne klaren Auftrag werden Sicherheitsprüfungen beliebig. |
| 02 | Domänenmodell und Zustände | Ein sicheres Programm braucht ein klares fachliches Modell. |
| 03 | Eingabevalidierung und Trust Boundaries | Viele Sicherheitsfehler beginnen an ungeprüften Eingaben. |
| 04 | Datenschutz und Audit-Logging | Nachvollziehbarkeit darf nicht zu Datensammlung ohne Zweck werden. |
| 05 | Rollen und Berechtigungen | Sichere Defaults und Least Privilege müssen früh sichtbar sein. |
| 06 | Persistenz, Import und Export | Dateien und Datenbanken sind typische Fehler- und Datenabflussstellen. |
| 07 | Testbarkeit und Qualität | Sicherheit ohne Tests bleibt Behauptung. |
| 08 | Supply Chain und MSL-Bewertung | Speichersichere Sprachen helfen, ersetzen aber keine Lieferkettenprüfung. |
| 09 | Sandbox und agentische Entwicklung | KI-Agenten brauchen klare technische und organisatorische Grenzen; das Container-First-Gate aus Unit 00 wird hier zur vollständigen Sandbox-Profilierung vertieft. |
| 10 | Prozessanalyse und Kennzahlen | Kennzahlen brauchen Datenqualität, Datenschutz und Aussagegrenzen. |
| 11 | Spec-Kit-Review und Abschluss | Ergebnisse müssen prüfbar und kundenverständlich zusammengeführt werden. |
| 12 | Jahr-2-Baseline und Track-Ableitung | Jahr 3 soll aus einem belastbaren Jahr-2-Stand starten, nicht aus einem leeren Projekt. |

## Fachrichtungsnutzung / Use by Specialization

**DE:** Die Reihe kann gemeinsam unterrichtet werden. Je nach Klasse oder Lerngruppe können Aufgaben stärker gewichtet werden.

| Fachrichtung | Besonders wichtige Aufgaben | Begründung |
|---|---|---|
| Anwendungsentwicklung | 00, 01, 02, 03, 05, 06, 07, 11, 12 | Diese Aufgaben behandeln Projektbasis, Anforderungen, Modell, Validierung, Berechtigungen, Persistenz, Tests, Review und spätere Track-Ableitung. |
| Systemintegration | 00, 01, 07, 08, 09, 11, 12 | Diese Aufgaben behandeln reproduzierbare Umgebung, Toolchains, Supply Chain, Sandbox, Secrets, Nachweise und Baseline-Fähigkeit. |
| Daten- und Prozessanalyse | 00, 01, 02, 04, 06, 10, 11, 12 | Diese Aufgaben behandeln Projektbasis, Datenarten, Datenschutz, Datenqualität, Auswertung, Aussagegrenzen und spätere Track-Ableitung. |
| Digitale Vernetzung | 00, 01, 03, 08, 09, 11, 12 | Diese Aufgaben behandeln Projektbasis, Systemgrenzen, Trust Boundaries, Toolchain, Sandbox, Vernetzungsperspektive und spätere Track-Ableitung. |

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

## Sandbox und Container-First-Gate / Sandbox and Container-First Gate

**DE:** `absdd-image-sandbox` ist als öffentliches Referenz-Repo verfügbar: <https://github.com/hindermath/absdd-image-sandbox>. **Container-First-Gate:** Jeder KI-Agenten-Aufruf (z. B. Codex, Claude, Copilot, Gemini) erfolgt ab Unit 00 verbindlich im Container bzw. in der freigegebenen Sandbox — nie direkt auf dem Arbeitsplatz-Rechner der Auszubildenden. Diese Regel gilt, **bevor** der erste Agent gestartet wird; verbindliche Grundlage ist `Secure-Trader-Sandbox-Preflight.md`. Lernende sollen zusätzlich Grenzen für KI-Agenten, Secrets, Mounts und Netzwerk verstehen. Was über die Jahre wächst, ist die Tiefe der eigenen Sandbox-Profilierung (Mounts, Egress, Nachweise) — Unit 09 vertieft dies —, nicht die Frage, ob das Gate gilt.

**EN:** `absdd-image-sandbox` is available as a public reference repository: <https://github.com/hindermath/absdd-image-sandbox>. **Container-first gate:** every AI-agent invocation (e.g. Codex, Claude, Copilot, Gemini) runs inside the container or approved sandbox from unit 00 onward — never directly on the apprentice's workstation. This rule applies **before** the first agent is started; the binding basis is `Secure-Trader-Sandbox-Preflight.md`. Learners should additionally understand boundaries for AI agents, secrets, mounts, and networking. What grows over the years is the depth of your own sandbox profiling (mounts, egress, evidence) — unit 09 deepens this — not whether the gate applies.

**DE:** Die Grenze verläuft am Agenten-Aufruf: Lesen, Review und allgemeine Entwicklung **ohne Agenten** dürfen außerhalb der Sandbox erfolgen, zum Beispiel mit JetBrains IDEs, VS Code oder unter Windows mit Visual Studio. Sobald ein KI-Agent Dateien oder Befehle ausführt, geschieht das im Container.

**EN:** The boundary is the agent invocation: reading, review, and general development **without agents** may happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Visual Studio on Windows. As soon as an AI agent runs files or commands, it happens inside the container.

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
- **DE:** Einen KI-Agenten direkt auf dem Arbeitsplatz-Rechner starten statt im Container (Container-First-Gate ab Unit 00, siehe `Secure-Trader-Sandbox-Preflight.md`).
  **EN:** Starting an AI agent directly on the workstation instead of inside the container (container-first gate from unit 00, see `Secure-Trader-Sandbox-Preflight.md`).

## Vorschlag für Unterrichtsablauf / Suggested Teaching Flow

**DE:** Eine kompakte Variante kann pro Aufgabe eine Unterrichtseinheit nutzen. Eine vertiefte Variante kann jede Aufgabe in Analyse, Spec-Kit-Spezifikation, Planung, Testentwurf und Review aufteilen.

**EN:** A compact variant can use one lesson per task. A deeper variant can split each task into analysis, Spec Kit specification, planning, test design, and review.

| Variante | Umfang | Nutzung |
|---|---|---|
| Kompakt | 11 fachliche Einheiten plus `00` nach Bedarf | Orientierung, Grundlagen, erste Reviews |
| Standard | `00` bis `11` plus Reviewblöcke | vollständige Spec-Kit-Vorbereitung |
| Vertieft | Aufgaben je Sprache wiederholen | Vergleich von C#, Go, Java, Python, Rust und Swift |

## Durchführung mit Level 1 und Level 2 / Execution with Level 1 and Level 2

**DE:** Für die spätere praktische Durchführung wird ein privates Level-1-Workspace-Repo empfohlen. Es koordiniert die Reihe, enthält aber keine eigene Fachimplementierung. Die Implementierungen entstehen getrennt in sechs Level-2-Repos. So können Lernende sehen, dass dieselbe Aufgabe je Sprache andere Werkzeuge und Prüfungen braucht.

**EN:** A private Level 1 workspace repository is recommended for later practical execution. It coordinates the series but contains no functional implementation itself. The implementations are created separately in six Level 2 repositories. This helps learners see that the same task needs different tools and checks depending on the language.

| Ebene / Level | Aufgabe / Task | Lehrnutzen / Teaching value |
|---|---|---|
| Level 0 | Zentrale Quelle in `home-baseline-source` | gemeinsame Richtlinie, Checklisten, Presets und Intakes bleiben stabil |
| Level 1 | Koordination in `SecureCaseTrackerProjects` | Status, Reihenfolge, Links und Vergleich bleiben an einer Stelle sichtbar |
| Level 2 | Umsetzung in sechs Sprach-Repos | jede MSL-Sprache erhält eigene Spec-Kit-Artefakte, Tests und Nachweise |

**DE:** Die Spec-Kit-Läufe werden später pro Level-2-Repo manuell gestartet. C# ist als erster Referenzpfad vorgesehen. Danach können Go, Java, Python, Rust und Swift als Vergleichspfade folgen. Diese Reihenfolge hilft, zuerst eine gut verstandene Referenz zu erzeugen und anschließend Unterschiede zwischen Toolchains, Validierung, Dependency-Audits und Secure-Coding-Regeln sichtbar zu machen.

**EN:** The Spec Kit runs are started later and manually per Level 2 repository. C# is planned as the first reference path. Go, Java, Python, Rust, and Swift can follow as comparison paths. This order helps create a well-understood reference first and then makes differences between toolchains, validation, dependency audits, and secure-coding rules visible.

**DE:** Wichtig: Eine vorbereitete Struktur ist noch kein ausgeführter Spec-Kit-Lauf. Ein Level-2-Repo gilt erst dann als bearbeitet, wenn Lernende oder Lehrende dort bewusst ein konkretes Aufgaben-Lastenheft `00` bis `12` mit `/speckit-specify` gestartet und die entstehenden Artefakte geprüft haben. Neue oder leere Sprachrepos beginnen mit `00`; fachliche Jahr-1-Arbeit beginnt mit `01`; `12` gehört zur späteren Jahr-2-Baseline vor Jahr 3.

**EN:** Important: A prepared structure is not yet an executed Spec Kit run. A Level 2 repository counts as worked on only after learners or instructors deliberately start a concrete task intake `00` to `12` with `/speckit-specify` and review the resulting artifacts. New or empty language repositories start with `00`; functional year-1 work starts with `01`; `12` belongs to the later year-2 baseline before year 3.

**DE:** Spec-Kit-Läufe sind begleitende SDD-Aufgaben. Sie ersetzen nicht das klassische Erlernen des Berufsbildes, die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder Prüfungsvorbereitung.

**EN:** Spec Kit runs are companion SDD tasks. They do not replace learning the occupation, vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

## Rolle von Spec Kit / Role of Spec Kit

**DE:** Spec Kit ist in dieser Reihe nicht nur Werkzeug, sondern Lernstruktur. Lernende sehen, dass professionelle Entwicklung nicht direkt mit Code beginnt. Sie beginnt mit einer Spezifikation, geht über Plan und Aufgaben in Tests und Review. Die Governance-Presets sorgen dafür, dass Sicherheit, Architektur, Barrierefreiheit, Plattformen und Agentenregeln nicht vergessen werden.

**EN:** In this series, Spec Kit is not only a tool but a learning structure. Learners see that professional development does not start directly with code. It starts with a specification, then moves through plan and tasks into tests and review. The governance presets help ensure that security, architecture, accessibility, platforms, and agent rules are not forgotten.

## Rolle der sechs Zielsprachen / Role of the Six Target Languages

**DE:** C#, Go, Java, Python, Rust und Swift sind hier Zielsprachen, weil sie sich gut für MSL-orientierte Ausbildung eignen. Die Reihe bleibt sprachneutral: Die fachlichen Regeln sind gleich, die technische Umsetzung unterscheidet sich. Dadurch können Lernende erkennen, welche Sicherheitsentscheidungen sprachunabhängig sind und welche in einer Sprache besonders beachtet werden müssen.

**EN:** C#, Go, Java, Python, Rust, and Swift are target languages here because they work well for MSL-oriented training. The series remains language-neutral: the functional rules are the same, while technical implementation differs. This helps learners see which security decisions are language-independent and which need special attention in a language.

## Abschluss / Closure

**DE:** Am Ende sollen Lernende nicht nur ein mögliches Programm verstehen, sondern auch erklären können, welche Sicherheitsentscheidungen getroffen wurden, welche Nachweise vorliegen, welche Punkte `N/A` sind und welche Risiken offen bleiben.

**EN:** At the end, learners should not only understand a possible program. They should also be able to explain which security decisions were made, which evidence exists, which points are `N/A`, and which risks remain open.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
