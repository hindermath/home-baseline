# Implementation Plan: Linked Intake Orders and Spec Kit Feature Evidence

**Branch**: `032-linked-intake-evidence` | **Date**: 2026-09-01 | **Spec**: [spec.md](spec.md)
**Input**: Accepted feature specification and autonomous run state under `specs/032-linked-intake-evidence/`

## Summary

Implement one shared five-field order-view contract across exactly seven
repositories while preserving every repository's current intake order,
lifecycle, role, root, dependency graph, generator ownership, and delivery
rules. Each generated active row will expose, in this order, `Position`,
`Status`, `Lastenheft/Intake`, `Abhängigkeiten / Dependencies`, and
`Spec-Kit-Feature`. Intake names become repository-relative Markdown links;
direct incoming edges retain `from`, `to`, `kind`, and `binding`; completed
entries link only to uniquely proven existing feature directories.

The implementation changes canonical manifests, renderer declarations, or
tracked renderer logic first and then regenerates views. It never treats an
edited generated table as a source. Home Baseline establishes the contract in
the existing Bash/PowerShell pair; Agent Operations Cockpit adopts that proven
contract; TinyPl0, TinyCalc, and TuiVision retain their JavaScript generators;
InventarWorkerService and `absdd-image-sandbox` retain their manifest-first
repository model and receive dependency-free local documentation-rendering
automation in their established script style. No product API, business logic,
runtime behavior, public data type, package, or external dependency changes.

## Technical Context

**Language/Version**: Existing Bash (`set -euo pipefail`) and PowerShell 7
(`Set-StrictMode -Version Latest`) for Home Baseline and its targeted adoption;
existing Node.js ECMAScript modules using only `node:` standard-library modules
for TinyPl0, TinyCalc, and TuiVision; repository-native PowerShell/Bash
documentation adapters for InventarWorkerService and `absdd-image-sandbox`.
No new language is introduced into an existing renderer implementation.

**Primary Dependencies**: Existing OS shells, PowerShell 7, Node.js where
already used, Git, and repository files. No package-manager or third-party
dependency is added. JSON parsing and SHA-256 use existing runtimes only.

**Storage**: Git-tracked JSON manifests, feature-local Spec Kit artifacts,
Markdown order views, Markdown governance evidence, fixture files, and project
statistics ledgers. No database or mutable external store.

**Testing**: Renderer check/write modes, repository-native alignment tests,
negative fixtures, exact manifest-to-view comparison, relative-link checks,
UTF-8/NUL and path-containment tests, two-run idempotence, Bash/PowerShell
parity, JavaScript generator tests, Git diff checks, secret scans, text-first
accessibility review, and repository-native build/test gates only where local
governance requires them.

**Target Platform**: macOS first; native or isolated Linux proof for Bash and
JavaScript; narrowly scoped native Windows proof for PowerShell 7 and
JavaScript. Markdown remains platform-neutral. `absdd-image-sandbox` retains
its Podman/Docker development context but this feature changes no image or
Compose runtime behavior.

**Project Type**: Multi-repository documentation-renderer and governance
change: Level 0 Home Baseline, one Level-2 scaffold, four Level-2 .NET
repositories with local documentation automation, and one container-tooling
repository.

**Performance Goals**: Linear work in the number of manifest targets and
dependencies; one bounded traversal of the repository-local feature evidence;
no network access during render; zero additional diff on the second unchanged
run.

**Constraints**: Exactly seven repositories; no new dependency; no network
during rendering; fail before publication on unsafe or ambiguous input;
strict repository-relative paths; no private absolute paths in evidence;
German first and English second at CEFR B2 where the local contract requires
it; no semantic mutation of series data; no work in another repository during
Plan.

**Scale/Scope**: Seven repository targets. TuiVision is the binding exact
fixture with ten completed rows, ten feature links `037` through `046`, six
unchanged dependency edges, and one separate non-executable `DeferredOptional`
backlog item.

## Read-Only Repository Baseline

The seven registered checkouts were inspected locally without fetch, checkout,
branch creation, rebase, write-mode renderer execution, or file mutation.
Private absolute path prefixes are intentionally not persisted; registered
workspace paths are the durable identifiers.

| Order | Repository / registered workspace | Observed branch and HEAD | Local state against cached `origin/main` | Canonical implementation surface |
|---:|---|---|---|---|
| 1 | `home-baseline` / `home-baseline-source` | `032-linked-intake-evidence`, `e38d31a5d6c528458493a07e74ee1694db7c3aab` | Accepted feature worktree changes; HEAD `0/0` | `requirements/intakes/series/home-baseline-delivery/manifest.json`, `scripts/lib/secure-development-hardening.sh`, `.ps1`, root order view |
| 2 | `agent-operations-cockpit` / `RiderProjects/AgentOperationsCockpit` | `main`, `3c9a618243fffff187932b1ee431ffbd25d3856e` | clean, `0/0` | `specs/intake-series/aoc-phase-2/manifest.json`, existing propagated Bash/PowerShell hardening renderer, root marker, and `requirements/intakes/series/order.md` |
| 3 | `TinyPl0` / `RiderProjects/TinyPl0` | `main`, `3366400b989532d7f270de532acb03ae6a8ce21f` | clean, `0/0` | `scripts/render-requirements-intake-governance.mjs`, local alignment tests, series manifest and root/series order views |
| 4 | `TinyCalc` / `RiderProjects/TinyCalc` | `main`, `9beb7d9395310fe8e711c51c3655d50d2df889a5` | clean, `0/0` | Existing JavaScript renderer already constructs both order views from one member set |
| 5 | `InventarWorkerService` / `RiderProjects/InventarWorkerService` | `main`, `ecc3c5d66f0e674e8650d968057fd4eb3151a4b7` | clean, `0/0` | Series manifest plus manifest-bound generated marker in the root view; add only repository-native dependency-free rendering automation |
| 6 | `TuiVision` / `RiderProjects/TuiVision` | `main`, `58f77c9047c3a31388995bd95e4a698408893585` | clean, `0/0` | Existing JavaScript renderer, root view, and `requirements/intakes/series/tui-vision-delivery/order.md` |
| 7 | `absdd-image-sandbox` / `container-images/absdd-image-sandbox` | `003-secure-development-container-hardening`, `d1c713246c4e5306d41d39bec82a13ef9cfbcaa8` | clean; tracks its same-named remote branch; `0` behind and `2` ahead of cached `origin/main` | `specs/intake-series/sandbox-development-lifecycle/manifest.json` and manifest-first root view; add only repository-native dependency-free rendering automation after the base-state gate |

The cached remote facts are planning observations, not freshness proof. The
implementation phase must perform a fresh delivery-set preflight before its
first mutation. The sandbox checkout is deliberately not switched, rebased,
reset, or otherwise altered by Plan. Its two-commit lead is an expected
pre-existing state, not authority to stack this feature. Feature work there is
blocked until Feature 003 has a terminal delivery decision and a clean,
freshly synchronized default-branch base is available.

## Constitution Check

*GATE: Passed before Phase 0 research and re-checked after Phase 1 design.*

### Project Environment and MSL

- Home Baseline remains Level 0. The six Level-2 rows from the Project
  Environment Registry are binding: Agent Operations Cockpit (.NET scaffold),
  TinyPl0 (.NET 10/C# 14), TinyCalc (.NET 10/C#), TuiVision (.NET 10/C#),
  InventarWorkerService (.NET 10/C# 14), and `absdd-image-sandbox` (Python plus
  Bash/PowerShell container automation).
- JavaScript and C# are memory-safe languages on Principle XI's allow-list.
  Existing Bash/PowerShell adapters remain constrained by their language rules;
  no non-MSL product runtime is introduced.
- The feature changes development/documentation automation only. It does not
  alter the .NET, Python, container, TUI, or service runtime of any product.

### Secure Coding and Architecture

- Manifest strings are untrusted data. Renderers validate UTF-8, reject NUL,
  absolute paths, `..`, option-like path components, missing paths, containment
  escapes, symlink escapes, and ambiguous feature mappings before any write.
- Renderers never execute manifest values, never construct a shell command
  from them, and redact private absolute roots from user-facing evidence.
- The existing data flow remains `series manifest + feature evidence -> local
  renderer -> generated Markdown -> validation`. No network, authentication,
  authorization, cryptography, service, deployment, or remote trust boundary is
  added.
- Security and architecture evidence is planned per repository at
  `docs/security/linked-intake-evidence.md`,
  `docs/architecture/linked-intake-evidence.md`, and
  `docs/accessibility/linked-intake-evidence.md`, or at a documented local
  equivalent. Each record uses `Applicable`, justified `N/A`, or temporary
  `Open` with owner, follow-up, and re-evaluation trigger.
- A new ADR/S-ADR is `N/A`: the plan preserves each existing source and
  generator boundary. Re-evaluate if implementation requires a new canonical
  source, new building block, new external interface, deployment change, or
  trust boundary.

### Standards Applicability

| Checkpoint | Decision | Planned evidence |
|---|---|---|
| NIST SSDF, CWE Top 25 | `Applicable` | Requirement/task/test/review traceability; path traversal, input-validation, option-injection, and command-injection negative tests |
| STRIDE + CIA, CAPEC | `Applicable` | Local path-boundary threat entry and quality scenarios; integrity and availability failure paths |
| OWASP SAMM | `Applicable` | Repository Security Review decision covering Requirements and Verification maturity |
| Dependency audit | `Applicable` | Diff proves zero dependency/lockfile/package changes |
| OWASP ASVS | `N/A` | No web, HTTP, API, auth, or session surface |
| SBOM, VEX, AI-SBOM, SLSA, OpenSSF Scorecard | `N/A` | No new dependency, package, release artifact, AI runtime, or supply-chain selection |
| Zero Trust | `N/A` | No distributed, service, cloud, or remote-access boundary |
| BSI C3A, BSI C5 | `N/A` | No cloud-service selection, hosting change, or cloud assurance scope |
| NIS2, CRA, EU AI Act, DORA | `N/A` | No new market, customer, AI-runtime, financial ICT, or regulated delivery scope |

AI is development tooling only. No model, service, dataset, inference
infrastructure, or AI runtime component is shipped, so AI-SBOM remains `N/A`.
No credential files, local model profiles, agent logs/history, SQLite state, or
machine-local runtime evidence enter Git.

### Accessibility, Language, and Learner Baseline

- Markdown views, CLI/check-mode output, errors, help, manpages, and evidence
  summaries are user-facing and receive a WCAG 2.2 AA-oriented text-first
  review. Position, status, intake, each dependency, feature state, error, and
  next action remain understandable after table linearization.
- Meaning never depends only on color, icon, glyph, column position, or visual
  grouping. Keyboard, screen-reader, Braille-display, and text-browser use are
  explicitly checked where applicable.
- German appears first and English second at CEFR B2 under each repository's
  language contract. First-use explanations assume Markdown/Git basics but no
  Spec Kit experience. German umlauts and `ß` are retained.
- Code blocks are language tagged. Non-trivial path, ambiguity, idempotence,
  parity, and proof-boundary logic is reviewed for concise didactic comments
  explaining why rather than restating what.

### Cross-Platform and Agent Parity

- Home Baseline changes the existing Bash/PowerShell pair as one unit,
  including `Update-SdhOrderFile`, dry-run/`-WhatIf`, error families, exit
  codes, full bilingual PowerShell help, and
  `docs/man/prepare-secure-development-hardening.1.md`.
- Bash keeps `set -euo pipefail`, quoted variables, safe `--` boundaries, no
  `eval`, and macOS-compatible constructs. PowerShell keeps strict mode,
  validated parameters, `${Name}` before punctuation, `-NoProfile` for child
  processes, no `Invoke-Expression`, and approved `Update` verb usage.
- Native macOS safe mode runs first. Linux and Windows proof binds exact commit,
  command, runner/platform, exit code, payload SHA-256, decision SHA-256, and
  zero-write count. A shell syntax check or a non-native run is explicitly a
  partial proof, never a full regression pass.
- Shared agent-guidance mutation is not expected. Every repository still
  records an agent-parity decision. If a shared rule becomes necessary, all
  maintained surfaces, project templates, and local constitution memory are
  updated atomically. No model names enter feature artifacts.

### Presets, Statistics, and Documentation Impact

- The standard eight governance presets are applicable as described above;
  Autonomous Run is `Applicable`; Parallel Autonomous Run is `N/A` because the
  accepted flow is serial. Model Routing, Intake Authoring, Intake Review, and
  Intake Sequencing evidence remains hash-bound and revalidated on drift.
- Each repository updates `docs/project-statistics.md` after its completed
  implementation phase using its local renderer and baseline: Home/AOC `80`
  and `125`; TinyPl0/TinyCalc/TuiVision `80` and `125`;
  InventarWorkerService `80` and `100`; sandbox `80` with no C# default.
- Documentation Impact is exactly `GeneratedUpdate`. Canonical manifests or
  renderer declarations are changed first; generated root/series views,
  renderer help/manpages, evidence, and statistics follow deterministically.
- Home Baseline `scripts/` are `homeRuntime`. Therefore a post-merge Home Sync
  is required only for the final Home Baseline delivery, after
  `sync-home.* --check-only`, and only under current sync authority. Feature
  artifacts and documentation remain `sourceOnly`. Other repositories do not
  inherit Home Baseline distribution classes.

### Post-Design Re-check

Phase 0 resolves every technical choice and Phase 1 introduces no new package,
product interface, runtime, canonical series meaning, or unresolved
clarification. All constitutional gates pass. Any implementation discovery
that contradicts this conclusion stops before expansion and returns to plan
review; it is not silently absorbed.

## Design and Source-of-Truth Strategy

### Shared Row Projection

Every renderer builds a typed in-memory projection defined in
[data-model.md](data-model.md) and [linked-intake-view.md](contracts/linked-intake-view.md).
The series manifest supplies order, role, lifecycle status, roots, and exact
dependency edges. The renderer supplies view formatting and validates feature
evidence against actual feature-local artifacts and directories. It does not
rewrite series business data.

Feature linkage requires one explicit proof path: a feature spec/run-state
binding to the intake, a branch-stamped archived intake that is part of the
feature closeout, or a reviewed renderer-owned legacy mapping such as the exact
TuiVision fixture. A numeric resemblance or directory-name guess is never
evidence. Zero proofs yields the exact no-feature text; more than one valid
proof is a hard stop.

### Repository Adoption Matrix

| Repository | Canonical changes | Generated outputs | Repository-specific validation |
|---|---|---|---|
| Home Baseline | Extend `scripts/lib/secure-development-hardening.sh` and `.ps1` plus fixtures; read the existing Home series manifest and explicit feature evidence | Generated marker in `Lastenheft_Abarbeitungsreihenfolge.md`; paired help/manpage; feature evidence docs | Bash syntax and safe mode, PowerShell parse/help/WhatIf, parity fixtures, current secret scan, PSScriptAnalyzer where configured |
| Agent Operations Cockpit | Adopt only the proven Level-0 row contract in its existing paired renderer; preserve AOC's own series and global-review controls | Root generated marker and local evidence | Fresh 14-target `global-ready`/local programme gates, paired no-write/parity checks, AEPS no-change-or-receipt decision |
| TinyPl0 | Extend existing `.mjs` member/view projection and existing alignment tests | Root and `tinypl0-delivery/order.md` from the same projection | Node check/write/check, alignment tests, relevant repository checks; no compiler/runtime golden change |
| TinyCalc | Extend existing `.mjs` row generation and alignment tests | Root and `tinycalc-delivery/order.md` from the same projection | Node tests, link/feature/path fixtures, non-interactive validation; product build only if local gate requires it |
| InventarWorkerService | Keep its manifest authoritative; add repository-native dependency-free manifest-to-marker automation and tests without touching solution APIs | Existing manifest-bound root marker plus help/manpage/evidence if a new script surface is added | Renderer tests, manifest validator, relevant .NET solution gate only if executable project files change (expected `N/A`) |
| TuiVision | Extend existing `.mjs` renderer declarations and tests; bind the exact ten intake/feature pairs and six edge tuples | Root and `tui-vision-delivery/order.md` identically generated; latest-completion note outside canonical row order | Exact cardinality/mapping/edge/backlog fixture, Node alignment tests, text-first review; no TuiVision product assembly changes |
| `absdd-image-sandbox` | After its base gate, keep sandbox manifest authoritative; add repository-native dependency-free manifest-to-view automation and tests without image/Compose changes | Root view and local evidence/help where applicable | Manifest/renderer checks, `podman-compose config` only if Compose scope changes (expected `N/A`), pre-commit/secret scan; no image build required for docs-only diff |

### Verified Repository Source and Test Paths

Read-only inspection verified the current paths below. Paths marked `planned`
do not exist yet; fixing them here removes ambiguity before task generation
without claiming implementation.

| Repository | Canonical source and renderer path | Test path | Generated view path |
|---|---|---|---|
| Home Baseline | `requirements/intakes/series/home-baseline-delivery/manifest.json`; `scripts/lib/secure-development-hardening.sh`; `scripts/lib/secure-development-hardening.ps1`; `scripts/prepare-secure-development-hardening.sh`; `scripts/prepare-secure-development-hardening.ps1` | `scripts/test-requirements-intake-governance.sh`, `scripts/test-requirements-intake-governance.ps1`, and `scripts/tests/linked-intake-evidence/` (`planned`) | `Lastenheft_Abarbeitungsreihenfolge.md` |
| Agent Operations Cockpit | `specs/intake-series/aoc-phase-2/manifest.json`; `scripts/lib/secure-development-hardening.sh`; `scripts/lib/secure-development-hardening.ps1`; `scripts/prepare-secure-development-hardening.sh`; `scripts/prepare-secure-development-hardening.ps1` | `scripts/test-requirements-intake-governance.sh`, `scripts/test-requirements-intake-governance.ps1`, and `scripts/tests/linked-intake-evidence/` (`planned`) | `Lastenheft_Abarbeitungsreihenfolge.md`; `requirements/intakes/series/order.md` |
| TinyPl0 | `requirements/intakes/series/tinypl0-delivery/manifest.json`; `scripts/render-requirements-intake-governance.mjs` | `scripts/tests/requirements-intake-alignment-tests.mjs`; `scripts/validate-requirements-intake-alignment.mjs`; `scripts/validate-requirements-intake-alignment.sh`; `scripts/validate-requirements-intake-alignment.ps1` | `Lastenheft_Abarbeitungsreihenfolge.md`; `requirements/intakes/series/tinypl0-delivery/order.md` |
| TinyCalc | `requirements/intakes/series/tinycalc-delivery/manifest.json`; `scripts/render-requirements-intake-governance.mjs` | `scripts/tests/requirements-intake-alignment-tests.mjs`; `scripts/validate-requirements-intake-alignment.mjs`; `scripts/validate-requirements-intake-alignment.sh`; `scripts/validate-requirements-intake-alignment.ps1` | `Lastenheft_Abarbeitungsreihenfolge.md`; `requirements/intakes/series/tinycalc-delivery/order.md` |
| InventarWorkerService | `requirements/intakes/series/inventar-worker-service/manifest.json`; `scripts/render-requirements-intake-governance.sh`; `scripts/render-requirements-intake-governance.ps1` (`planned`) | `scripts/test-requirements-intake-governance.sh`, `scripts/test-requirements-intake-governance.ps1`, and `scripts/tests/linked-intake-evidence/` (`planned`) | `Lastenheft_Abarbeitungsreihenfolge.md` |
| TuiVision | `requirements/intakes/series/tui-vision-delivery/manifest.json`; `scripts/render-requirements-intake-governance.mjs` | `scripts/tests/requirements-intake-alignment-tests.mjs`; `scripts/validate-requirements-intake-alignment.mjs`; `scripts/validate-requirements-intake-alignment.sh`; `scripts/validate-requirements-intake-alignment.ps1`; `scripts/tests/linked-intake-evidence/tuivision-exact.json` (`planned`) | `Lastenheft_Abarbeitungsreihenfolge.md`; `requirements/intakes/series/tui-vision-delivery/order.md` |
| `absdd-image-sandbox` | `specs/intake-series/sandbox-development-lifecycle/manifest.json`; `scripts/render-requirements-intake-governance.sh`; `scripts/render-requirements-intake-governance.ps1` (`planned`) | `scripts/test-requirements-intake-governance.sh`, `scripts/test-requirements-intake-governance.ps1`, and `scripts/tests/linked-intake-evidence/` (`planned`) | `Lastenheft_Abarbeitungsreihenfolge.md` |

Each planned Bash renderer/test receives its matching `docs/man/` page; each
PowerShell counterpart receives complete bilingual comment-based help. New
script paths are added to the repository-local script catalog when that
repository has one. These are documentation-renderer and verification paths,
not product or runtime surfaces. The new manpages are
`docs/man/render-requirements-intake-governance.1.md` and
`docs/man/test-requirements-intake-governance.1.md`; the PowerShell advanced
functions are `Invoke-RequirementsIntakeGovernanceRender` and
`Test-RequirementsIntakeGovernance`.

## Implementation Phases and Delivery Order

### Phase A - Freeze and Preflight

1. Revalidate the autonomous run state, accepted artifact hashes, branch, plan,
   tasks/analyze handoff, authority, and exact seven-target delivery set.
2. Freshly inspect each target's registered path, origin URL, default branch,
   clean state, ahead/behind state, canonical source, local governance, and
   installed validator surface before any repository mutation.
3. Require the sandbox Feature-003 branch to have a terminal delivery decision
   and a clean default-branch base. Do not reset, rebase, force-switch, or stack
   this feature on its current two-commit lead. If this cannot be proven, stop
   the entire implementation before the first target write.
4. Pre-name repository evidence paths, gate requirements, branch names,
   expected candidate paths, rollback anchors, and safe stop boundaries.

### Phase B - Representative Vertical Slice: Home Baseline

1. Add failing fixtures for the five fields, incoming-edge rendering, exact
   root text, proven/unproven/ambiguous feature states, unsafe paths, UTF-8/NUL,
   symlink containment, no-write mode, and second-run idempotence.
2. Extend the paired renderer at the canonical Level-0 source; update its
   help/manpage and generated root marker.
3. Prove Bash/PowerShell semantic and required byte parity on identical
   fixtures. Record security, architecture, A11Y, documentation-impact,
   statistics, and agent-parity decisions.
4. Freeze the reviewed Level-0 contract hash before downstream adoption.

### Phase C - Serial Repository Adoption

Adopt and completely validate one repository before starting the next:

1. Agent Operations Cockpit from the frozen Level-0 contract.
2. TinyPl0 through its existing JavaScript renderer.
3. TinyCalc through its existing JavaScript renderer.
4. InventarWorkerService through its manifest-first local automation.
5. TuiVision through its exact ten-row/six-edge fixture.
6. `absdd-image-sandbox` last, from a newly synchronized eligible base.

Each target receives a separate branch, candidate set, evidence record, review,
PR, merge, default-branch synchronization, and closeout decision. Success in an
earlier repository cannot satisfy a later repository's gates.

### Planned Branches

| Repository | Planned feature branch | Base rule |
|---|---|---|
| Home Baseline | existing `032-linked-intake-evidence` | Preserve accepted dirty feature worktree; no new branch during Plan |
| Agent Operations Cockpit | `003-linked-intake-evidence` | Fresh clean `main` after AOC global-review and default-sync proof |
| TinyPl0 | `006-linked-intake-evidence` | Fresh clean synchronized `main` |
| TinyCalc | `004-linked-intake-evidence` | Fresh clean synchronized `main` |
| InventarWorkerService | `003-linked-intake-evidence` | Fresh clean synchronized `main` |
| TuiVision | `047-linked-intake-evidence` | Fresh clean synchronized `main` |
| `absdd-image-sandbox` | `004-linked-intake-evidence` | Create only after Feature 003 terminal delivery and clean synchronized default branch; never from the currently observed two-commit-ahead branch by assumption |

If a repository's branch-number allocator reports a different next number at
implementation time, branch creation stops and the table is refreshed before
writes; a collision is never overwritten.

### Phase D - Fleet Validation and Delivery

1. Run the seven-row acceptance matrix and every `AC-LAF-001` through
   `AC-LAF-014` gate against exact repository heads.
2. Commit only the intended candidate in each repository, preserving unrelated
   user changes. Validate staged diffs, task counts, gate evidence, and secret
   scans before push.
3. Push and open one focused PR per repository in the serial dependency order.
   Use `gh` for live GitHub operations. Derive workflow/job/runner/command facts
   from actual logs, not green aggregate names.
4. Require all technical checks, independent review, and review follow-up on
   the exact head. A regular merge is attempted first. Admin bypass is allowed
   only after a documented protection-only refusal and never substitutes for
   task, acceptance, security, CI, A11Y, review, or platform evidence.
5. After every merge, fast-forward and prove the local default branch equals
   `origin/main`, then run post-merge validation. Do not proceed to the next
   dependent repository while the previous closeout is incomplete.
6. After the Home Baseline merge and default sync, run Home Sync check-only,
   then the authorized manifest-bound Home Runtime sync, and finally check-only
   again. No other target uses this Home Sync.

## Validation Strategy

### Functional and Contract Tests

- Exact five-column order and labels for every active row.
- Intake link label equals the full actual Markdown filename; link resolves
  relative to each generated view's directory.
- Direct incoming dependency list equals the manifest tuples exactly; no edge
  is reversed, dropped, duplicated, or reclassified. Root rows render exactly
  `— (Root / keine direkte Abhängigkeit)`.
- Completed entries have either one uniquely proven existing feature link or
  exactly `— (kein Spec-Kit-Feature / no Spec Kit feature)`. Non-completed
  entries never receive a guessed feature link.
- Order, lifecycle, role, roots, and dependency tuples are byte-normalized and
  compared before/after to prove zero business mutation.

### Negative and Security Tests

- Invalid UTF-8, NUL, absolute paths, `..`, leading option markers, missing
  paths, symlink escapes, disappearing targets, unknown dependency endpoints,
  duplicate targets, duplicate feature claims, and multiple valid feature
  candidates fail closed before publication.
- Error families are stable, bilingual where required, contain the safe
  repository-relative subject and next action, and never expose credentials,
  tokens, private roots, stack traces, or connection data.
- Manifest values are never interpolated into executable commands. No new
  dependency, package file, lockfile, runtime project, product API, or public
  data type appears in the candidate diff.

### Determinism and Platform Proof

- Check mode against current canonical outputs passes or reports stale output
  with zero writes.
- Write mode on an isolated fixture produces expected output; a second write
  produces byte-identical files and zero Git diff.
- Home Baseline Bash and PowerShell fixtures match in content, error class,
  exit code, and write count. Line-ending normalization is explicit and cannot
  create a platform-only second diff.
- macOS evidence runs first. Linux and Windows evidence is exact-head and
  command-bound. Missing native evidence is `Open` with owner and trigger, and
  blocks repository completion; it is never relabeled `N/A` merely because the
  local host is macOS.

### Accessibility and Documentation Proof

- Linearize representative rows with zero, one, and multiple dependencies and
  both feature states. A reviewer identifies all five fields and next action
  without using table position or color.
- Check heading order, descriptive link text, language order, CEFR B2,
  keyboard/text-only usability, correct code-block tags, and German
  orthography.
- Record exactly one `GeneratedUpdate` decision per repository with source,
  owner, audience, reader path, navigation, document class, language partner,
  platform/example proof, distribution, sync need, evidence, and re-evaluation.

## Evidence Lifecycle and Gate Model

Before implementation, create a machine-readable gate-requirements artifact
and a human-readable evidence index under this feature. Each repository gate
record binds:

- repository identity and registered path;
- gate ID and applicability (`Applicable`, `N/A`, or temporary `Open`);
- canonical source SHA-256 and exact candidate/default-branch commit;
- exact command, working directory, platform/runner, start/end time, exit code,
  payload SHA-256, decision SHA-256, and zero-write count where relevant;
- owner, reviewer, evidence path, residual risk, and re-evaluation trigger;
- PR, review, merge, default-sync, Home-sync, or justified `N/A` causal fact.

Evidence is valid only for the bound inputs and head. Canonical-source, target,
command, platform, workflow, policy, dependency, branch, or authority drift
invalidates the affected gate and requires re-execution. Cross-repository proof
is not transferable. Mutable future facts are not predicted.

Safe stop boundaries are: before first mutation, after each repository's local
validation, after each PR publication, after each review-complete head, after
each merge/default-sync, and before Home Sync. On interruption, revalidate run
state, accepted hashes, exact heads, dirty state, completed external actions,
authority, and idempotency before resume; never repeat a possibly completed
remote action without observation.

## Rollback and Recovery

- Before renderer writes, record canonical input hashes and the exact generated
  output set. Writes use temporary files and atomic replace only after complete
  validation; partial publication is forbidden.
- A failed check leaves canonical sources and published views unchanged. A
  failed write restores the pre-write generated bytes from the repository-local
  rollback anchor and records `NeedsRepair`; it does not make the generated
  view canonical.
- Before commit, rollback is a targeted revert of this feature's intended paths
  only. Never reset, clean, checkout, or overwrite unrelated user changes.
- After commit but before merge, add a corrective commit on the same feature
  branch. After merge, use a focused revert PR under current authority; do not
  rewrite default-branch history.
- Home Sync runs only after the merged source is validated. If post-sync
  check-only fails, stop, preserve the manifest-bound evidence, and repair from
  the canonical Level-0 source rather than editing the Home copy.
- The sandbox's existing Feature-003 branch is an input constraint, never a
  rollback target of this feature.

## PR, Review, Merge, and Admin-Boundary Rules

- `MergeAndSync` authorizes the later gate-bound delivery flow described by
  the accepted run state; Plan performs none of it.
- Each PR contains its exact source/output set, commands, risk statement,
  Documentation Impact, statistics decision, and sample user-facing output.
- Required workflows, repository review policy, GitHub Copilot review
  governance, Code Owner requirements, and security/A11Y review must complete
  on the exact candidate head. Review comments are resolved with code/evidence,
  not dismissed by aggregate green status.
- A protection refusal, a technical failure, a provider/billing refusal, and a
  pass are distinct outcomes. Admin bypass is available only for a pure
  protection refusal after all technical and review gates pass. It grants no
  ruleset edit, secret, billing, provider, or unrelated repository authority.
- Default-branch synchronization and post-merge checks are mandatory causal
  closeout facts. No repository is `Completed` while its local default branch,
  remote default branch, or required post-merge action is unproven.

## Requirement Traceability

| Requirement group | Plan/design location | Future task/evidence family |
|---|---|---|
| `LAF-001`–`LAF-005`, `AC-LAF-002`–`005` | Shared row projection; view contract; data model | Renderer fixtures, link/dependency/feature matrix |
| `LAF-006`–`LAF-012`, `AC-LAF-006` | Source-of-truth and A11Y strategy | Before/after semantic snapshot, linearization review |
| `LAF-013`–`LAF-016`, `AC-LAF-007`–`008` | Adoption matrix; platform strategy | Canonical-source diffs, two-run proof, pair parity, help/manpage |
| `LAF-017`–`LAF-022`, `AC-LAF-001`, `012`–`014` | Serial phases; seven-row evidence | Per-repository branch, candidate, governance, product-scope diff |
| `LAF-023`–`LAF-027`, `AC-LAF-009`–`011` | TuiVision exact contract | Ten-pair/six-edge/backlog fixture and generated views |
| `LAF-028`–`LAF-035` | Constitution, validation, security and platform sections | Native platform, path/UTF-8/NUL, redaction, comments, dependency audit |
| Delivery and autonomous contract | Evidence lifecycle, branch/delivery order, PR boundaries | Run state, phase results, PreMerge/PostMerge evidence, causal closeout |

## Project Structure

### Documentation (this feature)

```text
specs/032-linked-intake-evidence/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── autonomous-run-state.json
├── checklists/
│   ├── acceptance-readiness.md
│   ├── plan-quality.md
│   └── requirements.md
└── contracts/
    ├── fleet-evidence-and-delivery.md
    ├── linked-intake-view.md
    ├── renderer-validation.md
    └── tuivision-exact-contract.md
```

### Planned Implementation Surfaces

```text
home-baseline-source/
├── scripts/lib/secure-development-hardening.sh
├── scripts/lib/secure-development-hardening.ps1
├── scripts/prepare-secure-development-hardening.sh
├── scripts/prepare-secure-development-hardening.ps1
├── docs/man/prepare-secure-development-hardening.1.md
└── Lastenheft_Abarbeitungsreihenfolge.md

RiderProjects/{TinyPl0,TinyCalc,TuiVision}/
├── scripts/render-requirements-intake-governance.mjs
├── scripts/tests/requirements-intake-alignment-tests.mjs
├── Lastenheft_Abarbeitungsreihenfolge.md
└── requirements/intakes/series/<local-series>/order.md

RiderProjects/AgentOperationsCockpit/
├── scripts/lib/secure-development-hardening.sh
├── scripts/lib/secure-development-hardening.ps1
├── scripts/prepare-secure-development-hardening.sh
├── scripts/prepare-secure-development-hardening.ps1
├── scripts/test-requirements-intake-governance.sh            # planned paired test
├── scripts/test-requirements-intake-governance.ps1           # planned paired test
├── scripts/tests/linked-intake-evidence/                     # planned fixtures
├── Lastenheft_Abarbeitungsreihenfolge.md
├── requirements/intakes/series/order.md
└── specs/intake-series/aoc-phase-2/manifest.json

RiderProjects/InventarWorkerService/ and container-images/absdd-image-sandbox/
├── scripts/render-requirements-intake-governance.sh          # Inventar/sandbox planned
├── scripts/render-requirements-intake-governance.ps1         # Inventar/sandbox planned
├── scripts/test-requirements-intake-governance.sh            # planned paired test
├── scripts/test-requirements-intake-governance.ps1           # planned paired test
├── scripts/tests/linked-intake-evidence/                     # planned fixtures
├── Lastenheft_Abarbeitungsreihenfolge.md
├── requirements/intakes/series/inventar-worker-service/manifest.json  # Inventar only
└── specs/intake-series/sandbox-development-lifecycle/manifest.json    # sandbox only

each repository/
├── docs/security/linked-intake-evidence.md
├── docs/architecture/linked-intake-evidence.md
├── docs/accessibility/linked-intake-evidence.md
└── docs/project-statistics.md
```

**Structure Decision**: Preserve the implementation shape already present in
each repository. Shared shell behavior is authored at Level 0 and adopted only
where that paired renderer already belongs; JavaScript repositories keep their
local ESM generators; manifest-first repositories gain only the smallest
repository-native dependency-free documentation surface needed to make their
existing view reproducible. Generated views are outputs, never sources.

## Complexity Tracking

No constitution violation is accepted. Seven repositories are required by the
accepted feature scope, not an architectural convenience. Serial delivery and
separate repository evidence reduce shared-writer and authority risk.
