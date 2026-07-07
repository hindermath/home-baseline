# Lastenheft: Secure CaseTracker 07 - Testbarkeit und Qualität

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA

## Lernziel / Learning Goal

**DE:** Lernende können Tests als Sicherheits- und Lernnachweis planen und offene Testlücken transparent dokumentieren.

**EN:** Learners can plan tests as security and learning evidence and document open test gaps transparently.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welcher Fehlerfall muss unbedingt automatisiert getestet werden? |
| SI | Sekundär | Wie wird der Testlauf in der Sandbox reproduzierbar? |
| DPA | Sekundär | Welche Testdaten sind realistisch, aber datenschutzfreundlich? |

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

## Anforderungen / Requirements

- **R-01:** Ein Testplan trennt fachliche Tests, negative Sicherheitstests, Datenschutztests und spätere CI-/Sandbox-Nachweise.
- **R-02:** Jede sicherheitsrelevante Regel hat mindestens einen negativen Test; Tests enthalten Fehlpfade und keine Secrets.
- **R-03:** Testdaten sind fiktiv und enthalten keine echten personenbezogenen Daten; Datenschutztests prüfen Datenminimierung und Logging-Regeln.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert: Coverage-Schwellen sind `N/A`, wenn noch keine Implementierung existiert; CI-Ausführung ist `N/A`, wenn nur lokale Lernplanung erfolgt; jede `N/A`-Entscheidung nennt den späteren Re-Evaluierungszeitpunkt.
- **R-05:** Jede Zielsprachen-Umsetzung braucht vergleichbare Kernlogiktests für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Tests müssen Fehlpfade enthalten.
- Tests dürfen keine Secrets enthalten.
- Sicherheitsrelevante Regeln müssen mindestens einen negativen Test haben.
- Testdaten sind fiktiv.
- Testberichte enthalten keine unnötigen personenbezogenen Daten.
- Datenschutztests prüfen Datenminimierung und Logging-Regeln.
- Nicht anwendbare Standards (z. B. Coverage-Schwellen ohne Implementierung, CI-Ausführung bei reiner Lernplanung) werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielsprachen-Umsetzung braucht vergleichbare Kernlogiktests.
- Sicherheitstests prüfen Fehlpfade, nicht nur Erfolgspfade.
- Testdaten müssen zwischen Sprachen vergleichbar bleiben.
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
- Offene Punkte: fehlende Testarten werden als `Open` mit Folgeaufgabe erfasst; offene Toolchain-Fragen werden in die Sandbox- oder Supply-Chain-Einheit übernommen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Fachliche Tests, Sicherheitstests und Datenschutztests sind getrennt benannt.
- [ ] Jede kritische Regel hat mindestens eine Testidee.
- [ ] Offene Testlücken sind begründet und nicht versteckt.
- [ ] Testdaten enthalten keine echten personenbezogenen Daten.
- [ ] Nachweise vorhanden: Tests für Anlegen, Ändern und Schließen von Fällen, Tests für verbotene Aktionen, Tests für ungültige Eingaben, Pfade und Importdaten sowie ein Review der Testlücken.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Testplan, fachliche Tests, Sicherheitstests, Datenschutztests, CI-/Sandbox-Nachweise und offene Testlücken des Secure CaseTracker. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
