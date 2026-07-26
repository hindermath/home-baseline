<!-- intake-authoring:begin -->
# Lastenheft: Level-0-Dokumentations-Konsistenz-Remediation und Governance

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-25
**Reihenfolge:** verbindlicher Vorlauf D2
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Fachinformatiker*innen, IT-Kaufleute, Lehrende, Maintainer,
Dokumentationsverantwortliche und Reviewer ab dem ersten Ausbildungsjahr

## 1. Zweck / Purpose

Dieser Intake behebt ausschließlich bestätigte `DOC###`-Findings aus Position
18 und führt einen dauerhaften **Documentation-Impact-Vertrag** ein. Dieser
Vertrag verlangt bei jeder fachlichen oder technischen Änderung eine
nachvollziehbare Entscheidung, welche Dokumentation betroffen ist.

Die Erinnerungsregel wird nicht nur in KI-Agenten-Dateien abgelegt.
`constitution.md` und `.specify/memory/constitution.md` bilden die normative
Quelle. Spec-/Plan-/Tasks-/Checklist- und PR-Flächen bringen die Regel in den
Arbeitsablauf. Alle gepflegten Agentenflächen erklären dieselbe Ausführung.
Prüfbare CI- oder Evidence-Gates sichern die Anwendung.

*This intake remediates only confirmed Position 18 findings and establishes a
durable documentation-impact contract across normative policy, workflow
templates, agent guidance, and verifiable evidence.*

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake ist Vorlauf D2 und benötigt den abgeschlossenen, reviewten
Level-0-Audit aus D1. Er liefert die verbindliche Baseline und das
wiederverwendbare Prüfschema für die Level-2-Flotte in Vorlauf D3.

## 3. Documentation-Impact-Modell

Jede Änderung erhält genau eine Entscheidung:

- `UpdateRequired`: betroffene Dokumente werden im selben PR aktualisiert;
- `NoUpdateRequired`: keine Dokumentationsänderung, mit kurzer Begründung;
- `GeneratedUpdate`: Quellen werden geändert und abgeleitete Dokumente
  deterministisch neu erzeugt;
- `FollowUp`: separate Dokumentationsarbeit mit Owner, Risiko, Frist und
  Wiedervorlage.

Ein `FollowUp` ist nur zulässig, wenn eine sofortige Aktualisierung den
genehmigten Scope überschreiten würde. Sicherheits-, Bedienungs- oder
Breaking-Change-Dokumentation darf nicht ohne ausdrückliche Risikofreigabe
verschoben werden.

## 4. Normative und operative Ablage / Governance Surfaces

- `constitution.md` und `.specify/memory/constitution.md`: verbindliche Regel;
- `.specify/templates/spec-template.md`: betroffene Zielgruppen,
  Dokumentationsflächen und Abnahmekriterien;
- `.specify/templates/plan-template.md`: Source-of-Truth-, Ownership-,
  Generated-Doc- und Validierungsplan;
- `.specify/templates/tasks-template.md`: konkrete Update-, Build-, Link-,
  A11Y- und Paritätsaufgaben;
- Checklists und PR-Template: vollständige Documentation-Impact-Evidence;
- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md` und
  `.github/agents/copilot-instructions.md`: synchronisierte Agentenhinweise;
- eine zentrale, bilinguale Documentation-Governance-Referenz mit
  Ownership- und Trigger-Matrix;
- CI oder deterministische Validatoren, soweit Position 18 einen belastbaren
  automatisierbaren Vertrag nachweist.

## 5. Anforderungen / Requirements

- **DRG-001:** Alle bestätigten Position-18-Findings werden als
  `Resolved`, `AcceptedRisk`, `FollowUp` oder `N/A` dispositioniert.
- **DRG-002:** Geänderte Dokumente stimmen nachweislich mit dem gemergten
  Repository-Stand, realen Commands, Pfaden, Versionen und Plattformgrenzen
  überein.
- **DRG-003:** Eine normative Documentation-Impact-Regel wird in beiden
  Constitution-Dateien synchron verankert.
- **DRG-004:** Spec-, Plan-, Tasks-, Checklist- und PR-Flächen erzwingen eine
  explizite der vier Impact-Entscheidungen.
- **DRG-005:** Alle fünf gepflegten Agentenflächen werden gemeinsam
  aktualisiert; intentionale Abweichungen werden dokumentiert.
- **DRG-006:** Eine Source-of-Truth- und Ownership-Matrix nennt pro
  Dokumentfamilie Owner, Aktualisierungsauslöser, Quelle, Ableitungen,
  Validator und Wiedervorlage.
- **DRG-007:** Generierte Dokumente werden nur über ihre kanonischen Quellen
  und Build-Befehle geändert.
- **DRG-008:** Historische Evidence bleibt unverändert oder wird klar
  archiviert; aktuelle Anleitungen verweisen nicht irreführend darauf.
- **DRG-009:** Automatisierte Gates prüfen nur deterministische Aussagen wie
  Link-, Pfad-, Versions-, Hash-, Marker-, Generierungs- oder Evidence-Verträge.
  Semantische Wahrheit wird nicht durch einfache Textsuche behauptet.
- **DRG-010:** Jede Korrektur erhält passende funktionale, Dokumentations-,
  Plattform-, A11Y- und Lernendenvalidierung.
- **DRG-011:** Deutsch-zuerst/Englisch-danach, CEFR B2,
  Erstgebrauchserklärungen, Spec-Kit-Neutralität und WCAG 2.2 AA gelten für
  alle nutzerseitigen Änderungen.
- **DRG-012:** Der Lauf bewertet anhand reproduzierbarer Findings, ob die Regel
  in bestehende Presets gehört oder als separates portables Preset-Follow-up
  übergeben werden soll; ohne Beleg entsteht kein Preset.
- **DRG-013:** Änderungen an Runtime, API oder Verhalten sind nur zulässig,
  wenn ein bestätigtes Dokumentations-Finding eine tatsächlich falsche
  Implementierung beweist und dafür ein separates Produkt-Follow-up
  ausdrücklich freigegeben wurde; dieser Lauf selbst bleibt dokumentations-
  und governancebezogen.
- **DRG-014:** Vorlauf D3 übernimmt nur die gemergte und validierte
  Level-0-Baseline.

## 6. Nicht-Ziele / Non-Goals

- Keine ungeprüfte Massenumschreibung.
- Keine automatische Änderung fachlicher Aussagen ohne Audit-Evidence.
- Kein globales „jede Datei braucht mehr Text“.
- Keine pauschale Löschung historischer Specs oder Evidence.
- Keine direkte Level-2-Änderung.
- Kein neues Preset ohne reproduzierbaren portablen Bedarf.
- Kein automatischer Start von Vorlauf D3.

## 7. Akzeptanzkriterien / Acceptance Criteria

- **AC-DRG-001:** Alle Critical-/High-Findings sind gelöst oder mit
  ausdrücklicher Risikoevidence blockiert; keine wird still ausgelassen.
- **AC-DRG-002:** Alle geänderten Aussagen sind an aktuelle Repository-Evidence
  gebunden.
- **AC-DRG-003:** Die vier Impact-Entscheidungen erscheinen konsistent in
  Constitution, Templates, Checklists, PR-Evidence und Agentenflächen.
- **AC-DRG-004:** Source-of-Truth-, Ownership- und Generated-Doc-Verträge sind
  für Lernende textorientiert verständlich.
- **AC-DRG-005:** Bash-/PowerShell- beziehungsweise native
  Plattformvalidatoren liefern gleichwertige Ergebnisse.
- **AC-DRG-006:** Links, generierte Dokumente, Preset-/Command-Parität,
  Secret-Scan, Homogeneity und Projektstatistik sind grün.
- **AC-DRG-007:** Ein synthetisches Fixture beweist, dass veraltete Pfade,
  fehlende Impact-Evidence und unzulässige `FollowUp`-Einträge abgelehnt
  werden, soweit deterministisch prüfbar.
- **AC-DRG-008:** Die Level-0-Baseline ist gemergt, sauber und für Vorlauf D3
  verwendbar; D3 wurde nicht automatisch gestartet.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Governance.md` as mandatory documentation preflight D2. Verify its strict dependency on D1 findings, the four exact Documentation Impact decisions, normative Constitution placement, template/checklist/PR integration, five-surface agent parity, deterministic versus semantic validation boundaries, learner accessibility, and no-product-change scope. Do not modify the intake or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Governance.md` as the binding intake for mandatory documentation preflight D2 and the accepted DOC### findings from D1 as mandatory evidence. Create the feature specification for Level-0 documentation remediation and durable Documentation Impact governance. Preserve DRG-001 through DRG-014, AC-DRG-001 through AC-DRG-008, the exact four impact decisions, Constitution/template/checklist/PR/agent placement, generated-document ownership, deterministic validation boundaries, no speculative preset, no Level-2 writes, and all learner, A11Y, security, and non-goal constraints.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Governance.md` with deliveryAuthority=MergeAndSync after documentation preflight D1 is complete. Remediate only accepted DOC### findings, establish the approved Documentation Impact contract across normative policy, templates, checklists, PR evidence, agent guidance, and deterministic gates, converge all required and optional checks and reviews, merge a non-empty PR, return to clean synchronized main, and do not start preflight D3 automatically.
```

<!-- intake-authoring:end -->
