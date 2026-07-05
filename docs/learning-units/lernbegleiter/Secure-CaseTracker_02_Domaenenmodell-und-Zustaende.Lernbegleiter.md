# Lernbegleiter: Secure CaseTracker 02 – Domänenmodell und Zustände / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Programm verwaltet Dinge aus der echten Welt: Fälle, Kunden, Geräte, Arbeitsnotizen. Das
**Domänenmodell** beschreibt diese Dinge als Entitäten mit Feldern und Regeln. Besonders wichtig sind
**Zustände** und **Zustandsübergänge**: Ein Fall ist `new`, wird `in_progress`, dann `closed`. Manche Wechsel
sind erlaubt, andere nicht. Wenn ein `closed`-Fall plötzlich wieder `new` wird, weil eine ungeprüfte Eingabe
das erlaubt, entstehen Fehler und Sicherheitslücken. In dieser Einheit modellierst du ein kleines, sicheres
Datenmodell und legst genau fest, welche Zustandswechsel gültig sind.

**EN:** A program manages things from the real world: cases, customers, devices, work notes. The **domain
model** describes these things as entities with fields and rules. Especially important are **states** and
**state transitions**: a case is `new`, becomes `in_progress`, then `closed`. Some transitions are allowed,
others are not. If a `closed` case suddenly becomes `new` again because an unchecked input allows it, errors
and security holes appear. In this unit you model a small, secure data model and define exactly which state
transitions are valid.

**DE:** Du definierst die Entitäten `Case`, `Customer`, `Asset`, `WorkLog` und `AuditEntry`, ihre Pflicht-
und optionalen Felder sowie die erlaubten und verbotenen Zustandswechsel.

**EN:** You define the entities `Case`, `Customer`, `Asset`, `WorkLog`, and `AuditEntry`, their mandatory and
optional fields, and the allowed and forbidden state transitions.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Domänenmodell / Domain model | Beschreibung der fachlichen Dinge (Entitäten) mit Feldern und Regeln. |
| Entität / Entity | Ein fachliches Objekt wie `Case` oder `Customer`. |
| Zustand / State | Eine Lage, in der sich eine Entität befinden kann, z. B. `in_progress`. |
| Zustandsübergang / State transition | Wechsel von einem Zustand in einen anderen. |
| Invariante / Invariant | Regel, die immer gelten muss, egal was passiert. |
| Datenminimierung / Data minimization | Nur wirklich benötigte Felder speichern. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Entitäten und Zweck festlegen.** Beschreibe jede Entität mit einem klaren Zweck:
`Case` ist der Vorgang, `Customer` die Kontaktperson, `Asset` das betroffene Gerät, `WorkLog` die
Bearbeitungsnotiz, `AuditEntry` der Nachweis. Warum zuerst der Zweck? Ohne Zweck sammelt man leicht Felder,
die niemand braucht.

**EN:** **Step 1 – Define entities and purpose.** Describe each entity with a clear purpose: `Case` is the
matter, `Customer` the contact person, `Asset` the affected device, `WorkLog` the work note, `AuditEntry` the
evidence. Why the purpose first? Without a purpose you easily collect fields nobody needs.

**DE:** **Schritt 2 – Pflichtfelder und optionale Felder trennen.** Lege für jede Entität fest, welche Felder
zwingend sind und welche optional. Jedes Pflichtfeld braucht eine fachliche Begründung. Warum trennen?
Zu viele Pflichtfelder blockieren die Arbeit, zu wenige lassen unvollständige Daten zu.

**EN:** **Step 2 – Separate mandatory and optional fields.** For each entity, define which fields are
required and which are optional. Every mandatory field needs a functional justification. Why separate? Too
many mandatory fields block the work, too few allow incomplete data.

**DE:** **Schritt 3 – Zustände und erlaubte Übergänge definieren.** Nutze eine Zustandsmatrix. Beispiel:
`new -> in_progress` erlaubt, `in_progress -> waiting_for_customer` erlaubt, `closed -> new` verboten. Warum
eine Matrix? Sie zeigt lückenlos, welche Wechsel möglich sind, und macht verbotene Wechsel sichtbar.

**EN:** **Step 3 – Define states and allowed transitions.** Use a state matrix. Example: `new -> in_progress`
allowed, `in_progress -> waiting_for_customer` allowed, `closed -> new` forbidden. Why a matrix? It shows
completely which transitions are possible and makes forbidden transitions visible.

**DE:** **Schritt 4 – Regeln in die Kernlogik legen.** Ein Zustandswechsel darf nie allein durch einen
ungeprüften Eingabewert entstehen. Die Regel gehört in das Modell bzw. die Kernlogik, nicht nur in die
Oberfläche. Warum? Oberflächen lassen sich umgehen; nur eine Regel in der Kernlogik schützt zuverlässig.

**EN:** **Step 4 – Put rules into the core logic.** A state transition must never happen from an unchecked
input value alone. The rule belongs in the model or core logic, not only in the UI. Why? UIs can be bypassed;
only a rule in the core logic protects reliably.

**DE:** **Typische Fehler.** Nur Erfolgspfade modellieren und Fehlerfälle vergessen. Interne IDs mit
personenbezogenen Informationen füllen. Freitext ohne Zweck und Längenbegrenzung. Verbotene Zustandswechsel
nicht ausdrücklich nennen. Audit-Daten mit fachlichen Notizen vermischen.

**EN:** **Common mistakes.** Modeling only success paths and forgetting error cases. Filling internal IDs
with personal information. Free text without purpose and length limit. Not explicitly naming forbidden state
transitions. Mixing audit data with functional notes.

### Beispiel / Example

```text
Entitaet Case:     Pflicht: id, status, createdAt   Optional: assetRef, note
Zustaende:         new, in_progress, waiting_for_customer, closed, rejected
Erlaubt:           new -> in_progress, in_progress -> waiting_for_customer, in_progress -> closed
Erlaubt:           new -> rejected, waiting_for_customer -> in_progress
Verboten:          closed -> new, closed -> in_progress, rejected -> closed
Regel:             Uebergang nur ueber geprueften Methodenaufruf, nie direkt aus Rohdaten.
Datenschutz:       id ist technisch (kein Name), note hat Zweck + Laengenlimit, AuditEntry getrennt.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Ein sauberes Datenmodell mit Zuständen ist die Grundlage der Datenverwaltung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Ungültige Zustandswechsel und datenhungrige Felder sind ein Schutzbedarfsthema. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Code-Erzeugung und Datenschutz
durch Datenminimierung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Modellentscheidungen) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser
Einheit lautet: *Zustandsregeln liegen im Modell, nicht in der Oberfläche, und verbotene Übergänge sind
ausdrücklich benannt.* A11Y-Aspekt: Zustandsübergänge werden als Textmatrix oder klare Liste dargestellt,
nicht nur als Farbdiagramm, damit sie mit Screenreader und Braille-Zeile lesbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure code generation, and privacy
through data minimization. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/model decisions), and `CL_08` (security code review). The security decision of this unit is:
*state rules live in the model, not in the UI, and forbidden transitions are explicitly named.* Accessibility
aspect: state transitions are shown as a text matrix or clear list, not only as a color diagram, so they
remain readable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum müssen verbotene Zustandswechsel ausdrücklich genannt werden? /
   **EN:** Why must forbidden state transitions be explicitly named?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur benannte Verbote lassen sich prüfen und testen. Ein nicht genannter verbotener Wechsel kann
   versehentlich zugelassen werden und zu falschen Zuständen führen.
   **EN:** Only named prohibitions can be checked and tested. An unnamed forbidden transition can be allowed
   by accident and lead to wrong states.

   </details>

2. **DE:** (AE) Welche Regel gehört ins Domänenmodell und nicht erst in die UI? /
   **EN:** (AE) Which rule belongs in the domain model and not only in the UI?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zustandsregeln und Pflichtfeld-Prüfungen. Sie müssen dort greifen, wo die Daten wirklich verändert
   werden, weil die UI umgangen werden kann.
   **EN:** State rules and mandatory-field checks. They must apply where the data is really changed, because
   the UI can be bypassed.

   </details>

3. **DE:** Warum darf ein Zustandswechsel nicht allein aus einem ungeprüften Eingabewert entstehen? /
   **EN:** Why must a state transition not result from an unchecked input value alone?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sonst kann eine manipulierte Eingabe einen ungültigen Zustand erzwingen. Der Wechsel muss über eine
   geprüfte Regel laufen, die nur erlaubte Übergänge zulässt.
   **EN:** Otherwise a manipulated input can force an invalid state. The transition must go through a checked
   rule that only allows permitted transitions.

   </details>

4. **DE:** Warum dürfen interne IDs keine personenbezogenen Informationen enthalten? /
   **EN:** Why must internal IDs not contain personal information?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** IDs erscheinen in Logs, URLs und Exporten. Enthalten sie Namen oder E-Mail-Adressen, entsteht ein
   Datenschutzrisiko und ein unnötiger Personenbezug.
   **EN:** IDs appear in logs, URLs, and exports. If they contain names or email addresses, a privacy risk and
   unnecessary personal reference arise.

   </details>

5. **DE:** (SI) Welche Felder helfen im Betrieb, ohne den Datenschutz unnötig zu belasten? /
   **EN:** (SI) Which fields help operations without unnecessarily burdening privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Technische Felder wie Status, Zeitstempel und Asset-Bezug helfen bei Betrieb und Nachvollzug, ohne
   dass Freitexte oder personenbezogene Details nötig sind.
   **EN:** Technical fields such as status, timestamps, and asset reference help operations and traceability
   without needing free text or personal details.

   </details>

6. **DE:** (DPA) Welche Datenqualität brauchst du im Modell für spätere Kennzahlen? /
   **EN:** (DPA) Which data quality does the model need for later metrics?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klare Pflichtfelder, gültige Zustände und verlässliche Zeitstempel. Nur so lassen sich
   Durchlaufzeit oder Fallzahlen korrekt berechnen.
   **EN:** Clear mandatory fields, valid states, and reliable timestamps. Only then can throughput time or
   case counts be calculated correctly.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] jede Entität mit Zweck, Pflicht- und optionalen Feldern beschreiben.
- [ ] erlaubte Zustandsübergänge in einer Matrix darstellen.
- [ ] verbotene Zustandswechsel ausdrücklich nennen.
- [ ] erklären, warum Zustandsregeln in der Kernlogik liegen müssen.
- [ ] begründen, welche Felder aus Datenschutzgründen nicht gespeichert werden.

**EN:** I can …

- [ ] describe each entity with purpose, mandatory, and optional fields.
- [ ] show allowed state transitions in a matrix.
- [ ] explicitly name forbidden state transitions.
- [ ] explain why state rules must live in the core logic.
- [ ] justify which fields are not stored for privacy reasons.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
