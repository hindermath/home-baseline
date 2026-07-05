# Lernbegleiter: Secure InventoryHub 01 – Kundenauftrag, Scope und Inventarobjekte / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_01_Kundenauftrag-Scope-und-Inventarobjekte.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Kunde bittet die EuFPA: „Wir wissen nicht mehr, welche Geräte und welche Software wir überhaupt
besitzen." Bevor auch nur eine Zeile Code entsteht, muss klar sein, **was** verwaltet werden soll (die
Inventarobjekte), **was nicht** dazugehört (die Nicht-Ziele) und **welchen Schutzbedarf** die Daten haben.
Ein Inventar ohne klaren Umfang wächst unkontrolliert, wird ungenau und verliert seinen Wert. Wer den Scope
sauber abgrenzt, kann später prüfen, ob das Ergebnis wirklich zum Kundenauftrag passt.

**EN:** A customer asks EuFPA: "We no longer know which devices and which software we actually own." Before a
single line of code exists, it must be clear **what** should be managed (the inventory objects), **what does
not** belong (the non-goals), and **what protection need** the data has. An inventory without a clear scope
grows uncontrollably, becomes inaccurate, and loses its value. Whoever draws the scope cleanly can later
check whether the result really matches the customer task.

**DE:** In dieser Einheit lernst du, einen Kundenauftrag in einen prüfbaren Scope zu übersetzen,
Inventarobjekte wie IT-Assets und Software zu benennen und schon jetzt Sicherheits-, Datenschutz- und
Betriebsannahmen getrennt zu dokumentieren.

**EN:** In this unit you learn to translate a customer task into a testable scope, to name inventory objects
such as IT assets and software, and to document security, privacy, and operational assumptions separately
from the start.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Inventarobjekt / Inventory object | Ein verwalteter Gegenstand, z. B. ein IT-Asset (Gerät) oder ein Softwarestand. |
| Scope / Scope | Klar abgegrenzter Umfang: was gehört dazu und was nicht. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossener Punkt, damit der Umfang nicht unbemerkt wächst. |
| IT-Asset / IT asset | Ein technisches Betriebsmittel wie Laptop, Server oder Netzgerät. |
| Schutzbedarf / Protection need | Einschätzung, wie schützenswert Daten hinsichtlich Vertraulichkeit, Integrität und Verfügbarkeit sind. |
| Nachweispfad / Evidence path | Ort und Form, an dem eine Aussage belegt wird (z. B. Tabelle, Testbericht). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Kundenauftrag verstehen.** Lies den Auftrag und schreibe in eigenen Worten auf, welches
Problem der Kunde lösen will. Frage: Wer nutzt das Inventar? Wozu? Ein Auftrag, den du nicht in einem Satz
zusammenfassen kannst, ist noch nicht verstanden.

**EN:** **Step 1 – Understand the customer task.** Read the task and write in your own words what problem the
customer wants to solve. Ask: who uses the inventory? For what? A task you cannot summarize in one sentence is
not yet understood.

**DE:** **Schritt 2 – Inventarobjekte benennen.** Liste die zu verwaltenden Objekte auf: IT-Assets (Geräte)
und Softwarestände. Für jedes Objekt notierst du die wichtigsten Merkmale, z. B. eine eindeutige Kennung,
einen Typ und einen Verantwortlichen. Nur benannte Objekte lassen sich später modellieren und schützen.

**EN:** **Step 2 – Name the inventory objects.** List the objects to be managed: IT assets (devices) and
software versions. For each object, note the key attributes, e.g. a unique identifier, a type, and an owner.
Only named objects can later be modeled and protected.

**DE:** **Schritt 3 – Nicht-Ziele festlegen.** Genauso wichtig wie der Umfang ist, was **nicht** dazugehört.
Beispiel: „Diese Einheit verwaltet keine Lizenzkosten und keine Personaldaten." Nicht-Ziele verhindern
Scope-Creep – das unbemerkte Anwachsen des Umfangs – und schützen vor dem Sammeln unnötiger personenbezogener
Daten (Datenminimierung).

**EN:** **Step 3 – Define non-goals.** Just as important as the scope is what does **not** belong. Example:
"This unit does not manage license costs or personnel data." Non-goals prevent scope creep – the unnoticed
growth of scope – and protect against collecting unnecessary personal data (data minimization).

**DE:** **Schritt 4 – Schutzbedarf und Annahmen trennen.** Schreibe Sicherheits-, Datenschutz- und
Betriebsannahmen in getrennte Zeilen. Warum getrennt? Weil sie unterschiedliche Prüfungen brauchen: Sicherheit
prüft Angreifer, Datenschutz prüft personenbezogene Daten, Betrieb prüft Umgebung und Werkzeuge. Positive
Sicherheitsaussagen ohne Nachweis sind nur Wunschdenken; verweise deshalb je Aussage auf einen Nachweispfad.

**EN:** **Step 4 – Separate protection need and assumptions.** Write security, privacy, and operational
assumptions in separate lines. Why separate? Because they need different checks: security considers attackers,
privacy considers personal data, operations considers environment and tools. Positive security claims without
evidence are only wishful thinking; therefore point each claim to an evidence path.

**DE:** **Typische Fehler.** Den Auftrag zu weit fassen. Nicht-Ziele weglassen. Inventarobjekte nur vage
benennen. Sicherheitsaussagen ohne Nachweis. Nicht anwendbare Standards stillschweigend weglassen statt sie
als `N/A` mit kurzer Begründung zu dokumentieren.

**EN:** **Common mistakes.** Framing the task too broadly. Omitting non-goals. Naming inventory objects only
vaguely. Security claims without evidence. Silently dropping non-applicable standards instead of documenting
them as `N/A` with a short justification.

### Beispiel / Example

```text
Kundenauftrag:   "Zeige uns, welche Geräte und Software wir besitzen und wer dafür zuständig ist."

Im Scope:        IT-Assets (Laptop, Server, Netzgerät), Softwarestände, Verantwortliche
Nicht-Ziel:      Lizenzkosten, Beschaffungsvorgänge, echte Personaldaten
Inventarobjekt:  Asset { id, typ, standort, owner }   Software { id, name, version, asset-ref }
Schutzbedarf:    Integrität = hoch (falsche Daten führen zu falschen Entscheidungen)
Annahme (Sec):   Alle Importe gelten als nicht vertrauenswürdig  -> Nachweis: Validierungstest
N/A:             SBOM in dieser Einheit N/A (kein Release-Artefakt) -> Begründung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Kundenauftrag, Scope und die eigene Rolle im Projekt stehen im Mittelpunkt. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Der Auftrag ist eine Serviceanfrage, die verstanden und abgegrenzt werden muss. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Standards-Anwendbarkeit, sichere Code-Review-Perspektive,
Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Der Umfang wird bewusst begrenzt, und jede Sicherheitsaussage
erhält einen Nachweispfad.* A11Y-Aspekt: Scope-Tabellen und Nicht-Ziele müssen als klarer Text lesbar sein,
ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: standards applicability, a secure code-review
perspective, testability, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability),
`CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence and closure). The security decision
of this unit is: *scope is deliberately limited, and every security claim gets an evidence path.* Accessibility
aspect: scope tables and non-goals must be readable as clear text, without color-only marking, so they remain
usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum muss der Scope eines Inventars vor der Umsetzung klar abgegrenzt sein? /
   **EN:** Why must the scope of an inventory be clearly defined before implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne klaren Scope wächst das Inventar unkontrolliert (Scope-Creep), wird ungenau und lässt sich
   nicht gegen den Auftrag prüfen. Ein abgegrenzter Umfang macht das Ergebnis messbar und wartbar.
   **EN:** Without a clear scope the inventory grows uncontrollably (scope creep), becomes inaccurate, and
   cannot be checked against the task. A defined scope makes the result measurable and maintainable.

   </details>

2. **DE:** Was ist ein Inventarobjekt, und welche Merkmale braucht es mindestens? /
   **EN:** What is an inventory object, and which attributes does it need at least?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Inventarobjekt ist ein verwalteter Gegenstand wie ein IT-Asset oder ein Softwarestand. Es
   braucht mindestens eine eindeutige Kennung, einen Typ und einen Verantwortlichen, damit es identifizierbar
   und zuordenbar ist.
   **EN:** An inventory object is a managed item such as an IT asset or a software version. It needs at least a
   unique identifier, a type, and an owner so it is identifiable and assignable.

   </details>

3. **DE:** Wozu dienen Nicht-Ziele in einem Lastenheft? /
   **EN:** What is the purpose of non-goals in an intake?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht-Ziele grenzen bewusst aus, was nicht dazugehört. Sie verhindern Scope-Creep und schützen vor
   dem Sammeln unnötiger Daten, etwa personenbezogener Daten (Datenminimierung).
   **EN:** Non-goals deliberately exclude what does not belong. They prevent scope creep and protect against
   collecting unnecessary data, such as personal data (data minimization).

   </details>

4. **DE:** Warum werden Sicherheits-, Datenschutz- und Betriebsannahmen getrennt dokumentiert? /
   **EN:** Why are security, privacy, and operational assumptions documented separately?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie brauchen unterschiedliche Prüfungen: Sicherheit betrachtet Angreifer, Datenschutz betrachtet
   personenbezogene Daten, Betrieb betrachtet Umgebung und Werkzeuge. Getrennt bleiben sie prüfbar und
   nachvollziehbar.
   **EN:** They need different checks: security considers attackers, privacy considers personal data,
   operations considers environment and tools. Kept separate they stay verifiable and traceable.

   </details>

5. **DE:** Warum reicht eine positive Sicherheitsaussage ohne Nachweispfad nicht aus? /
   **EN:** Why is a positive security claim without an evidence path not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Behauptung ohne Beleg lässt sich nicht prüfen und ist wertlos für ein Audit. Jede Aussage
   braucht einen Nachweispfad, etwa einen Test, ein Review oder eine dokumentierte Begründung.
   **EN:** A claim without proof cannot be verified and is worthless for an audit. Every claim needs an
   evidence path, such as a test, a review, or a documented justification.

   </details>

6. **DE:** (DPA) Warum ist der Schutzbedarf „Integrität" für Inventardaten oft besonders hoch? /
   **EN:** (DPA) Why is the "integrity" protection need often especially high for inventory data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus Inventardaten werden Entscheidungen abgeleitet, etwa über Patch, Beschaffung oder Risiko.
   Falsche oder manipulierte Daten führen direkt zu falschen Entscheidungen, daher zählt die Integrität stark.
   **EN:** Decisions are derived from inventory data, e.g. about patching, procurement, or risk. Wrong or
   manipulated data leads directly to wrong decisions, so integrity matters strongly.

   </details>

7. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. So bleibt sichtbar,
   dass der Standard geprüft und bewusst als nicht anwendbar eingestuft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. This keeps visible that the
   standard was checked and deliberately classified as not applicable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Kundenauftrag in einem Satz zusammenfassen.
- [ ] Inventarobjekte mit Mindestmerkmalen benennen.
- [ ] mindestens zwei sinnvolle Nicht-Ziele formulieren.
- [ ] Sicherheits-, Datenschutz- und Betriebsannahmen getrennt notieren.
- [ ] je Sicherheitsaussage einen Nachweispfad angeben.

**EN:** I can …

- [ ] summarize a customer task in one sentence.
- [ ] name inventory objects with minimum attributes.
- [ ] state at least two meaningful non-goals.
- [ ] note security, privacy, and operational assumptions separately.
- [ ] give an evidence path for each security claim.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_01_Kundenauftrag-Scope-und-Inventarobjekte.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_01_Kundenauftrag-Scope-und-Inventarobjekte.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
