# Lernbegleiter: Secure CaseTracker Data & Process Track 06 – Reporting, Audit-Evidence und Nachvollziehbarkeit / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Data-Process-Track_06_Reporting-Audit-Evidence-und-Nachvollziehbarkeit.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Report ist mehr als eine hübsche Zahlentabelle. Wer eine Entscheidung darauf stützt, muss darauf
vertrauen können. Deshalb braucht ein guter Report **Audit-Evidence**: Man kann nachvollziehen, aus welchen
Daten, mit welcher Definition und zu welchem Zeitpunkt eine Kennzahl entstanden ist. **Nachvollziehbarkeit**
und **Reproduzierbarkeit** bedeuten: Dieselben Rohdaten und dieselbe Definition ergeben denselben Report –
heute, morgen und bei einer Prüfung. Zusätzlich muss ein Report **zugriffsgeschützt** sein, denn er kann
sensible Prozessinformationen enthalten.

**EN:** A report is more than a pretty table of numbers. Anyone basing a decision on it must be able to trust
it. That is why a good report needs **audit evidence**: you can trace from which data, with which definition,
and at which point in time a metric was produced. **Traceability** and **reproducibility** mean: the same raw
data and the same definition produce the same report – today, tomorrow, and during a review. In addition, a
report must be **access-protected**, because it can contain sensitive process information.

**DE:** In dieser Einheit lernst du, Reports so zu gestalten, dass jede Zahl bis zur Quelle zurückverfolgbar
ist, dass ein Report reproduzierbar erzeugt wird und dass der Zugriff auf berechtigte Personen beschränkt
bleibt.

**EN:** In this unit you learn to design reports so that every number is traceable back to its source, that a
report is produced reproducibly, and that access stays restricted to authorized people.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Report / Report | Aufbereitete Darstellung von Kennzahlen für eine Zielgruppe. |
| Audit-Evidence / Audit evidence | Nachweise, aus denen sich ein Ergebnis lückenlos herleiten lässt. |
| Nachvollziehbarkeit / Traceability | Jede Zahl lässt sich bis zu Rohdaten und Definition zurückverfolgen. |
| Reproduzierbarkeit / Reproducibility | Gleiche Eingaben ergeben verlässlich das gleiche Ergebnis. |
| Evidenzpfad / Evidence path | Dokumentierter Ort, an dem ein Nachweis liegt. |
| Zugriffsschutz / Access protection | Beschränkung, wer einen Report sehen oder ändern darf. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Report an Rohdaten und Definition koppeln.** Jede Kennzahl im Report verweist auf ihre
schriftliche Definition (Einheit 02) und den zugrunde liegenden Datenstand. So kann jemand später fragen
„Woher kommen die 12 Tage?" und eine belastbare Antwort finden.

**EN:** **Step 1 – Couple the report to raw data and definition.** Every metric in the report references its
written definition (unit 02) and the underlying data snapshot. This way someone can later ask "where do the 12
days come from?" and find a reliable answer.

**DE:** **Schritt 2 – Datenstand und Zeitpunkt festhalten.** Ein Report ohne Datum und ohne Angabe des
Datenstands ist wertlos, weil sich Daten ändern. Halte fest: Stichtag der Daten, Zeitpunkt der Erzeugung und
Version der Kennzahldefinition. Nur so ist ein Report später eindeutig einzuordnen.

**EN:** **Step 2 – Record data snapshot and time.** A report without a date and without a stated data snapshot
is worthless, because data changes. Record: the data cut-off, the time of generation, and the version of the
metric definition. Only then can a report later be placed unambiguously.

**DE:** **Schritt 3 – Reproduzierbar erzeugen.** Der Weg von Rohdaten zum Report soll wiederholbar sein: klare
Schritte, keine manuellen Einmal-Handgriffe, die niemand dokumentiert. Wer dieselben Rohdaten und dieselbe
Definition nimmt, muss denselben Report erhalten. Das ist die Grundlage von Vertrauen und Audit.

**EN:** **Step 3 – Generate reproducibly.** The path from raw data to report should be repeatable: clear
steps, no manual one-off touches that nobody documents. Whoever takes the same raw data and the same
definition must obtain the same report. This is the foundation of trust and audit.

**DE:** **Schritt 4 – Zugriff und Grenzen im Report zeigen.** Beschränke, wer den Report sehen und ändern
darf, und trenne sensible von öffentlichen Teilen. Nenne im Report auch die Aussagegrenzen (Einheit 01),
damit niemand die Zahlen überinterpretiert. Ein Report, der seine Grenzen verschweigt, verführt zu falschen
Entscheidungen.

**EN:** **Step 4 – Show access and limits in the report.** Restrict who may see and change the report, and
separate sensitive from public parts. Also name the limits of validity (unit 01) in the report, so no one
over-interprets the numbers. A report that hides its limits invites wrong decisions.

**DE:** **Typische Fehler.** Report ohne Datenstand und Datum. Zahlen ohne Rückverweis auf die Definition.
Manuelle, undokumentierte Schritte. Report an alle verteilen. Grenzen weglassen, damit die Zahlen stärker
wirken.

**EN:** **Common mistakes.** A report without a data snapshot and date. Numbers without a back-reference to
the definition. Manual, undocumented steps. Distributing the report to everyone. Omitting limits to make the
numbers look stronger.

### Beispiel / Example

```text
Report:          "Durchlaufzeit-Report Mai 2025"
Datenstand:      Rohdaten-Snapshot 2025-06-01, 1000 Faelle
Erzeugt am:      2025-06-02
Definition:      Median-Durchlaufzeit v1.2 (siehe Kennzahldefinition)
Evidenzpfad:     docs/security/... bzw. Projekt-Nachweisordner
Reproduzierbar:  gleicher Snapshot + gleiche Definition -> gleicher Wert (12 Tage)
Zugriffsschutz:  sichtbar fuer Rolle "Prozessverantwortung"; nicht oeffentlich
Grenzenhinweis:  gilt fuer 612 geschlossene Faelle (61 %), nicht fuer alle 1000
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Ein auditfähiger, nachvollziehbarer Report ist das Kundenergebnis der Prozess- und Datenanalyse. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Reports werden für die Steuerung der Servicebearbeitung erstellt und dorthin zurückgespielt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Nachvollziehbarkeit, Zugriffsschutz, sichere Konfiguration
und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Risikoblick),
`CL_08` (Review), `CL_10` (Datenschutz) und `CL_12` (auditfähige Nachweise). Die Datenentscheidung dieser
Einheit lautet: *Jede Zahl im Report ist bis zur Quelle rückverfolgbar und reproduzierbar erzeugt.*
A11Y-Aspekt: Reports müssen als strukturierte Tabellen mit Überschriften lesbar sein; Kennzahlen dürfen nie
allein über Farben oder Diagrammfarben transportiert werden.

**EN:** Relation to the Secure Development Guideline: traceability, access protection, secure configuration,
and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (risk view), `CL_08`
(review), `CL_10` (data protection), and `CL_12` (audit-ready evidence). The data decision of this unit is:
*every number in the report is traceable back to its source and generated reproducibly.* Accessibility aspect:
reports must be readable as structured tables with headers; metrics must never be carried by color or chart
color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist Audit-Evidence, und warum braucht ein Report sie? /
   **EN:** What is audit evidence, and why does a report need it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Audit-Evidence sind Nachweise, aus denen sich jede Zahl herleiten lässt. Ohne sie kann niemand
   prüfen, ob der Report stimmt, und die Entscheidung darauf ist nicht vertrauenswürdig.
   **EN:** Audit evidence are proofs from which every number can be derived. Without it, no one can check
   whether the report is correct, and a decision on it is not trustworthy.

   </details>

2. **DE:** (DPA) Warum ist ein Report ohne Datenstand und Datum wertlos? /
   **EN:** (DPA) Why is a report without a data snapshot and date worthless?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Daten ändern sich. Ohne Stichtag und Erzeugungsdatum lässt sich nicht sagen, welchen Zustand der
   Report zeigt, und Werte sind nicht vergleichbar oder prüfbar.
   **EN:** Data changes. Without a cut-off and a generation date, one cannot say which state the report shows,
   and values are not comparable or verifiable.

   </details>

3. **DE:** (DPA) Was bedeutet Reproduzierbarkeit für einen Report konkret? /
   **EN:** (DPA) What does reproducibility mean concretely for a report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Gleicher Rohdaten-Snapshot plus gleiche Definition ergeben denselben Report. Manuelle,
   undokumentierte Schritte zerstören diese Eigenschaft.
   **EN:** The same raw-data snapshot plus the same definition yields the same report. Manual, undocumented
   steps destroy this property.

   </details>

4. **DE:** Warum verweist jede Kennzahl im Report auf ihre Definition? /
   **EN:** Why does every metric in the report reference its definition?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** So ist eindeutig, wie die Zahl berechnet wurde, und die Frage „Woher kommt der Wert?" ist
   beantwortbar. Der Verweis macht den Report nachvollziehbar.
   **EN:** This makes it unambiguous how the number was computed, and the question "where does the value come
   from?" is answerable. The reference makes the report traceable.

   </details>

5. **DE:** Warum gehört Zugriffsschutz zu einem Prozessreport? /
   **EN:** Why does access protection belong to a process report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Reports können sensible Prozess- oder indirekt personenbezogene Informationen enthalten. Zugriff nur
   für berechtigte Rollen begrenzt das Datenschutz- und Missbrauchsrisiko.
   **EN:** Reports can contain sensitive process information or indirectly personal data. Restricting access to
   authorized roles limits the data-protection and misuse risk.

   </details>

6. **DE:** (DPA) Warum sollten Aussagegrenzen sichtbar im Report stehen? /
   **EN:** (DPA) Why should limits of validity appear visibly in the report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit die Leserschaft die Zahlen nicht überinterpretiert. Ohne sichtbare Grenzen wirken lückenhafte
   Werte vollständig und führen zu falschen Entscheidungen.
   **EN:** So the audience does not over-interpret the numbers. Without visible limits, incomplete values look
   complete and lead to wrong decisions.

   </details>

7. **DE:** Was ist ein Evidenzpfad, und warum wird er dokumentiert? /
   **EN:** What is an evidence path, and why is it documented?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Evidenzpfad ist der dokumentierte Ort eines Nachweises. Er macht bei einem Review sofort
   auffindbar, wo Rohdaten, Definition und Report-Herleitung liegen.
   **EN:** The evidence path is the documented location of a proof. In a review it makes immediately findable
   where raw data, definition, and report derivation are stored.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] jede Zahl im Report auf Rohdaten und Definition zurückführen.
- [ ] Datenstand, Erzeugungszeitpunkt und Definitionsversion angeben.
- [ ] einen Report reproduzierbar erzeugen.
- [ ] Zugriff auf berechtigte Rollen beschränken.
- [ ] Aussagegrenzen und Evidenzpfade im Report benennen.

**EN:** I can …

- [ ] trace every number in the report to raw data and definition.
- [ ] state data snapshot, generation time, and definition version.
- [ ] generate a report reproducibly.
- [ ] restrict access to authorized roles.
- [ ] name limits of validity and evidence paths in the report.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Data-Process-Track_06_Reporting-Audit-Evidence-und-Nachvollziehbarkeit.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Data-Process-Track_06_Reporting-Audit-Evidence-und-Nachvollziehbarkeit.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
