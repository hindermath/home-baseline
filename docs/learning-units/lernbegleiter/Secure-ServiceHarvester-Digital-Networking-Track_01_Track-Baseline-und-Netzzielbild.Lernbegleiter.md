# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 01 – Track-Baseline und Netzzielbild / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester sammelt Statusdaten von vielen Maschinen. In den Jahren 1 und 2 (v2) hast
du den Dienst selbst gebaut: Modell, Validierung, Persistenz, API, Betrieb. Jetzt, im DV-Track des 3.
Lehrjahres, wechselt der Blick von *einem* Dienst auf das *Netz*, in dem verteilt gesammelt wird. Die erste
Einheit legt die **Track-Baseline** fest (was aus v2 vorhanden ist) und übersetzt sie in ein **Netzzielbild**:
Welche Schutzziele hat das Netz? Wo liegen grobe Vertrauenszonen? Welche Verfügbarkeit ist gefordert?

**EN:** The Secure ServiceHarvester collects status data from many machines. In years 1 and 2 (v2) you built
the service itself: model, validation, persistence, API, operations. Now, in the Digital Networking Track of
year 3, the focus shifts from *one* service to the *network* in which collection happens in a distributed
way. This first unit records the **track baseline** (what exists from v2) and translates it into a **network
target picture**: which protection goals does the network have? Where are coarse trust zones? Which
availability is required?

**DE:** Ein häufiger Fehler ist, sofort über Firewalls, Ports und Zertifikate zu reden. Zuerst braucht es ein
klares Zielbild: *Was* soll das Netz leisten und *welche Sicherheit* ist das Ziel. Ohne Zielbild lassen sich
spätere Architekturentscheidungen nicht begründen. Die C#-Referenz `InventarWorkerService` zeigt beispielhaft
einen langlaufenden Sammel-Dienst; die Aufgabe bleibt sprachneutral.

**EN:** A common mistake is to talk immediately about firewalls, ports, and certificates. First you need a
clear target picture: *what* the network should achieve and *which security* is the goal. Without a target
picture, later architecture decisions cannot be justified. The C# reference `InventarWorkerService` shows an
example of a long-running collection service; the task stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Track-Baseline / Track baseline | Der dokumentierte Ausgangsstand aus Jahr 2 (v2), auf dem der DV-Track aufbaut. |
| Netzzielbild / Network target picture | Beschreibung, was das Netz leisten soll und welche Sicherheit angestrebt wird. |
| Verteiltes Sammeln / Distributed collection | Statusdaten werden von vielen Knoten über das Netz zu einem Sammler geführt. |
| Schutzziele (CIA) / Protection goals | Vertraulichkeit, Integrität und Verfügbarkeit von Daten und Diensten. |
| Vertrauenszone / Trust zone | Bereich mit gleichem Vertrauensniveau; Grenzen dazwischen werden geprüft. |
| Verfügbarkeitsziel / Availability target | Messbare Vorgabe, wie zuverlässig der Dienst erreichbar sein soll (z. B. SLO). |
| Nachweispfad / Evidence path | Ort und Form, an dem eine Aussage belegt wird (z. B. Tabelle, Testbericht). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Track-Baseline festhalten.** Schreibe kurz auf, was aus v2 vorliegt: ein langlaufender
Sammel-Dienst mit Modell, Validierung, Persistenz und API. Diese Baseline ist der Startpunkt; du entwickelst
sie nicht neu, sondern vernetzt sie sicher.

**EN:** **Step 1 – Record the track baseline.** Briefly write down what exists from v2: a long-running
collection service with model, validation, persistence, and API. This baseline is the starting point; you do
not rebuild it, you network it securely.

**DE:** **Schritt 2 – Netz-Schutzziele benennen.** Ordne den drei Schutzzielen konkrete Aussagen zu.
Vertraulichkeit: Wer darf gesammelte Daten sehen? Integrität: Warum wäre ein gefälschter Status gefährlich?
Verfügbarkeit: Was passiert, wenn der Sammler nicht erreichbar ist? Trenne die drei bewusst, weil sie
verschiedene Maßnahmen nach sich ziehen.

**EN:** **Step 2 – Name network protection goals.** Assign concrete statements to the three protection goals.
Confidentiality: who may see collected data? Integrity: why would a forged status be dangerous? Availability:
what happens if the collector is unreachable? Separate the three deliberately, because they lead to different
measures.

**DE:** **Schritt 3 – Grobe Vertrauenszonen skizzieren.** Teile das Bild in wenige Zonen: Sammel-Agenten auf
den Maschinen, den Sammler-Dienst, die Datenhaltung und die Auswertung. Es geht noch nicht um genaue Regeln,
sondern um die Frage: Wo wechselt Vertrauen? Diese groben Zonen leiten die spätere Segmentierung (Einheit 04).

**EN:** **Step 3 – Sketch coarse trust zones.** Divide the picture into a few zones: collection agents on the
machines, the collector service, data storage, and analytics. It is not yet about exact rules, but about the
question: where does trust change? These coarse zones guide the later segmentation (unit 04).

**DE:** **Schritt 4 – Verfügbarkeitsziele setzen.** Ein Netz ist nur nützlich, wenn es zuverlässig ist. Lege
ein einfaches, messbares Ziel fest, etwa: „Der Sammler ist zu 99 % der Arbeitszeit erreichbar; ein
verpasster Sammellauf wird später nachgeholt." Solche Ziele machen spätere Resilienzentscheidungen
begründbar.

**EN:** **Step 4 – Set availability targets.** A network is only useful if it is reliable. Define a simple,
measurable target, e.g.: "the collector is reachable during 99 % of working time; a missed collection run is
caught up later." Such targets make later resilience decisions justifiable.

**DE:** **Schritt 5 – Scope, Nicht-Ziele und Nachweise trennen.** Sage klar, was der DV-Track behandelt
(sichere Vernetzung) und was nicht (z. B. neue fachliche Sammelfelder). Für jede Sicherheits- oder
Verfügbarkeitsaussage nennst du einen Nachweispfad. Nicht anwendbare Standards notierst du als `N/A` mit
kurzer Begründung, statt sie wegzulassen.

**EN:** **Step 5 – Separate scope, non-goals, and evidence.** State clearly what the Digital Networking Track
covers (secure networking) and what not (e.g. new functional collection fields). For each security or
availability claim, name an evidence path. Non-applicable standards are noted as `N/A` with a short
justification instead of being omitted.

**DE:** **Typische Fehler.** Sofort in Technikdetails springen. Baseline und Zielbild vermischen. Nur über
Vertraulichkeit reden und Verfügbarkeit vergessen. Verfügbarkeitsziele ohne Messgröße formulieren.
Sicherheitsaussagen ohne Nachweis.

**EN:** **Common mistakes.** Jumping straight into technical details. Mixing baseline and target picture.
Talking only about confidentiality and forgetting availability. Formulating availability targets without a
metric. Security claims without evidence.

### Beispiel / Example

```text
Track-Baseline (v2):  langlaufender Sammel-Dienst mit Modell, Validierung, Persistenz, API (Referenz: InventarWorkerService)

Netz-Schutzziele:
  Vertraulichkeit = mittel  (Statusdaten sind intern; keine personenbezogenen Inhalte)
  Integritaet     = hoch    (falscher Status -> falsche Betriebsentscheidung)
  Verfuegbarkeit  = hoch    (Sammler muss zuverlaessig erreichbar sein)

Grobe Vertrauenszonen: [Sammel-Agenten] -> [Sammler-Dienst] -> [Datenhaltung] -> [Auswertung]
Verfuegbarkeitsziel:   Sammler zu 99 % der Arbeitszeit erreichbar; verpasster Lauf wird nachgeholt
Nicht-Ziel:            neue fachliche Sammelfelder; UI-Redesign
Nachweis:              Verfuegbarkeits-Testprotokoll -> Folgeeinheiten
N/A:                   Endkundenexposition N/A (rein internes Netz) -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Netz-Schutzziele, Vertrauenszonen und Verfügbarkeit sind Kern des sicheren Netzbetriebs. |
| LF 10d Cyber-physische Systeme entwickeln | Berührt / Touched | Das Netzzielbild ist die Grundlage der späteren Entwicklung des vernetzten Systems. |
| LF 12d Kundenspezifisches cyber-physisches System optimieren | Berührt / Touched | Baseline und Zielbild bereiten spätere Optimierungs- und Trade-off-Entscheidungen vor. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Verfügbarkeitsziele und Zonen greifen die Bereitstellung von Netz und Dienst auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries, Verfügbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_04` (Bedrohungsmodellierung) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser
Einheit lautet: *Das Netzzielbild legt Schutzziele, Zonen und Verfügbarkeit fest, bevor eine einzige
technische Regel entsteht; jede Aussage erhält einen Nachweispfad.* A11Y-Aspekt: Schutzziel- und Zonentabellen
müssen als klarer Text mit Kopfzeile lesbar sein, ohne reine Farbmarkierung, damit sie mit Screenreader oder
Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, availability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design),
`CL_04` (threat modeling), and `CL_12` (evidence and closure). The security decision of this unit is: *the
network target picture defines protection goals, zones, and availability before any technical rule exists;
every claim gets an evidence path.* Accessibility aspect: protection-goal and zone tables must be readable as
clear text with a header row, without color-only marking, so they stay usable with a screen reader or Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt der DV-Track die Track-Baseline vom Netzzielbild? /
   **EN:** Why does the Digital Networking Track separate the track baseline from the network target picture?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Baseline sagt, was aus v2 schon existiert; das Netzzielbild sagt, was das Netz künftig leisten
   und wie sicher es sein soll. Getrennt bleibt sichtbar, worauf man aufbaut und was neu zu entscheiden ist.
   **EN:** The baseline says what already exists from v2; the target picture says what the network should
   achieve and how secure it should be. Kept separate, it stays visible what you build on and what is newly
   to be decided.

   </details>

2. **DE:** (DV) Warum ist es wichtig, grobe Vertrauenszonen schon vor konkreten Regeln zu skizzieren? /
   **EN:** (DV) Why is it important to sketch coarse trust zones before concrete rules?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Zonen zeigen, wo Vertrauen wechselt, und geben der späteren Segmentierung und
   Transportsicherheit einen Rahmen. Ohne Zonen entstehen Einzelregeln ohne roten Faden und die Angriffsfläche
   bleibt unklar.
   **EN:** The zones show where trust changes and give later segmentation and transport security a frame.
   Without zones, isolated rules emerge without a common thread and the attack surface stays unclear.

   </details>

3. **DE:** Warum ist Integrität bei Statusdaten oft ein besonders hohes Schutzziel? /
   **EN:** Why is integrity often an especially high protection goal for status data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus Statusdaten werden Betriebsentscheidungen abgeleitet. Ein gefälschter oder falscher Status führt
   direkt zu falschen Entscheidungen, daher zählt die Unverfälschtheit stark.
   **EN:** Operational decisions are derived from status data. A forged or wrong status leads directly to wrong
   decisions, so integrity matters strongly.

   </details>

4. **DE:** (SI) Wie formuliert man ein Verfügbarkeitsziel so, dass es nachweisbar ist? /
   **EN:** (SI) How do you formulate an availability target so it is verifiable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einer messbaren Größe und Zeitbezug, etwa „zu 99 % der Arbeitszeit erreichbar". Nachweis: ein
   Erreichbarkeits- oder Verfügbarkeitsprotokoll. Ohne Messgröße ist das Ziel nicht prüfbar.
   **EN:** With a measurable metric and time reference, e.g. "reachable during 99 % of working time".
   Evidence: a reachability or availability log. Without a metric the target cannot be checked.

   </details>

5. **DE:** (DPA) Welche Datenschutzfrage sollte schon im Netzzielbild geklärt werden? /
   **EN:** (DPA) Which privacy question should already be clarified in the network target picture?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ob und welche personenbezogenen oder sensiblen Datenklassen überhaupt über das Netz fließen. Das
   entscheidet über Vertraulichkeitsziel, Verschlüsselung und engere Pfade in späteren Einheiten.
   **EN:** Whether and which personal or sensitive data classes flow over the network at all. That decides the
   confidentiality goal, encryption, and tighter paths in later units.

   </details>

6. **DE:** Warum dokumentiert man einen nicht anwendbaren Standard als `N/A` statt ihn wegzulassen? /
   **EN:** Why document a non-applicable standard as `N/A` instead of omitting it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `N/A` mit kurzer Begründung zeigt, dass der Standard geprüft wurde und bewusst nicht gilt. Stilles
   Weglassen sieht aus wie Vergessen und ist nicht auditfähig.
   **EN:** `N/A` with a short justification shows the standard was checked and deliberately does not apply.
   Silent omission looks like forgetting and is not audit-ready.

   </details>

7. **DE:** (AE) Welche Folge hat das Netzzielbild für spätere Schnittstellenentscheidungen? /
   **EN:** (AE) What consequence does the network target picture have for later interface decisions?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Schutzziele und Zonen geben vor, welche Schnittstellen überhaupt erlaubt sind, in welche Richtung
   sie sprechen dürfen und welche Datenklasse sie tragen. Der Schnittstellenvertrag folgt dem Zielbild, nicht
   umgekehrt.
   **EN:** Protection goals and zones dictate which interfaces are allowed at all, in which direction they may
   talk, and which data class they carry. The interface contract follows the target picture, not the other
   way around.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Track-Baseline aus v2 in wenigen Sätzen zusammenfassen.
- [ ] die drei Netz-Schutzziele mit konkreten Aussagen belegen.
- [ ] grobe Vertrauenszonen des verteilten Sammelns skizzieren.
- [ ] ein messbares Verfügbarkeitsziel formulieren.
- [ ] Scope, Nicht-Ziele und Nachweispfade trennen.
- [ ] einen nicht anwendbaren Standard als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] summarize the v2 track baseline in a few sentences.
- [ ] back the three network protection goals with concrete statements.
- [ ] sketch coarse trust zones of the distributed collection.
- [ ] formulate a measurable availability target.
- [ ] separate scope, non-goals, and evidence paths.
- [ ] document a non-applicable standard as `N/A` with justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md`. Danach
führt Einheit 02 (`Systemkontext und Maschinen-/Netzbezüge`) das grobe Zielbild in einen genauen Systemkontext
weiter. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md`.
Afterwards, unit 02 (`system context and machine/network relations`) develops the coarse target picture into a
precise system context. The copy-paste prompt for a later, manually started Spec Kit run is provided in the
intake.
