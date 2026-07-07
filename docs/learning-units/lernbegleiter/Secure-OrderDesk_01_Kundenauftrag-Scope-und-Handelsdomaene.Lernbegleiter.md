# Lernbegleiter: Secure OrderDesk 01 – Kundenauftrag, Scope und Handelsdomäne / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die fiktive Handelsfirma **Secure Trader** bittet die EuFPA: „Wir verwalten Kunden, Produkte und
Bestellungen bisher unübersichtlich. Wir brauchen eine sichere Bestell-/Handelsplattform, die unsere Kunden-
und Bestelldaten sauber führt." Bevor auch nur eine Zeile Code entsteht, muss klar sein, **was** die Plattform
Secure OrderDesk leistet, **welche Daten** sie führt, **was sie nicht** tut und **welchen Schutzbedarf** die
Kunden- und Bestelldaten haben. Die verbindliche Datenbasis ist die klassische Northwind-Sample-Datenbank
inklusive des Pflicht-Datensatzes `ALFKI` (Alfreds Futterkiste).

**EN:** The fictional trading company **Secure Trader** asks EuFPA: "We currently manage customers, products,
and orders in a messy way. We need a secure ordering/trading platform that keeps our customer and order data
clean." Before a single line of code exists, it must be clear **what** the Secure OrderDesk platform does,
**which data** it holds, **what it does not** do, and **what protection need** the customer and order data
have. The binding data base is the classic Northwind sample database including the mandatory record `ALFKI`
(Alfreds Futterkiste).

**DE:** In dieser Einheit lernst du, einen Kundenauftrag in einen prüfbaren Scope zu übersetzen, die
Handelsdomäne (Kunden, Produkte, Bestellungen, Positionen) einzugrenzen und schon jetzt Sicherheits-,
Datenschutz- und Betriebsannahmen getrennt zu dokumentieren. Die Plattform bleibt im 1. Lehrjahr bewusst
einfach.

**EN:** In this unit you learn to translate a customer task into a testable scope, to delimit the trading
domain (customers, products, orders, order lines), and to document security, privacy, and operational
assumptions separately from the start. The platform stays deliberately simple in year 1.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Handelsplattform / Trading platform | Ein System, das Kunden, Produkte und Bestellungen einer Handelsfirma verwaltet. |
| Scope / Scope | Klar abgegrenzter Umfang: was gehört dazu und was nicht. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossener Punkt, damit der Umfang nicht unbemerkt wächst. |
| Kundenstammdaten / Customer master data | Angaben zu einem Kunden, z. B. Firmenname, Kontaktname, Anschrift. |
| Bestellung / Order | Ein Bestellkopf (wer, wann, wohin) mit mehreren Bestellpositionen. |
| Bestellposition / Order line | Eine Zeile einer Bestellung: Produkt, Menge, Einzelpreis, Rabatt. |
| Northwind / Northwind | Klassische Beispiel-Handelsdatenbank; hier verbindliche, fiktive Datenquelle inkl. `ALFKI`. |
| Schutzbedarf / Protection need | Einschätzung, wie schützenswert Daten hinsichtlich Vertraulichkeit, Integrität und Verfügbarkeit sind. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Kundenauftrag verstehen.** Lies den Auftrag von Secure Trader und schreibe in eigenen
Worten auf, welches Problem die Firma lösen will. Frage: Wer nutzt die Plattform? Wer sieht welche Daten? Ein
Auftrag, den du nicht in einem Satz zusammenfassen kannst, ist noch nicht verstanden.

**EN:** **Step 1 – Understand the customer task.** Read Secure Trader's task and write in your own words what
problem the company wants to solve. Ask: who uses the platform? Who sees which data? A task you cannot
summarize in one sentence is not yet understood.

**DE:** **Schritt 2 – Die Handelsdomäne abgrenzen.** Die Northwind-Basis kennt viele Tabellen (Kunden,
Produkte, Kategorien, Lieferanten, Bestellungen, Positionen, Versender, Mitarbeitende). Für das 1. Lehrjahr
entscheidest du bewusst, welche fachlichen Kernobjekte im Scope sind – typischerweise Kunden, Produkte,
Bestellungen und Bestellpositionen – und hältst den Rest zunächst heraus. So bleibt die Plattform überschaubar.

**EN:** **Step 2 – Delimit the trading domain.** The Northwind base has many tables (customers, products,
categories, suppliers, orders, order lines, shippers, employees). For year 1 you deliberately decide which
core objects are in scope – typically customers, products, orders, and order lines – and keep the rest out for
now. This keeps the platform manageable.

**DE:** **Schritt 3 – Datenarten und Scope benennen.** Liste die zu führenden Datenarten auf, zum Beispiel
Firmenname, Kontaktname, Anschrift, Bestellkopf und Bestellpositionen. Für jedes Feld notierst du, warum es
gebraucht wird. Nur benannte Daten lassen sich später modellieren und schützen. Nenne die Northwind-Quelle und
den Pflicht-Datensatz `ALFKI` als festen Anker.

**EN:** **Step 3 – Name data types and scope.** List the data to be held, for example company name, contact
name, address, order header, and order lines. For each field, note why it is needed. Only named data can later
be modeled and protected. Name the Northwind source and the mandatory record `ALFKI` as a fixed anchor.

**DE:** **Schritt 4 – Nicht-Ziele festlegen.** Genauso wichtig wie der Umfang ist, was **nicht** dazugehört.
Beispiel: „Diese Plattform wickelt keine Zahlungen ab, speichert keine Zahlungsdaten und verwaltet keine
Lohn-/Personaldaten der Mitarbeitenden." Nicht-Ziele verhindern Scope-Creep und schützen vor dem Speichern
unnötiger personenbezogener Daten (Datenminimierung).

**EN:** **Step 4 – Define non-goals.** Just as important as the scope is what does **not** belong. Example:
"This platform does not process payments, does not store payment data, and does not manage employees' payroll
or HR data." Non-goals prevent scope creep and protect against storing unnecessary personal data (data
minimization).

**DE:** **Schritt 5 – Schutzbedarf und Annahmen trennen.** Schreibe Sicherheits-, Datenschutz- und
Betriebsannahmen in getrennte Zeilen. Warum getrennt? Weil sie unterschiedliche Prüfungen brauchen:
Sicherheit prüft Angreifer (z. B. manipulierte Bestelleingaben), Datenschutz prüft personenbezogene
Kundendaten, Betrieb prüft Datenbank und Umgebung. Positive Sicherheitsaussagen ohne Nachweis sind nur
Wunschdenken; verweise deshalb je Aussage auf einen Nachweispfad.

**EN:** **Step 5 – Separate protection need and assumptions.** Write security, privacy, and operational
assumptions in separate lines. Why separate? Because they need different checks: security considers attackers
(e.g. manipulated order input), privacy considers personal customer data, operations considers database and
environment. Positive security claims without evidence are only wishful thinking; therefore point each claim
to an evidence path.

**DE:** **Typische Fehler.** Den Auftrag zu weit fassen. Sofort an Datenbanktechnik, ORM oder eine API denken,
statt die Domäne einfach zu halten. Nicht-Ziele weglassen. Kundendaten nur vage benennen. Sicherheitsaussagen
ohne Nachweis. Nicht anwendbare Standards stillschweigend weglassen statt sie als `N/A` mit kurzer Begründung
zu dokumentieren.

**EN:** **Common mistakes.** Framing the task too broadly. Immediately thinking about database technology, ORM,
or an API instead of keeping the domain simple. Omitting non-goals. Naming customer data only vaguely.
Security claims without evidence. Silently dropping non-applicable standards instead of documenting them as
`N/A` with a short justification.

### Beispiel / Example

```text
Kundenauftrag:   "Führe unsere Kunden, Produkte und Bestellungen sauber und sicher in einer Plattform."

Datenbasis:      klassische Northwind-Sample-DB (fiktiv), Pflicht-Datensatz ALFKI (Alfreds Futterkiste)
Im Scope:        Kunden, Produkte, Bestellungen (Kopf), Bestellpositionen
Nicht-Ziel:      Zahlungsabwicklung, Zahlungsdaten, Lohn-/Personaldaten, Rechteverwaltung als Endprodukt
Kernobjekte:     Customer { id, company, contact, city, country }
                 Order { id, customer, employee, date }; OrderLine { product, qty, price, discount }
Schutzbedarf:    Vertraulichkeit Kundendaten = mittel/hoch; Integrität Bestellungen = hoch
Annahme (Sec):   Bestelleingaben gelten als nicht vertrauenswürdig  -> Nachweis: Validierungstest
Annahme (Daten): Nur benötigte Kundenfelder werden geführt          -> Nachweis: Datenminimierungs-Review
N/A:             Zahlungsabwicklung in dieser Einheit N/A (kein Bezahl-Flow) -> Begründung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Kundenauftrag der Handelsfirma und die eigene Rolle im Projekt stehen im Mittelpunkt. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Schutzbedarf der Kunden- und Bestelldaten und Trennung der Annahmen werden erstmals geübt. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Der Auftrag ist eine Serviceanfrage, die verstanden und abgegrenzt werden muss. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Standards-Anwendbarkeit, sichere Code-Review-Perspektive,
Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Der Umfang wird bewusst begrenzt, Bestelleingaben gelten als
nicht vertrauenswürdig, es werden nur benötigte Kundendaten geführt, und jede Sicherheitsaussage erhält einen
Nachweispfad.* A11Y-Aspekt: Scope-Tabellen und Nicht-Ziele müssen als klarer Text lesbar sein, ohne reine
Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: standards applicability, a secure code-review
perspective, testability, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability),
`CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence and closure). The security decision
of this unit is: *scope is deliberately limited, order input is treated as untrusted, only needed customer
data is held, and every security claim gets an evidence path.* Accessibility aspect: scope tables and
non-goals must be readable as clear text, without color-only marking, so they remain usable with a screen
reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum grenzt man die Handelsdomäne im 1. Lehrjahr bewusst auf wenige Kernobjekte ein? /
   **EN:** Why deliberately limit the trading domain to a few core objects in year 1?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Northwind-Basis hat viele Tabellen. Ein zu großer Umfang überfordert und lässt sich nicht gegen
   den Auftrag prüfen. Mit wenigen Kernobjekten (Kunden, Produkte, Bestellungen, Positionen) bleibt die
   Plattform überschaubar, modellierbar und testbar.
   **EN:** The Northwind base has many tables. Too large a scope overwhelms and cannot be checked against the
   task. With a few core objects (customers, products, orders, order lines) the platform stays manageable,
   modelable, and testable.

   </details>

2. **DE:** Warum muss der Scope vor der Umsetzung klar abgegrenzt sein? /
   **EN:** Why must the scope be clearly defined before implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne klaren Scope wächst der Umfang unkontrolliert (Scope-Creep), es werden unnötige Daten geführt,
   und das Ergebnis lässt sich nicht gegen den Auftrag prüfen. Ein abgegrenzter Umfang macht das Ergebnis
   messbar und wartbar.
   **EN:** Without a clear scope the scope grows uncontrollably (scope creep), unnecessary data is held, and
   the result cannot be checked against the task. A defined scope makes the result measurable and maintainable.

   </details>

3. **DE:** Warum sollen Bestelleingaben als „nicht vertrauenswürdig" behandelt werden? /
   **EN:** Why should order input be treated as "untrusted"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eingaben können falsch, unvollständig oder manipuliert sein (z. B. negative Mengen, überhöhte
   Rabatte). Wer sie ungeprüft übernimmt, riskiert falsche Bestellungen und Sicherheitslücken. Deshalb werden
   sie an der Vertrauensgrenze validiert.
   **EN:** Input can be wrong, incomplete, or manipulated (e.g. negative quantities, excessive discounts).
   Accepting it unchecked risks wrong orders and security gaps. Therefore it is validated at the trust
   boundary.

   </details>

4. **DE:** Warum ist der Pflicht-Datensatz `ALFKI` in der Northwind-Basis nützlich? /
   **EN:** Why is the mandatory record `ALFKI` in the Northwind base useful?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `ALFKI` (Alfreds Futterkiste) ist ein fester, bekannter Anker. Beispiele, Tests und Nachweise können
   verlässlich auf denselben Kunden verweisen, was Aufgaben vergleichbar und reproduzierbar macht.
   **EN:** `ALFKI` (Alfreds Futterkiste) is a fixed, well-known anchor. Examples, tests, and evidence can
   reliably refer to the same customer, which makes tasks comparable and reproducible.

   </details>

5. **DE:** (DPA) Welche Datenschutzannahme ist bei Kundendaten besonders wichtig und wie weist man sie nach? /
   **EN:** (DPA) Which privacy assumption matters most for customer data, and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Datenminimierung: Es werden nur die Kundenfelder geführt, die für Bestellungen wirklich nötig sind.
   Nachweis: ein Datenminimierungs-Review, das jedes gespeicherte Feld gegen einen Zweck prüft.
   **EN:** Data minimization: only the customer fields truly needed for orders are held. Evidence: a data
   minimization review that checks each stored field against a purpose.

   </details>

6. **DE:** (AE) Welche spätere Implementierungsentscheidung hängt direkt vom abgegrenzten Scope ab? /
   **EN:** (AE) Which later implementation decision depends directly on the defined scope?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel das Domänenmodell und die Datenzugriffsschicht: Nur benannte Kernobjekte und Felder
   werden modelliert und über sichere, parametrisierte Zugriffe angesprochen. Ein unklarer Scope führt zu einem
   unklaren Modell.
   **EN:** For example the domain model and the data access layer: only named core objects and fields are
   modeled and accessed via secure, parameterized queries. An unclear scope leads to an unclear model.

   </details>

7. **DE:** Wozu dienen Nicht-Ziele in diesem Lastenheft? /
   **EN:** What is the purpose of non-goals in this intake?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht-Ziele grenzen bewusst aus, was nicht dazugehört, etwa Zahlungsabwicklung oder Personaldaten.
   Sie verhindern Scope-Creep und schützen vor dem Speichern unnötiger, oft personenbezogener Daten
   (Datenminimierung).
   **EN:** Non-goals deliberately exclude what does not belong, such as payment processing or HR data. They
   prevent scope creep and protect against storing unnecessary, often personal data (data minimization).

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: Zahlungs-
   abwicklung ist `N/A`, weil es in dieser Einheit keinen Bezahl-Flow gibt. So bleibt sichtbar, dass der
   Standard geprüft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: payment processing is
   `N/A` because there is no payment flow in this unit. This keeps visible that the standard was checked.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Kundenauftrag der Handelsfirma in einem Satz zusammenfassen.
- [ ] die Handelsdomäne auf wenige Kernobjekte (Kunden, Produkte, Bestellungen, Positionen) eingrenzen.
- [ ] die zu führenden Kunden- und Bestelldaten mit Begründung benennen.
- [ ] die Northwind-Datenbasis inkl. `ALFKI` als Quelle benennen.
- [ ] mindestens zwei sinnvolle Nicht-Ziele formulieren.
- [ ] Sicherheits-, Datenschutz- und Betriebsannahmen getrennt notieren und je Sicherheitsaussage einen Nachweispfad angeben.

**EN:** I can …

- [ ] summarize the trading company's customer task in one sentence.
- [ ] limit the trading domain to a few core objects (customers, products, orders, order lines).
- [ ] name the customer and order data to be held with a rationale.
- [ ] name the Northwind data base incl. `ALFKI` as the source.
- [ ] state at least two meaningful non-goals.
- [ ] note security, privacy, and operational assumptions separately and give an evidence path for each security claim.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
