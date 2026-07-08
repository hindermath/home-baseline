# Lernbegleiter: Secure OrderDesk Data & Process Track 06 – Aussagegrenzen und Datenunsicherheit / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Secure OrderDesk wertet die Bestell- und Handelsdaten von Secure Trader aus der Northwind-Datenbasis
inkl. `ALFKI` aus. Jede Auswertung beruht auf einem bestimmten **Datenstand**: Zum Zeitpunkt der Abfrage gibt
es abgeschlossene, offene und noch nicht versendete Bestellungen. Aus solchen Daten lassen sich Kennzahlen
bilden – aber jede Kennzahl hat eine **Aussagegrenze**: Sie gilt nur unter bestimmten Bedingungen. „Der Umsatz
beträgt 120.000" ist ohne Zusatz irreführend. Ehrlich ist: „Der Umsatz aus abgeschlossenen Bestellungen im
Zeitraum Q1, mit Rabatt gerechnet, beträgt 120.000." Der Rest ist unbekannt, nicht automatisch „null".

**EN:** Secure OrderDesk evaluates Secure Trader's order and trading data from the Northwind data base incl.
`ALFKI`. Every evaluation rests on a specific **data state**: at query time there are completed, open, and not
yet shipped orders. Metrics can be built from such data – but every metric has a **limit of validity**: it only
holds under certain conditions. "Revenue is 120,000" is misleading without an addition. Honest is: "Revenue
from completed orders in period Q1, computed with discount, is 120,000." The rest is unknown, not automatically
"zero".

**DE:** In dieser Einheit lernst du, **Datenunsicherheit** (unvollständige Bestellungen, Aktualität des
Datenstands, Rabatt- und Preiseinfluss, Abdeckung je Kunde/Produkt/Zeitraum) sichtbar zu machen und zu jeder
Kennzahl eine ausdrückliche Aussagegrenze zu formulieren. So wird aus einer scheinbar exakten Zahl eine
ehrliche, belastbare Aussage.

**EN:** In this unit you learn to make **data uncertainty** (incomplete orders, freshness of the data state,
discount and price effects, coverage per customer/product/period) visible and to formulate an explicit limit
of validity for every metric. This turns a seemingly exact number into an honest, robust statement.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Aussagegrenze / Limit of validity | Bedingung, unter der eine Kennzahl gilt; alles außerhalb ist nicht belegt. |
| Datenunsicherheit / Data uncertainty | Grad, zu dem die Bestelldaten unvollständig, veraltet oder unsicher sind. |
| Datenstand / Data state | Stichtag, zu dem die Auswertung die Bestellungen sieht; er altert. |
| Offene Bestellung / Open order | Bestellung, die noch nicht abgeschlossen oder versendet ist. |
| Abdeckung / Coverage | Anteil der Kunden, Produkte oder Zeitpunkte, für die überhaupt Daten vorliegen. |
| Rabatteinfluss / Discount effect | Veränderung des Umsatzes durch Rabatte, die eine Kennzahl mitprägt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Datenstand und Herkunft verstehen.** Kläre, zu welchem Stichtag die Auswertung läuft und
welche Bestellungen darin vorkommen. Offene Bestellungen sind noch nicht abgeschlossen; ihr Beitrag zum Umsatz
steht noch nicht fest. Das ist keine Schwäche, solange man es benennt.

**EN:** **Step 1 – Understand the data state and origin.** Clarify at which cut-off date the evaluation runs and
which orders it contains. Open orders are not yet complete; their contribution to revenue is not yet fixed. That
is not a weakness as long as you name it.

**DE:** **Schritt 2 – Abdeckung und Aktualität messen.** Für jede Kennzahl: Für wie viele Kunden oder Produkte
liegen Daten vor (Abdeckung)? Wie aktuell ist der Datenstand? Eine Kennzahl über 8 von 91 Kunden ist etwas
anderes als über alle 91. Fehlende Werte nicht stillschweigend als „null" behandeln.

**EN:** **Step 2 – Measure coverage and freshness.** For each metric: for how many customers or products is there
data (coverage)? How current is the data state? A metric over 8 of 91 customers differs from one over all 91. Do
not silently treat missing values as "zero".

**DE:** **Schritt 3 – Unsicherheit von der Kennzahl trennen.** Schreibe die Kennzahl und ihre Unsicherheit in
getrennte Felder. Warum? Weil die Zahl und ihre Verlässlichkeit unterschiedliche Prüfungen brauchen. Eine
Kennzahl ohne Unsicherheitsangabe wirkt genauer, als sie ist.

**EN:** **Step 3 – Separate uncertainty from the metric.** Write the metric and its uncertainty in separate
fields. Why? Because the number and its reliability need different checks. A metric without an uncertainty note
looks more precise than it is.

**DE:** **Schritt 4 – Aussagegrenze ausformulieren.** Formuliere je Kennzahl einen Satz, der sagt, wofür sie
gilt und wofür nicht: „Gilt nur für abgeschlossene Bestellungen im Zeitraum Q1, Rabatt berücksichtigt; offene
Bestellungen zählen als unbekannt." So kann niemand die Zahl versehentlich überdehnen.

**EN:** **Step 4 – Spell out the limit of validity.** For each metric, write a sentence saying what it holds for
and what not: "Only holds for completed orders in period Q1, discount included; open orders count as unknown."
This prevents anyone from accidentally overstretching the number.

**DE:** **Schritt 5 – Nachweispfad angeben.** Jede Aussagegrenze braucht einen Beleg: eine Abdeckungstabelle,
eine Verteilung der Bestellzeiträume oder eine Auswertung, die zeigt, wie viele Positionen ohne Preis oder wie
viele offene Bestellungen fehlen. Ohne Nachweis ist die Aussagegrenze nur eine Behauptung.

**EN:** **Step 5 – State an evidence path.** Every limit of validity needs proof: a coverage table, a
distribution of order periods, or an evaluation showing how many line items without a price or how many open
orders are missing. Without evidence the limit of validity is just a claim.

**DE:** **Typische Fehler.** „Keine Bestellung" mit „Kunde verloren" verwechseln. Prozentzahlen ohne Nennung der
Grundgesamtheit. Offene Bestellungen wie abgeschlossene behandeln. Rabatt vergessen. Unsicherheit weglassen, um
eine Zahl überzeugender wirken zu lassen. Aussagegrenze nur denken, aber nicht aufschreiben.

**EN:** **Common mistakes.** Confusing "no order" with "customer lost". Percentages without naming the
population. Treating open orders like completed ones. Forgetting the discount. Dropping uncertainty to make a
number look more convincing. Only thinking the limit of validity but not writing it down.

### Beispiel / Example

```text
Kennzahl:          Umsatz je Kategorie (Getraenke)
Rohwert:           120000
Grundgesamtheit:   830 von 830 Bestellpositionen mit Preis (Abdeckung 100 %)
Datenstand:        Stichtag 2026-03-31; 14 offene Bestellungen noch nicht enthalten
Rabatt:            mit Rabatt gerechnet (sonst 128500 ohne Rabatt)
Unsicherheit:      14 offene Bestellungen => Umsatzbeitrag unbekannt, nicht "null"
Aussagegrenze:     "Gilt nur fuer abgeschlossene Bestellungen Q1, Rabatt inbegriffen"
Nachweis:          Abdeckungs- und Zeitraum-Tabelle in docs (Evidenzpfad); ALFKI enthalten
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Professional Tracks"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Secure OrderDesk Professional Tracks"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Belastbare kundenspezifische Handelskennzahlen brauchen ausdrückliche Aussagegrenzen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Abdeckung, Datenstand und Lücken entstehen in der relationalen Datenhaltung von Secure OrderDesk. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: belastbare Aussagen nur mit Nachweis, nachvollziehbare
Entscheidungen und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Review), `CL_10` (Datenschutz) und `CL_12` (auditfähige Nachweise). Auswertungen greifen ausschließlich über
parametrisierte Queries auf die Northwind-Daten zu. Die Datenentscheidung dieser Einheit lautet: *Jede Kennzahl
trägt eine ausdrückliche Aussagegrenze und einen Nachweispfad; „keine Bestellung" wird nie stillschweigend zu
„Kunde verloren".* A11Y-Aspekt: Abdeckungs- und Aktualitätsangaben müssen als klarer Text und als Tabelle
lesbar sein; Unsicherheit wird als Wort und Zahl angegeben, nicht nur als Farbe.

**EN:** Relation to the Secure Development Guideline: reliable statements only with evidence, traceable
decisions, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (review),
`CL_10` (data protection), and `CL_12` (audit-ready evidence). Evaluations access the Northwind data only via
parameterized queries. The data decision of this unit is: *every metric carries an explicit limit of validity
and an evidence path; "no order" never silently becomes "customer lost".* Accessibility aspect: coverage and
freshness must be readable as clear text and as a table; uncertainty is given as a word and a number, not by
color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Aussagegrenze und warum gehört sie zu jeder Kennzahl? /
   **EN:** What is a limit of validity and why does it belong to every metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Aussagegrenze nennt die Bedingung, unter der eine Kennzahl gilt. Ohne sie wird die Zahl auf
   Fälle übertragen, für die sie nicht belegt ist, und führt zu falschen Geschäftsentscheidungen.
   **EN:** A limit of validity names the condition under which a metric holds. Without it the number is applied
   to cases it does not cover and leads to wrong business decisions.

   </details>

2. **DE:** (DPA) Warum darf „keine Bestellung im Zeitraum" nicht als „Kunde verloren" gezählt werden? /
   **EN:** (DPA) Why must "no order in the period" not be counted as "customer lost"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fehlende Bestellungen bedeuten nur, dass im Zeitraum nichts vorliegt – der Kunde kann später wieder
   bestellen oder anders kaufen. „Verloren" wäre eine unbelegte Annahme; korrekt ist „im Zeitraum keine Daten".
   **EN:** Missing orders only mean there is nothing in the period – the customer may order again later or buy
   differently. "Lost" would be an unproven assumption; correct is "no data in the period".

   </details>

3. **DE:** Wie beeinflusst der Rabatt, was eine Umsatzkennzahl aussagt? /
   **EN:** How does the discount influence what a revenue metric says?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Umsatz mit Rabatt und Umsatz ohne Rabatt sind unterschiedliche Zahlen. Wird der Rabatt nicht
   benannt, kann dieselbe Kennzahl zwei verschiedene Aussagen tragen und wird missverstanden.
   **EN:** Revenue with discount and revenue without discount are different numbers. If the discount is not
   named, the same metric can carry two different statements and is misunderstood.

   </details>

4. **DE:** (DPA) Warum sollte Unsicherheit getrennt von der Kennzahl notiert werden? /
   **EN:** (DPA) Why should uncertainty be noted separately from the metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zahl und Verlässlichkeit brauchen verschiedene Prüfungen. Steht die Unsicherheit getrennt, bleibt
   sie sichtbar und die Kennzahl wirkt nicht genauer, als sie ist.
   **EN:** The number and its reliability need different checks. Kept separate, uncertainty stays visible and
   the metric does not look more precise than it is.

   </details>

5. **DE:** Warum braucht eine Aussagegrenze einen Nachweispfad? /
   **EN:** Why does a limit of validity need an evidence path?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Beleg ist die Grenze nur eine Behauptung. Eine Abdeckungs- oder Zeitraumtabelle zeigt, dass
   die Bedingung wirklich geprüft wurde, und macht die Aussage auditfähig.
   **EN:** Without proof the limit is just a claim. A coverage or period table shows the condition was really
   checked and makes the statement audit-ready.

   </details>

6. **DE:** (SI) Welche Betriebsbedingung erzeugt einen veralteten oder unvollständigen Datenstand? /
   **EN:** (SI) Which operational condition creates a stale or incomplete data state?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein später Import, ein Teilimport, ein Snapshot vor Buchungsschluss oder ein Wartungsfenster führen
   dazu, dass nicht alle Bestellungen enthalten sind. Man erkennt es am Stichtag und an fehlenden Zeiträumen.
   **EN:** A late import, a partial import, a snapshot before cut-off, or a maintenance window cause not all
   orders to be included. You recognize it by the cut-off date and by missing periods.

   </details>

7. **DE:** (DV) Warum kann eine Schnittstellen- oder Importlücke eine Kennzahl verzerren? /
   **EN:** (DV) Why can an interface or import gap distort a metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn ein Kanal (z. B. ein Shop oder eine Filiale) zeitweise keine Bestellungen liefert, fehlen deren
   Daten in der Grundgesamtheit. Die Kennzahl gilt dann nur für die erfassten Kanäle – das gehört in die
   Aussagegrenze.
   **EN:** If a channel (e.g. a shop or branch) temporarily delivers no orders, its data is missing from the
   population. The metric then only holds for the captured channels – that belongs in the limit of validity.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Abdeckung, Aktualität des Datenstands und Rabatteinfluss einer Kennzahl benennen.
- [ ] „keine Bestellung" sauber von „Kunde verloren" trennen.
- [ ] Datenunsicherheit getrennt von der Kennzahl dokumentieren.
- [ ] zu jeder Kennzahl eine ausdrückliche Aussagegrenze formulieren.
- [ ] je Aussagegrenze einen Nachweispfad angeben.

**EN:** I can …

- [ ] name coverage, freshness of the data state, and discount effect of a metric.
- [ ] cleanly separate "no order" from "customer lost".
- [ ] document data uncertainty separately from the metric.
- [ ] formulate an explicit limit of validity for every metric.
- [ ] give an evidence path for each limit of validity.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md`. Die nächste Einheit
`07_Anomalie-und-Lueckenerkennung` baut auf diesen Aussagegrenzen auf. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md`. The next unit
`07_Anomalie-und-Lueckenerkennung` builds on these limits of validity. The copy-paste prompt for a later,
manually started Spec Kit run is provided in the intake.
