# Lernbegleiter: Secure OrderDesk Data & Process Track 02 – Datenqualität in Bestellungen und Positionen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_02_Datenqualitaet-in-Bestellungen-und-Positionen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Umsatzzahlen sind nur so gut wie die Bestelldaten, aus denen sie entstehen. In dieser Einheit prüfst du die **Datenqualität** der Bestellungen (`Orders`) und Bestellpositionen (`Order Details`). Du misst die Qualität nach klaren Dimensionen: Vollständigkeit (fehlt ein Preis?), Aktualität (wie alt ist die Bestellung?), Genauigkeit (ist der Rabatt plausibel?), Konsistenz (passt die Position zu einer echten Bestellung und einem echten Produkt?) und Eindeutigkeit (gibt es Dubletten?). Der Pflicht-Datensatz `ALFKI` dient als fiktiver Beispielanker.

**EN:** Revenue figures are only as good as the order data they come from. In this unit you check the **data quality** of the orders (`Orders`) and order line items (`Order Details`). You measure quality along clear dimensions: completeness (is a price missing?), timeliness (how old is the order?), accuracy (is the discount plausible?), consistency (does the line item belong to a real order and a real product?), and uniqueness (are there duplicates?). The mandatory record `ALFKI` serves as a fictional example anchor.

**DE:** Wichtig ist die saubere Trennung: **Rohdaten bleiben unverändert**, jede Bereinigung wird getrennt, begründet und reproduzierbar protokolliert. So kann später jede Auswertung auf die Qualität zurückgeführt werden.

**EN:** The clean separation is important: **raw data stays unchanged**, every cleaning step is recorded separately, justified, and reproducibly. This way every later evaluation can be traced back to its quality basis.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Qualitätsdimension / Quality dimension | Messbare Eigenschaft der Daten, z. B. Vollständigkeit oder Konsistenz. |
| Plausibilitätsregel / Plausibility rule | Regel, die einen Wert auf Sinnhaftigkeit prüft, z. B. `Quantity > 0`. |
| Verwaiste Position / Orphan line item | `Order Details`-Zeile ohne gültige Bestellung oder ohne gültiges Produkt. |
| Dublette / Duplicate | Mehrfach vorhandener Datensatz, der eine Kennzahl verfälscht. |
| Bereinigungsprotokoll / Cleaning log | Nachvollziehbare, reproduzierbare Liste aller Korrekturen mit Begründung. |
| Roh-/Bereinigt-Trennung / Raw-cleaned separation | Getrennte Haltung von Originaldaten und ausgewerteten Daten. |
| Datenqualitätskennzahl / Data-quality metric | Zahl, die eine Qualitätsdimension messbar macht, z. B. Anteil vollständiger Positionen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Dimensionen wählen.** Lege fest, welche Qualitätsdimensionen für Bestellungen und Positionen zählen. Beispiel: Vollständigkeit (jede Position hat Preis und Menge), Konsistenz (jede Position verweist auf eine gültige Bestellung und ein gültiges Produkt), Eindeutigkeit (keine doppelten Positionen), Genauigkeit (Rabatt zwischen 0 und 1), Aktualität (Bestelldatum im erwarteten Zeitraum).

**EN:** **Step 1 – Choose dimensions.** Define which quality dimensions matter for orders and line items. Example: completeness (each line item has price and quantity), consistency (each line item references a valid order and product), uniqueness (no duplicate line items), accuracy (discount between 0 and 1), timeliness (order date within the expected period).

**DE:** **Schritt 2 – Je Dimension eine Kennzahl.** Ordne jeder Dimension eine messbare Zahl zu. Beispiel: Vollständigkeit = Anteil der Positionen mit gültigem `UnitPrice` und `Quantity`. Ohne Kennzahl bleibt „gute Qualität" eine Behauptung.

**EN:** **Step 2 – One metric per dimension.** Assign each dimension a measurable number. Example: completeness = share of line items with a valid `UnitPrice` and `Quantity`. Without a metric, "good quality" stays a claim.

**DE:** **Schritt 3 – Plausibilitätsregeln formulieren.** Schreibe die Regeln pro Feld auf: `Quantity > 0`, `UnitPrice > 0`, `0 <= Discount <= 1`, `OrderDate` nicht in der Zukunft, jede Position hat eine existierende `OrderID` und `ProductID`. Jede Regel ist ein späterer Test.

**EN:** **Step 3 – Formulate plausibility rules.** Write the rules per field: `Quantity > 0`, `UnitPrice > 0`, `0 <= Discount <= 1`, `OrderDate` not in the future, each line item has an existing `OrderID` and `ProductID`. Every rule becomes a later test.

**DE:** **Schritt 4 – Umgang mit Problemfällen.** Entscheide begründet, was mit fehlenden, fehlerhaften, veralteten, doppelten oder verwaisten Daten geschieht: sichtbar markieren, aus der Auswertung ausschließen oder als `Open` melden. **Nicht** still auffüllen – ein still ergänzter Preis verfälscht den Umsatz unbemerkt.

**EN:** **Step 4 – Handle problem cases.** Decide with justification what happens to missing, faulty, stale, duplicate, or orphan data: mark it visibly, exclude it from the evaluation, or report it as `Open`. Do **not** silently fill it – a silently added price falsifies revenue unnoticed.

**DE:** **Schritt 5 – Roh und bereinigt trennen.** Halte Originaldaten unverändert. Jede Bereinigung landet im Protokoll mit Regel, Begründung und betroffener Menge, sodass sie reproduzierbar ist. So bleibt jede spätere Umsatzzahl auf ihre Datenqualität zurückführbar.

**EN:** **Step 5 – Separate raw and cleaned.** Keep the original data unchanged. Every cleaning step goes into the log with rule, justification, and affected count, so it is reproducible. This way every later revenue figure remains traceable to its data quality.

**DE:** **Typische Fehler.** Fehlende Werte still auffüllen. Dubletten übersehen und Umsätze doppelt zählen. Verwaiste Positionen mitzählen. Rohdaten überschreiben. „Qualität ist gut" ohne Kennzahl behaupten.

**EN:** **Common mistakes.** Silently filling missing values. Overlooking duplicates and counting revenue twice. Counting orphan line items. Overwriting raw data. Claiming "quality is good" without a metric.

### Beispiel / Example

```text
Dimension        Kennzahl                                     Regel / Pruefung
Vollstaendigkeit Anteil Positionen mit UnitPrice und Quantity UnitPrice > 0 AND Quantity > 0
Genauigkeit      Anteil Positionen mit gueltigem Rabatt       0 <= Discount <= 1
Konsistenz       Anteil Positionen mit gueltiger Bestellung   OrderID existiert in Orders
Konsistenz       Anteil Positionen mit gueltigem Produkt      ProductID existiert in Products
Eindeutigkeit    Anteil eindeutiger (OrderID, ProductID)      keine Dublette je Kombination
Aktualitaet      Anteil Bestellungen mit gueltigem Datum      OrderDate <= heute

Fund: 3 verwaiste Positionen ohne Produkt -> aus Auswertung ausgeschlossen, als Open protokolliert
Rohdaten: unveraendert. Bereinigtes Set: 3 Positionen markiert, Begruendung im Protokoll.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c** ist primär, weil die Datenqualität einer kundenspezifischen Datenanalyse geprüft und gesichert wird; LF 5 ist berührt, weil Rohdaten und bereinigte Daten in der Datenhaltung getrennt verwaltet werden. LF 10c (maschinelles Lernen) passt hier nicht, weil kein Modell trainiert, sondern die Datenbasis bewertet wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c** is primary, because the data quality of a customer-specific data analysis is checked and secured; LF 5 is touched because raw and cleaned data are managed separately in the data storage. LF 10c (machine learning) does not fit here because no model is trained; instead the data basis is assessed.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Die Datenqualität der Handelsdaten wird als Grundlage der Analyse geprüft und gesichert. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Roh- und bereinigte Bestelldaten werden getrennt und nachvollziehbar verwaltet. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Eingabevalidierung, sichere Programmierung, Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungs- und Risikoblick), `CL_08` (Testbarkeit) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung dieser Einheit lautet: *Problemfälle werden sichtbar behandelt, niemals still aufgefüllt, und Rohdaten bleiben unverändert.* A11Y-Aspekt: Die Qualitätsdimensions-Tabelle und das Bereinigungsprotokoll müssen als echte Tabelle mit Kopfzeile lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: input validation, secure programming, testability, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat and risk view), `CL_08` (testability), and `CL_12` (evidence and closure). The data decision of this unit is: *problem cases are handled visibly, never silently filled, and raw data stays unchanged.* Accessibility aspect: the quality-dimension table and the cleaning log must be readable as real tables with a header row, without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum darf man einen fehlenden Positionspreis nicht still auffüllen? /
   **EN:** Why must you not silently fill a missing line-item price?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein still ergänzter Preis verfälscht den Umsatz unbemerkt. Der Fall muss sichtbar markiert oder ausgeschlossen und als `Open` protokolliert werden, damit die Aussagegrenze stimmt.
   **EN:** A silently added price falsifies revenue unnoticed. The case must be marked visibly or excluded and logged as `Open`, so the limit of validity is correct.

   </details>

2. **DE:** (DPA) Was ist eine verwaiste Position und warum ist sie ein Konsistenzproblem? /
   **EN:** (DPA) What is an orphan line item and why is it a consistency problem?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Position, deren `OrderID` oder `ProductID` auf keinen existierenden Datensatz verweist. Sie verletzt die Fremdschlüssel-Konsistenz und verfälscht Auswertungen, weil sie sich keiner echten Bestellung oder keinem Produkt zuordnen lässt.
   **EN:** A line item whose `OrderID` or `ProductID` references no existing record. It breaks foreign-key consistency and falsifies evaluations because it cannot be assigned to a real order or product.

   </details>

3. **DE:** Warum braucht jede Qualitätsdimension eine eigene Kennzahl? /
   **EN:** Why does each quality dimension need its own metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Kennzahl bleibt „gute Qualität" eine Behauptung. Erst eine messbare Zahl (z. B. Anteil vollständiger Positionen) macht die Qualität prüfbar und vergleichbar.
   **EN:** Without a metric, "good quality" stays a claim. Only a measurable number (e.g. share of complete line items) makes quality verifiable and comparable.

   </details>

4. **DE:** (DPA) Warum müssen Rohdaten unverändert bleiben? /
   **EN:** (DPA) Why must raw data stay unchanged?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur unveränderte Rohdaten erlauben es, jede Bereinigung nachzuvollziehen und rückgängig zu machen. Überschreibt man sie, verliert man die Prüfbarkeit und kann Fehler nicht mehr belegen.
   **EN:** Only unchanged raw data allows tracing and reverting every cleaning step. Overwriting it loses verifiability and makes errors impossible to evidence.

   </details>

5. **DE:** Wie erkennt man Dubletten in Bestellpositionen? /
   **EN:** How do you detect duplicates in order line items?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über die Eindeutigkeit der Kombination `(OrderID, ProductID)`. Kommt sie mehrfach vor, ist es eine Dublette, die den Umsatz doppelt zählen würde.
   **EN:** Via the uniqueness of the combination `(OrderID, ProductID)`. If it appears more than once, it is a duplicate that would count revenue twice.

   </details>

6. **DE:** (SI) Welche Betriebsbedingung erzeugt typischerweise Lücken in den Bestelldaten? /
   **EN:** (SI) Which operational condition typically creates gaps in the order data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein abgebrochener oder unvollständiger Importlauf. Nachweis: ein Importprotokoll oder ein Test, der fehlende Zeiträume sichtbar macht.
   **EN:** An aborted or incomplete import run. Evidence: an import log or a test that surfaces missing periods.

   </details>

7. **DE:** Warum ist ein reproduzierbares Bereinigungsprotokoll wichtig? /
   **EN:** Why is a reproducible cleaning log important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es macht jede Korrektur nachvollziehbar und wiederholbar. Andere können prüfen, ob die Bereinigung korrekt war, und dieselbe bereinigte Datenbasis erneut erzeugen.
   **EN:** It makes every correction traceable and repeatable. Others can check whether the cleaning was correct and reproduce the same cleaned data basis.

   </details>

8. **DE:** Wie dokumentierst du eine Qualitätsprüfung, die hier nicht anwendbar ist? /
   **EN:** How do you document a quality check that is not applicable here?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung. Beispiel: eine Geokoordinaten-Prüfung ist `N/A`, weil die Bestelldaten keine Koordinaten enthalten. So bleibt sichtbar, dass die Prüfung erwogen wurde.
   **EN:** As `N/A` with a short technical justification. Example: a geo-coordinate check is `N/A` because the order data contains no coordinates. This keeps visible that the check was considered.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] relevante Qualitätsdimensionen für Bestellungen und Positionen benennen.
- [ ] je Dimension eine messbare Kennzahl formulieren.
- [ ] Plausibilitätsregeln je Feld als Test aufschreiben.
- [ ] fehlende, fehlerhafte, doppelte und verwaiste Werte sichtbar behandeln.
- [ ] Rohdaten und bereinigte Daten getrennt und reproduzierbar halten.
- [ ] nicht anwendbare Prüfungen als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] name relevant quality dimensions for orders and line items.
- [ ] formulate a measurable metric per dimension.
- [ ] write down plausibility rules per field as a test.
- [ ] handle missing, faulty, duplicate, and orphan values visibly.
- [ ] keep raw and cleaned data separate and reproducible.
- [ ] document non-applicable checks as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Data-Process-Track_02_Datenqualitaet-in-Bestellungen-und-Positionen.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Data-Process-Track_02_Datenqualitaet-in-Bestellungen-und-Positionen.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
