# Lastenheft: Secure OrderDesk Application Track 04 - Query-, Filter- und Paginierungslogik

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE (Schwerpunkt)
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Für Listen von Bestellungen, Kunden und Produkten werden sichere Query-, Filter- und Paginierungsregeln entworfen. Lernende schützen Abfragen mit Feld-Whitelists und parametrisierten Zugriffen, wählen eine begründete Paginierungsstrategie und sichern deterministische Sortierung auf der Northwind-Bestelldomäne inkl. `ALFKI`.

**EN:** Safe query, filter, and pagination rules are designed for lists of orders, customers, and products. Learners protect queries with field whitelists and parameterized access, choose a justified pagination strategy, and ensure deterministic ordering on the Northwind ordering domain incl. `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welche Filter- und Paginierungslogik ist sicher, deterministisch und wartbar? |
| SI | mittel | Welche Last- oder Betriebsannahme folgt aus großen Bestellmengen? |
| DPA | mittel bis hoch | Welche Datenqualitäts- und Aussagegrenze hat ein gefiltertes Bestellergebnis? |
| DV | mittel | Welche Schnittstellenparameter beschreiben Filter und Seiten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet die Realisierung sicherer Abfragefunktionalität mit der Anpassung der Datenverwaltung der Bestellplattform.

**EN:** The task supports the AE specialization in year 3. It connects realizing secure query functionality with adapting the data management of the ordering platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Application Track trägt **LF 10a, LF 11a, LF 12a** (berührt LF 4, LF 5). Für diese Einheit ist **LF 11a („Funktionalität in Anwendungen realisieren")** primär; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_04_Query-Filter-und-Paginierungslogik.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Application Track carries **LF 10a, LF 11a, LF 12a** (touches LF 4, LF 5). For this unit **LF 11a ("Funktionalität in Anwendungen realisieren")** is primary; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_04_Query-Filter-und-Paginierungslogik.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Eingabevalidierung, sichere Architektur, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Entwirf eine sichere Query-, Filter- und Paginierungslogik für Bestell-, Kunden- und Produktlisten. Berücksichtige: erlaubte Filterfelder als Whitelist (z. B. `CustomerID`, `OrderDate`, `CategoryID`), parametrisierte Abfragen gegen SQL-Injection, eine begründete Paginierungsstrategie (Offset gegenüber Cursor), deterministische Sortierung mit eindeutigem Tiebreaker (z. B. `OrderID`), Obergrenzen für Seitengrößen und robustes Verhalten bei ungültigen Parametern. Trenne Fachlogik, Sicherheitsbezug und Nachweis.

**EN:** Design secure query, filter, and pagination logic for order, customer, and product lists. Consider: allowed filter fields as a whitelist (e.g. `CustomerID`, `OrderDate`, `CategoryID`), parameterized queries against SQL injection, a justified pagination strategy (offset versus cursor), deterministic ordering with a unique tiebreaker (e.g. `OrderID`), upper bounds for page sizes, and robust behavior on invalid parameters. Separate business logic, security aspect, and evidence.

## Anforderungen / Requirements

- **R-01:** Filterfelder, Sortierung und Paginierung sind klar und als Whitelist beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Die Paginierungsstrategie ist mit Trade-off (Offset gegenüber Cursor) begründet.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Der Abfragevertrag bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle Erweiterungen sind fiktiv.
- Filter-, Sortier- und Paginierungsparameter als nicht vertrauenswürdig behandeln und gegen eine Whitelist prüfen.
- Datenzugriffe nur parametrisiert; keine Zeichenkettenverkettung von Feldnamen oder Werten in Abfragen (SQL-Injection-Abwehr, CWE-89).
- Kundenbezogene Ergebnisfelder folgen der Datenminimierung; nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Abfragevertrag (Felder, Operatoren, Seitengrenzen) bleibt für alle Zielsprachen vergleichbar.
- Sprachspezifische Query-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Prüfung von Eingabevalidierung, Injection-Schutz und Ergebnisgrenzen.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Query-, Filter- und Paginierungslogik.
- `plan.md` mit Abfrage-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Filterfeld-Whitelist, Sortier- und Tiebreaker-Regel, Paginierungs-Trade-off, positive und negative Testfälle (inkl. `ALFKI`-Beispiel und ungültige Parameter), N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Filter, Sortierung und Paginierung sind konsistent, deterministisch und begründet.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Negativtestpfad für ungültige Parameter ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_04_Query-Filter-und-Paginierungslogik.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine sichere Query-, Filter- und Paginierungslogik auf der Northwind-Bestelldomäne (Kundenfirma Secure Trader, inkl. ALFKI) im Application Track der EuFPA-Lernreihe Secure OrderDesk Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
