# Fleet Rollout Evidence: Autonomous Run Governance v0.4.1

## Scope

The dynamic inventory found 47 active Git targets plus one collection target.
Exactly 36 Git repositories resolved an active profile containing
`autonomous-run-governance`: Home Baseline and the 35 registered Level-1/2
repositories below. The remaining registered targets were inventoried but were
not applicable consumers and were not mutated.

## Consumer Outcomes

| Consumer | Pull request | Result | Local synchronization |
|---|---:|---|---|
| `home-baseline` | [#243](https://github.com/hindermath/home-baseline/pull/243) | Merged as `4c8185aae6988957c94ddc4de104ea1eb4472ca1` | Feature head `525fbf90a0810a1cd46abc9c4e48fb757c68318c`; causal closeout follows separately |
| `c64-baseline` | [#34](https://github.com/hindermath/c64-baseline/pull/34) | Merged | `(0 0)` |
| `cc65` | [#32](https://github.com/hindermath/cc65/pull/32) | Merged | `(0 0)` on `master` |
| `clion-baseline` | [#4](https://github.com/hindermath/clion-baseline/pull/4) | Merged | `(0 0)` |
| `tvision` | [#14](https://github.com/hindermath/tvision/pull/14) | Merged after OpenCode parity correction | `(0 0)` on `master` |
| `datagrip-baseline` | [#35](https://github.com/hindermath/datagrip-baseline/pull/35) | Merged | `(0 0)` |
| `InventarDb` | [#34](https://github.com/hindermath/InventarDb/pull/34) | Merged | `(0 0)` |
| `rider-baseline` | [#35](https://github.com/hindermath/rider-baseline/pull/35) | Merged | `(0 0)` |
| `agent-operations-cockpit` | [#25](https://github.com/hindermath/agent-operations-cockpit/pull/25) | Merged | `(0 0)` |
| `InventarWorkerService` | [#57](https://github.com/hindermath/InventarWorkerService/pull/57) | Merged | `(0 0)` |
| `TinyCalc` | [#54](https://github.com/hindermath/TinyCalc/pull/54) | Merged | `(0 0)` |
| `TinyPl0` | [#65](https://github.com/hindermath/TinyPl0/pull/65) | Merged | `(0 0)` |
| `TuiVision` | [#152](https://github.com/hindermath/TuiVision/pull/152) | Merged | `(0 0)` |
| `secure-casetracker-baseline` | [#32](https://github.com/hindermath/secure-casetracker-baseline/pull/32) | Merged | `(0 0)` |
| `securecasetracker-csharp` | [#38](https://github.com/hindermath/securecasetracker-csharp/pull/38) | Merged | `(0 0)` |
| `securecasetracker-go` | [#37](https://github.com/hindermath/securecasetracker-go/pull/37) | Merged | `(0 0)` |
| `securecasetracker-java` | [#37](https://github.com/hindermath/securecasetracker-java/pull/37) | Merged | `(0 0)` |
| `securecasetracker-python` | [#38](https://github.com/hindermath/securecasetracker-python/pull/38) | Merged | `(0 0)` |
| `securecasetracker-rust` | [#37](https://github.com/hindermath/securecasetracker-rust/pull/37) | Merged | `(0 0)` |
| `securecasetracker-swift` | [#37](https://github.com/hindermath/securecasetracker-swift/pull/37) | Merged | `(0 0)` |
| `secure-orderdesk-baseline` | [#32](https://github.com/hindermath/secure-orderdesk-baseline/pull/32) | Merged | `(0 0)` |
| `secureorderdesk-csharp` | [#33](https://github.com/hindermath/secureorderdesk-csharp/pull/33) | Merged | `(0 0)` |
| `secureorderdesk-go` | [#32](https://github.com/hindermath/secureorderdesk-go/pull/32) | Merged | `(0 0)` |
| `secureorderdesk-java` | [#32](https://github.com/hindermath/secureorderdesk-java/pull/32) | Merged | `(0 0)` |
| `secureorderdesk-python` | [#32](https://github.com/hindermath/secureorderdesk-python/pull/32) | Merged | `(0 0)` |
| `secureorderdesk-rust` | [#32](https://github.com/hindermath/secureorderdesk-rust/pull/32) | Merged | `(0 0)` |
| `secureorderdesk-swift` | [#32](https://github.com/hindermath/secureorderdesk-swift/pull/32) | Merged | `(0 0)` |
| `secure-serviceharvester` | [#32](https://github.com/hindermath/secure-serviceharvester/pull/32) | Merged | `(0 0)` |
| `secureserviceharvester-csharp` | [#33](https://github.com/hindermath/secureserviceharvester-csharp/pull/33) | Merged | `(0 0)` |
| `secureserviceharvester-go` | [#32](https://github.com/hindermath/secureserviceharvester-go/pull/32) | Merged | `(0 0)` |
| `secureserviceharvester-java` | [#32](https://github.com/hindermath/secureserviceharvester-java/pull/32) | Merged | `(0 0)` |
| `secureserviceharvester-python` | [#32](https://github.com/hindermath/secureserviceharvester-python/pull/32) | Merged | `(0 0)` |
| `secureserviceharvester-rust` | [#32](https://github.com/hindermath/secureserviceharvester-rust/pull/32) | Merged | `(0 0)` |
| `secureserviceharvester-swift` | [#32](https://github.com/hindermath/secureserviceharvester-swift/pull/32) | Merged | `(0 0)` |
| `container-images` | [#32](https://github.com/hindermath/container-images/pull/32) | Merged | `(0 0)` |
| `absdd-image-sandbox` | [#46](https://github.com/hindermath/absdd-image-sandbox/pull/46) | Merged from isolated worktree | Primary checkout preserved: one pre-existing dirty path |

## Validation and Permission Boundary

Every consumer received a non-empty preset-only pull request. Local profile
resolution, generated-agent parity, diff checks, repository homogeneity and
secret scanning passed before push. The `tvision` CI exposed a real OpenCode
body-parity defect; the five affected generated commands and the resulting
statistics drift were corrected before all 34 technical checks passed.

For repositories whose GitHub jobs started normally, all required technical
checks passed. The remaining provider jobs executed zero steps and carried
GitHub's payment or spending-limit annotation. Those pull requests were merged
only after local exact-head gates passed, actionable review-thread count was
zero, and the explicitly authorized narrow admin-bypass conditions were met.
The bypass grants no continuing authority.

No product code changed. Project-specific guidance and each repository's
tracked OpenCode layout were preserved. The dirty `absdd-image-sandbox`
checkout was neither cleaned nor pulled; its remote default branch contains the
merged rollout and must be synchronized only after its unrelated local change
is resolved by its owner.
