# Lernbegleiter: Secure CaseTracker 08 – Supply Chain und MSL-Bewertung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_08_Supply-Chain-und-MSL-Bewertung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Moderne Software besteht selten nur aus eigenem Code. Sie nutzt viele fremde **Abhängigkeiten**
(Bibliotheken, Pakete). Diese Kette von Zulieferern heißt **Supply Chain** (Lieferkette). Wird eine Bibliothek
kompromittiert oder ist sie ungepflegt, erbt dein Projekt das Risiko. In dieser Einheit lernst du,
Abhängigkeiten mit Zweck, Quelle und Risikohinweis zu erfassen und je Sprache ein **Audit-Werkzeug** zu
nennen. Außerdem bewertest du **Memory-Safe Languages (MSL)**: C#, Go, Java, Python, Rust und Swift reduzieren
Speicherfehler – aber sie lösen **nicht** automatisch Eingabeprüfung, I/O, Auth, SQL, Krypto, Logging oder
Dependency-Risiken. MSL ist kein Freifahrtschein.

**EN:** Modern software rarely consists only of your own code. It uses many external **dependencies**
(libraries, packages). This chain of suppliers is called the **supply chain**. If a library is compromised or
unmaintained, your project inherits the risk. In this unit you learn to record dependencies with purpose,
source, and a risk note, and to name an **audit tool** per language. You also assess **memory-safe languages
(MSL)**: C#, Go, Java, Python, Rust, and Swift reduce memory errors – but they do **not** automatically solve
input validation, I/O, auth, SQL, crypto, logging, or dependency risks. MSL is not a free pass.

**DE:** Zusätzlich entscheidest du über SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open`. Solange nur
Entwicklungswerkzeuge genutzt und keine KI-Runtime ausgeliefert wird, ist AI-SBOM `N/A`.

**EN:** You also decide about SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`. As long as only
development tools are used and no AI runtime is shipped, AI-SBOM is `N/A`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Supply Chain / Lieferkette | Kette aller fremden Abhängigkeiten und Werkzeuge eines Projekts. |
| Abhängigkeit / Dependency | Externe Bibliothek oder Paket, das dein Code nutzt. |
| Memory-Safe Language (MSL) | Sprache, die viele Speicherfehler durch das Sprachdesign verhindert. |
| Lockfile | Datei, die exakte Abhängigkeitsversionen festhält. |
| SBOM | Software Bill of Materials: Stückliste aller enthaltenen Komponenten. |
| Audit-Werkzeug / Audit tool | Programm, das Abhängigkeiten auf bekannte Schwachstellen prüft. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Abhängigkeiten erfassen.** Liste je Sprache die genutzten Abhängigkeiten mit Zweck und
Quelle. Neue Abhängigkeit ohne Zweck? Dann gehört sie nicht ins Projekt. Warum? Jede Abhängigkeit vergrößert
die Angriffsfläche; nur begründete Pakete sind vertretbar.

**EN:** **Step 1 – Record dependencies.** For each language, list the used dependencies with purpose and
source. A new dependency without a purpose? Then it does not belong in the project. Why? Every dependency
increases the attack surface; only justified packages are acceptable.

**DE:** **Schritt 2 – Audit-Werkzeug je Sprache nennen.** Beispiele: NuGet-Audit (C#), `govulncheck` (Go),
Maven/Gradle-Audit oder OWASP Dependency-Check (Java), `pip-audit` (Python), `cargo audit` (Rust),
Abhängigkeitsprüfung im Swift Package Manager. Warum? Ein Audit findet bekannte kritische Schwachstellen, bevor
sie ausgeliefert werden.

**EN:** **Step 2 – Name an audit tool per language.** Examples: NuGet audit (C#), `govulncheck` (Go),
Maven/Gradle audit or OWASP Dependency-Check (Java), `pip-audit` (Python), `cargo audit` (Rust), dependency
review in the Swift Package Manager. Why? An audit finds known critical vulnerabilities before they ship.

**DE:** **Schritt 3 – Versionen festhalten.** Plane Lockfiles oder vergleichbare Versionsnachweise. Warum?
Ohne feste Versionen weiß niemand, welche Abhängigkeit wirklich im Build steckt; ein Audit ist dann nicht
belastbar.

**EN:** **Step 3 – Pin versions.** Plan lockfiles or comparable version evidence. Why? Without fixed versions,
nobody knows which dependency is really in the build; an audit is then not reliable.

**DE:** **Schritt 4 – MSL ehrlich bewerten.** Halte für alle sechs Sprachen dieselbe Aussage fest:
Speicherfehler werden reduziert, andere Sicherheitsklassen bleiben prüfpflichtig. Formuliere MSL **nie** als
pauschale Sicherheitsfreigabe. Warum? Ein Puffer-Überlauf ist bei MSL selten, aber SQL-Injection, fehlende
Autorisierung oder unsichere Deserialisierung sind weiter möglich.

**EN:** **Step 4 – Assess MSL honestly.** For all six languages, keep the same statement: memory errors are
reduced, other security classes still require review. Never phrase MSL as a blanket security clearance. Why? A
buffer overflow is rare with MSL, but SQL injection, missing authorization, or unsafe deserialization are
still possible.

**DE:** **Typische Fehler.** Abhängigkeiten ohne Zweck aufnehmen. Kein Audit-Werkzeug benennen. Keine
Lockfiles. MSL als „ist ja sicher" missverstehen. Tokens oder private Registry-Zugangsdaten in Nachweisen. Bei
AI-SBOM einfach etwas erfinden, obwohl keine KI-Runtime ausgeliefert wird.

**EN:** **Common mistakes.** Adding dependencies without a purpose. Naming no audit tool. No lockfiles.
Misreading MSL as "it's safe anyway". Tokens or private registry credentials in evidence. Inventing an AI-SBOM
even though no AI runtime is shipped.

### Beispiel / Example

```text
Sprache   Abhaengigkeit   Zweck               Quelle        Audit-Werkzeug   Lockfile
Rust      serde           JSON/Datenmodell    crates.io     cargo audit      Cargo.lock
Python    pydantic        Validierung         PyPI          pip-audit        requirements/uv.lock
Go        (stdlib)        JSON, Pfade         golang.org    govulncheck      go.sum

MSL-Aussage (fuer alle 6):  "Speicherfehler reduziert; Eingabe, Auth, SQL, Crypto, Logging, Deps bleiben pruefpflichtig."
SBOM:      Applicable (releasefaehiges Lernartefakt) ODER Open (Tooling noch offen)
AI-SBOM:   N/A  -> nur Entwicklungswerkzeuge, keine KI-Runtime im ausgelieferten System
VEX:       N/A  -> keine bekannte Schwachstelle zu bewerten
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Der Schutzbedarf der Lieferkette und die Werkzeugbewertung sind Kern der Einheit. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Paketquellen, Registries und Audit-Dienste sind Teil der bereitgestellten Toolchain. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: MSL-Präferenz, Supply-Chain-Sicherheit und sichere
Code-Erzeugung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten/Supply-Chain), `CL_08` (Sicherheits-Code-Review) und `CL_09` (Testmanagement/Nachweise). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jede Abhängigkeit hat Zweck, Quelle und Audit, und MSL wird
nie als pauschale Sicherheitsfreigabe verstanden.* A11Y-Aspekt: Dependency- und MSL-Bewertungen werden als
Texttabellen geführt, ohne reine Farbsignale, damit sie mit Screenreader und Braille-Zeile prüfbar bleiben.

**EN:** Relation to the Secure Development Guideline: MSL preference, supply-chain security, and secure code
generation. Matching checklists: `CL_01` (standards applicability), `CL_05` (dependencies/supply chain),
`CL_08` (security code review), and `CL_09` (test management/evidence). The security decision of this unit is:
*every dependency has purpose, source, and audit, and MSL is never understood as a blanket security
clearance.* Accessibility aspect: dependency and MSL assessments are kept as text tables, without color-only
signals, so they remain reviewable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist MSL keine pauschale Sicherheitsfreigabe? /
   **EN:** Why is MSL not a blanket security clearance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** MSL reduziert vor allem Speicherfehler. Eingabeprüfung, Autorisierung, SQL, Krypto, Logging und
   Dependencies bleiben trotzdem prüfpflichtig; diese Fehlerklassen verschwinden nicht durch die Sprache.
   **EN:** MSL mainly reduces memory errors. Input validation, authorization, SQL, crypto, logging, and
   dependencies still require review; these error classes do not disappear because of the language.

   </details>

2. **DE:** (SI) Wie beweist du, welche Versionen im Build verwendet wurden? /
   **EN:** (SI) How do you prove which versions were used in the build?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über Lockfiles oder vergleichbare Versionsnachweise, z. B. `Cargo.lock` oder `go.sum`. Sie halten
   die exakten Versionen fest und machen ein Audit belastbar.
   **EN:** Through lockfiles or comparable version evidence, e.g. `Cargo.lock` or `go.sum`. They pin the exact
   versions and make an audit reliable.

   </details>

3. **DE:** (AE) Welche Bibliothek würdest du vermeiden, wenn sie ungepflegt ist? /
   **EN:** (AE) Which library would you avoid if it is unmaintained?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Bibliothek ohne aktuelle Pflege oder mit bekannten kritischen CVEs. Sie erbt Risiken an das
   Projekt; besser ist eine gepflegte Alternative oder die Standardbibliothek.
   **EN:** A library without current maintenance or with known critical CVEs. It passes risks to the project; a
   maintained alternative or the standard library is better.

   </details>

4. **DE:** (DPA) Welche Risiken entstehen, wenn Analysebibliotheken ungeprüft bleiben? /
   **EN:** (DPA) Which risks arise if analysis libraries stay unchecked?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Falsche Ergebnisse, versteckte Schwachstellen und manipulierte Auswertungen. Datenanalyse ist nur so
   vertrauenswürdig wie die genutzten Werkzeuge und Bibliotheken.
   **EN:** Wrong results, hidden vulnerabilities, and manipulated evaluations. Data analysis is only as
   trustworthy as the tools and libraries it uses.

   </details>

5. **DE:** Warum ist AI-SBOM in dieser Lernreihe meist `N/A`? /
   **EN:** Why is AI-SBOM usually `N/A` in this learning series?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil KI nur als Entwicklungswerkzeug genutzt wird und keine KI-Runtime, kein Modell und keine
   KI-Komponente im ausgelieferten System steckt. Die `N/A`-Entscheidung wird mit Toolchain-Begründung notiert.
   **EN:** Because AI is only used as a development tool, with no AI runtime, model, or AI component in the
   shipped system. The `N/A` decision is recorded with a toolchain rationale.

   </details>

6. **DE:** Warum braucht jede neue Abhängigkeit Zweck und Quelle? /
   **EN:** Why does every new dependency need a purpose and source?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Abhängigkeit vergrößert die Angriffsfläche. Zweck und Quelle machen die Entscheidung prüfbar
   und verhindern, dass unnötige oder unbekannte Pakete ins Projekt gelangen.
   **EN:** Every dependency increases the attack surface. Purpose and source make the decision reviewable and
   prevent unnecessary or unknown packages from entering the project.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Abhängigkeiten mit Zweck, Quelle und Risikohinweis erfassen.
- [ ] je Zielsprache ein passendes Audit-Werkzeug benennen.
- [ ] Lockfiles oder Versionsnachweise einplanen.
- [ ] MSL ehrlich bewerten, ohne pauschale Sicherheitsfreigabe.
- [ ] SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open` begründen.

**EN:** I can …

- [ ] record dependencies with purpose, source, and a risk note.
- [ ] name a suitable audit tool per target language.
- [ ] plan lockfiles or version evidence.
- [ ] assess MSL honestly, without a blanket security clearance.
- [ ] justify SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_08_Supply-Chain-und-MSL-Bewertung.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_08_Supply-Chain-und-MSL-Bewertung.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
