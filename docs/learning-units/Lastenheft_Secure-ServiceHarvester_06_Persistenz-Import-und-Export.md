# Lastenheft: Secure ServiceHarvester 06 - Persistenz, Import und Export

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, DPA, SI, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Sichere Persistenz über eine austauschbare Ablage, sicherer CSV-Import und datensparsamer Export werden geplant, ohne unsichere Deserialisierung, Pfadfehler oder unnötige Datenweitergabe. Lernende behandeln Dateien und Ablage als Fehler- und Datenabflussstellen.

**EN:** Safe persistence via an exchangeable storage backend, safe CSV import, and data-minimal export are planned without unsafe deserialization, path errors, or unnecessary data disclosure. Learners treat files and storage as error and data-leak points.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | mittel bis hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, systemübergreifende Datenbereitstellung, Datenschutz und sichere Dateiverarbeitung auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects data management, cross-system data provision, privacy, and safe file handling at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 8 („Daten systemübergreifend bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_06_Persistenz-Import-und-Export.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 8 ("Daten systemübergreifend bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_06_Persistenz-Import-und-Export.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Datenschutz, Trust Boundaries an Dateigrenzen, Supply Chain bei Bibliotheken.
- **Checklisten:** CL_01, CL_05, CL_08, CL_11.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Leitlinie für sichere Programmierung, Richtlinie Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Plane eine austauschbare Ablage (Backend-Abstraktion) für die gesammelten Statusdaten. Zulässig sind JSON, SQLite oder eine sprachübliche Alternative. Definiere Regeln für den CSV-Import (Struktur- und Domänenvalidierung nach dem Einlesen), Pfadgrenzen und einen Export ohne unnötige personenbezogene Daten. Behandle Dateien und Ablage als mögliche Fehler- und Datenabflussstellen. Halte den Dienst im 1. Lehrjahr bewusst einfach.

**EN:** Plan an exchangeable storage backend (backend abstraction) for the collected status data. JSON, SQLite, or a language-common alternative is allowed. Define rules for CSV import (structure and domain validation after reading), path boundaries, and an export without unnecessary personal data. Treat files and storage as possible error and data-leak points. Keep the service deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Eine Ablage-Abstraktion trennt den fachlichen Datenvertrag von der konkreten Speicherform; die Persistenzentscheidung ist begründet.
- **R-02:** CSV-Import validiert Struktur und Domänenregeln nach dem Parsen erneut; keine unsichere Deserialisierung.
- **R-03:** Dateipfade werden normalisiert und auf erlaubte Verzeichnisse begrenzt; Export enthält keine verbotenen Felder.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Import und Export verwenden denselben fachlichen Datenvertrag und bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine unsichere Deserialisierung; Pfade kanonisieren und auf erlaubte Verzeichnisse begrenzen.
- Datei- oder Ablageoperationen geben keine internen Details (Pfade, SQL-Fehler, Stack-Traces) an Endnutzer aus.
- Exportprofile unterscheiden vollständigen Lernexport und datensparsame Auswertung; nicht benötigte Felder werden nicht exportiert.
- Personenbezogene Testdaten bleiben fiktiv; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Import und Export nutzen denselben fachlichen Datenvertrag wie das Domänenmodell (name, os, last_contact).
- Jede Sprache validiert importierte Daten nach dem Einlesen erneut und beschreibt Exportformate testbar.
- Sprachspezifische Hinweise (Kurzform): C# `System.Text.Json`/parametrisierte SQLite; Go Standard-JSON/`filepath`/parametrisiertes SQL; Java Jackson/Gson restriktiv, keine native Serialisierung; Python `json`/kein `pickle` aus Importdaten; Rust `serde` plus Domänenvalidierung; Swift `Codable` plus Domänenvalidierung und File-Scope-Prüfung.
- MSL-Status ersetzt keine sichere Deserialisierungs-, Pfad-, Datenschutz- oder Review-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Ablage-Abstraktion, Import-/Export-Vertrag, Pfadregel, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Persistenzentscheidung mit Begründung, Import-/Export-Vertrag, Pfadregel, Tests für gültige und ungültige Dateien.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Persistenzentscheidung und Alternative sind begründet; die Ablage ist als Abstraktion beschrieben.
- [ ] Der CSV-Import validiert Struktur und Domänenregeln; Import ungültiger Daten schlägt kontrolliert fehl.
- [ ] Pfadprüfung ist als Sicherheitsanforderung sichtbar; manipulierte Pfade werden abgelehnt.
- [ ] Export enthält keine verbotenen Felder; offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_06_Persistenz-Import-und-Export.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine austauschbare Ablage, sicheren CSV-Import, Export, Pfadprüfung, sichere Deserialisierung, Datenminimierung und Import-/Export-Tests des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
