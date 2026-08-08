# Aufgaben: RL-SE-Checklisten-Selbstprüfung / Tasks: RL-SE Checklist Self-Assessment

**Eingabe / Input**: Verbindliche Artefakte unter `specs/025-rl-se-self-assessment/`  
**Voraussetzungen / Prerequisites**: `spec.md`, `plan.md`, `research.md`, `data-model.md`, `quickstart.md`, `contracts/assessment-artifact-contract.md`, `checklists/requirements.md`, `.specify/memory/constitution.md`  
**Delivery Authority**: `MergeAndSync`

**Autoritätsgrenze / Authority boundary**: T001 bis T057 dokumentieren den abgeschlossenen lokalen Implementierungscheckpoint unter `LocalImplementation`. Die aktuelle Benutzeranweisung autorisiert T058 bis T065 mit `MergeAndSync`. Der Admin-Bypass bleibt auf gruene technische Gates, null umsetzbare Review-Threads und Human Approval als einziges offenes Gate begrenzt. Provider-, Secret-, Produkt- und Remediation-Aenderungen bleiben ausgeschlossen. / T001 through T057 document the completed local implementation checkpoint under `LocalImplementation`. The current user instruction authorizes T058 through T065 with `MergeAndSync`. The admin bypass remains limited to green technical gates, zero actionable review threads, and Human Approval as the sole open gate. Provider, secret, product, and remediation changes remain excluded.

**Validator-first / Validator-first** bedeutet hier: Die deterministischen Mengen-, Status- und Evidence-Prüfungen werden vor der fachlichen Befüllung festgelegt, zunächst gegen den noch unvollständigen Stand mit erwartetem Fehlschlag ausgeführt und nach jeder betroffenen Änderung wiederholt. Es entsteht kein neues Validator-Skript und kein neues Laufzeitverhalten. / Here, validator-first means that deterministic cardinality, status, and evidence checks are defined before professional population, first run against the incomplete state with an expected failure, and repeated after every affected change. No new validator script or runtime behavior is created.

## Format: `[ID] [P?] [Story] Beschreibung / Description`

- `[P]` ist nur für Aufgaben zulässig, die verschiedene Dateien ändern und weder Evidence, Statistik, Series noch dieselbe Validierungsfläche teilen. In diesem One-Writer-Feature erfüllt keine Aufgabe diese Bedingung. / `[P]` is allowed only for tasks that change distinct files and share neither evidence, statistics, series state, nor the same validation surface. No task in this one-writer feature satisfies that condition.
- Story-Aufgaben tragen genau `[US1]` bis `[US4]`; Setup, Fundament und Abschluss tragen kein Story-Label. / Story tasks carry exactly `[US1]` through `[US4]`; setup, foundation, and closeout tasks carry no story label.
- Jede Aufgabe nennt mindestens einen exakten Repository-Pfad. / Every task names at least one exact repository path.

---

## Phase 1: Setup und sichere Ausgangslage / Setup and Safe Starting State

**Zweck / Purpose**: Bindende Eingaben, Repositoryzustand, Authority und ausführbare Prüfoberflächen vor jeder fachlichen Bewertung erneut nachweisen. / Re-prove binding inputs, repository state, authority, and executable validation surfaces before any professional assessment.

- [X] T001 Branch, `HEAD`, Arbeitsbaum und den auf genau dieses Level-0-Repository begrenzten `LocalImplementation`-Scope mit `git branch --show-current`, `git rev-parse HEAD` und `git status --short` prüfen und die spätere Commit- oder dokumentierte Worktree-Bindung für `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` festhalten; keine anderen Repositories und keine Remote-Aktion einbeziehen. / Verify branch, `HEAD`, working tree, and the `LocalImplementation` scope limited to this Level 0 repository, and retain the later commit or documented-worktree binding for the matrix; include no other repository or remote action.
- [X] T002 Feature-024-Vorgänger, Intake-Authoring-Receipt, bindendes `Ready`-Review sowie aktives Series-Manifest und -Receipt mit den Bash- und PowerShell-Validatoren aus `specs/025-rl-se-self-assessment/quickstart.md` prüfen und Befehl, Zeitpunkt, Ergebnis und Proof-Grenze für `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` erfassen. / Validate the Feature 024 predecessor, authoring receipt, binding `Ready` review, and active series manifest/receipt with the Bash and PowerShell validators from the quickstart, recording command, time, outcome, and proof boundary for the matrix.
- [X] T003 Eine zulässige Änderungsfläche aus genau `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md`, `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md`, `docs/security/README.md`, `specs/025-rl-se-self-assessment/documentation-impact-evidence.json` sowie den nur bedingt zulässigen Statistik-/Series-Pfaden definieren und in `assessment-summary.md` gegen Produktcode-, Runtime-, API-, Dependency-, Toolchain-, Skript-, Provider-, Preset- und Shared-Agent-Guidance-Änderungen abgrenzen. / Define the allowed change surface and bound it in the summary against product-code, runtime, API, dependency, toolchain, script, provider, preset, and shared-agent-guidance changes.
- [X] T004 Verfügbarkeit und Version der in `specs/025-rl-se-self-assessment/quickstart.md` geforderten Werkzeuge Git, Bash, PowerShell 7, Python 3, `jq`, `rg`, `specify` und optional `lychee` prüfen; fehlende optionale Werkzeuge später als nicht ausgeführte Prüfung statt als positives Ergebnis in `assessment-summary.md` ausweisen. / Check availability and version of the required tools and optional `lychee`; later report an unavailable optional tool as an unrun check, never as a positive result.

**Checkpoint / Checkpoint**: Scope, Authority und Eingabebindung sind reproduzierbar; fachliche Matrixentscheidungen haben noch nicht begonnen. / Scope, authority, and input binding are reproducible; professional matrix decisions have not started.

---

## Phase 2: Fundament und Validator-first-Vertrag / Foundation and Validator-First Contract

**Zweck / Purpose**: Die Ergebnisformen und deterministischen Beweise anlegen, bevor Statusentscheidungen eingetragen werden. / Establish result structures and deterministic proofs before entering status decisions.

**Kritische Reihenfolge / Critical order**: T005 bis T012 blockieren alle User Stories. / T005 through T012 block all user stories.

- [X] T005 `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` mit den vertraglichen Sprachbereichsmarkern und je Sprachhälfte den Abschnitten Zweck/Scope/Proof-Grenze, Repository-/Baseline-Bindung, Quelleninventar, Zusatz-ID-Register, Statuslegende/Vorrang, Matrix, Dokument-/Preset-Abdeckung, externe Evidenzausfälle sowie Review/Re-Evaluation anlegen. / Create the matrix with contractual language markers and all required sections in each language half.
- [X] T006 `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` mit Baselinebindung, exakten Zeilen-/Statuszählungen, 12/12-, 157/157-, 15/15- und 11/11-Abdeckung, High-Risk-, Open-, FollowUp-, A11Y-, Documentation-Impact-, Statistik-, Series- und Authority-Abschnitten anlegen, ohne noch unbelegte positive Aussagen einzutragen. / Create the summary with every required aggregation and authority section, without entering unsupported positive claims.
- [X] T007 Die deterministischen Abfragen aus Szenario 3 von `specs/025-rl-se-self-assessment/quickstart.md` für Sprachbereich, CL-Mengenidentität, `HB-RLSE-*`-Register, Statusdomänen, Pflichtfelder, Evidence-Frische, Pfadsicherheit sowie DE/EN-Parität in `assessment-matrix.md` dokumentieren und vor der Befüllung mit erwartetem Fehlschlag ausführen. / Document the deterministic Scenario 3 queries in the matrix and run them before population with the expected failure.
- [X] T008 Beide Checklisten-Builder `scripts/build-secure-development-docs.sh` und `scripts/build-secure-development-docs.ps1` im Check-Modus ausführen, die kanonischen IDs direkt aus den zwölf Dateien unter `docs/secure-development/checklisten/` extrahieren und exakt 157 Zeilen sowie 157 eindeutige `CL-NN-NN`-IDs gegen `docs/secure-development/baseline-manifest.json` beweisen. / Run both checklist builders in check mode and prove exactly 157 rows and 157 unique canonical IDs against the baseline manifest.
- [X] T009 `specs/024-mitgeltende-dokumente-verzahnung/tests/test_mapping.py` und `specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py` ausführen und Baseline 3.2.0, Richtlinie 3.2.0, Sammelband 2.2.0, Mapping 1.3.0, zwölf Checklisten, 157 IDs, fünfzehn mitgeltende Dokumente sowie 8+3 Presets als aktuellen, aber noch nicht pauschal erfüllten Prüf-Scope in `assessment-matrix.md` binden. / Run the mapping tests and validator and bind all exact versions and counts as assessment scope, not blanket fulfillment.
- [X] T010 Das öffentliche Acht-Preset-Profil und das verwaltete Elf-Preset-Profil aus `scripts/config/spec-kit-governance-presets.json` unterscheiden, `scripts/install-spec-kit-governance-presets.sh --check-only`, `scripts/install-spec-kit-governance-presets.ps1 -CheckOnly` und `specify preset list` ausführen und die acht Default- plus drei optionalen Intake-Presets mit ID, Version, Priorität und Aktivstatus in `assessment-matrix.md` erfassen. / Distinguish the public eight-preset profile from the managed eleven-preset profile, run both check-only paths plus `specify preset list`, and record IDs, versions, priorities, and enabled states in the matrix.
- [X] T011 Bestehende Evidence unter `docs/security/`, Architektur-/Threat-/arc42-/SAMM-/Zero-Trust-/Supply-Chain-Nachweise, Tests, CI, Reviews und Spec-Kit-Artefakte inventarisieren und in `assessment-matrix.md` jeweils als aktuell, veraltet, Stub, scope-begrenzt, widersprüchlich oder nicht verfügbar mit konkreter Proof-Grenze kennzeichnen; Feature-024 nur für Mapping-Integrität verwenden. / Inventory existing security, architecture, test, CI, review, and Spec Kit evidence and classify its precise proof boundary; use Feature 024 only for mapping integrity.
- [X] T012 Das begrenzte Zusatz-ID-Register in `assessment-matrix.md` erst nach fachlicher Deduplizierung festlegen: ausschließlich semantische IDs nach `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$`, je ID Titel, Primärquelle und DE/EN-Bedarfsbegründung, keine Duplizierung eines vorhandenen `CL-*`-Owners und Gesamtzahl exakt `157 + Registeranzahl`. / Establish the bounded additional-ID register only after professional deduplication, with semantic IDs, complete bilingual rationale, no duplicate CL owner, and exact total cardinality.

**Checkpoint / Checkpoint**: Die Validatoren existieren als dokumentierte, zunächst fehlschlagende Abnahmeoberfläche; Baseline, Quellenmenge, Dokumente und Presetprofile sind gebunden. / Validators exist as a documented, initially failing acceptance surface; baseline, source set, documents, and preset profiles are bound.

---

## Phase 3: User Story 1 – Vollständige Selbstprüfung / Complete the Self-Assessment (Priority: P1) 🎯 MVP

**Ziel / Goal**: Jeden relevanten Prüfpunkt genau einmal, quellengetreu und ohne versteckte Umsetzung bewerten. / Assess every relevant checkpoint exactly once, source-faithfully and without hidden implementation.

**Unabhängiger Test / Independent Test**: `assessment-matrix.md` enthält je Sprachhälfte exakt 157 eindeutige kanonische IDs plus das deklarierte Zusatzregister; 12/12 Checklisten, 15/15 Dokumente und 8+3 Presets sind nachweisbar abgedeckt. / Each matrix half contains exactly 157 unique canonical IDs plus the declared register; 12/12 checklists, 15/15 documents, and 8+3 presets are demonstrably covered.

- [X] T013 [US1] Für jede direkt aus `docs/secure-development/checklisten/` extrahierte `CL-NN-NN`-ID genau eine identitätsstabile Primärentscheidung mit vollständigem Titel und primärer Quelle in der deutschen Matrixhälfte von `assessment-matrix.md` anlegen; unbekannte IDs und quellenbedingte Duplikatzeilen ausschließen. / Create exactly one identity-stable primary decision per canonical ID in the German matrix half; exclude unknown IDs and source-driven duplicates.
- [X] T014 [US1] Richtlinie, Manifest, Sammelband, aktuelle Zuordnungsdatei und alle fünfzehn Manifest-Einträge unter `docs/secure-development/mitgeltende-dokumente/` als Primärquelle oder Querverweis vorhandener Zeilen in `assessment-matrix.md` abbilden; Lern-/Managed-Reference-Dateien getrennt führen und Abdeckung nicht mit Erfüllung gleichsetzen. / Map the guideline, manifest, compendium, mapping, and all fifteen related-document entries as primary sources or cross-references without equating coverage with fulfillment.
- [X] T015 [US1] Alle elf Presets aus `.specify/presets/` in `assessment-matrix.md` sichtbar bewerten: acht Standardpresets sowie Intake Authoring, Intake Review und Intake Sequencing als optionale Presets; Autonomous als Governancefläche und Parallel Autonomous als begründet `N/A`-Ausführungsmodus bei einem Repository/einem Writer. / Visibly assess all eleven presets, distinguishing eight defaults and three optional intake presets; treat Autonomous as a governance surface and Parallel Autonomous as a justified `N/A` execution mode.
- [X] T016 [US1] Den vorhandenen MSL-Status sowie sichere Programmierschnittstellen, Ein-/Ausgabegrenzen, Eingabevalidierung, Fehlerbehandlung, Authentifizierung, Autorisierung, Kryptografie, Logging, Abhängigkeiten, Build/Release, sichere Sandbox und agentische Entwicklung in `assessment-matrix.md` prüfen; neue Implementierungssprache und neue Programmlogik für das Delta begründet `N/A` lassen. / Assess the existing MSL and secure-code/runtime surfaces while keeping a new implementation language and new program logic justified `N/A` for the delta.
- [X] T017 [US1] NIST SSDF, CWE Top 25, OWASP ASVS, OWASP SAMM, SBOM, VEX, SLSA, OpenSSF Scorecard, AI-SBOM, Zero Trust, BSI C3A, BSI C5, NIS2, CRA, EU AI Act und DORA in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` jeweils mit genau einem vertraglichen Workflowstatus und begründeter Delta-/Bestandsabgrenzung bewerten; keine Rechts-, Audit- oder Zertifizierungsfreigabe erfinden. / Assess every named standard, supply-chain topic, and regulation with exactly one contractual workflow status and a justified delta/current-state boundary, inventing no legal, audit, or certification approval.
- [X] T018 [US1] Architektur- und iSAQB-Prüfflächen in `assessment-matrix.md` sichtbar abdecken: Architekturziele, Qualitätszenarien, Kontext-, Baustein-, Runtime- und Deployment-Sichten, ADR/S-ADR, Architektur-/Technikschuldenrisiken, Trust Boundaries, Defense in Depth, Least Privilege, Fail-safe Defaults, Attack Surface, Separation of Concerns, sichere Konfiguration, arc42 Section 8, STRIDE+CIA und CAPEC; vorhandene Evidence bewerten, neue Architekturartefakte und Level-2-Registry-Anwendung für das Delta begründet `N/A` lassen. / Cover all named architecture and iSAQB surfaces, assessing existing evidence while leaving new architecture artifacts and Level 2 registry application justified `N/A` for the delta.
- [X] T019 [US1] A11Y, Cross-Platform, Agent-Parity, Intake- und Autonomous-Governance in `assessment-matrix.md` bewerten: WCAG 2.2 AA und vollständige Sprachparität `Applicable`, vorhandene Bash/PowerShell-Parität als Bestandsprüfung, neue Skript-/Manpage-/Cmdlet-/Guidance-/Templateänderungen `N/A` mit Trigger sowie keine Änderung an `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md`. / Assess A11Y, cross-platform, agent-parity, intake, and autonomous governance, including the exact no-change decisions for all shared agent surfaces.
- [X] T020 [US1] Auf jede Zeile in `assessment-matrix.md` genau die Vorrangfolge `N/A` → `AlreadySatisfied` → `FollowUp` → `Open` → `Applicable` anwenden und, wo das Quellprofil getrennte Achsen verlangt, `Applicability` aus `Applicable|N/A|Open` sowie `ImplementationStatus` aus `Fulfilled|Partly Fulfilled|Not Fulfilled|Not Assessed` konsistent ergänzen; `Applicable` nie als Synonym für erfüllt verwenden. / Apply the exact workflow precedence and, where required, the separate applicability and implementation axes; never use `Applicable` as a synonym for fulfilled.
- [X] T021 [US1] Jede Primärentscheidung in `assessment-matrix.md` mit ID, Titel, Primärquelle/Abschnitt, Querverweisen, genau einem Workflowstatus, Achsenstatus soweit erforderlich, prüfpunktspezifischer Begründung und Evidence-ID oder ausdrücklich `Keine` vervollständigen. / Complete every primary decision with all common matrix fields and either an evidence ID or explicit `None`.
- [X] T022 [US1] Die in T007 definierten Mengen-, Identitäts-, Register-, Quellen-, Status- und Abdeckungsprüfungen nach jeder Befüllungsgruppe gegen `assessment-matrix.md` ausführen und erst fortfahren, wenn 157/157, 12/12, 15/15 und 11/11 ohne Duplikate oder unbekannte `CL-*`-IDs bestehen. / Run the validator-first identity, register, source, status, and coverage checks after each population group and proceed only when every exact count passes without duplicates or unknown IDs.
- [X] T023 [US1] Exakte Gesamtzeilenzahl, Verteilung über alle fünf Workflowstatus, 12/12 Checklisten, 157/157 stabile IDs, 15/15 Dokumente, 8/8 Default- und 3/3 optionale Presets sowie die Aussagegrenze in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` aus der validierten Matrix aggregieren, ohne Matrixentscheidungen zu überschreiben. / Aggregate exact counts and proof boundaries from the validated matrix into the summary without overriding matrix decisions.

**Checkpoint / Checkpoint**: US1 ist unabhängig bestanden, wenn die vollständige Quellen- und Mengenabdeckung deterministisch grün ist. / US1 passes independently when complete source and cardinality coverage is deterministically green.

---

## Phase 4: User Story 2 – Lücken und Folgearbeit sicher unterscheiden / Distinguish Gaps and Follow-Up Safely (Priority: P1)

**Ziel / Goal**: Positive Aussagen, Unsicherheit und bewusst nachgelagerte Arbeit mit frischer Evidence, Rollen und Risiko vollständig unterscheiden. / Fully distinguish positive claims, uncertainty, and deliberately deferred work through fresh evidence, roles, and risk.

**Unabhängiger Test / Independent Test**: Jede positive Aussage hat aktuelle, passende Evidence; jede `Open`- und `FollowUp`-Zeile erfüllt den vollständigen Rollen-, Aktions-, Risiko-, Frist-/Review- und Triggervertrag. / Every positive claim has current, matching evidence; every `Open` and `FollowUp` row satisfies the full role, action, risk, due/review, and trigger contract.

- [X] T024 [US2] In `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` eindeutige Evidence Records mit Typ, repository-relativer Quelle oder exaktem Befehl, Commit-/dokumentierter Worktree-Bindung, Beobachtungszeitpunkt, Ergebnis und DE/EN-Proof-Grenze anlegen; für veränderliche externe Quellen zusätzlich Quelle und Abrufdatum erfassen. / Create complete evidence records with state binding, observation time, outcome, and bilingual proof boundary; add source and retrieval date for mutable external evidence.
- [X] T025 [US2] Jede `AlreadySatisfied`-Zeile in `assessment-matrix.md` auf semantisch passende, aktuelle Evidence, `Applicability=Applicable` und `ImplementationStatus=Fulfilled` prüfen; veraltete, hashfremde, Stub-, TUI-begrenzte oder nicht aussagegleiche Evidence sowie fehlende Human-Evidence auf `Open` oder nach Vorrangregel passenden Status zurückstufen. / Verify every `AlreadySatisfied` row against current, semantically matching evidence and downgrade stale, mismatched, stub, limited, or missing-human-evidence claims.
- [X] T026 [US2] Jede nicht erreichbare erforderliche externe Quelle in `assessment-matrix.md` nur für den betroffenen Prüfpunkt als `Open` mit Quellenbezeichnung, Owner, nächster Aktion, Risiko und Re-Evaluation-Trigger erfassen und die übrige Selbstprüfung ohne erfundenes Providerergebnis fortsetzen. / Record each unavailable required external source as `Open` only for the affected checkpoint and continue the rest of the assessment without inventing a provider result.
- [X] T027 [US2] Jede Zeile in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` mit Owner- und Reviewer-Rolle, Priorität `High|Medium|Low`, begründetem Risiko, Restrisiko `High|Medium|Low` plus Begründung und konkretem Re-Evaluation-Trigger vervollständigen; für `Open` und `FollowUp` konkrete nächste Aktion, für `FollowUp` zusätzlich Datum oder `NotScheduled` mit Trigger und Evidence-Ziel eintragen. / Complete every row with owner, reviewer, priority, justified risk and residual risk, concrete trigger, and all status-dependent action and due/review fields.
- [X] T028 [US2] Bestandswidersprüche und fehlende Nachweise in `assessment-matrix.md` statusgerecht entscheiden, insbesondere Zero-Trust-Stub versus „Partially applicable“, fehlende aktuelle SBOM/VEX-/Provenance-Evidence, begrenztes OWASP-SAMM-Snapshot sowie fehlenden Regulierungs- oder Organisationskontext; bewusst außerhalb des Features liegende Umsetzung nur als vollständig begründetes `FollowUp`, ungeklärte Evidence als `Open`. / Decide current contradictions and missing evidence according to the status contract, distinguishing fully bounded `FollowUp` from unresolved `Open`.
- [X] T029 [US2] Validator-first-Abfragen für genau einen Workflowstatus, Vorrangregel, getrennte Achsen, statusabhängige Pflichtfelder, Evidence-Frische, Prioritäts-/Restrisikodomänen, Begründungen und externe Ausfälle gegen `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` ausführen und alle Vertragsfehler vor der Summary-Aggregation korrigieren. / Run validator-first checks for one workflow status, precedence, separate axes, conditional fields, freshness, risk domains, rationales, and external failures before summary aggregation.
- [X] T030 [US2] Alle High-Risk-Entscheidungen, Open-Evidenzlücken und FollowUps mit Owner, Reviewer, Priorität, Risiko, Restrisiko, Aktion, Frist/Review, Scope-Grund und Re-Evaluation-Trigger aus `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` identitätsgleich in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` aggregieren. / Aggregate all high-risk decisions, open evidence gaps, and follow-ups identically into the summary with their complete field contract.
- [X] T031 [US2] `assessment-matrix.md` und `assessment-summary.md` auf menschlich zu entscheidende Freigaben, Audits, Wirksamkeitsnachweise und Risikoakzeptanzen prüfen; ohne konkrete ReviewDecision-Evidence `acceptedBy=NotAccepted` beziehungsweise einen nicht positiven Workflowstatus verwenden und keinerlei menschliche Zustimmung erfinden. / Review both artifacts for human-only approvals, audits, effectiveness evidence, and risk acceptance; without concrete review evidence, use `NotAccepted` or a non-positive workflow status and invent no approval.

**Checkpoint / Checkpoint**: US2 ist unabhängig bestanden, wenn keine positive Aussage ohne frische Evidence und kein `Open`/`FollowUp` ohne vollständigen Vertrag verbleibt. / US2 passes independently when no positive claim lacks fresh evidence and no `Open`/`FollowUp` lacks its complete contract.

---

## Phase 5: User Story 3 – Ergebnisse barrierearm verstehen / Understand Results Accessibly (Priority: P2)

**Ziel / Goal**: Vollständige Ergebnisse für Maintainer, Ausbildungsverantwortliche und Auszubildende ohne Spec-Kit-Vorkenntnisse textorientiert verständlich machen. / Make complete results text-first and understandable to maintainers, training leads, and apprentices without prior Spec Kit knowledge.

**Unabhängiger Test / Independent Test**: Deutsch steht vollständig vor Englisch; beide Sprachhälften sind entscheidungsidentisch, CEFR-B2-tauglich und ohne Farbe, Diagramm oder räumliche Bedeutung linear nutzbar. / Complete German precedes complete English; both halves are decision-identical, CEFR-B2 capable, and linearly usable without color, diagrams, or spatial meaning.

- [X] T032 [US3] Die vollständige deutsche Fassung von `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` mit Zweck, Statuslogik, ausgeschriebenen beziehungsweise bei erster Verwendung erklärten Fachbegriffen, eindeutigen Tabellenüberschriften und allen validierten Entscheidungen, Evidence-Verweisen, Risiken, Fristen und nächsten Aktionen auf CEFR-B2-Niveau redigieren. / Edit the complete German matrix at CEFR B2 with first-use term explanations, clear table headers, and every validated decision and field.
- [X] T033 [US3] Nach der vollständigen deutschen Fassung die vollständige englische Fassung von `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` erstellen und IDs, Quellen, Statuswerte, Achsen, Zahlen, Owner, Reviewer, Prioritäten, Risiken, Restrisiken, Evidence-IDs, Fristen, Trigger und nächste Aktionen semantisch exakt spiegeln. / Create the complete English matrix after the German part and mirror every identity, decision, count, role, risk, evidence, due date, trigger, and action exactly.
- [X] T034 [US3] `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` vollständig Deutsch zuerst und danach vollständig Englisch verfassen; Zweck, Statusvorrang, Abdeckung, höchste Risiken, Proof-Grenzen, Open-/FollowUp-Aktionen, A11Y-Review, Statistics-State, Series-State, Authority und nächsten sicheren Schritt für Personen ohne Spec-Kit-Vorkenntnisse erklären. / Write the full summary in German first and English second, explaining every required result and boundary for readers without prior Spec Kit knowledge.
- [X] T035 [US3] `docs/security/README.md` vollständig DE-first/EN-second um einen direkten, eindeutig bezeichneten Level-0-Reader-Path zu Matrix und Summary ergänzen; kanonische Baseline- und historische Feature-024-Evidence weder umdeuten noch redaktionell verändern. / Add a clear bilingual Level 0 reader path to the matrix and summary without reinterpreting canonical or historical evidence.
- [X] T036 [US3] Eine text-first-WCAG-2.2-AA-Prüfung von Überschriftenhierarchie, Linktexten, Tabellenköpfen, linearer Zeilenidentität und Status/Evidence-Bezug in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md` durchführen; Screenreader-, Braille-Zeilen- und Textbrowser-Nutzung ohne Farb-, Symbol-, Diagramm- oder Positionsabhängigkeit als begrenztes Review-Ergebnis dokumentieren. / Perform a text-first WCAG 2.2 AA review of matrix structure and linear relationships for screen readers, Braille displays, and text browsers.
- [X] T037 [US3] Dieselbe text-first-, CEFR-B2- und Erstbegriffsprüfung für `assessment-summary.md` und den neuen Einstieg in `docs/security/README.md` durchführen und DE/EN-Entscheidungsparität statt nur Wortähnlichkeit belegen. / Perform the same text-first, CEFR B2, first-use-term, and decision-parity review for the summary and security index entry.
- [X] T038 [US3] `assessment-matrix.md`, `assessment-summary.md` und `docs/security/README.md` auf absolute/private Pfade, `..`-Pfade, Secrets, Tokens, private Agentenzustände, Rohlogs, History-/SQLite-Inhalte, unnötige personenbezogene Daten und ungeprüfte Providerdetails prüfen und nur veröffentlichbare, repository-relative Evidence belassen. / Review all result Markdown for private paths, upward paths, secrets, tokens, private agent state, raw logs, history/SQLite content, unnecessary personal data, and unverified provider details, retaining only publishable repository-relative evidence.
- [X] T039 [US3] Mit einer repräsentativen Person ohne Spec-Kit-Vorerfahrung oder einer dokumentierten rollenbasierten Review-Simulation prüfen, ob in höchstens fünf Minuten Status, Evidence, Risiko und nächste Aktion eines ausgewählten Prüfpunkts aus `assessment-summary.md` über `docs/security/README.md` auffindbar sind; keine nicht durchgeführte Human-Prüfung behaupten. / Verify the five-minute findability criterion through an actual representative review or a clearly labeled role-based simulation, never claiming an unperformed human review.
- [X] T040 [US3] `specs/025-rl-se-self-assessment/documentation-impact-evidence.json` nach `.specify/templates/documentation-impact-evidence-template.json` vollständig mit der einzigen Entscheidung `UpdateRequired`, Zielgruppen, Leserpfaden, kanonischen Quellen/Owner, Navigation, Dokumentklasse, DE/EN-Strategie, Plattform-/Beispielnachweis, `distributionClass=sourceOnly`, `homeSyncRequired=false`, Evidence und Re-Evaluation ausfüllen. / Complete the Documentation Impact evidence with the sole decision `UpdateRequired` and every required governance field.

**Checkpoint / Checkpoint**: US3 ist unabhängig bestanden, wenn beide Sprachspuren identisch entscheiden und alle Inhalte linear, text-first und ohne private Daten nutzbar sind. / US3 passes independently when both language tracks make identical decisions and all content remains linear, text-first, and free of private data.

---

## Phase 6: User Story 4 – Begrenzte Verbesserung planen / Plan Bounded Improvement (Priority: P3)

**Ziel / Goal**: Findings priorisieren, ohne sie in diesem Assessment verdeckt umzusetzen oder einen Fleet-/Nachfolgelauf zu starten. / Prioritize findings without silently implementing them or starting a fleet/successor run.

**Unabhängiger Test / Independent Test**: Summary und Diff trennen Erfüllung, aktuelle Lücke und spätere Arbeit; außerhalb der erlaubten Evidence-/Dokumentationsflächen gibt es keine Mutation. / Summary and diff separate fulfillment, current gaps, and later work; no mutation exists outside the allowed evidence/documentation surfaces.

- [X] T041 [US4] In `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` eine priorisierte, aus Matrix-IDs abgeleitete Verbesserungsübersicht erstellen, die `AlreadySatisfied`, aktuelle `Open`-Lücken und bewusst begrenzte `FollowUp`-Arbeit trennt und je Folgepunkt Scope, Owner, Reviewer, Priorität, Risiko/Restrisiko, benötigte Evidence, Ausführungshinweis, Frist/Trigger sowie separate Autorisierung nennt. / Create a prioritized improvement view derived from matrix IDs that separates satisfied, open, and bounded follow-up work and carries the complete later-action contract.
- [X] T042 [US4] Mit `git diff --name-only`, `git diff --stat` und `git diff --check` beweisen und in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` festhalten, dass Produktcode, Runtime, APIs, Dependencies, Toolchain, Skripte, Providerkonfiguration, Presetinhalt, Constitution/Projekt-Templates und alle Shared-Agent-Guidance-Flächen unverändert bleiben; Abweichungen als Finding behandeln statt zu härten. / Prove through the Git diff that every forbidden product, runtime, toolchain, preset, constitution/template, and shared-agent surface remains unchanged; treat deviations as findings rather than hardening them.
- [X] T043 [US4] In `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` die aktuelle Authority als `LocalImplementation` festhalten, Statistik und Series bis zu ihren späteren Gates als `BlockedByAuthority` oder begründeten FollowUp führen und ausdrücklich bestätigen, dass kein repoübergreifender Lauf, kein Nachfolgeintake, kein Home-Sync und keine automatische Remediation gestartet wird. / Record current authority and the blocked/follow-up statistics and series states, explicitly confirming no cross-repository run, successor intake, Home sync, or automatic remediation starts.

**Checkpoint / Checkpoint**: US4 ist unabhängig bestanden, wenn jede Verbesserung begrenzt und separat autorisierbar bleibt und der Scope-Diff null versteckte Härtung zeigt. / US4 passes independently when every improvement remains bounded and separately authorizable and the scope diff shows zero hidden hardening.

---

## Phase 7: Abschluss, Repository-Gates und autoritätsgebundene Lieferung / Closeout, Repository Gates, and Authority-Gated Delivery

**Zweck / Purpose**: Targeted und repository-weite Beweise aus dem Quickstart ausführen, Statistics/Series kausal behandeln und den lokalen Implementierungscheckpoint vor der getrennten Remote-Lieferung abschließen. / Run targeted and repository-wide quickstart proofs, handle statistics/series causally, and complete the local implementation checkpoint before separate remote delivery.

- [X] T044 Die Bash- und PowerShell-Tests sowie Validatoren `scripts/test-documentation-impact.sh`, `scripts/test-documentation-impact.ps1`, `scripts/validate-documentation-impact.sh` und `scripts/validate-documentation-impact.ps1` gegen `specs/025-rl-se-self-assessment/documentation-impact-evidence.json` ausführen und exakt `UpdateRequired`, `sourceOnly` und `homeSyncRequired=false` belegen. / Run both Documentation Impact test and validation paths and prove the exact decision, distribution, and Home-sync values.
- [X] T045 Quickstart-Szenario 1 vollständig auf beiden Shellpfaden ausführen: Governance-Config, Authoring-Receipt, Review-Result, aktuelles Series-Manifest und Series-Receipt aus `requirements/intakes/series/home-baseline-delivery/` validieren und die aktuellen Graphwerte nur als zeitgebundene Evidence in `assessment-summary.md` aufnehmen. / Run all Scenario 1 intake/review/series validators on both shell paths and record current graph counts only as time-bound evidence.
- [X] T046 Quickstart-Szenario 2 vollständig ausführen: `scripts/build-secure-development-docs.sh --check`, `scripts/build-secure-development-docs.ps1 -Check`, Mapping-Test/-Validator, `specify preset list` sowie beide Check-only-Pfade von `scripts/install-spec-kit-governance-presets.*`; Bash/PowerShell-Parität und exakt 12/157/15/8+3 beziehungsweise elf installierte Presets in `assessment-matrix.md` belegen. / Run all Scenario 2 builders, mapping checks, preset listing, and exact-matrix check-only paths, proving Bash/PowerShell parity and all exact counts.
- [X] T047 Quickstart-Szenario 3 gegen beide Sprachbereiche von `assessment-matrix.md` ausführen und deterministisch Mengenidentität 157/157, Gesamtzahl `157 + HB-RLSE-Register`, null Duplikate/unbekannte IDs, genau einen Workflowstatus, Vorrangregel, Achsen, Pflichtfelder, Evidence-Frische, High/Medium/Low-Domänen, 15/15- und 11/11-Abdeckung sowie sichere relative Pfade beweisen. / Run Scenario 3 against both matrix language sections and deterministically prove all identity, status, field, freshness, coverage, and path contracts.
- [X] T048 Die semantische DE/EN-, CEFR-B2-, Erstbegriffs- und text-first-WCAG-2.2-AA-Abnahme aus Quickstart-Szenario 4 für `assessment-matrix.md`, `assessment-summary.md` und `docs/security/README.md` durchführen und Unterschiede als Fehler korrigieren, nicht als zulässige Sprachabweichung. / Perform the semantic bilingual, CEFR B2, first-use-term, and text-first WCAG 2.2 AA acceptance review and correct differences as errors.
- [X] T049 `git diff --check`, den Linkcheck `lychee --offline --include-fragments . './**/*.md'` soweit verfügbar sowie `scripts/check-homogeneity.sh --dry-run --no-patch .` und `scripts/check-homogeneity.ps1 -TargetDir . -DryRun -NoPatch` gegen den vollständigen Feature-Diff ausführen; Nichtverfügbarkeit dokumentieren, aber nicht als bestandene Prüfung in `assessment-summary.md` ausgeben. / Run diff, link, and non-writing Bash/PowerShell homogeneity checks across the complete feature diff, documenting unavailable tooling without claiming success.
- [X] T050 `scripts/invoke-psscriptanalyzer.ps1`, `scripts/scan-agent-secrets.sh --fail-on-high .`, `scripts/scan-agent-secrets.ps1 -WorkspaceRoot . -FailOnHigh` und `specify check` repository-weit ausführen und Ergebnisse mit Befehl, Zeitpunkt, Status und Worktree-Bindung in `assessment-summary.md` festhalten. / Run repository-wide PSScriptAnalyzer, both secret-scan paths, and `specify check`, recording command, time, status, and worktree binding.
- [X] T051 `scripts/test-render-project-statistics.ps1` sowie den ausschließlich lesenden Aufruf `scripts/render-project-statistics.sh --repo . --check-only --json` ausführen und Fixture-Ergebnis sowie `CURRENT` oder erwarteten Git-basierten `DRIFT` wahrheitsgemäß in `assessment-summary.md` erfassen; `DRIFT` vor Commit-Bindung nicht als technisches Versagen oder `CURRENT` umdeuten. / Run statistics fixtures and the read-only check-only path, truthfully recording `CURRENT` or expected Git-based `DRIFT` without misclassification.
- [X] T052 Nur nach neuer ausdrücklicher Commit-/Statistik-Schreibautorität, einem Source-Commit und sauberem Arbeitsbaum `docs/project-statistics.config.json` als kanonische Quelle aktualisieren, `scripts/render-project-statistics.sh --repo .` ausführen und Bash-/PowerShell-Check-only-Parität für `docs/project-statistics.md` belegen; fehlen die Voraussetzungen, beide Statistikdateien unverändert lassen und stattdessen in `assessment-summary.md` einen vollständigen FollowUp mit Owner, Risiko/Restrisiko, Frist/Trigger, DRIFT-Evidence und Scope-Grund führen. / Only with new explicit authority, a source commit, and a clean tree, update the canonical statistics config and render/verify the ledger; otherwise leave both statistics files unchanged and retain a complete bounded follow-up.
- [X] T053 Nach allen lokalen Prüfungen den endgültigen `git diff --name-only`, `git status --short` und `git diff --check` gegen die Allowlist aus T003 prüfen und in `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` den Nullnachweis für Produktcode, Runtime, API, Dependencies, Toolchain, Skripte, Providerkonfiguration, Presetinhalt und Shared-Agent-Guidance sowie alle ausgelösten Regressionsergebnisse erfassen. / After all local checks, compare the final diff and status with the T003 allowlist and record zero forbidden changes plus every triggered regression result.
- [X] T054 Den Position-6-Series-Closeout ausschließlich nach vollständiger validierter Matrix/Summary, aktueller Manifest-Re-Evaluation und neuer ausdrücklicher Closeout-Mutationsautorität durchführen: vorheriges `requirements/intakes/series/home-baseline-delivery/manifest.json` und `receipt.json` bytegleich unter `requirements/intakes/series/home-baseline-delivery/history/` archivieren, aktive Manifest-/Receipt-Dateien kausal supersedieren und den neuen Operationsnachweis unter `requirements/intakes/series/home-baseline-delivery/operations/` mit Authority, Vorher/Nachher-Graph, Supersession-Hashes und Order-Entscheidung erzeugen; andernfalls keine Series-Datei ändern. / Perform the Position 6 series closeout only after validated delivery, current-manifest re-evaluation, and new explicit mutation authority, creating byte-identical archives, causal supersession, operations evidence, graph deltas, hashes, and order decision; otherwise change no series file.
- [X] T055 Nach einem autorisierten T054-Closeout Nachfolger-Manifest/-Receipt, Archive, Operationsjournal, Supersession-Hashes und Order-Entscheidung gemeinsam mit den Bash- und PowerShell-Validatoren unter `.specify/presets/intake-sequencing-governance/scripts/` validieren und `seriesCloseoutState=Validated` in `assessment-summary.md` setzen; ohne Authority `BlockedByAuthority` mit vollständigem FollowUp beibehalten. / After an authorized closeout, jointly validate successor state, archives, operations, hashes, and order evidence on both shell paths; without authority retain `BlockedByAuthority` with a complete follow-up.
- [X] T056 In `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md` den Delivery-Gate-Endzustand festhalten: aktueller Handoff autorisiert keinen Commit, Push, PR, Merge, Admin-Bypass oder Remote-Schreibzugriff; keine dieser Aktionen ausführen, keinen Nachfolgeintake starten und erst bei einer späteren ausdrücklichen Authority die dann aktuellen Commit-, Clean-Tree-, Provider- und Series-Tokens erneut prüfen. / Record the final delivery gate: the current handoff authorizes no commit, push, PR, merge, bypass, or remote write; execute none, start no successor intake, and revalidate all mutable tokens only under later explicit authority.
- [X] T057 Jeden nicht leeren `Open`- oder `FollowUp`-Befund aus `assessment-matrix.md` abschließend als separaten Remediation-Intake-Kandidaten in `assessment-summary.md` mit Matrix-ID, begrenztem Scope, Owner/Reviewer, Priorität, Risiko/Restrisiko, benötigter Evidence, Frist/Trigger, Abhängigkeiten, Ausführungshinweis und erforderlicher separater Authority erfassen; keinen Intake erzeugen, keinen Spec-Kit-Lauf starten und keine Remediation automatisch ausführen. / Finally record every non-empty `Open` or `FollowUp` finding as a separate remediation-intake candidate with complete scope, ownership, risk, evidence, timing, dependency, execution, and authority guidance; create no intake, start no Spec Kit run, and execute no remediation automatically.

**Finaler Checkpoint / Final checkpoint**: Alle lokalen, nicht schreibenden und im Scope autorisierten Prüfungen sind belegt; bedingte Statistik-, Series- und Delivery-Schritte sind entweder mit neuer Authority kausal validiert oder vollständig als `FollowUp`/`BlockedByAuthority` abgegrenzt. / All local, non-writing, in-scope authorized checks are evidenced; conditional statistics, series, and delivery steps are either causally validated under new authority or fully bounded as `FollowUp`/`BlockedByAuthority`.

---

## Phase 8: Authority-Revalidierung, MergeAndSync und kausaler Closeout / Authority Revalidation, MergeAndSync, and Causal Closeout

- [X] T058 Die aktuelle Benutzerautoritaet, den supersedierenden Position-6-Intake, den `Ready`-Single-Review und den vollstaendigen 33/4/36-Series-Review in Bash und PowerShell pruefen; `MergeAndSync` und die enge Bypass-Grenze als aktuelle Delivery Authority binden. / Validate current user authority, superseding item-6 intake, Ready Single review, and complete 33/4/36 Series review in Bash and PowerShell; bind `MergeAndSync` and the narrow bypass boundary as current delivery authority.
- [X] T059 Aktuelles `main` bis PR #213 in den Feature-Branch mergen, den einzigen generierten Statistik-Konflikt mit der neueren `main`-Fassung aufloesen und alle akzeptierten Artefakte, Worktree-Eigentuemer und Driftgrenzen neu inventarisieren. / Merge current `main` through PR #213 into the feature branch, resolve the sole generated statistics conflict with the newer main version, and reinventory accepted artifacts, worktree ownership, and drift boundaries.
- [X] T060 `spec.md`, `plan.md`, `research.md`, `quickstart.md`, den Artefaktvertrag, `tasks.md`, Summary, Gate-Anforderungen, Run-State und Run-Evidence auf den Authority-Wechsel synchronisieren; Assessment-Scope und alle 159 Entscheidungen je Sprache unveraendert lassen und danach alle akzeptierten SHA-256-Werte erneuern. / Synchronize specification, plan, research, quickstart, artifact contract, tasks, summary, gate requirements, run state, and run evidence for the authority transition; preserve assessment scope and all 159 decisions per language, then refresh every accepted SHA-256 value.
- [X] T061 Den vollstaendigen Feature-Diff erneut mit Matrix-/Mapping-/Baseline-, Documentation-Impact-, Intake-/Review-/Series-, State-, Homogeneity-, PSScriptAnalyzer-, Secret-, Link-, `specify check`- und `git diff --check`-Gates validieren und den Source-Commit erstellen. / Revalidate the complete feature diff with all matrix, mapping, baseline, documentation-impact, intake/review/Series, state, homogeneity, PSScriptAnalyzer, secret, link, specify, and diff gates, then create the source commit.
- [ ] T062 Bei sauberem Source-Head die kanonische Statistik-Konfiguration fortschreiben, `docs/project-statistics.md` ausschliesslich mit dem Renderer aktualisieren, Bash-/PowerShell-`CURRENT` belegen und den Statistik-Commit erstellen. / On a clean source head, update canonical statistics configuration, render the ledger only through its renderer, prove Bash/PowerShell CURRENT, and create the statistics commit.
- [ ] T063 Feature-Branch pushen, Feature-PR erstellen, exakten Head, alle Pflichtchecks und Review-Threads bis zur Konvergenz pruefen; Admin-Bypass nur innerhalb der genehmigten engen Grenze verwenden. / Push the feature branch, create the feature PR, and converge exact-head checks and review threads; use admin bypass only within the approved narrow boundary.
- [ ] T064 Feature-PR mit Merge-Commit mergen, Remote-Feature-Branch loeschen und den lokalen Default-Branch fast-forward auf den gemergten Stand bringen. / Merge the feature PR with a merge commit, delete the remote feature branch, and fast-forward the local default branch to the merged state.
- [ ] T065 Auf aktuellem `main` einen nicht leeren kausalen Closeout erstellen: Position 6 archivieren, Series und Review auf den Nachfolger fortschreiben, Run-State/Evidence/Retrospektive und Statistik finalisieren, den Closeout-PR validieren und mergen sowie abschliessend sauberes `main == origin/main` bei `(0 0)` belegen; keinen Remediation- oder Folgelauf starten. / On current main, create a non-empty causal closeout: archive item 6, advance Series and review, finalize run state/evidence/retrospective and statistics, validate and merge the closeout PR, and prove clean `main == origin/main` at `(0 0)`; start no remediation or successor run.

---

## Anforderungsabdeckung / Requirement Coverage

| Anforderung / Requirement | Aktionale Tasks / Actionable tasks |
|---|---|
| RLSE-001 | T002, T009, T045 |
| RLSE-002 | T001, T003, T042, T053 |
| RLSE-003 | T008, T009, T013, T014, T046, T047 |
| RLSE-004 | T010, T015, T046 |
| RLSE-005 | T020, T021, T029, T047 |
| RLSE-006 | T020, T029, T047 |
| RLSE-007 | T027, T029 |
| RLSE-008 | T024, T025, T029 |
| RLSE-009 | T020, T027, T029 |
| RLSE-010 | T026–T030 |
| RLSE-011 | T027–T030 |
| RLSE-012 | T020, T029, T047 |
| RLSE-013 | T024, T025, T031 |
| RLSE-014 | T016 |
| RLSE-015 | T017 |
| RLSE-016 | T011, T024, T025 |
| RLSE-017 | T005, T006 |
| RLSE-018 | T006, T023, T030, T034 |
| RLSE-019 | T032–T039, T048 |
| RLSE-020 | T032–T039, T048 |
| RLSE-021 | T038, T050 |
| RLSE-022 | T049, T050, T053 |
| RLSE-023 | T003, T042, T053 |
| RLSE-024 | T028, T041, T057 |
| RLSE-025 | T035, T048 |
| RLSE-026 | T040, T044, T051, T052 |
| RLSE-027 | T054–T056 |
| RLSE-028 | T012, T013, T022, T047 |
| RLSE-029 | T020, T029, T047 |
| RLSE-030 | T001, T024–T026, T029 |
| RLSE-031 | T027, T029, T047 |
| RLSE-032 | T026, T029, T030 |

| Verfassungsanforderung / Constitution requirement | Aktionale Tasks / Actionable tasks |
|---|---|
| CR-001 | T018 |
| CR-002 | T032–T039, T048 |
| CR-003 | T032–T039, T048 |
| CR-004 | T019, T051, T052 |
| CR-005 | T016, T018 |
| CR-006 | T017 |
| CR-007 | T017 |
| CR-008 | T017 |
| CR-009 | T017 |
| CR-010 | T018 |
| CR-011 | T005, T011, T017 |
| CR-012 | T015, T019 |
| CR-013 | T035, T040, T044 |

| User Story / Success Criteria | Aktionale Tasks / Actionable tasks |
|---|---|
| US1 | T013–T023 |
| US2 | T024–T031 |
| US3 | T032–T040 |
| US4 | T041–T043, T057 |
| SC-001 | T013, T022, T047 |
| SC-002 | T014, T022, T047 |
| SC-003 | T010, T015, T046, T047 |
| SC-004 | T021, T027, T029, T047 |
| SC-005 | T020, T029, T047 |
| SC-006 | T024, T025, T029 |
| SC-007 | T027, T029, T030 |
| SC-008 | T015–T019, T047 |
| SC-009 | T033, T034, T048 |
| SC-010 | T039 |
| SC-011 | T003, T042, T053 |
| SC-012 | T049, T050, T053 |
| SC-013 | T020, T029, T047 |
| SC-014 | T024, T025, T029, T047 |
| SC-015 | T027, T029, T047 |
| SC-016 | T026, T029, T030 |

---

## Abhängigkeiten und Ausführungsreihenfolge / Dependencies and Execution Order

### Phasenabhängigkeiten / Phase Dependencies

1. **Phase 1 – Setup** beginnt sofort und bindet Scope, Authority und Inputs. / starts immediately and binds scope, authority, and inputs.
2. **Phase 2 – Fundament** hängt vollständig von Phase 1 ab und blockiert alle Stories. / depends on Phase 1 and blocks all stories.
3. **US1 (Phase 3)** hängt von T005–T012 ab und liefert die erste unabhängig prüfbare MVP-Matrix. / depends on T005–T012 and delivers the first independently testable MVP matrix.
4. **US2 (Phase 4)** hängt von US1 ab, weil Evidence-, Risiko- und Folgeverträge konkrete Matrixzeilen benötigen. / depends on US1 because evidence, risk, and follow-up contracts require concrete rows.
5. **US3 (Phase 5)** hängt von US1 und US2 ab, damit beide Sprachspuren bereits validierte Entscheidungen spiegeln. / depends on US1 and US2 so both language tracks mirror validated decisions.
6. **US4 (Phase 6)** hängt von US1 bis US3 ab, weil Verbesserungsplanung nur aus der validierten und verständlichen Ergebnisbasis abgeleitet wird. / depends on US1 through US3 because improvement planning derives only from validated, understandable results.
7. **Phase 7 – Abschluss** hängt von allen Stories ab; T052, T054 und T055 besitzen zusätzliche Authority-/Clean-Tree-/Kausalitäts-Gates. / depends on all stories; T052, T054, and T055 add authority, clean-tree, and causality gates.
8. **T057** bleibt die letzte fachliche Aufgabe und darf erst nach allen Validierungen und Delivery-Gate-Entscheidungen abgeschlossen werden. / remains the final professional task and may complete only after every validation and delivery-gate decision.

### Abhängigkeiten innerhalb der Stories / Within-Story Dependencies

- **US1**: Quellenzeilen T013 → Dokument-/Preset-/Governance-Mapping T014–T019 → Status T020–T021 → Validator T022 → Summary T023. / source rows → mappings and governance → statuses → validator → summary.
- **US2**: Evidence Records T024 → Positiv-/Ausfallprüfung T025–T026 → Rollen/Risiko T027 → konkrete Findings T028 → Validator T029 → Summary/Approval-Review T030–T031. / evidence records → positive/outage review → roles/risk → findings → validator → summary/approval review.
- **US3**: Deutsch T032 → Englisch T033 → Summary T034 → Navigation T035 → A11Y/Privacy/Usability T036–T039 → Documentation Impact T040. / German → English → summary → navigation → A11Y/privacy/usability → Documentation Impact.
- **US4**: Improvement View T041 → Scope-Proof T042 → Authority State T043. / improvement view → scope proof → authority state.
- **Abschluss / Closeout**: Targeted Validators T044–T048 → repository-weite Gates T049–T050 → Statistics Read T051 → bedingtes Statistics Write T052 → finaler Scope T053 → bedingter Series-Closeout T054–T055 → Delivery Gate T056 → Remediation-Kandidaten T057. / targeted validators → repository gates → statistics read → conditional statistics write → final scope → conditional series closeout → delivery gate → remediation candidates.

---

## Parallelbeispiele / Parallel Examples

Es gibt in diesem Feature bewusst keine mit `[P]` markierte Aufgabe. Matrix, Summary, Documentation-Impact-Evidence, Statistics und Series bilden jeweils gemeinsame Evidence- oder Validierungsflächen; parallele Writer würden den bindenden One-Writer- und Kausalitätsvertrag verletzen. / This feature intentionally has no task marked `[P]`. Matrix, summary, Documentation Impact evidence, statistics, and series state each form shared evidence or validation surfaces; parallel writers would violate the binding one-writer and causality contract.

Beispiele für ausdrücklich **nicht** parallele Paare / Examples of explicitly **non-parallel** pairs:

- T013 und T020: Statusentscheidungen benötigen die endgültige Primärzeilenidentität in `assessment-matrix.md`. / status decisions require final primary-row identity.
- T024 und T025: Positive Claims dürfen erst nach vollständigen Evidence Records bewertet werden. / positive claims may be assessed only after complete evidence records.
- T032 und T033: Die englische Fassung spiegelt die fachlich abgeschlossene deutsche Fassung. / the English part mirrors the professionally complete German part.
- T051 und T052: Der lesende Statistikstatus entscheidet, ob ein späterer Schreibpfad überhaupt zulässig ist. / the read-only statistics state determines whether a later write path is permitted.
- T054 und T055: Series-Validierung setzt die atomar erzeugten Closeout-Artefakte voraus. / series validation requires the atomically produced closeout artifacts.

Reine lokale Befehlsausführung darf intern beschleunigt werden, wird aber nicht als parallele Task-Arbeit gewertet, wenn Ergebnisse in dieselbe Evidence oder Validierungsentscheidung einfließen. / Pure local command execution may be accelerated internally, but it is not treated as parallel task work when results feed the same evidence or validation decision.

---

## Implementierungsstrategie / Implementation Strategy

### MVP zuerst: US1 / MVP First: US1

1. Phase 1 und Phase 2 vollständig abschließen. / Complete Phases 1 and 2.
2. T013–T023 sequenziell ausführen. / Execute T013–T023 sequentially.
3. Bei T022 stoppen und die unabhängige 157/157-, 12/12-, 15/15- und 11/11-Abnahme wiederholen. / Stop at T022 and repeat the independent exact-count acceptance checks.
4. US1 nur als MVP-Abdeckung verstehen; ohne US2 sind positive Evidence und Findings noch nicht abnahmefähig. / Treat US1 only as the coverage MVP; without US2, positive evidence and findings are not acceptance-ready.

### Inkrementelle Lieferung / Incremental Delivery

1. **US1** liefert vollständige, eindeutige Abdeckung. / delivers complete, unique coverage.
2. **US2** macht Status, Evidence, Risiko und Folgearbeit auditfähig. / makes status, evidence, risk, and follow-up audit-ready.
3. **US3** liefert vollständige DE/EN-, A11Y- und Leserpfad-Abnahme. / delivers complete bilingual, accessibility, and reader-path acceptance.
4. **US4** grenzt spätere Verbesserungen ohne Scope-Ausweitung ab. / bounds later improvements without scope expansion.
5. **Phase 7** validiert das Repository, behandelt Statistics und Series nur unter Authority und endet mit T057 ohne automatische Remediation. / validates the repository, handles statistics and series only under authority, and ends with T057 without automatic remediation.

### Sichere Stopppunkte / Safe Stop Points

- Nach T012: Validator-first-Fundament vorhanden, noch keine fachliche Entscheidung. / validator-first foundation exists, no professional decision yet.
- Nach T023: vollständige MVP-Abdeckung, aber noch keine abschließende Evidence-/Risikoabnahme. / complete MVP coverage, but no final evidence/risk acceptance yet.
- Nach T031: auditfähige Entscheidungen, noch ohne abschließende Sprach-/A11Y-Abnahme. / audit-ready decisions, before final language/accessibility acceptance.
- Nach T043: vollständige lokale Ergebnislieferung vor Repository-Gates. / complete local result delivery before repository gates.
- Nach T051: sicherer autoritätsfreier Stopp bei Statistik-`DRIFT`. / safe authority-free stop at statistics `DRIFT`.
- Nach T053: vollständige lokale Validierung; bedingte Series-/Delivery-Schritte bleiben gesperrt. / complete local validation; conditional series/delivery steps remain gated.
- Nach T057: historischer fachlicher Abschluss innerhalb `LocalImplementation`; die spaeter erteilte `MergeAndSync`-Autoritaet wird ausschliesslich in Phase 8 umgesetzt. / historical professional completion within `LocalImplementation`; the later `MergeAndSync` authority is exercised only in Phase 8.
