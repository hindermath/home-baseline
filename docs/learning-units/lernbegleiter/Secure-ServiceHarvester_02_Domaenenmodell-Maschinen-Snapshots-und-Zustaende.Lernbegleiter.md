# Lernbegleiter: Secure ServiceHarvester 02 – Domänenmodell: Maschinen, Snapshots und Zustände / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_02_Domaenenmodell-Maschinen-Snapshots-und-Zustaende.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester sammelt regelmäßig Statusdaten von Maschinen. Damit die Daten verlässlich sind,
braucht er ein sauberes **Domänenmodell**. Dabei gibt es zwei Arten von Daten: **Stammdaten**, die sich
selten ändern (eine Maschine mit `name` und `os`), und **Snapshots**, also zeitliche Momentaufnahmen, die
sich bei jeder Sammlung ändern (`last_contact`, `status`, `collectedAt`). Eine Maschine hat viele Snapshots –
das ist ein **Master-Detail-Muster**. Zusätzlich kann sich eine Maschine in einem **Zustand** befinden, z. B.
`online`, `stale` (länger nichts gehört) oder `offline`. Manche Wechsel sind sinnvoll, andere nicht. In dieser
Einheit modellierst du ein kleines, sicheres Datenmodell und legst genau fest, welche Zustandswechsel gültig
sind.

**EN:** The ServiceHarvester regularly collects status data from machines. For the data to be reliable, it
needs a clean **domain model**. There are two kinds of data: **master data** that rarely changes (a machine
with `name` and `os`), and **snapshots**, i.e. point-in-time records that change with every collection
(`last_contact`, `status`, `collectedAt`). One machine has many snapshots – this is a **master-detail
pattern**. In addition, a machine can be in a **state**, e.g. `online`, `stale` (nothing heard for a while),
or `offline`. Some transitions make sense, others do not. In this unit you model a small, secure data model
and define exactly which state transitions are valid.

**DE:** Du definierst die Entitäten `Machine` (Stammdaten), `Snapshot` (zeitlicher Zustand) und `AuditEntry`
(Nachweis über Änderungen), ihre Pflicht- und optionalen Felder sowie die erlaubten und verbotenen
Zustandswechsel. Die C#-Referenz ist der `InventarWorkerService`.

**EN:** You define the entities `Machine` (master data), `Snapshot` (time-based state), and `AuditEntry`
(evidence of changes), their mandatory and optional fields, and the allowed and forbidden state transitions.
The C# reference is the `InventarWorkerService`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Domänenmodell / Domain model | Beschreibung der fachlichen Dinge (Entitäten) mit Feldern und Regeln. |
| Stammdaten / Master data | Daten einer Maschine, die sich selten ändern, z. B. `name`, `os`. |
| Snapshot / Snapshot | Zeitliche Momentaufnahme des Status, z. B. `last_contact`, `status`, `collectedAt`. |
| Master-Detail / Master-detail | Muster: eine Maschine (Master) hat viele Snapshots (Detail). |
| Zustand / State | Lage einer Maschine, z. B. `online`, `stale`, `offline`, `unknown`. |
| Datenminimierung / Data minimization | Nur wirklich benötigte Felder speichern. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Stammdaten und Snapshots trennen.** Beschreibe `Machine` als Stammdatensatz mit
`id`, `name`, `os`. Beschreibe `Snapshot` als zeitlichen Eintrag mit `machineRef`, `collectedAt`,
`last_contact` und `status`. Warum trennen? Weil Stammdaten sich selten ändern und Snapshots ständig. Vermischt
man beides, überschreibt jede Sammlung die Stammdaten oder man verliert die Historie.

**EN:** **Step 1 – Separate master data and snapshots.** Describe `Machine` as a master record with `id`,
`name`, `os`. Describe `Snapshot` as a time-based entry with `machineRef`, `collectedAt`, `last_contact`, and
`status`. Why separate? Because master data rarely changes while snapshots change constantly. Mixing both means
each collection overwrites the master data or you lose the history.

**DE:** **Schritt 2 – Pflichtfelder und optionale Felder trennen.** Lege für jede Entität fest, welche Felder
zwingend sind. `Snapshot` braucht mindestens `machineRef`, `collectedAt` und `status`. Jedes Pflichtfeld
braucht eine fachliche Begründung. Warum? Zu viele Pflichtfelder blockieren die Sammlung, zu wenige lassen
unvollständige Snapshots zu.

**EN:** **Step 2 – Separate mandatory and optional fields.** For each entity, define which fields are
required. `Snapshot` needs at least `machineRef`, `collectedAt`, and `status`. Every mandatory field needs a
functional justification. Why? Too many mandatory fields block the collection, too few allow incomplete
snapshots.

**DE:** **Schritt 3 – Zustände und erlaubte Übergänge definieren.** Nutze eine Zustandsmatrix. Beispiel:
`unknown -> online` erlaubt, `online -> stale` erlaubt (lange kein Kontakt), `stale -> offline` erlaubt,
`offline -> online` erlaubt (Maschine meldet sich wieder). Ein Wechsel, der eine Historie verfälscht, etwa
das Rückdatieren eines Snapshots, ist verboten. Warum eine Matrix? Sie zeigt lückenlos, welche Wechsel möglich
sind, und macht verbotene Wechsel sichtbar.

**EN:** **Step 3 – Define states and allowed transitions.** Use a state matrix. Example: `unknown -> online`
allowed, `online -> stale` allowed (no contact for a while), `stale -> offline` allowed, `offline -> online`
allowed (machine reports again). A transition that falsifies history, such as back-dating a snapshot, is
forbidden. Why a matrix? It shows completely which transitions are possible and makes forbidden transitions
visible.

**DE:** **Schritt 4 – Regeln in die Kernlogik legen und Audit trennen.** Ein Zustandswechsel darf nie allein
aus einem rohen gesammelten Wert entstehen; er läuft über eine geprüfte Regel. Änderungen werden in einem
`AuditEntry` festgehalten, getrennt von den fachlichen Statusdaten. Warum? Nur so bleibt nachvollziehbar, wer
oder was wann etwas geändert hat, ohne die Statusdaten selbst zu belasten.

**EN:** **Step 4 – Put rules into the core logic and separate audit.** A state transition must never result
from a raw collected value alone; it goes through a checked rule. Changes are recorded in an `AuditEntry`,
separate from the functional status data. Why? Only then does it stay traceable who or what changed something
and when, without burdening the status data itself.

**DE:** **Typische Fehler.** Stammdaten und Snapshots in eine Tabelle mischen. Nur Erfolgspfade modellieren
und Fehlerfälle vergessen. Interne IDs mit personenbezogenen Informationen füllen (z. B. den Nutzernamen als
Maschinen-ID). Snapshots mit unnötigen Feldern überladen. Verbotene Zustandswechsel nicht ausdrücklich nennen.
Audit-Daten mit Statusdaten vermischen.

**EN:** **Common mistakes.** Mixing master data and snapshots into one table. Modeling only success paths and
forgetting error cases. Filling internal IDs with personal information (e.g. the user name as machine ID).
Overloading snapshots with unnecessary fields. Not explicitly naming forbidden state transitions. Mixing audit
data with status data.

### Beispiel / Example

```text
Entitaet Machine:   Pflicht: id, name, os            Optional: location_label
Entitaet Snapshot:  Pflicht: machineRef, collectedAt, status   Optional: last_contact, note
Zustaende:          unknown, online, stale, offline
Erlaubt:            unknown -> online, online -> stale, stale -> offline, offline -> online
Erlaubt:            stale -> online (Maschine meldet sich wieder)
Verboten:           Snapshot rueckdatieren, Zustand ohne neuen Snapshot setzen, offline -> stale
Regel:              Uebergang nur ueber geprueften Methodenaufruf, nie direkt aus Rohdaten.
Datenschutz:        id ist technisch (kein Name), note hat Zweck + Laengenlimit, AuditEntry getrennt.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Ein sauberes Datenmodell aus Stammdaten, Snapshots und Zuständen ist die Grundlage der Datenverwaltung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Ungültige Zustandswechsel und datenhungrige Snapshot-Felder sind ein Schutzbedarfsthema. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Code-Erzeugung und Datenschutz
durch Datenminimierung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Modellentscheidungen) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser
Einheit lautet: *Zustandsregeln liegen im Modell, nicht in der Oberfläche, Snapshots sind unveränderlich, und
verbotene Übergänge sind ausdrücklich benannt.* A11Y-Aspekt: Zustandsübergänge werden als Textmatrix oder
klare Liste dargestellt, nicht nur als Farbdiagramm, damit sie mit Screenreader und Braille-Zeile lesbar
bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure code generation, and privacy
through data minimization. Matching checklists: `CL_01` (standards applicability), `CL_02`
(architecture/model decisions), and `CL_08` (security code review). The security decision of this unit is:
*state rules live in the model, not in the UI, snapshots are immutable, and forbidden transitions are
explicitly named.* Accessibility aspect: state transitions are shown as a text matrix or clear list, not only
as a color diagram, so they remain readable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt man Stammdaten (`Machine`) und zeitliche Snapshots? /
   **EN:** Why separate master data (`Machine`) and time-based snapshots?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stammdaten ändern sich selten, Snapshots bei jeder Sammlung. Getrennt bleibt die Historie erhalten
   und die Stammdaten werden nicht bei jeder Sammlung überschrieben. Vermischt verliert man Verlauf oder
   Konsistenz.
   **EN:** Master data rarely changes, snapshots change with every collection. Kept separate, the history is
   preserved and the master data is not overwritten on each collection. Mixed, you lose history or consistency.

   </details>

2. **DE:** (AE) Welche Zustands- oder Snapshot-Regel gehört ins Domänenmodell und nicht erst in die Oberfläche? /
   **EN:** (AE) Which state or snapshot rule belongs in the domain model and not only in the UI?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zustandsübergänge und die Unveränderlichkeit von Snapshots. Sie müssen dort greifen, wo die Daten
   wirklich verändert werden, weil die Oberfläche umgangen werden kann.
   **EN:** State transitions and the immutability of snapshots. They must apply where the data is really
   changed, because the UI can be bypassed.

   </details>

3. **DE:** Warum darf ein Zustandswechsel nicht allein aus einem rohen gesammelten Wert entstehen? /
   **EN:** Why must a state transition not result from a raw collected value alone?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein gesammelter Wert kann falsch oder manipuliert sein. Der Wechsel muss über eine geprüfte Regel
   laufen, die nur erlaubte Übergänge zulässt, sonst entsteht ein ungültiger Zustand.
   **EN:** A collected value can be wrong or manipulated. The transition must go through a checked rule that
   only allows permitted transitions, otherwise an invalid state arises.

   </details>

4. **DE:** Warum dürfen interne IDs keine personenbezogenen Informationen enthalten? /
   **EN:** Why must internal IDs not contain personal information?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** IDs erscheinen in Logs, Snapshots und Exporten. Enthalten sie Namen oder E-Mail-Adressen, entsteht
   ein Datenschutzrisiko und ein unnötiger Personenbezug.
   **EN:** IDs appear in logs, snapshots, and exports. If they contain names or email addresses, a privacy risk
   and unnecessary personal reference arise.

   </details>

5. **DE:** (SI) Welche Snapshot-Felder helfen im Betrieb, ohne den Datenschutz unnötig zu belasten? /
   **EN:** (SI) Which snapshot fields help operations without unnecessarily burdening privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Technische Felder wie `status`, `collectedAt` und `last_contact` helfen bei Betrieb und Nachvollzug,
   ohne dass Freitexte oder personenbezogene Details nötig sind.
   **EN:** Technical fields such as `status`, `collectedAt`, and `last_contact` help operations and
   traceability without needing free text or personal details.

   </details>

6. **DE:** (DPA) Welche Datenqualität brauchst du im Modell für spätere Kennzahlen? /
   **EN:** (DPA) Which data quality does the model need for later metrics?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klare Pflichtfelder, gültige Zustände und verlässliche Zeitstempel in den Snapshots. Nur so lassen
   sich Verfügbarkeit oder Zahl der offline-Maschinen korrekt berechnen.
   **EN:** Clear mandatory fields, valid states, and reliable timestamps in the snapshots. Only then can
   availability or the number of offline machines be calculated correctly.

   </details>

7. **DE:** (DV) Wie hilft die Trennung von `Machine` und `Snapshot`, die Systemgrenze zum meldenden Rechner zu verstehen? /
   **EN:** (DV) How does separating `Machine` and `Snapshot` help understand the system boundary to the reporting machine?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Snapshot ist die über die Grenze gemeldete, veränderliche Information; die Stammdaten bleiben
   intern gepflegt. So sieht man klar, welche Daten von außen kommen und daher validiert werden müssen.
   **EN:** The snapshot is the changeable information reported across the boundary; the master data stays
   maintained internally. This clearly shows which data comes from outside and therefore must be validated.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] `Machine`, `Snapshot` und `AuditEntry` mit Zweck, Pflicht- und optionalen Feldern beschreiben.
- [ ] Stammdaten von zeitlichen Snapshots unterscheiden und das Master-Detail-Muster erklären.
- [ ] erlaubte Zustandsübergänge in einer Matrix darstellen und verbotene ausdrücklich nennen.
- [ ] erklären, warum Zustandsregeln in der Kernlogik liegen müssen.
- [ ] begründen, welche Felder aus Datenschutzgründen nicht gespeichert werden.

**EN:** I can …

- [ ] describe `Machine`, `Snapshot`, and `AuditEntry` with purpose, mandatory, and optional fields.
- [ ] distinguish master data from time-based snapshots and explain the master-detail pattern.
- [ ] show allowed state transitions in a matrix and explicitly name forbidden ones.
- [ ] explain why state rules must live in the core logic.
- [ ] justify which fields are not stored for privacy reasons.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_02_Domaenenmodell-Maschinen-Snapshots-und-Zustaende.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_02_Domaenenmodell-Maschinen-Snapshots-und-Zustaende.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
