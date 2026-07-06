# Lernbegleiter: Secure ServiceHarvester v2 01 – Architekturzielbild und Systemgrenzen / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In der Basis-Reihe war der ServiceHarvester ein einfaches Sammel-Programm. In v2 wird daraus ein
sauber geschnittener **Dienst**: Ein **Worker** trägt den Lebenszyklus (Start, Laufen, Stopp), ein
**Harvester** sammelt in Abständen Statusdaten, ein **Store** speichert sie hinter einer austauschbaren
Ablage, und eine kleine **API** stellt sie lesend bereit. Ein **Architekturzielbild** ist die geplante
Landkarte, die diese vier Bausteine und ihre Grenzen zeigt. Wer ohne Landkarte losläuft, zieht Grenzen
zufällig – und genau an zufälligen Grenzen entstehen Sicherheitslücken.

**EN:** In the base series the ServiceHarvester was a simple collection program. In v2 it becomes a cleanly
cut **service**: a **worker** carries the lifecycle (start, run, stop), a **harvester** collects status data
at intervals, a **store** saves it behind a swappable storage, and a small **API** provides it for reading.
An **architecture target picture** is the planned map that shows these four building blocks and their
boundaries. Whoever runs off without a map draws boundaries by accident – and it is exactly at accidental
boundaries that security holes appear.

**DE:** In dieser Einheit lernst du, den **Systemkontext** zu zeichnen (was gehört dazu, was nicht), die
**Vertrauensgrenzen** (Trust Boundaries) zwischen Worker, Harvester, Store und API zu benennen, die
Komponenten zu ordnen und die wichtigsten Architekturentscheidungen als **ADR-Kandidaten** festzuhalten. Der
**Schutzbedarf** jeder Komponente wird sichtbar, damit später klar ist, wo besonders geprüft werden muss.

**EN:** In this unit you learn to draw the **system context** (what belongs, what does not), to name the
**trust boundaries** between worker, harvester, store, and API, to order the components, and to record the
most important architecture decisions as **ADR candidates**. The **protection need** of each component
becomes visible, so that later it is clear where checks are especially required.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Worker / Worker | Baustein, der den Dienst hostet und den Lebenszyklus trägt (Start, Laufen, Stopp). |
| Harvester / Harvester | Baustein, der in Abständen Statusdaten sammelt und an den Store übergibt. |
| Store / Store | Speicher-Baustein hinter einer Abstraktion; die konkrete Ablage ist austauschbar. |
| API / API | Kleine Schnittstelle, die gesammelte Daten lesend bereitstellt. |
| Vertrauensgrenze / Trust boundary | Grenze zwischen nicht vertrauenswürdigen und geprüften Daten oder Zonen. |
| ADR / Architecture Decision Record | Kurznotiz zu einer wichtigen Entscheidung mit Grund, Alternative und Folge. |
| Schutzbedarf / Protection need | Bewertung, wie schützenswert Daten oder eine Funktion sind. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Systemkontext zeichnen.** Setze den Dienst in die Mitte und liste alle Nachbarn außen
herum: gesammelte Maschinen/Quellen, Importdateien, die kleine API mit ihren Aufrufern, den Store und das
Logziel. Was du außen nicht einträgst, vergisst du später bei der Absicherung. Der Kontext beantwortet:
*Wer oder was schickt Daten hinein, wer bekommt Daten heraus?*

**EN:** **Step 1 – Draw the system context.** Put the service in the center and list all neighbours around it:
collected machines/sources, import files, the small API with its callers, the store, and the log target. What
you do not enter outside you will forget later when securing it. The context answers: *who or what sends data
in, who receives data out?*

**DE:** **Schritt 2 – Vertrauensgrenzen einziehen.** Zwischen jedem Außen-Nachbarn und der Fachlogik liegt
eine Grenze; auch innen liegen Grenzen, etwa zwischen Harvester und Store oder zwischen API und Store.
**Warum wichtig:** Nur an einer benannten Grenze kannst du bewusst prüfen, protokollieren und Rechte
durchsetzen. Eine unsichtbare Grenze wird nicht geschützt.

**EN:** **Step 2 – Draw in trust boundaries.** Between every outside neighbour and the business logic lies a
boundary; boundaries also exist inside, for example between harvester and store, or between API and store.
**Why it matters:** only at a named boundary can you deliberately check, log, and enforce rights. An invisible
boundary is not protected.

**DE:** **Schritt 3 – Komponenten ordnen.** Teile den Dienst in die vier klaren Bausteine: **Worker**
(Hosting/Lebenszyklus), **Harvester** (Sammeln), **Store** (Ablage hinter Abstraktion) und **API**
(Leseschnittstelle). **Warum wichtig:** Getrennte Bausteine mit klarer Aufgabe heißen **Separation of
Concerns**. Sie erlauben, Sicherheit (Validierung, Auth, Logging) als Querschnitt einzuziehen statt
verstreut, und einen Store-Wechsel ohne Bruch der übrigen Teile.

**EN:** **Step 3 – Order the components.** Split the service into the four clear blocks: **worker**
(hosting/lifecycle), **harvester** (collection), **store** (storage behind an abstraction), and **API** (read
interface). **Why it matters:** separate blocks with a clear task are called **separation of concerns**. They
let you add security (validation, auth, logging) as a cross-cutting layer instead of scattered, and swap the
store without breaking the other parts.

**DE:** **Schritt 4 – ADR-Kandidaten festhalten.** Notiere jede wichtige Entscheidung kurz: *Was* wird
entschieden, *warum*, welche *Alternativen* gab es, welche *Folgen* hat es. Beispiel: „Store hinter einer
Abstraktion statt direktem Datenbankzugriff aus dem Harvester, weil ein Backend-Wechsel möglich bleiben soll;
Folge: eine klare Grenze, aber eine zusätzliche Schnittstelle.“ **Warum wichtig:** Ohne ADR weiß später
niemand, warum etwas so ist – und ändert es blind.

**EN:** **Step 4 – Record ADR candidates.** Note every important decision briefly: *what* is decided, *why*,
which *alternatives* existed, which *consequences* it has. Example: "Store behind an abstraction instead of
direct database access from the harvester, because a backend switch must remain possible; consequence: a clear
boundary, but an extra interface." **Why it matters:** without an ADR, nobody will later know why something is
the way it is – and changes it blindly.

**DE:** **Schritt 5 – Schutzbedarf sichtbar machen.** Bewerte je Komponente kurz, wie schützenswert die Daten
sind (Vertraulichkeit, Integrität, Verfügbarkeit). Gesammelte Statusdaten haben oft hohen Integritätsbedarf,
weil aus ihnen Betriebsentscheidungen folgen; eine Hilfe-Textdatei hat niedrigen Schutzbedarf. So weißt du,
wo du zuerst investierst.

**EN:** **Step 5 – Make the protection need visible.** Assess per component briefly how worth protecting the
data is (confidentiality, integrity, availability). Collected status data often has a high integrity need,
because operational decisions follow from it; a help text file has a low protection need. This tells you where
to invest first.

**DE:** **Typische Fehler.** Den Dienst als eine einzige Kiste ohne innere Struktur zeichnen. Grenzen
vergessen (z. B. das Logziel oder den Aufrufer der API). Frameworks wählen, ohne die Entscheidung zu
begründen. Positive Sicherheitsaussagen treffen („ist sicher“) ohne Nachweis. Schutzbedarf pauschal auf
„mittel“ setzen.

**EN:** **Common mistakes.** Drawing the service as one single box without inner structure. Forgetting
boundaries (e.g. the log target or the API caller). Choosing frameworks without justifying the decision.
Making positive security claims ("it is secure") without evidence. Setting the protection need flatly to
"medium".

### Beispiel / Example

```text
Systemkontext (vereinfacht):

  [Quelle/Maschine] --Statusdaten--> ( Grenze 1 ) --> [Harvester] --> ( Grenze 2 ) --> [Store]
  [Importdatei CSV] --Datei-------->  ( Grenze 3 ) --> [Harvester]
  [API-Aufrufer]    --Leseaufruf--->  ( Grenze 4 ) --> [API] --> ( Grenze 2 ) --> [Store]
  [Worker]          haelt Lebenszyklus (Start/Stopp) und startet Harvester und API
                    --Betrieb--> [Logziel] , [Konfiguration]

ADR-Kandidat: "Store hinter Abstraktion, nicht direkter DB-Zugriff aus dem Harvester"
  Warum:        spaeterer Backend-Wechsel (SQLite -> PostgreSQL -> MongoDB) soll moeglich sein
  Alternative:  Harvester spricht direkt mit der Datenbank (verworfen: harte Bindung)
  Folge:        eine klare Grenze und ein Speichervertrag statt verstreuter Zugriffe

Schutzbedarf (Auszug):
  gesammelte Statusdaten -> Integritaet hoch (falscher Status -> falsche Entscheidung)
  Konfiguration/Secrets  -> Vertraulichkeit hoch
  Hilfetext              -> niedrig
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das Architekturzielbild ordnet die datenverwaltende Dienst-Software in klare Bausteine und Grenzen. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Systemgrenzen und die kleine API bereiten die systemübergreifende Bereitstellung vor. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries, Angriffsflächen-
Reduktion und auditfähige Entscheidungen. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03`
(sichere Architektur), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12`
(Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Grenze zwischen Worker,
Harvester, Store und API wird benannt, bevor sie geschützt wird.* A11Y-Aspekt: Das Architekturzielbild muss
auch als Text (nicht nur als Grafik) lesbar sein – benenne Komponenten und Grenzen in einer Liste oder
Tabelle, damit Screenreader und Braille-Zeile es erfassen; setze nie Farbe als einziges Unterscheidungsmerkmal
ein.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, attack-surface
reduction, and auditable decisions. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure
architecture), `CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence / N/A rationale). The
security decision of this unit is: *every boundary between worker, harvester, store, and API is named before it
is protected.* Accessibility aspect: the architecture target picture must be readable as text (not only as a
graphic) – name components and boundaries in a list or table so a screen reader and Braille display can grasp
it; never use color as the only distinguishing feature.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt man Worker, Harvester, Store und API in vier Bausteine statt in einen Block? /
   **EN:** Why split worker, harvester, store, and API into four blocks instead of one?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Getrennte Bausteine mit je einer Aufgabe (Separation of Concerns) erlauben klare Grenzen,
   gezielte Prüfung und einen Store-Wechsel ohne Bruch der übrigen Teile. Ein einziger Block vermischt
   Verantwortungen und versteckt Grenzen.
   **EN:** Separate blocks with one task each (separation of concerns) allow clear boundaries, targeted checks,
   and a store swap without breaking the other parts. A single block mixes responsibilities and hides
   boundaries.

   </details>

2. **DE:** Warum muss eine Vertrauensgrenze benannt sein, bevor man sie schützen kann? /
   **EN:** Why must a trust boundary be named before it can be protected?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur an einer benannten Grenze kann man bewusst prüfen, protokollieren und Rechte durchsetzen. Eine
   unsichtbare Grenze wird übersehen und bleibt ungeschützt.
   **EN:** Only at a named boundary can one deliberately check, log, and enforce rights. An invisible boundary
   is overlooked and stays unprotected.

   </details>

3. **DE:** (AE) Wie hilft die Store-Abstraktion bei der späteren Implementierung? /
   **EN:** (AE) How does the store abstraction help in the later implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Harvester und die API sprechen nur mit dem Speichervertrag, nicht mit einer konkreten Datenbank.
   So kann man das Backend wechseln und einzelne Teile testen, ohne die Fachlogik zu ändern.
   **EN:** The harvester and the API talk only to the storage contract, not to a concrete database. This lets
   you swap the backend and test individual parts without changing the business logic.

   </details>

4. **DE:** (SI) Welche Betriebsannahme des Workers gehört in den Systemkontext? /
   **EN:** (SI) Which operational assumption of the worker belongs in the system context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Worker trägt Start und Stopp und braucht ein Logziel, eine Konfigurationsquelle und minimale
   Rechte. Diese Nachbarn müssen im Kontext stehen, weil dort Secrets, Schreibrechte und sauberes Beenden
   betroffen sind.
   **EN:** The worker carries start and stop and needs a log target, a configuration source, and minimal
   rights. These neighbours must appear in the context because secrets, write rights, and clean shutdown are
   affected there.

   </details>

5. **DE:** (DPA) Warum ist der Schutzbedarf nicht für alle Komponenten gleich? /
   **EN:** (DPA) Why is the protection need not the same for all components?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Gesammelte Statusdaten brauchen hohe Integrität, Konfiguration mit Secrets hohe Vertraulichkeit, ein
   Hilfetext fast nichts. Getrennte Bewertung zeigt, wo zuerst investiert und wo sparsam gesammelt wird.
   **EN:** Collected status data needs high integrity, configuration with secrets high confidentiality, a help
   text almost none. A separate assessment shows where to invest first and where to collect sparingly.

   </details>

6. **DE:** (DV) Warum ist es sinnvoll, die Grenze zwischen API-Aufrufern und dem Store früh zu benennen? /
   **EN:** (DV) Why is it useful to name the boundary between API callers and the store early?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Grenze zeigt, wo Daten die Vertrauenszone wechseln. Wer sie früh benennt, plant Schnittstelle,
   Kommunikationsweg, Validierung und Zugriffsrechte gezielt und lässt die API nicht direkt in den Store
   greifen.
   **EN:** The boundary shows where data crosses the trust zone. Naming it early allows targeted planning of
   interface, communication path, validation, and access rights, and prevents the API from reaching directly
   into the store.

   </details>

7. **DE:** Warum darf man eine Framework-Wahl nicht ohne Begründung treffen? /
   **EN:** Why must a framework choice not be made without a rationale?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Lösung soll für alle sechs Sprachen vergleichbar bleiben. Eine begründete Wahl macht Folgen und
   Alternativen sichtbar und verhindert eine versteckte Bindung an ein Werkzeug.
   **EN:** The solution must stay comparable across all six languages. A justified choice makes consequences and
   alternatives visible and prevents a hidden lock-in to one tool.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Systemkontext mit Worker, Harvester, Store, API und allen Nachbarn als Text beschreiben.
- [ ] alle Vertrauensgrenzen zwischen den vier Bausteinen benennen.
- [ ] den Dienst in vier klare Komponenten mit je einer Aufgabe teilen.
- [ ] mindestens einen ADR-Kandidaten mit Grund, Alternative und Folge notieren.
- [ ] den Schutzbedarf je Komponente unterscheiden und begründen.

**EN:** I can …

- [ ] describe a system context with worker, harvester, store, API, and all neighbours as text.
- [ ] name all trust boundaries between the four blocks.
- [ ] split the service into four clear components each with one task.
- [ ] note at least one ADR candidate with rationale, alternative, and consequence.
- [ ] distinguish and justify the protection need per component.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md`. The copy-paste prompt for
a later, manually started Spec Kit run is provided there.
