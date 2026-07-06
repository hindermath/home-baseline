# Lernbegleiter: Secure ServiceHarvester Operations Track 06 – CI/CD-Pipeline und reproduzierbare Builds / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester ist ein langlaufender Sammel-Dienst. Bevor er auf einem Server läuft, muss
er gebaut, getestet und paketiert werden. Wer das jedes Mal von Hand macht, macht Fehler und kann später nicht
mehr beweisen, wie ein Release entstanden ist. Eine **CI/CD-Pipeline** (Continuous Integration / Continuous
Delivery) automatisiert diesen Weg: Sie baut den Dienst, prüft ihn, testet ihn und stellt ihn reproduzierbar
bereit. „Reproduzierbar" heißt: Aus demselben Quellstand entsteht immer dasselbe, überprüfbare Ergebnis.

**EN:** The Secure ServiceHarvester is a long-running collection service. Before it runs on a server, it must
be built, tested, and packaged. Doing this by hand every time causes mistakes and makes it impossible to later
prove how a release came to be. A **CI/CD pipeline** (Continuous Integration / Continuous Delivery) automates
this path: it builds the service, checks it, tests it, and provides it reproducibly. "Reproducible" means: the
same source state always yields the same, verifiable result.

**DE:** In dieser Einheit lernst du, die Pipeline-Stufen zu benennen, Builds reproduzierbar zu machen
(festgesetzte Versionen, Lockfiles), Sicherheits- und Dependency-Prüfungen einzuplanen und Release-Nachweise
zu führen. Als C#-Referenz dient der langlaufende Dienst `InventarWorkerService`; die Idee bleibt aber für
C#, Go, Java, Python, Rust und Swift vergleichbar. Sie baut auf der Observability-Einheit auf und liefert die
gebauten Artefakte, die spätere Einheiten (Backup, Sandbox) betreiben.

**EN:** In this unit you learn to name the pipeline stages, make builds reproducible (pinned versions,
lockfiles), plan security and dependency checks, and keep release evidence. The C# reference is the
long-running service `InventarWorkerService`; the idea stays comparable across C#, Go, Java, Python, Rust, and
Swift. It builds on the observability unit and delivers the built artifacts that later units (backup, sandbox)
operate.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| CI/CD / CI/CD | Automatisierter Weg von Quellcode über Build und Test bis zur Bereitstellung. |
| Pipeline-Stufe / Pipeline stage | Ein abgegrenzter Schritt, z. B. Build, Test, Sicherheitsprüfung, Paketierung. |
| Reproduzierbarer Build / Reproducible build | Gleicher Quellstand ergibt gleiches, überprüfbares Ergebnis. |
| Lockfile / Lockfile | Datei, die exakte Versionen aller Abhängigkeiten festhält. |
| Provenance / Provenance | Nachweis der Herkunft eines Artefakts: aus welchem Quellstand und Build. |
| Release-Nachweis / Release evidence | Beleg wie Versionskennung, Prüfsumme und Build-Herkunft. |
| Artefakt / Artifact | Das gebaute Ergebnis, z. B. ein ausführbares Paket. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Pipeline-Stufen benennen.** Schreibe die Stufen in eine sinnvolle Reihenfolge: Quelle
holen, bauen, testen, Sicherheits- und Dependency-Prüfung, paketieren, optional ausliefern. Jede Stufe hat
eine klare Aufgabe und ein klares Ergebnis. Bricht eine Stufe ab, stoppt die Pipeline (Fail-Safe).

**EN:** **Step 1 – Name the pipeline stages.** Put the stages in a sensible order: get source, build, test,
security and dependency check, package, optionally deliver. Each stage has a clear task and a clear result. If
a stage fails, the pipeline stops (fail-safe).

**DE:** **Schritt 2 – Builds reproduzierbar machen.** Ein Build ist nur dann ein Nachweis, wenn er
wiederholbar ist. Dafür werden Versionen festgesetzt (kein „neueste Version") und Lockfiles genutzt. So
entsteht aus demselben Quellstand dasselbe Artefakt. Je Sprache gibt es passende Werkzeuge, etwa Lockfiles für
Paketmanager.

**EN:** **Step 2 – Make builds reproducible.** A build is evidence only if it is repeatable. For this,
versions are pinned (no "latest version") and lockfiles are used. Then the same source state yields the same
artifact. Each language has suitable tools, e.g. lockfiles for package managers.

**DE:** **Schritt 3 – Sicherheits- und Dependency-Prüfungen einplanen.** Die Pipeline prüft Abhängigkeiten
auf bekannte Schwachstellen und den Code auf einfache Fehler. Findet die Prüfung ein kritisches Problem, soll
die Pipeline warnen oder abbrechen. So wird Sicherheit ein wiederholbarer Schritt, kein Zufall.

**EN:** **Step 3 – Plan security and dependency checks.** The pipeline checks dependencies for known
vulnerabilities and the code for simple mistakes. If the check finds a critical problem, the pipeline should
warn or stop. This makes security a repeatable step, not a matter of chance.

**DE:** **Schritt 4 – Release-Nachweise führen.** Zu jedem Release gehören eine Versionskennung, eine
Prüfsumme des Artefakts und die Build-Herkunft (aus welchem Quellstand). Damit lässt sich später beweisen,
dass ein betriebenes Artefakt genau aus dem geprüften Stand kommt. Ohne Nachweis ist ein Release nur eine
Behauptung.

**EN:** **Step 4 – Keep release evidence.** Every release has a version identifier, an artifact checksum, and
the build provenance (from which source state). This lets you later prove that an operated artifact comes
exactly from the reviewed state. Without evidence, a release is only a claim.

**DE:** **Typische Fehler.** „Neueste Version" statt festgesetzter Versionen nutzen. Tests aus der Pipeline
weglassen, um Zeit zu sparen. Sicherheitsprüfungen nur als Warnung ohne Konsequenz. Secrets im Klartext in die
Pipeline schreiben. Keine Release-Nachweise führen, sodass die Herkunft eines Artefakts unklar bleibt.

**EN:** **Common mistakes.** Using "latest version" instead of pinned versions. Dropping tests from the
pipeline to save time. Security checks only as a warning without consequence. Writing secrets in plaintext into
the pipeline. Keeping no release evidence, so an artifact's origin stays unclear.

### Beispiel / Example

```text
Pipeline-Stufen:  1) Quelle  2) Build  3) Test  4) Dependency-/Sicherheitsprüfung  5) Paketieren  6) Release
Reproduzierbar:   Versionen festgesetzt + Lockfile  -> gleicher Quellstand = gleiches Artefakt
Sicherheit:       Dependency-Scan bricht bei kritischer CVE ab       -> Nachweis: Pipeline-Log
Release-Nachweis: Version 1.2.0, Prüfsumme sha256:<...>, Quellstand-Kennung dokumentiert
Secrets:          nur als Platzhalter <PLATZHALTER-KEIN-ECHTER-WERT>, echte Werte im Secret-Store
C#-Referenz:      InventarWorkerService als Beispiel eines langlaufenden Dienstes
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10b Serverdienste bereitstellen und Administrationsaufgaben automatisieren | Primär / Primary | Die Pipeline automatisiert Build, Test und Auslieferung des Dienstes. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Das reproduzierbare Artefakt ist die Grundlage der Dienstbereitstellung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Lieferkette, reproduzierbare Builds, Testbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Lieferkette/Dependency),
`CL_08` (Sicherheits-Review), `CL_11` (CI/Release) und `CL_12` (Dokumentation/N-A). Die
Sicherheitsentscheidung dieser Einheit lautet: *Nur ein reproduzierbarer, geprüfter Build mit Herkunftsnachweis
gilt als Release; Secrets stehen niemals im Klartext in der Pipeline.* A11Y-Aspekt: Pipeline-Stufen und
Release-Nachweise werden als klare, nummerierte Textschritte dokumentiert, ohne reine Farbmarkierung, damit
sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure supply chain, reproducible builds, testability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (supply chain/dependency),
`CL_08` (security review), `CL_11` (CI/release), and `CL_12` (documentation/N-A). The security decision of this
unit is: *only a reproducible, checked build with provenance counts as a release; secrets are never in
plaintext in the pipeline.* Accessibility aspect: pipeline stages and release evidence are documented as clear,
numbered text steps, without color-only marking, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet ein reproduzierbarer Build und warum ist er wichtig? /
   **EN:** What does a reproducible build mean and why is it important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus demselben Quellstand entsteht immer dasselbe Artefakt. Das ist wichtig, weil man dann beweisen
   kann, was betrieben wird, Fehler wiederholbar findet und ein Release gegen den Quellstand prüfen kann.
   **EN:** The same source state always yields the same artifact. This matters because you can then prove what
   is operated, reproducibly find errors, and check a release against the source state.

   </details>

2. **DE:** Warum sollten in einer Pipeline Versionen festgesetzt statt „neueste Version" verwendet werden? /
   **EN:** Why should a pipeline pin versions instead of using "latest version"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Neueste Version" kann sich jederzeit ändern, sodass der Build nicht mehr reproduzierbar ist und
   unbemerkt neue oder verwundbare Abhängigkeiten hereinkommen. Festgesetzte Versionen und Lockfiles halten den
   Zustand stabil und überprüfbar.
   **EN:** "Latest version" can change at any time, so the build is no longer reproducible and new or vulnerable
   dependencies enter unnoticed. Pinned versions and lockfiles keep the state stable and verifiable.

   </details>

3. **DE:** Welche Stufen gehören mindestens in eine sinnvolle CI/CD-Pipeline? /
   **EN:** Which stages belong at minimum in a sensible CI/CD pipeline?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Quelle holen, bauen, testen, Sicherheits- und Dependency-Prüfung, paketieren und optional
   ausliefern. Jede Stufe hat ein klares Ergebnis, und ein Abbruch stoppt die Pipeline.
   **EN:** Get source, build, test, security and dependency check, package, and optionally deliver. Each stage
   has a clear result, and a failure stops the pipeline.

   </details>

4. **DE:** (SI) Wie weist du nach, dass ein betriebenes Artefakt aus dem geprüften Quellstand stammt? /
   **EN:** (SI) How do you prove that an operated artifact comes from the reviewed source state?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über Release-Nachweise: Versionskennung, Prüfsumme des Artefakts und Build-Herkunft (Provenance).
   Stimmt die Prüfsumme des betriebenen Artefakts mit der aus der Pipeline überein, ist die Herkunft belegt.
   **EN:** Via release evidence: version identifier, artifact checksum, and build provenance. If the operated
   artifact's checksum matches the one from the pipeline, the origin is evidenced.

   </details>

5. **DE:** (SI) Warum gehören Sicherheits- und Dependency-Prüfungen in die Pipeline statt nur ans Ende? /
   **EN:** (SI) Why do security and dependency checks belong in the pipeline instead of only at the end?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** In der Pipeline laufen sie automatisch und bei jedem Build, also wiederholbar und früh. So werden
   verwundbare Abhängigkeiten früh sichtbar, statt erst im Betrieb. Sicherheit wird ein fester Schritt, kein
   Zufall.
   **EN:** In the pipeline they run automatically and on every build, i.e. repeatably and early. So vulnerable
   dependencies become visible early rather than only in operation. Security becomes a fixed step, not chance.

   </details>

6. **DE:** Warum dürfen Secrets nicht im Klartext in der Pipeline stehen? /
   **EN:** Why must secrets not be in plaintext in the pipeline?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Pipeline-Konfiguration und Logs sind oft breit sichtbar oder versioniert. Ein Secret im Klartext
   landet so schnell in fremden Händen. Deshalb: nur Platzhalter im Text, echte Werte im Secret-Store.
   **EN:** Pipeline configuration and logs are often widely visible or versioned. A plaintext secret quickly
   ends up in the wrong hands. Therefore: only placeholders in the text, real values in the secret store.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Stufen einer CI/CD-Pipeline in sinnvoller Reihenfolge benennen.
- [ ] erklären, was einen Build reproduzierbar macht.
- [ ] Sicherheits- und Dependency-Prüfungen als Pipeline-Schritt einplanen.
- [ ] Release-Nachweise (Version, Prüfsumme, Herkunft) benennen.
- [ ] begründen, warum Secrets nicht im Klartext in die Pipeline gehören.

**EN:** I can …

- [ ] name the stages of a CI/CD pipeline in a sensible order.
- [ ] explain what makes a build reproducible.
- [ ] plan security and dependency checks as a pipeline step.
- [ ] name release evidence (version, checksum, provenance).
- [ ] justify why secrets do not belong in plaintext in the pipeline.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
