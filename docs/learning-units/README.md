# Lernmaterialien / Learning Units

**Zweck / Purpose**

**DE:** Dieses Verzeichnis enthält ausführliche Lernmaterialien für sichere Entwicklung mit GitHub Spec Kit, Memory-Safe Languages (MSL), Sandbox-Nutzung und auditfähiger Dokumentation. Die Materialien sind DE-first, EN-second, CEFR-B2-orientiert und für Fachinformatiker*innen ab dem 1. Lehrjahr verständlich aufgebaut.

**EN:** This directory contains detailed learning material for secure development with GitHub Spec Kit, memory-safe languages (MSL), sandbox use, and audit-ready documentation. The material is DE-first, EN-second, CEFR-B2-oriented, and written for IT specialist apprentices from the first training year onward.

## Secure CaseTracker

**DE:** Die erste Lernreihe heißt [Secure CaseTracker Lernreihe](Secure-CaseTracker-Lernreihe.md). Sie nutzt die fiktive Übungsfirma **EuFPA - Europäische Firma Programmiert Alles** als fachlichen Rahmen. Die Lernenden planen ein kleines System für Kundenanfragen, Assets, Bearbeitungsnotizen und Prozesskennzahlen.

**EN:** The first learning series is [Secure CaseTracker Learning Series](Secure-CaseTracker-Lernreihe.md). It uses the fictional training company **EuFPA - European Company Programs Everything** as the business frame. Learners plan a small system for customer requests, assets, work notes, and process metrics.

Der ausführliche [Secure CaseTracker Unterrichtsleitfaden](Secure-CaseTracker-Unterrichtsleitfaden.md) erklärt Reihenfolge, Fachrichtungsbezug, typische Fehler, Nachweise und den didaktischen Einsatz der Reihe.

*The detailed [Secure CaseTracker Teaching Guide](Secure-CaseTracker-Unterrichtsleitfaden.md) explains order, specialization fit, common mistakes, evidence, and didactic use of the series.*

## Sandbox-Stufung / Sandbox Staging

**DE:** Die sichere Entwicklungs-Sandbox ist jetzt als öffentliches Referenz-Repo verfügbar: <https://github.com/hindermath/absdd-image-sandbox>. In Secure CaseTracker ist sie bewusst gestuft: Im 1. Lehrjahr wird sie erklärt und als Zielbild eingeordnet, aber nicht verpflichtend praktisch eingesetzt. Im 2. Lehrjahr wird sie als Betriebs-, Toolchain- und Nachweiskonzept vorbereitet. Ab dem 3. Lehrjahr wird erwartet, dass Lernende KI-gestützte Entwicklung in oder mit der Sandbox fachlich und technisch begründen können. Lesen, Review, normale Codearbeit und Bedienung von JetBrains IDEs, VS Code oder Windows-only Visual Studio können weiterhin außerhalb der Sandbox erfolgen.

**EN:** The secure development sandbox is now available as a public reference repository: <https://github.com/hindermath/absdd-image-sandbox>. Secure CaseTracker uses it in staged form: in year 1 it is explained and positioned as the target picture, but it is not mandatory for practical use. In year 2 it is prepared as an operational, toolchain, and evidence concept. From year 3 onward, learners are expected to justify AI-assisted development in or with the sandbox from a functional and technical perspective. Reading, review, normal code work, and use of JetBrains IDEs, VS Code, or Windows-only Visual Studio may still happen outside the sandbox.

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

**DE:** Für das 3. Lehrjahr ist [Secure CaseTracker Professional Tracks](Secure-CaseTracker-Professional-Tracks-Lernreihe.md) vorbereitet. Die Reihe nutzt den bekannten CaseTracker-Fall weiter, trennt die Arbeit aber in drei Spezialisierungen:

- [Secure CaseTracker Application Track](Secure-CaseTracker-Application-Track-Lernreihe.md) für AE.
- [Secure CaseTracker Operations Track](Secure-CaseTracker-Operations-Track-Lernreihe.md) für SI.
- [Secure CaseTracker Data & Process Track](Secure-CaseTracker-Data-Process-Track-Lernreihe.md) für DPA.

**EN:** [Secure CaseTracker Professional Tracks](Secure-CaseTracker-Professional-Tracks-Lernreihe.md) is prepared for the third training year. It continues the known CaseTracker case but separates the work into three specializations: Application, Operations, and Data & Process.

Jeder Track enthält einen Unterrichtsleitfaden, ein Master-Lastenheft, zehn einzelne Aufgaben-Intakes und DE/EN-Präsentationen. Die späteren Spec-Kit-Läufe werden manuell pro Track, Sprachpfad und Aufgaben-Lastenheft gestartet.

*Each track contains a teaching guide, master intake, ten individual task intakes, and DE/EN presentations. Later Spec Kit runs are started manually per track, language path, and task intake.*

## Präsentationen / Presentations

Die Präsentationen unter [`presentations/`](presentations/) dienen als Einführung vor dem ersten Spec-Kit-Lauf. Die Markdown-Dateien sind für eine spätere Pandoc-Umwandlung nach PowerPoint vorbereitet; die Markdown-Quelle bleibt die gepflegte Fassung.

*The presentations under [`presentations/`](presentations/) provide an introduction before the first Spec Kit run. The Markdown files are prepared for later Pandoc conversion to PowerPoint; the Markdown source remains the maintained version.*

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

**DE:** Sprachrepos starten mit einem technischen `00`-Intake, bevor fachliche Aufgaben beginnen. Dieser Lauf prüft minimales Projekt, Build/Test, Secure-Development-Basis und Governance-Presets. Fortgeschrittene Secure-CaseTracker-Reihen ab Jahr 2 erweitern den vorhandenen Sprachpfad. Jahr 3 leitet AE-, SI- oder DPA-Tracks aus dem abgeschlossenen Jahr-2-Stand mit Tag `learning/year-2-complete` ab.

**EN:** Language repositories start with a technical `00` intake before functional tasks begin. This run verifies the minimal project, build/test setup, secure-development baseline, and governance presets. Advanced Secure CaseTracker series from year 2 onward extend the existing language path. Year 3 derives AE, SI, or DPA tracks from the completed year-2 state tagged as `learning/year-2-complete`.

**DE:** Jedes Level-2-Sprachrepo fuehrt zusaetzlich einen separaten `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`-Intake. Dieser prueft Richtlinie Sichere Entwicklung, CL_01 bis CL_12, Sammelband, mitgeltende Dokumente und Presets als Selbstpruefung vor spaeterer Haertung. Er gilt unabhaengig von MSL; MSL-Status wird als eigener Pruefpunkt dokumentiert.

**EN:** Each level-2 language repository also carries a separate `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` intake. It checks the secure-development guideline, CL_01 through CL_12, compendium, related documents, and presets as a self-assessment before later hardening. It applies independently of MSL; MSL status is documented as its own checkpoint.

## Verbindung zu Lastenheften / Relation to Intake Files

**DE:** Die fachliche und didaktische Erklärung liegt in diesem Verzeichnis. Die später einzeln ausführbaren Spec-Kit-Intakes liegen hier ebenfalls als `Lastenheft_*.md`. Dadurch bleiben Lernmaterial, Unterrichtsleitfaden, Präsentationen und Intake-Dateien zusammen und sind zusätzlich über die Reihenbeschreibungen auffindbar.

**EN:** The functional and didactic explanation lives in this directory. The later individually runnable Spec Kit intake files also live here as `Lastenheft_*.md`. This keeps learning material, teaching guide, presentations, and intake files together while making them discoverable through the series descriptions.
