# Agentic workspace and one-command maintenance

[Deutsche Fassung](agentic-workspace-efficiency-guide.md)

## Purpose and audiences

This guide explains how to use the agentic workspace and one-command
maintenance safely, traceably, and efficiently. **Agentic** means that an AI
agent performs a clearly bounded task with explicit authority, reviewable
evidence, and human accountability. **Evidence** is a traceable proof such as a
report, exit code, or reviewed commit.

The guide serves first-year learners, daily users, maintainers, AI agents, and
reviewers. No prior Spec Kit knowledge is assumed. Speed is a secondary signal.
The primary measure is more reviewable work per complete quality cycle.

## Four reader paths

| Goal | Entry | Outcome |
|---|---|---|
| First safe run | [Inspection without maintenance mutation](#erster-sicherer-lauf--first-safe-run) | understand command, side effect, exit code, and next action |
| Regular operation | [Fleet state and preview](#regelmaessiger-betrieb--regular-operation) | distinguish allowed and blocked actions |
| Maintainers and AI agents | [Source, authority, and handoff](#maintainer-und-ki-agenten--maintainers-and-ai-agents) | choose the correct edit, sync, and delivery path |
| Troubleshooting and audit | [Evidence and recovery](#fehleranalyse-und-audit--troubleshooting-and-audit) | reconstruct a run without assuming success |

## Terms at first use

| Term | Explanation |
|---|---|
| Level 0 source | Permanent Git checkout where shared changes are versioned, reviewed, and delivered |
| Home Runtime | Manifest-controlled set of operational files below `~/`; not the complete home directory |
| Remote Freshness Barrier | Complete fetch preflight for every declared Git target before domain mutation |
| Worktree | Tracked and untracked files in one local Git checkout |
| Preview | Shows planned mutations without applying them |
| Run ID | Unique identifier connecting terminal, log, event stream, and final report |
| JSONL | Text format with one JSON object per line; used here only for live events |
| Authority | Current explicit permission for local or remote actions |

<a id="erster-sicherer-lauf--first-safe-run"></a>
<a id="erster-sicherer-lauf-first-safe-run"></a>
## Erster sicherer Lauf / First safe run

### 1. Open the canonical source

Shared baseline work starts in the versioned checkout:

```bash
cd ~/home-baseline-source
git status --short --branch
```

A clean worktree is required for a controlled fast-forward pull. A dirty
worktree may be fetched and inspected, but it must not be pulled or cleaned
automatically.

### 2. Detect the operating system

- Use Bash on macOS or Linux.
- Use PowerShell 7 with `-NoProfile` on Windows.
- Do not mix variants. They implement the same domain contract with
  platform-specific parameter names.

### 3. Read help

```bash
bash scripts/maintain-agentic-workspace.sh --help
```

```powershell
Get-Help ./scripts/maintain-agentic-workspace.ps1 -Full
```

Help is the short public contract. The detailed source is the
[manpage](../man/maintain-agentic-workspace.1.md). The
[generated script reference](../scripts/reference.md) proves which scripts
belong to the repository and is not edited manually.

### 4. Run the read-only check

On macOS or Linux:

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
```

On Windows:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
```

Check-only may perform safe `fetch --prune` attempts. It performs no pulls,
file updates, or package installations. It may therefore use the network and
return exit `1` when it finds drift or a blocker.

### 5. Read the result correctly

| Exit | Meaning | Safe next action |
|---:|---|---|
| `0` | Current state or successful completion | check expected Run ID and finalized report status |
| `1` | Drift, blocker, or unsynchronized state | read the complete remainder and exact next action in the report |
| `2` | Parameter, operational, or safety error | do not repeat before examining cause and evidence |
| `3` | Drift repaired locally | review changed files and deliver separately through branch and PR |
| `130` | Cancelled through `Ctrl+C` or `INT` | inspect finalized report and process end; do not assume success |
| `143` | Linux run ended through `TERM` | inspect terminal state and remainder; do not assume success |

A non-zero exit is not always a program failure: `1` represents a domain
finding. Conversely, exit `0` alone does not prove a complete run. The expected
final report, Run ID, and finalized status must agree.

### 6. Preview before mutation

```bash
bash scripts/maintain-agentic-workspace.sh --dry-run
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

Preview shows permitted changes. It does not replace check-only: first inspect
the complete fleet state, then assess planned mutations. An interactive launch
without arguments selects preview by default. Redirected invocations remain
headless for compatibility.

### First-run checklist

- [ ] Selected the matching platform variant.
- [ ] Worked in the canonical checkout.
- [ ] Read help.
- [ ] Ran check-only and recorded the exit code.
- [ ] Recorded report path and Run ID.
- [ ] Understood blockers and next action as text.
- [ ] Ran preview before mutation.
- [ ] Assumed no remote, admin, or secret authority.

<a id="regelmaessiger-betrieb--regular-operation"></a>
<a id="regelmäßiger-betrieb-regular-operation"></a>
## Regelmäßiger Betrieb / Regular operation

### Binding sequence

```text
Check source and current authority
  -> create lock, log, and atomic report
  -> inventory and fetch every declared Git target
  -> classify pull and blocker states
  -> only then inspect Home sync, registry, propagation, and profiles
  -> maintain toolchain only after the mutation barrier passes
  -> recheck final state and finalize report
```

Control evidence such as lock, log, and report may exist before the Remote
Freshness Barrier. Domain mutations remain blocked until all fetch attempts
finish and every required target has a safe classification. A failure in the
first repository must not stop the read-only inventory of the rest of the
fleet.

### Git states and decisions

| State | Fetch | Automatic pull | Domain mutations |
|---|---|---|---|
| Clean default branch, behind only | allowed | `pull --ff-only` allowed | possible after the complete barrier |
| Clean and synchronized | allowed | unnecessary | possible after the complete barrier |
| Dirty | allowed | blocked | blocked |
| Ahead | allowed | blocked | blocked |
| Diverged | allowed | blocked | blocked |
| Detached HEAD | allowed | blocked | blocked |
| Non-default branch | allowed | blocked | blocked |
| Missing or ambiguous upstream | when possible | blocked | blocked |
| Unreachable remote | bounded attempt | blocked | blocked |

The default branch comes from valid `origin/HEAD` evidence or
`git ls-remote --symref origin HEAD`. Names such as `main`, `master`, and
`trunk` are never guessed. Fetch and pull attempts record attempt count,
duration, final status, and next action. A timeout or silent output is never an
implicit success.

### Enhanced, plain, and headless

| Mode | Invocation | Purpose |
|---|---|---|
| Enhanced TUI | `--tui` / `-Tui` | interactive terminal surface with copyable text status |
| Plain UI | `--plain-ui` / `-PlainUi` | linear text-oriented assistant |
| Headless | `--no-tui` / `-NoTui` or another maintenance option | non-interactive automation |

The UI selectors are mutually exclusive. Missing terminal capability, missing
.NET 10 SDK, or an unsafe build cache may fall back to Plain before engine
start. After engine start, no second engine process starts. A fallback may
reduce presentation but never bypass confirmation, blockers, or authority.

### Domain options and boundaries

| Bash | PowerShell | Effect and boundary |
|---|---|---|
| `--check-only` | `-CheckOnly` | inspect and fetch; no pulls or updates |
| `--dry-run` | `-WhatIf` | show planned mutations |
| `--scripts-only` | `-ScriptsOnly` | skip machine packages |
| `--repair-drift` | `-RepairDrift` | repair maintenance package locally; never commit or push |
| `--include-optional` | `-IncludeOptional` | include optional machine packages in current authorization |
| `--allow-admin-prompts` | `-AllowAdminPrompts` | permit admin prompts for this process only |
| `--manifest PATH` | `-ManifestPath PATH` | use an alternate fleet manifest for a controlled run |
| `--home-dir PATH` | `-HomeDir PATH` | use an alternate home for tests or a second profile |

PowerShell additionally offers bounded Git and WinGet timeout parameters. This
is an intentional platform boundary, not a semantic parity gap. Admin authority
stores no credentials, bypasses neither UAC nor timeouts, and is not a GitHub
admin bypass.

### Report, log, and live events

Each run creates below `~/.home-baseline/`:

- a lock against parallel maintenance;
- a complete log;
- an atomically finalized JSON report;
- for TUI use, an internal JSONL event stream.

All artifacts share one Run ID. Events serve live presentation only. The
canonical result comes from finalized report and process exit. A completion
event, when present, must agree. `EVENT_STREAM_DEGRADED` means events are
missing, damaged, or out of order. The UI then stays in linear mode and must not
derive success from events.

### Routine completion

1. Record process exit.
2. Compare report path and Run ID with terminal output.
3. Read `finalized`, overall status, last stage, and next action.
4. Handle the complete blocked remainder; individual green targets are not a
   fleet pass.
5. After repaired drift, end maintenance and inventory changes separately.
6. Use a dedicated branch and PR only after review.

<a id="maintainer-und-ki-agenten--maintainers-and-ai-agents"></a>
<a id="maintainer-und-ki-agenten-maintainers-and-ai-agents"></a>
## Maintainer und KI-Agenten / Maintainers and AI agents

### Source, runtime, and local state

| Class | Canonical edit location | Read and sync rule | Remote boundary |
|---|---|---|---|
| Level 0 source | versioned checkout | read directly and change through branch/PR | only current explicit remote authority applies |
| `homeRuntime` | Level 0 source first | after merge inspect and distribute through `sync-home.*` | never push the runtime copy directly |
| `sourceOnly` | Level 0 source | read from checkout; no Home sync | normal source PR |
| `machineLocal` | local machine under its state contract | do not overwrite from source | no implicit publication |

Current Home Runtime membership is in
[`home-sync-manifest.json`](../../scripts/config/home-sync-manifest.json).
Fleet classes are in
[`agentic-workspace-fleet.json`](../../scripts/config/agentic-workspace-fleet.json).
Documentation does not maintain a second complete list.

Direct repair below `~/` is not canonical. A local Home commit records runtime
sync but replaces neither source commit nor PR. Writing Home sync runs only on
the host. A sandbox reads the mounted Level 0 reference and does not write the
host runtime.

### Delivery Authority

| Mode | Allowed | Not automatically allowed |
|---|---|---|
| `LocalImplementation` | change and validate locally | commit, push, PR, merge |
| `PublishPR` | additionally commit, push, create/update PR | merge or admin bypass |
| `MergeAndSync` | additionally converge reviews, merge under policy, synchronize default branch | secrets, provider admin, or general bypass |

Authority is current and task-specific. It is inferred from neither an earlier
chat nor the word "autonomous." Maintenance itself receives no authority to
commit or push target-repository changes.

### Reusable agent prompt

```text
Goal: <concrete maintenance or documentation goal>
Repository and branch: <exact local and logical identity>
Scope: <allowed files and behavior>
Non-goals: <explicitly blocked changes>
Delivery Authority: <LocalImplementation | PublishPR | MergeAndSync>
Evidence: <report, Run ID, intake, review, and expected gates>
Safe order: Check -> preview -> explicit mutation
Stop boundaries: Dirty/Ahead/Diverged, missing authority, unclear evidence,
                 failed mandatory check, or actionable review thread
Completion: <expected branch, PR, merge, and sync state>
Do not start a follow-up feature automatically.
```

The agent verifies valid evidence rather than recreating it blindly. Large logs
are referenced through Run ID and path instead of copied into prompts.

### Serial or parallel

Parallel work is safe only without shared writers. Serialize:

- evidence and autonomous run state;
- registry and desired-state manifests;
- preset profiles and publication copies;
- agent guidance and Spec Kit templates;
- project statistics and version files;
- identical source or documentation files.

Read-only inventories of different repositories may be grouped. One failure
does not stop the remaining inventory. Writing repairs are delivered afterward
through repository-specific branches and non-empty PRs.

### Drift repair and handoff

1. Derive exact drift and owner from the canonical report.
2. Re-inventory candidates after every state change.
3. Do not use broad `git clean`, reset, stash, or recursive deletion in user
   checkouts.
4. Change or remove only manifest- or lease-bound owned paths.
5. Create a dedicated branch from the current default branch.
6. Review changes and tests inside that repository.
7. Commit, push, review, and merge only with current authority.
8. Fast-forward the default branch afterward and prove `(0 0)`.

<a id="fehleranalyse-und-audit--troubleshooting-and-audit"></a>
<a id="fehleranalyse-und-audit-troubleshooting-and-audit"></a>
## Fehleranalyse und Audit / Troubleshooting and audit

### Diagnostic order

1. Identify repository, branch, and current commit.
2. Inspect process state and lock owner.
3. Identify Run ID from terminal or report path.
4. Read the finalized report.
5. Compare process and report exit codes.
6. Inspect log and last completed stage.
7. Use JSONL only as supplemental evidence.
8. Re-inventory worktree and owned lease evidence.
9. Only then choose retry, resume, or manual repair.

### Lock and lease

A lock prevents parallel runs in the same home context. A temporary preset
worktree has a lease: ownership evidence binding run, process start,
repository, commit, and reserved paths. Cleanup removes only a still-clean,
Git-registered, unambiguously owned worktree. Active, tampered, foreign, or
PID-reuse-ambiguous evidence remains and blocks mutation.

### Interruption and recovery

The first `Ctrl+C` is forwarded exactly once to the engine. Later signals start
no second process and perform no broad cleanup. Controlled cancellation waits
for canonical finalization and returns `130`; Linux `TERM` returns `143`.

After unexpected interruption, stale `Active` is not proof of a running or
successful operation. Before recovery, inspect process, worktree, report,
tasks, hashes, and last operation. An operation without trustworthy outcome
needs revalidation. Safely completed work is not repeated blindly.

### Common findings

| Finding | Meaning | Next action |
|---|---|---|
| `EVENT_STREAM_DEGRADED` | Live presentation is incomplete | use finalized report and process exit |
| `DEFERRED_ADMIN_REQUIRED` | Required admin action lacked current authority | inspect remainder and authorize a new run explicitly |
| Dirty/Ahead/Diverged | Automatic update is unsafe | inventory repository separately and make a human decision |
| Missing report | Completion cannot be proven | do not mark Pass; inspect log, process, and Run ID |
| Report/exit mismatch | Completion evidence is inconsistent | block run and reconstruct cause |
| Remote timeout | Freshness is unproven | treat as blocking and record bounded retry |
| Preset drift in detached worktree | Canonical default branch differs | prepare a separate repository branch and PR |

### Audit and retention

Publishable evidence names repository, commit, Run ID, command class, result,
proof boundary, and next action. Machine-local logs remain local. Secrets,
private absolute paths, and credentials are not copied. A green job name proves
only the command and runner actually used. Exact-head evidence is renewed
immediately before merge against the current PR head.

### Source precedence

1. current wrapper, parameter, and runtime contracts;
2. current manpage and generated script reference;
3. structured reports and reproducible tests;
4. merged feature evidence;
5. historical migration documents as historical boundaries only.

The machine-readable
[source matrix](agentic-workspace-efficiency-source-matrix.json) binds each
option, status, evidence file, and next action to exactly one current source or
an explicit non-normative historical boundary.

## Efficiency without reduced quality

- Inventory before writing.
- Reuse existing safe scripts and check modes.
- Verify valid evidence instead of recreating it blindly.
- Serialize shared writers and group independent read-only checks.
- Reference reports through Run ID.
- Hand off error classes and next actions rather than complete logs.
- Create neither empty PRs nor speculative follow-up intakes.
- Never trade tests, reviews, accessibility, or maintainability for speed.

### GitHub Actions runner profile

Outside the three public reference repositories, the continuously distributed
`Maintenance TUI` and `PowerShell Static Analysis` workflows use only
`ubuntu-22.04`. The full Linux/macOS/Windows matrix remains as a cross-platform
canary on `hindermath/home-baseline`,
`hindermath/agent-operations-cockpit`, and `hindermath/TuiVision`. Private fleet
repositories therefore still validate every push and pull request without
multiplying two generic maintenance gates across billed Windows and macOS
runners.

Product-specific workflows remain independent. A Swift, Windows, .NET
Framework, or other platform-bound build keeps the runner required by its real
product contract. The runner reduction is not a blanket removal of
platform-specific product validation.

## Further sources

- [Operation and maintenance](README.en.md)
- [Source and Home Runtime](../architecture/source-and-home-runtime.en.md)
- [Troubleshooting](../troubleshooting/README.en.md)
- [Maintenance manpage](../man/maintain-agentic-workspace.1.md)
- [Maintenance TUI architecture](../architecture/maintenance-tui.md)
- [Maintenance TUI accessibility](../accessibility/maintenance-tui.md)
- [Script reference](../scripts/reference.md)
