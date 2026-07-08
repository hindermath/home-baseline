# Lernbegleiter: Secure OrderDesk Digital Networking Track 07 – Verteilte Integration und Agentenkommunikation / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Bestell-Pipeline von Secure Trader ist nicht ein einziges Programm, sondern mehrere Dienste, die
über das Netz zusammenarbeiten: die Bestellannahme, die Katalogabfrage und die Persistenz in der relationalen
Ablage. Damit diese Dienste sicher zusammenspielen, brauchst du klare **Nachrichtenverträge** (welche Felder,
welches Format), **Agenten-Authentifizierung** (wer darf welche Nachricht senden), **Korrelations-IDs** (welche
Nachricht gehört zu welcher Bestellung) und eine bewusste **Zustellgarantie**. In dieser Einheit entwirfst du
die verteilte Integration so, dass eine Bestellung für einen Kunden wie `ALFKI` vollständig, in richtiger
Reihenfolge und ohne Doppelung ankommt.

**EN:** Secure Trader's order pipeline is not a single program but several services cooperating over the
network: order intake, catalog lookup, and persistence in the relational store. For these services to interact
safely you need clear **message contracts** (which fields, which format), **agent authentication** (who may
send which message), **correlation IDs** (which message belongs to which order), and a deliberate **delivery
guarantee**. In this unit you design the distributed integration so that an order for a customer such as
`ALFKI` arrives completely, in the correct order, and without duplication.

**DE:** Diese Einheit baut auf Verfügbarkeit und Wiederholung (Einheit 06,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md))
auf und liefert die Grundlage für Betriebs- und Netznachweise (Einheit 08). Der Nachrichtenvertrag bleibt
sprachneutral für C#, Go, Java, Python, Rust und Swift.

**EN:** This unit builds on availability and retries (unit 06,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.Lernbegleiter.md))
and provides the basis for operational and network evidence (unit 08). The message contract stays
language-neutral for C#, Go, Java, Python, Rust, and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Verteilte Integration / Distributed integration | Mehrere Dienste arbeiten über das Netz an einer gemeinsamen Aufgabe zusammen. |
| Nachrichtenvertrag / Message contract | Verbindliche Vereinbarung über Felder, Typen und Format einer Nachricht. |
| Schema / Schema | Formale Beschreibung, gegen die eine Nachricht validiert wird. |
| Korrelations-ID / Correlation ID | Kennung, die alle Nachrichten eines Bestellvorgangs verbindet. |
| Agenten-Authentifizierung / Agent authentication | Nachweis, dass ein sendender Dienst wirklich der ist, der er zu sein vorgibt. |
| Deduplizierung / Deduplication | Erkennen und Verwerfen doppelt empfangener Nachrichten. |
| Zustellgarantie / Delivery guarantee | Zusage, wie oft eine Nachricht mindestens oder höchstens ankommt. |
| Least Privilege / Least Privilege | Jeder Dienst erhält nur die minimal nötigen Rechte. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Dienste und Grenzen benennen.** Zeichne, welche Dienste es gibt (Bestellannahme,
Katalog, relationale Ablage) und wo die Vertrauensgrenzen liegen. Jede Grenze ist ein Ort, an dem Nachrichten
geprüft werden müssen, weil sie von einem anderen Dienst kommen und nicht blind vertraut werden dürfen.

**EN:** **Step 1 – Name services and boundaries.** Draw which services exist (order intake, catalog, relational
store) and where the trust boundaries are. Each boundary is a place where messages must be validated, because
they come from another service and must not be trusted blindly.

**DE:** **Schritt 2 – Nachrichtenvertrag und Schema festlegen.** Beschreibe für jede Nachricht die Felder,
Typen und Pflichtangaben, etwa eine Bestellnachricht mit `CustomerID` (z. B. `ALFKI`), Positionen,
`Quantity` und `OrderDate`. Ein Schema macht die Nachricht prüfbar. So erkennst du fehlerhafte oder
manipulierte Nachrichten früh.

**EN:** **Step 2 – Define message contract and schema.** For each message describe the fields, types, and
mandatory entries, for example an order message with `CustomerID` (e.g. `ALFKI`), line items, `Quantity`, and
`OrderDate`. A schema makes the message checkable. This lets you detect faulty or tampered messages early.

**DE:** **Schritt 3 – Korrelation und Reihenfolge.** Vergib je Bestellvorgang eine Korrelations-ID. Damit
findest du zusammengehörende Nachrichten wieder und kannst prüfen, ob die Reihenfolge stimmt (z. B. erst
Bestellung anlegen, dann Position hinzufügen). Reihenfolgeprobleme führen sonst zu inkonsistenten Bestellungen.

**EN:** **Step 3 – Correlation and ordering.** Assign a correlation ID per order operation. This lets you find
related messages again and check whether the order is correct (e.g. create the order first, then add a line
item). Otherwise ordering problems lead to inconsistent orders.

**DE:** **Schritt 4 – Authentifizierung und Least Privilege.** Jeder Dienst weist sich aus, bevor seine
Nachrichten angenommen werden. Jeder Dienst erhält nur die Rechte, die er braucht: Der Katalogdienst darf lesen,
aber keine Bestellungen löschen. Ein kompromittierter Dienst darf so keinen Vollzugriff auf die relationale
Ablage bedeuten.

**EN:** **Step 4 – Authentication and least privilege.** Each service authenticates before its messages are
accepted. Each service gets only the rights it needs: the catalog service may read but not delete orders. A
compromised service must therefore not mean full access to the relational store.

**DE:** **Schritt 5 – Zustellgarantie wählen und Deduplizierung.** Entscheide bewusst zwischen „mindestens
einmal" (Nachricht kann doppelt ankommen, daher Deduplizierung nötig) und „höchstens einmal" (Nachricht kann
verloren gehen). Für Bestellungen ist meist „mindestens einmal" mit Deduplizierung über die Korrelations-ID
sinnvoll, damit keine Bestellung verloren geht und keine Doppelbestellung entsteht. Benenne je Entscheidung die
Grenze.

**EN:** **Step 5 – Choose a delivery guarantee and deduplication.** Deliberately decide between "at least once"
(a message may arrive twice, so deduplication is needed) and "at most once" (a message may be lost). For orders,
"at least once" with deduplication via the correlation ID is usually sensible, so no order is lost and no
duplicate order is created. Name the limit of each decision.

**DE:** **Typische Fehler.** Nachrichten ohne Schema annehmen. Keine Korrelations-ID vergeben. Jedem Dienst
Vollzugriff geben. Zustellgarantie nicht benennen. Deduplizierung vergessen und so Doppelbestellungen erzeugen.
Secrets oder echte Kundendaten in Nachrichten schreiben.

**EN:** **Common mistakes.** Accepting messages without a schema. Assigning no correlation ID. Giving every
service full access. Not naming the delivery guarantee. Forgetting deduplication and thus creating duplicate
orders. Writing secrets or real customer data into messages.

### Beispiel / Example

```text
Dienste:          Bestellannahme -> Katalog (lesen) -> relationale Ablage (schreiben)
Nachricht:        OrderPlaced { order_key, CustomerID=ALFKI, items[], OrderDate }
Schema:           Pflichtfelder geprueft; unbekannte Felder abgelehnt
Korrelation:      order_key verbindet alle Nachrichten eines Bestellvorgangs
Auth:             jeder Dienst authentifiziert; Katalog nur Lese-Recht (Least Privilege)
Zustellgarantie:  mindestens einmal + Deduplizierung ueber order_key
Reihenfolge:      Bestellung anlegen vor Positionen hinzufuegen
N/A:              Event-Sourcing-Store in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10d Cyber-physische Systeme entwickeln | Primär / Primary | Die verteilte Bestell-Pipeline wird als vernetztes System entworfen. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Dienste werden als Clients eingebunden und authentifiziert. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Nachrichtenverträge und Zustelllogik gehören zur Dienstbereitstellung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries, Least Privilege und
Review-Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design), `CL_04`
(Eingabevalidierung/Trust Boundaries), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss).
Die Sicherheitsentscheidung dieser Einheit lautet: *Nachrichten werden an jeder Vertrauensgrenze validiert,
Dienste sind authentifiziert und minimal berechtigt, und die Zustellgarantie ist bewusst gewählt.* A11Y-Aspekt:
Nachrichten- und Rechte-Tabellen müssen als klarer Text ohne reine Farbmarkierung lesbar sein, damit sie mit
Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, least privilege, and
review evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design), `CL_04`
(input validation/trust boundaries), `CL_08` (security code review), and `CL_12` (evidence and closure). The
security decision of this unit is: *messages are validated at every trust boundary, services are authenticated
and minimally privileged, and the delivery guarantee is deliberately chosen.* Accessibility aspect: message and
permission tables must be readable as clear text without color-only marking, so they remain usable with a
screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum braucht die verteilte Bestell-Pipeline einen Nachrichtenvertrag mit Schema? /
   **EN:** Why does the distributed order pipeline need a message contract with a schema?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Vertrag und Schema weiß ein empfangender Dienst nicht sicher, welche Felder gültig sind. Falsche
   oder manipulierte Nachrichten würden verarbeitet und könnten inkonsistente Bestellungen erzeugen. Das Schema
   erlaubt frühe Validierung an der Vertrauensgrenze und macht die Kommunikation prüfbar.
   **EN:** Without a contract and schema a receiving service cannot be sure which fields are valid. Wrong or
   tampered messages would be processed and could create inconsistent orders. The schema allows early validation
   at the trust boundary and makes the communication checkable.

   </details>

2. **DE:** Wofür dient die Korrelations-ID in einem Bestellvorgang? /
   **EN:** What is the correlation ID used for in an order operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie verbindet alle Nachrichten, die zu einer Bestellung gehören. So kann die Plattform zusammengehörende
   Schritte wiederfinden, die Reihenfolge prüfen und doppelt empfangene Nachrichten erkennen. Ohne sie wäre die
   Zuordnung über mehrere Dienste hinweg unsicher.
   **EN:** It connects all messages belonging to one order. This lets the platform find related steps, check the
   ordering, and detect duplicate messages. Without it, mapping across several services would be unreliable.

   </details>

3. **DE:** Was bedeutet „mindestens einmal" gegenüber „höchstens einmal"? /
   **EN:** What does "at least once" mean versus "at most once"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Mindestens einmal" heißt: eine Nachricht geht nicht verloren, kann aber doppelt ankommen, weshalb
   Deduplizierung nötig ist. „Höchstens einmal" heißt: eine Nachricht kommt nie doppelt, kann aber verloren gehen.
   Für Bestellungen ist „mindestens einmal" mit Deduplizierung meist der sicherere Kompromiss.
   **EN:** "At least once" means a message is not lost but may arrive twice, so deduplication is needed. "At most
   once" means a message never arrives twice but may be lost. For orders, "at least once" with deduplication is
   usually the safer compromise.

   </details>

4. **DE:** Warum erhält der Katalogdienst nicht dieselben Rechte wie die relationale Ablage? /
   **EN:** Why does the catalog service not get the same rights as the relational store?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nach Least Privilege bekommt jeder Dienst nur die Rechte, die er für seine Aufgabe braucht. Der Katalog
   liest Produktdaten und braucht kein Schreib- oder Löschrecht auf Bestellungen. Wird er kompromittiert, bleibt
   der Schaden begrenzt, weil er keinen Vollzugriff hat.
   **EN:** By least privilege each service gets only the rights it needs for its task. The catalog reads product
   data and needs no write or delete right on orders. If it is compromised, the damage stays limited because it
   has no full access.

   </details>

5. **DE:** (AE) Wie verhindert Deduplizierung eine Doppelbestellung für `ALFKI`? /
   **EN:** (AE) How does deduplication prevent a duplicate order for `ALFKI`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Bestellnachricht trägt eine eindeutige Korrelations- bzw. Idempotenz-ID. Kommt eine Nachricht mit
   bereits bekannter ID erneut an, erkennt die Plattform die Wiederholung und verwirft sie, statt eine zweite
   Bestellung anzulegen. So bleibt `ALFKI` bei genau einer Bestellung.
   **EN:** Each order message carries a unique correlation or idempotency ID. If a message with an already known ID
   arrives again, the platform recognizes the repeat and discards it instead of creating a second order. So
   `ALFKI` keeps exactly one order.

   </details>

6. **DE:** (DV) Wie weist du nach, dass die Agentenkommunikation sicher und vollständig ist? /
   **EN:** (DV) How do you evidence that the agent communication is safe and complete?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit Tests, die eine gültige, eine schemaverletzende und eine doppelte Nachricht senden, sowie mit einem
   Nachweis, dass nicht authentifizierte Dienste abgewiesen werden. Man prüft Schema-Validierung, Deduplizierung
   über die Korrelations-ID und die Rechteprüfung. Diese Tests und Logs sind der Nachweispfad.
   **EN:** With tests that send a valid, a schema-violating, and a duplicate message, plus proof that
   unauthenticated services are rejected. You check schema validation, deduplication via the correlation ID, and
   the permission check. These tests and logs are the evidence path.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Dienste der Bestell-Pipeline und ihre Vertrauensgrenzen benennen.
- [ ] einen Nachrichtenvertrag mit Schema und Pflichtfeldern beschreiben.
- [ ] die Rolle einer Korrelations-ID erklären.
- [ ] „mindestens einmal" von „höchstens einmal" unterscheiden und eine Wahl begründen.
- [ ] Least Privilege je Dienst anwenden.
- [ ] je Kommunikationsentscheidung einen Nachweispfad angeben.

**EN:** I can …

- [ ] name the services of the order pipeline and their trust boundaries.
- [ ] describe a message contract with schema and mandatory fields.
- [ ] explain the role of a correlation ID.
- [ ] distinguish "at least once" from "at most once" and justify a choice.
- [ ] apply least privilege per service.
- [ ] give an evidence path for each communication decision.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort. Danach folgt Einheit 08
zu Betriebs- und Netznachweisen.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there. Unit 08 on operational and
network evidence follows next.
