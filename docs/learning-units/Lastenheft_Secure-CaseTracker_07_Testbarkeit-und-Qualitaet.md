# Lastenheft: Secure CaseTracker 07 - Testbarkeit und Qualität

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können Tests als Sicherheits- und Lernnachweis planen und offene Testlücken transparent dokumentieren.

**EN:** Learners can plan tests as security and learning evidence and document open test gaps transparently.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Testbarkeit ist Grundlage für sichere Implementierung. |
| SI | Sekundär | Tests müssen in CI oder Sandbox reproduzierbar laufen. |
| DPA | Sekundär | Testdaten beeinflussen Datenqualität und Kennzahlen. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Qualitätsmanagement, Testmanagement, sichere Entwicklung und nachvollziehbare Ergebnisdokumentation.

**EN:** The task connects quality management, test management, secure development, and traceable result documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Testmanagement, Sicherheits-Code-Review, nachvollziehbare Evidenz.
- **Checklisten:** CL_08, CL_09, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Testmanagement, Kompetenzprofile und Schulungsplan.

## Aufgabenstellung / Task

**DE:** Plane einen Testumfang für den Secure CaseTracker. Unterscheide fachliche Tests, negative Sicherheitstests, Datenschutztests und spätere CI-/Sandbox-Nachweise. Definiere Testdaten, die keine echten personenbezogenen Daten enthalten.

**EN:** Plan a test scope for the Secure CaseTracker. Distinguish functional tests, negative security tests, privacy tests, and later CI/sandbox evidence. Define test data that contains no real personal data.

## Sicherheitsanforderungen / Security Requirements

- Tests müssen Fehlpfade enthalten.
- Tests dürfen keine Secrets enthalten.
- Sicherheitsrelevante Regeln müssen mindestens einen negativen Test haben.

## Datenschutzanforderungen / Privacy Requirements

- Testdaten sind fiktiv.
- Testberichte enthalten keine unnötigen personenbezogenen Daten.
- Datenschutztests prüfen Datenminimierung und Logging-Regeln.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielsprachen-Umsetzung braucht vergleichbare Kernlogiktests.
- Sicherheitstests prüfen Fehlpfade, nicht nur Erfolgspfade.
- Testdaten müssen zwischen Sprachen vergleichbar bleiben.

## Sprachspezifische Hinweise / Language-Specific Notes

- **C#:** `dotnet test`.
- **Go:** `go test`.
- **Java:** JUnit mit Maven oder Gradle.
- **Python:** `pytest` oder Standard-`unittest`.
- **Rust:** `cargo test`.
- **Swift:** XCTest.

## Erwartete Artefakte / Expected Artifacts

- Testplan.
- Testfallliste.
- Mindestabdeckung für Kernlogik.
- Liste offener Testlücken.

## Akzeptanzkriterien / Acceptance Criteria

- Fachliche Tests, Sicherheitstests und Datenschutztests sind getrennt benannt.
- Jede kritische Regel hat mindestens eine Testidee.
- Offene Testlücken sind begründet und nicht versteckt.
- Testdaten enthalten keine echten personenbezogenen Daten.

## Tests und Nachweise / Tests and Evidence

- Tests für Anlegen, Ändern und Schließen von Fällen.
- Tests für verbotene Aktionen.
- Tests für ungültige Eingaben, Pfade und Importdaten.
- Review der Testlücken.

## Reflexionsfragen / Reflection Questions

- **AE:** Welcher Fehlerfall muss unbedingt automatisiert getestet werden?
- **SI:** Wie wird der Testlauf in der Sandbox reproduzierbar?
- **DPA:** Welche Testdaten sind realistisch, aber datenschutzfreundlich?

## N/A-Regeln / N/A Rules

- Coverage-Schwellen sind `N/A`, wenn noch keine Implementierung existiert; Testarten bleiben trotzdem zu planen.
- CI-Ausführung ist `N/A`, wenn nur lokale Lernplanung erfolgt.
- Jede `N/A`-Entscheidung nennt den späteren Re-Evaluierungszeitpunkt.

## Offene Punkte / Open Follow-Ups

- Fehlende Testarten werden als `Open` mit Folgeaufgabe erfasst.
- Offene Toolchain-Fragen werden in die Sandbox- oder Supply-Chain-Einheit übernommen.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Testplan, fachliche Tests, Sicherheitstests, Datenschutztests, CI-/Sandbox-Nachweise und offene Testlücken des Secure CaseTracker. Erzeuge keine Implementierung.
```
