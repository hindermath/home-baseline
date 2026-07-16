# Preset Follow-up: 029 Three-Source Conformance Audit

## Run Evidence

| Field | Value |
|---|---|
| Source feature | `029-tv203-freevision-terminalgui-conformance-audit` |
| Feature PR | `hindermath/TuiVision#84` |
| Feature head | `50b715e5bbebd357ef8b4dc3fa10b435581ca10c` |
| Merge commit | `e825b7d333667d7bd08e239c22e352f9460f24e1` |
| Delivery mode | `MergeAndSync` |
| Product behavior | No runtime, API, dependency, example, or historical-source change |
| Audit result | 48 contracts, 16 domains, 25 pinned Terminal.GUI v1.9.0 records, zero candidate findings |
| Exact-head gates | 10 Primary rows accepted by Bash and PowerShell validators |
| Remote proof | Required checks green; Claude passed; GraphQL review threads zero; Copilot unavailable because of quota |
| Merge boundary | Narrow previously authorized admin bypass applied only to the remaining human-approval rule |

## Workitem AR-029-01: The Package Needs an Operating Guide

| Field | Value |
|---|---|
| Observation | The preset README accurately listed commands and validator invocations but assumed that users already understood delivery modes, convergence, safe boundaries, exact-head evidence, deliberate stop versus interruption, permission wording, and the learning sequence. The user explicitly identified this as a gap for learners and application developers. |
| Artifact kind | README and field-validation summary |
| TuiVision-specific exclusions | Do not promote TuiVision feature numbers, .NET commands, branch versioning, Turbo Vision source policy, DocFX specifics, Wave ordering, or repository protection settings as portable defaults. |
| Generic target rule | Ship an accessible operating guide that explains purpose, audience, non-goals, delivery modes, convergence, installation, complete prompts, status/stop/resume, run-state and gate validation, retrospective learning, teaching order, troubleshooting, and authority boundaries. |
| Occurrence count | One explicit user finding after multiple successful field runs; the short README had remained stable through v0.2.1. |
| Confidence | High that the documentation gap is real; no runtime or orchestration rule change is required. |
| Permission risk | Low. Clearer examples reduce accidental authority expansion. Example bypass text must state that it is not a default. |
| Reproducible test | Give the package README to a user who has not followed the TuiVision field history. Require them to identify the safe default, start a local run, inspect it, stop it, resume it, distinguish all delivery modes, validate exact-head evidence, and explain why installation grants no remote rights. |
| Decision | `Promote` as documentation-only `autonomous-run-governance` v0.2.2. |

## Workitem AR-029-02: Exact-Head Evidence Must Stay Causal

| Field | Value |
|---|---|
| Observation | Feature 029 used ten accepted gates across local and GitHub Actions providers. The immutable final head could be validated only because provider-neutral evidence was created outside the repository. Recording final delivery facts in the same feature commit would have created a new head and invalidated the claim. |
| Artifact kind | Field evidence and documentation clarification |
| TuiVision-specific exclusions | Do not promote run IDs, job IDs, coverage percentages, test counts, or project command names. |
| Generic target rule | Keep accepted gate requirements in the feature. Generate exact-head provider evidence temporarily after final checks. Record immutable delivery facts later through causal closeout without claiming that the closeout proves its own revision. |
| Occurrence count | Reconfirmed in Features 020, 025, 026, and 029. |
| Confidence | High; the Git object relationship is deterministic. |
| Permission risk | Low. The rule prevents misleading proof and grants no remote authority. |
| Reproducible test | Validate a final head with temporary evidence, then commit that evidence and require validation against the new head to fail until new checks exist. Require causal closeout wording to identify the earlier immutable head explicitly. |
| Decision | `NoPromotion` for logic because v0.2.1 already contains the rule; improve the v0.2.2 operating explanation and field evidence only. |

## Workitem AR-029-03: Human Section Labels Are Not State Values

| Field | Value |
|---|---|
| Observation | The generated autonomous skill uses `## Deliver` as a readable section heading. Feature 029 copied that word into `autonomous-run-state.json`, but both state validators intentionally allow only the canonical closeout stages `Publish`, `Review`, and `MergeAndSync`. The invalid checkpoint was discovered when v0.2.2 validation reused the real Feature-029 state. |
| Artifact kind | Autonomous command, generated agent guidance, runbook, README, and field validation |
| TuiVision-specific exclusions | Do not promote Feature-029 task counts, branch, PR, merge, .NET commands, or repository closeout policy. |
| Generic target rule | Human-readable workflow headings must not be inferred as machine-state vocabulary. During remote delivery, persist the canonical stage matching the current operation and validate every transition. Keep validators strict; do not add an ambiguous alias merely to accept invalid state. |
| Occurrence count | One deterministic real-run failure found by both portable state validators. |
| Confidence | High. The allowed enum and invalid field value are directly reproducible. |
| Permission risk | Medium. Invalid run state can block or confuse audited resume near remote operations. The fix narrows state interpretation and grants no authority. |
| Reproducible test | Set a valid run-state fixture to `stage: "Deliver"` and require Bash and PowerShell validators to fail. Replace it with `Publish`, `Review`, or `MergeAndSync` as appropriate and require both to pass. |
| Decision | `Promote` as a bounded correctness clarification in `autonomous-run-governance` v0.2.2. |

## Field Boundary

Feature 029 confirms the existing lifecycle, permission, and exact-head model.
The promoted package changes are the extensive operating guide and one strict
state-vocabulary clarification. The
Terminal.GUI comparison, TuiVision contract matrix, multi-platform command
details, review-provider status, and narrow repository bypass remain field
evidence rather than portable defaults. No autonomous Feature 030 run is
started by this follow-up.
