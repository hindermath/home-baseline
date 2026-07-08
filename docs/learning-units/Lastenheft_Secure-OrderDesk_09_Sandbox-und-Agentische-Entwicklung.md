# Lastenheft: Secure OrderDesk 09 - Sandbox und agentische Entwicklung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI, DV, AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox`, öffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Lernende können erklären, warum KI-gestützte Entwicklungsarbeit an der Bestell-/Handelsplattform Secure OrderDesk in einer freigegebenen Sandbox stattfinden **muss** und welche Nachweise dafür erforderlich sind. Das Container-First-Gate (jeder KI-Agenten-Aufruf im Container, nie auf dem Arbeitsplatz-Rechner) gilt ab Unit 00 verbindlich; diese Einheit vertieft die vollständige Sandbox-Profilierung (Mounts, Egress, Nachweise).

**EN:** Learners can explain why AI-assisted development work on the Secure OrderDesk ordering/trading platform **must** happen in an approved sandbox and which evidence is required. The container-first gate (every AI-agent invocation inside the container, never on the workstation) is binding from unit 00; this unit deepens the full sandbox profiling (mounts, egress, evidence).

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Welche technische Grenze schützt den Host und die Testdatenbank vor Fehlern in der Sandbox? |
| DV | mittel bis hoch | Welche Netzwerkannahme der Plattform muss als Risikoentscheidung dokumentiert werden? |
| AE | mittel bis hoch | Welche Projektdateien darf ein Agent im Plattform-Repo verändern? |
| DPA | mittel bis hoch | Welche Kunden- oder Bestelldaten dürfen einem KI-Agenten nicht übergeben werden? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Entwicklungsumgebung, vernetzte Systeme, Schutzbedarf, Toolchain-Betrieb und dokumentierte Arbeitsprozesse rund um eine relationale Bestell-/Handelsplattform.

**EN:** The task connects secure development environment, networked systems, protection needs, toolchain operation, and documented work processes around a relational ordering/trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 2 („Arbeitsplätze nach Kundenwunsch ausstatten") und LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_09_Sandbox-und-Agentische-Entwicklung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 2 ("Arbeitsplätze nach Kundenwunsch ausstatten") and LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_09_Sandbox-und-Agentische-Entwicklung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, KI-Codeerzeugung, Sandbox-Freigabe, reproduzierbare Toolchain.
- **Checklisten:** CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Plane, wie Secure-OrderDesk-Aufgaben später in oder mit `absdd-image-sandbox` bearbeitet werden können. Dokumentiere Mounts, Schreibgrenzen, Netzwerkannahmen, Secret-Regeln (z. B. Datenbank-Zugangsdaten), den Umgang mit einer fiktiven Testdatenbank (Northwind inkl. `ALFKI`), den Toolchain-Status für die sechs Zielsprachen und klare Grenzen für KI-Agenten (Codex, Copilot, Claude, Gemini). Halte ausdrücklich das Container-First-Gate fest: Jeder KI-Agenten-Aufruf erfolgt im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner (Grundlage `Secure-Trader-Sandbox-Preflight.md`). Nur agentenlose Tätigkeit — allgemeine Entwicklung, Lesen und Review — darf außerhalb stattfinden, z. B. mit VS Code oder JetBrains-IDEs.

**EN:** Plan how Secure OrderDesk tasks can later be worked on in or with `absdd-image-sandbox`. Document mounts, write boundaries, network assumptions, secret rules (e.g. database credentials), the handling of a fictitious test database (Northwind incl. `ALFKI`), the toolchain status for the six target languages, and clear boundaries for AI agents (Codex, Copilot, Claude, Gemini). Explicitly record the container-first gate: every AI-agent invocation happens inside the container/sandbox, never on the workstation (basis `Secure-Trader-Sandbox-Preflight.md`). Only agent-free work — general development, reading, and review — may happen outside, e.g. with VS Code or JetBrains IDEs.

## Anforderungen / Requirements

- **R-01:** Mounts, Schreibgrenzen, Netzwerkannahmen und Secret-Regeln (inkl. Datenbank-Zugangsdaten und fiktiver Testdatenbank) sind dokumentiert.
- **R-02:** Jede der sechs Zielsprachen erhält einen Toolchain-Status `Supported`, `Open` oder `N/A`.
- **R-03:** Die Grenzen für KI-Agenten sind für Codex, Copilot, Claude und Gemini gleichwertig verständlich.
- **R-04:** Das Container-First-Gate ist festgehalten: Jeder KI-Agenten-Aufruf erfolgt ab Unit 00 verbindlich im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner. Diese Einheit vertieft die vollständige Sandbox-Profilierung (Mounts, Egress, Nachweise).
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Agenten dürfen nur in freigegebenen Arbeitsbereichen schreiben; Netzwerkzugriffe und Datenbankverbindungen sind begrenzt oder als Risikoentscheidung dokumentiert.
- Secrets und Datenbank-Zugangsdaten gehören nicht in Prompts, Logs, Screenshots oder Projektdateien; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Keine echten personenbezogenen Kunden- oder Bestelldaten in Agentenläufen; Testdaten bleiben fiktiv und datensparsam (Northwind-Layout inkl. `ALFKI`).
- Logs aus Sandbox- oder Agentenläufen werden auf sensible Inhalte geprüft; Spec-Kit-Artefakte bleiben im Projekt, Agenten-Caches nicht.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle sechs Zielsprachen werden in der MSL-Support-Matrix bewertet.
- Sandbox-Regeln gelten unabhängig vom verwendeten KI-Agenten.
- Fehlende Toolchains werden nicht verschwiegen, sondern als `Open` mit Folgeaufgabe dokumentiert.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Sandbox-Einordnung dieser Aufgabe.
- `plan.md` mit Isolations-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Konfigurations- und Dokumentationsschritten.
- Sandbox-Entscheidung, Mount-Liste, Regeln für die fiktive Testdatenbank, MSL-Support-Matrix, KI-Agenten-Grenzen.
- Erwartete Evidenz: Mount-/Netzwerk-/Secret-Tabelle, Toolchain-Status je Sprache, Applicable-/N/A-/Open-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Mounts, Schreibgrenzen, Netzwerk, Secrets und Testdatenbank-Regeln sind dokumentiert.
- [ ] Jede Zielsprachen-Toolchain hat einen Status.
- [ ] Agenten-Grenzen sind für Codex, Copilot, Claude und Gemini gleichwertig verständlich.
- [ ] Das Container-First-Gate ist verbindlich formuliert: KI-Agenten-Aufrufe nur im Container, nie auf dem Arbeitsplatz-Rechner.
- [ ] Keine echten personenbezogenen Daten oder Secrets sind für Agentenläufe vorgesehen.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_09_Sandbox-und-Agentische-Entwicklung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Sandbox-Einordnung und -Vertiefung der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI): Public-Referenz absdd-image-sandbox, Mounts, Schreibgrenzen, Secret-Regeln, fiktive Testdatenbank, Netzwerkannahmen, MSL-Support-Matrix, KI-Agenten-Grenzen und das verbindliche Container-First-Gate (jeder KI-Agenten-Aufruf im Container, nie auf dem Arbeitsplatz-Rechner, gemäß Secure-Trader-Sandbox-Preflight.md). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
