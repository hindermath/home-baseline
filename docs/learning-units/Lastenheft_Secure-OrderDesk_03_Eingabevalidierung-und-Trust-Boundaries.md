# Lastenheft: Secure OrderDesk 03 - Eingabevalidierung und Trust Boundaries

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Lernende können die Vertrauensgrenzen der Bestell-/Handelsplattform erkennen, eingehende Kunden-,
Produkt- und Bestelleingaben sowie importierte Northwind-Daten als nicht vertrauenswürdig behandeln, Eingaben
systematisch validieren und sichere Fehlermeldungen planen. Sie erkennen SQL-Injection als zentrale Gefahr an
Datenbank-Vertrauensgrenzen und verstehen parametrisierte Queries als Schutzmaßnahme.

**EN:** Learners can identify the trust boundaries of the ordering/trading platform, treat incoming customer,
product, and order input as well as imported Northwind data as untrusted, validate inputs systematically, and
plan safe error messages. They recognize SQL injection as a central threat at database trust boundaries and
understand parameterized queries as a countermeasure.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Validierung muss in der Kernlogik oder im Datenzugriff liegen und darf nicht nur an der Oberfläche stehen? |
| SI | hoch | Welche Eingaben kommen aus dem Formular, aus Dateiimport (CSV), aus der Datenbankschicht oder aus späteren API-/CLI-Parametern? |
| DPA | mittel bis hoch | Wie beeinflussen ungültige Bestell- oder Kundeneingaben spätere Auswertungen und den Datenschutz? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Eingabeverarbeitung, Schutzbedarf, Abwehr von SQL-Injection,
Schnittstellenverständnis und Qualität von Daten auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects safe input handling, protection needs, defense against SQL injection, interface
understanding, and data quality at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"):
**primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur
Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen:
`lernbegleiter/Secure-OrderDesk_03_Eingabevalidierung-und-Trust-Boundaries.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk
Base"): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5
("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions:
`lernbegleiter/Secure-OrderDesk_03_Eingabevalidierung-und-Trust-Boundaries.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Secure Coding, Trust Boundaries, parametrisierte SQL-Zugriffe, sichere Fehlerbehandlung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Bedrohungsmodellierung, Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance.

## Aufgabenstellung / Task

**DE:** Beschreibe alle Eingänge des Secure OrderDesk: Formular- oder Eingabefelder für Kunden- und
Bestelldaten, Dateiimport (z. B. CSV im Northwind-Layout), die Datenbank-Vertrauensgrenze sowie spätere API-
oder CLI-Parameter. Behandle alle eingegebenen und importierten Daten als nicht vertrauenswürdig. Definiere
Validierungsregeln für `CompanyName`/`ContactName` (Länge, erlaubte Zeichen), `Country`/`City` (Allowlist oder
Plausibilität), `OrderDate` (Format und Plausibilität, nicht in der Zukunft), `Quantity` (positive Ganzzahl),
`Discount` (Bereich 0 bis 1), `ProductID`/`CustomerID` (Existenz und referenzielle Integrität) sowie Dateipfade
(Kanonisierung, erlaubtes Verzeichnis). Plane für jeden Datenbankzugriff parametrisierte Queries statt
dynamisch zusammengesetztem SQL. Plane sichere Fehlermeldungen und Negativtests, auch für SQL-Injection-Muster.
Halte den Umfang im 1. Lehrjahr bewusst einfach.

**EN:** Describe all inputs of the Secure OrderDesk: form or entry fields for customer and order data, file
import (e.g. CSV in Northwind layout), the database trust boundary, and later API or CLI parameters. Treat all
entered and imported data as untrusted. Define validation rules for `CompanyName`/`ContactName` (length,
allowed characters), `Country`/`City` (allow-list or plausibility), `OrderDate` (format and plausibility, not
in the future), `Quantity` (positive integer), `Discount` (range 0 to 1), `ProductID`/`CustomerID` (existence
and referential integrity), and file paths (canonicalization, allowed directory). Plan parameterized queries
instead of dynamically assembled SQL for every database access. Plan safe error messages and negative tests,
including for SQL injection patterns. Keep the scope deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Alle Eingangsarten der Plattform sind benannt und je als Vertrauensgrenze markiert, einschließlich der Datenbank-Grenze.
- **R-02:** Jede Eingangsart hat mindestens eine Validierungsregel, bevorzugt gegen eine Allowlist oder einen definierten Wertebereich.
- **R-03:** Jeder Datenbankzugriff nutzt parametrisierte Queries; dynamisch aus Eingaben zusammengesetztes SQL ist ausgeschlossen. Dateipfade werden vor der Prüfung kanonisiert und auf ein erlaubtes Verzeichnis begrenzt.
- **R-04:** Fehlermeldungen sind fachlich verständlich, zeigen aber keine internen Details (kein Stack-Trace, keine SQL-Fehler, keine Verbindungszeichenketten).
- **R-05:** Es gibt mindestens einen negativen Test je kritischer Eingabeart, darunter ein SQL-Injection-Muster; alle `Applicable`, `N/A` und `Open` Punkte tragen Begründung oder Evidenzpfad.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Eingaben an jeder Vertrauensgrenze prüfen, bevor sie verarbeitet oder in eine Query gegeben werden.
- SQL-Injection wird durch parametrisierte Statements verhindert; kein dynamisches SQL aus nicht vertrauenswürdigem Input.
- Fehlermeldungen dürfen keine Stack-Traces, Pfade, SQL-Fragmente, Verbindungszeichenketten oder internen Details zeigen.
- Freitexte (z. B. `ContactName`) gegen Log-Injection und überlange Inhalte begrenzen; keine echten personenbezogenen Daten, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`. Fehler- und Importmeldungen dürfen Kundendaten nicht unnötig wiederholen oder offenlegen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielplattform unterscheidet gültige und ungültige Eingaben gleich und nutzt für Datenbankzugriffe parametrisierte Mechanismen der jeweiligen Sprache.
- Validierungsfehler sind fachlich verständlich und technisch sparsam.
- Die Regeln gelten unabhängig davon, ob später eine relationale DB, CLI, API oder Dateiimport umgesetzt wird; MSL-Status ersetzt keine Eingabe-, SQL- und Fehlerbehandlungsprüfung.

## Erwartete Artefakte / Expected Artifacts

- Trust-Boundary-Liste mit allen Eingängen der Plattform, einschließlich der Datenbank-Grenze.
- Validierungsregel-Tabelle für `CompanyName`, `ContactName`, `Country`/`City`, `OrderDate`, `Quantity`, `Discount`, `ProductID`/`CustomerID` und Dateipfade.
- Regel für parametrisierte Datenbankzugriffe mit einem Positiv- und einem Negativbeispiel (parametrisiert vs. dynamisch).
- Fehlermeldungsregeln (sicher gegenüber unsicher).
- negative Testfälle je kritischer Eingabeart, darunter mindestens ein SQL-Injection-Muster.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Alle Eingangsarten sind benannt und als Vertrauensgrenze markiert.
- [ ] Jede Eingangsart hat mindestens eine Validierungsregel.
- [ ] Jeder Datenbankzugriff ist parametrisiert; dynamisch zusammengesetztes SQL ist ausgeschlossen.
- [ ] Es gibt mindestens einen negativen Test je kritischer Eingabeart, darunter ein SQL-Injection-Muster.
- [ ] Fehlermeldungen zeigen keine internen Details; Dateipfade werden kanonisiert und begrenzt.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_03_Eingabevalidierung-und-Trust-Boundaries.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Trust Boundaries, Behandlung eingegebener und importierter Northwind-Daten als nicht vertrauenswürdig, Eingabevalidierung, parametrisierte SQL-Zugriffe gegen SQL-Injection, sichere Fehlermeldungen, Dateipfadprüfung und negative Tests des Secure OrderDesk. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
