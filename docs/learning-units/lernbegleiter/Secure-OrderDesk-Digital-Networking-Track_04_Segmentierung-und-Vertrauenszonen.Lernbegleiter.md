# Lernbegleiter: Secure OrderDesk Digital & Networking Track 04 – Segmentierung und Vertrauenszonen / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Kommunikationsmatrix aus Einheit 03 sagt, *welche* Verbindungen der Bestell-Pipeline von
Secure Trader erlaubt und verboten sind. Jetzt teilst du das Netz in **Vertrauenszonen** und **Segmente**:
Bereiche, die unterschiedlich schützenswert sind und zwischen denen der Verkehr kontrolliert fließt. Die
Bestell-Clients, die Bestellannahme und der Katalog-Dienst, die relationale Ablage (Northwind-Schema) und die
Auswertung gehören nicht in einen Topf – jede Gruppe ist ein eigenes Segment. Der Grundgedanke ist **deny by
default**: Zwischen Segmenten ist nichts erlaubt, außer es ist ausdrücklich und mit minimalen Rechten (**least
privilege**) freigegeben. Kontrollierter Verkehr fließt nur über wenige, bewusst gewählte **Choke Points**.

**EN:** The communication matrix from unit 03 says *which* connections of Secure Trader's order pipeline are
allowed and forbidden. Now you divide the network into **trust zones** and **segments**: areas with different
protection needs, between which traffic flows in a controlled way. The order clients, the order intake and
catalog service, the relational store (Northwind schema), and the analytics do not belong together – each group
is its own segment. The core idea is **deny by default**: between segments nothing is allowed unless it is
explicitly and with minimal rights (**least privilege**) permitted. Controlled traffic flows only through few,
deliberately chosen **choke points**.

**DE:** In dieser Einheit lernst du, Segmentgrenzen aus der Kommunikationsmatrix abzuleiten, deny-by-default-
und least-privilege-Regeln zwischen Segmenten zu formulieren, Choke Points zu begründen und Datenklassen dem
richtigen Segment zuzuordnen. Ein zentrales Ziel ist zu verstehen, **warum die Northwind-Datenbank nicht direkt
aus dem Internet erreichbar** sein darf, sondern hinter der Anwendungs-/API-Zone liegt. Die C#-Referenz
`InventarWorkerService` dient als Orientierung; die Lösung bleibt sprachneutral.

**EN:** In this unit you learn to derive segment boundaries from the communication matrix, to formulate
deny-by-default and least-privilege rules between segments, to justify choke points, and to map data classes to
the right segment. A central goal is to understand **why the Northwind database must not be directly reachable
from the internet** but sits behind the application/API zone. The C# reference `InventarWorkerService` serves as
orientation; the solution stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Segmentierung / Segmentation | Aufteilung des Netzes in abgegrenzte Abschnitte, die sich nicht ungefragt erreichen. |
| Vertrauenszone / Trust zone | Netzbereich mit einheitlichem Schutzbedarf und Vertrauensniveau, z. B. Client-, App- oder DB-Zone. |
| Trust Boundary / Vertrauensgrenze | Linie zwischen zwei Zonen, an der Verkehr das Vertrauensniveau wechselt und geprüft wird. |
| DMZ / DMZ | Vorgelagerte Zone zwischen Internet und internem Netz, in der nur exponierte Dienste stehen. |
| Defense in Depth / Defense in depth | Mehrere unabhängige Schutzschichten, sodass eine überwundene Grenze nicht sofort alles freigibt. |
| Least Privilege / Least privilege | Jede Verbindung erhält nur die minimal nötigen Rechte, z. B. nur lesen statt vollem Zugriff. |
| Laterale Bewegung / Lateral movement | Ausbreitung eines Angreifers von einem Segment ins nächste; Segmentgrenzen bremsen sie. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Vertrauenszonen bilden.** Gruppiere die Knoten aus Einheit 02/03 nach Schutzbedarf und
Vertrauen: die öffentliche **Client-Zone** (Bestell-Clients, aus dem Internet erreichbar, wenig vertraut), die
**Anwendungs-/API-Zone** (Bestellannahme und Katalog-Dienst, vermitteln), die **Datenbank-Zone** (Northwind mit
Orders und Customers, sensibel) und die **Auswertungs-Zone** (lesend, aggregiert). Knoten mit ähnlichem
Schutzbedarf und ähnlicher Aufgabe bilden eine Zone.

**EN:** **Step 1 – Form trust zones.** Group the nodes from units 02/03 by protection need and trust: the public
**client zone** (order clients, reachable from the internet, little trusted), the **application/API zone** (order
intake and catalog service, mediating), the **database zone** (Northwind with orders and customers, sensitive),
and the **analytics zone** (read-only, aggregated). Nodes with similar protection need and similar task form a
zone.

**DE:** **Schritt 2 – Segmentgrenzen und DMZ aus der Matrix ableiten.** Die erlaubten und verbotenen
Verbindungen aus Einheit 03 zeigen dir die natürlichen Grenzen. Wo kein erlaubter Fluss besteht, gehört eine
Segmentgrenze hin. Die Client-Zone ist aus dem Internet erreichbar und wirkt wie eine **DMZ**; die Datenbank-Zone
ist internes Netz. Der Bestell-Client darf nie direkt in die Datenbank – zwischen ihnen liegen zwei Grenzen und
die Anwendungs-/API-Zone.

**EN:** **Step 2 – Derive segment boundaries and DMZ from the matrix.** The allowed and forbidden connections from
unit 03 show you the natural boundaries. Where no allowed flow exists, a segment boundary belongs. The client zone
is reachable from the internet and acts like a **DMZ**; the database zone is internal network. The order client
must never reach the database directly – two boundaries and the application/API zone lie between them.

**DE:** **Schritt 3 – Deny by default und least privilege festlegen.** Formuliere je Segmentgrenze eine Regel,
die im Grundzustand alles verbietet und nur die nötigen Flüsse ausdrücklich erlaubt. Least privilege heißt: nicht
„die ganze Datenbank-Zone", sondern „nur die Bestellannahme darf in die Northwind-Datenbank schreiben, nur die
Auswertung darf aggregiert lesen". Je enger die Regel, desto kleiner die Angriffsfläche.

**EN:** **Step 3 – Set deny by default and least privilege.** For each segment boundary, formulate a rule that
forbids everything by default and explicitly allows only the necessary flows. Least privilege means: not "the
whole database zone", but "only order intake may write to the Northwind database, only analytics may read
aggregated". The tighter the rule, the smaller the attack surface.

**DE:** **Schritt 4 – Choke Points und Defense in Depth begründen.** Statt vieler direkter Verbindungen lässt du
erlaubten Verkehr über wenige, kontrollierte Übergänge laufen. Ein Choke Point ist ein Ort, an dem man Verkehr
prüfen, protokollieren und im Ernstfall abschalten kann – etwa der einzige Übergang von der Client-Zone in die
Anwendungs-/API-Zone. Mehrere hintereinanderliegende Grenzen (Client → App → DB) sind **Defense in Depth**: Wer
die erste Grenze überwindet, steht noch nicht in der Datenbank und wird bei der **lateralen Bewegung** gebremst.

**EN:** **Step 4 – Justify choke points and defense in depth.** Instead of many direct connections, you route
allowed traffic through few, controlled crossings. A choke point is a place where you can inspect, log, and, in an
emergency, shut off traffic – for example the single crossing from the client zone into the application/API zone.
Several boundaries in sequence (client → app → DB) are **defense in depth**: whoever passes the first boundary is
not yet inside the database and is slowed down during **lateral movement**.

**DE:** **Schritt 5 – Datenklassen den Segmenten zuordnen.** Ordne jede Datenklasse dem Segment mit passendem
Schutz zu: personenbezogene Kundendaten (z. B. `ContactName` von `ALFKI`) und Secrets (z. B. DB-Zugang) gehören
in die eng geschützte Datenbank-Zone, reine Betriebsdaten wie Bestellstatus in weniger strenge Segmente. Eine
Datenklasse, die ein eigenes, engeres Segment verlangt, wird nicht mit weniger schützenswerten Daten vermischt.
Das begrenzt die laterale Bewegung: Fällt ein Segment aus oder wird kompromittiert, bleibt der Schaden lokal.

**EN:** **Step 5 – Map data classes to segments.** Assign each data class to the segment with matching protection:
personal customer data (e.g. `ContactName` of `ALFKI`) and secrets (e.g. DB access) belong in the tightly
protected database zone, pure operational data such as order status in less strict segments. A data class that
requires its own tighter segment is not mixed with less sensitive data. This limits lateral movement: if a segment
fails or is compromised, the damage stays local.

**DE:** **Typische Fehler.** Alles in ein flaches Netz legen. Die Datenbank aus dem Internet erreichbar machen.
Segmentgrenzen ohne Bezug zur Kommunikationsmatrix ziehen. Regeln erlauben statt verbieten (kein deny by default).
Ganze Segmente statt einzelner Flüsse freigeben (kein least privilege). Personenbezogene Kundendaten mit
Betriebsdaten mischen. Annahmen als bestätigt darstellen statt als `Open`.

**EN:** **Common mistakes.** Putting everything into one flat network. Making the database reachable from the
internet. Drawing segment boundaries unrelated to the communication matrix. Rules that allow instead of forbid (no
deny by default). Permitting whole segments instead of single flows (no least privilege). Mixing personal customer
data with operational data. Presenting assumptions as confirmed instead of `Open`.

### Beispiel / Example

```text
Vertrauenszonen / Segmente:
  Z1 Client-Zone (DMZ)   Bestell-Clients, aus Internet erreichbar, wenig vertraut
  Z2 App-/API-Zone       Bestellannahme + Katalog-Dienst, vermittelt
  Z3 Datenbank-Zone      Northwind (Orders/Customers), intern, streng geschuetzt
  Z4 Auswertungs-Zone    lesend, aggregiert

Beispiel-Adressen (Platzhalter, keine echten Werte):
  Z1 10.10.x   Z2 10.20.x   Z3 db.internal.example (10.30.x)   Z4 10.40.x

Segmentregel-Tabelle (deny by default):
  Quelle-Segment    Ziel-Segment      erlaubt/verboten   Recht (least privilege)
  Internet          Z1 Client-Zone    erlaubt            nur HTTPS zur Bestellung
  Z1 Client-Zone    Z2 App-/API-Zone  erlaubt            nur Bestellung senden (API)
  Z2 App-/API-Zone  Z3 Datenbank-Zone erlaubt            nur schreiben/lesen der Bestellannahme
  Z4 Auswertung     Z3 Datenbank-Zone erlaubt            nur lesen (aggregiert)
  Z1 Client-Zone    Z3 Datenbank-Zone VERBOTEN           - (DB nie direkt aus DMZ)
  Internet          Z3 Datenbank-Zone VERBOTEN           - (DB nie aus dem Internet)
  alles uebrige     alles uebrige     VERBOTEN           deny by default

Choke Point:  einziger Uebergang Z1->Z2 am API-Endpunkt (pruef- und abschaltbar)
Datenklasse:  personenbezogen (ALFKI ContactName) + Secret nur in Z3;
              Beispiel-Secret nur als <PLATZHALTER-KEIN-ECHTER-WERT>
Open:         genaue Regel fuer Admin-Zugang zu Z3 noch nicht bestaetigt -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). Sie verbindet
den sicheren Betrieb vernetzter Systeme mit der Bereitstellung von Netz und Dienst und der sicheren Netzeinbindung
von Clients:

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). It links
the secure operation of networked systems with the provisioning of network and services and the secure network
integration of clients:

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Segmentierung, deny-by-default-Regeln und eine nicht direkt aus dem Internet erreichbare Datenbank sind Kern des sicheren Betriebs vernetzter Systeme. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Zonen, Choke Points und Freigaben bestimmen, wie die Bestell-Pipeline als Netz und Dienst bereitgestellt wird. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Die Zuordnung der Bestell-Clients zur öffentlichen Client-Zone greift die sichere Netzeinbindung von Clients auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, Defense in Depth, Least Privilege, Fail-Safe
Defaults und Angriffsfläche reduzieren. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_04` (Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz)
und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Die Bestell-Pipeline ist
nach Schutzbedarf in Client-, Anwendungs-/API- und Datenbank-Zone getrennt, zwischen ihnen gilt deny by default mit
least privilege, die Northwind-Datenbank ist nie direkt aus dem Internet erreichbar, und erlaubter Verkehr fließt
nur über begründete Choke Points.* A11Y-Aspekt: Zonen- und Segmentregel-Tabellen müssen als echte Tabelle mit
Kopfzeile in reinem Text lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar
bleiben.

**EN:** Relation to the Secure Development Guideline: trust boundaries, defense in depth, least privilege,
fail-safe defaults, and attack surface reduction. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling), `CL_08` (security code review), `CL_10` (data protection), and
`CL_12` (evidence and closure). The security decision of this unit is: *the order pipeline is separated by
protection need into client, application/API, and database zones, between them deny by default with least privilege
applies, the Northwind database is never directly reachable from the internet, and allowed traffic flows only
through justified choke points.* Accessibility aspect: zone and segment-rule tables must be readable as a real
table with a header row in plain text, without color coding, so they stay usable with a screen reader or Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was bedeutet „deny by default" zwischen der Client-Zone und der Anwendungs-/API-Zone? /
   **EN:** (DV) What does "deny by default" mean between the client zone and the application/API zone?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Im Grundzustand ist jeder Verkehr zwischen den beiden Zonen verboten. Nur ausdrücklich benannte Flüsse
   – etwa das Senden einer Bestellung an den API-Endpunkt – werden erlaubt. Alles, was nicht freigegeben ist,
   bleibt blockiert.
   **EN:** By default all traffic between the two zones is forbidden. Only explicitly named flows – such as sending
   an order to the API endpoint – are allowed. Everything not permitted stays blocked.

   </details>

2. **DE:** (DV) Warum darf die Northwind-Datenbank nicht direkt aus dem Internet erreichbar sein? /
   **EN:** (DV) Why must the Northwind database not be directly reachable from the internet?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie hält alle Kunden- und Bestelldaten (z. B. `ALFKI`) und ist damit das schützenswerteste Ziel. Liegt
   sie in der internen Datenbank-Zone hinter der Anwendungs-/API-Zone, muss ein Angreifer erst mehrere Grenzen
   überwinden (Defense in Depth). Ein direkter Weg aus dem Internet würde die Angriffsfläche massiv vergrößern.
   **EN:** It holds all customer and order data (e.g. `ALFKI`) and is thus the most protection-worthy target. In
   the internal database zone behind the application/API zone, an attacker must first pass several boundaries
   (defense in depth). A direct path from the internet would massively increase the attack surface.

   </details>

3. **DE:** Wie leitest du eine Segmentgrenze aus der Kommunikationsmatrix ab? /
   **EN:** How do you derive a segment boundary from the communication matrix?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wo zwischen zwei Knotengruppen kein erlaubter Fluss besteht (oder ein Fluss ausdrücklich verboten ist),
   gehört eine Segmentgrenze hin. Die Matrix zeigt die natürlichen Trennlinien, etwa zwischen Bestell-Client und
   Datenbank.
   **EN:** Where no allowed flow exists between two node groups (or a flow is explicitly forbidden), a segment
   boundary belongs. The matrix shows the natural dividing lines, e.g. between the order client and the database.

   </details>

4. **DE:** (SI) Wozu dient ein Choke Point und wie weist man seine Wirkung nach? /
   **EN:** (SI) What is a choke point for, and how do you evidence its effect?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Choke Point bündelt erlaubten Verkehr an einem kontrollierbaren Übergang, an dem man prüfen,
   protokollieren und abschalten kann – etwa der einzige Übergang von der Client-Zone in die App-/API-Zone.
   Nachweis: eine Firewall-/Regelprüfung, die zeigt, dass nur dieser Choke Point den Übergang zulässt.
   **EN:** A choke point bundles allowed traffic at a controllable crossing where you can inspect, log, and shut
   off – such as the single crossing from the client zone into the application/API zone. Evidence: a firewall/rule
   check showing that only this choke point permits the crossing.

   </details>

5. **DE:** (DPA) Welche Datenklasse verlangt ein eigenes, engeres Segment und warum? /
   **EN:** (DPA) Which data class requires its own tighter segment, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Personenbezogene Kundendaten (z. B. `ContactName` von `ALFKI`) und Secrets. Getrennt in der eng
   geschützten Datenbank-Zone begrenzt man ihren Zugriff und die laterale Bewegung: Ein Vorfall in der Client- oder
   Auswertungs-Zone erreicht sie nicht automatisch.
   **EN:** Personal customer data (e.g. `ContactName` of `ALFKI`) and secrets. Separated in the tightly protected
   database zone, you limit their access and lateral movement: an incident in the client or analytics zone does not
   automatically reach them.

   </details>

6. **DE:** (AE) Warum sollte die Bestellannahme über einen definierten Choke Point statt direkt mit der Datenbank
   sprechen? /
   **EN:** (AE) Why should order intake speak through a defined choke point instead of directly with the database?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein definierter Übergang lässt sich prüfen, protokollieren und mit least privilege begrenzen (nur die
   nötigen Schreib-/Lesezugriffe). Direkte Punkt-zu-Punkt-Wege vermehren die Angriffsfläche und die zu
   überwachenden Stellen. Der Choke Point hält die Kontrolle an einem Ort.
   **EN:** A defined crossing can be inspected, logged, and limited with least privilege (only the necessary
   read/write access). Direct point-to-point paths multiply the attack surface and the places to monitor. The choke
   point keeps control in one place.

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

- [ ] Knoten der Bestell-Pipeline zu Vertrauenszonen (Client, App/API, Datenbank, Auswertung) gruppieren.
- [ ] Segmentgrenzen und die DMZ-Rolle der Client-Zone aus der Kommunikationsmatrix ableiten.
- [ ] deny-by-default- und least-privilege-Regeln je Grenze formulieren.
- [ ] begründen, warum die Northwind-Datenbank nie direkt aus dem Internet erreichbar ist (Defense in Depth).
- [ ] Choke Points begründen und Datenklassen dem Segment mit passendem Schutz zuordnen.
- [ ] unbestätigte Regeln als `Open` mit Folgeaktion und nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] group order-pipeline nodes into trust zones (client, app/API, database, analytics).
- [ ] derive segment boundaries and the DMZ role of the client zone from the communication matrix.
- [ ] formulate deny-by-default and least-privilege rules per boundary.
- [ ] justify why the Northwind database is never directly reachable from the internet (defense in depth).
- [ ] justify choke points and map data classes to the segment with matching protection.
- [ ] mark unconfirmed rules as `Open` with a follow-up action and non-applicable standards as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md`. Sie baut auf
Einheit 03 (`Schnittstellen und Kommunikationsflüsse`) auf; die Segment- und Zonenzuordnung ist die Grundlage für
Einheit 05 (`Transportsicherheit und Endpunkt-Authentifizierung`). Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_04_Segmentierung-und-Vertrauenszonen.md`. It builds on
unit 03 (`interfaces and communication flows`); the segment and zone mapping is the basis for unit 05 (`transport
security and endpoint authentication`). The copy-paste prompt for a later, manually started Spec Kit run is
provided there.
