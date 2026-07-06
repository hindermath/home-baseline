# Lastenheft: Secure ServiceHarvester 02 - Domänenmodell: Maschinen, Snapshots und Zustände

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können ein kleines Domänenmodell aus Maschinen-Stammdaten und zeitlichen Snapshots sicher beschreiben, erlaubte Maschinen-Zustände definieren und ungültige Zustandswechsel als Risiko erkennen. Sie unterscheiden dauerhafte Stammdaten von zeitlich veränderlichen Statusdaten.

**EN:** Learners can securely describe a small domain model of machine master data and time-based snapshots, define allowed machine states, and identify invalid state transitions as a risk. They distinguish persistent master data from time-varying status data.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Zustands- oder Snapshot-Regel gehört ins Domänenmodell und nicht erst in die Oberfläche? |
| SI | hoch | Welche betriebsnahen Felder (z. B. `os`, `last_contact`) helfen im Betrieb, ohne den Datenschutz zu belasten? |
| DPA | mittel bis hoch | Welche Datenqualität in Stammdaten und Snapshots brauchst du für spätere Kennzahlen? |
| DV | mittel bis hoch | Wie trennst du dauerhafte Maschinen-Stammdaten von den über das Netz gemeldeten Snapshots? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, Anwendungslogik, Informationssicherheit und nachvollziehbare Dokumentation auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects data management, application logic, information security, and traceable documentation at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_02_Domaenenmodell-Maschinen-Snapshots-und-Zustaende.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_02_Domaenenmodell-Maschinen-Snapshots-und-Zustaende.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Code-Erzeugung, Datenschutz durch Datenminimierung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Architektur- und Modellentscheidungen, Datenschutz- und Nachweisdokumente nach Bedarf.
- **Presets:** architecture-governance, isaqb-architecture-governance, security-governance.

## Aufgabenstellung / Task

**DE:** Definiere die Entitäten `Machine` (Stammdaten: z. B. `id`, `name`, `os`), `Snapshot` (zeitlicher Zustand: z. B. `machineRef`, `collectedAt`, `last_contact`, `status`) und `AuditEntry` (Nachweis über Änderungen). Lege Pflichtfelder, optionale Felder und erlaubte Zustandsübergänge fest. Beispiel-Maschinenzustände sind `unknown`, `online`, `stale` und `offline`. Beschreibe das Master-Detail-Muster zwischen `Machine` und ihren `Snapshot`-Einträgen sowie das Snapshot-/Audit-Muster. Halte das Modell im 1. Lehrjahr bewusst klein.

**EN:** Define the entities `Machine` (master data: e.g. `id`, `name`, `os`), `Snapshot` (time-based state: e.g. `machineRef`, `collectedAt`, `last_contact`, `status`), and `AuditEntry` (evidence of changes). Define mandatory fields, optional fields, and allowed state transitions. Example machine states are `unknown`, `online`, `stale`, and `offline`. Describe the master-detail pattern between `Machine` and its `Snapshot` entries and the snapshot/audit pattern. Keep the model deliberately small in year 1.

## Anforderungen / Requirements

- **R-01:** Jede Entität hat einen klaren Zweck, Pflichtfelder und optionale Felder.
- **R-02:** Erlaubte Maschinen-Zustände und ihre Übergänge sind vollständig als Matrix oder Liste beschrieben.
- **R-03:** Verbotene Zustandswechsel sind ausdrücklich genannt und begründet.
- **R-04:** Das Master-Detail-Verhältnis (`Machine` zu `Snapshot`) und die Trennung von Audit-Daten sind dokumentiert.
- **R-05:** Das Modell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar; alle `Applicable`, `N/A` und `Open` Punkte tragen Begründung oder Evidenzpfad.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine Zustandsänderung darf allein durch einen ungeprüften Eingabewert oder einen rohen gesammelten Wert erfolgen.
- Interne IDs dürfen keine personenbezogenen Informationen enthalten; `Machine` und `Snapshot` enthalten nur Lern- und Testdaten.
- Snapshots speichern nur benötigte Statusfelder (Datenminimierung); keine Tastatureingaben, Dateiinhalte oder Standortdaten von Personen.
- Audit-Daten werden von fachlichen Statusdaten getrennt beschrieben; keine echten personenbezogenen Daten, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle Zielsprachen verwenden dieselben Entitäten, Felder und Zustandsregeln.
- Sprachspezifische Typen (Records, Structs, Dataclasses, Enums) sind erlaubt, ändern aber nicht den fachlichen Vertrag.
- Fehlerfälle (z. B. ungültiger Statuswert) müssen modelliert werden, nicht nur Erfolgspfade; MSL-Status ersetzt keine Modell- und Datenschutzprüfung.

## Erwartete Artefakte / Expected Artifacts

- Entitätenliste mit Feldern für `Machine`, `Snapshot` und `AuditEntry`.
- Zustandsdiagramm oder tabellarische Zustandsmatrix für die Maschinen-Zustände.
- Liste ungültiger Zustandswechsel mit kurzer Begründung.
- Beschreibung des Master-Detail- und Snapshot-/Audit-Musters.
- erste Modell-Testideen für erlaubte und verbotene Übergänge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Jede Entität hat Zweck, Pflichtfelder und optionale Felder.
- [ ] Jeder erlaubte Maschinen-Zustand ist erklärt.
- [ ] Verbotene Zustandswechsel sind ausdrücklich genannt.
- [ ] Das Modell speichert keine unnötigen personenbezogenen Daten.
- [ ] Master-Detail und Audit-Trennung sind nachvollziehbar dokumentiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_02_Domaenenmodell-Maschinen-Snapshots-und-Zustaende.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für das sprachneutrale Domänenmodell aus Maschinen-Stammdaten, zeitlichen Snapshots, Audit-Trennung, erlaubten und verbotenen Zustandswechseln sowie Datenminimierung des Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
