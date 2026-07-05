# Lernbegleiter: Secure CaseTracker Digital Networking Track 02 – Topologie, Schnittstellen und Kommunikationsflüsse / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_02_Topologie-Schnittstellen-und-Kommunikationsfluesse.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Systemkontext aus Einheit 01 sagt, *welche* Systeme es gibt. Jetzt geht es darum, *wie* sie
verbunden sind. Die **Topologie** beschreibt die Anordnung der Knoten, die **Schnittstellen** die Übergänge
und die **Kommunikationsflüsse** den tatsächlichen Datenverkehr: von wo nach wo, in welche Richtung, mit
welchem Zweck und mit welcher Datenklasse. Ein häufiger Denkfehler ist, nur die erlaubten Verbindungen zu
zeichnen. Genauso wichtig sind die **verbotenen** Verbindungen, denn sie definieren die Angriffsfläche, die
man bewusst klein hält.

**EN:** The system context from unit 01 says *which* systems exist. Now it is about *how* they are connected.
The **topology** describes the arrangement of nodes, the **interfaces** the crossings, and the
**communication flows** the actual traffic: from where to where, in which direction, with which purpose and
which data class. A common mistake is to draw only the allowed connections. The **forbidden** connections
are just as important, because they define the attack surface you deliberately keep small.

**DE:** In dieser Einheit lernst du, jede relevante Verbindung mit Quelle, Ziel, Richtung, Zweck und
Datenklasse zu beschreiben, Ports und Protokolle nachvollziehbar anzunehmen und eine Kommunikationsmatrix zu
erstellen, die erlaubte und verbotene Pfade klar trennt.

**EN:** In this unit you learn to describe each relevant connection with source, target, direction, purpose,
and data class, to make plausible assumptions about ports and protocols, and to build a communication matrix
that clearly separates allowed and forbidden paths.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Topologie / Topology | Anordnung und Verbindung der Knoten in einem Netz. |
| Kommunikationsfluss / Communication flow | Konkreter Datenverkehr zwischen zwei Knoten mit Richtung und Zweck. |
| Kommunikationsmatrix / Communication matrix | Tabelle, die jede Verbindung als erlaubt oder verboten dokumentiert. |
| Port / Protokoll / Port, protocol | Technischer Kanal und Regelsatz, über den zwei Knoten Daten austauschen. |
| Kommunikationsrichtung / Direction | Angabe, wer die Verbindung aufbaut (ausgehend, eingehend, beidseitig). |
| Angriffsfläche / Attack surface | Summe aller erreichbaren Wege in ein System; kleiner ist sicherer. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Knoten in eine Topologie ordnen.** Übernimm die Knoten aus Einheit 01 und ordne sie:
Wer spricht direkt mit wem? Gibt es einen zentralen Dienst, über den vieles läuft? Die Anordnung zeigt
bereits, welche Knoten besonders exponiert sind.

**EN:** **Step 1 – Arrange nodes into a topology.** Take the nodes from unit 01 and arrange them: who talks
directly to whom? Is there a central service through which much traffic runs? The arrangement already shows
which nodes are especially exposed.

**DE:** **Schritt 2 – Jede Verbindung vollständig beschreiben.** Eine Verbindung ohne Richtung und Zweck ist
wertlos für die Sicherheit. Notiere für jede Verbindung: Quelle, Ziel, Richtung, Zweck, Datenklasse und
angenommenes Protokoll. Warum die Richtung? Sie entscheidet, wer wen erreichen darf und wo eine Firewall-
oder Segmentregel greift.

**EN:** **Step 2 – Describe each connection completely.** A connection without direction and purpose is
worthless for security. For each connection note: source, target, direction, purpose, data class, and
assumed protocol. Why the direction? It decides who may reach whom and where a firewall or segmentation rule
applies.

**DE:** **Schritt 3 – Verbotene Verbindungen als Nicht-Ziele festhalten.** Schreibe ausdrücklich auf, welche
Verbindungen es *nicht* geben darf, zum Beispiel: der Monitoring-Sammler darf nicht auf die Falldatenbank
zugreifen. Ein nicht genannter Pfad wird sonst leicht stillschweigend erlaubt. Deny by default heißt: Was
nicht ausdrücklich erlaubt ist, ist verboten.

**EN:** **Step 3 – Record forbidden connections as non-goals.** Write down explicitly which connections must
*not* exist, for example: the monitoring collector must not access the case database. An unnamed path is
otherwise easily allowed silently. Deny by default means: whatever is not explicitly allowed is forbidden.

**DE:** **Schritt 4 – Ports und Protokolle plausibel annehmen.** In der Übung kennst du nicht jede reale
Konfiguration. Triff nachvollziehbare Annahmen (z. B. verschlüsseltes Protokoll für personenbezogene Daten)
und markiere Unsicheres als `Open`. Unverschlüsselte Übertragung sensibler Daten ist ein klassischer Fehler.

**EN:** **Step 4 – Assume ports and protocols plausibly.** In the exercise you do not know every real
configuration. Make traceable assumptions (e.g. an encrypted protocol for personal data) and mark uncertain
points as `Open`. Unencrypted transmission of sensitive data is a classic mistake.

**DE:** **Schritt 5 – Kommunikationsmatrix erstellen.** Fasse alles in einer Tabelle zusammen: jede Zeile
eine Verbindung, Spalten für Quelle, Ziel, Richtung, Datenklasse und Status (erlaubt/verboten). Diese Matrix
ist der Nachweis, den Reviewende und die folgende Segmentierungs-Einheit direkt weiterverwenden.

**EN:** **Step 5 – Build the communication matrix.** Summarize everything in a table: each row a connection,
columns for source, target, direction, data class, and status (allowed/forbidden). This matrix is the
evidence that reviewers and the following segmentation unit reuse directly.

**DE:** **Typische Fehler.** Nur Erlaubtes zeichnen. Richtung vergessen. Sensible Daten unverschlüsselt
übertragen. Monitoring- und Produktivpfade vermischen. Annahmen als Tatsachen ausgeben, statt sie als `Open`
zu markieren.

**EN:** **Common mistakes.** Drawing only what is allowed. Forgetting the direction. Transmitting sensitive
data unencrypted. Mixing monitoring and production paths. Presenting assumptions as facts instead of marking
them `Open`.

### Beispiel / Example

```text
Kommunikationsmatrix (Auszug):
  Quelle          Ziel              Richtung    Datenklasse            Protokoll   Status
  CaseTracker     Falldatenbank     ausgehend   personenbezogen        verschl.    erlaubt
  CaseTracker     Monitoring        ausgehend   Betriebsdaten          verschl.    erlaubt
  Monitoring      Falldatenbank     -           personenbezogen        -           VERBOTEN
  Fachdienst      CaseTracker       eingehend   personenbezogen        verschl.    erlaubt (Prüfung!)

Offene Annahme (Open): Exaktes Protokoll des Fachdienstes noch nicht bestaetigt -> Folgeaktion
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10d Cyber-physische Systeme entwickeln | Primär / Primary | Topologie, Schnittstellen und Kommunikationsflüsse sind die Entwicklungsgrundlage des vernetzten Systems. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Ports, Protokolle und Verbindungsrichtungen greifen die Grundlagen der Netzeinbindung direkt auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, Angriffsfläche reduzieren und sichere
Konfiguration. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_04` (Bedrohungsmodellierung) und `CL_10` (Betrieb/Konfiguration). Die Sicherheitsentscheidung dieser
Einheit lautet: *Nur ausdrücklich erlaubte Kommunikationsflüsse existieren; alles andere ist verboten (deny
by default).* A11Y-Aspekt: Die Kommunikationsmatrix ist eine echte Tabelle mit Kopfzeile und darf nicht nur
als Farbpfeil-Diagramm vorliegen, damit sie mit Screenreader und Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: trust boundaries, attack surface reduction, and secure
configuration. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design), `CL_04`
(threat modeling), and `CL_10` (operations/configuration). The security decision of this unit is: *only
explicitly allowed communication flows exist; everything else is forbidden (deny by default).* Accessibility
aspect: the communication matrix is a real table with a header row and must not exist only as a color-arrow
diagram, so it stays usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht es nicht, nur die erlaubten Verbindungen zu dokumentieren? /
   **EN:** Why is documenting only the allowed connections not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Verbotene Verbindungen definieren die Angriffsfläche. Wird ein Pfad nicht ausdrücklich verboten,
   gilt er leicht als erlaubt. Deny by default verlangt, dass Verbotenes benannt und alles Unerlaubte
   blockiert ist.
   **EN:** Forbidden connections define the attack surface. If a path is not explicitly forbidden, it is
   easily treated as allowed. Deny by default requires naming what is forbidden and blocking everything not
   permitted.

   </details>

2. **DE:** Warum gehört zu jeder Verbindung eine Richtung? /
   **EN:** Why does every connection need a direction?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Richtung entscheidet, wer die Verbindung aufbaut und wer wen erreichen darf. Segment- und
   Firewall-Regeln arbeiten richtungsbezogen; ohne Richtung ist keine präzise Regel möglich.
   **EN:** The direction decides who initiates the connection and who may reach whom. Segment and firewall
   rules work by direction; without direction no precise rule is possible.

   </details>

3. **DE:** (DV) Welche Datenklasse verlangt in der Topologie besondere Aufmerksamkeit und warum? /
   **EN:** (DV) Which data class demands special attention in the topology, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Personenbezogene Daten und Secrets. Sie brauchen verschlüsselte Übertragung, engere Pfade und
   eine Prüfung an der Vertrauensgrenze. Betriebsdaten wie Zählwerte sind weniger kritisch.
   **EN:** Personal data and secrets. They need encrypted transmission, tighter paths, and a check at the
   trust boundary. Operational data such as counters is less critical.

   </details>

4. **DE:** Was bedeutet „deny by default" für die Kommunikationsmatrix? /
   **EN:** What does "deny by default" mean for the communication matrix?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Verbindung, die nicht ausdrücklich als erlaubt eingetragen ist, gilt als verboten. Die
   Matrix muss erlaubte Pfade vollständig auflisten, damit der Rest blockiert bleibt.
   **EN:** Every connection not explicitly listed as allowed counts as forbidden. The matrix must fully list
   allowed paths so that the rest stays blocked.

   </details>

5. **DE:** Warum wird eine unsichere Protokollannahme als `Open` und nicht als erledigt markiert? /
   **EN:** Why is an uncertain protocol assumption marked `Open` and not as done?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine als erledigt dargestellte Annahme täuscht Sicherheit vor. `Open` macht die Unsicherheit
   sichtbar und erzwingt eine Bestätigung, bevor man sich darauf verlässt.
   **EN:** An assumption presented as done fakes security. `Open` makes the uncertainty visible and forces a
   confirmation before you rely on it.

   </details>

6. **DE:** Warum dürfen Monitoring- und Produktivpfade nicht vermischt werden? /
   **EN:** Why must monitoring and production paths not be mixed?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Vermischung öffnet Wege, über die Monitoring an Produktivdaten gelangt oder umgekehrt. Getrennte
   Pfade halten die Angriffsfläche klein und schützen personenbezogene Daten.
   **EN:** Mixing opens paths through which monitoring reaches production data or vice versa. Separate paths
   keep the attack surface small and protect personal data.

   </details>

7. **DE:** Warum ist eine Tabelle für die Kommunikationsmatrix barrierefreier als ein Farbpfeil-Diagramm? /
   **EN:** Why is a table more accessible for the communication matrix than a color-arrow diagram?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Tabelle mit Kopfzeile ist mit Screenreader und Braille-Zeile lesbar und braucht keine Farbe,
   um Bedeutung zu tragen. Ein Farbpfeil-Diagramm schließt diese Nutzung aus.
   **EN:** A table with a header row is readable with a screen reader and Braille display and needs no color
   to carry meaning. A color-arrow diagram excludes that use.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Knoten aus Einheit 01 zu einer Topologie ordnen und exponierte Knoten erkennen.
- [ ] jede Verbindung mit Quelle, Ziel, Richtung, Zweck und Datenklasse beschreiben.
- [ ] verbotene Verbindungen als Nicht-Ziele festhalten.
- [ ] Ports und Protokolle plausibel annehmen und Unsicheres als `Open` markieren.
- [ ] eine Kommunikationsmatrix erstellen, die erlaubte und verbotene Pfade trennt.

**EN:** I can …

- [ ] arrange the nodes from unit 01 into a topology and spot exposed nodes.
- [ ] describe each connection with source, target, direction, purpose, and data class.
- [ ] record forbidden connections as non-goals.
- [ ] assume ports and protocols plausibly and mark uncertain points as `Open`.
- [ ] build a communication matrix that separates allowed and forbidden paths.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_02_Topologie-Schnittstellen-und-Kommunikationsfluesse.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_02_Topologie-Schnittstellen-und-Kommunikationsfluesse.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
