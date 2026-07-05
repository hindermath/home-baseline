# Lernbegleiter: Secure CaseTracker Data & Process Track 04 – Datenschutz, Zweckbindung und Datenminimierung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Data-Process-Track_04_Datenschutz-Zweckbindung-und-Datenminimierung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wer Prozesse mit Falldaten auswertet, arbeitet oft nah an personenbezogenen Daten: Wer hat einen Fall
bearbeitet, wer war Kundin oder Kunde. Datenschutz heißt hier nicht „alles verbieten", sondern zwei einfache
Fragen konsequent stellen: *Wofür* brauchen wir ein Feld (**Zweckbindung**), und *wie wenig* reicht
(**Datenminimierung**)? Für eine Durchlaufzeit braucht man Datumsfelder, aber selten den Klarnamen einer
Person. Oft genügt eine **Pseudonymisierung**, die Auswertung erlaubt, ohne Personen direkt zu zeigen.

**EN:** Anyone who evaluates processes with case data often works close to personal data: who processed a
case, who was the customer. Data protection here does not mean "forbid everything", but consistently asking
two simple questions: *for what* do we need a field (**purpose limitation**), and *how little* is enough
(**data minimization**)? A throughput time needs date fields, but rarely a person's real name. Often a
**pseudonymization** is enough, allowing evaluation without directly showing individuals.

**DE:** In dieser Einheit lernst du, Personenbezug zu erkennen, Zweckbindung und Minimierung zu prüfen,
Pseudonymisierung sinnvoll einzusetzen und Nichtanwendbarkeit sauber mit `N/A`-Begründung zu dokumentieren.

**EN:** In this unit you learn to recognize personal reference, to check purpose limitation and minimization,
to use pseudonymization sensibly, and to document non-applicability cleanly with an `N/A` justification.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Personenbezug / Personal reference | Ein Datum lässt sich direkt oder indirekt einer Person zuordnen. |
| Zweckbindung / Purpose limitation | Daten nur für den Zweck nutzen, für den sie erhoben wurden. |
| Datenminimierung / Data minimization | Nur so viele Daten erheben und nutzen, wie nötig. |
| Pseudonymisierung / Pseudonymization | Direkte Kennungen durch Platzhalter ersetzen, Zuordnung getrennt aufbewahren. |
| Anonymisierung / Anonymization | Personenbezug endgültig entfernen, sodass keine Rückführung möglich ist. |
| N/A-Begründung / N/A justification | Dokumentierte Aussage, warum eine Anforderung hier nicht anwendbar ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Personenbezug ehrlich prüfen.** Geh jedes Feld durch: Kann es allein oder in
Kombination eine Person identifizieren? Auch ein Bearbeiterkürzel oder eine seltene Fallkonstellation kann
Personenbezug herstellen. Was du nicht als personenbezogen erkennst, kannst du nicht schützen.

**EN:** **Step 1 – Check personal reference honestly.** Go through every field: can it identify a person alone
or in combination? Even a processor's initials or a rare case constellation can create personal reference.
What you do not recognize as personal, you cannot protect.

**DE:** **Schritt 2 – Zweckbindung festhalten.** Notiere je Feld den Erhebungszweck. Für die Kennzahl
„Durchlaufzeit" ist der Zweck die Prozessmessung; der Bearbeiter-Name gehört nicht dazu. Wird ein Feld für
einen neuen Zweck gebraucht, ist das eine neue Entscheidung, keine Selbstverständlichkeit.

**EN:** **Step 2 – Record purpose limitation.** Note the collection purpose per field. For the metric
"throughput time" the purpose is process measurement; the processor's name is not part of it. If a field is
needed for a new purpose, that is a new decision, not a matter of course.

**DE:** **Schritt 3 – Minimieren statt maximal sammeln.** Frage konsequent: Reicht ein Monat statt eines
genauen Datums? Reicht eine Kategorie statt eines Freitexts? Reicht ein Pseudonym statt des Namens? Je weniger
Personenbezug in der Auswertung steckt, desto kleiner ist das Risiko bei Fehlern oder Zugriffen.

**EN:** **Step 3 – Minimize instead of collecting maximally.** Consistently ask: does a month suffice instead
of an exact date? Does a category suffice instead of free text? Does a pseudonym suffice instead of the name?
The less personal reference the evaluation holds, the smaller the risk on errors or accesses.

**DE:** **Schritt 4 – Pseudonymisieren und N/A begründen.** Ersetze direkte Kennungen durch stabile
Platzhalter (z. B. `Bearbeiter_07`) und bewahre die Zuordnungstabelle getrennt und zugriffsgeschützt auf.
Wenn eine Datenschutzanforderung hier nicht greift, schreibe eine kurze `N/A`-Begründung – nicht einfach
weglassen. Beispiel: „Kein Klarname in der Auswertung, daher Namens-Maskierung `N/A`."

**EN:** **Step 4 – Pseudonymize and justify N/A.** Replace direct identifiers with stable placeholders (e.g.
`processor_07`) and keep the mapping table separate and access-protected. If a data-protection requirement
does not apply here, write a short `N/A` justification – do not simply omit it. Example: "no real name in the
evaluation, therefore name masking is `N/A`."

**DE:** **Typische Fehler.** Personenbezug übersehen (Kombination mehrerer Felder). Felder „für später"
mitnehmen. Pseudonymtabelle im selben Ordner wie die Auswertung. `N/A` ohne Begründung. Auswertung
verbreiten, ohne Zugriff zu beschränken.

**EN:** **Common mistakes.** Overlooking personal reference (combination of several fields). Keeping fields
"for later". Storing the pseudonym table in the same folder as the evaluation. `N/A` without a reason.
Distributing an evaluation without restricting access.

### Beispiel / Example

```text
Feld:            Bearbeiter-Name (Klarname)
Zweck erhoben:   Fallzuordnung im Betrieb
Zweck Auswertung: Durchlaufzeit je Monat -> Name NICHT noetig
Minimierung:     Klarname -> Pseudonym "Bearbeiter_07"
Zuordnungstabelle: getrennt gespeichert, nur Datenverantwortliche/r hat Zugriff
N/A-Beispiel:    Feld "Geburtsdatum" existiert nicht -> Alters-Auswertung N/A (Begruendung notiert)
Ergebnis:        Kennzahl bleibt berechenbar, Personenbezug in der Auswertung entfaellt
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Kundenspezifische Datenanalyse muss Zweckbindung und Datenminimierung nachweisbar einhalten. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Datenfelder, Pseudonymisierung und Zugriffsschutz betreffen die zugrunde liegende Datenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Datensparsamkeit, sichere Konfiguration und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Risiko- und
Bedrohungsblick), `CL_08` (Review der Datenverarbeitung), `CL_10` (Datenschutz) und `CL_12` (auditfähige
Nachweise). Die Datenentscheidung dieser Einheit lautet: *In der Auswertung steckt nur so viel Personenbezug,
wie der Zweck zwingend braucht.* A11Y-Aspekt: Datenschutz- und Minimierungsentscheidungen müssen als klare
Tabelle mit Begründung lesbar sein, ohne dass Bedeutung allein über Farbe transportiert wird.

**EN:** Relation to the Secure Development Guideline: data protection, data economy, secure configuration, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (risk and threat view),
`CL_08` (review of data processing), `CL_10` (data protection), and `CL_12` (audit-ready evidence). The data
decision of this unit is: *the evaluation holds only as much personal reference as the purpose strictly
needs.* Accessibility aspect: data-protection and minimization decisions must be readable as a clear table
with justification, without meaning carried by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet Zweckbindung von Datenminimierung? /
   **EN:** What distinguishes purpose limitation from data minimization?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zweckbindung fragt „*wofür* darf ich das Feld nutzen?", Minimierung fragt „*wie wenig* reicht?".
   Das eine begrenzt die Nutzung, das andere die Menge.
   **EN:** Purpose limitation asks "*for what* may I use the field?", minimization asks "*how little*
   suffices?". One limits use, the other limits amount.

   </details>

2. **DE:** (DPA) Warum ist der Bearbeiter-Name für eine Durchlaufzeit meist nicht nötig? /
   **EN:** (DPA) Why is the processor's name usually not needed for a throughput time?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Durchlaufzeit ergibt sich aus Eröffnungs- und Abschlussdatum. Der Name erhöht nur das
   Datenschutzrisiko, ohne die Kennzahl zu verbessern.
   **EN:** Throughput time follows from opening and closing dates. The name only raises the data-protection
   risk without improving the metric.

   </details>

3. **DE:** Warum kann Personenbezug auch ohne Namen entstehen? /
   **EN:** Why can personal reference arise even without a name?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch Kombination mehrerer Felder oder seltene Konstellationen (z. B. ein einziger Fall einer
   Kategorie) lässt sich eine Person indirekt identifizieren.
   **EN:** Through the combination of several fields or rare constellations (e.g. a single case of a category),
   a person can be identified indirectly.

   </details>

4. **DE:** Wozu dient die getrennte Speicherung der Pseudonym-Zuordnungstabelle? /
   **EN:** What is the separately stored pseudonym mapping table for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Solange die Zuordnung getrennt und zugriffsgeschützt liegt, erlaubt die Auswertung keine direkte
   Rückführung auf Personen. Liegt sie daneben, ist die Pseudonymisierung wirkungslos.
   **EN:** As long as the mapping is stored separately and access-protected, the evaluation allows no direct
   re-identification. If it lies next to it, the pseudonymization is ineffective.

   </details>

5. **DE:** Warum ist ein `N/A` ohne Begründung ein Fehler? /
   **EN:** Why is an `N/A` without a reason a mistake?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Begründung ist nicht prüfbar, ob die Anforderung wirklich nicht gilt oder nur übersehen wurde.
   Ein Audit braucht die kurze, sachliche Begründung.
   **EN:** Without a reason it is not verifiable whether the requirement truly does not apply or was just
   overlooked. An audit needs the short, objective justification.

   </details>

6. **DE:** (DPA) Wie hilft Datenminimierung, das Risiko bei einem Datenleck zu senken? /
   **EN:** (DPA) How does data minimization lower the risk in case of a data leak?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Je weniger Personenbezug in der Auswertung steckt, desto weniger kann bei einem Zugriff oder Leck
   abfließen. Minimierung reduziert den Schaden im Voraus.
   **EN:** The less personal reference the evaluation holds, the less can leak on an access or breach.
   Minimization reduces the damage in advance.

   </details>

7. **DE:** Wann reicht Pseudonymisierung nicht, und Anonymisierung ist besser? /
   **EN:** When is pseudonymization not enough, and anonymization is better?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn keine Rückführung auf Personen mehr gebraucht wird, ist Anonymisierung sicherer, weil kein
   Schlüssel mehr existiert. Pseudonymisierung behält eine (geschützte) Rückführbarkeit.
   **EN:** If re-identification is no longer needed, anonymization is safer because no key remains anymore.
   Pseudonymization keeps a (protected) re-identifiability.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] direkten und indirekten Personenbezug in Falldaten erkennen.
- [ ] den Zweck je Feld benennen und die Nutzung darauf begrenzen.
- [ ] Datenfelder auf ein minimal nötiges Maß reduzieren.
- [ ] Pseudonymisierung mit getrennter Zuordnungstabelle einsetzen.
- [ ] Nichtanwendbarkeit als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] recognize direct and indirect personal reference in case data.
- [ ] name the purpose per field and limit use to it.
- [ ] reduce data fields to a minimally necessary level.
- [ ] use pseudonymization with a separate mapping table.
- [ ] document non-applicability as `N/A` with a reason.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Data-Process-Track_04_Datenschutz-Zweckbindung-und-Datenminimierung.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Data-Process-Track_04_Datenschutz-Zweckbindung-und-Datenminimierung.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
