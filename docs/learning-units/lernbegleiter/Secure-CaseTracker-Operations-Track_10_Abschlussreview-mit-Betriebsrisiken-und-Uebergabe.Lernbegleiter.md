# Lernbegleiter: Secure CaseTracker Operations Track 10 – Abschlussreview mit Betriebsrisiken und Übergabe / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_10_Abschlussreview-mit-Betriebsrisiken-und-Uebergabe.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Am Ende des Operations Track steht die **Übergabe**: Der betriebene CaseTracker geht an eine andere
Person, ein anderes Team oder in den regulären Betrieb über. Damit das sauber gelingt, braucht es ein
**Abschlussreview**: eine ehrliche Gesamtschau über Betriebsrisiken, vorhandene Nachweise, offene Punkte und
eine klare Empfehlung. Übergabe heißt nicht „alles ist perfekt", sondern „der nächste weiß genau, was läuft,
was fehlt und worauf zu achten ist". Eine gute Übergabe verhindert, dass Wissen mit einer Person
verschwindet.

**EN:** At the end of the Operations Track comes the **handover**: the operated CaseTracker passes to another
person, another team, or into regular operation. For this to succeed cleanly you need a **final review**: an
honest overall view of operational risks, existing evidence, open items, and a clear recommendation. Handover
does not mean "everything is perfect" but "the next person knows exactly what runs, what is missing, and what
to watch for". A good handover prevents knowledge from vanishing with one person.

**DE:** In dieser Einheit lernst du, Betriebsrisiken zusammenzufassen, Nachweise vollständig zu bündeln,
offene Punkte als Folgeaufgaben zu formulieren und eine klare, ehrliche Übergabeempfehlung zu schreiben.

**EN:** In this unit you learn to summarize operational risks, bundle evidence completely, phrase open items
as follow-up tasks, and write a clear, honest handover recommendation.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Abschlussreview / Final review | Gesamtschau über Risiken, Nachweise und offene Punkte am Ende. |
| Betriebsrisiko / Operational risk | Risiko, das den laufenden Betrieb beeinträchtigen kann. |
| Nachweisliste / Evidence list | Gebündelte Übersicht aller vorhandenen Belege. |
| Folgeaufgabe / Follow-up task | Klar formulierter offener Punkt mit Verantwortlichem und Ziel. |
| Übergabeempfehlung / Handover recommendation | Ehrliche Aussage, ob und unter welchen Bedingungen übergeben wird. |
| Restrisiko / Residual risk | Risiko, das nach allen Maßnahmen bewusst bestehen bleibt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Betriebsrisiken zusammenfassen.** Gehe die Einheiten 01–09 durch und sammle die
verbliebenen Risiken: bekannte Lücken, Restrisiken aus Backup/Recovery, offene Härtungspunkte,
Abhängigkeitsrisiken. Fasse sie kurz, verständlich und nach Wichtigkeit geordnet zusammen. Wer übernimmt,
soll die Lage in wenigen Minuten erfassen können.

**EN:** **Step 1 – Summarize operational risks.** Go through units 01–09 and collect the remaining risks:
known gaps, residual risks from backup/recovery, open hardening items, dependency risks. Summarize them
briefly, understandably, and ordered by importance. Whoever takes over should grasp the situation in a few
minutes.

**DE:** **Schritt 2 – Nachweise bündeln.** Stelle alle Belege an einem Ort zusammen: Betriebszielbild,
Sandbox-Profil, Pipeline-Nachweise, Secret-/Config-Matrix, Log-/Alertregeln, Recovery-Ergebnis,
Incident-Ablauf, SBOM und Härtungsmatrix. Eine vollständige Nachweisliste macht die Übergabe prüfbar und
belegt, was tatsächlich getan wurde.

**EN:** **Step 2 – Bundle evidence.** Collect all evidence in one place: operations target picture, sandbox
profile, pipeline evidence, secret/config matrix, log/alert rules, recovery result, incident procedure, SBOM,
and hardening matrix. A complete evidence list makes the handover reviewable and proves what was actually
done.

**DE:** **Schritt 3 – Offene Punkte als Folgeaufgaben formulieren.** Jeder offene Punkt wird zu einer klaren
Folgeaufgabe: Was ist zu tun, warum, mit welcher Priorität, wer ist verantwortlich? Vage Hinweise („noch
verbessern") helfen niemandem. Eine gute Folgeaufgabe kann der Nächste ohne Rückfragen aufgreifen.

**EN:** **Step 3 – Phrase open items as follow-up tasks.** Each open item becomes a clear follow-up task: what
to do, why, with which priority, who is responsible? Vague hints ("improve later") help nobody. A good
follow-up task can be picked up by the next person without further questions.

**DE:** **Schritt 4 – Übergabeempfehlung schreiben.** Formuliere ehrlich, ob der Betrieb übergeben werden
kann und unter welchen Bedingungen. Nenne die verbleibenden Restrisiken ausdrücklich. Eine ehrliche
Empfehlung mit klaren Bedingungen ist wertvoller als ein pauschales „alles gut". Die Entscheidung selbst
trifft die Ausbildung, nicht der Lernbegleiter.

**EN:** **Step 4 – Write the handover recommendation.** State honestly whether operation can be handed over
and under which conditions. Name the remaining residual risks explicitly. An honest recommendation with clear
conditions is more valuable than a blanket "all good". The decision itself is made by the training, not by the
study companion.

**DE:** **Typische Fehler.** Risiken schönen oder verschweigen. Nachweise verstreut lassen. Offene Punkte
ohne Verantwortlichen. Eine Empfehlung ohne Bedingungen. Wissen im Kopf behalten, statt es übergabefähig
aufzuschreiben.

**EN:** **Common mistakes.** Downplaying or hiding risks. Leaving evidence scattered. Open items without a
responsible person. A recommendation without conditions. Keeping knowledge in your head instead of writing it
down handover-ready.

### Beispiel / Example

```text
Top-Betriebsrisiko:  Recovery-Übung ausstehend -> Verfügbarkeit im Ernstfall unbelegt (Prio hoch)
Nachweisliste:       Betriebszielbild, Pipeline-Nachweis, Secret-Matrix, SBOM, Härtungsmatrix (alle vorhanden)
Folgeaufgabe:        "Restore-Test durchführen und Zeit gegen RTO messen" - Owner: Betrieb - Prio hoch
Restrisiko:          bis zu 1 h Datenverlust (aus Einheit 06), dokumentiert und akzeptiert
Übergabeempfehlung:  "Übergabe möglich, sofern Restore-Test in Woche 1 nachgeholt wird."
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12b Kundenspezifische Systemintegration durchführen | Primär / Primary | Abschlussreview und Übergabe sind der kundenverständliche Abschluss der Systemintegration. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Risiko- und Restrisiko-Bewertung schließt die Schutzbedarfsbetrachtung des Betriebs ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: ehrliche Risikoaussage, gebündelte Evidenz, klare Übergabe
und auditfähige Dokumentation. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07` (sichere
Konfiguration/Betrieb), `CL_08` (Sicherheits-Review), `CL_10` (Logging/Nachweise), `CL_11`
(Freigabe/Übergabe) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet:
*Restrisiken werden ausdrücklich benannt; die Übergabe erfolgt mit klaren Bedingungen statt mit falscher
Sicherheit.* A11Y-Aspekt: Risikoübersicht, Nachweisliste und Folgeaufgaben werden als klarer Text geführt,
damit die übernehmende Person sie mit Screenreader und Braille-Zeile vollständig erfassen kann.

**EN:** Relation to the Secure Development Guideline: honest risk statement, bundled evidence, clear handover,
and audit-ready documentation. Matching checklists: `CL_01` (standards applicability), `CL_07` (secure
configuration/operation), `CL_08` (security review), `CL_10` (logging/evidence), `CL_11` (approval/handover),
and `CL_12` (documentation/N-A). The security decision of this unit is: *residual risks are named explicitly;
the handover happens with clear conditions instead of false confidence.* Accessibility aspect: risk overview,
evidence list, and follow-up tasks are kept as clear text, so the receiving person can fully grasp them with
a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist das Ziel eines Abschlussreviews vor der Übergabe? /
   **EN:** What is the goal of a final review before handover?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine ehrliche Gesamtschau: verbleibende Risiken, vorhandene Nachweise, offene Punkte und eine klare
   Empfehlung. So kann die übernehmende Person die Lage schnell und vollständig verstehen.
   **EN:** An honest overall view: remaining risks, existing evidence, open items, and a clear recommendation.
   This lets the receiving person understand the situation quickly and completely.

   </details>

2. **DE:** Warum ist eine ehrliche Risikoaussage besser als „alles gut"? /
   **EN:** Why is an honest risk statement better than "all good"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Alles gut" verdeckt reale Risiken und erzeugt falsche Sicherheit. Eine ehrliche Aussage mit
   Bedingungen ermöglicht der übernehmenden Seite, bewusst zu handeln und Prioritäten zu setzen.
   **EN:** "All good" hides real risks and creates false confidence. An honest statement with conditions
   enables the receiving side to act deliberately and set priorities.

   </details>

3. **DE:** Was macht eine gute Folgeaufgabe aus? /
   **EN:** What makes a good follow-up task?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie ist klar: was zu tun ist, warum, mit welcher Priorität und wer verantwortlich ist. So kann der
   Nächste sie ohne Rückfragen aufgreifen. Vage Hinweise sind keine brauchbaren Folgeaufgaben.
   **EN:** It is clear: what to do, why, with which priority, and who is responsible. So the next person can
   pick it up without questions. Vague hints are not usable follow-up tasks.

   </details>

4. **DE:** (SI) Warum bündelt man alle Nachweise an einem Ort? /
   **EN:** (SI) Why do you bundle all evidence in one place?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine vollständige, gebündelte Nachweisliste macht die Übergabe prüfbar und belegt, was getan wurde.
   Verstreute Belege gehen verloren und lassen sich im Ernstfall oder Audit nicht schnell finden.
   **EN:** A complete, bundled evidence list makes the handover reviewable and proves what was done. Scattered
   evidence gets lost and cannot be found quickly in an incident or audit.

   </details>

5. **DE:** (SI) Warum werden Restrisiken in der Übergabe ausdrücklich genannt? /
   **EN:** (SI) Why are residual risks explicitly named in the handover?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kein Betrieb ist risikofrei. Ein bewusst benanntes Restrisiko (z. B. bis zu 1 h Datenverlust)
   erlaubt der übernehmenden Seite, es zu kennen, zu akzeptieren oder gezielt zu behandeln. Verschweigen wäre
   unehrlich und gefährlich.
   **EN:** No operation is risk-free. A deliberately named residual risk (e.g. up to 1 h data loss) lets the
   receiving side know, accept, or specifically address it. Hiding it would be dishonest and dangerous.

   </details>

6. **DE:** (SI) Warum entscheidet der Lernbegleiter nicht selbst über die Übergabe? /
   **EN:** (SI) Why does the study companion not decide the handover itself?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Lernbegleiter erklärt und bereitet vor. Die eigentliche Entscheidung trifft die Ausbildung
   bzw. der Betrieb – der Lernbegleiter ersetzt weder Ausbilderentscheidung noch betriebliche Freigabe.
   **EN:** The study companion explains and prepares. The actual decision is made by the training or operation
   – the companion replaces neither instructor decision nor operational approval.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Betriebsrisiken aus den Einheiten 01–09 nach Wichtigkeit zusammenfassen.
- [ ] alle vorhandenen Nachweise zu einer vollständigen Liste bündeln.
- [ ] offene Punkte als klare Folgeaufgaben mit Owner und Priorität formulieren.
- [ ] Restrisiken ausdrücklich benennen statt zu verschweigen.
- [ ] eine ehrliche Übergabeempfehlung mit klaren Bedingungen schreiben.

**EN:** I can …

- [ ] summarize the operational risks from units 01–09 by importance.
- [ ] bundle all existing evidence into a complete list.
- [ ] phrase open items as clear follow-up tasks with owner and priority.
- [ ] name residual risks explicitly instead of hiding them.
- [ ] write an honest handover recommendation with clear conditions.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_10_Abschlussreview-mit-Betriebsrisiken-und-Uebergabe.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_10_Abschlussreview-mit-Betriebsrisiken-und-Uebergabe.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
