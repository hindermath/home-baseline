# Contract: Fleet Evidence and Delivery

## Serial Delivery Set

The accepted delivery set contains exactly seven repositories in this order:

| Order | Repository | Planned feature branch |
|---:|---|---|
| 1 | Home Baseline | existing `032-linked-intake-evidence` |
| 2 | Agent Operations Cockpit | `004-linked-intake-evidence` |
| 3 | TinyPl0 | `007-linked-intake-evidence` |
| 4 | TinyCalc | `006-linked-intake-evidence` |
| 5 | InventarWorkerService | `003-linked-intake-evidence` |
| 6 | TuiVision | `047-linked-intake-evidence` |
| 7 | `absdd-image-sandbox` | `004-linked-intake-evidence`, only after its base gate |

Branch numbers are planning projections derived from current local histories.
They are revalidated against fresh remote and local feature state before branch
creation. A collision or newly reserved number returns to plan review rather
than silently changing the traceability identifier.

## Base Preflight

Before the first mutation in a repository, record:

- registered repository identity and expected origin;
- fresh remote default branch and exact base SHA;
- clean worktree or an explicit stop for unrelated changes;
- required local/central programme gates;
- active intake/review/sequencing hashes;
- no unexpected product/runtime/package scope;
- renderer owner, output owner, documentation class, and statistics baseline.

The preflight never discards, stashes, rebases, resets, or overwrites user work
without separate authority.

For `absdd-image-sandbox`, the current clean
`003-secure-development-container-hardening` branch and its two-commit lead
over cached `origin/main` are preserved. The base gate is unsatisfied until
Feature 003 has a terminal delivery decision and the checkout can start this
feature from a clean, freshly synchronized default branch. No work is stacked
on, rebased from, or cherry-picked implicitly from the observed branch.

## Home PR279 Integration Boundary

The fetched Home default head is
`91e9c7e5919063388dcc22da7616b3dd878acd19`; its already integrated base is
`2d1dc80065817426b97c13eeba8387f653b8cc41`. The incoming set is exactly the
name/status and content delta between those two commits. `HEAD..origin/main`
is not an admissible source because it also describes feature-only paths that
are intentionally absent from `main`.

Before Home final gates and the existing source checkpoint, the Home slot:

1. inventories and hashes all dirty tracked and untracked feature bytes;
2. writes only the three literal `whitespace=-trailing-space` path attributes
   for `resume-analysis-2026-09-08.md`, `resume-reanalysis-2026-09-08.md`, and
   `resume-analysis-2026-09-09.md`, verifies all three raw hashes, and validates
   the complete intended-untracked allowlist, mandatory delivery set, staged
   diff, and secret gate;
3. creates the bounded preservation commit needed for a clean Git integration
   without reset, stash, force, or byte loss;
4. integrates the exact fetched head with ancestry intact and merges the three
   literal attributes with the incoming README/statistics LF rules;
5. reconciles overlaps source-first: `scripts/config/script-catalog.json`
   precedes regeneration of `docs/scripts/reference.md`, while statistics
   source and chronological ledger facts are preserved without manually
   fabricating the current generated profile;
6. preserves the incoming `.gitattributes` LF rules for `README.md`,
   `README.en.md`, and `docs/spec-kit-runs/**`, plus the incoming
   `scripts/config/home-sync-manifest.json` `sourceOnly` classification; and
7. proves every incoming path is represented by ancestry or an explicitly
   source-reconciled final byte set before the normal Home gates.

Only the later clean-checkpoint statistics renderer may claim the final ledger
current. The only permitted whitespace additions are the three literal paths
for `checklists/resume-analysis-2026-09-08.md`,
`checklists/resume-reanalysis-2026-09-08.md`, and
`checklists/resume-analysis-2026-09-09.md`; no wildcard, broad exemption,
cached-check exclusion, or historical byte edit is valid. Their raw SHA-256
values remain respectively
`3688723e515ece9740da349ca918d3160767e26816a04db5e7cdee4dcf254ff7`,
`0d8861b6e6d945b2131a2746e82a21ab2c008339983d854f8e257fa213e2c80b`,
and `7be7d164a2985943b88b7fa2e1e45f3a6600b15746402a686408be51ef11733d`.

## Approved Feature-032 Product Version Exception

The following local files remain read-only for Feature 032 even when a required
`dotnet build` or `dotnet test` runs:

| Repository | Exact file | Dated observed three-field value |
|---|---|---|
| TinyPl0 | `src/Pl0.Ide/Pl0.Ide.csproj` | `1.6.569.80` |
| TinyCalc | `Directory.Build.props` | `1.5.7.26` |
| InventarWorkerService | `Directory.Build.props` | `1.2.8.66` |
| TuiVision | `Directory.Build.props` | `1.46.835.521` |

Each repository base task re-reads all three fields and the local manual build
counter rule. Its scoped adoption evidence binds before/after file hashes,
field values, counter value, executed `dotnet` commands when applicable, and a
zero product/build diff at the final head. The dated values above are planning
observations only. A changed field/counter is a hard stop; branch naming does
not satisfy or evade the proof. The ordinary local versioning rule applies
again outside Feature 032.

## Approved Constitution Preset-Version Corrections

AOC, InventarWorkerService, and `absdd-image-sandbox` may correct only stale
current `autonomous-run-governance` version references in their two local
Constitution mirrors. After a fresh clean-base validation and before the
repository's relevant governance gates, each slot must:

1. compare `scripts/config/spec-kit-governance-presets.json`,
   `.specify/presets/autonomous-run-governance/preset.yml`, `constitution.md`,
   and `.specify/memory/constitution.md` exactly;
2. change both mirrors together only when the current reference is still stale;
3. apply the local Constitution patch-version and amendment-date procedure as
   needed while preserving real principles and historical release statements;
4. review every locally bound agent/template surface atomically, update only a
   corresponding stale current-version reference, and record justified `N/A`
   where the surface already matches; and
5. prove byte-identical mirrors and zero preset-installation, promotion,
   product, runtime, image, or shared-global-guidance change.

Today's observations (AOC current reference v0.3.3;
InventarWorkerService/sandbox v0.3.0; configured and installed v0.4.1) are not
future completion evidence. Drift from that exact approved correction returns
to plan review.

The superseding Home-only reconciliation on 2026-09-10 publishes and installs
`autonomous-run-governance` v0.4.2 so the three immutable historical reports
can be named only by exact repository-relative path plus raw SHA-256. This
changes the comparison source for later AOC, InventarWorkerService and sandbox
slots to v0.4.2, but does not itself install or promote a preset in those
repositories. Their fresh local comparison and narrowly approved Constitution
mirror correction remain mandatory in their respective serial slots.

## AOC Logical Lifecycle Resolution

US2 established that AOC's manifest contains historical logical intake paths
whose current repository files are archived and feature-stamped; META-LH-03
also has a newer lifecycle hash. T079 must discover and hash the exact current
mapping after the local default branch is fast-forwarded. T080 may use only
that unique repository-local mapping to resolve rendering/proof inputs. It may
not guess paths, rename/move intakes, edit canonical lifecycle fields, or treat
the discovery as intake lifecycle authority. Missing or ambiguous resolution
is a hard stop.

## Per-Repository Evidence Record

Each repository records one hash-bound evidence bundle containing:

| Field | Requirement |
|---|---|
| Repository/base | identity, default branch, base SHA, feature branch, head SHA |
| Canonical inputs | manifest/evidence paths and lowercase SHA-256 values |
| Generated outputs | owned paths, candidate/final SHA-256, write count |
| Tests | exact commands, platform/runner, exit codes, log/payload hashes |
| Security | `Applicable`, `N/A` rationale, or `Open` owner/follow-up/trigger |
| Architecture/iSAQB | data-flow decision and quality scenarios |
| Accessibility | text-first and linearization review evidence |
| Cross-platform | native macOS/Linux/Windows decisions where applicable |
| Agent parity | all maintained surfaces updated together or justified `N/A` |
| Dependencies | diff-based zero dependency/package/lockfile proof |
| Product scope | diff-based zero runtime/API/business/image/Compose expansion proof |
| Product version exception | for the four named repositories only: fresh and final `Version`/`AssemblyVersion`/`FileVersion`/manual build-counter values and hashes prove zero diff |
| Constitution correction | for the three named repositories only: configured/installed/mirror comparison, local patch/date record, mirror equality, historical-fact preservation, and dependent-surface update or justified `N/A` |
| Documentation | exactly one impact decision and affected reader paths |
| Statistics | local ledger source change plus deterministic renderer result |
| Distribution | local class and sync decision; Home-only runtime sync when applicable |
| PR lifecycle | PR, review threads, gate results, merge SHA, default verification |
| Rollback | repository-local revert/regeneration procedure and evidence location |

Evidence contains repository-relative paths only. Credentials, local agent
state, browser/session data, absolute home paths, and private logs are excluded.

## Gate Semantics

### Executable local versus terminal global requirements

The installed validator evaluates every gate declared by the supplied
requirements file and has no repository filter. Serial delivery therefore uses
seven separate schema-1.0 local requirement artifacts. The named base task
creates and reviews its artifact against this contract and the unchanged global
`specs/032-linked-intake-evidence/autonomous-run-gate-requirements.json` before
the repository's first feature mutation or gate execution.

| Repository | Preparing/reviewing task | Exact local requirements artifact | Exact Applicable gate IDs |
|---|---|---|---|
| Home Baseline | T067, before attribute/staging/commit work | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/home-baseline-premerge-requirements.json` | `RL-HOME-LOCAL`, `RL-HOME-NATIVE`, `RL-HOME-REVIEW`, `RL-HOME-PRODUCT`, `RL-HOME-GOVERNANCE` |
| Agent Operations Cockpit | T079, before T080 or other AOC mutation | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/agent-operations-cockpit-premerge-requirements.json` | `RL-AOC-LOCAL`, `RL-AOC-NATIVE`, `RL-AOC-REVIEW`, `RL-AOC-PRODUCT`, `RL-AOC-GOVERNANCE` |
| TinyPl0 | T091, before T092 | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/tinypl0-premerge-requirements.json` | `RL-TINYPL0-LOCAL`, `RL-TINYPL0-NATIVE`, `RL-TINYPL0-REVIEW`, `RL-TINYPL0-PRODUCT`, `RL-TINYPL0-GOVERNANCE` |
| TinyCalc | T102, before T103 | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/tinycalc-premerge-requirements.json` | `RL-TINYCALC-LOCAL`, `RL-TINYCALC-NATIVE`, `RL-TINYCALC-REVIEW`, `RL-TINYCALC-PRODUCT`, `RL-TINYCALC-GOVERNANCE` |
| InventarWorkerService | T113, before Constitution or renderer mutation | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/inventar-worker-service-premerge-requirements.json` | `RL-INVENTAR-LOCAL`, `RL-INVENTAR-NATIVE`, `RL-INVENTAR-REVIEW`, `RL-INVENTAR-PRODUCT`, `RL-INVENTAR-GOVERNANCE` |
| TuiVision | T126, before T127 | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/tuivision-premerge-requirements.json` | `RL-TUIVISION-LOCAL`, `RL-TUIVISION-NATIVE`, `RL-TUIVISION-REVIEW`, `RL-TUIVISION-PRODUCT`, `RL-TUIVISION-GOVERNANCE` |
| `absdd-image-sandbox` | T140, before Constitution or renderer mutation | `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/requirements/absdd-image-sandbox-premerge-requirements.json` | `RL-SANDBOX-LOCAL`, `RL-SANDBOX-NATIVE`, `RL-SANDBOX-REVIEW`, `RL-SANDBOX-PRODUCT`, `RL-SANDBOX-GOVERNANCE` |

Each local artifact uses the five suffix contracts below verbatim. Replace only
`RL-<REPOSITORY>` with the exact prefix listed above and `PRIMARY_EVIDENCE` with
the exact path from the following repository table. Every entry is
`Applicable`; its evidence row must match `requiredScope`, contain every command
and runner token, use the actual reviewed head, and report `Pass`.
The artifact also records top-level `globalRequirementsPath` as
`specs/032-linked-intake-evidence/autonomous-run-gate-requirements.json`,
`globalRequirementsSha256` as the freshly verified normalized hash, and
`preparedAndReviewedByTask` as the exact task in the first table. These lineage
fields do not replace the validator-required schema-1.0 `gates` array. Each gate
object contains `gateId`, `applicability`, `primaryEvidencePath`,
`requiredScope`, `requiredCommandTokens`, `requiredRunnerOrPlatformTokens`,
`rationale`, `nABoundary`, and `reevaluationTrigger`.

| Suffix | Exact `requiredScope` | Exact `requiredCommandTokens` | Exact `requiredRunnerOrPlatformTokens` | Global lineage |
|---|---|---|---|---|
| `LOCAL` | `Prove this repository's canonical inputs, generated outputs, local tests, idempotence, links, UTF-8, and current statistics at the exact reviewed head.` | repository-specific LOCAL tokens below | `macOS`; `Exact Head` | local projection of `AC-LAF-002`–`007`; TuiVision also `AC-LAF-009`–`011` |
| `NATIVE` | `Prove required native Linux and Windows commands independently passed at the exact pushed reviewed head, with actual logs, input/source hashes, exit codes, and write counts.` | repository-specific NATIVE tokens below | `Linux`; `Windows`; `Exact Head` | repository-local precursor to global `AC-LAF-008` |
| `REVIEW` | `Prove required provider checks, independent reviews, and actionable conversations are terminal on the exact reviewed head.` | `gh pr view`; `gh pr checks` | `GitHub`; `Exact Head` | repository-local lifecycle precursor to global `AC-LAF-013` |
| `PRODUCT` | `Prove zero unauthorized product, runtime, API, dependency, package, lockfile, image, or Compose change and complete any approved repository-local version/build exception at the exact reviewed head.` | `git diff --name-only`; `git diff --check` | `macOS`; `Exact Head` | repository-local projection of unchanged global `AC-LAF-014` |
| `GOVERNANCE` | `Prove current security, architecture, accessibility, documentation-impact, statistics, agent-parity, and applicable Constitution evidence at the exact reviewed head.` | `validate-autonomous-delivery-set.sh`; `git rev-parse HEAD` | `macOS`; `Exact Head` | repository-local evidence later aggregated by global `AC-LAF-012` |

The exact prefix for every primary evidence path below is
`.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/`.
Append the displayed suffix without changing case or separators.

| Repository | LOCAL command tokens | NATIVE command tokens | LOCAL primary suffix | NATIVE primary suffix | REVIEW primary suffix | PRODUCT primary suffix | GOVERNANCE primary suffix |
|---|---|---|---|---|---|---|---|
| Home Baseline | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `repositories/home-baseline/local-gates.json` | `platform/home-baseline-native.json` | `delivery/home-baseline-review.json` | `delivery/home-baseline-candidate.json` | `repositories/home-baseline/local-gates.json` |
| Agent Operations Cockpit | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `repositories/agent-operations-cockpit/local-gates.json` | `platform/agent-operations-cockpit-native.json` | `delivery/agent-operations-cockpit-review.json` | `delivery/agent-operations-cockpit-candidate.json` | `repositories/agent-operations-cockpit/local-gates.json` |
| TinyPl0 | `node scripts/tests/requirements-intake-alignment-tests.mjs` | `node scripts/tests/requirements-intake-alignment-tests.mjs` | `repositories/tinypl0/local-gates.json` | `platform/tinypl0-native.json` | `delivery/tinypl0-review.json` | `delivery/tinypl0-candidate.json` | `repositories/tinypl0/local-gates.json` |
| TinyCalc | `node scripts/tests/requirements-intake-alignment-tests.mjs` | `node scripts/tests/requirements-intake-alignment-tests.mjs` | `repositories/tinycalc/local-gates.json` | `platform/tinycalc-native.json` | `delivery/tinycalc-review.json` | `delivery/tinycalc-candidate.json` | `repositories/tinycalc/local-gates.json` |
| InventarWorkerService | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `repositories/inventar-worker-service/local-gates.json` | `platform/inventar-worker-service-native.json` | `delivery/inventar-worker-service-review.json` | `delivery/inventar-worker-service-candidate.json` | `repositories/inventar-worker-service/local-gates.json` |
| TuiVision | `node scripts/tests/requirements-intake-alignment-tests.mjs` | `node scripts/tests/requirements-intake-alignment-tests.mjs` | `repositories/tuivision/local-gates.json` | `platform/tuivision-native.json` | `delivery/tuivision-review.json` | `delivery/tuivision-candidate.json` | `repositories/tuivision/local-gates.json` |
| `absdd-image-sandbox` | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `test-requirements-intake-governance.sh`; `test-requirements-intake-governance.ps1` | `repositories/absdd-image-sandbox/local-gates.json` | `platform/absdd-image-sandbox-native.json` | `delivery/absdd-image-sandbox-review.json` | `delivery/absdd-image-sandbox-candidate.json` | `repositories/absdd-image-sandbox/local-gates.json` |

The native checkpoint task produces the existing per-platform files and the
named hash-bound aggregate. A local requirements artifact must not declare a
global `AC-LAF` ID. Its normalized hash is bound into both local schema-2.0
snapshots.

Only after all seven real PostMerge/default-sync records exist do T153–T155
aggregate all seven rows and validate every unchanged `AC-LAF-001`–`014` entry
with the accepted global requirements file. `AC-LAF-012` and `AC-LAF-013`
remain mandatory there; incomplete future slots are `Open` and cannot be
represented as `N/A` or `Pass`.

- `Applicable` requires complete current evidence before the repository can
  advance.
- `N/A` requires a specific rationale and a re-evaluation trigger when scope
  could make it applicable.
- Temporary `Open` requires an owner, follow-up action, due/revisit point, risk,
  and trigger; it blocks merge when the governing preset defines a hard gate.
- Partial, stale, differently based, or syntactic-only proof is never reported
  as completed platform or delivery evidence.
- A gate pass is bound to the tested head. A changed head invalidates it unless
  the gate explicitly proves the change is outside its scope.

## PR, Review, and Merge Boundary

Before native platform proof, the approved `MergeAndSync` workflow permits a
bounded feature-branch checkpoint: validate the exact intended delivery set,
stage only its allowlist, verify the staged diff and secrets, commit with the
required co-author, and push without force. Native jobs then execute at that
exact remote commit. The subsequent candidate/commit tasks only verify the
same immutable checkpoint. No PR, review, or merge is required to create this
proof checkpoint. A changed candidate or head invalidates the affected proof
and returns to local gates plus native proof; neither a later commit nor a
green job name retroactively proves an uncommitted candidate.

Each repository has one focused PR. Before merge:

1. local check/write/check and idempotence evidence is complete;
2. repository-native tests and required platform proofs pass;
3. documentation impact, statistics, security, architecture, A11Y, and agent
   parity decisions are recorded;
4. all review conversations are resolved by code/evidence or an accepted
   documented decision;
5. required status checks and branch protections pass on the current head;
6. the diff contains no product/runtime/API/dependency expansion.
7. the four scoped version/build proofs and three scoped Constitution-correction
   proofs are complete where applicable; an approved exception is not itself
   execution evidence.

After merge, verify the remote default branch contains the merge result, rerun
the safe/check gate at the merged SHA where the repository requires it, and
confirm generated views remain current. Only then may delivery advance to the
next repository.

## Administrative Bypass

Administrative bypass is not general merge authority. It may be considered
only when every technical, security, review, evidence, and required status
gate has passed and the sole remaining failure is a verified branch-protection
mechanism that refuses an otherwise compliant merge. The decision must record
the exact refusal, current head, actor, reason, scope, time, and post-merge
verification. It must be the narrowest available action.

Bypass is forbidden for failing tests, missing review, unresolved findings,
stale platform proof, absent evidence, scope drift, sandbox base ambiguity, or
delivery-order convenience.

## Rollback and Recovery

Rollback is repository-local and preserves history:

- stop the serial campaign at the failing repository;
- revert the feature merge or offending commit through the repository's normal
  reviewed workflow;
- restore canonical renderer/manifests, regenerate owned outputs, and prove
  check-mode currency and idempotence;
- update evidence and statistics to describe the rollback truthfully;
- for Home Baseline runtime distribution, run the approved check/apply/check
  Home Sync rollback only after the source rollback merges;
- never reset, rebase, or force-update another repository as fleet rollback.

The sandbox's pre-existing Feature 003 commits are outside this feature's
rollback scope.

## Evidence Lifecycle

Evidence progresses through `Draft`, `Current`, `Superseded`, and `Archived`.
Any source, renderer, feature mapping, tested head, platform command, decision,
or output-hash change supersedes the affected record. Superseded evidence is
retained for audit but cannot satisfy a gate. Repository closeout archives the
final current bundle and links it from the feature and statistics ledger.
