# Lernbegleiter: Secure OrderDesk v2 01 – Architekturzielbild und Systemgrenzen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In der Basis-Reihe war der Secure OrderDesk ein einfaches Bestell-Programm für die fiktive Handelsfirma Secure Trader. In v2 wird daraus eine sauber geschnittene **Handelsplattform**: Eine **Bestellannahme** nimmt neue Bestellungen entgegen, ein **Katalog** hält Kunden, Produkte und Kategorien, ein **Store** speichert alles relational hinter einer austauschbaren Ablage, und eine kleine **API** stellt Daten lesend und schreibend bereit. Ein **Architekturzielbild** ist die geplante Landkarte, die diese vier Bausteine und ihre Grenzen zeigt. Wer ohne Landkarte losläuft, zieht Grenzen zufällig – und genau an zufälligen Grenzen entstehen Sicherheitslücken.

**EN:** In the base series the Secure OrderDesk was a simple ordering program for the fictional trading company Secure Trader. In v2 it becomes a cleanly cut **trading platform**: an **order intake** accepts new orders, a **catalog** holds customers, products, and categories, a **store** saves everything relationally behind a swappable backend, and a small **API** provides data for reading and writing. An **architecture target picture** is the planned map that shows these four building blocks and their boundaries. Whoever runs off without a map draws boundaries by accident – and it is exactly at accidental boundaries that security holes appear.

**DE:** In dieser Einheit lernst du, den **Systemkontext** zu zeichnen (was gehört dazu, was nicht), die **Vertrauensgrenzen** (Trust Boundaries) zwischen Bestellannahme, Katalog, Store und API zu benennen, die Komponenten zu ordnen und die wichtigsten Architekturentscheidungen als **ADR-Kandidaten** festzuhalten. Der **Schutzbedarf** jeder Komponente wird sichtbar. Die verbindliche Datenbasis ist die klassische Northwind-Sample-DB inkl. `ALFKI`.

**EN:** In this unit you learn to draw the **system context** (what belongs, what does not), to name the **trust boundaries** between order intake, catalog, store, and API, to order the components, and to record the most important architecture decisions as **ADR candidates**. The **protection need** of each component becomes visible. The binding data base is the classic Northwind sample database incl. `ALFKI`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Bestellannahme / Order intake | Baustein, der neue Bestellungen prüft, annimmt und an den Store übergibt. |
| Katalog / Catalog | Baustein für Stammdaten: Kunden, Produkte, Kategorien im Northwind-Layout. |
| Store / Store | Relationaler Speicher-Baustein hinter einer Abstraktion; die Ablage ist austauschbar. |
| API / API | Schnittstelle, die Bestellungen anlegt und Bestell-/Katalogdaten lesend bereitstellt. |
| Vertrauensgrenze / Trust boundary | Grenze zwischen nicht vertrauenswürdigen und geprüften Daten oder Zonen. |
| ADR / Architecture Decision Record | Kurznotiz zu einer wichtigen Entscheidung mit Grund, Alternative und Folge. |
| Schutzbedarf / Protection need | Bewertung, wie schützenswert Daten oder eine Funktion sind. |
| Northwind / `ALFKI` | Fiktive Sample-Datenbasis; `ALFKI` (Alfreds Futterkiste, Berlin) ist der feste Beispiel-Anker. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Systemkontext zeichnen.** Setze die Plattform in die Mitte und liste alle Nachbarn außen herum: Bestellquellen (Kundeneingaben, Import-Batches), die API mit ihren Aufrufern, den Store und das Logziel. Was du außen nicht einträgst, vergisst du später bei der Absicherung. Der Kontext beantwortet: *Wer schickt Bestellungen hinein, wer bekommt Daten heraus?*

**EN:** **Step 1 – Draw the system context.** Put the platform in the center and list all neighbours around it: order sources (customer input, import batches), the API with its callers, the store, and the log target. What you do not enter outside you will forget later when securing it. The context answers: *who sends orders in, who receives data out?*

**DE:** **Schritt 2 – Vertrauensgrenzen einziehen.** Zwischen jedem Außen-Nachbarn und der Fachlogik liegt eine Grenze; auch innen liegen Grenzen, etwa zwischen Bestellannahme und Store oder zwischen API und Store. **Warum wichtig:** Nur an einer benannten Grenze kannst du bewusst prüfen, protokollieren und Rechte durchsetzen. Eine unsichtbare Grenze wird nicht geschützt – dort schlüpft z. B. eine SQL-Injection durch.

**EN:** **Step 2 – Draw in trust boundaries.** Between every outside neighbour and the business logic lies a boundary; boundaries also exist inside, for example between order intake and store, or between API and store. **Why it matters:** only at a named boundary can you deliberately check, log, and enforce rights. An invisible boundary is not protected – that is where, for example, a SQL injection slips through.

**DE:** **Schritt 3 – Komponenten ordnen.** Teile die Plattform in vier klare Bausteine: **Bestellannahme** (Aufträge prüfen/annehmen), **Katalog** (Stammdaten), **Store** (relationale Ablage hinter Abstraktion) und **API** (Zugang). **Warum wichtig:** Getrennte Bausteine mit klarer Aufgabe heißen **Separation of Concerns**. Sie erlauben, Sicherheit (Validierung, Auth, Logging) als Querschnitt einzuziehen statt verstreut, und einen Backend-Wechsel ohne Bruch der übrigen Teile.

**EN:** **Step 3 – Order the components.** Split the platform into four clear blocks: **order intake** (check/accept orders), **catalog** (master data), **store** (relational backend behind an abstraction), and **API** (access). **Why it matters:** separate blocks with a clear task are called **separation of concerns**. They let you add security (validation, auth, logging) as a cross-cutting layer instead of scattered, and swap the backend without breaking the other parts.

**DE:** **Schritt 4 – ADR-Kandidaten festhalten.** Notiere jede wichtige Entscheidung kurz: *Was* wird entschieden, *warum*, welche *Alternativen* gab es, welche *Folgen* hat es. Beispiel: „Store hinter einer Abstraktion statt direktem Datenbankzugriff aus der Bestellannahme, weil ein Backend-Wechsel möglich bleiben soll; Folge: eine klare Grenze, aber eine zusätzliche Schnittstelle." **Warum wichtig:** Ohne ADR weiß später niemand, warum etwas so ist – und ändert es blind.

**EN:** **Step 4 – Record ADR candidates.** Note every important decision briefly: *what* is decided, *why*, which *alternatives* existed, which *consequences* it has. Example: "Store behind an abstraction instead of direct database access from the order intake, because a backend switch must remain possible; consequence: a clear boundary, but an extra interface." **Why it matters:** without an ADR, nobody will later know why something is the way it is – and changes it blindly.

**DE:** **Schritt 5 – Schutzbedarf sichtbar machen.** Bewerte je Komponente kurz, wie schützenswert die Daten sind (Vertraulichkeit, Integrität, Verfügbarkeit). Bestelldaten haben hohen Integritätsbedarf (falsche Menge/Preis → falsche Rechnung); Kundenkontaktdaten haben Vertraulichkeitsbedarf; ein Hilfetext fast keinen. So weißt du, wo du zuerst investierst und wo du sparsam sammelst (Datenminimierung).

**EN:** **Step 5 – Make the protection need visible.** Assess per component briefly how worth protecting the data is (confidentiality, integrity, availability). Order data has a high integrity need (wrong quantity/price → wrong invoice); customer contact data has a confidentiality need; a help text almost none. This tells you where to invest first and where to collect sparingly (data minimization).

**DE:** **Typische Fehler.** Die Plattform als eine einzige Kiste ohne innere Struktur zeichnen. Grenzen vergessen (z. B. den Import-Batch oder den Aufrufer der API). Frameworks wählen, ohne die Entscheidung zu begründen. Positive Sicherheitsaussagen treffen („ist sicher") ohne Nachweis. Schutzbedarf pauschal auf „mittel" setzen.

**EN:** **Common mistakes.** Drawing the platform as one single box without inner structure. Forgetting boundaries (e.g. the import batch or the API caller). Choosing frameworks without justifying the decision. Making positive security claims ("it is secure") without evidence. Setting the protection need flatly to "medium".

### Beispiel / Example

```text
Systemkontext (vereinfacht):

  [Kunde/Eingabe]   --Bestellung--> ( Grenze 1 ) --> [Bestellannahme] --> ( Grenze 2 ) --> [Store]
  [Import-Batch CSV]--Datei------->  ( Grenze 3 ) --> [Bestellannahme]
  [API-Aufrufer]    --Aufruf------>  ( Grenze 4 ) --> [API] --> [Katalog] / --> ( Grenze 2 ) --> [Store]
  Betrieb: --> [Logziel] , [Konfiguration]  (Northwind-Daten inkl. ALFKI im Store)

ADR-Kandidat: "Store hinter Abstraktion, nicht direkter DB-Zugriff aus der Bestellannahme"
  Warum:        spaeterer Backend-Wechsel (SQLite -> PostgreSQL -> SQL Server) soll moeglich sein
  Alternative:  Bestellannahme spricht direkt mit der Datenbank (verworfen: harte Bindung)
  Folge:        eine klare Grenze und ein Speichervertrag statt verstreuter Zugriffe

Schutzbedarf (Auszug):
  Bestelldaten (Menge/Preis) -> Integritaet hoch (falscher Wert -> falsche Rechnung)
  Kundenkontakt (ALFKI)      -> Vertraulichkeit mittel bis hoch
  Konfiguration/Secrets      -> Vertraulichkeit hoch
  Hilfetext                  -> niedrig
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das Architekturzielbild ordnet die datenverwaltende Handelsplattform in klare Bausteine und Grenzen. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Systemgrenzen und die kleine API bereiten die systemübergreifende Bereitstellung von Bestelldaten vor. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries, Angriffsflächen-Reduktion und auditfähige Entscheidungen. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere Architektur), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Grenze zwischen Bestellannahme, Katalog, Store und API wird benannt, bevor sie geschützt wird.* A11Y-Aspekt: Das Architekturzielbild muss auch als Text (nicht nur als Grafik) lesbar sein – benenne Komponenten und Grenzen in einer Liste oder Tabelle, damit Screenreader und Braille-Zeile es erfassen; setze nie Farbe als einziges Unterscheidungsmerkmal ein.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, attack-surface reduction, and auditable decisions. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture), `CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence / N/A rationale). The security decision of this unit is: *every boundary between order intake, catalog, store, and API is named before it is protected.* Accessibility aspect: the architecture target picture must be readable as text (not only as a graphic) – name components and boundaries in a list or table so a screen reader and Braille display can grasp it; never use color as the only distinguishing feature.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt man Bestellannahme, Katalog, Store und API in vier Bausteine statt in einen Block? /
   **EN:** Why split order intake, catalog, store, and API into four blocks instead of one?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Getrennte Bausteine mit je einer Aufgabe (Separation of Concerns) erlauben klare Grenzen, gezielte Prüfung und einen Backend-Wechsel ohne Bruch der übrigen Teile. Ein einziger Block vermischt Verantwortungen und versteckt Grenzen.
   **EN:** Separate blocks with one task each (separation of concerns) allow clear boundaries, targeted checks, and a backend swap without breaking the other parts. A single block mixes responsibilities and hides boundaries.

   </details>

2. **DE:** Warum muss eine Vertrauensgrenze benannt sein, bevor man sie schützen kann? /
   **EN:** Why must a trust boundary be named before it can be protected?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur an einer benannten Grenze kann man bewusst prüfen, protokollieren und Rechte durchsetzen. Eine unsichtbare Grenze wird übersehen und bleibt ungeschützt – dort kann z. B. eine SQL-Injection eindringen.
   **EN:** Only at a named boundary can one deliberately check, log, and enforce rights. An invisible boundary is overlooked and stays unprotected – a SQL injection can enter there, for example.

   </details>

3. **DE:** (AE) Wie hilft die Store-Abstraktion bei der späteren Implementierung? /
   **EN:** (AE) How does the store abstraction help in the later implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Bestellannahme und die API sprechen nur mit dem Speichervertrag, nicht mit einer konkreten Datenbank. So kann man das Backend (SQLite, PostgreSQL, SQL Server) wechseln und einzelne Teile testen, ohne die Fachlogik zu ändern.
   **EN:** The order intake and the API talk only to the storage contract, not to a concrete database. This lets you swap the backend (SQLite, PostgreSQL, SQL Server) and test individual parts without changing the business logic.

   </details>

4. **DE:** (SI) Welche Betriebsannahme der Plattform gehört in den Systemkontext? /
   **EN:** (SI) Which operational assumption of the platform belongs in the system context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Plattform braucht ein Logziel, eine Konfigurationsquelle, eine Verbindungszeichenkette zur Datenbank und minimale Rechte. Diese Nachbarn müssen im Kontext stehen, weil dort Secrets, Schreibrechte und der Datenbankzugang betroffen sind.
   **EN:** The platform needs a log target, a configuration source, a database connection string, and minimal rights. These neighbours must appear in the context because secrets, write rights, and database access are affected there.

   </details>

5. **DE:** (DPA) Warum ist der Schutzbedarf nicht für alle Komponenten gleich? /
   **EN:** (DPA) Why is the protection need not the same for all components?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bestelldaten brauchen hohe Integrität (falsche Menge/Preis → falsche Rechnung), Kundenkontaktdaten Vertraulichkeit, ein Hilfetext fast nichts. Getrennte Bewertung zeigt, wo zuerst investiert und wo sparsam gesammelt wird.
   **EN:** Order data needs high integrity (wrong quantity/price → wrong invoice), customer contact data needs confidentiality, a help text almost none. A separate assessment shows where to invest first and where to collect sparingly.

   </details>

6. **DE:** (DV) Warum ist es sinnvoll, die Grenze zwischen API-Aufrufern und dem Store früh zu benennen? /
   **EN:** (DV) Why is it useful to name the boundary between API callers and the store early?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Grenze zeigt, wo Daten die Vertrauenszone wechseln. Wer sie früh benennt, plant Schnittstelle, Kommunikationsweg, Validierung und Zugriffsrechte gezielt und lässt die API nicht direkt in den Store greifen.
   **EN:** The boundary shows where data crosses the trust zone. Naming it early allows targeted planning of interface, communication path, validation, and access rights, and prevents the API from reaching directly into the store.

   </details>

7. **DE:** Warum darf man eine Framework-Wahl nicht ohne Begründung treffen? /
   **EN:** Why must a framework choice not be made without a rationale?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Lösung soll für alle sechs Sprachen vergleichbar bleiben. Eine begründete Wahl macht Folgen und Alternativen sichtbar und verhindert eine versteckte Bindung an ein Werkzeug.
   **EN:** The solution must stay comparable across all six languages. A justified choice makes consequences and alternatives visible and prevents a hidden lock-in to one tool.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Systemkontext mit Bestellannahme, Katalog, Store, API und allen Nachbarn als Text beschreiben.
- [ ] alle Vertrauensgrenzen zwischen den vier Bausteinen benennen.
- [ ] die Plattform in vier klare Komponenten mit je einer Aufgabe teilen.
- [ ] mindestens einen ADR-Kandidaten mit Grund, Alternative und Folge notieren.
- [ ] den Schutzbedarf je Komponente unterscheiden und begründen.

**EN:** I can …

- [ ] describe a system context with order intake, catalog, store, API, and all neighbours as text.
- [ ] name all trust boundaries between the four blocks.
- [ ] split the platform into four clear components each with one task.
- [ ] note at least one ADR candidate with rationale, alternative, and consequence.
- [ ] distinguish and justify the protection need per component.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
