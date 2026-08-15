# Autonomous Run Retrospective: Feature 028

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | `028-autonomous-evidence-integrity-field-validation`; exact feature head is recorded by the later PreMerge snapshot |
| Delivery evidence | `pr-evidence.md`, `field-evidence/field-validation-evidence.json`, `fleet-rollout-evidence.md` |
| Delivery mode | `MergeAndSync` |
| Remote result | Public preset PRs #16/#17 merged, release v0.4.1 published, 35 consumer PRs merged, community issue github/spec-kit#4153 opened |
| Interruptions and resumes | None; the run state remained reconstructable at every persisted boundary |

## Observations

| ID | Observation | Artifact kind | Project exclusions | Generic target rule | Occurrences | Confidence | Permission risk | Reproducible test | Decision |
|---|---|---|---|---|---:|---|---|---|---|---|
| AR-028-01 | Release documentation still described the first v0.4.0 package as unpublished after its tag existed. Rollout stopped before consumer mutation and v0.4.1 corrected the immutable release. | Release checklist and documentation | Concrete version, repository and checksum | Validate every versioned install command and publication statement against the exact tag before rollout. Never rewrite a published tag. | 1 | High | Stale documentation can direct consumers to an older package, but correction grants no release authority. | Publish a temporary candidate whose README names the previous tag; require release validation to reject it before consumer mutation. | `NoPromotion` - corrected and covered by the current v0.4.1 release gates |
| AR-028-02 | One consumer's tracked OpenCode command body retained stale generated content and its parity test correctly failed. | Consumer generation and parity validation | `tvision` paths and C++ workflow | Preserve repository layout, then validate canonical command-body parity after every generated-surface and statistics update on the final head. | 1 | Medium | A bypass must never replace this executable parity proof. | Install into a fixture with a pre-existing plural OpenCode layout and assert final canonical-body parity after all generated updates. | `ObserveAgain` - one consumer occurrence; existing parity gate caught it before merge |
| AR-028-03 | GitHub rejected many fleet jobs before the first step because of account payment or spending limits. Local exact-head gates remained usable, but provider rejection had to be proved per PR. | Delivery evidence and permission policy | Concrete repositories, job IDs and account state | Distinguish a zero-step provider rejection from a technical failure using job steps and provider annotation; bypass only under explicit current authority and zero actionable threads. | 1 fleet event | High | Misclassification could merge a real technical failure. | Fixture provider records with zero steps and billing annotation versus a started failing job; only the former may enter the bounded exception path. | `NoPromotion` - the existing narrow-bypass contract already covers this classification |

Correctness, security, permission, and evidence-integrity defects may be
promoted after one deterministic occurrence. Efficiency preferences need at
least two independent field observations.

## Outcome

- Local non-empty correction: v0.4.1 package, Home Baseline adoption, workitem
  closeout and complete fleet evidence.
- Portable handoff: none; the three original Feature-038 findings are fully
  implemented by this feature.
- Pending observations: `AR-028-02` only; no empty follow-up branch or PR.
- Rejected project details: repository names, provider billing state, local
  OpenCode path history and concrete PR/check identifiers remain evidence, not
  preset defaults.
- Next field gate: ordinary use of v0.4.1; no synthetic or product feature is
  started automatically.
- Resume-state quality: `Valid`; accepted artifacts, tasks, evidence and
  delivery boundaries remained reconstructable without manual state repair.

## Promotion Decision

`NoPromotion`. Version v0.4.1 already contains the authorized portable
hardening. The rollout produced no additional reproducible provider-neutral
defect that justifies another release. The single OpenCode consumer occurrence
remains `ObserveAgain` and was caught by an existing executable parity gate.
