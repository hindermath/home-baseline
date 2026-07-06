# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 04 – Segmentierung und Vertrauenszonen / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Kommunikationsmatrix aus Einheit 03 sagt, *welche* Verbindungen erlaubt und verboten sind. Jetzt
teilst du das Netz in **Vertrauenszonen** und **Segmente**: Bereiche, die unterschiedlich schützenswert sind und
zwischen denen der Verkehr kontrolliert fließt. Die Sammel-Agenten, der Sammler-Dienst, die Datenhaltung und die
Auswertung gehören nicht in einen Topf – jede Gruppe ist ein eigenes Segment. Der Grundgedanke ist **deny by
default**: Zwischen Segmenten ist nichts erlaubt, außer es ist ausdrücklich und mit minimalen Rechten (**least
privilege**) freigegeben. Kontrollierter Verkehr fließt nur über wenige, bewusst gewählte **Choke Points**.

**EN:** The communication matrix from unit 03 says *which* connections are allowed and forbidden. Now you divide
the network into **trust zones** and **segments**: areas with different protection needs, between which traffic
flows in a controlled way. The collection agents, the collector service, the data storage, and the analytics do
not belong together – each group is its own segment. The core idea is **deny by default**: between segments
nothing is allowed unless it is explicitly and with minimal rights (**least privilege**) permitted. Controlled
traffic flows only through few, deliberately chosen **choke points**.

**DE:** In dieser Einheit lernst du, Segmentgrenzen aus der Kommunikationsmatrix abzuleiten, deny-by-default- und
least-privilege-Regeln zwischen Segmenten zu formulieren, Choke Points zu begründen und Datenklassen dem richtigen
Segment zuzuordnen. Die C#-Referenz `InventarWorkerService` dient als Orientierung; die Lösung bleibt
sprachneutral.

**EN:** In this unit you learn to derive segment boundaries from the communication matrix, to formulate
deny-by-default and least-privilege rules between segments, to justify choke points, and to map data classes to
the right segment. The C# reference `InventarWorkerService` serves as orientation; the solution stays
language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Vertrauenszone / Trust zone | Netzbereich mit einheitlichem Schutzbedarf und Vertrauensniveau. |
| Segment / Segment | Abgegrenzter Netzabschnitt, der andere Bereiche nicht ungefragt erreicht. |
| Deny by default / Deny by default | Grundregel: alles verboten, außer es ist ausdrücklich erlaubt. |
| Least Privilege / Least privilege | Jede Verbindung erhält nur die minimal nötigen Rechte. |
| Choke Point / Choke point | Kontrollierter Übergang, über den erlaubter Verkehr zwischen Segmenten fließt. |
| Datenklasse / Data class | Einstufung von Daten nach Schutzbedarf (z. B. sensibel, Betriebsdaten, Secret). |
| Blast-Radius / Blast radius | Reichweite eines Schadens, wenn ein Segment kompromittiert wird. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Vertrauenszonen bilden.** Gruppiere die Knoten aus Einheit 02/03 nach Schutzbedarf und
Vertrauen: Sammel-Agenten (viele, außen, wenig vertraut), Sammler-Dienst (zentral), Datenhaltung (sensibel),
Auswertung (lesend). Knoten mit ähnlichem Schutzbedarf und ähnlicher Aufgabe bilden eine Zone.

**EN:** **Step 1 – Form trust zones.** Group the nodes from units 02/03 by protection need and trust: collection
agents (many, outside, little trusted), collector service (central), data storage (sensitive), analytics
(read-only). Nodes with similar protection need and similar task form a zone.

**DE:** **Schritt 2 – Segmentgrenzen aus der Matrix ableiten.** Die erlaubten und verbotenen Verbindungen aus
Einheit 03 zeigen dir die natürlichen Grenzen. Wo kein erlaubter Fluss besteht, gehört eine Segmentgrenze hin.
Die Auswertung darf nicht direkt auf die Agenten zugreifen – also liegt zwischen ihnen eine Grenze.

**EN:** **Step 2 – Derive segment boundaries from the matrix.** The allowed and forbidden connections from unit 03
show you the natural boundaries. Where no allowed flow exists, a segment boundary belongs. Analytics must not
access the agents directly – so a boundary lies between them.

**DE:** **Schritt 3 – Deny by default und least privilege festlegen.** Formuliere je Segmentgrenze eine Regel, die
im Grundzustand alles verbietet und nur die nötigen Flüsse ausdrücklich erlaubt. Least privilege heißt: nicht „das
ganze Datenhaltungs-Segment", sondern „nur der Sammler-Dienst darf in die Datenhaltung schreiben, nur die
Auswertung darf lesen". Je enger die Regel, desto kleiner die Angriffsfläche.

**EN:** **Step 3 – Set deny by default and least privilege.** For each segment boundary, formulate a rule that
forbids everything by default and explicitly allows only the necessary flows. Least privilege means: not "the
whole storage segment", but "only the collector service may write to storage, only analytics may read". The
tighter the rule, the smaller the attack surface.

**DE:** **Schritt 4 – Choke Points begründen.** Statt vieler direkter Verbindungen lässt du erlaubten Verkehr über
wenige, kontrollierte Übergänge laufen. Ein Choke Point ist ein Ort, an dem man Verkehr prüfen, protokollieren und
im Ernstfall abschalten kann. Weniger Übergänge bedeuten weniger Stellen, die man absichern und überwachen muss.

**EN:** **Step 4 – Justify choke points.** Instead of many direct connections, you route allowed traffic through
few, controlled crossings. A choke point is a place where you can inspect, log, and, in an emergency, shut off
traffic. Fewer crossings mean fewer places to secure and monitor.

**DE:** **Schritt 5 – Datenklassen den Segmenten zuordnen.** Ordne jede Datenklasse dem Segment mit passendem
Schutz zu: Sensible Daten und Secrets gehören in eng geschützte Segmente, Betriebsdaten in weniger strenge. Eine
Datenklasse, die ein eigenes, engeres Segment verlangt, wird nicht mit weniger schützenswerten Daten vermischt.
Das begrenzt den **Blast-Radius**: Fällt ein Segment aus oder wird kompromittiert, bleibt der Schaden lokal.

**EN:** **Step 5 – Map data classes to segments.** Assign each data class to the segment with matching protection:
sensitive data and secrets belong in tightly protected segments, operational data in less strict ones. A data
class that requires its own tighter segment is not mixed with less sensitive data. This limits the **blast
radius**: if a segment fails or is compromised, the damage stays local.

**DE:** **Typische Fehler.** Alles in ein flaches Netz legen. Segmentgrenzen ohne Bezug zur Kommunikationsmatrix
ziehen. Regeln erlauben statt verbieten (kein deny by default). Ganze Segmente statt einzelner Flüsse freigeben
(kein least privilege). Sensible Daten mit Betriebsdaten mischen. Annahmen als bestätigt darstellen statt als
`Open`.

**EN:** **Common mistakes.** Putting everything into one flat network. Drawing segment boundaries unrelated to the
communication matrix. Rules that allow instead of forbid (no deny by default). Permitting whole segments instead
of single flows (no least privilege). Mixing sensitive with operational data. Presenting assumptions as confirmed
instead of `Open`.

### Beispiel / Example

```text
Vertrauenszonen / Segmente:
  Z1 Agenten       (aussen, wenig vertraut, viele Knoten)
  Z2 Sammler       (zentral, vermittelt)
  Z3 Datenhaltung  (sensibel, streng geschuetzt)
  Z4 Auswertung    (lesend, aggregiert)

Segmentregel-Tabelle (deny by default):
  Quelle-Segment   Ziel-Segment    erlaubt/verboten   Recht (least privilege)
  Z1 Agenten       Z2 Sammler       erlaubt            nur Status melden (Push)
  Z2 Sammler       Z3 Datenhaltung  erlaubt            nur schreiben
  Z4 Auswertung    Z3 Datenhaltung  erlaubt            nur lesen (aggregiert)
  Z4 Auswertung    Z1 Agenten       VERBOTEN           -
  alles uebrige    alles uebrige    VERBOTEN           deny by default

Choke Point:  einziger Uebergang Z1->Z2 am Sammler-Endpunkt (pruef- und abschaltbar)
Datenklasse:  Secret nur in Z2/Z3; Beispiel-Secret nur als <PLATZHALTER-KEIN-ECHTER-WERT>
Open:         genaue Regel fuer Admin-Zugang zu Z2 noch nicht bestaetigt -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Segmentierung und deny-by-default-Regeln sind Kern des sicheren Betriebs vernetzter Systeme. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Segmente, Choke Points und Freigaben bestimmen, wie Netzwerke und Dienste bereitgestellt werden. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Die Zuordnung der Agenten zu einer Zone greift die sichere Netzeinbindung von Clients auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, Defense in Depth, Least Privilege, Fail-Safe
Defaults und Angriffsfläche reduzieren. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_04` (Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz)
und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Segmente sind nach
Schutzbedarf getrennt, zwischen ihnen gilt deny by default mit least privilege, und erlaubter Verkehr fließt nur
über begründete Choke Points.* A11Y-Aspekt: Zonen- und Segmentregel-Tabellen müssen als echte Tabelle mit Kopfzeile
in reinem Text lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: trust boundaries, defense in depth, least privilege,
fail-safe defaults, and attack surface reduction. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling), `CL_08` (security code review), `CL_10` (data protection), and
`CL_12` (evidence and closure). The security decision of this unit is: *segments are separated by protection need,
between them deny by default with least privilege applies, and allowed traffic flows only through justified choke
points.* Accessibility aspect: zone and segment-rule tables must be readable as a real table with a header row in
plain text, without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was bedeutet „deny by default" zwischen zwei Segmenten? /
   **EN:** (DV) What does "deny by default" mean between two segments?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Im Grundzustand ist jeder Verkehr zwischen den Segmenten verboten. Nur ausdrücklich benannte Flüsse
   werden erlaubt. Alles, was nicht freigegeben ist, bleibt blockiert.
   **EN:** By default all traffic between the segments is forbidden. Only explicitly named flows are allowed.
   Everything not permitted stays blocked.

   </details>

2. **DE:** (DV) Wie leitest du eine Segmentgrenze aus der Kommunikationsmatrix ab? /
   **EN:** (DV) How do you derive a segment boundary from the communication matrix?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wo zwischen zwei Knotengruppen kein erlaubter Fluss besteht (oder ein Fluss ausdrücklich verboten ist),
   gehört eine Segmentgrenze hin. Die Matrix zeigt die natürlichen Trennlinien.
   **EN:** Where no allowed flow exists between two node groups (or a flow is explicitly forbidden), a segment
   boundary belongs. The matrix shows the natural dividing lines.

   </details>

3. **DE:** Warum senkt least privilege zwischen Segmenten die Angriffsfläche? /
   **EN:** Why does least privilege between segments reduce the attack surface?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Verbindung erhält nur die minimal nötigen Rechte, z. B. nur lesen statt voller Zugriff. Ein
   kompromittiertes Segment kann dann weniger anrichten, weil seine erlaubten Wege eng begrenzt sind.
   **EN:** Each connection gets only the minimal necessary rights, e.g. read-only instead of full access. A
   compromised segment can then do less harm because its allowed paths are tightly limited.

   </details>

4. **DE:** (SI) Wozu dient ein Choke Point und wie weist man seine Wirkung nach? /
   **EN:** (SI) What is a choke point for, and how do you evidence its effect?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Choke Point bündelt erlaubten Verkehr an einem kontrollierbaren Übergang, an dem man prüfen,
   protokollieren und abschalten kann. Nachweis: eine Firewall-/Regelprüfung, die zeigt, dass nur der Choke Point
   den Übergang zulässt.
   **EN:** A choke point bundles allowed traffic at a controllable crossing where you can inspect, log, and shut
   off. Evidence: a firewall/rule check showing that only the choke point permits the crossing.

   </details>

5. **DE:** (DPA) Welche Datenklasse verlangt ein eigenes, engeres Segment und warum? /
   **EN:** (DPA) Which data class requires its own tighter segment, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sensible Daten und Secrets. Getrennt in einem eng geschützten Segment begrenzt man ihren Zugriff und den
   Blast-Radius: Ein Vorfall in einem weniger strengen Segment erreicht sie nicht automatisch.
   **EN:** Sensitive data and secrets. Separated in a tightly protected segment, you limit their access and the
   blast radius: an incident in a less strict segment does not automatically reach them.

   </details>

6. **DE:** (AE) Warum sollte eine Schnittstelle über einen definierten Choke Point statt direkt sprechen? /
   **EN:** (AE) Why should an interface speak through a defined choke point instead of directly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein definierter Übergang lässt sich prüfen, protokollieren und begrenzen. Direkte Punkt-zu-Punkt-Wege
   vermehren die Angriffsfläche und die zu überwachenden Stellen. Der Choke Point hält die Kontrolle an einem Ort.
   **EN:** A defined crossing can be inspected, logged, and limited. Direct point-to-point paths multiply the
   attack surface and the places to monitor. The choke point keeps control in one place.

   </details>

7. **DE:** Warum wird eine noch unbestätigte Segmentregel als `Open` und nicht als erledigt markiert? /
   **EN:** Why is an unconfirmed segment rule marked `Open` and not as done?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine als erledigt dargestellte, aber ungeprüfte Regel täuscht Sicherheit vor. `Open` macht die
   Unsicherheit sichtbar und erzwingt eine Bestätigung, bevor man sich auf die Grenze verlässt.
   **EN:** A rule presented as done but unverified fakes security. `Open` makes the uncertainty visible and forces
   a confirmation before you rely on the boundary.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Knoten zu Vertrauenszonen nach Schutzbedarf gruppieren.
- [ ] Segmentgrenzen aus der Kommunikationsmatrix ableiten.
- [ ] deny-by-default- und least-privilege-Regeln je Grenze formulieren.
- [ ] Choke Points begründen und ihre Kontrollwirkung benennen.
- [ ] Datenklassen dem Segment mit passendem Schutz zuordnen.
- [ ] unbestätigte Regeln als `Open` mit Folgeaktion markieren.

**EN:** I can …

- [ ] group nodes into trust zones by protection need.
- [ ] derive segment boundaries from the communication matrix.
- [ ] formulate deny-by-default and least-privilege rules per boundary.
- [ ] justify choke points and name their control effect.
- [ ] map data classes to the segment with matching protection.
- [ ] mark unconfirmed rules as `Open` with a follow-up action.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md`. Sie baut auf
Einheit 03 (`Schnittstellen und Kommunikationsflüsse`) auf; die Segment- und Zonenzuordnung ist die Grundlage für
Einheit 05 (`Transportsicherheit und Endpunkt-Authentifizierung`). Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md`. It builds on
unit 03 (`interfaces and communication flows`); the segment and zone mapping is the basis for unit 05 (`transport
security and endpoint authentication`). The copy-paste prompt for a later, manually started Spec Kit run is
provided there.
