# Lernbegleiter: Secure OrderDesk 10 – Auswertungen und Kennzahlen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_10_Auswertungen-und-Kennzahlen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Handelsfirma **Secure Trader** möchte aus ihren Bestelldaten lernen: „Welche Warenkategorie bringt
den meisten Umsatz? Welche Produkte laufen am besten? Wie viele Bestellungen kommen pro Monat?" In dieser
Einheit leitest du solche **Auswertungen und Kennzahlen** aus den Handelsdaten ab. Typische Beispiele sind
**Umsatz je Kategorie**, **Top-Produkte** (nach Umsatz oder Menge) und **Bestell-KPIs** wie Bestellungen je
Zeitraum oder durchschnittlicher Bestellwert. Grundlage ist die klassische Northwind-Sample-Datenbank inklusive
des Pflicht-Datensatzes `ALFKI` (Alfreds Futterkiste). Kennzahlen verdichten viele Zeilen zu wenigen Zahlen –
aber nur, wenn man ihre **Grenzen** kennt. Ein Rabatt, ein fehlender Preis oder ein kurzer Zeitraum kann eine
Zahl stark verändern.

**EN:** The trading company **Secure Trader** wants to learn from its order data: "Which product category brings
the most revenue? Which products sell best? How many orders arrive per month?" In this unit you derive such
**evaluations and metrics** from the trading data. Typical examples are **revenue per category**, **top
products** (by revenue or quantity), and **order KPIs** such as orders per period or average order value. The
foundation is the classic Northwind sample database including the mandatory record `ALFKI` (Alfreds
Futterkiste). Metrics condense many rows into a few numbers – but only if you know their **limits**. A
discount, a missing price, or a short period can change a number strongly.

**DE:** In dieser Einheit definierst du je Kennzahl den Zweck, eine sprachneutrale Formel und die
**Aussagegrenzen**. Gleichzeitig achtest du auf Datenschutz und sichere Datenzugriffe: Auswertungen bleiben
aggregiert und erlauben keine Rückschlüsse auf einzelne echte Personen, und Datenbankzugriffe laufen über
parametrisierte Queries. Alle Testdaten sind fiktiv und wiederholbar; fehlende oder fehlerhafte Werte werden
sichtbar behandelt, nicht stillschweigend gefüllt. Die Auswertung bleibt im 1. Lehrjahr bewusst einfach.

**EN:** In this unit you define, per metric, the purpose, a language-neutral formula, and the **limits of
interpretation**. At the same time you watch privacy and secure data access: evaluations stay aggregated and
allow no conclusions about individual real people, and database access runs via parameterized queries. All test
data is fictitious and repeatable; missing or faulty values are handled visibly, not filled silently. The
evaluation stays deliberately simple in year 1.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Auswertung / Evaluation | Zielgerichtete Zusammenfassung von Daten zu einer Aussage. |
| Kennzahl / Metric | Verdichteter Zahlenwert, der einen Aspekt des Geschäfts beschreibt. |
| KPI / KPI | Zentrale Steuerungskennzahl (Key Performance Indicator), z. B. Bestellungen je Zeitraum. |
| Umsatz je Kategorie / Revenue per category | Summe aus Menge x Einzelpreis (abzüglich Rabatt) je Warenkategorie. |
| Top-Produkte / Top products | Produkte mit dem höchsten Umsatz oder der höchsten Menge. |
| Aggregation / Aggregation | Zusammenfassen vieler Zeilen (z. B. `SUM`, `COUNT`, `AVG`) zu einem Wert. |
| Aussagegrenze / Limit of interpretation | Grenze dessen, was eine Kennzahl wirklich aussagt. |
| Datenminimierung / Data minimization | Nur die wirklich benötigten Datenfelder auswerten. |
| Parametrisierte Query / Parameterized query | DB-Abfrage mit Platzhaltern statt zusammengesetztem SQL-Text; schützt vor SQL-Injection. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Frage und Zweck klären.** Beginne mit der Geschäftsfrage: „Welche Kategorie bringt den
meisten Umsatz?" Lege je Kennzahl den Zweck fest. Warum? Eine Kennzahl ohne klaren Zweck wird leicht falsch
verwendet oder überinterpretiert.

**EN:** **Step 1 – Clarify question and purpose.** Start with the business question: "Which category brings the
most revenue?" Set a purpose per metric. Why? A metric without a clear purpose is easily misused or
over-interpreted.

**DE:** **Schritt 2 – Sprachneutrale Formel festlegen.** Beschreibe je Kennzahl eine sprachneutrale Formel,
z. B. Umsatz je Kategorie = `SUMME(Menge x Einzelpreis x (1 - Rabatt))` gruppiert nach Kategorie, oder
Bestellungen je Monat = `ANZAHL(Bestellungen)` gruppiert nach Monat. Warum sprachneutral? Alle sechs
Zielsprachen müssen dieselben fiktiven Northwind-Daten gleich auswerten; nur so sind Ergebnisse vergleichbar.

**EN:** **Step 2 – Define a language-neutral formula.** Describe a language-neutral formula per metric, e.g.
revenue per category = `SUM(quantity x unit_price x (1 - discount))` grouped by category, or orders per month =
`COUNT(orders)` grouped by month. Why language-neutral? All six target languages must evaluate the same
fictitious Northwind data equally; only then are results comparable.

**DE:** **Schritt 3 – Sichere Datenzugriffe nutzen.** Auswertungen greifen auf die Datenbank zu. Nutze
**parametrisierte Queries** mit Platzhaltern für Filter wie Zeitraum oder Kategorie. Warum? Wer Filterwerte in
den SQL-Text einbaut, öffnet SQL-Injection. Parametrisierte Zugriffe trennen Abfrage und Daten sauber.

**EN:** **Step 3 – Use secure data access.** Evaluations query the database. Use **parameterized queries** with
placeholders for filters such as period or category. Why? Building filter values into the SQL text opens SQL
injection. Parameterized access cleanly separates query and data.

**DE:** **Schritt 4 – Datenqualität und fehlende Werte sichtbar behandeln.** Entscheide, wie fehlende,
fehlerhafte oder offene Werte behandelt werden (z. B. Positionen ohne Preis, ein noch nicht abgeschlossener
Monat). Warum? Wer fehlende Werte stillschweigend füllt oder rät, verfälscht den Umsatz und täuscht
Vollständigkeit vor. Markiere unvollständige Zeiträume und zähle sie sichtbar.

**EN:** **Step 4 – Handle data quality and missing values visibly.** Decide how missing, faulty, or open values
are handled (e.g. order lines without a price, a month not yet closed). Why? Silently filling or guessing
missing values distorts the revenue and fakes completeness. Mark incomplete periods and count them visibly.

**DE:** **Schritt 5 – Aussagegrenzen und Datenschutz benennen.** Jede Kennzahl bekommt eine Aussagegrenze und
einen Hinweis auf mögliche Fehlinterpretationen (z. B. „Top-Produkte über nur einen Monat sind nicht
repräsentativ"). Auswertungen bleiben aggregiert; sie dürfen keine Rückschlüsse auf einzelne echte Personen
erlauben und enthalten keine vertraulichen Kundendetails. Warum? Zahlen wirken objektiv, sind es aber nur, wenn
ihre Grenzen mitgenannt werden – und Datenschutz gilt auch für Geschäftsauswertungen.

**EN:** **Step 5 – Name limits of interpretation and privacy.** Every metric gets a limit of interpretation and
a note on possible misinterpretation (e.g. "top products over a single month are not representative").
Evaluations stay aggregated; they must not allow conclusions about individual real people and contain no
confidential customer details. Why? Numbers look objective but are only so if their limits are stated – and
privacy applies to business evaluations too.

**DE:** **Typische Fehler.** Umsatz ohne Rabatt rechnen. Filterwerte in den SQL-Text einbauen statt zu
parametrisieren. Top-Produkte über einen zu kurzen Zeitraum als „repräsentativ" darstellen. Fehlende Preise
still auf null setzen. Kennzahl ohne Zweck oder Aussagegrenze zeigen. Personenbezogene Umsatzprofile je
Kontaktperson bilden statt aggregiert zu bleiben.

**EN:** **Common mistakes.** Computing revenue without discount. Building filter values into the SQL text
instead of parameterizing. Presenting top products over too short a period as "representative". Silently
setting missing prices to zero. Showing a metric without purpose or limit of interpretation. Building personal
revenue profiles per contact person instead of staying aggregated.

### Beispiel / Example

```text
Kennzahl:          Umsatz je Kategorie
Formel:            SUMME(Quantity x UnitPrice x (1 - Discount)) gruppiert nach Categories.CategoryName
Datenzugriff:      parametrisierte Query, Zeitraum als Platzhalter (kein SQL-Text aus Eingabe)
Fiktive Daten:     Order Details zu Order 50218 (ALFKI): ProductID 28, UnitPrice 45.60, Quantity 15, Discount 0.05
Positionsumsatz:   15 x 45.60 x (1 - 0.05) = 649.80
Behandlung:        1 Position ohne UnitPrice -> "unvollstaendig" markiert UND gezaehlt, nicht auf 0 geraten
Top-Produkte:      ORDER BY Positionsumsatz DESC, LIMIT 5  (Zeitraum genannt)
Bestell-KPI:       Bestellungen je Monat = COUNT(Orders) gruppiert nach Monat
Aussagegrenze:     "Nur voll erfasste Monate; laufender Monat unvollstaendig, nicht vergleichbar."
Datenschutz:       nur aggregierte Summen, kein Umsatzprofil je Kontaktperson, kein Freitext.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Auswertungen und Kennzahlen beantworten eine Geschäftsanfrage der Handelsfirma verständlich. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Kennzahlen stammen aus dem relationalen Handelsdatenmodell und dessen Qualität. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Zweckbindung, sichere Datenzugriffe und
nachvollziehbare Dokumentation. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_11` (Datenschutz/Datenqualität). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jede Kennzahl hat Zweck, Formel und Aussagegrenze, Datenzugriffe
sind parametrisiert, und keine Auswertung erlaubt Rückschlüsse auf einzelne echte Personen.* A11Y-Aspekt:
Kennzahlen und Auswertungstabellen werden als klarer Text mit Zahlen und ausgeschriebenen Hinweisen
dargestellt, nicht nur als Farbdiagramm oder Ampel, damit sie mit Screenreader und Braille-Zeile verständlich
bleiben.

**EN:** Relation to the Secure Development Guideline: privacy, purpose limitation, secure data access, and
traceable documentation. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review),
`CL_10` (privacy), and `CL_11` (privacy/data quality). The security decision of this unit is: *every metric has
purpose, formula, and a limit of interpretation, data access is parameterized, and no evaluation allows
conclusions about individual real people.* Accessibility aspect: metrics and evaluation tables are shown as
clear text with numbers and written-out notes, not only as a color chart or traffic light, so they remain
understandable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum muss beim Umsatz je Kategorie der Rabatt berücksichtigt werden? /
   **EN:** Why must the discount be included in revenue per category?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der tatsächlich erzielte Umsatz ist Menge x Einzelpreis abzüglich Rabatt. Wer den Rabatt weglässt,
   überschätzt den Umsatz systematisch und trifft falsche Geschäftsentscheidungen.
   **EN:** The actually earned revenue is quantity x unit price minus the discount. Omitting the discount
   systematically overstates revenue and leads to wrong business decisions.

   </details>

2. **DE:** (AE) Warum werden Auswertungen über parametrisierte Queries statt über zusammengesetzten SQL-Text abgefragt? /
   **EN:** (AE) Why are evaluations queried via parameterized queries instead of concatenated SQL text?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Filterwerte wie Zeitraum oder Kategorie können manipuliert sein. Werden sie in den SQL-Text
   eingebaut, entsteht SQL-Injection. Parametrisierte Queries trennen Abfrage und Daten und schließen diese
   Lücke.
   **EN:** Filter values such as period or category can be manipulated. Building them into the SQL text creates
   SQL injection. Parameterized queries separate query and data and close this gap.

   </details>

3. **DE:** Warum dürfen fehlende oder fehlerhafte Werte nicht still gefüllt werden? /
   **EN:** Why must missing or faulty values not be filled silently?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Geratene Werte verfälschen die Kennzahl und täuschen Vollständigkeit vor. Fehlende oder fehlerhafte
   Daten werden sichtbar behandelt, z. B. als „unvollständig" markiert und gezählt.
   **EN:** Guessed values distort the metric and fake completeness. Missing or faulty data is handled visibly,
   e.g. marked as "incomplete" and counted.

   </details>

4. **DE:** Warum ist der Pflicht-Datensatz `ALFKI` für Beispielauswertungen nützlich? /
   **EN:** Why is the mandatory record `ALFKI` useful for sample evaluations?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `ALFKI` (Alfreds Futterkiste) ist ein fester, bekannter Anker. Beispielauswertungen und Tests können
   verlässlich auf dieselben Bestellungen verweisen, was Ergebnisse vergleichbar und reproduzierbar macht.
   **EN:** `ALFKI` (Alfreds Futterkiste) is a fixed, well-known anchor. Sample evaluations and tests can reliably
   refer to the same orders, which makes results comparable and reproducible.

   </details>

5. **DE:** (DPA) Welche Kennzahl kann leicht falsch interpretiert werden und wie schützt du davor? /
   **EN:** (DPA) Which metric can easily be misinterpreted, and how do you protect against it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Top-Produkte über einen kurzen oder unvollständigen Zeitraum. Der Schutz ist eine Aussagegrenze, die
   Datenbasis und Zeitraum nennt, plus ein Hinweis, dass kleine Zeiträume nicht repräsentativ sind.
   **EN:** Top products over a short or incomplete period. The protection is a limit of interpretation that names
   the data basis and period, plus a note that small periods are not representative.

   </details>

6. **DE:** (SI) Welche Auswertung wäre nützlich, offenbart aber leicht sensible Daten? /
   **EN:** (SI) Which evaluation would be useful but easily reveals sensitive data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Umsatzprofil je einzelner Kontaktperson oder je Kleinkunde. Es kann Steuerung erleichtern,
   erlaubt aber Rückschlüsse auf Personen. Deshalb bleiben Auswertungen aggregiert und datensparsam.
   **EN:** A revenue profile per individual contact person or per small customer. It can ease steering but allows
   conclusions about people. Therefore evaluations stay aggregated and data-minimal.

   </details>

7. **DE:** Warum braucht jede Kennzahl eine Aussagegrenze? /
   **EN:** Why does every metric need a limit of interpretation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zahlen wirken objektiv, können aber täuschen, wenn Daten fehlen, unvollständig oder klein sind. Die
   Aussagegrenze schützt vor Fehlinterpretationen und falschen Geschäftsentscheidungen.
   **EN:** Numbers look objective but can mislead when data is missing, incomplete, or small. The limit of
   interpretation protects against misinterpretation and wrong business decisions.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: ein
   Echtzeit-Dashboard ist `N/A`, weil hier nur einfache, wiederholbare Lernauswertungen berechnet werden.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: a real-time dashboard
   is `N/A` because only simple, repeatable learning evaluations are calculated here.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Umsatz je Kategorie, Top-Produkte und eine Bestell-KPI mit Zweck und sprachneutraler Formel definieren.
- [ ] den Rabatt korrekt in den Umsatz einrechnen.
- [ ] Auswertungen über parametrisierte Datenbankzugriffe abfragen.
- [ ] fehlende oder fehlerhafte Werte sichtbar behandeln, statt sie zu raten.
- [ ] für jede Kennzahl eine Aussagegrenze benennen.
- [ ] Auswertungen aggregiert und ohne Rückschluss auf einzelne echte Personen gestalten und `ALFKI` als Anker nutzen.

**EN:** I can …

- [ ] define revenue per category, top products, and one order KPI with purpose and a language-neutral formula.
- [ ] correctly include the discount in the revenue.
- [ ] query evaluations via parameterized database access.
- [ ] handle missing or faulty values visibly instead of guessing them.
- [ ] name a limit of interpretation for each metric.
- [ ] design evaluations aggregated and without conclusions about individual real people and use `ALFKI` as an anchor.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_10_Auswertungen-und-Kennzahlen.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_10_Auswertungen-und-Kennzahlen.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
