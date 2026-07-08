# Lernbegleiter: Secure OrderDesk Application Track 04 – Query-, Filter- und Paginierungslogik / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_04_Query-Filter-und-Paginierungslogik.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Handelsplattform hat viele Bestellungen – bei Secure Trader bis Juli 2026 mehrere Tausend. Niemand will alle auf einmal sehen. Deshalb brauchst du **Filter** (z. B. „Bestellungen von `ALFKI`"), **Sortierung** (z. B. nach `OrderDate`) und **Paginierung** (seitenweises Ausliefern). Diese drei Dinge sind bequem, aber auch riskant: Wenn Filter- oder Sortierfelder ungeprüft in SQL landen, entsteht SQL-Injection. Und wenn die Sortierung nicht eindeutig ist, springt die Reihenfolge zwischen Seiten. Sichere Abfragen brauchen deshalb **Feld-Whitelists**, **parametrisierte Zugriffe** und eine **deterministische Sortierung** mit eindeutigem Tiebreaker.

**EN:** A trading platform has many orders – at Secure Trader several thousand by July 2026. Nobody wants to see all at once. So you need **filters** (e.g. "orders of `ALFKI`"), **sorting** (e.g. by `OrderDate`), and **pagination** (delivering page by page). These three are convenient but also risky: if filter or sort fields reach SQL unchecked, SQL injection arises. And if sorting is not unique, the order jumps between pages. Safe queries therefore need **field whitelists**, **parameterized access**, and **deterministic ordering** with a unique tiebreaker.

**DE:** Du lernst, erlaubte Felder als Whitelist festzulegen, Werte immer parametrisiert zu übergeben, eine Paginierungsstrategie (Offset gegenüber Cursor) mit Trade-off zu begründen und robustes Verhalten bei ungültigen Parametern zu entwerfen.

**EN:** You learn to define allowed fields as a whitelist, always pass values parameterized, justify a pagination strategy (offset versus cursor) with a trade-off, and design robust behavior on invalid parameters.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Filter-Whitelist / Filter whitelist | Feste Liste erlaubter Filterfelder; alles andere wird abgelehnt. |
| Parametrisierte Abfrage / Parameterized query | Abfrage mit gebundenen Werten statt String-Verkettung. |
| Paginierung / Pagination | Aufteilung großer Ergebnismengen in Seiten. |
| Offset-Paginierung / Offset pagination | Seiten über „überspringe N, nimm M" (`OFFSET`/`LIMIT`). |
| Cursor-Paginierung / Cursor pagination | Seiten über einen Zeiger auf den letzten gesehenen Datensatz. |
| Deterministische Sortierung / Deterministic ordering | Eindeutige, stabile Reihenfolge, auch bei gleichen Werten. |
| Tiebreaker / Tiebreaker | Zusätzliches eindeutiges Sortierfeld (z. B. `OrderID`) bei Gleichstand. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Filterfelder als Whitelist.** Lege genau fest, nach welchen Feldern gefiltert werden darf, z. B. `CustomerID`, `OrderDate`, `CategoryID`. Ein Eingabefeldname, der nicht auf der Whitelist steht, wird abgelehnt – nie in SQL eingesetzt.

**EN:** **Step 1 – Filter fields as a whitelist.** Define exactly which fields may be filtered, e.g. `CustomerID`, `OrderDate`, `CategoryID`. An input field name not on the whitelist is rejected – never inserted into SQL.

**DE:** **Schritt 2 – Werte parametrisieren.** Filterwerte (z. B. `ALFKI`) werden als gebundene Parameter übergeben, nie per String-Verkettung. So kann kein Wert als SQL interpretiert werden. Auch Feldnamen werden nur über die geprüfte Whitelist eingesetzt, nicht direkt aus der Eingabe.

**EN:** **Step 2 – Parameterize values.** Filter values (e.g. `ALFKI`) are passed as bound parameters, never by string concatenation. This way no value can be interpreted as SQL. Field names too are set only via the checked whitelist, not directly from input.

**DE:** **Schritt 3 – Deterministisch sortieren.** Wähle ein Sortierfeld (z. B. `OrderDate`) und immer einen eindeutigen Tiebreaker (z. B. `OrderID`). Ohne Tiebreaker können zwei Bestellungen mit gleichem Datum ihre Reihenfolge zwischen Seiten tauschen – das verwirrt und macht Paginierung fehlerhaft.

**EN:** **Step 3 – Sort deterministically.** Choose a sort field (e.g. `OrderDate`) and always a unique tiebreaker (e.g. `OrderID`). Without a tiebreaker, two orders with the same date can swap their order between pages – this confuses and makes pagination faulty.

**DE:** **Schritt 4 – Paginierung mit Trade-off wählen.** Offset-Paginierung ist einfach, wird aber bei großen Offsets langsam und kann bei gleichzeitigen Änderungen Datensätze doppelt oder gar nicht zeigen. Cursor-Paginierung ist stabiler und schneller, aber komplexer. Begründe die Wahl und setze eine Obergrenze für die Seitengröße.

**EN:** **Step 4 – Choose pagination with a trade-off.** Offset pagination is simple but slow for large offsets and can show records twice or not at all under concurrent changes. Cursor pagination is more stable and faster but more complex. Justify the choice and set an upper bound for page size.

**DE:** **Schritt 5 – Ungültige Parameter robust behandeln.** Was passiert bei `pageSize=-1`, einem unbekannten Sortierfeld oder einem Datum im falschen Format? Definiere klares Verhalten (z. B. 400 mit neutraler Meldung) und schreibe dafür Negativtests. Fehler geben keine internen Details preis.

**EN:** **Step 5 – Handle invalid parameters robustly.** What happens with `pageSize=-1`, an unknown sort field, or a wrongly formatted date? Define clear behavior (e.g. 400 with a neutral message) and write negative tests for it. Errors reveal no internal details.

**DE:** **Typische Fehler.** Feldnamen aus Eingaben direkt in SQL setzen. Werte per String-Verkettung einbauen. Ohne Tiebreaker sortieren. Keine Obergrenze für die Seitengröße. Nur Erfolgsfälle testen. Interne Fehlerdetails ausgeben.

**EN:** **Common mistakes.** Putting input field names directly into SQL. Building values by string concatenation. Sorting without a tiebreaker. No upper bound for page size. Testing only success cases. Emitting internal error details.

### Beispiel / Example

```text
Whitelist Filter:   CustomerID, OrderDate, CategoryID           (alles andere -> abgelehnt)
Whitelist Sort:     OrderDate, Freight                          (+ Tiebreaker OrderID)
Abfrage (sicher):   SELECT ... FROM Orders WHERE CustomerID = @cid
                    ORDER BY OrderDate DESC, OrderID DESC
                    LIMIT @size OFFSET @offset
Beispiel:           filter CustomerID=ALFKI, sort OrderDate desc, size=20 -> Seite 1 der ALFKI-Bestellungen

Paginierung:        Offset  -> einfach, aber langsam bei grossen Offsets
                    Cursor  -> stabil/schnell, aber komplexer   (Trade-off dokumentieren)
Obergrenze:         size max 100; size<=0 oder size>100 -> 400 (neutrale Meldung)
Negativtest:        sort=DROP -> abgelehnt (nicht auf Whitelist); pageSize=-1 -> 400
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"). Für die Abfragelogik ist **LF 11a** primär, weil sichere Abfragefunktionalität realisiert wird; LF 5 ist berührt, weil die Datenverwaltung der Bestelldomäne über Filter und Seiten gezielt angepasst wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"). For the query logic **LF 11a** is primary, because secure query functionality is realized; LF 5 is touched, because the data management of the ordering domain is specifically adapted through filters and pages.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Sichere Filter-, Sortier- und Paginierungslogik wird als Funktionalität realisiert. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Filter und Seiten passen den Zugriff auf die relationale Bestelldatenverwaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, Eingabevalidierung und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Filter- und Sortierfelder kommen nur aus einer Whitelist, Werte sind immer parametrisiert, und ungültige Parameter führen zu einer neutralen Fehlerantwort.* A11Y-Aspekt: Whitelist-, Sortier- und Testfall-Tabellen müssen als klarer Text lesbar sein, ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, input validation, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_03` (input validation), `CL_08` (security code review), and `CL_12` (evidence and closure). The security decision of this unit is: *filter and sort fields come only from a whitelist, values are always parameterized, and invalid parameters lead to a neutral error response.* Accessibility aspect: whitelist, sorting, and test-case tables must be readable as clear text, without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum brauchen Filter- und Sortierfelder eine Whitelist? /
   **EN:** Why do filter and sort fields need a whitelist?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Feldnamen können nicht immer als gebundene Parameter übergeben werden. Ohne Whitelist könnte ein Eingabefeldname direkt in SQL landen und Injection ermöglichen. Die Whitelist erlaubt nur bekannte, sichere Felder.
   **EN:** Field names cannot always be passed as bound parameters. Without a whitelist, an input field name could reach SQL directly and enable injection. The whitelist allows only known, safe fields.

   </details>

2. **DE:** (AE) Warum ist ein eindeutiger Tiebreaker bei der Sortierung wichtig? /
   **EN:** (AE) Why is a unique tiebreaker important for sorting?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei gleichen Sortierwerten (z. B. zwei Bestellungen am selben Tag) ist die Reihenfolge sonst zufällig und kann zwischen Seiten wechseln. Ein Tiebreaker wie `OrderID` macht die Reihenfolge deterministisch und die Paginierung stabil.
   **EN:** With equal sort values (e.g. two orders on the same day), the order is otherwise random and can change between pages. A tiebreaker like `OrderID` makes the order deterministic and pagination stable.

   </details>

3. **DE:** (AE) Wann wählst du Offset- und wann Cursor-Paginierung? /
   **EN:** (AE) When do you choose offset versus cursor pagination?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Offset ist einfach und für kleine Datenmengen gut. Bei großen Datenmengen oder häufigen Änderungen ist Cursor stabiler und schneller, aber komplexer. Die Wahl wird mit Trade-off begründet und dokumentiert.
   **EN:** Offset is simple and fine for small data sets. For large data sets or frequent changes, cursor is more stable and faster but more complex. The choice is justified with a trade-off and documented.

   </details>

4. **DE:** Warum braucht die Seitengröße eine Obergrenze? /
   **EN:** Why does page size need an upper bound?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Obergrenze könnte ein Aufruf mit `pageSize=1000000` die Datenbank und den Speicher überlasten (eine Art Denial of Service). Eine feste Obergrenze schützt Betrieb und Antwortzeiten.
   **EN:** Without an upper bound, a call with `pageSize=1000000` could overload the database and memory (a kind of denial of service). A fixed upper bound protects operation and response times.

   </details>

5. **DE:** (DPA) Welche Aussagegrenze hat ein gefiltertes Bestellergebnis? /
   **EN:** (DPA) What is the significance limit of a filtered order result?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es zeigt nur die Datensätze, die dem Filter entsprechen, nicht die Gesamtlage. Wer aus einer gefilterten Liste Schlüsse zieht, muss den Filter kennen; sonst wirkt ein Ausschnitt wie das Ganze. Zudem sind die Daten fiktiv (Northwind).
   **EN:** It shows only the records matching the filter, not the whole picture. Anyone drawing conclusions from a filtered list must know the filter; otherwise an excerpt looks like the whole. Also the data is fictional (Northwind).

   </details>

6. **DE:** (DV) Welche Schnittstellenparameter beschreiben Filter und Seiten? /
   **EN:** (DV) Which interface parameters describe filters and pages?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Typisch: Filterparameter (z. B. `customerId`, `orderDate`), Sortierparameter (`sort`, Richtung) und Paginierungsparameter (`pageSize`, `offset` oder `cursor`). Sie bilden zusammen den Abfragevertrag und müssen validiert werden.
   **EN:** Typically: filter parameters (e.g. `customerId`, `orderDate`), sort parameters (`sort`, direction), and pagination parameters (`pageSize`, `offset`, or `cursor`). Together they form the query contract and must be validated.

   </details>

7. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung. Beispiel: Volltextsuche-Ranking ist `N/A`, wenn die Einheit nur feldbasierte Filter betrachtet. Die Prüfung bleibt sichtbar dokumentiert.
   **EN:** As `N/A` with a short technical justification. Example: full-text search ranking is `N/A` if the unit only considers field-based filters. The check stays visibly documented.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] erlaubte Filter- und Sortierfelder als Whitelist festlegen.
- [ ] Werte immer parametrisiert übergeben und Feldnamen nur über die Whitelist einsetzen.
- [ ] deterministisch mit eindeutigem Tiebreaker sortieren.
- [ ] eine Paginierungsstrategie (Offset gegenüber Cursor) mit Trade-off begründen.
- [ ] robustes Verhalten und Negativtests für ungültige Parameter benennen.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] define allowed filter and sort fields as a whitelist.
- [ ] always pass values parameterized and set field names only via the whitelist.
- [ ] sort deterministically with a unique tiebreaker.
- [ ] justify a pagination strategy (offset versus cursor) with a trade-off.
- [ ] name robust behavior and negative tests for invalid parameters.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Application-Track_04_Query-Filter-und-Paginierungslogik.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Application-Track_04_Query-Filter-und-Paginierungslogik.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
