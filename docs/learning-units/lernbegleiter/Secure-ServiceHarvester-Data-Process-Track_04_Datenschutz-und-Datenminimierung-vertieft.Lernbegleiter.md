# Lernbegleiter: Secure ServiceHarvester Data & Process Track 04 – Datenschutz und Datenminimierung vertieft / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Auf den ersten Blick sammelt der ServiceHarvester nur technische Daten: Maschinenname, Betriebssystem,
letzter Kontakt. Doch der Datenschutz beginnt genau dort, wo Technik unauffällig **personenbeziehbar** wird: Ein
Hostname wie `pc-mueller` verweist auf eine Person, ein Standort plus Zeitpunkt kann Anwesenheit verraten, und
eine Kennung, die einer Person zugeordnet ist, macht aus Statusdaten personenbezogene Daten. Im 3. Lehrjahr
prüfst du deshalb **jedes** Feld vertieft: Braucht die Auswertung es überhaupt? Für welchen Zweck? Wie lange darf
es gespeichert werden? Datenminimierung heißt: so wenig wie möglich, so viel wie nötig – und das begründet.

**EN:** At first glance the ServiceHarvester collects only technical data: machine name, operating system, last
contact. But privacy begins exactly where technology quietly becomes **personally identifiable**: a hostname
like `pc-mueller` points to a person, a location plus a timestamp can reveal presence, and an identifier tied to
a person turns status data into personal data. In year 3 you therefore examine **each** field in depth: does the
evaluation need it at all? For what purpose? How long may it be stored? Data minimization means: as little as
possible, as much as necessary – and justified.

**DE:** Du lernst, direkten und indirekten Personenbezug zu erkennen, die Zweckbindung streng zu prüfen,
begründete Aufbewahrungs- und Löschfristen festzulegen und zwischen Aggregation, Pseudonymisierung und Verzicht
zu wählen.

**EN:** You learn to recognize direct and indirect personal reference, to check purpose limitation strictly, to
set justified retention and deletion periods, and to choose between aggregation, pseudonymization, and omission.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Personenbezug / Personal reference | Möglichkeit, Daten einer natürlichen Person zuzuordnen, direkt oder indirekt. |
| Indirekter Personenbezug / Indirect reference | Bezug, der erst durch Kombination mehrerer Felder entsteht (z. B. Standort + Zeit). |
| Zweckbindung / Purpose limitation | Daten nur für den Zweck nutzen, für den sie erhoben wurden. |
| Datenminimierung / Data minimization | So wenig Daten wie möglich erheben, speichern und auswerten. |
| Aufbewahrungsfrist / Retention period | Begründete Zeit, nach der Daten gelöscht oder aggregiert werden. |
| Pseudonymisierung / Pseudonymization | Ersetzen einer Kennung durch ein Pseudonym, das nur mit Zusatzwissen auflösbar ist. |
| Aggregation / Aggregation | Zusammenfassen zu Gruppen, sodass Einzelpersonen nicht mehr erkennbar sind. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Jedes Feld auf Personenbezug prüfen.** Gehe die Felder einzeln durch und frage: Kann dies
direkt oder in Kombination auf eine Person zeigen? `os` allein ist neutral. `hostname = pc-mueller` ist direkt
beziehbar. `standort + last_contact` kann indirekt Anwesenheit zeigen. Trage die Einstufung in eine Matrix ein.

**EN:** **Step 1 – Check each field for personal reference.** Go through the fields one by one and ask: can this
point to a person directly or in combination? `os` alone is neutral. `hostname = pc-mueller` is directly
identifiable. `location + last_contact` can indirectly reveal presence. Record the classification in a matrix.

**DE:** **Schritt 2 – Zweckbindung streng anwenden.** Für jedes personenbeziehbare Feld gilt: Es darf nur für
den erhobenen Zweck genutzt werden. Ein Maschinenname zur Inventarzuordnung darf nicht heimlich zur
Anwesenheitskontrolle einer Person verwendet werden. Felder ohne klaren Zweck gehören nicht in die Auswertung.

**EN:** **Step 2 – Apply purpose limitation strictly.** For each personally identifiable field: it may only be
used for the purpose it was collected for. A machine name for inventory assignment must not be secretly used to
monitor a person's presence. Fields without a clear purpose do not belong in the evaluation.

**DE:** **Schritt 3 – Aufbewahrung und Löschung begründen.** Daten sollen nicht „für immer" liegen. Lege je Feld
fest, wie lange es gebraucht wird und was danach passiert: löschen oder zu einer anonymen Kennzahl aggregieren.
Beispiel: „Roh-Snapshots werden nach 30 Tagen gelöscht; nur aggregierte Tageswerte bleiben erhalten."

**EN:** **Step 3 – Justify retention and deletion.** Data should not lie around "forever". Define per field how
long it is needed and what happens afterwards: delete it or aggregate it to an anonymous metric. Example: "raw
snapshots are deleted after 30 days; only aggregated daily values remain."

**DE:** **Schritt 4 – Minimierungsmaßnahme wählen.** Für risikobehaftete Felder gibt es Optionen: **Verzicht**
(Feld gar nicht erheben), **Aggregation** (nur Gruppenwerte), **Pseudonymisierung** (Kennung ersetzen).
Verzicht ist am stärksten, Pseudonymisierung am schwächsten, weil sie mit Zusatzwissen umkehrbar sein kann.
Wähle die stärkste Maßnahme, die die fachliche Frage noch beantwortet.

**EN:** **Step 4 – Choose a minimization measure.** For risky fields there are options: **omission** (do not
collect the field), **aggregation** (only group values), **pseudonymization** (replace the identifier).
Omission is strongest, pseudonymization weakest because it can be reversible with extra knowledge. Choose the
strongest measure that still answers the business question.

**DE:** **Schritt 5 – Datenschutzentscheidung auditfähig dokumentieren.** Halte je Feld fest: Personenbezug,
Zweck, Aufbewahrung, Maßnahme und Begründung. Positive Aussagen wie „anonymisiert" brauchen ein nachvollziehbares
Verfahren. „Wir nennen es anonym" ohne Verfahren ist kein Nachweis.

**EN:** **Step 5 – Document the privacy decision in an audit-ready way.** Record per field: personal reference,
purpose, retention, measure, and rationale. Positive claims like "anonymized" need a traceable procedure. "We
call it anonymous" without a procedure is not evidence.

**DE:** **Typische Fehler.** Nur direkten Personenbezug prüfen und indirekten übersehen. Felder „für später"
behalten. Keine Löschfrist festlegen. Pseudonymisierung mit Anonymisierung verwechseln. Aggregierte Werte so
fein schneiden, dass Einzelpersonen wieder erkennbar werden. Datenschutzaussagen ohne Verfahren.

**EN:** **Common mistakes.** Checking only direct personal reference and missing indirect. Keeping fields "for
later". Setting no deletion period. Confusing pseudonymization with anonymization. Cutting aggregated values so
finely that individuals become recognizable again. Privacy claims without a procedure.

### Beispiel / Example

```text
Feld           Personenbezug       Zweck                 Aufbewahrung     Massnahme
os             kein                 OS-Verteilung         30 Tage roh      keine noetig
hostname       direkt (pc-mueller)  Inventarzuordnung     30 Tage roh      Pseudonymisierung -> host_7f3a
last_contact   indirekt (mit Ort)   Erreichbarkeit        30 Tage roh      Aggregation auf Tageswert
standort       indirekt             Standort-Uebersicht   sofort aggregiert Aggregation, Roh-Ort verworfen

Regel:      Roh-Snapshots nach 30 Tagen loeschen; nur aggregierte Tageswerte bleiben.
Nachweis:   "anonym" nur, wenn Aggregationsstufe gross genug ist -> Verfahren dokumentiert
N/A:        Einwilligungsmanagement in dieser Lernuebung N/A (keine echten Personendaten) -> begruendet
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c**
ist primär, weil Datenschutz und Datenminimierung untrennbar zur verantwortlichen kundenspezifischen Datenanalyse
gehören; LF 5 ist berührt, weil Aufbewahrung, Löschung und Maskierung in der verwalteten Datenhaltung umgesetzt
werden. LF 10c (maschinelles Lernen) passt nicht, weil hier Datenschutzentscheidungen statt Modelle im
Mittelpunkt stehen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
12c** is primary because data protection and minimization are inseparable from responsible customer-specific
data analysis; LF 5 is touched because retention, deletion, and masking are implemented in the managed data
storage. LF 10c (machine learning) does not fit because privacy decisions, not models, are central here.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Verantwortliche Datenanalyse verlangt geprüften Datenschutz und begründete Datenminimierung. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Aufbewahrung, Löschung und Maskierung setzen in der verwalteten Datenhaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Datenminimierung, sichere Datenverwaltung und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungs- und
Risikoblick), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung dieser Einheit
lautet: *Jedes Feld ist auf direkten und indirekten Personenbezug geprüft, hat einen Zweck, eine Löschfrist und
eine begründete Minimierungsmaßnahme.* A11Y-Aspekt: Die Personenbezugs-Matrix muss als reine Texttabelle mit
klaren Spaltenüberschriften lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile
nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: data protection, data minimization, secure data management,
and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat and risk view),
`CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit is: *each field is
checked for direct and indirect personal reference, has a purpose, a deletion period, and a justified
minimization measure.* Accessibility aspect: the personal-reference matrix must be readable as a plain-text table
with clear column headers, without color coding, so it stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DPA) Was ist ein indirekter Personenbezug, und warum ist er tückisch? /
   **EN:** (DPA) What is an indirect personal reference, and why is it tricky?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein indirekter Bezug entsteht erst durch Kombination mehrerer Felder, etwa Standort plus Zeitpunkt.
   Er ist tückisch, weil einzelne Felder harmlos wirken, zusammen aber eine Person identifizierbar machen.
   **EN:** An indirect reference arises only through the combination of several fields, e.g. location plus time.
   It is tricky because individual fields look harmless but together make a person identifiable.

   </details>

2. **DE:** (DPA) Warum reicht Pseudonymisierung nicht immer aus, um von „anonym" zu sprechen? /
   **EN:** (DPA) Why is pseudonymization not always enough to speak of "anonymous"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Pseudonymisierung ersetzt eine Kennung, ist aber mit Zusatzwissen umkehrbar. Erst wenn kein
   realistischer Rückschluss mehr möglich ist, darf man von anonym sprechen – und das braucht ein belegtes
   Verfahren.
   **EN:** Pseudonymization replaces an identifier but is reversible with extra knowledge. Only when no realistic
   re-identification is possible may one speak of anonymous – and that needs an evidenced procedure.

   </details>

3. **DE:** (DPA) Wie hängt die Zweckbindung mit der Auswahl der Datenfelder zusammen? /
   **EN:** (DPA) How is purpose limitation connected to the choice of data fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Feld darf nur genutzt werden, wenn es für genau diesen Zweck erhoben wurde. Ein Maschinenname zur
   Inventarzuordnung darf nicht zur Anwesenheitskontrolle zweckentfremdet werden.
   **EN:** A field may only be used if it was collected for exactly this purpose. A machine name for inventory
   assignment must not be repurposed for presence monitoring.

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

   **DE:** Der Verzicht, ein Feld gar nicht zu erheben, ist am stärksten, weil ein nicht vorhandenes Datum weder
   verloren gehen noch missbraucht werden kann. Aggregation und Pseudonymisierung sind schwächer.
   **EN:** Omission, not collecting a field at all, is strongest because non-existent data can neither be lost
   nor misused. Aggregation and pseudonymization are weaker.

   </details>

6. **DE:** (SI) Wie beeinflusst eine betriebliche Aufbewahrungsvorgabe die Speicherdauer der Snapshots? /
   **EN:** (SI) How does an operational retention rule affect the storage duration of the snapshots?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Betriebsvorgabe legt fest, wie lange Roh-Snapshots gehalten werden dürfen, bevor sie gelöscht oder
   aggregiert werden. Sie ist die Grundlage der technischen Löschumsetzung und muss dokumentiert sein.
   **EN:** The operational rule sets how long raw snapshots may be kept before deletion or aggregation. It is the
   basis of the technical deletion implementation and must be documented.

   </details>

7. **DE:** (DV) Warum kann eine Schnittstelle unbeabsichtigt personenbeziehbare Zusatzdaten einschleusen? /
   **EN:** (DV) Why can an interface unintentionally introduce personally identifiable extra data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Agent oder eine Quelle kann Felder mitsenden, die nicht angefordert wurden, etwa angemeldete
   Benutzer oder freie Beschreibungstexte. Ohne Filterung an der Vertrauensgrenze gelangen so personenbeziehbare
   Daten in die Auswertung.
   **EN:** An agent or source can send fields that were not requested, e.g. logged-in users or free description
   text. Without filtering at the trust boundary, personally identifiable data thus enters the evaluation.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] jedes Feld auf direkten und indirekten Personenbezug prüfen.
- [ ] die Zweckbindung je Feld begründen.
- [ ] begründete Aufbewahrungs- und Löschfristen festlegen.
- [ ] zwischen Verzicht, Aggregation und Pseudonymisierung begründet wählen.
- [ ] eine Datenschutzentscheidung auditfähig dokumentieren.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] check each field for direct and indirect personal reference.
- [ ] justify purpose limitation per field.
- [ ] set justified retention and deletion periods.
- [ ] choose between omission, aggregation, and pseudonymization with a rationale.
- [ ] document a privacy decision in an audit-ready way.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
