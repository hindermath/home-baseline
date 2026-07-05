# Lernbegleiter: Secure CaseTracker Operations Track 03 – CI/CD-Pipeline und Release-Nachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wenn Code von einem Rechner auf einen Server kommt, sollte das nicht von Hand und nicht auf gut Glück
passieren. Eine **CI/CD-Pipeline** automatisiert diesen Weg: Sie baut das Programm, prüft es mit Tests und
Scannern und stellt am Ende ein Artefakt bereit. **CI** steht für kontinuierliche Integration (bauen und
prüfen), **CD** für kontinuierliche Auslieferung (bereitstellen oder ausrollen). Jeder Schritt hinterlässt
einen Nachweis. Genau diese Nachweise machen einen Release auditfähig: Man sieht, was geprüft wurde, bevor
etwas live ging.

**EN:** When code goes from a machine to a server, this should not happen by hand or by luck. A **CI/CD
pipeline** automates this path: it builds the program, checks it with tests and scanners, and finally
provides an artifact. **CI** means continuous integration (build and check), **CD** means continuous
delivery (provide or roll out). Each step leaves evidence. Exactly this evidence makes a release audit-ready:
you can see what was checked before something went live.

**DE:** In dieser Einheit lernst du, Pipeline-Schritte zu ordnen, **Gates** (Prüfstellen, die einen fehlerhaften
Stand stoppen) zu setzen, Artefakte und Release-Nachweise zu planen und festzulegen, wann eine **manuelle
Freigabe** nötig ist.

**EN:** In this unit you learn to order pipeline steps, set **gates** (checkpoints that stop a faulty state),
plan artifacts and release evidence, and decide when a **manual approval** is required.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| CI/CD-Pipeline / CI/CD pipeline | Automatisierte Kette aus Bauen, Prüfen und Bereitstellen von Software. |
| Gate / Quality gate | Prüfstelle, die einen fehlerhaften oder unsicheren Stand stoppt. |
| Artefakt / Artifact | Ergebnis des Builds, z. B. ein Programm oder Container-Image. |
| Release-Nachweis / Release evidence | Belege, was vor der Auslieferung geprüft und freigegeben wurde. |
| Manuelle Freigabe / Manual approval | Bewusste menschliche Zustimmung vor einem kritischen Schritt. |
| Provenance / Provenance | Nachvollziehbare Herkunft eines Artefakts (wer, wann, aus welchem Stand gebaut). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Pipeline-Schritte ordnen.** Eine typische Reihenfolge ist: Quellcode holen, bauen,
Tests laufen lassen, Sicherheits- und Abhängigkeits-Scans, Artefakt paketieren, bereitstellen. Die
Reihenfolge ist wichtig: teure oder riskante Schritte kommen erst, wenn günstige Prüfungen bestanden sind.

**EN:** **Step 1 – Order the pipeline steps.** A typical order is: fetch source, build, run tests, security
and dependency scans, package the artifact, deploy. The order matters: expensive or risky steps come only
after cheap checks have passed.

**DE:** **Schritt 2 – Gates setzen.** Ein Gate stoppt die Pipeline, wenn eine Prüfung fehlschlägt: Tests rot,
Scanner findet einen kritischen Fund, Secrets im Code. Ein Gate schützt davor, dass ein kaputter oder
unsicherer Stand automatisch weiterläuft. Ohne Gate ist Automatisierung nur schnelles Verteilen von Fehlern.

**EN:** **Step 2 – Set gates.** A gate stops the pipeline when a check fails: tests red, a scanner finds a
critical result, secrets in code. A gate protects against a broken or insecure state automatically moving on.
Without a gate, automation is just fast distribution of errors.

**DE:** **Schritt 3 – Artefakte und Nachweise planen.** Jeder Lauf soll ein klar benanntes Artefakt und
zugehörige Nachweise erzeugen: Testbericht, Scan-Ergebnis, Versionsnummer, Herkunft (Provenance). So lässt
sich später belegen, was in einem Release steckt. Nachweise werden gespeichert, nicht nur angezeigt.

**EN:** **Step 3 – Plan artifacts and evidence.** Each run should produce a clearly named artifact and
related evidence: test report, scan result, version number, origin (provenance). This later proves what is
in a release. Evidence is stored, not only displayed.

**DE:** **Schritt 4 – Manuelle Freigaben festlegen.** Nicht alles darf vollautomatisch live gehen. Vor einem
kritischen Schritt – etwa dem Produktivbetrieb – ist eine bewusste menschliche Freigabe sinnvoll. Sie
verbindet Automatisierung mit Verantwortung: Ein Mensch bestätigt, dass die Nachweise passen.

**EN:** **Step 4 – Define manual approvals.** Not everything may go live fully automatically. Before a
critical step – such as production – a deliberate human approval is sensible. It combines automation with
responsibility: a person confirms that the evidence is sound.

**DE:** **Typische Fehler.** Pipeline ohne Gates (alles läuft durch). Nachweise nur flüchtig anzeigen, nicht
speichern. Secrets in Pipeline-Variablen im Klartext. Kritische Deployments ohne jede Freigabe. Schritte in
falscher Reihenfolge, sodass teure Läufe scheitern, obwohl ein günstiger Test schon rot war.

**EN:** **Common mistakes.** A pipeline without gates (everything passes through). Showing evidence only
briefly, not storing it. Secrets in pipeline variables in plain text. Critical deployments without any
approval. Steps in the wrong order, so expensive runs fail although a cheap test was already red.

### Beispiel / Example

```text
Schritt 1 Build:        Quellcode holen -> kompilieren                (Gate: Build muss grün sein)
Schritt 2 Test:         Unit- + Negativtests                          (Gate: alle Tests grün)
Schritt 3 Scan:         Secrets-Scan + Abhängigkeits-Scan             (Gate: kein kritischer Fund)
Schritt 4 Paket:        Artefakt + Versionsnummer + Provenance
Schritt 5 Freigabe:     manuelle Freigabe für Produktiv (Mensch)
Nachweis gespeichert:   Testbericht, Scan-Ergebnis, Artefakt-Hash, Freigabe-Vermerk
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10b Serverdienste bereitstellen und Administrationsaufgaben automatisieren | Primär / Primary | Eine CI/CD-Pipeline automatisiert Build, Prüfung und Bereitstellung als Administrationsaufgabe. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Das Ergebnis der Pipeline ist ein bereitgestellter Dienst mit belegter Herkunft. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Auslieferung, Testbarkeit, Supply-Chain-Bezug und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Testmanagement),
`CL_06` (Supply-Chain), `CL_08` (Sicherheits-Review) und `CL_11` (Freigabe/Release). Die
Sicherheitsentscheidung dieser Einheit lautet: *Kein unsicherer oder ungeprüfter Stand passiert ein Gate;
kritische Schritte brauchen eine bewusste Freigabe.* A11Y-Aspekt: Pipeline-Status und Nachweise müssen als
Text lesbar sein (grün/rot nie nur über Farbe), damit sie mit Screenreader und Braille-Zeile erfassbar sind.

**EN:** Relation to the Secure Development Guideline: secure delivery, testability, supply-chain relation,
and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (test management),
`CL_06` (supply chain), `CL_08` (security review), and `CL_11` (approval/release). The security decision of
this unit is: *no insecure or unchecked state passes a gate; critical steps need a deliberate approval.*
Accessibility aspect: pipeline status and evidence must be readable as text (green/red never by color alone)
so they are perceivable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet CI von CD? /
   **EN:** What distinguishes CI from CD?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** CI (kontinuierliche Integration) baut und prüft den Code automatisch. CD (kontinuierliche
   Auslieferung) stellt das geprüfte Artefakt bereit oder rollt es aus. CI sichert Qualität, CD sichert den
   Weg zum Betrieb.
   **EN:** CI (continuous integration) builds and checks the code automatically. CD (continuous delivery)
   provides or rolls out the checked artifact. CI secures quality, CD secures the path to operation.

   </details>

2. **DE:** Wozu dient ein Gate in der Pipeline? /
   **EN:** What is a gate in the pipeline for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Gate stoppt die Pipeline, wenn eine Prüfung fehlschlägt (rote Tests, kritischer Scan-Fund,
   Secrets). Es verhindert, dass ein kaputter oder unsicherer Stand automatisch weiterläuft.
   **EN:** A gate stops the pipeline when a check fails (red tests, a critical scan result, secrets). It
   prevents a broken or insecure state from automatically moving on.

   </details>

3. **DE:** Warum müssen Release-Nachweise gespeichert und nicht nur angezeigt werden? /
   **EN:** Why must release evidence be stored and not only displayed?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur gespeicherte Nachweise sind später prüfbar. Bei einem Audit oder Störfall muss man belegen
   können, was vor dem Release geprüft und freigegeben wurde. Ein flüchtiger Anzeigewert genügt dafür nicht.
   **EN:** Only stored evidence is verifiable later. In an audit or incident you must be able to prove what was
   checked and approved before the release. A fleeting display value is not enough.

   </details>

4. **DE:** (SI) Wann ist eine manuelle Freigabe trotz Automatisierung sinnvoll? /
   **EN:** (SI) When is a manual approval sensible despite automation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Vor kritischen Schritten wie dem Produktivbetrieb. Ein Mensch bestätigt, dass die Nachweise passen
   und der Zeitpunkt geeignet ist. So verbindet man Automatisierung mit klarer Verantwortung.
   **EN:** Before critical steps such as production. A person confirms that the evidence is sound and the
   timing is suitable. This combines automation with clear responsibility.

   </details>

5. **DE:** (SI) Warum ist die Reihenfolge der Pipeline-Schritte wichtig? /
   **EN:** (SI) Why does the order of pipeline steps matter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Günstige, schnelle Prüfungen (Build, Tests) sollten vor teuren oder riskanten Schritten laufen.
   Scheitert ein früher Test, spart man Zeit und Ressourcen und verteilt keinen fehlerhaften Stand weiter.
   **EN:** Cheap, fast checks (build, tests) should run before expensive or risky steps. If an early test
   fails, you save time and resources and do not distribute a faulty state further.

   </details>

6. **DE:** (SI) Warum dürfen Secrets nicht im Klartext in Pipeline-Variablen stehen? /
   **EN:** (SI) Why must secrets not be in plain text in pipeline variables?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klartext-Secrets landen leicht in Logs, in der Historie oder werden kopiert. Sie gehören in einen
   geschützten Secret-Speicher und werden nur zur Laufzeit eingelesen. Das ist Thema der nächsten Einheit.
   **EN:** Plain-text secrets easily end up in logs, history, or get copied. They belong in a protected secret
   store and are read only at runtime. This is the topic of the next unit.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die typischen Schritte einer CI/CD-Pipeline in sinnvoller Reihenfolge nennen.
- [ ] für kritische Prüfungen passende Gates festlegen.
- [ ] Artefakte und speicherbare Release-Nachweise planen.
- [ ] begründen, wann eine manuelle Freigabe nötig ist.
- [ ] erklären, warum Secrets nicht im Klartext in die Pipeline gehören.

**EN:** I can …

- [ ] name the typical steps of a CI/CD pipeline in a sensible order.
- [ ] set suitable gates for critical checks.
- [ ] plan artifacts and storable release evidence.
- [ ] justify when a manual approval is needed.
- [ ] explain why secrets must not be in the pipeline in plain text.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
