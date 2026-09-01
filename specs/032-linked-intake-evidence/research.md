# Research: Linked Intake Orders and Feature Evidence

## R01 - Accepted Inputs and Unknowns

**Decision**: Treat the eight hash-bound artifacts in
`autonomous-run-state.json`, the accepted `spec.md`, and both completed
checklists as the only feature inputs. All eight accepted file hashes were
recomputed locally and matched. There are no `NEEDS CLARIFICATION` items.

**Rationale**: The Ready intake review reports no finding, question, accepted
risk, or operator exception. Planning must preserve that closed scope.

**Alternatives considered**: Re-open the stale TuiVision-missing assumption or
request user input. Rejected because the user explicitly required inspection
of all seven now-existing checkouts and prohibited questions.

## R02 - Read-Only Checkout Reality

**Decision**: Use the registered workspace paths as durable identities and the
locally observed branch/HEAD/status as planning evidence only. Six targets were
clean at cached `origin/main`; Home Baseline contained the accepted feature
worktree; the sandbox was clean on
`003-secure-development-container-hardening`, tracking its same-named remote
branch and two commits ahead of cached `origin/main`.

**Rationale**: Local remote-tracking references can prove the observed state
but not current server freshness. A fresh preflight is therefore mandatory
before implementation writes.

**Alternatives considered**: Fetch or normalize branches during Plan. Rejected
because Plan is read-only for other repositories and the user explicitly
forbade mutation or rebase of the sandbox.

## R03 - Canonical Source Boundary

**Decision**: Preserve series manifests as the sole source for order, status,
role, roots, and dependency tuples. Preserve each existing renderer as the
source for presentation. Generate views only after canonical inputs validate.

**Rationale**: This prevents hand-edited tables from becoming shadow business
sources and keeps repository-specific governance intact.

**Alternatives considered**: Manually edit all seven Markdown tables. Rejected
because it is not idempotent, loses source ownership, and violates LAF-013.

## R04 - Feature Mapping Without Guessing

**Decision**: Resolve feature evidence only from explicit repository evidence:
an exact intake binding in a feature spec/run state, an archived intake path
stamped by that feature's closeout, or a reviewed renderer-owned legacy mapping
with an actual feature directory. Zero valid proofs produces the exact
no-feature fallback; multiple proofs fail closed. Numeric or slug similarity
alone is never proof.

**Rationale**: A `Completed` lifecycle is independent of the existence or
identity of a Spec Kit feature. The feature link must be independently
traceable.

**Alternatives considered**: Infer `specs/NNN-*` from filename suffixes or
pick the first matching directory. Rejected as ambiguous and contrary to
LAF-006 through LAF-008.

## R05 - Position Semantics

**Decision**: Use manifest order as the default display position, but preserve
an explicit stable visible position when canonical intake metadata declares
one. Home Baseline position 39 therefore stays `39` even though the intake is
active manifest slot 1.

**Rationale**: The accepted intake explicitly separates visible position from
active manifest placement. Conflating them would mutate business meaning.

**Alternatives considered**: Renumber every table by current array index.
Rejected because it would change the Home Baseline visible identity.

## R06 - Dependency Projection

**Decision**: For every target, render only direct incoming edges from the
manifest. Each rendered edge includes its source intake link, direction toward
the current row, exact `kind`, and literal `binding: true|false`. Rows without
incoming edges use exactly `— (Root / keine direkte Abhängigkeit)`.

**Rationale**: Transitive closure obscures which gate is direct and can turn an
advisory relationship into an apparent blocker.

**Alternatives considered**: Human prose summaries or transitive dependency
lists. Rejected because neither permits exact tuple comparison.

## R07 - Repository-Native Renderer Strategy

**Decision**: Keep the current implementation families:

- Home Baseline and Agent Operations Cockpit: paired Bash/PowerShell hardening
  renderer surface.
- TinyPl0, TinyCalc, TuiVision: existing standard-library-only JavaScript ESM
  generator and alignment tests.
- InventarWorkerService and `absdd-image-sandbox`: manifest-first views gain the
  smallest repository-native dependency-free rendering surface necessary for
  reproducibility, with paired help/validation where script governance applies.

**Rationale**: Read-only inspection found dedicated `.mjs` renderers in the
three JavaScript repositories and manifest-bound views but no dedicated
tracked order-view executable in the final two. Claiming a non-existent
renderer would be untruthful; adding a bounded documentation tool is not a
product runtime or API expansion.

**Alternatives considered**: Copy one renderer wholesale to every repository,
introduce a package, or edit the views manually. Rejected because these choices
erase repository ownership, add dependencies, or violate generation rules.

## R08 - TuiVision Exact Contract

**Decision**: Bind the ten accepted intake-to-feature pairs and the six exact
edge tuples in a dedicated contract fixture. Generate both root and series
views from the same projection. Keep Feature 046 separately identified as most
recently completed without moving it from manifest position 10. Keep the
optional NuGet intake outside the active series as one `DeferredOptional`
backlog item.

**Rationale**: TuiVision has the most concrete historic contract and is the
best regression oracle for cardinality, feature evidence, advisory edges, and
backlog separation.

**Alternatives considered**: Test only row/edge counts. Rejected because counts
can pass with reversed, invented, or retyped edges.

## R09 - Safe Path and Encoding Model

**Decision**: Treat all manifest and evidence paths as untrusted
repository-relative strings. Validate strict UTF-8 and no NUL before parsing;
reject absolute, traversal, leading-option, missing, outside-root, and
symlink-escape targets. Resolve links relative to the generated view, but
validate containment relative to the repository root. Recheck existence
immediately before atomic publication.

**Rationale**: The renderer crosses a data-to-filesystem trust boundary.
Fail-closed validation protects integrity and availability without adding a
new network boundary.

**Alternatives considered**: Rely on `path.resolve` or file existence alone.
Rejected because both can admit traversal or symlink escapes.

## R10 - Cross-Platform Proof

**Decision**: Validate macOS safe mode first, then exact-head Linux and Windows
proof. Home Bash and PowerShell must match fields, links, status, dependencies,
feature state, errors, exit codes, line-ending policy, and write counts.
JavaScript renderers use the same fixtures on their supported platforms.

**Rationale**: Syntax-only or emulated proof cannot establish native path and
line-ending behavior. The constitution requires runner- and command-bound
evidence.

**Alternatives considered**: Treat a successful macOS run as all-platform
proof. Rejected because it leaves Windows PowerShell and native Linux behavior
unproven.

## R11 - Security, Architecture, and A11Y Applicability

**Decision**: Security, Architecture, iSAQB quality scenarios, A11Y,
Cross-Platform, Agent Parity, and Autonomous Run are `Applicable`. Parallel
Autonomous Run is `N/A` because delivery is serial. ASVS, SBOM/VEX/AI-SBOM,
SLSA, Zero Trust, C3A/C5, and regulatory scope are justified `N/A` unless
implementation changes the accepted boundaries.

**Rationale**: Path input, deterministic output, text accessibility, and
multi-repository evidence are material. Product/network/release boundaries are
not.

**Alternatives considered**: Mark the change documentation-only and skip
security/architecture tests. Rejected because executable renderers process
untrusted paths and publish tracked files.

## R12 - Branch and Delivery Order

**Decision**: Deliver serially: Home Baseline, Agent Operations Cockpit,
TinyPl0, TinyCalc, InventarWorkerService, TuiVision, sandbox. Use one numbered
feature branch and one PR per repository. Verify and synchronize the default
branch after each merge before advancing.

**Rationale**: Home establishes the shared contract; AOC is its first targeted
consumer; remaining repositories have independent local implementations but
share fleet evidence. Serial closeout prevents a later repository from
claiming an unreviewed upstream contract.

**Alternatives considered**: Parallel worktrees or a single fleet branch.
Rejected because the accepted run is non-parallel and repositories have
separate histories, policies, and gate evidence.

## R13 - Sandbox Ahead-of-Main State

**Decision**: Preserve the current sandbox branch untouched during planning.
Before implementation, require an external terminal decision for Feature 003
and a clean, synchronized default-branch base before creating
`004-linked-intake-evidence`. Do not rebase, reset, force-switch, or assume the
two local commits may be carried into this feature.

**Rationale**: The branch is clean and internally synchronized with its remote
tracking branch, but it is intentionally two commits ahead of `origin/main`.
Stacking unrelated work would blur ownership and rollback.

**Alternatives considered**: Branch directly from the current head or rebase it
onto `origin/main`. Rejected as unauthorized mutation and unsafe history
coupling.

## R14 - Documentation, Statistics, and Home Sync

**Decision**: Record exactly one `GeneratedUpdate` decision in each repository
and update the local statistics ledger after the completed implementation
phase. Home Baseline script changes are `homeRuntime`; its feature docs are
`sourceOnly`. Therefore only Home Baseline requires the later check/apply/check
Home Sync sequence after merge. Other repositories use their local distribution
contracts and do not inherit Home Sync.

**Rationale**: `scripts/config/home-sync-manifest.json` includes `scripts/`
under `homeRuntime`, while feature docs and specs are source-only. Distribution
is repository-specific.

**Alternatives considered**: Declare the entire fleet source-only or run Home
Sync for every repository. Rejected because both contradict the manifest-bound
distribution model.

## R15 - Product and Dependency Boundary

**Decision**: Add no package, lockfile, product project, runtime endpoint,
business behavior, public type, image layer, or Compose change. If a new
dependency or product/runtime edit becomes necessary, stop and return to a
separate reviewed plan and supply-chain decision.

**Rationale**: The accepted feature is a documentation-renderer harmonization,
not a product expansion.

**Alternatives considered**: Use a third-party Markdown/JSON/schema library.
Rejected because standard runtimes are sufficient and LAF-035 forbids a new
dependency.
