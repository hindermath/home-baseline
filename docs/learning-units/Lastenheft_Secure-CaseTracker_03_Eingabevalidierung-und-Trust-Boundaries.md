# Lastenheft: Secure CaseTracker 03 - Eingabevalidierung und Trust Boundaries

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer Spec-Kit-Intake

## Lernziel / Learning Goal

**DE:** Lernende können Vertrauensgrenzen erkennen, Eingaben systematisch validieren und sichere Fehlermeldungen planen.

**EN:** Learners can identify trust boundaries, validate input systematically, and plan safe error messages.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welche Validierung muss serverseitig oder in der Kernlogik liegen? |
| SI | Sekundär | Welche Eingaben kommen aus Dateien, Shell oder Umgebung? |
| DPA | Ergänzend | Wie beeinflussen ungültige Daten spätere Kennzahlen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Eingabeverarbeitung, Schutzbedarf, Schnittstellenverständnis und Qualität von Daten.

**EN:** The task connects safe input handling, protection needs, interface understanding, and data quality.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4** (Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen), **berührt LF 5** (Software zur Verwaltung von Daten anpassen). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4** (perform a protection-needs analysis in your own work area), **touched LF 5** (adapt software for data management). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Secure Coding, Trust Boundaries, sichere Fehlerbehandlung.
- **Checklisten:** CL_01, CL_04, CL_08.
- **Presets:** security-governance, architecture-governance.

## Aufgabenstellung / Task

**DE:** Beschreibe alle Eingänge des Systems: manuelle Eingabe, Dateiimport und spätere API- oder CLI-Parameter. Definiere Validierungsregeln für IDs, Statuswerte, Freitexte, Datumswerte und Dateipfade.

**EN:** Describe all system inputs: manual input, file import, and later API or CLI parameters. Define validation rules for IDs, status values, free text, dates, and file paths.

## Anforderungen / Requirements

- **R-01:** Alle Eingangsarten (manuelle Eingabe, Dateiimport, spätere API- oder CLI-Parameter) sind benannt und einer Vertrauensgrenze zugeordnet.
- **R-02:** Jede Eingangsart hat mindestens eine Validierungsregel für IDs, Statuswerte, Freitexte, Datumswerte oder Dateipfade.
- **R-03:** Fehlermeldungen zeigen keine internen Details; zu jeder kritischen Eingabeart gibt es mindestens einen negativen Test.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert: API-spezifische Regeln sind `N/A`, wenn der spätere Lauf nur CLI oder Dateiimport betrachtet; Dateipfadregeln sind `N/A`, wenn in diesem Lauf keine Dateieingaben verarbeitet werden; jede Nichtanwendbarkeit braucht eine kurze Begründung.
- **R-05:** Die Validierungsregeln gelten vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Eingaben an jeder Vertrauensgrenze prüfen.
- Fehlermeldungen dürfen keine Stack-Traces, Pfade oder internen Details zeigen.
- Freitexte gegen Log-Injection und überlange Inhalte begrenzen.
- Dateipfade normalisieren und auf erlaubte Verzeichnisse begrenzen.
- Fehlermeldungen dürfen keine personenbezogenen Daten wiederholen, wenn dies nicht nötig ist.
- Importfehler werden so dokumentiert, dass Testdaten nicht unnötig offengelegt werden.
- Nicht anwendbare Standards (z. B. API-Regeln ohne API, Dateipfadregeln ohne Dateieingaben) werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielplattform unterscheidet gültige und ungültige Eingaben gleich.
- Validierungsfehler sind fachlich verständlich und technisch sparsam.
- Die Regeln gelten unabhängig davon, ob später CLI, API oder Dateiimport umgesetzt wird.
- **C#:** Data annotations oder explizite Validatoren, keine ungeprüfte Deserialisierung.
- **Go:** klare Fehlerwerte, `context`, Dateipfade mit Standardbibliothek bereinigen.
- **Java:** Bean Validation, sichere Parser, keine native Deserialisierung für untrusted data.
- **Python:** Pydantic oder explizite Validatoren, kein `eval`, kein unsicheres YAML.
- **Rust:** `Result` statt Panic aus Eingaben, keine ungeprüften `unwrap()`.
- **Swift:** keine Force-Unwraps bei Eingaben, `Codable` plus Domänenvalidierung.

## Erwartete Artefakte / Expected Artifacts

- Trust-Boundary-Liste.
- Validierungsregel-Tabelle.
- Fehlermeldungsregeln.
- negative Testfälle.
- Offene Punkte: unklare Eingangsarten werden vor Persistenz oder Import/Export nachgezogen; fehlende negative Tests werden als `Open` mit verantwortlicher Folgeaufgabe dokumentiert.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Alle Eingangsarten sind benannt.
- [ ] Jede Eingangsart hat mindestens eine Validierungsregel.
- [ ] Es gibt mindestens einen negativen Test je kritischer Eingabeart.
- [ ] Fehlermeldungen zeigen keine internen Details.
- [ ] Nachweise vorhanden: Tests für ungültige IDs, zu lange Texte, unbekannte Statuswerte und manipulierte Dateipfade sowie ein Review, ob Fehlermeldungen verständlich, aber nicht informationspreisgebend sind.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Trust Boundaries, Eingabevalidierung, sichere Fehlermeldungen, Dateipfadprüfung und negative Tests des Secure CaseTracker. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
