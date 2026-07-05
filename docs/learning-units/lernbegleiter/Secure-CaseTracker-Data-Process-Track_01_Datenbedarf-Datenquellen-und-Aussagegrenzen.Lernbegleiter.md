# Lernbegleiter: Secure CaseTracker Data & Process Track 01 – Datenbedarf, Datenquellen und Aussagegrenzen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Data-Process-Track_01_Datenbedarf-Datenquellen-und-Aussagegrenzen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bevor man Kennzahlen berechnet, muss man wissen, *welche* Daten man wirklich braucht, *woher* sie
kommen und *wofür* sie erhoben wurden. Im Secure CaseTracker geht es um Fälle: Wann wurde ein Fall
eröffnet, wann geschlossen, welchen Status hatte er, wer hat ihn bearbeitet. Nicht jede dieser Angaben ist
für jede Frage nötig. Wer zu viel sammelt, verletzt den Datenschutz; wer zu wenig hat, kann die Frage nicht
beantworten. Genauso wichtig ist die **Aussagegrenze**: Aus lückenhaften oder ungenauen Daten darf man
keine sichere Aussage ableiten.

**EN:** Before you compute metrics, you must know *which* data you really need, *where* it comes from, and
*for what purpose* it was collected. The Secure CaseTracker is about cases: when a case was opened, when it
was closed, which status it had, who worked on it. Not every field is needed for every question. Collecting
too much violates privacy; having too little means you cannot answer the question. Equally important is the
**limit of validity**: you must not derive a firm statement from incomplete or inaccurate data.

**DE:** In dieser Einheit lernst du, den Datenbedarf sauber aus einer Fragestellung abzuleiten, die Quellen
und ihre Qualität zu benennen, die Zweckbindung zu prüfen und die Aussagegrenzen ehrlich zu dokumentieren.

**EN:** In this unit you learn to derive the data need cleanly from a question, to name the sources and their
quality, to check purpose limitation, and to document the limits of validity honestly.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Datenbedarf / Data need | Die minimale Menge an Feldern, die eine konkrete Frage beantwortet. |
| Datenquelle / Data source | Ort oder System, aus dem ein Datenfeld stammt (z. B. Fall-Datenbank, Import-CSV). |
| Zweckbindung / Purpose limitation | Daten dürfen nur für den Zweck genutzt werden, für den sie erhoben wurden. |
| Aussagegrenze / Limit of validity | Grenze, bis zu der eine Auswertung belastbar ist; darüber hinaus ist sie Spekulation. |
| Datenherkunft / Data provenance | Nachvollziehbarer Weg eines Wertes von der Quelle bis zur Auswertung. |
| Vollständigkeit / Completeness | Anteil der benötigten Felder, die tatsächlich befüllt und nutzbar sind. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Frage zuerst, Daten danach.** Beginne mit der fachlichen Frage, nicht mit den
vorhandenen Spalten. Beispiel: „Wie lange dauert ein Fall im Durchschnitt bis zum Abschluss?" Erst diese
Frage sagt dir, dass du Eröffnungs- und Abschlussdatum brauchst – und nicht den Freitext-Kommentar. Wer mit
den Daten statt mit der Frage startet, sammelt oft Felder, die niemand braucht.

**EN:** **Step 1 – Question first, data second.** Start with the business question, not with the existing
columns. Example: "How long does a case take on average until closure?" Only this question tells you that you
need the opening and closing date – and not the free-text comment. Starting with the data instead of the
question often collects fields that nobody needs.

**DE:** **Schritt 2 – Quellen und ihre Qualität benennen.** Für jedes benötigte Feld hältst du fest: Aus
welcher Quelle kommt es? Wie zuverlässig ist es? Ein Abschlussdatum aus einem Pflichtfeld ist verlässlicher
als eines aus einem optionalen Freitext. Notiere bekannte Lücken, z. B. „Status wurde erst ab 2025 sauber
gepflegt". Diese Notiz ist später die Grundlage der Aussagegrenze.

**EN:** **Step 2 – Name sources and their quality.** For each needed field you record: which source does it
come from? How reliable is it? A closing date from a mandatory field is more reliable than one from an
optional free text. Note known gaps, e.g. "status was only maintained cleanly from 2025". This note later
becomes the basis of the limit of validity.

**DE:** **Schritt 3 – Zweckbindung prüfen.** Frage bei jedem Feld: Wurde es für genau diesen Zweck erhoben?
Der Name einer bearbeitenden Person darf nicht heimlich zur Leistungsbewertung genutzt werden, wenn er nur
zur Fallzuordnung erhoben wurde. Felder ohne klaren Zweck gehören nicht in die Auswertung.

**EN:** **Step 3 – Check purpose limitation.** For each field ask: was it collected for exactly this purpose?
The name of a processing person must not be secretly used for performance evaluation if it was only collected
for case assignment. Fields without a clear purpose do not belong in the evaluation.

**DE:** **Schritt 4 – Aussagegrenzen ehrlich festhalten.** Schreibe auf, was die Auswertung *nicht* aussagt.
Beispiele: „Fälle vor 2025 fehlen teilweise, daher gilt der Mittelwert erst ab 2025." Oder: „Nur 60 % der
Fälle haben ein Abschlussdatum; die Durchlaufzeit basiert nur auf diesen." Eine ehrliche Grenze schützt vor
falschen Entscheidungen.

**EN:** **Step 4 – Record limits of validity honestly.** Write down what the evaluation does *not* say.
Examples: "cases before 2025 are partly missing, so the mean is valid only from 2025." Or: "only 60% of cases
have a closing date; throughput time is based only on these." An honest limit protects against wrong
decisions.

**DE:** **Typische Fehler.** Alle verfügbaren Felder einsammeln „für alle Fälle". Quellenqualität nicht
notieren. Zweckbindung ignorieren. Aus 60 % Datenbasis eine Aussage über 100 % ableiten. Lücken verschweigen,
damit das Ergebnis überzeugender wirkt.

**EN:** **Common mistakes.** Collecting all available fields "just in case". Not recording source quality.
Ignoring purpose limitation. Deriving a statement about 100% from a 60% data base. Hiding gaps to make the
result look more convincing.

### Beispiel / Example

```text
Frage:              "Durchschnittliche Durchlaufzeit geschlossener Fälle in 2025?"
Benötigte Felder:   Fall-ID, Eröffnungsdatum, Abschlussdatum, Status
Quelle:             Fall-Datenbank (Pflichtfelder), CSV-Import fuer Altfaelle
Qualitaet:          Abschlussdatum nur bei Status = geschlossen befuellt
Vollstaendigkeit:   612 von 1000 Faellen haben ein gueltiges Abschlussdatum (61 %)
Aussagegrenze:      Mittelwert gilt nur fuer die 612 geschlossenen Faelle in 2025,
                    nicht fuer alle 1000 Faelle. Altfaelle vor 2025 sind ausgeschlossen.
Zweckbindung:       Bearbeiter-Name NICHT verwendet (nur zur Zuordnung erhoben).
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Jede kundenspezifische Datenanalyse beginnt mit Datenbedarf, Quellenbewertung und Aussagegrenzen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Datenquellen und Datenfelder stammen aus der verwalteten Fall-Datenbank. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, saubere Datenannahmen und auditfähige
Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungs- und Risikoblick),
`CL_08` (Review der Datenverarbeitung), `CL_10` (Datenschutz) und `CL_12` (auditfähige Nachweise). Die
Datenentscheidung dieser Einheit lautet: *Es werden nur Felder erhoben, die eine konkrete Frage brauchen,
und jede Aussage nennt ihre Grenze.* A11Y-Aspekt: Die Datenquellenmatrix muss als Tabelle mit klaren
Spaltenüberschriften lesbar sein, ohne Farbcodierung, damit sie auch mit Screenreader oder Braille-Zeile
nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: data protection, clean data assumptions, and audit-ready
evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat and risk view), `CL_08`
(review of data processing), `CL_10` (data protection), and `CL_12` (audit-ready evidence). The data decision
of this unit is: *only fields that a concrete question needs are collected, and every statement names its
limit.* Accessibility aspect: the data-source matrix must be readable as a table with clear column headers,
without color coding, so it stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum leitet man den Datenbedarf aus der Frage ab und nicht aus den vorhandenen Feldern? /
   **EN:** Why derive the data need from the question and not from the existing fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur die Frage sagt, welche Felder wirklich nötig sind. Startet man bei den Feldern, sammelt man zu
   viel, verletzt die Datenminimierung und verliert den Fokus.
   **EN:** Only the question says which fields are truly needed. Starting from the fields collects too much,
   violates data minimization, and loses focus.

   </details>

2. **DE:** Was ist eine Aussagegrenze, und warum gehört sie zu jeder Auswertung? /
   **EN:** What is a limit of validity, and why does it belong to every evaluation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie beschreibt, bis wohin eine Auswertung belastbar ist. Ohne sie wirken lückenhafte Daten wie
   vollständige, und Entscheidungen beruhen auf Scheingenauigkeit.
   **EN:** It describes how far an evaluation is reliable. Without it, incomplete data looks complete, and
   decisions rest on false precision.

   </details>

3. **DE:** (DPA) Nur 61 % der Fälle haben ein Abschlussdatum. Wie beeinflusst das die Durchlaufzeit? /
   **EN:** (DPA) Only 61% of cases have a closing date. How does that affect throughput time?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Durchlaufzeit gilt nur für die 61 % mit Abschlussdatum. Sie darf nicht als Wert für alle Fälle
   dargestellt werden; die 39 % ohne Datum müssen als Grenze benannt werden.
   **EN:** Throughput time applies only to the 61% with a closing date. It must not be presented as a value for
   all cases; the 39% without a date must be named as a limit.

   </details>

4. **DE:** Wie hängt die Zweckbindung mit der Auswahl der Datenfelder zusammen? /
   **EN:** How is purpose limitation connected to choosing data fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Feld darf nur ausgewertet werden, wenn es für diesen Zweck erhoben wurde. Der Bearbeiter-Name
   zur Fallzuordnung darf nicht zur Leistungsbewertung zweckentfremdet werden.
   **EN:** A field may only be evaluated if it was collected for this purpose. A processing person's name for
   case assignment must not be repurposed for performance evaluation.

   </details>

5. **DE:** Warum ist die Quellenqualität für die spätere Kennzahl wichtig? /
   **EN:** Why is source quality important for the later metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Pflichtfeld ist zuverlässiger als ein optionaler Freitext. Schlechte Quellenqualität erzeugt
   ungenaue Kennzahlen, auch wenn die Rechnung selbst korrekt ist.
   **EN:** A mandatory field is more reliable than an optional free text. Poor source quality produces
   inaccurate metrics even when the calculation itself is correct.

   </details>

6. **DE:** (DPA) Warum sollte eine Datenquellenmatrix Vollständigkeit und bekannte Lücken je Feld enthalten? /
   **EN:** (DPA) Why should a data-source matrix contain completeness and known gaps per field?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** So ist für jede Auswertung nachvollziehbar, wie belastbar sie ist. Die Matrix ist die auditfähige
   Grundlage der Aussagegrenzen und schützt vor überzogenen Aussagen.
   **EN:** This makes it traceable for every evaluation how reliable it is. The matrix is the audit-ready basis
   of the limits of validity and protects against overstated claims.

   </details>

7. **DE:** Warum ist es ein Fehler, Lücken zu verschweigen, um ein Ergebnis überzeugender zu machen? /
   **EN:** Why is it a mistake to hide gaps to make a result more convincing?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Verschwiegene Lücken führen zu falschen Entscheidungen und sind bei einem Audit nicht haltbar.
   Ehrliche Grenzen sind fachlich und rechtlich sicherer als scheinbar perfekte Zahlen.
   **EN:** Hidden gaps lead to wrong decisions and do not hold up in an audit. Honest limits are technically
   and legally safer than seemingly perfect numbers.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den Datenbedarf aus einer fachlichen Frage ableiten.
- [ ] jede Datenquelle mit Zuverlässigkeit und Lücken benennen.
- [ ] die Zweckbindung je Feld prüfen.
- [ ] eine Aussagegrenze klar und ehrlich formulieren.
- [ ] eine auditfähige Datenquellenmatrix aufbauen.

**EN:** I can …

- [ ] derive the data need from a business question.
- [ ] name each data source with reliability and gaps.
- [ ] check purpose limitation per field.
- [ ] state a limit of validity clearly and honestly.
- [ ] build an audit-ready data-source matrix.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Data-Process-Track_01_Datenbedarf-Datenquellen-und-Aussagegrenzen.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Data-Process-Track_01_Datenbedarf-Datenquellen-und-Aussagegrenzen.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
