# Lastenheft: Secure OrderDesk 04 - Datenschutz und Audit-Logging

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA, SI, AE
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Datenschutz der Kunden- und Bestelldaten sowie Betriebs- und Audit-Logging für Secure OrderDesk werden
so geplant, dass die Verarbeitung nachvollziehbar bleibt, ohne Secrets, vollständige Freitexte oder unnötige
personenbezogene Kundendaten zu protokollieren. Lernende trennen Betriebs-Log, Audit-Log und nutzerseitige
Fehlermeldung und beziehen sich auf die Northwind-Datenbasis inkl. `ALFKI`.

**EN:** Privacy of customer and order data as well as operational and audit logging for Secure OrderDesk are
planned so that processing stays traceable without recording secrets, complete free text, or unnecessary
personal customer data. Learners separate operational log, audit log, and user-facing error message and refer
to the Northwind data base including `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel bis hoch | Welche Implementierungsentscheidung für die Datenzugriffsschicht folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Datenbank- oder Sandbox-Annahme zum Logging muss dokumentiert werden? |
| DPA | hoch | Welche Kundendaten-Datenschutzfrage oder Aussagegrenze ist beim Protokollieren betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Schutzbedarf, Datenschutz der Kundendaten, nachvollziehbare Datenverarbeitung und
Betriebsdokumentation im Handelskontext auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects protection need, privacy of customer data, traceable data processing, and operational
documentation in a trading context at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_04_Datenschutz-und-Audit-Logging.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Basis"): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_04_Datenschutz-und-Audit-Logging.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, sichere Protokollierung, Trennung von Log-Ebenen, Review- und Evidenzpflicht.
- **Checklisten:** CL_01, CL_08, CL_09, CL_11.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Richtlinie Testmanagement, Leitlinie für sichere Programmierung.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Definiere für Secure OrderDesk, welche Ereignisse protokolliert werden: Kunde angelegt oder geändert,
Bestellung erfasst, Bestellposition geändert, Auswertung ausgeführt, Export durchgeführt, Anmeldeversuch einer
Rolle. Beschreibe getrennt ein Betriebs-Log (Ablauf und Fehler der Plattform, z. B. Datenbankfehler) und ein
Audit-Log (sicherheits- und fachrelevante Ereignisse an Kunden- und Bestelldaten). Lege fest, welche Daten je
Log erlaubt sind und welche nicht; personenbezogene Kundendaten aus Northwind (z. B. Kontaktname, Anschrift)
werden nicht ungefiltert geloggt. Nutze `ALFKI` nur als fiktiven Beispielanker. Halte die Plattform im 1.
Lehrjahr bewusst einfach.

**EN:** Define for Secure OrderDesk which events are logged: customer created or changed, order captured, order
line changed, report executed, export performed, role sign-in attempt. Describe separately an operational log
(platform flow and errors, e.g. database errors) and an audit log (security- and business-relevant events on
customer and order data). Define which data is allowed per log and which is not; personal customer data from
Northwind (e.g. contact name, address) is not logged unfiltered. Use `ALFKI` only as a fictional example
anchor. Keep the platform deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Audit- und Betriebs-Ereignisse sind als feste, benannte Liste beschrieben (Kunden-, Bestell- und Auswertungsereignisse).
- **R-02:** Erlaubte Log-Felder (Zweck, Zeitpunkt, Aktion, Rolle, technische Referenz wie `CustomerID`/`OrderID`) und verbotene Felder (Secrets, Tokens, vollständige Kundenanschrift, Kontaktname, vollständige Freitexte, unnötige personenbezogene Daten) sind getrennt.
- **R-03:** Log-Injection wird als Risiko behandelt; Steuerzeichen und Zeilenumbrüche aus Kunden-/Bestelleingaben werden sicher behandelt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine Secrets, Tokens, Zugangsdaten oder vollständigen Freitexte im Log; Beispielwerte nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Personenbezogene Kundendaten (Kontaktname, Anschrift, Telefon) werden nicht im Klartext protokolliert; statt vollständiger Werte wird eine technische Referenz wie `CustomerID` verwendet (Pseudonymisierung, Datenminimierung).
- Log-Injection verhindern, zum Beispiel durch Bereinigung von Zeilenumbrüchen und strukturiertes Logging.
- Nutzerseitige Fehlermeldungen und interne Logs trennen; keine internen Details wie SQL-Fehler, Tabellennamen oder Stack-Traces an Endnutzer.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren (z. B. zentrales SIEM, wenn keine Betriebsintegration geplant ist).

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Audit-Einträge sind strukturiert und in allen sechs Zielsprachen inhaltlich gleich.
- Das Log ist nachvollziehbar, aber nicht datenhungrig (Datensparsamkeit, Zweckbindung nach Kunden-/Bestellzweck).
- Jede Sprache behandelt Steuerzeichen in Logwerten sicher; Framework-Logging schreibt keine Secrets und keine vollständigen Kundendatensätze automatisch mit.
- MSL-Status ersetzt keine sichere Logging-, Datenschutz- oder Review-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Log-Architektur, Datenschutz-, Test- und Nachweispfaden für Kunden- und Bestelldaten.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Audit-Event-Liste, erlaubte/verbotene Log-Felder, Datenschutznotiz zu Kundendaten, Logging-Testfälle (inkl. `ALFKI`-Beispiel), N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Jedes Audit-Ereignis hat Zweck und erlaubte Felder; verbotene Inhalte (z. B. Kontaktname, Secrets) sind ausdrücklich genannt.
- [ ] Betriebs-Log, Audit-Log und nutzerseitige Fehlermeldung sind getrennt sichtbar.
- [ ] Log-Injection wird als Risiko behandelt und mit mindestens einem Test abgedeckt.
- [ ] Personenbezogene Kundendaten werden im Log minimiert oder pseudonymisiert; die Northwind-/`ALFKI`-Quelle ist als fiktiv benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert; nicht anwendbare Standards sind als `N/A` begründet.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_04_Datenschutz-und-Audit-Logging.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Datenschutz der Kundendaten, Betriebs- und Audit-Events, erlaubte und verbotene Log-Felder, Log-Injection-Schutz und Logging-Tests der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
