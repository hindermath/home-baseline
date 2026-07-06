# Lernbegleiter: Secure ServiceHarvester Data & Process Track 10 – Daten-Review, Trade-offs und Abschluss / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_10_Daten-Review-Trade-offs-und-Abschluss.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Dies ist die **Abschlusseinheit** des Data & Process Track. Du führst zusammen, was in den Einheiten 06
bis 09 entstanden ist: Aussagegrenzen, Anomalie- und Lückenerkennung, Prozessfeedback und die Test- und
Nachweisstrategie. Ein **Daten-Review** prüft ehrlich, was belegt ist und was offen bleibt. Im Zentrum stehen
**Trade-offs** – Zielkonflikte, bei denen man nicht alles gleichzeitig haben kann: Aktualität gegen Last,
Präzision gegen Trefferquote, Datenminimierung gegen Aussagekraft. Am Ende steht eine **begründete
Handlungsempfehlung** mit ehrlich benannten Restrisiken.

**EN:** This is the **closing unit** of the Data & Process Track. You bring together what was created in units 06
to 09: interpretation limits, anomaly and gap detection, process feedback, and the test and evidence strategy. A
**data review** honestly checks what is evidenced and what stays open. At the center are **trade-offs** – goal
conflicts where you cannot have everything at once: freshness versus load, precision versus recall, data
minimization versus expressiveness. At the end there is a **justified recommendation for action** with honestly
named residual risks.

**DE:** In dieser Einheit lernst du, ein ehrliches Abschlussbild zu zeichnen, zentrale Trade-offs mit Begründung
zu benennen, Restrisiken mit Eintritts- und Wirkungseinschätzung zu dokumentieren und eine priorisierte
Empfehlung abzuleiten. Jede positive Aussage braucht einen Nachweispfad. Die C#-Referenz `InventarWorkerService`
dient nur als Vergleich; die Lösung bleibt sprachneutral.

**EN:** In this unit you learn to draw an honest closing picture, to name central trade-offs with justification,
to document residual risks with an occurrence and impact estimate, and to derive a prioritized recommendation.
Every positive claim needs an evidence path. The C# reference `InventarWorkerService` serves only for comparison;
the solution stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Daten-Review / Data review | Ehrliche Abschlussprüfung, was belegt ist und was offen bleibt. |
| Trade-off / Trade-off | Zielkonflikt, bei dem ein Vorteil einen Nachteil an anderer Stelle bringt. |
| Restrisiko / Residual risk | Risiko, das nach allen Maßnahmen bewusst offen bleibt. |
| Eintritt und Wirkung / Occurrence and impact | Einschätzung, wie wahrscheinlich und wie schwer ein Risiko wirkt. |
| Handlungsempfehlung / Recommendation for action | Priorisierter, begründeter Vorschlag für die nächsten Schritte. |
| Nachweispfad / Evidence path | Ort und Form, an dem eine Aussage belegt wird. |
| Aussagegrenze / Limit of validity | Ausdrückliche Angabe, wofür eine Aussage gilt und wofür nicht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Abschlussbild zusammenführen.** Sammle die Ergebnisse der Einheiten 06 bis 09 an einer
Stelle: Welche Kennzahlen und Aussagegrenzen gelten? Welche Anomalien und Lücken sind bekannt? Welches
Prozessfeedback ist entstanden? Welche Nachweise liegen vor? Markiere fehlende Nachweise ausdrücklich als
fehlend – ein leeres Feld ist kein Nachweis.

**EN:** **Step 1 – Consolidate the closing picture.** Gather the results of units 06 to 09 in one place: which
metrics and interpretation limits apply? Which anomalies and gaps are known? Which process feedback emerged? Which
evidence exists? Mark missing evidence explicitly as missing – an empty field is not evidence.

**DE:** **Schritt 2 – Trade-offs benennen.** Ein Trade-off ist ehrliche Ingenieursarbeit: Du machst sichtbar,
dass jede Entscheidung einen Preis hat. Häufigere Sammlung bringt Aktualität, kostet aber Last und Speicher. Eine
strengere Anomalieregel findet mehr Fälle (Trefferquote), erzeugt aber mehr Fehlalarme (weniger Präzision).
Weniger Felder schützen die Privatsphäre, verringern aber die Aussagekraft. Benenne je Trade-off die Optionen und
deine begründete Wahl.

**EN:** **Step 2 – Name trade-offs.** A trade-off is honest engineering: you make visible that every decision has
a price. More frequent collection brings freshness but costs load and storage. A stricter anomaly rule finds more
cases (recall) but produces more false alarms (less precision). Fewer fields protect privacy but reduce
expressiveness. For each trade-off, name the options and your justified choice.

**DE:** **Schritt 3 – Restrisiken ehrlich dokumentieren.** Notiere, was trotz aller Maßnahmen offen bleibt, mit
einer Einschätzung von Eintritt (wie wahrscheinlich) und Wirkung (wie schwer). Beschönige nichts: Ein Restrisiko
als „behoben" darzustellen ist gefährlicher als es offen zu benennen, weil niemand mehr darauf achtet.

**EN:** **Step 3 – Document residual risks honestly.** Note what stays open despite all measures, with an estimate
of occurrence (how likely) and impact (how severe). Do not gloss over anything: presenting a residual risk as
"resolved" is more dangerous than naming it openly, because no one watches it anymore.

**DE:** **Schritt 4 – Handlungsempfehlung ableiten.** Leite aus Abschlussbild, Trade-offs und Restrisiken eine
priorisierte Empfehlung ab: Was zuerst, was später, was bewusst nicht? Jede Empfehlung braucht eine Begründung und
verweist auf ihren Nachweis. Eine Empfehlung ohne Begründung ist eine Meinung, keine belastbare Aussage.

**EN:** **Step 4 – Derive the recommendation for action.** From the closing picture, trade-offs, and residual
risks, derive a prioritized recommendation: what first, what later, what deliberately not? Every recommendation
needs a justification and points to its evidence. A recommendation without justification is an opinion, not a
dependable statement.

**DE:** **Schritt 5 – Lernreflexion und Aussagegrenzen des Abschlusses.** Halte fest, was der Track gezeigt hat
und wo seine Grenzen liegen. Auch das Abschlussbild hat eine Aussagegrenze: Es gilt für den betrachteten
Datenstand und Zeitraum. Ordne Spec Kit als begleitende SDD-Struktur ein, die die Nachweise strukturiert, aber
Berufsschule, betriebliche Ausbildung und Prüfung nicht ersetzt.

**EN:** **Step 5 – Learning reflection and limits of the closure.** Record what the track showed and where its
limits lie. The closing picture, too, has a limit of validity: it holds for the observed data state and period.
Position Spec Kit as an accompanying SDD structure that organizes the evidence but does not replace vocational
school, workplace training, and assessment.

**DE:** **Typische Fehler.** Erfolge betonen und Restrisiken verschweigen. Trade-offs als „gelöst" darstellen,
statt den Preis zu benennen. Empfehlungen ohne Begründung oder Nachweis geben. Fehlende Nachweise als vorhanden
behandeln. Die Aussagegrenze des Abschlusses selbst vergessen. Nicht anwendbare Standards still weglassen statt als
`N/A` mit Begründung.

**EN:** **Common mistakes.** Emphasizing successes and hiding residual risks. Presenting trade-offs as "solved"
instead of naming the price. Giving recommendations without justification or evidence. Treating missing evidence
as present. Forgetting the limit of validity of the closure itself. Silently dropping non-applicable standards
instead of documenting them as `N/A` with a rationale.

### Beispiel / Example

```text
Abschlussmatrix (Auszug):
  Thema (Einheit)          Nachweis vorhanden?   Status
  Aussagegrenzen (06)      ja: Kennzahltabelle   belegt
  Anomalien/Luecken (07)   teils: Regelliste     Open (Schwelle unbestaetigt)
  Prozessfeedback (08)     ja: Feedback-Notiz    belegt
  Test/Nachweis (09)       ja: Golden Dataset    belegt

Trade-offs:
  Aktualitaet vs. Last:      15-min-Sammlung gewaehlt (Aktualitaet), Last akzeptiert -> begruendet
  Praezision vs. Trefferquote: mildere Anomalieregel -> weniger Fehlalarm, evtl. verpasste Faelle
  Minimierung vs. Aussagekraft: Hostname aggregiert -> weniger Personenbezug, groebere Aussage

Restrisiko:  Anomalieschwelle nicht validiert | Eintritt: mittel | Wirkung: mittel -> beobachten
Empfehlung:  1) Schwelle mit Golden Dataset validieren  2) Sammelintervall pruefen  3) Bericht ausrollen
Aussagegrenze: gilt fuer aktuellen Datenstand und Zeitraum; Secrets nur als <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c**
ist primär, weil das Abschluss-Review die kundenspezifische Prozess- und Datenanalyse mit Empfehlung zusammenführt;
LF 6 ist berührt, weil die Empfehlung auf die Bearbeitung von Serviceanfragen zurückwirkt.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
12c** is primary because the closing review brings together the customer-specific process and data analysis with a
recommendation; LF 6 is touched because the recommendation feeds back into handling service requests.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Das Abschluss-Review bündelt die Analyse zu Trade-offs, Restrisiken und einer begründeten Empfehlung. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Die Handlungsempfehlung wirkt auf konkrete Serviceanfragen und Wartungsentscheidungen zurück. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähige Evidenz, ehrliche Restrisikobenennung, Datenschutz
und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Testmanagement), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Datenschutz), `CL_11` (Lieferkette/Reproduzierbarkeit) und `CL_12` (Nachweise
und Abschluss). Die Datenentscheidung dieser Einheit lautet: *Jede positive Aussage trägt einen Nachweispfad,
Trade-offs und Restrisiken sind ehrlich getrennt dokumentiert, und die Empfehlung ist begründet und priorisiert.*
A11Y-Aspekt: Abschlussmatrix, Trade-off- und Restrisikotabellen müssen als reiner Text mit Kopfzeile lesbar sein,
ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: audit-ready evidence, honest naming of residual risks,
privacy, and testability. Matching checklists: `CL_01` (standards applicability), `CL_04` (test management),
`CL_08` (security code review), `CL_10` (data protection), `CL_11` (supply chain/reproducibility), and `CL_12`
(evidence and closure). The data decision of this unit is: *every positive claim carries an evidence path,
trade-offs and residual risks are documented honestly and separately, and the recommendation is justified and
prioritized.* Accessibility aspect: closing matrix, trade-off, and residual-risk tables must be readable as plain
text with a header row, without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist ein Trade-off, und warum gehört er in ein ehrliches Abschluss-Review? /
   **EN:** What is a trade-off, and why does it belong in an honest closing review?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Trade-off ist ein Zielkonflikt, bei dem ein Vorteil einen Nachteil an anderer Stelle bringt. Er
   gehört ins Review, weil er sichtbar macht, dass jede Entscheidung einen Preis hat und bewusst getroffen wurde.
   **EN:** A trade-off is a goal conflict where a benefit brings a drawback elsewhere. It belongs in the review
   because it makes visible that every decision has a price and was made deliberately.

   </details>

2. **DE:** (DPA) Nenne den Trade-off „Datenminimierung gegen Aussagekraft" am ServiceHarvester. /
   **EN:** (DPA) Name the trade-off "data minimization versus expressiveness" on the ServiceHarvester.

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Werden Felder wie der volle Hostname aggregiert oder weggelassen, sinkt der Personenbezug (mehr
   Datenschutz), aber die Auswertung wird gröber (weniger Aussagekraft). Man wählt begründet, welche Ebene die
   Kundenfrage noch beantwortet.
   **EN:** If fields like the full hostname are aggregated or omitted, personal reference drops (more privacy), but
   the evaluation becomes coarser (less expressiveness). You choose, with justification, which level still answers
   the customer's question.

   </details>

3. **DE:** (DPA) Warum ist es gefährlicher, ein Restrisiko als „behoben" darzustellen, als es offen zu benennen? /
   **EN:** (DPA) Why is presenting a residual risk as "resolved" more dangerous than naming it openly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein als behoben dargestelltes Risiko wird nicht mehr beobachtet und trifft dann unvorbereitet. Offen
   benannt mit Eintritt und Wirkung bleibt es im Blick und kann bei Bedarf behandelt werden.
   **EN:** A risk presented as resolved is no longer watched and then strikes unprepared. Named openly with
   occurrence and impact, it stays in view and can be treated when needed.

   </details>

4. **DE:** Warum braucht jede Handlungsempfehlung eine Begründung und einen Nachweispfad? /
   **EN:** Why does every recommendation for action need a justification and an evidence path?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Begründung und Nachweis ist eine Empfehlung nur eine Meinung. Erst der Nachweis macht sie
   nachvollziehbar und prüfbar, sodass andere ihr vertrauen und darauf aufbauen können.
   **EN:** Without justification and evidence a recommendation is only an opinion. Only the evidence makes it
   traceable and checkable, so that others can trust it and build on it.

   </details>

5. **DE:** (SI) Welcher Betriebs-Trade-off zwischen Aktualität und Last ist zu benennen? /
   **EN:** (SI) Which operational trade-off between freshness and load must be named?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein kürzeres Sammelintervall liefert aktuellere Daten, erzeugt aber mehr Last, Netzverkehr und Speicher.
   Man wählt das Intervall begründet und benennt die akzeptierte Last als Preis der Aktualität.
   **EN:** A shorter collection interval yields fresher data but produces more load, network traffic, and storage.
   You choose the interval with justification and name the accepted load as the price of freshness.

   </details>

6. **DE:** (AE) Welche Trade-off-Entscheidung schlägt sich später im Code oder Datenmodell nieder? /
   **EN:** (AE) Which trade-off decision later shows up in the code or data model?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zum Beispiel die Anomalie-Schwelle (Präzision gegen Trefferquote): Sie wird als Parameter im Code
   sichtbar. Auch die Aggregationsebene und weggelassene Felder prägen das Datenmodell direkt.
   **EN:** For example the anomaly threshold (precision versus recall): it becomes visible as a parameter in the
   code. The aggregation level and omitted fields also shape the data model directly.

   </details>

7. **DE:** Warum hat auch das Abschlussbild selbst eine Aussagegrenze? /
   **EN:** Why does the closing picture itself also have a limit of validity?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es beruht auf einem bestimmten Datenstand und Zeitraum. Ändern sich Daten, Umgebung oder Anforderungen,
   kann sich das Bild verschieben. Die Grenze verhindert, dass der Abschluss als dauerhaft gültig missverstanden
   wird.
   **EN:** It rests on a specific data state and period. If data, environment, or requirements change, the picture
   can shift. The limit prevents the closure from being misread as permanently valid.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Ergebnisse der Einheiten 06 bis 09 zu einem ehrlichen Abschlussbild zusammenführen.
- [ ] zentrale Trade-offs mit Optionen und begründeter Wahl benennen.
- [ ] Restrisiken mit Eintritt und Wirkung ehrlich dokumentieren.
- [ ] eine priorisierte, begründete Handlungsempfehlung ableiten.
- [ ] jeder positiven Aussage einen Nachweispfad zuordnen.
- [ ] Spec Kit als begleitende SDD-Struktur einordnen.

**EN:** I can …

- [ ] consolidate the results of units 06 to 09 into an honest closing picture.
- [ ] name central trade-offs with options and a justified choice.
- [ ] document residual risks honestly with occurrence and impact.
- [ ] derive a prioritized, justified recommendation for action.
- [ ] assign an evidence path to every positive claim.
- [ ] position Spec Kit as an accompanying SDD structure.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_10_Daten-Review-Trade-offs-und-Abschluss.md`. Sie baut auf
der Test- und Nachweisstrategie (Einheit 09) auf und schließt den Data & Process Track ab. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_10_Daten-Review-Trade-offs-und-Abschluss.md`. It builds on
the test and evidence strategy (unit 09) and closes the Data & Process Track. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
