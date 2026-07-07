# Lernbegleiter: Secure OrderDesk v2 03 – Relationales Persistenzmodell und Backend-Abstraktion / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure OrderDesk speichert Kunden, Produkte, Kategorien, Bestellungen und Bestellpositionen im **Northwind-Layout** inkl. `ALFKI`. In v2 lernst du, diese relationale Ablage hinter einer **Speicher-Abstraktion** zu verstecken – einem stabilen Vertrag (z. B. `IOrderStore`), den die Fachlogik aufruft, ohne die konkrete Datenbank zu kennen. So kannst du das **Backend wechseln**: SQLite für lokale Tests, PostgreSQL für den Betrieb, SQL Server, wenn die Kundenfirma Secure Trader es verlangt – **ohne die Fachlogik zu ändern**.

**EN:** The Secure OrderDesk stores customers, products, categories, orders, and order lines in **Northwind layout** incl. `ALFKI`. In v2 you learn to hide this relational store behind a **storage abstraction** – a stable contract (e.g. `IOrderStore`) that the business logic calls without knowing the concrete database. This lets you **swap the backend**: SQLite for local tests, PostgreSQL for operation, SQL Server if the client company Secure Trader requires it – **without changing the business logic**.

**DE:** Der zweite Kern ist **SQL-Sicherheit**: **Jeder** Datenbankzugriff läuft über **parametrisierte Queries** (Platzhalter, gebundene Parameter). Eingaben werden nie per String-Verkettung in SQL eingebaut – das ist die wichtigste Abwehr gegen **SQL-Injection (CWE-89)**. Auch dynamische Teile wie Sortierspalte oder Filter kommen nur über eine geprüfte **Allowlist** in die Abfrage.

**EN:** The second core is **SQL security**: **every** database access uses **parameterized queries** (placeholders, bound parameters). Input is never inserted into SQL via string concatenation – this is the most important defense against **SQL injection (CWE-89)**. Dynamic parts such as sort column or filter also enter the query only through a checked **allow-list**.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Speicher-Abstraktion / Storage abstraction | Stabiler Vertrag (z. B. `IOrderStore`), der Fachlogik und Datenbank trennt. |
| Relationales Backend / Relational backend | Konkrete SQL-Datenbank: SQLite, PostgreSQL oder SQL Server. |
| Northwind-Layout / Northwind layout | Kanonisches Schema mit `Customers`, `Products`, `Orders`, `Order Details`. |
| Parametrisierte Query / Parameterized query | Abfrage mit Platzhaltern; Werte werden gebunden, nicht in Text eingebaut. |
| SQL-Injection / SQL injection | Angriff, der über ungeprüfte Eingabe eigenes SQL einschleust (CWE-89). |
| Allowlist / Allow-list | Feste Liste erlaubter Feldnamen für dynamische Sortierung/Filter. |
| Datenminimierung / Data minimization | Nur wirklich benötigte (Kunden-)Felder speichern und selektieren. |
| Migration / Migration | Kontrollierter, versionierter Schema-Aufbau/-Umbau je Backend. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Speichervertrag definieren.** Beschreibe die Operationen, die die Fachlogik braucht: `Kunde lesen`, `Bestellungen eines Kunden lesen`, `Produkte einer Kategorie lesen`, `Bestellung speichern`, `Umsatz je Zeitraum`. Diese Operationen bilden den Vertrag `IOrderStore`. **Warum wichtig:** Der Vertrag beschreibt *was* gespeichert wird, nicht *wie* – so bleibt die Fachlogik vom Backend unabhängig.

**EN:** **Step 1 – Define the storage contract.** Describe the operations the business logic needs: `read customer`, `read a customer's orders`, `read products of a category`, `save order`, `revenue per period`. These operations form the `IOrderStore` contract. **Why it matters:** the contract describes *what* is stored, not *how* – so the business logic stays independent of the backend.

**DE:** **Schritt 2 – Northwind-Layout festhalten.** Notiere Tabellen, Primär- und Fremdschlüssel: `Orders.CustomerID → Customers`, `Order Details.OrderID → Orders`, `Order Details.ProductID → Products`, `Products.CategoryID → Categories`. `ALFKI` bleibt als fester Anker aktiv. **Warum wichtig:** Ein sauberes Schema mit Fremdschlüsseln sichert referenzielle Integrität – eine Position ohne gültige Bestellung darf nicht existieren.

**EN:** **Step 2 – Record the Northwind layout.** Note tables, primary and foreign keys: `Orders.CustomerID → Customers`, `Order Details.OrderID → Orders`, `Order Details.ProductID → Products`, `Products.CategoryID → Categories`. `ALFKI` stays active as a fixed anchor. **Why it matters:** a clean schema with foreign keys secures referential integrity – a line without a valid order must not exist.

**DE:** **Schritt 3 – Nur parametrisierte Queries.** Jede Abfrage nutzt Platzhalter und gebundene Parameter. Beispiel: `SELECT ... FROM Orders WHERE CustomerID = @cust` mit gebundenem Wert `ALFKI`, **nie** `"... WHERE CustomerID = '" + eingabe + "'"`. **Warum wichtig:** So kann eine Eingabe wie `ALFKI'; DROP TABLE Orders;--` nichts anrichten – sie ist nur ein Wert, kein Code.

**EN:** **Step 3 – Only parameterized queries.** Every query uses placeholders and bound parameters. Example: `SELECT ... FROM Orders WHERE CustomerID = @cust` with bound value `ALFKI`, **never** `"... WHERE CustomerID = '" + input + "'"`. **Why it matters:** this way an input like `ALFKI'; DROP TABLE Orders;--` can do nothing – it is just a value, not code.

**DE:** **Schritt 4 – Dynamische Teile über Allowlist.** Manchmal soll nach einer wählbaren Spalte sortiert oder gefiltert werden. Spaltennamen kann man **nicht** binden. Bilde die Eingabe daher auf eine feste Liste erlaubter Feldnamen ab (`{"OrderDate", "Freight"}`); alles andere wird abgelehnt. **Warum wichtig:** So gelangt kein Eingabetext in rohes SQL.

**EN:** **Step 4 – Dynamic parts via allow-list.** Sometimes a selectable column should be used for sorting or filtering. Column names **cannot** be bound. So map the input onto a fixed list of allowed field names (`{"OrderDate", "Freight"}`); anything else is rejected. **Why it matters:** this way no input text reaches raw SQL.

**DE:** **Schritt 5 – Backend-Wechsel und Migration.** Halte fest, wie dasselbe Schema in SQLite, PostgreSQL und SQL Server entsteht (Migrationen/DDL) und welche Unterschiede es gibt (Datentypen, Auto-Increment, Datumsformate). **Warum wichtig:** Nur wenn der Wechsel geplant ist, bleibt die Abstraktion echt austauschbar und die Fachlogik unverändert.

**EN:** **Step 5 – Backend switch and migration.** Record how the same schema is created in SQLite, PostgreSQL, and SQL Server (migrations/DDL) and what differs (data types, auto-increment, date formats). **Why it matters:** only if the switch is planned does the abstraction stay truly swappable and the business logic unchanged.

**DE:** **Typische Fehler.** SQL aus Eingaben zusammenkleben. Spaltennamen „binden" wollen statt Allowlist nutzen. Datenbankfehler mit SQL-Text und Tabellennamen an Endnutzer zeigen. Zu viele Kundenfelder speichern. Das Backend fest in die Fachlogik verdrahten, sodass ein Wechsel unmöglich wird.

**EN:** **Common mistakes.** Gluing SQL together from input. Trying to "bind" column names instead of using an allow-list. Showing database errors with SQL text and table names to end users. Storing too many customer fields. Wiring the backend firmly into the business logic so a switch becomes impossible.

### Beispiel / Example

```text
Speichervertrag (Auszug):
  IOrderStore.GetOrdersByCustomer(customerId)   -> parametrisiert: WHERE CustomerID = @cust
  IOrderStore.GetProductsByCategory(categoryId) -> parametrisiert: WHERE CategoryID = @cat
  IOrderStore.SaveOrder(order)                  -> INSERT mit gebundenen Parametern
  IOrderStore.RevenueByPeriod(from, to)         -> WHERE OrderDate BETWEEN @from AND @to

Sicher (parametrisiert):
  SELECT OrderID, OrderDate, Freight FROM Orders WHERE CustomerID = @cust
  Parameter @cust = "ALFKI"

Unsicher (VERBOTEN, String-Verkettung):
  "SELECT ... FROM Orders WHERE CustomerID = '" + eingabe + "'"
  Angriff: eingabe = ALFKI'; DROP TABLE Orders;--

Dynamische Sortierung nur ueber Allowlist:
  erlaubt = { "OrderDate", "Freight" }
  wenn sortierfeld nicht in erlaubt -> ablehnen (kein rohes SQL)

Backend-Wechsel (gleiches Schema, andere Ablage):
  SQLite  -> lokale Tests
  PostgreSQL -> Betrieb
  SQL Server -> falls Secure Trader es verlangt
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das relationale Persistenzmodell und die Abstraktion sind der Kern der Datenverwaltung. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Der Backend-Wechsel und der Speichervertrag bereiten systemübergreifende Bereitstellung vor. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung (SQL-Sicherheit), sichere Architektur, Datenschutz durch Datenminimierung und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (sichere Konfiguration/Verbindungszeichenketten), `CL_04` (sichere Datenzugriffe), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Jeder Datenbankzugriff ist parametrisiert; dynamische Felder nur über Allowlist; kein SQL-Text in Fehlermeldungen an Endnutzer.* A11Y-Aspekt: Beschreibe das Schema und den Query-Katalog als Text-Tabelle; nutze eindeutige Feldnamen statt farbiger Markierungen, damit Screenreader und Braille-Zeile alles erfassen.

**EN:** Relation to the Secure Development Guideline: secure programming (SQL security), secure architecture, privacy through data minimization, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (secure configuration/connection strings), `CL_04` (secure data access), `CL_08` (security code review), and `CL_10` (privacy). The security decision of this unit is: *every database access is parameterized; dynamic fields only via allow-list; no SQL text in error messages to end users.* Accessibility aspect: describe the schema and query catalog as a text table; use unambiguous field names instead of colored markings so a screen reader and Braille display can grasp everything.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum versteckt man das Backend hinter einer Abstraktion wie `IOrderStore`? /
   **EN:** Why hide the backend behind an abstraction like `IOrderStore`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Fachlogik spricht nur mit dem Vertrag, nicht mit einer konkreten Datenbank. So kann man SQLite, PostgreSQL oder SQL Server wechseln und einzelne Teile testen, ohne die Fachlogik zu ändern.
   **EN:** The business logic talks only to the contract, not to a concrete database. This lets you swap SQLite, PostgreSQL, or SQL Server and test individual parts without changing the business logic.

   </details>

2. **DE:** Warum wehrt eine parametrisierte Query SQL-Injection ab? /
   **EN:** Why does a parameterized query defend against SQL injection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Eingabewert wird als reiner Wert gebunden, nicht als Code interpretiert. Selbst `ALFKI'; DROP TABLE Orders;--` bleibt nur ein Kundenname-Wert und verändert die Abfragestruktur nicht.
   **EN:** The input value is bound as a pure value, not interpreted as code. Even `ALFKI'; DROP TABLE Orders;--` stays only a customer-name value and does not change the query structure.

   </details>

3. **DE:** (AE) Wie behandelt man eine wählbare Sortierspalte sicher? /
   **EN:** (AE) How do you handle a selectable sort column securely?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Spaltennamen kann man nicht binden. Man bildet die Eingabe auf eine feste Allowlist erlaubter Feldnamen ab und lehnt alles andere ab; so gelangt kein Eingabetext in rohes SQL.
   **EN:** Column names cannot be bound. You map the input onto a fixed allow-list of permitted field names and reject anything else; this way no input text reaches raw SQL.

   </details>

4. **DE:** (SI) Warum ist die Verbindungszeichenkette ein Secret? /
   **EN:** (SI) Why is the connection string a secret?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie enthält oft Zugangsdaten zur Datenbank. Sie gehört nie in den Quellcode oder ein getracktes Config-File, sondern in einen Secret-Store; im Material steht nur `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** It often contains database credentials. It never belongs in source code or a tracked config file but in a secret store; in the material only `<PLATZHALTER-KEIN-ECHTER-WERT>` appears.

   </details>

5. **DE:** (DPA) Was bedeutet Datenminimierung bei Kundenabfragen? /
   **EN:** (DPA) What does data minimization mean for customer queries?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man selektiert und speichert nur wirklich benötigte Kundenfelder (z. B. `CompanyName`, `City`), keine überflüssigen personenbezogenen Daten. Weniger Daten bedeuten weniger Risiko bei einem Leck.
   **EN:** You select and store only genuinely needed customer fields (e.g. `CompanyName`, `City`), no superfluous personal data. Less data means less risk in a leak.

   </details>

6. **DE:** (DV) Warum ist die Datenbankgrenze eine Vertrauens- und Datenabflussstelle? /
   **EN:** (DV) Why is the database boundary a trust and data-leak point?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Dort treffen ungeprüfte Eingaben auf gespeicherte Daten. An dieser Grenze müssen Eingaben validiert, Zugriffe parametrisiert und Fehler ohne interne Details behandelt werden, damit weder Injection noch Datenabfluss entsteht.
   **EN:** There untrusted input meets stored data. At this boundary input must be validated, access parameterized, and errors handled without internal details, so that neither injection nor data leakage occurs.

   </details>

7. **DE:** Warum darf ein Datenbankfehler keinen SQL-Text an Endnutzer zeigen? /
   **EN:** Why must a database error not show SQL text to end users?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** SQL-Text, Tabellennamen und Stack-Traces verraten interne Struktur und helfen Angreifern. Details bleiben im internen Log (ohne Secrets); der Endnutzer bekommt nur eine neutrale Meldung.
   **EN:** SQL text, table names, and stack traces reveal internal structure and help attackers. Details stay in the internal log (without secrets); the end user only gets a neutral message.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Speichervertrag (`IOrderStore`) mit den nötigen Operationen beschreiben.
- [ ] das Northwind-Layout mit Primär- und Fremdschlüsseln inkl. `ALFKI` skizzieren.
- [ ] erklären, warum jeder Zugriff parametrisiert sein muss.
- [ ] dynamische Sortier-/Filterfelder über eine Allowlist sicher abbilden.
- [ ] einen Backend-Wechsel SQLite → PostgreSQL → SQL Server ohne Änderung der Fachlogik begründen.

**EN:** I can …

- [ ] describe a storage contract (`IOrderStore`) with the necessary operations.
- [ ] sketch the Northwind layout with primary and foreign keys incl. `ALFKI`.
- [ ] explain why every access must be parameterized.
- [ ] map dynamic sort/filter fields securely via an allow-list.
- [ ] justify a backend switch SQLite → PostgreSQL → SQL Server without changing the business logic.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
