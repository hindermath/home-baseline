# Lernbegleiter: Secure CaseTracker v2 01 – Architekturzielbild und Systemgrenzen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bevor eine einzige Zeile Code entsteht, muss klar sein, *was* das System ist, *wo* seine Grenzen
liegen und *wer* mit ihm spricht. In der Basis-Reihe hast du eine einfache Fallverwaltung gebaut. In v2
wird daraus eine Service Edition: ein System mit klaren Bausteinen, einer Persistenz, einer Schnittstelle
und einem Betrieb. Ein **Architekturzielbild** ist die geplante Landkarte dieses Systems. Wer ohne
Landkarte losläuft, baut Grenzen zufällig – und genau an zufälligen Grenzen entstehen Sicherheitslücken.

**EN:** Before a single line of code is written, it must be clear *what* the system is, *where* its
boundaries lie, and *who* talks to it. In the base series you built a simple case management. In v2 this
becomes a Service Edition: a system with clear building blocks, a persistence layer, an interface, and an
operation. An **architecture target picture** is the planned map of this system. Whoever runs off without a
map draws boundaries by accident – and it is exactly at accidental boundaries that security holes appear.

**DE:** In dieser Einheit lernst du, den **Systemkontext** zu zeichnen (was gehört dazu, was nicht), die
**Vertrauensgrenzen** (Trust Boundaries) zu benennen, die Komponenten zu ordnen und die wichtigsten
Architekturentscheidungen als **ADR-Kandidaten** festzuhalten. Der **Schutzbedarf** jeder Komponente wird
sichtbar, damit später klar ist, wo besonders geprüft werden muss.

**EN:** In this unit you learn to draw the **system context** (what belongs to it, what does not), to name
the **trust boundaries**, to order the components, and to record the most important architecture decisions
as **ADR candidates**. The **protection need** of each component becomes visible, so that later it is clear
where checks are especially required.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Systemkontext / System context | Sicht auf das System als Ganzes samt Nachbarn (Nutzer, Dateien, Dienste). |
| Vertrauensgrenze / Trust boundary | Grenze zwischen nicht vertrauenswürdigen und geprüften Daten oder Zonen. |
| Komponente / Component | Abgegrenzter Baustein mit klarer Aufgabe, z. B. Kernlogik oder Persistenz. |
| ADR / Architecture Decision Record | Kurznotiz zu einer wichtigen Entscheidung mit Grund und Alternativen. |
| Schutzbedarf / Protection need | Bewertung, wie schützenswert Daten oder eine Funktion sind. |
| Angriffsfläche / Attack surface | Summe aller Punkte, an denen ein Angreifer ansetzen könnte. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Systemkontext zeichnen.** Setze das System in die Mitte und liste alle Nachbarn außen
herum: bedienende Personen, Importdateien, eine spätere API, die Persistenz, das Logziel. Was du außen
nicht einträgst, vergisst du später bei der Absicherung. Der Kontext beantwortet die Frage: *Wer oder was
schickt Daten hinein, wer bekommt Daten heraus?*

**EN:** **Step 1 – Draw the system context.** Put the system in the center and list all neighbours around it:
operating users, import files, a later API, the persistence, the log target. What you do not enter outside
you will forget later when securing it. The context answers the question: *who or what sends data in, who
receives data out?*

**DE:** **Schritt 2 – Vertrauensgrenzen einziehen.** Zwischen jedem Außen-Nachbarn und der Kernlogik liegt
eine Vertrauensgrenze. Auch innen können Grenzen liegen, etwa zwischen Kernlogik und Persistenz. **Warum
wichtig:** Nur an einer benannten Grenze kannst du bewusst prüfen, protokollieren und Rechte durchsetzen.
Eine unsichtbare Grenze wird nicht geschützt.

**EN:** **Step 2 – Draw in trust boundaries.** Between every outside neighbour and the core logic lies a
trust boundary. Boundaries can also exist inside, for example between core logic and persistence. **Why it
matters:** only at a named boundary can you deliberately check, log, and enforce rights. An invisible
boundary is not protected.

**DE:** **Schritt 3 – Komponenten ordnen.** Teile das System in wenige klare Bausteine: Eingabe/Oberfläche,
Kernlogik (Fachregeln), Persistenz (Speicherung), Schnittstelle (API/CLI) und Betrieb (Logging,
Konfiguration). **Warum wichtig:** Getrennte Bausteine mit klarer Aufgabe heißen **Separation of Concerns**.
Sie erlauben, Sicherheit (Auth, Validierung, Logging) als Querschnitt einzuziehen statt verstreut.

**EN:** **Step 3 – Order the components.** Split the system into a few clear building blocks:
input/interface, core logic (business rules), persistence (storage), interface (API/CLI), and operation
(logging, configuration). **Why it matters:** separate blocks with a clear task are called **separation of
concerns**. They let you add security (auth, validation, logging) as a cross-cutting layer instead of
scattered.

**DE:** **Schritt 4 – ADR-Kandidaten festhalten.** Notiere jede wichtige Entscheidung kurz: *Was* wird
entschieden, *warum*, welche *Alternativen* gab es, welche *Folgen* hat es. Beispiel: „Persistenz als lokale
Datei statt Datenbank, weil sprachneutral und einfach; Folge: kein Netzwerk-Angriffspfad, aber begrenzte
Mehrbenutzerfähigkeit.“ **Warum wichtig:** Ohne ADR wird später niemand wissen, warum etwas so ist – und
ändert es blind.

**EN:** **Step 4 – Record ADR candidates.** Note every important decision briefly: *what* is decided, *why*,
which *alternatives* existed, which *consequences* it has. Example: "Persistence as a local file instead of a
database, because it is language-neutral and simple; consequence: no network attack path, but limited
multi-user capability." **Why it matters:** without an ADR, nobody will later know why something is the way
it is – and changes it blindly.

**DE:** **Schritt 5 – Schutzbedarf sichtbar machen.** Bewerte je Komponente kurz, wie schützenswert die
Daten sind (Vertraulichkeit, Integrität, Verfügbarkeit). Fallnotizen mit personenbezogenem Bezug haben
hohen Schutzbedarf; eine Hilfe-Textdatei nicht. So weißt du, wo du zuerst investierst.

**EN:** **Step 5 – Make the protection need visible.** Assess per component briefly how worth protecting the
data is (confidentiality, integrity, availability). Case notes with a personal reference have a high
protection need; a help text file does not. This tells you where to invest first.

**DE:** **Typische Fehler.** Das System als eine einzige Kiste ohne innere Struktur zeichnen. Grenzen
vergessen (z. B. das Logziel). Frameworks wählen, ohne die Entscheidung zu begründen. Positive
Sicherheitsaussagen treffen („ist sicher“) ohne Nachweis. Schutzbedarf pauschal auf „mittel“ setzen.

**EN:** **Common mistakes.** Drawing the system as one single box without inner structure. Forgetting
boundaries (e.g. the log target). Choosing frameworks without justifying the decision. Making positive
security claims ("it is secure") without evidence. Setting the protection need flatly to "medium".

### Beispiel / Example

```text
Systemkontext (vereinfacht):

  [Sachbearbeiter*in] --Eingabe--> ( Grenze 1 ) --> [Oberflaeche/CLI]
  [Importdatei CSV]   --Datei---->  ( Grenze 2 ) --> [Kernlogik] --> ( Grenze 3 ) --> [Persistenz-Datei]
  [Spaetere API]      --Aufruf---->  ( Grenze 4 ) --> [Kernlogik] --> [Logziel]

ADR-Kandidat: "Validierung in der Kernlogik, nicht nur in der Oberflaeche"
  Warum:        Oberflaeche laesst sich umgehen (API, CSV, CLI)
  Alternative:  nur UI-Pruefung (verworfen: kein echter Schutz)
  Folge:        eine verbindliche Pruefstelle je Eingang

Schutzbedarf (Auszug):
  Fallnotizen (personenbezogen)  -> hoch  (Vertraulichkeit)
  Statuswerte                    -> mittel (Integritaet)
  Hilfetext                      -> niedrig
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das Architekturzielbild ordnet die datenverwaltende Software in klare Bausteine und Grenzen. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Systemgrenzen und spätere Schnittstellen bereiten die systemübergreifende Bereitstellung vor. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries, Angriffsflächen-
Reduktion und auditfähige Entscheidungen. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03`
(sichere Architektur), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12`
(Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Grenze wird benannt,
bevor sie geschützt wird.* A11Y-Aspekt: Das Architekturzielbild muss auch als Text (nicht nur als Grafik)
lesbar sein – benenne Komponenten und Grenzen in einer Liste oder Tabelle, damit Screenreader und
Braille-Zeile es erfassen; setze nie Farbe als einziges Unterscheidungsmerkmal ein.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, attack-surface
reduction, and auditable decisions. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure
architecture), `CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence / N/A rationale). The
security decision of this unit is: *every boundary is named before it is protected.* Accessibility aspect:
the architecture target picture must be readable as text (not only as a graphic) – name components and
boundaries in a list or table so a screen reader and Braille display can grasp it; never use color as the
only distinguishing feature.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum muss eine Vertrauensgrenze benannt sein, bevor man sie schützen kann? /
   **EN:** Why must a trust boundary be named before it can be protected?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur an einer benannten Grenze kann man bewusst prüfen, protokollieren und Rechte durchsetzen. Eine
   unsichtbare Grenze wird übersehen und bleibt ungeschützt.
   **EN:** Only at a named boundary can one deliberately check, log, and enforce rights. An invisible boundary
   is overlooked and stays unprotected.

   </details>

2. **DE:** Was gehört in einen ADR-Kandidaten, und warum ist die Begründung so wichtig? /
   **EN:** What belongs in an ADR candidate, and why is the rationale so important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Was entschieden wird, warum, welche Alternativen es gab und welche Folgen entstehen. Ohne Grund
   ändern spätere Personen die Entscheidung blind und zerstören eventuell den Schutz.
   **EN:** What is decided, why, which alternatives existed, and which consequences arise. Without a rationale,
   later people change the decision blindly and may destroy the protection.

   </details>

3. **DE:** (AE) Wie hilft Separation of Concerns bei der späteren Implementierung? /
   **EN:** (AE) How does separation of concerns help in the later implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klar getrennte Bausteine erlauben, Sicherheit (Validierung, Auth, Logging) als Querschnitt an einer
   Stelle einzuziehen und einzelne Teile zu testen und zu ändern, ohne das Ganze zu gefährden.
   **EN:** Clearly separated blocks let you add security (validation, auth, logging) as a cross-cutting layer
   in one place and test and change individual parts without endangering the whole.

   </details>

4. **DE:** (SI) Welche Betriebsannahme (z. B. Logziel, Konfiguration) gehört in den Systemkontext? /
   **EN:** (SI) Which operational assumption (e.g. log target, configuration) belongs in the system context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Auch das Logziel, die Konfigurationsquelle und die Ablage der Persistenz sind Nachbarn mit Grenzen.
   Sie müssen im Kontext stehen, weil dort Secrets, Schreibrechte und Datenschutz betroffen sind.
   **EN:** The log target, the configuration source, and the persistence storage are also neighbours with
   boundaries. They must appear in the context because secrets, write rights, and privacy are affected there.

   </details>

5. **DE:** (DPA) Warum ist der Schutzbedarf nicht für alle Komponenten gleich? /
   **EN:** (DPA) Why is the protection need not the same for all components?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Personenbezogene Fallnotizen brauchen hohe Vertraulichkeit, ein Hilfetext fast keine. Getrennte
   Bewertung zeigt, wo zuerst investiert wird und welche Daten besonders sparsam behandelt werden.
   **EN:** Personal case notes need high confidentiality, a help text almost none. A separate assessment shows
   where to invest first and which data must be treated especially sparingly.

   </details>

6. **DE:** Warum darf man eine Framework-Wahl nicht ohne Begründung treffen? /
   **EN:** Why must a framework choice not be made without a rationale?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Lösung soll für alle sechs Sprachen vergleichbar bleiben. Eine begründete Wahl macht Folgen und
   Alternativen sichtbar und verhindert eine versteckte Bindung an ein Werkzeug.
   **EN:** The solution must stay comparable across all six languages. A justified choice makes consequences and
   alternatives visible and prevents a hidden lock-in to one tool.

   </details>

7. **DE:** Warum ist die Aussage „das System ist sicher“ ohne Nachweis problematisch? /
   **EN:** Why is the claim "the system is secure" problematic without evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Positive Sicherheitsbehauptungen brauchen Nachweise (Test, Review, N/A-Begründung). Ohne Beleg ist
   die Aussage nur eine Hoffnung und kann im Audit nicht bestehen.
   **EN:** Positive security claims need evidence (test, review, N/A rationale). Without proof the statement is
   just a hope and cannot hold up in an audit.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Systemkontext mit allen Nachbarn als Text oder Tabelle beschreiben.
- [ ] alle Vertrauensgrenzen des Systems benennen.
- [ ] das System in wenige klare Komponenten mit je einer Aufgabe teilen.
- [ ] mindestens einen ADR-Kandidaten mit Grund, Alternative und Folge notieren.
- [ ] den Schutzbedarf je Komponente unterscheiden und begründen.

**EN:** I can …

- [ ] describe a system context with all neighbours as text or a table.
- [ ] name all trust boundaries of the system.
- [ ] split the system into a few clear components each with one task.
- [ ] note at least one ADR candidate with rationale, alternative, and consequence.
- [ ] distinguish and justify the protection need per component.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
