# Lernbegleiter: Secure ServiceHarvester Application Track 04 – Query-, Filter- und Paginierungslogik / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Sobald der ServiceHarvester viele Maschinen und Snapshots kennt, will niemand mehr die ganze Liste auf
einmal sehen. Man **filtert** (nur laufende Maschinen), **sortiert** (nach letztem Kontakt) und blättert in
**Seiten** (Pagination). Genau hier lauern zwei Gefahren: Erstens kann ungeprüfter Filter- oder Sortiereingang
zu Injection oder falschen Ergebnissen führen. Zweitens wird eine Liste ohne eindeutige Sortierung
**nicht-deterministisch** – dieselbe Seite zeigt bei zwei Aufrufen andere Einträge. Du entwirfst deshalb
sichere und deterministische Query-, Filter- und Paginierungsregeln.

**EN:** As soon as the ServiceHarvester knows many machines and snapshots, nobody wants to see the whole list
at once. You **filter** (only running machines), **sort** (by last contact), and page through it
(**pagination**). Exactly here two dangers lurk: first, unchecked filter or sort input can lead to injection
or wrong results. Second, a list without a unique ordering becomes **non-deterministic** – the same page shows
different entries across two calls. You therefore design secure and deterministic query, filter, and
pagination rules.

**DE:** Du lernst, Filterfelder als Whitelist zu erlauben, Abfragen zu parametrisieren, eine
Paginierungsstrategie (Offset oder Cursor) zu begründen, eine deterministische Sortierung mit eindeutigem
Tiebreaker zu sichern und Obergrenzen für Seitengrößen zu setzen.

**EN:** You learn to allow filter fields via a whitelist, parameterize queries, justify a pagination strategy
(offset or cursor), ensure deterministic ordering with a unique tiebreaker, and set upper bounds for page
sizes.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Query / Query | Eine Abfrage, die eine Teilmenge der Daten nach Regeln zurückgibt. |
| Filter / Filter | Bedingung, die Ergebnisse einschränkt, z. B. `status = running`. |
| Whitelist / Whitelist | Liste ausdrücklich erlaubter Werte; alles andere wird abgelehnt. |
| Paginierung / Pagination | Aufteilen großer Ergebnismengen in Seiten. |
| Offset / Offset | Paginierung über „überspringe N Einträge" – einfach, aber bei Änderungen wackelig. |
| Cursor / Cursor | Paginierung über einen Zeiger auf den letzten Eintrag – stabiler bei Änderungen. |
| Tiebreaker / Tiebreaker | Zweites, eindeutiges Sortierkriterium für deterministische Reihenfolge. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Filterfelder als Whitelist.** Lege ausdrücklich fest, nach welchen Feldern gefiltert und
sortiert werden darf (`status`, `os`, `last_contact`). Jeder andere Feldname wird abgelehnt. Eine Whitelist ist
sicherer als eine Blacklist, weil sie standardmäßig verweigert (Fail-Safe Default).

**EN:** **Step 1 – Filter fields as a whitelist.** Explicitly define which fields may be filtered and sorted by
(`status`, `os`, `last_contact`). Any other field name is rejected. A whitelist is safer than a blacklist
because it denies by default (fail-safe default).

**DE:** **Schritt 2 – Parametrisiert abfragen.** Setze niemals Werte oder Feldnamen per Zeichenkette in eine
Abfrage. Werte gehören als gebundene Parameter, Feldnamen werden gegen die Whitelist geprüft und nur dann
verwendet. So verhinderst du Injection.

**EN:** **Step 2 – Query parameterized.** Never insert values or field names into a query via string
concatenation. Values belong as bound parameters, field names are checked against the whitelist and only then
used. This prevents injection.

**DE:** **Schritt 3 – Deterministische Sortierung.** Sortiere nach einem fachlichen Feld (z. B.
`last_contact`), aber ergänze immer einen eindeutigen Tiebreaker (z. B. `id`). Ohne Tiebreaker haben Einträge
mit gleichem Wert keine feste Reihenfolge, und Seitengrenzen verschieben sich unvorhersehbar.

**EN:** **Step 3 – Deterministic ordering.** Sort by a business field (e.g. `last_contact`), but always add a
unique tiebreaker (e.g. `id`). Without a tiebreaker, entries with the same value have no fixed order, and page
boundaries shift unpredictably.

**DE:** **Schritt 4 – Paginierung wählen und begründen.** Offset ist einfach („Seite 3, je 20"), wird aber
unzuverlässig, wenn zwischen zwei Aufrufen Daten hinzukommen oder wegfallen. Cursor zeigt auf den letzten
gesehenen Eintrag und bleibt bei Änderungen stabiler, ist aber aufwendiger. Wähle bewusst und notiere den
Trade-off.

**EN:** **Step 4 – Choose and justify pagination.** Offset is simple ("page 3, 20 each") but becomes
unreliable when data is added or removed between calls. A cursor points to the last seen entry and stays more
stable across changes but is more complex. Choose deliberately and note the trade-off.

**DE:** **Schritt 5 – Grenzen und Robustheit.** Setze eine Obergrenze für die Seitengröße (z. B. maximal 100),
damit niemand die ganze Datenbank in einem Aufruf zieht. Bei ungültigen Parametern (negativer Offset,
unbekanntes Feld) antwortest du klar mit `400`, nicht mit einem Absturz oder einer stillen Standardausgabe.

**EN:** **Step 5 – Limits and robustness.** Set an upper bound for page size (e.g. max 100) so nobody pulls the
whole database in one call. On invalid parameters (negative offset, unknown field) respond clearly with `400`,
not with a crash or a silent default.

**DE:** **Typische Fehler.** Beliebige Feldnamen zulassen. Werte in Abfragen verketten. Sortieren ohne
Tiebreaker. Keine Obergrenze für die Seitengröße. Ungültige Parameter still ignorieren. Paginierung wählen,
ohne den Trade-off zu nennen.

**EN:** **Common mistakes.** Allowing arbitrary field names. Concatenating values into queries. Sorting without
a tiebreaker. No upper bound for page size. Silently ignoring invalid parameters. Choosing pagination without
naming the trade-off.

### Beispiel / Example

```text
Whitelist Filter/Sort: status, os, last_contact   (alles andere -> 400)

Query (parametrisiert):
  list(status = ?, order_by = last_contact DESC, id ASC, limit = ?, offset = ?)
  Werte als gebundene Parameter; Feldnamen nur aus der Whitelist

Determinismus: ORDER BY last_contact DESC, id ASC   (id = eindeutiger Tiebreaker)

Grenzen:  page_size <= 100 ; offset >= 0 ; ungueltig -> 400

Paginierung:
  Offset : "skip N" -> einfach, aber wackelig bei Einfuegungen/Loeschungen
  Cursor : Zeiger auf letzten Eintrag -> stabiler, aber aufwendiger

ADR-Kandidat: "Cursor-Paginierung fuer haeufig veraenderliche Listen"
  Alternative: Offset | Trade-off: Stabilitaet vs. Implementierungsaufwand
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11a**
ist primär, weil sichere Abfrage- und Blätterfunktionalität realisiert wird; LF 5 ist berührt, weil Filter und
Sortierung die Datenverwaltung anpassen und auswerten.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`).
**LF 11a** is primary because secure query and paging functionality is realized; LF 5 is touched because
filtering and sorting adapt and evaluate the data management.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Sichere Query-, Filter- und Paginierungslogik wird als Funktionalität realisiert. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Filter und Sortierung passen die Sicht auf die verwalteten Daten an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Eingabevalidierung, Fail-Safe Defaults (Whitelist), sichere
Programmierung (parametrisierte Abfragen) und Testbarkeit. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_03` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_12`
(Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Nur Whitelist-Felder sind
erlaubt, Abfragen sind parametrisiert, und jede Sortierung hat einen eindeutigen Tiebreaker.* A11Y-Aspekt:
gefilterte Ergebnislisten und Seitennavigation müssen als klarer Text und mit Tastatur nutzbar sein; die
aktuelle Seite darf nicht allein über Farbe erkennbar sein.

**EN:** Relation to the Secure Development Guideline: input validation, fail-safe defaults (whitelist), secure
programming (parameterized queries), and testability. Matching checklists: `CL_01` (standards applicability),
`CL_03` (input validation), `CL_08` (security code review), and `CL_12` (evidence and closure). The security
decision of this unit is: *only whitelist fields are allowed, queries are parameterized, and every ordering has
a unique tiebreaker.* Accessibility aspect: filtered result lists and page navigation must be usable as clear
text and with a keyboard; the current page must not be recognizable by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine Whitelist für Filterfelder sicherer als eine Blacklist? /
   **EN:** Why is a whitelist for filter fields safer than a blacklist?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Whitelist verweigert standardmäßig und erlaubt nur ausdrücklich Genanntes (Fail-Safe Default).
   Eine Blacklist muss jede gefährliche Möglichkeit kennen und vergisst leicht einen Fall.
   **EN:** A whitelist denies by default and allows only what is explicitly named (fail-safe default). A
   blacklist must know every dangerous option and easily forgets a case.

   </details>

2. **DE:** (AE) Warum braucht eine sortierte Liste einen eindeutigen Tiebreaker? /
   **EN:** (AE) Why does a sorted list need a unique tiebreaker?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Haben mehrere Einträge denselben Sortierwert, ist ihre Reihenfolge ohne Tiebreaker unbestimmt. Dann
   sind Seitengrenzen nicht-deterministisch, und beim Blättern können Einträge doppelt oder gar nicht
   erscheinen. Ein eindeutiges zweites Kriterium (z. B. `id`) macht die Reihenfolge stabil.
   **EN:** If several entries share the same sort value, their order is undefined without a tiebreaker. Then
   page boundaries are non-deterministic, and paging can show entries twice or not at all. A unique second
   criterion (e.g. `id`) makes the order stable.

   </details>

3. **DE:** (AE) Welchen Trade-off haben Offset- und Cursor-Paginierung? /
   **EN:** (AE) What trade-off do offset and cursor pagination have?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Offset ist einfach, wird aber unzuverlässig, wenn sich die Daten zwischen Aufrufen ändern. Cursor ist
   stabiler gegenüber Änderungen, aber aufwendiger umzusetzen. Die Wahl hängt davon ab, wie oft sich die Liste
   ändert.
   **EN:** Offset is simple but becomes unreliable when data changes between calls. A cursor is more stable
   against changes but more complex to implement. The choice depends on how often the list changes.

   </details>

4. **DE:** Warum müssen Werte in Abfragen parametrisiert werden? /
   **EN:** Why must values in queries be parameterized?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Parametrisierung trennt Code von Daten und verhindert Injection. Werden Werte per Zeichenkette
   eingesetzt, kann manipulierte Eingabe die Abfrage verändern und mehr Daten preisgeben als gewollt.
   **EN:** Parameterization separates code from data and prevents injection. If values are inserted via string
   concatenation, manipulated input can change the query and reveal more data than intended.

   </details>

5. **DE:** (SI) Warum ist eine Obergrenze für die Seitengröße auch eine Betriebsmaßnahme? /
   **EN:** (SI) Why is an upper bound on page size also an operational measure?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Grenze könnte ein Aufruf die ganze Datenmenge ziehen und Speicher, Netz und Antwortzeit
   belasten. Eine Obergrenze schützt die Verfügbarkeit des Dienstes und begrenzt die Wirkung von Missbrauch.
   **EN:** Without a limit, one call could pull the entire dataset and strain memory, network, and response
   time. An upper bound protects the availability of the service and limits the impact of abuse.

   </details>

6. **DE:** (DPA) Warum ist die Aussagegrenze eines gefilterten Ergebnisses wichtig? /
   **EN:** (DPA) Why does the interpretive limit of a filtered result matter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein gefiltertes Ergebnis zeigt nur einen Ausschnitt. Wer es als Gesamtbild liest, zieht falsche
   Schlüsse. Filter, Sortierung und Seitenausschnitt gehören zur Aussage dazu und sollten sichtbar dokumentiert
   sein.
   **EN:** A filtered result shows only a section. Reading it as the full picture leads to wrong conclusions.
   Filter, ordering, and page section are part of the statement and should be documented visibly.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] erlaubte Filter- und Sortierfelder als Whitelist festlegen.
- [ ] Abfragen parametrisieren und Feldnamen prüfen.
- [ ] eine deterministische Sortierung mit Tiebreaker sichern.
- [ ] eine Paginierungsstrategie (Offset/Cursor) mit Trade-off begründen.
- [ ] eine Obergrenze für Seitengrößen setzen.
- [ ] ungültige Parameter klar mit `400` beantworten.

**EN:** I can …

- [ ] define allowed filter and sort fields as a whitelist.
- [ ] parameterize queries and check field names.
- [ ] ensure deterministic ordering with a tiebreaker.
- [ ] justify a pagination strategy (offset/cursor) with a trade-off.
- [ ] set an upper bound for page sizes.
- [ ] answer invalid parameters clearly with `400`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
