# Lernbegleiter: Secure InventoryHub 07 – Patch-, Wartungs- und Risikoansicht / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_07_Patch-Wartungs-und-Risikoansicht.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Inventar ist kein Selbstzweck – es soll helfen, Entscheidungen zu treffen. Eine der wichtigsten
Fragen lautet: „Welche Software ist veraltet und wo ist das Risiko am größten?" Die **Patch-, Wartungs- und
Risikoansicht** verbindet Softwarestände mit Patchstatus, Wartungsterminen und Risikoklassen. So wird sichtbar,
welche Assets dringend aktualisiert werden müssen. Wichtig ist Ehrlichkeit: Eine Risikoeinstufung ist eine
begründete Einschätzung, keine absolute Wahrheit. Deshalb müssen die **Aussagegrenzen** klar benannt werden.

**EN:** An inventory is not an end in itself – it should help make decisions. One of the most important
questions is: "Which software is outdated and where is the risk greatest?" The **patch, maintenance, and risk
view** connects software versions with patch status, maintenance dates, and risk classes. This makes visible
which assets urgently need updating. Honesty is important: a risk rating is a justified estimate, not an
absolute truth. Therefore the **statement limits** must be clearly named.

**DE:** In dieser Einheit lernst du, Patchstand und Wartungstermine sichtbar zu machen, veraltete Software zu
erkennen, Risikoklassen nachvollziehbar zu vergeben und die Grenzen deiner Aussagen zu dokumentieren.

**EN:** In this unit you learn to make patch status and maintenance dates visible, to recognize outdated
software, to assign risk classes traceably, and to document the limits of your statements.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Patchstand / Patch level | Angabe, ob und wie aktuell eine Software mit Korrekturen versorgt ist. |
| Wartungstermin / Maintenance date | Geplanter Zeitpunkt für Pflege, Update oder Prüfung eines Assets. |
| Veraltete Software / Outdated software | Softwarestand ohne aktuelle Sicherheitskorrekturen. |
| Risikoklasse / Risk class | Nachvollziehbare Einstufung, z. B. niedrig, mittel, hoch. |
| CVE / CVE | Öffentlich benannte, dokumentierte Schwachstelle einer Software. |
| Aussagegrenze / Statement limit | Ehrliche Grenze dessen, was eine Risikoansicht wirklich belegt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Patchstand sichtbar machen.** Verbinde jeden Softwarestand mit einer Information über
seine Aktualität: aktuelle Version, installierte Version, Datum der letzten Aktualisierung. Erst wenn dieser
Vergleich vorliegt, kann man „veraltet" überhaupt bestimmen.

**EN:** **Step 1 – Make patch status visible.** Connect each software version with information about its
currency: current version, installed version, date of last update. Only when this comparison exists can one
determine "outdated" at all.

**DE:** **Schritt 2 – Veraltete Software erkennen.** Definiere eine klare Regel, wann Software als veraltet
gilt, z. B. wenn die installierte Version hinter der aktuellen liegt oder ein Wartungstermin überschritten ist.
Eine klare Regel ist wichtiger als ein Bauchgefühl, weil sie prüfbar und wiederholbar ist.

**EN:** **Step 2 – Recognize outdated software.** Define a clear rule for when software counts as outdated,
e.g. when the installed version lags behind the current one or a maintenance date has passed. A clear rule is
more important than a gut feeling because it is verifiable and repeatable.

**DE:** **Schritt 3 – Risikoklassen nachvollziehbar vergeben.** Ordne jedem Fund eine Risikoklasse zu und
begründe sie. Faktoren können sein: Schwere einer bekannten Schwachstelle (CVE), Erreichbarkeit des Assets,
Wichtigkeit für den Betrieb. Wichtig: Die Einstufung muss nachvollziehbar sein, damit sie überprüft und bei
Bedarf korrigiert werden kann.

**EN:** **Step 3 – Assign risk classes traceably.** Assign a risk class to each finding and justify it.
Factors can be: severity of a known vulnerability (CVE), reachability of the asset, importance for operations.
Important: the rating must be traceable so it can be reviewed and corrected if needed.

**DE:** **Schritt 4 – Aussagegrenzen dokumentieren.** Eine Risikoansicht ist nur so gut wie ihre Datenbasis.
Wenn nicht alle Assets erfasst sind oder Versionsdaten fehlen, ist die Aussage begrenzt. Benenne diese Grenzen
ehrlich und markiere offene Punkte als `Open` mit Folgeaktion. Ein überzeichnetes „alles sicher" ist
gefährlicher als ein ehrliches „hier fehlen uns Daten".

**EN:** **Step 4 – Document statement limits.** A risk view is only as good as its data basis. If not all
assets are recorded or version data is missing, the statement is limited. Name these limits honestly and mark
open points as `Open` with a follow-up action. An overstated "everything is safe" is more dangerous than an
honest "we are missing data here".

**DE:** **Typische Fehler.** „Veraltet" ohne klare Regel behaupten. Risikoklassen ohne Begründung vergeben.
Fehlende Daten verschweigen. Risiko als absolute Wahrheit darstellen. Wartungstermine ignorieren. Bekannte
Schwachstellen (CVE) nicht mit dem eigenen Bestand verknüpfen.

**EN:** **Common mistakes.** Claiming "outdated" without a clear rule. Assigning risk classes without
justification. Hiding missing data. Presenting risk as absolute truth. Ignoring maintenance dates. Not linking
known vulnerabilities (CVE) to your own stock.

### Beispiel / Example

```text
Software:        OpenSSL installiert 3.0.13, aktuell 3.0.14 -> hinter aktueller Version
Wartungstermin:  2026-06-01 überschritten
Regel:           installierte < aktuelle ODER wartungstermin < heute  => "veraltet"
Ergebnis:        veraltet = ja

Risikoklasse:    hoch  (Begründung: bekannter CVE mittel-hoch + Asset extern erreichbar)
Aussagegrenze:   nur 78 % der Assets haben Versionsdaten -> Ansicht unvollständig
Open:            "Versionsdaten für 22 % nachpflegen"  (Folgeaktion, Owner: team-ops)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Die Patch- und Risikoansicht beantwortet eine konkrete Serviceanfrage nach Handlungsbedarf. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Risikoklassen und Patchstand sind angewandte Schutzbedarfsanalyse. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Schwachstellen- und Patch-Management, Risikobewertung und
Lieferkettenbezug. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_06` (Abhängigkeiten/Supply
Chain), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise). Die
Sicherheitsentscheidung dieser Einheit lautet: *Risikoaussagen werden nachvollziehbar begründet und ehrlich mit
Aussagegrenzen versehen.* A11Y-Aspekt: Risikoklassen dürfen nicht nur über Farbe (z. B. rot/grün) gezeigt
werden, sondern brauchen zusätzlich klaren Text (niedrig/mittel/hoch), damit sie mit Screenreader oder
Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: vulnerability and patch management, risk assessment, and
supply-chain relation. Matching checklists: `CL_01` (standards applicability), `CL_06` (dependencies/supply
chain), `CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence). The security decision of
this unit is: *risk statements are justified traceably and honestly annotated with statement limits.*
Accessibility aspect: risk classes must not be shown by color only (e.g. red/green) but also need clear text
(low/medium/high), so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum braucht man den Patchstand, um „veraltet" bestimmen zu können? /
   **EN:** Why do you need the patch status to determine "outdated"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Erst der Vergleich von installierter und aktueller Version (plus Wartungsdatum) zeigt, ob Software
   hinterherhinkt. Ohne diese Information ist „veraltet" nur eine Vermutung.
   **EN:** Only the comparison of installed and current version (plus maintenance date) shows whether software
   lags behind. Without this information, "outdated" is only a guess.

   </details>

2. **DE:** Warum sollte die Regel für „veraltet" klar und prüfbar sein? /
   **EN:** Why should the rule for "outdated" be clear and verifiable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine klare Regel liefert wiederholbare, überprüfbare Ergebnisse. Ein Bauchgefühl ist nicht
   nachvollziehbar und kann je nach Person unterschiedlich ausfallen.
   **EN:** A clear rule produces repeatable, verifiable results. A gut feeling is not traceable and can differ
   from person to person.

   </details>

3. **DE:** (SI) Welche Faktoren können in eine Risikoklasse einfließen? /
   **EN:** (SI) Which factors can feed into a risk class?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Schwere einer bekannten Schwachstelle (CVE), Erreichbarkeit des Assets und Wichtigkeit für den
   Betrieb. Die Kombination ergibt eine begründete Einstufung.
   **EN:** Severity of a known vulnerability (CVE), reachability of the asset, and importance for operations.
   The combination yields a justified rating.

   </details>

4. **DE:** Warum muss eine Risikoeinstufung nachvollziehbar begründet sein? /
   **EN:** Why must a risk rating be justified traceably?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur eine begründete Einstufung lässt sich überprüfen und bei neuen Erkenntnissen korrigieren. Ohne
   Begründung ist sie beliebig und im Audit nicht haltbar.
   **EN:** Only a justified rating can be reviewed and corrected with new insights. Without justification it is
   arbitrary and not defensible in an audit.

   </details>

5. **DE:** (DPA) Warum ist es wichtig, Aussagegrenzen der Risikoansicht zu benennen? /
   **EN:** (DPA) Why is it important to name the statement limits of the risk view?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fehlende oder unvollständige Daten begrenzen die Aussage. Ohne diesen Hinweis entsteht ein falsches
   Sicherheitsgefühl. Ehrliche Grenzen ermöglichen richtige Entscheidungen und Folgeaktionen.
   **EN:** Missing or incomplete data limits the statement. Without this note a false sense of security arises.
   Honest limits enable correct decisions and follow-up actions.

   </details>

6. **DE:** Warum ist ein überzeichnetes „alles sicher" gefährlicher als ein ehrliches „hier fehlen Daten"? /
   **EN:** Why is an overstated "everything is safe" more dangerous than an honest "data is missing here"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein falsches „alles sicher" verhindert nötige Maßnahmen, weil man sich in Sicherheit wiegt. Ein
   ehrliches Fehlen weist auf konkreten Handlungsbedarf hin.
   **EN:** A false "everything is safe" prevents necessary measures because one feels safe. An honest gap
   points to concrete action needed.

   </details>

7. **DE:** Wie hängen Wartungstermine mit der Risikoansicht zusammen? /
   **EN:** How do maintenance dates relate to the risk view?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein überschrittener Wartungstermin ist ein Hinweis auf mögliches Risiko, auch ohne bekannten CVE. Er
   fließt als Faktor in die Bewertung „veraltet" und in die Risikoklasse ein.
   **EN:** A passed maintenance date indicates possible risk, even without a known CVE. It feeds as a factor
   into the "outdated" assessment and into the risk class.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den Patchstand einer Software sichtbar machen.
- [ ] eine klare Regel für „veraltet" formulieren.
- [ ] Risikoklassen nachvollziehbar vergeben und begründen.
- [ ] Aussagegrenzen und offene Punkte dokumentieren.
- [ ] Risikoklassen textbasiert und nicht nur farblich darstellen.

**EN:** I can …

- [ ] make the patch status of a software visible.
- [ ] formulate a clear rule for "outdated".
- [ ] assign and justify risk classes traceably.
- [ ] document statement limits and open points.
- [ ] present risk classes text-based, not by color only.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_07_Patch-Wartungs-und-Risikoansicht.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_07_Patch-Wartungs-und-Risikoansicht.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
