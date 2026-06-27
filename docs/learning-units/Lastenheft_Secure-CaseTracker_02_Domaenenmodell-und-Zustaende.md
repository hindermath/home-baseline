# Lastenheft: Secure CaseTracker 02 - Domänenmodell und Zustände

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer Spec-Kit-Intake

## Lernziel / Learning Goal

**DE:** Lernende können ein kleines Domänenmodell sicher beschreiben, erlaubte Zustände definieren und ungültige Zustandswechsel als Risiko erkennen.

**EN:** Learners can describe a small domain model securely, define allowed states, and identify invalid state transitions as a risk.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Modell, Zustände und Regeln sind Kern der späteren Implementierung. |
| SI | Ergänzend | Betriebsnahe Informationen wie Asset-Bezug werden verständlich modelliert. |
| DPA | Sekundär | Saubere Datenstrukturen sind Grundlage für spätere Auswertungen. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, Anwendungslogik, Informationssicherheit und nachvollziehbare Dokumentation.

**EN:** The task connects data management, application logic, information security, and traceable documentation.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Code-Erzeugung, Datenschutz durch Datenminimierung.
- **Checklisten:** CL_01, CL_02, CL_08.
- **Presets:** architecture-governance, isaqb-architecture-governance, security-governance.

## Aufgabenstellung / Task

**DE:** Definiere die Entitäten `Case`, `Customer`, `Asset`, `WorkLog` und `AuditEntry`. Lege Pflichtfelder, optionale Felder und erlaubte Zustandsübergänge fest. Beispielzustände sind `new`, `in_progress`, `waiting_for_customer`, `closed` und `rejected`.

**EN:** Define the entities `Case`, `Customer`, `Asset`, `WorkLog`, and `AuditEntry`. Define mandatory fields, optional fields, and allowed state transitions. Example states are `new`, `in_progress`, `waiting_for_customer`, `closed`, and `rejected`.

## Sicherheitsanforderungen / Security Requirements

- Keine Zustandsänderung darf allein durch einen ungeprüften Eingabewert erfolgen.
- Pflichtfelder müssen fachlich begründet sein.
- Interne IDs dürfen keine personenbezogenen Informationen enthalten.

## Datenschutzanforderungen / Privacy Requirements

- `Customer` enthält nur Lern- und Testdaten.
- Freitextfelder bekommen Zweck, Längenbegrenzung und Beispielinhalte.
- Audit-Daten werden von fachlichen Notizen getrennt beschrieben.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle Zielsprachen verwenden dieselben Entitäten und Zustandsregeln.
- Sprachspezifische Typen sind erlaubt, ändern aber nicht den fachlichen Vertrag.
- Fehlerfälle müssen modelliert werden, nicht nur Erfolgspfade.

## Sprachspezifische Hinweise / Language-Specific Notes

- C#, Java und Swift können Domänenregeln über Klassen, Records, Structs oder Value Types ausdrücken.
- Go, Rust und Python können Domänenregeln über Structs, Dataclasses, Enums oder explizite Validatoren ausdrücken.
- Sprachspezifische Typwahl darf keine Zustandsregel schwächen.

## Erwartete Artefakte / Expected Artifacts

- Entitätenliste mit Feldern.
- Zustandsdiagramm oder tabellarische Zustandsmatrix.
- Liste ungültiger Zustandswechsel.
- erste Modell-Testideen.

## Akzeptanzkriterien / Acceptance Criteria

- Jede Entität hat Zweck, Pflichtfelder und optionale Felder.
- Jeder erlaubte Zustand ist erklärt.
- Verbotene Zustandswechsel sind ausdrücklich genannt.
- Das Modell speichert keine unnötigen personenbezogenen Daten.

## Tests und Nachweise / Tests and Evidence

- Tests für erlaubte und verbotene Zustandswechsel.
- Review der Pflichtfelder und Datenminimierung.
- Dokumentierte Entscheidung, welche Felder nicht gespeichert werden.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Regel gehört ins Domänenmodell und nicht erst in die UI?
- **SI:** Welche Felder helfen beim Betrieb, ohne Datenschutz unnötig zu belasten?
- **DPA:** Welche Datenqualität brauchst du für spätere Kennzahlen?

## N/A-Regeln / N/A Rules

- Persistenz ist `N/A`, wenn diese Aufgabe nur das Modell beschreibt.
- Authentifizierung ist `N/A`, wenn nur fachliche Rollen vorbereitet werden.
- Technische Framework-Entscheidungen sind `N/A`, solange der Sprachvertrag neutral bleibt.

## Offene Punkte / Open Follow-Ups

- Unklare Felder werden als `Open` markiert und vor Persistenz geklärt.
- Unklare Zustandsübergänge werden vor Rollen- und Berechtigungsaufgaben nachgezogen.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für das sprachneutrale Domänenmodell, erlaubte Zustände, verbotene Zustandswechsel, Datenminimierung und Modelltests des Secure CaseTracker. Erzeuge keine Implementierung.
```
