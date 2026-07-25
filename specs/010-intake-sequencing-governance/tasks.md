# Tasks: Intake Sequencing Governance

## Phase 1: Foundation

- [x] T001 Verify branch, feature metadata, bootstrap receipt, and review.
- [x] T002 Create `pr-evidence.md` before implementation changes.
- [x] T003 Record accepted scope, authority, preset matrix, and stop boundaries.
- [x] T004 Define manifest, receipt, operation, tombstone, and policy schemas.
- [x] T005 Define stable Bash/PowerShell error classes and exit codes.
- [x] T006 Capture unchanged hashes of existing eight-, nine-, and ten-preset profiles.

## Phase 2: Validators First

- [x] T007 Add a positive three-target fixture.
- [x] T008 Add the read-only 13-target/6-root/15-edge field fixture.
- [x] T009 Add path, duplicate-target, and identity negative fixtures.
- [x] T010 Add reference, self-edge, duplicate-edge, and type negative fixtures.
- [x] T011 Add order, cycle, root, and indegree negative fixtures.
- [x] T012 Add lifecycle, hash, receipt, authority, archive, and tombstone negative fixtures.
- [x] T013 Implement the Bash manifest validator.
- [x] T014 Implement the PowerShell manifest validator.
- [x] T015 Implement the Bash receipt validator.
- [x] T016 Implement the PowerShell receipt validator.
- [x] T017 Add one shared PowerShell fixture runner for both shell variants.
- [x] T018 Prove Bash/PowerShell result and error-class parity.

## Phase 3: Portable Preset

- [x] T019 Add preset metadata for v0.1.0 and Spec Kit >=0.8.3.
- [x] T020 Add the series policy template.
- [x] T021 Add manifest and receipt templates.
- [x] T022 Add operation and tombstone templates.
- [x] T023 Add order document, checklist, runbook, and field-summary templates.
- [x] T024 Add the agent-guidance addendum.
- [x] T025 Add `speckit.intake-series-create`.
- [x] T026 Add `speckit.intake-series-read`.
- [x] T027 Add `speckit.intake-series-update`.
- [x] T028 Add `speckit.intake-series-delete`.
- [x] T029 Add `speckit.intake-series-status`.
- [x] T030 Add `speckit.intake-series-next`.
- [x] T031 Document read-only and no-implicit-execution boundaries in every command.
- [x] T032 Add bilingual README and package documentation.
- [x] T033 Add Bash manpages and PowerShell comment-based help.
- [x] T034 Synchronize canonical scaffold and publication copy.

## Phase 4: Repository Integration

- [x] T035 Add the optional eleven-preset profile at priority 66.
- [x] T036 Register the profile without changing existing defaults.
- [x] T037 Register package files in maintenance propagation.
- [x] T038 Register the publication repository in the fleet inventory.
- [x] T039 Update shared agent guidance on sequencing handoff.
- [x] T040 Update preset catalog and learner-facing priority documentation.
- [x] T041 Record Legacy Adoption field validation.

## Phase 5: Validation

- [x] T042 Run Bash syntax, PowerShell parser, and PSScriptAnalyzer.
- [x] T043 Run positive and negative validator fixtures.
- [x] T044 Prove canonical/publication byte parity.
- [x] T045 Prove existing preset-profile hashes unchanged.
- [x] T046 Run `git diff --check`, secret scan, homogeneity, and `specify check`.
- [x] T047 Validate add/list/info/resolve/disable/enable/remove/reinstall in a temporary project.
- [x] T048 Prove all six commands appear exactly once on supported agent surfaces.
- [x] T049 Prove no downstream workflow starts implicitly.
- [ ] T050 Update project statistics and final evidence.

## Phase 6: Delivery

- [ ] T051 Commit and push the Home Baseline feature branch.
- [ ] T052 Create the Home Baseline PR and converge mandatory checks/reviews.
- [ ] T053 Merge normally and synchronize local `main`.
- [ ] T054 Create or update the owned publication repository through a PR.
- [ ] T055 Publish tag and release `v0.1.0`.
- [ ] T056 Validate the versioned GitHub ZIP and checksum.
- [ ] T057 Propagate the optional profile with `required: false` to the registered fleet.
- [ ] T058 Converge non-empty fleet PRs without inferred bypass.
- [ ] T059 Submit through the official community preset template and ping `@mnriem` once.
- [ ] T060 Verify all changed repositories are clean and synchronized.
