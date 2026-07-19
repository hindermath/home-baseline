# Standard-Achtermatrix: Fleet-Rollout 2026-07-19

## Zweck / Purpose

**DE:** Dieser Nachweis dokumentiert die Erweiterung der bereits in 25
Level-2-Repositories installierten Achtermatrix auf die gesamte registrierte
Workspace-Flotte. Der Rollout umfasst Level 0, alle sieben Level-1-Repositories
und alle 25 Level-2-Repositories. Installation allein startet keinen autonomen
oder parallelen autonomen Lauf und erteilt keine zusaetzlichen Berechtigungen.

**EN:** This record documents the expansion of the eight-preset matrix, already
installed in 25 level-2 repositories, to the complete registered workspace
fleet. The rollout covers level 0, all seven level-1 repositories, and all 25
level-2 repositories. Installation alone starts no autonomous or parallel
autonomous run and grants no additional authority.

## Verbindliche Matrix / Binding Matrix

| Priority | Preset | Version |
|---:|---|---:|
| 10 | `security-governance` | `v0.6.1` |
| 20 | `architecture-governance` | `v0.5.1` |
| 30 | `isaqb-architecture-governance` | `v0.2.1` |
| 40 | `a11y-governance` | `v0.4.1` |
| 50 | `cross-platform-governance` | `v0.2.1` |
| 60 | `agent-parity-governance` | `v0.4.0` |
| 70 | `autonomous-run-governance` | `v0.3.0` |
| 80 | `parallel-autonomous-run-governance` | `v0.2.1` |

## Umfang / Scope

| Level | Repositories | Ergebnis / Result |
|---:|---:|---|
| 0 | 1 | Exakte Achtermatrix installiert und mit Bash sowie PowerShell geprueft |
| 1 | 7 | Alle registrierten Workspace-Repositories aktualisiert |
| 2 | 25 | Alle registrierten Projekt-Repositories aktualisiert |
| **Gesamt / Total** | **33** | **33/33 exact matrix checks passed** |

Die Level-1-Gruppen sind `C64Projects`, `DataGripProjects`, `RiderProjects`,
`SecureOrderDeskProjects`, `SecureServiceHarvesterProjects`,
`container-images` und `secure-casetracker-baseline`. Die Level-2-Menge
umfasst die registrierten Einzelprojekte sowie die sechs MSL-Sprachzweige der
drei Secure-Trader-Familien, soweit sie im operativen Register vorhanden sind.

*The level-1 groups are `C64Projects`, `DataGripProjects`, `RiderProjects`,
`SecureOrderDeskProjects`, `SecureServiceHarvesterProjects`,
`container-images`, and `secure-casetracker-baseline`. The level-2 set contains
the registered individual projects and the six MSL language branches of the
three Secure Trader families where present in the operational registry.*

## Dokumentationsabgleich / Documentation Alignment

**DE:** Alle aktuellen normativen Agenten-, Constitution-, README-,
Secure-Development-, Lernreihen-, Lernbegleiter-, Praesentations- und
Lastenheft-Stellen, die zuvor sechs oder sieben Presets verlangten, wurden auf
acht Presets aktualisiert. Die Level-0-Quellen wurden in 503 vorhandene
kanonische Dokumentkopien synchronisiert. Alte Versionsprotokolle, abgeschlossene
Feature-Specs, Feldtestevidenz, Changelogs und Statistikzeilen wurden nicht
rueckwirkend umgeschrieben.

**EN:** All current normative agent, constitution, README, secure-development,
learning-series, learner-guide, presentation, and intake locations that
previously required six or seven presets were updated to eight presets. The
level-0 sources were synchronized into 503 existing canonical document copies.
Old version logs, completed feature specs, field-test evidence, changelogs, and
statistics entries were not rewritten retroactively.

Audit-Ergebnis / Audit result:

- `0` nicht-historische Sechs-/Siebenerstellen
- `112` absichtlich erhaltene historische Richtlinienzeilen
- `0` unerwartete geaenderte Pfade

## Technische Validierung / Technical Validation

- `33/33` `git diff --check`
- `33/33` Bash parser checks
- `33/33` PowerShell parser checks
- `33/33` exact matrix checks with
  `install-spec-kit-governance-presets.* --check-only`
- `928/928` propagated toolchain file comparisons, `0` drift
- `503/503` canonical documentation comparisons, `0` drift
- Level-0 Bash and PowerShell exact checks both passed
- One transient release-download timeout in
  `SecureOrderDesk-CSharp` was repaired by a complete forced reinstall and
  subsequent exact check
- The published `parallel-autonomous-run-governance` patch release `v0.2.1`
  was reinstalled and revalidated in all 33 repositories. Its tag ZIP has
  SHA-256
  `1322ef523f2288076237d477eb45656cf330ff3573bf5fcfe3c94e9c204f49d2`.
- GitHub rejected 60 deduplicated PR workflow runs twice before their first
  step. Attempt 2 contained 123 jobs with no runner and no steps: 115 carried
  the identical billing/spending-limit annotation and eight matrix jobs were
  canceled only because a sibling job had received that annotation. These
  provider refusals are recorded as `N/A`; no technical check is reported as
  passed on their basis.

The dirty user worktree in `C64Projects/cc65` was not modified. Its rollout was
prepared in the isolated worktree
`~/.home-baseline/worktrees/cc65-standard-eight-governance-presets` from
`origin/master`.

## Uebernommene Erkenntnisse / Adopted Learnings

**KI-Agenten-Dateien / AI-agent guidance**

- Fleet rollouts are complete only after install, exact check, commit, push,
  and required main-branch synchronization at every registered level.
- Generated preset paths and unrelated user changes must be classified
  separately.
- Normative documentation is migrated; historical evidence remains immutable.
- Provider-side zero-step refusals remain distinct from passed or failed
  technical gates.

**Sieben bestehende Presets / Seven existing presets**

- Security: narrow provider-refusal classification, no bypass-as-evidence.
- Architecture: resumable remote transactions, exact heads, idempotent
  manifest-owned post-merge actions, and stacked-base revalidation.
- iSAQB: interruption, partial failure, resume, and idempotency scenarios.
- A11Y: equivalent accessible text and JSON status, stable ordering, and
  understandable repeated lifecycle operations.
- Cross-platform: check-only parity, root invocation, scoped native overrides,
  and separation of OS from provider evidence.
- Agent parity: all-level fleet completion, generated-path classification,
  normative-versus-historical migration, and secret-free runner metadata.
- Autonomous run: schema-1.1 closeout semantics, strict final validation, and
  delivery-mode-specific completion.

## Veroeffentlichte Preset-Releases / Published Preset Releases

| Preset | Pull Request | Release |
|---|---|---|
| Security | `hindermath/spec-kit-preset-security-governance#3` | `v0.6.1` |
| Architecture | `hindermath/spec-kit-preset-architecture-governance#2` | `v0.5.1` |
| iSAQB Architecture | `hindermath/spec-kit-preset-isaqb-architecture-governance#2` | `v0.2.1` |
| A11Y | `hindermath/spec-kit-preset-a11y-governance#2` | `v0.4.1` |
| Cross-Platform | `hindermath/spec-kit-preset-cross-platform-governance#2` | `v0.2.1` |
| Agent Parity | `hindermath/spec-kit-preset-agent-parity-governance#2` | `v0.4.0` |
| Autonomous Run | `hindermath/spec-kit-preset-autonomous-run-governance#9` | `v0.3.0` |
| Parallel Autonomous Run | `hindermath/spec-kit-preset-parallel-autonomous-run-governance#4` | `v0.2.1` |

Copilot-Hinweise wurden vor den Merges fachlich behandelt. Der erforderliche
Admin-Bypass ersetzte nur die fehlende formale externe Approval-Stimme, nicht
die technischen Checks oder die Review-Evidenz.

*Copilot findings were addressed before merging. The required admin bypass
replaced only the missing formal external approval vote, not technical checks
or review evidence.*
