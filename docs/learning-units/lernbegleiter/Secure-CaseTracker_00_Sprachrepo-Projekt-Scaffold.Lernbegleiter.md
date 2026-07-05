# Lernbegleiter: Secure CaseTracker 00 – Sprachrepo-Projekt-Scaffold / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bevor man ein Haus einrichtet, muss das Fundament stehen. Genauso braucht jede spätere fachliche
Aufgabe des Secure CaseTracker ein sauberes **Projektgerüst** (Scaffold). In dieser Einheit legst du für
genau eine Zielsprache ein minimales, lauffähiges Projekt an: Es lässt sich bauen, ein erster Test läuft,
die Build- und Testbefehle sind dokumentiert und die Governance-Grundlage ist vorhanden. Noch ohne echte
CaseTracker-Logik. Ein gutes Gerüst spart später viel Zeit, weil alle folgenden Aufgaben auf demselben
verlässlichen Startpunkt aufsetzen.

**EN:** Before you furnish a house, the foundation must be there. In the same way, every later functional
task of the Secure CaseTracker needs a clean **project scaffold**. In this unit you create a minimal,
runnable project for exactly one target language: it builds, a first test runs, the build and test commands
are documented, and the governance baseline is in place. Still without real CaseTracker logic. A good
scaffold saves a lot of time later, because all following tasks start from the same reliable point.

**DE:** In dieser Einheit lernst du, eine minimale Projektstruktur zu wählen, Build- und Testkommandos zu
dokumentieren, die sechs Governance-Presets nachzuweisen und die lokale Secure-Development-Basis zu prüfen –
ohne Fachlogik vorwegzunehmen.

**EN:** In this unit you learn to choose a minimal project structure, document build and test commands, prove
the six governance presets, and check the local secure-development baseline – without anticipating any
domain logic.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Projektgerüst / Scaffold | Minimale, lauffähige Grundstruktur eines Projekts ohne Fachlogik. |
| Build | Vorgang, der Quellcode in ein ausführbares Ergebnis übersetzt. |
| Reproduzierbarkeit / Reproducibility | Eigenschaft, dass ein Lauf auf einem anderen Rechner gleich funktioniert. |
| Governance-Preset | Vordefinierter Regelsatz, der Sicherheit und Qualität im Spec-Kit-Lauf steuert. |
| Secure-Development-Basis / Baseline | Zentrale sichere-Entwicklung-Grundlage unter `docs/secure-development/`. |
| Blocker | Dokumentiertes Hindernis, das eine Aufgabe (noch) verhindert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Eine Sprache wählen.** Wähle genau eine der sechs MSL-Zielsprachen (C#, Go, Java,
Python, Rust, Swift). Ein Gerüst pro Sprache reicht. Warum nur eine? Weil die Einheit die Grundlage testet,
nicht die Sprachvielfalt. Zu viele Baustellen gleichzeitig verstecken Fehler.

**EN:** **Step 1 – Choose one language.** Pick exactly one of the six MSL target languages (C#, Go, Java,
Python, Rust, Swift). One scaffold per language is enough. Why only one? Because this unit tests the
foundation, not the variety of languages. Too many open sites at once hide mistakes.

**DE:** **Schritt 2 – Minimale Struktur anlegen.** Erzeuge das kleinste sinnvolle Projekt: ein Programm plus
ein Testprojekt. Beispiele: `dotnet` für C#, `go.mod` für Go, Maven/Gradle für Java, ein Paket mit `pytest`
für Python, `cargo` für Rust, ein Swift-Package. Warum so klein? Ein kleines Gerüst ist leicht zu prüfen und
schnell reparierbar.

**EN:** **Step 2 – Create a minimal structure.** Build the smallest reasonable project: one program plus one
test project. Examples: `dotnet` for C#, `go.mod` for Go, Maven/Gradle for Java, a package with `pytest` for
Python, `cargo` for Rust, a Swift package. Why so small? A small scaffold is easy to check and quick to fix.

**DE:** **Schritt 3 – Build und Test dokumentieren.** Schreibe die genauen Befehle auf, mit denen man das
Projekt baut und testet (z. B. `dotnet test`, `go test ./...`, `cargo test`). Warum dokumentieren? Ohne
notierte Befehle ist ein Lauf nicht reproduzierbar, und andere können ihn nicht wiederholen.

**EN:** **Step 3 – Document build and test.** Write down the exact commands to build and test the project
(e.g. `dotnet test`, `go test ./...`, `cargo test`). Why document? Without noted commands a run is not
reproducible, and others cannot repeat it.

**DE:** **Schritt 4 – Governance und Secure-Development prüfen.** Weise die sechs Governance-Presets nach,
z. B. mit `specify preset list`. Prüfe, ob `docs/secure-development/` als Arbeitsbasis vorhanden ist. Fehlt
etwas, wird es als **Blocker** oder `Open` mit konkretem Behebungsweg dokumentiert – nicht stillschweigend
übersprungen.

**EN:** **Step 4 – Check governance and secure development.** Prove the six governance presets, e.g. with
`specify preset list`. Check whether `docs/secure-development/` exists as a working baseline. If something is
missing, document it as a **blocker** or `Open` with a concrete fix path – do not silently skip it.

**DE:** **Typische Fehler.** Fachlogik zu früh einbauen. Build- oder Testbefehle nur im Kopf behalten.
Fehlende Presets ignorieren. Echte Daten, Secrets oder private Pfade in Beispielausgaben. Mehrere Sprachen
gleichzeitig anfangen und keine sauber fertigstellen.

**EN:** **Common mistakes.** Adding domain logic too early. Keeping build or test commands only in your head.
Ignoring missing presets. Real data, secrets, or private paths in sample output. Starting several languages
at once and finishing none cleanly.

### Beispiel / Example

```text
Sprache:        Rust
Struktur:       cargo new secure-casetracker --bin  (plus Basistest)
Build:          cargo build      -> OK
Test:           cargo test       -> 1 passed
Presets:        specify preset list -> 6 Presets sichtbar (security, architecture, isaqb, a11y, cross, agent)
Secure-Dev:     docs/secure-development/ vorhanden -> Applicable
Fachlogik:      KEINE (bewusst N/A in diesem Schritt)
Blocker:        keiner  (sonst: "Open: govulncheck fehlt, Folgeaufgabe in Einheit 08")
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Arbeitsorganisation und die eigene Rolle prägen, wie ein reproduzierbares Projektgerüst entsteht. |
| LF 2 Arbeitsplätze nach Kundenwunsch ausstatten | Berührt / Touched | Die eingerichtete, lauffähige Entwicklungsumgebung ist die technische Ausstattung des Arbeitsplatzes. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Entwicklungsumgebung, MSL-Präferenz, sichere
Code-Erzeugung und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten/Toolchain), `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement), `CL_10`
(Kompetenz/Nachweis) und `CL_12` (sichere Sandbox/Umgebung). Die Sicherheitsentscheidung dieser Einheit
lautet: *Erst eine geprüfte, reproduzierbare Basis, dann Fachlogik.* A11Y-Aspekt: Build- und Testanleitungen
werden als klarer Text mit Sprach-Tag im Code-Block geschrieben, damit sie auch mit Screenreader oder
Braille-Zeile nutzbar sind; keine reinen Farbsignale für Erfolg oder Fehler.

**EN:** Relation to the Secure Development Guideline: secure development environment, MSL preference, secure
code generation, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05`
(dependencies/toolchain), `CL_08` (security code review), `CL_09` (test management), `CL_10`
(competence/evidence), and `CL_12` (secure sandbox/environment). The security decision of this unit is:
*first a verified, reproducible baseline, then domain logic.* Accessibility aspect: build and test
instructions are written as clear text with a language tag in the code block, so they remain usable with a
screen reader or Braille display; no color-only signals for success or failure.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum wird in dieser Einheit noch keine CaseTracker-Fachlogik gebaut? /
   **EN:** Why is no CaseTracker domain logic built in this unit yet?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Einheit prüft nur die Grundlage: Build, Test, Doku, Presets und Secure-Development-Basis. Erst
   wenn dieses Fundament sicher steht, können spätere Aufgaben verlässlich darauf aufsetzen.
   **EN:** The unit only checks the foundation: build, test, docs, presets, and the secure-development
   baseline. Only when this foundation is solid can later tasks build on it reliably.

   </details>

2. **DE:** (SI) Warum müssen Build- und Testbefehle dokumentiert sein und nicht nur einmal ausgeführt werden? /
   **EN:** (SI) Why must build and test commands be documented, not just run once?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Dokumentierte Befehle machen den Lauf reproduzierbar. Andere Personen oder ein anderer Rechner
   können ihn wiederholen; ein nur im Kopf gehaltener Befehl geht verloren.
   **EN:** Documented commands make the run reproducible. Other people or another machine can repeat it; a
   command kept only in your head gets lost.

   </details>

3. **DE:** (AE) Welche minimale Struktur braucht eine Sprache, damit spätere Fachlogik sauber ergänzt werden kann? /
   **EN:** (AE) What minimal structure does a language need so later domain logic can be added cleanly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mindestens ein lauffähiges Programm und ein Testprojekt mit klaren Erweiterungspunkten. So kann
   neue Logik ergänzt werden, ohne das Gerüst umzubauen.
   **EN:** At least one runnable program and a test project with clear extension points. New logic can then be
   added without rebuilding the scaffold.

   </details>

4. **DE:** Was passiert mit einem fehlenden Preset oder einer fehlenden Secure-Development-Datei? /
   **EN:** What happens with a missing preset or a missing secure-development file?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es wird nicht stillschweigend übersprungen, sondern als Blocker oder `Open` mit konkretem
   Behebungsweg dokumentiert. So bleibt der Zustand ehrlich und nachvollziehbar.
   **EN:** It is not silently skipped but documented as a blocker or `Open` with a concrete fix path. This
   keeps the status honest and traceable.

   </details>

5. **DE:** (DPA) Welche Datenannahmen dürfen im Scaffold noch nicht vorweggenommen werden? /
   **EN:** (DPA) Which data assumptions must not be anticipated in the scaffold?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Rollen, Persistenz, Felder, Import/Export und Kennzahlen sind hier `N/A`. Sie gehören in spätere
   Aufgaben; hier gäbe es sonst falsche, ungeprüfte Annahmen.
   **EN:** Roles, persistence, fields, import/export, and metrics are `N/A` here. They belong to later tasks;
   otherwise there would be wrong, unverified assumptions.

   </details>

6. **DE:** Warum sollen Beispielausgaben keine echten Namen, Tokens oder privaten Pfade enthalten? /
   **EN:** Why should sample output contain no real names, tokens, or private paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Angaben können personenbezogene Daten oder Secrets preisgeben. Neutrale Beispiele schützen
   Datenschutz und verhindern versehentliche Leaks in einem öffentlichen Lernrepo.
   **EN:** Real values can expose personal data or secrets. Neutral examples protect privacy and prevent
   accidental leaks in a public learning repository.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] genau eine MSL-Zielsprache wählen und ein minimales lauffähiges Projekt anlegen.
- [ ] Build- und Testbefehle vollständig dokumentieren.
- [ ] die sechs Governance-Presets und die Secure-Development-Basis nachweisen.
- [ ] fehlende Werkzeuge als Blocker oder `Open` statt als stille Lücke behandeln.
- [ ] begründen, warum in diesem Schritt keine Fachlogik entsteht.

**EN:** I can …

- [ ] choose exactly one MSL target language and create a minimal runnable project.
- [ ] fully document the build and test commands.
- [ ] prove the six governance presets and the secure-development baseline.
- [ ] treat missing tools as a blocker or `Open` rather than a silent gap.
- [ ] explain why no domain logic is created in this step.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
