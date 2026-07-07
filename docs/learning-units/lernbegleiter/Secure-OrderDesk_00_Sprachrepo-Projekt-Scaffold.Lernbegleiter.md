# Lernbegleiter: Secure OrderDesk 00 – Sprachrepo-Projekt-Scaffold / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_00_Sprachrepo-Projekt-Scaffold.md`
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
Aufgabe des Secure OrderDesk ein sauberes **Projektgerüst** (Scaffold). In dieser Einheit legst du für genau
eine Zielsprache ein minimales, lauffähiges Projekt an: Es lässt sich bauen, ein erster Test läuft, die Build-
und Testbefehle sind dokumentiert und die Governance-Grundlage ist vorhanden. Noch ohne echte Handels- oder
Datenbanklogik – also ohne Kundenverwaltung, ohne Bestellungen, ohne SQL. Ein gutes Gerüst spart später viel
Zeit, weil alle folgenden Aufgaben auf demselben verlässlichen Startpunkt aufsetzen.

**EN:** Before you furnish a house, the foundation must be there. In the same way, every later functional task
of the Secure OrderDesk needs a clean **project scaffold**. In this unit you create a minimal, runnable project
for exactly one target language: it builds, a first test runs, the build and test commands are documented, and
the governance baseline is in place. Still without real trading or database logic – no customer management, no
orders, no SQL. A good scaffold saves a lot of time later, because all following tasks start from the same
reliable point.

**DE:** Der spätere OrderDesk ist eine **relationale Handels-/Bestellplattform** für die fiktive Handelsfirma
Secure Trader. Die verbindliche Datenbasis ist die klassische Northwind-Sample-DB inkl. Pflicht-Datensatz
`ALFKI` – aber erst in späteren Einheiten. In diesem Schritt wird die Datenbasis nur **benannt** und noch nicht
angebunden. Du lernst, eine minimale Projektstruktur zu wählen, Build- und Testkommandos zu dokumentieren, die
sechs Governance-Presets nachzuweisen und die lokale Secure-Development-Basis zu prüfen – ohne Fachlogik
vorwegzunehmen.

**EN:** The later OrderDesk is a **relational trading/ordering platform** for the fictional trading company
Secure Trader. The binding data base is the classic Northwind sample database incl. the mandatory record
`ALFKI` – but only in later units. In this step the data base is only **named** and not yet connected. You
learn to choose a minimal project structure, document build and test commands, prove the six governance
presets, and check the local secure-development baseline – without anticipating any domain logic.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Projektgerüst / Scaffold | Minimale, lauffähige Grundstruktur eines Projekts ohne Fachlogik. |
| Build | Vorgang, der Quellcode in ein ausführbares Ergebnis übersetzt. |
| Reproduzierbarkeit / Reproducibility | Eigenschaft, dass ein Lauf auf einem anderen Rechner gleich funktioniert. |
| Governance-Preset | Vordefinierter Regelsatz, der Sicherheit und Qualität im Spec-Kit-Lauf steuert. |
| Secure-Development-Basis / Baseline | Zentrale sichere-Entwicklung-Grundlage unter `docs/secure-development/`. |
| Northwind / Northwind | Klassische Beispiel-Handelsdatenbank; hier spätere, fiktive Datenquelle inkl. `ALFKI`. |
| Blocker | Dokumentiertes Hindernis, das eine Aufgabe (noch) verhindert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Eine Sprache wählen.** Wähle genau eine der sechs MSL-Zielsprachen (C#, Go, Java, Python,
Rust, Swift). Ein Gerüst pro Sprache reicht. Warum nur eine? Weil die Einheit die Grundlage testet, nicht die
Sprachvielfalt. Zu viele Baustellen gleichzeitig verstecken Fehler.

**EN:** **Step 1 – Choose one language.** Pick exactly one of the six MSL target languages (C#, Go, Java,
Python, Rust, Swift). One scaffold per language is enough. Why only one? Because this unit tests the
foundation, not the variety of languages. Too many open sites at once hide mistakes.

**DE:** **Schritt 2 – Minimale Struktur anlegen.** Erzeuge das kleinste sinnvolle Projekt: ein Programm plus
ein Testprojekt. Beispiele: ein `.NET` Console- oder Klassenbibliotheks-Projekt für C#, `go.mod` für Go,
Maven/Gradle für Java, ein Paket mit `pytest` für Python, `cargo` für Rust, ein Swift-Package. Warum so klein?
Ein kleines Gerüst ist leicht zu prüfen und schnell reparierbar. Datenbanktreiber oder ein ORM werden hier noch
**nicht** eingebunden.

**EN:** **Step 2 – Create a minimal structure.** Build the smallest reasonable project: one program plus one
test project. Examples: a `.NET` console or class-library project for C#, `go.mod` for Go, Maven/Gradle for
Java, a package with `pytest` for Python, `cargo` for Rust, a Swift package. Why so small? A small scaffold is
easy to check and quick to fix. Database drivers or an ORM are **not** wired in here yet.

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

**DE:** **Typische Fehler.** Fachlogik zu früh einbauen (z. B. schon jetzt eine Kunden- oder Bestelltabelle).
Datenbanktreiber oder echte Verbindungszeichenketten einbauen. Build- oder Testbefehle nur im Kopf behalten.
Fehlende Presets ignorieren. Echte Daten, Secrets oder private Pfade in Beispielausgaben. Mehrere Sprachen
gleichzeitig anfangen und keine sauber fertigstellen.

**EN:** **Common mistakes.** Adding domain logic too early (e.g. a customer or order table already now). Wiring
in database drivers or real connection strings. Keeping build or test commands only in your head. Ignoring
missing presets. Real data, secrets, or private paths in sample output. Starting several languages at once and
finishing none cleanly.

### Beispiel / Example

```text
Sprache:        Go
Struktur:       go mod init orderdesk  (plus ein Basistest in main_test.go)
Build:          go build ./...      -> OK
Test:           go test ./...       -> 1 passed
Presets:        specify preset list -> 6 Presets sichtbar (security, architecture, isaqb, a11y, cross, agent)
Secure-Dev:     docs/secure-development/ vorhanden -> Applicable
Fachlogik:      KEINE (Kunden, Produkte, Bestellungen, SQL bewusst N/A in diesem Schritt)
Datenbasis:     Northwind inkl. ALFKI nur benannt, noch NICHT angebunden -> Open fuer Einheit 02/06
Secrets:        keine; Verbindungszeichenkette nur als <PLATZHALTER-KEIN-ECHTER-WERT>
Blocker:        keiner  (sonst: "Open: DB-Treiber fehlt, Folgeaufgabe in spaeterer Einheit")
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Basis"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Secure OrderDesk Base"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 1 Das Unternehmen und die eigene Rolle im Betrieb beschreiben | Primär / Primary | Arbeitsorganisation und die eigene Rolle prägen, wie ein reproduzierbares Projektgerüst für die Handelsplattform entsteht. |
| LF 2 Arbeitsplätze nach Kundenwunsch ausstatten | Berührt / Touched | Die eingerichtete, lauffähige Entwicklungsumgebung ist die technische Ausstattung des Arbeitsplatzes. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Entwicklungsumgebung, MSL-Präferenz, sichere
Code-Erzeugung und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten/Toolchain), `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement), `CL_10`
(Kompetenz/Nachweis) und `CL_12` (sichere Sandbox/Umgebung). Die Sicherheitsentscheidung dieser Einheit
lautet: *Erst eine geprüfte, reproduzierbare Basis, dann Fachlogik und erst später die Datenbank.* A11Y-Aspekt:
Build- und Testanleitungen werden als klarer Text mit Sprach-Tag im Code-Block geschrieben, damit sie auch mit
Screenreader oder Braille-Zeile nutzbar sind; keine reinen Farbsignale für Erfolg oder Fehler.

**EN:** Relation to the Secure Development Guideline: secure development environment, MSL preference, secure
code generation, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05`
(dependencies/toolchain), `CL_08` (security code review), `CL_09` (test management), `CL_10`
(competence/evidence), and `CL_12` (secure sandbox/environment). The security decision of this unit is:
*first a verified, reproducible baseline, then domain logic, and only later the database.* Accessibility
aspect: build and test instructions are written as clear text with a language tag in the code block, so they
remain usable with a screen reader or Braille display; no color-only signals for success or failure.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum wird in dieser Einheit noch keine OrderDesk-Fachlogik und keine Datenbank gebaut? /
   **EN:** Why is no OrderDesk domain logic and no database built in this unit yet?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Einheit prüft nur die Grundlage: Build, Test, Doku, Presets und Secure-Development-Basis. Erst
   wenn dieses Fundament sicher steht, können spätere Aufgaben wie Domänenmodell oder SQL-Zugriffe verlässlich
   darauf aufsetzen.
   **EN:** The unit only checks the foundation: build, test, docs, presets, and the secure-development
   baseline. Only when this foundation is solid can later tasks such as the domain model or SQL access build on
   it reliably.

   </details>

2. **DE:** (AE) Welche minimale Struktur braucht eine Sprache, damit spätere Domänen- und Datenzugriffslogik sauber ergänzt werden kann? /
   **EN:** (AE) What minimal structure does a language need so later domain and data-access logic can be added cleanly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mindestens ein lauffähiges Programm und ein Testprojekt mit klaren Erweiterungspunkten. So kann neue
   Logik – etwa Entitäten oder eine parametrisierte Query – ergänzt werden, ohne das Gerüst umzubauen.
   **EN:** At least one runnable program and a test project with clear extension points. New logic – such as
   entities or a parameterized query – can then be added without rebuilding the scaffold.

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

5. **DE:** (DPA) Welche Annahmen zu Kunden- und Bestelldaten dürfen im reinen Gerüst noch nicht vorweggenommen werden? /
   **EN:** (DPA) Which customer- and order-data assumptions must not be anticipated in the pure scaffold?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Felder wie `CompanyName`, `OrderDate`, `Quantity`, die konkrete Tabellenstruktur, Import/Export und
   Auswertungen sind hier `N/A`. Sie gehören in spätere Aufgaben; hier gäbe es sonst falsche, ungeprüfte
   Annahmen über die Northwind-Daten.
   **EN:** Fields such as `CompanyName`, `OrderDate`, `Quantity`, the concrete table structure, import/export,
   and reporting are `N/A` here. They belong to later tasks; otherwise there would be wrong, unverified
   assumptions about the Northwind data.

   </details>

6. **DE:** Warum wird die Northwind-Datenbasis inkl. `ALFKI` schon jetzt benannt, aber noch nicht angebunden? /
   **EN:** Why is the Northwind data base incl. `ALFKI` already named but not yet connected?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Benennen zeigt die verbindliche Quelle für spätere Einheiten und macht die Planung ehrlich. Eine
   frühe Anbindung würde ungeprüfte Datenbank- und Verbindungsannahmen erzeugen und unnötige Angriffsfläche
   schaffen, bevor das Fundament steht.
   **EN:** Naming shows the binding source for later units and keeps planning honest. An early connection would
   create unverified database and connection assumptions and unnecessary attack surface before the foundation
   is solid.

   </details>

7. **DE:** Warum sollen Beispielausgaben keine echten Namen, Tokens, Verbindungszeichenketten oder privaten Pfade enthalten? /
   **EN:** Why should sample output contain no real names, tokens, connection strings, or private paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Angaben können personenbezogene Daten oder Secrets preisgeben. Neutrale Beispiele und klare
   Platzhalter wie `<PLATZHALTER-KEIN-ECHTER-WERT>` schützen den Datenschutz und verhindern versehentliche
   Leaks in einem öffentlichen Lernrepo.
   **EN:** Real values can expose personal data or secrets. Neutral examples and clear placeholders like
   `<PLATZHALTER-KEIN-ECHTER-WERT>` protect privacy and prevent accidental leaks in a public learning
   repository.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] genau eine MSL-Zielsprache wählen und ein minimales lauffähiges Projekt anlegen.
- [ ] Build- und Testbefehle vollständig dokumentieren.
- [ ] die sechs Governance-Presets und die Secure-Development-Basis nachweisen.
- [ ] fehlende Werkzeuge als Blocker oder `Open` statt als stille Lücke behandeln.
- [ ] die Northwind-Datenbasis inkl. `ALFKI` als spätere Quelle benennen, ohne sie schon anzubinden.
- [ ] begründen, warum in diesem Schritt keine Fachlogik und keine Datenbank entsteht.

**EN:** I can …

- [ ] choose exactly one MSL target language and create a minimal runnable project.
- [ ] fully document the build and test commands.
- [ ] prove the six governance presets and the secure-development baseline.
- [ ] treat missing tools as a blocker or `Open` rather than a silent gap.
- [ ] name the Northwind data base incl. `ALFKI` as the later source without connecting it yet.
- [ ] explain why no domain logic and no database is created in this step.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_00_Sprachrepo-Projekt-Scaffold.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_00_Sprachrepo-Projekt-Scaffold.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
