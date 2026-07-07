# Lastenheft: Secure OrderDesk 07 - Testbarkeit und Qualität

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Tests werden als Sicherheits- und Lernnachweis für die Bestell-/Handelsplattform Secure OrderDesk geplant. Lernende unterscheiden fachliche Tests, negative Sicherheitstests, Datenschutztests und datenbankspezifische Tests wie parametrisierte Zugriffe und referentielle Integrität und dokumentieren offene Testlücken transparent.

**EN:** Tests are planned as security and learning evidence for the Secure OrderDesk ordering/trading platform. Learners distinguish functional tests, negative security tests, privacy tests, and database-specific tests such as parameterized access and referential integrity, and document open test gaps transparently.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welcher Fehlerfall der Bestellverarbeitung muss unbedingt automatisiert getestet werden? |
| SI | mittel bis hoch | Wie wird der Testlauf gegen die relationale Ablage in CI oder Sandbox reproduzierbar? |
| DPA | mittel bis hoch | Welche Kunden- und Bestelltestdaten sind realistisch, aber datenschutzfreundlich? |
| DV | mittel bis hoch | Welche Systemgrenze zwischen Bestelleingabe und Datenbank braucht einen eigenen Negativtest? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Qualitätsmanagement, Testmanagement, sichere Entwicklung und nachvollziehbare Ergebnisdokumentation für eine relationale Bestell-/Handelsplattform.

**EN:** The task connects quality management, test management, secure development, and traceable result documentation for a relational ordering/trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_07_Testbarkeit-und-Qualitaet.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_07_Testbarkeit-und-Qualitaet.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Testmanagement, Sicherheits-Code-Review, Testbarkeit und nachvollziehbare Evidenz.
- **Checklisten:** CL_08, CL_09, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Testmanagement, Leitlinie für sichere Programmierung, Kompetenzprofile und Schulungsplan.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Plane einen Testumfang für die Secure-OrderDesk-Plattform. Unterscheide fachliche Tests (Kunde anlegen, gültige Bestellung mit Positionen speichern, einfache Auswertung berechnen), negative Sicherheitstests (ungültige Bestelleingaben wie negative Mengen oder überhöhte Rabatte, SQL-Injektionsversuche in Eingabefeldern, Pfad- und Importgrenzen), Datenschutztests (fiktive Kunden- und Bestelldaten, Log-Regeln, Datenminimierung) und datenbankspezifische Tests, die parametrisierte Datenzugriffe und referentielle Integrität der Northwind-Daten (inkl. `ALFKI`) absichern. Definiere Testdaten ohne echte personenbezogene Daten. Halte den Testumfang im 1. Lehrjahr überschaubar.

**EN:** Plan a test scope for the Secure OrderDesk platform. Distinguish functional tests (create a customer, store a valid order with lines, compute a simple report), negative security tests (invalid order input such as negative quantities or excessive discounts, SQL injection attempts in input fields, path and import boundaries), privacy tests (fictitious customer and order data, log rules, data minimization), and database-specific tests that safeguard parameterized data access and referential integrity of the Northwind data (incl. `ALFKI`). Define test data without real personal data. Keep the test scope manageable in year 1.

## Anforderungen / Requirements

- **R-01:** Fachliche Tests, Sicherheitstests, Datenschutztests und datenbankspezifische Tests sind getrennt benannt.
- **R-02:** Jede sicherheitsrelevante Regel hat mindestens einen Negativtest (Fehlpfad), inkl. mindestens eines SQL-Injektions-Negativtests.
- **R-03:** Für den Datenzugriff sind mindestens ein Test für parametrisierte Queries und ein Test für referentielle Integrität benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Testidee bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Tests müssen Fehlpfade enthalten und dürfen keine Secrets enthalten; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Bestell- und Kundeneingaben gelten in Tests als nicht vertrauenswürdig und werden an der Vertrauensgrenze geprüft; dynamisches SQL aus Eingaben wird durch Negativtests ausgeschlossen.
- Testdaten sind fiktiv (Northwind-Layout inkl. `ALFKI`); Testberichte enthalten keine unnötigen personenbezogenen Daten.
- Nicht anwendbare Testarten oder Schwellen werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Zielsprachen-Umsetzung braucht vergleichbare Kernlogiktests für den Bestell-, Speicher- und Auswertungspfad.
- Sicherheitstests prüfen Fehlpfade, nicht nur Erfolgspfade; Testdaten bleiben zwischen Sprachen vergleichbar.
- Parametrisierte Datenzugriffe werden in jeder Sprache getestet; MSL-Status ersetzt keine Prüfung von Eingabe, I/O, Auth, SQL, Crypto, Logging oder Dependencies.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für den Testumfang dieser Aufgabe.
- `plan.md` mit Test-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Test-, Review- und Dokumentationsschritten.
- Testplan, Testfallliste, Mindestabdeckung für die Kernlogik und eine Liste offener Testlücken.
- Erwartete Evidenz: Testarten-Tabelle, Negativtest-Liste (inkl. SQL-Injektion), Testkommando je Sprache, N/A-/Open-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Fachliche Tests, Sicherheitstests, Datenschutztests und datenbankspezifische Tests sind getrennt sichtbar.
- [ ] Jede kritische Regel hat mindestens eine Testidee mit Fehlpfad, inklusive SQL-Injektionsschutz.
- [ ] Parametrisierter Datenzugriff und referentielle Integrität sind durch je einen Test abgedeckt.
- [ ] Offene Testlücken sind als `Open` oder `N/A` mit Begründung und Re-Evaluierungszeitpunkt notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_07_Testbarkeit-und-Qualitaet.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Testplan, fachliche Tests, negative Sicherheitstests (inkl. SQL-Injektion), Datenschutztests, Tests für parametrisierte Datenzugriffe und referentielle Integrität sowie offene Testlücken der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
