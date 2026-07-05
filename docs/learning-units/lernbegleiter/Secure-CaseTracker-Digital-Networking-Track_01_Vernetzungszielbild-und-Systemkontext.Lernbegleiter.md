# Lernbegleiter: Secure CaseTracker Digital Networking Track 01 – Vernetzungszielbild und Systemkontext / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_01_Vernetzungszielbild-und-Systemkontext.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bevor man ein vernetztes System baut, muss man wissen, *wo es steht*. Der Secure CaseTracker läuft
im dritten Lehrjahr nicht mehr allein auf einem Rechner, sondern spricht mit anderen Systemen: einem
Fachdienst, einer Datenbank, vielleicht einem Monitoring-Sammler. Der **Systemkontext** ist die Landkarte,
die zeigt, welche Beteiligten, Knoten und Schnittstellen es gibt und wo die Grenze des eigenen Systems
verläuft. Ohne diese Landkarte plant man ins Blaue und übersieht genau die Übergänge, an denen später
Sicherheitsprobleme entstehen.

**EN:** Before you build a networked system, you must know *where it sits*. In the third training year the
Secure CaseTracker no longer runs alone on one machine; it talks to other systems: a business service, a
database, maybe a monitoring collector. The **system context** is the map that shows which stakeholders,
nodes, and interfaces exist and where the boundary of your own system runs. Without this map you plan
blindly and miss exactly the crossings where security problems later appear.

**DE:** In dieser Einheit lernst du, den Systemkontext des vernetzten CaseTracker abzugrenzen: beteiligte
Systeme und Rollen benennen, Knoten und Schnittstellen auflisten, Datenarten unterscheiden, Nicht-Ziele
festhalten und erste Vertrauensgrenzen markieren. Ein sauberer Kontext ist die Grundlage für Topologie,
Segmentierung und Bedrohungsmodell in den späteren Einheiten.

**EN:** In this unit you learn to scope the system context of the networked CaseTracker: name the involved
systems and roles, list nodes and interfaces, distinguish data classes, record non-goals, and mark the first
trust boundaries. A clean context is the foundation for topology, segmentation, and the threat model in
later units.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Systemkontext / System context | Landkarte der Beteiligten, Nachbarsysteme und Schnittstellen rund um das eigene System. |
| Knoten / Node | Ein Gerät, Dienst oder Prozess im Netz, der Daten sendet oder empfängt. |
| Schnittstelle / Interface | Vereinbarter Übergang, über den zwei Systeme Daten austauschen. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossene Funktion oder Grenze, die das System nicht abdeckt. |
| Datenart / Data class | Kategorie von Daten (z. B. personenbezogen, Betriebsdaten, Secrets) mit eigenem Schutzbedarf. |
| Vertrauensgrenze / Trust boundary | Übergang, an dem nicht vertrauenswürdige Daten in einen geschützteren Bereich gelangen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Beteiligte und Rollen benennen.** Wer nutzt oder betreibt das System? Sachbearbeitung,
Administration, ein technischer Dienst, ein Monitoring-Team. Jede Rolle hat eigene Erwartungen und eigene
Rechte. Was du nicht benennst, kannst du später nicht schützen oder begrenzen.

**EN:** **Step 1 – Name stakeholders and roles.** Who uses or operates the system? Case workers,
administration, a technical service, a monitoring team. Each role has its own expectations and its own
rights. What you do not name, you cannot later protect or limit.

**DE:** **Schritt 2 – Knoten und Nachbarsysteme auflisten.** Zeichne das eigene System in die Mitte und die
Nachbarn ringsum: Datenbankknoten, Fachdienst, Import-Quelle, Monitoring-Sammler. Für jeden Nachbarn hältst
du fest, ob er innerhalb oder außerhalb deiner Verantwortung liegt. Genau an dieser Linie beginnt eine
Vertrauensgrenze.

**EN:** **Step 2 – List nodes and neighbor systems.** Draw your own system in the center and the neighbors
around it: database node, business service, import source, monitoring collector. For each neighbor you
record whether it lies inside or outside your responsibility. Exactly on this line a trust boundary begins.

**DE:** **Schritt 3 – Datenarten trennen.** Nicht alle Daten sind gleich schützenswert. Trenne
personenbezogene Falldaten, reine Betriebsdaten (z. B. Zählwerte) und Secrets (z. B. Zugangsschlüssel).
Warum? Der Schutzbedarf steuert später Segmentierung, Verschlüsselung und Protokollierung. Wer alles
gleich behandelt, schützt entweder zu wenig oder verschwendet Aufwand.

**EN:** **Step 3 – Separate data classes.** Not all data deserves the same protection. Separate personal
case data, plain operational data (e.g. counters), and secrets (e.g. access keys). Why? The protection need
later drives segmentation, encryption, and logging. Treating everything the same either underprotects or
wastes effort.

**DE:** **Schritt 4 – Nicht-Ziele festhalten.** Ein guter Kontext sagt auch, was das System *nicht* tut:
keine Fernwartung des Fachdienstes, kein direkter Internetzugang, keine Speicherung echter Personendaten in
der Übung. Nicht-Ziele verhindern schleichende Ausweitung (Scope Creep) und machen spätere Reviews
ehrlich.

**EN:** **Step 4 – Record non-goals.** A good context also states what the system does *not* do: no remote
maintenance of the business service, no direct internet access, no storage of real personal data in the
exercise. Non-goals prevent scope creep and keep later reviews honest.

**DE:** **Schritt 5 – Erste Vertrauensgrenzen markieren.** Ziehe an jeder Systemgrenze eine Linie und
notiere, welche Datenart sie kreuzt. Diese ersten Grenzen sind noch grob, aber sie zeigen, wo in Einheit 03
segmentiert und in Einheit 08 bedroht wird.

**EN:** **Step 5 – Mark first trust boundaries.** Draw a line at each system boundary and note which data
class crosses it. These first boundaries are still coarse, but they show where unit 03 will segment and
unit 08 will threat-model.

**DE:** **Typische Fehler.** Nur die eigene Anwendung zeichnen und die Nachbarn vergessen. Alle Daten als
„irgendwie wichtig" behandeln, ohne Datenarten zu trennen. Nicht-Ziele weglassen und dadurch später alles
begründen zu müssen. Vertrauensgrenzen erst im Code entdecken statt im Kontext.

**EN:** **Common mistakes.** Drawing only your own application and forgetting the neighbors. Treating all
data as "somehow important" without separating data classes. Omitting non-goals and thus having to justify
everything later. Discovering trust boundaries only in the code instead of in the context.

### Beispiel / Example

```text
Systemkontext (Auszug):
  Eigenes System:   Secure CaseTracker (vernetzter Betrieb)
  Nachbar 1:        Fachdienst (extern)      Datenart: personenbezogene Falldaten
  Nachbar 2:        Datenbankknoten (intern) Datenart: personenbezogene Falldaten
  Nachbar 3:        Monitoring-Sammler       Datenart: Betriebsdaten (Zählwerte)

Nicht-Ziele:
  - Keine Speicherung echter Personendaten in der Übung
  - Kein direkter Internetzugang des CaseTracker

Erste Vertrauensgrenze:
  Zwischen Fachdienst (extern) und CaseTracker -> kreuzt personenbezogene Falldaten -> Prüfung nötig
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10d Cyber-physische Systeme entwickeln | Primär / Primary | Das Vernetzungszielbild und der Systemkontext sind der erste Entwicklungsschritt eines vernetzten, cyber-physischen Systems. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Knoten, Nachbarsysteme und Systemgrenzen greifen die Grundlagen der Netzeinbindung auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries und Datenschutz.
Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design), `CL_04`
(Bedrohungsmodellierung) und `CL_12` (Abschluss/Evidenz). Die Sicherheitsentscheidung dieser Einheit lautet:
*Jede Systemgrenze wird als Vertrauensgrenze erkannt, bevor Daten sie kreuzen.* A11Y-Aspekt: Der
Systemkontext muss auch ohne Bild verständlich sein. Eine textbasierte Knoten- und Grenzliste (wie im
Beispiel) ist für Screenreader und Braille-Zeile lesbar; ein reines Farbdiagramm wäre es nicht.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, and privacy.
Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design), `CL_04` (threat
modeling), and `CL_12` (closeout/evidence). The security decision of this unit is: *every system boundary is
recognized as a trust boundary before data crosses it.* Accessibility aspect: the system context must be
understandable without a picture. A text-based node and boundary list (as in the example) is readable with a
screen reader or Braille display; a color-only diagram would not be.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist der Systemkontext die Grundlage für spätere Topologie und Segmentierung? /
   **EN:** Why is the system context the foundation for later topology and segmentation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Kontext benennt Beteiligte, Knoten, Datenarten und Grenzen. Topologie und Segmentierung
   verfeinern genau diese Grenzen. Fehlt ein Knoten im Kontext, fehlt er auch in Segmentierung und
   Bedrohungsmodell.
   **EN:** The context names stakeholders, nodes, data classes, and boundaries. Topology and segmentation
   refine exactly these boundaries. A node missing in the context is also missing in segmentation and threat
   model.

   </details>

2. **DE:** Was unterscheidet einen internen von einem externen Knoten, und warum ist das sicherheitsrelevant? /
   **EN:** What distinguishes an internal from an external node, and why is that security-relevant?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein interner Knoten liegt in der eigenen Verantwortung und Kontrolle, ein externer nicht. An der
   Linie dazwischen liegt eine Vertrauensgrenze; Daten von außen gelten zunächst als nicht vertrauenswürdig.
   **EN:** An internal node is within your own responsibility and control, an external one is not. On the
   line between them lies a trust boundary; data from outside is initially untrusted.

   </details>

3. **DE:** Warum werden Datenarten getrennt, statt alle Daten gleich zu behandeln? /
   **EN:** Why separate data classes instead of treating all data the same?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Schutzbedarf steuert Segmentierung, Verschlüsselung und Protokollierung. Personenbezogene
   Daten und Secrets brauchen mehr Schutz als reine Zählwerte. Gleichbehandlung schützt zu wenig oder
   verschwendet Aufwand.
   **EN:** The protection need drives segmentation, encryption, and logging. Personal data and secrets need
   more protection than plain counters. Equal treatment underprotects or wastes effort.

   </details>

4. **DE:** Welchen Nutzen haben klar benannte Nicht-Ziele im Systemkontext? /
   **EN:** What benefit do clearly named non-goals bring in the system context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie verhindern schleichende Ausweitung (Scope Creep), machen Reviews ehrlich und sparen Aufwand,
   weil ausgeschlossene Funktionen nicht abgesichert werden müssen.
   **EN:** They prevent scope creep, keep reviews honest, and save effort, because excluded functions do not
   need to be secured.

   </details>

5. **DE:** (DV) Wie hängt die Netzeinbindung eines Clients mit dem Systemkontext zusammen? /
   **EN:** (DV) How does connecting a client to the network relate to the system context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder eingebundene Client wird zu einem Knoten mit einer Schnittstelle und einer Datenart. Der
   Kontext zeigt, ob der Client innen oder außen liegt und welche Vertrauensgrenze er kreuzt.
   **EN:** Every connected client becomes a node with an interface and a data class. The context shows
   whether the client is inside or outside and which trust boundary it crosses.

   </details>

6. **DE:** Warum sollte der Systemkontext textbasiert und nicht nur als Farbdiagramm vorliegen? /
   **EN:** Why should the system context exist in text form and not only as a color diagram?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine textbasierte Knoten- und Grenzliste ist mit Screenreader und Braille-Zeile lesbar und
   erfüllt WCAG 2.2 AA. Ein reines Farbdiagramm schließt Menschen aus und ist nicht barrierefrei.
   **EN:** A text-based node and boundary list is readable with a screen reader and Braille display and meets
   WCAG 2.2 AA. A color-only diagram excludes people and is not accessible.

   </details>

7. **DE:** Warum wird ein noch nicht geklärter Nachbar besser als `Open` markiert als weggelassen? /
   **EN:** Why is an unclarified neighbor better marked as `Open` than left out?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein weggelassener Knoten wird stillschweigend als sicher angenommen. Ein `Open`-Eintrag macht die
   Wissenslücke sichtbar und erzwingt eine Folgeaktion.
   **EN:** An omitted node is silently assumed safe. An `Open` entry makes the knowledge gap visible and
   forces a follow-up action.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Beteiligte, Rollen und Nachbarsysteme des vernetzten CaseTracker benennen.
- [ ] jeden Knoten als intern oder extern einordnen und die Grenze begründen.
- [ ] Datenarten mit unterschiedlichem Schutzbedarf trennen.
- [ ] Nicht-Ziele festhalten und ihren Nutzen erklären.
- [ ] erste Vertrauensgrenzen markieren und je Grenze die gekreuzte Datenart nennen.

**EN:** I can …

- [ ] name stakeholders, roles, and neighbor systems of the networked CaseTracker.
- [ ] classify each node as internal or external and justify the boundary.
- [ ] separate data classes with different protection needs.
- [ ] record non-goals and explain their benefit.
- [ ] mark first trust boundaries and name the data class crossing each one.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_01_Vernetzungszielbild-und-Systemkontext.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_01_Vernetzungszielbild-und-Systemkontext.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
