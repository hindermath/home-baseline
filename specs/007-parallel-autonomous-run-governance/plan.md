# Implementation Plan: Parallel Autonomous Run Governance

## Architecture

The preset adds a campaign layer above autonomous single runs. A tracked
campaign manifest declares portable intent. A local runner-profile file binds
agent and provider commands without storing secrets. Runtime worktrees, logs,
locks, and process results live outside tracked feature artifacts.

The PowerShell 7 coordinator is the canonical structured implementation. The
Bash entry point delegates argument-for-argument to that implementation, which
keeps behavior identical on macOS, Linux, and Windows where PowerShell 7 is part
of the required workspace toolchain.

## Contracts

- `parallel-campaign.json`: immutable campaign intent and worker graph.
- `parallel-runner-profiles.json`: local executable/argument-array bindings.
- `parallel-campaign-state.json`: resumable aggregate lifecycle.
- `worker-result.json`: worker outcome, head, evidence, and optional PR.
- Existing `autonomous-run-state.json`: authoritative worker-internal state.

## Delivery

Implement and validate in Level 0, publish v0.1.0 in a protected standalone
repository, then opt in the Secure CaseTracker coordinator and six language
repositories. Promote to v0.2.0 and the standard eight-preset matrix only after
the Units 00-03 field campaign succeeds.

## Native Development Override

Repository owner Thorsten Hindermann explicitly authorized both the 13-worker
smoke set and the Secure CaseTracker Units 00-03 field campaign to run natively
on the development Mac on 2026-07-18. This is a deliberate development-phase
override of the otherwise binding Secure Trader Container-First rule.

The campaign evidence MUST record the override, host platform, agent family,
maximum configured and observed concurrency, repositories, run IDs, and start
and completion times. Concurrency remains capped at three. The override ends
after field findings are captured and does not apply to learner, production,
routine maintenance, or later campaigns. Those return to Container-First
unless the repository owner issues a new explicit authorization.
