# Implementierungs-Governance / Implementation Governance

## Presetprofil / Preset profile (T005)

| Scope | Exact check | Result | Applicability |
|---|---|---|---|
| Central eight-only (2026-09-08) | default central matrix check | Exit `1`: additional installed presets | Historical preserved failure; not a pass |
| Home old thirteen (2026-09-08) | v0.1.3 field-test matrix against then-installed v0.1.2 | Exit `1` | Historical preserved failure; not a current result |
| Home current thirteen | `bash scripts/install-spec-kit-governance-presets.sh --check-only --preset-config scripts/config/spec-kit-secure-development-assurance-governance-presets.json --repo .` | Exit `0`, exactly 13 presets, Assurance `0.1.3` | Applicable/current |
| AOC local current | read-only `git status`, `rev-parse HEAD origin/main` | clean `17df5332...`, behind 5 from `49bfa60c...`; local profile remains old bytes | Blocking prerequisite before AOC writes |
| AOC `origin/main` | `git show origin/main:<path>` for registry, preset, formal context and verification records | Assurance `0.1.3`, remote field-test evidence | Remote fact only; not local exact-check evidence |
| Five field targets | `bash scripts/install-spec-kit-governance-presets.sh --check-only --preset-config scripts/config/spec-kit-secure-development-assurance-governance-presets.json --repo ../RiderProjects/TinyPl0 --repo ../RiderProjects/TinyCalc --repo ../RiderProjects/InventarWorkerService --repo ../RiderProjects/TuiVision --repo ../container-images/absdd-image-sandbox` | Exit `0`, 13 exact presets, Assurance `0.1.3` | Applicable |
| Home accepted baseline | `bash scripts/install-spec-kit-governance-presets.sh --check-only --preset-config .specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/resume-2026-09-08/home-accepted-assurance-v012-matrix.json --repo .` | Exit `0`, preserved 13-preset `0.1.2` state | Historical-baseline comparison only |
| Local inventory | `specify preset list` | Exit `0`, 13 installed | Applicable |

The exact central components are Security, Architecture, iSAQB Architecture,
A11Y, Cross-Platform, Agent Parity, Autonomous Run, and Parallel Autonomous
Run. The repository profiles additionally bind Model Routing, Intake
Authoring, Intake Review, and Intake Sequencing. Home and the five previously
checked field targets use Assurance `0.1.3`. AOC `origin/main` also contains
`0.1.3`, but AOC local `main` must first fast-forward and pass the exact local
thirteen-profile check.

## Assurance-Neubewertung vor T013 / Assurance re-evaluation before T013

Mandatory rule delta: `Applicable`. v0.1.3 requires one exact dated directory,
full case-sensitive context identity, exact Evidence `contextId` and `mode`,
and—when present—array-typed `acceptedRisks` with scalar nonblank IDs and
complete review metadata. Current Home uses
`home-baseline-assurance-v013`/`training`; AOC remote uses
`aoc-assurance-v013`/`training`. Neither current four-gate context contains
`acceptedRisks`.

Feature-specific renewed control assessment and image impact remain bounded
`N/A / Not Assessed`: Feature 032 changes no formal Assurance context or
product/runtime/image scope. Owner: Feature Orchestrator. Reviewer: fresh
Analyze result. Residual risk: structural Ready evidence may be mistaken for
control implementation or approval. Re-evaluate on context/mode/risk schema,
evidence, profile, authority or scope change and before each repository slot.
Technical validation grants no pilot, project, release, rollout, certification
or other human-only decision.

## Liefer-Vorbereitung / Delivery preparation

- Preserve all three hash-bound Analyze reports byte-for-byte. Before the T067
  Preservation Commit, add only their three exact `.gitattributes` paths with
  `whitespace=-trailing-space`, verify with `git check-attr`, recheck raw hashes
  `3688723e...`, `0d8861b6...`, and `7be7d164...`, validate the complete
  intended-untracked delivery set, run the full `git diff --cached --check`
  without exclusions, and pass the secret gate. Merge these entries with the
  incoming PR279 LF rules; never trim a historical byte or exclude it from the
  cached check.
- Statistics remain `Open`: sources are preserved, but write mode correctly
  refuses the dirty checkout. T071/T161 create a real bounded source commit,
  render only when clean, then validate and commit the generated follow-up.
  Stash, fake repository/index and guard overrides remain forbidden.

## Genehmigte Ausnahmen vom 10. September / Approved 10 September exceptions

- **Produktversion/Buildzähler**: `Applicable` ausschließlich für TinyPl0,
  TinyCalc, InventarWorkerService und TuiVision. T091/T102/T113/T126 erfassen
  die frischen drei Versionsfelder, Dateihashes und manuellen Buildzähler;
  T096/T107/T121/T132 sowie T097/T108/T122/T133 belegen nach erforderlichen
  `dotnet`-Gates und am finalen Head exakt null Änderung. Datiert beobachtet:
  `1.6.569.80`, `1.5.7.26`, `1.2.8.66`, `1.46.835.521`. Diese Werte sind kein
  Zukunftspass. Owner: jeweiliger Repository Owner; Reviewer: Product/Build
  Reviewer. Restrisiko: impliziter Bot-Inkrementpfad. Trigger: irgendein
  Wert-, Hash-, Counter-, Branch-, Build- oder Gatewechsel.
- **Constitution-Presetspiegel**: `Applicable` ausschließlich für AOC,
  InventarWorkerService und `absdd-image-sandbox`. Nach frischer Baseprüfung
  werden konfigurierte, installierte und in beiden Constitution-Spiegeln
  referenzierte `autonomous-run-governance`-Versionen exakt verglichen. Nur
  ein noch vorhandener Current-Reference-Drift wird in beiden Spiegeln
  zusammen mit lokaler Patchversion/Datum korrigiert; Prinzipien und echte
  historische Releasefakten bleiben erhalten. Lokale Agent-/Templateflächen
  werden atomar aktualisiert oder bei bereits passender Fassung begründet
  `N/A`. Keine Installation, Promotion oder globale Guidance-Änderung.
  Owner: jeweiliger Repository Owner; Reviewer: Governance/Agent-Parity
  Reviewer. Trigger: Base-, Config-, Install-, Mirror-, Template- oder
  Guidance-Drift.

## Home PR279 Source Gate

`Applicable/Open`. T067 verwendet ausschließlich den eingehenden Delta von
`2d1dc80065817426b97c13eeba8387f653b8cc41` zu
`91e9c7e5919063388dcc22da7616b3dd878acd19`, erhält alle Feature-/Untracked-
Bytes über einen begrenzten Preservation Commit, der bereits den vollständigen
Delivery-Set-/Allowlist-/Staged-Diff-/Secret-Gate besteht, und integriert ohne
Reset/Stash/Force. Die drei literalen historischen Whitespace-Attribute stehen
vor diesem Commit und werden mit den eingehenden LF-Regeln vereinigt. T069
reconciliert `scripts/config/script-catalog.json` vor
der generierten `docs/scripts/reference.md` und hält Statistik bis zum
Clean-Checkpoint offen. T070/T071 belegen die vollständige incoming
Path-/Ancestry-Abdeckung, die drei eingehenden LF-Attribute, die Home-Sync-
`sourceOnly`-Regel und genau drei exakte historische Analyze-Whitespace-
Attribute. Owner: Home Repository Owner; Reviewer: Source/Statistics Reviewer.
Residual risk: overlap loss or a premature current-statistics claim. Trigger:
Home head, incoming base/head, overlap path, attribute, catalog, sync manifest,
ledger, or renderer state changes.

## AOC Lifecycle-Auflösung / AOC lifecycle resolution

`Applicable/Open`. T079 inventarisiert nach lokalem Fast-forward die in US2
beobachteten historischen logischen Manifestpfade und ihre tatsächlichen
archivierten/featuregestempelten Dateien samt Hashes, einschließlich des
neueren META-LH-03-Lifecycle-Hashes. T080 verwendet nur diese eindeutige
repositorylokale Auflösung. Fehlende/mehrdeutige Ziele stoppen; Manifest,
Lifecycle und kanonische Intakepfade werden nicht geraten oder geändert.
Owner: AOC Repository Owner; Reviewer: Intake Governance Reviewer. Trigger:
Base-, Manifest-, Lifecycle-, Datei- oder Hashdrift.

## Hard-Stop-Matrix (T008)

| Failure class | Stop boundary | Owner | Next safe action | Re-evaluation trigger |
|---|---|---|---|---|
| Scope drift | before affected write | Feature Orchestrator | return to plan review and mutation allowlist | changed target/path/requirement |
| Dirty or diverged downstream | before branch/write | Repository Owner | preserve state; identify ownership; refresh read-only facts | clean reviewed base available |
| Missing/current-evidence failure | before positive claim | Evidence Owner | regenerate exact-head evidence | source, command, head, or hash changes |
| New dependency | before adoption | Security/Architecture Reviewer | separate supply-chain review and updated plan | package/lock/dependency delta |
| Product/runtime/API diff | before write/build | Product Owner | remove diff or seek separately reviewed scope | product path appears |
| Version/build counter drift in the four approved targets | immediately after the command and before checkpoint | Product/Build Reviewer | stop; restore no bytes implicitly; determine why the supposedly read-only surface changed | field, file hash, counter, build command, or head changes |
| Constitution correction exceeds the three approved local mirrors/current-version references | before staging | Governance Reviewer | stop and return to bounded plan review | principle, historical fact, preset, priority, global guidance, product, or runtime enters diff |
| Home PR279 path/ancestry or source reconciliation incomplete | before T070/T071 | Home Source Reviewer | preserve all bytes and reconcile the exact base-to-head delta source-first | incoming head/base/path set or overlap changes |
| T067 first commit lacks complete intended-untracked, staged-diff, secret, or three-path hash/attribute proof | before the Preservation Commit | Home Delivery Reviewer | keep bytes uncommitted, correct only the literal attributes or allowlist, and rerun the full mandatory set | intended path, historical hash, attribute, index, or secret-gate result changes |
| Local PreMerge uses the global 14-AC requirements or omits a declared local gate | before repository merge | Evidence Owner | regenerate from the pre-reviewed repository-local requirements and rerun all five exact-head gates | requirements hash, scope, command, runner, evidence, or reviewed head changes |
| AOC logical-to-archived/stamped resolution missing or ambiguous | before T080 adoption write | Intake Governance Reviewer | retain canonical lifecycle; refresh repository-local inventory | AOC base, manifest, lifecycle hash, or target file changes |
| Non-protection provider failure | before delivery advance | Delivery Owner | diagnose without bypass; retry only when safe | provider state changes |
| Reviewed-head drift | immediately | Technical Reviewer | invalidate affected proof and rerun gates | candidate bytes/head changes |
| Protection-only refusal | after all other gates pass | Delivery Owner | use only recorded narrow admin bypass, then verify | exact refusal at unchanged green head |
| Native Linux/Windows evidence absent | before repository completion | Cross-Platform Reviewer | keep `Open`; run approved native proof later | exact candidate available on runner |
| Human-only approval absent | before claim requiring it | Human Owner | retain `Open`; request human decision | dated human evidence exists |

No hard stop may be weakened into `N/A` for convenience. The protection-only
bypass changes neither technical gate semantics nor evidence duties.
