# Research: Wartungs-TUI- und Wrapper-Regressionshaertung

## Decision R01: Persisted events own sequence advancement

**Decision**: Select the Bash details argument explicitly, validate it through
the existing writer, and advance the public sequence only after successful
persistence.

**Rationale**: Consumers interpret sequence numbers as persisted record order.
Advancing before a failed write creates a false gap and hides the causal writer
failure behind a reader warning.

**Rejected**: Making the reader tolerate gaps. That would hide lost evidence
and weaken genuine corruption detection.

## Decision R02: Explicit zero-argument delegation

**Decision**: Branch on the original argument count. Use `exec bash SCRIPT`
for zero arguments and quoted array forwarding for one or more arguments.

**Rationale**: This is portable to Bash 3.2 with nounset, preserves argument
boundaries and keeps the single-process delegation model.

**Rejected**: String concatenation or `eval`, because both re-interpret shell
syntax. Disabling nounset globally would weaken the wrapper.

## Decision R03: Typed expected report path

**Decision**: Add the deterministic report path to the internal process
invocation record and pass it to the runner.

**Rationale**: The wrapper already derives the report from Home directory and
run ID. Carrying that value makes ownership reviewable and avoids directory
scans or dependence on advisory events.

**Rejected**: Search the reports directory for the newest file. This is racy,
can select another run and violates fail-closed run correlation.

## Decision R04: Three evidence sources, two canonical

**Decision**: Process exit code and finalized run report remain canonical. A
matching completion event corroborates them but is optional when presentation
has degraded.

**Rationale**: Feature 018 intentionally made events advisory so a damaged live
view cannot alter maintenance execution or final truth.

**Rejected**: Treat every missing completion event as `RESULT_MISMATCH`. Absence
is not a contradiction and incorrectly overrides valid canonical evidence.

## Decision R05: Preserve schema and PowerShell implementation

**Decision**: Keep event schema 1, report schema, CLI and correct PowerShell
behavior unchanged. Add parity assertions where useful.

**Rationale**: The defects are implementation regressions on the Bash and TUI
paths. Mechanical PowerShell edits would increase risk without fixing a defect.

## Decision R06: Documentation follows actual contract impact

**Decision**: Update user and maintainer documentation only where it currently
implies that completion events are mandatory for result discovery or omits the
Bash 3.2 zero-argument guarantee.

**Rationale**: Documentation Impact is semantic, not a requirement to churn all
related pages.

