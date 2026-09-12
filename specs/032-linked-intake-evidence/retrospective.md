# Autonomous Run Retrospective

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | `032-linked-intake-evidence` at Home base `a894fff3709ce02d05a499c54e43156e83746277` before causal closeout |
| Delivery evidence | `evidence/v1/delivery.json`, `evidence/v1/fleet-acceptance.json`, `evidence/v1/final-0-0.json` |
| Delivery mode | `MergeAndSync` with admin bypass only after protection-only refusal |
| Remote result | Seven repository PRs merged and seven Default-Branches synchronized at `0/0`; Home closeout remains T160–T167 |
| Interruptions and resumes | Run `c53e4b5b-74fa-4ff9-ac5e-ce51850a5321`; controlled resumes preserved task, authority and exact-head evidence state |

## Observations

| ID | Observation | Artifact kind | Project exclusions | Generic target rule | Occurrences | Confidence | Permission risk | Reproducible test | Decision |
|---|---|---|---|---|---:|---|---|---|---|
| AR-001 | Manifest-driven five-field views remained portable across Bash, PowerShell, Node and seven differently structured repositories. | Renderer/test contract | TuiVision exact 10/6/1 counts remain project-specific. | Keep canonical manifest ownership, strict paths, explicit terminal feature proof, atomic publication and second-render zero-write behavior. | `7` | High | Low; local writes only in explicit write mode. | Repository-local positive/negative/atomic/idempotence suites and `AC-LAF-002`–`007`. | ObserveAgain |
| AR-002 | Synthetic expected-output Markdown fixtures caused a false-positive global link crawl although the renderer and real views were correct. | CI/link gate | Exact fixture directory names differ by repository. | Exclude test-only expected-output fixture roots from navigable-document link gates while retaining direct fixture contract tests. | `1` | High | Low; CI configuration only. | Sandbox link gate before/after bounded exclusion plus unchanged renderer tests. | NoPromotion |
| AR-003 | One complete native proof per unchanged exact head provides the required Linux/Windows evidence without duplicate CI cost. | Workflow/orchestration rule | Runner durations and commands remain repository-local. | Cancel only semantically duplicate same-head runs; rerun once after an actual input/head change or a concrete failure. | `7` | High | Medium; incorrect cancellation could remove unique evidence. | Match event head, workflow hash, command set and matrix before cancellation; require both native jobs terminal. | ObserveAgain |
| AR-004 | Merge-commit trees equaled reviewed candidate trees in every repository, allowing a bounded current-view proof without rerunning unchanged content gates. | Delivery evidence | Does not apply to squash/rebase or post-merge writer workflows. | Compare reviewed-head and merged-default tree IDs; rerun content gates only when the tree changes. | `7` | High | Medium; merge strategy or post-merge mutation must be checked. | `git rev-parse HEAD^{tree}` versus reviewed-head tree after fresh fetch. | ObserveAgain |
| AR-005 | Repository-local five-gate requirements prevented a local success from masquerading as the final fourteen-gate fleet decision. | Evidence schema | Gate IDs and scopes are feature-specific. | Validate each repository against its reviewed local requirements, then aggregate exactly one Primary row per global acceptance gate after all rows are terminal. | `7` | High | Low; fail-closed validation. | Schema-2.0 local PreMerge/PostMerge validation plus final 14-gate validator. | ObserveAgain |
| AR-006 | Copilot quota unavailability did not require weakening material review gates when exact-head native/static/security checks and an explicitly authorized independent or compensating review were recorded. | Review governance | Provider/quota state and available independent reviewer vary. | Never claim self-approval; record provider unavailability, compensating scope, zero findings/conversations and the still-visible protection-only refusal. | `3` | Medium | High; review evidence must not become an approval bypass. | PR check/review/conversation snapshot bound to the exact head. | NoPromotion |

Correctness, security, permission, and evidence-integrity findings remain
head- and hash-bound. Efficiency behavior is retained only where repeated
field evidence exists and never suppresses a unique required gate.

## Rejected False Positives

- Link failures inside `scripts/tests/linked-intake-evidence/**/expected-*.md`
  were rejected as navigable-document defects only after the real generated
  views and direct fixture tests stayed green. The bounded CI exclusion is
  recorded in the sandbox candidate and product-boundary evidence.
- A cancelled pull-request-event native matrix was not treated as a material
  failed check because the already active push-event matrix completed on the
  same head, workflow and commands for both Linux and Windows.
- Formal GitHub `REVIEW_REQUIRED` was not reported as a technical failure after
  all material checks and compensating review passed; it remained visible as
  the protection-only condition required before authorized admin bypass.

## Residual Risks and Follow-ups

- Hosted runner images, provider protection and review availability can change;
  re-evaluate on workflow, runner, permission or provider-state changes.
- Portable evidence intentionally omits raw logs and private paths. The local
  runtime evidence is still required for deep incident reconstruction.
- TuiVision's exact 10/10 mappings, 6/6 dependency tuples, latest 1/1 and
  backlog 1/1 remain a project-specific locked contract, not a generic count.
- No follow-up feature is started and no additional mutation authority is
  inferred from these observations.

## Outcome

- Local non-empty correction: seven repository renderer/documentation slices,
  their causal delivery records, and the Home portable closeout artifacts.
- Portable handoff: `specs/032-linked-intake-evidence/evidence/v1/index.json`.
- Pending observations: `AR-001`, `AR-003`, `AR-004`, `AR-005` for later
  separately authorized promotion review.
- Rejected project details: TuiVision fixed counts and Sandbox Feature-003
  lineage are retained only in their explicit evidence.
- Next field gate: Home causal closeout T160–T168; no next feature started.
- Resume-state quality: `Valid`; task count, exact next action, authority and
  repository-local evidence were preserved across resumes.
