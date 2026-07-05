# Lernbegleiter: Secure CaseTracker Operations Track 08 – Dependency-, SBOM- und Supply-Chain-Nachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_08_Dependency-SBOM-und-Supply-Chain-Nachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Kaum ein Programm ist ganz allein geschrieben. Es nutzt fremde Bibliotheken – **Dependencies**
(Abhängigkeiten). Jede fremde Bibliothek ist geliehener Code, für den du im Betrieb trotzdem verantwortlich
bist. Die Kette aus deinem Code, den Bibliotheken und den Werkzeugen, die daraus ein Programm machen, heißt
**Supply Chain** (Lieferkette). Angreifer zielen zunehmend auf diese Kette: Wird eine beliebte Bibliothek
kompromittiert, sind viele Systeme betroffen. Eine **SBOM** (Software Bill of Materials) ist die Stückliste:
Sie listet auf, was alles in deiner Software steckt.

**EN:** Almost no program is written entirely alone. It uses external libraries – **dependencies**. Every
external library is borrowed code for which you are still responsible in operation. The chain of your code,
the libraries, and the tools that turn them into a program is called the **supply chain**. Attackers
increasingly target this chain: if a popular library is compromised, many systems are affected. An **SBOM**
(Software Bill of Materials) is the parts list: it enumerates everything inside your software.

**DE:** In dieser Einheit lernst du, Abhängigkeiten zu erfassen und zu bewerten, eine SBOM zu verstehen,
Begriffe wie **VEX**, **SLSA** und **OpenSSF Scorecard** einzuordnen und für den Betrieb ehrlich zwischen
`Applicable`, `N/A` und `Open` zu unterscheiden.

**EN:** In this unit you learn to capture and assess dependencies, understand an SBOM, place terms like
**VEX**, **SLSA**, and **OpenSSF Scorecard**, and honestly distinguish `Applicable`, `N/A`, and `Open` for
operation.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Dependency / Dependency | Fremde Bibliothek oder Komponente, die deine Software mitnutzt. |
| Supply Chain / Supply chain | Die ganze Kette aus Code, Abhängigkeiten und Bauwerkzeugen. |
| SBOM / Software Bill of Materials | Stückliste aller Komponenten und Versionen in der Software. |
| VEX / Vulnerability Exploitability eXchange | Aussage, ob eine bekannte Schwachstelle im eigenen System ausnutzbar ist. |
| SLSA / Supply-chain Levels for Software Artifacts | Reifegrad-Modell für die Sicherheit des Build-Weges. |
| OpenSSF Scorecard / OpenSSF Scorecard | Bewertung, wie gepflegt und sicher ein Open-Source-Projekt arbeitet. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Abhängigkeiten erfassen.** Liste alle direkten und, soweit möglich, indirekten
Abhängigkeiten mit Version auf. Ein **Lockfile** (feste Versionsdatei) sorgt dafür, dass immer dieselben
Versionen verwendet werden. Was du nicht kennst, kannst du nicht bewerten – die vollständige Liste ist die
Grundlage.

**EN:** **Step 1 – Capture dependencies.** List all direct and, where possible, indirect dependencies with
their version. A **lockfile** (fixed version file) ensures the same versions are always used. What you do not
know, you cannot assess – the complete list is the basis.

**DE:** **Schritt 2 – Risiko bewerten.** Prüfe die Abhängigkeiten auf bekannte Schwachstellen (CVEs), auf
Pflegezustand (wird das Projekt aktiv gewartet?) und auf Lizenz. Eine bekannte kritische Schwachstelle in
einer genutzten Komponente ist ein Betriebsrisiko, das behandelt werden muss – ersetzen, aktualisieren oder
mit VEX begründen, warum sie nicht ausnutzbar ist.

**EN:** **Step 2 – Assess risk.** Check the dependencies for known vulnerabilities (CVEs), maintenance state
(is the project actively maintained?), and license. A known critical vulnerability in a used component is an
operational risk that must be handled – replace, update, or justify with VEX why it is not exploitable.

**DE:** **Schritt 3 – SBOM und Nachweise erstellen.** Eine SBOM macht die Stückliste maschinenlesbar und
teilbar. Ergänzend ordnest du ein: **VEX** sagt, ob eine Schwachstelle bei dir wirklich ausnutzbar ist;
**SLSA** beschreibt, wie vertrauenswürdig dein Build-Weg ist; die **OpenSSF Scorecard** bewertet die
Pflegequalität eines Open-Source-Projekts. Nicht jeder Standard passt zu jedem Projekt.

**EN:** **Step 3 – Create SBOM and evidence.** An SBOM makes the parts list machine-readable and shareable. In
addition you place: **VEX** says whether a vulnerability is really exploitable in your case; **SLSA**
describes how trustworthy your build path is; the **OpenSSF Scorecard** rates the maintenance quality of an
open-source project. Not every standard fits every project.

**DE:** **Schritt 4 – Ehrlich zwischen Applicable, N/A und Open unterscheiden.** Für ein Ausbildungsprojekt
gilt manches nicht (z. B. voller SLSA-Reifegrad ohne echte Release-Pipeline). Dokumentiere jeden Standard als
`Applicable` (mit Evidenzpfad), `N/A` (mit technischer Begründung) oder `Open` (mit Folgeaktion). Ehrliche
Nichtanwendbarkeit ist besser als eine unbelegte Behauptung.

**EN:** **Step 4 – Honestly distinguish Applicable, N/A, and Open.** For a training project some things do
not apply (e.g. full SLSA maturity without a real release pipeline). Document each standard as `Applicable`
(with evidence path), `N/A` (with a technical rationale), or `Open` (with a follow-up action). Honest
non-applicability is better than an unsupported claim.

**DE:** **Typische Fehler.** Nur direkte Abhängigkeiten sehen, indirekte ignorieren. Keine festen Versionen.
Bekannte kritische CVEs übersehen. Standards behaupten, ohne Nachweis. „Alles N/A" ohne Begründung oder
„alles erfüllt" ohne Evidenz.

**EN:** **Common mistakes.** Seeing only direct dependencies, ignoring indirect ones. No fixed versions.
Missing known critical CVEs. Claiming standards without evidence. "Everything N/A" without a rationale or
"everything met" without evidence.

### Beispiel / Example

```text
Abhängigkeit:   lib-parse 2.3.1  (direkt)   -> Lockfile fixiert Version
Prüfung:        CVE-Check: 1 bekannter Fund  -> Update auf 2.3.2 (behoben)
Pflegezustand:  aktiv gewartet; Lizenz kompatibel
SBOM:           maschinenlesbare Stückliste aller Komponenten + Versionen
Einordnung:     SBOM = Applicable (Evidenz: docs/security/supply-chain-evidence.md)
                SLSA voller Reifegrad = N/A (kein produktiver Release-Pfad; begründet)
                Rest-CVE-Prüfung = Open (Folgeaktion: monatlicher Re-Scan)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Abhängigkeits- und Lieferkettensicherheit ist ein zentraler Betriebssicherheitsaspekt. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Die Bewertung von Abhängigkeitsrisiken setzt die Schutzbedarfsanalyse auf die Lieferkette fort. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Supply-Chain-Sicherheit, Abhängigkeits-Audit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_06` (Supply-Chain/SBOM),
`CL_08` (Sicherheits-Review), `CL_10` (Logging/Nachweise) und `CL_12` (Dokumentation/N-A). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jede Abhängigkeit ist bekannt, bewertet und mit Nachweis
oder begründetem N/A dokumentiert.* A11Y-Aspekt: Die Abhängigkeits- und N/A-Matrix wird als klare
Text-Tabelle geführt, damit Status und Begründung ohne Farbcode mit Screenreader und Braille-Zeile lesbar
bleiben.

**EN:** Relation to the Secure Development Guideline: supply-chain security, dependency audit, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_06` (supply chain/SBOM),
`CL_08` (security review), `CL_10` (logging/evidence), and `CL_12` (documentation/N-A). The security
decision of this unit is: *every dependency is known, assessed, and documented with evidence or a justified
N/A.* Accessibility aspect: the dependency and N/A matrix is kept as a clear text table, so status and
rationale stay readable without color coding with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine SBOM, und wozu dient sie? /
   **EN:** What is an SBOM, and what is it for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine SBOM ist die Stückliste aller Komponenten und Versionen in einer Software. Sie macht
   nachvollziehbar, was drinsteckt, und erlaubt es, bei einer neuen Schwachstelle schnell zu prüfen, ob man
   betroffen ist.
   **EN:** An SBOM is the parts list of all components and versions in a piece of software. It makes clear
   what is inside and lets you quickly check, when a new vulnerability appears, whether you are affected.

   </details>

2. **DE:** Warum ist die Supply Chain ein eigenes Angriffsziel? /
   **EN:** Why is the supply chain its own attack target?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wird eine weit verbreitete Bibliothek oder ein Bauwerkzeug kompromittiert, sind auf einen Schlag
   viele Systeme betroffen. Angreifer erreichen so mehr mit weniger Aufwand als beim Angriff auf ein einzelnes
   System.
   **EN:** If a widely used library or build tool is compromised, many systems are affected at once. Attackers
   thus achieve more with less effort than by attacking a single system.

   </details>

3. **DE:** Wozu dient eine VEX-Aussage? /
   **EN:** What is a VEX statement for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** VEX sagt, ob eine bekannte Schwachstelle im eigenen System tatsächlich ausnutzbar ist. So kann man
   begründen, warum ein CVE-Fund im konkreten Betrieb kein Risiko darstellt – oder eben doch behandelt werden
   muss.
   **EN:** VEX says whether a known vulnerability is actually exploitable in your own system. This lets you
   justify why a CVE finding is not a risk in the concrete operation – or does need handling after all.

   </details>

4. **DE:** (SI) Warum sind feste Versionen (Lockfile) für den Betrieb wichtig? /
   **EN:** (SI) Why are fixed versions (lockfile) important for operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie sorgen dafür, dass immer dieselben, geprüften Versionen laufen. Ohne Lockfile könnte sich eine
   Abhängigkeit unbemerkt ändern und eine Schwachstelle oder ein Bruch einschleichen. Feste Versionen machen
   den Betrieb reproduzierbar.
   **EN:** They ensure the same, checked versions always run. Without a lockfile a dependency could change
   unnoticed and introduce a vulnerability or a break. Fixed versions make operation reproducible.

   </details>

5. **DE:** (SI) Wann ist es korrekt, einen Standard wie SLSA als `N/A` zu dokumentieren? /
   **EN:** (SI) When is it correct to document a standard like SLSA as `N/A`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn er auf das Projekt sachlich nicht zutrifft, z. B. voller SLSA-Reifegrad ohne echten
   produktiven Release-Pfad. Wichtig ist eine kurze technische Begründung – nicht stilles Weglassen.
   **EN:** When it factually does not apply to the project, e.g. full SLSA maturity without a real production
   release path. Important is a short technical rationale – not silent omission.

   </details>

6. **DE:** (SI) Wie hängt diese Einheit mit der CI/CD-Pipeline (Einheit 03) zusammen? /
   **EN:** (SI) How is this unit connected to the CI/CD pipeline (unit 03)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Abhängigkeits-Scan ist ein Gate in der Pipeline. Die SBOM und Provenance-Nachweise entstehen im
   Build. So werden Supply-Chain-Prüfungen automatisch und wiederholbar, statt einmalig von Hand.
   **EN:** The dependency scan is a gate in the pipeline. The SBOM and provenance evidence are produced in the
   build. This makes supply-chain checks automatic and repeatable instead of one-off by hand.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] direkte und indirekte Abhängigkeiten mit Version erfassen.
- [ ] Abhängigkeiten auf CVEs, Pflegezustand und Lizenz bewerten.
- [ ] SBOM, VEX, SLSA und OpenSSF Scorecard grob einordnen.
- [ ] jeden Standard als `Applicable`, `N/A` oder `Open` mit Begründung dokumentieren.
- [ ] den Zusammenhang von Supply-Chain-Prüfung und CI/CD-Pipeline erklären.

**EN:** I can …

- [ ] capture direct and indirect dependencies with their version.
- [ ] assess dependencies for CVEs, maintenance state, and license.
- [ ] roughly place SBOM, VEX, SLSA, and OpenSSF Scorecard.
- [ ] document each standard as `Applicable`, `N/A`, or `Open` with a rationale.
- [ ] explain the connection between supply-chain checks and the CI/CD pipeline.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_08_Dependency-SBOM-und-Supply-Chain-Nachweise.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_08_Dependency-SBOM-und-Supply-Chain-Nachweise.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
