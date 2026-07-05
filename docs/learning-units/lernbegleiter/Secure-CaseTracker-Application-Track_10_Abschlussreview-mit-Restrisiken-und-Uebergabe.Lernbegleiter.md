# Lernbegleiter: Secure CaseTracker Application Track 10 – Abschlussreview mit Restrisiken und Übergabe / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_10_Abschlussreview-mit-Restrisiken-und-Uebergabe.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Am Ende einer professionellen Entwicklung steht nicht „fertig", sondern ein **Abschlussreview** und
eine geordnete **Übergabe**. Man fasst die Ergebnisse zusammen, benennt offene Punkte und **Restrisiken**
ehrlich, verweist auf die Testnachweise und gibt eine klare **Übergabeempfehlung**. In dieser letzten Einheit
führst du alle Fäden der Einheiten 01–09 zusammen. Bild dazu: die Schlüsselübergabe einer fertigen Wohnung.
Man zeigt, was gemacht wurde, was noch aussteht, welche Mängel bewusst bleiben – und übergibt eine
verständliche Dokumentation, mit der die nächste Person weiterarbeiten kann.

**EN:** At the end of a professional development there is not "done" but a **final review** and an orderly
**handover**. You summarize the results, name open points and **residual risks** honestly, reference the test
evidence, and give a clear **handover recommendation**. In this final unit you bring together all threads from
units 01–09. The picture: handing over the keys to a finished flat. You show what was done, what is still open,
which defects deliberately remain – and hand over an understandable documentation with which the next person
can continue.

**DE:** Du lernst, ein ehrliches, auditfähiges Abschlussbild zu erstellen, das eine Entscheidung stützt:
freigeben, mit Auflagen freigeben oder zurückstellen.

**EN:** You learn to create an honest, audit-ready closing picture that supports a decision: release, release
with conditions, or defer.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Abschlussreview / Final review | Strukturierte Prüfung des Gesamtergebnisses am Ende. |
| Restrisiko / Residual risk | Bewusst verbleibendes Risiko, das benannt und getragen wird. |
| Übergabenotiz / Handover note | Kompaktes Dokument für die nächste Person oder das nächste Team. |
| Offener Punkt / Open item | Noch nicht erledigte Sache mit Folgeaktion und Verantwortlichem. |
| Testnachweis / Test evidence | Prüfbares Ergebnis der Tests als Beleg statt Behauptung. |
| Übergabeempfehlung / Handover recommendation | Klare Empfehlung: freigeben, mit Auflagen, oder zurückstellen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ergebnisse zusammenführen.** Sammle je Einheit den Stand: Scope, Architektur, API,
Rechte, Validierung, Persistenz, Tests, Secure Coding, ADRs. Ein Abschlussreview ohne vollständigen Überblick
übersieht Lücken.

**EN:** **Step 1 – Bring together the results.** Collect the status per unit: scope, architecture, API, rights,
validation, persistence, tests, secure coding, ADRs. A final review without a complete overview misses gaps.

**DE:** **Schritt 2 – Offene Punkte und Restrisiken ehrlich benennen.** Trage alles zusammen, was `Open` ist,
und alle bewusst akzeptierten Restrisiken – jeweils mit Folgeaktion und Verantwortlichem. Warum ehrlich? Ein
geschöntes Review führt zu falschen Entscheidungen und fällt im Audit auf.

**EN:** **Step 2 – Name open points and residual risks honestly.** Gather everything that is `Open` and all
deliberately accepted residual risks – each with a follow-up and owner. Why honestly? A whitewashed review
leads to wrong decisions and is exposed in an audit.

**DE:** **Schritt 3 – Nachweise verknüpfen.** Verweise auf Testläufe (CI-Nachweise), Reviews und
Sicherheitsdokumente. Positive Aussagen („Autorisierung sicher") stehen nur mit Evidenzpfad. So wird das
Review prüfbar, nicht behauptet.

**EN:** **Step 3 – Link the evidence.** Reference test runs (CI evidence), reviews, and security documents.
Positive claims ("authorization is secure") stand only with an evidence path. This makes the review verifiable,
not asserted.

**DE:** **Schritt 4 – Übergabeempfehlung geben.** Formuliere eine klare Empfehlung: freigeben, mit Auflagen
freigeben (welche?) oder zurückstellen (warum?). Schreibe eine kundenverständliche Übergabenotiz, damit die
nächste Person ohne Rückfragen weiterarbeiten kann.

**EN:** **Step 4 – Give a handover recommendation.** State a clear recommendation: release, release with
conditions (which?), or defer (why?). Write a customer-understandable handover note so the next person can
continue without follow-up questions.

**DE:** **Typische Fehler.** Nur Erfolge zeigen, Risiken verschweigen. Offene Punkte ohne Verantwortlichen
lassen. Aussagen ohne Evidenz treffen. Keine klare Empfehlung geben. Übergabenotiz zu technisch, sodass der
Kunde sie nicht versteht.

**EN:** **Common mistakes.** Showing only successes, hiding risks. Leaving open points without an owner. Making
claims without evidence. Giving no clear recommendation. A handover note too technical for the customer to
understand.

### Beispiel / Example

```text
Abschlussreview (Auszug)
Bereich        | Stand      | Nachweis / Evidenz
Autorisierung  | erledigt   | Autorisierungstests grün (CI #128), CL_08-Review
Validierung    | erledigt   | Negativtests grün, Response-Modell dokumentiert
Persistenz     | erledigt   | Integritätstests grün, Rollback-Plan dokumentiert
Export         | offen      | Folgeaktion: nächste Iteration, Owner: Team B

Restrisiko: zentrale Autorisierungsregel bei Fehlkonfiguration -> überwacht per Test.
Übergabeempfehlung: FREIGEBEN MIT AUFLAGE (Export in nächster Iteration nachziehen).
Übergabenotiz: kundenverständlich, 1 Seite, verweist auf Nachweise.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12a Kundenspezifische Anwendungsentwicklung durchführen | Primär / Primary | Abschlussreview und kundenverständliche Übergabe sind der Abschluss einer kundenspezifischen Entwicklung. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Übergabe umfasst den geprüften Stand der angepassten Datenverwaltung samt Integritätsnachweisen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähige Evidenz, sichtbare Restrisiken und
verantwortliche Übergabe. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser
Einheit lautet: *Es wird nur mit belegter Evidenz und offen benannten Restrisiken übergeben.* A11Y-Aspekt: Der
Reviewbericht und die Übergabenotiz sind als klar strukturierter Text mit Überschriften und Tabellen
formuliert; der Status („erledigt", „offen") steht als Wort und nicht nur als Farbe, damit alles mit
Screenreader und Braille-Zeile lesbar bleibt.

**EN:** Relation to the Secure Development Guideline: audit-ready evidence, visible residual risks, and
responsible handover. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review),
and `CL_10` (secure development environment). The security decision of this unit is: *handover happens only
with proven evidence and openly named residual risks.* Accessibility aspect: the review report and handover
note are written as clearly structured text with headings and tables; the status ("done", "open") stands as a
word and not only as a color, so everything stays readable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehört zu einem Abschlussreview mehr als eine Liste der Erfolge? /
   **EN:** Why does a final review need more than a list of successes?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es muss auch offene Punkte und Restrisiken zeigen, damit die Entscheidung (freigeben oder nicht) auf
   einem ehrlichen Gesamtbild beruht. Nur Erfolge zu zeigen führt zu falschen Entscheidungen.
   **EN:** It must also show open points and residual risks so the decision (release or not) rests on an honest
   overall picture. Showing only successes leads to wrong decisions.

   </details>

2. **DE:** Warum bekommt jeder offene Punkt eine Folgeaktion und einen Verantwortlichen? /
   **EN:** Why does every open point get a follow-up and an owner?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Folgeaktion und Verantwortlichen bleibt ein offener Punkt liegen. Mit beidem ist klar, was
   passiert und wer es tut.
   **EN:** Without a follow-up and owner, an open point is left lying around. With both it is clear what happens
   and who does it.

   </details>

3. **DE:** Warum darf eine positive Sicherheitsaussage nur mit Evidenzpfad stehen? /
   **EN:** Why may a positive security claim only stand with an evidence path?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Beleg ist sie eine Behauptung, die im Audit nicht hält und falsche Sicherheit erzeugt. Ein
   Evidenzpfad (Test, Review) macht sie prüfbar.
   **EN:** Without proof it is a claim that fails in an audit and creates false confidence. An evidence path
   (test, review) makes it verifiable.

   </details>

4. **DE:** Was unterscheidet „freigeben mit Auflage" von „freigeben"? /
   **EN:** What distinguishes "release with conditions" from "release"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Mit Auflage" benennt konkrete Bedingungen, die noch erfüllt oder überwacht werden müssen. Es ist
   eine ehrliche Zwischenlösung statt einer vorschnellen Freigabe.
   **EN:** "With conditions" names concrete conditions still to be met or monitored. It is an honest middle
   ground instead of a premature release.

   </details>

5. **DE:** Warum muss die Übergabenotiz kundenverständlich sein? /
   **EN:** Why must the handover note be customer-understandable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Kunde und das nächste Team müssen ohne tiefes technisches Wissen erkennen, was übergeben wurde
   und was zu tun bleibt. Zu technische Notizen führen zu Rückfragen und Fehlern.
   **EN:** The customer and the next team must recognize without deep technical knowledge what was handed over
   and what remains to be done. Overly technical notes cause follow-up questions and errors.

   </details>

6. **DE:** Wie zeigt sich der Status im Reviewbericht barrierefrei? /
   **EN:** How is the status shown accessibly in the review report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als Wort („erledigt", „offen") in einer Texttabelle, nicht allein über Farbe. So bleibt der Status
   mit Screenreader und Braille-Zeile eindeutig lesbar.
   **EN:** As a word ("done", "open") in a text table, not by color alone. This keeps the status unambiguously
   readable with a screen reader and Braille display.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Ergebnisse aller Einheiten zu einem Überblick zusammenführen.
- [ ] offene Punkte und Restrisiken ehrlich mit Folgeaktion benennen.
- [ ] positive Aussagen mit Evidenzpfad belegen.
- [ ] eine klare Übergabeempfehlung (freigeben/Auflage/zurückstellen) geben.
- [ ] eine kundenverständliche, barrierefreie Übergabenotiz schreiben.

**EN:** I can …

- [ ] merge the results of all units into an overview.
- [ ] name open points and residual risks honestly with a follow-up.
- [ ] back positive claims with an evidence path.
- [ ] give a clear handover recommendation (release/conditions/defer).
- [ ] write a customer-understandable, accessible handover note.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_10_Abschlussreview-mit-Restrisiken-und-Uebergabe.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_10_Abschlussreview-mit-Restrisiken-und-Uebergabe.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
