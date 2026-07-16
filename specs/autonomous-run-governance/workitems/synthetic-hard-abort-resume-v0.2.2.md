# Preset Follow-up: Synthetic v0.2.2 Hard-Abort/Resume Field Test

## Run Evidence

| Field | Value |
|---|---|
| Source | Isolated `autonomous-hard-abort-v022` Spec Kit project |
| Spec Kit | `0.12.11` |
| Preset stack | Security 0.6.0, Architecture 0.5.0, iSAQB 0.2.0, A11Y 0.4.0, Cross-Platform 0.2.0, Agent Parity 0.3.0, Autonomous Run 0.2.2 |
| Baseline commit | `ea6352bf35ce3f29799a30e2eef1d7dea923506b` |
| Delivery mode | `LocalImplementation` |
| Remote boundary | No Git remote; no commit, push, pull request, or merge during the feature run |
| Interruption | Codex UI abort after Attempt 1 wrote `HARD_ABORT_READY`; graceful stop command not used |
| Post-abort process | Attempt 1 completed externally; original PID no longer running; no failed or interrupted marker |
| Status proof | Effective `Interrupted`; accepted artifacts unchanged; stale state 13/30 versus tasks 15/30; state hash unchanged by status |
| Refusal proof | General autonomous command changed no file and directed the run to explicit resume |
| Resume proof | Local authority revalidated; Attempt 1 marker, content, and SHA-256 verified; no Attempt 2 |
| Final state | `Retrospective`, `Completed`, 30/30, `nextExactAction: N/A` |
| Final validation | Bash and PowerShell state validators, `specify check`, Bash syntax, byte comparison, whitespace check, and zero-remotes proof passed |

## Workitem AR-SYN-022-01: Externally Completed Work Is Verified Before Retry

| Field | Value |
|---|---|
| Observation | The UI abort stopped the agent while its child validation continued and completed successfully. Persisted state therefore remained `Active` with a stale task hash and count. Read-only status reconstructed the effective interruption without mutation, the general autonomous command refused implicit continuation, and explicit resume verified the completed operation before deciding whether to retry. Invocation count remained one. |
| Artifact kind | Post-release lifecycle, state, permission, and duplicate-work field validation |
| Project-specific exclusions | Do not promote local paths, process IDs, timestamps, task counts, fixture text, document hashes, or the macOS UI behavior as portable defaults. |
| Generic target rule | After unexpected interruption, reconcile persisted state with Git, tasks, accepted artifacts, process and marker evidence, and current authority. A started operation is not proof of success. Verify a trustworthy completed result before re-execution; retry only an unproven or incomplete operation. |
| Occurrence count | One deterministic synthetic hard-abort result, in addition to the earlier real Feature-028 protected-resume field proof. |
| Confidence | High. Hashes, process state, markers, invocation count, task drift, command refusal, and both final validators agree. |
| Permission risk | Medium if absent because duplicate local or remote effects could occur. The existing v0.2.2 rule failed closed and granted no new authority. |
| Reproducible test | In a no-remote project, start a long deterministic validation with numbered start/completion markers, abort the agent after start, allow the child outcome to vary, require status to remain read-only, require the general command to refuse continuation, and require explicit resume to verify completion before any retry. |
| Decision | `NoPromotion`; v0.2.2 already contains the required lifecycle, evidence, duplicate-work, and authority rules. Record this as additional field validation. |

## Workitem AR-SYN-022-02: Synthetic Artifact EOF Correction Is Local

| Field | Value |
|---|---|
| Observation | Final validation required a minimal EOF-format correction in synthetic feature artifacts. `git diff --check` then passed. |
| Artifact kind | Project-specific documentation formatting |
| Project-specific exclusions | The temporary result document and feature evidence are not preset package artifacts. |
| Generic target rule | Existing exact-candidate whitespace validation remains sufficient. |
| Occurrence count | One local formatting correction. |
| Confidence | High that no shared lifecycle or template defect exists. |
| Permission risk | None. |
| Reproducible test | Run `git diff --check` against the intended local candidate and correct only reported whitespace findings. |
| Decision | `NoPromotion`; no shared preset surface changes. |

## Field Boundary

The synthetic run proves hard-abort recovery for the externally completed child
process case. It changes no preset behavior and does not justify v0.2.3,
re-release, TuiVision re-adoption, or a community-issue update. Feature 030 may
start with the installed v0.2.2 package when separately authorized.
