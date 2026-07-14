# Preset Follow-up: 026 Component and Data Conformance Hardening

## Delivery Evidence

| Field | Value |
|---|---|
| Source feature | `026-component-data-conformance-hardening` |
| Feature PR | `hindermath/TuiVision#74` |
| Feature head | `00b8bbb9c7154e0c4e84e9be48584d66f1ec5213` |
| Feature merge | `f3586aa5597d69756419a11dc23238929c914b9e` |
| Supplemental Windows proof | Actions run `29291308306`, head `e55b07531ae1ce72bf25fbcf1ae74310e3db6265`, branch deleted without merge |
| Delivery mode | `MergeAndSync` |
| Required checks | PR-context CI, DocFX/Axe, three-OS tooling, supply-chain, Gitleaks, secret scan, and Claude passed; supplemental Windows runtime and DocFX passed after merge |
| Review state | Claude passed with no findings; GraphQL reported zero threads and zero conversation comments; Copilot was unavailable because requester quota was exhausted |
| Permission boundary | Admin bypass was limited to the sole Human Approval rule after the PR-context technical checks passed; it did not and cannot supply the initially missing Windows runtime proof |
| Source evidence | `hindermath/TuiVision@f3586aa:specs/026-component-data-conformance-hardening/pr-evidence.md`, PR #74, and immutable Actions run `29291308306` |

## Workitem AR-026-01: Enforce Acceptance-Gate Execution Mapping

| Field | Value |
|---|---|
| Observation | Feature 026 explicitly required macOS, Linux, and Windows/WSL proof. PR #74 was merged after every visible technical check was green, but its Windows job was the tooling-only Homogeneity workflow. The CI workflow executed the 748 runtime tests only on Ubuntu and macOS. The missing Windows proof was detected during the retrospective and closed by temporary, unmerged Actions run 29291308306, which passed Release build, all 748 tests, and DocFX with 0 warnings and 0 errors on `windows-latest`. |
| Artifact kind | Command, generated skill, runbook, tasks addendum, evidence template, readiness checklist, agent addendum, field-validation summary, and deterministic validation-automation requirement |
| Home-Baseline target surfaces | `commands/speckit.autonomous.md`, generated agent skills, `templates/autonomous-runbook-template.md`, `templates/tasks-addendum.md`, `templates/autonomous-run-evidence-template.md`, `templates/autonomous-run-readiness-checklist-template.md`, `templates/agent-file-addendum.md`, `templates/field-validation-summary.md`, and any proven cross-platform validator payload |
| TuiVision-specific exclusions | Do not promote TuiVision workflow names, .NET commands, Windows as a universal requirement, test totals, DocFX, numbered branches, build counters, temporary proof branches, Turbo Vision source rules, or Feature-024 schemas. |
| Generic target rule | Every accepted gate marked `Applicable` must have a machine-checkable evidence row that binds the requirement to the exact reviewed head, provider run, workflow, job, runner or platform, executed command, result, and evidence URL or immutable identifier. A green aggregate status, job name, platform label, approval, or bypass never satisfies a row whose required command did not execute. Any missing or contradictory Applicable row blocks merge. `N/A` requires rationale and a re-evaluation trigger. |
| Required evidence shape | `GateId`, `Applicability`, `RequiredScope`, `HeadSha`, `Provider`, `RunId`, `Workflow`, `Job`, `RunnerOrPlatform`, `ExecutedCommand`, `Result`, `EvidenceReference`, `Rationale`, and `ReevaluationTrigger`. The validator must reject empty starter rows and duplicate primary evidence for the same gate unless the relationship is explicitly supplemental. |
| Occurrence count | Two deterministic evidence-integrity failures: Feature 025 and Feature 026. Feature 025 produced the v0.1.2 prose rule; Feature 026 reproduced the same invalid readiness decision while v0.1.2 was installed and active. |
| Confidence | High. Workflow definitions and immutable run logs objectively show which commands ran. The successful supplemental Windows jobs for both features demonstrate the missing scope independently. |
| Permission risk | High. A false-ready result can authorize an invalid merge. Validation must remain read-only and cannot infer push, PR, merge, bypass, or publication authority. A bypass must never convert missing technical evidence into a pass. |
| Reproducible test | In a temporary project, define an Applicable gate requiring a runtime command on three platforms. Provide green runtime jobs for two platforms and a green tooling-only job named after the third platform. Require the validator to fail before merge. Add a third-platform runtime job on the same head and require the validator to pass. Repeat with an `N/A` row missing its re-evaluation trigger and require failure. |
| Decision | `Promote`. Text-only guidance was insufficient after the first occurrence; the second independent recurrence justifies deterministic validation automation or an equally machine-checkable provider-neutral gate. |

## Proposed Portable Surfaces

| Surface | Required change |
|---|---|
| `commands/speckit.autonomous.md` | Require the machine-checkable gate matrix before any merge decision and stop when an Applicable row lacks exact-head executed-command evidence. |
| Generated agent skills | Preserve the same fail-closed matrix rule on every supported agent surface without granting remote authority. |
| `templates/autonomous-runbook-template.md` | Separate visible check status, executed technical scope, and accepted gate coverage; require exact-head reconciliation immediately before merge. |
| `templates/tasks-addendum.md` | Add dependency-ordered tasks to declare gates before implementation, populate immutable execution evidence after CI, and validate completeness before merge. |
| `templates/autonomous-run-evidence-template.md` | Add the structured gate-evidence fields and distinguish primary from supplemental runs. |
| `templates/autonomous-run-readiness-checklist-template.md` | Reject readiness for missing, contradictory, stale-head, empty, or job-name-only evidence. |
| `templates/agent-file-addendum.md` | State that a green check and a platform label prove only commands actually executed on the reviewed head. |
| `templates/field-validation-summary.md` | Record Features 025 and 026 as two independent field failures and their supplemental proof runs. |
| Scripts or validator payload | Home Baseline must evaluate a provider-neutral machine-readable validator. If executable scripts are included, Bash and PowerShell parity, clean error channels, missing-dependency failure, and temporary-project fixtures are mandatory. Repeating prose alone is not an acceptable v0.1.3 remediation. |

## Package Boundary

This workitem does not itself modify, version, publish, or adopt the preset. It
does not authorize a pull request, merge, bypass, public release, or upstream
issue update. Home Baseline owns the bounded implementation, temporary-project
validation, seven-preset composition, generated-agent parity, tag-ZIP smoke,
and release decision.

The public v0.1.3 release passed package and ZIP checks. During TuiVision
adoption, Spec Kit copied the Bash validator without its Git executable mode.
The documented `bash` invocation worked, as did the PowerShell surface, but the
ambiguous direct-path contract was not portable. A bounded v0.1.4 packaging
patch therefore completes adoption before Feature 028.

## Promotion Status

| Field | Value |
|---|---|
| Target version | Gate schema and validators in v0.1.3; installer-stable invocation in v0.1.4 |
| Portable surfaces | Command, generated skill, constitution/spec/plan/tasks addenda, runbook, evidence, readiness, agent guidance, two JSON templates, field-validation summary, and validator payload |
| Script decision | `Promote`; read-only Bash and PowerShell validators passed equivalent success, tooling-only, stale-head, N/A-trigger, duplicate-Primary, empty-starter, and Supplemental fixtures |
| Local package validation | Pass for v0.1.3; installer-boundary follow-up in `specs/autonomous-run-governance/package-validation-v0.1.4.md` |
| Release-dependent validation | v0.1.3 published; v0.1.4 review/merge, public tag, ZIP smoke, TuiVision adoption, and issue update remain |
