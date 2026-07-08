# Lastenheft: Secure CaseTracker 09 - Sandbox und agentische Entwicklung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI, AE, DPA
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox`, öffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>

## Lernziel / Learning Goal

**DE:** Lernende können erklären, warum KI-gestützte Entwicklungsarbeit an der Support-Plattform Secure CaseTracker in einer freigegebenen Sandbox stattfinden **muss** und welche Nachweise dafür erforderlich sind. Das Container-First-Gate (jeder KI-Agenten-Aufruf im Container, nie auf dem Arbeitsplatz-Rechner) gilt ab Unit 00 verbindlich; diese Einheit vertieft die vollständige Sandbox-Profilierung (Mounts, Egress, Nachweise).

**EN:** Learners can explain why AI-assisted development work on the Secure CaseTracker support platform **must** happen in an approved sandbox and which evidence is required. The container-first gate (every AI-agent invocation inside the container, never on the workstation) is binding from unit 00; this unit deepens the full sandbox profiling (mounts, egress, evidence).

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

**DE:** Plane, wie Secure-CaseTracker-Aufgaben später in oder mit `absdd-image-sandbox` bearbeitet werden können. Dokumentiere Mounts, Schreibgrenzen, Netzwerkannahmen, Secret-Regeln, den Umgang mit fiktiven Case-Testdaten, den Toolchain-Status für die sechs Zielsprachen und klare Grenzen für KI-Agenten (Codex, Copilot, Claude, Gemini). Halte ausdrücklich das Container-First-Gate fest: Jeder KI-Agenten-Aufruf erfolgt im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner (Grundlage `Secure-Trader-Sandbox-Preflight.md`). Nur agentenlose Tätigkeit — allgemeine Entwicklung, Lesen und Review — darf außerhalb stattfinden, z. B. mit VS Code oder JetBrains-IDEs.

**EN:** Plan how Secure CaseTracker tasks can later be worked on in or with `absdd-image-sandbox`. Document mounts, write boundaries, network assumptions, secret rules, the handling of fictitious case test data, the toolchain status for the six target languages, and clear boundaries for AI agents (Codex, Copilot, Claude, Gemini). Explicitly record the container-first gate: every AI-agent invocation happens inside the container/sandbox, never on the workstation (basis `Secure-Trader-Sandbox-Preflight.md`). Only agent-free work — general development, reading, and review — may happen outside, e.g. with VS Code or JetBrains IDEs.

## Anforderungen / Requirements

- **R-01:** Mounts, Schreibgrenzen, Netzwerkannahmen und Secret-Regeln für die Sandbox-Nutzung sind klar dokumentiert.
- **R-02:** Für die sechs Zielsprachen wird ein Toolchain-Status als `Supported`, `Open` oder `N/A` geführt; fehlende Toolchains werden nicht verschwiegen, sondern als `Open` mit Folgeaufgabe notiert.
- **R-03:** Grenzen für KI-Agenten sind für Codex, Copilot, Claude und Gemini gleichwertig verständlich beschrieben; Agenten schreiben nur in freigegebenen Arbeitsbereichen.
- **R-04:** Das Container-First-Gate ist festgehalten: Jeder KI-Agenten-Aufruf erfolgt ab Unit 00 verbindlich im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner. Diese Einheit vertieft die vollständige Sandbox-Profilierung (Mounts, Egress, Nachweise).
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder kurzer Begründung dokumentiert; nicht genutzte Zielsprachen können in einem konkreten Lauf `N/A` sein, Cloud-Betrieb ist `N/A`, solange die Sandbox lokal oder containerbasiert bleibt, und Netzwerkfreigaben sind `N/A`, wenn der Lauf bewusst offline geplant wird.
- **R-06:** Die Sandbox- und Agenten-Regeln bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift.

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
- [ ] Das Container-First-Gate ist verbindlich formuliert: KI-Agenten-Aufrufe nur im Container, nie auf dem Arbeitsplatz-Rechner.
- [ ] Keine echten personenbezogenen Daten oder Secrets werden für Agentenläufe vorgesehen.
- [ ] Review prüft, ob die Sandbox-Regeln mit CL_12 übereinstimmen und ob alle sechs Zielsprachen bewertet wurden; offene Toolchain- oder Isolationspunkte werden als Follow-up erfasst.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_09_Sandbox-und-Agentische-Entwicklung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die vertiefende Sandbox-Einordnung der Support-Plattform Secure CaseTracker: Public-Referenz absdd-image-sandbox, Mounts, Schreibgrenzen, Secret-Regeln, fiktive Case-Testdaten, Netzwerkannahmen, MSL-Support-Matrix, KI-Agenten-Grenzen und das verbindliche Container-First-Gate (jeder KI-Agenten-Aufruf im Container, nie auf dem Arbeitsplatz-Rechner, gemäß Secure-Trader-Sandbox-Preflight.md). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
