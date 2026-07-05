# Secure CaseTracker v2 Unterrichtsleitfaden / Secure CaseTracker v2 Service Edition Teaching Guide

**Stand / Date:** 2026-07-05

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung der Lernreihe ab dem 2. Lehrjahr. Er erklärt Reihenfolge, didaktische Tiefe, Fachrichtungsbezug, typische Fehler und erwartete Nachweise.

**EN:** This guide supports instructors when using the learning series from the second training year onward. It explains order, depth, specialization fit, common mistakes, and expected evidence.

## Didaktische Einordnung / Didactic Position

**DE:** Lernende sollen nicht nur Funktionen beschreiben. Sie sollen Architekturentscheidungen begründen, Varianten vergleichen, Tests planen, Betriebsannahmen dokumentieren und Sicherheitsnachweise auditfähig ablegen. Die Aufgaben bleiben geführt, lassen aber mehr Eigenentscheidung zu als die Reihe ab dem 1. Lehrjahr.

**EN:** Learners should not only describe functions. They should justify architecture decisions, compare variants, plan tests, document operation assumptions, and store security evidence in an audit-ready way.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Fachrichtungsbezug | Lehrhinweis |
|---:|---|---|---|
| 01 | Architekturzielbild und Systemgrenzen | AE, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 02 | Persistenzmodell und Migrationen | AE, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 03 | API- und Service-Vertrag | AE, SI, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 04 | Fehler-, Validierungs- und Response-Modell | AE | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 05 | Rollen- und Autorisierungsmatrix | AE, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 06 | Audit-Logging und Datenschutz | SI, DPA, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 07 | Import- und Export-Härtung | AE, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 08 | Teststrategie und CI-Nachweise | AE, SI, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 09 | Sandbox- und Betriebsnachweise | SI, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 10 | MSL-Vergleich und Abschlussreview | AE, SI, DPA, DV | Entscheidung, Nachweis und Reflexion sichtbar machen. |

## Bewertung / Assessment

- Prüfe, ob Entscheidungen begründet und nicht nur behauptet werden.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob Nachweise konkrete Pfade, Tests, Dokumente oder Spec-Kit-Artefakte nennen.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.
- Prüfe, ob MSL-Vorteile sichtbar werden, ohne sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung zu ersetzen.
- Prüfe, ob Sandbox-Nutzung im 2. Lehrjahr als Betriebs- und Nachweiskonzept vorbereitet und nicht unreflektiert als Pflicht behauptet wird.

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
