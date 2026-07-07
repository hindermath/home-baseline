# Lastenheft: Secure CaseTracker 09 - Sandbox und agentische Entwicklung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI, AE, DPA
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox`, öffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>

## Lernziel / Learning Goal

**DE:** Lernende können erklären, warum KI-gestützte Entwicklungsarbeit in einer freigegebenen Sandbox stattfinden soll und welche Nachweise später dafür erforderlich sind. Im 1. Lehrjahr ist praktische Sandbox-Nutzung noch keine Pflicht.

**EN:** Learners can explain why AI-assisted development should happen in an approved sandbox and which evidence will later be required for that. In the first training year, practical sandbox use is not yet mandatory.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Sekundär | Welche Projektdateien darf ein Agent verändern? |
| SI | Primär | Welche technische Grenze schützt den Host vor Fehlern in der Sandbox? |
| DPA | Sekundär | Welche Daten dürfen einem KI-Agenten nicht übergeben werden? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Entwicklungsumgebung, vernetzte Systeme, Schutzbedarf, Toolchain-Betrieb und dokumentierte Arbeitsprozesse.

**EN:** The task connects secure development environment, networked systems, protection needs, toolchain operation, and documented work processes.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 2 („Arbeitsplätze nach Kundenwunsch ausstatten"), LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_09_Sandbox-und-Agentische-Entwicklung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 2 ("Arbeitsplätze nach Kundenwunsch ausstatten"), LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_09_Sandbox-und-Agentische-Entwicklung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, KI-Codeerzeugung, Sandbox-Freigabe.
- **Checklisten:** CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** agent-parity-governance, cross-platform-governance, security-governance.

## Aufgabenstellung / Task

**DE:** Plane, wie Secure-CaseTracker-Aufgaben später in oder mit `absdd-image-sandbox` bearbeitet werden können. Dokumentiere Mounts, Schreibgrenzen, Netzwerkannahmen, Secret-Regeln, Toolchain-Status für die sechs Zielsprachen und Grenzen für KI-Agenten. Halte ausdrücklich fest, dass im 1. Lehrjahr auch Arbeit außerhalb der Sandbox zulässig ist, wenn die Sandbox-Technologien noch nicht ausreichend behandelt wurden. Allgemeine Entwicklung, Lesen, Review und Bedienung der Werkzeuge dürfen außerhalb der Sandbox stattfinden, zum Beispiel mit JetBrains IDEs, VS Code oder unter Windows mit Visual Studio; die Sandbox ist das Zielbild für KI-Agenten, reproduzierbare Toolchains, riskantere Experimente sowie klare Schreib- und Netzwerkgrenzen.

**EN:** Plan how Secure CaseTracker tasks can later be worked on in or with `absdd-image-sandbox`. Document mounts, write boundaries, network assumptions, secret rules, toolchain status for the six target languages, and AI-agent boundaries. Explicitly record that work outside the sandbox remains acceptable in the first training year if the sandbox technologies have not been covered deeply enough. General development, reading, review, and tool operation may happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Visual Studio on Windows; the sandbox is the target picture for AI agents, reproducible toolchains, higher-risk experiments, and clear write and network boundaries.

## Anforderungen / Requirements

- **R-01:** Mounts, Schreibgrenzen, Netzwerkannahmen und Secret-Regeln für die Sandbox-Nutzung sind klar dokumentiert.
- **R-02:** Für die sechs Zielsprachen wird ein Toolchain-Status als `Supported`, `Open` oder `N/A` geführt; fehlende Toolchains werden nicht verschwiegen, sondern als `Open` mit Folgeaufgabe notiert.
- **R-03:** Grenzen für KI-Agenten sind für Codex, Copilot, Claude und Gemini gleichwertig verständlich beschrieben; Agenten schreiben nur in freigegebenen Arbeitsbereichen.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder kurzer Begründung dokumentiert; nicht genutzte Zielsprachen können in einem konkreten Lauf `N/A` sein, Cloud-Betrieb ist `N/A`, solange die Sandbox lokal oder containerbasiert bleibt, praktische Sandbox-Nutzung kann im 1. Lehrjahr `N/A` sein, wenn Container-, Mount- oder Agentenkenntnisse noch nicht behandelt wurden, und Netzwerkfreigaben sind `N/A`, wenn der Lauf bewusst offline geplant wird.
- **R-05:** Die Sandbox- und Agenten-Regeln bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Agenten dürfen nur in freigegebenen Arbeitsbereichen schreiben.
- Secrets gehören nicht in Prompts, Logs, Screenshots oder Projektdateien.
- Netzwerkzugriffe sind begrenzt oder als Risikoentscheidung dokumentiert.
- Toolchains werden als `Supported`, `Open` oder `N/A` dokumentiert.
- Keine echten personenbezogenen Daten in Agentenläufen; Testdaten bleiben fiktiv und datensparsam.
- Logs aus Sandbox- oder Agentenläufen werden auf sensible Inhalte geprüft.
- Nicht anwendbare Standards werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle sechs Zielsprachen werden in der MSL-Support-Matrix bewertet.
- Sandbox-Regeln gelten unabhängig vom verwendeten KI-Agenten.
- Spec-Kit-Artefakte bleiben im Projekt, Agenten-Caches nicht.
- C#, Go, Java, Python, Rust und Swift erhalten je einen Status `Supported`, `Open` oder `N/A`.
- Fehlende Toolchains werden nicht verschwiegen, sondern als `Open` mit Folgeaufgabe dokumentiert.
- Sprachspezifische Paketquellen werden nur freigegeben, wenn sie für den Lernlauf benötigt werden.

## Erwartete Artefakte / Expected Artifacts

- Sandbox-Entscheidung.
- Mount-Liste.
- MSL-Support-Matrix.
- KI-Agenten-Grenzen.
- `Applicable` / `N/A` / `Open`-Matrix.
- Liste offener Punkte: fehlende Toolchains je Sprache als `Open` und unklare Netzwerk- oder Secret-Regeln, die vor Agenten-Implementierung geklärt werden müssen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Mounts, Schreibgrenzen, Netzwerk und Secrets sind dokumentiert.
- [ ] Jede Zielsprachen-Toolchain hat einen Status.
- [ ] Agenten-Grenzen sind für Codex, Copilot, Claude und Gemini gleichwertig verständlich.
- [ ] Praktische Sandbox-Nutzung ist für Jahr 1 nicht als Pflicht formuliert, sondern als begründete Vorbereitung.
- [ ] Keine echten personenbezogenen Daten oder Secrets werden für Agentenläufe vorgesehen.
- [ ] Review prüft, ob die Sandbox-Regeln mit CL_12 übereinstimmen und ob alle sechs Zielsprachen bewertet wurden; offene Toolchain- oder Isolationspunkte werden als Follow-up erfasst.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_09_Sandbox-und-Agentische-Entwicklung.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für die vorbereitende Sandbox-Einordnung der Secure-CaseTracker-Lernreihe: Public-Referenz `absdd-image-sandbox`, Mounts, Schreibgrenzen, Secret-Regeln, Netzwerkannahmen, MSL-Support-Matrix, KI-Agenten-Grenzen und klare N/A-Begründung, falls praktische Sandbox-Nutzung im 1. Lehrjahr noch nicht verpflichtend ist. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
