# Stage-B-Rollout validieren und betreiben / Validate and Operate the Stage B Rollout

## Deutsch

### 1. Zweck und harte Grenze

Diese Anleitung ist nach Implementierung der geplanten Stage-B-Oberflächen
ausführbar. Sie beginnt immer mit einer mutationsfreien Vorschau. Ein echter
`Deliver`- oder `Resume`-Aufruf kann Commits, Pushes, Pull Requests, Merges und
Rulesets in der autoritativen Flotte verändern. Er ist nur mit einem aktuellen,
schema-validierten `MergeAndSync`-Authority Binding zulässig.

Der Admin-Bypass ist kein CLI-Komfortschalter. Die Engine darf ihn erst nach
einem gescheiterten regulären Mergeversuch und nur mit vollständiger,
ziel-/zeit-/headgebundener Evidence verwenden. G4, Intake-Serie, Copilot,
Account und Subscription bleiben in jedem Modus unverändert.

### 2. Voraussetzungen

- Repositorywurzel ist `~/home-baseline-source`.
- Python 3, Git, `gh`, Bash und PowerShell 7 sind vorhanden.
- `gh auth status` ist erfolgreich; kein Token wird ausgegeben oder kopiert.
- Feature 029 ist terminal: Reviewed Head
  `e1ff2a0b5146604b2a71a20576dbd4341d618121`, Merge Commit
  `b6a0d81760e9ef68a058e5d9578073b5e78b61b8` und gültige PostMerge-Evidence.
- Aktiver Stage-B-Run ist
  `954ff259-ffed-44a8-883f-28742b031a9b` mit `MergeAndSync`.
- Der Arbeitsbaum und alle Zielklone sind sauber und nicht divergent.

Read-only Preflight:

```bash
git status --short
gh auth status
bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.sh \
  --state specs/030-stage-b-rollout/autonomous-run-state.json
```

Erwartung: leere Git-Statusausgabe, gültige GitHub-Sitzung und Exitcode `0`.
Ein anderer Exitcode stoppt vor Stage B.

Verwende für alle zwölf Primary-Befehle genau den repository-relativen,
versionierten Stage-B-Evidence-Root
`.specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1`.
Die Engine schreibt kausale Repository-, Wellen-, Budget-, Terminal- und
Closeout-Evidence nach `operational/`; der Gate-Aggregator schreibt nur
temporäre AC-SBR-Snapshots nach `primary/`. Interne Phasenresultate wie
`plan-remediation-1.result.json` bleiben direkt unter dem Autonomous-Run-Root.
Eine spätere redigierte Auswahl unter `specs/030-stage-b-rollout/evidence/v1/`
ist committed Feature-Evidence und ersetzt die operative Quelle nicht. Kein
persistierter Evidence-Eintrag darf einen absoluten lokalen Pfad enthalten.

### 3. Designverträge lokal prüfen

```bash
for schema in specs/030-stage-b-rollout/contracts/*.schema.json; do
  python3 -m json.tool "$schema" >/dev/null || exit $?
done
python3 -m json.tool \
  specs/030-stage-b-rollout/autonomous-run-gate-requirements.json >/dev/null
python3 scripts/tests/test_stage_b_rollout.py ContractTests
```

PowerShell:

```powershell
Get-ChildItem specs/030-stage-b-rollout/contracts/*.schema.json | ForEach-Object {
    python3 -m json.tool $_.FullName | Out-Null
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}
python3 -m json.tool specs/030-stage-b-rollout/autonomous-run-gate-requirements.json | Out-Null
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
python3 scripts/tests/test_stage_b_rollout.py ContractTests
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Erwartung: Exitcode `0`; keine Datei, kein Provider und kein Zielrepository
wird verändert.

### 4. Bash-Vorschau unter macOS/Linux

```bash
bash scripts/maintain-agentic-workspace.sh \
  --stage-b-action preflight \
  --dry-run
```

Erwartete lineare Ausgabe nennt in dieser Reihenfolge: Run-ID,
Authority-Status, dynamische Zielanzahl, fünf Wellen, erste zulässige Mutation
oder `N/A` für eine vollständig bereits konvergente No-op-Flotte,
Budgetstatus, Blocker und nächste Aktion. Die aktuelle Anzahl darf `48` sein,
wird aber live ermittelt. Vor jeder tatsächlichen Mutation muss der fixierte
Plan stattdessen eine konkrete erste Mutation enthalten. Vorschau schreibt
keine Evidence und erzeugt keinen Branch, Commit, PR, Merge, Ruleset oder
Home-Sync. Sie schreibt außerdem weder Rolloutplan noch Run-State; die letzte
lineare Ausgabezeile enthält den vollständigen normalisierten Plan als JSON.

### 5. PowerShell-Vorschau unter Windows

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 `
    -StageBAction Preflight `
    -WhatIf
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Erwartung: dieselbe fachliche Entscheidung, derselbe Exitcode und dieselben
normalisierten JSON-Felder wie bei Bash. Farbe oder Cursorposition ist für
keine Aussage erforderlich.

### 5a. Lokale Planpublikation nach Level-0-Lieferung

Dieser Schritt ist vom Remediation- und Lieferteil getrennt. Er darf erst vom
sauberen, synchronisierten Default-Head ausgeführt werden, nachdem die
Preflight-Implementierung regulär nach Level 0 geliefert wurde:

```bash
bash scripts/maintain-agentic-workspace.sh --stage-b-action preflight
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -StageBAction Preflight
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Der Aufruf liest Flotte und Provider live, hält den Snapshot nur im Speicher
und publiziert lokal zuerst den atomar ersetzten Rolloutplan und danach den
hashbindenden State als Commit-Marker. Er schreibt weder Git, Provider, Home
noch Zielrepositories. Der vorbereitete State trägt `authorityBinding.status`
`Pending`, `externalWriteGate=Closed`, `adminBypass=NotAuthorized` und
`N/A` statt behaupteter Autoritätsquelle oder -zeit. Ein Plan ohne State ist
nicht autoritativ; ein State ohne vorhandenen hashgleichen Plan ist ungültig.

### 6. Lokale vollständige Validierung

```bash
python3 scripts/tests/run_stage_b_rollout_acceptance.py \
  --gate AC-SBR-009 \
  --repository-root . \
  --evidence-root .specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1
```

Der Gate-Aggregator prüft Bash-/PowerShell-Parität, macOS-/Linux-/Windows-
Evidence, Syntax, PSScriptAnalyzer, Secret Scan, Security, A11Y,
Dokumentation, Statistik und Regressionen. Erwartung: Exitcode `0` und genau
eine Primary-Evidence-Zeile für `AC-SBR-009`. Interne Plattformnachweise sind
hashgebunden und behaupten keine nicht ausgeführte Plattform.

### 7. Public-Canary-Slice vor breitem Rollout

Zuerst Fake-Provider und Mutation-Spy:

```bash
python3 scripts/tests/test_stage_b_rollout.py PublicCanaryVerticalSliceTests
```

Erwartung:

- der absichtlich rote Fall blockiert mit erwartetem Code und `0` Writes;
- der grüne Fall durchläuft für `agent-operations-cockpit` Preflight, exakten
  Diff, Gates, PR, Review, Merge, Sync und kausale Evidence;
- Resume erzeugt `0` doppelte PRs;
- Exitcode des gesamten Testscopes ist `0`.

Die echte Canary-Ausführung darf erst nach diesem Nachweis und nach
Level-0-Merge/Sync beginnen.

### 8. Autorisierte Lieferung starten

Vorher immer erneut voranzeigen:

```bash
bash scripts/maintain-agentic-workspace.sh \
  --stage-b-action deliver \
  --dry-run
```

Nur wenn Vorschau, Authority, Delivery Set, G3, Budget und alle Gates aktuell
sind:

```bash
bash scripts/maintain-agentic-workspace.sh \
  --stage-b-action deliver
```

Windows:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 `
    -StageBAction Deliver `
    -WhatIf
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 `
    -StageBAction Deliver
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Der echte Aufruf verarbeitet genau ein Ziel zur Zeit. Er startet keine spätere
Welle, bevor alle Ziele der aktuellen Welle und die neue Budgetprojektion grün
sind. Er stoppt beim ersten nicht behebbaren Fehler vor dem nächsten Ziel.

### 9. Admin-Bypass-Auditgrenze

Es gibt absichtlich keinen Parameter wie `--force` oder `-AdminBypass`. Wenn
der normale Merge ausschließlich an einer Schutzregel scheitert, prüft die
Engine ausschließlich eine für T144 und den exakten aktuellen Mergefall frisch
erteilte, plan- und headgebundene Ausnahmeauthority. Der vorbereitete
Preflight-State enthält ausdrücklich keine solche Freigabe. Vor `gh pr merge
--admin` müssen folgende Felder vollständig sein:

- aktueller Authority-/Scope-Hash;
- Repository-ID, PR-Head, Bindungs- und Ablaufzeit;
- Grund und enger Scope;
- Action-ID und Ergebnis des regulären Mergeversuchs;
- unabhängige Acceptance-, Security-, Review- und Gate-Evidence-Hashes;
- anschließende Provideraktion und Post-Write-Verifikation.

Fehlt ein Feld oder ist es veraltet, lautet das Ergebnis `Blocked`; der Lauf
fordert neue ausdrückliche Authority und startet kein weiteres Ziel.

### 10. Stop und Resume

Ein kontrollierter Stop endet mit `130`. Fachlicher Drift/Gate-Blocker endet
mit `1`, Betriebs-/Schema-/Security-/Providerfehler mit `2`. Der State nennt
Welle, Ziel, letzte sichere Grenze, Blocker und nächste Aktion.

Resume immer zuerst voranzeigen:

```bash
bash scripts/maintain-agentic-workspace.sh \
  --stage-b-action resume \
  --dry-run
bash scripts/maintain-agentic-workspace.sh \
  --stage-b-action resume
```

PowerShell:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 `
    -StageBAction Resume `
    -WhatIf
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 `
    -StageBAction Resume
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

Resume verwendet dieselbe Run-ID, revalidiert die Gesamtflotte und bestätigt
bereits konvergierte Ziele read-only. Es startet am ersten nicht konvergierten
Ziel und erzeugt keine zweite PR-/Ruleset-Identität.

### 11. Terminale Prüfung und G4-Nichtmutation

```bash
bash scripts/maintain-agentic-workspace.sh \
  --stage-b-action verify \
  --dry-run
python3 scripts/tests/run_stage_b_rollout_acceptance.py \
  --gate AC-SBR-011 \
  --repository-root . \
  --evidence-root .specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1
python3 scripts/tests/run_stage_b_rollout_acceptance.py \
  --gate AC-SBR-012 \
  --repository-root . \
  --evidence-root .specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1
```

Erwartung: jede autoritative ID genau einmal konvergent, fünf grüne
Budgetprojektionen, `0` Restricted-Treffer und `Unchanged` für G4,
Intake-Serie, Copilot, Account und Subscription. Die einzige nächste Aktion
lautet: getrennt autorisiertes Intake-Series-Sequencing-Update anfordern; G4
nicht starten.

### 12. Home-Sync nur bei manifestgebundener Runtime

Stage-B-Implementierung ändert `scripts/` und ist damit `homeRuntime`. Erst
nach Level-0-Merge, Default-Sync und Authority-Revalidierung:

```bash
bash scripts/sync-home.sh --dry-run --no-pull
bash scripts/sync-home.sh --no-pull
```

Ein Konflikt, unerwarteter Pfad oder fehlende Authority stoppt. Design-,
Evidence- oder reine Zielrepository-Änderungen allein begründen keinen Sync.

### 13. Exitcodes

| Code | Bedeutung / Meaning |
|---:|---|
| `0` | Erfolg oder gültige mutationsfreie Vorschau |
| `1` | Fachlicher Drift-, Gate-, Review-, Budget- oder Konvergenzblocker |
| `2` | Schema-, Security-, Provider- oder Betriebsfehler |
| `3` | Bestehender Maintenance-Reparaturvertrag; nicht Stage-B-Erfolg |
| `130` | Kontrollierter Stop; explizites Resume erforderlich |

## English

### 1. Safety boundary

Run preview first. A real `Deliver` or `Resume` may create commits, pushes,
pull requests, merges, and rulesets and therefore requires a current validated
`MergeAndSync` authority binding. There is no force/bypass CLI switch. Admin
bypass is evaluated only after a regular protection-only merge refusal and
never replaces acceptance, security, review, or gate evidence.

All acceptance commands use the repository-relative Stage B evidence root
`.specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1`.
`operational/` is the causal run record, `primary/` contains temporary AC-SBR
snapshots, internal phase results remain directly below the autonomous run
root, and selected redacted committed evidence eventually goes to
`specs/030-stage-b-rollout/evidence/v1/`. Persisted evidence contains no
private absolute path. A fully converged no-op fleet may report
`firstMutation=N/A`; any actual write requires the concrete immutable binding
and a freshly open authority gate in mutable run state.

### 2. Preview and local validation

```bash
bash scripts/maintain-agentic-workspace.sh --stage-b-action preflight --dry-run
python3 scripts/tests/test_stage_b_rollout.py PublicCanaryVerticalSliceTests
python3 scripts/tests/run_stage_b_rollout_acceptance.py \
  --gate AC-SBR-009 --repository-root . \
  --evidence-root .specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1
```

Expected: exit `0`, a dynamically discovered fleet, five ordered waves, a
green `agent-operations-cockpit` fake-provider slice, cross-platform evidence,
and no write of any kind. The final linear preview line contains the complete
normalized rollout plan as JSON; preview creates neither plan nor state.

PowerShell preview:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -StageBAction Preflight -WhatIf
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
```

After the preflight remediation has been delivered separately and the local
default branch is clean and synchronized, publish the local plan and prepared
state:

```bash
bash scripts/maintain-agentic-workspace.sh --stage-b-action preflight
```

The live fleet snapshot remains in memory. The engine atomically replaces the
validated plan first and the validated state second; the state is the commit
marker and binds the exact plan hash. This call performs no Git, provider,
Home, or target-repository write. Prepared authority is `Pending`, the external
write gate is closed, admin bypass is not authorized, and source/timestamps are
`N/A`. A plan without state is non-authoritative; state without the matching
plan is invalid. Any bypass authority must be granted freshly at T144 for the
exact current merge case.

### 3. Authorized delivery and resume

```bash
bash scripts/maintain-agentic-workspace.sh --stage-b-action deliver --dry-run
bash scripts/maintain-agentic-workspace.sh --stage-b-action deliver
bash scripts/maintain-agentic-workspace.sh --stage-b-action resume --dry-run
bash scripts/maintain-agentic-workspace.sh --stage-b-action resume
```

Delivery is serial and stops before the next repository on the first
non-recoverable error. Resume retains the same run ID, revalidates the complete
fleet, confirms merged targets read-only, and creates no duplicate PR.

### 4. Terminal verification

```bash
bash scripts/maintain-agentic-workspace.sh --stage-b-action verify --dry-run
python3 scripts/tests/run_stage_b_rollout_acceptance.py \
  --gate AC-SBR-012 --repository-root . \
  --evidence-root .specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1
```

Expected: every authoritative repository is converged exactly once; all five
budget projections pass; G4, intake series, Copilot configuration, account,
and subscription are unchanged. The only next action is a separately
authorized sequencing update. This command does not start G4.
