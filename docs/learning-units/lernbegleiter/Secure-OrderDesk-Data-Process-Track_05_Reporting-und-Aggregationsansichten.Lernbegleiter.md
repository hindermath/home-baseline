# Lernbegleiter: Secure OrderDesk Data & Process Track 05 – Reporting und Aggregationsansichten / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Umsatz-Kennzahlen aus Einheit 03 sind definiert – jetzt sollen sie **jemandem** nützen. Ein
**Bericht** (Report) beantwortet eine Frage für einen bestimmten Adressaten, damit dieser eine Entscheidung
treffen kann. Der Kunde Secure Trader fragt: „Wie liefen unsere Bestellungen in diesem Monat?" Die Rohdaten je
Bestellposition helfen ihm nicht; er braucht eine **Aggregationsansicht** – zusammengefasste Zahlen je Gruppe,
etwa je Warenkategorie (`Products.CategoryID`), je Land oder je Monat (`Orders.OrderDate`). Im 3. Lehrjahr
gestaltest du diesen Auswertungsprozess bewusst: Welche Ebene beantwortet die Frage? Welche Aussagegrenze gilt?
Und wie bleibt der Bericht für alle lesbar – auch mit Screenreader oder Braille-Zeile?

**EN:** The revenue metrics from unit 03 are defined – now they should be **useful to someone**. A **report**
answers a question for a specific audience so that they can make a decision. The client Secure Trader asks: "how
did our orders run this month?" The raw data per line item does not help them; they need an **aggregation view** –
summarized numbers per group, for example per product category (`Products.CategoryID`), per country, or per month
(`Orders.OrderDate`). In year 3 you deliberately shape this evaluation process: which level answers the question?
Which limit of validity applies? And how does the report stay readable for everyone – including with a screen
reader or Braille display?

**DE:** Du lernst, Berichte adressatengerecht zu planen, sinnvolle Aggregationsebenen zu wählen, die
Aussagegrenzen aus Einheit 06 mitzuführen und Aggregation zugleich als Datenschutz zu nutzen: Wer nur Gruppen
zeigt, macht keine einzelne Kundenfirma und keine Person nachverfolgbar. Der Pflicht-Datensatz `ALFKI` bleibt
dabei ein fiktiver Anker aus der Northwind-Datenbasis.

**EN:** You learn to plan reports for their audience, choose sensible aggregation levels, carry the interpretation
limits from unit 06 along, and use aggregation as privacy at the same time: showing only groups makes no
individual customer company and no person traceable. The mandatory record `ALFKI` stays a fictional anchor from
the Northwind data base.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Aggregationsansicht / Aggregation view | Zusammengefasste Sicht (z. B. als View) auf viele Bestellpositionen, gruppiert nach einem Merkmal wie Kategorie oder Monat. |
| Gruppierung / Grouping | Bilden von Gruppen nach einem Merkmal (z. B. `CategoryID`), über die Kennzahlen summiert werden. |
| Roll-up / Roll-up | Verdichten auf eine gröbere Ebene, z. B. von Monat auf Quartal oder von Produkt auf Kategorie. |
| Drill-down / Drill-down | Aufklappen auf eine feinere Ebene, z. B. von Kategorie zurück auf einzelne Produkte. |
| Bezugszeitraum / Reporting period | Zeitfenster, für das der Bericht gilt (z. B. ein Monat aus `Orders.OrderDate`). |
| Aussagegrenze / Limit of validity | Ausdrückliche Angabe, wofür eine Zahl gilt und wofür nicht (z. B. Erlös, nicht Gewinn). |
| Mindestgruppengröße / Minimum group size | Kleinste erlaubte Gruppe, damit keine einzelne Kundenfirma re-identifizierbar wird. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Adressat und Entscheidung zuerst.** Bevor du eine Zahl darstellst, frage: Wer liest den
Bericht, und welche Entscheidung soll er stützen? Ein Bericht für den Einkauf braucht andere Zahlen als ein
Bericht für die Geschäftsleitung. Ein Bericht ohne benannten Adressaten und ohne Entscheidung ist nur eine
Zahlensammlung.

**EN:** **Step 1 – Audience and decision first.** Before you present a number, ask: who reads the report, and
which decision should it support? A report for purchasing needs different numbers than a report for management. A
report without a named audience and without a decision is only a collection of numbers.

**DE:** **Schritt 2 – Aggregationsebene begründet wählen.** Fasse die Umsatz-Kennzahlen nach einem sinnvollen
Merkmal zusammen: je Warenkategorie (`Products.CategoryID`), je Land, je Monat (`Orders.OrderDate`). Die Ebene
muss zur Frage passen. „Welche Warenkategorie brachte diesen Monat den meisten Umsatz?" verlangt die Ebene
Kategorie, nicht die Ebene Einzelposition. Halte fest, warum du die Ebene gewählt hast. Roll-up (Produkt →
Kategorie) und Drill-down (Kategorie → Produkt) sind zwei Richtungen derselben Ansicht.

**EN:** **Step 2 – Choose the aggregation level with a rationale.** Summarize the revenue metrics by a sensible
attribute: per product category (`Products.CategoryID`), per country, per month (`Orders.OrderDate`). The level
must fit the question. "Which product category brought the most revenue this month?" requires the category level,
not the single-line-item level. Record why you chose the level. Roll-up (product → category) and drill-down
(category → product) are two directions of the same view.

**DE:** **Schritt 3 – Aussagegrenze in den Bericht übernehmen.** Eine aggregierte Zahl erbt die Grenzen ihrer
Rohdaten. Beruht der Umsatz auf `UnitPrice * Quantity * (1 - Discount)`, gilt er als Erlös, nicht als Gewinn, und
nur für den Bezugszeitraum der Daten. Schreibe die Grenze sichtbar in den Bericht, z. B. als Fußzeile „Erlös ohne
Frachtkosten; Stornierungen nicht abgezogen". So verhinderst du, dass die schöne Zusammenfassung mehr behauptet,
als die Daten hergeben.

**EN:** **Step 3 – Carry the limit of validity into the report.** An aggregated number inherits the limits of its
raw data. If revenue is based on `UnitPrice * Quantity * (1 - Discount)`, it counts as earnings, not profit, and
only for the reporting period of the data. Write the limit visibly into the report, e.g. as a footer "Earnings
excluding freight; cancellations not deducted". This prevents the neat summary from claiming more than the data
supports.

**DE:** **Schritt 4 – Aggregation als Datenschutz nutzen.** Aggregation fasst zusammen und verbirgt damit
Einzelfälle – aber nur, wenn die Gruppen groß genug sind. Eine Gruppe mit nur einer Kundenfirma (z. B. nur
`ALFKI` in einem seltenen Land) ist keine Aggregation, sondern zeigt genau diese Firma. Lege eine
**Mindestgruppengröße** fest (z. B. „Gruppen unter 5 Kundenfirmen werden zu ‚Sonstige' zusammengelegt"), damit
niemand über kleine Gruppen re-identifiziert werden kann.

**EN:** **Step 4 – Use aggregation as privacy.** Aggregation summarizes and thereby hides individual cases – but
only if the groups are large enough. A group with just one customer company (e.g. only `ALFKI` in a rare country)
is not aggregation; it shows exactly that company. Define a **minimum group size** (e.g. "groups below 5 customer
companies are merged into 'other'") so that no one can be re-identified through small groups.

**DE:** **Schritt 5 – Barrierefrei darstellen.** Ein Bericht muss für alle nutzbar sein. Verwende echte Tabellen
mit Kopfzeile statt reiner Farbbalken, gib Bedeutung nie nur über Farbe an („grün = Wachstum" schließt Menschen
aus) und beschrifte jede Spalte. So bleibt der Bericht mit Screenreader und Braille-Zeile lesbar. Barrierefreiheit
ist hier kein Zusatz, sondern Teil der Reporting-Qualität.

**EN:** **Step 5 – Present accessibly.** A report must be usable by everyone. Use real tables with a header row
instead of color bars only, never convey meaning through color alone ("green = growth" excludes people), and
label every column. This keeps the report readable with a screen reader and Braille display. Accessibility here is
not an add-on but part of reporting quality.

**DE:** **Typische Fehler.** Rohdaten je Bestellposition als „Bericht" ausgeben. Adressat und Entscheidung nicht
benennen. Die Aussagegrenze weglassen. Gruppen so klein wählen, dass eine einzelne Kundenfirma sichtbar wird.
Bedeutung nur über Farbe zeigen. Nicht anwendbare Standards stillschweigend weglassen statt als `N/A` mit
Begründung.

**EN:** **Common mistakes.** Presenting per-line-item raw data as a "report". Not naming audience and decision.
Omitting the limit of validity. Choosing groups so small that a single customer company becomes visible.
Conveying meaning only through color. Silently dropping non-applicable standards instead of documenting them as
`N/A` with a rationale.

### Beispiel / Example

```text
Bericht:     "Monatsreport Umsatz je Kategorie" fuer Einkaufsleitung -> Entscheidung: Sortiment planen

Aggregationsansicht (je Kategorie, Bezugsmonat 1997-06):
  Kategorie        Umsatz      Bestellungen   Kundenfirmen   Anteil Umsatz
  Beverages        12480.50    41             27             31 %
  Dairy Products    9310.75    33             22             23 %
  Confections       7205.00    28             19             18 %
  Produce           1180.20     4              3             (Gruppe < min -> mit "Sonstige" zusammengelegt)
  Sonstige          3120.40    12              9             8 %

Formel:         Umsatz = SUM(UnitPrice * Quantity * (1 - Discount)) je Kategorie
Bezugszeitraum: Bestellungen mit OrderDate im Monat 1997-06
Aussagegrenze:  Erloes, nicht Gewinn; Stornierungen nicht abgezogen (Einheit 06)
Datenschutz:    Mindestgruppengroesse 5 Kundenfirmen; kleinere Gruppen -> "Sonstige"; keine Einzelfirma ausgewiesen
A11Y:           echte Tabelle mit Kopfzeile; Anteil als Text, nicht nur als Farbbalken
N/A:            interaktives Drill-down-Dashboard in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11c**
ist primär, weil Reporting- und Aggregationsansichten den Auswertungsprozess gestalten und ihn auf Entscheidungen
ausrichten; LF 6 ist berührt, weil aus den Berichten konkrete Serviceanfragen und Geschäftsentscheidungen
entstehen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
11c** is primary because reporting and aggregation views shape the evaluation process and orient it toward
decisions; LF 6 is touched because concrete service requests and business decisions arise from the reports.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11c Prozesse analysieren und gestalten | Primär / Primary | Reporting- und Aggregationsansichten gestalten den Auswertungsprozess des Handels und richten ihn auf Entscheidungen aus. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Aus den Berichten entstehen konkrete Serviceanfragen und Geschäftsentscheidungen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz durch Aggregation, Nachvollziehbarkeit,
Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review der Aggregation), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die
Datenentscheidung dieser Einheit lautet: *Jeder Bericht nennt Adressat, Entscheidung und Aussagegrenze,
aggregiert oberhalb einer Mindestgruppengröße und macht keine einzelne Kundenfirma oder Person nachverfolgbar.*
A11Y-Aspekt: Berichte sind echte Tabellen mit Kopfzeile und tragen Bedeutung nie nur über Farbe, damit sie mit
Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: privacy through aggregation, traceability, testability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review of the
aggregation), `CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit is:
*every report names audience, decision, and limit of validity, aggregates above a minimum group size, and makes
no individual customer company or person traceable.* Accessibility aspect: reports are real tables with a header
row and never carry meaning through color alone, so they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum beginnt ein guter Bericht mit dem Adressaten und der Entscheidung, nicht mit der Zahl? /
   **EN:** Why does a good report start with the audience and the decision, not with the number?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Erst Adressat und Entscheidung legen fest, welche Zahlen relevant sind und wie sie dargestellt werden.
   Ohne diese Ausrichtung entsteht eine Zahlensammlung, die keine Entscheidung stützt.
   **EN:** Only the audience and the decision determine which numbers are relevant and how they are presented.
   Without this orientation you get a collection of numbers that supports no decision.

   </details>

2. **DE:** (DPA) Wie hilft eine begründete Aggregationsebene, die Kundenfrage zu beantworten? /
   **EN:** (DPA) How does a justified aggregation level help answer the customer's question?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Ebene bestimmt, wie zusammengefasst wird. „Umsatz je Kategorie" verlangt die Ebene Kategorie. Eine
   passende Ebene macht die Antwort direkt lesbar; eine falsche Ebene erzeugt entweder Detailflut oder verdeckt
   die relevante Struktur.
   **EN:** The level determines how data is summarized. "Revenue per category" requires the category level. A
   fitting level makes the answer directly readable; a wrong level either floods with detail or hides the relevant
   structure.

   </details>

3. **DE:** (DPA) Warum ist eine Aggregationsgruppe mit nur einer Kundenfirma ein Datenschutzproblem? /
   **EN:** (DPA) Why is an aggregation group with only one customer company a privacy problem?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Gruppe mit nur einem Element fasst nichts zusammen, sondern zeigt genau dieses Element. Damit wird
   die einzelne Kundenfirma (z. B. `ALFKI`) re-identifizierbar. Eine Mindestgruppengröße verhindert das.
   **EN:** A group with only one element summarizes nothing; it shows exactly that element. This makes the single
   customer company (e.g. `ALFKI`) re-identifiable. A minimum group size prevents that.

   </details>

4. **DE:** Warum muss die Aussagegrenze der Kennzahl auch im aggregierten Bericht stehen? /
   **EN:** Why must the metric's limit of validity also appear in the aggregated report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine aggregierte Zahl erbt die Grenzen ihrer Rohdaten. Ohne die Grenze wirkt der Bericht belastbarer,
   als er ist. Sichtbar gemacht schützt die Grenze vor Fehlinterpretation – etwa Erlös mit Gewinn zu verwechseln.
   **EN:** An aggregated number inherits the limits of its raw data. Without the limit the report seems more robust
   than it is. Made visible, the limit protects against misinterpretation – for example confusing earnings with
   profit.

   </details>

5. **DE:** (SI) Welche Betriebsbedingung kann die Aktualität eines Berichts einschränken? /
   **EN:** (SI) Which operational condition can limit the freshness of a report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Erzeugungsintervall und die Datenaktualität. Wird der Monatsreport erst nach Monatsabschluss oder
   nur nachts erzeugt, ist er entsprechend alt und enthält verspätet gebuchte Bestellungen nicht. Diese
   Verzögerung gehört als Aussagegrenze in den Bericht.
   **EN:** The generation interval and the data freshness. If the monthly report is built only after month-end or
   only at night, it is correspondingly old and misses late-booked orders. This delay belongs in the report as a
   limit of validity.

   </details>

6. **DE:** (DV) Welche Schnittstelle liefert die Rohdaten, und welche Aussagegrenze bringt sie mit? /
   **EN:** (DV) Which interface delivers the raw data, and which limit of validity does it bring along?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Northwind-Datenbasis liefert Bestellungen und Positionen über `Orders` und `Order Details`. Ihre
   Grenze: Sie enthält nur erfasste Bestellungen, keine Einkaufspreise – daher ist Umsatz als Erlös belastbar,
   Gewinn aber nicht. Die Grenze gehört sichtbar in den Bericht.
   **EN:** The Northwind data base delivers orders and line items via `Orders` and `Order Details`. Its limit: it
   contains only recorded orders, no purchase prices – so revenue is robust as earnings, but profit is not. The
   limit belongs visibly in the report.

   </details>

7. **DE:** Warum darf ein Bericht Bedeutung nicht nur über Farbe transportieren? /
   **EN:** Why must a report not convey meaning through color alone?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Farbe allein ist für Screenreader, Braille-Zeilen und Menschen mit Farbsehschwäche nicht nutzbar. Steht
   die Bedeutung auch als Text (z. B. „Anteil 31 %") in einer Tabellenspalte, bleibt der Bericht für alle lesbar
   (WCAG).
   **EN:** Color alone is not usable for screen readers, Braille displays, and people with color vision
   deficiency. If the meaning is also present as text (e.g. "share 31%") in a table column, the report stays
   readable for everyone (WCAG).

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Bericht mit Adressat und gestützter Entscheidung planen.
- [ ] eine begründete Aggregationsebene (Kategorie, Land, Monat) für eine Kundenfrage wählen.
- [ ] eine Mindestgruppengröße festlegen und begründen.
- [ ] die Aussagegrenze jeder Kennzahl in den Bericht übernehmen.
- [ ] Aggregation so einsetzen, dass keine einzelne Kundenfirma nachverfolgbar wird.
- [ ] nicht anwendbare Standards als `N/A` mit kurzer Begründung dokumentieren.

**EN:** I can …

- [ ] plan a report with an audience and a supported decision.
- [ ] choose a justified aggregation level (category, country, month) for a customer question.
- [ ] define and justify a minimum group size.
- [ ] carry each metric's limit of validity into the report.
- [ ] use aggregation so that no individual customer company becomes traceable.
- [ ] document non-applicable standards as `N/A` with a short justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md`. Sie baut auf
Einheit 03 (`Umsatz-Kennzahlen und Betriebsmetriken`) auf und übernimmt die Grenzen aus Einheit 06
(`Aussagegrenzen und Datenunsicherheit`). Der Copy-Paste-Prompt für einen späteren, manuell gestarteten
Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md`. It builds on unit 03
(`revenue metrics and operational metrics`) and carries over the limits from unit 06 (`interpretation limits and
data uncertainty`). The copy-paste prompt for a later, manually started Spec Kit run is provided there.
