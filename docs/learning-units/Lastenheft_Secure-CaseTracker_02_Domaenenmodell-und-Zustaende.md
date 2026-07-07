# Lastenheft: Secure CaseTracker 02 - Domänenmodell und Zustände

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer Spec-Kit-Intake

## Lernziel / Learning Goal

**DE:** Lernende können ein kleines Domänenmodell sicher beschreiben, erlaubte Zustände definieren und ungültige Zustandswechsel als Risiko erkennen.

**EN:** Learners can describe a small domain model securely, define allowed states, and identify invalid state transitions as a risk.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welche Regel gehört ins Domänenmodell und nicht erst in die UI? |
| SI | Ergänzend | Welche Felder helfen beim Betrieb, ohne Datenschutz unnötig zu belasten? |
| DPA | Sekundär | Welche Datenqualität brauchst du für spätere Kennzahlen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, Anwendungslogik, Informationssicherheit und nachvollziehbare Dokumentation.

**EN:** The task connects data management, application logic, information security, and traceable documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Code-Erzeugung, Datenschutz durch Datenminimierung.
- **Checklisten:** CL_01, CL_02, CL_08.
- **Presets:** architecture-governance, isaqb-architecture-governance, security-governance.

## Aufgabenstellung / Task

**DE:** Definiere die Entitäten `Case`, `Customer`, `Asset`, `WorkLog` und `AuditEntry`. Lege Pflichtfelder, optionale Felder und erlaubte Zustandsübergänge fest. Beispielzustände sind `new`, `in_progress`, `waiting_for_customer`, `closed` und `rejected`.

**EN:** Define the entities `Case`, `Customer`, `Asset`, `WorkLog`, and `AuditEntry`. Define mandatory fields, optional fields, and allowed state transitions. Example states are `new`, `in_progress`, `waiting_for_customer`, `closed`, and `rejected`.

## Anforderungen / Requirements

- **R-01:** Die Entitäten `Case`, `Customer`, `Asset`, `WorkLog` und `AuditEntry` haben je Zweck, Pflichtfelder und optionale Felder.
- **R-02:** Erlaubte Zustände und erlaubte Zustandsübergänge sind vollständig definiert; verbotene Zustandswechsel sind ausdrücklich genannt.
- **R-03:** Keine Zustandsänderung erfolgt allein durch einen ungeprüften Eingabewert; Fehlerfälle sind mitmodelliert, nicht nur Erfolgspfade.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert: Persistenz ist `N/A`, wenn diese Aufgabe nur das Modell beschreibt; Authentifizierung ist `N/A`, wenn nur fachliche Rollen vorbereitet werden; technische Framework-Entscheidungen sind `N/A`, solange der Sprachvertrag neutral bleibt.
- **R-05:** Entitäten und Zustandsregeln gelten vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine Zustandsänderung darf allein durch einen ungeprüften Eingabewert erfolgen.
- Pflichtfelder müssen fachlich begründet sein.
- Interne IDs dürfen keine personenbezogenen Informationen enthalten.
- `Customer` enthält nur Lern- und Testdaten.
- Freitextfelder bekommen Zweck, Längenbegrenzung und Beispielinhalte.
- Audit-Daten werden von fachlichen Notizen getrennt beschrieben.
- Nicht anwendbare Standards (z. B. Persistenz, Authentifizierung, Framework-Wahl) werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle Zielsprachen verwenden dieselben Entitäten und Zustandsregeln.
- Sprachspezifische Typen sind erlaubt, ändern aber nicht den fachlichen Vertrag.
- Fehlerfälle müssen modelliert werden, nicht nur Erfolgspfade.
- C#, Java und Swift können Domänenregeln über Klassen, Records, Structs oder Value Types ausdrücken.
- Go, Rust und Python können Domänenregeln über Structs, Dataclasses, Enums oder explizite Validatoren ausdrücken.
- Sprachspezifische Typwahl darf keine Zustandsregel schwächen.

## Erwartete Artefakte / Expected Artifacts

- Entitätenliste mit Feldern.
- Zustandsdiagramm oder tabellarische Zustandsmatrix.
- Liste ungültiger Zustandswechsel.
- erste Modell-Testideen.
- Offene Punkte: unklare Felder werden als `Open` markiert und vor Persistenz geklärt; unklare Zustandsübergänge werden vor Rollen- und Berechtigungsaufgaben nachgezogen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Jede Entität hat Zweck, Pflichtfelder und optionale Felder.
- [ ] Jeder erlaubte Zustand ist erklärt.
- [ ] Verbotene Zustandswechsel sind ausdrücklich genannt.
- [ ] Das Modell speichert keine unnötigen personenbezogenen Daten.
- [ ] Nachweise vorhanden: Tests für erlaubte und verbotene Zustandswechsel, Review der Pflichtfelder und Datenminimierung sowie eine dokumentierte Entscheidung, welche Felder nicht gespeichert werden.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für das sprachneutrale Domänenmodell, erlaubte Zustände, verbotene Zustandswechsel, Datenminimierung und Modelltests des Secure CaseTracker. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
