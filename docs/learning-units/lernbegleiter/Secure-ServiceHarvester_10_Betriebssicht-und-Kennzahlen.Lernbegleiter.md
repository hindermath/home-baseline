# Lernbegleiter: Secure ServiceHarvester 10 – Betriebssicht und Kennzahlen / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_10_Betriebssicht-und-Kennzahlen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester läuft als Dienst und sammelt regelmäßig Statusdaten von Maschinen (name,
os, last_contact). Damit man sieht, ob der Dienst gesund arbeitet, braucht er eine **Betriebssicht**: Läuft er?
Wann hat er zuletzt erfolgreich gesammelt? Wie viele Maschinen hat er gesehen? Aus diesen Daten bildest du
einfache **Kennzahlen**: Anzahl gesehener Maschinen, das **Alter des letzten Sammelns** (Harvest-Age) und die
**Fehlerquote** der Sammelläufe. Kennzahlen verdichten viele Daten zu wenigen Zahlen – aber nur, wenn man ihre
**Grenzen** kennt. Eine schön aussehende Zahl kann täuschen, wenn Daten fehlen oder veraltet sind.

**EN:** The Secure ServiceHarvester runs as a service and regularly collects status data from machines (name,
os, last_contact). To see whether the service is healthy, it needs an **operational view**: is it running?
When did it last collect successfully? How many machines has it seen? From this data you form simple
**metrics**: number of seen machines, the **age of the last collection** (harvest age), and the **error rate**
of collection runs. Metrics condense a lot of data into a few numbers – but only if you know their **limits**.
A nice-looking number can mislead when data is missing or stale.

**DE:** In dieser Einheit definierst du diese Betriebskennzahlen, beschreibst ihre Formeln und, ganz wichtig,
ihre **Aussagegrenzen**. Gleichzeitig achtest du auf Datenschutz: Kennzahlen dürfen keine Rückschlüsse auf
echte Personen erlauben. Alle Testdaten sind fiktiv und wiederholbar; veraltete oder fehlende Werte werden
sichtbar behandelt, nicht stillschweigend gefüllt. Die Betriebssicht bleibt im 1. Lehrjahr bewusst einfach.

**EN:** In this unit you define these operational metrics, describe their formulas and, very importantly, their
**limits of interpretation**. At the same time you watch privacy: metrics must not allow conclusions about
real people. All test data is fictitious and repeatable; stale or missing values are handled visibly, not
filled silently. The operational view stays deliberately simple in year 1.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Health / Health | Kurzer Zustandsbericht: Läuft der Dienst und arbeitet er wie erwartet? |
| Kennzahl / Metric | Verdichteter Zahlenwert, der einen Aspekt des Dienstbetriebs beschreibt. |
| Harvest-Age / Harvest age | Zeit seit dem letzten erfolgreichen Sammeln (`now - last_contact`). |
| Fehlerquote / Error rate | Anteil fehlgeschlagener Sammelläufe an allen Läufen. |
| Aussagegrenze / Limit of interpretation | Grenze dessen, was eine Kennzahl wirklich aussagt. |
| Datenqualität / Data quality | Grad, in dem Daten vollständig, aktuell und konsistent sind. |
| Zweckbindung / Purpose limitation | Daten nur für den festgelegten Zweck auswerten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Health und Betriebssicht beschreiben.** Lege fest, was „gesund" bedeutet: Der Dienst
läuft, das letzte Sammeln liegt nicht zu weit zurück, und die Fehlerquote ist niedrig. Warum zuerst Health?
Ohne einen klaren Gesundheitsbegriff lässt sich später keine Kennzahl sinnvoll bewerten.

**EN:** **Step 1 – Describe health and the operational view.** Define what "healthy" means: the service is
running, the last collection is not too far in the past, and the error rate is low. Why health first? Without a
clear notion of health, no metric can be assessed meaningfully later.

**DE:** **Schritt 2 – Kennzahlen mit Zweck definieren.** Lege je Kennzahl den Zweck fest: gesehene Maschinen
(Reichweite), Harvest-Age (Aktualität), Fehlerquote (Zuverlässigkeit), Datenqualitätsprobleme (Vertrauen in
die Zahlen). Warum mit Zweck? Eine Kennzahl ohne klaren Zweck wird leicht falsch verwendet oder
überinterpretiert.

**EN:** **Step 2 – Define metrics with a purpose.** Set a purpose per metric: seen machines (reach), harvest
age (freshness), error rate (reliability), data-quality issues (trust in the numbers). Why with a purpose? A
metric without a clear purpose is easily misused or over-interpreted.

**DE:** **Schritt 3 – Sprachneutrale Formeln festlegen.** Beschreibe für jede Kennzahl eine sprachneutrale
Formel, z. B. Harvest-Age = `now - last_contact` oder Fehlerquote = `fehlgeschlagene Laeufe / alle Laeufe`.
Warum sprachneutral? Alle sechs Zielsprachen müssen dieselben fiktiven Testdaten gleich auswerten; nur so sind
Ergebnisse vergleichbar.

**EN:** **Step 3 – Define language-neutral formulas.** Describe a language-neutral formula for each metric,
e.g. harvest age = `now - last_contact` or error rate = `failed runs / all runs`. Why language-neutral? All six
target languages must evaluate the same fictitious test data equally; only then are results comparable.

**DE:** **Schritt 4 – Datenqualität und veraltete Werte sichtbar behandeln.** Entscheide, wie fehlende, alte
oder widersprüchliche Werte behandelt werden (z. B. veraltete Maschinen als „stale" markieren und zählen, nicht
raten). Warum? Wer fehlende oder alte Werte stillschweigend füllt, verfälscht die Kennzahl und täuscht
Aktualität vor.

**EN:** **Step 4 – Handle data quality and stale values visibly.** Decide how missing, old, or contradictory
values are handled (e.g. mark stale machines as "stale" and count them, do not guess). Why? Whoever silently
fills missing or old values distorts the metric and fakes freshness.

**DE:** **Schritt 5 – Aussagegrenzen und Datenschutz benennen.** Jede Kennzahl bekommt eine Aussagegrenze und
einen Warnhinweis zu möglichen Fehlinterpretationen. Kennzahlen dürfen keine Rückschlüsse auf echte Personen
erlauben; aggregierte Werte enthalten keine vertraulichen Details. Warum? Zahlen wirken objektiv, sind es aber
nur, wenn ihre Grenzen mitgenannt werden – und Datenschutz gilt auch für Betriebsauswertungen.

**EN:** **Step 5 – Name limits of interpretation and privacy.** Every metric gets a limit of interpretation and
a warning about possible misinterpretations. Metrics must not allow conclusions about real people; aggregated
values contain no confidential details. Why? Numbers look objective but are only so if their limits are stated
– and privacy applies to operational evaluations too.

**DE:** **Typische Fehler.** Health mit Fachlogik verwechseln. Kennzahl ohne Zweck oder Aussagegrenze zeigen.
Harvest-Age über nur eine Maschine als „repräsentativ" darstellen. Veraltete Werte still füllen.
Nicht-deterministische Datums-/Zeittests. Personenbezogene Details in Betriebskennzahlen aufnehmen.

**EN:** **Common mistakes.** Confusing health with business logic. Showing a metric without purpose or limit of
interpretation. Presenting a harvest age over a single machine as "representative". Silently filling stale
values. Non-deterministic date/time tests. Including personal details in operational metrics.

### Beispiel / Example

```text
Kennzahl:          Harvest-Age (Alter des letzten Sammelns)
Formel:            now - last_contact  (je Maschine), Betriebssicht = aeltester Wert
Fiktive Daten:     3 Maschinen: last_contact vor 2 min, 9 min, 1 Maschine ohne last_contact
Behandlung:        Maschine ohne last_contact -> "stale/unbekannt" markiert UND gezaehlt (1 unvollstaendig)
Ergebnis:          Gesehene Maschinen = 3 (2 aktuell), aeltestes Harvest-Age = 9 min
Fehlerquote:       1 fehlgeschlagener Lauf / 20 Laeufe = 5 %
Aussagegrenze:     "Nur 2 vollstaendige Maschinen; kleine Datenmenge, nicht repraesentativ."
Datenschutz:       kein Name einer Person, kein Freitext -> nur Status, Zeit und Zaehlwerte.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Health und Betriebskennzahlen werten den Dienstbetrieb aus und machen ihn steuerbar. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Kennzahlen stammen aus dem verwalteten Statusdatenmodell und dessen Qualität. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Zweckbindung und nachvollziehbare
Dokumentation. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und
`CL_11` (Datenschutz/Datenqualität). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Kennzahl hat
Zweck, Formel und Aussagegrenze, und keine Betriebsauswertung erlaubt Rückschlüsse auf echte Personen.*
A11Y-Aspekt: Health und Kennzahlen werden als klarer Text mit Zahlen und ausgeschriebenen Hinweisen
dargestellt, nicht nur als Farbdiagramm oder Ampel, damit sie mit Screenreader und Braille-Zeile verständlich
bleiben.

**EN:** Relation to the Secure Development Guideline: privacy, purpose limitation, and traceable documentation.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_11`
(privacy/data quality). The security decision of this unit is: *every metric has purpose, formula, and a limit
of interpretation, and no operational evaluation allows conclusions about real people.* Accessibility aspect:
health and metrics are shown as clear text with numbers and written-out notes, not only as a color chart or
traffic light, so they remain understandable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was beschreibt die Betriebssicht (Health) eines Sammel-Dienstes? /
   **EN:** What does the operational view (health) of a collection service describe?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ob der Dienst läuft, wann er zuletzt erfolgreich gesammelt hat und wie zuverlässig er arbeitet.
   Health beantwortet die Frage „Arbeitet der Dienst gerade wie erwartet?" kurz und prüfbar.
   **EN:** Whether the service is running, when it last collected successfully, and how reliably it works.
   Health answers the question "is the service currently working as expected?" briefly and verifiably.

   </details>

2. **DE:** (DPA) Warum kann das Harvest-Age leicht falsch interpretiert werden? /
   **EN:** (DPA) Why can the harvest age easily be misinterpreted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein einzelner alter oder fehlender `last_contact`-Wert verschiebt die Sicht stark. Ohne Hinweis auf
   die Datenbasis und stale Maschinen wirkt die Zahl aktueller oder repräsentativer, als sie ist.
   **EN:** A single old or missing `last_contact` value shifts the view strongly. Without a note on the data
   basis and stale machines, the number looks more current or representative than it is.

   </details>

3. **DE:** Warum dürfen veraltete oder fehlende Werte nicht still gefüllt werden? /
   **EN:** Why must stale or missing values not be filled silently?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Geratene Werte verfälschen die Kennzahl und täuschen Aktualität vor. Fehlende oder alte Daten werden
   sichtbar behandelt, z. B. als „stale" markiert und gezählt.
   **EN:** Guessed values distort the metric and fake freshness. Missing or old data is handled visibly, e.g.
   marked as "stale" and counted.

   </details>

4. **DE:** (AE) Welche Kennzahlenberechnung muss deterministisch testbar sein? /
   **EN:** (AE) Which metric calculation must be deterministically testable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Datums- und Zeitberechnungen wie das Harvest-Age. Mit festen, fiktiven Testdaten und einer
   festgelegten „Jetzt"-Zeit liefert derselbe Lauf immer dasselbe Ergebnis, unabhängig von Zeitzone oder Uhrzeit.
   **EN:** Date and time calculations such as harvest age. With fixed, fictitious test data and a defined "now"
   time, the same run always yields the same result, independent of time zone or clock time.

   </details>

5. **DE:** (SI) Welche Betriebs- oder Health-Daten wären für Kennzahlen nützlich, aber sensibel? /
   **EN:** (SI) Which operational or health data would be useful for metrics but sensitive?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Detaillierte Logs, IP-Adressen oder Nutzernamen an Maschinen. Sie können Kennzahlen verbessern,
   erlauben aber leicht Rückschlüsse auf Personen und werden deshalb nur aggregiert und datensparsam genutzt.
   **EN:** Detailed logs, IP addresses, or user names on machines. They can improve metrics but easily allow
   conclusions about people and are therefore used only aggregated and data-minimal.

   </details>

6. **DE:** (DV) Warum beeinflusst die Systemgrenze zwischen Maschinen und Dienst die Datenqualität? /
   **EN:** (DV) Why does the system boundary between machines and the service affect data quality?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fällt die Verbindung aus oder ist eine Maschine getrennt, bleibt `last_contact` alt. Wer die Grenze
   kennt, kann veraltete Werte richtig als „stale" deuten statt sie als aktuelle Kennzahl zu werten.
   **EN:** If the connection drops or a machine is disconnected, `last_contact` stays old. Knowing the boundary
   lets you correctly read stale values as "stale" instead of treating them as a current metric.

   </details>

7. **DE:** Warum braucht jede Betriebskennzahl eine Aussagegrenze? /
   **EN:** Why does every operational metric need a limit of interpretation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zahlen wirken objektiv, können aber täuschen, wenn Daten fehlen, alt oder klein sind. Die
   Aussagegrenze schützt vor Fehlinterpretationen und falschen Betriebsentscheidungen.
   **EN:** Numbers look objective but can mislead when data is missing, old, or small. The limit of
   interpretation protects against misinterpretation and wrong operational decisions.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: ein
   Echtzeit-Dashboard ist `N/A`, weil hier nur einfache Lernkennzahlen berechnet werden.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: a real-time dashboard
   is `N/A` because only simple learning metrics are calculated here.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Health und Betriebssicht eines Sammel-Dienstes beschreiben.
- [ ] Betriebskennzahlen (gesehene Maschinen, Harvest-Age, Fehlerquote) mit Zweck und Formel definieren.
- [ ] für jede Kennzahl eine Aussagegrenze benennen.
- [ ] veraltete oder fehlende Werte sichtbar behandeln.
- [ ] Kennzahlen ohne Rückschluss auf echte Personen gestalten.
- [ ] eine Beispielauswertung mit fiktiven, wiederholbaren Daten erstellen.

**EN:** I can …

- [ ] describe health and the operational view of a collection service.
- [ ] define operational metrics (seen machines, harvest age, error rate) with purpose and formula.
- [ ] name a limit of interpretation for each metric.
- [ ] handle stale or missing values visibly.
- [ ] design metrics without conclusions about real people.
- [ ] create a sample evaluation with fictitious, repeatable data.

## Kaufmännische Rollen-Umschaltung / Commercial Role Switch

**DE:** Betriebssicht und Kennzahlen sind besonders **KDM-nah**, für KITSM zusätzlich betriebs-/
service-relevant (Grundlage:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).

- **KDM (Authoring):** Schreibe eine parametrisierte **Betriebskennzahl-Abfrage** selbst (z. B.
  „aktive Dienste je Zeitraum", „Bestandsentwicklung") und benenne die **Aussagegrenzen**.
- **KITSM (lesend + Bewertung):** Interpretiere die Betriebskennzahlen unter **Kosten/Nutzen** und
  Service-Sicht. Kein Pflicht-Authoring hier — dein SQL-Touch war in 06.
- **Abnahme (evidenzbasiert), eingebaute Abweichung:** Eine Kennzahl ist **überinterpretiert** (fehlende
  Aussagegrenze oder falsche Aggregationsbasis). Finde sie und fordere die Korrektur vor Freigabe.

**EN:** Operational view and key figures are especially **close to KDM**, and additionally
operations/service relevant for KITSM (basis:
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](../Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md)).
KDM authors a parameterized operational-metric query (e.g. "active services per period") and names the
limits of the statement. KITSM interprets the metrics under cost/benefit and service view (no mandatory
authoring here — the SQL touch was in unit 06). Evidence-based acceptance: one figure is
over-interpreted (missing limit or wrong aggregation base) — find it and require the correction before
release.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_10_Betriebssicht-und-Kennzahlen.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_10_Betriebssicht-und-Kennzahlen.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
