# Lernbegleiter: Secure ServiceHarvester Operations Track 08 – Supply Chain, SBOM und Dependency-Audit / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Kein Dienst besteht nur aus eigenem Code. Der Secure ServiceHarvester nutzt viele fremde Bibliotheken:
für Zeitplanung, Speicherung, Netz oder Formate. All diese Bausteine bilden die **Lieferkette** (Supply Chain).
Wenn eine dieser fremden Bibliotheken eine Schwachstelle hat, hat sie auch dein Dienst. Deshalb brauchst du
eine **Stückliste der Software** (SBOM, Software Bill of Materials): eine Liste aller enthaltenen Komponenten
mit Version und Herkunft. Ein **Dependency-Audit** prüft diese Liste regelmäßig auf bekannte Schwachstellen.

**EN:** No service consists only of its own code. The Secure ServiceHarvester uses many third-party libraries:
for scheduling, storage, network, or formats. All these building blocks form the **supply chain**. If one of
these third-party libraries has a vulnerability, so does your service. Therefore you need a **software bill of
materials** (SBOM): a list of all included components with version and origin. A **dependency audit** checks
this list regularly for known vulnerabilities.

**DE:** In dieser Einheit lernst du, eine SBOM zu verstehen und zu pflegen, ein Dependency-Audit je Zielsprache
zu planen, mit bekannten Schwachstellen (CVE) umzugehen und SBOM, AI-SBOM und VEX richtig einzuordnen. Als
C#-Referenz dient `InventarWorkerService`; die Idee bleibt für C#, Go, Java, Python, Rust und Swift
vergleichbar. Sie baut auf den reproduzierbaren Builds aus Einheit 06 auf und liefert Nachweise für das
Betriebs-Review in Einheit 10.

**EN:** In this unit you learn to understand and maintain an SBOM, plan a dependency audit per target language,
handle known vulnerabilities (CVE), and correctly classify SBOM, AI-SBOM, and VEX. The C# reference is
`InventarWorkerService`; the idea stays comparable across C#, Go, Java, Python, Rust, and Swift. It builds on the
reproducible builds from unit 06 and delivers evidence for the operations review in unit 10.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Lieferkette / Supply chain | Alle fremden Komponenten und Bezugswege, aus denen der Dienst besteht. |
| SBOM / Software Bill of Materials | Stückliste aller enthaltenen Software-Komponenten mit Version und Herkunft. |
| Dependency-Audit / Dependency audit | Regelmäßige Prüfung der Abhängigkeiten auf bekannte Schwachstellen. |
| CVE / Common Vulnerabilities and Exposures | Eindeutige Kennung für eine bekannte Schwachstelle. |
| VEX / Vulnerability Exploitability eXchange | Aussage, ob eine bekannte Schwachstelle im Dienst wirklich ausnutzbar ist. |
| AI-SBOM / AI-SBOM | Stückliste für KI-Komponenten, nur relevant bei KI-Runtime im Produkt. |
| MSL / Memory-Safe Language | Speichersichere Sprache; reduziert Speicherfehler, löst aber nicht alle Risiken. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – SBOM verstehen und erzeugen.** Eine SBOM listet alle Komponenten des Dienstes mit
Version und Herkunft. Sie ist der Nachweis, was wirklich enthalten ist. Viele Sprachen und Werkzeuge können
eine SBOM aus dem Build erzeugen. Ohne SBOM weißt du im Ernstfall nicht, ob eine gemeldete Schwachstelle dich
betrifft.

**EN:** **Step 1 – Understand and generate an SBOM.** An SBOM lists all components of the service with version
and origin. It is the evidence of what is really included. Many languages and tools can generate an SBOM from
the build. Without an SBOM you do not know in a real case whether a reported vulnerability affects you.

**DE:** **Schritt 2 – Dependency-Audit je Sprache planen.** Jede Zielsprache hat eigene Paketquellen und
Audit-Werkzeuge (z. B. einen Schwachstellen-Scan für den Paketmanager). Plane, wie und wann geprüft wird –
am besten automatisch in der Pipeline aus Einheit 06.

**EN:** **Step 2 – Plan a dependency audit per language.** Each target language has its own package sources and
audit tools (e.g. a vulnerability scan for the package manager). Plan how and when checks run – best
automatically in the pipeline from unit 06.

**DE:** **Schritt 3 – Mit bekannten Schwachstellen umgehen.** Findet ein Audit eine kritische CVE, gibt es
drei ehrliche Wege: aktualisieren, die Abhängigkeit ersetzen oder – wenn nicht ausnutzbar – dies mit
Begründung dokumentieren (VEX). Ignorieren ist kein Weg. Ungepflegte Bibliotheken werden möglichst vermieden.

**EN:** **Step 3 – Handle known vulnerabilities.** If an audit finds a critical CVE, there are three honest
paths: update, replace the dependency, or – if not exploitable – document this with a rationale (VEX). Ignoring
is not a path. Unmaintained libraries are avoided where possible.

**DE:** **Schritt 4 – SBOM, AI-SBOM und VEX einordnen.** SBOM ist für releasefähige Artefakte `Applicable`.
AI-SBOM ist `N/A`, solange keine KI-Runtime im Dienst ausgeliefert wird – reine KI-Entwicklungswerkzeuge zählen
nicht. VEX ist `Applicable`, wenn bekannte Schwachstellen bewertet werden müssen. Jede Einordnung braucht eine
kurze Begründung.

**EN:** **Step 4 – Classify SBOM, AI-SBOM, and VEX.** SBOM is `Applicable` for releasable artifacts. AI-SBOM is
`N/A` as long as no AI runtime is shipped in the service – pure AI development tools do not count. VEX is
`Applicable` when known vulnerabilities need a disposition. Each classification needs a short rationale.

**DE:** **Typische Fehler.** Abhängigkeiten ohne Zweck und Herkunft übernehmen. Keine SBOM führen. Audits nur
einmalig statt regelmäßig. MSL als pauschale Sicherheitsfreigabe missverstehen. Kritische CVEs ignorieren statt
zu bewerten. Tokens oder private Registry-Zugänge versehentlich in Nachweisen veröffentlichen.

**EN:** **Common mistakes.** Taking dependencies without purpose and origin. Keeping no SBOM. Auditing only
once instead of regularly. Misreading MSL as a blanket security clearance. Ignoring critical CVEs instead of
assessing them. Accidentally publishing tokens or private registry access in evidence.

### Beispiel / Example

```text
SBOM:           Liste aller Komponenten mit Version + Herkunft, aus dem Build erzeugt  -> Applicable
Dependency-Audit: je Sprache Paketquelle + Scan-Werkzeug; läuft in der Pipeline
CVE-Umgang:     kritische CVE -> 1) aktualisieren  2) ersetzen  3) begründet als nicht ausnutzbar (VEX)
MSL-Aussage:    C#, Go, Java, Python, Rust, Swift reduzieren Speicherfehler; I/O, Auth, Crypto bleiben prüfpflichtig
AI-SBOM:        N/A - keine KI-Runtime im Dienst, nur Entwicklungswerkzeuge  -> Begründung dokumentiert
Secrets:        nur Platzhalter <PLATZHALTER-KEIN-ECHTER-WERT> in Nachweisen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | SBOM und Dependency-Audit sind Sicherheitsmaßnahmen für den laufenden Dienst. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Bewertung der Lieferkette ist eine Schutzbedarfsfrage. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Supply-Chain-Sicherheit, sichere Abhängigkeiten,
MSL-Präferenz und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Lieferkette/Dependency), `CL_08` (Sicherheits-Review), `CL_09` (MSL/Sprachprofil) und `CL_12`
(Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Abhängigkeit hat Zweck, Herkunft
und Risikohinweis; bekannte kritische Schwachstellen werden bewertet, nicht ignoriert; MSL ist keine pauschale
Sicherheitsfreigabe.* A11Y-Aspekt: Dependency- und SBOM-Tabellen müssen als klarer Text lesbar sein, ohne reine
Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: supply-chain security, secure dependencies, MSL
preference, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (supply
chain/dependency), `CL_08` (security review), `CL_09` (MSL/language profile), and `CL_12` (documentation/N-A).
The security decision of this unit is: *every dependency has purpose, origin, and a risk note; known critical
vulnerabilities are assessed, not ignored; MSL is not a blanket security clearance.* Accessibility aspect:
dependency and SBOM tables must be readable as clear text, without color-only marking, so they stay usable with
a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine SBOM und wozu dient sie? /
   **EN:** What is an SBOM and what is it for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine SBOM ist die Stückliste aller enthaltenen Software-Komponenten mit Version und Herkunft. Sie
   dient als Nachweis, was wirklich im Dienst steckt, und erlaubt zu prüfen, ob eine gemeldete Schwachstelle
   den Dienst betrifft.
   **EN:** An SBOM is the bill of materials of all included software components with version and origin. It
   serves as evidence of what is really in the service and lets you check whether a reported vulnerability
   affects the service.

   </details>

2. **DE:** Warum ist die Lieferkette ein Sicherheitsthema, auch wenn der eigene Code sauber ist? /
   **EN:** Why is the supply chain a security topic even if your own code is clean?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Dienst enthält viele fremde Bibliotheken. Hat eine davon eine Schwachstelle, hat sie auch der
   Dienst – unabhängig vom eigenen Code. Deshalb muss die Lieferkette selbst geprüft werden.
   **EN:** The service contains many third-party libraries. If one of them has a vulnerability, so does the
   service – independent of your own code. Therefore the supply chain itself must be checked.

   </details>

3. **DE:** (SI) Welche drei ehrlichen Wege gibt es, wenn ein Audit eine kritische CVE meldet? /
   **EN:** (SI) Which three honest paths exist when an audit reports a critical CVE?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aktualisieren auf eine gepatchte Version, die Abhängigkeit ersetzen, oder – wenn nachweislich nicht
   ausnutzbar – dies mit Begründung dokumentieren (VEX). Ignorieren gehört nicht dazu.
   **EN:** Update to a patched version, replace the dependency, or – if provably not exploitable – document this
   with a rationale (VEX). Ignoring is not among them.

   </details>

4. **DE:** (SI) Warum ist MSL keine pauschale Sicherheitsfreigabe? /
   **EN:** (SI) Why is MSL not a blanket security clearance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Speichersichere Sprachen reduzieren Speicherfehler, aber Risiken wie unsichere Eingabe, schwache
   Authentifizierung, falsche Kryptografie oder verwundbare Abhängigkeiten bleiben. Diese müssen weiterhin
   geprüft werden.
   **EN:** Memory-safe languages reduce memory errors, but risks like unsafe input, weak authentication, wrong
   cryptography, or vulnerable dependencies remain. These still must be checked.

   </details>

5. **DE:** Wann ist AI-SBOM `N/A` und wie dokumentierst du das? /
   **EN:** When is AI-SBOM `N/A` and how do you document it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** AI-SBOM ist `N/A`, solange keine KI-Runtime im Dienst ausgeliefert oder betrieben wird und KI nur
   als Entwicklungswerkzeug dient. Das wird als `N/A` mit kurzer technischer Begründung dokumentiert, nicht
   stillschweigend weggelassen.
   **EN:** AI-SBOM is `N/A` as long as no AI runtime is shipped or operated in the service and AI is only a
   development tool. This is documented as `N/A` with a short technical rationale, not silently omitted.

   </details>

6. **DE:** (SI) Warum sollten Audits regelmäßig statt nur einmal laufen? /
   **EN:** (SI) Why should audits run regularly instead of only once?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Neue Schwachstellen werden ständig entdeckt. Eine Abhängigkeit, die heute sauber ist, kann morgen
   eine gemeldete CVE haben. Nur regelmäßige, am besten automatische Audits halten die Bewertung aktuell.
   **EN:** New vulnerabilities are discovered constantly. A dependency clean today can have a reported CVE
   tomorrow. Only regular, ideally automatic audits keep the assessment current.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] erklären, was eine SBOM ist und wozu sie dient.
- [ ] ein Dependency-Audit je Zielsprache mit Paketquelle und Werkzeug planen.
- [ ] drei ehrliche Wege im Umgang mit einer kritischen CVE benennen.
- [ ] begründen, warum MSL keine pauschale Sicherheitsfreigabe ist.
- [ ] SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open` mit Begründung einordnen.

**EN:** I can …

- [ ] explain what an SBOM is and what it is for.
- [ ] plan a dependency audit per target language with package source and tool.
- [ ] name three honest paths for handling a critical CVE.
- [ ] justify why MSL is not a blanket security clearance.
- [ ] classify SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
