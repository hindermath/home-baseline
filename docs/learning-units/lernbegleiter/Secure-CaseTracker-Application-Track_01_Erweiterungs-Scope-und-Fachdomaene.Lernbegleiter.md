# Lernbegleiter: Secure CaseTracker Application Track 01 – Erweiterungs-Scope und Fachdomäne / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_01_Erweiterungs-Scope-und-Fachdomaene.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bevor eine Zeile Code entsteht, muss klar sein, *was* gebaut wird und *was ausdrücklich nicht*. Der
Secure CaseTracker wird für einen professionellen Einsatz erweitert. Diese erste Einheit trennt den
**Feature-Scope** (was gehört dazu) von den **Nicht-Zielen** (was bewusst wegbleibt), beschreibt die
**Fachdomäne** (Fälle, Status, Zuständigkeiten) und benennt den **Schutzbedarf**. Ein unscharfer Scope ist
im 3. Lehrjahr eine der teuersten Fehlerquellen: Er führt zu Nacharbeit, ungeprüften Annahmen und zu
Sicherheitslücken, die niemand geplant hat.

**EN:** Before a single line of code exists, it must be clear *what* is built and *what is explicitly not*.
The Secure CaseTracker is extended for professional use. This first unit separates the **feature scope**
(what is included) from the **non-goals** (what is deliberately left out), describes the **business domain**
(cases, states, responsibilities), and names the **protection need**. A blurry scope is one of the most
expensive error sources in year 3: it causes rework, unchecked assumptions, and security gaps nobody planned.

**DE:** Du lernst, einen tragfähigen Scope so zu schneiden, dass er kundenverständlich, prüfbar und sicher
ist – und dass jede weggelassene Funktion eine bewusste Entscheidung ist, keine Lücke.

**EN:** You learn to cut a viable scope so that it is customer-understandable, verifiable, and secure – and
that every omitted function is a deliberate decision, not a gap.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Feature-Scope / Feature scope | Menge der Funktionen, die diese Erweiterung ausdrücklich liefert. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossene Funktion, mit kurzer Begründung. |
| Fachdomäne / Business domain | Fachlicher Gegenstand: Fälle, Zustände, Rollen, Regeln der Bearbeitung. |
| Schutzbedarf / Protection need | Wie stark Vertraulichkeit, Integrität und Verfügbarkeit geschützt werden müssen. |
| Scope-Matrix / Scope matrix | Tabelle, die jede Funktion als „drin", „draußen" oder „später" einordnet. |
| Annahme / Assumption | Vorausgesetzte Bedingung, die getrennt dokumentiert und später geprüft wird. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Fachdomäne beschreiben.** Halte fest, was ein „Fall" ist, welche Zustände er
durchläuft (`offen`, `in Arbeit`, `geschlossen`), wer ihn bearbeiten darf und welche Regeln gelten. Ohne
klares Domänenbild lässt sich kein Scope sinnvoll schneiden.

**EN:** **Step 1 – Describe the business domain.** Record what a "case" is, which states it passes through
(`open`, `in progress`, `closed`), who may work on it, and which rules apply. Without a clear domain picture,
no scope can be cut meaningfully.

**DE:** **Schritt 2 – Scope-Matrix bauen.** Ordne jede mögliche Funktion in eine Tabelle ein: „in Scope",
„Nicht-Ziel" oder „später". Warum eine Matrix? Sie zwingt zu einer Entscheidung je Zeile und macht Lücken
sichtbar. Ein „vielleicht" ohne Zeile ist eine unkontrollierte Annahme.

**EN:** **Step 2 – Build a scope matrix.** Sort every possible function into a table: "in scope", "non-goal",
or "later". Why a matrix? It forces a decision per row and makes gaps visible. A "maybe" without a row is an
uncontrolled assumption.

**DE:** **Schritt 3 – Schutzbedarf trennen.** Notiere Sicherheits-, Datenschutz- und Betriebsannahmen
getrennt von der Fachlichkeit. Beispiel: „Fall-IDs sind keine personenbezogenen Daten, Freitextfelder
können welche enthalten." Diese Trennung ist die Grundlage für spätere Bedrohungsmodelle.

**EN:** **Step 3 – Separate the protection need.** Note security, privacy, and operational assumptions
separately from the business logic. Example: "case IDs are not personal data, free-text fields may contain
some." This separation is the basis for later threat models.

**DE:** **Schritt 4 – Nicht-Ziele begründen.** Jedes Nicht-Ziel bekommt einen Satz Begründung. „Keine
Mehrmandantenfähigkeit in dieser Iteration, weil kein Kundenbedarf und höheres Risiko." So bleibt die
Entscheidung auditfähig und nachvollziehbar.

**EN:** **Step 4 – Justify non-goals.** Every non-goal gets one sentence of rationale. "No multi-tenancy in
this iteration, because there is no customer need and a higher risk." This keeps the decision audit-ready and
traceable.

**DE:** **Typische Fehler.** Scope nur im Kopf statt in einer Tabelle. Nicht-Ziele weglassen statt begründen.
Fachlichkeit und Sicherheit vermischen. Offene Punkte still übergehen, statt sie als `Open` mit Folgeaktion
zu notieren. Positive Sicherheitsaussagen ohne Nachweis treffen.

**EN:** **Common mistakes.** Keeping scope only in your head instead of in a table. Dropping non-goals
instead of justifying them. Mixing business logic and security. Silently ignoring open points instead of
recording them as `Open` with a follow-up. Making positive security claims without evidence.

### Beispiel / Example

```text
Scope-Matrix (Auszug)
Funktion                      | Einordnung   | Begründung
Fall anlegen / bearbeiten     | in Scope     | Kernfunktion der Erweiterung
Statuswechsel mit Regelprüfung| in Scope     | Fachliche Integrität
Export als CSV                | später       | erst nach Persistenz-Einheit
Mehrmandantenfähigkeit        | Nicht-Ziel   | kein Kundenbedarf, höheres Risiko
E-Mail-Versand                | Nicht-Ziel   | außerhalb der Domäne

Schutzbedarf (getrennt notiert)
Fall-ID    -> Integrität hoch, Vertraulichkeit niedrig (kein Personenbezug)
Freitext   -> Vertraulichkeit mittel (kann personenbezogene Daten enthalten)
Offen (Open): Aufbewahrungsfrist der Fälle -> Folgeaktion: mit Ausbilder klären
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12a Kundenspezifische Anwendungsentwicklung durchführen | Primär / Primary | Scope-Schnitt, Fachdomäne und Nicht-Ziele sind der Kern einer kundenspezifischen Entwicklungsentscheidung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Der getrennte Schutzbedarf ist eine erste Schutzbedarfsanalyse für die Erweiterung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Standards-Anwendbarkeit und sichere Architektur bereits im
Scope. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und `CL_10`
(Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser Einheit lautet: *Schutzbedarf wird vor dem
Bauen benannt, nicht danach.* A11Y-Aspekt: Die Scope-Matrix ist eine echte Texttabelle mit klaren
Spaltenüberschriften, damit sie mit Screenreader und Braille-Zeile lesbar bleibt; Einordnungen dürfen nicht
allein über Farbe signalisiert werden.

**EN:** Relation to the Secure Development Guideline: standards applicability and secure architecture already
in scope. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_10`
(secure development environment). The security decision of this unit is: *the protection need is named before
building, not after.* Accessibility aspect: the scope matrix is a real text table with clear column headers so
it stays readable with a screen reader and Braille display; classifications must not be signalled by color
alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist ein begründetes Nicht-Ziel wertvoller als ein weggelassenes Feature? /
   **EN:** Why is a justified non-goal more valuable than an omitted feature?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein begründetes Nicht-Ziel ist eine sichtbare, nachvollziehbare Entscheidung; ein weggelassenes
   Feature ist eine unsichtbare Lücke. Die Begründung schützt vor späterer Nacharbeit und macht den Scope
   auditfähig.
   **EN:** A justified non-goal is a visible, traceable decision; an omitted feature is an invisible gap. The
   rationale prevents later rework and makes the scope audit-ready.

   </details>

2. **DE:** Warum sollte der Schutzbedarf getrennt von der Fachlichkeit dokumentiert werden? /
   **EN:** Why should the protection need be documented separately from the business logic?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Getrennte Dokumentation macht Sicherheitsentscheidungen prüfbar und vermeidet, dass sie in der
   Fachlogik untergehen. Sie ist die Grundlage für spätere Bedrohungsmodelle und Reviews.
   **EN:** Separate documentation makes security decisions verifiable and prevents them from being buried in
   the business logic. It is the basis for later threat models and reviews.

   </details>

3. **DE:** Wozu dient die Scope-Matrix gegenüber einer reinen Aufzählung? /
   **EN:** What is the scope matrix good for compared to a plain list?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Matrix erzwingt je Funktion eine Einordnung (drin/draußen/später) mit Begründung und macht
   fehlende Entscheidungen sichtbar. Eine Aufzählung lässt „vielleicht"-Fälle offen.
   **EN:** The matrix forces a classification per function (in/out/later) with rationale and reveals missing
   decisions. A plain list leaves "maybe" cases open.

   </details>

4. **DE:** Wie gehst du mit einem noch nicht geklärten Punkt um? /
   **EN:** How do you handle a point that is not yet clarified?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `Open` mit konkreter Folgeaktion und Verantwortlichem notieren, nicht still übergehen. So bleibt
   der offene Punkt sichtbar und wird bewusst geschlossen.
   **EN:** Record it as `Open` with a concrete follow-up and owner, do not silently pass over it. This keeps
   the open point visible and lets it be closed deliberately.

   </details>

5. **DE:** Warum darf eine positive Sicherheitsaussage nur mit Nachweis stehen? /
   **EN:** Why may a positive security claim only stand with evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Nachweis ist die Aussage eine Behauptung, die bei einem Audit nicht standhält und falsche
   Sicherheit erzeugt. Ein Evidenzpfad macht sie prüfbar.
   **EN:** Without evidence the claim is an assertion that fails in an audit and creates false confidence. An
   evidence path makes it verifiable.

   </details>

6. **DE:** Was macht diese Einheit zu einer Aufgabe der kundenspezifischen Anwendungsentwicklung (LF 12a)? /
   **EN:** What makes this unit a task of customer-specific application development (LF 12a)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Scope wird an einem konkreten Kundenbedarf ausgerichtet und in kundenverständlicher,
   prüfbarer Form entschieden. Genau das ist kundenspezifische Entwicklung.
   **EN:** The scope is aligned to a concrete customer need and decided in a customer-understandable,
   verifiable form. That is exactly customer-specific development.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Fachdomäne mit Fällen, Zuständen und Rollen beschreiben.
- [ ] eine Scope-Matrix mit „drin/draußen/später" und Begründung erstellen.
- [ ] Nicht-Ziele mit je einer Begründung dokumentieren.
- [ ] Schutzbedarf getrennt von der Fachlichkeit notieren.
- [ ] offene Punkte als `Open` mit Folgeaktion festhalten.

**EN:** I can …

- [ ] describe the business domain with cases, states, and roles.
- [ ] create a scope matrix with "in/out/later" and rationale.
- [ ] document non-goals each with one rationale.
- [ ] note the protection need separately from the business logic.
- [ ] record open points as `Open` with a follow-up.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_01_Erweiterungs-Scope-und-Fachdomaene.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_01_Erweiterungs-Scope-und-Fachdomaene.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
