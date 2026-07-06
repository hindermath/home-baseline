# Lernbegleiter: Secure ServiceHarvester 07 – Testbarkeit und Qualität / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_07_Testbarkeit-und-Qualitaet.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Tests sind kein lästiges Anhängsel, sondern **Beweise**. Sie zeigen, dass der Sammel-Dienst tut, was
er soll – und dass er fehlerhafte oder manipulierte Statusdaten zuverlässig ablehnt. In dieser Einheit planst
du den Testumfang für den Secure ServiceHarvester. Wichtig ist die Unterscheidung: **fachliche Tests**
(Snapshot sammeln, gültigen Status speichern), **negative Sicherheitstests** (ungültige `last_contact`,
unbekanntes `os`, manipulierter Import- oder Dateipfad), **Datenschutztests** (keine unnötigen
personenbezogenen Daten, Log-Regeln) und – weil es ein **Dienst** ist – **dienstspezifische Tests** für das
Sammel-Intervall und das saubere Beenden (Graceful Shutdown). Genauso wichtig: offene Testlücken werden
**transparent** dokumentiert und nicht versteckt.

**EN:** Tests are not an annoying add-on but **evidence**. They show that the collection service does what it
should – and that it reliably rejects faulty or manipulated status data. In this unit you plan the test scope
for the Secure ServiceHarvester. The key distinction: **functional tests** (collect a snapshot, store a valid
status), **negative security tests** (invalid `last_contact`, unknown `os`, manipulated import or file path),
**privacy tests** (no unnecessary personal data, log rules), and – because it is a **service** –
**service-specific tests** for the collection interval and clean shutdown (graceful shutdown). Equally
important: open test gaps are documented **transparently** and not hidden.

**DE:** Alle Testdaten sind fiktiv und enthalten keine echten personenbezogenen Daten und keine echten
Secrets. Jede sicherheitsrelevante Regel bekommt mindestens einen negativen Test.

**EN:** All test data is fictitious and contains no real personal data and no real secrets. Every
security-relevant rule gets at least one negative test.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Fachlicher Test / Functional test | Prüft, ob eine gewünschte Funktion des Dienstes korrekt arbeitet. |
| Negativtest / Negative test | Prüft, ob ungültige oder verbotene Fälle korrekt abgelehnt werden. |
| Datenschutztest / Privacy test | Prüft Datenminimierung und Logging-Regeln. |
| Fehlpfad / Error path | Ablauf, bei dem etwas absichtlich schiefgeht und geprüft wird. |
| Shutdown-Test / Shutdown test | Prüft, ob der Dienst auf ein Stopp-Signal geordnet beendet. |
| CI-Nachweis / CI evidence | Automatischer Testlauf, der Ergebnisse reproduzierbar belegt. |
| Testlücke / Test gap | Bekannter, dokumentierter Bereich ohne (ausreichende) Tests. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testarten trennen.** Benenne getrennt fachliche Tests, Sicherheitstests,
Datenschutztests und Diensttests. Warum trennen? Jede Art prüft ein anderes Risiko; wer nur Erfolgspfade
testet, übersieht gerade die gefährlichen Fälle.

**EN:** **Step 1 – Separate test types.** Name functional tests, security tests, privacy tests, and service
tests separately. Why separate? Each type checks a different risk; whoever tests only success paths misses
exactly the dangerous cases.

**DE:** **Schritt 2 – Fehlpfade und Negativtests planen.** Jede sicherheitsrelevante Regel braucht mindestens
einen negativen Test: ungültiger `last_contact`-Zeitstempel, unbekanntes `os`, überlanger Maschinenname,
manipulierter Import- oder Dateipfad. Gesammelte Statusdaten gelten als nicht vertrauenswürdig und werden an
der Vertrauensgrenze geprüft. Warum? Ein Negativtest beweist, dass der Schutz wirklich greift, nicht nur der
Erfolgsfall.

**EN:** **Step 2 – Plan error paths and negative tests.** Every security-relevant rule needs at least one
negative test: invalid `last_contact` timestamp, unknown `os`, over-long machine name, manipulated import or
file path. Collected status data is treated as untrusted and validated at the trust boundary. Why? A negative
test proves the protection really works, not just the success case.

**DE:** **Schritt 3 – Dienstverhalten testen.** Ein Dienst ist kein einmaliges Programm. Plane deshalb einen
Intervall-Test (sammelt der Dienst im geplanten Takt?) und einen Shutdown-Test (beendet er sich auf ein
Stopp-Signal geordnet, ohne Daten zu verlieren oder hängen zu bleiben?). Warum? Genau diese Lebenszyklus-
Fragen unterscheiden einen Dienst von einem Skript und sind sonst leicht zu übersehen.

**EN:** **Step 3 – Test service behavior.** A service is not a one-shot program. Therefore plan an interval
test (does the service collect at the planned cadence?) and a shutdown test (does it stop in an orderly way on
a stop signal, without losing data or hanging?). Why? These lifecycle questions are exactly what distinguishes
a service from a script and are otherwise easy to overlook.

**DE:** **Schritt 4 – Testdaten datenschutzfreundlich wählen.** Nutze fiktive, wiederholbare Testdaten. Keine
echten Maschinen- oder Personennamen, keine Secrets, keine unnötigen personenbezogenen Daten in Tests oder
Testberichten. Secrets erscheinen nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`. Warum? Auch Testdaten
und Berichte können Datenschutz verletzen, wenn echte Daten hineingeraten.

**EN:** **Step 4 – Choose privacy-friendly test data.** Use fictitious, repeatable test data. No real machine
or personal names, no secrets, no unnecessary personal data in tests or test reports. Secrets appear only as
the placeholder `<PLATZHALTER-KEIN-ECHTER-WERT>`. Why? Test data and reports can also violate privacy if real
data slips in.

**DE:** **Schritt 5 – Testlücken sichtbar machen.** Wenn eine Testart oder Coverage-Schwelle noch nicht
möglich ist (z. B. weil keine Implementierung existiert), dokumentiere sie als `Open` oder `N/A` mit Grund und
späterem Re-Evaluierungszeitpunkt. Warum? Versteckte Lücken täuschen Sicherheit vor; offene Lücken lassen sich
planen und schließen.

**EN:** **Step 5 – Make test gaps visible.** If a test type or coverage threshold is not yet possible (e.g.
because no implementation exists), document it as `Open` or `N/A` with a reason and a later re-evaluation
point. Why? Hidden gaps fake security; open gaps can be planned and closed.

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Sicherheitsregeln ohne Negativtest lassen. Intervall-
und Shutdown-Verhalten des Dienstes vergessen. Secrets oder echte Daten in Testdaten. Testlücken verschweigen.
Testkommandos je Sprache nicht dokumentieren.

**EN:** **Common mistakes.** Testing only success paths. Leaving security rules without a negative test.
Forgetting the service's interval and shutdown behavior. Secrets or real data in test data. Hiding test gaps.
Not documenting the test command per language.

### Beispiel / Example

```text
Fachlicher Test:     Snapshot sammeln -> Machine{name,os,last_contact} gespeichert, Status gueltig.
Sicherheits-Negativ: last_contact = "morgen" (ungueltig)     -> ABGELEHNT (Validierung greift).
Sicherheits-Negativ: Import mit Pfad "../../etc/passwd"       -> ABGELEHNT (Pfadgrenze greift).
Dienst-Test:         Intervall -> Dienst sammelt im geplanten Takt (kein Dauerlauf, kein Aussetzen).
Dienst-Test:         Shutdown  -> Stopp-Signal -> Dienst beendet geordnet, kein Datenverlust.
Datenschutztest:     Betriebs-/Audit-Log enthaelt kein Secret, keinen vollstaendigen Freitext.
Testkommando:        C#: dotnet test | Go: go test ./... | Java: mvn test | Python: pytest
                     Rust: cargo test | Swift: swift test
Testluecke (Open):   Coverage-Schwelle N/A -> noch keine Implementierung, Re-Eval nach Einheit 06.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Testbarkeit sichert die Qualität der datenverwaltenden Dienst-Software ab. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Tests decken die typischen Dienstabläufe (sammeln, speichern, bereitstellen) ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testmanagement, Sicherheits-Code-Review und nachvollziehbare
Evidenz. Passende Checklisten: `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement) und `CL_10`
(Kompetenz-/Qualitätsnachweis). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede sicherheitsrelevante
Regel hat mindestens einen Negativtest, Intervall und Shutdown sind geprüft, und offene Lücken werden ehrlich
dokumentiert.* A11Y-Aspekt: Testberichte sind textbasiert und ohne reine Farbsignale (nicht nur „grün/rot"),
damit Ergebnisse mit Screenreader und Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: test management, security code review, and traceable
evidence. Matching checklists: `CL_08` (security code review), `CL_09` (test management), and `CL_10`
(competence/quality evidence). The security decision of this unit is: *every security-relevant rule has at
least one negative test, interval and shutdown are checked, and open gaps are documented honestly.*
Accessibility aspect: test reports are text-based and without color-only signals (not just "green/red"), so
results remain understandable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht es nicht, nur Erfolgspfade zu testen? /
   **EN:** Why is it not enough to test only success paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sicherheitslücken zeigen sich meist im Fehlerfall. Nur Negativtests beweisen, dass ungültige oder
   manipulierte Statusdaten wirklich abgelehnt werden.
   **EN:** Security holes usually show up in the error case. Only negative tests prove that invalid or
   manipulated status data is really rejected.

   </details>

2. **DE:** (AE) Welcher Fehlerfall des Dienstes muss unbedingt automatisiert getestet werden? /
   **EN:** (AE) Which service error case must absolutely be tested automatically?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder sicherheitsrelevante Fall, z. B. ungültiger `last_contact`, unbekanntes `os` oder ein
   manipulierter Importpfad. Diese Fälle sind das Kernrisiko und dürfen nicht nur manuell geprüft werden.
   **EN:** Every security-relevant case, e.g. invalid `last_contact`, unknown `os`, or a manipulated import
   path. These cases are the core risk and must not be checked only manually.

   </details>

3. **DE:** (SI) Wie wird ein Testlauf in der Sandbox oder CI reproduzierbar? /
   **EN:** (SI) How is a test run reproducible in the sandbox or CI?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch dokumentierte Testkommandos je Sprache und feste, fiktive Testdaten. So liefert derselbe Lauf
   auf einem anderen Rechner dasselbe Ergebnis.
   **EN:** Through documented test commands per language and fixed, fictitious test data. The same run then
   yields the same result on another machine.

   </details>

4. **DE:** (DPA) Welche Testdaten sind realistisch, aber datenschutzfreundlich? /
   **EN:** (DPA) Which test data is realistic but privacy-friendly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fiktive, wiederholbare Statusdaten, die die Struktur echter Maschinen nachbilden, aber keine echten
   Namen, Standorte oder Secrets enthalten.
   **EN:** Fictitious, repeatable status data that mirrors the structure of real machines but contains no real
   names, locations, or secrets.

   </details>

5. **DE:** (DV) Warum braucht die Systemgrenze zwischen sammelnden Maschinen und dem Dienst einen eigenen
   Negativtest? / **EN:** (DV) Why does the system boundary between collecting machines and the service need
   its own negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An dieser Grenze wechseln Daten die Vertrauenszone. Ein Negativtest zeigt, dass der Dienst
   fehlerhafte oder manipulierte Daten von außen ablehnt und nicht ungeprüft übernimmt.
   **EN:** At this boundary data crosses the trust zone. A negative test shows that the service rejects faulty
   or manipulated data from outside instead of accepting it unchecked.

   </details>

6. **DE:** Warum braucht ein Dienst zusätzlich Intervall- und Shutdown-Tests? /
   **EN:** Why does a service additionally need interval and shutdown tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Dienst läuft dauerhaft und sammelt in Abständen. Intervall- und Shutdown-Tests beweisen, dass er
   im richtigen Takt arbeitet und sich sauber beenden lässt – Fragen, die ein einmaliges Programm nicht hat.
   **EN:** A service runs continuously and collects at intervals. Interval and shutdown tests prove that it
   works at the right cadence and stops cleanly – questions a one-shot program does not have.

   </details>

7. **DE:** Warum werden offene Testlücken dokumentiert statt verschwiegen? /
   **EN:** Why are open test gaps documented rather than hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Versteckte Lücken täuschen falsche Sicherheit vor. Offene, begründete Lücken lassen sich planen,
   priorisieren und später schließen.
   **EN:** Hidden gaps fake a false sense of security. Open, justified gaps can be planned, prioritized, and
   closed later.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] fachliche Tests, Sicherheitstests und Datenschutztests getrennt planen.
- [ ] für jede sicherheitsrelevante Regel mindestens einen Negativtest angeben.
- [ ] Intervall- und Shutdown-Verhalten des Dienstes durch je einen Test abdecken.
- [ ] fiktive, datenschutzfreundliche Testdaten wählen.
- [ ] offene Testlücken als `Open` oder `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] plan functional, security, and privacy tests separately.
- [ ] give at least one negative test for each security-relevant rule.
- [ ] cover the service's interval and shutdown behavior with one test each.
- [ ] choose fictitious, privacy-friendly test data.
- [ ] document open test gaps as `Open` or `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_07_Testbarkeit-und-Qualitaet.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_07_Testbarkeit-und-Qualitaet.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
