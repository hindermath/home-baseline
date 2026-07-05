# Lernbegleiter: Secure CaseTracker Application Track 04 – Rollen, Rechte und sichere Feature-Gates / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_04_Rollen-Rechte-und-sichere-Feature-Gates.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Nicht jede Person darf alles. Eine Sachbearbeiterin darf Fälle bearbeiten, aber vielleicht keine Fälle
löschen; eine Leitung darf mehr. Diese Steuerung heißt **Autorisierung**: Wer darf welche Aktion ausführen?
Ein **Feature-Gate** ist ein Tor vor einer Funktion, das nur bei ausreichendem Recht öffnet. In dieser Einheit
lernst du, Rollen und Rechte in einer klaren **Rechtematrix** zu ordnen, **sichere Defaults** zu setzen (im
Zweifel verbieten) und **Missbrauchsfälle** durchzuspielen. Bild dazu: eine Schlüsselkarte im Gebäude. Sie
öffnet nur die Türen, für die man freigeschaltet ist – und der Standardzustand einer Tür ist „verschlossen".

**EN:** Not everyone may do everything. A case worker may edit cases but perhaps not delete them; a manager may
do more. This control is called **authorization**: who may perform which action? A **feature gate** is a gate
in front of a function that only opens with sufficient rights. In this unit you learn to organize roles and
rights in a clear **rights matrix**, to set **secure defaults** (deny when in doubt), and to play through
**abuse cases**. The picture: a key card in a building. It only opens the doors you are cleared for – and a
door's default state is "locked".

**DE:** Wichtig ist der Unterschied zwischen **Authentifizierung** (Wer bist du?) und **Autorisierung** (Was
darfst du?). Ein Feature-Gate darf sich nie darauf verlassen, dass die Oberfläche einen Knopf ausblendet.

**EN:** Important is the difference between **authentication** (Who are you?) and **authorization** (What may
you do?). A feature gate must never rely on the interface hiding a button.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Authentifizierung / Authentication | Nachweis, wer jemand ist. |
| Autorisierung / Authorization | Entscheidung, was jemand tun darf. |
| Rolle / Role | Bündel von Rechten, das Personen zugewiesen wird. |
| Rechtematrix / Rights matrix | Tabelle: Rolle mal Aktion mit erlaubt/verboten. |
| Sichere Defaults / Secure defaults | Grundregel „standardmäßig verboten, explizit erlaubt". |
| Feature-Gate / Feature gate | Prüfstelle, die eine Funktion nur bei ausreichendem Recht freigibt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rollen und Aktionen sammeln.** Liste die Rollen (z. B. Sachbearbeitung, Leitung,
Lesezugriff) und die schützenswerten Aktionen (Fall anlegen, ändern, schließen, löschen, exportieren). Ohne
diese Liste kannst du keine Rechte sauber zuordnen.

**EN:** **Step 1 – Collect roles and actions.** List the roles (e.g. case worker, manager, read-only) and the
protected actions (create, edit, close, delete, export a case). Without this list you cannot assign rights
cleanly.

**DE:** **Schritt 2 – Rechtematrix bauen.** Trage in eine Tabelle ein, welche Rolle welche Aktion darf. Der
Standardwert ist **verboten**; jede Erlaubnis ist eine bewusste Eintragung. Warum? Vergisst man eine Zelle,
soll das System sicher sein (verbieten), nicht unsicher (erlauben).

**EN:** **Step 2 – Build the rights matrix.** Enter in a table which role may perform which action. The default
value is **deny**; every permission is a deliberate entry. Why? If you forget a cell, the system should be safe
(deny), not unsafe (allow).

**DE:** **Schritt 3 – Gate serverseitig prüfen.** Das Feature-Gate muss dort prüfen, wo die Aktion wirklich
ausgeführt wird – in der Kernlogik oder serverseitig, nicht nur in der Oberfläche. Ein ausgeblendeter Knopf ist
Komfort, kein Schutz: Direkte Aufrufe umgehen ihn.

**EN:** **Step 3 – Check the gate server-side.** The feature gate must check where the action is really
performed – in the core logic or server-side, not only in the UI. A hidden button is convenience, not
protection: direct calls bypass it.

**DE:** **Schritt 4 – Missbrauchsfälle durchspielen.** Frage aktiv: „Was, wenn jemand ohne Recht die Aktion
direkt aufruft?", „Was, wenn eine Rolle nachträglich entzogen wird?" Dokumentiere je Missbrauchsfall die
erwartete sichere Reaktion und einen Reviewpfad.

**EN:** **Step 4 – Play through abuse cases.** Actively ask: "What if someone without rights calls the action
directly?", "What if a role is revoked afterwards?" Document per abuse case the expected safe reaction and a
review path.

**DE:** **Typische Fehler.** Nur die Oberfläche schützen. Standard auf „erlauben" setzen. Rechte im Code
verstreuen statt zentral zu prüfen. Rollen zu grob schneiden, sodass jemand mehr darf als nötig (Verstoß gegen
Least Privilege). Missbrauchsfälle nicht dokumentieren.

**EN:** **Common mistakes.** Protecting only the UI. Setting the default to "allow". Scattering rights across
the code instead of checking centrally. Cutting roles too coarsely, so someone may do more than needed (a
violation of least privilege). Not documenting abuse cases.

### Beispiel / Example

```text
Rechtematrix (Auszug), Standard = VERBOTEN
Aktion          | Lesezugriff | Sachbearbeitung | Leitung
Fall ansehen    | erlaubt     | erlaubt         | erlaubt
Fall bearbeiten | verboten    | erlaubt         | erlaubt
Fall löschen    | verboten    | verboten        | erlaubt
Export          | verboten    | verboten        | erlaubt

Missbrauchsfall: Sachbearbeitung ruft "Fall löschen" direkt über die API auf.
  Erwartete sichere Reaktion: 403 NOT_ALLOWED, keine Löschung, Ereignis protokolliert.
  Reviewpfad: Autorisierungstest + Sicherheits-Code-Review (CL_08).
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Feature-Gates und Rechteprüfung sind Funktionalität, die serverseitig sicher realisiert wird. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Rollen, Rechte und sichere Defaults sind konkrete Schutzmaßnahmen aus der Schutzbedarfsanalyse. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Zugangssteuerung, Least Privilege und Fail-Safe-Defaults.
Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und `CL_10`
(Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser Einheit lautet: *Standardmäßig verboten,
serverseitig geprüft, jede Erlaubnis bewusst vergeben.* A11Y-Aspekt: „Kein Zugriff" muss als klarer Text
erscheinen (z. B. „Aktion nicht erlaubt"), nicht nur durch einen ausgegrauten Button oder eine Farbe – so
bleibt der Zustand für Screenreader und Braille-Zeile erkennbar.

**EN:** Relation to the Secure Development Guideline: access control, least privilege, and fail-safe defaults.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_10` (secure
development environment). The security decision of this unit is: *deny by default, checked server-side, every
permission granted deliberately.* Accessibility aspect: "no access" must appear as clear text (e.g. "action not
allowed"), not only as a greyed-out button or a color – so the state stays recognizable for a screen reader and
Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist der Unterschied zwischen Authentifizierung und Autorisierung? /
   **EN:** What is the difference between authentication and authorization?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Authentifizierung klärt, *wer* jemand ist; Autorisierung klärt, *was* diese Person tun darf. Beide
   sind nötig, aber sie beantworten verschiedene Fragen.
   **EN:** Authentication establishes *who* someone is; authorization establishes *what* that person may do.
   Both are needed, but they answer different questions.

   </details>

2. **DE:** Warum ist „standardmäßig verboten" sicherer als „standardmäßig erlaubt"? /
   **EN:** Why is "deny by default" safer than "allow by default"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Vergisst man eine Regel, führt „verboten" zu einem sicheren Zustand, „erlaubt" zu einer Lücke. Die
   Grundeinstellung entscheidet, wie ein System bei Lücken reagiert.
   **EN:** If a rule is forgotten, "deny" leads to a safe state, "allow" to a gap. The default decides how a
   system reacts to gaps.

   </details>

3. **DE:** Warum reicht es nicht, einen Knopf in der Oberfläche auszublenden? /
   **EN:** Why is hiding a button in the UI not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Oberfläche lässt sich über direkte API- oder CLI-Aufrufe umgehen. Die verbindliche Prüfung muss
   dort liegen, wo die Aktion ausgeführt wird.
   **EN:** The UI can be bypassed via direct API or CLI calls. The binding check must be where the action is
   performed.

   </details>

4. **DE:** Was bedeutet Least Privilege für den Schnitt der Rollen? /
   **EN:** What does least privilege mean for how roles are cut?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Rolle bekommt nur die Rechte, die für ihre Aufgabe nötig sind – nicht mehr. Zu grobe Rollen
   geben unnötige Rechte und vergrößern die Angriffsfläche.
   **EN:** Each role gets only the rights needed for its task – no more. Overly coarse roles grant unnecessary
   rights and enlarge the attack surface.

   </details>

5. **DE:** Warum spielst du Missbrauchsfälle bewusst durch? /
   **EN:** Why do you deliberately play through abuse cases?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie zeigen, ob das Gate auch bei absichtlichem Umgehen sicher reagiert. Nur Positivfälle beweisen
   nicht, dass der Schutz greift.
   **EN:** They show whether the gate reacts safely even under deliberate bypass. Positive cases alone do not
   prove the protection works.

   </details>

6. **DE:** Wie zeigt sich eine verweigerte Aktion barrierefrei? /
   **EN:** How is a denied action shown accessibly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als klarer, textbasierter Hinweis („Aktion nicht erlaubt"), nicht allein durch Farbe oder einen
   ausgegrauten Zustand. So bleibt er mit Screenreader und Braille-Zeile erkennbar.
   **EN:** As a clear, text-based note ("action not allowed"), not by color or a greyed-out state alone. This
   keeps it recognizable with a screen reader and Braille display.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Rollen und schützenswerte Aktionen auflisten.
- [ ] eine Rechtematrix mit Standard „verboten" erstellen.
- [ ] erklären, warum das Gate serverseitig prüfen muss.
- [ ] Missbrauchsfälle mit erwarteter sicherer Reaktion notieren.
- [ ] eine verweigerte Aktion barrierefrei und ohne Interna melden.

**EN:** I can …

- [ ] list roles and protected actions.
- [ ] create a rights matrix with "deny" as default.
- [ ] explain why the gate must check server-side.
- [ ] note abuse cases with the expected safe reaction.
- [ ] report a denied action accessibly and without internals.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_04_Rollen-Rechte-und-sichere-Feature-Gates.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_04_Rollen-Rechte-und-sichere-Feature-Gates.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
