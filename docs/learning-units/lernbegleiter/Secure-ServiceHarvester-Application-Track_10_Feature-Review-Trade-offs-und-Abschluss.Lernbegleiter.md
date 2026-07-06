# Lernbegleiter: Secure ServiceHarvester Application Track 10 – Feature-Review, Trade-offs und Abschluss / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Am Ende des Application Track führst du die Feature-Arbeit der Einheiten 01–09 in einem **Abschluss-
review** zusammen. Ein gutes Review beantwortet drei Fragen: Was wurde erreicht (und belegt)? Welche
Entscheidungen waren **Trade-offs** – also bewusste Abwägungen zwischen Vorteilen und Nachteilen? Welche
**Restrisiken** bleiben offen? Bild dazu: eine Bauabnahme. Man geht das Gebäude durch, hakt Fertiges ab,
notiert Mängel mit Zuständigkeit und sagt ehrlich, was noch nicht sicher ist.

**EN:** At the end of the Application Track you consolidate the feature work of units 01–09 in a **final
review**. A good review answers three questions: What was achieved (and evidenced)? Which decisions were
**trade-offs** – conscious weighings of advantages and disadvantages? Which **residual risks** remain open? The
picture: a building acceptance. You walk through the building, tick off what is finished, note defects with
responsibility, and honestly say what is not yet safe.

**DE:** Im 3. Lehrjahr geht es nicht darum, alles perfekt zu behaupten, sondern **auditfähig** und ehrlich zu
dokumentieren: Jede positive Sicherheits- oder Qualitätsaussage braucht einen Nachweis, sonst wird sie als
Restrisiko geführt. Am Schluss steht eine begründete **Übergabeempfehlung**. Als C#-Referenz dient
`InventarWorkerService`; die Bewertung bleibt sprachneutral.

**EN:** In the third year it is not about claiming everything is perfect, but documenting **audit-ready** and
honestly: every positive security or quality claim needs evidence, otherwise it is recorded as a residual risk.
At the end stands a justified **handover recommendation**. `InventarWorkerService` serves as a C# reference, but
the assessment stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Feature-Review / Feature review | Strukturierte Bewertung der umgesetzten Funktionen gegen Ziel und Nachweis. |
| Trade-off / Trade-off | Bewusste Abwägung zwischen Vorteilen und Nachteilen einer Entscheidung. |
| Restrisiko / Residual risk | Bekanntes, nach den Maßnahmen verbleibendes Risiko mit Bewertung. |
| Auditfähig / Audit-ready | So dokumentiert, dass ein Dritter es nachvollziehen und prüfen kann. |
| Offener Punkt / Open item | Noch nicht erledigte Aufgabe mit Folgeaktion und Zuständigkeit. |
| Übergabeempfehlung / Handover recommendation | Begründete Aussage, ob und unter welchen Bedingungen übergeben werden kann. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ergebnisse gegen Ziel und Nachweis prüfen.** Gehe die Einheiten 01–09 durch und halte für
jede fest: Was war das Ziel, was ist umgesetzt, welcher Nachweis existiert (Test, Tabelle, Dokument)? Was ohne
Nachweis dasteht, gilt nicht als erledigt, sondern als offener Punkt oder Restrisiko.

**EN:** **Step 1 – Check results against goal and evidence.** Go through units 01–09 and record for each: what
was the goal, what is implemented, which evidence exists (test, table, document)? Anything without evidence
does not count as done but as an open item or residual risk.

**DE:** **Schritt 2 – Entscheidungen als Trade-offs benennen.** Suche die wichtigsten Entwurfsentscheidungen
(z. B. ein zusätzlicher Erweiterungspunkt, ein bestimmter Serialisierer, striktes Ablehnen unbekannter Felder).
Schreibe je Entscheidung auf: Was war der Vorteil, was der Preis (Aufwand, Sicherheit, Wartbarkeit)? Eine gute
Begründung macht sichtbar, dass die Entscheidung bewusst und nicht zufällig war.

**EN:** **Step 2 – Name decisions as trade-offs.** Find the key design decisions (e.g. an extra extension point,
a specific serializer, strict rejection of unknown fields). For each, write down: what was the advantage, what
the cost (effort, security, maintainability)? A good justification shows the decision was conscious, not
accidental.

**DE:** **Schritt 3 – Restrisiken ehrlich bewerten.** Liste, was trotz aller Maßnahmen offen bleibt, und
bewerte es (z. B. Auswirkung und Wahrscheinlichkeit grob). Ehrliche Restrisiken sind wertvoller als
geschönte Sicherheit: Der nächste Bearbeiter weiß dann, worauf er achten muss.

**EN:** **Step 3 – Assess residual risks honestly.** List what remains open despite all measures, and assess it
(e.g. roughly impact and likelihood). Honest residual risks are more valuable than embellished security: the
next person then knows what to watch for.

**DE:** **Schritt 4 – Offene Punkte mit Folgeaktion sichern.** Jeder offene Punkt bekommt eine klare Folgeaktion
und, wenn möglich, eine Zuständigkeit. „`Open`: Contract-Test für v3-Schema fehlt → Folgeaktion: vor Rollout
ergänzen." So geht nichts unbemerkt verloren.

**EN:** **Step 4 – Secure open items with follow-up.** Each open item gets a clear follow-up and, if possible, a
responsibility. "`Open`: contract test for v3 schema missing → follow-up: add before rollout." This way nothing
is lost unnoticed.

**DE:** **Schritt 5 – Begründete Übergabeempfehlung schreiben.** Fasse zusammen: Kann das Feature übergeben
werden – ja, nein oder ja unter Bedingungen? Verweise auf die Nachweise und die wichtigsten Restrisiken. Die
Empfehlung ist eine ehrliche fachliche Einschätzung, keine Werbung.

**EN:** **Step 5 – Write a justified handover recommendation.** Summarize: can the feature be handed over – yes,
no, or yes under conditions? Point to the evidence and the key residual risks. The recommendation is an honest
professional assessment, not marketing.

**DE:** **Typische Fehler.** Ergebnisse ohne Nachweis als „fertig" führen. Entscheidungen nicht begründen.
Restrisiken verschweigen. Offene Punkte ohne Folgeaktion notieren. Eine Übergabeempfehlung ohne Bezug zu
Nachweisen abgeben.

**EN:** **Common mistakes.** Listing results without evidence as "done". Not justifying decisions. Concealing
residual risks. Noting open items without follow-up. Giving a handover recommendation without reference to
evidence.

### Beispiel / Example

```text
Reviewbericht (Auszug):
  Einheit 06 Fehlerbehandlung  -> umgesetzt, Nachweis: Negativtests je Fehlerklasse (grün)   -> erledigt
  Einheit 08 Serialisierung    -> umgesetzt, Nachweis: Härtungstests + Schema v2             -> erledigt
  Einheit 09 Teststrategie     -> teilweise, Contract-Test für v3-Schema fehlt               -> Open

Trade-off-Tabelle:
  Entscheidung: zusätzlicher Port "RemotePush"
    Vorteil: spätere Anbindung leichter | Preis: mehr Angriffsfläche/Testfläche
    Ergebnis: vorerst deaktiviert (bewusst), Reaktivierung nur mit Contract-Test.

Restrisiken:
  R1: v3-Schema noch ohne Contract-Test (Auswirkung mittel, Wahrscheinlichkeit gering) -> Folgeaktion vor Rollout.

Übergabeempfehlung:
  "Übergabe möglich unter der Bedingung, dass R1 vor dem produktiven Rollout geschlossen wird.
   Nachweise: docs/security/*, Testberichte, Trade-off-Tabelle."
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12a Kundenspezifische Anwendungsentwicklung durchführen | Primär / Primary | Abschlussreview, Trade-off-Bewertung und Übergabe schließen die kundenspezifische Entwicklung auditfähig ab. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Bewertung und Übergabe betreffen auch die angepasste Datenverwaltung und deren Restrisiken. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähige Evidenz, Restrisiko-Transparenz, sichere
Architektur- und Programmierbewertung sowie Datenschutz. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz), `CL_11` (Umgebung/Nachweise)
und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Nur belegte
Aussagen gelten als sicher; alles andere wird als Restrisiko mit Folgeaktion transparent gemacht.* A11Y-Aspekt:
Reviewbericht, Trade-off-Tabelle und Restrisiken werden als klarer, strukturierter Text dargestellt und nicht
allein über Farbe signalisiert, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: audit-ready evidence, residual-risk transparency, secure
architecture and coding assessment, and privacy. Matching checklists: `CL_01` (standards applicability), `CL_08`
(security code review), `CL_10` (privacy), `CL_11` (environment/evidence), and `CL_12` (evidence and closure).
The security decision of this unit is: *only evidenced claims count as secure; everything else is made
transparent as a residual risk with follow-up.* Accessibility aspect: review report, trade-off table, and
residual risks are presented as clear, structured text and not signaled by color alone, so they remain usable
with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gilt ein Ergebnis ohne Nachweis nicht als erledigt? /
   **EN:** Why does a result without evidence not count as done?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Auditfähigkeit verlangt, dass ein Dritter jede Aussage nachvollziehen kann. Ohne Nachweis (Test,
   Tabelle, Dokument) ist die Aussage nur eine Behauptung und wird als offener Punkt oder Restrisiko geführt.
   **EN:** Audit-readiness requires that a third party can trace every claim. Without evidence (test, table,
   document) the claim is only an assertion and is recorded as an open item or residual risk.

   </details>

2. **DE:** Was ist ein Trade-off und warum muss er begründet werden? /
   **EN:** What is a trade-off and why must it be justified?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Trade-off ist eine bewusste Abwägung zwischen Vor- und Nachteilen. Die Begründung zeigt, dass die
   Entscheidung überlegt war, und erlaubt es später, sie bei geänderten Bedingungen erneut zu bewerten.
   **EN:** A trade-off is a conscious weighing of advantages and disadvantages. The justification shows the
   decision was considered and lets it be re-evaluated later under changed conditions.

   </details>

3. **DE:** Warum ist ein ehrlich benanntes Restrisiko wertvoller als geschönte Sicherheit? /
   **EN:** Why is an honestly named residual risk more valuable than embellished security?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein bekanntes Restrisiko kann bewusst behandelt, überwacht oder vor dem Rollout geschlossen werden.
   Geschönte Sicherheit verbirgt die Gefahr und führt später zu unerwarteten Ausfällen oder Vorfällen.
   **EN:** A known residual risk can be deliberately handled, monitored, or closed before rollout. Embellished
   security hides the danger and later leads to unexpected failures or incidents.

   </details>

4. **DE:** Was gehört zu einem gut dokumentierten offenen Punkt? /
   **EN:** What belongs to a well-documented open item?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine klare Beschreibung, der Status `Open`, eine konkrete Folgeaktion und möglichst eine
   Zuständigkeit und ein Auslöser für die Wiedervorlage. So geht der Punkt nicht unbemerkt verloren.
   **EN:** A clear description, the status `Open`, a concrete follow-up, and ideally a responsibility and a
   trigger for re-evaluation. This way the item is not lost unnoticed.

   </details>

5. **DE:** Was gehört in eine begründete Übergabeempfehlung? /
   **EN:** What belongs in a justified handover recommendation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine klare Aussage (übergeben: ja/nein/ja unter Bedingungen), der Bezug zu den vorhandenen Nachweisen
   und die wichtigsten Restrisiken samt Bedingungen. Sie ist eine ehrliche fachliche Einschätzung.
   **EN:** A clear statement (hand over: yes/no/yes under conditions), the reference to existing evidence, and
   the key residual risks with conditions. It is an honest professional assessment.

   </details>

6. **DE:** (AE) Wie hilft die Trade-off-Reflexion künftigen Bearbeitern des Codes? /
   **EN:** (AE) How does trade-off reflection help future maintainers of the code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie macht sichtbar, warum eine Lösung so und nicht anders gewählt wurde. Wer später ändert, versteht
   die Randbedingungen und vermeidet es, eine bewusste Entscheidung versehentlich rückgängig zu machen.
   **EN:** It makes visible why a solution was chosen this way. Whoever changes it later understands the
   constraints and avoids accidentally reversing a deliberate decision.

   </details>

7. **DE:** (DPA) Warum sollten auch Datenschutz- und Datenqualitätsrisiken im Abschlussreview auftauchen? /
   **EN:** (DPA) Why should privacy and data-quality risks also appear in the final review?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie sind Teil des Gesamtrisikos. Ein Feature kann technisch sicher sein, aber Datenschutz- oder
   Datenqualitätslücken haben. Nur wenn sie benannt sind, können sie behandelt und bei Übergabe berücksichtigt werden.
   **EN:** They are part of the overall risk. A feature can be technically secure but have privacy or
   data-quality gaps. Only when named can they be handled and considered at handover.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Feature-Ergebnisse gegen Ziel und Nachweis bewerten.
- [ ] wichtige Entwurfsentscheidungen als begründete Trade-offs beschreiben.
- [ ] Restrisiken ehrlich benennen und grob bewerten.
- [ ] offene Punkte mit Folgeaktion und Zuständigkeit sichern.
- [ ] eine begründete, nachweisgestützte Übergabeempfehlung schreiben.

**EN:** I can …

- [ ] assess feature results against goal and evidence.
- [ ] describe key design decisions as justified trade-offs.
- [ ] name residual risks honestly and assess them roughly.
- [ ] secure open items with follow-up and responsibility.
- [ ] write a justified, evidence-based handover recommendation.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_10_Feature-Review-Trade-offs-und-Abschluss.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
