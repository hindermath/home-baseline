<!-- intake-authoring:begin -->
# Lastenheft: Secure-Development-RL-/CL-/Preset-Gap-Audit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-08-29
**Reihenfolge:** Position 14
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Fachinformatiker*innen, Kaufleute für IT-System-Management,
Kaufleute für Digitalisierungsmanagement, Lehrende, Maintainer und Reviewer
ab dem ersten Ausbildungsjahr

## 1. Zweck / Purpose

Dieser Intake beschreibt einen rein prüfenden Gap-Audit. Ein **Gap** ist eine
nachweisbare Lücke zwischen einer geltenden Anforderung und dem vorhandenen
Dokument- oder Evidence-Stand. Geprüft werden die Richtlinie Sichere
Entwicklung, zwölf Checklisten, der generierte Sammelband, alle mitgeltenden
Dokumente, die aktuelle Preset-Komposition und der Pilotstand von
`absdd-image-sandbox`.

Der Lauf verändert weder Richtlinien noch Presets oder Projektcode. Er schafft
die belastbare Grundlage für ein späteres
`secure-development-assurance-governance`-Preset.

*This intake defines a read-only gap audit across the secure-development
guideline, twelve checklists, the generated compendium, related documents,
governance preset composition, and the `absdd-image-sandbox` pilot state. It
creates evidence for later productization without changing policy, presets, or
product code.*

## Verbindliche Handoff-Ergänzung 2026-08-29

Der Audit bleibt read-only und bewertet den neuen Vertrag mit den vier Gates
baseline, delta, closure und image-impact. Jeder Prüfpunkt führt Anwendbarkeit
(Applicable, N/A, Open) und Umsetzung (Fulfilled, Partly Fulfilled,
Not Fulfilled, Not Assessed) getrennt. Zulässige Gesamtergebnisse sind Ready,
ReadyWithAcceptedRisks, NeedsRemediation und Blocked.

Der Audit bindet Home Baseline, die sechs betroffenen Intakes und den
ABSDD-Ausgangsstand an exakte Commits und Hashes. HOSK/GWDG darf ausschließlich
als ExternalComparison erscheinen. Technische Validierung, Pilotfreigabe,
Projektabnahme und allgemeine Sandbox-/Flottenfreigabe werden nicht
zusammengezogen.

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake steht auf Position 14. Er beginnt erst, wenn Position 5 die aktuelle
Dokumentverzahnung und Position 13 den bestehenden Skript-/Konfigurationsstrang
abgeschlossen haben. Diese Vorgänger verhindern, dass der Audit bewusst
veraltete oder noch in Bearbeitung befindliche Baselines bewertet.

Er liefert die bindende fachliche Grundlage für Position 15
`Lastenheft_Preset-Secure-Development-Assurance-Governance.md`.

## 3. Ausgangslage / Current State

Home Baseline führt unter `docs/secure-development/` eine versionierte
Dokumentfamilie:

- Richtlinie Sichere Entwicklung;
- `CL_01` bis `CL_12`;
- generierter Checklisten-Sammelband;
- `baseline-manifest.json`;
- mitgeltende Dokumente und Standardsverweise;
- das Acht-Preset-Standardprofil und die optionalen Profile bis zum bestehenden
  Zwölfer-Profil.

Technische Sicherheitsanforderungen werden bereits insbesondere durch
`security-governance` und `architecture-governance` abgedeckt. Noch fehlt ein
portabler Assurance-Vertrag, der prüft, ob Richtlinie, Checklisten,
Sammelband, Manifest, Standardsanwendbarkeit und konkrete Evidence
kontrolliert zusammenpassen.

Eine **Assurance** ist hier ein nachvollziehbarer Vertrauensnachweis. Sie ist
keine Zertifizierung. Der Audit darf weder ISO-Konformität behaupten noch eine
organisationsweite Statement of Applicability ersetzen. Eine **Statement of
Applicability (SoA)** ist die organisationsweite Erklärung, welche
ISO/IEC-27001-Kontrollen gelten und wie sie behandelt werden.

## 4. Zielbild / Target State

Der Lauf liefert eine vollständige, textorientierte Mapping-Matrix. Jede
geprüfte Beziehung erhält genau einen Status:

- `Covered`: vollständig und mit Evidence belegt;
- `Partial`: teilweise vorhanden oder nur teilweise belegt;
- `ProjectOnly`: bewusst projektspezifisch und nicht portabel;
- `DuplicateRisk`: drohende Doppelregelung zu einem bestehenden Preset;
- `N/A`: nachweislich nicht anwendbar, mit Begründung und Wiedervorlage.

Jede Zeile nennt Quelle, Ziel, Begründung, Evidence-Pfad, Owner, Reviewer,
Restrisiko und Re-Evaluation-Trigger. Eine rein visuelle Darstellung reicht
nicht aus.

## 5. Scope

Der Audit prüft mindestens:

- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`;
- `docs/secure-development/checklisten/CL_01_*.md` bis `CL_12_*.md`;
- `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`;
- `docs/secure-development/baseline-manifest.json`;
- alle Dateien unter `docs/secure-development/mitgeltende-dokumente/`;
- die acht Standard-Presets und die optionalen Profile 9 bis 12;
- `security-governance` als technische Security-Basis;
- `architecture-governance`, `isaqb-architecture-governance`,
  `a11y-governance`, `cross-platform-governance` und
  `agent-parity-governance`;
- ISO/IEC 27001 und 27002, NIST Secure Software Development Framework (SSDF),
  OWASP Application Security Verification Standard (ASVS), OWASP Software
  Assurance Maturity Model (SAMM), Cyber Resilience Act (CRA) und weitere
  bereits referenzierte Regelwerke;
- den aktuellen Dokument-, Preset- und Evidence-Stand von
  `absdd-image-sandbox`.

## 6. Nicht-Ziele / Non-Goals

- Keine Änderung an Richtlinie, Checklisten, Sammelband oder Manifest.
- Keine Preset-Implementierung oder Preset-Veröffentlichung.
- Keine automatische Synchronisierung nach `absdd-image-sandbox`.
- Keine Produktcode-, API-, Abhängigkeits- oder Toolchain-Änderung.
- Keine ISO-Zertifizierungs-, Audit- oder Compliance-Behauptung.
- Kein automatischer Start von Specify, Autonomous oder Folge-Intakes.

## 7. Anforderungen / Requirements

- **SDG-001:** Der Lauf bindet exakte Pfade, Versionen und normalisierte
  SHA-256-Hashes aller geprüften Dokumente.
- **SDG-002:** Alle zwölf Checklisten-IDs kommen genau einmal in der
  Dokumentinventur vor.
- **SDG-003:** Der Sammelband wird gegen seine zwölf Quelldateien und beide
  vorhandenen Build-Varianten geprüft.
- **SDG-004:** Jedes mitgeltende Dokument erhält genau eine Mapping-Entscheidung
  pro betroffener Richtlinien-, Checklisten- und Preset-Fläche.
- **SDG-005:** Alle acht Standard-Presets und die optionalen Profile 9 bis 12
  werden auf Abdeckung und `DuplicateRisk` geprüft.
- **SDG-006:** Standardsverweise werden auf tatsächliche Anwendbarkeit,
  Evidence-Grenze und unzulässige Zertifizierungsbehauptungen geprüft.
- **SDG-007:** Home Baseline und `absdd-image-sandbox` werden getrennt bewertet;
  projektspezifische Evidence wird nicht als portable Preset-Regel ausgegeben.
- **SDG-008:** Der geplante Preset-Schnitt, die beiden Commands und die
  Kompositionsvoraussetzung `security-governance >=0.6.1` werden ausschließlich
  als Audit-Empfehlung bewertet.
- **SDG-009:** Findings erhalten stabile IDs, Owner, Priorität, Restrisiko,
  Evidence und Re-Evaluation-Trigger.
- **SDG-010:** Deutsch steht vor Englisch, Fachbegriffe werden beim ersten
  Auftreten erklärt, CEFR B2 und anwendbare WCAG-2.2-AA-Kriterien werden
  geprüft.
- **SDG-011:** Der Lauf bleibt read-only gegenüber allen geprüften
  Secure-Development- und ABSDD-Artefakten.
- **SDG-012:** Das Ergebnis trennt eindeutig portable Preset-Anforderungen,
  Home-Baseline-Aufgaben, ABSDD-Aufgaben und begründete Nichtanwendbarkeit.

## 8. Erwartete Artefakte und Evidence

- vollständiges Quellen- und Hashinventar;
- Mapping-Matrix mit den fünf festgelegten Statuswerten;
- priorisierte Findings mit stabilen IDs;
- Duplicate-Risk-Matrix zu vorhandenen Presets;
- dokumentierte Empfehlung für Preset-Schnitt und Pilotgrenzen;
- textorientierter Abschlussbericht mit Restrisiken und nächstem Intake.

## 9. Akzeptanzkriterien / Acceptance Criteria

- **AC-SDG-001:** Alle zwölf Checklisten, der Sammelband, das Manifest und alle
  mitgeltenden Dokumente sind ohne stille Auslassung inventarisiert.
- **AC-SDG-002:** Jede Mapping-Zeile verwendet genau einen erlaubten Status.
- **AC-SDG-003:** `Covered` besitzt konkrete Evidence; `Partial`,
  `DuplicateRisk` und `N/A` besitzen Begründung und Wiedervorlage.
- **AC-SDG-004:** Kein bestehender technischer Security- oder
  Architecture-Preset-Vertrag wird als neue Assurance-Regel dupliziert.
- **AC-SDG-005:** Home Baseline und ABSDD sind getrennt, aber vergleichbar
  ausgewertet.
- **AC-SDG-006:** Der Bericht enthält keine Zertifizierungsbehauptung.
- **AC-SDG-007:** Bash-/PowerShell-Sammelbandprüfung, Hashprüfung,
  `git diff --check`, Secret-Scan und Agent-Parität sind dokumentiert.
- **AC-SDG-008:** Der Lauf endet mit einer belastbaren Empfehlung für Position
  15 und startet sie nicht automatisch.

## 10. Qualitäts- und Schutzgrenzen

`Programmierung #include<everyone>` ist verbindlich. Inhalte müssen ohne
vorherige Spec-Kit-Erfahrung verständlich sein und mit Tastatur, Screenreader,
Braille-Zeile und Textbrowser nutzbar bleiben. Personenbezogene Daten,
Credentials und private absolute Pfade dürfen nicht in veröffentlichbare
Evidence gelangen.

<!-- intake-authoring:prompts -->
## 11. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Secure-Development-RL-CL-Preset-Gap-Audit.md` as one intake in its active ordered series. Verify the read-only audit boundary, complete RL/CL/compendium/manifest/related-document inventory, separation from existing technical governance presets, standards applicability, ABSDD pilot scope, learner accessibility, Position 14 dependencies, and measurable acceptance criteria. Do not change the intake and do not start Specify or Autonomous.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Secure-Development-RL-CL-Preset-Gap-Audit.md` as the binding intake for the existing active order. Create the feature specification for a read-only Secure Development RL/CL/Preset Gap Audit at Position 14. Preserve SDG-001 through SDG-012, AC-SDG-001 through AC-SDG-008, the five exact mapping statuses, the no-certification boundary, the Home Baseline and ABSDD separation, and all learner, security, A11Y, evidence, and non-goal constraints. Do not implement the future preset, change policy documents, or perform remote actions.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Secure-Development-RL-CL-Preset-Gap-Audit.md` with deliveryAuthority=MergeAndSync. Start only after binding predecessors Position 5 and Position 13 are complete. Preserve the read-only audit scope for policy, preset, product, and ABSDD source artifacts; produce only feature artifacts, deterministic validators, audit evidence, required ordering/archive/statistics updates, and delivery evidence. Converge all required and optional Spec Kit quality steps, commit, push, create and merge a non-empty PR, return to clean synchronized main, and do not start Position 15 automatically.
```

<!-- intake-authoring:end -->
