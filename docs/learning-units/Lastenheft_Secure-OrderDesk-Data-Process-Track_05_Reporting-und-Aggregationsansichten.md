# Lastenheft: Secure OrderDesk Data & Process Track 05 - Reporting und Aggregationsansichten

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DPA - Daten- und Prozessanalyse
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Aus den definierten Umsatz-Kennzahlen (Einheit 03) entstehen barrierefreie Reporting- und Aggregationsansichten. Lernende wählen begründete Aggregationsebenen (z. B. Warenkategorie, Land, Zeitfenster), gestalten Berichte adressatengerecht, übernehmen die Aussagegrenzen jeder Kennzahl in den Bericht und stellen sicher, dass Aggregation zugleich Datenschutz stärkt und keine einzelne Kundenfirma oder Person nachverfolgbar macht. Die Berichte stützen sich auf die Northwind-Datenbasis inkl. `ALFKI`.

**EN:** From the defined revenue metrics (unit 03), accessible reporting and aggregation views are created. Learners choose justified aggregation levels (e.g. product category, country, time window), design reports for their audience, carry the interpretation limits of every metric into the report, and ensure that aggregation also strengthens privacy and makes no individual customer company or person traceable. The reports build on the Northwind data base incl. `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welche Aggregationsebene beantwortet die Kundenfrage, ohne einzelne Kundenfirmen sichtbar zu machen? |
| AE | mittel | Welche Abfrage-, Gruppierungs- oder Darstellungslogik folgt aus der Reporting-Entscheidung? |
| SI | mittel | Welche Betriebslast oder Datenaktualität begrenzt die Berichtserzeugung? |
| DV | mittel | Welche Schnittstelle liefert die Rohdaten, und welche Aussagegrenze bringt sie mit? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet die Analyse und Gestaltung eines Auswertungsprozesses, adressatengerechtes und barrierefreies Reporting, Datenschutz durch Aggregation und auditfähige Dokumentation. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the DPA specialization in year 3. It connects the analysis and shaping of an evaluation process, audience-appropriate and accessible reporting, privacy through aggregation, and audit-ready documentation. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11c („Prozesse analysieren und gestalten")**; berührt LF 6 („Serviceanfragen bearbeiten"). Begründung: Reporting- und Aggregationsansichten gestalten den Auswertungsprozess, aus dem konkrete Serviceanfragen und Geschäftsentscheidungen entstehen. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_05_Reporting-und-Aggregationsansichten.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11c ("Prozesse analysieren und gestalten")**; touched LF 6 ("Serviceanfragen bearbeiten"). Rationale: reporting and aggregation views shape the evaluation process from which concrete service requests and business decisions arise. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_05_Reporting-und-Aggregationsansichten.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz durch Aggregation, Nachvollziehbarkeit, sichere Programmierung, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Datenschutz- und Aufbewahrungsdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Reporting und Aggregationsansichten eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: die Auswahl begründeter Aggregationsebenen (z. B. je Warenkategorie, Land oder Zeitfenster), die adressatengerechte Gestaltung je Bericht (wer liest ihn und für welche Entscheidung), die ausdrückliche Übernahme der Aussagegrenzen (aus Einheit 06) in jeden Bericht, Aggregation als Datenschutzmaßnahme (keine einzelne Kundenfirma oder Person nachverfolgbar, sinnvolle Mindestgruppengröße) sowie barrierefreie Darstellung (echte Tabellen mit Kopfzeile, keine reine Farbcodierung). Baue auf den Umsatz-Kennzahlen aus Einheit 03 auf. Nutze die Northwind-Datenbasis inkl. `ALFKI`; die Lösung bleibt sprachneutral.

**EN:** Prepare a focused specification for reporting and aggregation views for the DPA - Data and Process Analysis specialization. Consider: the choice of justified aggregation levels (e.g. per product category, country, or time window), audience-appropriate design per report (who reads it and for which decision), the explicit carrying-over of the interpretation limits (from unit 06) into every report, aggregation as a privacy measure (no individual customer company or person traceable, sensible minimum group size), and accessible presentation (real tables with a header row, no color-only coding). Build on the revenue metrics from unit 03. Use the Northwind data base incl. `ALFKI`; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Je Bericht sind Adressat, gestützte Entscheidung und enthaltene Kennzahlen klar benannt.
- **R-02:** Aggregationsebenen und eine sinnvolle Mindestgruppengröße sind begründet dokumentiert.
- **R-03:** Jede Kennzahl im Bericht trägt ihre Aussagegrenze; positive Aussagen tragen einen Nachweispfad.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-Daten sind fiktiv, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Aggregation so wählen, dass keine einzelne Kundenfirma und keine Einzelperson über kleine Gruppen re-identifizierbar wird.
- Positive Datenschutz-, Qualitäts- oder Aussagekraftbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Aggregationsebenen, Berichtsinhalten und Aussagegrenzen bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks für Gruppierung, Aggregation oder Darstellung dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, SQL-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Analyse-, Datenschutz-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Berichtskatalog (Adressat/Entscheidung/Kennzahlen), Aggregationsebenen-Tabelle mit Mindestgruppengröße, Aussagegrenzen je Kennzahl, A11Y-Prüfnotiz, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Jeder Bericht benennt Adressat, Entscheidung und Aussagegrenze der enthaltenen Kennzahlen.
- [ ] Aggregation schützt nachweislich vor Re-Identifikation einzelner Kundenfirmen oder Personen.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für barrierefreie Reporting- und Aggregationsansichten der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
