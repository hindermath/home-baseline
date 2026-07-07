# Lernbegleiter: Secure OrderDesk 03 – Eingabevalidierung und Trust Boundaries / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_03_Eingabevalidierung-und-Trust-Boundaries.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure OrderDesk bekommt Daten von außen: Kundinnen und Kunden geben Bestellungen ein, eine Datei
mit Northwind-Daten wird importiert, später ruft vielleicht eine Schnittstelle oder ein CLI-Befehl die
Plattform auf. Alles, was von außen kommt, ist zunächst **nicht vertrauenswürdig** – auch importierte
Bestelldaten. Die Stelle, an der nicht vertrauenswürdige Daten in einen geschützteren Bereich übergehen, heißt
**Vertrauensgrenze** (Trust Boundary). Eine besonders wichtige Vertrauensgrenze ist der **Datenbankzugriff**:
Wer Eingaben ungeprüft in eine SQL-Abfrage einbaut, öffnet die Tür für **SQL-Injection**. Genau dort muss
geprüft und mit **parametrisierten Queries** gearbeitet werden.

**EN:** The Secure OrderDesk receives data from outside: customers enter orders, a file with Northwind data is
imported, and later an interface or a CLI command may call the platform. Everything that comes from outside is
initially **not trustworthy** – including imported order data. The place where untrusted data crosses into a
more protected area is called a **trust boundary**. A particularly important trust boundary is **database
access**: whoever builds input unchecked into an SQL query opens the door to **SQL injection**. That is exactly
where checks must happen and **parameterized queries** must be used.

**DE:** In dieser Einheit lernst du, alle Eingänge des Secure OrderDesk zu benennen, für jeden Eingang klare
Validierungsregeln zu planen (z. B. für `CompanyName`, `OrderDate`, `Quantity`, `Discount`, `ProductID` und
Dateipfade), jeden Datenbankzugriff zu parametrisieren und Fehlermeldungen so zu gestalten, dass sie
verständlich sind, aber keine internen Details oder SQL-Fragmente verraten.

**EN:** In this unit you learn to name all inputs of the Secure OrderDesk, to plan clear validation rules for
each input (e.g. for `CompanyName`, `OrderDate`, `Quantity`, `Discount`, `ProductID`, and file paths), to
parameterize every database access, and to design error messages that are understandable but do not reveal
internal details or SQL fragments.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Vertrauensgrenze / Trust boundary | Grenze zwischen nicht vertrauenswürdigen und geprüften Daten. |
| Validierung / Validation | Prüfung, ob eine Eingabe erlaubt, sinnvoll und sicher ist. |
| Allowlist / Allow-list | Liste erlaubter Werte; alles andere wird abgelehnt. |
| SQL-Injection / SQL injection | Angriff, bei dem manipulierte Eingaben eine SQL-Abfrage verändern. |
| Parametrisierte Query / Parameterized query | SQL mit Platzhaltern; Werte werden getrennt übergeben, nicht in den Text eingebaut. |
| Kanonisierung / Canonicalization | Pfad oder Wert auf eine eindeutige Normalform bringen, bevor man ihn prüft. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Eingänge finden.** Liste jeden Weg auf, über den Daten in die Plattform kommen:
Eingabefelder für Kunden- und Bestelldaten (`CompanyName`, `ContactName`, `OrderDate`, `Quantity`, `Discount`),
Dateiimport (z. B. CSV im Northwind-Layout), den Datenbankzugriff selbst und spätere API- oder CLI-Parameter.
Jeder Eingang ist eine Vertrauensgrenze. Was du nicht benennst, kannst du nicht schützen.

**EN:** **Step 1 – Find the inputs.** List every path through which data enters the platform: entry fields for
customer and order data (`CompanyName`, `ContactName`, `OrderDate`, `Quantity`, `Discount`), file import (e.g.
CSV in Northwind layout), the database access itself, and later API or CLI parameters. Each input is a trust
boundary. What you do not name, you cannot protect.

**DE:** **Schritt 2 – Regeln je Eingang festlegen.** Prüfe lieber gegen eine **Allowlist** oder einen klaren
Wertebereich als gegen eine Verbotsliste. Beispiele: `CompanyName`/`ContactName` haben eine Höchstlänge und
erlaubte Zeichen. `Country`/`City` prüfst du gegen eine Liste oder auf Plausibilität. `OrderDate` muss ein
gültiges, plausibles Datum sein (nicht in der Zukunft). `Quantity` ist eine positive Ganzzahl. `Discount` liegt
zwischen 0 und 1. `ProductID`/`CustomerID` müssen existieren (referenzielle Integrität). Ein Dateipfad wird
**kanonisiert** und darf nur in ein erlaubtes Verzeichnis zeigen.

**EN:** **Step 2 – Define rules per input.** Prefer an **allow-list** or a clear value range over a deny-list.
Examples: `CompanyName`/`ContactName` have a maximum length and allowed characters. `Country`/`City` are
checked against a list or for plausibility. `OrderDate` must be a valid, plausible date (not in the future).
`Quantity` is a positive integer. `Discount` is between 0 and 1. `ProductID`/`CustomerID` must exist
(referential integrity). A file path is **canonicalized** and may only point into an allowed directory.

**DE:** **Schritt 3 – Datenbankzugriffe parametrisieren.** Baue niemals Eingaben direkt in einen SQL-Text ein
(z. B. `"... WHERE CustomerID = '" + eingabe + "'"`). Nutze **parametrisierte Queries** mit Platzhaltern; die
Datenbank behandelt den Wert dann als Daten, nicht als Befehl. So verhinderst du SQL-Injection. Die Prüfung
gehört in die Datenzugriffsschicht, nicht nur in die Oberfläche – ein Import oder eine API kann die Oberfläche
umgehen.

**EN:** **Step 3 – Parameterize database access.** Never build input directly into an SQL text (e.g.
`"... WHERE CustomerID = '" + input + "'"`). Use **parameterized queries** with placeholders; the database then
treats the value as data, not as a command. This prevents SQL injection. The check belongs in the data-access
layer, not only in the UI – an import or an API can bypass the UI.

**DE:** **Schritt 4 – Sichere Fehlermeldungen.** Eine gute Fehlermeldung sagt, *was* falsch war, aber nicht
*wie das System innen aussieht*. Kein Stack-Trace, kein interner Pfad, keine SQL-Fehlermeldung, keine
Verbindungszeichenkette. Wiederhole außerdem keine Kundendaten unnötig. Begrenze Freitext (z. B. `ContactName`),
damit niemand über eine Eingabe das Protokoll fälschen kann (Log-Injection).

**EN:** **Step 4 – Safe error messages.** A good error message says *what* was wrong, but not *what the system
looks like inside*. No stack trace, no internal path, no SQL error message, no connection string. Also do not
repeat customer data unnecessarily. Limit free text (e.g. `ContactName`) so that no one can forge the log
through an input (log injection).

**DE:** **Typische Fehler.** Importierte Northwind-Daten als vertrauenswürdig behandeln, nur weil sie „aus
unserer Datei" kommen. Eingaben direkt in SQL einbauen (SQL-Injection). Nur Erfolgspfade testen. Nur in einer
Oberfläche prüfen. Dateipfade ohne Kanonisierung akzeptieren (`../` erlaubt dann den Ausbruch aus dem
Zielordner). Fehlermeldungen mit SQL-Fragmenten oder internen Details. Freitext ohne Längengrenze.

**EN:** **Common mistakes.** Treating imported Northwind data as trustworthy just because it comes "from our
file". Building input directly into SQL (SQL injection). Testing only success paths. Checking only in a UI.
Accepting file paths without canonicalization (`../` then allows escaping the target folder). Error messages
with SQL fragments or internal details. Free text without a length limit.

### Beispiel / Example

```text
Eingabe (CustomerID): "ALFKI' OR '1'='1"
Unsicher (NICHT so!): "SELECT * FROM Customers WHERE CustomerID = '" + eingabe + "'"
Sicher:               "SELECT * FROM Customers WHERE CustomerID = ?"  -> Wert als Parameter uebergeben
Ergebnis (sicher):    Wert wird als Daten behandelt, Injection wirkungslos -> ABGELEHNT/leer

Eingabe (Quantity):   "-5"
Regel:                positive Ganzzahl > 0
Ergebnis:             ABGELEHNT
Sichere Meldung:      "Ungueltige Menge. Erlaubt: ganze Zahl groesser 0."
Unsichere Meldung:    "DB error near '-5': constraint failed at /app/db/orders.sql:88"  (NICHT so!)

Eingabe (OrderDate):  "2999-01-01"
Regel:                Format pruefen und Plausibilitaet: Datum darf nicht in der Zukunft liegen
Ergebnis:             ABGELEHNT (unplausibel)

Eingabe (Dateipfad):  "../../etc/passwd"
Regel:                Pfad kanonisieren, dann pruefen: liegt er im erlaubten Import-Ordner?
Ergebnis:             ABGELEHNT (zeigt aus dem erlaubten Verzeichnis heraus)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Basis"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Secure OrderDesk Base"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Vertrauensgrenzen, Eingabeprüfung und Abwehr von SQL-Injection sind die praktische Umsetzung einer Schutzbedarfsanalyse. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Validierung und parametrisierte Zugriffe schützen die Datenverwaltung vor fehlerhaften und schädlichen Daten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Secure Coding, Trust Boundaries, parametrisierte SQL-Zugriffe
und sichere Fehlerbehandlung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Bedrohungsmodellierung) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser Einheit
lautet: *Alle eingegebenen und importierten Daten gelten als nicht vertrauenswürdig, jeder Datenbankzugriff ist
parametrisiert, und geprüft wird an jeder Vertrauensgrenze, bevor Daten verarbeitet werden.* A11Y-Aspekt:
Fehlermeldungen müssen klar, textbasiert und ohne reine Farbsignale verständlich sein, damit sie auch mit
Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, trust boundaries, parameterized SQL access,
and safe error handling. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat modeling), and
`CL_08` (security code review). The security decision of this unit is: *all entered and imported data is
treated as untrusted, every database access is parameterized, and checks happen at every trust boundary before
data is processed.* Accessibility aspect: error messages must be clear, text-based, and understandable without
color-only signals, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Vertrauensgrenze, und warum ist gerade sie der richtige Ort für Prüfungen? /
   **EN:** What is a trust boundary, and why is it the right place for checks?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Vertrauensgrenze ist der Übergang von nicht vertrauenswürdigen Daten in einen geschützten
   Bereich. Dort ist die Prüfung sinnvoll, weil danach die Daten als geprüft gelten und weiterverarbeitet
   werden. Prüft man erst später, sind die Daten schon in der Logik oder in der Datenbank.
   **EN:** A trust boundary is the crossing from untrusted data into a protected area. Checking there makes
   sense because afterwards the data counts as validated and is processed further. Checking later means the
   data is already inside the logic or the database.

   </details>

2. **DE:** Warum gelten auch importierte Northwind-Daten aus einer eigenen Datei als nicht vertrauenswürdig? /
   **EN:** Why is imported Northwind data from your own file also treated as untrusted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Auch eine eigene Datei kann fehlerhaft, veraltet oder manipuliert sein. Die Werte kommen von
   außerhalb der Kernlogik, können also falsch sein und müssen vor der Verarbeitung geprüft werden.
   **EN:** Even your own file can be faulty, outdated, or manipulated. The values come from outside the core
   logic, so they can be wrong and must be checked before processing.

   </details>

3. **DE:** Was ist SQL-Injection, und wie verhindern parametrisierte Queries sie? /
   **EN:** What is SQL injection, and how do parameterized queries prevent it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei SQL-Injection verändert eine manipulierte Eingabe die Abfrage, z. B. `' OR '1'='1`.
   Parametrisierte Queries übergeben den Wert getrennt über einen Platzhalter; die Datenbank behandelt ihn als
   Daten, nicht als Befehl, sodass die Injection wirkungslos bleibt.
   **EN:** In SQL injection a manipulated input changes the query, e.g. `' OR '1'='1`. Parameterized queries
   pass the value separately via a placeholder; the database treats it as data, not as a command, so the
   injection has no effect.

   </details>

4. **DE:** (AE) Warum reicht eine Prüfung nur an der Oberfläche nicht aus, sondern muss in der Datenzugriffsschicht liegen? /
   **EN:** (AE) Why is a check only at the UI not enough, and why must it be in the data-access layer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Oberfläche lässt sich umgehen, z. B. über Dateiimport oder API. Die verbindliche Regel und die
   Parametrisierung müssen dort liegen, wo die Daten wirklich in die Datenbank gehen.
   **EN:** The UI can be bypassed, e.g. via file import or API. The binding rule and the parameterization must
   live where the data really goes into the database.

   </details>

5. **DE:** (SI) Welche Angabe darf eine Fehlermeldung nicht enthalten, und warum? /
   **EN:** (SI) What must an error message not contain, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine internen Details wie Stack-Traces, Dateipfade, SQL-Fragmente, Verbindungszeichenketten oder
   unnötige Kundendaten. Solche Angaben helfen Angreifern und verletzen den Datenschutz.
   **EN:** No internal details such as stack traces, file paths, SQL fragments, connection strings, or
   unnecessary customer data. Such information helps attackers and violates privacy.

   </details>

6. **DE:** Warum muss ein Dateipfad vor der Prüfung kanonisiert werden? /
   **EN:** Why must a file path be canonicalized before it is checked?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Kanonisierung kann `../` aus dem erlaubten Verzeichnis herausführen. Erst die Normalform zeigt
   den echten Zielpfad, den man dann gegen den erlaubten Ordner prüfen kann.
   **EN:** Without canonicalization, `../` can lead out of the allowed directory. Only the normal form shows the
   real target path, which can then be checked against the allowed folder.

   </details>

7. **DE:** (DPA) Wie beeinflussen ungültige Bestell- oder Kundeneingaben spätere Auswertungen und den Datenschutz? /
   **EN:** (DPA) How do invalid order or customer inputs affect later evaluations and privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ungültige oder unplausible Daten (falsche Mengen, überhöhte Rabatte) verfälschen Umsatz- und
   Bestellauswertungen. Werden Kundendaten unnötig in Fehlermeldungen wiederholt, entsteht zusätzlich ein
   Datenschutzrisiko.
   **EN:** Invalid or implausible data (wrong quantities, excessive discounts) distorts revenue and order
   evaluations. If customer data is unnecessarily repeated in error messages, an additional privacy risk
   arises.

   </details>

8. **DE:** (SI) An welcher Systemgrenze wechseln eingegebene oder importierte Daten von „nicht vertrauenswürdig" zu „geprüft", und warum sollte man das früh benennen? /
   **EN:** (SI) At which system boundary do entered or imported data change from "untrusted" to "validated", and why name it early?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Am Eingang der Plattform und spätestens vor dem Datenbankzugriff, wo die Eingaben angenommen und
   validiert werden. Wer diese Grenze früh benennt, kann Validierung, parametrisierte Zugriffe und
   Fehlerbehandlung gezielt und einheitlich planen.
   **EN:** At the platform's entry point and at the latest before database access, where inputs are accepted and
   validated. Naming this boundary early allows planning validation, parameterized access, and error handling
   in a targeted and consistent way.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] alle Eingänge der Plattform benennen und je Eingang eine Vertrauensgrenze zeigen, einschließlich der Datenbank-Grenze.
- [ ] eingegebene und importierte Northwind-Daten als nicht vertrauenswürdig behandeln.
- [ ] für jede Eingabeart mindestens eine Validierungsregel formulieren.
- [ ] jeden Datenbankzugriff parametrisieren und SQL-Injection erklären.
- [ ] eine sichere von einer unsicheren Fehlermeldung unterscheiden.
- [ ] je kritischer Eingabeart einen Negativtest angeben, darunter ein SQL-Injection-Muster.

**EN:** I can …

- [ ] name all inputs of the platform and show a trust boundary for each, including the database boundary.
- [ ] treat entered and imported Northwind data as untrusted.
- [ ] state at least one validation rule per input type.
- [ ] parameterize every database access and explain SQL injection.
- [ ] tell a safe error message from an unsafe one.
- [ ] give a negative test for each critical input type, including an SQL injection pattern.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_03_Eingabevalidierung-und-Trust-Boundaries.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_03_Eingabevalidierung-und-Trust-Boundaries.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
