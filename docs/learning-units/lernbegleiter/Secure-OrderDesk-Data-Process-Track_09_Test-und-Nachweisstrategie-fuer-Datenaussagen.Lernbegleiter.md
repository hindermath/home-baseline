# Lernbegleiter: Secure OrderDesk Data & Process Track 09 – Test- und Nachweisstrategie für Datenaussagen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Du hast für Secure OrderDesk Umsatz-Kennzahlen (Einheit 03), Berichte (Einheit 05) und Aussagegrenzen
(Einheit 06) erarbeitet. Aber woher weißt du, dass eine Kennzahl **wirklich** das berechnet, was sie behauptet?
Dafür brauchst du eine **Test- und Nachweisstrategie**. Der Kern ist ein wichtiger Unterschied: Ein **Code-Test**
prüft, ob eine Funktion technisch korrekt rechnet – zum Beispiel, ob die Umsatzformel
`UnitPrice * Quantity * (1 - Discount)` je Position stimmt. Ein **Nachweis einer Datenaussage** prüft, ob die
Kennzahl die fachlich zugesicherte Aussage trifft – auch bei Lücken, leeren Bestellungen und Ausreißern. Beides
gehört zusammen, ist aber nicht dasselbe.

**EN:** For Secure OrderDesk you have created revenue metrics (unit 03), reports (unit 05), and interpretation
limits (unit 06). But how do you know that a metric **really** computes what it claims? For that you need a **test
and evidence strategy**. The core is an important distinction: a **code test** checks whether a function computes
technically correctly – for example, whether the revenue formula `UnitPrice * Quantity * (1 - Discount)` per line
item is right. An **evidence of a data claim** checks whether the metric makes its promised business statement –
even with gaps, empty orders, and outliers. Both belong together but are not the same.

**DE:** In dieser Einheit lernst du, synthetische Northwind-Testdaten inkl. `ALFKI` ohne echte personenbezogene
Inhalte zu wählen, ein **Golden Dataset** mit bekanntem Sollergebnis (Umsatz von Hand berechnet) anzulegen,
Kantenfälle (leere Menge, Bestellung ohne Positionen, Rabatt-Ausreißer) abzudecken und alles reproduzierbar zu
machen. „Microsoft“ wird nur als Herkunftshinweis der Northwind-Beispieldaten genannt; die Lösung bleibt
sprachneutral für C#, Go, Java, Python, Rust und Swift.

**EN:** In this unit you learn to choose synthetic Northwind test data incl. `ALFKI` without real personal content,
to build a **golden dataset** with a known target result (revenue computed by hand), to cover edge cases (empty
set, order without line items, discount outlier), and to make everything reproducible. "Microsoft" is named only as
the origin hint of the Northwind sample data; the solution stays language-neutral for C#, Go, Java, Python, Rust,
and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Testfall / Test case | Feste Eingabe mit vorher festgelegter Erwartung, um eine Kennzahl gezielt zu prüfen. |
| Erwartungswert / Expected value | Das von Hand bekannte, richtige Sollergebnis, gegen das der Code geprüft wird. |
| Golden Sample / Fixture / Golden sample / fixture | Fest vorbereiteter, unveränderlicher Testdatenstand (z. B. mit `ALFKI`), der einen Test wiederholbar macht. |
| Reproduzierbarkeit / Reproducibility | Gleiche Eingabe und Parameter ergeben immer denselben Umsatz oder dieselbe Kennzahl. |
| Randfall / Edge case | Grenzsituation wie leere Menge, Bestellung ohne Positionen oder Rabatt-Ausreißer. |
| Nachweis / Evidenz / Evidence | Auditfähiger Beleg, dass eine Kennzahl die zugesicherte Aussage trifft. |
| Regressionstest / Regression test | Wiederholter Test, der sicherstellt, dass eine Änderung ein früheres Ergebnis nicht heimlich verändert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Code-Test und Datenaussage trennen.** Schreibe zuerst auf, was du prüfen willst: die
**Rechnung** (technisch korrekt) oder die **Aussage** (fachlich gültig). Beispiel: Ein Test kann bestätigen, dass
der Umsatz einer Kategorie 649,80 ergibt. Ob „649,80 Umsatz" als fachliche Aussage stimmt, hängt zusätzlich von der
Aussagegrenze aus Einheit 06 ab (Erlös, nicht Gewinn; Storno nicht abgezogen). Trenne beide Prüfungen bewusst.

**EN:** **Step 1 – Separate code test and data claim.** First write down what you want to check: the
**calculation** (technically correct) or the **claim** (business-valid). Example: a test can confirm the revenue of
a category is 649.80. Whether "649.80 revenue" is the correct business statement additionally depends on the limit
of validity from unit 06 (earnings, not profit; cancellations not deducted). Deliberately separate both checks.

**DE:** **Schritt 2 – Synthetische Testdaten wählen.** Verwende erfundene Northwind-Daten ohne echten Personenbezug.
Der Pflichtdatensatz `ALFKI` ist ein fiktiver Beispielanker; niemals echte Kundennamen, Adressen oder Secrets.
Secrets stehen in Beispielen nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`. So testest du realitätsnah, ohne
Datenschutzrisiken zu schaffen.

**EN:** **Step 2 – Choose synthetic test data.** Use invented Northwind data without real personal reference. The
mandatory record `ALFKI` is a fictional example anchor; never real customer names, addresses, or secrets. In
examples, secrets appear only as `<PLATZHALTER-KEIN-ECHTER-WERT>`. This way you test realistically without creating
privacy risks.

**DE:** **Schritt 3 – Golden Dataset mit Sollergebnis anlegen.** Erstelle einen festen, überschaubaren Datensatz
(z. B. wenige Bestellpositionen zu `ALFKI`) und rechne den richtigen Umsatz **von Hand** aus:
`UnitPrice * Quantity * (1 - Discount)` je Position, danach summiert. Dieses bekannte Sollergebnis ist der Maßstab:
Weicht die Berechnung ab, ist entweder der Code oder deine Erwartung falsch – beides muss geklärt werden. Das Golden
Sample bleibt unverändert, damit der Vergleich stabil ist.

**EN:** **Step 3 – Build a golden dataset with a target result.** Create a fixed, manageable dataset (e.g. a few
line items for `ALFKI`) and compute the correct revenue **by hand**: `UnitPrice * Quantity * (1 - Discount)` per
line item, then summed. This known target result is the yardstick: if the calculation deviates, either the code or
your expectation is wrong – both must be clarified. The golden sample stays unchanged so the comparison is stable.

**DE:** **Schritt 4 – Randfälle abdecken.** Die interessanten Fehler stecken an den Rändern. Prüfe mindestens: die
**leere Menge** (kein Treffer – was ergibt eine Summe oder ein Durchschnitt mit Nenner null?), die **Bestellung
ohne Positionen** (Order ohne Order Details – zählt sie als Umsatz null oder gar nicht?) und den **Rabatt-Ausreißer**
(Discount = 0 oder ein unrealistischer Wert über 100 %). Lege je Randfall fest, was das erwartete, sichere Verhalten
ist.

**EN:** **Step 4 – Cover edge cases.** The interesting bugs live at the edges. Check at least: the **empty set** (no
match – what does a sum or average with denominator zero yield?), the **order without line items** (order without
order details – does it count as revenue zero or not at all?), and the **discount outlier** (discount = 0 or an
unrealistic value above 100%). For each edge case, define the expected, safe behavior.

**DE:** **Schritt 5 – Reproduzierbarkeit sichern.** Ein Nachweis zählt nur, wenn er wiederholbar ist. Halte den
Datenstand fest (z. B. eine Fixture-Datei mit festen Positionen), fixiere Parameter wie den Auswertungszeitraum und
dokumentiere, wie das Ergebnis erzeugt und geprüft wird. Datenzugriffe erfolgen über parametrisierte Queries – nie
über zusammengebautes SQL aus Filter-Eingaben. Zufall, aktuelle Systemzeit oder wechselnde Daten machen einen
Nachweis wertlos. Feste Eingabe plus feste Parameter ergeben immer denselben Umsatz.

**EN:** **Step 5 – Ensure reproducibility.** Evidence only counts if it is repeatable. Fix the data state (e.g. a
fixture file with fixed line items), pin parameters such as the evaluation period, and document how the result is
produced and checked. Data access uses parameterized queries – never SQL assembled from filter input. Randomness,
the current system time, or changing data make evidence worthless. Fixed input plus fixed parameters always yield
the same revenue.

**DE:** **Typische Fehler.** Nur den Code testen und die fachliche Aussage vergessen. Echte Kundendaten als
Testdaten verwenden. Kein Golden Dataset, also kein Maßstab. Den Rabatt in der Handrechnung vergessen. Den leeren
Fall und die Division durch null übersehen. Bestellungen ohne Positionen unbewusst zählen. Nachweise mit der
aktuellen Uhrzeit erzeugen, sodass sie sich nicht wiederholen lassen. Nicht anwendbare Standards still weglassen
statt als `N/A` mit Begründung.

**EN:** **Common mistakes.** Testing only the code and forgetting the business claim. Using real customer data as
test data. No golden dataset, so no yardstick. Forgetting the discount in the hand calculation. Overlooking the
empty case and division by zero. Unknowingly counting orders without line items. Producing evidence with the current
time so it cannot be repeated. Silently dropping non-applicable standards instead of documenting them as `N/A` with a
rationale.

### Beispiel / Example

```text
Golden Sample (fest, synthetisch, Kunde ALFKI):
  Position   UnitPrice  Quantity  Discount   Umsatz = UnitPrice * Quantity * (1 - Discount)
  P-1        45.60      15        0.05       45.60 * 15 * 0.95 = 649.80
  P-2        10.00      10        0.00       10.00 * 10 * 1.00 = 100.00
  P-3        20.00       5        0.10       20.00 *  5 * 0.90 =  90.00

Erwartungswert (von Hand): Summe = 649.80 + 100.00 + 90.00 = 839.80
Code-Test:                 Funktion liefert 839.80  -> bestanden
Datenaussage-Nachweis:     "839.80 Umsatz" = Erloes, nicht Gewinn (Einheit 06)

Randfaelle:
  leer:          0 Positionen         -> Summe = 0.00, Durchschnitt "n/a, keine Daten" (kein 0/0)
  ohne Position: Order ohne Details   -> zaehlt als Umsatz 0.00, nicht als fehlend verworfen
  Rabatt-Ausreisser: Discount > 1.00  -> als ungueltig verworfen + geloggt, nicht negativer Umsatz

Reproduzierbar: feste Fixture, fixer Auswertungszeitraum; kein Zufall, keine echte Systemzeit
Datenzugriff nur ueber parametrisierte Queries
Secret in Beispielen nur als <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Professional Tracks"). **LF 12c** ist primär, weil der Nachweis, dass eine kundenspezifische
Datenanalyse der Handelsdomäne korrekt und reproduzierbar ist, Kern der Prozess- und Datenanalyse ist; LF 5 ist
berührt, weil die Testdaten inkl. `ALFKI` in der relationalen Datenhaltung von Secure OrderDesk liegen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section
"Secure OrderDesk Professional Tracks"). **LF 12c** is primary because evidencing that a customer-specific data
analysis of the trading domain is correct and reproducible is the core of process and data analysis; LF 5 is touched
because the test data incl. `ALFKI` lives in the relational data storage of Secure OrderDesk.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Der reproduzierbare Nachweis, dass eine Handels-Datenanalyse korrekt ist, gehört zum Kern von LF 12c. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Golden Dataset und Fixtures inkl. `ALFKI` liegen in der relationalen Datenhaltung von Secure OrderDesk. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, reproduzierbare Evidenz, Datenschutz und sichere
Programmierung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Testmanagement/Verifikation),
`CL_08` (Sicherheits-Code-Review der Umsatzberechnung) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung
dieser Einheit lautet: *Testdaten sind synthetisch inkl. `ALFKI`, ein Golden Dataset liefert das von Hand
berechnete Sollergebnis, Randfälle sind abgedeckt, Datenzugriffe erfolgen über parametrisierte Queries, und jeder
Nachweis ist reproduzierbar.* A11Y-Aspekt: Golden-Dataset- und Randfalltabellen müssen als reiner Text mit
Kopfzeile lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: testability, reproducible evidence, privacy, and secure
programming. Matching checklists: `CL_01` (standards applicability), `CL_04` (test management/verification), `CL_08`
(security code review of the revenue calculation), and `CL_12` (evidence and closure). The data decision of this
unit is: *test data is synthetic incl. `ALFKI`, a golden dataset provides the hand-computed target result, edge
cases are covered, data access uses parameterized queries, and every piece of evidence is reproducible.*
Accessibility aspect: golden-dataset and edge-case tables must be readable as plain text with a header row, without
color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet einen Code-Test vom Nachweis einer Datenaussage? /
   **EN:** What distinguishes a code test from evidencing a data claim?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Code-Test prüft, ob die Umsatzfunktion technisch korrekt rechnet. Der Nachweis einer Datenaussage
   prüft, ob die Kennzahl die fachlich zugesicherte Aussage trifft, inklusive Aussagegrenze. Eine korrekte Rechnung
   kann trotzdem eine falsche Aussage stützen, etwa Erlös mit Gewinn zu verwechseln.
   **EN:** The code test checks whether the revenue function computes technically correctly. Evidencing a data claim
   checks whether the metric makes its promised business statement, including the limit of validity. A correct
   calculation can still support a wrong statement, such as confusing earnings with profit.

   </details>

2. **DE:** (DPA) Wozu dient ein Golden Dataset und warum bleibt es unverändert? /
   **EN:** (DPA) What is a golden dataset for, and why does it stay unchanged?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es liefert ein vorher bekanntes, von Hand berechnetes Sollergebnis (z. B. den Umsatz zu `ALFKI`) als
   Maßstab. Bleibt es unverändert, ist der Vergleich stabil: Weicht die Berechnung ab, liegt der Fehler klar im Code
   oder in der Erwartung.
   **EN:** It provides a previously known, hand-computed target result (e.g. the revenue for `ALFKI`) as a
   yardstick. If it stays unchanged, the comparison is stable: if the calculation deviates, the fault clearly lies in
   the code or in the expectation.

   </details>

3. **DE:** (DPA) Welche drei Randfälle solltest du für eine Umsatzkennzahl mindestens prüfen? /
   **EN:** (DPA) Which three edge cases should you check at minimum for a revenue metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die leere Menge (kein Treffer, Nenner null, Division vermeiden), die Bestellung ohne Positionen (Umsatz
   null statt fehlend verworfen) und den Rabatt-Ausreißer (Discount = 0 oder über 100 %). Für jeden Fall wird das
   erwartete, sichere Verhalten festgelegt.
   **EN:** The empty set (no match, denominator zero, avoid division), the order without line items (revenue zero
   rather than discarded as missing), and the discount outlier (discount = 0 or above 100%). For each case the
   expected, safe behavior is defined.

   </details>

4. **DE:** Warum dürfen für die Tests keine echten personenbezogenen Kundendaten verwendet werden? /
   **EN:** Why must no real personal customer data be used for the tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Daten in Tests oder Fixtures schaffen ein Datenschutzrisiko und können in Repositories oder Logs
   landen. Synthetische Northwind-Daten inkl. des fiktiven `ALFKI` testen genauso gut, ohne dieses Risiko; Secrets
   stehen nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Real data in tests or fixtures creates a privacy risk and can end up in repositories or logs. Synthetic
   Northwind data incl. the fictional `ALFKI` tests just as well without that risk; secrets appear only as
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

5. **DE:** Warum ist ein Nachweis wertlos, wenn er nicht reproduzierbar ist? /
   **EN:** Why is evidence worthless if it is not reproducible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur ein wiederholbares Ergebnis lässt sich prüfen. Hängt der Umsatz von Zufall oder der aktuellen
   Systemzeit ab, kann niemand ihn nachvollziehen oder gegenprüfen. Feste Fixture und feste Parameter machen ihn
   belastbar.
   **EN:** Only a repeatable result can be checked. If the revenue depends on randomness or the current system time,
   no one can retrace or verify it. A fixed fixture and fixed parameters make it dependable.

   </details>

6. **DE:** (DV) Wie testest du eine Umsatzkennzahl über Schnittstellen- oder Zeitgrenzen hinweg? /
   **EN:** (DV) How do you test a revenue metric across interface or time boundaries?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einer festen Fixture und einem fixierten Auswertungszeitraum, damit Bestellungen nahe der
   Zeitgrenze immer gleich zugeordnet werden. Über Schnittstellen hinweg wird dasselbe Golden Sample verwendet, damit
   ein und dieselbe Eingabe überall denselben Umsatz ergibt; die Logik bleibt sprachneutral.
   **EN:** With a fixed fixture and a pinned evaluation period so orders near the time boundary are always assigned
   the same way. Across interfaces the same golden sample is used so one and the same input yields the same revenue
   everywhere; the logic stays language-neutral.

   </details>

7. **DE:** (SI) Wie stellt man eine reproduzierbare Testdatenbank ohne echte Daten bereit? /
   **EN:** (SI) How do you provide a reproducible test database without real data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit versionierten Fixture-Dateien (synthetische Northwind-Daten inkl. `ALFKI`), festen Parametern und
   einer isolierten Umgebung (z. B. Sandbox), in der keine echten Produktionsdaten liegen. Zugriffe erfolgen über
   parametrisierte Queries. So läuft der Test überall gleich und gefährdet keine echten Kundendaten.
   **EN:** With versioned fixture files (synthetic Northwind data incl. `ALFKI`), fixed parameters, and an isolated
   environment (e.g. sandbox) that holds no real production data. Access uses parameterized queries. This way the
   test runs the same everywhere and endangers no real customer data.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Code-Test vom Nachweis einer Datenaussage unterscheiden.
- [ ] synthetische Northwind-Testdaten inkl. `ALFKI` ohne echten Personenbezug wählen.
- [ ] ein Golden Dataset mit von Hand berechnetem Umsatz-Sollergebnis anlegen.
- [ ] die Randfälle leere Menge, Bestellung ohne Positionen und Rabatt-Ausreißer abdecken.
- [ ] einen Nachweis reproduzierbar über parametrisierte Queries erzeugen und prüfen.
- [ ] nicht anwendbare Teststandards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] distinguish a code test from evidencing a data claim.
- [ ] choose synthetic Northwind test data incl. `ALFKI` without real personal reference.
- [ ] build a golden dataset with a hand-computed revenue target result.
- [ ] cover the edge cases empty set, order without line items, and discount outlier.
- [ ] produce and check evidence reproducibly via parameterized queries.
- [ ] document non-applicable testing standards as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md`. Es übernimmt
die Aussagegrenzen aus Einheit 06 und liefert die Nachweise für das Abschluss-Review in Einheit 10. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md`. It carries
over the interpretation limits from unit 06 and provides the evidence for the closing review in unit 10. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
