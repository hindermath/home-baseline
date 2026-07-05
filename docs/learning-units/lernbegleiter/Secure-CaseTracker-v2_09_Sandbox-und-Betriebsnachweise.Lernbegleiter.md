# Lernbegleiter: Secure CaseTracker v2 09 – Sandbox- und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_09_Sandbox-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Software läuft nicht im luftleeren Raum, sondern in einer **Umgebung**: mit Konfiguration, Secrets,
Dateizugriffen und Rechten. Eine **Sandbox** ist eine bewusst eingegrenzte Umgebung, in der ein Programm (oder
ein KI-Agent) nur das darf, was ausdrücklich erlaubt ist – begrenzte Schreibrechte, kein unnötiger
Netzzugang, klar getrennte Secrets. Das öffentliche Referenz-Repo dazu ist
`https://github.com/hindermath/absdd-image-sandbox`. Wer ohne Grenzen arbeitet, riskiert, dass ein Fehler
oder ein bösartiger Aufruf das ganze System berührt.

**EN:** Software does not run in a vacuum but in an **environment**: with configuration, secrets, file access,
and rights. A **sandbox** is a deliberately bounded environment in which a program (or an AI agent) may only
do what is explicitly allowed – limited write rights, no unnecessary network access, clearly separated
secrets. The public reference repo for this is `https://github.com/hindermath/absdd-image-sandbox`. Whoever
works without boundaries risks that a mistake or a malicious call touches the whole system.

**DE:** Wichtig für das 2. Lehrjahr: Die Sandbox ist hier ein **vorbereitetes Betriebs- und Nachweiskonzept**.
Praktische Sandbox-Nutzung ist noch **keine harte Pflicht** – sie darf begründet `N/A` oder `Open` bleiben.
Allgemeine Codearbeit, Lesen und Review in IDEs wie JetBrains, VS Code oder Windows-only Visual Studio dürfen
außerhalb der Sandbox stattfinden. Ab dem 3. Lehrjahr wird sichere Sandbox-Nutzung verpflichtender. In dieser
Einheit planst du **Konfiguration**, **Secrets**, **Schreibgrenzen**, **Laufzeitannahmen** und
**Betriebsnachweise** und entscheidest dokumentiert, ob die Nutzung `Applicable`, `N/A` oder `Open` ist.

**EN:** Important for year 2: the sandbox here is a **prepared operational and evidence concept**. Practical
sandbox use is not yet a **hard requirement** – it may stay justified `N/A` or `Open`. General code work,
reading, and review in IDEs like JetBrains, VS Code, or Windows-only Visual Studio may happen outside the
sandbox. From year 3, secure sandbox use becomes more binding. In this unit you plan **configuration**,
**secrets**, **write limits**, **runtime assumptions**, and **operational evidence**, and decide, documented,
whether use is `Applicable`, `N/A`, or `Open`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Sandbox / Sandbox | Bewusst eingegrenzte Umgebung mit minimalen Rechten und Zugriffen. |
| Secret / Secret | Vertrauliches Zugangsmerkmal (z. B. Token), das nie in den Code gehört. |
| Schreibgrenze / Write boundary | Festlegung, wohin ein Prozess überhaupt schreiben darf. |
| Betriebsnachweis / Operational evidence | Beleg, dass Betriebsannahmen eingehalten werden. |
| Least Privilege / Least privilege | Nur die minimal nötigen Rechte vergeben. |
| Reproduzierbarkeit / Reproducibility | Gleiche Umgebung erzeugt überall dasselbe, prüfbare Verhalten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Betriebsumgebung beschreiben.** Halte fest, welche Konfiguration das System braucht,
woher sie kommt und welche Laufzeitannahmen gelten (Betriebssystem, Verzeichnisse, Netz). **Warum wichtig:**
Nur eine benannte Umgebung lässt sich absichern und reproduzieren. Unklare Umgebung heißt unklare
Angriffsfläche.

**EN:** **Step 1 – Describe the operating environment.** Record which configuration the system needs, where it
comes from, and which runtime assumptions apply (operating system, directories, network). **Why it matters:**
only a named environment can be secured and reproduced. An unclear environment means an unclear attack
surface.

**DE:** **Schritt 2 – Secrets sauber trennen.** Secrets gehören nie in den Quellcode oder in getrackte
Konfigurationsdateien, sondern in einen plattformgeeigneten Secret-Store (z. B. Schlüsselbund/Keychain).
**Warum wichtig:** Ein Secret im Code landet in der Historie und ist praktisch nicht mehr zurückzuholen; das
ist eine der häufigsten echten Sicherheitspannen.

**EN:** **Step 2 – Separate secrets cleanly.** Secrets never belong in the source code or in tracked config
files but in a platform-appropriate secret store (e.g. keychain). **Why it matters:** a secret in the code
ends up in the history and is practically impossible to recall; this is one of the most common real security
incidents.

**DE:** **Schritt 3 – Schreibgrenzen und Least Privilege festlegen.** Bestimme, wohin der Prozess schreiben
darf (z. B. nur ein Arbeitsverzeichnis) und welche Rechte er wirklich braucht. **Warum wichtig:** Enge
Schreibgrenzen begrenzen den Schaden, wenn etwas schiefgeht. Ein Prozess, der überallhin schreiben darf, ist
ein großes Risiko.

**EN:** **Step 3 – Define write limits and least privilege.** Determine where the process may write (e.g. only
a working directory) and which rights it really needs. **Why it matters:** tight write limits contain the
damage when something goes wrong. A process that may write anywhere is a large risk.

**DE:** **Schritt 4 – Nachweise und Jahr-2-Abgrenzung dokumentieren.** Verlinke die Public-Sandbox, beschreibe
die Betriebsnachweise (Backup, Incident als `Applicable`/`N/A`) und triff die dokumentierte Entscheidung, ob
praktische Sandbox-Nutzung jetzt `Applicable`, `N/A` oder `Open` ist – mit Begründung. **Warum wichtig:** Im
2. Lehrjahr wird die Nutzung nicht stillschweigend vorausgesetzt; die bewusste Entscheidung ist selbst der
Nachweis.

**EN:** **Step 4 – Document evidence and the year-2 delimitation.** Link the public sandbox, describe the
operational evidence (backup, incident as `Applicable`/`N/A`), and make the documented decision whether
practical sandbox use is now `Applicable`, `N/A`, or `Open` – with a rationale. **Why it matters:** in year 2,
use is not silently assumed; the deliberate decision is itself the evidence.

**DE:** **Typische Fehler.** Secrets in Code oder Config committen. Keine Schreibgrenze setzen. Praktische
Nutzung stillschweigend voraussetzen oder pauschal überspringen ohne Begründung. Umgebung nicht beschreiben,
sodass niemand sie reproduzieren kann. IDE-Arbeit und Sandbox-Arbeit vermischen ohne klare Abgrenzung.

**EN:** **Common mistakes.** Committing secrets into code or config. Setting no write limit. Silently assuming
practical use or skipping it flatly without a rationale. Not describing the environment so nobody can
reproduce it. Mixing IDE work and sandbox work without a clear delimitation.

### Beispiel / Example

```text
Betriebsannahmen (Auszug):
  Konfiguration: aus Umgebungsvariablen, NICHT aus getracktem Code
  Secrets:       im Schluesselbund/Keychain; niemals im Repo
  Schreibgrenze: nur ./work/ ; keine Systemverzeichnisse
  Netz:          standardmaessig kein ausgehender Zugriff (Least Privilege)

Jahr-2-Entscheidung (dokumentiert):
  Public-Sandbox: https://github.com/hindermath/absdd-image-sandbox
  Praktische Nutzung: Open  (Begruendung: Sandbox-Kompetenz wird ab Jahr 3 verpflichtend;
                             jetzt Konzept vorbereitet, Nutzung als Folgeaufgabe)
  IDE-Arbeit:     JetBrains/VS Code/Visual Studio ausserhalb der Sandbox erlaubt
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Sandbox und Betriebsnachweise gehören zum sicheren Bereitstellen von Diensten. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Schreibgrenzen, Secrets und Least Privilege setzen den Schutzbedarf im Betrieb um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Konfiguration, Least Privilege, sichere Architektur
und auditfähige Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_07` (sichere
Konfiguration/Secrets), `CL_08` (Sicherheits-Code-Review), `CL_09` (Betrieb/Deployment) und `CL_12`
(Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Der Prozess arbeitet mit
minimalen Rechten und getrennten Secrets, und die Sandbox-Nutzung wird bewusst entschieden statt
stillschweigend vorausgesetzt.* A11Y-Aspekt: Betriebs- und Nachweisdokumente müssen als klarer Text lesbar
sein; Entscheidungen (`Applicable`/`N/A`/`Open`) dürfen nicht nur an Farbe hängen, damit Screenreader- und
Braille-Nutzende sie erfassen.

**EN:** Relation to the Secure Development Guideline: secure configuration, least privilege, secure
architecture, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_07` (secure
configuration/secrets), `CL_08` (security code review), `CL_09` (operation/deployment), and `CL_12` (evidence
/ N/A rationale). The security decision of this unit is: *the process works with minimal rights and separated
secrets, and sandbox use is decided deliberately instead of silently assumed.* Accessibility aspect:
operational and evidence documents must be readable as clear text; decisions (`Applicable`/`N/A`/`Open`) must
not depend on color alone, so screen-reader and Braille users can grasp them.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Sandbox, und welchen Schutz bietet sie? /
   **EN:** What is a sandbox, and which protection does it offer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine bewusst eingegrenzte Umgebung mit minimalen Rechten und Zugriffen. Sie begrenzt den Schaden,
   wenn ein Programm oder Agent fehlerhaft oder bösartig handelt.
   **EN:** A deliberately bounded environment with minimal rights and access. It limits the damage if a program
   or agent acts faultily or maliciously.

   </details>

2. **DE:** Warum gehören Secrets nie in den Quellcode oder getrackte Config? /
   **EN:** Why do secrets never belong in the source code or tracked config?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Secret im Code landet in der Historie und lässt sich praktisch nicht mehr zurückholen. Es gehört
   in einen Secret-Store wie den Schlüsselbund.
   **EN:** A secret in the code ends up in the history and is practically impossible to recall. It belongs in a
   secret store like the keychain.

   </details>

3. **DE:** (SI) Warum sind enge Schreibgrenzen und Least Privilege im Betrieb wichtig? /
   **EN:** (SI) Why are tight write limits and least privilege important in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie begrenzen den Schaden, wenn etwas schiefgeht. Ein Prozess, der nur in ein Arbeitsverzeichnis
   schreibt und minimale Rechte hat, kann nicht das ganze System berühren.
   **EN:** They contain the damage when something goes wrong. A process that only writes to a working directory
   and has minimal rights cannot touch the whole system.

   </details>

4. **DE:** Warum darf im 2. Lehrjahr die praktische Sandbox-Nutzung als `N/A` oder `Open` dokumentiert werden? /
   **EN:** Why may practical sandbox use be documented as `N/A` or `Open` in year 2?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Im 2. Lehrjahr ist die Sandbox ein vorbereitetes Konzept, noch keine harte Pflicht. Die Nutzung darf
   begründet aufgeschoben werden; ab Jahr 3 wird sie verpflichtender.
   **EN:** In year 2 the sandbox is a prepared concept, not yet a hard requirement. Use may be deferred with a
   rationale; from year 3 it becomes more binding.

   </details>

5. **DE:** Warum ist die dokumentierte Entscheidung `Applicable`/`N/A`/`Open` selbst ein Nachweis? /
   **EN:** Why is the documented decision `Applicable`/`N/A`/`Open` itself an evidence item?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie zeigt, dass die Frage bewusst geprüft und begründet wurde, statt sie stillschweigend zu
   überspringen. Das bleibt auditfähig.
   **EN:** It shows the question was deliberately reviewed and justified instead of silently skipped. That stays
   auditable.

   </details>

6. **DE:** (DPA) Wie schützt eine klare Betriebsumgebung die Datenqualität und Datensicherheit? /
   **EN:** (DPA) How does a clear operating environment protect data quality and data security?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine benannte, reproduzierbare Umgebung mit klaren Schreib- und Zugriffsgrenzen verhindert
   ungewollte Datenänderungen und macht Vorgänge nachvollziehbar.
   **EN:** A named, reproducible environment with clear write and access limits prevents unwanted data changes
   and makes processes traceable.

   </details>

7. **DE:** Warum ist die Abgrenzung zwischen IDE-Arbeit und Sandbox-Arbeit sinnvoll? /
   **EN:** Why is the delimitation between IDE work and sandbox work useful?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Lesen, Review und allgemeine Codearbeit in IDEs sind außerhalb der Sandbox erlaubt; die eng
   begrenzte Ausführung gehört später in die Sandbox. Die klare Abgrenzung verhindert falsche Erwartungen.
   **EN:** Reading, review, and general code work in IDEs are allowed outside the sandbox; the tightly bounded
   execution belongs in the sandbox later. The clear delimitation prevents false expectations.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Betriebsumgebung mit Konfiguration und Laufzeitannahmen beschreiben.
- [ ] Secrets sicher vom Code und von getrackter Config trennen.
- [ ] Schreibgrenzen und Least Privilege festlegen.
- [ ] die Jahr-2-Entscheidung `Applicable`/`N/A`/`Open` mit Begründung dokumentieren.
- [ ] IDE-Arbeit und spätere Sandbox-Nutzung klar abgrenzen.

**EN:** I can …

- [ ] describe the operating environment with configuration and runtime assumptions.
- [ ] separate secrets securely from code and tracked config.
- [ ] define write limits and least privilege.
- [ ] document the year-2 decision `Applicable`/`N/A`/`Open` with a rationale.
- [ ] clearly delimit IDE work and later sandbox use.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_09_Sandbox-und-Betriebsnachweise.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_09_Sandbox-und-Betriebsnachweise.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
