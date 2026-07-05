# Lernbegleiter: Secure CaseTracker Application Track 03 – API-Versionierung und Kompatibilität / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_03_API-Versionierung-und-Kompatibilitaet.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Sobald eine Anwendung eine **Programmierschnittstelle** (API) anbietet, verlassen sich andere
Programme darauf. Ändert man die API unbedacht, brechen diese anderen Programme – oft ohne Vorwarnung. Eine
API ist ein **Vertrag**: Wer ihn ändert, muss die Folgen für die Nutzer bedenken. In dieser Einheit lernst
du, Änderungen in **abwärtskompatibel** (alte Nutzer arbeiten weiter) und **brechend** (breaking) zu
unterscheiden, sinnvoll zu **versionieren** und einen klaren **Fehlervertrag** festzulegen. Das Bild dazu: Ein
Vertrag mit einem Kunden. Kleine Ergänzungen sind erlaubt, aber man streicht keine zugesagte Leistung ohne
Ankündigung und Übergangsfrist.

**EN:** As soon as an application offers a **programming interface** (API), other programs rely on it. If you
change the API carelessly, those programs break – often without warning. An API is a **contract**: whoever
changes it must consider the consequences for its users. In this unit you learn to distinguish
**backward-compatible** changes (old users keep working) from **breaking** changes, to **version** sensibly,
and to define a clear **error contract**. The picture: a contract with a customer. Small additions are
allowed, but you do not remove a promised service without announcement and a transition period.

**DE:** Du lernst außerdem, Migrationspfade zu planen, damit ein Wechsel für die Nutzer geordnet und sicher
verläuft.

**EN:** You also learn to plan migration paths so that a switch is orderly and safe for the users.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| API-Vertrag / API contract | Verbindliche Zusage über Ein-/Ausgaben und Verhalten der Schnittstelle. |
| Abwärtskompatibel / Backward-compatible | Änderung, bei der bestehende Aufrufe weiter funktionieren. |
| Breaking Change / Breaking change | Änderung, die bestehende Aufrufe kaputt macht; braucht neue Version. |
| Versionierung / Versioning | Kennzeichnung von Ständen, z. B. `v1`, `v2`, damit Nutzer stabil bleiben. |
| Fehlervertrag / Error contract | Feste Regeln, welche Fehler mit welchem Code und welcher Bedeutung kommen. |
| Migrationspfad / Migration path | Geplanter Weg von alter zu neuer Version mit Übergangsfrist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Vertrag benennen.** Beschreibe je Endpunkt die Eingaben, Ausgaben, erlaubten Werte und
das erwartete Verhalten. Was nicht im Vertrag steht, dürfen Nutzer nicht voraussetzen – und du darfst es nicht
still zusichern.

**EN:** **Step 1 – Name the contract.** Describe per endpoint the inputs, outputs, allowed values, and expected
behavior. What is not in the contract, users may not assume – and you must not silently promise it.

**DE:** **Schritt 2 – Änderungsart bestimmen.** Additiv (neues optionales Feld) ist meist abwärtskompatibel.
Das Entfernen oder Umdeuten eines Feldes ist ein Breaking Change. Warum ist das wichtig? Ein Breaking Change
ohne neue Version bricht bestehende Nutzer ohne Vorwarnung.

**EN:** **Step 2 – Determine the change type.** Additive (a new optional field) is usually backward-compatible.
Removing or reinterpreting a field is a breaking change. Why does this matter? A breaking change without a new
version breaks existing users without warning.

**DE:** **Schritt 3 – Versionieren und Migrationspfad planen.** Führe brechende Änderungen als neue Version
(`v2`) ein und lasse die alte Version für eine angekündigte Übergangsfrist parallel laufen. So können Nutzer
geordnet wechseln, statt schlagartig auszufallen.

**EN:** **Step 3 – Version and plan the migration path.** Introduce breaking changes as a new version (`v2`)
and keep the old version running in parallel for an announced transition period. This lets users switch in an
orderly way instead of failing suddenly.

**DE:** **Schritt 4 – Fehlervertrag festlegen.** Definiere, welche Fehler mit welchem Code und welcher
Bedeutung zurückkommen – und dass Fehlermeldungen keine internen Details verraten. Ein stabiler Fehlervertrag
ist Teil der Kompatibilität: Nutzer verlassen sich auch auf das Fehlerverhalten.

**EN:** **Step 4 – Define the error contract.** Define which errors return which code and meaning – and that
error messages reveal no internal details. A stable error contract is part of compatibility: users also rely
on the error behavior.

**DE:** **Typische Fehler.** Felder still umdeuten. Breaking Changes ohne neue Version einführen. Keine
Übergangsfrist geben. Fehlercodes je Release ändern. Interne Details in Fehlermeldungen zeigen. Keine
Kompatibilitätstests, die alte Aufrufe gegen die neue Version prüfen.

**EN:** **Common mistakes.** Silently reinterpreting fields. Introducing breaking changes without a new
version. Giving no transition period. Changing error codes per release. Showing internal details in error
messages. No compatibility tests that check old calls against the new version.

### Beispiel / Example

```text
Änderung A: Neues optionales Feld "priority" (Standard: normal)
  -> abwärtskompatibel, keine neue Version nötig, alte Aufrufe funktionieren weiter.

Änderung B: Feld "status" umbenannt und Werteliste geändert
  -> Breaking Change -> API v2, v1 bleibt 6 Monate parallel (angekündigt).

Fehlervertrag (Auszug)
  400 VALIDATION_FAILED  -> "Ungültige Eingabe: <Feld> erlaubt ..."   (keine internen Pfade)
  403 NOT_ALLOWED        -> "Aktion nicht erlaubt."
  404 CASE_NOT_FOUND     -> "Fall nicht gefunden."
Kompatibilitätstest: v1-Aufruf gegen v2-Endpunkt -> erwartetes Verhalten dokumentiert.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Der API-Vertrag legt fest, wie Funktionalität stabil und kompatibel nach außen realisiert wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Versionierung und Migrationspfade betreffen, wie verwaltete Daten über Änderungen hinweg zugänglich bleiben. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Schnittstellen, sichere Fehlerbehandlung und
Kompatibilität als Betriebsschutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser
Einheit lautet: *Änderungen an der API sind versioniert, angekündigt und der Fehlervertrag verrät keine
Interna.* A11Y-Aspekt: Der Fehlervertrag ist als Texttabelle mit Code, Bedeutung und nutzerlesbarer Meldung
formuliert; die Bedeutung eines Fehlers darf nicht allein über Farbe oder ein Symbol transportiert werden.

**EN:** Relation to the Secure Development Guideline: secure interfaces, safe error handling, and compatibility
as operational protection. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code
review), and `CL_10` (secure development environment). The security decision of this unit is: *API changes are
versioned, announced, and the error contract reveals no internals.* Accessibility aspect: the error contract is
written as a text table with code, meaning, and a user-readable message; the meaning of an error must not be
carried by color or a symbol alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine API ein Vertrag und keine reine technische Funktion? /
   **EN:** Why is an API a contract and not just a technical function?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil andere Programme sich auf ihr Verhalten verlassen. Eine Änderung wirkt nicht nur intern,
   sondern trifft alle Nutzer, die den zugesagten Vertrag voraussetzen.
   **EN:** Because other programs rely on its behavior. A change acts not only internally but affects all users
   who assume the promised contract.

   </details>

2. **DE:** Was unterscheidet eine additive Änderung von einem Breaking Change? /
   **EN:** What distinguishes an additive change from a breaking change?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Additive Änderungen (neues optionales Feld) lassen bestehende Aufrufe unverändert funktionieren.
   Ein Breaking Change entfernt oder deutet etwas um, sodass alte Aufrufe scheitern.
   **EN:** Additive changes (a new optional field) leave existing calls working unchanged. A breaking change
   removes or reinterprets something, so old calls fail.

   </details>

3. **DE:** Wozu dient eine parallele Übergangsfrist zweier Versionen? /
   **EN:** What is a parallel transition period of two versions for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie gibt Nutzern Zeit, geordnet auf die neue Version zu wechseln, ohne dass ihr Betrieb schlagartig
   ausfällt. Das reduziert Ausfallrisiko und Druck.
   **EN:** It gives users time to move to the new version in an orderly way without their operation failing
   suddenly. This reduces outage risk and pressure.

   </details>

4. **DE:** Warum gehört der Fehlervertrag zur Kompatibilität? /
   **EN:** Why is the error contract part of compatibility?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nutzer reagieren programmatisch auf Fehlercodes. Ändern sich Codes oder Bedeutung, brechen ihre
   Fehlerbehandlungen – auch das ist eine brechende Änderung.
   **EN:** Users react programmatically to error codes. If codes or meaning change, their error handling
   breaks – that too is a breaking change.

   </details>

5. **DE:** Warum darf eine API-Fehlermeldung keine internen Details enthalten? /
   **EN:** Why must an API error message not contain internal details?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Interne Pfade, Stack-Traces oder Datenbankmeldungen helfen Angreifern und offenbaren Struktur. Die
   Meldung soll sagen, *was* falsch war, nicht *wie das System innen aussieht*.
   **EN:** Internal paths, stack traces, or database messages help attackers and reveal structure. The message
   should say *what* was wrong, not *what the system looks like inside*.

   </details>

6. **DE:** Wie beweist du, dass eine neue Version alte Nutzer nicht unbemerkt bricht? /
   **EN:** How do you prove that a new version does not silently break old users?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch Kompatibilitätstests, die typische alte Aufrufe gegen die neue Version ausführen und das
   erwartete Verhalten dokumentieren. Das ist prüfbare Evidenz statt einer Behauptung.
   **EN:** Through compatibility tests that run typical old calls against the new version and document the
   expected behavior. That is verifiable evidence instead of a claim.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den API-Vertrag je Endpunkt beschreiben.
- [ ] additive von brechenden Änderungen unterscheiden.
- [ ] eine Versionierung mit Migrationspfad und Übergangsfrist planen.
- [ ] einen Fehlervertrag ohne interne Details festlegen.
- [ ] Kompatibilitätstests als Nachweis benennen.

**EN:** I can …

- [ ] describe the API contract per endpoint.
- [ ] distinguish additive from breaking changes.
- [ ] plan versioning with a migration path and transition period.
- [ ] define an error contract without internal details.
- [ ] name compatibility tests as evidence.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_03_API-Versionierung-und-Kompatibilitaet.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_03_API-Versionierung-und-Kompatibilitaet.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
