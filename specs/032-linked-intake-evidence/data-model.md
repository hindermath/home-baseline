# Data Model: Linked Intake Evidence

## Purpose

This model defines the typed projection between repository-local canonical
series data, feature evidence, deterministic Markdown output, and delivery
evidence. It is an implementation contract, not a new persisted product API.
Each repository may express the types in its existing scripting language, but
the fields, invariants, and state transitions remain equivalent.

## RepositoryTarget

Represents one of the exactly seven accepted repositories.

| Field | Type | Rules |
|---|---|---|
| `repositoryId` | enum | One of `home-baseline`, `agent-operations-cockpit`, `TinyPl0`, `TinyCalc`, `InventarWorkerService`, `TuiVision`, `absdd-image-sandbox` |
| `registeredWorkspace` | repository-relative workspace identifier | Never persisted as a private absolute path |
| `originIdentity` | normalized repository identity | Validated during delivery preflight; credentials and tokens excluded |
| `defaultBranch` | non-empty string | Refreshed before implementation; planning observations are not freshness proof |
| `featureBranch` | non-empty string | One repository-local numbered feature branch |
| `canonicalManifestPath` | safe repository-relative path | Must exist, remain inside the repository, and be the series source |
| `rendererFamily` | enum | `BashPowerShellPair`, `JavaScriptEsm`, or `RepositoryNativeAdapter` |
| `generatedViewPaths` | ordered list of safe paths | Every declared output must have one canonical owner |
| `distributionClass` | enum | Repository-local value; Home distinguishes `homeRuntime` from `sourceOnly` |
| `baseGate` | `GateEvidence` | Must be `Satisfied` before the first write |

Invariant: there are exactly seven distinct `repositoryId` values and no
renderer may read or write another target repository.

## SeriesSnapshot

An immutable, hash-bound parse of one repository's canonical series state.

| Field | Type | Rules |
|---|---|---|
| `schemaVersion` | non-empty string | Must be supported explicitly |
| `manifestPath` | safe path | Repository-contained regular file |
| `manifestSha256` | lowercase SHA-256 | Computed from normalized input bytes under the repository contract |
| `seriesId` | non-empty string | Preserved verbatim after validation |
| `entries` | ordered `IntakeEntry[]` | No duplicate intake path or display position unless the local schema expressly permits it |
| `dependencies` | ordered `DependencyEdge[]` | Every endpoint must identify an entry in this snapshot |
| `backlog` | ordered `BacklogEntry[]` | Separate from active execution order |

The snapshot is rebuilt after canonical input changes. Renderers never mutate
it while projecting views.

## IntakeEntry

| Field | Type | Rules |
|---|---|---|
| `manifestIndex` | positive integer | One-based position in the active manifest array |
| `displayPosition` | positive integer | Explicit stable position when declared; otherwise `manifestIndex` |
| `intakePath` | safe repository-relative path | Existing regular file, no absolute/traversal/option-like/symlink escape |
| `role` | repository-defined enum/string | Preserved; not inferred from filename |
| `lifecycleStatus` | repository-defined enum/string | Preserved exactly; feature state is independent |
| `isRoot` | boolean | Derived only from canonical series data |
| `intakeSha256` | lowercase SHA-256 | Evidence binding, not displayed unless local evidence requires it |

Invariant: changing a row label, link, or feature mapping must not silently
change `displayPosition`, `lifecycleStatus`, `role`, or root semantics.

## DependencyEdge

| Field | Type | Rules |
|---|---|---|
| `fromIntakePath` | safe path | Existing entry in the same snapshot |
| `toIntakePath` | safe path | Existing entry in the same snapshot |
| `kind` | non-empty canonical string | Rendered literally after Markdown escaping |
| `binding` | boolean | Rendered literally as `true` or `false` |

Only direct incoming edges where `toIntakePath` equals the current row are
rendered. Transitive edges are never invented. An entry with no incoming edge
uses the exact root fallback even when it is not the semantic series root.

## FeatureEvidence

| Field | Type | Rules |
|---|---|---|
| `intakePath` | safe path | Exact entry identity |
| `proofKind` | enum | `FeatureBinding`, `ArchivedCloseoutBinding`, or `ReviewedLegacyMapping` |
| `proofPath` | safe path | Existing repository-local evidence file or directory |
| `proofSha256` | lowercase SHA-256 | Binds the reviewed proof material |
| `featureDirectory` | safe path | Existing unique `specs/NNN-slug` directory |
| `featureState` | enum | `Linked`, `NoEvidence`, `Ambiguous`, `Invalid` |

State rules:

- Exactly one valid proof and one existing feature directory yields `Linked`.
- No valid proof yields `NoEvidence` and the exact no-feature fallback.
- More than one valid candidate yields `Ambiguous` and aborts rendering.
- A missing, unsafe, malformed, or contradictory proof yields `Invalid` and
  aborts rendering.
- Lifecycle `Completed` does not imply `Linked`.

## OrderRow

The renderer output projection has exactly these fields in this order:

1. `position`: decimal rendering of `displayPosition`.
2. `status`: escaped `lifecycleStatus`.
3. `intakeLink`: repository-relative Markdown link from the output view to
   `intakePath`.
4. `incomingDependencies`: ordered direct incoming dependency renderings, or
   the exact root fallback.
5. `featureCell`: repository-relative feature link for `Linked`, or the exact
   no-feature fallback for `NoEvidence`.

No additional hidden field may influence row ordering or lifecycle meaning.
Repository-specific explanatory notes are outside the canonical table.

## BacklogEntry

| Field | Type | Rules |
|---|---|---|
| `intakePath` | safe path | Existing backlog intake |
| `status` | canonical string | TuiVision optional NuGet entry is exactly `DeferredOptional` |
| `active` | boolean | Must be `false` for non-executable backlog items |

Backlog entries never consume an active `displayPosition` and never appear as
active dependency endpoints.

## RenderTransaction

| Field | Type | Rules |
|---|---|---|
| `mode` | enum | `Check` or `Write` |
| `inputHashes` | ordered map of safe path to lowercase SHA-256 | Complete canonical input set |
| `plannedOutputs` | ordered list of safe paths | Limited to renderer-owned generated markers/files |
| `beforeHashes` | ordered map | Captured before publication |
| `candidateHashes` | ordered map | Computed fully before a write |
| `afterHashes` | ordered map | Equals candidate hashes after successful write |
| `writeCount` | non-negative integer | Must be `0` in `Check`; second unchanged `Write` also yields `0` |
| `diagnostics` | ordered list of typed diagnostics | Stable code, path-safe message, remediation |
| `result` | enum | `Current`, `Stale`, `Updated`, or `Failed` |

Transition rules:

```text
Parsed -> Validated -> Projected -> Compared -> Current
                                      |
                                      +-> Stale (Check, zero writes)
                                      +-> Published -> Verified -> Updated (Write)
Any pre-publication error ---------------------------> Failed (zero writes)
Any publication/verification error -----------------> Failed (rollback required)
```

All candidate outputs are prepared and validated before publication. A
multi-output renderer must not leave a mixed old/new state.

## GateEvidence

| Field | Type | Rules |
|---|---|---|
| `gateId` | stable string | Repository and checkpoint specific |
| `applicability` | enum | `Applicable`, `N/A`, or `Open` |
| `decision` | enum | `Satisfied`, `NotSatisfied`, or `NotRun` |
| `commitSha` | lowercase Git SHA | Exact tested commit when applicable |
| `command` | string | Exact non-secret command when applicable |
| `platform` | string | OS/runner identity when applicable |
| `exitCode` | integer | Captured without suppressing failure |
| `payloadSha256` | lowercase SHA-256 | Evidence payload binding |
| `decisionSha256` | lowercase SHA-256 | Decision record binding |
| `writeCount` | non-negative integer | Required for safe/check proofs |
| `rationale` | non-empty string | Mandatory for `N/A` |
| `owner` | non-empty string | Mandatory for `Open` |
| `followUp` | non-empty string | Mandatory for `Open` |
| `reevaluationTrigger` | non-empty string | Mandatory for `Open` and scope-sensitive `N/A` |

`Satisfied` is permitted only when the complete command/result/hash evidence
exists. A stale or differently based platform run is `NotSatisfied`, not a
partial success.

## DeliveryRecord

One record exists per repository and binds branch, PR, review, gates, merge,
post-merge default-branch verification, statistics, documentation impact, and
distribution decision. Its states are:

```text
Planned -> BaseReady -> Implemented -> LocallyVerified -> PRReady
        -> Reviewed -> GateReady -> Merged -> DefaultVerified -> Closed
```

Any failed gate moves the record to `Blocked` without advancing another
repository. `RolledBack` records the reverted commit/PR and regenerated output
hashes. Administrative bypass never changes a failed technical gate into a
pass.
