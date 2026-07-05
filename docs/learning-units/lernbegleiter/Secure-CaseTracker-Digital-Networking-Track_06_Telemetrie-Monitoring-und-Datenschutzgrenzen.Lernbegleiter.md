# Lernbegleiter: Secure CaseTracker Digital Networking Track 06 – Telemetrie, Monitoring und Datenschutzgrenzen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_06_Telemetrie-Monitoring-und-Datenschutzgrenzen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wer ein vernetztes System betreibt, muss sehen, ob es gesund ist. **Telemetrie** sind die Daten, die
das System über sich selbst aussendet: **Metriken** (Zahlen wie Antwortzeit), **Logs** (Ereignistexte) und
**Traces** (der Weg einer Anfrage durch mehrere Dienste). **Monitoring** wertet diese Daten aus und schlägt
mit **Alerts** Alarm. Der wichtige Konflikt im dritten Lehrjahr: Monitoring ist nützlich, sammelt aber leicht
zu viel. Logs mit vollständigen Personendaten, Secrets oder ganzen Pfaden werden selbst zum Risiko. Die
**Datenschutzgrenze** legt fest, was gesammelt werden darf und was nicht.

**EN:** Whoever operates a networked system must see whether it is healthy. **Telemetry** is the data the
system emits about itself: **metrics** (numbers like response time), **logs** (event texts), and **traces**
(the path of a request through several services). **Monitoring** evaluates this data and raises alarms with
**alerts**. The important conflict in the third year: monitoring is useful but easily collects too much. Logs
with full personal data, secrets, or whole paths become a risk themselves. The **privacy boundary** defines
what may be collected and what may not.

**DE:** In dieser Einheit lernst du, Metriken, Logs, Traces und Alerts getrennt zu beschreiben, für jede
Datenquelle Zweck, Zugriff, Aufbewahrung und Datenminimierung festzulegen und die Grenze der Aussagekraft
(Aussagegrenze) ehrlich zu benennen.

**EN:** In this unit you learn to describe metrics, logs, traces, and alerts separately, to define purpose,
access, retention, and data minimization for each data source, and to name the interpretation limit
honestly.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Telemetrie / Telemetry | Daten, die ein System über seinen eigenen Zustand aussendet. |
| Metrik / Metric | Zahlenwert, der einen Zustand misst (z. B. Antwortzeit, Fehlerzahl). |
| Trace / Trace | Aufzeichnung des Wegs einer Anfrage durch mehrere Dienste. |
| Datenminimierung / Data minimization | Nur so viele Daten erheben, wie der Zweck wirklich braucht. |
| Zweckbindung / Purpose limitation | Daten nur für den vorher festgelegten Zweck nutzen. |
| Aussagegrenze / Interpretation limit | Ehrliche Grenze, was die Daten belegen und was nicht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Datenquellen trennen.** Metriken, Logs, Traces und Alerts haben unterschiedliche
Risiken. Eine Metrik „Zahl offener Fälle" ist harmlos. Ein Log, das einen kompletten Fallinhalt speichert,
ist heikel. Trenne die Quellen, damit du je Quelle passend entscheiden kannst.

**EN:** **Step 1 – Separate the data sources.** Metrics, logs, traces, and alerts carry different risks. A
metric "number of open cases" is harmless. A log that stores a whole case content is sensitive. Separate the
sources so you can decide appropriately per source.

**DE:** **Schritt 2 – Zweck vor Erhebung.** Für jede Datenquelle notierst du zuerst den Zweck: Warum wird das
gebraucht? Ohne Zweck keine Erhebung (Zweckbindung). Was keinen Betriebs- oder Sicherheitszweck hat, wird
nicht gesammelt.

**EN:** **Step 2 – Purpose before collection.** For each data source you first note the purpose: why is it
needed? No purpose, no collection (purpose limitation). Whatever has no operational or security purpose is
not collected.

**DE:** **Schritt 3 – Datenminimierung anwenden.** Sammle so wenig wie möglich. Statt des ganzen Falltexts
genügt eine Fall-ID oder ein Zählwert. Statt der vollständigen IP genügt oft ein grober Bereich. Warum? Was
nicht gespeichert ist, kann nicht gestohlen werden und muss nicht geschützt werden.

**EN:** **Step 3 – Apply data minimization.** Collect as little as possible. Instead of the whole case text,
a case ID or a counter is enough. Instead of the full IP, a coarse range is often enough. Why? What is not
stored cannot be stolen and does not need protection.

**DE:** **Schritt 4 – Zugriff und Aufbewahrung regeln.** Wer darf die Monitoring-Daten sehen? Wie lange
werden sie behalten? Lege Zugriffsschutz und eine Aufbewahrungsfrist fest. Keine Secrets, Tokens oder
vollständigen Pfade ins Log. Ein Log ist ein Ziel, kein sicherer Ort.

**EN:** **Step 4 – Regulate access and retention.** Who may see the monitoring data? How long is it kept?
Define access protection and a retention period. No secrets, tokens, or full paths in the log. A log is a
target, not a safe place.

**DE:** **Schritt 5 – Aussagegrenze ehrlich benennen.** Monitoring zeigt Symptome, nicht immer Ursachen. Aus
schwankenden Zahlen darf man keine sichere Aussage über eine Person oder eine Ursache ableiten. Schreibe auf,
was die Daten belegen und was nicht. So verhindert man Fehlentscheidungen aus überzogenen Schlüssen.

**EN:** **Step 5 – Name the interpretation limit honestly.** Monitoring shows symptoms, not always causes.
Fluctuating numbers must not lead to a firm statement about a person or a cause. Write down what the data
proves and what it does not. This prevents wrong decisions from overstated conclusions.

**DE:** **Typische Fehler.** Alles loggen „für den Notfall". Vollständige Personendaten oder Secrets ins Log
schreiben. Keine Aufbewahrungsfrist. Aus Monitoring stärkere Aussagen ableiten, als die Datenqualität trägt.
Zugriff auf Monitoring-Daten nicht begrenzen.

**EN:** **Common mistakes.** Logging everything "just in case". Writing full personal data or secrets into
the log. No retention period. Deriving stronger statements from monitoring than the data quality supports.
Not limiting access to monitoring data.

### Beispiel / Example

```text
Telemetrie-Matrix (Auszug):
  Quelle      Inhalt (minimiert)      Zweck                 Zugriff        Aufbewahrung
  Metrik      Zahl offener Faelle     Kapazitaetsplanung    Betrieb        90 Tage
  Log         Fall-ID + Ereignistyp   Fehlersuche           Betrieb        30 Tage
  Trace       Anfrageweg (ohne Inhalt)Latenzanalyse         Betrieb        7 Tage
  Alert       Schwelle ueberschritten Frueherkennung        Betrieb        -

Verboten im Log: voller Falltext, Namen, Tokens, Passwoerter, vollstaendige Pfade
Aussagegrenze: "Latenz gestiegen" belegt kein Verschulden einer Person, nur ein Symptom.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Telemetrie und Monitoring sind Betriebsinstrumente, deren datenschutzgerechte Gestaltung Sicherheit und Betrieb verbindet. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Metriken, Logs und Traces gehören zum überwachbaren Bereitstellen von Netzwerken und Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, sichere Protokollierung, minimale
Datenerhebung und Nachvollziehbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review), `CL_10` (Betrieb/Konfiguration) und `CL_11`
(Datenschutz/Logging). Die Sicherheitsentscheidung dieser Einheit lautet: *Es wird nur mit Zweck und
Datenminimierung gesammelt; Logs enthalten keine Secrets und keine unnötigen personenbezogenen Daten.*
A11Y-Aspekt: Alerts und Dashboards müssen textliche Beschriftungen und Schwellenwerte tragen, nicht nur
farbige Ampeln, damit sie mit Screenreader und Braille-Zeile lesbar bleiben.

**EN:** Relation to the Secure Development Guideline: privacy, safe logging, minimal data collection, and
traceability. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat modeling), `CL_08`
(security code review), `CL_10` (operations/configuration), and `CL_11` (privacy/logging). The security
decision of this unit is: *collection happens only with purpose and data minimization; logs contain no
secrets and no unnecessary personal data.* Accessibility aspect: alerts and dashboards must carry text labels
and threshold values, not only colored traffic lights, so they stay readable with a screen reader and Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum wird der Zweck vor der Erhebung festgelegt? /
   **EN:** Why is the purpose fixed before collection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zweckbindung heißt: Ohne Zweck keine Erhebung. Nur Daten mit klarem Betriebs- oder
   Sicherheitszweck werden gesammelt; alles andere unterbleibt.
   **EN:** Purpose limitation means: no purpose, no collection. Only data with a clear operational or
   security purpose is collected; everything else is left out.

   </details>

2. **DE:** Was bedeutet Datenminimierung für ein Log? /
   **EN:** What does data minimization mean for a log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Statt des ganzen Falltexts genügt eine Fall-ID und ein Ereignistyp. Was nicht gespeichert ist,
   kann nicht gestohlen werden und muss nicht geschützt werden.
   **EN:** Instead of the whole case text a case ID and an event type is enough. What is not stored cannot be
   stolen and does not need protection.

   </details>

3. **DE:** (DV) Warum dürfen Secrets und vollständige Pfade nicht ins Log? /
   **EN:** (DV) Why must secrets and full paths not go into the log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Log ist ein Ziel, kein sicherer Ort. Secrets im Log sind ein Datenleck, und vollständige Pfade
   verraten interne Struktur, die Angreifern hilft.
   **EN:** A log is a target, not a safe place. Secrets in the log are a data leak, and full paths reveal
   internal structure that helps attackers.

   </details>

4. **DE:** Was ist eine Aussagegrenze, und warum ist sie wichtig? /
   **EN:** What is an interpretation limit, and why does it matter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie sagt ehrlich, was die Daten belegen und was nicht. Monitoring zeigt Symptome; daraus darf man
   keine sichere Ursache oder ein Verschulden ableiten. Sonst drohen Fehlentscheidungen.
   **EN:** It states honestly what the data proves and what it does not. Monitoring shows symptoms; one must
   not derive a firm cause or fault from them. Otherwise wrong decisions loom.

   </details>

5. **DE:** Warum braucht Monitoring-Zugriff eine Begrenzung und eine Aufbewahrungsfrist? /
   **EN:** Why does monitoring access need a limit and a retention period?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Monitoring-Daten können personenbezogen sein. Begrenzter Zugriff und eine Frist verringern Risiko
   und Datenschutzumfang; alte Daten werden gelöscht statt endlos aufbewahrt.
   **EN:** Monitoring data can be personal. Limited access and a period reduce risk and privacy scope; old
   data is deleted rather than kept forever.

   </details>

6. **DE:** Warum werden Metriken, Logs und Traces getrennt betrachtet? /
   **EN:** Why are metrics, logs, and traces considered separately?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie haben unterschiedliche Risiken. Eine Zählmetrik ist harmlos, ein Log mit Fallinhalt heikel.
   Getrennte Betrachtung erlaubt je Quelle eine passende Datenschutzentscheidung.
   **EN:** They carry different risks. A counter metric is harmless, a log with case content is sensitive.
   Separate consideration allows an appropriate privacy decision per source.

   </details>

7. **DE:** Warum reicht eine farbige Ampel im Dashboard nicht aus? /
   **EN:** Why is a colored traffic light in the dashboard not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Reine Farbe schließt Menschen mit Farbfehlsichtigkeit und Screenreader-Nutzung aus. Textliche
   Beschriftung und Schwellenwerte machen die Aussage für alle lesbar (WCAG 2.2 AA).
   **EN:** Color only excludes people with color-vision deficiency and screen-reader use. Text labels and
   threshold values make the statement readable for everyone (WCAG 2.2 AA).

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Metriken, Logs, Traces und Alerts getrennt beschreiben.
- [ ] je Datenquelle Zweck, Zugriff und Aufbewahrung festlegen.
- [ ] Datenminimierung anwenden und Secrets aus Logs heraushalten.
- [ ] die Aussagegrenze der Monitoring-Daten ehrlich benennen.
- [ ] Alerts textlich und nicht nur farbig gestalten.

**EN:** I can …

- [ ] describe metrics, logs, traces, and alerts separately.
- [ ] define purpose, access, and retention per data source.
- [ ] apply data minimization and keep secrets out of logs.
- [ ] name the interpretation limit of the monitoring data honestly.
- [ ] design alerts as text and not only as color.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_06_Telemetrie-Monitoring-und-Datenschutzgrenzen.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_06_Telemetrie-Monitoring-und-Datenschutzgrenzen.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
