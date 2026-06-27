# Lastenheft: Secure CaseTracker 03 - Eingabevalidierung und Trust Boundaries

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer Spec-Kit-Intake

## Lernziel / Learning Goal

**DE:** Lernende können Vertrauensgrenzen erkennen, Eingaben systematisch validieren und sichere Fehlermeldungen planen.

**EN:** Learners can identify trust boundaries, validate input systematically, and plan safe error messages.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Validierung schützt die Anwendungslogik direkt. |
| SI | Sekundär | Import, CLI und spätere API sind Betriebs- und Schnittstellenthemen. |
| DPA | Ergänzend | Schlechte Eingaben verschlechtern Datenqualität und Kennzahlen. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Eingabeverarbeitung, Schutzbedarf, Schnittstellenverständnis und Qualität von Daten.

**EN:** The task connects safe input handling, protection needs, interface understanding, and data quality.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Secure Coding, Trust Boundaries, sichere Fehlerbehandlung.
- **Checklisten:** CL_01, CL_04, CL_08.
- **Presets:** security-governance, architecture-governance.

## Aufgabenstellung / Task

**DE:** Beschreibe alle Eingänge des Systems: manuelle Eingabe, Dateiimport und spätere API- oder CLI-Parameter. Definiere Validierungsregeln für IDs, Statuswerte, Freitexte, Datumswerte und Dateipfade.

**EN:** Describe all system inputs: manual input, file import, and later API or CLI parameters. Define validation rules for IDs, status values, free text, dates, and file paths.

## Sicherheitsanforderungen / Security Requirements

- Eingaben an jeder Vertrauensgrenze prüfen.
- Fehlermeldungen dürfen keine Stack-Traces, Pfade oder internen Details zeigen.
- Freitexte gegen Log-Injection und überlange Inhalte begrenzen.
- Dateipfade normalisieren und auf erlaubte Verzeichnisse begrenzen.

## Datenschutzanforderungen / Privacy Requirements

- Fehlermeldungen dürfen keine personenbezogenen Daten wiederholen, wenn dies nicht nötig ist.
- Importfehler werden so dokumentiert, dass Testdaten nicht unnötig offengelegt werden.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielplattform unterscheidet gültige und ungültige Eingaben gleich.
- Validierungsfehler sind fachlich verständlich und technisch sparsam.
- Die Regeln gelten unabhängig davon, ob später CLI, API oder Dateiimport umgesetzt wird.

## Sprachspezifische Hinweise / Language-Specific Notes

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

## Akzeptanzkriterien / Acceptance Criteria

- Alle Eingangsarten sind benannt.
- Jede Eingangsart hat mindestens eine Validierungsregel.
- Es gibt mindestens einen negativen Test je kritischer Eingabeart.
- Fehlermeldungen zeigen keine internen Details.

## Tests und Nachweise / Tests and Evidence

- Tests für ungültige IDs, zu lange Texte, unbekannte Statuswerte und manipulierte Dateipfade.
- Review prüft, ob Fehlermeldungen verständlich, aber nicht informationspreisgebend sind.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Validierung muss serverseitig oder in der Kernlogik liegen?
- **SI:** Welche Eingaben kommen aus Dateien, Shell oder Umgebung?
- **DPA:** Wie beeinflussen ungültige Daten spätere Kennzahlen?

## N/A-Regeln / N/A Rules

- API-spezifische Regeln sind `N/A`, wenn der spätere Lauf nur CLI oder Dateiimport betrachtet.
- Dateipfadregeln sind `N/A`, wenn in diesem Lauf keine Dateieingaben verarbeitet werden.
- Jede Nichtanwendbarkeit braucht eine kurze Begründung.

## Offene Punkte / Open Follow-Ups

- Unklare Eingangsarten werden vor Persistenz oder Import/Export nachgezogen.
- Fehlende negative Tests werden als `Open` mit verantwortlicher Folgeaufgabe dokumentiert.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze Lastenheft_Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Trust Boundaries, Eingabevalidierung, sichere Fehlermeldungen, Dateipfadprüfung und negative Tests des Secure CaseTracker. Erzeuge keine Implementierung.
```
