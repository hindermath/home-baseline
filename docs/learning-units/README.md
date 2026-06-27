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

## Arbeitsmodell / Working Model

**DE:** Die Lernreihe ist für ein dreistufiges Arbeitsmodell vorbereitet:

- **Level 0:** `home-baseline-tmp` bleibt die zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, mitgeltende Dokumente, Spec-Kit-Presets und Intake-Vorlagen.
- **Level 1:** Ein späteres privates Workspace-Repo, empfohlen `SecureCaseTrackerProjects`, koordiniert die gesamte Reihe, Statusmatrix und Abarbeitungsreihenfolge.
- **Level 2:** Je Ziel-Sprache entsteht ein eigenes privates Projekt-Repo: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust` und `SecureCaseTracker-Swift`.

**EN:** The learning series is prepared for a three-level working model:

- **Level 0:** `home-baseline-tmp` remains the central source for learning material, guideline, checklists, related documents, Spec Kit presets, and intake templates.
- **Level 1:** A later private workspace repository, recommended as `SecureCaseTrackerProjects`, coordinates the full series, status matrix, and processing order.
- **Level 2:** Each target language gets its own private project repository: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust`, and `SecureCaseTracker-Swift`.

**DE:** Die lokalen Level-2-Ordner verwenden CamelCase. Die zugehörigen GitHub-Repository-Slugs werden durch `bootstrap-project.sh` lowercase erzeugt, zum Beispiel `securecasetracker-csharp`.

**EN:** The local Level 2 folders use CamelCase. The matching GitHub repository slugs are created lowercase by `bootstrap-project.sh`, for example `securecasetracker-csharp`.

**DE:** Codex oder andere KI-Agenten dürfen diese Struktur vorbereiten, aber die eigentlichen Spec-Kit-Läufe werden später bewusst manuell durch Lehrende oder Lernende gestartet. C# ist als erster Referenzpfad vorgesehen; die anderen MSL-Sprachen dienen danach als Vergleichs- und Vertiefungspfade.

**EN:** Codex or other AI agents may prepare this structure, but the actual Spec Kit runs are started later and deliberately by instructors or learners. C# is planned as the first reference path; the other MSL languages then serve as comparison and deeper practice paths.

## Verbindung zu Lastenheften / Relation to Intake Files

**DE:** Die fachliche und didaktische Erklärung liegt in diesem Verzeichnis. Die später einzeln ausführbaren Spec-Kit-Intakes liegen als `Lastenheft_Secure-CaseTracker*.md` im Repository-Wurzelverzeichnis. Dadurch bleiben sie über `Lastenheft_Abarbeitungsreihenfolge.md` auffindbar.

**EN:** The functional and didactic explanation lives in this directory. The later individually runnable Spec Kit intake files live as `Lastenheft_Secure-CaseTracker*.md` in the repository root. This keeps them discoverable through `Lastenheft_Abarbeitungsreihenfolge.md`.
