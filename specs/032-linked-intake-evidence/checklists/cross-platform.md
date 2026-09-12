# Plattformplan / Cross-Platform Plan

Native Linux and Windows evidence is terminal for all seven repository
candidates. One complete required run was retained per unchanged exact head;
duplicates were cancelled and reruns occurred only after actual input or head
changes.

| Platform | Order and exact proof contract | State | Owner / next action |
|---|---|---|---|
| macOS | repository-local Bash/Node safe/check command first; exact head, command, runner, exit code, hashes and write count captured | Pass | Re-evaluate on local input or head change |
| Linux | native Bash/Node and required PowerShell command at the exact candidate head | Pass | Re-evaluate on workflow, runner, input or head change |
| Windows | native PowerShell 7/Node and required Git Bash command at the exact candidate head | Pass | Re-evaluate on workflow, runner, input or head change |
| Parity | normalized row fields, links, diagnostics, exit class and write count compared | Pass | Rerun only when inputs, renderer, platform or head changes |

Each accepted record contains its exact head, command, runner, platform,
exit code, source/log hashes and zero-write count. No missing native result was
relabeled as `N/A`.

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
