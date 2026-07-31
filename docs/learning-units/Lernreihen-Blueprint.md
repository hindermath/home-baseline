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

**DE:** Jede neue oder geänderte Lernreihe bindet die
[Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) ein. Die Basis gilt ab
dem 1. Lehrjahr auch für Kaufleute für IT-System-Management und Kaufleute für
Digitalisierungsmanagement. Reihenwurzeln müssen diese Vererbung sichtbar
nennen; einzelne Lernaufgaben dürfen sie über die Reihenwurzel übernehmen.

**EN:** Every new or changed learning series binds the
[Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md). From training year 1,
the baseline also covers IT system management and digitalisation management
trainees. Series roots must state this inheritance; individual units may
inherit it through the series root.

## Grundregeln / Core Rules

- **DE-first, EN-second:** Deutsche Fassung zuerst, englische Erlaeuterung danach.
- **CEFR B2:** Saetze klar, fachlich genau und ohne unnoetige Fremdwoerter.
- **WCAG 2.2 AA:** Markdown muss mit Tastatur, Screenreader, Braille-Zeile und Textbrowser nutzbar bleiben.
- **Vorkenntnisse:** Keine vorherige Spec-Kit-Erfahrung voraussetzen; Fach- und
  Workflow-Begriffe beim ersten Auftreten erklären.
- **Text-first:** Abhängigkeiten, Status, Entscheidungen und nächste Schritte
  immer als Text erklären; Diagramme sind nur Ergänzungen.
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

**DE:** Lernreihen koennen neben Fachinformatiker-Fachrichtungen auch weitere IT-Ausbildungsberufe didaktisch adressieren. Das Mapping bleibt eine Unterrichtshilfe und erzeugt keine neuen Repositories. Als Mindestmatrix gelten FI/AE, FI/SI, FI/DPA, FI/DV, IT-System-Elektroniker/-in, Kaufmann/-frau fuer IT-System-Management (KITSM) und Kaufmann/-frau fuer Digitalisierungsmanagement (KDM).

Fuer KITSM und KDM ist eine eigenstaendige, fachlich gleichwertige Progression vorbereitet. Sie verwendet C# als Referenzsprache, SQL als verpflichtende deklarative Bruecke und die vorhandenen Secure-Trader-Domaenen als gemeinsame Fallbeispiele:

1. Im ersten Lehrjahr werden vorhandene Grundlagen um kaufmaennische Rollen, einfache C#- und SQL-Arbeit, Datenschutz, sichere Abnahme und nachvollziehbare Evidence ergaenzt.
2. Im zweiten Lehrjahr folgt ein gemeinsamer kaufmaennischer Kern zu Anforderungen, Kosten, Beschaffung, Verträgen, Servicequalitaet, Daten und Prozessverbesserung.
3. Im dritten Lehrjahr trennen sich KITSM und KDM in eigene berufsspezifische Vertiefungen.

Die Positionen 18 bis 25 der aktiven Intake-Reihenfolge bereiten Audit, Lernarchitektur, Jahrgaenge, kontrollierten C#-Rollout und Abschlusspruefung vor. Bis diese Laeufe umgesetzt sind, bleibt die `Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md` die gueltige Uebergangsbasis. Die Vorbereitung startet keinen Lernenden- oder Spec-Kit-Lauf automatisch.

Für IT-System-Elektroniker*innen (ITSE) ist eine eigene, fachlich gleichwertige
Progression vorbereitet. Sie vergleicht vorrangig mit allen vier
FI-Fachrichtungen. Systemintegration und Digitale Vernetzung liegen fachlich
besonders nah; Anwendungsentwicklung sowie Daten- und Prozessanalyse bleiben
für Softwareanpassung, Diagnose, Messdatenauswertung und sichere
Automatisierung sichtbar:

1. Im ersten Lehrjahr werden LF1 bis LF5 gemeinsam wiederverwendet und ab LF2
   um Energie-, Leitungsdimensionierungs- und Schutzgrenzen ergänzt.
2. Im zweiten Lehrjahr folgen LF6 bis LF9 mit Service, cyber-physischen
   Systemen, Datenbereitstellung, Netzwerken und Diagnose.
3. Im dritten Lehrjahr bilden LF10 bis LF12 eine eigene ITSE-Reihe zu
   Energieversorgung, Betriebssicherheit vernetzter Systeme und
   Instandhaltung.

C# bleibt die Referenzsprache für Simulation, Diagnose, Testautomation und
Dokumentation. C# ersetzt keine elektrotechnische Praxis. Elektrische
Schalt-, Mess- oder Inbetriebnahmearbeit findet nur in freigegebenen
Lernumgebungen und unter fachkundiger Aufsicht statt; ein KI-Agent steuert
keine elektrische Anlage. Die Positionen 26 bis 32 bereiten den ITSE-Strang
vor. Die Positionen 33 bis 37 prüfen danach alle FI-, ITSE-, KITSM- und
KDM-Reihen in sich, gegen ihre normativen Quellen und insgesamt zueinander,
einschließlich nachvollziehbarer berufsbezogener KI-Kompetenz.

**EN:** Learning series may also address additional IT training occupations didactically. The mapping remains a teaching aid and does not create repositories. The minimum matrix covers FI/AE, FI/SI, FI/DPA, FI/DV, IT systems electronics technician, IT systems management clerk (KITSM), and digitalization management clerk (KDM).

A dedicated, professionally equivalent progression is prepared for KITSM and KDM. It uses C# as the reference language, SQL as the mandatory declarative bridge, and the existing Secure Trader domains as shared case studies:

1. Year 1 extends the existing foundations with commercial roles, basic C# and SQL work, data protection, secure acceptance, and traceable evidence.
2. Year 2 provides a shared commercial core covering requirements, cost, procurement, contracts, service quality, data, and process improvement.
3. Year 3 separates into occupation-specific KITSM and KDM advanced tracks.

Positions 18 through 25 of the active intake order prepare the audit, learning architecture, training years, controlled C# rollout, and final closure review. Until those runs are implemented, `Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md` remains the valid transitional baseline. Preparation does not automatically start a learner or Spec Kit run.

A dedicated, professionally equivalent progression is prepared for IT systems
electronics technicians (ITSE). It compares primarily with all four
IT-specialist tracks. System Integration and Digital Networking are especially
close; Application Development and Data and Process Analysis remain visible
for software adaptation, diagnostics, measurement-data evaluation, and safe
automation:

1. Year 1 reuses LF1 through LF5 and adds ITSE power, conductor-sizing, and
   protection boundaries from LF2 onward.
2. Year 2 covers LF6 through LF9 with service, cyber-physical systems, data
   exchange, networks, and diagnostics.
3. Year 3 provides a dedicated LF10 through LF12 series for power supply,
   operational safety of networked systems, and maintenance.

C# remains the reference language for simulation, diagnostics, test
automation, and documentation. It does not replace electrical practice.
Electrical switching, measurement, or commissioning takes place only in
approved learning environments under qualified supervision; an AI agent never
controls an electrical installation. Positions 26 through 32 prepare the ITSE
track. Positions 33 through 37 then check all FI, ITSE, KITSM, and KDM series
internally, against their normative sources, and together, including traceable
occupation-specific AI competence.

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

**DE:** Die öffentliche Basis für Level-2-Repos bleibt das zentrale Acht-Preset-Profil. Thorstens registrierte Lernreihen-Flotte wählt zusätzlich Intake Authoring, Intake Review und Intake Sequencing über `intake-sequencing-eleven-governance-presets`. Authoring verwaltet Intakes und ausdrücklich freigegebene Serien; Review prüft Inhalte und Hashes unabhängig; Sequencing verwaltet Reihenfolge und Abhängigkeiten. Die Installation erteilt keine Ausführungsautorität. Kein Lernendenlauf startet ohne ausdrücklichen Auftrag.

**EN:** The public baseline for level-2 repositories remains the central eight-preset profile. Thorsten's registered learning-series fleet additionally selects Intake Authoring, Intake Review, and Intake Sequencing through `intake-sequencing-eleven-governance-presets`. Authoring manages intakes and explicitly approved series; Review independently validates content and hashes; Sequencing manages order and dependencies. Installation grants no execution authority. No learner run starts without explicit authorization.

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
