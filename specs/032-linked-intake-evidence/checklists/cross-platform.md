# Plattformplan / Cross-Platform Plan

Native Linux and Windows evidence is intentionally `Open`; no later task is
claimed complete by this plan.

| Platform | Order and exact proof contract | State | Owner / next action |
|---|---|---|---|
| macOS | repository-local Bash/Node safe/check command first; capture exact head, command, runner, exit code, payload SHA-256, decision SHA-256, and write count | Applicable | Repository Owner runs local gate |
| Linux | native or approved isolation-bound Bash/Node command at the exact candidate head with the same seven evidence fields | Open | Cross-Platform Reviewer schedules native run after checkpoint |
| Windows | narrowly bounded native PowerShell 7/Node command at the exact candidate head with the same seven evidence fields | Open | Cross-Platform Reviewer schedules native run after checkpoint |
| Parity | compare normalized row fields, links, diagnostics, exit class and write count; syntax/emulation is partial only | Open | rerun whenever inputs, renderer, platform, or head changes |

Each record must contain `commitSha`, `command`, `runner`, `platform`,
`exitCode`, `payloadSha256`, `decisionSha256`, and `writeCount`. A missing
native result remains blocking `Open`, never convenient `N/A`.

Home T071 predeclares `.github/workflows/linked-intake-evidence-native-proof.yml`
unless the same exact-head Feature-032 proof appears remotely first. It uses the
repository's existing pinned checkout convention, `contents: read`, bounded job
timeouts, independent `ubuntu-22.04` and `windows-2022` matrix results, and the
exact pushed SHA. Both actual Bash and PowerShell suites run on both jobs; the
Windows job proves real Git Bash and `jq` resolution, and PowerShell symlink
negative tests execute rather than skip. The aggregate
`platform/home-baseline-native.json` binds actual suite logs plus input/source
hashes. Neither `assurance-preset.yml` nor the Feature-031 Copilot-review native
workflow can satisfy this requirement by name or inference.

For TinyPl0, TinyCalc, InventarWorkerService, and TuiVision, any locally
required `dotnet build`/`dotnet test` command executes under the approved
Feature-032 zero-version-change exception. Platform evidence also records the
fresh and final `Version`, `AssemblyVersion`, `FileVersion`, product-file hash,
and manual build-counter value. A changed value is a failed gate; a numbered
branch never replaces this proof.
