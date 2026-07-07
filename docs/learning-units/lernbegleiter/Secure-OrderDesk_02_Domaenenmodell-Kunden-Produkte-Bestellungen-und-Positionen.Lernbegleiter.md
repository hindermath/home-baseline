# Lernbegleiter: Secure OrderDesk 02 – Domänenmodell: Kunden, Produkte, Bestellungen und Positionen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_02_Domaenenmodell-Kunden-Produkte-Bestellungen-und-Positionen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure OrderDesk verwaltet Kunden, Produkte und Bestellungen der Handelsfirma Secure Trader. Damit
die Daten verlässlich sind, braucht er ein sauberes **relationales Domänenmodell**. Dabei gibt es zwei Arten
von Daten: **Stammdaten**, die sich selten ändern (ein Kunde wie `ALFKI` mit `CompanyName` und `ContactName`,
ein Produkt mit `ProductName` und `UnitPrice`), und **Bewegungsdaten**, die bei jedem Geschäftsvorfall neu
entstehen (eine `Order` und ihre `OrderLine`-Positionen). Eine Bestellung hat viele Positionen – das ist ein
**Master-Detail-Muster**. Positionen und Bestellungen zeigen über **Fremdschlüssel** auf Kunden und Produkte.
Zusätzlich kann eine Bestellung in einem **Zustand** sein, z. B. `new`, `confirmed`, `shipped` oder
`cancelled`. Manche Wechsel sind sinnvoll, andere nicht. In dieser Einheit modellierst du ein kleines, sicheres
relationales Modell im Northwind-Layout und legst genau fest, welche Beziehungen und Zustandswechsel gültig
sind.

**EN:** The Secure OrderDesk manages customers, products, and orders of the trading company Secure Trader. For
the data to be reliable, it needs a clean **relational domain model**. There are two kinds of data: **master
data** that rarely changes (a customer like `ALFKI` with `CompanyName` and `ContactName`, a product with
`ProductName` and `UnitPrice`), and **transactional data** created with each business event (an `Order` and its
`OrderLine` items). One order has many lines – this is a **master-detail pattern**. Lines and orders point to
customers and products via **foreign keys**. In addition, an order can be in a **state**, e.g. `new`,
`confirmed`, `shipped`, or `cancelled`. Some transitions make sense, others do not. In this unit you model a
small, secure relational model in Northwind layout and define exactly which relationships and state transitions
are valid.

**DE:** Du definierst die Entitäten `Customer`, `Product`, `Order` (Bestellkopf) und `OrderLine`
(Bestellposition, entspricht `Order Details`), ihre Pflicht- und optionalen Felder, Primär- und Fremdschlüssel
sowie die erlaubten und verbotenen Zustandswechsel. Die verbindliche Datenbasis ist die klassische
Northwind-Sample-DB inkl. `ALFKI`.

**EN:** You define the entities `Customer`, `Product`, `Order` (order header), and `OrderLine` (order line,
equivalent to `Order Details`), their mandatory and optional fields, primary and foreign keys, and the allowed
and forbidden state transitions. The binding data base is the classic Northwind sample database incl. `ALFKI`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Domänenmodell / Domain model | Beschreibung der fachlichen Dinge (Entitäten) mit Feldern und Regeln. |
| Stammdaten / Master data | Daten, die sich selten ändern, z. B. Kunde (`ALFKI`), Produkt, Kategorie. |
| Bewegungsdaten / Transactional data | Daten aus Geschäftsvorfällen, z. B. eine Bestellung und ihre Positionen. |
| Primärschlüssel / Primary key | Feld, das einen Datensatz eindeutig identifiziert, z. B. `CustomerID`, `OrderID`. |
| Fremdschlüssel / Foreign key | Feld, das auf einen Datensatz einer anderen Tabelle verweist. |
| Master-Detail / Master-detail | Muster: eine Bestellung (Master) hat viele Positionen (Detail). |
| Bestellzustand / Order state | Lage einer Bestellung, z. B. `new`, `confirmed`, `shipped`, `cancelled`. |
| Datenminimierung / Data minimization | Nur wirklich benötigte Felder speichern. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Stammdaten und Bewegungsdaten trennen.** Beschreibe `Customer` und `Product` als
Stammdaten (ändern sich selten) und `Order` mit `OrderLine` als Bewegungsdaten (entstehen bei jeder
Bestellung). Warum trennen? Weil Stammdaten dauerhaft gepflegt werden, während Bestellungen ständig hinzukommen.
Vermischt man beides, verliert man Übersicht und Historie.

**EN:** **Step 1 – Separate master data and transactional data.** Describe `Customer` and `Product` as master
data (rarely change) and `Order` with `OrderLine` as transactional data (created with each order). Why
separate? Because master data is maintained persistently while orders keep being added. Mixing both means you
lose overview and history.

**DE:** **Schritt 2 – Pflichtfelder, optionale Felder und Schlüssel festlegen.** Jede Entität braucht einen
Primärschlüssel (`CustomerID`, `ProductID`, `OrderID`). `OrderLine` verweist über Fremdschlüssel auf `Order`
und `Product`; `Order` verweist auf `Customer`. Lege fest, welche Felder Pflicht sind (z. B. `Quantity` und
`UnitPrice` in `OrderLine`) und welche optional. Jedes Pflichtfeld braucht eine fachliche Begründung. Warum?
Zu viele Pflichtfelder blockieren die Erfassung, zu wenige lassen unvollständige Bestellungen zu.

**EN:** **Step 2 – Define mandatory fields, optional fields, and keys.** Every entity needs a primary key
(`CustomerID`, `ProductID`, `OrderID`). `OrderLine` references `Order` and `Product` via foreign keys; `Order`
references `Customer`. Define which fields are mandatory (e.g. `Quantity` and `UnitPrice` in `OrderLine`) and
which are optional. Every mandatory field needs a functional justification. Why? Too many mandatory fields
block data entry, too few allow incomplete orders.

**DE:** **Schritt 3 – Beziehungen und referenzielle Integrität.** Eine Position ohne gültige Bestellung darf
nicht existieren; eine Bestellung ohne gültigen Kunden ebenfalls nicht. Das nennt man **referenzielle
Integrität**. Der Pflicht-Datensatz `ALFKI` ist ein fester Anker: Eine Beispielbestellung von `ALFKI` mit zwei
Positionen zeigt das Master-Detail-Muster konkret. Warum wichtig? Ohne Integritätsregeln entstehen „verwaiste"
Positionen oder Bestellungen für nicht existierende Kunden.

**EN:** **Step 3 – Relationships and referential integrity.** A line without a valid order must not exist; an
order without a valid customer must not either. This is called **referential integrity**. The mandatory record
`ALFKI` is a fixed anchor: an example order from `ALFKI` with two lines shows the master-detail pattern
concretely. Why important? Without integrity rules, "orphaned" lines or orders for non-existing customers
appear.

**DE:** **Schritt 4 – Zustände und erlaubte Übergänge definieren.** Nutze eine Zustandsmatrix. Beispiel:
`new -> confirmed` erlaubt, `confirmed -> shipped` erlaubt, `new -> cancelled` erlaubt. Ein Wechsel, der eine
Historie verfälscht, etwa `shipped -> new`, oder das Ändern einer bereits versendeten Bestellung ist verboten.
Ein Zustandswechsel darf nie allein aus einem rohen Eingabewert entstehen; er läuft über eine geprüfte Regel im
Modell. Warum eine Matrix? Sie zeigt lückenlos, welche Wechsel möglich sind, und macht verbotene sichtbar.

**EN:** **Step 4 – Define states and allowed transitions.** Use a state matrix. Example: `new -> confirmed`
allowed, `confirmed -> shipped` allowed, `new -> cancelled` allowed. A transition that falsifies history, such
as `shipped -> new`, or changing an already shipped order is forbidden. A state transition must never result
from a raw input value alone; it goes through a checked rule in the model. Why a matrix? It shows completely
which transitions are possible and makes forbidden ones visible.

**DE:** **Typische Fehler.** Stammdaten und Bewegungsdaten in eine Tabelle mischen. Fremdschlüssel und
referenzielle Integrität vergessen. Nur Erfolgspfade modellieren und Fehlerfälle (negative Menge, unbekannte
`ProductID`) übersehen. Interne IDs mit personenbezogenen Informationen füllen. Kundendaten über den
Bestellzweck hinaus speichern. Verbotene Zustandswechsel nicht ausdrücklich nennen.

**EN:** **Common mistakes.** Mixing master data and transactional data into one table. Forgetting foreign keys
and referential integrity. Modeling only success paths and missing error cases (negative quantity, unknown
`ProductID`). Filling internal IDs with personal information. Storing customer data beyond the ordering
purpose. Not explicitly naming forbidden state transitions.

### Beispiel / Example

```text
Entitaet Customer:  Pflicht: CustomerID, CompanyName      Optional: ContactName, City, Country
Entitaet Product:   Pflicht: ProductID, ProductName, UnitPrice   Optional: SupplierID, CategoryID
Entitaet Order:     Pflicht: OrderID, CustomerID(FK), OrderDate   Optional: EmployeeID, ShipVia
Entitaet OrderLine: Pflicht: OrderID(FK), ProductID(FK), UnitPrice, Quantity   Optional: Discount
Beziehung:          Order 1---* OrderLine   (Master-Detail)
Beziehung:          Order *---1 Customer,   OrderLine *---1 Product   (Fremdschluessel)
Beispiel (ALFKI):   Order 50218 -> Customer ALFKI; OrderLine (50218, Produkt 28, 45.60, 15, 0.05)
Zustaende:          new, confirmed, shipped, cancelled
Erlaubt:            new -> confirmed, confirmed -> shipped, new -> cancelled, confirmed -> cancelled
Verboten:           shipped -> new, versendete Bestellung aendern, OrderLine ohne gueltige Order
Regel:              Zustandswechsel nur ueber gepruefte Methode, nie direkt aus Rohdaten.
Datenschutz:        CustomerID technisch; keine Zahlungs-/Personaldaten; nur Bestellzweck-Felder.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Basis"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Secure OrderDesk Base"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Ein sauberes relationales Modell aus Kunden, Produkten, Bestellungen und Positionen ist die Grundlage der Datenverwaltung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Datenhungrige Kundenfelder und ungültige Zustandswechsel sind ein Schutzbedarfsthema. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Code-Erzeugung und Datenschutz
durch Datenminimierung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Modellentscheidungen) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser
Einheit lautet: *Beziehungs- und Zustandsregeln liegen im Modell, nicht in der Oberfläche, referenzielle
Integrität ist Pflicht, und es werden nur benötigte Kundendaten geführt.* A11Y-Aspekt: Beziehungen und
Zustandsübergänge werden als Textmatrix oder klare Liste dargestellt, nicht nur als Farbdiagramm, damit sie mit
Screenreader und Braille-Zeile lesbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure code generation, and privacy
through data minimization. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/model decisions), and `CL_08` (security code review). The security decision of this unit is:
*relationship and state rules live in the model, not in the UI, referential integrity is mandatory, and only
needed customer data is held.* Accessibility aspect: relationships and state transitions are shown as a text
matrix or clear list, not only as a color diagram, so they remain readable with a screen reader and Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt man Stammdaten (`Customer`, `Product`) und Bewegungsdaten (`Order`, `OrderLine`)? /
   **EN:** Why separate master data (`Customer`, `Product`) and transactional data (`Order`, `OrderLine`)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stammdaten ändern sich selten und werden dauerhaft gepflegt, Bestellungen kommen ständig hinzu.
   Getrennt bleibt die Übersicht erhalten, Stammdaten werden nicht bei jeder Bestellung dupliziert, und die
   Historie bleibt konsistent.
   **EN:** Master data rarely changes and is maintained persistently, orders keep being added. Kept separate,
   the overview is preserved, master data is not duplicated with every order, and history stays consistent.

   </details>

2. **DE:** (AE) Welche Beziehungs- oder Zustandsregel gehört ins Domänenmodell und nicht erst in die Oberfläche? /
   **EN:** (AE) Which relationship or state rule belongs in the domain model and not only in the UI?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Referenzielle Integrität (Position nur zu gültiger Bestellung und gültigem Produkt) und die
   erlaubten Zustandswechsel. Sie müssen dort greifen, wo die Daten wirklich verändert werden, weil die
   Oberfläche umgangen werden kann.
   **EN:** Referential integrity (a line only to a valid order and valid product) and the allowed state
   transitions. They must apply where the data is really changed, because the UI can be bypassed.

   </details>

3. **DE:** Was bedeutet referenzielle Integrität, und was passiert ohne sie? /
   **EN:** What does referential integrity mean, and what happens without it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder Fremdschlüssel muss auf einen existierenden Datensatz zeigen. Ohne sie entstehen verwaiste
   Positionen ohne Bestellung oder Bestellungen für nicht existierende Kunden, und Auswertungen werden falsch.
   **EN:** Every foreign key must point to an existing record. Without it, orphaned lines without an order or
   orders for non-existing customers appear, and evaluations become wrong.

   </details>

4. **DE:** Warum dürfen interne IDs (`CustomerID`, `OrderID`) keine zusätzlichen personenbezogenen Informationen enthalten? /
   **EN:** Why must internal IDs (`CustomerID`, `OrderID`) not contain additional personal information?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** IDs erscheinen in Logs, Exporten und Auswertungen. Enthalten sie Namen oder Kontaktangaben, entsteht
   ein Datenschutzrisiko und ein unnötiger Personenbezug über den Bestellzweck hinaus.
   **EN:** IDs appear in logs, exports, and evaluations. If they contain names or contact details, a privacy
   risk and unnecessary personal reference beyond the ordering purpose arise.

   </details>

5. **DE:** (SI) Welche Integritätsregeln müssen früh feststehen, damit die Northwind-Datenbasis konsistent bleibt? /
   **EN:** (SI) Which integrity rules must be fixed early so the Northwind data base stays consistent?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eindeutige Primärschlüssel, gültige Fremdschlüssel (`Order`→`Customer`, `OrderLine`→`Order`/`Product`)
   und Pflichtfelder wie `Quantity` und `UnitPrice`. Nur so bleiben Bestellungen und Positionen widerspruchsfrei.
   **EN:** Unique primary keys, valid foreign keys (`Order`→`Customer`, `OrderLine`→`Order`/`Product`), and
   mandatory fields such as `Quantity` and `UnitPrice`. Only then do orders and lines stay consistent.

   </details>

6. **DE:** (DPA) Welche Datenqualität brauchst du im Modell für spätere Umsatz- und Bestellauswertungen? /
   **EN:** (DPA) Which data quality does the model need for later revenue and order evaluations?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Gültige Fremdschlüssel, plausible Mengen und Preise sowie ein klarer Bestellzustand. Nur so lassen
   sich Umsatz je Kunde oder die Zahl versendeter Bestellungen korrekt berechnen.
   **EN:** Valid foreign keys, plausible quantities and prices, and a clear order state. Only then can revenue
   per customer or the number of shipped orders be calculated correctly.

   </details>

7. **DE:** Warum ist der Pflicht-Datensatz `ALFKI` für dieses Domänenmodell nützlich? /
   **EN:** Why is the mandatory record `ALFKI` useful for this domain model?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `ALFKI` (Alfreds Futterkiste) ist ein fester, bekannter Anker. Eine Beispielbestellung von `ALFKI`
   mit mehreren Positionen zeigt Master-Detail und Fremdschlüssel konkret und macht Beispiele und Tests
   reproduzierbar.
   **EN:** `ALFKI` (Alfreds Futterkiste) is a fixed, well-known anchor. An example order from `ALFKI` with
   several lines shows master-detail and foreign keys concretely and makes examples and tests reproducible.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] `Customer`, `Product`, `Order` und `OrderLine` mit Zweck, Pflicht- und optionalen Feldern beschreiben.
- [ ] Stammdaten von Bewegungsdaten unterscheiden und das Master-Detail-Muster erklären.
- [ ] Primär- und Fremdschlüssel benennen und referenzielle Integrität erklären.
- [ ] erlaubte Bestellzustände in einer Matrix darstellen und verbotene ausdrücklich nennen.
- [ ] begründen, welche Kundenfelder aus Datenschutzgründen nicht gespeichert werden.
- [ ] die Northwind-Datenbasis inkl. `ALFKI` als Quelle benennen.

**EN:** I can …

- [ ] describe `Customer`, `Product`, `Order`, and `OrderLine` with purpose, mandatory, and optional fields.
- [ ] distinguish master data from transactional data and explain the master-detail pattern.
- [ ] name primary and foreign keys and explain referential integrity.
- [ ] show allowed order states in a matrix and explicitly name forbidden ones.
- [ ] justify which customer fields are not stored for privacy reasons.
- [ ] name the Northwind data base incl. `ALFKI` as the source.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_02_Domaenenmodell-Kunden-Produkte-Bestellungen-und-Positionen.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_02_Domaenenmodell-Kunden-Produkte-Bestellungen-und-Positionen.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
