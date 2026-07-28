# Autonomous Run Evidence: Feature 015

## Authority and accepted inputs

- Run ID: `2b72e80e-30e1-4b5e-bc62-3a8697105d5b`
- Delivery mode: `MergeAndSync`
- Branch: `015-windows-maintenance-hardening`
- Starting head: `694429cd0c0a8f683ab1ef93531d36ad5de8625b`
- Binding intake: Windows hardening v1.2, WEM-001 through WEM-013 and
  AC-001 through AC-016.
- Current review: `9a538f3b-3a27-400a-88b6-7bf2db43e340`,
  `Series`, `Ready`, 21 targets, 0 findings.
- Historical baseline: completed Feature 009.
- Admin boundary: visible, policy-compliant admin prompts are permitted for
  the current authorized operation. UAC, safety, test and review gates are not
  technically bypassed.

## Preflight

- Windows and PowerShell 7 were selected according to repository guidance.
- `origin/main` was fetched and fast-forwarded before branch creation.
- GitHub CLI authentication is active for `hindermath` with repository and
  workflow scopes.
- No nonterminal autonomous state or maintenance process remained.
- The canonical series declares Windows hardening as its only explicit
  `Eligible` target.
- Intake authoring, series manifest, series receipt and fresh review validators
  passed.

## Planned validation

The exact commands and results will be recorded after implementation. Required
classes are the Windows hardening fixtures, existing maintenance regressions,
PSScriptAnalyzer, statistics/path parity, secret/homogeneity checks, complete
CheckOnly/WhatIf, exact staged-candidate validation and exact-PR-head provider
gates.

## Test-first baseline

`python scripts/tests/test_windows_maintenance_hardening.py` executed before
product implementation. All ten tests failed only because the new internal
module and its required integration tokens were absent. The red baseline
covered canonical modes, bounded Python probing, bounded retries, process-tree
timeout cleanup, exact resume hashes, Git-normalized line endings, unique
package results, terminal exitcodes, public-script integration and the explicit
eleven-preset profile.

## Implemented contracts

- `scripts/lib/windows-maintenance-hardening.psm1` provides the shared
  PowerShell 7 contracts for one canonical mode, bounded process execution,
  validated Python 3 discovery, transient-only retry, Git-normalized hashes,
  atomic resume evidence, canonical package results and terminal exitcodes.
- `maintain-agentic-workspace.ps1` validates Python 3, the eleven-preset
  catalog entry and PSScriptAnalyzer 1.25.0 before dependent mutation. It
  forwards exactly one mode, correlates the visible result with the current
  JSON report, and accepts dirty repair state only through exact resume
  evidence.
- Git fetch, pull and clone operations are bounded. Authentication and
  repository-state failures are terminal; only classified transient network
  failures are retried.
- WinGet child processes use argument lists, a hard timeout and complete
  process-tree cleanup. Upgrade and install work without current
  administrator-prompt authority is not started. A timeout or unavailable
  interactive completion is visible as `DEFERRED_ADMIN_REQUIRED`; UAC is not
  bypassed.
- Canonical package observations reduce to one final status per
  case-insensitive ID. Propagation reports raw differences separately from
  Git-actionable drift.
- Registry creation and migration use the explicit
  `intake-sequencing-eleven-governance-presets` profile and verify its eleven
  entries fail-closed.

## Local validation completed so far

- `python scripts/tests/test_windows_maintenance_hardening.py`: 10 passed.
  The fixtures include fallback through `python` and `py -3`, two transient
  failures followed by success, terminal authentication failure, process-tree
  timeout cleanup, exact resume hashes, `rawDifferences=93` versus
  `actionableDrift=3`, unique package status, canonical exitcodes and the
  eleven-preset matrix.
- `python scripts/tests/test_agentic_workspace_maintenance.py`: 13 passed,
  1 skipped by platform contract.
- `python scripts/tests/test_maintenance_contracts.py`: 9 passed, 5 skipped by
  platform contract.
- `python scripts/tests/test_home_sync_files.py`: 4 passed.
- `pwsh -NoProfile -File scripts/test-render-project-statistics.ps1`: 146
  assertions passed, including byte-identical WSL Bash/Windows PowerShell
  parity.
- PowerShell parser: all seven changed `.ps1`/`.psm1` files passed.
- Bash parser: both changed `.sh` files passed `bash -n`.
- `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`:
  PSScriptAnalyzer 1.25.0 analyzed 146 files with zero Error or Warning
  findings.
- `pwsh -NoProfile -File scripts/test-script-reference.ps1`: generated
  inventory is idempotent with 120 canonical and 154 embedded scripts.
- `validate-documentation-impact.ps1`: five current decisions passed.
- The real Windows WinGet surface completed `-CompareOnly` without mutation.
  It truthfully reported machine-local missing packages and CLI tools; this
  host drift is not a product-code pass and was not repaired by the feature
  run.

## Security, architecture, accessibility and standards disposition

- Trust boundaries are explicit at filesystem paths, Git remotes, Python
  launchers, WinGet/package sources, child-process trees and UAC. Validated
  arguments, bounded retries, fail-closed hashes, least privilege and
  process-tree cleanup provide defense in depth.
- PowerShell 7/.NET and Python remain memory-safe primary languages. No
  `Invoke-Expression`, shell-built command string, credential persistence,
  UAC automation, force push, hard reset or foreign-change discard was added.
- NIST SSDF, CWE Top 25, CAPEC process/path/argument patterns, OWASP SAMM and
  OpenSSF review are applicable and represented by tests and gates. ASVS,
  SBOM/VEX/SLSA, AI-SBOM, Zero Trust, BSI C3A/C5 and regulatory profiles remain
  `N/A`: no web/API, new dependency, release artifact, runtime AI, cloud or
  regulated product scope was introduced.
- CLI output remains text-first and status is not color-only. User-facing
  additions are German-first/English-second and usable in linear screenreader,
  Braille and text-browser flows.
- All five shared agent-guidance surfaces were reviewed. No new durable agent
  rule emerged, so `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md` and
  `.github/agents/copilot-instructions.md` intentionally remain unchanged.
- Documentation Impact is recorded in
  `documentation-impact-evidence.json`; sanitized success, deferred, retry
  exhaustion and resume hard-stop examples are stored in
  `sanitized-report-examples.json`.

## Delivery boundary

Only Level 0 is delivered. The feature does not commit or push maintenance
target repositories, bypass UAC, discard foreign changes, or start a successor
feature. Final Git inventory runs after merge and local default-branch sync.
