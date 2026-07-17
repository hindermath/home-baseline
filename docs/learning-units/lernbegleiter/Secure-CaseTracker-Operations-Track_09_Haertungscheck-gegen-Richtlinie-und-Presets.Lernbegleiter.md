# Lernbegleiter: Secure CaseTracker Operations Track 09 – Härtungscheck gegen Richtlinie und Presets / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_09_Haertungscheck-gegen-Richtlinie-und-Presets.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In den Einheiten 01 bis 08 hast du viele Einzelmaßnahmen geplant: Systemgrenzen, Sandbox, Pipeline,
Secrets, Logging, Backup, Incident Response, Supply Chain. Jetzt kommt die **Härtung**: Du prüfst systematisch,
ob dein Betrieb wirklich den Regeln der **Richtlinie Sichere Entwicklung** und den **Presets** entspricht.
Härtung heißt, ein System bewusst widerstandsfähiger zu machen und offene Lücken zu schließen. Ein
**Härtungscheck** ist die strukturierte Gegenprüfung: Was fordert die Regel, was ist erfüllt, was fehlt, und
was hat welche Priorität?

**EN:** In units 01 to 08 you planned many individual measures: system boundaries, sandbox, pipeline, secrets,
logging, backup, incident response, supply chain. Now comes **hardening**: you systematically check whether
your operation really matches the rules of the **Secure Development Guideline** and the **presets**. Hardening
means deliberately making a system more resilient and closing open gaps. A **hardening check** is the
structured cross-check: what does the rule require, what is met, what is missing, and what has which priority?

**DE:** In dieser Einheit lernst du, eine Härtungsmatrix aufzubauen, jede Anforderung gegen Richtlinie und
Presets zu prüfen, offene Punkte ehrlich mit Priorität zu notieren und die sieben Governance-Presets als
prüfbaren Rahmen zu nutzen.

**EN:** In this unit you learn to build a hardening matrix, check each requirement against the guideline and
presets, honestly note open items with a priority, and use the seven governance presets as a verifiable frame.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Härtung / Hardening | Ein System bewusst widerstandsfähiger machen und Lücken schließen. |
| Härtungscheck / Hardening check | Strukturierte Prüfung des Betriebs gegen verbindliche Regeln. |
| Richtlinie / Guideline | Verbindliches Regelwerk für sichere Entwicklung und Betrieb. |
| Preset / Preset | Vordefiniertes Regel-Paket (Governance) mit Prioritäten und Nachweisen. |
| Härtungsmatrix / Hardening matrix | Tabelle: Anforderung, Status, Lücke, Priorität, Nachweis. |
| Priorität / Priority | Reihenfolge, in der offene Punkte behandelt werden sollten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Prüfrahmen festlegen.** Der Rahmen ist die Richtlinie Sichere Entwicklung plus die
sechs Presets: `security-governance`, `architecture-governance`, `isaqb-architecture-governance`,
`a11y-governance`, `cross-platform-governance` und `agent-parity-governance`. Sie geben vor, was geprüft
wird. Ein klarer Rahmen verhindert, dass die Prüfung beliebig wird.

**EN:** **Step 1 – Define the check frame.** The frame is the Secure Development Guideline plus the six
presets: `security-governance`, `architecture-governance`, `isaqb-architecture-governance`,
`a11y-governance`, `cross-platform-governance`, and `agent-parity-governance`. They define what is checked. A
clear frame prevents the review from becoming arbitrary.

**DE:** **Schritt 2 – Härtungsmatrix aufbauen.** Lege eine Tabelle an: pro Anforderung eine Zeile mit Status
(erfüllt / offen / nicht anwendbar), gefundener Lücke, Priorität und Evidenzpfad. Die Matrix macht sichtbar,
wo der Betrieb schon robust ist und wo nicht. Sichtbarkeit ist der erste Schritt zur Verbesserung.

**EN:** **Step 2 – Build the hardening matrix.** Create a table: one row per requirement with status (met /
open / not applicable), the gap found, priority, and evidence path. The matrix shows where operation is
already robust and where not. Visibility is the first step to improvement.

**DE:** **Schritt 3 – Ehrlich prüfen und einordnen.** Eine positive Aussage („ist gehärtet") braucht einen
Nachweis. Fehlt er, ist der Punkt `Open` mit Folgeaktion, nicht „erledigt". Nicht anwendbare Anforderungen
werden als `N/A` mit technischer Begründung dokumentiert. Ehrlichkeit ist hier wichtiger als eine schöne,
grüne Liste.

**EN:** **Step 3 – Check and classify honestly.** A positive claim ("is hardened") needs evidence. If it is
missing, the item is `Open` with a follow-up, not "done". Non-applicable requirements are documented as `N/A`
with a technical rationale. Honesty here matters more than a nice, green list.

**DE:** **Schritt 4 – Prioritäten setzen.** Nicht alles lässt sich sofort schließen. Ordne offene Punkte nach
Risiko und Aufwand: Was schützt am meisten bei vertretbarem Aufwand, kommt zuerst. So wird aus der Matrix ein
umsetzbarer Plan statt einer langen Wunschliste. Der Betriebsschutzbedarf aus Einheit 01 hilft beim
Priorisieren.

**EN:** **Step 4 – Set priorities.** Not everything can be closed at once. Rank open items by risk and effort:
what protects most at reasonable effort comes first. This turns the matrix into an actionable plan instead of
a long wish list. The operational protection need from unit 01 helps with prioritizing.

**DE:** **Typische Fehler.** Prüfen ohne festen Rahmen. „Alles grün" ohne Nachweis. Offene Punkte ohne
Priorität, sodass nichts vorankommt. `N/A` ohne Begründung. Die Presets nur nennen, aber nicht wirklich gegen
den eigenen Betrieb halten.

**EN:** **Common mistakes.** Checking without a fixed frame. "All green" without evidence. Open items without
priority, so nothing progresses. `N/A` without a rationale. Only naming the presets but not really holding
them against your own operation.

### Beispiel / Example

```text
Anforderung:     Secrets nie im Code               Preset: security-governance
Status:          erfüllt                            Nachweis: Secret-/Config-Matrix (Einheit 04)
Anforderung:     Restore getestet                   Preset: security-governance
Status:          Open  Prio: hoch                    Lücke: Recovery-Übung noch nicht durchgeführt
Anforderung:     A11Y der Betriebsdoku              Preset: a11y-governance
Status:          erfüllt                            Nachweis: Textform, kein reiner Farbcode
Anforderung:     voller SLSA-Reifegrad              Preset: security-governance
Status:          N/A  Begründung: kein produktiver Release-Pfad (Ausbildungsprojekt)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12b Kundenspezifische Systemintegration durchführen | Primär / Primary | Der Härtungscheck prüft die integrierte, betriebsfertige Lösung gegen verbindliche Vorgaben. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Prioritäten der Härtung leiten sich aus dem bewerteten Schutzbedarf ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Härtung, sichere Konfiguration, Preset-Konformität und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07` (sichere
Konfiguration), `CL_08` (Sicherheits-Review), `CL_09` (Supply-Chain/Umgebung), `CL_11` (Freigabe) und
`CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Härtungsaussage ist
belegt oder ehrlich als `Open`/`N/A` mit Priorität und Begründung dokumentiert.* A11Y-Aspekt: Die
Härtungsmatrix nutzt Text-Status statt Farbampeln, damit sie mit Screenreader und Braille-Zeile prüfbar
bleibt; das ist zugleich Gegenstand des `a11y-governance`-Presets.

**EN:** Relation to the Secure Development Guideline: hardening, secure configuration, preset conformity, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_07` (secure configuration),
`CL_08` (security review), `CL_09` (supply chain/environment), `CL_11` (approval), and `CL_12`
(documentation/N-A). The security decision of this unit is: *every hardening claim is evidenced or honestly
documented as `Open`/`N/A` with priority and rationale.* Accessibility aspect: the hardening matrix uses text
status instead of color traffic lights, so it stays reviewable with a screen reader and Braille display; this
is at the same time the subject of the `a11y-governance` preset.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Härtung im Betrieb? /
   **EN:** What does hardening mean in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein System bewusst widerstandsfähiger machen: Angriffsfläche verkleinern, sichere Defaults setzen,
   offene Lücken schließen. Härtung ist gezielte Verbesserung gegen bekannte Regeln, nicht zufälliges
   Optimieren.
   **EN:** Deliberately making a system more resilient: reduce the attack surface, set secure defaults, close
   open gaps. Hardening is targeted improvement against known rules, not random optimizing.

   </details>

2. **DE:** Wozu dient ein fester Prüfrahmen aus Richtlinie und Presets? /
   **EN:** What is a fixed check frame of guideline and presets for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er legt fest, was geprüft wird, und macht die Prüfung wiederholbar und vergleichbar. Ohne Rahmen
   prüft jeder etwas anderes, und Lücken werden übersehen.
   **EN:** It defines what is checked and makes the review repeatable and comparable. Without a frame everyone
   checks something different, and gaps are missed.

   </details>

3. **DE:** Warum steht ein Punkt ohne Nachweis auf `Open` statt „erledigt"? /
   **EN:** Why is an item without evidence set to `Open` instead of "done"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine positive Sicherheitsaussage gilt nur mit Beleg. Ohne Nachweis ist unklar, ob die Maßnahme
   wirklich greift. `Open` mit Folgeaktion ist ehrlich; „erledigt" ohne Beleg erzeugt falsche Sicherheit.
   **EN:** A positive security claim counts only with evidence. Without evidence it is unclear whether the
   measure really works. `Open` with a follow-up is honest; "done" without evidence creates false confidence.

   </details>

4. **DE:** (SI) Wie priorisierst du offene Härtungspunkte? /
   **EN:** (SI) How do you prioritize open hardening items?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nach Risiko und Aufwand: Was bei vertretbarem Aufwand den größten Schutz bringt, kommt zuerst. Der
   Schutzbedarf aus Einheit 01 hilft, das Risiko einzuschätzen. So entsteht ein umsetzbarer Plan.
   **EN:** By risk and effort: what brings the greatest protection at reasonable effort comes first. The
   protection need from unit 01 helps estimate the risk. This yields an actionable plan.

   </details>

5. **DE:** (SI) Welche Rolle spielt das `a11y-governance`-Preset in einem Betriebs-Härtungscheck? /
   **EN:** (SI) What role does the `a11y-governance` preset play in an operational hardening check?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es fordert, dass Betriebsartefakte (Doku, Dashboards, Statusanzeigen) barrierefrei sind: Textform,
   kein reiner Farbcode, mit Screenreader/Braille nutzbar. Härtung umfasst also auch die Zugänglichkeit der
   Nachweise.
   **EN:** It requires operational artifacts (docs, dashboards, status displays) to be accessible: text form,
   no color-only coding, usable with screen reader/Braille. Hardening therefore also covers the accessibility
   of the evidence.

   </details>

6. **DE:** (SI) Warum baut der Härtungscheck auf den Einheiten 01–08 auf? /
   **EN:** (SI) Why does the hardening check build on units 01–08?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Einheiten liefern die Einzelmaßnahmen und Nachweise (Secrets, Logging, Backup, Supply Chain).
   Der Härtungscheck prüft, ob sie zusammen den Regeln entsprechen, und bündelt offene Punkte mit Priorität.
   **EN:** The units provide the individual measures and evidence (secrets, logging, backup, supply chain).
   The hardening check verifies whether together they meet the rules and bundles open items with priority.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den Prüfrahmen aus Richtlinie und den sechs Presets benennen.
- [ ] eine Härtungsmatrix mit Status, Lücke, Priorität und Nachweis aufbauen.
- [ ] positive Aussagen nur mit Nachweis, sonst `Open`/`N/A` mit Begründung führen.
- [ ] offene Härtungspunkte nach Risiko und Aufwand priorisieren.
- [ ] die Rolle des `a11y-governance`-Presets für barrierefreie Betriebsartefakte erklären.

**EN:** I can …

- [ ] name the check frame of the guideline and the seven presets.
- [ ] build a hardening matrix with status, gap, priority, and evidence.
- [ ] keep positive claims only with evidence, else `Open`/`N/A` with a rationale.
- [ ] prioritize open hardening items by risk and effort.
- [ ] explain the role of the `a11y-governance` preset for accessible operational artifacts.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_09_Haertungscheck-gegen-Richtlinie-und-Presets.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_09_Haertungscheck-gegen-Richtlinie-und-Presets.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
