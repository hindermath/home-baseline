# MANAGE-COPILOT-REVIEW-GOVERNANCE(1)

## NAME

`manage-copilot-review-governance` — prüft und plant Copilot-Review-Governance
für eine geschlossene Repository-Menge. / Validates and plans Copilot review
governance for a closed repository set.

## SYNOPSIS

```text
bash scripts/manage-copilot-review-governance.sh --action preview --dry-run \
  --desired-state FILE --inventory FILE --output FILE
pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 \
  -Action Preview -WhatIf -DesiredStatePath FILE -InventoryPath FILE -OutputPath FILE
```

## BESCHREIBUNG / DESCRIPTION

Der sichere Einstieg ist immer Validation oder Preview. Der PowerShell-7/.NET-
Kern validiert geschlossene JSON-Verträge, exakte Identitäten und Hashes. Der
Bash-3.2-Adapter startet genau einen `pwsh -NoProfile`-Prozess. `--dry-run`,
`--read-only` und `-WhatIf` erzeugen keine Providerwrites.

The safe entry is always validation or preview. The PowerShell 7/.NET core
validates closed JSON contracts, exact identities, and hashes. The Bash 3.2
adapter starts exactly one `pwsh -NoProfile` process. Safe modes perform no
provider writes.

## AUTHORITY UND EXTERNAL-WRITE-GRENZE

Ein External-Write-Gate gilt nur für eine Operationsklasse, exakte IDs bzw.
`accountOwner=hindermath`, ein Zeitfenster, Hashes und Mindestberechtigungen.
Credentials, ein Merge-Gate oder Admin-Bypass erteilen keine Setting-Autorität.
Inventory darf mit `--read-only` und redigierter Browser-Evidence eine
vollstaendige GitHub-Live-Inventur ausschliesslich per GET erzeugen. Die
Read-Definitionen verwenden die akzeptierte GitHub-API-Version `2026-03-10`;
alle Live-Reads und unmittelbar vor dem Schreiben wiederholten Reads binden
genau einmal `--hostname github.com`, unabhaengig von `GH_HOST`;
transiente Transportfehler werden hoechstens dreimal versucht. Apply darf ohne
`--fake-provider` ausschliesslich `RulesetCreate`, `RulesetUpdate` und
`RulesetDisable` mit aktuellem operationsspezifischem Gate, exakten IDs,
festem Host/API-Header und genau einem POST-/PUT-Versuch pro Aktion live
ausfuehren. Zielrulesets gelten nur mit `target=branch` und exakt
`refs/heads/<defaultBranch>` ohne Ausschluss als konvergent; abweichende
Branch-Bedingungen werden korrigiert, Tag-/Push-Ziele blockiert. Ein unklares Ergebnis wird GET-only reconciled und nie blind
wiederholt. Account-/Effortwrites bleiben BrowserManual; Rollback bleibt eine
separat autorisierte Fake-Provider-Transaktion. `--read-only` blockiert Apply
und Rollback zentral vor jedem Live- oder Fake-Providerzugriff. Apply erzeugt
vor dem ersten Providerzugriff atomar einen privaten, dauerhaft erhaltenen
Single-Use-Claim. Ein zweiter Prozess oder eine spätere Wiederverwendung wird
abgelehnt; eine zwischenzeitliche Revocation wird beim Abschluss nicht
überschrieben.

## OPTIONEN / OPTIONS

- `--action`: validate, inventory, preview, apply, validate-after-state oder rollback.
- `--dry-run`, `--read-only`, `-WhatIf`: mutationsfreier Modus; Read-only
  lehnt Apply und Rollback ausnahmslos ab.
- `--authorization`: operationsspezifisches Gate.
- `--plan`: aktueller Mutation Plan; wird niemals durch `--rollback-plan` ersetzt.
- `--rollback-plan`: separater gebundener Rollbackrecord; keine Autorität.
- `--result`: deterministische Mutation-/Rollback-Ergebnisdatei; fuer Live-Ruleset-Apply optional mit operationsspezifischem Standardpfad.
- `--fake-provider`: explizite lokale Fixture-/Transaktionsdatei; fuer Rollback weiterhin zwingend.
- `--evidence-root`: restriktiver, symlinkfreier Evidence-Root.

Ein echter Live-Apply akzeptiert Evidence nur unter
`~/.home-baseline/copilot-review-governance/evidence`, wenn der komplette
Verzeichnispfad dem aktuellen Benutzer gehört und keine Gruppen-/Fremdrechte
beziehungsweise geerbten Windows-ACLs besitzt. Live-Providerwrites sind auf
die acht kanonischen Desired-State-Ziele und deren festen Default-Branch
begrenzt. Das Deaktivieren von Nichtziel-Rulesets bleibt bis zu einer separat
geprüften Cleanup-Allowlist manuell.

Der öffentliche Gate-Validator liest unter diesem Root zwingend
`operational/live-read/{authority,inventory,mutation-plan,change-set-review}.json`
sowie `operational/gate-evidence/{acceptance,security,review,technical}.json`,
prüft deren vollständige Semantik und bindet ihre normalisierten bzw. rohen
SHA-256-Werte an das Gate. Fehlende, leere, veraltete oder abweichende Records
blockieren mit null Writes.

`validate-after-state` leitet ohne `--inventory` den akzeptierten Pfad
`operational/provider-convergence/after-inventory.json` aus dem Evidence-Root
ab und prüft alle acht Ziele, Account Disabled, Lite, Nichtziele und die
dedizierten Review-Gate-Invarianten.

## EVIDENCE UND ROLLBACK

Evidence wird vor dem Hashen redigiert, atomar geschrieben und auf Benutzerzugriff
beschränkt. Der Evidence-Root selbst muss ein regulaeres, unverlinktes
Verzeichnis sein und wird vor Anlage und unmittelbar vor Publication erneut
geprueft. Rollback ist eine neue Transaktion mit eigenem Gate und stoppt bei
After-State-Drift. Ein erstelltes Ruleset wird deaktiviert, nie gelöscht.

## EXIT STATUS

- `0`: Validierung oder sichere lokale Operation erfolgreich.
- `1`: Validierungs- oder Providerfehler.
- `2`: ungültige Eingabe, Schema oder Pfad.
- `3`: fehlende Autorität oder Drift; keine Mutation.
- `130`: kontrollierter Abbruch.

## EXAMPLES

```bash
bash scripts/manage-copilot-review-governance.sh --action validate-desired-state \
  --desired-state scripts/config/copilot-review-governance-desired-state.json
```

```powershell
Get-Help ./scripts/manage-copilot-review-governance.ps1 -Full
```
