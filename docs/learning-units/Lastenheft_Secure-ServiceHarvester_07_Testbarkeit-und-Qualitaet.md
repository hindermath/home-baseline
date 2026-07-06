# Lastenheft: Secure ServiceHarvester 07 - Testbarkeit und Qualität

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Tests werden als Sicherheits- und Lernnachweis für den Sammel-Dienst geplant. Lernende unterscheiden fachliche Tests, negative Sicherheitstests, Datenschutztests und dienstspezifische Tests wie Intervall- und Shutdown-Verhalten und dokumentieren offene Testlücken transparent.

**EN:** Tests are planned as security and learning evidence for the collection service. Learners distinguish functional tests, negative security tests, privacy tests, and service-specific tests such as interval and shutdown behavior, and document open test gaps transparently.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welcher Fehlerfall des Dienstes muss unbedingt automatisiert getestet werden? |
| SI | mittel bis hoch | Wie wird der Testlauf in CI oder Sandbox reproduzierbar? |
| DPA | mittel bis hoch | Welche Testdaten sind realistisch, aber datenschutzfreundlich? |
| DV | mittel bis hoch | Welche Systemgrenze oder Schnittstelle braucht einen eigenen Negativtest? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Qualitätsmanagement, Testmanagement, sichere Entwicklung und nachvollziehbare Ergebnisdokumentation für einen langlaufenden Dienst.

**EN:** The task connects quality management, test management, secure development, and traceable result documentation for a long-running service.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_07_Testbarkeit-und-Qualitaet.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_07_Testbarkeit-und-Qualitaet.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Testmanagement, Sicherheits-Code-Review, Testbarkeit und nachvollziehbare Evidenz.
- **Checklisten:** CL_08, CL_09, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Testmanagement, Leitlinie für sichere Programmierung, Kompetenzprofile und Schulungsplan.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Plane einen Testumfang für den Secure ServiceHarvester. Unterscheide fachliche Tests (Snapshot sammeln, gültige Statusdaten speichern), negative Sicherheitstests (ungültige oder manipulierte Statusdaten, Pfad- und Importgrenzen), Datenschutztests (fiktive Testdaten, Log-Regeln) und dienstspezifische Tests für Sammel-Intervall und sauberes Beenden (Graceful Shutdown). Definiere Testdaten ohne echte personenbezogene Daten. Halte den Testumfang im 1. Lehrjahr überschaubar.

**EN:** Plan a test scope for the Secure ServiceHarvester. Distinguish functional tests (collect a snapshot, store valid status data), negative security tests (invalid or manipulated status data, path and import boundaries), privacy tests (fictitious test data, log rules), and service-specific tests for the collection interval and clean shutdown (graceful shutdown). Define test data without real personal data. Keep the test scope manageable in year 1.

## Anforderungen / Requirements

- **R-01:** Fachliche Tests, Sicherheitstests, Datenschutztests und dienstspezifische Tests sind getrennt benannt.
- **R-02:** Jede sicherheitsrelevante Regel hat mindestens einen Negativtest (Fehlpfad).
- **R-03:** Für das Dienstverhalten sind mindestens ein Intervall- und ein Shutdown-Test benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Testidee bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Tests müssen Fehlpfade enthalten und dürfen keine Secrets enthalten; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Gesammelte Statusdaten gelten in Tests als nicht vertrauenswürdig und werden an der Vertrauensgrenze geprüft.
- Testdaten sind fiktiv; Testberichte enthalten keine unnötigen personenbezogenen Daten.
- Nicht anwendbare Testarten oder Schwellen werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielsprachen-Umsetzung braucht vergleichbare Kernlogiktests für den Sammel- und Speicherpfad.
- Sicherheitstests prüfen Fehlpfade, nicht nur Erfolgspfade; Testdaten bleiben zwischen Sprachen vergleichbar.
- MSL-Status ersetzt keine Prüfung von Eingabe, I/O, Auth, Crypto, Logging oder Dependencies.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für den Testumfang dieser Aufgabe.
- `plan.md` mit Test-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Test-, Review- und Dokumentationsschritten.
- Testplan, Testfallliste, Mindestabdeckung für die Kernlogik und eine Liste offener Testlücken.
- Erwartete Evidenz: Testarten-Tabelle, Negativtest-Liste, Testkommando je Sprache, N/A-/Open-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Fachliche Tests, Sicherheitstests, Datenschutztests und Diensttests sind getrennt sichtbar.
- [ ] Jede kritische Regel hat mindestens eine Testidee mit Fehlpfad.
- [ ] Intervall- und Shutdown-Verhalten des Dienstes sind durch je einen Test abgedeckt.
- [ ] Offene Testlücken sind als `Open` oder `N/A` mit Begründung und Re-Evaluierungszeitpunkt notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_07_Testbarkeit-und-Qualitaet.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Testplan, fachliche Tests, negative Sicherheitstests, Datenschutztests, Intervall-/Shutdown-Tests und offene Testlücken des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
