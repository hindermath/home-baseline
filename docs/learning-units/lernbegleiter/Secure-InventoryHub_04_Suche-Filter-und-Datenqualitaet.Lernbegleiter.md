# Lernbegleiter: Secure InventoryHub 04 – Suche, Filter und Datenqualität / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_04_Suche-Filter-und-Datenqualitaet.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Inventar wird erst nützlich, wenn man gezielt darin suchen und filtern kann: „Zeige alle Laptops
mit veralteter Software in Halle A." Suche und Filter klingen einfach, sind aber eine **Vertrauensgrenze**:
Suchbegriffe kommen von außen und dürfen nicht ungeprüft in eine Datenbankabfrage fließen, sonst droht
Injection. Gleichzeitig hängt das Ergebnis von der **Datenqualität** ab: Wenn Felder leer, uneinheitlich oder
falsch sind, findet die Suche das Falsche oder gar nichts. Und jedes Ergebnis hat **Aussagegrenzen** – es
zeigt nur, was im Inventar erfasst ist.

**EN:** An inventory only becomes useful when you can search and filter it purposefully: "Show all laptops
with outdated software in hall A." Search and filter sound simple but are a **trust boundary**: search terms
come from outside and must not flow unchecked into a database query, otherwise injection threatens. At the same
time the result depends on **data quality**: if fields are empty, inconsistent, or wrong, the search finds the
wrong thing or nothing. And every result has **statement limits** – it only shows what is recorded in the
inventory.

**DE:** In dieser Einheit lernst du, Such- und Filterfelder klar zu definieren, Eingaben sicher zu behandeln,
Datenqualitätsgrenzen zu benennen und Fehlerfälle sauber zu behandeln.

**EN:** In this unit you learn to define search and filter fields clearly, handle inputs safely, name data
quality limits, and handle error cases cleanly.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Suchvertrag / Search contract | Klare Festlegung, welche Felder wie durchsucht werden. |
| Filter / Filter | Einschränkung der Ergebnismenge nach festgelegten Kriterien. |
| Parametrisierte Abfrage / Parameterized query | Abfrage, die Eingaben als Daten, nicht als Code behandelt. |
| Injection / Injection | Angriff, der über Eingaben fremden Code in eine Abfrage einschleust. |
| Datenqualität / Data quality | Grad, in dem Daten vollständig, korrekt und einheitlich sind. |
| Aussagegrenze / Statement limit | Ehrliche Grenze dessen, was ein Ergebnis wirklich belegt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Suchvertrag festlegen.** Bestimme, welche Felder durchsuchbar und filterbar sind, z. B.
Assettyp, Standort, Softwarename, Version, Status. Lege fest, wie sortiert wird. Ein klarer Suchvertrag
verhindert, dass die Suche „irgendwie" arbeitet und unerwartete Felder preisgibt.

**EN:** **Step 1 – Define the search contract.** Determine which fields are searchable and filterable, e.g.
asset type, location, software name, version, status. Define how results are sorted. A clear search contract
prevents the search from working "somehow" and exposing unexpected fields.

**DE:** **Schritt 2 – Eingaben sicher behandeln.** Suchbegriffe sind nicht vertrauenswürdig. Nutze
**parametrisierte Abfragen**, damit eine Eingabe niemals als Code ausgeführt wird. Prüfe Filterwerte gegen
eine Allowlist (z. B. nur erlaubte Statuswerte). So verhinderst du Injection und unsinnige Filter.

**EN:** **Step 2 – Handle inputs safely.** Search terms are untrusted. Use **parameterized queries** so that
an input is never executed as code. Check filter values against an allow-list (e.g. only allowed status
values). This prevents injection and nonsensical filters.

**DE:** **Schritt 3 – Datenqualitätsgrenzen benennen.** Suche liefert nur, was gut erfasst ist. Wenn
Standorte mal „Halle A", mal „HalleA", mal leer sind, findet der Filter nicht alles. Benenne solche Grenzen
ausdrücklich und definiere Regeln, z. B. einheitliche Schreibweise oder Pflichtfelder. Ehrliche Grenzen sind
besser als ein falscher Eindruck von Vollständigkeit.

**EN:** **Step 3 – Name data quality limits.** Search returns only what is well recorded. If locations are
sometimes "hall A", sometimes "hallA", sometimes empty, the filter does not find everything. Name such limits
explicitly and define rules, e.g. uniform spelling or mandatory fields. Honest limits are better than a false
impression of completeness.

**DE:** **Schritt 4 – Fehlerfälle sauber behandeln.** Was passiert bei leerer Suche, ungültigem Filter oder
zu vielen Treffern? Definiere klares Verhalten: verständliche Meldung, keine internen Details, sinnvolle
Begrenzung der Trefferzahl (Paginierung). Eine gute Fehlermeldung sagt, *was* zu tun ist, ohne die
Systemstruktur zu verraten.

**EN:** **Step 4 – Handle error cases cleanly.** What happens with an empty search, an invalid filter, or too
many hits? Define clear behavior: an understandable message, no internal details, a sensible limit on the
number of hits (pagination). A good error message says *what* to do without revealing the system structure.

**DE:** **Typische Fehler.** Suchbegriffe direkt in eine Abfrage einsetzen (Injection). Filter ohne Allowlist.
Datenqualitätsgrenzen verschweigen. Fehlermeldungen mit internen Details. Ergebnisse als vollständig
darstellen, obwohl Felder fehlen.

**EN:** **Common mistakes.** Inserting search terms directly into a query (injection). Filters without an
allow-list. Hiding data quality limits. Error messages with internal details. Presenting results as complete
although fields are missing.

### Beispiel / Example

```text
Filter:            typ = "Laptop", standort = "Halle-A", software_veraltet = true
Suchbegriff:       name enthält "OpenSSL"

Unsicher:          "SELECT * FROM sw WHERE name LIKE '%" + eingabe + "%'"   (Injection möglich!)
Sicher:            "SELECT ... WHERE name LIKE ?"  mit Parameter = "%OpenSSL%"  (parametrisiert)

Filter-Allowlist:  standort IN { Halle-A, Halle-B, RZ-1 }  -> "xyz" wird ABGELEHNT
Datenqualität:     23 Assets ohne standort -> Ergebnis unvollständig -> als Aussagegrenze ausweisen
Fehlerfall:        leere Suche -> Meldung: "Bitte mindestens ein Filterkriterium angeben."
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Suche und Filter sind Kernfunktionen der Datenverwaltung. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Suchergebnisse beantworten konkrete Serviceanfragen der Nutzer. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Eingabeverarbeitung, parametrisierte Abfragen und
Datenschutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (Zugangssteuerung), `CL_04`
(Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die
Sicherheitsentscheidung dieser Einheit lautet: *Suchbegriffe werden immer als Daten behandelt, nie als Code,
und Ergebnisse werden ehrlich mit Aussagegrenzen versehen.* A11Y-Aspekt: Suchergebnisse und Fehlermeldungen
müssen textbasiert und ohne reine Farbsignale verständlich sein, damit sie mit Screenreader oder Braille-Zeile
nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: safe input handling, parameterized queries, and privacy.
Matching checklists: `CL_01` (standards applicability), `CL_03` (access control), `CL_04` (threat modeling),
`CL_08` (security code review), and `CL_10` (privacy). The security decision of this unit is: *search terms are
always treated as data, never as code, and results are honestly annotated with statement limits.* Accessibility
aspect: search results and error messages must be text-based and understandable without color-only signals, so
they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine Suche eine Vertrauensgrenze? /
   **EN:** Why is a search a trust boundary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Suchbegriffe kommen von außen und sind nicht vertrauenswürdig. Ungeprüft in eine Abfrage
   übernommen, können sie Injection ermöglichen. Deshalb muss an dieser Grenze geprüft werden.
   **EN:** Search terms come from outside and are untrusted. Taken into a query unchecked, they can enable
   injection. Therefore checks must happen at this boundary.

   </details>

2. **DE:** Was leistet eine parametrisierte Abfrage? /
   **EN:** What does a parameterized query achieve?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie behandelt die Eingabe als reinen Datenwert, nicht als Teil des Abfragecodes. So kann eine
   Eingabe die Abfragestruktur nicht verändern, und Injection wird verhindert.
   **EN:** It treats the input as a pure data value, not as part of the query code. This way an input cannot
   change the query structure, and injection is prevented.

   </details>

3. **DE:** Warum sollten Filterwerte gegen eine Allowlist geprüft werden? /
   **EN:** Why should filter values be checked against an allow-list?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Allowlist lässt nur bekannte gültige Werte zu, z. B. erlaubte Statuswerte. Unbekannte oder
   schädliche Eingaben werden abgelehnt, was Fehler und Angriffe reduziert.
   **EN:** An allow-list permits only known valid values, e.g. allowed status values. Unknown or malicious
   inputs are rejected, which reduces errors and attacks.

   </details>

4. **DE:** (DPA) Wie beeinflusst schlechte Datenqualität ein Suchergebnis? /
   **EN:** (DPA) How does poor data quality affect a search result?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Uneinheitliche oder leere Felder führen dazu, dass die Suche nicht alles findet. Das Ergebnis wirkt
   vollständig, ist es aber nicht. Solche Grenzen müssen ausgewiesen werden.
   **EN:** Inconsistent or empty fields cause the search to miss items. The result looks complete but is not.
   Such limits must be disclosed.

   </details>

5. **DE:** Warum sollte man die Trefferzahl begrenzen (Paginierung)? /
   **EN:** Why should the number of hits be limited (pagination)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sehr große Ergebnismengen belasten System und Nutzer und können ein Angriffsmittel sein.
   Paginierung hält die Antwort handhabbar und schützt die Verfügbarkeit.
   **EN:** Very large result sets strain the system and the user and can be an attack vector. Pagination keeps
   the response manageable and protects availability.

   </details>

6. **DE:** Warum darf eine Suchfehlermeldung keine internen Details enthalten? /
   **EN:** Why must a search error message contain no internal details?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Interne Details wie Abfragen, Tabellen oder Pfade helfen Angreifern. Die Meldung soll dem Nutzer
   sagen, was zu tun ist, ohne die Systemstruktur preiszugeben.
   **EN:** Internal details such as queries, tables, or paths help attackers. The message should tell the user
   what to do without revealing the system structure.

   </details>

7. **DE:** Warum ist es wichtig, Aussagegrenzen eines Suchergebnisses zu benennen? /
   **EN:** Why is it important to name the statement limits of a search result?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Ergebnis zeigt nur, was erfasst ist. Ohne Hinweis auf fehlende Daten entstehen falsche
   Schlüsse. Ehrliche Grenzen schützen vor Fehlentscheidungen.
   **EN:** A result shows only what is recorded. Without a note about missing data, wrong conclusions arise.
   Honest limits protect against wrong decisions.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] durchsuchbare und filterbare Felder als Suchvertrag festlegen.
- [ ] erklären, warum parametrisierte Abfragen Injection verhindern.
- [ ] Filterwerte gegen eine Allowlist prüfen.
- [ ] Datenqualitätsgrenzen eines Ergebnisses benennen.
- [ ] Fehlerfälle mit sicheren Meldungen behandeln.

**EN:** I can …

- [ ] define searchable and filterable fields as a search contract.
- [ ] explain why parameterized queries prevent injection.
- [ ] check filter values against an allow-list.
- [ ] name the data quality limits of a result.
- [ ] handle error cases with safe messages.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_04_Suche-Filter-und-Datenqualitaet.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_04_Suche-Filter-und-Datenqualitaet.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
