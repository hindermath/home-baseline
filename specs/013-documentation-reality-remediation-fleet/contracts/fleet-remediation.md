# Contract: Fleet Documentation Remediation

An accepted fleet result contains one repository outcome for Level 0 and every
registered Level-1/2 target, one final disposition for each inherited finding,
and immutable PR-head and merge evidence for each changed repository.

The result is invalid when a target is missing or duplicated, a changed target
has no non-empty PR, an unsafe target was modified, a finding lacks a
disposition, or completion is claimed with a failed required gate or actionable
review thread.
