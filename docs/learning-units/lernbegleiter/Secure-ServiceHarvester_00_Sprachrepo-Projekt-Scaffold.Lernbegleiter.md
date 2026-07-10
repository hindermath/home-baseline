# Lernbegleiter: Secure ServiceHarvester 00 – Sprachrepo-Projekt-Scaffold / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_00_Sprachrepo-Projekt-Scaffold.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

> **Start / Start:** Arbeite zuerst
> [`START-HERE-FUER-LERNENDE.md`](../START-HERE-FUER-LERNENDE.md) und den
> [`Secure-Trader-Sandbox-Preflight`](../Secure-Trader-Sandbox-Preflight.md)
> durch. Starte einen Agenten nur in der Podman-Sandbox.

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bevor man ein Haus einrichtet, muss das Fundament stehen. Genauso braucht jede spätere fachliche
Aufgabe des Secure ServiceHarvester ein sauberes **Projektgerüst** (Scaffold). In dieser Einheit legst du für
genau eine Zielsprache ein minimales, lauffähiges Projekt an: Es lässt sich bauen, ein erster Test läuft, die
Build- und Testbefehle sind dokumentiert und die Governance-Grundlage ist vorhanden. Noch ohne echte
Harvester-Logik – also ohne Sammeln, ohne Ablage, ohne Zeitplan. Ein gutes Gerüst spart später viel Zeit,
weil alle folgenden Aufgaben auf demselben verlässlichen Startpunkt aufsetzen.

**EN:** Before you furnish a house, the foundation must be there. In the same way, every later functional task
of the Secure ServiceHarvester needs a clean **project scaffold**. In this unit you create a minimal, runnable
project for exactly one target language: it builds, a first test runs, the build and test commands are
documented, and the governance baseline is in place. Still without real harvester logic – no collecting, no
storage, no schedule. A good scaffold saves a lot of time later, because all following tasks start from the
same reliable point.

**DE:** Der spätere ServiceHarvester ist ein **langlaufender Dienst** (Worker). Als C#-Referenz dient das
Projekt `InventarWorkerService`, ein Worker-Service-Projekttyp. In dieser Einheit lernst du, eine minimale
Projektstruktur zu wählen, Build- und Testkommandos zu dokumentieren, die sechs Governance-Presets
nachzuweisen und die lokale Secure-Development-Basis zu prüfen – ohne Fachlogik vorwegzunehmen.

**EN:** The later ServiceHarvester is a **long-running service** (worker). The C# reference is the project
`InventarWorkerService`, a worker-service project type. In this unit you learn to choose a minimal project
structure, document build and test commands, prove the six governance presets, and check the local
secure-development baseline – without anticipating any domain logic.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Projektgerüst / Scaffold | Minimale, lauffähige Grundstruktur eines Projekts ohne Fachlogik. |
| Worker-Service / Worker service | Projekttyp für einen dauerhaft laufenden Hintergrunddienst. |
| Build | Vorgang, der Quellcode in ein ausführbares Ergebnis übersetzt. |
| Reproduzierbarkeit / Reproducibility | Eigenschaft, dass ein Lauf auf einem anderen Rechner gleich funktioniert. |
| Governance-Preset | Vordefinierter Regelsatz, der Sicherheit und Qualität im Spec-Kit-Lauf steuert. |
| Secure-Development-Basis / Baseline | Zentrale sichere-Entwicklung-Grundlage unter `docs/secure-development/`. |
| Blocker | Dokumentiertes Hindernis, das eine Aufgabe (noch) verhindert. |
| Container / Sandbox | Abgeschottete Umgebung, in der Werkzeuge und KI-Agenten laufen, ohne den echten Rechner zu berühren. |
| Container-First-Gate | Regel: Ein KI-Agent wird nur im Container gestartet, nie direkt auf dem Arbeitsplatz-Rechner. |
| KI-Agent / AI agent | Werkzeug wie Codex, Claude, Copilot oder Gemini, das Dateien liest/schreibt und Befehle ausführt. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Eine Sprache wählen.** Wähle genau eine der sechs MSL-Zielsprachen (C#, Go, Java,
Python, Rust, Swift). Ein Gerüst pro Sprache reicht. Warum nur eine? Weil die Einheit die Grundlage testet,
nicht die Sprachvielfalt. Zu viele Baustellen gleichzeitig verstecken Fehler.

**EN:** **Step 1 – Choose one language.** Pick exactly one of the six MSL target languages (C#, Go, Java,
Python, Rust, Swift). One scaffold per language is enough. Why only one? Because this unit tests the
foundation, not the variety of languages. Too many open sites at once hide mistakes.

**DE:** **Schritt 2 – Minimale Struktur anlegen.** Erzeuge das kleinste sinnvolle Projekt: ein Programm plus
ein Testprojekt. Beispiele: ein `.NET` Worker- oder Console-Projekt für C# (Referenz `InventarWorkerService`),
`go.mod` für Go, Maven/Gradle für Java, ein Paket mit `pytest` für Python, `cargo` für Rust, ein Swift-Package.
Warum so klein? Ein kleines Gerüst ist leicht zu prüfen und schnell reparierbar.

**EN:** **Step 2 – Create a minimal structure.** Build the smallest reasonable project: one program plus one
test project. Examples: a `.NET` worker or console project for C# (reference `InventarWorkerService`),
`go.mod` for Go, Maven/Gradle for Java, a package with `pytest` for Python, `cargo` for Rust, a Swift package.
Why so small? A small scaffold is easy to check and quick to fix.

**DE:** **Schritt 3 – Build und Test dokumentieren.** Schreibe die genauen Befehle auf, mit denen man das
Projekt baut und testet (z. B. `dotnet test`, `go test ./...`, `cargo test`, `swift test`). Warum
dokumentieren? Ohne notierte Befehle ist ein Lauf nicht reproduzierbar, und andere können ihn nicht
wiederholen.

**EN:** **Step 3 – Document build and test.** Write down the exact commands to build and test the project
(e.g. `dotnet test`, `go test ./...`, `cargo test`, `swift test`). Why document? Without noted commands a run
is not reproducible, and others cannot repeat it.

**DE:** **Schritt 4 – Governance und Secure-Development prüfen.** Weise die sechs Governance-Presets nach,
z. B. mit `specify preset list`. Prüfe, ob `docs/secure-development/` als Arbeitsbasis vorhanden ist. Fehlt
etwas, wird es als **Blocker** oder `Open` mit konkretem Behebungsweg dokumentiert – nicht stillschweigend
übersprungen.

**EN:** **Step 4 – Check governance and secure development.** Prove the six governance presets, e.g. with
`specify preset list`. Check whether `docs/secure-development/` exists as a working baseline. If something is
missing, document it as a **blocker** or `Open` with a concrete fix path – do not silently skip it.

**DE:** **Schritt 5 – Container-First-Gate, bevor du einen KI-Agenten startest.** Wenn du in diesem Schritt
einen KI-Agenten (z. B. Codex, Claude, Copilot, Gemini) nutzt, startest du ihn **im Container bzw. in der
freigegebenen Sandbox** (`absdd-image-sandbox`), **nie** direkt auf deinem Arbeitsplatz-Rechner. Warum? Ein
Agent kann Dateien schreiben und Befehle ausführen; im Container bleibt ein Fehlgriff eingegrenzt, deine
privaten Daten und Zugangsdaten sind geschützt. Arbeite die Preflight-Checkliste aus
`Secure-Trader-Sandbox-Preflight.md` ab. Nutzt du keinen Agenten, hältst du das als `N/A` mit Begründung fest.
Lesen, Review und Tippen ohne Agent dürfen auf dem Host bleiben.

**EN:** **Step 5 – Container-first gate before you start an AI agent.** If you use an AI agent in this step
(e.g. Codex, Claude, Copilot, Gemini), you start it **inside the container or approved sandbox**
(`absdd-image-sandbox`), **never** directly on your workstation. Why? An agent can write files and run
commands; inside the container a mistake stays contained and your private data and credentials are protected.
Work through the preflight checklist in `Secure-Trader-Sandbox-Preflight.md`. If you do not use an agent,
record this as `N/A` with a reason. Reading, review, and typing without an agent may stay on the host.

**DE:** **Typische Fehler.** Fachlogik zu früh einbauen (z. B. schon jetzt einen Sammel-Timer). Build- oder
Testbefehle nur im Kopf behalten. Fehlende Presets ignorieren. Echte Daten, Secrets oder private Pfade in
Beispielausgaben. Mehrere Sprachen gleichzeitig anfangen und keine sauber fertigstellen. **Einen KI-Agenten
direkt auf dem Arbeitsplatz-Rechner statt im Container starten.**

**EN:** **Common mistakes.** Adding domain logic too early (e.g. a collection timer already now). Keeping
build or test commands only in your head. Ignoring missing presets. Real data, secrets, or private paths in
sample output. Starting several languages at once and finishing none cleanly. **Starting an AI agent directly
on the workstation instead of inside the container.**

### Beispiel / Example

```text
Sprache:        Go
Struktur:       go mod init serviceharvester  (plus ein Basistest in main_test.go)
Build:          go build ./...      -> OK
Test:           go test ./...       -> 1 passed
Presets:        specify preset list -> 6 Presets sichtbar (security, architecture, isaqb, a11y, cross, agent)
Secure-Dev:     docs/secure-development/ vorhanden -> Applicable
Fachlogik:      KEINE (Sammeln, Ablage, Zeitplan bewusst N/A in diesem Schritt)
Secrets:        keine; Beispielwert nur als <PLATZHALTER-KEIN-ECHTER-WERT>
Blocker:        keiner  (sonst: "Open: govulncheck fehlt, Folgeaufgabe in spaeterer Einheit")
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Arbeitsorganisation und die eigene Rolle prägen, wie ein reproduzierbares Projektgerüst für den Dienst entsteht. |
| LF 2 Arbeitsplätze nach Kundenwunsch ausstatten | Berührt / Touched | Die eingerichtete, lauffähige Entwicklungsumgebung ist die technische Ausstattung des Arbeitsplatzes. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Das Container-First-Gate schützt den eigenen Arbeitsbereich: KI-Agenten laufen isoliert, nicht auf dem Arbeitsplatz-Rechner. |

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

**DE:** Zusätzliche Sicherheitsentscheidung: *Container-First für KI-Agenten.* Wird ein Agent genutzt, läuft er
im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner (Grundlage `Secure-Trader-Sandbox-Preflight.md`,
`CL_12`). In ISO/IEC-27001-zertifizierten Organisationen ist das ein pruefbarer Kontrollpunkt (u. a. A.8.25,
A.8.31), kein Komfort.

**EN:** Additional security decision: *container-first for AI agents.* If an agent is used, it runs inside the
container/sandbox, never on the workstation (basis `Secure-Trader-Sandbox-Preflight.md`, `CL_12`). In
ISO/IEC 27001-certified organizations this is an auditable control point (e.g. A.8.25, A.8.31), not a
convenience.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum wird in dieser Einheit noch keine Harvester-Fachlogik gebaut? /
   **EN:** Why is no harvester domain logic built in this unit yet?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Einheit prüft nur die Grundlage: Build, Test, Doku, Presets und Secure-Development-Basis. Erst
   wenn dieses Fundament sicher steht, können spätere Aufgaben wie Sammeln oder Ablage verlässlich darauf
   aufsetzen.
   **EN:** The unit only checks the foundation: build, test, docs, presets, and the secure-development
   baseline. Only when this foundation is solid can later tasks such as collecting or storage build on it
   reliably.

   </details>

2. **DE:** (AE) Welche minimale Struktur braucht eine Sprache, damit spätere Dienst-Logik sauber ergänzt werden kann? /
   **EN:** (AE) What minimal structure does a language need so later service logic can be added cleanly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mindestens ein lauffähiges Programm und ein Testprojekt mit klaren Erweiterungspunkten. So kann
   neue Logik – etwa ein Sammelintervall – ergänzt werden, ohne das Gerüst umzubauen.
   **EN:** At least one runnable program and a test project with clear extension points. New logic – such as a
   collection interval – can then be added without rebuilding the scaffold.

   </details>

3. **DE:** (SI) Warum müssen Build- und Testbefehle dokumentiert sein und nicht nur einmal ausgeführt werden? /
   **EN:** (SI) Why must build and test commands be documented, not just run once?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Dokumentierte Befehle machen den Lauf reproduzierbar. Andere Personen oder ein anderer Rechner
   können ihn wiederholen; ein nur im Kopf gehaltener Befehl geht verloren.
   **EN:** Documented commands make the run reproducible. Other people or another machine can repeat it; a
   command kept only in your head gets lost.

   </details>

4. **DE:** Was passiert mit einem fehlenden Preset oder einer fehlenden Secure-Development-Datei? /
   **EN:** What happens with a missing preset or a missing secure-development file?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es wird nicht stillschweigend übersprungen, sondern als Blocker oder `Open` mit konkretem
   Behebungsweg dokumentiert. So bleibt der Zustand ehrlich und nachvollziehbar.
   **EN:** It is not silently skipped but documented as a blocker or `Open` with a concrete fix path. This
   keeps the status honest and traceable.

   </details>

5. **DE:** (DPA) Welche Datenannahmen zu Statusdaten dürfen im Scaffold noch nicht vorweggenommen werden? /
   **EN:** (DPA) Which status-data assumptions must not be anticipated in the scaffold?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Felder wie `name`, `os`, `last_contact`, Ablageform, Import/Export und Kennzahlen sind hier `N/A`.
   Sie gehören in spätere Aufgaben; hier gäbe es sonst falsche, ungeprüfte Annahmen.
   **EN:** Fields such as `name`, `os`, `last_contact`, storage form, import/export, and metrics are `N/A`
   here. They belong to later tasks; otherwise there would be wrong, unverified assumptions.

   </details>

6. **DE:** (DV) Warum bleibt in diesem Schritt jede Schnittstellen- oder Netzwerkannahme des späteren Dienstes bewusst offen? /
   **EN:** (DV) Why does every interface or network assumption of the later service stay deliberately open in this step?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Gerüst soll nur bauen und testen. Ob der Dienst später über Netzwerk, Dateiimport oder CLI
   sammelt, ist eine Fachentscheidung. Frühe, ungeprüfte Netzwerkannahmen erzeugen unnötige Angriffsfläche.
   **EN:** The scaffold should only build and test. Whether the service later collects via network, file
   import, or CLI is a functional decision. Early, unverified network assumptions create unnecessary attack
   surface.

   </details>

7. **DE:** Warum sollen Beispielausgaben keine echten Namen, Tokens oder privaten Pfade enthalten? /
   **EN:** Why should sample output contain no real names, tokens, or private paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Angaben können personenbezogene Daten oder Secrets preisgeben. Neutrale Beispiele und klare
   Platzhalter wie `<PLATZHALTER-KEIN-ECHTER-WERT>` schützen den Datenschutz und verhindern versehentliche
   Leaks in einem öffentlichen Lernrepo.
   **EN:** Real values can expose personal data or secrets. Neutral examples and clear placeholders like
   `<PLATZHALTER-KEIN-ECHTER-WERT>` protect privacy and prevent accidental leaks in a public learning
   repository.

   </details>

8. **DE:** Warum muss ein KI-Agent im Container laufen und nicht direkt auf dem Arbeitsplatz-Rechner? /
   **EN:** Why must an AI agent run inside the container and not directly on the workstation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Agent kann Dateien schreiben, Befehle ausführen und auf das Netzwerk zugreifen. Ohne Isolation
   trifft das den echten Rechner mit privaten Daten, Zugangsdaten und anderen Projekten. Im Container gelten
   klare Grenzen (Mounts, Schreibrechte, Netzwerk), und ein Fehlgriff bleibt eingegrenzt. In
   ISO-27001-zertifizierten Organisationen ist das ein pruefbarer Kontrollpunkt, kein Komfort.
   **EN:** An agent can write files, run commands, and access the network. Without isolation this hits the real
   machine with private data, credentials, and other projects. Inside the container clear limits apply
   (mounts, write permissions, network), and a mistake stays contained. In ISO-27001-certified organizations
   this is an auditable control point, not a convenience.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] genau eine MSL-Zielsprache wählen und ein minimales lauffähiges Projekt anlegen.
- [ ] Build- und Testbefehle vollständig dokumentieren.
- [ ] die sechs Governance-Presets und die Secure-Development-Basis nachweisen.
- [ ] fehlende Werkzeuge als Blocker oder `Open` statt als stille Lücke behandeln.
- [ ] begründen, warum in diesem Schritt keine Fachlogik entsteht.
- [ ] das Container-First-Gate anwenden: einen KI-Agenten nur im Container starten, nie auf dem Arbeitsplatz-Rechner.

**EN:** I can …

- [ ] choose exactly one MSL target language and create a minimal runnable project.
- [ ] fully document the build and test commands.
- [ ] prove the six governance presets and the secure-development baseline.
- [ ] treat missing tools as a blocker or `Open` rather than a silent gap.
- [ ] explain why no domain logic is created in this step.
- [ ] apply the container-first gate: start an AI agent only inside the container, never on the workstation.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_00_Sprachrepo-Projekt-Scaffold.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_00_Sprachrepo-Projekt-Scaffold.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
