# Lernbegleiter: Secure ServiceHarvester Application Track 01 – Track-Baseline und Feature-Zielbild / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester existiert bereits: In der v2-Baseline ist er ein langlaufender Sammel-Dienst mit
Persistenz-Backend, einem API-Vertrag, Rollen und Audit-Logging. Im Application Track geht es nicht darum, den
Dienst neu zu erfinden, sondern ihn als Anwendungsentwickler*in **gezielt weiterzubauen**. Bevor Code
entsteht, brauchst du ein **Feature-Zielbild**: Was ist die Baseline, was kommt neu dazu, was bleibt bewusst
außen vor, und welche Entscheidung hat welche Folgen? Im 3. Lehrjahr reicht es nicht mehr, eine Lösung zu
nennen – du musst sie gegen Alternativen abwägen und den **Trade-off** belegen.

**EN:** The ServiceHarvester already exists: in the v2 baseline it is a long-running collection service with a
persistence backend, an API contract, roles, and audit logging. The Application Track is not about reinventing
the service but about **extending it deliberately** as an application developer. Before code exists, you need
a **feature target picture**: what is the baseline, what is added, what is deliberately left out, and which
decision has which consequences? In year 3 it is no longer enough to name a solution – you must weigh it
against alternatives and evidence the **trade-off**.

**DE:** Du lernst, eine bestehende Baseline sauber von geplanten Erweiterungen zu trennen, ein prüfbares
Zielbild zu formulieren und zentrale Entwurfsentscheidungen als ADR-Kandidaten mit Alternative und Folge
festzuhalten. Das Zielbild wird zur gemeinsamen Baseline für alle folgenden Track-Einheiten.

**EN:** You learn to cleanly separate an existing baseline from planned extensions, to formulate a testable
target picture, and to record central design decisions as ADR candidates with alternative and consequence.
The target picture becomes the shared baseline for all following track units.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Baseline / Baseline | Der belegte Ausgangszustand, auf dem aufgebaut wird (hier: ServiceHarvester v2). |
| Feature-Zielbild / Feature target picture | Klare Beschreibung der geplanten Erweiterungen mit Umfang und Grenzen. |
| Erweiterbarkeit / Extensibility | Fähigkeit, neue Funktionen hinzuzufügen, ohne den Kern zu beschädigen. |
| Trade-off / Trade-off | Bewusste Abwägung zwischen Vor- und Nachteilen einer Entscheidung. |
| ADR-Kandidat / ADR candidate | Entscheidung, die wichtig genug für ein Architecture Decision Record ist. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossener Punkt, damit der Umfang nicht unbemerkt wächst. |
| Auditnachweis / Audit evidence | Belegbarer Nachweis, der eine Aussage später überprüfbar macht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Baseline belegen.** Schreibe auf, was die v2-Baseline schon kann: Dienst-Lebenszyklus,
Persistenz-Abstraktion, API-Vertrag, Rollen, Audit-Logging. Wichtig: Baseline heißt „belegt", nicht
„vermutet". Was du nicht belegen kannst, ist noch offen (`Open`).

**EN:** **Step 1 – Evidence the baseline.** Write down what the v2 baseline already provides: service
lifecycle, persistence abstraction, API contract, roles, audit logging. Important: baseline means "evidenced",
not "assumed". What you cannot evidence is still `Open`.

**DE:** **Schritt 2 – Erweiterungen schneiden.** Liste die geplanten Features des Tracks: gut geschnittene
Funktionen, saubere Persistenz-Adapter, wartbare Oberfläche (Viewer/Client), belastbare Tests. Jedes Feature
bekommt einen Satz Zweck und einen Bezug zur Baseline. So wird sichtbar, was Erweiterung und was schon
vorhanden ist.

**EN:** **Step 2 – Cut extensions.** List the planned features of the track: well-scoped functions, clean
persistence adapters, a maintainable interface (viewer/client), robust tests. Each feature gets one sentence
of purpose and a relation to the baseline. This makes visible what is an extension and what already exists.

**DE:** **Schritt 3 – Nicht-Ziele festlegen.** Nenne, was der Track **nicht** liefert, etwa Fernsteuerung von
Maschinen, ein vollständiges Dashboard-Produkt oder das Sammeln zusätzlicher personenbezogener Daten.
Nicht-Ziele verhindern Scope-Creep und halten die Datenminimierung ein.

**EN:** **Step 3 – Define non-goals.** State what the track does **not** deliver, e.g. remote control of
machines, a full dashboard product, or collecting additional personal data. Non-goals prevent scope creep and
uphold data minimization.

**DE:** **Schritt 4 – Schutzbedarf und Annahmen trennen.** Ordne jedem geplanten Feature den betroffenen
Schutzbedarf zu (Vertraulichkeit, Integrität, Verfügbarkeit). Schreibe Sicherheits-, Datenschutz- und
Betriebsannahmen in getrennte Zeilen, damit sie unterschiedlich geprüft werden können.

**EN:** **Step 4 – Separate protection need and assumptions.** Assign each planned feature the affected
protection need (confidentiality, integrity, availability). Write security, privacy, and operational
assumptions in separate lines so they can be checked differently.

**DE:** **Schritt 5 – Trade-offs als ADR-Kandidaten festhalten.** Für jede zentrale Entscheidung notierst du:
Option A, Option B, gewählte Option, Begründung und Folge. Beispiel: „Persistenz über Repository-Port
abstrahieren" gegenüber „direkt an ein Backend binden". Im 3. Lehrjahr ist die **Begründung** die eigentliche
Leistung, nicht die bloße Auswahl.

**EN:** **Step 5 – Record trade-offs as ADR candidates.** For each central decision, note: option A, option B,
chosen option, rationale, and consequence. Example: "abstract persistence via a repository port" versus "bind
directly to a backend". In year 3 the **rationale** is the actual achievement, not the mere choice.

**DE:** **Typische Fehler.** Baseline und Wunschliste vermischen. Features nennen, ohne den Zweck zu
begründen. Nicht-Ziele weglassen. Entscheidungen ohne Alternative treffen. Positive Aussagen („ist sicher",
„ist erweiterbar") ohne Nachweis. Standards still weglassen statt sie als `N/A` mit Begründung zu
dokumentieren.

**EN:** **Common mistakes.** Mixing baseline and wish list. Naming features without justifying the purpose.
Omitting non-goals. Making decisions without an alternative. Positive claims ("is secure", "is extensible")
without evidence. Silently dropping standards instead of documenting them as `N/A` with a justification.

### Beispiel / Example

```text
Baseline (belegt):   v2 = langlaufender Dienst, Persistenz-Abstraktion, API-Vertrag, Rollen, Audit-Log
Erweiterung (Track): API-Ressourcen (02), Persistenz-Adapter (03), Query/Filter/Pagination (04), Viewer (05)
Nicht-Ziel:          Fernsteuerung von Maschinen, Dashboard-Produkt, zusaetzliche personenbezogene Daten
Schutzbedarf:        Integritaet = hoch (Statusdaten steuern Betriebsentscheidungen)
Annahme (Sec):       neue Endpunkte behandeln Eingaben als nicht vertrauenswuerdig -> Nachweis: Validierungstest
Annahme (Betrieb):   Erweiterung darf Dienst-Lebenszyklus nicht brechen           -> Nachweis: Start/Stop-Test
ADR-Kandidat:        "Repository-Port statt direkter Backend-Bindung"
                     Alternative: direkte Bindung  | Trade-off: Testbarkeit/Austauschbarkeit vs. Mehraufwand
N/A:                 verteiltes Deployment in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). Für das
Feature-Zielbild ist **LF 12a** primär, weil eine kundenspezifische Erweiterung von der Auftragslage her
geplant und abgegrenzt wird; LF 4 ist berührt, weil der Schutzbedarf der betroffenen Daten mitgeplant wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). For
the feature target picture **LF 12a** is primary, because a customer-specific extension is planned and scoped
from the task situation; LF 4 is touched because the protection need of the affected data is planned along.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12a Kundenspezifische Anwendungsentwicklung durchführen | Primär / Primary | Das Feature-Zielbild plant und begrenzt eine kundenspezifische Erweiterung mit Trade-offs. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Jedem geplanten Feature wird der betroffene Schutzbedarf zugeordnet. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Standards-Anwendbarkeit und auditfähige
Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (sichere Architektur), `CL_08`
(Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit
lautet: *Erweiterungen bauen nur auf einer belegten Baseline auf, jede Entscheidung nennt ihren Trade-off, und
jede positive Aussage erhält einen Nachweispfad.* A11Y-Aspekt: Baseline-, Feature- und ADR-Tabellen müssen als
klarer Text lesbar sein, ohne reine Farbmarkierung, damit sie mit Screenreader oder Braille-Zeile nutzbar
bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, standards applicability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (secure architecture),
`CL_08` (security code review), and `CL_12` (evidence and closure). The security decision of this unit is:
*extensions build only on an evidenced baseline, every decision names its trade-off, and every positive claim
gets an evidence path.* Accessibility aspect: baseline, feature, and ADR tables must be readable as clear
text, without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum muss eine Baseline „belegt" und nicht nur „vermutet" sein? /
   **EN:** Why must a baseline be "evidenced" and not just "assumed"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine vermutete Baseline führt zu Erweiterungen, die auf falschen Annahmen stehen. Nur ein belegter
   Ausgangszustand macht Erweiterungen prüfbar; alles Unbelegte bleibt `Open` mit Folgeaktion.
   **EN:** An assumed baseline leads to extensions built on wrong assumptions. Only an evidenced starting state
   makes extensions verifiable; anything unevidenced stays `Open` with a follow-up action.

   </details>

2. **DE:** (AE) Warum ist im 3. Lehrjahr die Begründung einer Entscheidung wichtiger als die Auswahl selbst? /
   **EN:** (AE) Why is the rationale of a decision more important than the choice itself in year 3?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mehrere Optionen können funktionieren; entscheidend ist, ob die gewählte Option zu Zielbild, Risiko
   und Aufwand passt. Eine dokumentierte Begründung mit Trade-off macht die Entscheidung nachvollziehbar und
   später revidierbar.
   **EN:** Several options can work; what matters is whether the chosen option fits the target picture, risk,
   and effort. A documented rationale with trade-off makes the decision traceable and revisable later.

   </details>

3. **DE:** (AE) Was gehört minimal in einen ADR-Kandidaten? /
   **EN:** (AE) What minimally belongs in an ADR candidate?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mindestens: die Entscheidung, mindestens eine echte Alternative, die gewählte Option, die Begründung
   und die Folge (Trade-off). Ohne Alternative ist es keine Entscheidung, sondern nur eine Feststellung.
   **EN:** At least: the decision, at least one real alternative, the chosen option, the rationale, and the
   consequence (trade-off). Without an alternative it is not a decision but only a statement.

   </details>

4. **DE:** Wozu dienen Nicht-Ziele im Feature-Zielbild? /
   **EN:** What is the purpose of non-goals in the feature target picture?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie grenzen bewusst aus, was nicht dazugehört, und verhindern so Scope-Creep. Zugleich schützen sie
   die Datenminimierung, indem sie das Sammeln unnötiger, oft personenbezogener Daten ausschließen.
   **EN:** They deliberately exclude what does not belong and thus prevent scope creep. At the same time they
   protect data minimization by excluding the collection of unnecessary, often personal data.

   </details>

5. **DE:** (SI) Warum darf eine Erweiterung den Dienst-Lebenszyklus nicht brechen, und wie weist man das
   nach? / **EN:** (SI) Why must an extension not break the service lifecycle, and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Sammel-Dienst muss weiter sauber starten und stoppen; eine Erweiterung, die das verhindert,
   gefährdet den Betrieb. Nachweis: ein Start/Stop- oder Shutdown-Test, der zeigt, dass der Dienst mit der
   Erweiterung geordnet startet und beendet.
   **EN:** A collection service must still start and stop cleanly; an extension that prevents this endangers
   operation. Evidence: a start/stop or shutdown test showing the service starts and stops in an orderly way
   with the extension.

   </details>

6. **DE:** (DPA) Warum wird jedem Feature ein Schutzbedarf zugeordnet? /
   **EN:** (DPA) Why is a protection need assigned to each feature?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Schutzbedarf zeigt, welche Sicherheitsziele (Vertraulichkeit, Integrität, Verfügbarkeit) ein
   Feature berührt, und lenkt die späteren Prüfungen. Bei Statusdaten ist oft die Integrität hoch, weil aus
   ihnen Betriebsentscheidungen folgen.
   **EN:** The protection need shows which security goals (confidentiality, integrity, availability) a feature
   touches and guides later checks. For status data, integrity is often high because operational decisions
   follow from it.

   </details>

7. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: verteiltes
   Deployment ist `N/A`, weil der Track zunächst eine lokale Erweiterung plant. So bleibt sichtbar, dass der
   Standard geprüft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: distributed
   deployment is `N/A` because the track first plans a local extension. This keeps visible that the standard
   was checked.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die v2-Baseline belegt von geplanten Erweiterungen trennen.
- [ ] ein prüfbares Feature-Zielbild mit Zweck je Feature formulieren.
- [ ] mindestens zwei sinnvolle Nicht-Ziele nennen.
- [ ] jedem Feature einen Schutzbedarf zuordnen.
- [ ] zwei Entwurfsentscheidungen als ADR-Kandidaten mit Trade-off festhalten.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] separate the evidenced v2 baseline from planned extensions.
- [ ] formulate a testable feature target picture with a purpose per feature.
- [ ] name at least two meaningful non-goals.
- [ ] assign a protection need to each feature.
- [ ] record two design decisions as ADR candidates with a trade-off.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
