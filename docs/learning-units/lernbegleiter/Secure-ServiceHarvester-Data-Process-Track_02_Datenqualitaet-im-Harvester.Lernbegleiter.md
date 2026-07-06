# Lernbegleiter: Secure ServiceHarvester Data & Process Track 02 – Datenqualität im Harvester / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_02_Datenqualitaet-im-Harvester.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Kennzahl ist nur so gut wie die Daten darunter. Der ServiceHarvester sammelt Maschinen-Snapshots
automatisch, und dabei entstehen typische Qualitätsprobleme: Ein Feld fehlt, ein Betriebssystem ist mal
`Windows 11`, mal `win11`, ein letzter Kontakt liegt Wochen zurück, oder dieselbe Maschine erscheint doppelt.
Bevor man in Einheit 03 Kennzahlen berechnet, muss man die **Datenqualität** messen und begründet verbessern.
Im 3. Lehrjahr genügt kein „sieht gut aus": Du misst die Qualität mit klaren Dimensionen und belegst jede
Bereinigung, damit sie reproduzierbar und auditfähig bleibt.

**EN:** A metric is only as good as the data beneath it. The ServiceHarvester collects machine snapshots
automatically, and typical quality problems arise: a field is missing, an operating system is sometimes
`Windows 11`, sometimes `win11`, a last contact lies weeks in the past, or the same machine appears twice.
Before you compute metrics in unit 03, you must measure and justifiably improve **data quality**. In year 3 a
"looks fine" is not enough: you measure quality with clear dimensions and evidence every cleaning step so it
stays reproducible and audit-ready.

**DE:** Du lernst, die Qualitätsdimensionen zu unterscheiden, je Dimension eine messbare Kennzahl zu bilden,
Plausibilitätsregeln zu formulieren und Rohdaten strikt von bereinigten Daten zu trennen.

**EN:** You learn to distinguish the quality dimensions, to form a measurable metric per dimension, to
formulate plausibility rules, and to strictly separate raw data from cleaned data.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Vollständigkeit / Completeness | Anteil der benötigten Felder, die tatsächlich befüllt sind. |
| Aktualität / Timeliness | Wie frisch ein Snapshot ist, gemessen am letzten Kontakt. |
| Genauigkeit / Accuracy | Grad, in dem ein Wert der Realität entspricht (z. B. korrektes Betriebssystem). |
| Konsistenz / Consistency | Einheitliche Schreibweise und widerspruchsfreie Werte über Datensätze hinweg. |
| Eindeutigkeit / Uniqueness | Jede Maschine erscheint genau einmal; keine Dubletten. |
| Plausibilitätsregel / Plausibility rule | Prüfregel, die unrealistische Werte erkennt (z. B. Kontakt in der Zukunft). |
| Bereinigungsprotokoll / Cleaning log | Nachvollziehbare Aufzeichnung jeder Änderung an den Daten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Qualitätsdimensionen wählen.** Nicht jede Dimension ist gleich wichtig. Für Statusdaten
zählen vor allem Vollständigkeit (fehlt der letzte Kontakt?), Aktualität (wie alt ist der Snapshot?),
Konsistenz (einheitliche OS-Schreibweise?) und Eindeutigkeit (Dubletten?). Wähle die Dimensionen, die deine
geplanten Kennzahlen wirklich brauchen.

**EN:** **Step 1 – Choose quality dimensions.** Not every dimension is equally important. For status data the
key ones are completeness (is the last contact missing?), timeliness (how old is the snapshot?), consistency
(uniform OS spelling?), and uniqueness (duplicates?). Choose the dimensions your planned metrics really need.

**DE:** **Schritt 2 – Je Dimension eine Kennzahl bilden.** Mache Qualität messbar. Beispiel Vollständigkeit:
„Anteil der Snapshots mit befülltem `last_contact` = befüllte / alle." Eine Zahl wie „92 % vollständig" ist
prüfbar; „meistens vollständig" ist es nicht. Notiere immer Zähler und Nenner.

**EN:** **Step 2 – Form a metric per dimension.** Make quality measurable. Completeness example: "share of
snapshots with a filled `last_contact` = filled / all." A number like "92% complete" is verifiable; "mostly
complete" is not. Always note numerator and denominator.

**DE:** **Schritt 3 – Plausibilitätsregeln formulieren.** Regeln erkennen unrealistische Werte, ohne die
Realität zu kennen. Beispiele: „Ein letzter Kontakt darf nicht in der Zukunft liegen." „Das Betriebssystem muss
zu einer bekannten Liste passen." „Ein Maschinenname darf nicht leer sein." Jede verletzte Regel wird gezählt,
nicht stillschweigend übergangen.

**EN:** **Step 3 – Formulate plausibility rules.** Rules detect unrealistic values without knowing reality.
Examples: "a last contact must not be in the future." "The operating system must match a known list." "A
machine name must not be empty." Every violated rule is counted, not silently ignored.

**DE:** **Schritt 4 – Fehlende, veraltete und doppelte Werte behandeln.** Lege je Fall eine begründete
Strategie fest. Fehlend: als „unbekannt" markieren, nicht raten. Veraltet: mit Schwellwert kennzeichnen (z. B.
„älter als 7 Tage = stale"). Doppelt: nach klarer Regel zusammenführen (z. B. jüngster Snapshot je Maschine).
Die Wahl beeinflusst spätere Kennzahlen und gehört deshalb dokumentiert.

**EN:** **Step 4 – Handle missing, stale, and duplicate values.** Define a justified strategy per case. Missing:
mark as "unknown", do not guess. Stale: flag with a threshold (e.g. "older than 7 days = stale"). Duplicate:
merge by a clear rule (e.g. the most recent snapshot per machine). The choice affects later metrics and must
therefore be documented.

**DE:** **Schritt 5 – Rohdaten und bereinigte Daten trennen.** Ändere niemals die Rohdaten. Bereinigung erzeugt
einen neuen, bereinigten Datenstand plus ein Protokoll: welche Regel, welcher Wert vorher, welcher nachher,
warum. So bleibt jede Auswertung reproduzierbar und ein Audit kann jeden Schritt nachvollziehen.

**EN:** **Step 5 – Separate raw and cleaned data.** Never change the raw data. Cleaning produces a new, cleaned
data state plus a log: which rule, which value before, which after, why. This keeps every evaluation
reproducible and lets an audit trace each step.

**DE:** **Typische Fehler.** Qualität nur mit Worten statt mit Zahlen beschreiben. Rohdaten direkt überschreiben.
Fehlende Werte durch Schätzungen ersetzen und dies verschweigen. Dubletten ohne Regel entfernen.
Plausibilitätsverstöße stillschweigend löschen. Bereinigung ohne Protokoll.

**EN:** **Common mistakes.** Describing quality only with words instead of numbers. Overwriting raw data
directly. Replacing missing values with estimates and hiding it. Removing duplicates without a rule. Silently
deleting plausibility violations. Cleaning without a log.

### Beispiel / Example

```text
Dimension        Kennzahl                                  Messwert   Interpretation
Vollstaendigkeit befuellte last_contact / alle Snapshots   918/1000   92 % vollstaendig
Aktualitaet      Snapshots juenger als 7 Tage / alle       740/1000   74 % aktuell (26 % stale)
Konsistenz       os-Werte nach Normalisierung / Rohwerte   6 von 11   11 Schreibweisen -> 6 Kategorien
Eindeutigkeit    Maschinen nach Dubletten-Merge            965/1000   35 Dubletten zusammengefuehrt

Plausibilitaetsregel:  last_contact in der Zukunft   -> 3 Verstoesse -> als "ungueltig" markiert
Bereinigung (Log):     "win11","Win 11" -> "Windows 11"  | vorher/ nachher/ Regel dokumentiert
Grundsatz:             Rohdaten unveraendert; bereinigter Stand + Protokoll separat
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c**
ist primär, weil Datenqualität die Grundlage jeder kundenspezifischen Datenanalyse ist; LF 5 ist berührt, weil
die geprüften Felder aus der vom Dienst verwalteten Datenhaltung stammen und Bereinigungslogik an dieser
Datenverwaltung ansetzt. LF 10c (maschinelles Lernen) passt nicht, weil hier Regeln und Messungen statt Modelle
verwendet werden.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
12c** is primary because data quality is the foundation of every customer-specific data analysis; LF 5 is
touched because the checked fields come from the data storage managed by the service and cleaning logic acts on
this data management. LF 10c (machine learning) does not fit because rules and measurements are used here, not
models.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Datenqualität ist die messbare Grundlage jeder belastbaren Datenanalyse. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Prüf- und Bereinigungslogik setzt an der verwalteten Datenhaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Eingabevalidierung, sichere Datenverarbeitung, Testbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungs- und
Risikoblick), `CL_08` (Sicherheits-Code-Review der Verarbeitung) und `CL_12` (Nachweise und Abschluss). Die
Datenentscheidung dieser Einheit lautet: *Rohdaten bleiben unverändert, Qualität wird gemessen, und jede
Bereinigung ist reproduzierbar protokolliert.* A11Y-Aspekt: Die Qualitätsdimensions-Tabelle muss klare
Spaltenüberschriften und reine Textwerte enthalten, ohne Farbcodierung, damit sie mit Screenreader oder
Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: input validation, secure data processing, testability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat and risk view),
`CL_08` (security code review of processing), and `CL_12` (evidence and closure). The data decision of this unit
is: *raw data stays unchanged, quality is measured, and every cleaning step is logged reproducibly.*
Accessibility aspect: the quality-dimension table must use clear column headers and plain text values, without
color coding, so it stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht es nicht, Datenqualität mit Worten wie „meistens gut" zu beschreiben? /
   **EN:** Why is it not enough to describe data quality with words like "mostly good"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Worte sind nicht prüfbar und nicht vergleichbar. Eine Kennzahl mit Zähler und Nenner, etwa „92 %
   vollständig", ist messbar, wiederholbar und auditfähig.
   **EN:** Words are not verifiable and not comparable. A metric with numerator and denominator, e.g. "92%
   complete", is measurable, repeatable, and audit-ready.

   </details>

2. **DE:** (DPA) Nenne je eine Qualitätsdimension für Statusdaten und eine passende Kennzahl. /
   **EN:** (DPA) Name one quality dimension for status data and a matching metric each.

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Beispiel Aktualität: „Anteil der Snapshots jünger als 7 Tage." Beispiel Vollständigkeit: „Anteil der
   Snapshots mit befülltem `last_contact`." Jede Kennzahl nennt Zähler und Nenner.
   **EN:** Timeliness example: "share of snapshots younger than 7 days." Completeness example: "share of
   snapshots with a filled `last_contact`." Each metric names numerator and denominator.

   </details>

3. **DE:** (DPA) Warum dürfen Rohdaten bei der Bereinigung nicht überschrieben werden? /
   **EN:** (DPA) Why must raw data not be overwritten during cleaning?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur unveränderte Rohdaten machen jede Auswertung reproduzierbar und ein Audit möglich. Bereinigung
   erzeugt einen separaten Stand plus Protokoll, sodass jeder Schritt nachvollziehbar bleibt.
   **EN:** Only unchanged raw data makes every evaluation reproducible and an audit possible. Cleaning produces a
   separate state plus a log, so each step stays traceable.

   </details>

4. **DE:** Wie behandelst du fehlende Werte korrekt, und was ist dabei verboten? /
   **EN:** How do you handle missing values correctly, and what is forbidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fehlende Werte werden als „unbekannt" markiert und in der Kennzahl offen ausgewiesen. Verboten ist,
   sie durch Schätzungen zu ersetzen und dies zu verschweigen, weil das die Aussagegrenze verfälscht.
   **EN:** Missing values are marked as "unknown" and shown openly in the metric. Forbidden is replacing them
   with estimates and hiding it, because that distorts the limit of validity.

   </details>

5. **DE:** Wozu dient eine Plausibilitätsregel wie „letzter Kontakt darf nicht in der Zukunft liegen"? /
   **EN:** What is the purpose of a plausibility rule like "last contact must not be in the future"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie erkennt unrealistische Werte, die auf Fehler bei Erfassung, Zeitzone oder Manipulation hindeuten.
   Verstöße werden gezählt und markiert, statt still gelöscht zu werden.
   **EN:** It detects unrealistic values pointing to errors in capture, time zone, or manipulation. Violations
   are counted and flagged instead of being silently deleted.

   </details>

6. **DE:** (SI) Welche Betriebsbedingung erzeugt typischerweise veraltete oder lückenhafte Snapshots? /
   **EN:** (SI) Which operational condition typically produces stale or incomplete snapshots?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein zeitweiser Ausfall des Dienstes, ein zu langes Sammelintervall oder eine Maschine, die offline
   war. Solche Bedingungen erklären, warum ein Snapshot „stale" ist, und gehören in die Aussagegrenze.
   **EN:** A temporary service outage, a too-long collection interval, or a machine that was offline. Such
   conditions explain why a snapshot is "stale" and belong in the limit of validity.

   </details>

7. **DE:** (DV) Warum sind uneinheitliche Betriebssystem-Schreibweisen ein Schnittstellenthema? /
   **EN:** (DV) Why are inconsistent operating-system spellings an interface topic?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unterschiedliche Quellen oder Agents an der Schnittstelle liefern denselben Wert verschieden
   (`win11`, `Windows 11`). Eine Normalisierung an der Vertrauensgrenze macht Konsistenz messbar und Auswertungen
   vergleichbar.
   **EN:** Different sources or agents at the interface deliver the same value differently (`win11`, `Windows
   11`). Normalization at the trust boundary makes consistency measurable and evaluations comparable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die wichtigsten Qualitätsdimensionen für Statusdaten benennen.
- [ ] je Dimension eine messbare Kennzahl mit Zähler und Nenner bilden.
- [ ] Plausibilitätsregeln formulieren und Verstöße zählen.
- [ ] fehlende, veraltete und doppelte Werte begründet behandeln.
- [ ] Rohdaten und bereinigte Daten mit Protokoll trennen.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] name the key quality dimensions for status data.
- [ ] form a measurable metric with numerator and denominator per dimension.
- [ ] formulate plausibility rules and count violations.
- [ ] handle missing, stale, and duplicate values with a rationale.
- [ ] separate raw and cleaned data with a log.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_02_Datenqualitaet-im-Harvester.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_02_Datenqualitaet-im-Harvester.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
