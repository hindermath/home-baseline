# Preset-7-/Preset-8-Dokumentations-Patches: Flottenabschluss 2026-07-20

## Zweck / Purpose

**DE:** Dieser Nachweis schliesst die Veroeffentlichung und den
33-Repository-Rollout der Dokumentations-Patch-Releases
`autonomous-run-governance` v0.3.1 und
`parallel-autonomous-run-governance` v0.2.2 ab. Er verbindet die
Release-Evidenz mit den exakten Rollout-Heads, den GitHub-Pruefungen, den
Merge-Commits und der anschliessenden Standardbranch-Validierung.

Die Patch-Releases verbessern Einstieg, Handbuecher, Mermaid-Diagramme,
Textalternativen und den sichtbaren Abhaengigkeitsvertrag. Commands, Skripte,
Templates, Schemas, Berechtigungen und Laufzeitverhalten wurden nicht
veraendert. Installation oder Dokumentation startet keinen autonomen Lauf und
erteilt keine Remote-, Merge-, Bypass- oder Provider-Berechtigung.

**EN:** This record closes the release and 33-repository rollout of
`autonomous-run-governance` v0.3.1 and
`parallel-autonomous-run-governance` v0.2.2. It connects release evidence with
the exact rollout heads, GitHub checks, merge commits, and final default-branch
validation.

The patch releases improve onboarding, manuals, Mermaid diagrams, text
alternatives, and the visible dependency contract. Commands, scripts,
templates, schemas, authority, and runtime behavior did not change.
Installation or documentation starts no autonomous run and grants no remote,
merge, bypass, or provider authority.

## Release-Identitaet / Release Identity

| Preset | Version | Public PR | Tag and `main` | ZIP SHA-256 |
|---|---:|---|---|---|
| Autonomous Run Governance | `v0.3.1` | [#10](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/10) | `c30accf37751` | `2d939a0942fc3b1dadb7c1824e491bdb2c410802e79a70308b44192473055dc7` |
| Parallel Autonomous Run Governance | `v0.2.2` | [#5](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/pull/5) | `65a7b71932e3` | `cd0767e2cecd96b7d36d79b82e25970c31854da1996b06e89c3a7be3147f36a1` |

Veroeffentlichte Releases:

- [Autonomous Run Governance v0.3.1](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.3.1)
- [Parallel Autonomous Run Governance v0.2.2](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.2)

## Abhaengigkeitsvertrag / Dependency Contract

- Preset 7 wird mit Prioritaet `70` vor Preset 8 mit Prioritaet `80`
  installiert.
- Jeder reale Worker einer Preset-8-Kampagne benoetigt ein installiertes und
  aktiviertes `autonomous-run-governance >=0.2.2`.
- Preset 8 orchestriert mehrere Preset-7-Laeufe. Es ersetzt deren Lifecycle-,
  Evidence- und Berechtigungsregeln nicht.
- Fehlend, deaktiviert und `0.2.1` werden vor dem Worker-Start abgelehnt;
  `0.2.2` und die aktuelle Version `0.3.1` werden angenommen.
- `requireAutonomousPreset: false` bleibt auf isolierte interne Fixtures
  begrenzt und ist kein dokumentierter Produktionsmodus.
- Es wurde kein vom Spec-Kit-Manifest nicht unterstuetztes
  `requires.presets`-Feld erfunden.

*Preset 7 is installed at priority `70` before Preset 8 at priority `80`.
Every real Preset-8 worker requires an installed and enabled
`autonomous-run-governance >=0.2.2`. Preset 8 coordinates Preset-7 runs but
does not replace their lifecycle, evidence, or authority rules.*

## Umfang und Abschluss / Scope and Completion

| Level | Repositories | Ergebnis / Result |
|---:|---:|---|
| 0 | 1 | Dokumentation, Matrix und kanonische Pakete ueber PR #79; Workflow-Pin ueber PR #80 |
| 1 | 7 | Alle registrierten Workspace-Repositories gemergt und synchronisiert |
| 2 | 25 | Alle registrierten Projekt-Repositories gemergt und synchronisiert |
| **Gesamt / Total** | **33** | **33/33 exact matrix, propagation, statistics, clean-tree, and remote-parity checks passed** |

Die 31 nach dem Level-0- und C64-Pilot verbliebenen Rollout-PRs verwendeten
jeweils zwei nachvollziehbare Commits: zuerst Toolchain, Konfiguration und
Guidance, danach das neu erzeugte Statistik-Ledger. Vor jedem Merge wurden der
exakte Head, Draft-Status, Mergefaehigkeit, ausstehende Checks und aktuelle
Review-Threads erneut geprueft.

*The 31 rollout PRs remaining after the level-0 and C64 pilot used two
traceable commits each: toolchain, configuration, and guidance first, followed
by the rendered statistics ledger. Exact head, draft state, mergeability,
pending checks, and current review threads were rechecked before every merge.*

## PR- und Merge-Matrix / PR and Merge Matrix

| Level | Repository | PR | Exact head | Merge commit | Evidence |
|---:|---|---|---|---|---|
| 0 | `hindermath/home-baseline` | [#79](https://github.com/hindermath/home-baseline/pull/79), [#80](https://github.com/hindermath/home-baseline/pull/80) | `089fcb67948e`, `0e3b3bd73e80` | `e1c49e90ee5c`, `b15d519bd5e8` | Live CI green on macOS, Linux, and Windows |
| 1 | `hindermath/c64-baseline` | [#7](https://github.com/hindermath/c64-baseline/pull/7) | `930db8f7909d` | `48dd1217083a` | Local gates green; provider N/A |
| 1 | `hindermath/container-images` | [#5](https://github.com/hindermath/container-images/pull/5) | `18a087abdca0` | `a6f9d4fcdaf6` | Local gates green; provider N/A |
| 1 | `hindermath/datagrip-baseline` | [#7](https://github.com/hindermath/datagrip-baseline/pull/7) | `8f4df157b797` | `2940520972c3` | Local gates green; provider N/A |
| 1 | `hindermath/rider-baseline` | [#7](https://github.com/hindermath/rider-baseline/pull/7) | `d31d7e48a481` | `09d221290f65` | Local gates green; provider N/A |
| 1 | `hindermath/secure-casetracker-baseline` | [#5](https://github.com/hindermath/secure-casetracker-baseline/pull/5) | `f293208af888` | `931b90bd3268` | Local gates green; provider N/A |
| 1 | `hindermath/secure-orderdesk-baseline` | [#5](https://github.com/hindermath/secure-orderdesk-baseline/pull/5) | `e59e602330be` | `607da29f6b09` | Local gates green; provider N/A |
| 1 | `hindermath/secure-serviceharvester` | [#5](https://github.com/hindermath/secure-serviceharvester/pull/5) | `fb24390dd95a` | `d3d093ca9c05` | Local gates green; provider N/A |
| 2 | `hindermath/cc65` | [#7](https://github.com/hindermath/cc65/pull/7) | `1df54fe54baa` | `b7bd136ff513` | Live CI green |
| 2 | `hindermath/absdd-image-sandbox` | [#13](https://github.com/hindermath/absdd-image-sandbox/pull/13) | `eb5c896e387d` | `bb153d086126` | Live CI green |
| 2 | `hindermath/InventarDb` | [#6](https://github.com/hindermath/InventarDb/pull/6) | `75918823a2f6` | `559b913989b6` | Local gates green; provider N/A |
| 2 | `hindermath/InventarWorkerService` | [#30](https://github.com/hindermath/InventarWorkerService/pull/30) | `0681a2ec19ee` | `ac279243d13e` | Technical CI green; Claude service error |
| 2 | `hindermath/TinyCalc` | [#24](https://github.com/hindermath/TinyCalc/pull/24) | `4f6716f96de5` | `591739473276` | Technical CI green; Claude service error |
| 2 | `hindermath/TinyPl0` | [#36](https://github.com/hindermath/TinyPl0/pull/36) | `6e2194b415ce` | `9539799194a7` | Technical CI green; Claude service error |
| 2 | `hindermath/TuiVision` | [#109](https://github.com/hindermath/TuiVision/pull/109) | `a192ab012a9a` | `bb53aab6b76e` | Live CI green |
| 2 | `hindermath/securecasetracker-csharp` | [#10](https://github.com/hindermath/securecasetracker-csharp/pull/10) | `6e20de1df53c` | `67c4ca69b850` | Local gates green; provider N/A |
| 2 | `hindermath/securecasetracker-go` | [#10](https://github.com/hindermath/securecasetracker-go/pull/10) | `815875677d39` | `a13e768f2ef5` | Local gates green; provider N/A |
| 2 | `hindermath/securecasetracker-java` | [#10](https://github.com/hindermath/securecasetracker-java/pull/10) | `6b0eda246405` | `e757f90de9d8` | Local gates green; provider N/A |
| 2 | `hindermath/securecasetracker-python` | [#10](https://github.com/hindermath/securecasetracker-python/pull/10) | `990a21f4c820` | `d5d37faa629f` | Local gates green; provider N/A |
| 2 | `hindermath/securecasetracker-rust` | [#10](https://github.com/hindermath/securecasetracker-rust/pull/10) | `474d9d42f3e9` | `90eae0c18178` | Local gates green; provider N/A |
| 2 | `hindermath/securecasetracker-swift` | [#10](https://github.com/hindermath/securecasetracker-swift/pull/10) | `bedf9a28866b` | `c2c4c488b4cd` | Local gates green; provider N/A |
| 2 | `hindermath/secureorderdesk-csharp` | [#5](https://github.com/hindermath/secureorderdesk-csharp/pull/5) | `acce9011499e` | `68abb29aa2be` | Local gates green; provider N/A |
| 2 | `hindermath/secureorderdesk-go` | [#5](https://github.com/hindermath/secureorderdesk-go/pull/5) | `2952e3b9d8f3` | `1e6370dcdc9b` | Local gates green; provider N/A |
| 2 | `hindermath/secureorderdesk-java` | [#5](https://github.com/hindermath/secureorderdesk-java/pull/5) | `aefb7d3c772b` | `ca4a3eadcc57` | Local gates green; provider N/A |
| 2 | `hindermath/secureorderdesk-python` | [#5](https://github.com/hindermath/secureorderdesk-python/pull/5) | `cc025b4f37fe` | `a8a62788f3fd` | Local gates green; provider N/A |
| 2 | `hindermath/secureorderdesk-rust` | [#5](https://github.com/hindermath/secureorderdesk-rust/pull/5) | `b6f4c6b60041` | `46faeeaf2eb8` | Local gates green; provider N/A |
| 2 | `hindermath/secureorderdesk-swift` | [#5](https://github.com/hindermath/secureorderdesk-swift/pull/5) | `6285860bd690` | `5cf37aa07069` | Local gates green; provider N/A |
| 2 | `hindermath/secureserviceharvester-csharp` | [#5](https://github.com/hindermath/secureserviceharvester-csharp/pull/5) | `7ce8403865bc` | `e0d1978bdcdd` | Local gates green; provider N/A |
| 2 | `hindermath/secureserviceharvester-go` | [#5](https://github.com/hindermath/secureserviceharvester-go/pull/5) | `c97cb7e3b55b` | `3e019418c8ce` | Local gates green; provider N/A |
| 2 | `hindermath/secureserviceharvester-java` | [#5](https://github.com/hindermath/secureserviceharvester-java/pull/5) | `35e4fea3c3f2` | `1cbaee7c20fc` | Local gates green; provider N/A |
| 2 | `hindermath/secureserviceharvester-python` | [#5](https://github.com/hindermath/secureserviceharvester-python/pull/5) | `60db07a9c7b5` | `21d3c8c2c6d1` | Local gates green; provider N/A |
| 2 | `hindermath/secureserviceharvester-rust` | [#5](https://github.com/hindermath/secureserviceharvester-rust/pull/5) | `d0c06c5fb3ed` | `d9c47e87bdc7` | Local gates green; provider N/A |
| 2 | `hindermath/secureserviceharvester-swift` | [#5](https://github.com/hindermath/secureserviceharvester-swift/pull/5) | `9964369b08ad` | `4042878971c6` | Local gates green; provider N/A |

## CI- und Review-Klassifikation / CI and Review Classification

### Private GitHub-Repositories

Die 25 privaten Repositories der abschliessenden 31-PR-Welle zeigten 117
fehlgeschlagene oder abgebrochene Jobs in den jeweils neuesten
Current-Head-Workflow-Laeufen. Fuer alle 117 Jobs gilt:

- Head-SHA entspricht exakt dem dokumentierten PR-Head;
- `steps=0`;
- `runner_id=0` und leerer Runner-Name;
- 25/25 repraesentative Repository-Annotationen nennen denselben
  GitHub-Billing-/Spending-Limit-Grund.

Diese Jobs sind `N/A` als externe Provider-Ablehnung. Sie sind weder
technischer Erfolg noch technischer Fehler. Die lokalen Gates umfassten exakte
Preset-Matrix, Preset-7-Abhaengigkeitsfixtures, aktuelle Statistik,
Toolchain-Paritaet, sauberen Diff und Secret-Scan mit `High: 0`. Der vorherige
C64-Level-1-Pilot zeigte dieselbe Null-Schritt-Providerklasse und wurde
getrennt dokumentiert.

*The 25 private repositories had 117 failed or canceled jobs in the latest
current-head workflow runs. Every job matched the exact head, had zero steps,
no runner, and the same representative billing/spending-limit annotation in
25 of 25 repositories. These jobs are external-provider `N/A`, neither a
technical pass nor a technical failure.*

### Oeffentliche GitHub-Repositories

- `home-baseline`, `cc65`, `TuiVision` und `absdd-image-sandbox` bestanden ihre
  real gestarteten technischen Current-Head-Checks.
- `cc65` bestand Linux in `5m00s` und Windows einschliesslich kompletter
  Regressionstests in `17m56s`.
- `InventarWorkerService`, `TinyCalc` und `TinyPl0` bestanden alle technischen
  Checks. Nur `claude-review` endete nach normalem Runner-Start mit
  `subtype: success` und gleichzeitig `is_error: true`.
- Die drei Claude-Jobs erzeugten keinen Review-Kommentar, keinen
  Permission-Denial und keinen technischen Befund. Sie wurden als externer
  Review-Dienstfehler dokumentiert und nicht blind wiederholt.
- In allen 31 Abschluss-PRs gab es `0` aktuelle ungeloeste Review-Threads;
  Head-Drift und Draft-PRs bestanden ebenfalls nicht.

*Real public CI passed for the technical jobs. Three Claude review actions
failed with an inconsistent provider result after starting normally, but
produced no review finding or unresolved thread.*

## Technische Endvalidierung / Final Technical Validation

- `33/33` exakte Acht-Preset-Matrix mit
  `install-spec-kit-governance-presets.sh --check-only`
- `33/33` kanonische Toolchain-Paritaet mit
  `propagate-agentic-toolchain-maintenance.sh --check-only`
- `33/33` aktuelle Statistik-Profil-2-Ledger mit
  `render-project-statistics.sh --check-only --json`
- `33/33` saubere validierte Arbeitsbaeume
- `33/33` Standardbranches exakt gleich `origin/<default>`
- Preset 7 v0.3.1 und Preset 8 v0.2.2 einzeln sowie gemeinsam in der
  Acht-Preset-Matrix validiert
- `14/14` Mermaid-Diagramme syntaktisch gerendert und in GitHub hell/dunkel
  kontrolliert
- vollstaendige DE-/EN-Textalternativen, Pandoc-Lesereihenfolge und
  Lychee-Linkpruefung bestanden
- Release-ZIPs isoliert entpackt, gehasht und mit den Publikationskopien
  verglichen
- Missing-, Disabled-, Outdated-, Minimum- und Current-Fixtures des
  Preset-7-Abhaengigkeitsvertrags bestanden
- bestehende Coordinator-, Schema-, State-, Evidence-, Stop-, Resume- und
  Consolidation-Tests blieben gruen

## Abweichungen und Schutzmassnahmen / Exceptions and Safeguards

- Das urspruengliche `C64Projects/cc65`-Arbeitsverzeichnis blieb auf
  `upstream/noexec-bsd-find` mit seinen 29 fremden ungetrackten Build- und
  IDE-Dateien unveraendert. Rollout, Merge und Validierung erfolgten im isolierten
  Worktree
  `~/.home-baseline/worktrees/cc65-standard-eight-governance-presets`.
- Ein temporaerer Download-Timeout beim iSAQB-Preset in
  `securecasetracker-go` wurde durch eine vollstaendige, anschliessend exakt
  gepruefte Neuinstallation repariert.
- `InventarDb` behaelt eine bereits auf `main` vorhandene, diff-fremde
  PSScriptAnalyzer-Warnung in `scripts/lib/hg-secrets.ps1`. Alle geaenderten
  PowerShell-Bereiche waren ohne Befund.
- Vom Installer erzeugte zusaetzliche Leerzeilen und die Entfernung
  bestehender Legacy-OpenCode-Wrapper wurden nicht als Teil dieses
  Dokumentations-Patches uebernommen.
- Der `cc65`-Build meldete eine bestehende Node-20-Deprecation-Warnung fuer
  unveraenderte Workflow-Actions. Sie war kein Befund des Preset-Patches.
- Der Vergleich mit `TuiVision` zeigte einen neueren, bereits validierten
  `actions/checkout@v7`-Pin. Der kanonische Level-0-Workflow wurde vor dem
  Flottenrollout ueber PR #80 entsprechend aktualisiert.

## Wiederverwendbare Erkenntnisse / Reusable Learnings

1. Ein Flottenrollout ist erst nach Merge, Standardbranch-Synchronisation,
   exakter Remote-Paritaet und erneutem Check-only-Lauf abgeschlossen.
2. Ein roter GitHub-Check darf nicht nur nach `conclusion` klassifiziert
   werden. Head, Runner, Schritte und Annotation entscheiden, ob ein
   technischer Fehler oder eine Provider-Ablehnung vorliegt.
3. Wiederholte Current-Head-Laeufe koennen denselben Statuskontext mehrfach
   anzeigen. Die neueste Workflow-Ausfuehrung wird vollstaendig geprueft;
   historische Duplikate werden nicht als neue Fehler gezaehlt.
4. Ein gestarteter Review-Provider kann ohne Reviewbefund scheitern, waehrend
   alle technischen Checks gruen sind. Review-Dienst, technische Gates und
   formale Approval-Pflicht bleiben getrennte Evidenzklassen.
5. Dokumentations-Patches duerfen keine generierten Commands, Legacy-Wrapper
   oder projektspezifischen Dateien stillschweigend veraendern.
6. Ein isolierter Worktree ist der sichere Rollout-Pfad, wenn der primaere
   Arbeitsbaum fremde Aenderungen enthaelt.
7. Preset-8-Dokumentation muss die Preset-7-Abhaengigkeit sichtbar machen,
   waehrend der Koordinator sie weiterhin fail-closed prueft.

*A fleet rollout is complete only after merge, default-branch synchronization,
exact remote parity, and another check-only pass. Provider refusals, technical
failures, review-service failures, and formal approval requirements remain
separate evidence classes.*

## Abschluss / Closeout

Alle 33 registrierten Level-0-/1-/2-Repositories verwenden die
Dokumentations-Patch-Versionen in der Standard-Achtermatrix. Die 31
abschliessenden Rollout-PRs und die vorherigen Level-0-/C64-Pilot-PRs sind
gemergt. Der verwendete Admin-Bypass ersetzte die formale Code-Owner-Stimme,
nicht die technische oder Review-Evidenz.

*All 33 registered level-0/1/2 repositories use the documentation patch
versions in the standard eight-preset matrix. The 31 final rollout PRs and the
earlier level-0/C64 pilot PRs are merged. The owner admin bypass replaced the
formal code-owner vote, not technical or review evidence.*
