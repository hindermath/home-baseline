# Lernbegleiter: Secure CaseTracker Application Track 09 – Security-ADR und Architektur-Trade-offs / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_09_Security-ADR-und-Architektur-Trade-offs.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Architekturentscheidungen sind selten „richtig" oder „falsch" – sie sind **Abwägungen** (Trade-offs).
Mehr Sicherheit kostet oft Komfort, Geschwindigkeit oder Aufwand. Damit solche Entscheidungen später
nachvollziehbar bleiben, schreibt man sie als **Architecture Decision Record** (ADR) auf: Kontext, betrachtete
Alternativen, Entscheidung, Folgen und **Restrisiken**. In dieser Einheit dokumentierst du die wichtigsten
sicherheitsrelevanten Entscheidungen des CaseTracker als Security-ADRs. Bild dazu: das Protokoll einer
Bauabnahme. Man hält fest, warum man sich für eine bestimmte Bauweise entschieden hat, welche Alternativen es
gab und welche Risiken bewusst in Kauf genommen wurden.

**EN:** Architecture decisions are rarely "right" or "wrong" – they are **trade-offs**. More security often
costs convenience, speed, or effort. So that such decisions stay traceable later, you write them down as an
**Architecture Decision Record** (ADR): context, considered alternatives, decision, consequences, and
**residual risks**. In this unit you document the most important security-relevant decisions of the CaseTracker
as security ADRs. The picture: the record of a building inspection. You note why a certain construction was
chosen, which alternatives existed, and which risks were deliberately accepted.

**DE:** Du lernst, eine Entscheidung ehrlich zu begründen – inklusive der Nachteile – und Restrisiken sichtbar
zu machen, statt sie zu verschweigen.

**EN:** You learn to justify a decision honestly – including its downsides – and to make residual risks
visible instead of hiding them.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| ADR / ADR | Kurzdokument, das eine Architekturentscheidung mit Kontext und Folgen festhält. |
| Trade-off / Trade-off | Abwägung, bei der ein Vorteil einen Preis an anderer Stelle hat. |
| Alternative / Alternative | Eine ernsthaft geprüfte andere Option, die verworfen wurde. |
| Restrisiko / Residual risk | Bewusst akzeptiertes Rest-Risiko nach einer Entscheidung. |
| Kontext / Context | Randbedingungen, unter denen die Entscheidung getroffen wurde. |
| Konsequenz / Consequence | Positive und negative Folge der getroffenen Entscheidung. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Entscheidung und Kontext benennen.** Beschreibe die konkrete Frage („Wie wird
Autorisierung geprüft?") und die Randbedingungen (Zielsprachen, Sandbox, keine echten personenbezogenen
Daten). Ohne Kontext ist eine Entscheidung später nicht bewertbar.

**EN:** **Step 1 – Name the decision and context.** Describe the concrete question ("How is authorization
checked?") and the constraints (target languages, sandbox, no real personal data). Without context, a decision
cannot be judged later.

**DE:** **Schritt 2 – Alternativen ehrlich prüfen.** Nenne mindestens zwei ernsthaft betrachtete Optionen mit
ihren Vor- und Nachteilen. Eine ADR mit nur einer Option ist keine Abwägung, sondern eine Behauptung.

**EN:** **Step 2 – Assess alternatives honestly.** Name at least two seriously considered options with their
pros and cons. An ADR with only one option is not a trade-off but an assertion.

**DE:** **Schritt 3 – Entscheiden und Trade-off benennen.** Triff die Entscheidung und sage klar, *was sie
kostet*. Beispiel: „Zentrale serverseitige Autorisierung: sicherer, aber ein zusätzlicher Prüfpunkt und etwas
mehr Latenz." Der genannte Preis macht die Entscheidung glaubwürdig.

**EN:** **Step 3 – Decide and name the trade-off.** Make the decision and clearly state *what it costs*.
Example: "Central server-side authorization: safer, but an extra check point and slightly more latency." The
named price makes the decision credible.

**DE:** **Schritt 4 – Restrisiken und Folgeaktionen festhalten.** Notiere, welches Risiko bleibt und wie es
überwacht oder später verringert wird. Ein sichtbares Restrisiko mit Verantwortlichem ist besser als ein
unsichtbares. Verknüpfe die ADR mit Evidenz (Test, Review).

**EN:** **Step 4 – Record residual risks and follow-ups.** Note which risk remains and how it is monitored or
later reduced. A visible residual risk with an owner is better than an invisible one. Link the ADR to evidence
(test, review).

**DE:** **Typische Fehler.** Nur die gewählte Option nennen. Nachteile verschweigen. Restrisiken weglassen.
ADRs ohne Kontext schreiben, sodass man später nicht versteht, warum entschieden wurde. Entscheidungen nicht
mit Evidenz verknüpfen.

**EN:** **Common mistakes.** Naming only the chosen option. Hiding downsides. Omitting residual risks. Writing
ADRs without context, so later nobody understands why it was decided. Not linking decisions to evidence.

### Beispiel / Example

```text
ADR-2025-03: Autorisierung
  Kontext:      6 Zielsprachen, Sandbox, sichere Defaults gefordert.
  Alternativen: (A) serverseitig zentral   (B) verteilt je Modul   (C) nur UI-seitig
  Entscheidung: (A) serverseitig zentral.
  Trade-off:    + einheitlich, prüfbar, sicher; - ein zentraler Prüfpunkt, etwas Latenz.
  Verworfen:    (C) unsicher (umgehbar), (B) schwer konsistent zu halten.
  Restrisiko:   Fehlkonfiguration der zentralen Regel -> Folgeaktion: Autorisierungstest
                + Sicherheits-Code-Review (CL_08) als Evidenz.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12a Kundenspezifische Anwendungsentwicklung durchführen | Primär / Primary | Begründete, dokumentierte Architekturentscheidungen mit Trade-offs sind Kern kundenspezifischer Entwicklung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Restrisiken und sicherheitsrelevante Abwägungen setzen die Schutzbedarfsanalyse in Entscheidungen um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, dokumentierte Entscheidungen und
sichtbare Restrisiken. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser
Einheit lautet: *Jede sicherheitsrelevante Architekturentscheidung wird mit Alternativen, Trade-off und
Restrisiko dokumentiert.* A11Y-Aspekt: ADRs werden als strukturierter Text mit klaren Feldern (Kontext,
Alternativen, Entscheidung, Restrisiko) geschrieben, nicht nur als Diagramm, damit sie mit Screenreader und
Braille-Zeile vollständig erfassbar sind.

**EN:** Relation to the Secure Development Guideline: secure architecture, documented decisions, and visible
residual risks. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and
`CL_10` (secure development environment). The security decision of this unit is: *every security-relevant
architecture decision is documented with alternatives, trade-off, and residual risk.* Accessibility aspect:
ADRs are written as structured text with clear fields (context, alternatives, decision, residual risk), not
only as a diagram, so they are fully accessible with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine ADR mit nur einer Option keine echte Abwägung? /
   **EN:** Why is an ADR with only one option not a real trade-off?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne betrachtete Alternativen fehlt der Vergleich, der eine Entscheidung begründet. Es bleibt eine
   Behauptung, keine nachvollziehbare Abwägung.
   **EN:** Without considered alternatives, the comparison that justifies a decision is missing. It stays an
   assertion, not a traceable trade-off.

   </details>

2. **DE:** Warum gehört zu jeder Entscheidung der genannte Preis (Trade-off)? /
   **EN:** Why does every decision include the named price (trade-off)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Entscheidung hat Nachteile. Werden sie benannt, ist die Entscheidung ehrlich, überprüfbar und
   später anpassbar. Verschwiegene Nachteile überraschen im Betrieb.
   **EN:** Every decision has downsides. If named, the decision is honest, verifiable, and later adjustable.
   Hidden downsides surprise you in operation.

   </details>

3. **DE:** Was ist ein Restrisiko und warum wird es sichtbar gemacht? /
   **EN:** What is a residual risk and why is it made visible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein bewusst akzeptiertes Rest-Risiko nach der Entscheidung. Sichtbar mit Verantwortlichem kann es
   überwacht und später verringert werden; unsichtbar wird es zur bösen Überraschung.
   **EN:** A deliberately accepted remaining risk after the decision. Visible with an owner it can be monitored
   and later reduced; invisible it becomes a nasty surprise.

   </details>

4. **DE:** Warum braucht eine ADR den Kontext, unter dem entschieden wurde? /
   **EN:** Why does an ADR need the context under which it was decided?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Kontext erklärt, warum die Entscheidung damals sinnvoll war. Ändert sich der Kontext, weiß man,
   dass die ADR neu bewertet werden sollte.
   **EN:** The context explains why the decision made sense at the time. If the context changes, you know the
   ADR should be re-evaluated.

   </details>

5. **DE:** Wie verknüpfst du eine ADR mit prüfbarer Evidenz? /
   **EN:** How do you link an ADR to verifiable evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über einen Verweis auf Tests, Reviews oder Nachweise, die die Entscheidung stützen (z. B.
   Autorisierungstest, Sicherheits-Code-Review). So bleibt die Aussage belegt statt behauptet.
   **EN:** Through a reference to tests, reviews, or evidence supporting the decision (e.g. an authorization
   test, a security code review). This keeps the statement proven instead of claimed.

   </details>

6. **DE:** Warum ist dieses Dokumentieren eine Aufgabe der kundenspezifischen Anwendungsentwicklung (LF 12a)? /
   **EN:** Why is this documentation a task of customer-specific application development (LF 12a)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kundenspezifische Entwicklung verlangt nachvollziehbare, begründete Entscheidungen, die der Kunde
   und spätere Teams verstehen und prüfen können. ADRs liefern genau diese Nachvollziehbarkeit.
   **EN:** Customer-specific development requires traceable, justified decisions that the customer and later
   teams can understand and check. ADRs provide exactly this traceability.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Entscheidung und Kontext einer ADR klar benennen.
- [ ] mindestens zwei Alternativen mit Vor- und Nachteilen prüfen.
- [ ] den Trade-off der gewählten Option offen benennen.
- [ ] Restrisiken mit Folgeaktion und Verantwortlichem festhalten.
- [ ] eine ADR mit prüfbarer Evidenz verknüpfen.

**EN:** I can …

- [ ] clearly name an ADR's decision and context.
- [ ] assess at least two alternatives with pros and cons.
- [ ] openly name the trade-off of the chosen option.
- [ ] record residual risks with a follow-up and owner.
- [ ] link an ADR to verifiable evidence.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_09_Security-ADR-und-Architektur-Trade-offs.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_09_Security-ADR-und-Architektur-Trade-offs.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
