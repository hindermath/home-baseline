# Stage-B-Mutations-Allowlist / Stage B Mutation Allowlist

**Applicability / Anwendbarkeit**: `Applicable`
**Implementation status / Umsetzungsstatus**: `T171 final allowlist frozen; regular and causal sets separated`
**Owner / Owner**: Fleet Delivery Owner
**Reviewer / Reviewer**: Security and Delivery-Set Reviewer

## Grundgrenze / Baseline Boundary

- Level-0-Änderungen sind auf die in `tasks.md` benannten Implementierungs-,
  Test-, Fixture-, Template-, Dokumentations-, Statistik- und Feature-Evidence-
  Pfade begrenzt. / Level-0 changes are limited to the implementation, test,
  fixture, template, documentation, statistics, and feature-evidence paths
  named in `tasks.md`.
- Maschinenlokale Evidence unter `.specify/runtime/` bleibt ignoriert und darf
  nie gestaged werden. / Machine-local evidence remains ignored and must never
  be staged.
- Zielrepositorywriter sind ausschließlich die serialisierten T145–T156-
  Transaktionen nach Level-0-Merge und frischem ExternalWriteGate. / Target
  repository writers are only the serialized T145–T156 transactions after
  Level-0 merge and a fresh ExternalWriteGate.
- Providerwriter sind auf gebundene Branch-/PR-/Merge-/Ruleset-Aktionen mit
  sicheren Argumentarrays beschränkt. / Provider writers are limited to bound
  branch, PR, merge, and ruleset actions using safe argument arrays.
- Der reguläre Closeout enthält alle bis T171 belegten Feature-, Fleet-,
  Security-, Architektur-/iSAQB-, A11Y-, Cross-Platform-, Agent-Parity-,
  Dokumentations-, Statistik-, Checklisten- und redigierten Evidence-Pfade
  einschließlich der wahrheitsgemäßen State-/Dokumentationsimpact-
  Zwischenstände. / The regular closeout contains every feature, fleet,
  security, architecture/iSAQB, A11Y, cross-platform, agent-parity,
  documentation, statistics, checklist, and redacted evidence path proven by
  T171, including truthful state and documentation-impact intermediate states.
- Nach dem regulären Merge darf genau ein kausaler Delta entstehen: die vier
  vorbenannten Governance-/Evidence-Pfade plus der inhaltsgleiche
  Lastenheft-Rename. Produkt-, Runtime-, Workflow-, Ruleset-, Budgetmodell-
  und Zielrepositoryänderungen sind dafür ausgeschlossen. / After the regular
  merge, exactly one causal delta may exist: the four predeclared governance
  and evidence paths plus the content-identical intake rename. Product,
  runtime, workflow, ruleset, budget-model, and target-repository changes are
  excluded from it.

## Exakte Level-0-Allowlist / Exact Level-0 Allowlist

| Writer class | Allowed repository-relative paths | Task boundary |
|---|---|---|
| Accepted feature metadata and inputs | `.specify/feature.json`; `specs/030-stage-b-rollout/`; `specs/flottenweite-ci-budget-governance-stage-b-rollout-intake-review/`; `specs/intake-authoring-receipts/flottenweite-ci-budget-governance-stage-b-rollout.json` | T001–T010, T168–T190 |
| Runtime control plane | `scripts/lib/agentic_workspace_fleet.py`; `scripts/maintain-agentic-workspace.sh`; `scripts/maintain-agentic-workspace.ps1` | T019–T024, T031–T036, T043–T053, T062–T067, T075–T081, T088–T093, T100–T105 |
| Installed Stage-B contracts | `scripts/config/stage-b-rollout-plan.schema.json`; `scripts/config/stage-b-run-state.schema.json`; `scripts/config/repository-rollout-result.schema.json`; `scripts/config/fleet-terminal-evidence.schema.json`; `scripts/config/stage-b-ruleset-plan.schema.json` | T011–T015 |
| Test and acceptance harness | `scripts/tests/test_stage_b_rollout.py`; `scripts/tests/run_stage_b_rollout_acceptance.py`; `scripts/tests/stage-b-rollout/fixtures/` | T016–T018, T026–T030, T037–T042, T054–T125 |
| Target templates | `scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml`; `scripts/templates/ci-budget-governance/private-governance-ruleset.json` | T025 |
| Validation-only Windows workflow | `.github/workflows/stage-b-windows-proof.yml` only; no other `.github/workflows/` path | T112 only, after the fresh Analyze pass and exact Delivery-Set/Secret/Index checks; exactly one feature-branch checkpoint commit/push with `[stage-b-windows-proof]`, no PR or merge |
| User and operator documentation | `README.md`; `docs/scripts/reference.md`; existing affected files below `docs/scripts/`; `docs/man/maintain-agentic-workspace.1.md`; `specs/030-stage-b-rollout/quickstart.md`; `docs/accessibility/ci-budget-governance.md` | T104–T110 |
| Security and architecture evidence | `docs/architecture/ci-budget-governance.md`; `docs/security/threat-model.md`; `docs/security/arc42-security.md`; `docs/security/security-quality-scenarios.md`; `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md`; `docs/security/security-checklist.md`; `docs/security/dependency-audit.md`; `docs/security/supply-chain-evidence.md`; `docs/security/zero-trust-applicability.md`; `docs/security/samm-assessment.md`; `docs/security/cloud-autonomy-applicability.md`; `docs/security/cloud-compliance-assurance.md`; `docs/security/asvs-verification.md`; `docs/security/regulatory-applicability.md` | T114–T119 |
| Statistics | `docs/project-statistics.config.json`; generated `docs/project-statistics.md` | T122–T123, T169–T170 |
| Conditional shared guidance | `AGENTS.md`; `CLAUDE.md`; `GEMINI.md`; `.github/copilot-instructions.md`; `.github/agents/copilot-instructions.md`; `constitution.md`; `.specify/memory/constitution.md`; affected `.specify/templates/` and `scripts/templates/` paths | T121 only when the documented shared-semantics trigger fires |
| Regular versioned evidence | redacted files below `specs/030-stage-b-rollout/evidence/v1/`, excluding `stage-b-causal-postmerge.json` until T182; current `specs/030-stage-b-rollout/autonomous-run-state.json`; `specs/030-stage-b-rollout/documentation-impact-evidence.json`; all accepted feature/checklist artifacts | T168–T179 |
| Causal governance-only closeout | `specs/030-stage-b-rollout/evidence/v1/stage-b-causal-postmerge.json`; `specs/030-stage-b-rollout/autonomous-run-state.json`; `specs/030-stage-b-rollout/documentation-impact-evidence.json`; `specs/030-stage-b-rollout/retrospective.md`; deterministic rename from `Lastenheft_Flottenweite-CI-Budget-Governance-Stage-B-Rollout.md` to `Lastenheft_Flottenweite-CI-Budget-Governance-Stage-B-Rollout.030-stage-b-rollout.md` | T181–T190; exactly one helper-created commit |

The unarchived Lastenheft is an accepted immutable input and must remain
unstaged until T186. Its content may not change; only the deterministic rename
is allowed in the causal closeout. / Das unarchivierte Lastenheft bleibt bis
T186 unverändert und ungestaged; im kausalen Closeout ist nur der
deterministische Rename erlaubt.

## Zielrepository- und Provider-Allowlist / Target and Provider Allowlist

- **Read-only providers / Nur Lesen**: authenticated `gh auth status`, bounded
  `gh api --method GET`, `gh pr view`, `gh pr checks`, repository/ruleset/job
  reads and `git ls-remote` for identities already bound by the current fleet
  snapshot.
- **Per-target Git writers / Git-Writer je Ziel**: one isolated run-bound
  worktree/branch, exact planned index, one non-empty commit, idempotent push,
  exactly one matching pull request, regular review, allowed merge method,
  fast-forward default synchronization, and cleanup of only that bound branch.
- **Validation-only provider writer / Nur-Validierung**: T112 darf nach dem
  frischen Analyze-Pass genau den gebundenen Feature-Branch-Checkpoint pushen
  und den auf diesen Branch, die fuenf gebundenen Pfade und den Commitmarker
  `[stage-b-windows-proof]` beschraenkten Push-Workflow am exakten Commit
  starten lassen. Das oeffnet weder PR noch Merge-/Ruleset-/Fleet- oder
  Home-Write und darf keinen anderen Workflowpfad aendern.
- **Full-regression checkpoint writers / Vollregressions-Checkpoints**: Für
  T124 wurden nach nativen Windows-Fehlern fünf jeweils einzeln ausdrücklich
  genehmigte, nicht erzwungene Pushes desselben Feature-Branches ausgeführt.
  Die exakten Checkpoint-Heads `6157f31`, `db3af89`, `cd67b58`, `cf6daa2` und
  `8ae4ef289d8dd42080a0b69ea374bde2881f6fb2` durften ausschließlich die
  vorhandenen Branch-Workflows auslösen. Der letzte Head bestand die
  vollständige Windows-, macOS- und Ubuntu-Regression; kein Checkpoint
  erstellte einen PR, Merge, Ruleset-/Fleetwrite oder Home-Sync. Alle fünf
  Autorisierungen sind verbraucht und begründen keine künftige Remoteaktion.
- **Provider writers / Provider-Writer**: `gh pr create`, regular
  `gh pr merge`, narrowly evidenced `gh pr merge --admin` only after a
  protection-only refusal, and numeric-ID-bound ruleset create/update/restore
  through `gh api --input`. Every write is serialized and reconciled read-only
  before any retry.
- **Target order / Zielreihenfolge**: `agent-operations-cockpit`,
  `home-baseline`, `tui-vision`; then `public-products`, `private-products`,
  `private-governance-scaffold`, `public-presets`, each lexicographically by
  stable repository ID. No target after the first non-recoverable failure may
  start.
- **Evidence writers / Evidence-Writer**: only atomic, redacted, schema-valid
  writes below the bound ignored `operational/` and `primary/` roots; selected
  source-only evidence is copied only at T168 and later closeout boundaries.
- **Home writer / Home-Writer**: only `bash scripts/sync-home.sh --no-pull`
  after its exact preview, conflict check, actual manifest-bound `homeRuntime`
  delta, completed Level-0 merge/default sync, and fresh authority.

## Nulländerungs-Guards / Zero-Change Guards

Die folgenden Flächen sind ausdrücklich verboten und werden vor Delivery und
terminal erneut hashgebunden geprüft: / The following surfaces are explicitly
forbidden and are hash-bound before delivery and at terminal verification:

- `requirements/intakes/series/home-baseline-delivery/manifest.json`;
- G4 start, configuration, review, or artifacts;
- Copilot configuration or reviewer settings;
- account and subscription settings;
- unrestricted Home sync;
- foreign worktree/index changes and machine-local `.specify/runtime/` data.

Additional forbidden writers: force push, foreign branch deletion, empty PR,
parallel target/provider writers, intake creation/review/sequencing mutation,
G4 command, Copilot reviewer/configuration update, account/subscription update,
and any raw provider-response or credential persistence. / Zusätzlich
verboten sind Force-Push, fremde Branchlöschung, leerer PR, parallele Writer,
Intake-/Serienmutation, G4-Befehl, Copilot-/Account-/Subscription-Update und
Persistierung roher Providerantworten oder Zugangsdaten.

**Residual risk / Restrisiko**: Dynamische Flotten- und Providerzustände
können die exakte Pfadmenge ändern. / Dynamic fleet and provider state can
change the exact path set.
**Follow-up / Folgemaßnahme**: T172 und T183 validieren die jetzt eingefrorenen
regulären beziehungsweise kausalen Delivery Sets; nach T190 sind alle Writer
verboten.
**Re-evaluation / Neubewertung**: Bei Scope-, Registry-, Profil-, Aufgaben-,
Authority-, Provider-, Distribution- oder Closeoutdrift.
