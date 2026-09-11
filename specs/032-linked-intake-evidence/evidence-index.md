# Evidence Index

This index is a planning/foundation registry. `Open` is truthful pending later
implementation, native-platform, review, and delivery tasks; it is not a
failure masked as `N/A`.

| Repository | Base / branch | Canonical inputs | Outputs | Tests / security / architecture / A11Y | Platform / parity | Dependency and product scope | Documentation / statistics | PR through default sync | Distribution / rollback |
|---|---|---|---|---|---|---|---|---|---|
| home-baseline | current base; existing `032-linked-intake-evidence` | manifest + explicit feature proof: validation Passed | root view Current; isolated two-output transaction Passed | renderer/negative tests Passed; security/architecture/A11Y Open | macOS Bash/PowerShell parity Passed; Linux/Windows Open | zero product/dependency delta Open | GeneratedUpdate; ledger source updated, render Open | Open | rollback Passed; scripts `homeRuntime`, feature docs `sourceOnly`; Home Sync Open |
| agent-operations-cockpit | current main; `004-linked-intake-evidence` planned | AOC manifest/proofs: Applicable/Open | root + series views: Applicable/Open | all Applicable/Open; Assurance absent | native proof Open; paired parity Open | zero-delta proof Open | GeneratedUpdate; ledger Open | Open | local distribution; reviewed revert |
| TinyPl0 | current main; `007-linked-intake-evidence` planned | series manifest/proofs: Applicable/Open | root + series views: Applicable/Open | all Applicable/Open | native Node proof Open; agent parity N/A unless guidance changes | zero-delta proof Open | GeneratedUpdate; ledger Open | Open | local distribution; reviewed revert |
| TinyCalc | current main; `006-linked-intake-evidence` planned | series manifest/proofs: Applicable/Open | root + series views: Applicable/Open | all Applicable/Open | native Node proof Open; agent parity N/A unless guidance changes | zero-delta proof Open | GeneratedUpdate; ledger Open | Open | local distribution; reviewed revert |
| InventarWorkerService | current main; `003-linked-intake-evidence` planned | series manifest/proofs: Applicable/Open | root view: Applicable/Open | all Applicable/Open | native Bash/PowerShell proof Open; parity Open | zero-delta proof Open | GeneratedUpdate; ledger Open | Open | local distribution; reviewed revert |
| TuiVision | current main; `047-linked-intake-evidence` planned | exact ten mappings/six edges/backlog: Applicable/Open | root + series views: Applicable/Open | all Applicable/Open | native Node proof Open; agent parity N/A unless guidance changes | zero-delta proof Open | GeneratedUpdate; ledger Open | Open | local distribution; reviewed revert |
| absdd-image-sandbox | current clean main after terminal Feature 003; `004-linked-intake-evidence` planned | sandbox manifest/proofs: Applicable/Open | root view: Applicable/Open | all Applicable/Open | native Bash/PowerShell proof Open; parity Open | zero product/image/Compose/dependency delta Open | GeneratedUpdate; ledger Open | Open | local distribution; reviewed revert preserving Feature 003 |

Detailed lifecycle fields (Base, Branch, Canonical Inputs, Outputs, Tests,
Security, Architecture/iSAQB, A11Y, Platform, Agent Parity, Dependencies,
Product Scope, Documentation Impact, Statistics, PR, Review, PreMerge, Merge,
PostMerge, Default-Sync, Distribution, Rollback) are the seven-row matrix in
`checklists/repository-delivery.md`.
