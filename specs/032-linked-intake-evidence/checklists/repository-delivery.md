# Repository Delivery Matrix

Planned numbers were revalidated from the fresh local/remote identities in
`parent-preflight-facts.json`: `032`, `004`, `007`, `006`, `003`, `047`,
`004`. There is no collision. Recheck immediately before later branch creation.

Legend: `Applicable` means mandatory later; `Open` means not yet evidenced;
`N/A(reason; trigger)` is a scoped decision, never a silent omission.

Each row's `PreMerge`/`PostMerge` fields use the exact repository-local
requirements artifact and five `RL-*` IDs pre-named in
`contracts/fleet-evidence-and-delivery.md`. The base task prepares and reviews
that artifact before mutation. The installed validator must see every declared
local ID with exact scope and `Pass` at the actual reviewed head; PostMerge
retains that head/requirements hash and adds causal PreMerge and merge binding.
The unchanged global `AC-LAF-001`–`014` file is reserved for T153–T155 after all
seven rows are real and terminal. In particular, global `AC-LAF-012/013` remain
mandatory and `Open` until then; no future row is `N/A` or pre-passed.

| Repository | Base | Branch | Canonical Inputs | Outputs | Tests | Security | Architecture/iSAQB | A11Y | Platform | Agent Parity | Dependencies | Product Scope | Documentation Impact | Statistics | PR | Review | PreMerge | Merge | PostMerge | Default-Sync | Distribution | Rollback |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| home-baseline | Applicable/current `f3f6954c...`; exact Assurance v0.1.3 profile | existing `032-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open; formal context unchanged | Applicable/Open | Applicable/Open | macOS Applicable; Linux/Windows Open | N/A(no shared guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Open: preserved sources, dirty guard blocks write | Open | Open | Open | Open | Open | Open | `homeRuntime` scripts; `sourceOnly` feature docs | repository-local revert; Home resync only after merged revert |
| agent-operations-cockpit | Blocking base prerequisite: local clean `17df5332...`, behind 5 from remote `49bfa60c...`; fast-forward, fresh inventory, local exact 13-check required | `004-linked-intake-evidence` only after prerequisite | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open; remote formal context unchanged, no local pass yet | Applicable/Open | Applicable/Open | native proof Open | N/A(no shared guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| TinyPl0 | Applicable/current `a988d641...` | `007-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| TinyCalc | Applicable/current `1aa45a86...` | `006-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| InventarWorkerService | Applicable/current `73ceab5a...` | `003-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| TuiVision | Applicable/current `a58c2026...` | `047-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| absdd-image-sandbox | Applicable/current terminal Feature 003 at `d3731df2...` | `004-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert; preserve Feature 003 commits |

PR, review, lifecycle evidence and story acceptance remain honestly Open until
their later tasks. A branch-number drift stops for plan review instead of
silent renumbering.

The 2026-09-10 authority adds only these still-Open repository-local proofs:

| Scope | Required evidence before repository completion |
|---|---|
| Home | exact `2d1dc800...91e9c7e...` ancestry/path integration; no lost feature/untracked bytes; incoming three LF attributes and Home-sync `sourceOnly` rule preserved; catalog-first script-reference regeneration; statistics current only after the clean T071 renderer |
| AOC | T079 exact logical-intake-to-current-archived/stamped mapping including META-LH-03 hash; T080 no canonical lifecycle change; configured/installed/mirrored autonomous preset comparison and bounded two-mirror correction or justified no-delta result |
| TinyPl0 | `src/Pl0.Ide/Pl0.Ide.csproj` three fields/file hash/manual counter unchanged from T091 through required `dotnet` gates and final head |
| TinyCalc | `Directory.Build.props` three fields/file hash/manual counter unchanged from T102 through required `dotnet` gates and final head |
| InventarWorkerService | `Directory.Build.props` three fields/file hash/manual counter unchanged; configured/installed/mirrored autonomous preset comparison and bounded two-mirror correction or justified no-delta result |
| TuiVision | `Directory.Build.props` three fields/file hash/manual counter unchanged from T126 through required `dotnet` gates and final head |
| absdd-image-sandbox | configured/installed/mirrored autonomous preset comparison and bounded two-mirror correction or justified no-delta result after the Feature-003/base gate |

Constitution corrections preserve principles and historical release facts,
apply local patch-version/date rules only when an actual mismatch remains, and
update directly dependent local agent/templates atomically or record justified
`N/A`. No preset install/promotion, product/runtime/image change, or global
guidance mutation is authorized. The approved exception is authority, not
evidence that a later repository action has completed.

The Home/AOC Assurance contexts are technical governance evidence, not new
pilot, project, release, rollout, certification or control approval. The
v0.1.3 exact-context/mode and typed-`acceptedRisks` rules are Applicable to any
later review; Feature 032's unchanged-context control reassessment and image
impact are `N/A / Not Assessed` with Feature Orchestrator ownership, risk of
overclaiming structural Ready, and re-evaluation on evidence/profile/scope or
authority change.
