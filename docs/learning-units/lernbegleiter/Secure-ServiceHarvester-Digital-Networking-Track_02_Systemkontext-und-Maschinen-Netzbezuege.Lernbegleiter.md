# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 02 – Systemkontext und Maschinen-/Netzbezüge / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_02_Systemkontext-und-Maschinen-Netzbezuege.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Das Netzzielbild aus Einheit 01 sagt, *was* das Netz leisten soll. Jetzt beschreibst du den
**Systemkontext**: *welche* Systeme, Menschen und Knoten es gibt und *wie* sie am Netz hängen. Zum verteilten
Sammeln gehören Sammel-Agenten auf den Zielmaschinen, der Sammler-Dienst, die Datenhaltung, die Auswertung und
externe Systeme. Jeder **Netzbezug** – jede Verbindung eines Knotens zum Netz – trägt eine bestimmte
**Datenklasse**. Wichtig ist zu erkennen, wo Daten die Vertrauenszone wechseln, denn genau dort muss später
geprüft werden.

**EN:** The network target picture from unit 01 says *what* the network should achieve. Now you describe the
**system context**: *which* systems, people, and nodes exist and *how* they attach to the network.
Distributed collection includes collection agents on the target machines, the collector service, data
storage, analytics, and external systems. Each **network relation** – each connection of a node to the
network – carries a certain **data class**. It is important to recognize where data crosses the trust zone,
because exactly there a check is needed later.

**DE:** In dieser Einheit lernst du, ein Kontextdiagramm oder eine Kontextliste zu erstellen, Knoten und
Sammel-Agenten zu benennen, Subnetze und Netzbezüge zu ordnen und jedem Netzbezug eine Datenklasse und eine
erste Vertrauensgrenze zuzuordnen. Die C#-Referenz `InventarWorkerService` dient als Orientierung; die Lösung
bleibt sprachneutral.

**EN:** In this unit you learn to create a context diagram or context list, name nodes and collection agents,
arrange subnets and network relations, and assign a data class and a first trust boundary to each network
relation. The C# reference `InventarWorkerService` serves as orientation; the solution stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Systemkontext / System context | Übersicht aller beteiligten Systeme, Rollen und Grenzen rund um den Dienst. |
| Knoten / Node | Ein am Netz teilnehmendes Element, z. B. Maschine, Dienst oder Datenbank. |
| Sammel-Agent / Collection agent | Kleines Programm auf einer Zielmaschine, das Statusdaten erfasst und sendet. |
| Subnetz / Subnet | Abgegrenzter Netzbereich, in dem bestimmte Knoten zusammengefasst sind. |
| Netzbezug / Network relation | Konkrete Anbindung eines Knotens an das Netz mit einer Datenklasse. |
| Datenklasse / Data class | Einordnung von Daten nach Schutzbedarf (z. B. Betriebsdaten, sensibel, Secret). |
| Trust Boundary / Vertrauensgrenze | Linie, an der Daten das Vertrauensniveau wechseln und geprüft werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Beteiligte Systeme und Rollen sammeln.** Liste alle Systeme und Benutzergruppen auf, die
mit dem Sammeln zu tun haben: Zielmaschinen mit Agenten, Sammler-Dienst, Datenhaltung, Auswertung,
Administratoren, ggf. ein externes Monitoring. Wer nichts mit dem Sammeln zu tun hat, gehört bewusst *nicht*
in den Kontext.

**EN:** **Step 1 – Gather involved systems and roles.** List all systems and user groups related to
collection: target machines with agents, collector service, data storage, analytics, administrators, possibly
external monitoring. Whoever has nothing to do with collection deliberately does *not* belong in the context.

**DE:** **Schritt 2 – Knoten und Agenten benennen.** Für jede Zielmaschine gibt es typischerweise einen
Sammel-Agenten. Benenne die Knoten eindeutig und gruppiere sie. So wird sichtbar, wie viele gleichartige
Endpunkte es gibt und welche zentralen Knoten besonders exponiert sind.

**EN:** **Step 2 – Name nodes and agents.** Each target machine typically has a collection agent. Name the
nodes uniquely and group them. This shows how many similar endpoints exist and which central nodes are
especially exposed.

**DE:** **Schritt 3 – Subnetze und Netzbezüge ordnen.** Ordne die Knoten grob in Subnetze, etwa
„Maschinennetz", „Dienstnetz" und „Auswertungsnetz". Für jeden Netzbezug notierst du: welcher Knoten hängt
über welchen Weg am Netz. Diese Struktur bereitet die Kommunikationsflüsse (Einheit 03) vor.

**EN:** **Step 3 – Arrange subnets and network relations.** Group the nodes roughly into subnets, e.g.
"machine network", "service network", and "analytics network". For each network relation note: which node
attaches to the network by which path. This structure prepares the communication flows (unit 03).

**DE:** **Schritt 4 – Datenklassen zuordnen.** Für jeden Netzbezug bestimmst du die Datenklasse: reine
Betriebsdaten (z. B. Zählwerte), sensible Daten oder Secrets. Die Datenklasse entscheidet später über
Verschlüsselung und engere Pfade. Secrets werden in Beispielen nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`
dargestellt.

**EN:** **Step 4 – Assign data classes.** For each network relation determine the data class: pure
operational data (e.g. counters), sensitive data, or secrets. The data class later decides encryption and
tighter paths. Secrets appear in examples only as `<PLATZHALTER-KEIN-ECHTER-WERT>`.

**DE:** **Schritt 5 – Erste Vertrauensgrenzen und exponierte Knoten markieren.** Zeichne die Linien, an denen
Daten die Zone wechseln, etwa vom Agenten in das Dienstnetz. Markiere die exponiertesten Knoten. Was du hier
sauber benennst, kannst du in der Segmentierung (Einheit 04) direkt weiterverwenden. Unsicheres markierst du
als `Open`.

**EN:** **Step 5 – Mark first trust boundaries and exposed nodes.** Draw the lines where data crosses the
zone, e.g. from the agent into the service network. Mark the most exposed nodes. What you name cleanly here
can be reused directly in the segmentation (unit 04). Mark uncertain points as `Open`.

**DE:** **Typische Fehler.** Zu viele unbeteiligte Systeme aufnehmen. Agenten und Maschinen verwechseln.
Netzbezüge ohne Datenklasse lassen. Trust Boundaries vergessen. Annahmen als Tatsachen ausgeben statt sie als
`Open` zu markieren.

**EN:** **Common mistakes.** Including too many unrelated systems. Confusing agents and machines. Leaving
network relations without a data class. Forgetting trust boundaries. Presenting assumptions as facts instead
of marking them `Open`.

### Beispiel / Example

```text
Systemkontext (Auszug):
  Knoten                Subnetz             Netzbezug/Rolle              Datenklasse       Trust Boundary
  Maschine A + Agent    Maschinennetz       sendet Status an Sammler     Betriebsdaten     Agent -> Dienstnetz
  Maschine B + Agent    Maschinennetz       sendet Status an Sammler     Betriebsdaten     Agent -> Dienstnetz
  Sammler-Dienst        Dienstnetz          nimmt Status entgegen        Betriebsdaten     Dienstnetz -> Datenhaltung
  Datenhaltung          Dienstnetz          speichert Snapshots          sensibel (intern) Datenhaltung <- Auswertung
  Auswertung            Auswertungsnetz     liest aggregiert             Betriebsdaten     -

Exponierter Knoten: Sammler-Dienst (zentrale Anlaufstelle vieler Agenten)
Offene Annahme (Open): Anzahl externer Monitoring-Zugriffe noch nicht bestaetigt -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10d Cyber-physische Systeme entwickeln | Primär / Primary | Der Systemkontext mit Maschinen, Agenten und Netzbezügen ist die Entwicklungsgrundlage des vernetzten Systems. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Sammel-Agenten sind Clients, deren Netzeinbindung hier strukturiert wird. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Subnetze und Netzbezüge greifen die Bereitstellung von Netz und Dienst auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries, Angriffsfläche
reduzieren und Datenschutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_04` (Bedrohungsmodellierung) und `CL_10` (Datenschutz/Betrieb). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jeder Netzbezug bekommt eine Datenklasse und eine
Vertrauensgrenze; exponierte Knoten werden früh benannt.* A11Y-Aspekt: Der Systemkontext liegt als echte
Tabelle oder klar strukturierte Liste vor, nicht nur als Farbgrafik, damit er mit Screenreader und
Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, attack surface
reduction, and privacy. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling), and `CL_10` (privacy/operations). The security decision of
this unit is: *every network relation gets a data class and a trust boundary; exposed nodes are named early.*
Accessibility aspect: the system context is a real table or clearly structured list, not just a color graphic,
so it stays usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wozu dient ein Systemkontext, bevor man Kommunikationsflüsse plant? /
   **EN:** What is the purpose of a system context before planning communication flows?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er zeigt, welche Systeme, Rollen und Knoten es gibt und wo Grenzen liegen. Erst wenn die Beteiligten
   klar sind, lassen sich Verbindungen sinnvoll und vollständig beschreiben.
   **EN:** It shows which systems, roles, and nodes exist and where the boundaries are. Only when the
   participants are clear can connections be described meaningfully and completely.

   </details>

2. **DE:** (DV) Warum ist der zentrale Sammler-Dienst oft der am stärksten exponierte Knoten? /
   **EN:** (DV) Why is the central collector service often the most exposed node?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Viele Agenten verbinden sich mit ihm; er ist die zentrale Anlaufstelle. Fällt er aus oder wird er
   kompromittiert, ist das gesamte Sammeln betroffen. Daher braucht er besondere Absicherung.
   **EN:** Many agents connect to it; it is the central point of contact. If it fails or is compromised, the
   whole collection is affected. Therefore it needs special protection.

   </details>

3. **DE:** Was unterscheidet einen Sammel-Agenten von der Maschine, auf der er läuft? /
   **EN:** What distinguishes a collection agent from the machine it runs on?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Maschine ist der Knoten; der Agent ist das kleine Programm darauf, das Statusdaten erfasst und
   sendet. Diese Trennung hilft, Verantwortlichkeiten und Netzbezüge klar zuzuordnen.
   **EN:** The machine is the node; the agent is the small program on it that captures and sends status data.
   This separation helps to assign responsibilities and network relations clearly.

   </details>

4. **DE:** (DPA) Warum bekommt jeder Netzbezug eine Datenklasse? /
   **EN:** (DPA) Why does every network relation get a data class?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Datenklasse bestimmt den Schutzbedarf und damit spätere Maßnahmen wie Verschlüsselung oder
   engere Pfade. Ohne Datenklasse lässt sich nicht begründen, warum eine Verbindung besonders geschützt wird.
   **EN:** The data class determines the protection need and thus later measures such as encryption or tighter
   paths. Without a data class you cannot justify why a connection is specially protected.

   </details>

5. **DE:** (SI) Welche Betriebsannahme über Subnetze sollte dokumentiert und nachgewiesen werden? /
   **EN:** (SI) Which operational assumption about subnets should be documented and evidenced?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel, dass Maschinennetz und Auswertungsnetz getrennt sind. Nachweis: eine Subnetz-/
   Zuordnungstabelle oder ein Konfigurationsauszug. Nur benannte und belegte Trennungen wirken.
   **EN:** For example that the machine network and analytics network are separated. Evidence: a subnet/
   assignment table or a configuration excerpt. Only named and evidenced separations are effective.

   </details>

6. **DE:** Warum markiert man eine unsichere Kontextannahme als `Open`? /
   **EN:** Why do you mark an uncertain context assumption as `Open`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil eine als sicher dargestellte, aber ungeprüfte Annahme später zu falschen Regeln führt. `Open`
   macht die Lücke sichtbar und erzwingt eine Klärung mit Folgeaktion.
   **EN:** Because an assumption presented as certain but unverified leads to wrong rules later. `Open` makes
   the gap visible and forces a clarification with a follow-up action.

   </details>

7. **DE:** Wie hilft der Systemkontext der späteren Segmentierung? /
   **EN:** How does the system context help the later segmentation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er liefert Knoten, Subnetze, Datenklassen und erste Vertrauensgrenzen. Daraus lassen sich Segmente
   und Zonen direkt ableiten, statt sie neu zu erfinden.
   **EN:** It provides nodes, subnets, data classes, and first trust boundaries. From these, segments and zones
   can be derived directly instead of inventing them anew.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] beteiligte Systeme und Rollen des verteilten Sammelns auflisten.
- [ ] Knoten und Sammel-Agenten eindeutig benennen und gruppieren.
- [ ] Subnetze und Netzbezüge ordnen.
- [ ] jedem Netzbezug eine passende Datenklasse zuordnen.
- [ ] erste Vertrauensgrenzen und exponierte Knoten markieren.
- [ ] unsichere Annahmen als `Open` mit Folgeaktion festhalten.

**EN:** I can …

- [ ] list involved systems and roles of distributed collection.
- [ ] name and group nodes and collection agents uniquely.
- [ ] arrange subnets and network relations.
- [ ] assign a suitable data class to each network relation.
- [ ] mark first trust boundaries and exposed nodes.
- [ ] record uncertain assumptions as `Open` with a follow-up action.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_02_Systemkontext-und-Maschinen-Netzbezuege.md`.
Sie baut auf Einheit 01 (`Track-Baseline und Netzzielbild`) auf und liefert die Grundlage für Einheit 03
(`Schnittstellen und Kommunikationsflüsse`). Der Copy-Paste-Prompt für einen späteren, manuell gestarteten
Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_02_Systemkontext-und-Maschinen-Netzbezuege.md`.
It builds on unit 01 (`track baseline and network target picture`) and provides the basis for unit 03
(`interfaces and communication flows`). The copy-paste prompt for a later, manually started Spec Kit run is
provided in the intake.
