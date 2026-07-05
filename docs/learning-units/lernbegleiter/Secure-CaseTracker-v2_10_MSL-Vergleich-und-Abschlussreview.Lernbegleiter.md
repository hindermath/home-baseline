# Lernbegleiter: Secure CaseTracker v2 10 – MSL-Vergleich und Abschlussreview / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_10_MSL-Vergleich-und-Abschlussreview.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Am Ende einer Reihe zieht man Bilanz. In v2 hast du dasselbe fachliche Ziel für sechs
speichersichere Sprachen (**MSL** – Memory-Safe Languages: C#, Go, Java, Python, Rust, Swift) betrachtet.
Jetzt vergleichst du sie fair: nach klaren **Vergleichskriterien**, nicht nach Geschmack. Ein
**Abschlussreview** hält fest, was gut lief, welche **offenen Risiken** bleiben, welche **Restrisiken**
bewusst akzeptiert werden und welche **Folgeaufgaben** entstehen. Am Schluss steht eine **Übergabenotiz**,
die eine andere Person verstehen könnte, ohne dabei gewesen zu sein.

**EN:** At the end of a series you take stock. In v2 you looked at the same business goal for six memory-safe
languages (**MSL**: C#, Go, Java, Python, Rust, Swift). Now you compare them fairly: by clear **comparison
criteria**, not by taste. A **final review** records what went well, which **open risks** remain, which
**residual risks** are deliberately accepted, and which **follow-up tasks** arise. At the end there is a
**handover note** that another person could understand without having been there.

**DE:** Wichtig: **MSL-Status ist kein Freibrief.** Dass eine Sprache speichersicher ist, ersetzt keine
sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung. Der Vergleich muss deshalb ehrlich und
nachweisbasiert sein.

**EN:** Important: **MSL status is not a free pass.** That a language is memory-safe does not replace secure
API, I/O, auth, crypto, logging, or dependency review. The comparison must therefore be honest and
evidence-based.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| MSL / Memory-Safe Language | Sprache, die typische Speicherfehler von sich aus verhindert. |
| Vergleichskriterium / Comparison criterion | Klar definierter Maßstab, an dem alle Sprachen gemessen werden. |
| Restrisiko / Residual risk | Bewusst akzeptiertes Risiko, das nach den Maßnahmen bleibt. |
| Offenes Risiko / Open risk | Noch nicht behandeltes Risiko mit nötiger Folgeaktion. |
| Übergabenotiz / Handover note | Zusammenfassung, die Dritte ohne Vorwissen verstehen können. |
| Nachweisbasiert / Evidence-based | Aussagen werden mit Belegen statt Meinungen gestützt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Vergleichskriterien festlegen.** Bestimme *vorher* die Maßstäbe, an denen du alle sechs
Sprachen misst: z. B. Klarheit der Validierung, Aufwand für sichere Deserialisierung, Qualität der
Fehlerbehandlung, Reife der Abhängigkeiten, Testbarkeit. **Warum wichtig:** Kriterien vorher festzulegen
verhindert, dass man am Ende die Lieblingssprache schönredet. Der Vergleich wird fair und nachvollziehbar.

**EN:** **Step 1 – Define comparison criteria.** Determine *beforehand* the standards by which you measure all
six languages: e.g. clarity of validation, effort for safe deserialization, quality of error handling,
maturity of dependencies, testability. **Why it matters:** setting criteria beforehand prevents talking up
your favourite language at the end. The comparison becomes fair and traceable.

**DE:** **Schritt 2 – Nachweisbasiert vergleichen.** Fülle je Kriterium und Sprache mit Belegen aus den
vorherigen Einheiten (Testmatrix, Fehlermodell, Rechtematrix). **Warum wichtig:** Ein Vergleich aus Meinungen
ist wertlos. MSL-Status allein sagt nichts über sichere I/O oder Dependencies – nur Nachweise zählen.

**EN:** **Step 2 – Compare with evidence.** Fill per criterion and language with evidence from the previous
units (test matrix, error model, role matrix). **Why it matters:** a comparison of opinions is worthless. MSL
status alone says nothing about safe I/O or dependencies – only evidence counts.

**DE:** **Schritt 3 – Risiken trennen und einordnen.** Unterscheide offene Risiken (brauchen noch eine
Aktion) von akzeptierten Restrisiken (bewusst hingenommen, mit Begründung). **Warum wichtig:** Wer alle
Risiken als „erledigt“ darstellt, täuscht. Ehrliche Trennung macht Entscheidungen prüfbar und die Reihe
auditfähig.

**EN:** **Step 3 – Separate and classify risks.** Distinguish open risks (still need an action) from accepted
residual risks (deliberately tolerated, with a rationale). **Why it matters:** presenting all risks as "done"
is deceptive. Honest separation makes decisions reviewable and the series auditable.

**DE:** **Schritt 4 – Folgeaufgaben und Übergabenotiz schreiben.** Notiere klare Folgeaufgaben mit Owner und
Auslöser für erneute Prüfung. Schreibe eine Übergabenotiz, die eine dritte Person ohne Vorwissen versteht –
auch über Systemgrenzen und Schnittstellen hinweg (Bezug DV). **Warum wichtig:** Eine gute Übergabe ist der
eigentliche Wert des Abschlusses; ohne sie geht Wissen verloren.

**EN:** **Step 4 – Write follow-up tasks and the handover note.** Note clear follow-up tasks with owner and a
trigger for re-evaluation. Write a handover note that a third person understands without prior knowledge –
also across system boundaries and interfaces (DV relation). **Why it matters:** a good handover is the actual
value of the closing; without it, knowledge is lost.

**DE:** **Typische Fehler.** Kriterien erst am Ende erfinden. Meinungen statt Nachweise. Alle Risiken als
gelöst darstellen. Keine Folgeaufgaben mit Owner. Eine Übergabenotiz, die nur Eingeweihte verstehen.

**EN:** **Common mistakes.** Inventing criteria only at the end. Opinions instead of evidence. Presenting all
risks as solved. No follow-up tasks with an owner. A handover note only insiders understand.

### Beispiel / Example

```text
Vergleichsmatrix (Auszug; nachweisbasiert, Kriterien vorher festgelegt):

  Kriterium               C#     Go     Java   Python  Rust   Swift   Beleg
  Validierung klar        gut    gut    gut    gut     gut    gut     Einheit 04
  Sichere Deserial.       ok     ok     ok     Vorsicht ok    ok      Einheit 07
  Dependency-Reife        hoch   hoch   hoch   hoch    hoch   mittel  Audit-Notiz

Risiken:
  Offen:      Dependency X ohne aktuellen Audit-Stand -> Folgeaufgabe (Owner: Team, Trigger: Release)
  Restrisiko: Sandbox-Nutzung erst ab Jahr 3 -> bewusst akzeptiert, dokumentiert

Uebergabenotiz: Ziel, Stand, offene Punkte, naechste Schritte - fuer Dritte ohne Vorwissen verstaendlich
Hinweis: MSL-Status ersetzt KEINE sichere I/O-, Auth-, Crypto- oder Dependency-Pruefung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Abschlussreview und Übergabenotiz schließen den Service kundenverständlich ab. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Der Vergleich bewertet die datenverwaltende Lösung über alle sechs Sprachen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähige Nachweise, ehrliche Risikobewertung,
Supply-Chain-/Dependency-Bezug und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit),
`CL_08` (Sicherheits-Code-Review), `CL_09` (Betrieb/Deployment), `CL_10` (Datenschutz), `CL_11`
(CI/Nachweise) und `CL_12` (Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet:
*Vergleich und Abschluss sind nachweisbasiert und ehrlich; MSL-Status ersetzt keine Sicherheitsprüfung.*
A11Y-Aspekt: Vergleichsmatrix und Übergabenotiz müssen als reiner Text lesbar sein; Bewertungen dürfen nicht
nur über Farbe transportiert werden, damit Screenreader- und Braille-Nutzende sie erfassen.

**EN:** Relation to the Secure Development Guideline: auditable evidence, honest risk assessment,
supply-chain/dependency relation, and testability. Matching checklists: `CL_01` (standards applicability),
`CL_08` (security code review), `CL_09` (operation/deployment), `CL_10` (privacy), `CL_11` (CI/evidence), and
`CL_12` (evidence / N/A rationale). The security decision of this unit is: *comparison and closing are
evidence-based and honest; MSL status does not replace a security review.* Accessibility aspect: the
comparison matrix and handover note must be readable as plain text; assessments must not be carried only by
color, so screen-reader and Braille users can grasp them.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum müssen Vergleichskriterien vor dem Vergleich festgelegt werden? /
   **EN:** Why must comparison criteria be defined before the comparison?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Vorher festgelegte Kriterien verhindern, dass man am Ende die Lieblingssprache schönredet. Der
   Vergleich bleibt fair, nachvollziehbar und für alle sechs Sprachen gleich.
   **EN:** Criteria set beforehand prevent talking up the favourite language at the end. The comparison stays
   fair, traceable, and equal for all six languages.

   </details>

2. **DE:** Warum ist MSL-Status kein Freibrief für Sicherheit? /
   **EN:** Why is MSL status not a free pass for security?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Speichersicherheit verhindert typische Speicherfehler, aber nicht unsichere API, I/O, Auth, Crypto,
   Logging oder verwundbare Abhängigkeiten. Diese müssen weiterhin geprüft werden.
   **EN:** Memory safety prevents typical memory errors but not insecure API, I/O, auth, crypto, logging, or
   vulnerable dependencies. These must still be reviewed.

   </details>

3. **DE:** Worin unterscheiden sich offene Risiken und akzeptierte Restrisiken? /
   **EN:** How do open risks and accepted residual risks differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Offene Risiken brauchen noch eine Folgeaktion; Restrisiken werden bewusst und mit Begründung
   hingenommen. Die ehrliche Trennung macht die Bewertung prüfbar.
   **EN:** Open risks still need a follow-up action; residual risks are deliberately tolerated with a rationale.
   The honest separation makes the assessment reviewable.

   </details>

4. **DE:** (AE) Wie fließen die Ergebnisse früherer Einheiten in den Vergleich ein? /
   **EN:** (AE) How do the results of earlier units feed into the comparison?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Testmatrix, Fehlermodell, Rechtematrix und Import-/Export-Härtung liefern die Belege je Kriterium.
   So ist der Vergleich nachweisbasiert statt meinungsbasiert.
   **EN:** Test matrix, error model, role matrix, and import/export hardening provide the evidence per
   criterion. This makes the comparison evidence-based rather than opinion-based.

   </details>

5. **DE:** (SI) Welche Betriebs- und Dependency-Aspekte gehören in ein ehrliches Abschlussreview? /
   **EN:** (SI) Which operational and dependency aspects belong in an honest final review?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Betriebsannahmen, Sandbox-Entscheidung, Reife und Audit-Stand der Abhängigkeiten und bekannte
   Schwachstellen. Sie werden mit Nachweis oder begründetem `N/A`/`Open` festgehalten.
   **EN:** Operational assumptions, sandbox decision, maturity and audit status of dependencies, and known
   vulnerabilities. They are recorded with evidence or justified `N/A`/`Open`.

   </details>

6. **DE:** (DPA) Warum ist eine ehrliche Restrisiko-Angabe für spätere Datenauswertungen wichtig? /
   **EN:** (DPA) Why is an honest residual-risk statement important for later data analyses?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wer Restrisiken kennt, kann Kennzahlen und Aussagen richtig einordnen und ihre Grenzen benennen.
   Verschwiegene Risiken führen zu falschem Vertrauen in die Daten.
   **EN:** Knowing residual risks lets you correctly place metrics and statements and name their limits.
   Concealed risks lead to false trust in the data.

   </details>

7. **DE:** (DV) Warum muss eine Übergabenotiz Systemgrenzen und Schnittstellen klar benennen? /
   **EN:** (DV) Why must a handover note clearly name system boundaries and interfaces?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Andere Systeme und Teams docken über Schnittstellen an. Nur klar benannte Grenzen und Verträge
   erlauben eine sichere Weiterarbeit ohne Missverständnisse.
   **EN:** Other systems and teams connect via interfaces. Only clearly named boundaries and contracts allow
   safe continuation without misunderstandings.

   </details>

8. **DE:** Was macht eine gute Übergabenotiz aus? /
   **EN:** What makes a good handover note?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie fasst Ziel, Stand, offene Punkte und nächste Schritte so zusammen, dass eine dritte Person ohne
   Vorwissen versteht und weiterarbeiten kann.
   **EN:** It summarizes goal, status, open points, and next steps so that a third person without prior
   knowledge understands and can continue.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Vergleichskriterien vorab festlegen und für alle sechs Sprachen anwenden.
- [ ] den Vergleich nachweisbasiert statt meinungsbasiert führen.
- [ ] offene Risiken von akzeptierten Restrisiken unterscheiden.
- [ ] Folgeaufgaben mit Owner und Re-Evaluationsauslöser notieren.
- [ ] eine Übergabenotiz für Dritte ohne Vorwissen schreiben.

**EN:** I can …

- [ ] define comparison criteria in advance and apply them to all six languages.
- [ ] run the comparison evidence-based rather than opinion-based.
- [ ] distinguish open risks from accepted residual risks.
- [ ] note follow-up tasks with owner and re-evaluation trigger.
- [ ] write a handover note for third parties without prior knowledge.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_10_MSL-Vergleich-und-Abschlussreview.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_10_MSL-Vergleich-und-Abschlussreview.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
