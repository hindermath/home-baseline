# Research: Registered Documentation Architecture Adoption

## Decision 1: Use The Versioned Fleet Manifest As Scope Authority

- **Decision**: Resolve active targets from
  `scripts/config/agentic-workspace-fleet.json`; validate the operational
  registry but do not add filesystem discoveries to scope.
- **Rationale**: The manifest distinguishes canonical repositories, preset
  repositories and collection-only targets and is the current reviewed source.
- **Alternatives rejected**: Historic fixed counts and recursive directory scans
  can silently omit or add targets.

## Decision 2: Central Evidence, Repository-Owned Changes

- **Decision**: Keep the complete decision matrix and deterministic validator in
  Feature 023. Create a target PR only when a repository-specific gap requires a
  real documentation change.
- **Rationale**: Central evidence proves completeness without forcing every
  repository to host duplicated campaign metadata.
- **Alternatives rejected**: One empty evidence PR per target violates D7;
  copying one Level-0 guide into every target would misstate local architecture.

## Decision 3: Four Mutually Exclusive Final Outcomes

- **Decision**: Use `Adopted`, `AlreadyAligned`, `NotApplicable`, and `Blocked`.
- **Rationale**: These distinguish delivered change, equivalent existing
  coverage, legitimate non-applicability and an unresolved local safety state.
- **Alternatives rejected**: A generic `Pass/N/A` pair conflates unchanged
  quality with non-applicability and cannot express blocked ownership.

## Decision 4: Feature-022 Claims Are Candidates, Not Mandatory Copies

- **Decision**: Each target evaluates the 17 `AEC###` claims. A target may cover
  a claim under different wording or may reject it as Level-0-specific.
- **Rationale**: D6 records the Level-0 operating contract. D7 extracts portable
  decision patterns while preserving project reality.
- **Alternatives rejected**: Mandatory one-to-one claim adoption would expand
  runtime and documentation scope and create false statements.

## Decision 5: Keep Maintenance-Package Drift Outside D7

- **Decision**: Record current propagation drift as an operational boundary and
  never use D7 to copy executable maintenance files.
- **Rationale**: The check-only preflight found broad drift after Features
  019-022, but D7 explicitly forbids runtime, workflow and toolchain changes.
- **Alternatives rejected**: Running `--repair-drift` would modify scripts and
  violate Feature 023's accepted scope.

## Decision 6: Block Local Ownership Conflicts Per Repository

- **Decision**: A dirty or non-default checkout remains `Blocked`; the rest of
  the fleet proceeds. Existing user work is never stashed, reset or cleaned.
- **Rationale**: This preserves user ownership while satisfying complete fleet
  inventory.
- **Observed case**: `AgentOperationsCockpit` is on a non-default branch with a
  local managed-file change and therefore cannot be changed by D7.

## Decision 7: Deterministic Matrix Validator

- **Decision**: Add a feature-local Python standard-library validator and
  positive/negative fixtures for fleet cardinality, unique decisions,
  applicability, Documentation Impact, delivery evidence and path safety.
- **Rationale**: Human review remains necessary for meaning, while deterministic
  structure catches omissions, duplicate targets and invalid completion claims.
- **Alternatives rejected**: Prose-only evidence cannot reliably prove 100%
  target coverage or one-decision-per-target.

## Decision 8: Serial Delivery

- **Decision**: Inventory may be read concurrently, but evidence writers and
  repository deliveries remain serial.
- **Rationale**: Branch, PR, review, statistics and Series closeout state are
  shared mutable surfaces.
- **Parallel preset**: `N/A`; Feature 023 is one serial autonomous run.
