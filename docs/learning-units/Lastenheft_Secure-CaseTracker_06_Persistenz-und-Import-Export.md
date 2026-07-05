# Lastenheft: Secure CaseTracker 06 - Persistenz, Import und Export

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können sichere Persistenz, Import und Export planen, ohne unsichere Deserialisierung, Pfadfehler oder unnötige Datenweitergabe einzubauen.

**EN:** Learners can plan safe persistence, import, and export without unsafe deserialization, path errors, or unnecessary data disclosure.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Persistenz und Import/Export sind Kernfunktionen. |
| SI | Sekundär | Speicherorte, Dateirechte und Laufzeitpfade sind Betriebsfragen. |
| DPA | Primär | Datenqualität und Exportumfang bestimmen spätere Auswertung. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, Schnittstellen, Datenschutz, sichere Dateiverarbeitung und Qualität von Auswertungsdaten.

**EN:** The task connects data management, interfaces, privacy, safe file handling, and quality of analysis data.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 8 („Daten systemübergreifend bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_06_Persistenz-und-Import-Export.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 8 ("Daten systemübergreifend bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_06_Persistenz-und-Import-Export.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Datenschutz, Supply Chain bei Bibliotheken.
- **Checklisten:** CL_01, CL_05, CL_08, CL_11.
- **Presets:** security-governance, architecture-governance.

## Aufgabenstellung / Task

**DE:** Plane eine einfache Persistenzform für Lernzwecke. Zulässig sind JSON, SQLite oder eine sprachübliche Alternative. Definiere Import- und Exportregeln, Pfadgrenzen, Validierung nach dem Einlesen und Export ohne unnötige personenbezogene Daten.

**EN:** Plan a simple persistence form for learning purposes. JSON, SQLite, or a language-common alternative is allowed. Define import and export rules, path boundaries, validation after reading, and export without unnecessary personal data.

## Sicherheitsanforderungen / Security Requirements

- Keine unsichere Deserialisierung.
- Pfade normalisieren und auf erlaubte Verzeichnisse begrenzen.
- Importierte Daten nach dem Parsen erneut fachlich validieren.
- Datenbank- oder Dateioperationen dürfen keine internen Details an Endnutzer ausgeben.

## Datenschutzanforderungen / Privacy Requirements

- Exportprofile unterscheiden vollständigen Lernexport und datensparsame Auswertung.
- Personenbezogene Testdaten bleiben fiktiv.
- Nicht benötigte Felder werden nicht exportiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Import und Export verwenden denselben fachlichen Datenvertrag.
- Jede Sprache validiert importierte Daten nach dem Einlesen erneut.
- Exportformate werden so beschrieben, dass sie später testbar sind.

## Sprachspezifische Hinweise / Language-Specific Notes

- **C#:** `System.Text.Json`, keine unsicheren Formatter, parametrisierte SQLite-Zugriffe.
- **Go:** Standard-JSON, Pfade mit `filepath`, SQL nur parametrisiert.
- **Java:** Jackson/Gson restriktiv konfigurieren, keine native Java-Serialisierung.
- **Python:** `json` oder validierende Bibliothek, kein `pickle` aus Importdaten.
- **Rust:** `serde` plus Domänenvalidierung, Fehler als `Result`.
- **Swift:** `Codable` plus Domänenvalidierung, File-Scope prüfen.

## Erwartete Artefakte / Expected Artifacts

- Persistenzentscheidung mit Begründung.
- Import-/Export-Vertrag.
- Pfadregel.
- Tests für gültige und ungültige Dateien.

## Akzeptanzkriterien / Acceptance Criteria

- Persistenzentscheidung und Alternative sind begründet.
- Import validiert Struktur und Domänenregeln.
- Export enthält keine verbotenen Felder.
- Pfadprüfung ist als Sicherheitsanforderung sichtbar.

## Tests und Nachweise / Tests and Evidence

- Import ungültiger Daten schlägt kontrolliert fehl.
- Export enthält keine verbotenen Felder.
- Manipulierte Pfade werden abgelehnt.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Daten müssen nach dem Einlesen erneut validiert werden?
- **SI:** Wo darf die Anwendung Dateien lesen oder schreiben?
- **DPA:** Welche Exportdaten reichen für Kennzahlen aus?

## N/A-Regeln / N/A Rules

- Datenbankbetrieb ist `N/A`, wenn nur Datei-Persistenz geplant wird.
- Verschlüsselung ruhender Daten ist `N/A`, wenn nur fiktive lokale Lern-Testdaten genutzt werden; die Begründung muss das klar sagen.
- Cloud-Speicherung ist `N/A`, wenn keine Cloud-Integration geplant wird.

## Offene Punkte / Open Follow-Ups

- Unklare Persistenzrisiken werden vor Implementierung als `Open` geführt.
- Exportfelder mit Datenschutzrisiko werden vor Prozessanalyse erneut geprüft.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_06_Persistenz-und-Import-Export.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für sichere Persistenz, Import, Export, Pfadprüfung, sichere Deserialisierung, Datenminimierung und Import-/Export-Tests des Secure CaseTracker. Erzeuge keine Implementierung.
```
