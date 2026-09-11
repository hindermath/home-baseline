# Contract: TuiVision Exact Historical Projection

## Active Intake-to-Feature Mapping

The TuiVision renderer must preserve exactly ten active entries in manifest
order and bind them to these existing feature directories:

| Position | Exact intake path | Exact Spec-Kit feature path |
|---:|---|---|
| 1 | `requirements/intakes/active/Lastenheft_22_Wave6-Combined-Delta-Closure.md` | `specs/037-wave6-combined-delta-closure/` |
| 2 | `requirements/intakes/active/Lastenheft_15_Post-Wave6-Example-Portfolio-Conformance-Audit.md` | `specs/038-example-portfolio-conformance-audit/` |
| 3 | `requirements/intakes/active/Lastenheft_Example-Portfolio-Closure.md` | `specs/039-example-portfolio-closure/` |
| 4 | `requirements/intakes/active/Lastenheft_Constitution_Change.md` | `specs/040-constitution-governance-closure/` |
| 5 | `requirements/intakes/active/Lastenheft_Source-Reference-Policy.md` | `specs/041-source-reference-policy/` |
| 6 | `requirements/intakes/active/Lastenheft_Transactional-Form-Model.md` | `specs/042-transactional-form-model/` |
| 7 | `requirements/intakes/active/Lastenheft_23_Documentation-Publishing-Closure.md` | `specs/043-documentation-publishing-closure/` |
| 8 | `requirements/intakes/active/Lastenheft_Sandbox-gestuetzte-Secure-Development-Haertung.md` | `specs/044-sandbox-secure-development-hardening/` |
| 9 | `requirements/intakes/archive/Lastenheft_RL-SE-Checklist-Selbstpruefung.045-rl-se-checklist-self-review.md` | `specs/045-rl-se-checklist-self-review/` |
| 10 | `requirements/intakes/archive/Lastenheft_GSDB-Spec-Kit-Intensivpruefung.046-gsdb-spec-kit-intensive-review.md` | `specs/046-gsdb-spec-kit-intensive-review/` |

Implementation must bind these exact path pairs from the canonical manifest;
the table does not authorize filename or number guessing. Every feature
directory and its explicit binding proof must exist. Feature
`046-gsdb-spec-kit-intensive-review` is identified separately as the most
recently completed feature; it remains at position 10 and is not moved to the
top or outside canonical order.

## Exact Dependency Tuples

The six active dependency edges remain exactly:

| # | Exact `from` path | Exact `to` path | `kind` | `binding` |
|---:|---|---|---|---|
| 1 | `requirements/intakes/active/Lastenheft_22_Wave6-Combined-Delta-Closure.md` | `requirements/intakes/active/Lastenheft_15_Post-Wave6-Example-Portfolio-Conformance-Audit.md` | `HardCompletionGate` | `true` |
| 2 | `requirements/intakes/active/Lastenheft_15_Post-Wave6-Example-Portfolio-Conformance-Audit.md` | `requirements/intakes/active/Lastenheft_Example-Portfolio-Closure.md` | `HardCompletionGate` | `true` |
| 3 | `requirements/intakes/active/Lastenheft_Constitution_Change.md` | `requirements/intakes/active/Lastenheft_Source-Reference-Policy.md` | `SharedWriterSerialization` | `false` |
| 4 | `requirements/intakes/active/Lastenheft_Source-Reference-Policy.md` | `requirements/intakes/active/Lastenheft_Transactional-Form-Model.md` | `HardCompletionGate` | `true` |
| 5 | `requirements/intakes/active/Lastenheft_Example-Portfolio-Closure.md` | `requirements/intakes/active/Lastenheft_Transactional-Form-Model.md` | `HardCompletionGate` | `true` |
| 6 | `requirements/intakes/active/Lastenheft_Transactional-Form-Model.md` | `requirements/intakes/active/Lastenheft_23_Documentation-Publishing-Closure.md` | `PreferredSerialOrder` | `false` |

The exact manifest paths corresponding to these identities are compared as
ordered tuples. Tests fail on a missing, additional, reversed, duplicated, or
retyped edge, and on any changed `binding` value.

## Backlog Separation

The optional NuGet intake remains one separate backlog entry with status
exactly `DeferredOptional`. It is not an active row, not a dependency endpoint,
not assigned an active position, and not interpreted as a required delivery
step.

## Two-View and Feature Evidence Invariants

- Root and series order views derive from the same typed projection.
- Both views contain the same ten active rows, feature mappings, and six direct
  incoming edge tuples after resolving their view-relative links.
- All ten intake links and all ten feature links resolve inside the repository.
- The exact root and no-feature fallbacks from the shared view contract remain
  available, although this fixture expects all ten active rows to have unique
  feature links.
- The second unchanged write-mode render changes no file.
- No TuiVision product source, assembly, public API, terminal behavior, or
  package dependency changes as part of this feature.

## Proof Set

The TuiVision evidence bundle contains the canonical manifest SHA-256, the ten
exact mapping proofs, the ordered six-edge comparison, the backlog assertion,
both generated-output SHA-256 values, Node test command and exit code, exact
commit/platform binding, and zero-write idempotence result.
