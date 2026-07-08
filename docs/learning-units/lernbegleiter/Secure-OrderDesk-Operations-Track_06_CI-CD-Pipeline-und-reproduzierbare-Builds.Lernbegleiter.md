# Lernbegleiter: Secure OrderDesk Operations Track 06 – CI/CD-Pipeline und reproduzierbare Builds / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Secure OrderDesk ist die Bestell-/Handelsplattform der fiktiven Kundenfirma Secure Trader. Sie arbeitet
mit einer relationalen Datenbank im Northwind-Layout (Kunden wie `ALFKI`, Produkte, Bestellungen, Positionen).
Bevor eine neue Version der Plattform auf einem Server läuft, muss sie gebaut, getestet und paketiert werden,
und häufig muss auch das Datenbankschema mitwandern. Wer das jedes Mal von Hand macht, macht Fehler und kann
später nicht mehr beweisen, wie ein Release entstanden ist. Eine **CI/CD-Pipeline** (Continuous Integration /
Continuous Delivery) automatisiert diesen Weg: Sie baut die Plattform, prüft sie, testet sie, führt
Datenbank-Migrationen aus und stellt sie reproduzierbar bereit. „Reproduzierbar" heißt: Aus demselben
Quellstand entsteht immer dasselbe, überprüfbare Ergebnis.

**EN:** Secure OrderDesk is the ordering/trading platform of the fictitious client company Secure Trader. It
works with a relational database in Northwind layout (customers such as `ALFKI`, products, orders, lines).
Before a new version of the platform runs on a server, it must be built, tested, and packaged, and often the
database schema must move along too. Doing this by hand every time causes mistakes and makes it impossible to
later prove how a release came to be. A **CI/CD pipeline** (Continuous Integration / Continuous Delivery)
automates this path: it builds the platform, checks it, tests it, runs database migrations, and provides it
reproducibly. "Reproducible" means: the same source state always yields the same, verifiable result.

**DE:** In dieser Einheit lernst du, die Pipeline-Stufen zu benennen, Builds reproduzierbar zu machen
(festgesetzte Versionen, Lockfiles), einen Datenbank-Migrationsschritt einzuplanen, Sicherheits- und
Dependency-Prüfungen einzubauen und Release-Nachweise zu führen. Als C#-Referenz dient der langlaufende Dienst
`InventarWorkerService`; die Idee bleibt aber für C#, Go, Java, Python, Rust und Swift vergleichbar. Sie liefert
die gebauten Artefakte, die spätere Einheiten (Backup, Sandbox) betreiben.

**EN:** In this unit you learn to name the pipeline stages, make builds reproducible (pinned versions,
lockfiles), plan a database migration step, add security and dependency checks, and keep release evidence. The
C# reference is the long-running service `InventarWorkerService`; the idea stays comparable across C#, Go,
Java, Python, Rust, and Swift. It delivers the built artifacts that later units (backup, sandbox) operate.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| CI/CD / CI/CD | Automatisierter Weg von Quellcode über Build und Test bis zur Bereitstellung. |
| Pipeline-Stufe / Pipeline stage | Ein abgegrenzter Schritt, z. B. Build, Test, Sicherheitsprüfung, Migration, Paketierung. |
| Reproduzierbarer Build / Reproducible build | Gleicher Quellstand ergibt gleiches, überprüfbares Ergebnis. |
| Lockfile / Lockfile | Datei, die exakte Versionen aller Abhängigkeiten festhält. |
| Datenbank-Migration / Database migration | Versionierter, geprüfter Schritt, der das Schema mitzieht. |
| Provenance / Provenance | Nachweis der Herkunft eines Artefakts: aus welchem Quellstand und Build. |
| Release-Nachweis / Release evidence | Beleg wie Versionskennung, Prüfsumme und Build-Herkunft. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Pipeline-Stufen benennen.** Schreibe die Stufen in eine sinnvolle Reihenfolge: Quelle
holen, bauen, testen, Sicherheits- und Dependency-Prüfung, Datenbank-Migration, paketieren, optional
ausliefern. Jede Stufe hat eine klare Aufgabe und ein klares Ergebnis. Bricht eine Stufe ab, stoppt die
Pipeline (Fail-Safe).

**EN:** **Step 1 – Name the pipeline stages.** Put the stages in a sensible order: get source, build, test,
security and dependency check, database migration, package, optionally deliver. Each stage has a clear task
and a clear result. If a stage fails, the pipeline stops (fail-safe).

**DE:** **Schritt 2 – Builds reproduzierbar machen.** Ein Build ist nur dann ein Nachweis, wenn er
wiederholbar ist. Dafür werden Versionen festgesetzt (kein „neueste Version") und Lockfiles genutzt. So
entsteht aus demselben Quellstand dasselbe Artefakt. Je Sprache gibt es passende Werkzeuge, etwa Lockfiles für
Paketmanager.

**EN:** **Step 2 – Make builds reproducible.** A build is evidence only if it is repeatable. For this,
versions are pinned (no "latest version") and lockfiles are used. Then the same source state yields the same
artifact. Each language has suitable tools, e.g. lockfiles for package managers.

**DE:** **Schritt 3 – Datenbank-Migration und Prüfungen einplanen.** Die Pipeline führt Schema-Migrationen
versioniert aus und prüft danach an fiktiven Testdaten (Northwind inkl. `ALFKI`), ob die Plattform noch
korrekt liest und schreibt. Zusätzlich prüft sie Abhängigkeiten auf bekannte Schwachstellen. Findet eine
Prüfung ein kritisches Problem, soll die Pipeline warnen oder abbrechen.

**EN:** **Step 3 – Plan database migration and checks.** The pipeline runs schema migrations in a versioned
way and then checks against fictitious test data (Northwind incl. `ALFKI`) whether the platform still reads
and writes correctly. It also checks dependencies for known vulnerabilities. If a check finds a critical
problem, the pipeline should warn or stop.

**DE:** **Schritt 4 – Release-Nachweise führen.** Zu jedem Release gehören eine Versionskennung, eine
Prüfsumme des Artefakts und die Build-Herkunft (aus welchem Quellstand). Damit lässt sich später beweisen,
dass eine betriebene Plattform genau aus dem geprüften Stand kommt. Ohne Nachweis ist ein Release nur eine
Behauptung.

**EN:** **Step 4 – Keep release evidence.** Every release has a version identifier, an artifact checksum, and
the build provenance (from which source state). This lets you later prove that an operated platform comes
exactly from the reviewed state. Without evidence, a release is only a claim.

**DE:** **Typische Fehler.** „Neueste Version" statt festgesetzter Versionen nutzen. Migrationen ungeprüft
oder ohne Rückfallweg fahren. Tests aus der Pipeline weglassen, um Zeit zu sparen. Datenbank-Zugangsdaten im
Klartext in die Pipeline schreiben. Keine Release-Nachweise führen, sodass die Herkunft eines Artefakts unklar
bleibt.

**EN:** **Common mistakes.** Using "latest version" instead of pinned versions. Running migrations unchecked
or without a fallback. Dropping tests from the pipeline to save time. Writing database credentials in
plaintext into the pipeline. Keeping no release evidence, so an artifact's origin stays unclear.

### Beispiel / Example

```text
Pipeline-Stufen:  1) Quelle  2) Build  3) Test  4) Dependency-/Sicherheitsprüfung  5) DB-Migration  6) Paketieren  7) Release
Reproduzierbar:   Versionen festgesetzt + Lockfile  -> gleicher Quellstand = gleiches Artefakt
DB-Migration:     Schema v3 -> v4, geprüft an Testdaten (ALFKI vorhanden)   -> Nachweis: Migrations-Log
Sicherheit:       Dependency-Scan bricht bei kritischer CVE ab              -> Nachweis: Pipeline-Log
Release-Nachweis: Version 1.2.0, Prüfsumme sha256:<...>, Quellstand-Kennung dokumentiert
Secrets:          nur als Platzhalter <PLATZHALTER-KEIN-ECHTER-WERT>, echte Werte im Secret-Store
C#-Referenz:      InventarWorkerService als Orientierung eines langlaufenden Dienstes
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10b Serverdienste bereitstellen und Administrationsaufgaben automatisieren | Primär / Primary | Die Pipeline automatisiert Build, Test, Migration und Auslieferung der Plattform. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Das reproduzierbare Artefakt ist die Grundlage der Dienstbereitstellung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Lieferkette, reproduzierbare Builds, Testbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Lieferkette/Dependency),
`CL_08` (Sicherheits-Review), `CL_11` (CI/Release) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung
dieser Einheit lautet: *Nur ein reproduzierbarer, geprüfter Build mit Herkunftsnachweis und geprüfter Migration
gilt als Release; Datenbank-Zugangsdaten stehen niemals im Klartext in der Pipeline.* A11Y-Aspekt: Pipeline-
Stufen und Release-Nachweise werden als klare, nummerierte Textschritte dokumentiert, ohne reine
Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure supply chain, reproducible builds, testability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (supply chain/dependency),
`CL_08` (security review), `CL_11` (CI/release), and `CL_12` (documentation/N-A). The security decision of this
unit is: *only a reproducible, checked build with provenance and a verified migration counts as a release;
database credentials are never in plaintext in the pipeline.* Accessibility aspect: pipeline stages and release
evidence are documented as clear, numbered text steps, without color-only marking, so they stay usable with a
screen reader or Braille display.

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

3. **DE:** Warum gehört ein Datenbank-Migrationsschritt in die Pipeline der Handelsplattform? /
   **EN:** Why does a database migration step belong in the trading platform's pipeline?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Code und Schema müssen zusammenpassen. Ein versionierter, geprüfter Migrationsschritt zieht das
   Northwind-Schema mit und prüft an Testdaten (z. B. `ALFKI`), dass Lesen und Schreiben weiter korrekt sind.
   **EN:** Code and schema must match. A versioned, checked migration step moves the Northwind schema along and
   verifies against test data (e.g. `ALFKI`) that reading and writing remain correct.

   </details>

4. **DE:** (SI) Wie weist du nach, dass eine betriebene Plattform aus dem geprüften Quellstand stammt? /
   **EN:** (SI) How do you prove that an operated platform comes from the reviewed source state?

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

6. **DE:** Warum dürfen Datenbank-Zugangsdaten nicht im Klartext in der Pipeline stehen? /
   **EN:** Why must database credentials not be in plaintext in the pipeline?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Pipeline-Konfiguration und Logs sind oft breit sichtbar oder versioniert. Ein Zugangsdatum im
   Klartext landet so schnell in fremden Händen. Deshalb: nur Platzhalter im Text, echte Werte im Secret-Store.
   **EN:** Pipeline configuration and logs are often widely visible or versioned. A plaintext credential quickly
   ends up in the wrong hands. Therefore: only placeholders in the text, real values in the secret store.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Stufen einer CI/CD-Pipeline inklusive Datenbank-Migration in sinnvoller Reihenfolge benennen.
- [ ] erklären, was einen Build reproduzierbar macht.
- [ ] Sicherheits- und Dependency-Prüfungen als Pipeline-Schritt einplanen.
- [ ] Release-Nachweise (Version, Prüfsumme, Herkunft) benennen.
- [ ] begründen, warum Datenbank-Zugangsdaten nicht im Klartext in die Pipeline gehören.

**EN:** I can …

- [ ] name the stages of a CI/CD pipeline including database migration in a sensible order.
- [ ] explain what makes a build reproducible.
- [ ] plan security and dependency checks as a pipeline step.
- [ ] name release evidence (version, checksum, provenance).
- [ ] justify why database credentials do not belong in plaintext in the pipeline.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
