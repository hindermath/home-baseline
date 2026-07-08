# Lastenheft: Secure OrderDesk Data & Process Track 07 - Anomalie- und Lückenerkennung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA (Schwerpunkt)
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Anomalien (z. B. eine negative Menge, ein Rabatt über 100 %, ein Bestelldatum in der Zukunft, ein Positionspreis von null, ein plötzlicher Umsatzsprung eines Kunden) und Lücken (fehlende Bestellungen in einem Zeitraum, Bestellungen ohne Positionen) in den Secure-OrderDesk-Handelsdaten werden erkannt, unterschieden und begründet gemeldet. Lernende wählen zwischen einfachen Schwellenwertregeln und Werkzeugen des maschinellen Lernens und wägen Falsch-Positive gegen Falsch-Negative ab.

**EN:** Anomalies (e.g., a negative quantity, a discount above 100%, an order date in the future, a line-item price of zero, a sudden revenue jump of a customer) and gaps (missing orders in a period, orders without line items) in the Secure OrderDesk trading data are detected, distinguished, and reported with justification. Learners choose between simple threshold rules and machine-learning tools and weigh false positives against false negatives.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel | Wie kapselt der Code eine Anomalieregel für Bestellungen testbar und ohne Fehlalarm-Flut? |
| SI | mittel bis hoch | Welche Betriebs- oder Importlücke (Ausfall, Teilimport, Datenstand) erzeugt scheinbare Anomalien? |
| DPA | hoch | Welche Anomalie ist echt, welche ist ein Datenartefakt, und wie belegt man das? |
| DV | mittel bis hoch | Welche Schnittstellen- oder Übertragungslücke verursacht fehlende Bestellungen oder Positionen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet Mustererkennung in Bestell- und Umsatzdaten, sichere Entwicklung und begründete Meldelogik mit auditfähiger Dokumentation und baut auf der v2-Baseline (Jahr 2) auf.

**EN:** The task supports the DPA specialization in year 3. It connects pattern detection in order and revenue data, secure development, and justified alerting logic with audit-ready documentation, building on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Data & Process Track trägt **LF 10c, LF 11c, LF 12c** (berührt LF 5, LF 6). Für diese Einheit ist **LF 10c („Werkzeuge des maschinellen Lernens einsetzen")** primär; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Begründung: Anomalie- und Lückenerkennung in Bestelldaten ist ein klassischer Einsatzfall für ML- und Schwellenwert-Werkzeuge; die relationale Datenhaltung von Secure OrderDesk (LF 5) liefert die auswertbaren Bestellungen und Positionen. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Data & Process Track carries **LF 10c, LF 11c, LF 12c** (touches LF 5, LF 6). For this unit **LF 10c ("Werkzeuge des maschinellen Lernens einsetzen")** is primary; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Rationale: anomaly and gap detection in order data is a classic use case for ML and threshold tools; the relational data storage of Secure OrderDesk (LF 5) provides the evaluable orders and line items. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Anomalie- und Lückenerkennung in den Secure-OrderDesk-Handelsdaten eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Definiere zunächst eine Baseline (was ist eine normale Bestellung?), unterscheide echte Anomalien (z. B. negativer Umsatz, Rabatt über 100 %) von Datenartefakten (z. B. Rundung, offene Bestellung) und benenne Lücken (fehlende Bestellungen im Zeitraum, Positionen ohne Preis) getrennt von auffälligen Werten. Lege je Erkennungsregel fest, ob sie ein einfacher Schwellenwert oder ein ML-Werkzeug ist, welche Falsch-Positiv-/Falsch-Negativ-Rate erwartet wird und wie ein Alarm belegt wird. Stütze die Auswertung auf die Northwind-Datenbasis inkl. `ALFKI`; die Lösung bleibt sprachneutral. Anomalien aus nicht vertrauenswürdigen Daten dürfen nie ungeprüft eine Aktion auslösen.

**EN:** Prepare a focused specification for anomaly and gap detection in the Secure OrderDesk trading data for the DPA - Data and Process Analysis specialization. Consider: first define a baseline (what is a normal order?), distinguish real anomalies (e.g., negative revenue, discount above 100%) from data artifacts (e.g., rounding, open order), and name gaps (missing orders in the period, line items without a price) separately from unusual values. For each detection rule, define whether it is a simple threshold or an ML tool, which false-positive/false-negative rate is expected, and how an alert is evidenced. Base the evaluation on the Northwind data base incl. `ALFKI`; the solution stays language-neutral. Anomalies derived from untrusted data must never trigger an action unchecked.

## Anforderungen / Requirements

- **R-01:** Baseline, Anomaliearten und Lückenarten für Bestellungen und Positionen sind klar beschrieben und getrennt benannt.
- **R-02:** Je Erkennungsregel sind Verfahren (Schwellenwert oder ML-Werkzeug), erwartete Fehlerrate und Meldeweg dokumentiert.
- **R-03:** Test-, Review- oder Evidenzpfade für Alarme und für Falsch-Positive sind benannt; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten verwenden; die Northwind-Daten inkl. `ALFKI` und alle Erweiterungen sind fiktiv; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Eingaben, Zeitstempel, Bestellungen, Positionen, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Datenbankzugriffe für die Erkennung erfolgen ausschließlich über parametrisierte Queries; kein dynamisches SQL aus nicht vertrauenswürdigem Filter-Input.
- Anomalien aus nicht vertrauenswürdigen Daten lösen keine automatische Aktion ohne Prüfung aus.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Baseline, Anomalie- und Lückenregeln bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Bibliotheken für Statistik oder ML dürfen gewählt, müssen aber begründet und in der Lieferkette bewertet werden.
- MSL-Status ersetzt keine sichere API-, SQL-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Analyse-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Baseline-Definition, Anomalie-/Lücken-Regeltabelle, Fehlerraten-Abschätzung, Beispiel-Alarm mit Nachweis, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Echte Anomalien, Datenartefakte und Lücken sind getrennt sichtbar.
- [ ] Je Regel sind Verfahren, erwartete Fehlerrate und Nachweisweg benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Anomalie- und Lückenerkennung der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) im Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
