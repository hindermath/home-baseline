# Lernbegleiter: Secure OrderDesk Data & Process Track 04 – Datenschutz und Datenminimierung vertieft / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Auf den ersten Blick verarbeitet Secure OrderDesk nur nüchterne Handelsdaten: Kundennummer, Bestellung,
Positionen, Kategorien. Doch der Datenschutz beginnt genau dort, wo Handelsdaten unauffällig
**personenbeziehbar** werden: Ein `ContactName` wie „Maria Anders" verweist auf eine reale Person, eine
`Address` plus `Phone` macht sie erreichbar, und `City` in Kombination mit der Bestellhistorie kann eine einzelne
Kundenfirma eindeutig machen. Im 3. Lehrjahr prüfst du deshalb **jedes** Feld vertieft: Braucht die Auswertung es
überhaupt? Für welchen Zweck? Wie lange darf es gespeichert werden? Datenminimierung heißt: so wenig wie möglich,
so viel wie nötig – und das begründet. Der Northwind-Datensatz `ALFKI` (Alfreds Futterkiste, Kontakt Maria
Anders, Berlin) dient als fiktiver Beispielanker.

**EN:** At first glance Secure OrderDesk processes only sober trading data: customer number, order, line items,
categories. But privacy begins exactly where trading data quietly becomes **personally identifiable**: a
`ContactName` like "Maria Anders" points to a real person, an `Address` plus `Phone` makes them reachable, and
`City` combined with order history can make a single customer company unique. In year 3 you therefore examine
**each** field in depth: does the evaluation need it at all? For what purpose? How long may it be stored? Data
minimization means: as little as possible, as much as necessary – and justified. The Northwind record `ALFKI`
(Alfreds Futterkiste, contact Maria Anders, Berlin) serves as a fictional example anchor.

**DE:** Du lernst, direkten und indirekten Personenbezug zu erkennen, die Zweckbindung streng zu prüfen,
begründete Aufbewahrungs- und Löschfristen festzulegen und zwischen Aggregation, Pseudonymisierung (z. B.
Auswertung über `CustomerID` statt `ContactName`) und Verzicht zu wählen.

**EN:** You learn to recognize direct and indirect personal reference, to check purpose limitation strictly, to
set justified retention and deletion periods, and to choose between aggregation, pseudonymization (e.g.
evaluation via `CustomerID` instead of `ContactName`), and omission.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Personenbezug / Personal reference | Möglichkeit, Daten einer natürlichen Person zuzuordnen, direkt oder indirekt. |
| Indirekter Personenbezug / Indirect reference | Bezug, der erst durch Kombination entsteht, z. B. `City` plus Bestellhistorie. |
| Zweckbindung / Purpose limitation | Daten nur für den Zweck nutzen, für den sie erhoben wurden. |
| Datenminimierung / Data minimization | So wenig Daten wie möglich erheben, speichern und auswerten. |
| Aufbewahrungsfrist / Retention period | Begründete Zeit, nach der Daten gelöscht oder aggregiert werden. |
| Pseudonymisierung / Pseudonymization | Kennung durch ein Pseudonym ersetzen, z. B. `CustomerID` statt `ContactName`. |
| Re-Identifikation / Re-identification | Rückschluss auf eine Person aus kleinen Gruppen, z. B. eine Kundenfirma je Stadt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Jedes Feld auf Personenbezug prüfen.** Gehe die Felder einzeln durch und frage: Kann dies
direkt oder in Kombination auf eine Person zeigen? `CategoryID` allein ist neutral. `ContactName = Maria Anders`
ist direkt beziehbar. `City + Bestellhistorie` kann indirekt eine einzelne Kundenfirma identifizieren. Trage die
Einstufung in eine Matrix ein.

**EN:** **Step 1 – Check each field for personal reference.** Go through the fields one by one and ask: can this
point to a person directly or in combination? `CategoryID` alone is neutral. `ContactName = Maria Anders` is
directly identifiable. `City + order history` can indirectly identify a single customer company. Record the
classification in a matrix.

**DE:** **Schritt 2 – Zweckbindung streng anwenden.** Für jedes personenbeziehbare Feld gilt: Es darf nur für den
erhobenen Zweck genutzt werden. Ein `ContactName` für die Rechnungsstellung darf nicht heimlich zur
Profilbildung über das Kaufverhalten einer Person verwendet werden. Felder ohne klaren Zweck gehören nicht in die
Auswertung.

**EN:** **Step 2 – Apply purpose limitation strictly.** For each personally identifiable field: it may only be
used for the purpose it was collected for. A `ContactName` for invoicing must not be secretly used to profile a
person's buying behavior. Fields without a clear purpose do not belong in the evaluation.

**DE:** **Schritt 3 – Aufbewahrung und Löschung begründen.** Daten sollen nicht „für immer" liegen. Lege je Feld
fest, wie lange es gebraucht wird und was danach passiert: löschen oder zu einer anonymen Kennzahl aggregieren.
Beispiel: „Kontaktdaten werden nach Ablauf der handels-/steuerrechtlichen Frist gelöscht; nur aggregierte
Umsätze je Kategorie bleiben erhalten."

**EN:** **Step 3 – Justify retention and deletion.** Data should not lie around "forever". Define per field how
long it is needed and what happens afterwards: delete it or aggregate it to an anonymous metric. Example:
"contact data is deleted after the commercial/tax retention period; only aggregated revenue per category
remains."

**DE:** **Schritt 4 – Minimierungsmaßnahme wählen.** Für risikobehaftete Felder gibt es Optionen: **Verzicht**
(Feld gar nicht erheben), **Aggregation** (nur Gruppenwerte), **Pseudonymisierung** (Auswertung über `CustomerID`
statt `ContactName`). Verzicht ist am stärksten, Pseudonymisierung am schwächsten, weil sie mit Zusatzwissen
umkehrbar sein kann. Wähle die stärkste Maßnahme, die die fachliche Frage noch beantwortet. Achte auf
Re-Identifikation: Ist nur eine Kundenfirma je Stadt vorhanden, verrät ein Stadtwert die Firma trotz
Pseudonymisierung.

**EN:** **Step 4 – Choose a minimization measure.** For risky fields there are options: **omission** (do not
collect the field), **aggregation** (only group values), **pseudonymization** (evaluate via `CustomerID` instead
of `ContactName`). Omission is strongest, pseudonymization weakest because it can be reversible with extra
knowledge. Choose the strongest measure that still answers the business question. Watch re-identification: if only
one customer company exists per city, a city value reveals the company despite pseudonymization.

**DE:** **Schritt 5 – Datenschutzentscheidung auditfähig dokumentieren.** Halte je Feld fest: Personenbezug,
Zweck, Aufbewahrung, Maßnahme und Begründung. Positive Aussagen wie „anonymisiert" brauchen ein nachvollziehbares
Verfahren. „Wir werten nur über `CustomerID` aus, also anonym" ist ohne Prüfung der Gruppengröße kein Nachweis.

**EN:** **Step 5 – Document the privacy decision in an audit-ready way.** Record per field: personal reference,
purpose, retention, measure, and rationale. Positive claims like "anonymized" need a traceable procedure. "We
evaluate only via `CustomerID`, therefore anonymous" is not evidence without checking the group size.

**DE:** **Typische Fehler.** Nur direkten Personenbezug prüfen und indirekten übersehen. Felder „für später"
behalten. Keine Löschfrist festlegen. Pseudonymisierung mit Anonymisierung verwechseln. Gruppen so klein
schneiden, dass eine einzelne Kundenfirma je Stadt wieder erkennbar wird. Datenschutzaussagen ohne Verfahren.

**EN:** **Common mistakes.** Checking only direct personal reference and missing indirect. Keeping fields "for
later". Setting no deletion period. Confusing pseudonymization with anonymization. Cutting groups so small that a
single customer company per city becomes recognizable again. Privacy claims without a procedure.

### Beispiel / Example

```text
Feld           Personenbezug         Zweck                 Aufbewahrung        Massnahme
CategoryID     kein                  Sortimentsanalyse     roh, unbefristet    keine noetig
CustomerID     indirekt (Pseudonym)  Bestellzuordnung      handelsrechtl. Frist Auswertung ueber CustomerID
ContactName    direkt (Person)       Rechnungsstellung     handelsrechtl. Frist Verzicht in Auswertung
Phone          direkt (Person)       Rueckfrage Bestellung handelsrechtl. Frist Verzicht in Auswertung
Address        direkt (Person)       Lieferung             handelsrechtl. Frist Verzicht in Auswertung
City           indirekt (klein)      Regionsuebersicht     nur aggregiert      Aggregation auf Region

Regel:      Rohe Kontaktfelder nach Fristablauf loeschen; nur aggregierte Kategorie-/Regionswerte bleiben.
Nachweis:   "anonym" nur, wenn Gruppe je Region gross genug ist -> Re-Identifikation geprueft und dokumentiert
N/A:        Einwilligungsmanagement in dieser Lernuebung N/A (Northwind fiktiv, keine echten Personendaten)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c**
ist primär, weil Datenschutz und Datenminimierung untrennbar zur verantwortlichen kundenspezifischen Datenanalyse
gehören; LF 5 ist berührt, weil Aufbewahrung, Löschung und Maskierung in der verwalteten Datenhaltung umgesetzt
werden. LF 10c (maschinelles Lernen) passt nicht, weil hier Datenschutzentscheidungen statt Modelle im
Mittelpunkt stehen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
12c** is primary because data protection and minimization are inseparable from responsible customer-specific data
analysis; LF 5 is touched because retention, deletion, and masking are implemented in the managed data storage.
LF 10c (machine learning) does not fit because privacy decisions, not models, are central here.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Verantwortliche Datenanalyse verlangt geprüften Datenschutz und begründete Datenminimierung. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Aufbewahrung, Löschung und Maskierung setzen in der verwalteten Datenhaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Datenminimierung, sichere Datenverwaltung und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungs- und
Risikoblick), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung dieser Einheit
lautet: *Jedes Feld ist auf direkten und indirekten Personenbezug geprüft, hat einen Zweck, eine Löschfrist und
eine begründete Minimierungsmaßnahme; Re-Identifikation über kleine Gruppen ist bewertet.* A11Y-Aspekt: Die
Personenbezugs-Matrix muss als reine Texttabelle mit klaren Spaltenüberschriften lesbar sein, ohne Farbcodierung,
damit sie mit Screenreader oder Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: data protection, data minimization, secure data management,
and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat and risk view),
`CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit is: *each field is
checked for direct and indirect personal reference, has a purpose, a deletion period, and a justified
minimization measure; re-identification over small groups is assessed.* Accessibility aspect: the
personal-reference matrix must be readable as a plain-text table with clear column headers, without color coding,
so it stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DPA) Was ist ein indirekter Personenbezug, und warum ist er im Handelskontext tückisch? /
   **EN:** (DPA) What is an indirect personal reference, and why is it tricky in a trading context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein indirekter Bezug entsteht erst durch Kombination mehrerer Felder, etwa `City` plus Bestellhistorie.
   Er ist tückisch, weil einzelne Felder harmlos wirken, zusammen aber eine einzelne Kundenfirma oder deren
   Kontaktperson identifizierbar machen.
   **EN:** An indirect reference arises only through the combination of several fields, e.g. `City` plus order
   history. It is tricky because individual fields look harmless but together make a single customer company or
   its contact person identifiable.

   </details>

2. **DE:** (DPA) Warum reicht die Auswertung über `CustomerID` statt `ContactName` nicht immer aus, um von „anonym" zu sprechen? /
   **EN:** (DPA) Why is evaluating via `CustomerID` instead of `ContactName` not always enough to speak of "anonymous"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `CustomerID` ist ein Pseudonym und mit Zusatzwissen (der Kundentabelle) umkehrbar. Erst wenn kein
   realistischer Rückschluss mehr möglich ist – auch nicht über kleine Gruppen –, darf man von anonym sprechen;
   das braucht ein belegtes Verfahren.
   **EN:** `CustomerID` is a pseudonym and reversible with extra knowledge (the customer table). Only when no
   realistic re-identification is possible – not even via small groups – may one speak of anonymous; that needs
   an evidenced procedure.

   </details>

3. **DE:** (DPA) Wie hängt die Zweckbindung mit der Auswahl der Datenfelder zusammen? /
   **EN:** (DPA) How is purpose limitation connected to the choice of data fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Feld darf nur genutzt werden, wenn es für genau diesen Zweck erhoben wurde. Ein `ContactName` zur
   Rechnungsstellung darf nicht zur Profilbildung über das Kaufverhalten zweckentfremdet werden.
   **EN:** A field may only be used if it was collected for exactly this purpose. A `ContactName` for invoicing
   must not be repurposed to profile buying behavior.

   </details>

4. **DE:** Warum gehört zu jedem gespeicherten Feld eine begründete Aufbewahrungs- und Löschfrist? /
   **EN:** Why does every stored field need a justified retention and deletion period?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Frist wachsen Datenbestände unbegrenzt und das Risiko steigt. Eine begründete Frist setzt
   Datenminimierung um und macht die Aufbewahrung auditfähig.
   **EN:** Without a period, data holdings grow indefinitely and risk rises. A justified period implements data
   minimization and makes retention audit-ready.

   </details>

5. **DE:** Welche Minimierungsmaßnahme ist am stärksten und warum? /
   **EN:** Which minimization measure is strongest and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Verzicht, ein Feld gar nicht in die Auswertung zu übernehmen, ist am stärksten, weil ein nicht
   vorhandenes Datum weder verloren gehen noch missbraucht werden kann. Aggregation und Pseudonymisierung sind
   schwächer.
   **EN:** Omission, not taking a field into the evaluation at all, is strongest because non-existent data can
   neither be lost nor misused. Aggregation and pseudonymization are weaker.

   </details>

6. **DE:** (SI) Wie beeinflusst eine handels- oder steuerrechtliche Aufbewahrungsvorgabe die Speicherdauer der Bestelldaten? /
   **EN:** (SI) How does a commercial or tax retention rule affect the storage duration of the order data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Vorgabe legt fest, wie lange Bestell- und Kontaktdaten gehalten werden müssen, bevor sie gelöscht
   oder aggregiert werden. Sie ist die Grundlage der technischen Löschumsetzung und muss dokumentiert sein.
   **EN:** The rule sets how long order and contact data must be kept before deletion or aggregation. It is the
   basis of the technical deletion implementation and must be documented.

   </details>

7. **DE:** (DV) Warum kann eine Schnittstelle unbeabsichtigt personenbeziehbare Zusatzdaten einschleusen? /
   **EN:** (DV) Why can an interface unintentionally introduce personally identifiable extra data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Import- oder Bestellschnittstelle kann Felder mitsenden, die nicht angefordert wurden, etwa freie
   Kommentartexte oder Empfängernamen. Ohne Filterung an der Vertrauensgrenze gelangen so personenbeziehbare
   Daten in die Auswertung.
   **EN:** An import or order interface can send fields that were not requested, e.g. free comment text or
   recipient names. Without filtering at the trust boundary, personally identifiable data thus enters the
   evaluation.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] jedes Feld auf direkten und indirekten Personenbezug prüfen.
- [ ] die Zweckbindung je Feld begründen.
- [ ] begründete Aufbewahrungs- und Löschfristen festlegen.
- [ ] zwischen Verzicht, Aggregation und Pseudonymisierung (`CustomerID` statt `ContactName`) begründet wählen.
- [ ] Re-Identifikation über kleine Gruppen (eine Kundenfirma je Stadt) bewerten und eine Datenschutzentscheidung auditfähig dokumentieren.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] check each field for direct and indirect personal reference.
- [ ] justify purpose limitation per field.
- [ ] set justified retention and deletion periods.
- [ ] choose between omission, aggregation, and pseudonymization (`CustomerID` instead of `ContactName`) with a rationale.
- [ ] assess re-identification over small groups (one customer company per city) and document a privacy decision in an audit-ready way.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
