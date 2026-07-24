# Validation Evidence: Active Lastenheft Normalization

## Scope

- Active root intakes: 14
- Creator-native before normalization: 3
- Current `LegacyAdoption` receipts: 10
- Current `Supersession` receipts: 4
- Current receipt schemas: one schema 2.0 and 13 schema 1.1
- Creator-native position-4 intake: 1, now superseded in place
- Historical root intakes changed: 0
- Learning-series intakes changed: 0 of 222

## Intake And Review Validation

- Every active intake has exactly one complete Creator marker set.
- Every active intake has exactly one `$speckit-specify` and one
  `$speckit-autonomous` invocation.
- Every generated Autonomous prompt uses `LocalImplementation`.
- Bash and PowerShell accepted all 14 current receipts.
- Bash and PowerShell accepted the 14-target series review as `Ready`.
- Intake Review Governance v0.1.1 accepted the schema-1.1 request binding,
  eight exact roots, nine unique order-consistent DAG edges, all target roles,
  and all 14 current target hashes.
- Intake Authoring Governance v0.2.0 accepted the position-1 schema-2.0
  supersession with stable intake and operation identities, two ordered
  sources, archived prior evidence, and `LocalImplementation` authority.
- The queue-to-receipt mapping is exactly 14:14 without duplicate targets.

## Remote-Freshness-Barrier Supersession

- The position-4 intake preserves `PWH-001` through `PWH-011` and `AC-001`
  through `AC-012`.
- `PWH-012` through `PWH-015` define complete fleet inventory, safe fetch,
  fast-forward-only pull classification, the downstream mutation barrier, and
  deterministic text-first fleet evidence.
- `AC-013` through `AC-017` require operation ordering, safe fast-forward
  behavior, non-mutating refusal cases, continued audit after an early
  finding, and Bash/PowerShell parity.
- The previous intake-authoring receipt is archived byte-for-byte and the new
  receipt uses schema-1.1 `Supersession` provenance with explicit update
  authority.
- The previous Series request, result, and report are archived byte-for-byte
  under their former review ID.
- The position-4 Series result remains preserved under review ID
  `dfcf1ff5-95ad-488a-879a-65e81e8e350f`.

## Position-1 Maintenance Intake Supersession

- The position-1 intake now reflects 32 active registered Level-1/Level-2
  repositories, three currently checked-out preset repositories, and ten
  desired preset repositories.
- The Bash 3.2 empty-array correction delivered through PR #90 and the four
  optional Homebrew classifications are recorded as current baselines and
  regression obligations, not new product fixes.
- Manifest, orchestration, clone-on-missing, and final reporting remain
  position-1 scope. Remote freshness, arbitrary default branches, worktree
  cleanup, and hard-abort cleanup remain position-4 ownership.
- The prior target and receipt are archived byte-for-byte. The new receipt uses
  schema-2.0 `Supersession` provenance with explicit current update authority.
- The renewed Series result has review ID
  `5ce575e0-90a0-4946-b183-b8c3e1d83a71`, supersedes
  `dfcf1ff5-95ad-488a-879a-65e81e8e350f`, and binds request SHA-256
  `df0b897e276ab82eaa6ad90f76abad3370211a897942a5d094da60b2a421e187`.

## Preset Validation

- Canonical scaffold, publication copy, and installed preset copy are
  byte-identical.
- The v0.1.1 fixture suite passed for all three copies.
- Positive cases cover Git-blob and snapshot-only legacy adoption.
- Negative cases reject missing update authority and mismatching legacy hashes.
- PSScriptAnalyzer 1.25.0 reported no Error or Warning finding across 108 files.
- `specify check` passed.
- Gitleaks found no secret in the current Git diff.

The prior package-validation run installed all ten local presets in an
isolated temporary Spec Kit project at
priorities `10`, `20`, `30`, `40`, `50`, `60`, `64`, `65`, `70`, and `80`.
Install, Disable/Enable, Remove/Reinstall, and unique Codex skill generation
passed for Intake Authoring v0.1.1.

## Statistics Boundary

The update-log entry and phase slot are prepared. The canonical statistics
renderer correctly reports drift but refuses to write while the working tree
is dirty. Profile 2 must therefore be rendered after the implementation commit
and committed as the normal statistics follow-up. Its 146 deterministic
renderer assertions already pass.

## Delivery Boundary

No Specify, Autonomous, or Parallel Autonomous feature run was started.
No preset release, fleet propagation, commit, push, pull request, or merge was
performed by this implementation.
