# Lernbegleiter: Secure InventoryHub 08 – Supply Chain, SBOM und Dependency-Bezug / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_08_Supply-Chain-SBOM-und-Dependency-Bezug.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Moderne Software besteht selten nur aus eigenem Code – sie nutzt viele Abhängigkeiten (Bibliotheken,
Frameworks). Diese Kette von Zulieferern heißt **Supply Chain**. Wenn eine einzige Abhängigkeit eine
Schwachstelle hat, kann sie das ganze System betreffen. Deshalb braucht man einen Überblick, **was** in einer
Software steckt. Eine **SBOM** (Software Bill of Materials) ist genau das: eine Stückliste aller Bestandteile.
Für das Inventar bedeutet das: Softwarestände lassen sich mit ihren Abhängigkeiten und bekannten
Schwachstellen verknüpfen. Nicht jeder Standard ist immer anwendbar; manches ist begründet `N/A`.

**EN:** Modern software rarely consists only of your own code – it uses many dependencies (libraries,
frameworks). This chain of suppliers is called the **supply chain**. If a single dependency has a
vulnerability, it can affect the whole system. Therefore you need an overview of **what** is inside a software.
An **SBOM** (Software Bill of Materials) is exactly that: a parts list of all components. For the inventory
this means: software versions can be linked to their dependencies and known vulnerabilities. Not every
standard is always applicable; some is justifiably `N/A`.

**DE:** In dieser Einheit lernst du, Softwarestände und Abhängigkeiten einzuordnen, die Begriffe SBOM, VEX und
SLSA zu unterscheiden, ihre Anwendbarkeit zu prüfen und nicht anwendbare Standards als `N/A` mit Begründung zu
dokumentieren.

**EN:** In this unit you learn to classify software versions and dependencies, to distinguish the terms SBOM,
VEX, and SLSA, to check their applicability, and to document non-applicable standards as `N/A` with a
justification.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Supply Chain / Supply chain | Kette aller Zulieferer und Bestandteile einer Software. |
| Abhängigkeit / Dependency | Externe Bibliothek oder Komponente, die eine Software nutzt. |
| SBOM / SBOM | Software-Stückliste: Liste aller Bestandteile einer Software. |
| VEX / VEX | Aussage, ob eine bekannte Schwachstelle ein Produkt tatsächlich betrifft. |
| SLSA / SLSA | Rahmenwerk für nachweisbare Integrität der Build- und Lieferkette. |
| N/A-Begründung / N/A justification | Dokumentierte Erklärung, warum ein Standard hier nicht anwendbar ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Softwarestände und Abhängigkeiten erfassen.** Verknüpfe jeden Softwarestand mit seinen
Abhängigkeiten. Erst wenn bekannt ist, welche Bibliotheken enthalten sind, kann man eine Schwachstelle einer
Bibliothek dem eigenen Bestand zuordnen. „Man kann nur schützen, was man kennt."

**EN:** **Step 1 – Record software versions and dependencies.** Link each software version with its
dependencies. Only when it is known which libraries are included can a vulnerability of a library be assigned
to your own stock. "You can only protect what you know."

**DE:** **Schritt 2 – SBOM, VEX und SLSA unterscheiden.** Eine **SBOM** listet die Bestandteile. **VEX** sagt
zusätzlich, ob eine bekannte Schwachstelle das Produkt wirklich betrifft (manche betreffen es nicht, weil der
verwundbare Teil gar nicht genutzt wird). **SLSA** beschreibt, wie vertrauenswürdig der Build- und Lieferweg
ist. Die drei ergänzen sich: Bestandteile, Betroffenheit, Herkunftsvertrauen.

**EN:** **Step 2 – Distinguish SBOM, VEX, and SLSA.** An **SBOM** lists the components. **VEX** additionally
states whether a known vulnerability really affects the product (some do not, because the vulnerable part is
not used at all). **SLSA** describes how trustworthy the build and delivery path is. The three complement each
other: components, exposure, provenance trust.

**DE:** **Schritt 3 – Anwendbarkeit prüfen.** Nicht jede Übung liefert ein Release-Artefakt. Prüfe ehrlich:
Ist in dieser Aufgabe überhaupt ein auslieferbares Produkt beteiligt? Wenn nein, kann SBOM/VEX/SLSA `N/A` sein
– aber nur mit klarer Begründung, nicht durch stilles Weglassen. Reine Entwicklungswerkzeuge sind meist `N/A`.

**EN:** **Step 3 – Check applicability.** Not every exercise produces a release artifact. Check honestly: is a
deliverable product even involved in this task? If not, SBOM/VEX/SLSA can be `N/A` – but only with a clear
justification, not by silent omission. Pure development tools are usually `N/A`.

**DE:** **Schritt 4 – Nachweise und Begründungen dokumentieren.** Halte fest: Welche Standards sind
`Applicable`, welche `N/A`, welche `Open`? Gib je Punkt einen Evidenzpfad oder eine Begründung an. So bleibt
die Lieferketten-Bewertung auditfähig und ehrlich, auch wenn vieles bewusst als nicht anwendbar eingestuft
wird.

**EN:** **Step 4 – Document evidence and justifications.** Record: which standards are `Applicable`, which
`N/A`, which `Open`? Give an evidence path or a justification for each point. This keeps the supply-chain
assessment audit-ready and honest, even when much is deliberately classified as not applicable.

**DE:** **Typische Fehler.** Abhängigkeiten nicht erfassen. SBOM, VEX und SLSA verwechseln. Standards
stillschweigend weglassen statt `N/A` zu begründen. Eine Schwachstelle einer Bibliothek nicht mit dem eigenen
Bestand verknüpfen. VEX ignorieren und dadurch nicht betroffene Schwachstellen als kritisch behandeln.

**EN:** **Common mistakes.** Not recording dependencies. Confusing SBOM, VEX, and SLSA. Silently dropping
standards instead of justifying `N/A`. Not linking a library vulnerability to your own stock. Ignoring VEX and
thereby treating non-affecting vulnerabilities as critical.

### Beispiel / Example

```text
Softwarestand:   InventoryHub-App 1.2  -> Abhängigkeit: OpenSSL 3.0.13, libjson 2.1
Schwachstelle:   CVE-XXXX in OpenSSL 3.0.13
Zuordnung:       betrifft alle Assets mit dieser App-Version

SBOM:            listet App + OpenSSL 3.0.13 + libjson 2.1        (Bestandteile)
VEX:             "verwundbarer Codepfad wird nicht genutzt" -> nicht betroffen (dokumentiert)
SLSA:            Build-Herkunft in dieser Übung nicht nachgewiesen -> Open

N/A-Beispiel:    Diese Lerneinheit liefert kein Release-Artefakt
                 -> SBOM als Produkt-Nachweis N/A (Begründung: reine Spezifikationsübung)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Der Schutzbedarf der Lieferkette und die Bewertung von Abhängigkeiten stehen im Mittelpunkt. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Werkzeuge und Dienste der Lieferkette werden bewertet und eingebunden. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Supply-Chain-Sicherheit, Abhängigkeits-Audit und
Standards-Anwendbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_06`
(Abhängigkeiten/Supply Chain), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12`
(Nachweise). Die Sicherheitsentscheidung dieser Einheit lautet: *Abhängigkeiten werden bewusst erfasst und
bewertet, und Nichtanwendbarkeit wird als `N/A` mit Begründung dokumentiert.* A11Y-Aspekt: SBOM- und
Bewertungslisten müssen als klarer Text mit eindeutigen Begriffen lesbar sein, ohne reine Farbsignale, damit
sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: supply-chain security, dependency audit, and standards
applicability. Matching checklists: `CL_01` (standards applicability), `CL_06` (dependencies/supply chain),
`CL_08` (security code review), `CL_10` (privacy), and `CL_12` (evidence). The security decision of this unit
is: *dependencies are deliberately recorded and assessed, and non-applicability is documented as `N/A` with a
justification.* Accessibility aspect: SBOM and assessment lists must be readable as clear text with unambiguous
terms, without color-only signals, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Supply Chain im Software-Kontext? /
   **EN:** What is a supply chain in the software context?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Kette aller Zulieferer und Bestandteile einer Software, also eigener Code plus alle
   Abhängigkeiten. Ein Problem in einem Glied kann das ganze System betreffen.
   **EN:** The chain of all suppliers and components of a software, i.e. your own code plus all dependencies. A
   problem in one link can affect the whole system.

   </details>

2. **DE:** Wozu dient eine SBOM? /
   **EN:** What is an SBOM for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie listet alle Bestandteile einer Software auf. So kann man eine Schwachstelle einer Komponente dem
   eigenen Bestand zuordnen. Man kann nur schützen, was man kennt.
   **EN:** It lists all components of a software. This lets you assign a component's vulnerability to your own
   stock. You can only protect what you know.

   </details>

3. **DE:** Worin unterscheiden sich SBOM und VEX? /
   **EN:** How do SBOM and VEX differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die SBOM listet die Bestandteile. VEX sagt zusätzlich, ob eine bekannte Schwachstelle das Produkt
   wirklich betrifft, z. B. weil der verwundbare Teil nicht genutzt wird.
   **EN:** The SBOM lists the components. VEX additionally states whether a known vulnerability really affects
   the product, e.g. because the vulnerable part is not used.

   </details>

4. **DE:** Wofür steht SLSA grob? /
   **EN:** What does SLSA roughly stand for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Für ein Rahmenwerk zur nachweisbaren Integrität der Build- und Lieferkette. Es geht um Vertrauen in
   die Herkunft eines Artefakts, nicht nur um dessen Inhalt.
   **EN:** For a framework for provable integrity of the build and delivery chain. It is about trust in the
   provenance of an artifact, not just its content.

   </details>

5. **DE:** Warum darf ein nicht anwendbarer Standard nicht einfach weggelassen werden? /
   **EN:** Why must a non-applicable standard not simply be omitted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stilles Weglassen wirkt wie Vergessen. Ein dokumentiertes `N/A` mit Begründung zeigt, dass der
   Standard geprüft und bewusst als nicht anwendbar eingestuft wurde. Das bleibt auditfähig.
   **EN:** Silent omission looks like forgetting. A documented `N/A` with justification shows the standard was
   checked and deliberately classified as not applicable. This stays audit-ready.

   </details>

6. **DE:** (SI) Warum muss man eine Bibliotheks-Schwachstelle mit dem eigenen Bestand verknüpfen? /
   **EN:** (SI) Why must a library vulnerability be linked to your own stock?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur so weiß man, welche Assets oder Softwarestände tatsächlich betroffen sind und wo gehandelt werden
   muss. Eine Schwachstelle ohne Bezug zum Bestand bleibt abstrakt und führt zu keiner Maßnahme.
   **EN:** Only then does one know which assets or software versions are actually affected and where action is
   needed. A vulnerability without a link to the stock stays abstract and leads to no measure.

   </details>

7. **DE:** Wie hilft VEX, unnötige Aufregung zu vermeiden? /
   **EN:** How does VEX help avoid unnecessary alarm?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** VEX kann belegen, dass eine bekannte Schwachstelle das Produkt nicht betrifft, etwa weil der
   verwundbare Codepfad nicht genutzt wird. So spart man Aufwand für nicht relevante Funde.
   **EN:** VEX can prove that a known vulnerability does not affect the product, e.g. because the vulnerable
   code path is not used. This saves effort on irrelevant findings.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Softwarestände mit ihren Abhängigkeiten verknüpfen.
- [ ] SBOM, VEX und SLSA in eigenen Worten unterscheiden.
- [ ] die Anwendbarkeit dieser Standards für eine Aufgabe prüfen.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.
- [ ] eine Bibliotheks-Schwachstelle dem eigenen Bestand zuordnen.

**EN:** I can …

- [ ] link software versions to their dependencies.
- [ ] distinguish SBOM, VEX, and SLSA in my own words.
- [ ] check the applicability of these standards for a task.
- [ ] document non-applicable standards as `N/A` with a justification.
- [ ] assign a library vulnerability to my own stock.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_08_Supply-Chain-SBOM-und-Dependency-Bezug.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_08_Supply-Chain-SBOM-und-Dependency-Bezug.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
