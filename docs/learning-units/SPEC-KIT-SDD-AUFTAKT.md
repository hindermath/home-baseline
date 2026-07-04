# Spec-Kit-SDD-Auftakt / Spec Kit SDD Kickoff

**Stand / Date:** 2026-07-05
**Zielgruppe / Audience:** Lernende, Lehrende, Reviewer und KI-Agenten / learners, instructors, reviewers, and AI agents

## Zweck / Purpose

**DE:** Dieses Handout erklärt den Einstieg in Spec-Driven Development (SDD) mit Spec Kit für die Lernreihen. Es ist bewusst neutral formuliert und enthält keine organisationsspezifischen Workshop-Bezüge.

**EN:** This handout explains the entry point into Spec-Driven Development (SDD) with Spec Kit for the learning series. It is intentionally neutral and contains no organization-specific workshop references.

## Grundidee / Core Idea

**DE:** SDD bedeutet: erst beschreiben, dann planen, dann umsetzen. Spec Kit hilft dabei, Anforderungen, offene Fragen, technische Planung, Aufgaben, Konsistenzanalyse und Umsetzung nachvollziehbar zu trennen.

**EN:** SDD means: describe first, then plan, then implement. Spec Kit helps separate requirements, open questions, technical planning, tasks, consistency analysis, and implementation.

## Rolle in der Ausbildung / Role in Training

- Spec Kit begleitet Lernaufgaben als Struktur für Analyse, Planung, Nachweise und Review.
- Spec Kit ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.
- Lehrende entscheiden, welche Aufgaben in welcher Tiefe genutzt werden.
- Lernende lesen die erzeugten Artefakte und übernehmen Verantwortung für Entscheidungen.

## Typischer Ablauf / Typical Flow

| Schritt | Zweck | Ergebnis |
|---|---|---|
| Constitution | langlebige Projektprinzipien festhalten | `.specify/memory/constitution.md` |
| Specify | Aufgaben-Lastenheft in eine Feature-Spezifikation übersetzen | `spec.md` |
| Clarify | wichtige offene Entscheidungen klären | aktualisierte `spec.md` |
| Plan | technische Umsetzung und Nachweise planen | `plan.md`, Research, Data Model, Verträge |
| Tasks | Arbeit in prüfbare Schritte zerlegen | `tasks.md` |
| Analyze | Spec, Plan und Tasks auf Lücken prüfen | Findings ohne Codeänderung |
| Implement | geplante Tasks umsetzen | Code, Tests, Doku, erledigte Tasks |

## Arbeitsregeln / Working Rules

- Master-Lastenhefte sind Gesamtlandkarten und werden nicht als Sammellauf gestartet.
- Einzelne Aufgaben-Lastenhefte werden bewusst mit `/speckit-specify` gestartet.
- Nach jedem Lauf werden Artefakte gelesen, verstanden und versioniert.
- `Applicable`, `N/A` und `Open` werden ehrlich dokumentiert.
- Sicherheits-, Datenschutz-, A11Y- und Architekturbehauptungen brauchen Evidenz.
- KI-Agenten dürfen vorbereiten, aber keine Lernenden-Läufe ohne ausdrücklichen Auftrag starten.

## Minimaler Start / Minimal Start

```text
/speckit-specify Nutze <Pfad-zum-Aufgaben-Lastenheft> als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```

## Reviewfragen / Review Questions

- Ist der Auftrag klar genug, bevor Code entsteht?
- Sind Nicht-Ziele sichtbar?
- Sind Datenschutz, Sicherheit und Testbarkeit getrennt betrachtet?
- Sind `N/A`-Entscheidungen begründet?
- Sind offene Punkte als `Open` mit Folgeaktion dokumentiert?
