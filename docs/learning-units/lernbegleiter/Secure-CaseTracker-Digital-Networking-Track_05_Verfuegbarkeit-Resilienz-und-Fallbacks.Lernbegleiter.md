# Lernbegleiter: Secure CaseTracker Digital Networking Track 05 – Verfügbarkeit, Resilienz und Fallbacks / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Digital-Networking-Track_05_Verfuegbarkeit-Resilienz-und-Fallbacks.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Vernetzte Systeme fallen aus: Ein Netzwerk ist kurz weg, ein Dienst antwortet langsam, ein Knoten
startet neu. **Verfügbarkeit** heißt, dass das System trotzdem nutzbar bleibt. **Resilienz** ist die
Fähigkeit, sich von Störungen zu erholen. Ein **Fallback** ist ein geplanter Ersatzweg, wenn der
Normalbetrieb nicht möglich ist. Der wichtigste Gedanke im dritten Lehrjahr: Ein Fallback darf nie die
Sicherheit senken. Ein System, das im Fehlerfall einfach jeden hereinlässt, ist verfügbar, aber unsicher.
Sicher heißt: Im Zweifel lieber sicher schließen als offen weiterlaufen (Fail-Safe, nicht Fail-Open).

**EN:** Networked systems fail: a network drops briefly, a service answers slowly, a node restarts.
**Availability** means the system stays usable anyway. **Resilience** is the ability to recover from
disturbances. A **fallback** is a planned alternative path when normal operation is impossible. The key idea
in the third year: a fallback must never lower security. A system that simply lets everyone in on error is
available but insecure. Secure means: when in doubt, close safely rather than run on openly (fail-safe, not
fail-open).

**DE:** In dieser Einheit lernst du, Ausfallarten und ihre Auswirkungen zu beschreiben, Timeouts, Retries und
Wiederanlauf getrennt zu planen, sichere Degradation zu definieren und für jede Resilienzbehauptung eine
Test- oder Review-Evidenz zu benennen.

**EN:** In this unit you learn to describe failure types and their effects, to plan timeouts, retries, and
restart separately, to define safe degradation, and to name a test or review evidence for every resilience
claim.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Verfügbarkeit / Availability | Anteil der Zeit, in der ein System nutzbar ist. |
| Resilienz / Resilience | Fähigkeit, Störungen zu überstehen und sich zu erholen. |
| Timeout / Timeout | Grenze, nach der ein Warten auf eine Antwort abgebrochen wird. |
| Retry / Retry | Kontrolliertes erneutes Versuchen einer fehlgeschlagenen Aktion. |
| Fallback / Fallback | Geplanter Ersatzweg, der bei Störung greift. |
| Sichere Degradation / Safe degradation | Eingeschränkter, aber sicherer Betrieb statt Total- oder Fail-Open-Ausfall. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ausfallarten benennen.** Welche Störungen sind realistisch? Netzwerkverlust,
langsamer Dienst, überlasteter Knoten, Neustart. Beschreibe je Ausfallart, welcher Teil betroffen ist und
was der Nutzer merkt. Was du nicht benennst, kannst du nicht abfangen.

**EN:** **Step 1 – Name failure types.** Which disturbances are realistic? Network loss, slow service,
overloaded node, restart. For each failure type describe which part is affected and what the user notices.
What you do not name, you cannot catch.

**DE:** **Schritt 2 – Timeouts setzen.** Ohne Timeout wartet ein Aufruf ewig und blockiert das System. Setze
für jeden Netzaufruf eine sinnvolle Zeitgrenze. Warum? Ein hängender Aufruf zieht Ressourcen und macht das
ganze System langsam. Ein Timeout gibt Kontrolle zurück.

**EN:** **Step 2 – Set timeouts.** Without a timeout a call waits forever and blocks the system. Set a
sensible time limit for each network call. Why? A hanging call ties up resources and slows the whole system.
A timeout returns control.

**DE:** **Schritt 3 – Retries kontrollieren.** Ein erneuter Versuch kann helfen, aber unbegrenzte Retries
verstärken eine Überlast (Retry-Sturm). Plane eine Obergrenze und Abstände zwischen den Versuchen. Nicht
jede Aktion darf wiederholt werden: Eine bereits gespeicherte Fallanlage zweimal auszuführen wäre falsch.

**EN:** **Step 3 – Control retries.** A new attempt can help, but unlimited retries amplify an overload
(retry storm). Plan an upper bound and gaps between attempts. Not every action may be repeated: creating an
already-saved case twice would be wrong.

**DE:** **Schritt 4 – Sichere Degradation definieren.** Wenn ein Teil ausfällt, soll das System eingeschränkt
weiterlaufen, ohne Sicherheit aufzugeben. Beispiel: Fällt das Monitoring aus, arbeitet der CaseTracker weiter,
aber ohne Live-Kennzahlen. Fällt die Falldatenbank aus, wird lieber der Schreibvorgang abgelehnt, als Daten
zu verlieren. Ein Fallback umgeht nie Authentifizierung oder Datenschutzgrenzen.

**EN:** **Step 4 – Define safe degradation.** When a part fails, the system should keep running in a limited
way without giving up security. Example: if monitoring fails, the CaseTracker keeps working but without live
metrics. If the case database fails, the write is rejected rather than losing data. A fallback never bypasses
authentication or privacy boundaries.

**DE:** **Schritt 5 – Datenverlustgrenzen und Evidenz.** Lege fest, wie viel Datenverlust im schlimmsten Fall
tolerierbar ist, und benenne für jede Behauptung („System übersteht Neustart") eine Test- oder Review-Idee.
Eine Resilienzbehauptung ohne Nachweis ist nur eine Hoffnung.

**EN:** **Step 5 – Data-loss limits and evidence.** Define how much data loss is tolerable in the worst case,
and for each claim ("the system survives a restart") name a test or review idea. A resilience claim without
evidence is only a hope.

**DE:** **Typische Fehler.** Keine Timeouts setzen. Unbegrenzt wiederholen. Nicht wiederholbare Aktionen
retryen. Im Fehlerfall Sicherheit senken (Fail-Open). Fehlerausgaben mit internen Pfaden oder Secrets.
Resilienz behaupten ohne Testidee.

**EN:** **Common mistakes.** Setting no timeouts. Retrying without limit. Retrying non-repeatable actions.
Lowering security on error (fail-open). Error outputs with internal paths or secrets. Claiming resilience
without a test idea.

### Beispiel / Example

```text
Ausfall- und Fallback-Matrix (Auszug):
  Ausfallart          Auswirkung              Fallback                       Sicherheit bleibt?
  Monitoring weg      keine Live-Kennzahlen   ohne Kennzahlen weiterarbeiten ja
  Falldatenbank weg   kein Schreiben moeglich Schreibvorgang ablehnen        ja (kein Datenverlust)
  Fachdienst langsam  Wartezeit               Timeout 5s, danach 1 Retry     ja

Datenverlustgrenze: max. die aktuelle, noch nicht gespeicherte Eingabe
Evidenz: Testidee "Datenbank trennen -> Schreiben wird sauber abgelehnt, keine Teilspeicherung"
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Verfügbarkeit, Resilienz und sichere Fallbacks sind Kern des zuverlässigen und sicheren Betriebs vernetzter Systeme. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Timeouts, Wiederanlauf und Degradation gehören zur belastbaren Bereitstellung von Diensten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Fail-Safe Defaults, Defense in Depth, Testbarkeit und
sichere Fehlerbehandlung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur/Design), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Betrieb/Konfiguration). Die
Sicherheitsentscheidung dieser Einheit lautet: *Ein Fallback hält Sicherheit und Datenschutz aufrecht; im
Zweifel wird sicher geschlossen (Fail-Safe), nicht offen weitergelaufen.* A11Y-Aspekt: Statusmeldungen bei
Degradation müssen textlich verständlich sein („Kennzahlen derzeit nicht verfügbar"), nicht nur ein
farbiges Symbol, damit sie mit Screenreader und Braille-Zeile erfassbar sind.

**EN:** Relation to the Secure Development Guideline: fail-safe defaults, defense in depth, testability, and
safe error handling. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design),
`CL_08` (security code review), and `CL_10` (operations/configuration). The security decision of this unit
is: *a fallback keeps security and privacy intact; when in doubt the system closes safely (fail-safe) rather
than running on openly.* Accessibility aspect: status messages during degradation must be understandable as
text ("metrics currently unavailable"), not only a colored icon, so they are perceivable with a screen reader
and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum darf ein Fallback die Sicherheit nicht senken? /
   **EN:** Why must a fallback not lower security?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Fallback, der im Fehlerfall Authentifizierung oder Datenschutzgrenzen umgeht (Fail-Open), macht
   das System angreifbar. Sicher ist Fail-Safe: im Zweifel schließen statt offen weiterlaufen.
   **EN:** A fallback that bypasses authentication or privacy boundaries on error (fail-open) makes the system
   attackable. Secure is fail-safe: when in doubt, close rather than run on openly.

   </details>

2. **DE:** Wozu dient ein Timeout bei einem Netzaufruf? /
   **EN:** What is a timeout for on a network call?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es begrenzt die Wartezeit, damit ein hängender Aufruf nicht Ressourcen bindet und das ganze System
   blockiert. Nach dem Timeout gibt das System die Kontrolle zurück.
   **EN:** It limits the waiting time so a hanging call does not tie up resources and block the whole system.
   After the timeout the system returns control.

   </details>

3. **DE:** Warum sind unbegrenzte Retries gefährlich? /
   **EN:** Why are unlimited retries dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie können eine Überlast verstärken (Retry-Sturm) und ein ohnehin schwaches System endgültig
   überfordern. Retries brauchen eine Obergrenze und Abstände.
   **EN:** They can amplify an overload (retry storm) and finally overwhelm an already weak system. Retries
   need an upper bound and gaps.

   </details>

4. **DE:** (DV) Was bedeutet sichere Degradation, wenn das Monitoring ausfällt? /
   **EN:** (DV) What does safe degradation mean if monitoring fails?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der CaseTracker arbeitet ohne Live-Kennzahlen weiter, aber ohne Sicherheit oder Datenschutz
   aufzugeben. Die fehlende Funktion wird verständlich gemeldet.
   **EN:** The CaseTracker keeps working without live metrics, but without giving up security or privacy. The
   missing function is reported understandably.

   </details>

5. **DE:** Warum darf nicht jede Aktion wiederholt werden? /
   **EN:** Why must not every action be repeated?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht wiederholbare Aktionen wie eine bereits gespeicherte Fallanlage würden bei einem Retry
   doppelt ausgeführt. Nur idempotente Aktionen sind gefahrlos wiederholbar.
   **EN:** Non-repeatable actions such as an already-saved case would run twice on a retry. Only idempotent
   actions can be repeated safely.

   </details>

6. **DE:** Warum braucht jede Resilienzbehauptung eine Test- oder Review-Evidenz? /
   **EN:** Why does every resilience claim need a test or review evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Nachweis ist die Behauptung nur eine Hoffnung. Eine Testidee wie „Datenbank trennen" zeigt,
   ob das System sich wirklich sicher verhält.
   **EN:** Without evidence the claim is only a hope. A test idea like "disconnect the database" shows whether
   the system really behaves safely.

   </details>

7. **DE:** Warum muss eine Degradationsmeldung textlich und nicht nur farbig sein? /
   **EN:** Why must a degradation message be textual and not only colored?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Textmeldung wie „Kennzahlen derzeit nicht verfügbar" ist mit Screenreader und Braille-Zeile
   erfassbar. Ein reines Farbsymbol schließt Menschen aus und verletzt WCAG 2.2 AA.
   **EN:** A text message like "metrics currently unavailable" is perceivable with a screen reader and Braille
   display. A color-only icon excludes people and violates WCAG 2.2 AA.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] realistische Ausfallarten und ihre Auswirkungen beschreiben.
- [ ] für Netzaufrufe sinnvolle Timeouts und begrenzte Retries planen.
- [ ] sichere Degradation definieren, die Sicherheit und Datenschutz erhält.
- [ ] Datenverlustgrenzen festlegen.
- [ ] für jede Resilienzbehauptung eine Test- oder Review-Idee angeben.

**EN:** I can …

- [ ] describe realistic failure types and their effects.
- [ ] plan sensible timeouts and bounded retries for network calls.
- [ ] define safe degradation that preserves security and privacy.
- [ ] set data-loss limits.
- [ ] give a test or review idea for each resilience claim.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_05_Verfuegbarkeit-Resilienz-und-Fallbacks.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Digital-Networking-Track_05_Verfuegbarkeit-Resilienz-und-Fallbacks.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
