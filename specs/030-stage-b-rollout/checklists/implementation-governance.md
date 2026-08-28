# Implementierungs-Governance / Implementation Governance

**Feature / Feature**: `specs/030-stage-b-rollout`
**Run ID / Run-ID**: `954ff259-ffed-44a8-883f-28742b031a9b`
**Owner / Owner**: Fleet Delivery Owner
**Reviewer / Reviewer**: Autonomous Run Governance Reviewer

## T002 Run-State-Revalidierung / Run-State Revalidation

- **Applicability / Anwendbarkeit**: `Applicable`
- **Implementation status / Umsetzungsstatus**: `Completed`
- **Command / Befehl**: `bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.sh --state specs/030-stage-b-rollout/autonomous-run-state.json`
- **Result / Ergebnis**: Exitcode `0`; Run `954ff259-ffed-44a8-883f-28742b031a9b`, Featurepfad `specs/030-stage-b-rollout`, Branch `030-stage-b-rollout`, Stage `Implement`, Status `Active`, Liefermodus `MergeAndSync` und Aufgabenstand `1/194` sind konsistent. / Exit code `0`; run, feature path, branch, stage, status, delivery mode, and task checkpoint are consistent.
- **Accepted inputs / Akzeptierte Eingaben**: Fünf Intake-/Review-Artefakte und das abgeschlossene Plan-Review bleiben durch die im State gebundenen normalisierten SHA-256-Werte belegt. Die ausdrückliche Admin-Bypass-Authority bleibt eine eng begrenzte Ausnahme nach einem regulären Protection-Refusal. / Five intake/review artifacts and the completed plan review remain bound by normalized SHA-256 values. Explicit admin-bypass authority remains a narrowly scoped exception after a regular protection refusal.
- **Evidence / Nachweis**: Validatorausgabe `PASS`; frisches Analyze-Phasenergebnis `bf957bfb1ee860b932518a61824779f560cba73934e9f5fd63a36bc6d613ed27`; akzeptierter Tasks-Payload vor Fortschrittsmarkierung `a3eb5aa04f98eb0a11a3ca18346f629bbf9cac9dbf6ed1dc90a42d45cac1f19d`.
- **Residual risk / Restrisiko**: Authority, Provider-, Flotten-, Head-, Gate-, Review- und Budgetzustände sind dynamisch und müssen an den vorgesehenen Mutationsgrenzen erneut geprüft werden. / Authority, provider, fleet, head, gate, review, and budget state remain dynamic and require revalidation at each specified mutation boundary.
- **Follow-up / Folgemaßnahme**: T003 vervollständigt die Governance-Skelette; T127 und jede weitere ExternalWriteGate-Grenze revalidieren die dynamischen Fakten. / T003 completes the governance skeletons; T127 and every subsequent ExternalWriteGate boundary revalidate dynamic facts.
- **Re-evaluation / Neubewertung**: Bei Drift von Run-ID, Featurepfad, Branch, Tasks-Hash/-Zähler, akzeptierten Artefakten, Authority, G3, Flotte, Provider, Gate-Anforderungen oder Delivery Mode. / Re-evaluate on drift of run ID, feature path, branch, tasks hash/count, accepted artifacts, authority, G3, fleet, provider, gate requirements, or delivery mode.

## Governance-Checkpoint-Matrix / Governance Checkpoint Matrix

Die Anwendbarkeit ist fuer alle zwoelf Presets abgeschlossen und bleibt von der
Umsetzungsachse getrennt. `Pending` benennt ein spaeteres, weiterhin
blockierendes Gate; `Open` wird nicht als stille Zwischenablage verwendet.
Jedes anwendbare lokale Pre-Delivery-Subgate muss vor T126 auf `Passed` stehen;
ausdrücklich späteren Live-/Delivery-/Closeout-Aufgaben zugeordnete Subgates
bleiben wahrheitsgemäß `Pending`. / Applicability is closed for all twelve
presets and remains separate from implementation status. `Pending` names a
later blocking gate; `Open` is not used as a silent holding state. Every
applicable local pre-delivery subgate must be `Passed` before T126, while
explicitly later live, delivery, and closeout subgates remain truthfully
`Pending`.

| Checkpoint | Applicability | Implementation status | Owner / Reviewer | Evidence | Residual risk / Follow-up / Re-evaluation |
|---|---|---|---|---|---|
| Security Governance | Applicable | T114–T118 assurance and T124 full regression Passed | Security Owner / Security Reviewer | T114–T118, T124; Run `32587448948` | Provider-, Ruleset-, Bypass-, Secret- oder Trust-Boundary-Drift; bei jeder solchen Änderung neu prüfen. |
| Architecture Governance | Applicable | T114/T119 review Passed; 48/48 live delivery converged | Architecture Owner / Architecture Reviewer | T114, T119, T164 | Remote- oder Vertragsdrift erfordert erneute ADR-/arc42-Prüfung. |
| iSAQB Architecture Governance | Applicable | T119 final local review Passed | Architecture Owner / iSAQB-oriented Peer | T119 | Baustein- und Laufzeitsicht bei struktureller Änderung neu bewerten. |
| A11Y Governance | Applicable | Local user surfaces and T125 aggregation Passed | Documentation Owner / A11Y Reviewer | T100–T110, T108, T125; `primary/AC-SBR-009.json` | Nutzertexte können driften; WCAG-2.2-AA-orientierte Textnutzung erneut prüfen. |
| Cross-Platform Governance | Applicable | Native platform checkpoint, full T124 regression and T125 acceptance Passed | Script Owner / Cross-Platform Reviewer | `checklists/cross-platform.md`, T102–T125; Windows Run `32587448948`, Job `97065888986`; `primary/AC-SBR-009.json` | Native Tokens, Vollregression und AC-SBR-009 sind hashgebunden; spätere Payloaddrift bleibt Re-Evaluation-Trigger. |
| Agent Parity Governance | Applicable | T121 Passed | Governance Owner / Agent-Parity Reviewer | Constitution v1.21.0 mirror; five agent surfaces; source/runtime templates; `test_spec_kit_agent_surface_parity.py` | Shared-Guidance-Trigger verlangt atomare Fünf-Flächen-/Template-/Constitution-Pflege. |
| Model Routing Governance | N/A for feature change | Closed input gate | Run Owner / Routing Validator | gebundener Runner `codex-implementation-auto` | Bei Profil-, Modell-, Rollen- oder Preflight-Drift stoppen. |
| Intake Authoring Governance | N/A | Closed input gate | Intake Owner / Intake Governance Reviewer | fünf akzeptierte Artefakthashes | Bei Intake-/Receipt-Drift stoppen. |
| Intake Review Governance | Applicable as input gate; N/A for new review work | Passed input gate | Intake Owner / Review Owner | Ready-Result `132ba8e631ca930778b36d3d96b91fe974a3c126a4f9e9dbaf5b1b21b8c5ec69` | Bei Quell- oder Review-Hashdrift neues Review verlangen. |
| Intake Sequencing Governance | N/A for new feature work; read-only isolation input | T166 Passed; terminal read-only T194 remains after closeout | Series Owner / Sequencing Validator | T091, T099, T166, T194 | Nur separat autorisierte Sequencing-Arbeit darf die Serie ändern. |
| Autonomous Run Governance | Applicable | T001–T170 Passed; regular and causal closeout T171–T194 active | Run Owner / Autonomous Reviewer | T001–T194 | Head-, Authority-, Delivery-Set-, Gate- oder Evidence-Drift stoppt fail-closed. |
| Parallel Autonomous Governance | N/A | Closed | Run Owner / Governance Reviewer | serielle Writerregel in `tasks.md` | Nur bei ausdrücklicher Kampagnenautorität neu bewerten. |
| Documentation Impact | Applicable | T120–T123 and T168–T171 Passed; truthful pre-merge intermediate state recorded | Documentation Owner / Documentation Reviewer | `documentation-impact-evidence.json`, T120–T123, T168–T182 | Die finale Home-Sync-Disposition wird erst kausal nach T179 belegt. |
| Statistics | Applicable | T169/T170 Passed; canonical slot 68, renderer CURRENT, 146 assertions | Statistics Owner / Documentation Reviewer | canonical slots 67–68; T169–T170 | Nur kanonische Konfiguration und Renderer dürfen den Profilblock ändern. |
| Acceptance AC-SBR-001–012 | Applicable | 12/12 fresh Primary rows Passed at Level-0 head `b200862`; aggregation validated | Fleet Delivery Owner / Acceptance Reviewer | `autonomous-run-gate-requirements.json`, T125, T142–T167; `evidence/v1/acceptance-operational.json` | Jeder spätere Kandidaten-Head benötigt einen neuen T178-/T189-Snapshot. |
| G4/Copilot/Account/Subscription isolation | Applicable | T164–T166 Passed; terminal T194 remains read-only | Fleet Delivery Owner / Governance Reviewer | T091, T099, T164–T166, T194 | Jede Mutation ist verboten; T194 bestätigt den terminalen Nullzustand. |

## Implementierungsstatus / Implementation Status

- **Current checkpoint / Aktueller Checkpoint**: T001–T170 sind abgeschlossen. Der frische Plan `adbcb810…` umfasst 48 autoritative Repositories, fünf geschlossene Wellen, 28 belegte No-ops und 20 regulär gemergte Private-Governance-Lieferungen.
- **Runtime implementation / Runtime-Implementierung**: `Completed`; Stage-B-Verträge, atomare Evidence, sichere Provider-Reads, immutable Planung und ExternalWriteGate sind implementiert und durch zwölf Acceptance-Gates belegt.
- **Remote delivery / Remote-Lieferung**: `Fleet completed`; 48/48 Ziele sind synchronisiert. Alle 20 nichtleeren Zieltransaktionen wurden regulär gemergt, ihre Minimal-Workflows und Rulesets sind exakt verifiziert; Quota-Refusals bleiben wahrheitsgemäß nicht ausgeführte Provider-Payloads.
- **Home sync / Home-Sync**: `Completed`; der konfliktfreie Dry-Run umfasste 45 manifestgebundene Pfade. Der echte Lauf und der anschließende Check-only-Lauf hatten Exitcode `0`; Home-Commit `f61738e` bindet Quellcommit `0203102`.
- **Terminal closeout / Terminaler Abschluss**: `In progress`; zwölf Primary-Gates und FleetTerminalEvidence sind bestanden, `Completed` folgt erst nach T194.
- **T141 resume gap / T141-Resume-Lücke**: `NeedsRevalidation`. Der produktive
  CLI-Handler gab nur feste Statusfelder aus und rief die bereits getesteten
  Klassen `StageBFleetPreflight` und `StageBRolloutPlanner` nicht auf. Deshalb
  gelten weder ein Exitcode `0` dieses Stubs noch fixture-only AC-SBR-001/002
  als Live-Preflight. Die minimale Remediation verdrahtet den read-only
  Live-Pfad, trennt Preview von lokaler atomarer Planpublikation und hält den
  ExternalWriteGate bis zu neuer T144-Authority geschlossen.

### T127–T140 Level-0-Control-Plane / Level 0 Control Plane

- **Completed / Abgeschlossen**: T127–T140. Die frische Authority band
  `MergeAndSync` ausschließlich an T127–T140. Kandidatencommit `4618428`
  entspricht exakt Tree `b38d7942…`; der deterministische Statistik-Companion
  `c7e64f6` repariert ausschließlich den durch den neuen Git-Head ausgelösten
  Profil-2-Drift. Beide nicht erzwungenen Pushes wurden reconciled.
- **Pull request / Pull Request**: PR `#251`, Head
  `c7e64f6e498ea0f56d4b055c003eeb046ce734e9`, Base `main`, wurde als
  Mergecommit `0203102102b709ab37f5599b852c7978d595e368` integriert.
- **Gates / Gates**: Alle 26 Push-/PR-Checks am aktuellen Head sind grün. Die
  vier maßgeblichen PR-Workflows sind Runs `32594635038`, `32594635062`,
  `32594635018` und `32594635065`; Workflow, Job, Runner und tatsächliche
  Befehle sind in `operational/control-plane/t134-gate-map.json` gebunden.
- **Owner self-review exception / Owner-Self-Review-Ausnahme**: GitHub meldet
  am unveränderten Head weiterhin `REVIEW_REQUIRED`, obwohl alle 26 Checks
  grün sind, keine Review-Threads bestehen und kein Reviewer mehr angefordert
  ist. Repository-Owner `hindermath` hat die Fremdreview-Anforderung
  ausdrücklich zurückgenommen, den exakten Head selbst geprüft und das
  Restrisiko einer fehlenden Provider-Approval akzeptiert. Dies wird nicht als
  GitHub-Approval dargestellt. Der Admin-Bypass bleibt ausschließlich nach
  einem belegten regulären Protection-Refusal zulässig und ersetzt keine
  Gate-, Security- oder Acceptance-Evidence.
- **Merge and synchronization / Merge und Synchronisierung**: Der reguläre
  Mergeversuch wurde ausschließlich von der Base-Branch-Policy abgelehnt.
  Danach wurde der genehmigte Admin-Bypass am unveränderten Head eingesetzt.
  Lokaler und entfernter `main` sind per Fast-forward auf `0203102`
  konvergiert; ausschließlich `030-stage-b-rollout` wurde lokal und remote
  entfernt.
- **Home sync / Home-Sync**: Preview und echter `--no-pull`-Lauf hatten
  Exitcode `0`; der Check-only-Nachlauf meldet alle verwalteten Home-Dateien
  aktuell. Vorhandene nicht manifestgebundene lokale Agent-Skill-/Statistik-
  Änderungen wurden weder verworfen noch erzwungen überschrieben.

## T006 Vertrags- und Historiennachweis / Contract and History Evidence

- **Applicability / Anwendbarkeit**: `Applicable`
- **Implementation status / Umsetzungsstatus**: `Passed`
- **Owner / Reviewer**: Contract Owner / Architecture and Evidence Reviewer
- **Evidence / Nachweis**: Alle fünf Stage-B-JSON-Schemas und
  `autonomous-run-gate-requirements.json` parsen mit Python 3; der sechste
  Workflow-/Ruleset-Vertrag wurde vollständig gelesen. `git diff --exit-code
  b6a0d81760e9ef68a058e5d9578073b5e78b61b8 --
  specs/029-ci-budget-governance/contracts/` meldet Exitcode `0`.

| Stage-B-Vertrag / Contract | Version | SHA-256 |
|---|---:|---|
| `fleet-terminal-evidence.schema.json` | 1.1 | `c1bae9090aaf043ba1faf38f942ffee6366b1dd31b3fe4446d805ec0eb3e6e89` |
| `repository-rollout-result.schema.json` | 1.1 | `ccd3a8647373c9066d6d2d186c8d5e612b49f073b0c6d3879ab70c76256c2f76` |
| `stage-b-rollout-plan.schema.json` | 1.1 | `87e30d43966dc94944eaf8ac94ffa10bf944fd27aca2ae316b89bf86379b8f44` |
| `stage-b-ruleset-plan.schema.json` | 1.0 | `5d654e82070abd7782df04371bb5cd353b2980c89db0000886548762fecdb621` |
| `stage-b-run-state.schema.json` | 1.1 | `411a5caf9b2504d994a7b4ba712224480b3a92ce3134f1cd220503800751c23c` |
| `workflow-ruleset-contract.md` | Markdown contract | `1c26366fb7cb1a74c3871e717b45725ddf43767df284bd0523dc2a0640269c5f` |
| `autonomous-run-gate-requirements.json` | 1.0 | `79b516fa726f3289cf2a29b77c81f75b95ae34277bce17fc760fb25926a24626` |

| Unveränderter Stage-A-Vertrag / Unchanged contract | SHA-256 |
|---|---|
| `ci-budget-path-contracts.schema.json` | `08860f95e37f0772284b4d2939e9c3ee1e0e29ba1640f2e367f6215cf29673e9` |
| `ci-budget-profile-registry.schema.json` | `58b5298a5310d4752de6fc7ea72c2e80621a4e90fc92bd35b9d9d5552654e27f` |
| `ci-gate-evidence.schema.json` | `aae750841d33d5c5a027b822b7a8f60dd3f53021ac8f2ddaf24149949b0dc352` |
| `ci-inventory-rollout-plan.schema.json` | `ce88b4e782f867455b3d78d0edbfa0f319e7d457ec2a84b80646093c2695675a` |
| `workflow-ruleset-contract.md` | `606af81f877fe1dd710ff65c2535034a2181e09d3346b5de539e7e070a69359b` |

- **Residual risk / Restrisiko**: Ein späterer Schema- oder Historien-Drift
  würde installierte Verträge beziehungsweise historische Stage-A-Evidence
  entkoppeln. / Later schema or history drift could detach installed contracts
  from historical Stage-A evidence.
- **Follow-up / Folgemaßnahme**: T011–T015 installieren bytegleiche Kopien;
  T016/T019 prüfen Versions- und Semantikdrift fail-closed.
- **Re-evaluation / Neubewertung**: Bei jeder Änderung unter den beiden
  Contract-Wurzeln, an Gate Requirements, G3-Head oder G3-Mergecommit.

## T007 Preset-Matrix / Preset Matrix

- **Applicability / Anwendbarkeit**: Core eight `Applicable`; four
  supplemental presets read-only/input-gate dispositioned.
- **Implementation status / Umsetzungsstatus**: `Passed with exact supplemental-matrix disposition`.
- **Owner / Reviewer**: Governance Owner / Preset Matrix Reviewer.
- **Evidence / Nachweis**: Der vorgeschriebene Aufruf `bash
  scripts/install-spec-kit-governance-presets.sh --check-only` wurde
  read-only ausgeführt. Sein exakter Acht-Preset-Mengenvergleich meldete nur
  die vier im Plan erwarteten Zusatz-IDs und Exitcode `1`; kein Core-Eintrag
  fehlte oder driftete. Eine anschließende read-only Kernprojektion gegen
  `scripts/config/spec-kit-governance-presets.json`, die aktive Registry und
  `specify preset list` bestätigte alle acht Core-Versionen/-Prioritäten und
  insgesamt zwölf aktive Presets.

| Preset | Version | Priority | Disposition |
|---|---:|---:|---|
| Security | 0.6.2 | 10 | Applicable |
| Architecture | 0.5.2 | 20 | Applicable |
| iSAQB Architecture | 0.2.2 | 30 | Applicable |
| A11Y | 0.4.3 | 40 | Applicable |
| Cross-Platform | 0.2.2 | 50 | Applicable |
| Agent Parity | 0.4.2 | 60 | Applicable |
| Model Routing | 0.1.4 | 61 | N/A for feature change; active routed input |
| Intake Authoring | 0.3.1 | 64 | N/A; accepted artifact remains input |
| Intake Review | 0.2.1 | 65 | Applicable Ready input gate; no new review work |
| Intake Sequencing | 0.2.3 | 66 | N/A; series and G4 remain unchanged |
| Autonomous Run | 0.4.1 | 70 | Applicable |
| Parallel Autonomous Run | 0.2.6 | 80 | N/A; no campaign or delegated writer |

- **Residual risk / Restrisiko**: Der generische Acht-Preset-Exact-Set-Check
  kann eine absichtlich erweiterte lokale Zwölf-Preset-Zuordnung nicht allein
  als Pass darstellen. / The generic exact eight-set check cannot by itself
  report an intentionally extended twelve-preset assignment as a pass.
- **Follow-up / Folgemaßnahme**: Die getrennte Core-Projektion und aktive
  Zwölf-Preset-Inventur bleiben für diesen akzeptierten Plan bindend; keine
  Installations- oder Reparaturmutation wurde ausgeführt.
- **Re-evaluation / Neubewertung**: Bei Registry-, Konfigurations-, Versions-,
  Priority-, Enabled- oder Preset-Dateidrift.

## T008 Consumer- und Auswirkungsinventar / Consumer and Impact Inventory

- **Applicability / Anwendbarkeit**: `Applicable`
- **Implementation status / Umsetzungsstatus**: `Passed for pre-code inventory`
- **Owner / Reviewer**: Test Owner / Documentation and Contract Reviewer
- **Evidence / Nachweis**: `rg` suchte nach allen geplanten Stage-B-
  Dokumenttypen, AC-SBR-Markern, Evidence-Namespaces und Governancepfaden in
  `scripts/`, `.specify/`, `docs/` und der unveränderten Stage-A-Basis.
- **Affected executable validators / Betroffene Validatoren**:
  `scripts/validate-documentation-impact.{sh,ps1}`;
  `validate-autonomous-run-state`, `validate-autonomous-delivery-set`,
  `validate-autonomous-gate-evidence`, `validate-autonomous-phase-result`;
  `scripts/tests/test_stage_b_rollout.py` und
  `scripts/tests/run_stage_b_rollout_acceptance.py` (neu);
  `test_ci_budget_governance.py`, `test_agentic_workspace_maintenance.py`,
  `test_maintenance_contracts.py`,
  `test_spec_kit_agent_surface_parity.py`, Statistikrenderer/-tests,
  PSScriptAnalyzer, Bash-Syntax und Secret Scan.
- **Affected documentation/templates / Betroffene Dokumentation/Templates**:
  Quickstart, Script Reference, Manpage, PowerShell Help, Architektur,
  Accessibility, Security, Statistics, Private-Minimal-Workflow und Ruleset.
- **Residual risk / Restrisiko**: Neue Marker- oder Pfadkonsumenten können
  während der Implementierung hinzukommen.
- **Follow-up / Folgemaßnahme**: T124 führt alle betroffenen Regressionen
  aus; T121 und T171 wiederholen Paritäts-/Delivery-Set-Prüfungen.
- **Re-evaluation / Neubewertung**: Bei neuem Schema, Statuswert,
  Evidencepfad, Marker, Template, Validator oder Dokumentationsziel.

## T009 Execution-Surface-Review / Execution Surface Review

- **Applicability / Anwendbarkeit**: `Applicable`
- **Implementation status / Umsetzungsstatus**: `Passed for pre-code review`
- **Owner / Reviewer**: Runtime Owner / Secure Scripting Reviewer
- **Evidence / Nachweis**: `python3 -m py_compile
  scripts/lib/agentic_workspace_fleet.py`, Bash-Syntax für Maintenance und
  Pre-Push-Hook sowie der PowerShell-Parser liefen mit Exitcode `0`.
  Der vorhandene Kern nutzt Python-Standardbibliothek, `subprocess`-
  Argumentlisten und im CI-Gate explizit `shell=False`. Bash startet den Kern
  mit Arrays und `exec`; PowerShell verwendet eine
  `List[string]` und gibt `$LASTEXITCODE` unmittelbar weiter. Der Pre-Push-Hook
  bleibt eine unabhängige lokale Stage-A-Defense-in-Depth-Grenze.
- **Dependency disposition / Abhängigkeitsentscheidung**: Keine neue
  Dependency. Verwendet werden Python-Standardbibliothek, Git, authentifizierte
  `gh` CLI, Bash 3.2+ und PowerShell 7.
- **Safe process boundary / Sichere Prozessgrenze**: Stage-B-Reads/Writes
  müssen getrennte nicht ausgewertete Argumentarrays, feste Hosts,
  validierte IDs/Pfade und begrenzte Ausgaben verwenden; kein `eval`,
  `Invoke-Expression` oder Shell-String.
- **Residual risk / Restrisiko**: Der bestehende Kern besitzt noch keinen
  Stage-B-Subcommand; Providerwriter sind daher bis T021/T043–T053 gesperrt.
- **Follow-up / Folgemaßnahme**: Rote Verträge vor Implementierung, danach
  sichere Argumentarray-/Injection-/SSRF-/Redaktions-Regressionen.
- **Re-evaluation / Neubewertung**: Bei Dependency-, Prozess-, Hook-,
  Wrapper-, Provider-, Netzwerk- oder Trust-Boundary-Änderung.

## US1 Preflight-Nachweis / US1 Preflight Evidence

- **Applicability / Anwendbarkeit**: `Applicable` für SBR-001–SBR-004 und SBR-006.
- **Implementation status / Umsetzungsstatus**: `Passed locally; live provider revalidation remains required before T144`.
- **Owner / Reviewer**: Fleet Delivery Owner / Acceptance and Security Reviewer.
- **Evidence / Nachweis**: `FleetPreflightTests` und `ExternalWriteGateTests` bestehen auf macOS. Die dynamische Manifestunion, Assignments und Fixture-Inventur besitzen denselben sortierten ID-Hash `53b09dd5fabc6a0bbdad7b34cde0420c951aed7ef5f3033f953e969c8744e998`. G3 bindet Reviewed Head `e1ff2a0b5146604b2a71a20576dbd4341d618121`, Merge Commit `b6a0d81760e9ef68a058e5d9578073b5e78b61b8` und PostMerge-Hash. Bash/PowerShell erzeugen für denselben Preview-Aufruf den normalisierten Entscheidungs-Hash `71a5bfd204df75cc39b8e440424b86b170149311a7a279467479bd97432cfdcd` bei null Writes.
- **Residual risk / Restrisiko**: Providerinventar, Heads, Sichtbarkeit, Rulesets, Budget und Authority bleiben dynamisch. Fixture-Evidence autorisiert keine Live-Mutation.
- **Follow-up / Folgemaßnahme**: T141 erzeugt den frischen Live-Plan; T142/T143 publizieren AC-SBR-001/002 erst danach. T144 öffnet das Gate nur für die exakt gebundene erste Aktion.
- **Re-evaluation / Neubewertung**: Bei G3-, Manifest-, Assignment-, Provider-ID-, Remote-, Default-Branch-, Head-, Schema-, Scope-, Delivery-Set-, Budget- oder Authority-Drift.

## US3 Exakter regulärer Lifecycle / Exact Regular Lifecycle

- **Applicability / Anwendbarkeit**: `Applicable` für SBR-009–SBR-013, SBR-016 und SBR-021.
- **Implementation status / Umsetzungsstatus**: `Passed for local fake-provider vertical slice; live delivery remains blocked until T127–T144`.
- **Owner / Reviewer**: Fleet Delivery Owner / Security and Acceptance Reviewer.
- **Evidence / Nachweis**: Der rote Canary-Slice blockierte vor Branch/Commit/PR mit `writes=0`; der grüne `PublicCanaryVerticalSliceTests`-Scope belegt exakt Branch, PreMerge, Commit, Push, einen PR, konkrete Gates, regulären Review, Merge, Default-Sync und kausales PostMerge. Resume derselben Run-/Plan-/Head-Bindung erzeugt null Duplikate. `RegularDeliveryTests`, `PrivateRulesetTests`, `AdminBypassEvidenceTests` und `SecurityBoundaryTests` belegen Diff-/Head-/Review-/Ruleset-/Bypass-/Injection-/SSRF-/Redaktionsgrenzen.
- **Residual risk / Restrisiko**: Fake-Provider-Evidence ist kein Live-Providerbeleg. Review, Checks, Billing, Rulesets und Heads müssen am exakten Live-Kandidaten erneut gelesen werden.
- **Follow-up / Folgemaßnahme**: T127–T140 liefern zuerst die Level-0-Control-Plane; T145 ff. führen den seriellen Live-Lifecycle aus. Admin-Bypass bleibt nur protection-only nach vollständiger unabhängiger Evidence.
- **Re-evaluation / Neubewertung**: Bei Branch-, Diff-, Gate-, Review-, Merge-, Ruleset-, Provider-, Bypass-, Redaktions- oder Evidence-Schemaänderung.

## US4 No-op, Stop und Resume / No-op, Stop, and Resume

- **Applicability / Anwendbarkeit**: `Applicable` für SBR-005, SBR-014 und SBR-015.
- **Implementation status / Umsetzungsstatus**: `Passed for deterministic local fixtures; live resume remains a revalidation gate`.
- **Owner / Reviewer**: Run Owner / Autonomous and Provider Reviewer.
- **Evidence / Nachweis**: `NoOpTests` beweist semantische Tree-/Profil-/Workflow-/Gate-/Ruleset-/Providerkonvergenz und null leere Branches, Commits oder PRs. `StopResumeIdempotencyTests` persistiert den ersten Providerblocker atomar, erhält bereits konvergierte Resultate, setzt beim ersten nicht konvergierten Ziel fort und verwendet stabile aktionsspezifische Idempotency Keys. Portable Bash-/PowerShell-Entscheidungen und Exitcodes stimmen überein.
- **Residual risk / Restrisiko**: Ein Live-Providerergebnis kann nach unklarem Timeout Drift enthalten; es muss read-only reconciled werden. Die nativen Plattformtokens sind vorhanden, werden aber bei Payload- oder Plattformdrift ungültig.
- **Follow-up / Folgemaßnahme**: T125 aggregiert später die vollständige Plattform-/Security-/A11Y-Acceptance; T144 ff. revalidieren Plan, Fleet, Authority, Provider und Budget vor jedem Resume-/Write-Grenzpunkt.
- **Re-evaluation / Neubewertung**: Bei No-op-Semantik, State-Transition, Idempotency-Key, Providerklassifikation, Budget, Plattform oder Resume-Policy.

## US2 Serielle Profilwellen / Serialized Profile Waves

- **Applicability / Anwendbarkeit**: `Applicable` für SBR-007, SBR-008 und SBR-010.
- **Implementation status / Umsetzungsstatus**: `Passed for deterministic local coordinator; live fleet delivery remains pending`.
- **Owner / Reviewer**: Fleet Delivery Owner / Concurrency and Profile Reviewer.
- **Evidence / Nachweis**: `WaveOrderTests` erzwingt Public Canaries `agent-operations-cockpit`, `home-baseline`, `tui-vision`, danach Public Products, Private Products, Private Governance/Scaffold und Public Presets. Innerhalb jeder Welle sind stable IDs lexikografisch und `maximum_active_writers=1`; der erste Blocker startet kein späteres Ziel. `ProfileContractTests` bindet alle fünf Profilverträge.
- **Serialized writers / Serialisierte Writer**: Providerwrites, Zieltransaktionen, Wellenresultate, Budgetprojektionen, Shared Evidence, Run State, Dokumentationsimpact, Statistik und Agent Guidance bleiben strikt seriell. Nur fixture-/schema-getrennte `[P]`-Aufgaben sind parallelisierbar; dieser Lauf verwendet keine parallelen Writer.
- **Residual risk / Restrisiko**: Die dynamische Live-Menge und aktuelle Zielzustände können die geplante Reihenfolge verändern; sie werden vor T141 neu fixiert, nicht heuristisch ergänzt.
- **Follow-up / Folgemaßnahme**: T145–T156 liefern jede Zieltransaktion einzeln und publizieren Wellen-/Budgetresultate erst nach vollständiger Konvergenz.
- **Re-evaluation / Neubewertung**: Bei Canary-, Profil-, Wellen-, Sortier-, Writer-, Budget- oder Stop-Gate-Änderung.

## US5 Budget, Terminal Evidence und Isolation / Budget, Terminal Evidence, and Isolation

- **Applicability / Anwendbarkeit**: `Applicable` für SBR-019, SBR-021, SBR-022 und SBR-024; SBR-023 bleibt ein getrennt autorisierbarer Sequencing-Follow-up.
- **Implementation status / Umsetzungsstatus**: `Passed for deterministic local fixtures; terminal live evidence pending`.
- **Owner / Reviewer**: Budget and Evidence Owner / Governance Reviewer.
- **Evidence / Nachweis**: `BudgetProjectionTests` verwendet Decimal ohne frühe Rundung, `52/12`, Budget `3000` und strikt `<500`; Missing ist nicht null und Copilot-Kategorien bleiben getrennt. `TerminalFleetEvidenceTests` verlangt exakte ID-/Count-Gleichheit, fünf Wellen/Budgets und direkte Planbindungen. `G4IsolationTests` blockiert jede G4-/Series-/Copilot-/Account-/Subscription-Drift und führt keine Folgeaktion aus.
- **Residual risk / Restrisiko**: Live-Billing- und Providerdaten stehen noch aus; Fixture-Pass ist keine Budget- oder Terminalbehauptung für die echte Flotte.
- **Follow-up / Folgemaßnahme**: T148/T150/T152/T154/T156 erzeugen frische Live-Projektionen; T164–T166 schließen terminale Evidence und Isolation. Der Sequencing-Follow-up benötigt später eigene Autorität.
- **Re-evaluation / Neubewertung**: Bei Wellenzahl, Billingfrische, Budgetgrenze, Copilot-Kategorien, Fleet-ID, Terminalschema, Isolation oder Sequencing-Autorität.

## T112 Resume-Checkpoint / Resume Checkpoint

- **Status**: `Completed`; T001–T112 sind abgeschlossen, T113 wurde nicht gestartet.
- **Checklist counts / Checklist-Zählung**: `clarifications.md` 0/0, `cross-platform.md` 0/0, `governance.md` 40/40, `implementation-governance.md` 0/0, `plan-review.md` 8/8, `requirements.md` 30/30 und `stage-b-mutation-allowlist.md` 0/0 abgeschlossen/offen. Thorstens ausdrückliche Proceed-Antwort galt ausschließlich für den begrenzten T112-Pfad; spätere semantische Implementierungscheckpoints bleiben offen.
- **Analyze and local gates / Analyze und lokale Gates**: `analyze-resume-t112` ist am vorherigen Tasks-Hash `58cb1da8...` `Completed`. Secret Scan meldete `high=0`; exaktes Delivery Set, sauberer Index, `git diff --check`, Workflowvertrag, PowerShell-Payloadhash, vier `PlatformParityTests` und PowerShell-Parser bestanden.
- **Checkpoint / Checkpoint**: Genau ein Commit `0d5144c9aa12fc069dd2dfbff6e6d247da0d30fc` mit Marker `[stage-b-windows-proof]` wurde non-forced auf `origin/030-stage-b-rollout` gepusht. Der Remote-Feature-Head entspricht diesem Commit; `origin/main` blieb `9b3a10a4d0c745c9a538cac6eff44532984f144a`.
- **Native Windows evidence / Nativer Windows-Nachweis**: Workflow `Stage B Windows Proof` (Workflow-ID `339958112`, Run `32567141555`, Run-URL `https://github.com/hindermath/home-baseline/actions/runs/32567141555`) führte Job `Native Windows PowerShell 7 proof` (Job-ID `97017306468`, Job-URL `https://github.com/hindermath/home-baseline/actions/runs/32567141555/job/97017306468`) auf `windows-2022` / Microsoft Windows Server 2022 aus. PowerShell `7.6.5` führte `pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -StageBAction Preflight -WhatIf` mit Exitcode `0` aus; Payload `1b7a4602d2d4c7d20cc85573a1ac33ddec5ac65e31f744a508ec8a61598741c3` und Entscheidung `70d4e65f1b8e5ab3d167c57f48346a01a41b24e5e1b826910cc0e991ce484897` stimmen exakt.
- **Zero-write boundary / Nullschreibgrenze**: Der Proof meldet `gitWrites=0` und `providerWrites=0`; es gab keinen PR, Merge, Home-Sync, Ruleset- oder Fleetwrite und keinen Admin-Bypass.
- **Owner / Reviewer**: Windows Platform Owner / Cross-Platform Reviewer.
- **Safe boundary / Sichere Grenze**: Das lokale Windows-Record und die T112-Buchungen bleiben ungestaged. Es gibt keinen zweiten Commit oder Push; T113 darf erst in einer späteren ausdrücklich gerouteten Fortsetzung starten. `.specify/runtime/` bleibt immer ungestaged.

## T112 GitHub-Actions-Ausweg / GitHub Actions Route

- **Authority / Autoritaet**: Thorsten genehmigte am 22. August 2026 ausdruecklich den vorgeschlagenen nativen `windows-2022`-Nachweispfad einschließlich des dafuer erforderlichen vorgezogenen Feature-Branch-Checkpoint-Commits und Pushs. `MergeAndSync` und der eng begrenzte Admin-Bypass bleiben aktuell; weder PR noch Merge sind an dieser Grenze erlaubt.
- **Mandatory-rule delta / Pflichtregel-Delta**: Die installierte Autonomous-Run-Governance v0.4.1 war bereits im akzeptierten Plan und T007 gebunden. Der Resume-Audit findet deshalb keinen fehlenden neuen Pflichtvertrag. Die einzige inhaltliche Aenderung ist der explizit genehmigte Windows-Runner-Nachweispfad; Spec-Scope, Acceptance, Security, Review, Gate-Evidence 2.0 und kausaler Closeout bleiben unveraendert.
- **Amendment / Anpassung**: `plan.md`, T112 und `checklists/cross-platform.md` erlauben genau einen nicht mergefaehigen Validierungs-Checkpoint mit einem auf `030-stage-b-rollout`, fuenf gebundene Pfade und den Commitmarker `[stage-b-windows-proof]` beschraenkten Push-Workflow, `contents: read`, `windows-2022`, `-WhatIf`, exakter Payload-/Entscheidungshashpruefung und unveraenderlicher Run-/Job-Bindung. Der Push-Trigger vermeidet die Default-Branch-Voraussetzung eines erstmalig angelegten `workflow_dispatch`-Workflows.
- **Required rerun / Erforderliche Wiederholung**: Vor Workflowimplementierung und Remoteaktion muss ein frischer `$speckit-analyze specs/030-stage-b-rollout` ohne Critical-/High-/ungeloeste Medium-Findings abgeschlossen und hashgebunden werden. Danach gelten Delivery-Set-, Secret-, Index- und Branch-Head-Pruefung erneut.
- **Proof boundary / Nachweisgrenze**: Nur ein erfolgreicher nativer Windows-Job am exakten Checkpoint-Commit schließt T112. Genehmigung, Workflowname oder ein macOS-PowerShell-Lauf allein bleiben unzureichend.
- **Executed proof / Ausgeführter Nachweis**: Diese Grenze wurde durch Run `32567141555` und Job `97017306468` am Commit `0d5144c9aa12fc069dd2dfbff6e6d247da0d30fc` erfüllt. Die maschinenlokale Evidence bindet Workflow-/Run-/Job-Metadaten, URLs, Runner, Befehl, PowerShell-Version, Exitcode, beide Hashes und die Nullschreibwerte.

## Wiederverwendbares macOS-first-Lernen / Reusable macOS-First Learning

- **User decision / Nutzerentscheidung**: Thorsten hat am 22. August 2026 ausdrücklich verlangt, den erfolgreichen Windows-Nachweis sowie den Linux-Nachweispfad für weitere plattformübergreifende Prüfungen dauerhaft zu übernehmen, weil die Entwicklung primär auf macOS erfolgt.
- **Binding pattern / Bindendes Muster**: macOS wird lokal zuerst im Safe Mode geprüft. Fehlt ein eigener Zielhost, liefert Linux den nativen Token über einen isolierten Container oder einen minimal berechtigten Linux-CI-Job; Windows liefert ihn über einen minimal berechtigten nativen Windows-CI-Job. Evidence bindet Commit, Befehl, Runner/Plattform, Exitcode, Payload- und Entscheidungshash sowie Nullschreibwerte.
- **Proof limit / Nachweisgrenze**: Ein eng begrenzter Preflight beweist nur diesen Befehl und ersetzt weder vollständige Regressionen noch Security-, A11Y-, Review- oder Merge-Gates. Der fehlgeschlagene allgemeine Windows-Regressionslauf `32567141523` bleibt deshalb trotz erfolgreichem T112-Proof als T124-Eingabe offen.
- **Propagation / Verteilung**: T121 überführt das agentenneutrale Muster atomar in alle gemeinsamen Agent-Guidance- und betroffenen Template-Flächen. Änderungen an Trigger, Pfaden, Permissions, Payload, Runner oder Zielplattform erzwingen Re-Evaluation.

## T120–T123 lokale Abschlussnachweise / Local Completion Evidence

- **T120 Documentation Impact**: Genau ein Feature-Eintrag bleibt
  `UpdateRequired`. `validate-documentation-impact.sh` meldet einen aktuellen
  Eintrag; der Feature-021-Migrationsvalidator meldet 16 Sektionen, vier
  Leserpfade und 17 verlinkte Dateien. Beide Exitcodes sind `0`. Der README-
  Link nutzt den tatsächlich berechneten Manpage-Anchor; `README.en.md` führt
  denselben sicheren Leserpfad.
- **T121 Shared Guidance**: Constitution `1.21.0` und
  `.specify/memory/constitution.md` sind bytegleich. Alle fünf Agentflächen,
  kanonischen `.specify/templates/`-Flächen und Runtime-Agenttemplates tragen
  macOS-first, isoliertes natives Linux, eng begrenztes natives Windows-CI,
  exakte Commit-/Command-/Runner-/Exitcode-/Payload-/Decision-/Zero-Write-
  Bindung und die Teilnachweisgrenze. Agent-Surface-Parität: Exitcode `0`.
- **T122 canonical statistics**: Nur
  `docs/project-statistics.config.json` erhielt Slot `67`, Methodik `2`,
  `9851` Nettozeilen vor Statistikpflege, einen sichtbaren Git-Aktivtag und
  unveränderte Referenzen `80/100`.
- **T123 generated statistics**: Der unveränderte Renderer verweigerte den
  schreibenden Dirty-Tree-Modus sicher. Sein `--dry-run`-Output wurde deshalb
  ausschließlich zwischen den Generated-Markern mechanisch übernommen;
  `--check-only` meldet `CURRENT` bei Exitcode `0`. Die PowerShell-
  Statistikfixtures bestehen mit 146 Assertions. Bash und PowerShell melden
  im Safe Mode jeweils 30/30 Homogenitätschecks und Exitcode `0`.
- **Proof boundary / Nachweisgrenze**: Diese Evidence schließt nur T113–T123.
  Sie behauptet weder die T124-Vollregression noch AC-SBR-009, Live-Delivery,
  Home-Sync oder terminalen Closeout.

## T124 Windows-Regressionskonvergenz / Windows Regression Convergence

- **Native diagnostic evidence / Nativer Diagnosenachweis**: Commit `6157f31`,
  Run `32576605400`, Job `97039763606` belegte zwei Windows-`fsync`-Fehler und
  zwei Adapterfehler. Commit `db3af89`, Run `32577264130`, Job `97041302454`
  bestätigte den reparierten Flush und präzisierte die Restgrenzen auf fehlende
  owner-only-Semantik von Windows-`chmod 0600` sowie den WSL- statt
  Git-for-Windows-Bash-Resolver. Beide Runs bestanden macOS 14 und Ubuntu 22.04;
  ihre Windows-Wrapperstufen waren grün.
- **Third native diagnostic / Dritter nativer Diagnosenachweis**: Commit
  `cd67b58`, Run `32578308644`, Job `97043808631` bestand Build, TUI und den
  Windows-Wrapper. Die vollständige Regression führte 225 Tests aus und fand
  genau einen Fehler: Der neue ACL-Assertionstest erwartete den Dateipfad in
  PowerShell `$args[0]`, obwohl `pwsh -Command` ihn in dieser Aufrufform nicht
  bereitstellte. Dokumentation, PowerShell-Analyse, Homogenität sowie die
  vollständigen macOS-14- und Ubuntu-22.04-Jobs desselben Commits waren grün.
- **Fourth native diagnostic / Vierter nativer Diagnosenachweis**: Commit
  `cf6daa2`, Run `32582382241`, Job `97053599384` bestand erneut Build, TUI,
  Windows-Wrapper und 224 von 225 Tests. Die nun ausführbare ACL-Assertion
  belegte, dass `/inheritancelevel:r` zwar Vererbung entfernt, aber explizite
  Regeln für `OWNER RIGHTS` (`S-1-3-4`), `Administrators` (`S-1-5-32-544`) und
  `SYSTEM` (`S-1-5-18`) beibehielt. Dokumentation, PowerShell-Analyse,
  Homogenität, macOS 14 und Ubuntu 22.04 waren am selben Head vollständig grün.
- **Fail-closed repair / Geschlossene Reparatur**: Die vollständige temporäre
  Evidence erhält vor `os.replace` eine neu aufgebaute vererbungsfreie DACL:
  alle vorhandenen Access Rules werden aus dem ACL-Objekt entfernt und genau
  eine `Modify`-/`Allow`-Regel für die validierte aktuelle Windows-SID ergänzt.
  Pfad und SID werden ausschließlich über Prozess-Umgebungsvariablen an
  PowerShell übergeben. Identitäts- oder ACL-Fehler brechen vor Veröffentlichung
  ab und erhalten die letzte gültige Evidence. Native
  Adaptertests lösen Git-for-Windows-Bash über den Git-Installationspfad auf
  und können nicht mehr versehentlich den WSL-Launcher akzeptieren.
- **Local evidence / Lokaler Nachweis**: 56 Stage-B-, 39 CI-Budget-, 30
  Workspace-Maintenance- und 22 Maintenance-Contract-Tests sowie Bash-Syntax,
  PowerShell-Parser/PSScriptAnalyzer und Secret Scan bestehen. Negativtests
  belegen DACL-Befehlsbindung und Erhalt der vorherigen Evidence bei ACL-Fehler.
  Nach Run `32578308644` übergibt der native ACL-Test den Pfad explizit über
  `STAGE_B_EVIDENCE_PATH`; 56 Stage-B- und alle 225 lokalen Regressionen
  bestehen erneut. Nach Run `32582382241` besteht auch der exakte DACL-Neuaufbau
  mit geschützter Vererbung, vollständiger Entfernung vorhandener Access Rules
  und genau einer aktuellen SID-Regel dieselben 56 Stage-B- und 225 lokalen
  Regressionen.
- **Fifth native proof / Fünfter nativer Nachweis**: Der exakte Head
  `8ae4ef289d8dd42080a0b69ea374bde2881f6fb2` bestand im Workflow
  `Maintenance TUI`, Run `32587448948`, Windows-Job `97065888986` auf
  `windows-2022` mit PowerShell `7.6.5` den Befehl `python -m unittest
  discover -s scripts/tests -p 'test_*.py'`: 225 Tests, Exitcode `0`, 44
  Skips und keine Restricted-Ausgabe. Die macOS- und Ubuntu-Jobs desselben
  Heads bestanden ebenfalls. Dokumentationsprüfung, PowerShell-Analyse und
  Homogenitätsprüfung waren am selben Head grün; das Workflow-Token besaß nur
  `contents: read` und `metadata: read`.
- **Closed gate / Geschlossenes Gate**: T124 ist bestanden. Die fünfte
  Commit-/Push-Autorität ist verbraucht und verleiht keine weitere
  Remote-Autorität. T125 darf lokal mit dem exakt vorgegebenen Befehl starten;
  PR, Merge, Home-Sync, Fleetwrite und Admin-Bypass bleiben ausgeschlossen.

## T125 AC-SBR-009-Plattformakzeptanz / Platform Acceptance

- **Command / Befehl**: `python3 scripts/tests/run_stage_b_rollout_acceptance.py
  --gate AC-SBR-009 --repository-root . --evidence-root
  .specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1`.
- **Result / Ergebnis**: Exitcode `0`; vier `PlatformParityTests` bestanden.
  Der Primary-Snapshot `primary/AC-SBR-009.json` bindet den vollständigen Head
  `8ae4ef289d8dd42080a0b69ea374bde2881f6fb2`, Requirements-Hash
  `79b516fa726f3289cf2a29b77c81f75b95ae34277bce17fc760fb25926a24626`
  und exakt `macOS,Linux,Windows`.
- **Boundary / Grenze**: Der Snapshot schließt AC-SBR-009 lokal. Er erzeugt
  keine Remote-, Provider-, Fleet-, Merge-, Home-Sync- oder Bypass-Autorität;
  die übrigen elf Primary-Gates bleiben ihren späteren Aufgaben zugeordnet.

## T126 Bidirektionale Traceability / Bidirectional Traceability

- **Implementation status / Umsetzungsstatus**: `Passed`.
- **Scope / Umfang**: Ein frischer getrennter Read-only-Review bestätigte
  194/194 Aufgaben, 24/24 SBR, 13/13 CR, 12/12 AC und alle 43
  SBR-zu-AC-Beziehungen. Alle zwölf exakten Acceptance-Befehle stimmen mit
  `autonomous-run-gate-requirements.json` überein.
- **Checklist evidence / Checklistenbeleg**: Governance 40/40, Plan Review
  8/8 und Requirements 30/30; semantische Checklisten ohne Checkboxformat
  besitzen keine `Open`-Ablage. Run-State- und Documentation-Impact-Validator
  sowie `git diff --check` bestanden.
- **Delivery boundary / Liefergrenze**: T127–T194 bleiben offen,
  `authorityRevalidationRequired=true` und der ExternalWriteGate bleibt
  geschlossen. Der Review führte keinen Providerzugriff, Commit oder Push aus.

## T141 Resume-Analyse und Vertragsremediation / Resume Analysis and Contract Remediation

- **Analyze result / Analyseergebnis**: `Completed`. Der erste geroutete
  Analyze-Lauf fand vor Implementierung eine Critical- und vier High-Lücken:
  fehlende Bedienungsgrenze, vermischte Remediation/Lieferung/Live-Ausführung,
  keine Pending-Authority, unklare Mehrdateipublikation und fehlende
  AC-SBR-001-Live-Plan-Bindung. Nach der Vertragskorrektur bestand der zweite
  strikt read-only Analyze-Lauf mit Result-Hash
  `134da6569fcea065c07e0d37b21551058ddf984e63563ca831169f4e74e3fcef`.
- **Contract repair / Vertragskorrektur**: Plan und Tasks trennen T141-R,
  T141-D und T141-L strikt. Der Snapshot bleibt im Speicher; Plan wird zuerst
  atomar publiziert, State danach als hashbindender Commit-Marker. Schema und
  Datenmodell unterscheiden `Pending` von `Authorized`; Pending hält Gate
  geschlossen, Bypass nicht autorisiert und Autoritätsquelle/-zeiten auf
  `N/A`. Quickstart, Manpage und beide Wrapper-Hilfen dokumentieren Preview,
  lokale Publikation sowie frische T144-Authority.
- **Current boundary / Aktuelle Grenze**: Nur T141-R ist unter der aktuellen
  `LocalImplementation`-Authority ausführbar. T141-D benötigt eine neue
  ausdrückliche `MergeAndSync`-Freigabe; T141-L folgt erst vom sauberen,
  synchronisierten Default-Head. T141-R ist lokal bestanden; die fehlende
  T141-D-Authority blockiert jetzt jede Git-/Provider-/Home-Lieferaktion.
- **Independent correction / Unabhängige Korrektur**: Der erste T141-R-Diff
  ließ `observedAt` über `sourceRevision` und `fleetSnapshotHash` in den
  semantischen Planhash einfließen. Die unabhängige Prüfung entfernte
  Beobachtungszeiten aus diesen drei Hashpayloads und ergänzte einen Test, der
  bei abweichenden Erfassungszeiten identische `inputSetHash`-, Snapshot- und
  Planhashes verlangt.
- **Provider completeness / Providervollständigkeit**: Workflow- und
  Ruleset-Reads fordern die maximale 100er-Seite explizit an. Workflow-
  `total_count` muss der gelesenen Menge entsprechen; 100 Ruleset-Summaries
  blockieren als potenziell unvollständige Paginierung. Damit entsteht aus
  einer still abgeschnittenen Providerantwort kein doppelter Create-Plan.

## T141-R lokale Remediation / Local Remediation

- **Implementation status / Umsetzungsstatus**: `Passed` ausschließlich für
  T141-R. Der produktive `Preflight`-CLI-Pfad lädt das vollständige
  read-only Fleet-/Providerinventar, ruft `StageBFleetPreflight` und danach
  `StageBRolloutPlanner` auf und zeigt in der Vorschau den vollständigen Plan.
  Der Testadapter ist ausschließlich in explizitem Testmodus und nur für
  Preview zulässig; er kann weder Plan noch State publizieren.
- **Publication boundary / Publikationsgrenze**: Plan und vorbereiteter State
  werden vorab gegen Runtime-Schema und Semantik validiert. Der Plan wird
  zuerst atomar ersetzt, der hashbindende State danach als Commit-Marker. Die
  Failure-Injection-Nachweise belegen null Artefakte vor der Plangrenze, einen
  nicht autoritativen und sicher ersetzbaren Orphan-Plan vor der State-Grenze
  sowie fail-closed State ohne vorhandenen passenden Plan.
- **Authority and acceptance / Authority und Abnahme**: Vorbereitete Authority
  ist exakt `Pending`, Quelle/Autorisierungs-/Validierungszeit sind `N/A`, das
  ExternalWriteGate ist `Closed` und Admin-Bypass `NotAuthorized`. Jede externe
  Schreibgrenze verlangt zusätzlich `status=Authorized`. AC-SBR-001 lädt den
  tatsächlich publizierten Plan, prüft Schema und kanonischen Planhash, bindet
  Pfad plus normalisierten Dateihash und revalidiert dynamische Fleet-Gleichheit
  sowie G3 live; Fixture-only-Evidence wird abgewiesen.
- **Local evidence / Lokaler Nachweis**: 68 Stage-B-Tests und die vollständige
  lokale Suite mit 237 Tests und 12 erwarteten Skips bestanden; darin bleiben
  die getrennten CI-Budget- und Maintenance-Contract-Scopes grün. Bash-Syntax, PowerShell-Parser,
  PSScriptAnalyzer `1.25.0` über 173 Dateien, `git diff --check` und Secret Scan
  bestanden; Gitleaks meldete null Secrets im aktuellen Diff und null High-
  Findings. Dokumentationsimpact bleibt genau `UpdateRequired`: Bash-/
  PowerShell-Hilfe, Manpage und Quickstart beschreiben vollständigen Preview,
  Nullschreibgrenze, lokale Publikation und Pending-Authority. Owner ist der
  Fleet Delivery Owner; Leserpfade sind CLI-Hilfe → Manpage → Quickstart;
  `scripts/` bleibt `homeRuntime`, Design/Governance `sourceOnly`, Run-State
  `machineLocal`. Home-Sync wird erst nach separater Lieferung und erneuter
  Authority bewertet.
- **Hard boundary / Harte Grenze**: Kein echter Stage-B-Preflight, kein
  AC-SBR-001-Live-Gate, Commit, Push, PR, Merge, Home-Sync, Fleet-/Providerwrite
  und kein Bypass wurden ausgeführt. T141 bleibt offen; T141-D, T141-L und T142
  bleiben streng nachgelagert. Re-Evaluation ist bei CLI-, Provider-, Schema-,
  Hash-, Plan-/State-, Authority- oder Publikationsgrenzendrift Pflicht.

## T141-D Resume-Audit und Lieferfreigabe / Resume Audit and Delivery Authority

- **Fresh authority / Frische Autorität**: Thorsten genehmigte T141-D
  ausdrücklich im `MergeAndSync`-Modus für Branch, Commit, Push, regulären PR,
  Gates, Review, Merge und Default-Branch-Sync. Die Freigabe umfasst weder
  T141-L noch Home-Sync, Fleet-/Providerwrites oder Admin-Bypass.
- **Revalidation / Revalidierung**: `main` und `origin/main` zeigen beide auf
  `0203102102b709ab37f5599b852c7978d595e368`. Der autonome Run-State, das
  ausgewählte Stage-B-Intake-Review (`Ready`), die fünf akzeptierten
  Artefakthashes, der geroutete Implementierungsresult-Hash, das Aufgaben-Payload
  und das `Aligned`-Modellrouting wurden erneut geprüft. Weder lokaler noch
  entfernter Lieferbranch oder PR existierten beim Audit.
- **Exact delivery set / Exakter Lieferumfang**: Die Lieferung enthält genau
  die bereits validierten 14 T141-R-Pfade: beide Workspace-Wrapper, Fleet-
  Bibliothek, beide Stage-B-Schemas, beide Stage-B-Testdateien, Manpage,
  Run-State, Governance-Checkliste, Datenmodell, Plan, Quickstart und Tasks.
  Beim Audit waren keine Dateien gestaged oder untracked.
- **Drift disposition / Driftbewertung**: Der Intake-Authoring-Receipt erkennt
  erwartete historische Source-Drift, weil Feature 030 die referenzierte
  Architekturdatei nach der Intake-Erstellung weiterentwickelt hat; Ziel und
  akzeptierter Target-Hash sind unverändert. Der globale Requirements-Validator
  meldet separat den bereits archivierten Feature-029-Originalnamen in RIG014.
  Beide Befunde verändern das ausgewählte Stage-B-Intake nicht und werden ohne
  sachfremde Intake-Reparatur als nicht scope-verändernd behandelt.
- **Fail-closed boundary / Fail-Closed-Grenze**: Nur der reguläre Lieferpfad
  darf jetzt fortgesetzt werden. Ein Schutzregel- oder Review-Blocker wird nicht
  mit Bypass umgangen; T141-L beginnt erst nach abgeschlossener Lieferung von
  einem sauberen, synchronisierten Default-Branch.
- **Delivery branch / Lieferbranch**: Der lokale Branch
  `codex/stage-b-954ff259-t141-r` wurde direkt aus dem synchronisierten
  `main`-Head erstellt. Der Branch war zuvor weder lokal noch remote vorhanden;
  zu diesem Zeitpunkt existierte weiterhin kein PR.
- **Commit, push and PR / Commit, Push und PR**: Der validierte 14-Pfad-Payload
  wurde als `b664b604bed9a648f5f47c788ceace2dc07b4723` committed. Der Pre-Push-Hook
  bestätigte null Secrets; der Branch wurde zu `origin` gepusht und der
  reguläre PR `#252` gegen `main` eröffnet. GitHub verlangt eine Approval und
  hat gemäß aktivem Ruleset die automatische Copilot-Code-Review gestartet.
- **Generated statistics update / Generiertes Statistikupdate**: Der erste
  native Windows-Homogenitätsjob `97188340137` im Run `32637074208` erreichte
  die Plattformprüfung, scheiterte aber erwartungsgemäß an Profil-2-Drift, weil
  der neue T141-R-Commit die sichtbare Git-Historie erweitert. Das ist kein
  funktionaler Preflight-Fehler, sondern ein verpflichtendes `GeneratedUpdate`
  aus der unveränderten kanonischen Statistikquelle. Der deterministisch
  gerenderte Pfad `docs/project-statistics.md` ist daher der einzige zulässige
  zusätzliche Lieferpfad; Slot 67 bleibt bis T169 fachlich unverändert.

## T141–T171 Live-Flottenabschluss / Live Fleet Completion

- **Plan and authority / Plan und Autorität**: Der nach T153-R6 frisch
  erzeugte Plan `a1ff9f53-bd45-5d5c-babc-eb602d21d1c2` ist an Planhash
  `adbcb81091443fe10f283211b1d13e0572feb57cfd1e42816ba7e1e894343ce5`
  und Fleet-Snapshot
  `ad8993784edeb6115b1840bda520140e102dbc651a9d850d98ab07dbad0a8a89`
  gebunden. Die verbrauchte Live-Authority umfasste exakt seine 48 Ziele;
  G4 blieb ausgeschlossen.
- **Serialized outcome / Serialisiertes Ergebnis**: Fünf Wellen wurden in
  stabiler Reihenfolge geschlossen. 28 Ziele waren semantisch
  `NoOpConverged`; 20 Private-Governance-Ziele erhielten exakt den
  Minimal-Workflow über reguläre PRs und danach ein aktives Default-Branch-
  Ruleset mit einem Status, einer Approval, strict checks und null
  Bypass-Akteuren. Jeder lokale/entfernte Default-Head ist synchron.
- **Provider truth / Provider-Wahrheit**: Die privaten GitHub-Actions-Läufe
  wurden vor Payloadausführung durch das bekannte Billing-/Quota-Limit
  abgelehnt und deshalb als `BillingOrQuotaRefusal`, niemals als technischer
  Pass, erfasst. Der bytegleiche Workflow besitzt zusätzlich nativen
  öffentlichen Linux-Nachweis. Ein Aufstocken des Kontingents gehört nicht
  zum Featureumfang.
- **Terminal evidence / Terminale Evidence**: FleetTerminalEvidence v1.1
  bindet 48/48 konvergierte Repositoryresultate, fünf Wellen, fünf
  Budgetprojektionen, null Restricted-Treffer und den synchronisierten
  Level-0-Merge `b20086224227b069c7763e52b0f8f966fcfa24e5`. AC-SBR-001 bis
  AC-SBR-012 wurden frisch am selben operativen Head ausgeführt und als genau
  zwölf Primary-Zeilen validiert.
- **Versioned boundary / Versionierte Grenze**: T168 wählte nur redigierte,
  schema-validierte source-only Evidence. T169/T170 ergänzten den realen
  Statistikslot 68 mit 1.315 Nettozeilen; Renderer und 146 Assertions sind
  grün. Die T171-Allowlist trennt den jetzt folgenden regulären Closeout
  vollständig vom späteren kausalen Governance-/Evidence-Commit.
- **Residual risk and reevaluation / Restrisiko und Neubewertung**: Bis T190
  können PR-Head, Checks, Review, Schutzregeln und Home-Sync-Trigger driften;
  jede Grenze wird frisch revalidiert. Nach T190 sind alle Writer verboten,
  und T191–T194 dürfen nur maschinenlokale Runtime-Evidence schreiben.
