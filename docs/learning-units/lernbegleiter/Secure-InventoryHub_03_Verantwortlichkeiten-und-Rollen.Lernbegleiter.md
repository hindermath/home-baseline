# Lernbegleiter: Secure InventoryHub 03 – Verantwortlichkeiten und Rollen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_03_Verantwortlichkeiten-und-Rollen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In einem Inventar dürfen nicht alle Personen alles tun. Wer ein Asset ausmustert, wer Software-Daten
ändert und wer nur lesen darf, muss klar geregelt sein. Rollen bündeln Rechte: Ein **asset-owner** pflegt
seine Geräte, ein **operator** betreibt das System, ein **auditor** prüft ohne zu ändern, ein **learner**
lernt mit eingeschränkten Rechten. Der Grundsatz lautet: **so wenig Rechte wie möglich** (Least Privilege) und
**im Zweifel verweigern** (Deny by default). So verhindert man versehentliche und absichtliche
Fehlbedienungen.

**EN:** In an inventory, not everyone may do everything. Who retires an asset, who changes software data, and
who may only read must be clearly regulated. Roles bundle rights: an **asset-owner** maintains their devices,
an **operator** runs the system, an **auditor** checks without changing, a **learner** learns with restricted
rights. The principle is: **as few rights as possible** (least privilege) and **when in doubt, deny** (deny by
default). This prevents accidental and deliberate misuse.

**DE:** In dieser Einheit lernst du, sinnvolle Rollen zu benennen, ihnen erlaubte Aktionen zuzuordnen,
verbotene Aktionen ausdrücklich zu nennen und sichere Standardrechte festzulegen.

**EN:** In this unit you learn to name meaningful roles, assign them allowed actions, explicitly state
forbidden actions, and define safe default rights.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Rolle / Role | Bündel von Rechten für eine bestimmte Aufgabe, z. B. asset-owner. |
| Berechtigung / Permission | Recht, eine bestimmte Aktion auszuführen (lesen, ändern, löschen). |
| Least Privilege / Least privilege | Jede Rolle erhält nur die minimal nötigen Rechte. |
| Deny by default / Deny by default | Was nicht ausdrücklich erlaubt ist, ist verboten. |
| Rollenmatrix / Role matrix | Tabelle, die Rollen und erlaubte Aktionen gegenüberstellt. |
| Verantwortlichkeit / Accountability | Zuordnung, wer für welche Daten oder Aktion verantwortlich ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rollen benennen.** Bestimme die nötigen Rollen aus den Aufgaben, nicht aus einzelnen
Personen. Beispiele: `asset-owner`, `operator`, `auditor`, `learner`. Rollen bleiben stabil, auch wenn
Personen wechseln. So bleibt die Zuordnung wartbar.

**EN:** **Step 1 – Name the roles.** Determine the needed roles from tasks, not from individual people.
Examples: `asset-owner`, `operator`, `auditor`, `learner`. Roles stay stable even when people change. This
keeps the assignment maintainable.

**DE:** **Schritt 2 – Aktionen je Rolle zuordnen.** Lege für jede Rolle fest, welche Aktionen erlaubt sind:
lesen, anlegen, ändern, löschen, exportieren. Ein `auditor` darf lesen, aber nichts ändern. Ein `learner`
darf in einer Übung lesen und begrenzt anlegen, aber nichts ausmustern. Diese Zuordnung ergibt die
**Rollenmatrix**.

**EN:** **Step 2 – Assign actions per role.** For each role, define which actions are allowed: read, create,
change, delete, export. An `auditor` may read but change nothing. A `learner` may read and create in a limited
way during an exercise but not retire anything. This assignment forms the **role matrix**.

**DE:** **Schritt 3 – Verbotene Aktionen ausdrücklich nennen.** Es reicht nicht, nur Erlaubtes aufzulisten.
Nenne wichtige Verbote klar, z. B. „Ein `operator` darf keine Audit-Logs löschen." Ausdrückliche Verbote
machen Grenzen sichtbar und prüfbar.

**EN:** **Step 3 – Explicitly state forbidden actions.** Listing only what is allowed is not enough. State
important prohibitions clearly, e.g. "An `operator` may not delete audit logs." Explicit prohibitions make
boundaries visible and verifiable.

**DE:** **Schritt 4 – Sichere Defaults festlegen.** Der Standard muss **Deny by default** sein: Eine neue
Rolle oder eine unbekannte Aktion ist zunächst verboten und wird nur bei Bedarf ausdrücklich erlaubt. Warum?
Wer im Zweifel erlaubt, öffnet unbemerkt Rechte. Wer im Zweifel verweigert, bleibt sicher und ergänzt Rechte
bewusst.

**EN:** **Step 4 – Define safe defaults.** The default must be **deny by default**: a new role or an unknown
action is initially forbidden and only explicitly allowed when needed. Why? Whoever allows in doubt silently
opens rights. Whoever denies in doubt stays safe and adds rights deliberately.

**DE:** **Typische Fehler.** Rechte an Personen statt an Rollen hängen. Nur Erlaubtes auflisten, Verbote
vergessen. Standard auf „alles erlaubt" setzen. Prüfrolle (`auditor`) versehentlich Schreibrechte geben.
Rollen zu grob schneiden, sodass fast jeder fast alles darf.

**EN:** **Common mistakes.** Attaching rights to people instead of roles. Listing only what is allowed,
forgetting prohibitions. Setting the default to "allow everything". Accidentally giving the audit role
(`auditor`) write access. Cutting roles too coarsely so that almost everyone may do almost everything.

### Beispiel / Example

```text
Rollenmatrix (Auszug):
Aktion            | asset-owner | operator | auditor | learner
------------------|-------------|----------|---------|--------
Assets lesen      |     ja      |    ja    |   ja    |   ja
Asset ändern      |     ja      |    ja    |  nein   |  nein
Asset ausmustern  |     ja      |   nein   |  nein   |  nein
Audit-Log lesen   |    nein     |   nein   |   ja    |  nein
Audit-Log löschen |    nein     |   nein   |  nein   |  nein   (fuer niemanden erlaubt)

Default:          Deny by default -> unbekannte Aktion / neue Rolle = verboten
Verbot explizit:  "operator darf keine Audit-Logs löschen"
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Zugangssteuerung und sichere Defaults sind konkrete Schutzmaßnahmen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Rollen bestimmen, wer die verwalteten Daten wie verändern darf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Zugangssteuerung, Least Privilege und sichere Defaults.
Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (Zugangssteuerung), `CL_05`
(Autorisierung/Rollen), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise). Die
Sicherheitsentscheidung dieser Einheit lautet: *Rechte werden minimal vergeben, und was nicht ausdrücklich
erlaubt ist, bleibt verboten.* A11Y-Aspekt: Die Rollenmatrix muss als Text-Tabelle lesbar sein und darf
Erlaubnis/Verbot nicht nur über Farbe zeigen, damit sie mit Screenreader oder Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: access control, least privilege, and safe defaults.
Matching checklists: `CL_01` (standards applicability), `CL_03` (access control), `CL_05`
(authorization/roles), `CL_08` (security code review), and `CL_12` (evidence). The security decision of this
unit is: *rights are granted minimally, and what is not explicitly allowed stays forbidden.* Accessibility
aspect: the role matrix must be readable as a text table and must not show allow/deny by color only, so it
stays usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum werden Rechte an Rollen und nicht an einzelne Personen gebunden? /
   **EN:** Why are rights bound to roles and not to individual people?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Rollen bleiben stabil, wenn Personen wechseln. Man ändert nur die Zuordnung Person→Rolle, nicht
   jede einzelne Berechtigung. Das ist wartbar und weniger fehleranfällig.
   **EN:** Roles stay stable when people change. You only change the person→role assignment, not each single
   permission. This is maintainable and less error-prone.

   </details>

2. **DE:** Was bedeutet Least Privilege? /
   **EN:** What does least privilege mean?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Rolle erhält nur die minimal nötigen Rechte für ihre Aufgabe. So bleibt der Schaden gering,
   falls ein Konto missbraucht wird.
   **EN:** Each role gets only the minimum rights needed for its task. This keeps the damage small if an
   account is misused.

   </details>

3. **DE:** Was bedeutet Deny by default, und warum ist es sicherer? /
   **EN:** What does deny by default mean, and why is it safer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Was nicht ausdrücklich erlaubt ist, ist verboten. Neue oder unbekannte Aktionen sind automatisch
   gesperrt. So entstehen keine ungewollten Rechte durch Vergessen.
   **EN:** What is not explicitly allowed is forbidden. New or unknown actions are automatically blocked. This
   prevents unintended rights through omission.

   </details>

4. **DE:** Warum darf ein auditor keine Schreibrechte haben? /
   **EN:** Why must an auditor have no write access?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Prüfer muss unabhängig bleiben. Könnte er Daten ändern, wäre die Prüfung nicht mehr
   vertrauenswürdig, und Manipulationen ließen sich verdecken.
   **EN:** An auditor must stay independent. If they could change data, the audit would no longer be
   trustworthy, and manipulation could be hidden.

   </details>

5. **DE:** Wozu dient es, verbotene Aktionen ausdrücklich zu nennen? /
   **EN:** What is the purpose of explicitly stating forbidden actions?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ausdrückliche Verbote machen Grenzen sichtbar und prüfbar. Man kann sie testen und im Review gezielt
   kontrollieren, statt sie nur zu vermuten.
   **EN:** Explicit prohibitions make boundaries visible and verifiable. They can be tested and specifically
   checked in a review instead of only being assumed.

   </details>

6. **DE:** (SI) Warum sollte das Löschen von Audit-Logs für niemanden über die normale Rolle erlaubt sein? /
   **EN:** (SI) Why should deleting audit logs be allowed for no one via the normal role?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Audit-Logs belegen, was passiert ist. Wäre ihr Löschen normal erlaubt, könnte man Spuren verwischen.
   Solche Aktionen brauchen besondere, getrennte Kontrolle statt einer Standardberechtigung.
   **EN:** Audit logs prove what happened. If deleting them were normally allowed, traces could be erased. Such
   actions need special, separate control instead of a standard permission.

   </details>

7. **DE:** Was passiert, wenn Rollen zu grob geschnitten sind? /
   **EN:** What happens if roles are cut too coarsely?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fast jeder darf fast alles, wodurch Least Privilege verletzt wird. Fehler und Missbrauch haben dann
   große Wirkung. Rollen sollten so fein wie nötig geschnitten sein.
   **EN:** Almost everyone may do almost everything, which violates least privilege. Errors and misuse then
   have large impact. Roles should be cut as finely as necessary.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] sinnvolle Rollen aus Aufgaben ableiten.
- [ ] eine Rollenmatrix mit erlaubten Aktionen aufstellen.
- [ ] wichtige verbotene Aktionen ausdrücklich benennen.
- [ ] Deny by default als sicheren Standard erklären.
- [ ] Least Privilege an einem Beispiel begründen.

**EN:** I can …

- [ ] derive meaningful roles from tasks.
- [ ] build a role matrix with allowed actions.
- [ ] explicitly name important forbidden actions.
- [ ] explain deny by default as a safe default.
- [ ] justify least privilege with an example.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_03_Verantwortlichkeiten-und-Rollen.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_03_Verantwortlichkeiten-und-Rollen.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
