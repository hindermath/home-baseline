# Lastenheft: Secure OrderDesk Application Track 10 - Feature-Review, Trade-offs und Abschluss

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** AE - Anwendungsentwicklung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Die AE-Feature-Arbeit am Secure OrderDesk für Secure Trader wird in einem fachlichen und technischen Abschlussreview zusammengeführt. Lernende bewerten Entwurfsentscheidungen als bewusste Trade-offs, dokumentieren Restrisiken und offene Punkte auditfähig und formulieren eine begründete Übergabeempfehlung für die Bestell-/Handelsplattform.

**EN:** The AE feature work on the Secure OrderDesk for Secure Trader is consolidated in a technical and functional final review. Learners assess design decisions as conscious trade-offs, document residual risks and open points in an audit-ready way, and formulate a justified handover recommendation for the ordering/trading platform.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (primär) | Welche Entwurfsentscheidung war ein Trade-off und wie ist sie begründet? |
| SI | mittel | Welche Betriebs-, Datenbank- oder Übergaberisiken bleiben offen? |
| DPA | mittel | Welche Datenschutz- oder Datenqualitätsrisiken der Kunden-/Bestelldaten sind noch offen? |
| DV | mittel | Welche Schnittstellen- oder Systemgrenze braucht bei Übergabe besondere Aufmerksamkeit? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe schließt die kundenspezifische Anwendungsentwicklung im 3. Lehrjahr ab. Sie verbindet Ergebnisbewertung, Trade-off-Reflexion, Restrisiken und Übergabe mit auditfähiger Dokumentation und dem Anpassen der relationalen Datenverwaltung (Northwind-Bestelldomäne inkl. `ALFKI`).

**EN:** The task closes customer-specific application development in the third year. It connects result assessment, trade-off reflection, residual risks, and handover with audit-ready documentation and adapting the relational data management (Northwind ordering domain including `ALFKI`).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks", Application Track): **primär LF 12a („Kundenspezifische Anwendungsentwicklung durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen") und LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks", Application Track): **primary LF 12a ("Kundenspezifische Anwendungsentwicklung durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen") and LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, Restrisiko-Transparenz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für das Feature-Review, die Trade-off-Reflexion und den Abschluss des Secure OrderDesk Application Track eine fokussierte Spezifikation für die Spezialisierung AE - Anwendungsentwicklung. Berücksichtige: Zusammenführung der Feature-Ergebnisse aus den Einheiten 01–09 (API, Persistenz-Adapter, Query-/Filterlogik, Oberfläche, Fehlerbehandlung, Erweiterbarkeit, Serialisierung, Tests), Bewertung der wichtigsten Entwurfsentscheidungen als Trade-offs (Flexibilität, Sicherheit, Aufwand, Wartbarkeit, SQL-Sicherheit), Restrisiken und offene Punkte mit Folgeaktion sowie eine begründete Übergabeempfehlung. Der fachliche Datenvertrag (Customer, Product, Order, OrderLine inkl. `ALFKI`) bleibt sprachneutral; alle Daten bleiben fiktiv.

**EN:** Prepare a focused specification for the feature review, trade-off reflection, and closure of the Secure OrderDesk Application Track for the AE - Application Development specialization. Consider: consolidation of feature results from units 01–09 (API, persistence adapters, query/filter logic, interface, error handling, extensibility, serialization, tests), assessment of the key design decisions as trade-offs (flexibility, security, effort, maintainability, SQL security), residual risks and open points with follow-up, and a justified handover recommendation. The domain contract (Customer, Product, Order, OrderLine including `ALFKI`) stays language-neutral; all data stays fictitious.

## Anforderungen / Requirements

- **R-01:** Die Feature-Ergebnisse des Tracks sind zusammengeführt und bewertet.
- **R-02:** Die wichtigsten Entwurfsentscheidungen sind als begründete Trade-offs dokumentiert.
- **R-03:** Restrisiken, offene Punkte und Folgeaktionen sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-/`ALFKI`-Quelle ist als fiktiver Testanker benannt.
- **R-05:** Eine begründete Übergabeempfehlung liegt vor und verweist auf die vorhandenen Nachweise.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Kundendaten bleiben fiktiv (`ALFKI`).
- Ergebnisse, Konfiguration, Logs, Tests, SQL-Zugriffe und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen; sonst als Restrisiko führen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Reviewbericht, Trade-off-Tabelle und Übergabenotiz bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Belege dürfen genutzt werden, müssen aber begründet und einheitlich dokumentiert werden.
- Der fachliche Datenvertrag (Customer, Product, Order, OrderLine inkl. `ALFKI`) bleibt für alle sechs Sprachpfade gleich.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, SQL-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Review-, Trade-off-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Reviewbericht, Trade-off-Tabelle, Restrisiko- und Folgeaktionsliste, Übergabenotiz.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung AE ist klar sichtbar.
- [ ] Entwurfsentscheidungen sind als begründete Trade-offs sichtbar.
- [ ] Restrisiken und offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Eine begründete Übergabeempfehlung liegt vor.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für das Feature-Review, die Trade-off-Reflexion und den Abschluss der EuFPA-Lernreihe Secure OrderDesk Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
