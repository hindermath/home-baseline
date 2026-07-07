# Lastenheft: Secure CaseTracker 06 - Persistenz, Import und Export

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA

## Lernziel / Learning Goal

**DE:** Lernende können sichere Persistenz, Import und Export planen, ohne unsichere Deserialisierung, Pfadfehler oder unnötige Datenweitergabe einzubauen.

**EN:** Learners can plan safe persistence, import, and export without unsafe deserialization, path errors, or unnecessary data disclosure.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welche Daten müssen nach dem Einlesen erneut validiert werden? |
| SI | Sekundär | Wo darf die Anwendung Dateien lesen oder schreiben? |
| DPA | Primär | Welche Exportdaten reichen für Kennzahlen aus? |

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

## Anforderungen / Requirements

- **R-01:** Eine Persistenzentscheidung (JSON, SQLite oder sprachübliche Alternative) ist mit Begründung und benannter Alternative dokumentiert.
- **R-02:** Import und Export nutzen denselben fachlichen Datenvertrag; importierte Daten werden nach dem Parsen erneut fachlich validiert.
- **R-03:** Pfade werden normalisiert und auf erlaubte Verzeichnisse begrenzt; Export enthält keine unnötigen personenbezogenen Daten.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert: Datenbankbetrieb ist `N/A`, wenn nur Datei-Persistenz geplant wird; Verschlüsselung ruhender Daten ist `N/A`, wenn nur fiktive lokale Lern-Testdaten genutzt werden; Cloud-Speicherung ist `N/A`, wenn keine Cloud-Integration geplant wird.
- **R-05:** Persistenz, Import und Export bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine unsichere Deserialisierung.
- Pfade normalisieren und auf erlaubte Verzeichnisse begrenzen.
- Importierte Daten nach dem Parsen erneut fachlich validieren.
- Datenbank- oder Dateioperationen dürfen keine internen Details an Endnutzer ausgeben.
- Exportprofile unterscheiden vollständigen Lernexport und datensparsame Auswertung.
- Personenbezogene Testdaten bleiben fiktiv.
- Nicht benötigte Felder werden nicht exportiert.
- Nicht anwendbare Standards (z. B. Datenbankbetrieb, Verschlüsselung ruhender Daten, Cloud-Speicherung) werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Import und Export verwenden denselben fachlichen Datenvertrag.
- Jede Sprache validiert importierte Daten nach dem Einlesen erneut.
- Exportformate werden so beschrieben, dass sie später testbar sind.
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
- Offene Punkte: unklare Persistenzrisiken werden vor Implementierung als `Open` geführt; Exportfelder mit Datenschutzrisiko werden vor Prozessanalyse erneut geprüft.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Persistenzentscheidung und Alternative sind begründet.
- [ ] Import validiert Struktur und Domänenregeln.
- [ ] Export enthält keine verbotenen Felder.
- [ ] Pfadprüfung ist als Sicherheitsanforderung sichtbar.
- [ ] Nachweise vorhanden: Import ungültiger Daten schlägt kontrolliert fehl, Export enthält keine verbotenen Felder und manipulierte Pfade werden abgelehnt.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_06_Persistenz-und-Import-Export.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für sichere Persistenz, Import, Export, Pfadprüfung, sichere Deserialisierung, Datenminimierung und Import-/Export-Tests des Secure CaseTracker. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
