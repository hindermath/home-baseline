# Lernbegleiter: Secure OrderDesk 08 – Lieferanten, Supply Chain und MSL-Bewertung / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_08_Lieferanten-Supply-Chain-und-MSL-Bewertung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In dieser Einheit treffen zwei „Lieferketten" aufeinander, und du musst sie sauber trennen. Erstens die
**fachliche Lieferkette** der Handelsfirma: In Northwind gibt es die Tabelle `Suppliers` (Lieferanten), die
`Products` für Secure Trader liefern. Zweitens die **technische Lieferkette** deiner Software: fremde
**Abhängigkeiten** (Bibliotheken, Pakete), etwa für Datenbankzugriff, JSON oder Validierung. Diese Kette von
Zulieferern heißt **Supply Chain**. Wird eine Bibliothek kompromittiert oder ist sie ungepflegt, erbt deine
Plattform das Risiko. Du lernst, Abhängigkeiten mit Zweck, Quelle und Risikohinweis zu erfassen und je Sprache
ein **Audit-Werkzeug** zu nennen – inklusive der Bibliothek, die den relationalen Zugriff parametrisiert.
Außerdem bewertest du **Memory-Safe Languages (MSL)**: C#, Go, Java, Python, Rust und Swift reduzieren
Speicherfehler – aber sie lösen **nicht** automatisch Eingabeprüfung, I/O, Auth, SQL-Injection, Krypto, Logging
oder Dependency-Risiken. MSL ist kein Freifahrtschein und ersetzt keine Lieferkettenprüfung.

**EN:** In this unit two "supply chains" meet, and you must separate them cleanly. First the **business supply
chain** of the trading company: Northwind has a `Suppliers` table whose suppliers provide `Products` for Secure
Trader. Second the **technical supply chain** of your software: external **dependencies** (libraries,
packages), for example for database access, JSON, or validation. This chain of suppliers is called the **supply
chain**. If a library is compromised or unmaintained, your platform inherits the risk. You learn to record
dependencies with purpose, source, and a risk note, and to name an **audit tool** per language – including the
library that parameterizes relational access. You also assess **memory-safe languages (MSL)**: C#, Go, Java,
Python, Rust, and Swift reduce memory errors – but they do **not** automatically solve input validation, I/O,
auth, SQL injection, crypto, logging, or dependency risks. MSL is not a free pass and does not replace a
supply-chain review.

**DE:** Zusätzlich entscheidest du über SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open`. Solange nur
Entwicklungswerkzeuge genutzt und keine KI-Runtime in der Plattform ausgeliefert wird, ist AI-SBOM `N/A`.

**EN:** You also decide about SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`. As long as only
development tools are used and no AI runtime is shipped in the platform, AI-SBOM is `N/A`.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Fachlicher Lieferant / Business supplier | Northwind-`Suppliers`-Eintrag, der Produkte für die Handelsfirma liefert. |
| Supply Chain / Lieferkette | Kette aller fremden Software-Abhängigkeiten und Werkzeuge eines Projekts. |
| Abhängigkeit / Dependency | Externe Bibliothek oder Paket, das deine Plattform nutzt. |
| Memory-Safe Language (MSL) | Sprache, die viele Speicherfehler durch das Sprachdesign verhindert. |
| Lockfile | Datei, die exakte Abhängigkeitsversionen festhält. |
| SBOM | Software Bill of Materials: Stückliste aller enthaltenen Komponenten. |
| Audit-Werkzeug / Audit tool | Programm, das Abhängigkeiten auf bekannte Schwachstellen prüft. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Zwei Lieferketten trennen.** Halte die fachlichen Lieferanten (`Suppliers` in Northwind,
liefern Produkte an Secure Trader) klar getrennt von den technischen Abhängigkeiten (Bibliotheken deiner
Software). Warum? Es sind verschiedene Risiken: Ein fachlicher Lieferant betrifft Handelsdaten, eine technische
Abhängigkeit betrifft die Sicherheit deines Codes. Wer beides vermischt, verliert die Übersicht.

**EN:** **Step 1 – Separate two supply chains.** Keep the business suppliers (`Suppliers` in Northwind,
providing products to Secure Trader) clearly separate from the technical dependencies (your software's
libraries). Why? They are different risks: a business supplier concerns trading data, a technical dependency
concerns the security of your code. Mixing both loses the overview.

**DE:** **Schritt 2 – Technische Abhängigkeiten erfassen.** Liste je Sprache die genutzten Abhängigkeiten mit
Zweck und Quelle, inklusive der Bibliothek für parametrisierten Datenzugriff. Neue Abhängigkeit ohne Zweck?
Dann gehört sie nicht in die Plattform. Warum? Jede Abhängigkeit vergrößert die Angriffsfläche; nur begründete
Pakete sind vertretbar. Im 1. Lehrjahr bleibt die Plattform einfach, also ist die Liste bewusst kurz.

**EN:** **Step 2 – Record technical dependencies.** For each language, list the used dependencies with purpose
and source, including the library for parameterized data access. A new dependency without a purpose? Then it
does not belong in the platform. Why? Every dependency increases the attack surface; only justified packages
are acceptable. In year 1 the platform stays simple, so the list is deliberately short.

**DE:** **Schritt 3 – Audit-Werkzeug je Sprache nennen.** Beispiele: NuGet-Audit (C#), `govulncheck` (Go),
Maven-/Gradle-Audit oder OWASP Dependency-Check (Java), `pip-audit` (Python), `cargo audit` (Rust),
Abhängigkeitsprüfung im Swift Package Manager (Swift). Warum? Ein Audit findet bekannte kritische Schwachstellen,
bevor sie in die laufende Plattform gelangen. Plane zusätzlich Lockfiles oder vergleichbare Versionsnachweise,
damit klar ist, welche Version wirklich im Build steckt.

**EN:** **Step 3 – Name an audit tool per language.** Examples: NuGet audit (C#), `govulncheck` (Go),
Maven/Gradle audit or OWASP Dependency-Check (Java), `pip-audit` (Python), `cargo audit` (Rust), dependency
review in the Swift Package Manager (Swift). Why? An audit finds known critical vulnerabilities before they
reach the running platform. Also plan lockfiles or comparable version evidence, so it is clear which version is
really in the build.

**DE:** **Schritt 4 – MSL ehrlich bewerten.** Halte für alle sechs Sprachen dieselbe Aussage fest:
Speicherfehler werden reduziert, andere Sicherheitsklassen bleiben prüfpflichtig. Formuliere MSL **nie** als
pauschale Sicherheitsfreigabe. Warum? Ein Puffer-Überlauf ist bei MSL selten, aber SQL-Injection aus
Bestelleingaben, fehlende Autorisierung oder unsichere Deserialisierung sind in der Plattform weiter möglich.

**EN:** **Step 4 – Assess MSL honestly.** For all six languages, keep the same statement: memory errors are
reduced, other security classes still require review. Never phrase MSL as a blanket security clearance. Why? A
buffer overflow is rare with MSL, but SQL injection from order input, missing authorization, or unsafe
deserialization are still possible in the platform.

**DE:** **Typische Fehler.** Fachliche und technische Lieferkette vermischen. Abhängigkeiten ohne Zweck
aufnehmen. Kein Audit-Werkzeug benennen. Keine Lockfiles. MSL als „ist ja sicher" missverstehen. Tokens oder
private Registry-Zugangsdaten in Nachweisen. Bei AI-SBOM etwas erfinden, obwohl keine KI-Runtime ausgeliefert
wird.

**EN:** **Common mistakes.** Mixing the business and technical supply chains. Adding dependencies without a
purpose. Naming no audit tool. No lockfiles. Misreading MSL as "it's safe anyway". Tokens or private registry
credentials in evidence. Inventing an AI-SBOM even though no AI runtime is shipped.

### Beispiel / Example

```text
Fachlich (Northwind):  Suppliers -> liefern Products an Secure Trader (Handelsdaten, fiktiv).
Technisch (Software):
Sprache   Abhaengigkeit   Zweck               Quelle        Audit-Werkzeug   Lockfile
Rust      sqlx            parametrisiert DB   crates.io     cargo audit      Cargo.lock
Python    (db-api)        parametrisiert DB   PyPI          pip-audit        uv.lock
Go        database/sql    parametrisiert DB   golang.org    govulncheck      go.sum

MSL-Aussage (fuer alle 6):  "Speicherfehler reduziert; Eingabe, Auth, SQL-Injection, Crypto, Logging, Deps bleiben pruefpflichtig."
Registry-Token:  <PLATZHALTER-KEIN-ECHTER-WERT>  -> niemals echt in Nachweis/Log
SBOM:      Applicable (releasefaehige Lern-Plattform) ODER Open (Tooling noch offen)
AI-SBOM:   N/A  -> nur Entwicklungswerkzeuge, keine KI-Runtime in der ausgelieferten Plattform
VEX:       N/A  -> keine bekannte Schwachstelle zu bewerten
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Der Schutzbedarf der technischen Lieferkette und die Werkzeugbewertung sind Kern der Einheit. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Paketquellen, Registries und Audit-Dienste sind Teil der bereitgestellten Toolchain. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: MSL-Präferenz, Supply-Chain-Sicherheit und sichere
Code-Erzeugung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten/Supply-Chain), `CL_08` (Sicherheits-Code-Review) und `CL_09` (Testmanagement/Nachweise). Die
Sicherheitsentscheidung dieser Einheit lautet: *Fachliche und technische Lieferkette werden getrennt, jede
Abhängigkeit hat Zweck, Quelle und Audit, und MSL wird nie als pauschale Sicherheitsfreigabe verstanden.*
A11Y-Aspekt: Dependency- und MSL-Bewertungen werden als Texttabellen geführt, ohne reine Farbsignale, damit sie
mit Screenreader und Braille-Zeile prüfbar bleiben.

**EN:** Relation to the Secure Development Guideline: MSL preference, supply-chain security, and secure code
generation. Matching checklists: `CL_01` (standards applicability), `CL_05` (dependencies/supply chain),
`CL_08` (security code review), and `CL_09` (test management/evidence). The security decision of this unit is:
*business and technical supply chains are separated, every dependency has purpose, source, and audit, and MSL
is never understood as a blanket security clearance.* Accessibility aspect: dependency and MSL assessments are
kept as text tables, without color-only signals, so they remain reviewable with a screen reader and Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist MSL keine pauschale Sicherheitsfreigabe? /
   **EN:** Why is MSL not a blanket security clearance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** MSL reduziert vor allem Speicherfehler. Eingabeprüfung, Autorisierung, SQL-Injection, Krypto, Logging
   und Dependencies bleiben trotzdem prüfpflichtig; diese Fehlerklassen verschwinden nicht durch die Sprache.
   **EN:** MSL mainly reduces memory errors. Input validation, authorization, SQL injection, crypto, logging,
   and dependencies still require review; these error classes do not disappear because of the language.

   </details>

2. **DE:** Warum müssen fachliche Lieferanten und technische Abhängigkeiten getrennt werden? /
   **EN:** Why must business suppliers and technical dependencies be separated?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie betreffen verschiedene Risiken: Ein fachlicher Lieferant (Northwind `Suppliers`) gehört zu den
   Handelsdaten, eine technische Abhängigkeit zur Codesicherheit. Getrennt bleiben beide prüfbar.
   **EN:** They concern different risks: a business supplier (Northwind `Suppliers`) belongs to the trading
   data, a technical dependency to code security. Kept separate, both stay reviewable.

   </details>

3. **DE:** (SI) Wie beweist du, welche Versionen im Build der Plattform verwendet wurden? /
   **EN:** (SI) How do you prove which versions were used in the platform build?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über Lockfiles oder vergleichbare Versionsnachweise, z. B. `Cargo.lock` oder `go.sum`. Sie halten die
   exakten Versionen fest und machen ein Audit belastbar.
   **EN:** Through lockfiles or comparable version evidence, e.g. `Cargo.lock` or `go.sum`. They pin the exact
   versions and make an audit reliable.

   </details>

4. **DE:** (AE) Welche Bibliothek würdest du vermeiden, wenn sie ungepflegt ist? /
   **EN:** (AE) Which library would you avoid if it is unmaintained?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Bibliothek ohne aktuelle Pflege oder mit bekannten kritischen CVEs, besonders im
   Datenzugriffspfad. Sie erbt Risiken an die Plattform; besser ist eine gepflegte Alternative oder die
   Standardbibliothek.
   **EN:** A library without current maintenance or with known critical CVEs, especially in the data access
   path. It passes risks to the platform; a maintained alternative or the standard library is better.

   </details>

5. **DE:** (DPA) Welche Risiken entstehen, wenn Reporting- oder Datenbibliotheken ungeprüft bleiben? /
   **EN:** (DPA) Which risks arise if reporting or data libraries stay unchecked?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Falsche Auswertungen, versteckte Schwachstellen und manipulierte Kennzahlen der Handelsdaten. Ein
   Umsatzbericht ist nur so vertrauenswürdig wie die genutzten Werkzeuge und Bibliotheken.
   **EN:** Wrong evaluations, hidden vulnerabilities, and manipulated metrics of the trading data. A revenue
   report is only as trustworthy as the tools and libraries it uses.

   </details>

6. **DE:** (DV) Warum gehören Paketquellen und Registries zur bereitgestellten Lieferkette der Plattform? /
   **EN:** (DV) Why do package sources and registries belong to the platform's provided supply chain?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Plattform bezieht ihre Bausteine über das Netz aus Registries. Diese Quellen sind bereitgestellte
   Dienste, deren Erreichbarkeit, Vertrauen und Versionierung mitgeplant werden müssen.
   **EN:** The platform obtains its building blocks over the network from registries. These sources are provided
   services whose availability, trust, and versioning must be planned as well.

   </details>

7. **DE:** Warum ist AI-SBOM in dieser Lernreihe meist `N/A`? /
   **EN:** Why is AI-SBOM usually `N/A` in this learning series?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil KI nur als Entwicklungswerkzeug genutzt wird und keine KI-Runtime, kein Modell und keine
   KI-Komponente in der ausgelieferten Plattform steckt. Die `N/A`-Entscheidung wird mit Toolchain-Begründung
   notiert.
   **EN:** Because AI is only used as a development tool, with no AI runtime, model, or AI component in the
   shipped platform. The `N/A` decision is recorded with a toolchain rationale.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] fachliche Lieferanten (Northwind `Suppliers`) von technischen Abhängigkeiten trennen.
- [ ] Abhängigkeiten mit Zweck, Quelle und Risikohinweis erfassen.
- [ ] je Zielsprache ein passendes Audit-Werkzeug und die Bibliothek für parametrisierten Zugriff benennen.
- [ ] MSL ehrlich bewerten, ohne pauschale Sicherheitsfreigabe.
- [ ] SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open` begründen.

**EN:** I can …

- [ ] separate business suppliers (Northwind `Suppliers`) from technical dependencies.
- [ ] record dependencies with purpose, source, and a risk note.
- [ ] name a suitable audit tool per target language and the library for parameterized access.
- [ ] assess MSL honestly, without a blanket security clearance.
- [ ] justify SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_08_Lieferanten-Supply-Chain-und-MSL-Bewertung.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_08_Lieferanten-Supply-Chain-und-MSL-Bewertung.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
