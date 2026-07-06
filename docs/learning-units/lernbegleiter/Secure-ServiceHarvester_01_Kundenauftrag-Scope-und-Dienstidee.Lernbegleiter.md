# Lernbegleiter: Secure ServiceHarvester 01 – Kundenauftrag, Scope und Dienstidee / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_01_Kundenauftrag-Scope-und-Dienstidee.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Kunde bittet die EuFPA: „Wir wissen nie genau, welche unserer Rechner gerade laufen, welches
Betriebssystem sie haben und wann sie sich zuletzt gemeldet haben." Statt jeden Rechner einzeln von Hand zu
prüfen, soll ein **Dienst** diese Statusdaten regelmäßig und automatisch **sammeln** und **bereitstellen**.
Bevor auch nur eine Zeile Code entsteht, muss klar sein, **was** der Dienst tut, **welche Daten** er sammelt,
**was er nicht** tut und **welchen Schutzbedarf** die Daten haben.

**EN:** A customer asks EuFPA: "We never know exactly which of our machines are currently running, which
operating system they have, and when they last reported in." Instead of checking each machine by hand, a
**service** should **collect** and **provide** this status data regularly and automatically. Before a single
line of code exists, it must be clear **what** the service does, **which data** it collects, **what it does
not** do, and **what protection need** the data has.

**DE:** In dieser Einheit lernst du, einen Kundenauftrag in einen prüfbaren Scope zu übersetzen, die
**Dienstidee** von einem einmaligen Programm abzugrenzen und schon jetzt Sicherheits-, Datenschutz- und
Betriebsannahmen getrennt zu dokumentieren. Der Dienst bleibt im 1. Lehrjahr bewusst einfach.

**EN:** In this unit you learn to translate a customer task into a testable scope, to distinguish the
**service idea** from a one-shot program, and to document security, privacy, and operational assumptions
separately from the start. The service stays deliberately simple in year 1.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Dienst / Service | Ein Programm, das dauerhaft im Hintergrund läuft und wiederkehrend Arbeit erledigt. |
| Sammeln / Harvesting | Das regelmäßige Erfassen von Statusdaten von einer oder mehreren Maschinen. |
| Scope / Scope | Klar abgegrenzter Umfang: was gehört dazu und was nicht. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossener Punkt, damit der Umfang nicht unbemerkt wächst. |
| Statusdaten / Status data | Einfache Angaben zu einer Maschine, z. B. Name, Betriebssystem, letzter Kontakt. |
| Schutzbedarf / Protection need | Einschätzung, wie schützenswert Daten hinsichtlich Vertraulichkeit, Integrität und Verfügbarkeit sind. |
| Nachweispfad / Evidence path | Ort und Form, an dem eine Aussage belegt wird (z. B. Tabelle, Testbericht). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Kundenauftrag verstehen.** Lies den Auftrag und schreibe in eigenen Worten auf, welches
Problem der Kunde lösen will. Frage: Wer nutzt die gesammelten Daten? Wozu? Ein Auftrag, den du nicht in einem
Satz zusammenfassen kannst, ist noch nicht verstanden.

**EN:** **Step 1 – Understand the customer task.** Read the task and write in your own words what problem the
customer wants to solve. Ask: who uses the collected data? For what? A task you cannot summarize in one
sentence is not yet understood.

**DE:** **Schritt 2 – Die Dienstidee abgrenzen.** Ein einmaliges Programm läuft, gibt ein Ergebnis aus und
endet. Ein **Dienst** läuft dauerhaft, sammelt in Abständen und muss sich sauber starten und beenden lassen.
Für diese Einheit entscheidest du bewusst: „Wir bauen einen kleinen Sammel-Dienst, kein einmaliges Skript."
Warum ist das wichtig? Weil ein Dienst andere Fragen aufwirft: Wann sammelt er? Was passiert bei einem
Fehler? Wie stoppt man ihn sauber?

**EN:** **Step 2 – Delimit the service idea.** A one-shot program runs, produces a result, and ends. A
**service** runs continuously, collects at intervals, and must start and stop cleanly. For this unit you
deliberately decide: "We build a small collection service, not a one-shot script." Why does this matter?
Because a service raises different questions: when does it collect? What happens on an error? How do you stop
it cleanly?

**DE:** **Schritt 3 – Statusdaten und Scope benennen.** Liste die zu sammelnden Statusdaten auf, zum Beispiel
Maschinenname, Betriebssystem und Zeitpunkt des letzten Kontakts. Für jedes Datenfeld notierst du, warum es
gebraucht wird. Nur benannte Daten lassen sich später modellieren und schützen. Halte die Liste im 1.
Lehrjahr kurz.

**EN:** **Step 3 – Name status data and scope.** List the status data to be collected, for example machine
name, operating system, and time of last contact. For each field, note why it is needed. Only named data can
later be modeled and protected. Keep the list short in year 1.

**DE:** **Schritt 4 – Nicht-Ziele festlegen.** Genauso wichtig wie der Umfang ist, was **nicht** dazugehört.
Beispiel: „Dieser Dienst sammelt keine Tastatureingaben, keine Dateiinhalte und keine Standortdaten von
Personen." Nicht-Ziele verhindern Scope-Creep – das unbemerkte Anwachsen des Umfangs – und schützen vor dem
Sammeln unnötiger personenbezogener Daten (Datenminimierung).

**EN:** **Step 4 – Define non-goals.** Just as important as the scope is what does **not** belong. Example:
"This service does not collect keystrokes, file contents, or people's location data." Non-goals prevent scope
creep – the unnoticed growth of scope – and protect against collecting unnecessary personal data (data
minimization).

**DE:** **Schritt 5 – Schutzbedarf und Annahmen trennen.** Schreibe Sicherheits-, Datenschutz- und
Betriebsannahmen in getrennte Zeilen. Warum getrennt? Weil sie unterschiedliche Prüfungen brauchen:
Sicherheit prüft Angreifer, Datenschutz prüft personenbezogene Daten, Betrieb prüft Umgebung und Werkzeuge.
Positive Sicherheitsaussagen ohne Nachweis sind nur Wunschdenken; verweise deshalb je Aussage auf einen
Nachweispfad.

**EN:** **Step 5 – Separate protection need and assumptions.** Write security, privacy, and operational
assumptions in separate lines. Why separate? Because they need different checks: security considers attackers,
privacy considers personal data, operations considers environment and tools. Positive security claims without
evidence are only wishful thinking; therefore point each claim to an evidence path.

**DE:** **Typische Fehler.** Den Auftrag zu weit fassen. Sofort an Hosting, Datenbanken oder eine API denken,
statt den Dienst einfach zu halten. Nicht-Ziele weglassen. Statusdaten nur vage benennen.
Sicherheitsaussagen ohne Nachweis. Nicht anwendbare Standards stillschweigend weglassen statt sie als `N/A`
mit kurzer Begründung zu dokumentieren.

**EN:** **Common mistakes.** Framing the task too broadly. Immediately thinking about hosting, databases, or an
API instead of keeping the service simple. Omitting non-goals. Naming status data only vaguely. Security
claims without evidence. Silently dropping non-applicable standards instead of documenting them as `N/A` with
a short justification.

### Beispiel / Example

```text
Kundenauftrag:   "Zeige uns regelmäßig, welche Rechner laufen, welches OS sie haben und wann sie
                  sich zuletzt gemeldet haben."

Dienstidee:      langlaufender Sammel-Dienst (kein einmaliges Skript); startet, sammelt im Intervall,
                 stoppt sauber
Im Scope:        Statusdaten je Maschine: name, os, last_contact
Nicht-Ziel:      Tastatureingaben, Dateiinhalte, personenbezogene Standortdaten, Fernsteuerung
Statusobjekt:    Machine { name, os, last_contact }
Schutzbedarf:    Integrität = hoch (falscher Status führt zu falschen Betriebsentscheidungen)
Annahme (Sec):   Gesammelte Daten gelten als nicht vertrauenswürdig  -> Nachweis: Validierungstest
Annahme (Betrieb): Dienst muss auf Stopp-Signal sauber beenden       -> Nachweis: Shutdown-Test
N/A:             API-Härtung in dieser Einheit N/A (noch keine Schnittstelle) -> Begründung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Kundenauftrag, Dienstidee und die eigene Rolle im Projekt stehen im Mittelpunkt. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Schutzbedarf der Statusdaten und Trennung der Annahmen werden erstmals geübt. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Der Auftrag ist eine Serviceanfrage, die verstanden und abgegrenzt werden muss. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Standards-Anwendbarkeit, sichere Code-Review-Perspektive,
Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Der Umfang wird bewusst begrenzt, gesammelte Daten gelten als
nicht vertrauenswürdig, und jede Sicherheitsaussage erhält einen Nachweispfad.* A11Y-Aspekt: Scope-Tabellen
und Nicht-Ziele müssen als klarer Text lesbar sein, ohne reine Farbmarkierung, damit sie mit Screenreader
oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: standards applicability, a secure code-review
perspective, testability, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability),
`CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence and closure). The security decision
of this unit is: *scope is deliberately limited, collected data is treated as untrusted, and every security
claim gets an evidence path.* Accessibility aspect: scope tables and non-goals must be readable as clear text,
without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet einen langlaufenden Dienst von einem einmaligen Programm? /
   **EN:** What distinguishes a long-running service from a one-shot program?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein einmaliges Programm läuft, gibt ein Ergebnis aus und endet. Ein Dienst läuft dauerhaft,
   arbeitet in Abständen und muss sich sauber starten und beenden lassen. Deshalb sind Lebenszyklus,
   Intervall und Fehlerverhalten wichtige Fragen.
   **EN:** A one-shot program runs, produces a result, and ends. A service runs continuously, works at
   intervals, and must start and stop cleanly. Therefore lifecycle, interval, and error behavior are
   important questions.

   </details>

2. **DE:** Warum muss der Scope eines Sammel-Dienstes vor der Umsetzung klar abgegrenzt sein? /
   **EN:** Why must the scope of a collection service be clearly defined before implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne klaren Scope wächst der Umfang unkontrolliert (Scope-Creep), es werden unnötige Daten
   gesammelt, und das Ergebnis lässt sich nicht gegen den Auftrag prüfen. Ein abgegrenzter Umfang macht das
   Ergebnis messbar und wartbar.
   **EN:** Without a clear scope the scope grows uncontrollably (scope creep), unnecessary data is collected,
   and the result cannot be checked against the task. A defined scope makes the result measurable and
   maintainable.

   </details>

3. **DE:** Warum sollen gesammelte Statusdaten als „nicht vertrauenswürdig" behandelt werden? /
   **EN:** Why should collected status data be treated as "untrusted"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Daten kommen von außen und können falsch, unvollständig oder manipuliert sein. Wer sie ungeprüft
   übernimmt, riskiert falsche Entscheidungen und Sicherheitslücken. Deshalb werden sie an der Vertrauensgrenze
   validiert.
   **EN:** The data comes from outside and can be wrong, incomplete, or manipulated. Accepting it unchecked
   risks wrong decisions and security gaps. Therefore it is validated at the trust boundary.

   </details>

4. **DE:** Wozu dienen Nicht-Ziele in diesem Lastenheft? /
   **EN:** What is the purpose of non-goals in this intake?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht-Ziele grenzen bewusst aus, was nicht dazugehört, etwa Tastatureingaben oder Standortdaten.
   Sie verhindern Scope-Creep und schützen vor dem Sammeln unnötiger, oft personenbezogener Daten
   (Datenminimierung).
   **EN:** Non-goals deliberately exclude what does not belong, such as keystrokes or location data. They
   prevent scope creep and protect against collecting unnecessary, often personal data (data minimization).

   </details>

5. **DE:** (SI) Welche Betriebsannahme ist für einen Dienst besonders wichtig und wie weist man sie nach? /
   **EN:** (SI) Which operational assumption is especially important for a service, and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Dienst muss sich auf ein Stopp-Signal sauber beenden (Graceful Shutdown), ohne Daten zu
   verlieren oder hängen zu bleiben. Nachweis: ein Shutdown-Test, der zeigt, dass der Dienst nach dem Signal
   geordnet stoppt.
   **EN:** The service must stop cleanly on a stop signal (graceful shutdown) without losing data or hanging.
   Evidence: a shutdown test showing the service stops in an orderly way after the signal.

   </details>

6. **DE:** (DPA) Warum ist der Schutzbedarf „Integrität" für Statusdaten oft besonders hoch? /
   **EN:** (DPA) Why is the "integrity" protection need often especially high for status data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus Statusdaten werden Betriebsentscheidungen abgeleitet, etwa über Wartung oder Verfügbarkeit.
   Falsche oder manipulierte Daten führen direkt zu falschen Entscheidungen, daher zählt die Integrität stark.
   **EN:** Operational decisions are derived from status data, e.g. about maintenance or availability. Wrong or
   manipulated data leads directly to wrong decisions, so integrity matters strongly.

   </details>

7. **DE:** (DV) Warum ist es sinnvoll, schon jetzt die Systemgrenze zwischen sammelnden Maschinen und dem
   Dienst zu benennen? / **EN:** (DV) Why is it useful to name the system boundary between collecting machines
   and the service already now?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Grenze zeigt, wo Daten die Vertrauenszone wechseln. Wer sie früh benennt, kann später
   Schnittstellen, Kommunikationswege und Validierung gezielt planen und Verfügbarkeit und Segmentierung
   berücksichtigen.
   **EN:** The boundary shows where data crosses the trust zone. Naming it early allows later planning of
   interfaces, communication paths, and validation, and considering availability and segmentation.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: API-Härtung
   ist `N/A`, weil es in dieser Einheit noch keine Schnittstelle gibt. So bleibt sichtbar, dass der Standard
   geprüft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: API hardening is
   `N/A` because there is no interface yet in this unit. This keeps visible that the standard was checked.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Kundenauftrag in einem Satz zusammenfassen.
- [ ] einen langlaufenden Dienst von einem einmaligen Programm unterscheiden.
- [ ] die zu sammelnden Statusdaten mit Begründung benennen.
- [ ] mindestens zwei sinnvolle Nicht-Ziele formulieren.
- [ ] Sicherheits-, Datenschutz- und Betriebsannahmen getrennt notieren.
- [ ] je Sicherheitsaussage einen Nachweispfad angeben.

**EN:** I can …

- [ ] summarize a customer task in one sentence.
- [ ] distinguish a long-running service from a one-shot program.
- [ ] name the status data to be collected with a rationale.
- [ ] state at least two meaningful non-goals.
- [ ] note security, privacy, and operational assumptions separately.
- [ ] give an evidence path for each security claim.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_01_Kundenauftrag-Scope-und-Dienstidee.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_01_Kundenauftrag-Scope-und-Dienstidee.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
