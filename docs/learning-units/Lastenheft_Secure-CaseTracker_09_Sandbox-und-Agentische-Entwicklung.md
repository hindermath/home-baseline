# Lastenheft: Secure CaseTracker 09 - Sandbox und agentische Entwicklung

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können erklären, warum KI-gestützte Entwicklungsarbeit in einer freigegebenen Sandbox stattfinden soll und welche Nachweise dafür erforderlich sind.

**EN:** Learners can explain why AI-assisted development should happen in an approved sandbox and which evidence is required for that.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Sekundär | Entwickler*innen nutzen die Sandbox für Spezifikation, Tests und Codearbeit. |
| SI | Primär | Isolation, Mounts, Netzwerk, Toolchains und Secrets sind Kern der Aufgabe. |
| DPA | Sekundär | Daten und Auswertungen dürfen nicht unkontrolliert in Agentenläufe geraten. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet sichere Entwicklungsumgebung, vernetzte Systeme, Schutzbedarf, Toolchain-Betrieb und dokumentierte Arbeitsprozesse.

**EN:** The task connects secure development environment, networked systems, protection needs, toolchain operation, and documented work processes.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, KI-Codeerzeugung, Sandbox-Freigabe.
- **Checklisten:** CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** agent-parity-governance, cross-platform-governance, security-governance.

## Aufgabenstellung / Task

**DE:** Plane, wie Secure-CaseTracker-Aufgaben in oder mit `absdd-image-sandbox` bearbeitet werden können. Dokumentiere Mounts, Schreibgrenzen, Netzwerkannahmen, Secret-Regeln, Toolchain-Status für die sechs Zielsprachen und Grenzen für KI-Agenten.

**EN:** Plan how Secure CaseTracker tasks can be worked on in or with `absdd-image-sandbox`. Document mounts, write boundaries, network assumptions, secret rules, toolchain status for the six target languages, and AI-agent boundaries.

## Sicherheitsanforderungen / Security Requirements

- Agenten dürfen nur in freigegebenen Arbeitsbereichen schreiben.
- Secrets gehören nicht in Prompts, Logs, Screenshots oder Projektdateien.
- Netzwerkzugriffe sind begrenzt oder als Risikoentscheidung dokumentiert.
- Toolchains werden als `Supported`, `Open` oder `N/A` dokumentiert.

## Datenschutzanforderungen / Privacy Requirements

- Keine echten personenbezogenen Daten in Agentenläufen.
- Testdaten bleiben fiktiv und datensparsam.
- Logs aus Sandbox- oder Agentenläufen werden auf sensible Inhalte geprüft.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Alle sechs Zielsprachen werden in der MSL-Support-Matrix bewertet.
- Sandbox-Regeln gelten unabhängig vom verwendeten KI-Agenten.
- Spec-Kit-Artefakte bleiben im Projekt, Agenten-Caches nicht.

## Sprachspezifische Hinweise / Language-Specific Notes

- C#, Go, Java, Python, Rust und Swift erhalten je einen Status `Supported`, `Open` oder `N/A`.
- Fehlende Toolchains werden nicht verschwiegen, sondern als `Open` mit Folgeaufgabe dokumentiert.
- Sprachspezifische Paketquellen werden nur freigegeben, wenn sie für den Lernlauf benötigt werden.

## Erwartete Artefakte / Expected Artifacts

- Sandbox-Entscheidung.
- Mount-Liste.
- MSL-Support-Matrix.
- KI-Agenten-Grenzen.
- `Applicable` / `N/A` / `Open`-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- Mounts, Schreibgrenzen, Netzwerk und Secrets sind dokumentiert.
- Jede Zielsprachen-Toolchain hat einen Status.
- Agenten-Grenzen sind für Codex, Copilot, Claude und Gemini gleichwertig verständlich.
- Keine echten personenbezogenen Daten oder Secrets werden für Agentenläufe vorgesehen.

## Tests und Nachweise / Tests and Evidence

- Review prüft, ob die Sandbox-Regeln mit CL_12 übereinstimmen.
- Review prüft, ob alle sechs Zielsprachen bewertet wurden.
- Offene Toolchain- oder Isolationspunkte werden als Follow-up erfasst.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Projektdateien darf ein Agent verändern?
- **SI:** Welche technische Grenze schützt den Host vor Fehlern in der Sandbox?
- **DPA:** Welche Daten dürfen einem KI-Agenten nicht übergeben werden?

## N/A-Regeln / N/A Rules

- Nicht genutzte Zielsprachen können in einem konkreten Lauf `N/A` sein, wenn die Lernaufgabe nur eine Sprache prüft.
- Cloud-Betrieb ist `N/A`, solange die Sandbox lokal oder containerbasiert bleibt.
- Netzwerkfreigaben sind `N/A`, wenn der Lauf bewusst offline geplant wird.

## Offene Punkte / Open Follow-Ups

- Fehlende Toolchains werden je Sprache als `Open` notiert.
- Unklare Netzwerk- oder Secret-Regeln müssen vor Agenten-Implementierung geklärt werden.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_09_Sandbox-und-Agentische-Entwicklung.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Sandbox-Nutzung, Mounts, Schreibgrenzen, Secret-Regeln, Netzwerkannahmen, MSL-Support-Matrix und KI-Agenten-Grenzen der Secure-CaseTracker-Lernreihe. Erzeuge keine Implementierung.
```
