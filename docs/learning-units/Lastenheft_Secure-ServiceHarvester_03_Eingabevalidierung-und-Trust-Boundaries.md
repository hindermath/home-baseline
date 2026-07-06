# Lastenheft: Secure ServiceHarvester 03 - Eingabevalidierung und Trust Boundaries

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können Vertrauensgrenzen des Sammel-Dienstes erkennen, gesammelte und importierte Statusdaten als nicht vertrauenswürdig behandeln, Eingaben systematisch validieren und sichere Fehlermeldungen planen.

**EN:** Learners can identify the trust boundaries of the collection service, treat collected and imported status data as untrusted, validate inputs systematically, and plan safe error messages.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Validierung muss in der Kernlogik liegen und darf nicht nur an der Oberfläche stehen? |
| SI | hoch | Welche Eingaben kommen aus dem Netz, aus Dateien, aus der Shell oder aus der Umgebung? |
| DPA | mittel bis hoch | Wie beeinflussen ungültige gesammelte Daten spätere Kennzahlen? |
| DV | mittel bis hoch | An welcher Systemgrenze wechseln die gemeldeten Daten von „nicht vertrauenswürdig" zu „geprüft"? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Eingabeverarbeitung, Schutzbedarf, Schnittstellenverständnis und Qualität von Daten auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects safe input handling, protection needs, interface understanding, and data quality at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_03_Eingabevalidierung-und-Trust-Boundaries.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_03_Eingabevalidierung-und-Trust-Boundaries.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Secure Coding, Trust Boundaries, sichere Fehlerbehandlung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Bedrohungsmodellierung, Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance.

## Aufgabenstellung / Task

**DE:** Beschreibe alle Eingänge des Secure ServiceHarvester: die von Maschinen gemeldeten oder gesammelten Statusdaten, Dateiimport (z. B. CSV) und spätere API- oder CLI-Parameter. Behandle alle gesammelten und importierten Daten als nicht vertrauenswürdig. Definiere Validierungsregeln für `name`, `os` (Allowlist), `last_contact` und andere Datumswerte (Format und Plausibilität), `status` (Allowlist) sowie Dateipfade (Kanonisierung, erlaubtes Verzeichnis). Plane sichere Fehlermeldungen und Negativtests. Halte den Umfang im 1. Lehrjahr bewusst einfach.

**EN:** Describe all inputs of the Secure ServiceHarvester: the status data reported or collected from machines, file import (e.g. CSV), and later API or CLI parameters. Treat all collected and imported data as untrusted. Define validation rules for `name`, `os` (allow-list), `last_contact` and other dates (format and plausibility), `status` (allow-list), and file paths (canonicalization, allowed directory). Plan safe error messages and negative tests. Keep the scope deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Alle Eingangsarten des Dienstes sind benannt und je als Vertrauensgrenze markiert.
- **R-02:** Jede Eingangsart hat mindestens eine Validierungsregel, bevorzugt gegen eine Allowlist.
- **R-03:** Dateipfade werden vor der Prüfung kanonisiert und auf ein erlaubtes Verzeichnis begrenzt.
- **R-04:** Fehlermeldungen sind fachlich verständlich, zeigen aber keine internen Details.
- **R-05:** Es gibt mindestens einen negativen Test je kritischer Eingabeart; alle `Applicable`, `N/A` und `Open` Punkte tragen Begründung oder Evidenzpfad.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Eingaben an jeder Vertrauensgrenze prüfen, bevor sie verarbeitet werden.
- Fehlermeldungen dürfen keine Stack-Traces, Pfade, Verbindungszeichenketten oder internen Details zeigen.
- Freitexte gegen Log-Injection und überlange Inhalte begrenzen; keine echten personenbezogenen Daten, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Fehlermeldungen und Importfehler dürfen personenbezogene Testdaten nicht unnötig wiederholen oder offenlegen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielplattform unterscheidet gültige und ungültige Eingaben gleich.
- Validierungsfehler sind fachlich verständlich und technisch sparsam.
- Die Regeln gelten unabhängig davon, ob später Netzwerk-Sammlung, CLI, API oder Dateiimport umgesetzt wird; MSL-Status ersetzt keine Eingabe- und Fehlerbehandlungsprüfung.

## Erwartete Artefakte / Expected Artifacts

- Trust-Boundary-Liste mit allen Eingängen des Dienstes.
- Validierungsregel-Tabelle für `name`, `os`, `last_contact`, `status` und Dateipfade.
- Fehlermeldungsregeln (sicher gegenüber unsicher).
- negative Testfälle je kritischer Eingabeart.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Alle Eingangsarten sind benannt und als Vertrauensgrenze markiert.
- [ ] Jede Eingangsart hat mindestens eine Validierungsregel.
- [ ] Es gibt mindestens einen negativen Test je kritischer Eingabeart.
- [ ] Fehlermeldungen zeigen keine internen Details.
- [ ] Dateipfade werden kanonisiert und begrenzt.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_03_Eingabevalidierung-und-Trust-Boundaries.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Trust Boundaries, Behandlung gesammelter Daten als nicht vertrauenswürdig, Eingabevalidierung, sichere Fehlermeldungen, Dateipfadprüfung und negative Tests des Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
