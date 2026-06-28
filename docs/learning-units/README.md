# Lernmaterialien / Learning Units

**Zweck / Purpose**

**DE:** Dieses Verzeichnis enthält ausführliche Lernmaterialien für sichere Entwicklung mit GitHub Spec Kit, Memory-Safe Languages (MSL), Sandbox-Nutzung und auditfähiger Dokumentation. Die Materialien sind DE-first, EN-second, CEFR-B2-orientiert und für Fachinformatiker*innen ab dem 1. Lehrjahr verständlich aufgebaut.

**EN:** This directory contains detailed learning material for secure development with GitHub Spec Kit, memory-safe languages (MSL), sandbox use, and audit-ready documentation. The material is DE-first, EN-second, CEFR-B2-oriented, and written for IT specialist apprentices from the first training year onward.

## Secure CaseTracker

**DE:** Die erste Lernreihe heißt [Secure CaseTracker Lernreihe](Secure-CaseTracker-Lernreihe.md). Sie nutzt die fiktive Übungsfirma **EuFPA – Europäische Firma Programmiert Alles** als fachlichen Rahmen. Die Lernenden planen ein kleines System für Kundenanfragen, Assets, Bearbeitungsnotizen und Prozesskennzahlen.

**EN:** The first learning series is [Secure CaseTracker Learning Series](Secure-CaseTracker-Lernreihe.md). It uses the fictional training company **EuFPA – European Company Programs Everything** as the business frame. Learners plan a small system for customer requests, assets, work notes, and process metrics.

Der ausführliche [Secure CaseTracker Unterrichtsleitfaden](Secure-CaseTracker-Unterrichtsleitfaden.md) erklärt Reihenfolge, Fachrichtungsbezug, typische Fehler, Nachweise und den didaktischen Einsatz der Reihe.

*The detailed [Secure CaseTracker Teaching Guide](Secure-CaseTracker-Unterrichtsleitfaden.md) explains order, specialization fit, common mistakes, evidence, and didactic use of the series.*

Die Präsentationen unter [`presentations/`](presentations/) dienen als Einführung vor dem ersten Spec-Kit-Lauf. Die Markdown-Dateien sind für eine spätere Pandoc-Umwandlung nach PowerPoint vorbereitet; die Markdown-Quelle bleibt die gepflegte Fassung.

*The presentations under [`presentations/`](presentations/) provide an introduction before the first Spec Kit run. The Markdown files are prepared for later Pandoc conversion to PowerPoint; the Markdown source remains the maintained version.*

## Wiederverwendbare Lernreihen / Reusable Learning Series

**DE:** Dieses Verzeichnis ist nicht nur fuer Secure CaseTracker gedacht. Es ist die Level-0-Quelle fuer weitere Lernreihen ab dem 1., 2. und 3. Lehrjahr. Der [Lernreihen-Blueprint](Lernreihen-Blueprint.md) beschreibt das generische Vorgehen. Das [Lernreihen-Register](Lernreihen-Register.md) zeigt, welche Reihen vorbereitet, geplant oder aktiv sind.

**EN:** This directory is not only for Secure CaseTracker. It is the level-0 source for additional learning series from the first, second, and third training year onward. The [Learning Series Blueprint](Lernreihen-Blueprint.md) describes the generic approach. The [Learning Series Register](Lernreihen-Register.md) shows which series are prepared, planned, or active.

Neue Reihen nutzen die Vorlagen unter [`templates/`](templates/):

- [`Lernreihe-Vorlage.md`](templates/Lernreihe-Vorlage.md)
- [`Lastenheft-Lernaufgabe-Vorlage.md`](templates/Lastenheft-Lernaufgabe-Vorlage.md)

*New series use the templates under [`templates/`](templates/).*

Die generische [Git-Start-Anleitung fuer Lernende](GIT-START-FUER-LERNENDE.md) wird in Lernpakete kopiert, damit Lernende nach dem Entpacken einen eigenen Git-Verlauf ohne urspruengliche Remotes starten koennen.

*The generic [Git start guide for learners](GIT-START-FUER-LERNENDE.md) is copied into learning packages so learners can start their own Git history after extraction, without original remotes.*

## Arbeitsmodell / Working Model

**DE:** Die Lernreihe ist für ein dreistufiges Arbeitsmodell vorbereitet:

- **Level 0:** `home-baseline-tmp` bleibt die zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, mitgeltende Dokumente, Spec-Kit-Presets und Intake-Vorlagen.
- **Level 1:** Ein späteres privates Workspace-Repo, empfohlen `SecureCaseTrackerProjects`, koordiniert die gesamte Reihe, Statusmatrix und Abarbeitungsreihenfolge.
- **Level 2:** Je Ziel-Sprache entsteht ein eigenes privates Projekt-Repo: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust` und `SecureCaseTracker-Swift`. Jedes Level-2-Repo fuehrt die Secure-Development-Basis lokal mit: Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente, Preset-Verzahnung und installierte Governance-Presets aus der zentralen Matrix.

**EN:** The learning series is prepared for a three-level working model:

- **Level 0:** `home-baseline-tmp` remains the central source for learning material, guideline, checklists, related documents, Spec Kit presets, and intake templates.
- **Level 1:** A later private workspace repository, recommended as `SecureCaseTrackerProjects`, coordinates the full series, status matrix, and processing order.
- **Level 2:** Each target language gets its own private project repository: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust`, and `SecureCaseTracker-Swift`. Each level-2 repository carries the secure-development baseline locally: guideline, 12 individual checklists, compendium, related documents, preset alignment, and installed governance presets from the central matrix.

**DE:** Die lokalen Level-2-Ordner verwenden CamelCase. Die zugehörigen GitHub-Repository-Slugs werden durch `bootstrap-project.sh` lowercase erzeugt, zum Beispiel `securecasetracker-csharp`.

**EN:** The local Level 2 folders use CamelCase. The matching GitHub repository slugs are created lowercase by `bootstrap-project.sh`, for example `securecasetracker-csharp`.

**DE:** Codex oder andere KI-Agenten dürfen diese Struktur vorbereiten, aber die eigentlichen Spec-Kit-Läufe werden später bewusst manuell durch Lehrende oder Lernende gestartet. C# ist als erster Referenzpfad vorgesehen; die anderen MSL-Sprachen dienen danach als Vergleichs- und Vertiefungspfade.

**EN:** Codex or other AI agents may prepare this structure, but the actual Spec Kit runs are started later and deliberately by instructors or learners. C# is planned as the first reference path; the other MSL languages then serve as comparison and deeper practice paths.

## Verbindung zu Lastenheften / Relation to Intake Files

**DE:** Die fachliche und didaktische Erklärung liegt in diesem Verzeichnis. Die später einzeln ausführbaren Spec-Kit-Intakes liegen hier ebenfalls als `Lastenheft_Secure-CaseTracker*.md`. Dadurch bleiben Lernmaterial, Unterrichtsleitfaden, Präsentationen und Intake-Dateien zusammen und sind zusätzlich über `Lastenheft_Abarbeitungsreihenfolge.md` auffindbar.

**EN:** The functional and didactic explanation lives in this directory. The later individually runnable Spec Kit intake files also live here as `Lastenheft_Secure-CaseTracker*.md`. This keeps learning material, teaching guide, presentations, and intake files together while also making them discoverable through `Lastenheft_Abarbeitungsreihenfolge.md`.
