# Lernbegleiter: Secure OrderDesk 06 – Persistenz, SQL und sichere Datenzugriffe / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_06_Persistenz-SQL-und-sichere-Datenzugriffe.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Secure OrderDesk speichert Kunden, Produkte, Bestellungen und Bestellpositionen in einer relationalen
Datenbank im Northwind-Layout (inkl. `ALFKI`). Damit die Plattform später die Speicherform wechseln kann,
planst du eine **austauschbare Datenzugriffsschicht** (Repository- oder Store-Abstraktion): Die Kernlogik
spricht mit einem einfachen Datenvertrag, egal ob dahinter SQLite, PostgreSQL oder eine andere relationale
Ablage steckt. Der wichtigste Sicherheitspunkt dieser Einheit ist **SQL-Sicherheit**: **Jeder Datenbankzugriff
erfolgt über parametrisierte Statements** (Platzhalter, gebundene Parameter). **Dynamisches SQL, das Eingaben
per String-Verkettung zusammenbaut, ist verboten** – genau daraus entsteht **SQL-Injection** (CWE-89), einer
der gefährlichsten Angriffe auf Datenbanken.

**EN:** Secure OrderDesk stores customers, products, orders, and order lines in a relational database in
Northwind layout (incl. `ALFKI`). So the platform can later switch storage form, you plan an **exchangeable
data access layer** (repository or store abstraction): the core logic talks to a simple data contract, no
matter whether SQLite, PostgreSQL, or another relational store sits behind it. The most important security
point of this unit is **SQL security**: **every database access uses parameterized statements** (placeholders,
bound parameters). **Dynamic SQL that assembles input via string concatenation is forbidden** – that is exactly
what causes **SQL injection** (CWE-89), one of the most dangerous attacks on databases.

**DE:** In dieser Einheit legst du eine einfache, sichere Persistenzform fest und definierst einen Katalog
parametrisierter Abfragen für typische Fälle: „Bestellungen eines Kunden", „Produkte einer Kategorie", „Umsatz
je Zeitraum". Du sorgst dafür, dass auch dynamische Teile wie Sortierspalte oder Filterfeld nur über eine
geprüfte Allowlist gebildet werden, dass Kunden- und Bestelleingaben als nicht vertrauenswürdig gelten und dass
Datenbankfehler keine internen Details (SQL-Text, Tabellennamen) an Endnutzer verraten. `ALFKI` dient als
fester, fiktiver Testanker.

**EN:** In this unit you set a simple, safe persistence form and define a catalog of parameterized queries for
typical cases: "orders of a customer", "products of a category", "revenue per period". You ensure that even
dynamic parts such as sort column or filter field are built only via a checked allowlist, that customer and
order input is treated as untrusted, and that database errors reveal no internal details (SQL text, table
names) to end users. `ALFKI` serves as a fixed, fictional test anchor.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Persistenz / Persistence | Dauerhaftes Speichern von Daten, hier in einer relationalen Datenbank. |
| Datenzugriffsschicht / Data access layer | Austauschbares Backend hinter einem festen Datenvertrag (Repository/Store). |
| Parametrisierte Query / Parameterized query | Abfrage mit Platzhaltern; Werte werden gebunden, nicht in den SQL-Text geklebt. |
| Dynamisches SQL / Dynamic SQL | SQL-Text, der aus Eingaben zusammengesetzt wird – gefährlich, hier verboten. |
| SQL-Injection | Angriff, der über Eingaben fremdes SQL einschleust; verändert oder liest Daten. |
| Allowlist / Allowlist | Feste Liste erlaubter Werte, z. B. gültige Sortierspalten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Datenzugriffs-Abstraktion und Persistenzform wählen.** Beschreibe einen einfachen Vertrag
zum Lesen und Schreiben (z. B. „speichere Bestellung", „lies Bestellungen eines Kunden") und entscheide dich
dahinter für SQLite, PostgreSQL oder eine sprachübliche relationale Ablage. Begründe die Wahl. Warum eine
Abstraktion? So kann die Plattform später die Speicherform wechseln, ohne die Kernlogik umzubauen, und Tests
bleiben stabil.

**EN:** **Step 1 – Choose data access abstraction and persistence form.** Describe a simple contract for
reading and writing (e.g. "store order", "read orders of a customer") and behind it decide on SQLite,
PostgreSQL, or a language-common relational store. Justify the choice. Why an abstraction? So the platform can
later switch storage form without rebuilding the core logic, and tests stay stable.

**DE:** **Schritt 2 – Immer parametrisiert zugreifen.** Jede Abfrage nutzt Platzhalter und bindet die Werte:
`SELECT * FROM Orders WHERE CustomerID = ?` statt `... WHERE CustomerID = '" + eingabe + "'`. Warum? Beim
Zusammenkleben von SQL kann eine Eingabe wie `ALFKI' OR '1'='1` die Abfrage verändern und alle Bestellungen
oder Kunden auslesen. Bei parametrisierten Abfragen bleibt die Eingabe **immer nur ein Wert**, niemals Teil des
SQL-Befehls.

**EN:** **Step 2 – Always access parameterized.** Every query uses placeholders and binds the values: `SELECT *
FROM Orders WHERE CustomerID = ?` instead of `... WHERE CustomerID = '" + input + "'`. Why? When gluing SQL
together, an input like `ALFKI' OR '1'='1` can change the query and read all orders or customers. With
parameterized queries the input stays **always only a value**, never part of the SQL command.

**DE:** **Schritt 3 – Dynamische Teile nur über eine Allowlist.** Manchmal muss die Abfrage flexibel sein, z.
B. Sortierspalte oder Filterfeld aus der Oberfläche. Spaltennamen kann man **nicht** als Parameter binden.
Deshalb prüfst du sie gegen eine **feste Allowlist** erlaubter Feldnamen (z. B. `{"OrderDate", "Freight"}`) und
verwirfst alles andere. Warum? Ein Feldname aus einer Eingabe direkt in den SQL-Text zu setzen wäre wieder
dynamisches SQL und damit angreifbar.

**EN:** **Step 3 – Dynamic parts only via an allowlist.** Sometimes the query must be flexible, e.g. sort
column or filter field from the UI. Column names **cannot** be bound as a parameter. Therefore you check them
against a **fixed allowlist** of allowed field names (e.g. `{"OrderDate", "Freight"}`) and reject everything
else. Why? Putting a field name from input directly into the SQL text would again be dynamic SQL and thus
attackable.

**DE:** **Schritt 4 – Eingaben validieren und Fehler kapseln.** Behandle Kunden- und Bestelleingaben als nicht
vertrauenswürdig und prüfe sie vor dem Zugriff (z. B. gültige `CustomerID`, plausible Menge). Fängt ein
Datenbankfehler auf, gib dem Endnutzer eine klare, allgemeine Meldung – niemals SQL-Text, Tabellennamen oder
Stack-Traces. Warum? Interne Details helfen Angreifern und können personenbezogene Kundendaten oder die
Datenbankstruktur verraten. Zusätzlich exportierst du bei Kundenabfragen nur die wirklich benötigten Felder
(Datenminimierung).

**EN:** **Step 4 – Validate input and encapsulate errors.** Treat customer and order input as untrusted and
check it before access (e.g. valid `CustomerID`, plausible quantity). If a database error occurs, give the end
user a clear, general message – never SQL text, table names, or stack traces. Why? Internal details help
attackers and can reveal personal customer data or the database structure. In addition, for customer queries
you select only the truly needed fields (data minimization).

**DE:** **Typische Fehler.** SQL aus Eingaben zusammenkleben. Glauben, Escaping von Anführungszeichen reiche
statt echter Parametrisierung. Spaltennamen aus Eingaben ohne Allowlist einsetzen. Rohe SQL-Fehler an den
Nutzer geben. Alle Kundenfelder ausgeben, auch unnötige. `ORDER BY` oder `LIKE`-Filter aus ungeprüften
Eingaben bauen.

**EN:** **Common mistakes.** Gluing SQL from input. Believing that escaping quotes is enough instead of real
parameterization. Inserting column names from input without an allowlist. Passing raw SQL errors to the user.
Returning all customer fields, even unnecessary ones. Building `ORDER BY` or `LIKE` filters from unchecked
input.

### Beispiel / Example

```text
SICHER (parametrisiert):
  SELECT OrderID, OrderDate, Freight FROM Orders WHERE CustomerID = ?     -- Parameter: "ALFKI"
UNSICHER (NICHT so - String-Verkettung):
  "SELECT * FROM Orders WHERE CustomerID = '" + eingabe + "'"
Angriffseingabe:   ALFKI' OR '1'='1     -> bei Verkettung: liest ALLE Bestellungen. Bei ? : bleibt ein Wert.
Dynamische Sortierung:
  eingabe_spalte = "OrderDate; DROP TABLE Orders"  -> NICHT in SQL kleben
  Allowlist = {"OrderDate", "Freight"}  -> Wert nicht enthalten -> ABGELEHNT, Default "OrderDate"
Fehlermeldung:     "Abfrage fehlgeschlagen."   (kein SQL-Text, kein Tabellenname, kein Stack-Trace)
Datenminimierung:  Kundenabfrage liefert nur CustomerID, CompanyName, City -> nicht die ganze Zeile.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Basis"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Relationale Persistenz und parametrisierte Datenzugriffe sind Kern der Datenverwaltung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | SQL-Injection-Abwehr und Fehlerkapselung schützen die Kunden- und Bestelldaten an der Datenbankgrenze. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung (SQL-Sicherheit), Datenschutz sowie
Supply-Chain-Bezug bei Datenbanktreibern und ORM. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit),
`CL_05` (Abhängigkeiten/Bibliotheken), `CL_08` (Sicherheits-Code-Review) und `CL_11`
(Datenschutz/Datenqualität). Die Sicherheitsentscheidung dieser Einheit lautet: *Jeder Datenbankzugriff ist
parametrisiert, dynamische Teile laufen nur über eine Allowlist, und Datenbankfehler geben keine internen
Details preis.* A11Y-Aspekt: Fehlermeldungen und Abfrageergebnisse bleiben klarer Text ohne interne Details und
ohne reine Farbsignale, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding (SQL security), privacy, and supply-chain
relevance of database drivers and ORMs. Matching checklists: `CL_01` (standards applicability), `CL_05`
(dependencies/libraries), `CL_08` (security code review), and `CL_11` (privacy/data quality). The security
decision of this unit is: *every database access is parameterized, dynamic parts run only via an allowlist, and
database errors reveal no internal details.* Accessibility aspect: error messages and query results stay clear
text without internal details and without color-only signals, so they remain usable with a screen reader and
Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist String-konkateniertes SQL gefährlich? /
   **EN:** Why is string-concatenated SQL dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Eingabe kann Teil des SQL-Befehls werden. Mit `ALFKI' OR '1'='1` ließen sich alle Datensätze
   auslesen oder verändern (SQL-Injection). Der Befehl tut dann etwas anderes als geplant.
   **EN:** Input can become part of the SQL command. With `ALFKI' OR '1'='1` all records could be read or
   changed (SQL injection). The command then does something other than intended.

   </details>

2. **DE:** Warum schützt eine parametrisierte Abfrage besser als das Escapen von Anführungszeichen? /
   **EN:** Why does a parameterized query protect better than escaping quotes?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei parametrisierten Abfragen bleibt die Eingabe immer ein reiner Wert und wird nie als SQL
   interpretiert. Escaping ist fehleranfällig und lässt sich durch Sonderfälle umgehen.
   **EN:** With parameterized queries the input always stays a pure value and is never interpreted as SQL.
   Escaping is error-prone and can be bypassed through special cases.

   </details>

3. **DE:** (AE) Wie behandelt man eine dynamische Sortierspalte sicher? /
   **EN:** (AE) How do you safely handle a dynamic sort column?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Spaltennamen kann man nicht als Parameter binden. Man prüft die Eingabe gegen eine feste Allowlist
   erlaubter Spalten und verwirft oder ersetzt alles andere durch einen sicheren Default.
   **EN:** Column names cannot be bound as a parameter. You check the input against a fixed allowlist of allowed
   columns and reject or replace anything else with a safe default.

   </details>

4. **DE:** Warum ist eine austauschbare Datenzugriffsschicht hinter einem festen Vertrag sinnvoll? /
   **EN:** Why is an exchangeable data access layer behind a fixed contract useful?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Plattform kann die Speicherform (SQLite, PostgreSQL, …) wechseln, ohne die Kernlogik umzubauen.
   Der feste Vertrag hält Abfragen, Tests und die Sicherheitsregeln stabil.
   **EN:** The platform can switch storage form (SQLite, PostgreSQL, …) without rebuilding the core logic. The
   fixed contract keeps queries, tests, and the security rules stable.

   </details>

5. **DE:** (DPA) Wie bleibt eine Kundenabfrage datensparsam? /
   **EN:** (DPA) How does a customer query stay data-minimal?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es werden nur die benötigten Spalten selektiert (z. B. `CustomerID`, `CompanyName`, `City`), nicht
   die ganze Zeile mit Kontaktname, Telefon und Anschrift. So verlassen nur nötige Kundendaten die Datenbank.
   **EN:** Only the needed columns are selected (e.g. `CustomerID`, `CompanyName`, `City`), not the whole row
   with contact name, phone, and address. This way only necessary customer data leaves the database.

   </details>

6. **DE:** (SI) Warum darf ein Datenbankfehler nicht roh an den Endnutzer gehen? /
   **EN:** (SI) Why must a database error not go raw to the end user?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** SQL-Text, Tabellennamen oder Stack-Traces verraten die interne Struktur und helfen Angreifern beim
   Vorbereiten von Injektionen. Der Nutzer bekommt eine allgemeine Meldung, die Details bleiben im internen Log.
   **EN:** SQL text, table names, or stack traces reveal the internal structure and help attackers prepare
   injections. The user gets a general message; the details stay in the internal log.

   </details>

7. **DE:** Wie prüft man mit `ALFKI` testbar, dass eine Abfrage injection-sicher ist? /
   **EN:** How do you use `ALFKI` to testably prove a query is injection-safe?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man nutzt einen positiven Test (Abfrage mit `ALFKI` liefert dessen Bestellungen) und einen negativen
   Test (Eingabe `ALFKI' OR '1'='1` liefert keine fremden Datensätze, sondern behandelt den Text als reinen
   Wert). Beide zusammen belegen die Parametrisierung.
   **EN:** You use a positive test (query with `ALFKI` returns its orders) and a negative test (input `ALFKI' OR
   '1'='1` returns no foreign records but treats the text as a pure value). Together they evidence
   parameterization.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: ein verteiltes
   Datenbank-Cluster ist `N/A`, weil im 1. Lehrjahr eine einfache lokale Ablage genügt; die parametrisierten
   Tests gelten als Nachweis.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: a distributed
   database cluster is `N/A` because a simple local store suffices in year 1; the parameterized tests serve as
   evidence.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Datenzugriffs-Abstraktion und eine relationale Persistenzform wählen und begründen.
- [ ] jeden Datenbankzugriff parametrisiert formulieren und kein dynamisches SQL aus Eingaben bauen.
- [ ] dynamische Teile (Sortierung, Filter) über eine Allowlist absichern.
- [ ] SQL-Injection an einem Beispiel erklären und eine Gegenmaßnahme nennen.
- [ ] Kunden- und Bestelleingaben vor dem Zugriff validieren und Datenbankfehler kapseln.
- [ ] eine Kundenabfrage datensparsam gestalten und `ALFKI` als Testanker nutzen.

**EN:** I can …

- [ ] choose and justify a data access abstraction and a relational persistence form.
- [ ] formulate every database access parameterized and build no dynamic SQL from input.
- [ ] secure dynamic parts (sorting, filter) via an allowlist.
- [ ] explain SQL injection with an example and name a countermeasure.
- [ ] validate customer and order input before access and encapsulate database errors.
- [ ] design a customer query data-minimal and use `ALFKI` as a test anchor.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_06_Persistenz-SQL-und-sichere-Datenzugriffe.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_06_Persistenz-SQL-und-sichere-Datenzugriffe.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
