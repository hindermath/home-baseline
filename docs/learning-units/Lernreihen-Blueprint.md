# Lernreihen-Blueprint / Learning Series Blueprint

## Zweck / Purpose

**DE:** Dieser Blueprint beschreibt, wie neue Lernreihen fuer Fachinformatiker*innen in diesem Workspace vorbereitet werden. Er ist die kanonische Vorlage fuer spaetere Reihen ab dem 1., 2. und 3. Lehrjahr.

**EN:** This blueprint describes how new learning series for IT specialist apprentices are prepared in this workspace. It is the canonical template for later series from the first, second, and third training year onward.

## Grundregeln / Core Rules

- **DE-first, EN-second:** Deutsche Fassung zuerst, englische Erlaeuterung danach.
- **CEFR B2:** Saetze klar, fachlich genau und ohne unnoetige Fremdwoerter.
- **WCAG 2.2 AA:** Markdown muss mit Tastatur, Screenreader, Braille-Zeile und Textbrowser nutzbar bleiben.
- **MSL-neutral:** Aufgaben duerfen nicht von einer einzelnen Sprache abhaengen, solange das Lernziel sprachneutral ist.
- **Manuelle Spec-Kit-Laeufe:** KI-Agenten bereiten Intakes und Struktur vor, starten aber keine Spec-Kit-Laeufe fuer Lernende.
- **Auditfaehige Nachweise:** Jede Aufgabe benennt erwartete Dokumente, Checklisten, `N/A`-Begruendungen und Evidenzpfade.

*DE-first, EN-second; CEFR B2; WCAG 2.2 AA; memory-safe-language neutral where possible; manual Spec Kit runs only; and audit-ready evidence paths.*

## Level-Modell / Level Model

| Level | Aufgabe / Responsibility | Typischer Inhalt / Typical Content |
|---|---|---|
| Level 0 | Kanonische Quelle / Canonical source | Blueprint, Register, Vorlagen, Richtlinie, Checklisten, Presets |
| Level 1 | Koordination / Coordination | Statusmatrix, Reihenfolge, Lernpaket, Links zu Sprachpfaden |
| Level 2 | Umsetzung / Implementation | ein Repo je MSL-Sprache, lokale Secure-Development-Basis, manuelle Spec-Kit-Laeufe, Projektnachweise |

**DE:** Level 0 bleibt `home-baseline-tmp`. Level 1 ist ein eigenes Koordinations-Repo pro Lernreihe. Level 2 enthaelt die konkreten Sprachpfade und spaeteren Projektergebnisse.

**EN:** Level 0 remains `home-baseline-tmp`. Level 1 is a dedicated coordination repository per learning series. Level 2 contains the concrete language paths and later project results.

## Standard-Sprachpfade / Standard Language Paths

Neue sprachneutrale Lernreihen verwenden standardmaessig diese sechs MSL-Pfade:

1. C# als Referenzpfad
2. Go als kompakter Vergleichspfad
3. Java als JVM-Vergleichspfad
4. Python als dynamischer Daten-/Prozesspfad
5. Rust als stark typisierter Systempfad
6. Swift als Apple-/Swift-Plattformpfad

*New language-neutral learning series normally use C# as the reference path, then Go, Java, Python, Rust, and Swift as comparison paths.*

## Mindestartefakte / Minimum Artefacts

Jede Lernreihe enthaelt mindestens:

- eine Reihenbeschreibung mit Zielgruppe, Lernzielen und Fachrichtungsbezug
- einen Unterrichtsleitfaden fuer Lehrende
- ein Master-Lastenheft als Gesamtlandkarte, nicht als grosser Spec-Kit-Lauf
- einzelne Aufgaben-Lastenhefte als spaetere manuelle Spec-Kit-Intakes
- eine sichtbare Abarbeitungsreihenfolge
- eine Statusmatrix fuer Sprachpfade
- eine Paketierungsanleitung fuer Lernende ohne urspruengliche Git-Remotes
- in jedem Level-2-Sprachrepo die vollstaendige Secure-Development-Basis: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente, Verzahnung zu Spec-Kit-Presets und installierte Presets aus der zentralen Matrix

*Each learning series contains a series description, teaching guide, master map, individual task intakes, processing order, language-path status matrix, a package guide without original Git remotes, and the complete secure-development baseline plus installed governance presets in every level-2 language repository.*

## Secure-Development-Basis in Level 2 / Secure Development Baseline in Level 2

**DE:** Jede Lernaufgabe darf auf `CL_01` bis `CL_12`, den Sammelband und die mitgeltenden Dokumente verweisen. Diese Unterlagen muessen deshalb lokal im jeweiligen Level-2-Repo unter `docs/secure-development/` vorhanden sein. Sie sind Arbeits- und Nachweisgrundlage fuer spaetere manuelle Spec-Kit-Laeufe, nicht nur externe Referenz.

**EN:** Each learning task may reference `CL_01` through `CL_12`, the compendium, and the related documents. These materials therefore must be locally available in each level-2 repository under `docs/secure-development/`. They are working and evidence material for later manual Spec Kit runs, not only external references.

**DE:** Die sechs Governance-Presets werden fuer MSL-Level-2-Repos aus der zentralen Matrix `scripts/config/spec-kit-governance-presets.json` installiert. Der konkrete Spec-Kit-Lauf bleibt manuell; die installierten Presets sind aber Vorbedingung und Nachweisbasis.

**EN:** The six governance presets are installed for MSL level-2 repositories from the central matrix `scripts/config/spec-kit-governance-presets.json`. The actual Spec Kit run remains manual, but the installed presets are prerequisite and evidence baseline.

## Projekt-Scaffold und Baseline-Ableitung / Project Scaffold and Baseline Derivation

**DE:** Neue Sprachrepos starten mit einem technischen `00`-Intake. Dieser Intake erzeugt oder prüft nur ein minimales lauffähiges Projekt, Build-/Testbefehle, Secure-Development-Basis und installierte Presets. Fachliche Aufgaben dürfen nicht stillschweigend ein Projektgerüst erzeugen, wenn dafür ein eigener Startlauf vorgesehen ist.

**EN:** New language repositories start with a technical `00` intake. This intake only creates or verifies a minimal runnable project, build/test commands, the secure-development baseline, and installed presets. Functional tasks must not silently create a project scaffold when a separate scaffold run is defined.

**DE:** Fortgeschrittene Reihen ab dem 2. und 3. Lehrjahr bauen auf einem vorhandenen Sprachrepo auf. Für Spezialisierungen im 3. Lehrjahr wird der fertige Jahr-2-Stand mit einem eindeutigen Tag wie `learning/year-2-complete` gesichert. Abgeleitete Track-Repos oder Track-Kopien dokumentieren ihre Herkunft mit `TRACK_BASELINE.md`; der Jahr-2-Stand dokumentiert sich mit `YEAR2_BASELINE.md`.

**EN:** Advanced series from year 2 and year 3 onward build on an existing language repository. For third-year specializations, the completed year-2 state is preserved with a clear tag such as `learning/year-2-complete`. Derived track repositories or track copies document their origin with `TRACK_BASELINE.md`; the year-2 state documents itself with `YEAR2_BASELINE.md`.

## Jahrgangsplanung / Training-Year Planning

| Lehrjahr / Year | Typischer Fokus / Typical Focus | Erwartete Tiefe / Expected Depth |
|---|---|---|
| ab 1. Lehrjahr | Grundlagen, sichere Eingaben, Git, einfache Prozesse | gefuehrte Aufgaben, klare Nachweise |
| ab 2. Lehrjahr | Architektur, Persistenz, Schnittstellen, Tests, Betrieb | mehr Eigenentscheidung, mehr Varianten |
| ab 3. Lehrjahr | Härtung, Lieferkette, Compliance, Deployment, Review | auditnahe Nachweise, Trade-offs, Abschlussbewertung |

**DE:** Die Jahrgangszuordnung ist ein Startpunkt. Wenn eine Lerngruppe weiter ist, darf eine Reihe frueher genutzt werden, solange Begriffe und Aufgaben angepasst werden.

**EN:** The year assignment is a starting point. If a learner group is more advanced, a series may be used earlier when terms and tasks are adjusted.

## Spec-Kit-Grenzen / Spec Kit Boundaries

- Ein Master-Lastenheft beschreibt die ganze Reihe und wird nicht als ein grosser Lauf gestartet.
- Aufgaben-Lastenhefte werden einzeln mit `/speckit-specify` gestartet.
- Der optimale Specify-Prompt steht am Ende jedes Aufgaben-Lastenhefts.
- Agenten duerfen Dateien vorbereiten, Reihenfolgen pflegen und Pakete erzeugen.
- Agenten starten keine Lernenden-Laeufe, erstellen keine Feature-Branches fuer Lernende und befuellen keine projektspezifischen `docs/security/`-Nachweise ohne ausdruecklichen Auftrag.

*The master intake maps the full series and is not started as one large run. Task intakes are started one by one with `/speckit-specify`. Agents prepare structure and packages, but do not run learner Spec Kit flows without an explicit instruction.*
