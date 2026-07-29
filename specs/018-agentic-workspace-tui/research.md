# Research: Agentic-Workspace-Wartungs-TUI

## R01 - Runtime and UI Library

**Decision**: Use .NET 10 with Spectre.Console `0.57.2` and
Spectre.Console.Testing `0.57.2`.

**Rationale**: The repository already standardizes .NET 10 for current C#
work. Spectre provides the accepted prompt, table, live-display, capability and
test surfaces. `0.57.2` is the current stable version in the official NuGet V3
inventory; later entries are alpha builds.

**Alternatives considered**: Raw ANSI handling duplicates capability and A11Y
logic. Terminal.Gui adds a larger application model than this assistant needs.
Shell-only UI would duplicate interactive behavior across Bash and PowerShell.

## R02 - Maintenance Ownership

**Decision**: Keep Bash and PowerShell as sole maintenance engines. C# owns
selection, presentation, child-process invocation and result reconciliation.

**Rationale**: Features 015-017 already hardened the engine contracts. Moving
Git, registry, propagation, package or cleanup behavior would reopen completed
safety work and create platform drift.

**Alternatives considered**: Porting the engine to C# was rejected as broad
framework replacement. Parsing engine console text was rejected as unstable
and unsafe.

## R03 - Event Transport

**Decision**: Add a versioned append-only JSONL file with complete records and
stable run, sequence, phase, target and status fields.

**Rationale**: A local file is available on all target platforms, supports
incremental reads and preserves evidence when the UI exits. Complete
line-delimited objects tolerate an unfinished final write without treating it
as a valid event.

**Alternatives considered**: stdout parsing is not a contract. Named pipes and
sockets increase platform and lifecycle complexity. Rewriting one JSON
document risks contention and partial-document ambiguity.

## R04 - Canonical Completion

**Decision**: Treat events as advisory live state. The atomic report and
process exit are reconciled; the process exit wins on contradiction and the UI
adds `RESULT_MISMATCH`.

**Rationale**: This preserves Feature 015/016 finalization semantics and avoids
the UI turning malformed presentation data into a second execution result.

**Alternatives considered**: Trusting `run-completed` alone could report
success before an engine process fails. Trusting only the report would hide
process-launch or termination failures.

## R05 - Cache Identity and Publication

**Decision**: Hash sorted relative paths and bytes of the TUI source, project
and lock files plus a wrapper UI version. Bind the hash to a normalized
OS/architecture and publish only by atomic directory move after successful
locked restore/build.

**Rationale**: The cache can reuse exact local builds while rejecting stale
uncommitted source or cross-platform output. Atomic publication prevents
partial builds from becoming executable.

**Alternatives considered**: Commit-only identity ignores intentionally tested
local changes. Timestamp identity is not deterministic. One global cache mixes
architectures.

## R06 - Plain Fallback

**Decision**: Keep a line-oriented ASCII assistant at the wrapper boundary with
the same mode/conflict/confirmation rules. It is selected only before an engine
starts.

**Rationale**: The maintenance flow must remain usable if terminal
capabilities, SDK, restore, build or cache are unavailable. An engine failure
must not trigger fallback because that would duplicate maintenance.

**Alternatives considered**: Failing closed without an assistant would make
the interactive entry fragile. Retrying after engine failure could repeat
mutations.

## R07 - Process and Cancellation

**Decision**: Use `ProcessStartInfo.ArgumentList`, redirect output for linear
fallback, forward one controlled interrupt, wait for terminal status and never
construct executable shell text.

**Rationale**: Typed arguments avoid injection and platform quoting ambiguity.
Cooperative cancellation preserves existing finalization and evidence.

**Alternatives considered**: Shell command strings, `eval` and
`Invoke-Expression` violate secure coding rules. Immediate recursive kill or
cleanup could destroy evidence or unrelated processes.

## R08 - Test Platform

**Decision**: Use Microsoft.NET.Test.Sdk `18.8.1` and MSTest
TestFramework/TestAdapter `4.3.3`, all current stable versions in the official
NuGet inventory, plus existing Python unittest fixtures.

**Rationale**: `dotnet test` is a binding intake gate. MSTest is maintained by
Microsoft and supports the current .NET SDK. Python fixtures continue to prove
wrapper and engine behavior without replacing .NET console tests.

**Alternatives considered**: A custom executable test harness would not meet
the required `dotnet test` contract. Introducing multiple .NET test frameworks
would add dependency and maintenance cost.

## R09 - Accessibility

**Decision**: Provide one canonical textual status model rendered in enhanced,
compact and linear modes. Respect `NO_COLOR`, use ASCII labels, stable reading
order, keyboard-only prompts and German-first/English-second CEFR-B2 text.

**Rationale**: Terminal colors, layout and animation are not reliably exposed
to screenreaders or Braille displays. Shared text semantics allow snapshot
proof across all presentation modes.

**Alternatives considered**: Color themes or animations as primary state were
rejected. A separate simplified accessibility mode risks unequal information.

## R10 - Dependency and Regulatory Evidence

**Decision**: Track lock files, NuGet source, package inventory, vulnerability
result, license/source provenance, SBOM-oriented package evidence and VEX
disposition. Mark AI-SBOM, SLSA, Scorecard, cloud and regulatory gates `N/A`
with re-evaluation triggers.

**Rationale**: New third-party packages create a real supply-chain change but
not a cloud, AI-runtime, regulated-service or public product release.

**Alternatives considered**: Treating all controls as `N/A` would omit the
actual dependency risk. Claiming certification or full release provenance
would exceed scope.

## R11 - Documentation and Agent Guidance

**Decision**: Update operational README/manpage/reference plus focused
architecture, security and accessibility evidence. Record
`NoUpdateRequired` for shared agent guidance unless implementation reveals a
new durable rule.

**Rationale**: Users need invocation and fallback guidance. The accepted
repository governance already covers secure, cross-platform and accessible
code generation; repeating feature-specific UI rules in every agent file
would create noise.

**Alternatives considered**: Updating all agent surfaces unconditionally would
misstate a local product feature as new global policy.

## R12 - Remote Validation

**Decision**: Add one three-platform workflow for locked restore, build, test
and focused wrapper checks. Continue existing homogeneity and PowerShell
workflows and validate temporary exact-head gate evidence before merge.

**Rationale**: Local macOS proof cannot substitute for Ubuntu and Windows
execution. One explicit workflow makes command and runner mapping auditable.

**Alternatives considered**: Relying on aggregate existing workflow names would
not prove .NET or TUI commands. Committing exact-head evidence would invalidate
its own head claim.
