# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 03 – Schnittstellen und Kommunikationsflüsse / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_03_Schnittstellen-und-Kommunikationsfluesse.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Systemkontext aus Einheit 02 sagt, *welche* Knoten es gibt. Jetzt beschreibst du die
**Schnittstellen** – die Übergänge zwischen Knoten – und die **Kommunikationsflüsse** – den tatsächlichen
Datenverkehr: von wo nach wo, in welche Richtung, mit welchem Zweck, mit welcher Datenklasse und über welches
Protokoll. Beim verteilten Sammeln entscheidet vor allem die Frage: Holt der Sammler die Daten aktiv (Pull)
oder schicken die Agenten sie (Push)? Ein häufiger Denkfehler ist, nur die erlaubten Verbindungen zu
beschreiben. Genauso wichtig sind die **verbotenen**, denn sie definieren die Angriffsfläche, die man bewusst
klein hält (deny by default).

**EN:** The system context from unit 02 says *which* nodes exist. Now you describe the **interfaces** – the
crossings between nodes – and the **communication flows** – the actual traffic: from where to where, in which
direction, with which purpose, with which data class, and over which protocol. In distributed collection, the
key question is: does the collector fetch the data actively (pull) or do the agents send it (push)? A common
mistake is describing only the allowed connections. The **forbidden** ones are just as important, because they
define the attack surface you deliberately keep small (deny by default).

**DE:** In dieser Einheit lernst du, jede Verbindung vollständig zu beschreiben, Ports und Protokolle
nachvollziehbar anzunehmen und eine **Kommunikationsmatrix** zu erstellen, die erlaubte und verbotene Pfade
klar trennt. Sensible Datenklassen dürfen nie unverschlüsselt fließen. Die C#-Referenz `InventarWorkerService`
dient als Orientierung; die Lösung bleibt sprachneutral.

**EN:** In this unit you learn to describe each connection completely, to assume ports and protocols
traceably, and to build a **communication matrix** that clearly separates allowed and forbidden paths.
Sensitive data classes must never flow unencrypted. The C# reference `InventarWorkerService` serves as
orientation; the solution stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Schnittstelle / Interface | Definierter Übergang, über den zwei Knoten Daten austauschen. |
| Kommunikationsfluss / Communication flow | Konkreter Datenverkehr zwischen zwei Knoten mit Richtung und Zweck. |
| Pull / Push | Der Sammler holt Daten aktiv (Pull) oder der Agent sendet sie (Push). |
| Kommunikationsmatrix / Communication matrix | Tabelle, die jede Verbindung als erlaubt oder verboten dokumentiert. |
| Port / Protokoll / Port, protocol | Technischer Kanal und Regelsatz, über den zwei Knoten Daten austauschen. |
| Richtung / Direction | Angabe, wer die Verbindung aufbaut (ausgehend, eingehend, beidseitig). |
| Angriffsfläche / Attack surface | Summe aller erreichbaren Wege in ein System; kleiner ist sicherer. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Schnittstellen aus dem Kontext ableiten.** Übernimm die Knoten und Netzbezüge aus
Einheit 02 und bestimme, wo echte Schnittstellen liegen: Agent zu Sammler, Sammler zu Datenhaltung, Auswertung
zu Datenhaltung, ggf. Administration zu Sammler. Jede Schnittstelle wird später einzeln beschrieben.

**EN:** **Step 1 – Derive interfaces from the context.** Take the nodes and network relations from unit 02 and
determine where real interfaces are: agent to collector, collector to storage, analytics to storage, possibly
administration to collector. Each interface is described individually later.

**DE:** **Schritt 2 – Pull oder Push entscheiden.** Kläre je Sammel-Schnittstelle, ob der Sammler zieht oder
der Agent schiebt. Das entscheidet über die Richtung: Bei Push baut der Agent die Verbindung auf, bei Pull der
Sammler. Die Richtung bestimmt später, wo eine Firewall- oder Segmentregel greift.

**EN:** **Step 2 – Decide pull or push.** For each collection interface, clarify whether the collector pulls
or the agent pushes. This decides the direction: with push the agent initiates, with pull the collector. The
direction later determines where a firewall or segmentation rule applies.

**DE:** **Schritt 3 – Jede Verbindung vollständig beschreiben.** Eine Verbindung ohne Richtung und Zweck ist
für die Sicherheit wertlos. Notiere je Verbindung: Quelle, Ziel, Richtung, Zweck, Datenklasse und angenommenes
Protokoll. Für sensible Datenklassen ist ein verschlüsseltes Protokoll Pflicht; die konkrete Umsetzung folgt
in Einheit 05.

**EN:** **Step 3 – Describe each connection completely.** A connection without direction and purpose is
worthless for security. For each connection note: source, target, direction, purpose, data class, and assumed
protocol. For sensitive data classes an encrypted protocol is mandatory; the concrete implementation follows
in unit 05.

**DE:** **Schritt 4 – Verbotene Verbindungen festhalten.** Schreibe ausdrücklich auf, welche Verbindungen es
*nicht* geben darf, zum Beispiel: die Auswertung darf keinen direkten Zugriff auf die Sammel-Agenten haben.
Deny by default heißt: Was nicht ausdrücklich erlaubt ist, ist verboten. Unsichere Protokollannahmen markierst
du als `Open`.

**EN:** **Step 4 – Record forbidden connections.** Write down explicitly which connections must *not* exist,
for example: analytics must not have direct access to the collection agents. Deny by default means: whatever
is not explicitly allowed is forbidden. Mark uncertain protocol assumptions as `Open`.

**DE:** **Schritt 5 – Kommunikationsmatrix erstellen.** Fasse alles in einer Tabelle zusammen: je Zeile eine
Verbindung, Spalten für Quelle, Ziel, Richtung, Datenklasse, Protokoll und Status (erlaubt/verboten). Diese
Matrix ist der Nachweis, den Reviewende und die Segmentierungs-Einheit (04) direkt weiterverwenden.

**EN:** **Step 5 – Build the communication matrix.** Summarize everything in a table: each row a connection,
columns for source, target, direction, data class, protocol, and status (allowed/forbidden). This matrix is
the evidence that reviewers and the segmentation unit (04) reuse directly.

**DE:** **Typische Fehler.** Nur Erlaubtes beschreiben. Richtung oder Pull/Push offenlassen. Sensible Daten
unverschlüsselt übertragen. Administrations- und Sammelpfade vermischen. Annahmen als Tatsachen ausgeben statt
als `Open` zu markieren.

**EN:** **Common mistakes.** Describing only what is allowed. Leaving direction or pull/push open. Transmitting
sensitive data unencrypted. Mixing administration and collection paths. Presenting assumptions as facts
instead of marking them `Open`.

### Beispiel / Example

```text
Kommunikationsmatrix (Auszug):
  Quelle          Ziel              Richtung    Zweck            Datenklasse     Protokoll   Status
  Agent           Sammler-Dienst    ausgehend   Status melden    Betriebsdaten   verschl.    erlaubt (Push)
  Sammler-Dienst  Datenhaltung      ausgehend   Snapshot ablegen sensibel        verschl.    erlaubt
  Auswertung      Datenhaltung      ausgehend   aggregiert lesen Betriebsdaten   verschl.    erlaubt
  Auswertung      Agent             -           -                -               -           VERBOTEN
  Admin           Sammler-Dienst    ausgehend   Verwaltung       Secret          verschl.    erlaubt (Pruefung!)

Offene Annahme (Open): exakter Port des Admin-Zugangs noch nicht bestaetigt -> Folgeaktion
Secret in Beispielen nur als <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10d Cyber-physische Systeme entwickeln | Primär / Primary | Schnittstellen und Kommunikationsflüsse sind die Entwicklungsgrundlage des vernetzten Sammelns. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Pull/Push, Ports und Richtungen greifen die Grundlagen der Netzeinbindung direkt auf. |
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Berührt / Touched | Erlaubte und verbotene Flüsse bereiten die sichere Betriebsregelung vor. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, Angriffsfläche reduzieren, sichere
Schnittstellenverträge und sichere Konfiguration. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit),
`CL_02` (Architektur/Design), `CL_04` (Bedrohungsmodellierung) und `CL_08` (Sicherheits-Code-Review). Die
Sicherheitsentscheidung dieser Einheit lautet: *Nur ausdrücklich erlaubte Kommunikationsflüsse existieren;
sensible Daten fließen nie unverschlüsselt; alles andere ist verboten (deny by default).* A11Y-Aspekt: Die
Kommunikationsmatrix ist eine echte Tabelle mit Kopfzeile und darf nicht nur als Farbpfeil-Diagramm vorliegen,
damit sie mit Screenreader und Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: trust boundaries, attack surface reduction, secure
interface contracts, and secure configuration. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/design), `CL_04` (threat modeling), and `CL_08` (security code review). The security decision of
this unit is: *only explicitly allowed communication flows exist; sensitive data never flows unencrypted;
everything else is forbidden (deny by default).* Accessibility aspect: the communication matrix is a real
table with a header row and must not exist only as a color-arrow diagram, so it stays usable with a screen
reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DV) Was unterscheidet Pull von Push beim Sammeln und warum ist das sicherheitsrelevant? /
   **EN:** (DV) What distinguishes pull from push in collection, and why is that security-relevant?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei Pull baut der Sammler die Verbindung auf, bei Push der Agent. Das legt die Richtung fest und
   damit, welcher Knoten erreichbar sein muss und wo eine Firewall- oder Segmentregel greift.
   **EN:** With pull the collector initiates, with push the agent. This sets the direction and thus which node
   must be reachable and where a firewall or segmentation rule applies.

   </details>

2. **DE:** Warum reicht es nicht, nur die erlaubten Verbindungen zu dokumentieren? /
   **EN:** Why is documenting only the allowed connections not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Verbotene Verbindungen definieren die Angriffsfläche. Wird ein Pfad nicht ausdrücklich verboten,
   gilt er leicht als erlaubt. Deny by default verlangt, Verbotenes zu benennen und alles Unerlaubte zu
   blockieren.
   **EN:** Forbidden connections define the attack surface. If a path is not explicitly forbidden, it is easily
   treated as allowed. Deny by default requires naming what is forbidden and blocking everything not permitted.

   </details>

3. **DE:** Warum gehört zu jeder Verbindung eine Richtung? /
   **EN:** Why does every connection need a direction?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Richtung entscheidet, wer die Verbindung aufbaut und wer wen erreichen darf. Segment- und
   Firewall-Regeln arbeiten richtungsbezogen; ohne Richtung ist keine präzise Regel möglich.
   **EN:** The direction decides who initiates the connection and who may reach whom. Segment and firewall
   rules work by direction; without direction no precise rule is possible.

   </details>

4. **DE:** (DPA) Welche Datenklasse verlangt zwingend ein verschlüsseltes Protokoll und warum? /
   **EN:** (DPA) Which data class strictly requires an encrypted protocol, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sensible Daten und Secrets. Unverschlüsselt könnten sie auf dem Netzweg mitgelesen oder verändert
   werden. Verschlüsselung schützt Vertraulichkeit und Integrität an der Vertrauensgrenze.
   **EN:** Sensitive data and secrets. Unencrypted, they could be read or altered in transit. Encryption
   protects confidentiality and integrity at the trust boundary.

   </details>

5. **DE:** (AE) Wie beeinflusst der Kommunikationsfluss den Schnittstellenvertrag im Code? /
   **EN:** (AE) How does the communication flow influence the interface contract in code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Richtung, Format und Datenklasse legen fest, welche Operationen erlaubt sind, wer aufruft und welche
   Felder übertragen werden. Der Vertrag (z. B. Endpunkt, Nachrichtenschema) folgt direkt aus dem Fluss.
   **EN:** Direction, format, and data class define which operations are allowed, who calls, and which fields
   are transmitted. The contract (e.g. endpoint, message schema) follows directly from the flow.

   </details>

6. **DE:** Warum wird eine unsichere Protokollannahme als `Open` und nicht als erledigt markiert? /
   **EN:** Why is an uncertain protocol assumption marked `Open` and not as done?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine als erledigt dargestellte Annahme täuscht Sicherheit vor. `Open` macht die Unsicherheit
   sichtbar und erzwingt eine Bestätigung, bevor man sich darauf verlässt.
   **EN:** An assumption presented as done fakes security. `Open` makes the uncertainty visible and forces a
   confirmation before you rely on it.

   </details>

7. **DE:** Warum ist eine Tabelle für die Kommunikationsmatrix barrierefreier als ein Farbpfeil-Diagramm? /
   **EN:** Why is a table more accessible for the communication matrix than a color-arrow diagram?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Tabelle mit Kopfzeile ist mit Screenreader und Braille-Zeile lesbar und braucht keine Farbe, um
   Bedeutung zu tragen. Ein Farbpfeil-Diagramm schließt diese Nutzung aus.
   **EN:** A table with a header row is readable with a screen reader and Braille display and needs no color to
   carry meaning. A color-arrow diagram excludes that use.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Schnittstellen aus dem Systemkontext ableiten.
- [ ] je Sammel-Schnittstelle Pull oder Push entscheiden und begründen.
- [ ] jede Verbindung mit Quelle, Ziel, Richtung, Zweck, Datenklasse und Protokoll beschreiben.
- [ ] verbotene Verbindungen festhalten und deny by default anwenden.
- [ ] eine Kommunikationsmatrix erstellen, die erlaubte und verbotene Pfade trennt.
- [ ] unsichere Protokollannahmen als `Open` markieren.

**EN:** I can …

- [ ] derive interfaces from the system context.
- [ ] decide and justify pull or push per collection interface.
- [ ] describe each connection with source, target, direction, purpose, data class, and protocol.
- [ ] record forbidden connections and apply deny by default.
- [ ] build a communication matrix that separates allowed and forbidden paths.
- [ ] mark uncertain protocol assumptions as `Open`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_03_Schnittstellen-und-Kommunikationsfluesse.md`.
Sie baut auf Einheit 02 (`Systemkontext und Maschinen-/Netzbezüge`) auf; die Kommunikationsmatrix ist die
Grundlage für Einheit 04 (`Segmentierung und Vertrauenszonen`). Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_03_Schnittstellen-und-Kommunikationsfluesse.md`.
It builds on unit 02 (`system context and machine/network relations`); the communication matrix is the basis
for unit 04 (`segmentation and trust zones`). The copy-paste prompt for a later, manually started Spec Kit run
is provided in the intake.
