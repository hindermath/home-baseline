# Implementierungsplan: RL-SE-Checklisten-Selbstprüfung

**Branch**: `025-rl-se-self-assessment` | **Datum**: 2026-08-05 | **Spezifikation**: [spec.md](./spec.md)
**Eingabe**: Freigegebene Feature-Spezifikation unter `specs/025-rl-se-self-assessment/spec.md`

## Zusammenfassung

Das Feature erstellt eine commit-gebundene, barrierearme Selbstprüfung des Level-0-Repositories gegen die Richtlinie Sichere Entwicklung, alle zwölf kanonischen Checklisten, die 15 mitgeltenden Dokumente und das installierte Elf-Preset-Profil. Die Ergebnismatrix enthält jede der 157 stabilen `CL-NN-NN`-IDs genau einmal. Nur tatsächlich noch nicht durch eine stabile Checklisten-ID abgedeckte Prüfpunkte erhalten einen Eintrag in einem expliziten Zusatz-ID-Register. Jeder Prüfpunkt erhält einen eindeutigen Workflowstatus, eine begründete Anwendbarkeit, einen Implementierungsstatus, überprüfbare Evidenz, Owner, Risiko, Restrisiko und einen Re-Evaluation-Trigger.

Die Umsetzung ändert ausschließlich Dokumentation und Evidence. Sie führt keine automatische Härtung, keine Laufzeitänderung und keine Remote-Aktion aus. Fehlende, widersprüchliche oder nicht hinreichend aktuelle Evidenz wird als `Open` oder `FollowUp` sichtbar gemacht. Die Matrix und ihre Zusammenfassung entstehen vollständig Deutsch zuerst und Englisch danach; `docs/security/README.md` erhält einen Leserpfad. Nach semantischer Prüfung und deterministischen Konsistenznachweisen wird der generierte Statistikblock aus seiner kanonischen Konfiguration aktualisiert.

## Technischer Kontext

**Sprache/Version**: Markdown und JSON als Evidence-Formate; keine neue Implementierungssprache. Bestehende Validatoren bleiben Bash 3.2+- und PowerShell-7-kompatibel.

**Primäre Abhängigkeiten**: Git, Bash, PowerShell 7, `jq`, `rg`, vorhandene Repository-Skripte und Spec Kit CLI; keine neuen Abhängigkeiten.

**Speicherung**: Git-getrackte, repository-relative Markdown- und JSON-Artefakte.

**Tests**: Baseline-Builder in Bash und PowerShell, Feature-024-Mapping-Validator und -Tests, deterministische Matrix-Vertragsprüfung, Statistik-Renderer/-Verifier, Geheimnisscan, `git diff --check` und manuelle bilinguale/A11Y-Prüfung.

**Zielplattform**: Plattformneutrale Level-0-Dokumentation; Validierung auf macOS zuerst mit Bash und anschließend als PowerShell-7-Gegenprobe.

**Projekttyp**: Dokumentations- und Evidence-Feature in einem skriptbasierten Infrastruktur-Repository.

**Leistungsziele**: Nicht laufzeitbezogen; die Prüfung muss bei gleichem Commit und gleichen Quellen deterministisch dieselben Mengen und Entscheidungen ergeben.

**Randbedingungen**: `sourceOnly`; kein Home-Sync; keine Code-, Skript-, Abhängigkeits-, Runtime-, Preset-, Agent-Guidance- oder Provideränderung; keine Remote-Aktion; textorientiert; WCAG 2.2 AA; CEFR B2; Deutsch vollständig vor Englisch.
**Umfang**: 12 Checklisten, exakt 157 stabile IDs, 15 mitgeltende Dokumente, 11 installierte Presets sowie ein begrenztes, explizit deklariertes Zusatz-ID-Register.

Es bestehen keine `NEEDS CLARIFICATION`-Marker.

## Verfassungsprüfung vor dem Design

*Gate: vor Phase 0 bestanden. Bindender Stand: Constitution 1.20.1 und Baseline-Manifest 3.2.0.*

| Gate | Bewertung | Plan und Evidenz | Re-Evaluation |
|---|---|---|---|
| Level-2-Umgebung | N/A | Das Ziel ist das Level-0-Repository; keine Level-2-Registry-Zeile gilt. | Bei Änderung des Ziel-Repositories oder einer Level-2-Runtime. |
| Memory-Safe Language | N/A für das Delta | Es entsteht keine Programmlogik. Vorhandene Bash-, PowerShell-, Python- und C#-Flächen bleiben Gegenstand der Bestandsprüfung. | Bei Code-, Skript- oder Runtime-Änderung. |
| Sichere Code-Erzeugung | N/A für das Delta | Kein Code wird erzeugt. Findings zu Eingaben, Pfaden, Prozessen, Geheimnissen oder Abhängigkeiten werden in der Matrix erfasst. | Sobald ein Finding eine Codeänderung verlangt. |
| Sichere Architektur | Applicable als Prüfbereich, N/A für neue Architektur | Vorhandene Trust Boundaries, TUI- und Source/Home-Runtime-Nachweise werden bewertet; das Feature fügt keine Grenze, Schnittstelle oder Datenfluss hinzu. | Bei neuer Grenze, Authentisierung, Autorisierung, Cloud-, Runtime- oder Deploymentfläche. |
| Security-Dokumentation | Applicable | Matrix und Zusammenfassung sind die gleichwertige Feature-Evidenz. Bestehende Dateien unter `docs/security/` werden referenziert, aber nicht stillschweigend gehärtet. | Bei Security-Finding oder geänderter Baseline. |
| NIST SSDF und CWE Top 25 | Applicable | Beide werden gegen die vorhandenen Skript-, Prozess- und Governanceflächen bewertet. TUI-begrenzte Evidenz ist kein pauschaler Nachweis. | Bei Code-, SDLC- oder Baseline-Änderung. |
| OWASP ASVS | N/A für das Delta | Keine Web-, API-, HTTP-, AuthN- oder AuthZ-Fläche wird ergänzt. | Bei entsprechender neuer Fläche. |
| SBOM, VEX, SLSA, OpenSSF Scorecard | Applicable als Bestandsprüfung | Fehlende aktuelle oder maschinenlesbare Evidenz wird `Open`; externe Nichterreichbarkeit bricht die Gesamtprüfung nicht ab. | Bei Abhängigkeits-, Build-, Release- oder Distributionsänderung. |
| AI-SBOM | N/A | KI ist Entwicklungswerkzeug, kein ausgelieferter oder betriebener Systembestandteil. | Bei Modell-, Datensatz-, Inferenz- oder AI-Runtime-Anteil. |
| STRIDE, CIA, CAPEC | N/A für das Delta | Bestehende Threat-Model-Evidenz wird bewertet; keine neue Bedrohungsmodellfläche entsteht. | Bei neuer Grenze, privilegiertem Pfad oder externem Datenfluss. |
| Zero Trust | Open für die Repository-Prüfung; N/A für das Delta | Der Widerspruch zwischen „Partially applicable“ und Stub-Kennzeichnung wird sichtbar bewertet, nicht vorausentschieden. | Bei Identitätsföderation, Remote Access, Cloud oder Managed Service. |
| BSI C3A und C5 | N/A | Generisches Git-Hosting ohne betriebene Cloud-Runtime begründet N/A. | Bei Cloudauswahl, Managed Service oder Assurance-Anforderung. |
| OWASP SAMM | Applicable | Der vorhandene TUI-Snapshot beweist keine organisationsweite Reife und wird neu eingeordnet. | Bei Audit, Incident, Prozess- oder Baseline-Änderung. |
| NIS2, CRA, EU AI Act, DORA | Applicable als Screening | Keine Rechts- oder Zertifizierungsbehauptung. Fehlender Kontext führt zu `Open` oder `FollowUp`. | Bei Markt-, Kunden-, Lieferketten-, AI- oder Finanzsektorbezug. |
| Spec-Kit-Presets | Applicable | Exakt elf: Security 0.6.1, Architecture 0.5.1, iSAQB 0.2.1, A11Y 0.4.2, Cross-Platform 0.2.1, Agent-Parity 0.4.1, Intake Authoring 0.3.0, Intake Review 0.2.0, Intake Sequencing 0.2.2, Autonomous 0.3.3, Parallel Autonomous 0.2.4. | Bei Registry- oder Installationsänderung. |
| Security-first | bestanden | Keine Credentials, privaten Agentenzustände, Logs, History- oder SQLite-Dateien werden getrackt. Evidence-Pfade sind repository-relativ. | Vor Commit und bei jeder neuen Evidence-Quelle. |
| Inklusion/A11Y | Applicable | Matrix, Summary und Navigation bleiben text-first, linear lesbar, ohne farb- oder layoutabhängige Bedeutung, WCAG 2.2 AA. | Bei jeder Änderung nutzerseitiger Darstellung. |
| Bilinguale Lieferung | Applicable | Jedes neue oder geänderte nutzerseitige Artefakt enthält zuerst den vollständigen deutschen, danach den vollständigen englischen Inhalt. | Bei semantischer Endprüfung. |
| Lernenden-Baseline | Applicable | CEFR B2; Fachbegriffe werden bei erster Verwendung erklärt; keine Spec-Kit-Vorkenntnisse werden vorausgesetzt. Primär Maintainer/Ausbildungsverantwortliche, sekundär Auszubildende. | Bei Inhalts- und A11Y-Review. |
| Statistik | Applicable bei Feature-Abschluss | Kanonische Quelle ist `docs/project-statistics.config.json`; `docs/project-statistics.md` wird nur über den Renderer fortgeschrieben. Wegen Clean-Tree-Barriere und `LocalImplementation` wird verbleibender Git-`DRIFT` bis zu einer autorisierten Commit-Bindung als begrenzter Follow-up dokumentiert. Referenzen: 80 und 100 Zeilen/Arbeitstag, 7,8 Stunden und 21,5 Arbeitstage/Monat. | Nach Abschluss der Feature-Artefakte und erneut nach einem später autorisierten Commit. |
| Agent-Guidance-Parität | N/A | Keine der gemeinsamen Guidance-Flächen wird geändert. | Falls ein Finding eine Guidance-Änderung verlangt. |
| Dokumentationsauswirkung | UpdateRequired | Owner: Level-0-Maintainer. Kanonische Quellen: Baseline, Checklisten, mitgeltende Dokumente, Preset-Registry und Feature-Spezifikation. Betroffen: Matrix, Summary, Security-Index, Documentation-Impact-Evidence sowie Abschluss-/Statistik-Evidence. Dokumentklasse: Security-Governance/Evidence. Distribution: `sourceOnly`; Home-Sync: nein. | Baseline-, Preset-, Zielgruppen-, A11Y-, Architektur-, Runtime-, Distributions- oder Delivery-Authority-Änderung. |

**Gate-Ergebnis**: bestanden. Es gibt keine unbegründete Verfassungsabweichung und keine offene Klärung.

## Projektstruktur

### Planungsartefakte dieses Features

```text
specs/025-rl-se-self-assessment/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── contracts/
    └── assessment-artifact-contract.md
```

`tasks.md` gehört zu Phase 2 und wird durch diesen `/speckit-plan`-Lauf nicht erzeugt.

### Spätere Feature-Artefakte im Repository

```text
docs/
├── secure-development/
│   ├── baseline-manifest.json
│   ├── Richtlinie_Sichere-Entwicklung.md
│   ├── Checklistensammelband_Sichere-Entwicklung.md
│   ├── checklisten/
│   └── mitgeltende-dokumente/
├── security/
│   ├── README.md
│   └── secure-development/
│       └── 2026-08-05-home-baseline-rl-se-self-assessment/
│           ├── assessment-matrix.md
│           └── assessment-summary.md
├── project-statistics.config.json
└── project-statistics.md

specs/025-rl-se-self-assessment/
└── documentation-impact-evidence.json
```

**Strukturentscheidung**: Die kanonische Secure-Development-Baseline bleibt unverändert unter `docs/secure-development/`. Die projektspezifische, zeitgebundene Evidence liegt unter `docs/security/secure-development/`. Der Security-Index stellt die Navigation her. Es entstehen weder `src/` noch ein neuer Testbaum; vorhandene Validatoren werden wiederverwendet, und matrixspezifische Vertragsprüfungen werden in der späteren Implementierungsplanung festgelegt.

## Umsetzungsdesign

### 1. Evidenzbasis erneut binden

- Aktuellen Commit oder dokumentierten Arbeitsbaumzustand festhalten.
- Baseline-Manifest, zwölf kanonische Checklisten, 15 mitgeltende Dokumente und elf installierte Presets erneut validieren.
- Die 157 Quell-IDs direkt aus den kanonischen Checklisten extrahieren; Manifestzählung und Sammelband allein reichen nicht.
- Vorhandene Feature-024-Evidenz nur innerhalb ihrer bewiesenen Mapping-Grenze verwenden.

### 2. Deterministisches Quellen- und Zusatzregister aufbauen

- Für jede stabile `CL-NN-NN`-ID genau eine Matrixzeile anlegen.
- Zusätzliche Prüfpunkte nur dann anlegen, wenn keine stabile Checklisten-ID fachlich zuständig ist.
- Zusatz-IDs als semantische, sortierunabhängige Slugs im Namensraum `HB-RLSE-*` führen und in einem Register mit Quelle und Begründung deklarieren.
- Mitgeltende Dokumente und Presets als Querverweise zu bestehenden Zeilen abbilden; Abdeckung ist nicht automatisch Erfüllung.

### 3. Prüfentscheidungen treffen

- Die Statusvorrangfolge `N/A` → `AlreadySatisfied` → `FollowUp` → `Open` → `Applicable` je Zeile anwenden.
- `AlreadySatisfied` nur mit aktueller, aussagegleicher, commit- oder Arbeitsbaum-gebundener Evidence vergeben.
- Wo die Baseline getrennte Achsen verlangt, `Applicability` und `ImplementationStatus` zusätzlich führen.
- Priorität, Risiko, Restrisiko, Owner, Reviewer, nächste Aktion und Re-Evaluation-Trigger begründen.
- Nicht verfügbare externe Evidenz als `Open` dokumentieren und die übrige Prüfung fortsetzen.

### 4. Matrix und Zusammenfassung erstellen

- Matrix vollständig Deutsch zuerst, danach vollständig Englisch ausgeben; Entscheidungen und Identitäten müssen semantisch übereinstimmen.
- Summary mit Umfang, Statusverteilung, höchsten Risiken, blockierenden Evidenzlücken, Follow-ups, Proof-Grenzen und nächstem sicheren Schritt erstellen.
- Fehlende kanonische Security-Dokumente, SBOM/VEX-Evidenz, regulatorischen Kontext und Zero-Trust-Widerspruch sichtbar machen, aber nicht in diesem Feature still beheben.

### 5. Navigation und Dokumentation integrieren

- `docs/security/README.md` um den datierten Reader Path ergänzen und die Level-0-Einordnung prüfen.
- Dokumentationsklasse, Zielgruppen, Sprache, Distribution `sourceOnly`, Owner, Plattformnachweis und Re-Evaluation festhalten.
- Keinen Home-Sync ausführen.

### 6. Validieren und kausal abschließen

- Mengenidentität 157/157, Zusatz-ID-Register, Statusdomänen, Pflichtfelder, Priorität, Pfade, 15/15-Dokument- und 11/11-Preset-Abdeckung sowie DE/EN-Parität deterministisch prüfen.
- Baseline-Builder, Mapping-Tests/-Validator, Statistik-Renderer/-Verifier, Geheimnisscan und `git diff --check` ausführen.
- Nach autorisierter Commit-Bindung und sauberem Arbeitsbaum die Statistik-Konfiguration ergänzen, das generierte Ledger rendern und erneut prüfen; fehlen diese Voraussetzungen unter `LocalImplementation`, einen vollständigen Statistik-Follow-up statt einer erzwungenen Änderung dokumentieren.
- Feature-Abschluss nur mit frischer, kausal gebundener Evidence erklären. Commit, Push, PR, Merge oder nachfolgender Spec-Kit-Lauf benötigen jeweils eigene Autorität.

## Verfassungsprüfung nach dem Design

*Gate: nach Phase 1 erneut geprüft.*

- Das Design fügt keine Laufzeit, Abhängigkeit, Architekturgrenze, Remote-Aktion oder Agent-Guidance-Änderung hinzu.
- Der Evidence-Vertrag erzwingt Security-first, repository-relative Pfade, aktuelle positive Nachweise und sichtbare Unsicherheit.
- A11Y, CEFR B2, Zielgruppenvertrag und vollständige DE/EN-Parität sind in Datenmodell, Artefaktvertrag und Quickstart prüfbar verankert.
- `UpdateRequired` ist mit kanonischen Quellen, Owner, Leserpfad, Distribution und Re-Evaluation vollständig beschrieben; die Statistik bleibt darin eine deterministisch erzeugte Abschlussaktualisierung beziehungsweise ein transparenter Follow-up.
- Keine anwendbare Governance-Anforderung ist unbehandelt; N/A-Entscheidungen haben konkrete Trigger.

**Gate-Ergebnis**: bestanden. Keine Verfassungsverstöße; Complexity Tracking ist nicht erforderlich.

---

# Implementation Plan: RL-SE Checklist Self-Assessment

**Branch**: `025-rl-se-self-assessment` | **Date**: 2026-08-05 | **Specification**: [spec.md](./spec.md)
**Input**: Approved feature specification at `specs/025-rl-se-self-assessment/spec.md`

## Summary

The feature creates a commit-bound, accessible self-assessment of the Level 0 repository against the Secure Development Policy, all twelve canonical checklists, the 15 related documents, and the installed eleven-preset profile. The assessment matrix contains each of the 157 stable `CL-NN-NN` identifiers exactly once. Only checkpoints that are genuinely not covered by a stable checklist identifier receive an entry in an explicit additional-ID register. Every checkpoint receives one workflow status, justified applicability, implementation status, verifiable evidence, owner, risk, residual risk, and a re-evaluation trigger.

The implementation changes documentation and evidence only. It performs no automatic hardening, runtime change, or remote action. Missing, contradictory, or insufficiently current evidence is exposed as `Open` or `FollowUp`. The matrix and summary are delivered in full German followed by full English, and `docs/security/README.md` receives a reader path. After semantic review and deterministic consistency proofs, the generated statistics block is updated through its canonical configuration.

## Technical Context

**Language/Version**: Markdown and JSON evidence formats; no new implementation language. Existing validators remain Bash 3.2+ and PowerShell 7 compatible.

**Primary Dependencies**: Git, Bash, PowerShell 7, `jq`, `rg`, existing repository scripts, and Spec Kit CLI; no new dependencies.

**Storage**: Git-tracked, repository-relative Markdown and JSON artifacts.

**Testing**: Baseline builders in Bash and PowerShell, Feature 024 mapping validator and tests, deterministic matrix-contract validation, statistics renderer/verifier, secret scan, `git diff --check`, and manual bilingual/accessibility review.

**Target Platform**: Platform-neutral Level 0 documentation; validation on macOS with Bash first, followed by a PowerShell 7 cross-check.

**Project Type**: Documentation and evidence feature in a script-based infrastructure repository.

**Performance Goals**: Not runtime-related; identical commits and sources must yield identical sets and decisions.

**Constraints**: `sourceOnly`; no Home sync; no code, script, dependency, runtime, preset, agent-guidance, or provider change; no remote action; text-oriented; WCAG 2.2 AA; CEFR B2; complete German before complete English.
**Scale/Scope**: 12 checklists, exactly 157 stable identifiers, 15 related documents, 11 installed presets, plus a bounded and explicitly declared additional-ID register.

There are no `NEEDS CLARIFICATION` markers.

## Pre-Design Constitution Check

*Gate passed before Phase 0. Binding versions: Constitution 1.20.1 and baseline manifest 3.2.0.*

| Gate | Assessment | Plan and evidence | Re-evaluation |
|---|---|---|---|
| Level 2 environment | N/A | The target is the Level 0 repository; no Level 2 registry row applies. | Target-repository or Level 2 runtime change. |
| Memory-safe language | N/A for the delta | No program logic is introduced. Existing Bash, PowerShell, Python, and C# surfaces remain assessment inputs. | Code, script, or runtime change. |
| Secure code generation | N/A for the delta | No code is generated. Findings about inputs, paths, processes, secrets, or dependencies are recorded in the matrix. | A finding requires a code change. |
| Secure architecture | Applicable as an assessment area; N/A for new architecture | Existing trust-boundary, TUI, and source/Home-runtime evidence is assessed; no boundary, interface, or data flow is added. | New boundary, authentication, authorization, cloud, runtime, or deployment surface. |
| Security documentation | Applicable | Matrix and summary are the equivalent feature evidence. Existing `docs/security/` files are referenced but not silently hardened. | Security finding or baseline change. |
| NIST SSDF and CWE Top 25 | Applicable | Both are assessed against existing script, process, and governance surfaces. TUI-scoped evidence is not a blanket proof. | Code, SDLC, or baseline change. |
| OWASP ASVS | N/A for the delta | No web, API, HTTP, authentication, or authorization surface is added. | A matching new surface. |
| SBOM, VEX, SLSA, OpenSSF Scorecard | Applicable as current-state checks | Missing current or machine-readable evidence becomes `Open`; unavailable external evidence does not abort the assessment. | Dependency, build, release, or distribution change. |
| AI-SBOM | N/A | AI is a development tool, not part of the released or operated system. | Model, dataset, inference, or AI-runtime component. |
| STRIDE, CIA, CAPEC | N/A for the delta | Existing threat-model evidence is assessed; no new threat-model surface arises. | New boundary, privileged path, or external data flow. |
| Zero Trust | Open for the repository assessment; N/A for the delta | The conflict between “Partially applicable” and the stub classification is assessed explicitly. | Identity federation, remote access, cloud, or managed service. |
| BSI C3A and C5 | N/A | Generic Git hosting without an operated cloud runtime justifies N/A. | Cloud selection, managed service, or assurance requirement. |
| OWASP SAMM | Applicable | The existing TUI snapshot does not prove organization-wide maturity. | Audit, incident, process, or baseline change. |
| NIS2, CRA, EU AI Act, DORA | Applicable as screening | No legal or certification claim. Missing context results in `Open` or `FollowUp`. | Market, customer, supply-chain, AI, or financial-sector relevance. |
| Spec Kit presets | Applicable | Exactly eleven: Security 0.6.1, Architecture 0.5.1, iSAQB 0.2.1, A11Y 0.4.2, Cross-Platform 0.2.1, Agent Parity 0.4.1, Intake Authoring 0.3.0, Intake Review 0.2.0, Intake Sequencing 0.2.2, Autonomous 0.3.3, Parallel Autonomous 0.2.4. | Registry or installation change. |
| Security-first | Passed | No credentials, private agent state, logs, history, or SQLite files are tracked. Evidence paths are repository-relative. | Before commit and for every new evidence source. |
| Inclusion/accessibility | Applicable | Matrix, summary, and navigation remain text-first and linearly readable without color- or layout-only meaning, following WCAG 2.2 AA. | Every user-facing presentation change. |
| Bilingual delivery | Applicable | Each new or changed user-facing artifact contains the complete German content before the complete English content. | Semantic final review. |
| Learner baseline | Applicable | CEFR B2; terms are explained on first use; no Spec Kit experience is assumed. Primary audience: maintainers/training leads; secondary audience: apprentices. | Content and accessibility review. |
| Statistics | Applicable at feature completion | Canonical source: `docs/project-statistics.config.json`; `docs/project-statistics.md` is changed only through the renderer. Because of the clean-tree barrier and `LocalImplementation`, remaining Git-derived `DRIFT` is recorded as a bounded follow-up until an authorized commit binding exists. References: 80 and 100 lines/workday, 7.8 hours, and 21.5 workdays/month. | After feature artifacts are complete and again after a later authorized commit. |
| Agent-guidance parity | N/A | No shared guidance surface changes. | A finding requires a guidance change. |
| Documentation Impact | UpdateRequired | Owner: Level 0 maintainer. Canonical sources: baseline, checklists, related documents, preset registry, and feature specification. Affected: matrix, summary, security index, Documentation Impact evidence, and completion/statistics evidence. Class: security governance/evidence. Distribution: `sourceOnly`; Home sync: no. | Baseline, preset, audience, accessibility, architecture, runtime, distribution, or delivery-authority change. |

**Gate result**: passed. There is no unjustified constitutional deviation and no unresolved clarification.

## Project Structure

### Planning Artifacts for This Feature

```text
specs/025-rl-se-self-assessment/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
└── contracts/
    └── assessment-artifact-contract.md
```

`tasks.md` belongs to Phase 2 and is not created by this `/speckit-plan` run.

### Later Feature Artifacts in the Repository

```text
docs/
├── secure-development/
│   ├── baseline-manifest.json
│   ├── Richtlinie_Sichere-Entwicklung.md
│   ├── Checklistensammelband_Sichere-Entwicklung.md
│   ├── checklisten/
│   └── mitgeltende-dokumente/
├── security/
│   ├── README.md
│   └── secure-development/
│       └── 2026-08-05-home-baseline-rl-se-self-assessment/
│           ├── assessment-matrix.md
│           └── assessment-summary.md
├── project-statistics.config.json
└── project-statistics.md

specs/025-rl-se-self-assessment/
└── documentation-impact-evidence.json
```

**Structure Decision**: The canonical secure-development baseline remains unchanged under `docs/secure-development/`. Project-specific, time-bound evidence resides under `docs/security/secure-development/`. The security index supplies navigation. No `src/` directory or new test tree is introduced; existing validators are reused, and matrix-specific contract checks are defined during later implementation planning.

## Implementation Design

### 1. Re-bind the evidence baseline

- Record the current commit or documented working-tree state.
- Revalidate the baseline manifest, twelve canonical checklists, 15 related documents, and eleven installed presets.
- Extract the 157 source identifiers directly from the canonical checklist files; the manifest count and generated compendium are insufficient by themselves.
- Use existing Feature 024 evidence only within its proven mapping boundary.

### 2. Build deterministic source and additional-ID registers

- Create exactly one matrix row for each stable `CL-NN-NN` identifier.
- Create additional checkpoints only when no stable checklist identifier is the responsible owner.
- Use semantic, order-independent slugs in the `HB-RLSE-*` namespace and declare each in a register with source and rationale.
- Map related documents and presets as cross-references to existing rows; coverage does not equal fulfillment.

### 3. Make assessment decisions

- Apply the status precedence `N/A` → `AlreadySatisfied` → `FollowUp` → `Open` → `Applicable` per row.
- Assign `AlreadySatisfied` only with current, semantically matching, commit- or working-tree-bound evidence.
- Where the baseline requires separate axes, also record `Applicability` and `ImplementationStatus`.
- Justify priority, risk, residual risk, owner, reviewer, next action, and re-evaluation trigger.
- Record unavailable external evidence as `Open` and continue the remaining assessment.

### 4. Produce matrix and summary

- Deliver the matrix in complete German followed by complete English; identities and decisions must remain semantically equivalent.
- Produce a summary covering scope, status distribution, highest risks, blocking evidence gaps, follow-ups, proof boundaries, and next safe action.
- Expose missing canonical security documents, SBOM/VEX evidence, regulatory context, and the Zero Trust contradiction without silently fixing them in this feature.

### 5. Integrate navigation and documentation

- Add the dated reader path to `docs/security/README.md` and verify the Level 0 classification.
- Record document class, audiences, language, `sourceOnly` distribution, owner, platform evidence, and re-evaluation.
- Do not run Home sync.

### 6. Validate and close causally

- Deterministically verify 157/157 set identity, the additional-ID register, status domains, required fields, priority, paths, 15/15 document coverage, 11/11 preset coverage, and German/English parity.
- Run baseline builders, mapping tests/validator, statistics renderer/verifier, secret scan, and `git diff --check`.
- After an authorized commit binding and a clean worktree, extend the statistics configuration, render the generated ledger, and verify it again; if those prerequisites are absent under `LocalImplementation`, record a complete statistics follow-up rather than forcing the change.
- Declare feature completion only with fresh, causally bound evidence. Commit, push, pull request, merge, or a subsequent Spec Kit run each require separate authority.

## Post-Design Constitution Check

*Gate re-evaluated after Phase 1.*

- The design adds no runtime, dependency, architecture boundary, remote action, or agent-guidance change.
- The evidence contract enforces security-first behavior, repository-relative paths, current positive proof, and visible uncertainty.
- Accessibility, CEFR B2, audience contract, and complete German/English parity are verifiable in the data model, artifact contract, and quickstart.
- `UpdateRequired` is fully described with canonical sources, owner, reader path, distribution, and re-evaluation; statistics remain a deterministically generated completion update or transparent follow-up within that decision.
- No applicable governance requirement remains untreated; every N/A decision has a concrete trigger.

**Gate result**: passed. There are no constitutional violations; Complexity Tracking is not required.
