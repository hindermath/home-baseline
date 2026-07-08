# Lernbegleiter: Secure OrderDesk Operations Track 08 – Supply Chain, SBOM und Dependency-Audit / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Handelsplattform Secure OrderDesk besteht nicht nur aus eigenem Code, sondern nutzt viele fremde
Bibliotheken, zum Beispiel für den Datenbankzugriff, für Logging oder für Reporting. Diese Bibliotheken sind
die **technische Lieferkette** (Supply Chain). Wenn eine davon eine bekannte Schwachstelle (CVE) hat oder nicht
mehr gepflegt wird, wird die ganze Plattform unsicher. Eine **SBOM** (Software Bill of Materials, Stückliste
der Software) listet auf, welche Komponenten in welcher Version enthalten sind. Ein **Dependency-Audit** prüft
diese Komponenten je Zielsprache auf bekannte Probleme. Wichtig ist die Trennung: Die fachlichen Lieferanten
der Handelsdomäne (Northwind-Tabelle `Suppliers`, die Produkte für Secure Trader liefern) sind etwas anderes
als die technische Software-Lieferkette.

**EN:** The Secure OrderDesk trading platform consists not only of its own code but uses many third-party
libraries, for example for database access, logging, or reporting. These libraries are the **technical supply
chain**. If one of them has a known vulnerability (CVE) or is no longer maintained, the whole platform becomes
insecure. An **SBOM** (software bill of materials) lists which components in which version are included. A
**dependency audit** checks these components per target language for known problems. The separation matters:
the business suppliers of the trading domain (Northwind `Suppliers` table, providing products for Secure
Trader) are something different from the technical software supply chain.

**DE:** In dieser Einheit lernst du, eine SBOM als Nachweis zu verstehen, je Sprache Paketquelle und
Audit-Werkzeug zu benennen, die Bibliothek für parametrisierten Datenzugriff zu erfassen und den Umgang mit
bekannten Schwachstellen zu beschreiben. Zusätzlich bewertest du SBOM, AI-SBOM und VEX als `Applicable`, `N/A`
oder `Open`. Als C#-Referenz dient `InventarWorkerService`; die Idee bleibt für C#, Go, Java, Python, Rust und
Swift vergleichbar.

**EN:** In this unit you learn to understand an SBOM as evidence, to name per language the package source and
audit tool, to record the library for parameterized data access, and to describe how known vulnerabilities are
handled. You also assess SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`. The C# reference is
`InventarWorkerService`; the idea stays comparable across C#, Go, Java, Python, Rust, and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Supply Chain / Supply chain | Alle fremden Komponenten und Bezugswege, aus denen die Software besteht. |
| SBOM / SBOM | Stückliste der Software: welche Komponente in welcher Version enthalten ist. |
| Dependency-Audit / Dependency audit | Prüfung der Abhängigkeiten auf bekannte Schwachstellen. |
| CVE / CVE | Öffentlich bekannte Schwachstelle mit einer eindeutigen Kennung. |
| AI-SBOM / AI-SBOM | SBOM für KI-Komponenten; hier meist `N/A`, weil KI nur Werkzeug ist. |
| VEX / VEX | Aussage, ob eine bekannte Schwachstelle das Produkt betrifft oder nicht. |
| MSL / MSL | Speichersichere Sprache; reduziert Speicherfehler, nicht alle Risiken. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Fachliche und technische Lieferanten trennen.** Fachliche Lieferanten liefern Produkte
(Northwind-Tabelle `Suppliers`). Die technische Lieferkette liefert Software-Bibliotheken. Beide haben Risiken,
aber unterschiedliche. Halte sie klar auseinander, damit die Bewertung sauber bleibt.

**EN:** **Step 1 – Separate business and technical suppliers.** Business suppliers deliver products (Northwind
`Suppliers` table). The technical supply chain delivers software libraries. Both carry risks, but different
ones. Keep them clearly apart so the assessment stays clean.

**DE:** **Schritt 2 – SBOM als Nachweis verstehen.** Eine SBOM beantwortet die Frage: Was steckt genau in der
betriebenen Plattform? Ohne SBOM kann niemand sicher sagen, welche Version einer Bibliothek läuft. Mit SBOM
lässt sich bei einer neuen CVE schnell prüfen, ob man betroffen ist.

**EN:** **Step 2 – Understand the SBOM as evidence.** An SBOM answers the question: what exactly is inside the
operated platform? Without an SBOM nobody can say for sure which version of a library runs. With an SBOM, a new
CVE can be quickly checked for whether you are affected.

**DE:** **Schritt 3 – Audit je Sprache und Datenzugriff benennen.** Jede Zielsprache hat eine Paketquelle
(Registry) und ein Audit-Werkzeug für Dependency-Scans. Benenne zusätzlich die Bibliothek, die den relationalen
Datenzugriff mit **parametrisierten Queries** übernimmt, denn hier entscheidet sich der Schutz vor
SQL-Injection.

**EN:** **Step 3 – Name the audit per language and the data access.** Each target language has a package source
(registry) and an audit tool for dependency scans. Additionally name the library that handles relational data
access with **parameterized queries**, because this is where protection against SQL injection is decided.

**DE:** **Schritt 4 – Mit Schwachstellen umgehen und ehrlich zu MSL sein.** Eine bekannte kritische CVE wird
nicht ignoriert: bewerten, die Bibliothek aktualisieren oder ersetzen, oder das Restrisiko begründen. Und die
ehrliche Aussage zu MSL: Speichersichere Sprachen reduzieren Speicherfehler, aber SQL-Injection, falsche Auth
oder unsichere Deserialisierung bleiben unabhängig von der Sprache prüfpflichtig.

**EN:** **Step 4 – Handle vulnerabilities and be honest about MSL.** A known critical CVE is not ignored:
assess it, update or replace the library, or justify the residual risk. And the honest statement about MSL:
memory-safe languages reduce memory errors, but SQL injection, wrong auth, or unsafe deserialization remain to
be checked regardless of the language.

**DE:** **Typische Fehler.** Fachliche und technische Lieferanten vermischen. Keine SBOM führen. „Neueste
Version" ohne Lockfile nutzen. MSL als pauschale Sicherheitsfreigabe missverstehen. Kritische CVE ignorieren.
Registry-Tokens im Audit-Bericht offenlegen.

**EN:** **Common mistakes.** Mixing business and technical suppliers. Keeping no SBOM. Using "latest version"
without a lockfile. Misreading MSL as a blanket security clearance. Ignoring a critical CVE. Exposing registry
tokens in the audit report.

### Beispiel / Example

```text
Trennung:   fachlich = Northwind Suppliers (liefern Produkte)   |   technisch = Software-Bibliotheken
SBOM:        Liste aller Komponenten + Versionen der betriebenen Plattform
Sprache     Paketquelle     Audit-Werkzeug        DB-Zugriff (parametrisiert)
C#          NuGet           dependency scan       ADO.NET / ORM mit Parametern
Go          Go modules      govulncheck           database/sql mit Platzhaltern
Java        Maven Central   dependency scan       JDBC PreparedStatement
Python      PyPI            pip audit             DB-API mit Parametern
Rust        crates.io       cargo audit           sqlx / Parameter-Bindings
Swift       Swift PM        dependency scan       DB-Treiber mit Parametern
CVE-Umgang:  kritische CVE -> bewerten, aktualisieren/ersetzen oder Restrisiko begründen
SBOM=Applicable, AI-SBOM=N/A (nur Entwicklungswerkzeuge), VEX=Open (Folgeaufgabe)
Secrets:     Registry-Token nur als <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | SBOM und Audit sichern die laufende Plattform gegen verwundbare Komponenten. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Bewertung der Lieferkette ist eine Schutzbedarfsfrage. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Supply-Chain-Sicherheit, sichere Abhängigkeiten,
MSL-Präferenz und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Lieferkette/Dependency), `CL_08` (Sicherheits-Review), `CL_09` (MSL/sichere Programmierung) und `CL_12`
(Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Bekannte kritische Schwachstellen
werden bewertet, nicht ignoriert; MSL ist keine pauschale Freigabe, SQL-Injection bleibt prüfpflichtig.*
A11Y-Aspekt: Dependency-Tabellen und die Applicable-/N/A-/Open-Matrix werden als klare Textstrukturen
dokumentiert, ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: supply-chain security, secure dependencies, MSL
preference, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (supply
chain/dependency), `CL_08` (security review), `CL_09` (MSL/secure coding), and `CL_12` (documentation/N-A). The
security decision of this unit is: *known critical vulnerabilities are assessed, not ignored; MSL is not a
blanket clearance, SQL injection remains to be checked.* Accessibility aspect: dependency tables and the
applicable/N-A/open matrix are documented as clear text structures, without color-only marking, so they stay
usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist der Unterschied zwischen fachlichen Lieferanten und der technischen Lieferkette? /
   **EN:** What is the difference between business suppliers and the technical supply chain?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fachliche Lieferanten liefern Produkte für den Handel (Northwind `Suppliers`). Die technische
   Lieferkette liefert Software-Bibliotheken und Pakete für die Plattform. Beide haben eigene Risiken.
   **EN:** Business suppliers deliver products for trading (Northwind `Suppliers`). The technical supply chain
   delivers software libraries and packages for the platform. Both have their own risks.

   </details>

2. **DE:** Wozu dient eine SBOM? /
   **EN:** What is an SBOM for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie listet auf, welche Komponenten in welcher Version in der Plattform enthalten sind. So kann man
   bei einer neuen CVE schnell prüfen, ob man betroffen ist, und die eingesetzten Komponenten belegen.
   **EN:** It lists which components in which version are included in the platform. So on a new CVE you can
   quickly check whether you are affected and evidence the used components.

   </details>

3. **DE:** Warum ist die Bibliothek für parametrisierten Datenzugriff besonders wichtig? /
   **EN:** Why is the library for parameterized data access especially important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil dort der Schutz vor SQL-Injection entschieden wird. Parametrisierte Queries trennen Daten von
   SQL-Befehlen. Das ist unabhängig von der Sprache prüfpflichtig.
   **EN:** Because that is where protection against SQL injection is decided. Parameterized queries separate
   data from SQL commands. This must be checked regardless of the language.

   </details>

4. **DE:** (SI) Wie gehst du mit einer bekannten kritischen CVE in einer Abhängigkeit um? /
   **EN:** (SI) How do you handle a known critical CVE in a dependency?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nicht ignorieren: bewerten, die Bibliothek aktualisieren oder ersetzen. Ist das nicht möglich, wird
   das Restrisiko mit Begründung und Folgeaufgabe dokumentiert.
   **EN:** Do not ignore it: assess it, update or replace the library. If that is not possible, document the
   residual risk with a justification and a follow-up task.

   </details>

5. **DE:** (SI) Warum ist AI-SBOM in dieser Aufgabe meist `N/A`? /
   **EN:** (SI) Why is AI-SBOM usually `N/A` in this task?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Weil KI hier nur als Entwicklungswerkzeug genutzt wird und keine KI-Runtime in der Plattform
   ausgeliefert oder betrieben wird. Das wird als `N/A` mit kurzer Begründung dokumentiert, nicht verschwiegen.
   **EN:** Because AI is used here only as a development tool and no AI runtime is shipped or operated in the
   platform. This is documented as `N/A` with a short justification, not omitted.

   </details>

6. **DE:** Warum ist MSL keine pauschale Sicherheitsfreigabe? /
   **EN:** Why is MSL not a blanket security clearance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** MSL reduziert Speicherfehler, löst aber SQL-Injection, falsche Auth oder unsichere Deserialisierung
   nicht automatisch. Diese Klassen bleiben unabhängig von der Sprache prüfpflichtig.
   **EN:** MSL reduces memory errors but does not automatically solve SQL injection, wrong auth, or unsafe
   deserialization. These classes remain to be checked regardless of the language.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] fachliche Lieferanten und technische Lieferkette klar trennen.
- [ ] erklären, wozu eine SBOM dient.
- [ ] je Sprache Paketquelle, Audit-Werkzeug und Datenzugriffs-Bibliothek benennen.
- [ ] den Umgang mit einer kritischen CVE beschreiben.
- [ ] SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open` bewerten.

**EN:** I can …

- [ ] clearly separate business suppliers and the technical supply chain.
- [ ] explain what an SBOM is for.
- [ ] name per language the package source, audit tool, and data-access library.
- [ ] describe how to handle a critical CVE.
- [ ] assess SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
