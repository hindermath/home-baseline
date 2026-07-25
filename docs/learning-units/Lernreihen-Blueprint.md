# Lernreihen-Blueprint / Learning Series Blueprint

<!-- include-everyone-guiding-principle -->
> **Leitsatz:** `Programmierung #include<everyone>`.
>
> **Guiding principle:** `Programming #include<everyone>`.
>
> **DE:** Jede Lernreihe gestaltet Software, Dokumentation und Lernwege
> inklusiv und barrierefrei. WCAG 2.2 AA, Tastaturbedienung, Screenreader- und
> Texttauglichkeit werden von Anfang an beruecksichtigt und geprueft.
>
> **EN:** Every learning series designs software, documentation, and learning
> paths to be inclusive and accessible. WCAG 2.2 AA, keyboard operation,
> screen-reader support, and text usability are considered and verified from
> the start.

## Zweck / Purpose

**DE:** Dieser Blueprint beschreibt, wie neue Lernreihen fuer Fachinformatiker*innen in diesem Workspace vorbereitet werden. Er ist die kanonische Vorlage fuer spaetere Reihen ab dem 1., 2. und 3. Lehrjahr.

**EN:** This blueprint describes how new learning series for IT specialist apprentices are prepared in this workspace. It is the canonical template for later series from the first, second, and third training year onward.

## Grundregeln / Core Rules

- **DE-first, EN-second:** Deutsche Fassung zuerst, englische Erlaeuterung danach.
- **CEFR B2:** Saetze klar, fachlich genau und ohne unnoetige Fremdwoerter.
- **WCAG 2.2 AA:** Markdown muss mit Tastatur, Screenreader, Braille-Zeile und Textbrowser nutzbar bleiben.
- **MSL-neutral:** Aufgaben duerfen nicht von einer einzelnen Sprache abhaengen, solange das Lernziel sprachneutral ist.
- **Manuelle Spec-Kit-Laeufe:** KI-Agenten bereiten Intakes und Struktur vor, starten aber keine Spec-Kit-Laeufe fuer Lernende.
- **Berufsbild bleibt fuehrend:** Spec-Kit-Laeufe begleiten Aufgaben pro Lehrjahr, Track, Sprachpfad und Aufgaben-Lastenheft; sie ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Pruefungsvorbereitung.
- **Auditfaehige Nachweise:** Jede Aufgabe benennt erwartete Dokumente, Checklisten, `N/A`-Begruendungen und Evidenzpfade.
- **Container-First fuer KI-Agenten:** Jeder KI-Agenten-Aufruf erfolgt in einer freigegebenen Sandbox bzw. einem Container (Referenz: `absdd-image-sandbox`), nie direkt auf dem Arbeitsplatz-Rechner der Auszubildenden. Diese Regel gilt als Gate ab dem 1. Lehrjahr (Unit 00), bevor der erste Agent gestartet wird. Verbindliche Grundlage: [`Secure-Trader-Sandbox-Preflight.md`](Secure-Trader-Sandbox-Preflight.md), `Leitlinie_Sichere-Entwicklungs-Sandbox.md` und `CL_12_Agentische-KI-Sandbox.md`.

*DE-first, EN-second; CEFR B2; WCAG 2.2 AA; memory-safe-language neutral where possible; manual Spec Kit runs only; occupational learning remains leading; audit-ready evidence paths; and container-first for AI agents (every agent invocation runs in an approved sandbox/container, never on the apprentice's workstation, as a gate from year 1 / unit 00 — see `Secure-Trader-Sandbox-Preflight.md`).*

## Gemeinsame fiktive Systemlandschaft / Shared Fictional Landscape

**DE:** Die fiktive Handelsfirma **Secure Trader** betreibt eine Bestell-/Handelsplattform auf Northwind-Datenbasis. Die didaktische Software-Schmiede **EuFPA** baut und betreut für Secure Trader drei ineinandergreifende, aber je **eigenständig nutzbare** Systeme:

- **Secure OrderDesk** — die Handels-/Bestellplattform selbst (Kunden, Produkte, Bestellungen; Northwind-Daten inkl. `ALFKI`).
- **Secure ServiceHarvester** — erfasst System-/Bestandsdaten der Arbeitsplatz-PCs und Server, auf denen die Systeme von Secure Trader laufen.
- **Secure CaseTracker** — Support-Plattform für Support-Cases von Kundinnen/Kunden (Angebot/Bestellung/Lieferung) und internen Mitarbeitenden.

Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit. Jede Lernreihe bleibt eigenständig bearbeitbar. Das gemeinsame Universums- und Datenmodell mit Beispieldaten steht in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md).

**EN:** The fictional trading company **Secure Trader** runs an ordering/trading platform on a Northwind data base. The didactic software house **EuFPA** builds and maintains three interlocking, yet individually usable systems for Secure Trader: **Secure OrderDesk** (the trading platform itself), **Secure ServiceHarvester** (collects system/inventory data of the workstation PCs and servers that run Secure Trader’s systems), and **Secure CaseTracker** (support platform for support cases from customers and internal staff). The coupling is deliberately light: enriching context, not a hard dependency. Every series stays usable on its own. The shared world and data model with sample data is in [`Secure-Trader-Systemlandschaft.md`](Secure-Trader-Systemlandschaft.md).

## Level-Modell / Level Model

| Level | Aufgabe / Responsibility | Typischer Inhalt / Typical Content |
|---|---|---|
| Level 0 | Kanonische Quelle / Canonical source | Blueprint, Register, Vorlagen, Richtlinie, Checklisten, Presets |
| Level 1 | Koordination / Coordination | Statusmatrix, Reihenfolge, Lernpaket, Links zu Sprachpfaden |
| Level 2 | Umsetzung / Implementation | ein Repo je MSL-Sprache, lokale Secure-Development-Basis, manuelle Spec-Kit-Laeufe, Projektnachweise |

**DE:** Level 0 bleibt `home-baseline-source`. Level 1 ist ein eigenes Koordinations-Repo pro Lernreihe. Level 2 enthaelt die konkreten Sprachpfade und spaeteren Projektergebnisse.

**EN:** Level 0 remains `home-baseline-source`. Level 1 is a dedicated coordination repository per learning series. Level 2 contains the concrete language paths and later project results.

## Standard-Sprachpfade / Standard Language Paths

Neue sprachneutrale Lernreihen verwenden standardmaessig diese sechs MSL-Pfade:

1. C# als Referenzpfad
2. Go als kompakter Vergleichspfad
3. Java als JVM-Vergleichspfad
4. Python als dynamischer Daten-/Prozesspfad
5. Rust als stark typisierter Systempfad
6. Swift als Apple-/Swift-Plattformpfad

*New language-neutral learning series normally use C# as the reference path, then Go, Java, Python, Rust, and Swift as comparison paths.*

## IT-Berufsbild-Mapping / IT Occupation Mapping

**DE:** Lernreihen koennen neben Fachinformatiker-Fachrichtungen auch weitere IT-Ausbildungsberufe didaktisch adressieren. Das Mapping bleibt eine Unterrichtshilfe und erzeugt keine neuen Repositories. Als Mindestmatrix gelten FI/AE, FI/SI, FI/DPA, FI/DV, IT-System-Elektroniker/-in, Kaufmann/-frau fuer IT-System-Management und Kaufmann/-frau fuer Digitalisierungsmanagement. Fuer die beiden kaufmaennischen Berufe (KITSM, KDM) beschreibt die `Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`, wie viel Programmierung im agentischen SDD dazugehoert (Rolle Auftraggeber:in/Abnehmer:in, SQL als deklarative Bruecken-Programmiersprache, verpflichtender SQL-Schreib-Touch, evidenzbasierte Abnahme) und wird ohne neue Repos ueber bestehende Lernbegleiter-Overlays und die drei `IT-Berufe-Secure-*-Mapping.md` integriert.

**EN:** Learning series may also address additional IT training occupations didactically. The mapping remains a teaching aid and does not create repositories. The minimum matrix covers FI/AE, FI/SI, FI/DPA, FI/DV, IT systems electronics technician, IT systems management clerk, and digitalization management clerk. For the two commercial occupations (KITSM, KDM) the `Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md` describes how much programming belongs to agentic SDD (client/acceptor role, SQL as declarative bridge language, mandatory SQL write touch, evidence-based acceptance) and is integrated without new repositories through existing study-companion overlays and the three `IT-Berufe-Secure-*-Mapping.md`.

## Mindestartefakte / Minimum Artefacts

Jede Lernreihe enthaelt mindestens:

- eine Reihenbeschreibung mit Zielgruppe, Lernzielen und Fachrichtungsbezug
- einen Unterrichtsleitfaden fuer Lehrende
- ein Master-Lastenheft als Gesamtlandkarte, nicht als grosser Spec-Kit-Lauf
- einzelne Aufgaben-Lastenhefte als spaetere manuelle Spec-Kit-Intakes
- eine sichtbare Abarbeitungsreihenfolge
- eine Statusmatrix fuer Sprachpfade
- eine Paketierungsanleitung fuer Lernende ohne urspruengliche Git-Remotes
- je regulaerer Aufgaben-Einheit einen Lernbegleiter unter `lernbegleiter/` mit ausfuehrlicher Erklaerung (CEFR B2), Kernbegriffen, Schritt-fuer-Schritt-Beispiel, konkretem Lernfeldbezug, Verstaendnisfragen mit Musterantworten und Rueckverweis auf das zugehoerige Lastenheft
- eine zentrale Rahmenlehrplan-Lernfeld-Zuordnung als verbindliche Quelle fuer konkrete Lernfelder je Einheit
- in jedem Level-2-Sprachrepo die vollstaendige Secure-Development-Basis: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente, Verzahnung zu Spec-Kit-Presets und installierte Presets aus der zentralen Matrix

*Each learning series contains a series description, teaching guide, master map, individual task intakes, processing order, language-path status matrix, a package guide without original Git remotes, one study companion per regular task unit under `lernbegleiter/` (detailed explanation, key terms, worked example, concrete learning-field relation, comprehension questions with model answers, backlink to the intake), a central curriculum learning-field mapping as the binding source for concrete learning fields, and the complete secure-development baseline plus installed governance presets in every level-2 language repository.*

## Struktur der Aufgaben-Intakes / Structure of Task Intakes

**DE:** Die Aufgaben-Lastenhefte nutzen als Haus-Default ein **uniformes 12-Abschnitte-Muster** ueber alle
Sub-Reihen hinweg (Basis, v2, Jahr-3-Tracks). Die Jahresprogression und die Erklaertiefe liegen im
Lernbegleiter und in den Anforderungen, nicht in zusaetzlichen Lastenheft-Abschnitten. Beide aktuellen
Familien — **Secure CaseTracker** und **Secure ServiceHarvester** — folgen diesem uniformen Muster und sind
damit auch strukturell zueinander konsistent. Die uniformen 12 Abschnitte sind: `Metadaten`, `Lernziel`,
`Fachrichtungsbezug`, `Rahmenlehrplanbezug`, `Bezug zur Richtlinie Sichere Entwicklung`, `Aufgabenstellung`,
`Anforderungen`, `Sicherheits- und Datenschutzanforderungen`, `Sprachneutrale Anforderungen`,
`Erwartete Artefakte`, `Akzeptanzkriterien` und `Optimaler Specify-Prompt`.

**EN:** The task intakes use a **uniform 12-section shape** as the house default across all sub-series (base,
v2, year-3 tracks). Year progression and explanatory depth live in the study companion and in the
requirements, not in extra intake sections. Both current families — **Secure CaseTracker** and **Secure
ServiceHarvester** — follow this uniform pattern and are therefore also structurally consistent with each
other. The uniform 12 sections are `Metadaten`, `Lernziel`, `Fachrichtungsbezug`, `Rahmenlehrplanbezug`,
`Bezug zur Richtlinie Sichere Entwicklung`, `Aufgabenstellung`, `Anforderungen`, `Sicherheits- und
Datenschutzanforderungen`, `Sprachneutrale Anforderungen`, `Erwartete Artefakte`, `Akzeptanzkriterien`, and
`Optimaler Specify-Prompt`.

### Zwei zulaessige Struktur-Muster / Two Accepted Structure Patterns

**DE:** Fuer die Lastenheft-Struktur einer Familie sind zwei Muster zulaessig. Eine Familie waehlt genau eines
und haelt es in sich durch:

- **Uniform / uniform** (Haus-Default; Referenz: **Secure CaseTracker** und **Secure ServiceHarvester**): Alle
  Sub-Reihen (Basis, v2, Tracks) nutzen einheitlich das schlanke 12-Abschnitte-Niveau. Erklaertiefe und
  Jahresprogression liegen vollstaendig im Lernbegleiter und in den Anforderungen, nicht in zusaetzlichen
  Abschnitten. Reichere Erst-Lehrjahr-Didaktik (Reflexionsfragen, Nachweise, N/A-Begruendung, offene Punkte)
  wird inhaltlich in die 12 Abschnitte eingewebt (z. B. Reflexionsfragen in die `Fachrichtungsbezug`-Tabelle).
- **Gestuft / tiered** (weiterhin zulaessige Variante, aktuell **nicht belegt**): Die Basis (1. Lehrjahr) ist
  am reichsten (rund 17 Abschnitte), v2 schlanker (rund 12), die Jahr-3-Tracks am schlanksten (rund 10).
  Secure CaseTracker war historisch gestuft und wurde bewusst auf das uniforme Muster angeglichen.

**DE:** Beide Muster sind bewusst gewaehlt und geprueft; sie sind kein Konsistenzfehler. Der **Lernbegleiter
bleibt in beiden Mustern identisch strukturiert** (9 Abschnitte), ebenso Familienform, Namenskonvention,
Governance-Anbindung und Bilingualitaet. Der `Optimaler Specify-Prompt / Optimal Specify Prompt`-Abschnitt in
Aufgaben-Lastenheften und der `Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt`-Abschnitt in
Master-Lastenheften werden in beiden Mustern bilingual gefuehrt.

**EN:** Two patterns are allowed for a family's intake structure. A family picks exactly one and keeps it
internally consistent:

- **Uniform** (house default; reference: **Secure CaseTracker** and **Secure ServiceHarvester**): all
  sub-series (base, v2, tracks) use the same lean 12-section level. Explanatory depth and year progression
  live entirely in the study companion and in the requirements, not in extra sections. Richer year-1 didactics
  (reflection questions, evidence, `N/A` rationale, open follow-ups) are woven into the 12 sections in content
  (e.g. reflection questions into the `Fachrichtungsbezug` table).
- **Tiered** (still an allowed variant, currently **not in use**): the base (year 1) is richest (about 17
  sections), v2 leaner (about 12), the year-3 tracks leanest (about 10). Secure CaseTracker was historically
  tiered and was deliberately aligned to the uniform pattern.

**EN:** Both patterns are deliberate and reviewed; they are not a consistency defect. The **study companion
stays identically structured in both patterns** (9 sections), as do family shape, naming convention,
governance wiring, and bilinguality. The `Optimaler Specify-Prompt / Optimal Specify Prompt` section in task
intakes and the `Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt` section in master intakes are kept
bilingual in both patterns.

## Secure-Development-Basis in Level 2 / Secure Development Baseline in Level 2

**DE:** Jede Lernaufgabe darf auf `CL_01` bis `CL_12`, den Sammelband und die mitgeltenden Dokumente verweisen. Diese Unterlagen muessen deshalb lokal im jeweiligen Level-2-Repo unter `docs/secure-development/` vorhanden sein. Sie sind Arbeits- und Nachweisgrundlage fuer spaetere manuelle Spec-Kit-Laeufe, nicht nur externe Referenz.

**EN:** Each learning task may reference `CL_01` through `CL_12`, the compendium, and the related documents. These materials therefore must be locally available in each level-2 repository under `docs/secure-development/`. They are working and evidence material for later manual Spec Kit runs, not only external references.

**DE:** Die oeffentliche Basis fuer MSL-Level-2-Repos bleibt die zentrale Acht-Preset-Matrix. Thorstens registrierte Lernreihen-Flotte waehlt zusaetzlich Intake Authoring, Intake Review und Intake Sequencing ueber `intake-sequencing-eleven-governance-presets`. Authoring bereitet Intakes vor, Review prueft sie hashgebunden und Sequencing verwaltet Reihenfolge und naechste Kandidaten. Kein Lernendenlauf startet ohne ausdruecklichen Auftrag.

**EN:** The public baseline for MSL level-2 repositories remains the central eight-preset matrix. Thorsten's registered learning-series fleet additionally selects Intake Authoring, Intake Review, and Intake Sequencing through `intake-sequencing-eleven-governance-presets`. Authoring prepares intakes, Review validates them against hashes, and Sequencing manages order and next candidates. No learner run starts without explicit authorization.

**DE:** Jede Lernreihe plant fuer Level-2-Repos einen separaten RL-SE-/Checklist-Selbstpruefungs-Intake vor spaeterer Haertung ein. Dieser Intake gilt unabhaengig von MSL und verlangt eine Evidenzmatrix mit `Applicable`, `AlreadySatisfied`, `N/A`, `Open` und `FollowUp`.

**EN:** Each learning series plans a separate RL-SE/checklist self-assessment intake for level-2 repositories before later hardening. This intake applies independently of MSL and requires an evidence matrix with `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, and `FollowUp`.

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
- Spec-Kit-Laeufe sind begleitende SDD-Aufgaben und ersetzen nicht das jeweilige Berufsbild.
- Der optimale Specify-Prompt steht am Ende jedes Aufgaben-Lastenhefts.
- Agenten duerfen Dateien vorbereiten, Reihenfolgen pflegen und Pakete erzeugen.
- Lernreihen-Pakete duerfen Preset-, Policy- und Guidance-Dateien enthalten, aber keine lokalen Review-Ergebnisse, Remotes oder maschinenspezifischen Pfade.
- Agenten starten keine Lernenden-Laeufe, erstellen keine Feature-Branches fuer Lernende und befuellen keine projektspezifischen `docs/security/`-Nachweise ohne ausdruecklichen Auftrag.

*The master intake maps the full series and is not started as one large run. Task intakes are started one by one with `/speckit-specify`. Agents prepare structure and packages, but do not run learner Spec Kit flows without an explicit instruction.*
