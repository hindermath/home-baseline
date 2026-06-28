# Secure CaseTracker v2 Unterrichtsleitfaden / Secure CaseTracker v2 Service Edition Teaching Guide

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
| 03 | API- und Service-Vertrag | AE, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 04 | Fehler-, Validierungs- und Response-Modell | AE | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 05 | Rollen- und Autorisierungsmatrix | AE, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 06 | Audit-Logging und Datenschutz | SI, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 07 | Import- und Export-Härtung | AE, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 08 | Teststrategie und CI-Nachweise | AE, SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 09 | Sandbox- und Betriebsnachweise | SI | Entscheidung, Nachweis und Reflexion sichtbar machen. |
| 10 | MSL-Vergleich und Abschlussreview | AE, SI, DPA | Entscheidung, Nachweis und Reflexion sichtbar machen. |

## Bewertung / Assessment

- Prüfe, ob Entscheidungen begründet und nicht nur behauptet werden.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob Nachweise konkrete Pfade, Tests, Dokumente oder Spec-Kit-Artefakte nennen.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.
- Prüfe, ob MSL-Vorteile sichtbar werden, ohne sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung zu ersetzen.

## Grenzen / Boundaries

**DE:** Der Leitfaden ist kein Spec-Kit-Intake. Die späteren Spec-Kit-Läufe werden manuell pro Aufgaben-Lastenheft und pro späterem Level-2-Repo gestartet.

**EN:** This guide is not a Spec Kit intake. Later Spec Kit runs are started manually per task intake and per later level-2 repository.
