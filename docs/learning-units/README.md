# Lernmaterialien / Learning Units

**Zweck / Purpose**

**DE:** Dieses Verzeichnis enthält ausführliche Lernmaterialien für sichere Entwicklung mit GitHub Spec Kit, Memory-Safe Languages (MSL), Sandbox-Nutzung und auditfähiger Dokumentation. Die Materialien sind DE-first, EN-second, CEFR-B2-orientiert und für Fachinformatiker*innen ab dem 1. Lehrjahr verständlich aufgebaut.

**EN:** This directory contains detailed learning material for secure development with GitHub Spec Kit, memory-safe languages (MSL), sandbox use, and audit-ready documentation. The material is DE-first, EN-second, CEFR-B2-oriented, and written for IT specialist apprentices from the first training year onward.

## Start fuer Lernende / Start for Learners

**DE:** Beginne mit
[`START-HERE-FUER-LERNENDE.md`](START-HERE-FUER-LERNENDE.md). Der Leitfaden
fuehrt ohne vorausgesetzte Git-, Container- oder Agentenkenntnisse vom
persoenlichen `home-baseline`-Fork beziehungsweise das institutionell
bereitgestellte Lernenden-Repository ueber die Required-Werkzeuge und die
Podman-Sandbox bis zum ersten kontrollierten Agentenlauf.

**EN:** Start with
[`START-HERE-FUER-LERNENDE.md`](START-HERE-FUER-LERNENDE.md). The guide assumes
no prior Git, container, or agent knowledge and leads from the personal
`home-baseline` fork or institution-provided learner repository through the
required tools and Podman sandbox to the first
controlled agent run.

Ausbildende, die GitLab, Codeberg, Forgejo oder ein anderes institutionelles
Git-System verwenden, beginnen mit
[`INSTITUTIONELLES-GIT-HOSTING.md`](INSTITUTIONELLES-GIT-HOSTING.md).

## Secure CaseTracker

**DE:** Die erste Lernreihe heißt [Secure CaseTracker Lernreihe](Secure-CaseTracker-Lernreihe.md). Sie nutzt die fiktive Übungsfirma **EuFPA - Europäische Firma Programmiert Alles** als fachlichen Rahmen. Die Lernenden planen ein kleines System für Kundenanfragen, Assets, Bearbeitungsnotizen und Prozesskennzahlen.

**EN:** The first learning series is [Secure CaseTracker Learning Series](Secure-CaseTracker-Lernreihe.md). It uses the fictional training company **EuFPA - European Company Programs Everything** as the business frame. Learners plan a small system for customer requests, assets, work notes, and process metrics.

Der ausführliche [Secure CaseTracker Unterrichtsleitfaden](Secure-CaseTracker-Unterrichtsleitfaden.md) erklärt Reihenfolge, Fachrichtungsbezug, typische Fehler, Nachweise und den didaktischen Einsatz der Reihe.

*The detailed [Secure CaseTracker Teaching Guide](Secure-CaseTracker-Unterrichtsleitfaden.md) explains order, specialization fit, common mistakes, evidence, and didactic use of the series.*

## Sandbox-Stufung / Sandbox Staging

**DE:** Die sichere Entwicklungs-Sandbox ist als oeffentliches Referenz-Repo
verfuegbar: <https://github.com/hindermath/absdd-image-sandbox>. Institutionen
koennen diese Referenz in ihr eigenes Git-System uebertragen. Das
Container-First-Gate gilt fuer Secure CaseTracker, Secure OrderDesk und Secure
ServiceHarvester verbindlich ab Unit 00: Jeder Agentenaufruf erfolgt in der
Podman-Sandbox. Wird kein Agent verwendet, darf der Sandbox-Punkt begruendet als
`N/A` dokumentiert werden. Lesen, Review und normale agentenlose Codearbeit
duerfen ausserhalb der Sandbox stattfinden.

**EN:** The secure development sandbox is available as a public reference
repository: <https://github.com/hindermath/absdd-image-sandbox>. Institutions
may transfer this reference to their own Git system. The
container-first gate applies to Secure CaseTracker, Secure OrderDesk, and Secure
ServiceHarvester from unit 00 onward: every agent invocation runs inside the
Podman sandbox. If no agent is used, the sandbox item may be documented as
justified `N/A`. Reading, review, and normal agent-free coding may happen outside
the sandbox.

## Lernreihen ab dem 2. Lehrjahr / Learning Series from the Second Training Year

**DE:** Für Lernende ab dem 2. Lehrjahr sind zwei Reihen vorbereitet:

- [Secure CaseTracker v2](Secure-CaseTracker-v2-Lernreihe.md) vertieft die vorhandene Reihe in Richtung Architektur, Persistenz, Service-Verträge, Autorisierung, Audit-Logging, CI, Sandbox, Betrieb und MSL-Vergleich.
- [Secure InventoryHub](Secure-InventoryHub-Lernreihe.md) ist ein eigenständiger Praxisfall zu Inventar, Softwareständen, Rollen, Datenqualität, Patch-/Wartungsstatus, SBOM-Bezug, Tests und Betriebsnachweisen.

**EN:** Two series are prepared for learners from the second training year onward:

- [Secure CaseTracker v2](Secure-CaseTracker-v2-Lernreihe.md) deepens the existing series toward architecture, persistence, service contracts, authorization, audit logging, CI, sandbox, operation, and MSL comparison.
- [Secure InventoryHub](Secure-InventoryHub-Lernreihe.md) is a standalone practical case about inventory, software versions, roles, data quality, patch/maintenance state, SBOM relation, tests, and operational evidence.

Die zugehörigen Unterrichtsleitfäden sind [Secure CaseTracker v2 Unterrichtsleitfaden](Secure-CaseTracker-v2-Unterrichtsleitfaden.md) und [Secure InventoryHub Unterrichtsleitfaden](Secure-InventoryHub-Unterrichtsleitfaden.md).

*The related teaching guides are [Secure CaseTracker v2 Teaching Guide](Secure-CaseTracker-v2-Unterrichtsleitfaden.md) and [Secure InventoryHub Teaching Guide](Secure-InventoryHub-Unterrichtsleitfaden.md).*

## Lernreihen ab dem 3. Lehrjahr / Learning Series from the Third Training Year

**DE:** Für das 3. Lehrjahr ist [Secure CaseTracker Professional Tracks](Secure-CaseTracker-Professional-Tracks-Lernreihe.md) vorbereitet. Die Reihe nutzt den bekannten CaseTracker-Fall weiter, trennt die Arbeit aber in vier Spezialisierungen:

- [Secure CaseTracker Application Track](Secure-CaseTracker-Application-Track-Lernreihe.md) für AE.
- [Secure CaseTracker Operations Track](Secure-CaseTracker-Operations-Track-Lernreihe.md) für SI.
- [Secure CaseTracker Data & Process Track](Secure-CaseTracker-Data-Process-Track-Lernreihe.md) für DPA.
- [Secure CaseTracker Digital Networking Track](Secure-CaseTracker-Digital-Networking-Track-Lernreihe.md) für DV.

**EN:** [Secure CaseTracker Professional Tracks](Secure-CaseTracker-Professional-Tracks-Lernreihe.md) is prepared for the third training year. It continues the known CaseTracker case but separates the work into four specializations: Application, Operations, Data & Process, and Digital Networking.

Jeder Track enthält einen Unterrichtsleitfaden, ein Master-Lastenheft, zehn einzelne Aufgaben-Intakes und DE/EN-Präsentationen. Die späteren Spec-Kit-Läufe werden manuell pro Track, Sprachpfad und Aufgaben-Lastenheft gestartet. Sie begleiten die Aufgaben, ersetzen aber nicht das klassische Erlernen des jeweiligen Berufsbildes.

*Each track contains a teaching guide, master intake, ten individual task intakes, and DE/EN presentations. Later Spec Kit runs are started manually per track, language path, and task intake. They accompany the tasks but do not replace learning the respective occupation.*

## Berufsbild-Mapping / Occupation Mapping

**DE:** Das [IT-Berufe-Mapping für Secure CaseTracker](IT-Berufe-Secure-CaseTracker-Mapping.md) ordnet die vorhandenen Reihen den Fachinformatiker-Fachrichtungen AE, SI, DPA und DV sowie den weiteren IT-Berufen IT-System-Elektroniker/-in, Kaufmann/-frau für IT-System-Management und Kaufmann/-frau für Digitalisierungsmanagement zu.

**EN:** The [IT occupation mapping for Secure CaseTracker](IT-Berufe-Secure-CaseTracker-Mapping.md) maps the existing series to the IT specialist specializations AE, SI, DPA, and DV, and to the additional IT occupations IT systems electronics technician, IT systems management clerk, and digitalization management clerk.

## Präsentationen / Presentations

Die Präsentationen unter [`presentations/`](presentations/) dienen als Einführung vor dem ersten Spec-Kit-Lauf. Die neutrale [Spec-Kit-SDD-Auftaktinformation](SPEC-KIT-SDD-AUFTAKT.md) und die zugehörige Präsentation erklären Spec-Driven Development ohne organisationsspezifische Workshop-Bezüge. Die Markdown-Dateien sind für eine spätere Pandoc-Umwandlung nach PowerPoint vorbereitet; die Markdown-Quelle bleibt die gepflegte Fassung.

*The presentations under [`presentations/`](presentations/) provide an introduction before the first Spec Kit run. The neutral [Spec Kit SDD kickoff](SPEC-KIT-SDD-AUFTAKT.md) and the related presentation explain spec-driven development without organization-specific workshop references. The Markdown files are prepared for later Pandoc conversion to PowerPoint; the Markdown source remains the maintained version.*

## Wiederverwendbare Lernreihen / Reusable Learning Series

**DE:** Dieses Verzeichnis ist nicht nur für Secure CaseTracker gedacht. Es ist die Level-0-Quelle für weitere Lernreihen ab dem 1., 2. und 3. Lehrjahr. Der [Lernreihen-Blueprint](Lernreihen-Blueprint.md) beschreibt das generische Vorgehen. Das [Lernreihen-Register](Lernreihen-Register.md) zeigt, welche Reihen vorbereitet, geplant oder aktiv sind.

**EN:** This directory is not only for Secure CaseTracker. It is the level-0 source for additional learning series from the first, second, and third training year onward. The [Learning Series Blueprint](Lernreihen-Blueprint.md) describes the generic approach. The [Learning Series Register](Lernreihen-Register.md) shows which series are prepared, planned, or active.

Neue Reihen nutzen die Vorlagen unter [`templates/`](templates/):

- [`Lernreihe-Vorlage.md`](templates/Lernreihe-Vorlage.md)
- [`Lastenheft-Lernaufgabe-Vorlage.md`](templates/Lastenheft-Lernaufgabe-Vorlage.md)

*New series use the templates under [`templates/`](templates/).*

Die generische [Git-Start-Anleitung für Lernende](GIT-START-FUER-LERNENDE.md) wird in Lernpakete kopiert, damit Lernende nach dem Entpacken einen eigenen Git-Verlauf ohne ursprüngliche Remotes starten können.

*The generic [Git start guide for learners](GIT-START-FUER-LERNENDE.md) is copied into learning packages so learners can start their own Git history after extraction, without original remotes.*

## Arbeitsmodell / Working Model

**DE:** Die Lernreihen sind für ein dreistufiges Arbeitsmodell vorbereitet:

- **Level 0:** `home-baseline-tmp` bleibt die zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, mitgeltende Dokumente, Spec-Kit-Presets und Intake-Vorlagen.
- **Level 1:** Ein späteres privates Workspace-Repo pro Reihe koordiniert Statusmatrix, Abarbeitungsreihenfolge und Links zu den Sprachpfaden.
- **Level 2:** Je Ziel-Sprache entsteht ein eigenes privates Projekt-Repo. Für sprachneutrale Reihen sind C#, Go, Java, Python, Rust und Swift die Standardpfade. Jedes Level-2-Repo führt die Secure-Development-Basis lokal mit: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente, Preset-Verzahnung und installierte Governance-Presets aus der zentralen Matrix.

**EN:** The learning series are prepared for a three-level working model:

- **Level 0:** `home-baseline-tmp` remains the central source for learning material, guideline, checklists, related documents, Spec Kit presets, and intake templates.
- **Level 1:** A later private workspace repository per series coordinates the status matrix, processing order, and links to the language paths.
- **Level 2:** Each target language gets its own private project repository. For language-neutral series, C#, Go, Java, Python, Rust, and Swift are the standard paths. Each level-2 repository carries the secure-development baseline locally: guideline, 12 individual checklists, compendium, related documents, preset alignment, and installed governance presets from the central matrix.

**DE:** Codex oder andere KI-Agenten dürfen diese Struktur vorbereiten, aber die eigentlichen Spec-Kit-Läufe werden später bewusst manuell durch Lehrende oder Lernende gestartet. C# ist als erster Referenzpfad vorgesehen; die anderen MSL-Sprachen dienen danach als Vergleichs- und Vertiefungspfade.

**EN:** Codex or other AI agents may prepare this structure, but the actual Spec Kit runs are started later and deliberately by instructors or learners. C# is planned as the first reference path; the other MSL languages then serve as comparison and deeper practice paths.

## Scaffold, Baseline und Tracks / Scaffold, Baseline, and Tracks

**DE:** Sprachrepos starten mit einem technischen `00`-Intake, bevor fachliche Aufgaben beginnen. Dieser Lauf prüft minimales Projekt, Build/Test, Secure-Development-Basis und Governance-Presets. Fortgeschrittene Secure-CaseTracker-Reihen ab Jahr 2 erweitern den vorhandenen Sprachpfad. Jahr 3 leitet AE-, SI-, DPA- oder DV-Tracks aus dem abgeschlossenen Jahr-2-Stand mit Tag `learning/year-2-complete` ab.

**EN:** Language repositories start with a technical `00` intake before functional tasks begin. This run verifies the minimal project, build/test setup, secure-development baseline, and governance presets. Advanced Secure CaseTracker series from year 2 onward extend the existing language path. Year 3 derives AE, SI, DPA, or DV tracks from the completed year-2 state tagged as `learning/year-2-complete`.

**DE:** Jedes Level-2-Sprachrepo fuehrt zusaetzlich einen separaten `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`-Intake. Dieser prueft Richtlinie Sichere Entwicklung, CL_01 bis CL_12, Sammelband, mitgeltende Dokumente und Presets als Selbstpruefung vor spaeterer Haertung. Er gilt unabhaengig von MSL; MSL-Status wird als eigener Pruefpunkt dokumentiert.

**EN:** Each level-2 language repository also carries a separate `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` intake. It checks the secure-development guideline, CL_01 through CL_12, compendium, related documents, and presets as a self-assessment before later hardening. It applies independently of MSL; MSL status is documented as its own checkpoint.

## Verbindung zu Lastenheften / Relation to Intake Files

**DE:** Die fachliche und didaktische Erklärung liegt in diesem Verzeichnis. Die später einzeln ausführbaren Spec-Kit-Intakes liegen hier ebenfalls als `Lastenheft_*.md`. Dadurch bleiben Lernmaterial, Unterrichtsleitfaden, Präsentationen und Intake-Dateien zusammen und sind zusätzlich über die Reihenbeschreibungen auffindbar.

**EN:** The functional and didactic explanation lives in this directory. The later individually runnable Spec Kit intake files also live here as `Lastenheft_*.md`. This keeps learning material, teaching guide, presentations, and intake files together while making them discoverable through the series descriptions.

## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit der Secure-CaseTracker-Familie und von Secure InventoryHub gibt es einen **Lernbegleiter** unter [`lernbegleiter/`](lernbegleiter/). Der Lernbegleiter erklärt das Thema ausführlich (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor, zeigt den Rahmenlehrplanbezug und enthält Verständnisfragen mit Musterantworten. Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Als zusätzliches Material ersetzt der Lernbegleiter nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of the Secure CaseTracker family and of Secure InventoryHub has a **study companion** under [`lernbegleiter/`](lernbegleiter/). The companion explains the topic in detail (CEFR B2), names key terms, proceeds step by step, shows the curriculum relation, and includes comprehension questions with model answers. The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. As additional material, the companion does not replace vocational school, workplace training, the curriculum, or exam preparation.

**DE:** Die konkreten Lernfelder je Einheit stehen zentral in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Sie ist die einzige verbindliche Quelle für Lernfeld-Bezüge; jeder Lernbegleiter und jedes Lastenheft zitiert daraus. Neue Lernbegleiter nutzen die Vorlage [`templates/Lernbegleiter-Vorlage.md`](templates/Lernbegleiter-Vorlage.md).

**EN:** The concrete learning fields per unit are documented centrally in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). It is the single binding source for learning-field references; every companion and every intake cites from it. New companions use the template [`templates/Lernbegleiter-Vorlage.md`](templates/Lernbegleiter-Vorlage.md).
