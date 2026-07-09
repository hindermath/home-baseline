# Lernbegleiter: Secure OrderDesk Data & Process Track 03 – Umsatz-Kennzahlen und Betriebsmetriken / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_03_Umsatz-Kennzahlen-und-Betriebsmetriken.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Jetzt entstehen aus den bereinigten Handelsdaten (Einheit 02) echte **Umsatz-Kennzahlen und Betriebsmetriken**. Der Umsatz einer Bestellposition folgt der Formel `UnitPrice * Quantity * (1 - Discount)`. Klingt einfach – aber die Kunst liegt in der sauberen Definition: Jede Kennzahl braucht eine **Formel**, eine **Bezugsmenge** (den Nenner, z. B. „je Kategorie" oder „je Monat") und eine **Aussagegrenze**. Der Pflicht-Datensatz `ALFKI` dient als fiktiver Beispielanker.

**EN:** Now real **revenue metrics and operational metrics** are created from the cleaned trading data (unit 02). The revenue of a line item follows the formula `UnitPrice * Quantity * (1 - Discount)`. It sounds simple – but the art lies in the clean definition: every metric needs a **formula**, a **reference set** (the denominator, e.g. "per category" or "per month"), and a **limit of validity**. The mandatory record `ALFKI` serves as a fictional example anchor.

**DE:** Du unterscheidest drei Metrik-Typen: **Bestandsmetriken** (ein Zustand zu einem Zeitpunkt, z. B. Anzahl aktiver Kund*innen), **Flussmetriken** (Ereignisse über Zeit, z. B. Umsatz je Monat) und **Qualitätsmetriken** (Anteil, z. B. Anteil vollständiger Positionen). Zu jeder Kennzahl gehört, welche Entscheidung sie stützt – und welche Fehlinterpretation droht.

**EN:** You distinguish three metric types: **stock metrics** (a state at a point in time, e.g. number of active customers), **flow metrics** (events over time, e.g. revenue per month), and **quality metrics** (a share, e.g. share of complete line items). For every metric it matters which decision it supports – and which misinterpretation looms.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Umsatzformel / Revenue formula | `UnitPrice * Quantity * (1 - Discount)` je Position, danach summiert. |
| Bezugsmenge / Reference set | Der Nenner oder die Gruppierung einer Kennzahl, z. B. je Kategorie oder je Monat. |
| Bestandsmetrik / Stock metric | Zustand zu einem Zeitpunkt, z. B. Anzahl aktiver Kund*innen. |
| Flussmetrik / Flow metric | Ereignisse über einen Zeitraum, z. B. Bestellungen je Monat. |
| Qualitätsmetrik / Quality metric | Anteil an einer Grundmenge, z. B. Anteil vollständiger Positionen. |
| Aussagegrenze / Limit of validity | Grenze, bis zu der die Kennzahl belastbar ist. |
| Fehlinterpretation / Misinterpretation | Falscher Schluss, den eine Zahl nahelegt, aber nicht trägt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Kennzahl vollständig definieren.** Für jede Kennzahl notierst du Formel, Bezugsmenge und Aussagegrenze. Beispiel „Umsatz je Kategorie": Formel = Summe aus `UnitPrice * Quantity * (1 - Discount)` je Position, gruppiert über `Products.CategoryID`; Bezugsmenge = Kategorie; Aussagegrenze = Erlös, nicht Gewinn.

**EN:** **Step 1 – Define the metric completely.** For each metric you note formula, reference set, and limit of validity. Example "revenue per category": formula = sum of `UnitPrice * Quantity * (1 - Discount)` per line item, grouped over `Products.CategoryID`; reference set = category; limit of validity = earnings, not profit.

**DE:** **Schritt 2 – Rabatt korrekt behandeln.** Ein häufiger Fehler ist, den Rabatt zu vergessen. `UnitPrice * Quantity` ohne `(1 - Discount)` überschätzt den Umsatz. Fehlt der Rabatt in den Daten (Einheit 02), gilt die dort begründete Regel, nicht eine stille Annahme.

**EN:** **Step 2 – Handle discount correctly.** A common mistake is forgetting the discount. `UnitPrice * Quantity` without `(1 - Discount)` overestimates revenue. If the discount is missing in the data (unit 02), the rule justified there applies, not a silent assumption.

**DE:** **Schritt 3 – Metrik-Typ zuordnen.** Ordne jede Kennzahl einem Typ zu: Anzahl aktiver Kund*innen = Bestand, Umsatz je Monat = Fluss, Anteil vollständiger Positionen = Qualität. Der Typ bestimmt, wie du die Zahl liest und über welche Zeit du sie aggregierst.

**EN:** **Step 3 – Assign the metric type.** Assign each metric a type: number of active customers = stock, revenue per month = flow, share of complete line items = quality. The type determines how you read the number and over which time you aggregate it.

**DE:** **Schritt 4 – Entscheidung und Fehlinterpretation nennen.** Zu jeder Kennzahl schreibst du, welche Entscheidung sie stützt (z. B. „Top-Produkte für Sortimentsplanung") und mindestens eine Fehlinterpretation (z. B. „hoher Umsatz heißt nicht hoher Gewinn"; „durchschnittlicher Bestellwert verdeckt große und kleine Bestellungen").

**EN:** **Step 4 – Name the decision and the misinterpretation.** For each metric you write which decision it supports (e.g. "top products for range planning") and at least one misinterpretation (e.g. "high revenue does not mean high profit"; "average order value hides large and small orders").

**DE:** **Schritt 5 – Deterministisch testen.** Lege einen kleinen, wiederholbaren Northwind-Testfall an (inkl. `ALFKI`), bei dem du das Ergebnis von Hand kennst. Gleiche Eingabe muss in allen sechs Sprachen dieselbe Zahl ergeben. Achte auf Rundung und Zeitzone bei Zeitraum-Kennzahlen.

**EN:** **Step 5 – Test deterministically.** Create a small, repeatable Northwind test case (incl. `ALFKI`) where you know the result by hand. The same input must yield the same number in all six languages. Watch out for rounding and time zone in period metrics.

**DE:** **Typische Fehler.** Rabatt vergessen. Bezugsmenge (Nenner) nicht nennen. Durchschnitt ohne Streuung zeigen. Umsatz mit Gewinn verwechseln. Zeiträume unscharf abgrenzen. Positive Aussage ohne Nachweis.

**EN:** **Common mistakes.** Forgetting the discount. Not naming the reference set (denominator). Showing an average without spread. Confusing revenue with profit. Fuzzy period boundaries. Positive claim without evidence.

### Beispiel / Example

```text
Kennzahl              Formel                                        Bezugsmenge  Typ       Aussagegrenze
Umsatz je Kategorie   SUM(UnitPrice * Quantity * (1 - Discount))    Kategorie    Fluss     Erloes, nicht Gewinn
Top-Produkte          SUM(Umsatz) je ProductID, absteigend          Produkt      Fluss     nur Zeitraum der Daten
Bestellungen/Monat    COUNT(DISTINCT OrderID) je Monat              Monat        Fluss     Storno nicht abgezogen
Durchschn. Bestellwert SUM(Umsatz) / COUNT(DISTINCT OrderID)        gesamt       Fluss     verdeckt Ausreisser
Aktive Kund*innen     COUNT(DISTINCT CustomerID) mit Bestellung     Zeitfenster  Bestand   "aktiv" = Bestellung im Fenster

Beispieltest (ALFKI): Position 50218 -> 28: 45.60 * 15 * (1 - 0.05) = 649.80
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11c** ist primär, weil Kennzahlen einen Geschäfts- und Auswertungsprozess analysieren und gestalten; LF 6 ist berührt, weil aus den Kennzahlen konkrete Serviceanfragen und Geschäftsentscheidungen entstehen. LF 10c (maschinelles Lernen) passt hier nicht, weil keine Modelle, sondern definierte Kennzahlen berechnet werden.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11c** is primary, because metrics analyze and shape a business and evaluation process; LF 6 is touched because concrete service requests and business decisions arise from the metrics. LF 10c (machine learning) does not fit here because defined metrics, not models, are computed.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11c Prozesse analysieren und gestalten | Primär / Primary | Umsatz- und Betriebsmetriken analysieren und gestalten den Geschäftsprozess des Handels. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Aus den Kennzahlen entstehen konkrete Service- und Geschäftsentscheidungen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, Testbarkeit, Datenschutz und Nachvollziehbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Testbarkeit), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung dieser Einheit lautet: *Jede Kennzahl hat Formel, Bezugsmenge und Aussagegrenze; Datenzugriffe erfolgen über parametrisierte Queries.* A11Y-Aspekt: Der Kennzahlkatalog und die Interpretationstabelle müssen als echte Tabelle mit Kopfzeile lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure programming, testability, data protection, and traceability. Matching checklists: `CL_01` (standards applicability), `CL_08` (testability), `CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit is: *every metric has a formula, reference set, and limit of validity; data access uses parameterized queries.* Accessibility aspect: the metric catalog and the interpretation table must be readable as real tables with a header row, without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehört zu jeder Kennzahl eine Bezugsmenge (Nenner)? /
   **EN:** Why does every metric need a reference set (denominator)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Bezugsmenge ist eine Zahl nicht einordbar. „1000 Umsatz" sagt wenig; „1000 Umsatz je Kategorie im Juni" ist vergleichbar und interpretierbar.
   **EN:** Without a reference set a number cannot be placed. "1000 revenue" says little; "1000 revenue per category in June" is comparable and interpretable.

   </details>

2. **DE:** (DPA) Warum darf man den Rabatt in der Umsatzformel nicht vergessen? /
   **EN:** (DPA) Why must you not forget the discount in the revenue formula?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `UnitPrice * Quantity` ohne `(1 - Discount)` überschätzt den tatsächlichen Erlös. Der korrekte Umsatz je Position ist `UnitPrice * Quantity * (1 - Discount)`.
   **EN:** `UnitPrice * Quantity` without `(1 - Discount)` overestimates the actual earnings. The correct line-item revenue is `UnitPrice * Quantity * (1 - Discount)`.

   </details>

3. **DE:** (DPA) Was ist der Unterschied zwischen einer Bestands- und einer Flussmetrik? /
   **EN:** (DPA) What is the difference between a stock and a flow metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Bestandsmetrik misst einen Zustand zu einem Zeitpunkt (z. B. Anzahl aktiver Kund*innen), eine Flussmetrik misst Ereignisse über einen Zeitraum (z. B. Umsatz je Monat).
   **EN:** A stock metric measures a state at a point in time (e.g. number of active customers), a flow metric measures events over a period (e.g. revenue per month).

   </details>

4. **DE:** Warum nennt man zu jeder Kennzahl eine Fehlinterpretation? /
   **EN:** Why name a misinterpretation for every metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil Zahlen leicht falsch gelesen werden. „Hoher Umsatz" heißt nicht „hoher Gewinn". Die genannte Fehlinterpretation schützt Betrachtende vor falschen Entscheidungen.
   **EN:** Because numbers are easily misread. "High revenue" does not mean "high profit". The named misinterpretation protects viewers from wrong decisions.

   </details>

5. **DE:** Warum verdeckt ein durchschnittlicher Bestellwert wichtige Information? /
   **EN:** Why does an average order value hide important information?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Durchschnitt glättet Ausreißer: sehr große und sehr kleine Bestellungen verschwinden in einer Zahl. Ohne Streuung oder Verteilung wirkt das Bild einheitlicher, als es ist.
   **EN:** An average smooths outliers: very large and very small orders disappear into one number. Without spread or distribution the picture looks more uniform than it is.

   </details>

6. **DE:** (SI) Warum muss ein Kennzahltest deterministisch sein? /
   **EN:** (SI) Why must a metric test be deterministic?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur ein deterministischer Test liefert bei gleicher Eingabe immer dieselbe Zahl. So lässt sich die Kennzahl über alle sechs Sprachen vergleichen und Rundungs- oder Zeitzonenfehler aufdecken.
   **EN:** Only a deterministic test always yields the same number for the same input. This allows comparing the metric across all six languages and reveals rounding or time-zone errors.

   </details>

7. **DE:** (DV) Warum kann die Zeitzone eine Zeitraum-Kennzahl verändern? /
   **EN:** (DV) Why can the time zone change a period metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Bestellung nahe Mitternacht kann je Zeitzone in einen anderen Tag oder Monat fallen. Ohne feste Zeitbasis unterscheiden sich die Zeitraum-Summen zwischen Systemen.
   **EN:** An order near midnight can fall into a different day or month depending on the time zone. Without a fixed time basis the period sums differ between systems.

   </details>

8. **DE:** Wie dokumentierst du eine Kennzahl, die hier nicht anwendbar ist? /
   **EN:** How do you document a metric that is not applicable here?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung. Beispiel: eine Gewinnmarge ist `N/A`, weil Einkaufspreise nicht in der Datenbasis sind. So bleibt sichtbar, dass die Kennzahl erwogen wurde.
   **EN:** As `N/A` with a short technical justification. Example: a profit margin is `N/A` because purchase prices are not in the data basis. This keeps visible that the metric was considered.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Kennzahl mit Formel, Bezugsmenge und Aussagegrenze definieren.
- [ ] den Rabatt korrekt in der Umsatzformel berücksichtigen.
- [ ] Bestands-, Fluss- und Qualitätsmetriken unterscheiden.
- [ ] zu jeder Kennzahl eine gestützte Entscheidung und eine Fehlinterpretation nennen.
- [ ] eine Kennzahl deterministisch mit fiktiven Northwind-Daten testen.
- [ ] nicht anwendbare Kennzahlen als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] define a metric with formula, reference set, and limit of validity.
- [ ] account for the discount correctly in the revenue formula.
- [ ] distinguish stock, flow, and quality metrics.
- [ ] name a supported decision and a misinterpretation for every metric.
- [ ] test a metric deterministically with fictional Northwind data.
- [ ] document non-applicable metrics as `N/A` with a justification.

## Kaufmännische Rollen-Umschaltung / Commercial Role Switch

**DE:** Diese Track-Einheit ist die **KDM-Vertiefung** für Umsatz-Kennzahlen und Betriebsmetriken
(Grundlage:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).

- **KDM (Authoring, Kernkompetenz):** Schreibe mehrere parametrisierte **Kennzahl-Abfragen** selbst
  (z. B. Umsatz je Kunde/Monat, Bestellhäufigkeit) und bereite sie als belastbare **Datenaussage** auf.
  Benenne pro Kennzahl die Aussagegrenze und die Datenquelle.
- **KITSM (optional, lesend):** Nutze die Kennzahlen für Kosten/Nutzen und Service-Entscheidungen.
- **Abnahme (evidenzbasiert), eingebaute Abweichung:** Eine Aggregation **verdeckt eine
  Datenqualitätslücke** (z. B. fehlende Monate zählen als 0 statt „unbekannt"). Finde sie und korrigiere
  die Aussage, bevor du sie freigibst.

**EN:** This track unit is the **KDM deepening** for revenue key figures and operational metrics (basis:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
KDM authors several parameterized key-figure queries (e.g. revenue per customer/month) and prepares them
as a defensible data statement, naming each figure's limit and source. KITSM optionally uses the figures
for cost/benefit and service decisions. Evidence-based acceptance: one aggregation hides a data-quality
gap (e.g. missing months counted as 0 instead of "unknown") — find it and correct the statement before
release.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Data-Process-Track_03_Umsatz-Kennzahlen-und-Betriebsmetriken.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Data-Process-Track_03_Umsatz-Kennzahlen-und-Betriebsmetriken.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
