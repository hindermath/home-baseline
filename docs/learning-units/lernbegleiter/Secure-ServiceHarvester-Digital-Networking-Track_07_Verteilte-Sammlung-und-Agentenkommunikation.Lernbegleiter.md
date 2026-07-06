# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 07 – Verteilte Sammlung und Agentenkommunikation / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bisher haben wir den Sammel-Dienst als eine Einheit betrachtet. In der Praxis läuft auf vielen
Maschinen je ein kleiner **Agent**, der lokale Statusdaten erfasst und an einen zentralen Dienst schickt. Das
ist eine **verteilte Sammlung**. In dieser Einheit lernst du, wie Agenten und zentraler Dienst sicher
**kommunizieren**: über einen klaren **Nachrichtenvertrag**, mit **Authentifizierung** der Agenten und mit
Regeln für **Reihenfolge**, **Deduplizierung** und **Zustellgarantie**.

**EN:** So far we treated the collection service as one unit. In practice each of many machines runs a small
**agent** that captures local status data and sends it to a central service. This is a **distributed
collection**. In this unit you learn how agents and the central service communicate safely: through a clear
**message contract**, with **authentication** of the agents, and with rules for **ordering**,
**deduplication**, and **delivery guarantee**.

**DE:** Diese Einheit baut auf Verfügbarkeit, Timeouts und Wiederholstrategien (Einheit 06,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md))
auf und liefert die Grundlage für die Betriebs- und Netznachweise (Einheit 08,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.Lernbegleiter.md)).
Die Wiederhollogik aus Einheit 06 erklärt, warum Zustellgarantien und Idempotenz hier zusammengehören.

**EN:** This unit builds on availability, timeouts, and retry strategies (unit 06,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md))
and provides the basis for operational and network evidence (unit 08,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.Lernbegleiter.md)).
The retry logic from unit 06 explains why delivery guarantees and idempotency belong together here.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Agent / Agent | Kleines Programm auf einer Maschine, das lokale Statusdaten erfasst und meldet. |
| Verteilte Sammlung / Distributed collection | Sammeln über mehrere Maschinen oder Segmente statt an einem Ort. |
| Nachrichtenvertrag / Message contract | Verbindliche Struktur und Bedeutung der ausgetauschten Nachrichten. |
| Schema / Schema | Formale Beschreibung erlaubter Felder und Typen einer Nachricht. |
| Korrelations-ID / Correlation ID | Kennung, die zusammengehörige Nachrichten über Grenzen hinweg verknüpft. |
| Deduplizierung / Deduplication | Erkennen und Verwerfen doppelt eingetroffener Nachrichten. |
| Zustellgarantie / Delivery guarantee | Zusage wie „mindestens einmal" oder „höchstens einmal". |
| Vertrauensgrenze / Trust boundary | Stelle, an der Daten die Vertrauenszone wechseln und geprüft werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Agenten und zentralen Dienst abgrenzen.** Beschreibe, was ein Agent tut (lokal messen,
melden) und was der zentrale Dienst tut (annehmen, prüfen, zusammenführen). Zeichne die Systemgrenze: Die
Nachricht eines Agenten überquert eine **Vertrauensgrenze**, sobald sie den zentralen Dienst erreicht.

**EN:** **Step 1 – Delimit agents and central service.** Describe what an agent does (measure locally, report)
and what the central service does (accept, validate, consolidate). Draw the system boundary: an agent's message
crosses a **trust boundary** as soon as it reaches the central service.

**DE:** **Schritt 2 – Nachrichtenvertrag und Schema festlegen.** Lege fest, welche Felder eine Statusmeldung
hat (z. B. Maschinenname, Betriebssystem, Zeitpunkt) und welche Typen erlaubt sind. Ein klarer Vertrag macht
die Kommunikation sprachneutral: C#, Go, Java, Python, Rust und Swift können denselben Vertrag erfüllen.

**EN:** **Step 2 – Define message contract and schema.** Define which fields a status message has (e.g. machine
name, operating system, timestamp) and which types are allowed. A clear contract makes communication
language-neutral: C#, Go, Java, Python, Rust, and Swift can all fulfill the same contract.

**DE:** **Schritt 3 – Agenten authentifizieren und Rechte begrenzen.** Jeder Agent muss sich ausweisen, und
seine Nachrichten gelten trotzdem als nicht vertrauenswürdig und werden validiert. Nach dem Prinzip **Least
Privilege** darf ein Agent nur seine eigenen Statusdaten melden, nicht fremde Daten lesen oder verändern. So
bleibt der Schaden klein, wenn ein Agent kompromittiert wird.

**EN:** **Step 3 – Authenticate agents and limit rights.** Each agent must identify itself, and its messages are
still treated as untrusted and validated. Following **least privilege**, an agent may only report its own
status data, not read or change other data. This keeps the damage small if an agent is compromised.

**DE:** **Schritt 4 – Reihenfolge, Deduplizierung und Zustellgarantie.** Über das Netz können Nachrichten in
falscher Reihenfolge, doppelt oder gar nicht ankommen. Mit einer **Korrelations-ID** und einer laufenden
Nummer erkennt der Dienst Doppler und Lücken. Wähle bewusst eine Zustellgarantie: „mindestens einmal" braucht
Deduplizierung (aus Einheit 06 kennst du Idempotenz), „höchstens einmal" riskiert Verluste.

**EN:** **Step 4 – Ordering, deduplication, and delivery guarantee.** Over the network messages can arrive out
of order, twice, or not at all. With a **correlation ID** and a sequence number the service detects duplicates
and gaps. Deliberately choose a delivery guarantee: "at least once" needs deduplication (you know idempotency
from unit 06), "at most once" risks losses.

**DE:** **Schritt 5 – Nachweis planen.** Benenne je Entscheidung einen Nachweispfad, etwa einen Contract-Test
für das Schema, einen Test für doppelte Nachrichten und eine Prüfung, dass ein fremder Agent keine fremden
Daten melden darf. Positive Sicherheitsaussagen ohne Nachweis sind nur Wunschdenken.

**EN:** **Step 5 – Plan the evidence.** Name an evidence path per decision, for example a contract test for the
schema, a test for duplicate messages, and a check that a foreign agent may not report foreign data. Positive
security claims without evidence are only wishful thinking.

**DE:** **Typische Fehler.** Nachrichten von Agenten ungeprüft übernehmen. Kein festes Schema. Alle Agenten mit
denselben weiten Rechten. Zustellgarantie nicht bewusst wählen. Deduplizierung vergessen und dadurch doppelte
Statuswerte erzeugen.

**EN:** **Common mistakes.** Accepting agent messages unchecked. No fixed schema. All agents with the same broad
rights. Not choosing a delivery guarantee deliberately. Forgetting deduplication and thereby producing
duplicate status values.

### Beispiel / Example

```text
Agent:            misst lokal { name, os, last_contact }, sendet an zentralen Dienst
Vertrauensgrenze: Nachricht wird am zentralen Dienst validiert (nicht vertrauenswuerdig)
Nachrichtenvertrag: { agent_id, correlation_id, seq, name, os, last_contact }
Auth:             Agent weist sich aus; darf nur eigene agent_id melden (Least Privilege)
Zustellgarantie:  "mindestens einmal" -> Deduplizierung ueber (agent_id, seq)
Reihenfolge:      seq erlaubt Erkennen von Doppler und Luecken
Nachweis:         Contract-Test Schema + Dedup-Test + Test "fremde agent_id abgelehnt"
N/A:              Ende-zu-Ende-Verschluesselung pro Feld in dieser Einheit N/A -> begruendet
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10d Cyber-physische Systeme entwickeln | Primär / Primary | Die verteilte Sammlung wird als vernetztes System aus Agenten und Dienst entwickelt. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Agenten werden als Clients sicher in das Netz und den Dienst eingebunden. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Der zentrale Sammel-Dienst wird als vernetzter Dienst bereitgestellt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, Least Privilege, sichere Architektur und
Review-Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design), `CL_04`
(Bedrohungsmodell/Datenflüsse), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Agentennachrichten gelten als nicht vertrauenswürdig, jeder
Agent arbeitet mit minimalen Rechten, und die Zustellgarantie wird bewusst mit Deduplizierung gewählt.*
A11Y-Aspekt: Schema- und Zustelltabellen müssen als klarer Text ohne reine Farbmarkierung lesbar sein, damit
sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: trust boundaries, least privilege, secure architecture,
and review evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design),
`CL_04` (threat model/data flows), `CL_08` (security code review), and `CL_12` (evidence and closure). The
security decision of this unit is: *agent messages are treated as untrusted, each agent works with minimal
rights, and the delivery guarantee is deliberately chosen with deduplication.* Accessibility aspect: schema and
delivery tables must be readable as clear text without color-only marking, so they remain usable with a screen
reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gelten Nachrichten von Sammelagenten als nicht vertrauenswürdig? /
   **EN:** Why are messages from collection agents treated as untrusted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie kommen über das Netz von außen und können falsch, unvollständig, verspätet oder manipuliert
   sein. Ein Agent könnte auch kompromittiert sein. Deshalb werden die Nachrichten an der Vertrauensgrenze des
   zentralen Dienstes validiert, bevor sie weiterverarbeitet werden.
   **EN:** They arrive from outside over the network and can be wrong, incomplete, late, or manipulated. An
   agent could also be compromised. Therefore the messages are validated at the trust boundary of the central
   service before further processing.

   </details>

2. **DE:** Wozu dient ein klarer Nachrichtenvertrag mit Schema? /
   **EN:** What is a clear message contract with a schema used for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er legt verbindlich fest, welche Felder und Typen eine Nachricht hat. So können Agenten in
   verschiedenen Sprachen dieselbe Struktur erfüllen, der Dienst kann streng validieren, und Änderungen bleiben
   nachvollziehbar. Der Vertrag macht die Kommunikation prüfbar und sprachneutral.
   **EN:** It bindingly defines which fields and types a message has. Agents in different languages can fulfill
   the same structure, the service can validate strictly, and changes stay traceable. The contract makes
   communication testable and language-neutral.

   </details>

3. **DE:** Warum erhält jeder Agent nur minimale Rechte (Least Privilege)? /
   **EN:** Why does each agent receive only minimal rights (least privilege)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn ein Agent nur seine eigenen Statusdaten melden darf und nichts anderes lesen oder ändern kann,
   bleibt der Schaden klein, falls dieser Agent kompromittiert wird. Weite Rechte würden aus einem einzelnen
   kompromittierten Agenten ein Risiko für das ganze System machen.
   **EN:** If an agent may only report its own status data and cannot read or change anything else, the damage
   stays small if that agent is compromised. Broad rights would turn a single compromised agent into a risk for
   the whole system.

   </details>

4. **DE:** Was unterscheidet „mindestens einmal" von „höchstens einmal" bei der Zustellung? /
   **EN:** What distinguishes "at least once" from "at most once" delivery?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Mindestens einmal" stellt sicher, dass keine Nachricht verloren geht, kann aber Doppler erzeugen,
   die man deduplizieren muss. „Höchstens einmal" vermeidet Doppler, riskiert aber Verluste. Die Wahl hängt
   davon ab, ob Verlust oder Doppler das größere Problem ist.
   **EN:** "At least once" ensures no message is lost but can produce duplicates that must be deduplicated. "At
   most once" avoids duplicates but risks losses. The choice depends on whether loss or duplication is the
   bigger problem.

   </details>

5. **DE:** Wie hängen die Wiederhollogik aus Einheit 06 und die Deduplizierung hier zusammen? /
   **EN:** How are the retry logic from unit 06 and deduplication here related?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wiederholungen (Einheit 06) führen dazu, dass dieselbe Nachricht mehrfach ankommen kann.
   Deduplizierung erkennt diese Doppler anhand einer Kennung und verwirft sie. Idempotenz und Deduplizierung
   sorgen gemeinsam dafür, dass Wiederholungen die Datenqualität nicht verfälschen.
   **EN:** Retries (unit 06) can cause the same message to arrive several times. Deduplication detects these
   duplicates by an identifier and discards them. Idempotency and deduplication together ensure that retries do
   not corrupt data quality.

   </details>

6. **DE:** (DV) Warum ist eine Korrelations-ID in einer verteilten Sammlung nützlich? /
   **EN:** (DV) Why is a correlation ID useful in a distributed collection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Korrelations-ID verknüpft zusammengehörige Nachrichten über Agenten- und Systemgrenzen hinweg.
   So lassen sich Doppler erkennen, Abläufe nachvollziehen und Nachweise über mehrere Stationen hinweg führen,
   ohne personenbezogene Daten zu benötigen.
   **EN:** A correlation ID links related messages across agent and system boundaries. This allows detecting
   duplicates, tracing flows, and producing evidence across several stations without needing personal data.

   </details>

7. **DE:** Wie weist du nach, dass ein fremder Agent keine fremden Daten melden kann? /
   **EN:** How do you evidence that a foreign agent cannot report foreign data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem gezielten Test: Ein Agent versucht, unter einer fremden `agent_id` zu melden, und der
   Dienst weist die Nachricht ab. Der Testbericht ist der Nachweispfad für die Least-Privilege-Entscheidung.
   **EN:** With a targeted test: an agent tries to report under a foreign `agent_id`, and the service rejects
   the message. The test report is the evidence path for the least-privilege decision.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Agent und zentralen Dienst mit Systemgrenze beschreiben.
- [ ] einen Nachrichtenvertrag mit Schema entwerfen.
- [ ] erklären, warum Agentennachrichten validiert werden müssen.
- [ ] Least Privilege für Agenten anwenden und begründen.
- [ ] eine Zustellgarantie bewusst wählen und ihre Grenze benennen.
- [ ] je Kommunikationsentscheidung einen Nachweispfad angeben.

**EN:** I can …

- [ ] describe agent and central service with a system boundary.
- [ ] design a message contract with a schema.
- [ ] explain why agent messages must be validated.
- [ ] apply and justify least privilege for agents.
- [ ] deliberately choose a delivery guarantee and name its limit.
- [ ] give an evidence path for each communication decision.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort. Danach folgt Einheit 08
zu den Betriebs- und Netznachweisen.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there. Unit 08 on operational and
network evidence follows next.
