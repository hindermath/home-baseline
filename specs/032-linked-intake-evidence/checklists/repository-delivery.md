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
| home-baseline | Applicable/current `e78c8fc6...`; exact origin/main `91e9c7e5...` integrated; exact Assurance v0.1.3 profile | existing `032-linked-intake-evidence` | PreCheckpoint Pass | PreCheckpoint Pass | macOS Pass | Pass; formal Assurance context unchanged | Pass | Pass | macOS Pass; Linux/Windows Open | N/A/reviewed(no diff in the five shared guidance surfaces; trigger shared-rule, template, Constitution, routing or reader-path change) | Pass: zero dependency/package/lockfile paths | Pass: zero product/runtime/API/image/Compose paths | GeneratedUpdate/current decision; final output current in T071 | Open: source slot 82 = 52; check-only DRIFT at source revision `4068aafd5d2c`, 672210 text lines, 106 active days; write deferred to clean T071 checkpoint | Open | Open | Open | Open | Open | Open | `homeRuntime` scripts; `sourceOnly` feature docs and Public-Statistics artifacts | repository-local revert; Home resync only after merged revert |
| agent-operations-cockpit | Blocking base prerequisite: local clean `17df5332...`, behind 5 from remote `49bfa60c...`; fast-forward, fresh inventory, local exact 13-check required | `004-linked-intake-evidence` only after prerequisite | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open; remote formal context unchanged, no local pass yet | Applicable/Open | Applicable/Open | native proof Open | N/A(no shared guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| TinyPl0 | Applicable/current `a988d641...` | `007-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| TinyCalc | Applicable/current `1aa45a86...` | `006-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| InventarWorkerService | Applicable/current `73ceab5a...` | `003-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| TuiVision | Applicable/current `a58c2026...` | `047-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert |
| absdd-image-sandbox | Applicable/current terminal Feature 003 at `d3731df2...` | `004-linked-intake-evidence` | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | Applicable/Open | native proof Open | N/A(no guidance diff; trigger guidance change) | Applicable/Open | Applicable/Open | GeneratedUpdate/Open | Applicable/Open | Open | Open | Open | Open | Open | Open | repository-local; no Home Sync | repository-local revert; preserve Feature 003 commits |

## Home-Baseline-Disposition nach T067 / Home Baseline disposition after T067

Die einzige Documentation-Impact-Entscheidung bleibt **GeneratedUpdate**.
Kanonische Quellen sind das lokale Reihenmanifest, der Renderer, der
Skriptkatalog und die Statistik-Konfiguration; Owner sind Feature Orchestrator
und Home-Baseline Repository Owner. Betroffen sind die generierten Root- und
Serienansichten, die Skriptreferenz, die Statistik-Ledger-Ausgabe und die
Feature-Evidence. Die fachliche Aktualität der noch offenen Ausgaben wird in
T069-T071 belegt und hier nicht vorweggenommen.

*The single Documentation Impact decision remains **GeneratedUpdate**.
Canonical sources are the local series manifest, renderer, script catalog, and
statistics configuration; the Feature Orchestrator and Home Baseline
Repository Owner own them. Generated root and series views, script reference,
statistics ledger output, and feature evidence are affected. T069-T071 prove
the still-open output currency; this disposition does not pre-claim it.*

| Pflichtfeld / Required field | Home-Baseline-Entscheidung / Home Baseline decision |
|---|---|
| Zielgruppen / Audiences | Maintainer, Reviewer, IT-Auszubildende und Trainingsverantwortliche / maintainers, reviewers, IT apprentices, and training leads |
| Leserpfade / Reader paths | Root-Reihenfolge → vollständiger Intake-Link → nachgewiesenes Feature; Serienansicht → direkte Abhängigkeit → kanonische Quelle; Feature-Evidence-Index → repository-lokale Delivery-Evidence |
| Navigation | `Lastenheft_Abarbeitungsreihenfolge.md`, lokale Serienansicht, `specs/032-linked-intake-evidence/evidence-index.md`, generierte Skriptreferenz |
| Dokumentklasse / Document class | Generierte Markdown-Ansichten und source-only Feature-/Governance-Evidence |
| Sprache / Language partner | Deutsch zuerst, Englisch danach auf CEFR-B2-Niveau innerhalb derselben kurzen Artefakte; vorhandene große `.en.md`-Partner bleiben synchron |
| Plattform-/Beispielnachweis | macOS lokal in T070; native Linux-/Windows-Evidence am unveränderten Push-Head in T071 |
| Distribution | Renderer-Skripte `homeRuntime`; Feature-, Governance- und Public-Statistics-Artefakte `sourceOnly` |
| Home Sync | Erst nach erfolgreichem Home-Merge in T078; kein Sync in T068 |
| Evidence | diese Matrix, `documentation-impact-evidence.json`, `evidence-command-inventory.md`, später `local-gates.json` und der native T071-Nachweis |
| Re-Evaluation | Quelle, Owner, Zielgruppe, Navigation, Sprachstrategie, Plattform, Distribution, Home-Runtime-Scope oder Kandidaten-Head ändert sich |

Die fünf gemeinsamen Guidance-Flächen `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
`.github/copilot-instructions.md` und
`.github/agents/copilot-instructions.md` weisen gegenüber dem akzeptierten
Feature-Basiscommit keinen Diff auf. Eine atomare Shared-Guidance-Mutation ist
für T068 daher begründet **N/A**. Dasselbe gilt für neue Projektvorlagen und
eine weitere lokale Constitution-Mutation: Feature 032 führt keine neue
gemeinsame Betriebsregel oder Bootstrap-Schnittstelle ein; die separat
abgeschlossene v1.21.1-Metadatenkorrektur wird nicht erweitert.
Re-Evaluation erfolgt sofort, sobald eine gemeinsame Regel, Vorlage,
Constitution-, Routing- oder Reader-Path-Bindung geändert werden müsste.

*The five shared guidance surfaces have no diff from the accepted feature base,
so an atomic shared-guidance mutation is justified **N/A** for T068. New
project templates and any further local Constitution mutation are also N/A:
Feature 032 introduces no shared operating rule or bootstrap interface, and it
does not extend the separately completed v1.21.1 metadata correction. Any
shared-rule, template, Constitution, routing, or reader-path change triggers
immediate re-evaluation.*

### T069 Statistik- und Katalognachweis / T069 statistics and catalog evidence

`scripts/config/script-catalog.json` enthält sowohl den Feature-032-Testeintrag
als auch den eingehenden Public-Statistics-Eintrag. Die daraus regenerierte
`docs/scripts/reference.md` ist mit 146 kanonischen und 99 eingebetteten
Skripten aktuell. Die chronologischen Update-Log-Schlüssel beider Merge-Eltern
sind vollständig im vereinigten Ledger enthalten.

Statistik-Slot 82 erfasst 52 Nettozeilen der Home-Lieferbasis. Der ausschließlich
lesende Lauf `bash scripts/render-project-statistics.sh --repo . --check-only
--json` meldete erwartungsgemäß `DRIFT`, Exitcode 1, `changed=true`, Methodik 2,
672.210 Textzeilen, 106 sichtbare Aktivtage und Source-Revision `4068aafd5d2c`.
Dies ist ausdrücklich kein Current-Pass; der schreibende Renderer bleibt T071
im tatsächlich sauberen Checkout vorbehalten.

*The reconciled catalog and generated reference are current, and the merged
ledger retains the chronological keys from both parents. Slot 82 records 52
net lines. The read-only statistics check reported the expected dirty-checkout
drift and does not pre-claim a current ledger; the write remains deferred to
the genuinely clean T071 checkpoint.*

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
