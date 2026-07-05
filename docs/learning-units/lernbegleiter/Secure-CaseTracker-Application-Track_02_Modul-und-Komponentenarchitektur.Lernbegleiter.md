# Lernbegleiter: Secure CaseTracker Application Track 02 – Modul- und Komponentenarchitektur / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_02_Modul-und-Komponentenarchitektur.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Anwendung, die als ein einziger großer Block gebaut wird, lässt sich schwer prüfen, testen und
absichern. Deshalb teilt man sie in **Module** und **Komponenten** mit klaren Grenzen. Jede Grenze legt fest,
wer wen aufrufen darf und wo eine **Vertrauensgrenze** (Trust Boundary) verläuft. Gute Modulgrenzen sind wie
Zimmertüren in einem Haus: Man weiß, welcher Raum wofür da ist, und ein Problem in einem Raum bleibt möglichst
dort. In dieser Einheit entwirfst du die Komponentenlandschaft des CaseTracker und legst die
Abhängigkeitsrichtung fest.

**EN:** An application built as one large block is hard to review, test, and secure. Therefore you split it
into **modules** and **components** with clear boundaries. Each boundary defines who may call whom and where a
**trust boundary** runs. Good module boundaries are like room doors in a house: you know which room serves
which purpose, and a problem in one room stays there as much as possible. In this unit you design the
component landscape of the CaseTracker and fix the direction of dependencies.

**DE:** Du lernst, Verantwortlichkeiten zu schneiden, Abhängigkeiten in eine Richtung zeigen zu lassen und
Kandidaten für Architekturentscheidungen (ADR) früh zu erkennen.

**EN:** You learn to cut responsibilities, let dependencies point in one direction, and spot candidates for
architecture decisions (ADR) early.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Modul / Module | Abgegrenzter Baustein mit einer klaren Verantwortung. |
| Komponente / Component | Ausführbarer oder wiederverwendbarer Teil mit einer definierten Schnittstelle. |
| Abhängigkeitsrichtung / Dependency direction | Wer darf wen kennen und aufrufen; sie soll nur in eine Richtung zeigen. |
| Trust Boundary / Trust boundary | Grenze, an der nicht vertrauenswürdige Daten geprüft werden müssen. |
| Kopplung / Coupling | Wie stark Module voneinander abhängen; lose Kopplung ist Ziel. |
| ADR-Kandidat / ADR candidate | Entscheidung, die wichtig genug für ein Architecture Decision Record ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Verantwortlichkeiten schneiden.** Ordne jede Aufgabe einer Komponente zu: z. B.
Eingang/Schnittstelle, Fachlogik (Fälle, Zustände), Persistenz, Querschnitt (Logging, Validierung). Warum?
Eine Komponente mit einer klaren Verantwortung ist leichter zu testen und zu prüfen.

**EN:** **Step 1 – Cut responsibilities.** Assign each task to a component: e.g. input/interface, business
logic (cases, states), persistence, cross-cutting (logging, validation). Why? A component with one clear
responsibility is easier to test and review.

**DE:** **Schritt 2 – Abhängigkeiten in eine Richtung.** Lege fest, dass die Fachlogik nicht von der
Persistenz-Technik abhängt, sondern umgekehrt. So bleibt der Kern austauschbar und testbar. Zyklische
Abhängigkeiten sind ein Warnsignal: Sie machen Änderungen riskant und Tests schwer.

**EN:** **Step 2 – Dependencies in one direction.** Decide that the business logic does not depend on the
persistence technology, but the other way around. This keeps the core replaceable and testable. Cyclic
dependencies are a warning sign: they make changes risky and tests hard.

**DE:** **Schritt 3 – Trust Boundaries markieren.** Zeichne ein, wo Daten von außen (Schnittstelle, Import)
in den geschützten Kern übergehen. An genau diesen Stellen muss später validiert werden. Eine Komponente ohne
markierte Grenze verleitet dazu, Prüfungen zu vergessen.

**EN:** **Step 3 – Mark trust boundaries.** Draw where data from outside (interface, import) crosses into the
protected core. Exactly at these places validation must happen later. A component without a marked boundary
tempts you to forget checks.

**DE:** **Schritt 4 – ADR-Kandidaten sammeln.** Jede Entscheidung mit Alternativen und Folgen ist ein
ADR-Kandidat: „Schichten- oder hexagonale Architektur?", „Ein Modul oder getrennte Module für Import und
Kernlogik?" Notiere die Kandidaten; die eigentlichen ADRs entstehen in Einheit 09.

**EN:** **Step 4 – Collect ADR candidates.** Every decision with alternatives and consequences is an ADR
candidate: "layered or hexagonal architecture?", "one module or separate modules for import and core logic?"
Note the candidates; the actual ADRs are written in unit 09.

**DE:** **Typische Fehler.** Alles in eine Komponente packen. Abhängigkeiten kreuz und quer erlauben. Trust
Boundaries nicht markieren. Technische Details (Datenbanktreiber) in den Fachkern lecken lassen. Entscheidungen
treffen, ohne Alternativen zu notieren.

**EN:** **Common mistakes.** Putting everything into one component. Allowing dependencies in all directions.
Not marking trust boundaries. Letting technical details (database drivers) leak into the business core. Making
decisions without noting alternatives.

### Beispiel / Example

```text
Komponentenübersicht (Zielbild)
[Schnittstelle/CLI]  --ruft-->  [Fachlogik: Fälle, Zustände]  --nutzt-->  [Persistenz-Port]
        |                                    |                                   ^
   Trust Boundary                       [Querschnitt:                     [Persistenz-Adapter
   (Eingaben pruefen)                    Logging, Validierung]             (Datei/DB)]

Abhängigkeitsregel: Fachlogik kennt nur den Persistenz-*Port* (Schnittstelle),
nie den konkreten *Adapter*. -> Kern bleibt testbar und austauschbar.

ADR-Kandidat: "Hexagonale Architektur mit Ports/Adaptern"
  Alternative: klassische Schichtenarchitektur
  Trade-off: mehr Struktur vs. mehr anfängliche Komplexität
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Der modulare Aufbau ist die tragende Struktur, in der Funktionalität sicher realisiert wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Persistenz-Port und -Adapter bestimmen, wie die Datenverwaltung angebunden und angepasst wird. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Trust Boundaries und Separation of
Concerns. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und
`CL_10` (Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser Einheit lautet: *Abhängigkeiten
zeigen nur in eine Richtung, und jede Trust Boundary ist benannt.* A11Y-Aspekt: Architekturbilder brauchen
eine gleichwertige Textbeschreibung (Komponenten, Richtungen, Grenzen), damit sie ohne Grafik verständlich
bleiben; Pfeile und Grenzen dürfen nicht allein über Farbe unterschieden werden.

**EN:** Relation to the Secure Development Guideline: secure architecture, trust boundaries, and separation of
concerns. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_10`
(secure development environment). The security decision of this unit is: *dependencies point in only one
direction, and every trust boundary is named.* Accessibility aspect: architecture diagrams need an equivalent
text description (components, directions, boundaries) so they stay understandable without graphics; arrows and
boundaries must not be distinguished by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sollen Abhängigkeiten nur in eine Richtung zeigen? /
   **EN:** Why should dependencies point in only one direction?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Einseitige Abhängigkeiten halten den Fachkern von technischen Details frei, machen ihn testbar und
   austauschbar. Zyklen machen Änderungen riskant und Tests schwer.
   **EN:** One-way dependencies keep the business core free of technical details, making it testable and
   replaceable. Cycles make changes risky and tests hard.

   </details>

2. **DE:** Warum ist eine markierte Trust Boundary mehr als eine Zeichnung? /
   **EN:** Why is a marked trust boundary more than a drawing?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie legt fest, wo später zwingend validiert werden muss. Ohne markierte Grenze wird die Prüfung
   leicht vergessen, und ungeprüfte Daten gelangen in den Kern.
   **EN:** It defines where validation is later mandatory. Without a marked boundary the check is easily
   forgotten, and unchecked data reaches the core.

   </details>

3. **DE:** Was unterscheidet einen Persistenz-Port von einem Persistenz-Adapter? /
   **EN:** What distinguishes a persistence port from a persistence adapter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Port ist die abstrakte Schnittstelle, die der Fachkern kennt; der Adapter ist die konkrete
   Umsetzung (Datei, Datenbank). Der Kern hängt nur vom Port ab, nicht vom Adapter.
   **EN:** The port is the abstract interface known to the business core; the adapter is the concrete
   implementation (file, database). The core depends only on the port, not the adapter.

   </details>

4. **DE:** Woran erkennst du einen ADR-Kandidaten? /
   **EN:** How do you recognize an ADR candidate?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An einer Entscheidung mit echten Alternativen und spürbaren Folgen (Trade-offs). Solche
   Entscheidungen sollten dokumentiert werden, damit sie später nachvollziehbar sind.
   **EN:** By a decision with real alternatives and noticeable consequences (trade-offs). Such decisions should
   be documented so they stay traceable later.

   </details>

5. **DE:** Warum ist lose Kopplung ein Sicherheitsvorteil, nicht nur ein Komfort? /
   **EN:** Why is loose coupling a security advantage, not only convenience?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Lose Kopplung begrenzt, wie weit sich ein Fehler oder Angriff ausbreitet, und erlaubt, einzelne
   Teile gezielt zu prüfen und zu härten. Enge Kopplung verteilt Risiko über das ganze System.
   **EN:** Loose coupling limits how far an error or attack spreads and allows reviewing and hardening single
   parts. Tight coupling spreads risk across the whole system.

   </details>

6. **DE:** Wie hängt diese Einheit mit dem Realisieren von Funktionalität (LF 11a) zusammen? /
   **EN:** How does this unit relate to realizing functionality (LF 11a)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Modulstruktur ist der Rahmen, in dem Funktionen sauber, testbar und sicher umgesetzt werden.
   Ohne tragfähige Struktur wird Funktionalität unübersichtlich und schwer prüfbar.
   **EN:** The module structure is the frame in which functions are implemented cleanly, testably, and
   securely. Without a viable structure, functionality becomes tangled and hard to verify.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Verantwortlichkeiten auf Komponenten mit klarer Aufgabe aufteilen.
- [ ] die Abhängigkeitsrichtung festlegen und Zyklen vermeiden.
- [ ] Trust Boundaries im Architekturbild benennen.
- [ ] Port und Adapter unterscheiden und die Regel dazu formulieren.
- [ ] ADR-Kandidaten mit Alternativen sammeln.

**EN:** I can …

- [ ] split responsibilities into components with a clear task.
- [ ] set the dependency direction and avoid cycles.
- [ ] name trust boundaries in the architecture picture.
- [ ] distinguish port and adapter and state the rule for it.
- [ ] collect ADR candidates with alternatives.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_02_Modul-und-Komponentenarchitektur.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_02_Modul-und-Komponentenarchitektur.md`. The copy-paste
prompt for a later, manually started Spec Kit run is provided there.
