# Lernbegleiter: Secure CaseTracker v2 05 – Rollen- und Autorisierungsmatrix / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_05_Rollen-und-Autorisierungsmatrix.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Nicht jede Person darf alles. Eine Sachbearbeiterin darf Fälle anlegen und bearbeiten, eine
Leserolle darf nur schauen, eine Administration darf verwalten. Wer *was* darf, regelt die
**Autorisierung**. Man schreibt sie am besten als **Matrix**: Zeilen sind Rollen, Spalten sind Aktionen, und
in jeder Zelle steht erlaubt oder verboten. Der wichtigste Grundsatz heißt **Deny by default**: Was nicht
ausdrücklich erlaubt ist, ist verboten. So kann eine vergessene Regel niemals versehentlich zu viel öffnen.

**EN:** Not every person may do everything. A case worker may create and edit cases, a reader role may only
look, an administration may manage. Who may do *what* is governed by **authorization**. It is best written as
a **matrix**: rows are roles, columns are actions, and each cell says allowed or denied. The most important
principle is **deny by default**: what is not explicitly allowed is denied. This way a forgotten rule can
never accidentally open too much.

**DE:** In dieser Einheit modellierst du **Rollen**, **erlaubte** und **verbotene** Aktionen, **sichere
Defaults** und **Missbrauchsfälle** (was, wenn jemand mehr will, als er darf?). Zu jeder wichtigen Regel
gehört ein **Test**, der beweist, dass verbotene Aktionen wirklich abgelehnt werden.

**EN:** In this unit you model **roles**, **allowed** and **denied** actions, **safe defaults**, and **abuse
cases** (what if someone wants more than they may?). Every important rule needs a **test** proving that denied
actions are really rejected.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Autorisierung / Authorization | Entscheidung, ob eine bekannte Rolle eine Aktion ausführen darf. |
| Authentifizierung / Authentication | Feststellung, *wer* jemand ist (Vorstufe zur Autorisierung). |
| Rollenmatrix / Role matrix | Tabelle aus Rollen und Aktionen mit erlaubt/verboten je Zelle. |
| Deny by default / Deny by default | Grundsatz: alles verbieten, nur Erlaubtes ausdrücklich freigeben. |
| Least Privilege / Least privilege | Jede Rolle bekommt nur die minimal nötigen Rechte. |
| Missbrauchsfall / Abuse case | Szenario, in dem jemand mehr Rechte nutzen will, als vorgesehen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rollen und Aktionen benennen.** Liste die Rollen (z. B. Leser, Bearbeiter, Admin) und
alle sicherheitsrelevanten Aktionen (Fall anlegen, Status ändern, Notiz löschen, exportieren). **Warum
wichtig:** Nur klar benannte Rollen und Aktionen kann man in eine prüfbare Matrix bringen.

**EN:** **Step 1 – Name roles and actions.** List the roles (e.g. reader, editor, admin) and all
security-relevant actions (create case, change status, delete note, export). **Why it matters:** only clearly
named roles and actions can be put into a reviewable matrix.

**DE:** **Schritt 2 – Matrix mit Deny-by-default füllen.** Setze zuerst alle Zellen auf verboten und öffne
dann bewusst nur die erlaubten. Halte dich an **Least Privilege**: im Zweifel weniger Rechte. **Warum
wichtig:** Beginnt man mit „alles erlaubt“ und verbietet einzeln, öffnet eine vergessene Zelle zu viel. Deny
by default dreht das Risiko um.

**EN:** **Step 2 – Fill the matrix with deny-by-default.** First set all cells to denied and then deliberately
open only the allowed ones. Follow **least privilege**: when in doubt, fewer rights. **Why it matters:** if
you start with "everything allowed" and deny individually, a forgotten cell opens too much. Deny by default
reverses the risk.

**DE:** **Schritt 3 – Missbrauchsfälle durchdenken.** Frage bei jeder Aktion: *Was, wenn eine schwächere
Rolle sie doch versucht?* Beispiel: Ein Leser ruft direkt die Export-Operation auf. Die Antwort muss ein
klares Verbot sein, geprüft an der Vertrauensgrenze, nicht nur im Menü versteckt. **Warum wichtig:** Rechte,
die man nur im Menü ausblendet, lassen sich über die API oder CLI umgehen.

**EN:** **Step 3 – Think through abuse cases.** Ask for every action: *what if a weaker role still tries it?*
Example: a reader calls the export operation directly. The answer must be a clear denial, checked at the trust
boundary, not just hidden in the menu. **Why it matters:** rights that are only hidden in the menu can be
bypassed via the API or CLI.

**DE:** **Schritt 4 – Autorisierung von Authentifizierung trennen.** Erst *wer bist du* (Authentifizierung),
dann *darfst du das* (Autorisierung). Die Autorisierung gehört als Querschnitt (Separation of Concerns) an
eine zentrale Stelle, nicht verstreut in jede Funktion. **Warum wichtig:** Verstreute Prüfungen werden
widersprüchlich; eine zentrale Stelle bleibt konsistent und testbar.

**EN:** **Step 4 – Separate authorization from authentication.** First *who are you* (authentication), then
*may you do this* (authorization). Authorization belongs as a cross-cutting concern in one central place, not
scattered into every function. **Why it matters:** scattered checks become inconsistent; a central place stays
consistent and testable.

**DE:** **Typische Fehler.** Mit „alles erlaubt“ starten. Rechte nur im Menü verstecken. Autorisierung in
jede Funktion einzeln streuen. Missbrauchsfälle nicht testen. Eine „Super-Rolle“, die alles darf, ohne
Begründung.

**EN:** **Common mistakes.** Starting with "everything allowed". Hiding rights only in the menu. Scattering
authorization into every function. Not testing abuse cases. A "super role" that may do everything without
justification.

### Beispiel / Example

```text
Rollenmatrix (Auszug; Standard = verboten):

  Aktion \ Rolle     Leser     Bearbeiter   Admin
  Fall lesen         erlaubt   erlaubt      erlaubt
  Fall anlegen       verboten  erlaubt      erlaubt
  Status aendern     verboten  erlaubt      erlaubt
  Notiz loeschen     verboten  verboten     erlaubt
  Exportieren        verboten  verboten     erlaubt

Missbrauchsfall: Leser ruft "Exportieren" direkt ueber die API
  Erwartung: Ablehnung an der Vertrauensgrenze (nicht nur Menue ausblenden)
  Test:      als Leser Export aufrufen -> erwarte "verboten" + Audit-Eintrag
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Zugangssteuerung mit sicheren Defaults ist die praktische Schutzmaßnahme aus der Schutzbedarfsanalyse. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Rechtematrix bestimmt, wer die datenverwaltende Software wie verändern darf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Least Privilege, Fail-safe-Defaults und
auditfähige Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere Architektur),
`CL_05` (Zugangssteuerung/Autorisierung), `CL_08` (Sicherheits-Code-Review) und `CL_12`
(Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Deny by default – was nicht
ausdrücklich erlaubt ist, ist verboten, und das wird geprüft.* A11Y-Aspekt: Die Matrix muss als reine
Text-Tabelle lesbar sein; erlaubt/verboten darf nicht nur durch Farbe, sondern durch Wörter erkennbar sein,
damit sie mit Screenreader und Braille-Zeile funktioniert.

**EN:** Relation to the Secure Development Guideline: secure architecture, least privilege, fail-safe defaults,
and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture),
`CL_05` (access control / authorization), `CL_08` (security code review), and `CL_12` (evidence / N/A
rationale). The security decision of this unit is: *deny by default – what is not explicitly allowed is
denied, and this is checked.* Accessibility aspect: the matrix must be readable as a plain text table;
allowed/denied must be recognizable by words, not only by color, so it works with a screen reader and Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Deny by default, und warum ist es sicherer als „alles erlaubt, einzeln verbieten“? /
   **EN:** What does deny by default mean, and why is it safer than "allow all, deny individually"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Alle Zellen sind zuerst verboten; nur Erlaubtes wird bewusst geöffnet. Eine vergessene Regel bleibt
   dann sicher (verboten), statt versehentlich zu viel zu öffnen.
   **EN:** All cells are denied first; only allowed ones are deliberately opened. A forgotten rule then stays
   safe (denied) instead of accidentally opening too much.

   </details>

2. **DE:** Wie hängen Authentifizierung und Autorisierung zusammen? /
   **EN:** How are authentication and authorization related?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Authentifizierung klärt, *wer* jemand ist; Autorisierung klärt, *ob* diese Rolle eine Aktion darf.
   Erst identifizieren, dann Rechte prüfen.
   **EN:** Authentication establishes *who* someone is; authorization establishes *whether* that role may do an
   action. First identify, then check rights.

   </details>

3. **DE:** (SI) Warum reicht es nicht, eine Aktion nur im Menü auszublenden? /
   **EN:** (SI) Why is it not enough to only hide an action in the menu?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Oberfläche lässt sich umgehen (API, CLI). Die Rechteprüfung muss an der Vertrauensgrenze im
   Backend liegen, nicht nur in der Anzeige.
   **EN:** The UI can be bypassed (API, CLI). The rights check must live at the trust boundary in the backend,
   not only in the display.

   </details>

4. **DE:** (AE) Warum gehört die Autorisierung zentral statt in jede Funktion verstreut? /
   **EN:** (AE) Why should authorization be central instead of scattered into every function?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine zentrale Stelle (Cross-Cutting Concern) bleibt konsistent, testbar und leicht änderbar.
   Verstreute Prüfungen werden schnell widersprüchlich oder unvollständig.
   **EN:** A central place (cross-cutting concern) stays consistent, testable, and easy to change. Scattered
   checks quickly become inconsistent or incomplete.

   </details>

5. **DE:** Was ist ein Missbrauchsfall, und wie prüft man ihn? /
   **EN:** What is an abuse case, and how do you test it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Szenario, in dem eine schwächere Rolle eine verbotene Aktion versucht. Man prüft mit einem Test,
   dass die Aktion abgelehnt und protokolliert wird.
   **EN:** A scenario in which a weaker role attempts a denied action. You test that the action is rejected and
   logged.

   </details>

6. **DE:** (DPA) Wie schützt eine Rechtematrix personenbezogene Daten wie Fallnotizen? /
   **EN:** (DPA) How does a role matrix protect personal data such as case notes?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie begrenzt Lese- und Exportrechte auf berechtigte Rollen (Least Privilege). So sehen weniger
   Personen sensible Daten, was das Datenschutzrisiko senkt.
   **EN:** It limits read and export rights to authorized roles (least privilege). Fewer people then see
   sensitive data, which lowers the privacy risk.

   </details>

7. **DE:** Warum sollte eine „Super-Rolle“, die alles darf, begründet und dokumentiert werden? /
   **EN:** Why should a "super role" that may do everything be justified and documented?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Rolle mit allen Rechten verletzt Least Privilege und ist ein hohes Risiko. Sie braucht eine
   ausdrückliche Begründung, enge Nutzung und Audit-Nachweis.
   **EN:** A role with all rights violates least privilege and is a high risk. It needs an explicit rationale,
   narrow use, and audit evidence.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Rollen und sicherheitsrelevante Aktionen benennen.
- [ ] eine Rechtematrix nach Deny-by-default aufstellen.
- [ ] Autorisierung von Authentifizierung unterscheiden.
- [ ] Missbrauchsfälle beschreiben und je Fall einen Test angeben.
- [ ] Least Privilege für jede Rolle begründen.

**EN:** I can …

- [ ] name roles and security-relevant actions.
- [ ] build a role matrix following deny-by-default.
- [ ] distinguish authorization from authentication.
- [ ] describe abuse cases and give a test per case.
- [ ] justify least privilege for each role.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_05_Rollen-und-Autorisierungsmatrix.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_05_Rollen-und-Autorisierungsmatrix.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
