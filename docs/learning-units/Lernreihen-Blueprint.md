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
| Level 2 | Umsetzung / Implementation | ein Repo je MSL-Sprache, manuelle Spec-Kit-Laeufe, Projektnachweise |

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

*Each learning series contains a series description, teaching guide, master map, individual task intakes, processing order, language-path status matrix, and a package guide without original Git remotes.*

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
