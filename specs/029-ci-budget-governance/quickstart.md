# Stufe-A-Validierung / Stage A Validation

> Diese Anleitung beschreibt die nach der Implementierung verfügbaren
> Stufe-A-Aufrufe. In der Planphase selbst sind die neuen Schalter und
> Engine-Subcommands noch nicht implementiert.
>
> *This guide describes Stage A commands available after implementation. The
> new switches and engine subcommands do not exist during the plan phase.*

## Deutsch

### 1. Zweck und Sicherheitsgrenze

Mit der Vorschau prüfst du Profil, ausgewähltes Gate-Set, Einzelschritte und
Evidence-Ziel, ohne Evidence oder Repositorys zu ändern. Ein echter lokaler
Gate darf nur nach vollständigem Erfolg eine maschinenlokale Datei unter
`~/.home-baseline/evidence/ci-gates/` veröffentlichen.

Alle Stufe-A-Aufrufe sind lokal oder read-only. Sie dürfen keine
Zielrepositories, GitHub-Workflows, Rulesets, Account-/Reviewer-Einstellungen,
G4-Zustände oder Home Runtime ändern. Sie committen, pushen und mergen nicht.

### 2. Voraussetzungen

- Arbeitsverzeichnis ist der Level-0-Klon `home-baseline-source`.
- macOS/Linux: Bash und Python 3; Windows: PowerShell 7 und Python 3.
- Git ist verfügbar. Für die Live-Inventur ist `gh auth status` erfolgreich;
  der Adapter verwendet ausschließlich Lesezugriffe.
- Der Working Tree darf eigene Änderungen enthalten; die Vergleichsschritte
  unten prüfen, dass die Vorschau diesen Zustand nicht verändert.

### 3. Verträge und Fixture-Tests prüfen

```bash
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-budget-profile-registry.schema.json >/dev/null
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-budget-path-contracts.schema.json >/dev/null
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-gate-evidence.schema.json >/dev/null
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-inventory-rollout-plan.schema.json >/dev/null
python3 -m json.tool scripts/config/ci-budget-path-contracts.schema.json >/dev/null
python3 -m json.tool specs/029-ci-budget-governance/autonomous-run-gate-requirements.json >/dev/null
git check-ignore -q .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/test_ci_budget_governance.py
```

Erwartet: Exitcode `0`; alle Profil-, Evidence-, Hook-, Workflow-, Kosten-,
Determinismus- und Mutationsbarriere-Fixtures sind grün. Die Tests verwenden
temporäre Verzeichnisse und schreiben nicht zu GitHub. Negative Vertrags-
Fixtures blockieren ein zweites eingebettetes `pathContracts`, unbekannte Gate-
oder Produktjob-Referenzen und jede Abweichung des denormalisierten `profileId`.

PowerShell verwendet dieselben Python-Verträge:

```powershell
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-budget-profile-registry.schema.json *> $null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-budget-path-contracts.schema.json *> $null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-gate-evidence.schema.json *> $null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 -m json.tool specs/029-ci-budget-governance/contracts/ci-inventory-rollout-plan.schema.json *> $null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 -m json.tool scripts/config/ci-budget-path-contracts.schema.json *> $null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 -m json.tool specs/029-ci-budget-governance/autonomous-run-gate-requirements.json *> $null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
git check-ignore -q .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 scripts/tests/test_ci_budget_governance.py
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Jeder native PowerShell-Aufruf prüft `$LASTEXITCODE` unmittelbar vor dem
nächsten Befehl und beendet mit exakt diesem Exitcode. Dadurch kann ein späterer
Erfolg keinen früheren Fehler verdecken.

Die spätere Abnahme verwendet pro AC genau einen Primary-Aggregator. Für den
aktuellen Lauf sind dies die zehn vollständig aufgelösten Befehle:

```bash
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-001 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-002 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-003 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-004 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-005 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-006 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-007 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-008 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-009 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-010 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
```

`git check-ignore` muss Exitcode `0` liefern; damit ist die lauflokale Evidence
maschinenlokal und kann nicht versehentlich in die Lieferung gelangen. Jeder
Aggregator führt den vollständigen Scope selbst aus oder validiert seine
internen maschinenlokalen Bash-, PowerShell-, manuellen und Fixture-Dateien
fail-closed. Er nimmt den normalisierten SHA-256 jeder konsumierten Datei in
sein eigenes Ergebnis auf. Diese Inputs sind keine autonomen Gate-Evidence-
Zeilen und enthalten kein `supplementalFor`. Das finale Schema-2.0-Artefakt
enthält exakt zehn `Primary`-Zeilen, je eine pro AC mit dem realen Befehl oben
und `runnerOrPlatform="macOS"`, sowie null `Supplemental`-Zeilen. Bash und
PowerShell 7 werden beide manuell auf macOS ausgeführt; Fixtures belegen
zusätzlich die semantische macOS-/Linux-/Windows-Normalisierung.

### 4. Lokalen Gate unter macOS/Linux sicher voranzeigen

```bash
git status --porcelain=v1 --untracked-files=all > /tmp/cbg-status-before.txt
bash scripts/maintain-agentic-workspace.sh --ci-gate --dry-run
gate_status=$?
git status --porcelain=v1 --untracked-files=all > /tmp/cbg-status-after.txt
cmp /tmp/cbg-status-before.txt /tmp/cbg-status-after.txt
test "$gate_status" -eq 0
```

Erwartete lineare Ausgabe:

```text
Profil / Profile: <genau ein Profil>
Entscheidung / Decision: Preview
Status: Passed
Blocker: None
Naechste Aktion / Next action: Run without --dry-run only after review.
```

Zusätzlich werden Gate-Set-Hash, geordnete Einzelschritte und der geplante
Evidence-Pfad gezeigt. Es entsteht keine neue Evidence. `cmp` bestätigt einen
unveränderten Working Tree.

### 5. Lokalen Gate unter Windows sicher voranzeigen

```powershell
$before = @(git status --porcelain=v1 --untracked-files=all)
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CiGate -WhatIf
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
$after = @(git status --porcelain=v1 --untracked-files=all)
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
if (Compare-Object $before $after) { throw 'Die Vorschau hat den Working Tree verändert.' }
```

Erwartet: dieselbe fachliche Reihenfolge, dasselbe Profil, derselbe Gate-Set-
Hash und Exitcode `0` wie beim Bash-Aufruf. `-WhatIf` schreibt keine Evidence.
Die öffentliche Cmdlet-Oberfläche bleibt
`Invoke-HBAgenticWorkspaceMaintenance`.

### 6. Deterministische Fleet-Planung ohne Netzwerk simulieren

```bash
python3 scripts/lib/agentic_workspace_fleet.py ci-budget-plan \
  --repository-root . \
  --manifest scripts/config/agentic-workspace-fleet.json \
  --profiles scripts/config/ci-budget-profiles.json \
  --path-contracts scripts/config/ci-budget-path-contracts.json \
  --adapter fixture \
  --inventory scripts/tests/ci-budget-governance/fixtures/fleet-valid.json \
  --check-only \
  --output -
```

Erwartet: JSON auf stdout, Exitcode `0`, `stage="A"`,
`deliveryMode="LocalImplementation"`, `mutationsPerformed=false` und
`remoteConverged=false` in jedem Rollout-Eintrag. Die Repository-IDs sind
sortiert. Die autoritative Menge besteht aus dem aus Repositorywurzel und
konfiguriertem `origin` aufgelösten Self-Record `home-baseline` plus allen
aktiven `kind=git-repository`-Manifestzielen; aktuell 1 + 47 = 48. Der
Collection-Knoten `spec-kit-preset-projects` fehlt. Die drei Pflicht-Canaries
sind `home-baseline`, `agent-operations-cockpit` und `tui-vision`.
`--output -` erzeugt keine Datei. `source` und `sourceRevision` erscheinen
genau einmal an der Wurzel und binden atomar den vollständigen Snapshot. Jeder
Repository-Eintrag enthält `observedAt`, aber weder `source` noch
`sourceRevision`; ein Quellenmix oder partieller Refresh blockiert.
Jeder Eintrag besitzt außerdem ein `profileId`, das erst nach erfolgreicher
Assignment-Validierung kopiert wurde und exakt mit Assignment und Rollout-
Eintrag übereinstimmt. Die Ausgabe führt `profileRegistryHash` und
`pathContractHash` getrennt.

Wiederhole den Aufruf zweimal und vergleiche normalisierte Ausgaben mit einer
festen Fixture-Uhr. Abgesehen vom ausdrücklich injizierten Zeitstempel müssen
Entscheidungen, Hashes, Reihenfolge und Exitcode identisch sein.

### 7. Read-only Live-Inventur voranzeigen

```bash
gh auth status
python3 scripts/lib/agentic_workspace_fleet.py ci-budget-plan \
  --repository-root . \
  --manifest scripts/config/agentic-workspace-fleet.json \
  --profiles scripts/config/ci-budget-profiles.json \
  --path-contracts scripts/config/ci-budget-path-contracts.json \
  --adapter github-read-only \
  --check-only \
  --output -
```

Erwartet: Der Adapter führt nur GitHub-REST-GET-Leseabfragen aus. Er inventarisiert
Level 0 über dessen konfiguriertes `origin`, vereinigt diesen Self-Record mit
den 47 aktiven Manifest-Git-Zielen und meldet Live-Kardinalitäten statt den
Snapshot `3/6/6/21/12`. Jede unbekannte,
fehlende, doppelte oder sichtbarkeitswidrige ID sowie unvollständige/rate-
limitierte Live-Evidence blockiert fail-closed. Es wird kein veralteter Cache
als aktuell ausgegeben.

### 8. Echten lokalen Gate ausführen

Erst nach geprüfter Vorschau:

```bash
bash scripts/maintain-agentic-workspace.sh --ci-gate
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CiGate
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Erwartet bei Erfolg: Exitcode `0` und genau eine schema-gültige Datei unter
`~/.home-baseline/evidence/ci-gates/<repo-id>/<head>.json`. Start- und End-HEAD
sind gleich, der aktuelle Gate-Set-Hash stimmt, jedes Einzelergebnis ist
`Passed`, und die Datei enthält keine Secrets oder privaten Billingdetails.

Bei Gate-Fehler, HEAD-/Gate-Set-Wechsel, Signal oder unsicherem Evidence-Pfad:
Exitcode `1`, `2` oder `130`, eine stabile Blocker-/Next-Action-Ausgabe und
keine finale erfolgreiche Restdatei für diesen Lauf.

### 9. Pre-push- und Servergrenze prüfen

```bash
bash scripts/install-hooks.sh
cmp scripts/hooks/pre-push .git/hooks/pre-push
shasum -a 256 scripts/hooks/pre-push .git/hooks/pre-push
python3 scripts/tests/test_ci_budget_governance.py HookEvidenceRulesetTests
bash scripts/scan-agent-secrets.sh --fail-on-high .
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-007 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-008 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence
```

Erwartet: Die Installation folgt unmittelbar auf den Hook-Edit; `cmp` und die
beiden identischen SHA-256-Werte beweisen, dass `.git/hooks/pre-push` die neue
Version ist. Danach wird der tatsächlich installierte Hook manuell und direkt
mit sicheren, temporären Fixture-Remote-/Ref-Eingaben ausgeführt: passende
Fixture-Evidence erlaubt mit Exitcode `0`, fehlende, alte oder inkonsistente
Evidence blockiert mit einem Exitcode ungleich `0`. Die Eingaben werden über
stdin an den Hook gegeben; `git push` wird nicht aufgerufen. Befehl,
Quell-/Zielhash, Fixture-Identitäten und beide Exitcodes liegen unter
`.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/ac-cbg-007-008-hook-installation-macos.json`.
Die beiden Aggregatoren prüfen diese interne Datei fail-closed und binden ihren
Hash. Die Ruleset-/Workflow-Fixtures blockieren direkte, Web- und API-Default-
Branch-Schreibpfade auch bei fehlendem oder umgangenem Hook. Es wird kein
Ruleset aktiviert. Optionale Spec-Kit-Git-Commit-Hooks bleiben nicht
autorisiert und werden nicht ausgeführt.

### 10. Exitcodes

| Code | Bedeutung |
|---:|---|
| `0` | Gate/Plan erfolgreich oder gültige mutationsfreie Vorschau |
| `1` | Fachlicher Gate-, Mapping-, Profil-, Evidence- oder Driftblocker |
| `2` | Betriebs-, Schema-, Sicherheits-, Pfad- oder Live-Inventory-Fehler |
| `3` | Nur bestehender Maintenance-Reparaturvertrag; CI-Gate erzeugt ihn nicht |
| `130` | Kontrollierter Benutzerabbruch; keine neue Erfolgsevidence |

### 11. Explizite Nichtmutation

Nach allen Stufe-A-Prüfungen muss gelten:

- keine Zielrepository-Datei geändert;
- kein Commit, Push oder Merge;
- kein Home-Sync;
- kein GitHub POST/PUT/PATCH/DELETE;
- kein aktives Workflow/Ruleset/Account-/Reviewer-Update;
- kein G4-Start;
- Live-/Gate-/Rollout-Evidence ausschließlich maschinenlokal und unge-trackt.

## English

### 1. Purpose and safety boundary

Preview shows the selected profile, gate set, ordered steps, and evidence
destination without writing evidence or changing repositories. A real local
gate may publish one machine-local record only after every gate passes and
HEAD plus gate-set hash remain stable.

All Stage A operations are local or read-only. They must not change target
repositories, GitHub workflows, rulesets, account/reviewer settings, G4 state,
or Home Runtime. They do not commit, push, or merge.

### 2. Prerequisites

- Run from the Level-0 `home-baseline-source` clone.
- Use Bash and Python 3 on macOS/Linux; PowerShell 7 and Python 3 on Windows.
- Git is available. `gh auth status` succeeds for live inventory; the adapter
  uses read operations only.
- Existing working-tree changes are allowed; the status comparison proves that
  preview leaves them unchanged.

### 3. Validate contracts and fixtures

Run the JSON and Python commands from German step 3. Expected result: exit `0`
with all profile, evidence, hook, workflow, cost, determinism, and mutation-
barrier fixtures passing. Tests use temporary directories and never write to
GitHub. Run the ten literal aggregator commands from that step for final
acceptance. The schema-2.0 result has ten Primary rows and no Supplemental
rows; internal records are fail-closed inputs whose normalized hashes are
embedded in the aggregator results. The new design and installable path-
contract schemas are both parsed. In every PowerShell block, each native
invocation is followed immediately by a `$LASTEXITCODE` check that exits with
that exact code before any later command can mask the failure. Negative
contract fixtures reject a second embedded `pathContracts`, unknown gate or
product-job references, and denormalized `profileId` mismatch.

### 4. Preview the local gate

On macOS/Linux run the Bash commands from step 4. On Windows run the
PowerShell commands from step 5. Expected result: the same profile, gate-set
hash, ordered business output, and exit `0`. `--dry-run` and `-WhatIf` write no
evidence and leave the working tree unchanged.

### 5. Simulate or inspect the fleet

Use the fixture command from step 6 for deterministic offline proof. It
resolves `home-baseline` from the executing repository and configured origin,
then unions it with all active manifest Git targets; the current total is 48
and the collection remains excluded. Use the
`github-read-only` command from step 7 only when authenticated live inspection
is intended. `--output -` writes JSON to stdout and creates no report file.
Incomplete, stale, rate-limited, or classification-incompatible live data
fails closed. Root-level `source` and `sourceRevision` atomically bind the
complete snapshot; repository rows retain `observedAt` but neither source
field. Mixed-source or partial-refresh snapshots fail closed.
Each repository row also has a deliberately denormalized `profileId`, copied
only after assignment validation and required to equal both assignment and
rollout values. `profileRegistryHash` and `pathContractHash` remain separate.

### 6. Run the real local gate

After reviewing preview, run the Bash or PowerShell command from step 8.
Success means exit `0` and one schema-valid record at
`~/.home-baseline/evidence/ci-gates/<repo-id>/<head>.json`. Failure,
interruption, unsafe storage, HEAD drift, or gate-set drift leaves no successful
final record for that run.

### 7. Verify defense in depth

Run the installation, source/installed comparison, direct pass/block fixture,
aggregator, ruleset, and secret-scan sequence from step 9. Matching evidence
passes the newly installed local hook; missing or stale evidence blocks it.
The hook is invoked directly with safe fixture refs and remotes, so no push
occurs. Independently, the simulated server contract still requires a pull
request and the one lean status check when the hook is absent or bypassed. No
ruleset is activated, and optional Spec-Kit commit hooks remain skipped.

### 8. Exit codes and non-mutation

Exit codes are listed in step 10. After Stage A, the assertions in step 11 must
all remain true: no target edit, delivery action, Home sync, GitHub write,
active configuration change, or G4 start occurred; operational evidence stays
machine-local and untracked.
