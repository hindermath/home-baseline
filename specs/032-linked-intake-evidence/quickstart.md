# Quickstart: Implement and Verify Linked Intake Evidence

## Purpose and Safety Boundary

This is the implementation-phase runbook. Planning created no branch, commit,
push, merge, Home Sync, renderer output, or change in another repository.
Before using any write command below, revalidate the active autonomous state,
fresh remote state, local governance, and repository-specific help.

Work serially. Do not begin the next repository until the current repository
is merged and verified on its default branch. Never normalize a checkout with
reset, rebase, force checkout, or automatic stash.

## 1. Validate the Plan Package

From Home Baseline on `032-linked-intake-evidence`:

```bash
git status --short --branch
find specs/032-linked-intake-evidence -maxdepth 2 -type f -print | sort
rg -n 'NEEDS CLARIFICATION|\[FEATURE\]|\[DATE\]|TODO' \
  specs/032-linked-intake-evidence/plan.md \
  specs/032-linked-intake-evidence/research.md \
  specs/032-linked-intake-evidence/data-model.md \
  specs/032-linked-intake-evidence/contracts \
  specs/032-linked-intake-evidence/quickstart.md
git diff --check
```

The placeholder search succeeds only when it finds no unresolved planning
marker. Existing accepted feature artifacts may remain uncommitted until the
autonomous runner reaches its authorized delivery phase.

## 2. Revalidate Every Delivery Base

For each registered checkout, inspect the repository-local agent guidance and
script help first, then capture fresh read-only evidence:

```bash
git status --short --branch
git remote -v
git fetch --prune origin
git rev-parse HEAD
git rev-parse origin/main
git rev-list --left-right --count HEAD...origin/main
```

Use the actual remote default branch when it is not `main`. A fetch changes
remote-tracking state and therefore belongs to implementation preflight, not
Plan.

For `absdd-image-sandbox`, stop unless Feature 003 has a terminal delivery
decision and a clean, freshly synchronized default-branch base is available.
Do not create Feature 004 from the observed
`003-secure-development-container-hardening` head and do not rebase or reset
that branch.

## 3. Implement Canonical Sources First

Within one repository only:

1. create the freshly validated numbered feature branch;
2. add or update typed renderer declarations, explicit feature proofs, and
   fixtures without changing series meaning;
3. update the repository-local renderer and tests;
4. run safe/check mode and confirm stale output with zero writes;
5. run write mode once to regenerate only owned views;
6. run write mode again and prove zero additional change;
7. update evidence, documentation impact, and statistics from their canonical
   sources; and
8. review the complete diff before any commit.

Do not edit a generated marker or statistics profile as its own source.

## 4. Repository-Native Checks

The exact commands are finalized from each repository's current help and
guidance during implementation. The expected command families are:

### Home Baseline and Agent Operations Cockpit

```bash
bash -n scripts/lib/secure-development-hardening.sh
bash scripts/prepare-secure-development-hardening.sh --help
bash scripts/prepare-secure-development-hardening.sh --dry-run
pwsh -NoProfile -File scripts/prepare-secure-development-hardening.ps1 -Help
pwsh -NoProfile -File scripts/prepare-secure-development-hardening.ps1 -WhatIf
bash scripts/test-requirements-intake-governance.sh
pwsh -NoProfile -File scripts/test-requirements-intake-governance.ps1
```

Run the repository's renderer fixtures and parity test, then Home Baseline's
configured secret scan and PowerShell analyzer. The real Home renderer write
is permitted only after dry-run/`-WhatIf` agree. Reinstall hooks only if a hook
source changes, which is not expected.

### TinyPl0, TinyCalc, and TuiVision

```bash
node --check scripts/render-requirements-intake-governance.mjs
node scripts/render-requirements-intake-governance.mjs --help
```

Use each repository's existing check/write flags and its local Node alignment
test. Do not invent a common flag when a renderer already has another CLI.
TuiVision additionally runs every assertion in
[tuivision-exact-contract.md](contracts/tuivision-exact-contract.md).

### InventarWorkerService and `absdd-image-sandbox`

Add the planned dependency-free repository-native pair at
`scripts/render-requirements-intake-governance.sh` and `.ps1`, its paired tests
at `scripts/test-requirements-intake-governance.sh` and `.ps1`, fixtures below
`scripts/tests/linked-intake-evidence/`, the Bash manpages, and complete
bilingual PowerShell help. The PowerShell scripts expose
`Invoke-RequirementsIntakeGovernanceRender` and
`Test-RequirementsIntakeGovernance` as advanced functions. InventarWorkerService reads
`requirements/intakes/series/inventar-worker-service/manifest.json`; the
sandbox reads `specs/intake-series/sandbox-development-lifecycle/manifest.json`.
Run syntax/parser checks, the manifest fixture suite, check/write/check, and
the repository-local secret scan. Product builds, image builds, and
`podman-compose config` are `N/A` for the planned documentation-only diff; they
become mandatory if implementation unexpectedly touches their scope, and that
scope change first returns to plan review.

## 5. Idempotence and Diff Boundary

After the second unchanged render:

```bash
git diff --check
git status --short
git diff --stat
git diff --name-only
```

Verify that changed paths are limited to canonical renderer/fixture sources,
owned generated views, required help/manpages, governance evidence, feature
artifacts, and statistics sources/outputs. Fail the gate if package manifests,
lockfiles, product projects, runtime code, public APIs, image definitions, or
Compose files changed.

## 6. Platform Proof

Run macOS safe mode first. Bind Linux and Windows proof to the exact same commit
using native or approved isolated runners. Each evidence record includes the
commit, command, runner/platform, exit code, payload SHA-256, decision SHA-256,
and write count. Bash/PowerShell parity must use the same fixtures. A syntax
check or non-native run remains partial evidence and does not close the native
platform gate.

## 7. Review and Delivery

For each repository:

1. complete local and platform gates;
2. commit and push only under the delivery phase's current authority;
3. open one focused PR and resolve every review conversation;
4. wait for required status checks on the current head;
5. merge without bypass unless the narrow protection-only exception in
   [fleet-evidence-and-delivery.md](contracts/fleet-evidence-and-delivery.md)
   is fully satisfied;
6. verify the merged default-branch SHA and renderer check mode; and
7. close/archive the repository evidence before advancing.

If any gate fails, stop the serial sequence and keep later repositories
untouched.

## 8. Home Sync Boundary

Only Home Baseline's script changes are `homeRuntime`. After its source change
has merged and only when the autonomous delivery phase still has sync
authority, run the repository's documented sequence from the stable clone:

```bash
bash scripts/sync-home.sh --check-only
bash scripts/sync-home.sh --no-pull
bash scripts/sync-home.sh --check-only
```

Review conflicts before any force option; force is not part of this plan.
Feature specs, evidence, documentation, and statistics remain `sourceOnly`.
No other repository receives Home Sync.

## 9. Rollback

Stop at the affected repository, use a reviewed revert, regenerate all owned
views from restored canonical sources, and rerun check/idempotence evidence.
For an already distributed Home runtime, perform the approved Home Sync
check/apply/check only after the source revert merges. Never roll back the fleet
with reset/rebase and never alter the sandbox's pre-existing Feature 003 work.
