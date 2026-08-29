# Schnellstart / Quickstart: GitHub-Copilot-Review-Governance

> Die lokale Implementierungsoberflaeche ist ausfuehrbar. Inventory, Apply und
> Rollback verwenden in dieser Anleitung ausschliesslich den expliziten
> Fake-Provider; ein Live-Fallback existiert nicht. Starte immer mit Preview
> und Validation. Kein Beispiel erteilt Live-Provider-Write-Autoritaet.

## Deutsch

### Voraussetzungen und sichere Reihenfolge

Arbeite im versionierten Level-0-Klon. Benoetigt werden PowerShell 7/.NET als
bindender Produkt- und Entscheidungskern, Git und `gh`; der Bash-Adapter auf
macOS/Linux startet genau einen `pwsh -NoProfile`-Prozess. Python 3 wird nur
fuer repositoryeigene Test-/Validierungshelfer benoetigt und trifft keine
Produktentscheidung. Fuer reine Preview-/Validate-Laeufe reicht eine
read-only GitHub-Anmeldung mit den dokumentierten minimalen Leserechten.
Browserwerte werden manuell und redigiert erfasst; exportiere keine Cookies,
Tokens, HTML-Seiten oder Browserprofile.

Die sichere Reihenfolge ist:

1. Hilfe lesen und Desired State validieren.
2. Frische read-only Inventur plus Browser-Evidence erfassen.
3. Preview ausfuehren und Plan/Hashes reviewen.
4. Validation und Tests ohne Providerwrites abschliessen.
5. Nur mit einem neuen operationsspezifischen External-Write-Gate anwenden.
6. Nachzustand und Null-Write-Zweitlauf validieren.
7. Rollback nur mit eigenem frischem Gate ausfuehren.

### Bash auf macOS/Linux: Preview zuerst

```bash
bash scripts/manage-copilot-review-governance.sh --help

bash scripts/manage-copilot-review-governance.sh \
  --action validate-desired-state \
  --desired-state scripts/config/copilot-review-governance-desired-state.json

bash scripts/manage-copilot-review-governance.sh \
  --action inventory \
  --read-only \
  --fake-provider .specify/runtime/copilot-review-governance/fake-provider.json \
  --output .specify/runtime/copilot-review-governance/inventory.json

bash scripts/manage-copilot-review-governance.sh \
  --action preview \
  --dry-run \
  --desired-state scripts/config/copilot-review-governance-desired-state.json \
  --inventory .specify/runtime/copilot-review-governance/inventory.json \
  --output .specify/runtime/copilot-review-governance/mutation-plan.json
```

Preview fuehrt null Providerwrites aus und muss die exakte Acht-Menge und ausschliesslich
`NoOp`, `Update`, `Create`, `Disable` oder `Blocked` ausgeben. `Blocked`,
unvollstaendige Pagination, `Unknown` auf einer Sollflaeche oder ein neuer
Planhash beendet den Ablauf vor Apply.

### PowerShell 7 auf Windows: Preview zuerst

```powershell
Get-Help ./scripts/manage-copilot-review-governance.ps1 -Full

pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action ValidateDesiredState `
    -DesiredStatePath scripts/config/copilot-review-governance-desired-state.json

pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action Inventory `
    -ReadOnly `
    -FakeProviderPath .specify/runtime/copilot-review-governance/fake-provider.json `
    -OutputPath .specify/runtime/copilot-review-governance/inventory.json

pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action Preview `
    -WhatIf `
    -DesiredStatePath scripts/config/copilot-review-governance-desired-state.json `
    -InventoryPath .specify/runtime/copilot-review-governance/inventory.json `
    -OutputPath .specify/runtime/copilot-review-governance/mutation-plan.json
```

PowerShell und Bash muessen fuer dieselben Inputs denselben kanonischen
Entscheidungshash und dieselbe Aktionsreihenfolge liefern.

### Read-only Validation und Tests

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action validate \
  --desired-state scripts/config/copilot-review-governance-desired-state.json \
  --inventory .specify/runtime/copilot-review-governance/inventory.json \
  --plan .specify/runtime/copilot-review-governance/mutation-plan.json

python3 scripts/tests/test_copilot_review_governance.py
```

```powershell
pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action Validate `
    -DesiredStatePath scripts/config/copilot-review-governance-desired-state.json `
    -InventoryPath .specify/runtime/copilot-review-governance/inventory.json `
    -PlanPath .specify/runtime/copilot-review-governance/mutation-plan.json
```

### Accountidentitaets-Vertragschecks vor Apply

Der planning-time Vertragscheck
`ExternalWriteGateAccountIdentityContractTests` ist fail-closed und fuehrt
mindestens diese Faelle aus:

| Fall | Erwartung |
|---|---|
| `AccountSetting`, `accountOwner=hindermath`, aktueller exakter Authority-Record, `BrowserManual`, `PersonalCopilotSettings:write`, alle drei Ziel-ID-Arrays leer | Schema und Semantik bestehen. |
| `accountOwner` fehlt oder ist nicht exakt `hindermath` | Schema scheitert. |
| Account des aktuellen Authority-Records stimmt nicht mit `accountOwner` ueberein | Semantik scheitert. |
| Repository-, Ruleset- oder PR-ID ist bei `AccountSetting` vorhanden | Schema scheitert. |
| `accountOwner` steht in `EffortLevel`, Ruleset-, PR-, Delivery- oder einem nicht accountbezogenen Rollback-Gate | Schema scheitert. |
| AccountSetting-Plan, Gate, Mutation Result und Account-Rollback verwenden nicht alle exakt `hindermath` | Der Cross-Record-Check scheitert vor Apply/Rollback. |

```bash
python3 scripts/tests/test_copilot_review_governance.py \
  ExternalWriteGateAccountIdentityContractTests
```

Danach muss `ExternalWriteGateClosedWorldContractTests` die positive
Minimalmenge aller neun Operationsklassen und die vorhandenen negativen
Delivery-/Providerfaelle erneut bestehen. Der Test verwendet nur Fixtures und
fuehrt keine Providerwrites aus. Ein vorhandenes Credential, `MergeAndSync`
oder ein Merge-Bypass wird nie als Accountautoritaet akzeptiert.

### Browser-Evidence

Erfasse getrennt:

- persoenliche Copilot-Einstellung `Automatic Copilot code review = Disabled`;
- fuer jede der acht exakten Repository-IDs `Code review effort = Lite`;
- manuelle Reviewer-Verfuegbarkeit vor und nach der Aenderung.

Nutze die mitgelieferte leere Browser-Evidence-Vorlage. Trage nur Zustand,
semantische UI-Pfadklasse, UTC-Zeit sowie Operator-/Reviewerrolle ein. Dann:

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action validate-browser-evidence \
  --browser-evidence .specify/runtime/copilot-review-governance/browser-evidence.json
```

Ein Screenshot kann machine-local Zusatzbeleg sein, ersetzt aber nie den
linearen Textrecord. Vor versionierter Evidence muss der Secret-/PII-Scan null
Treffer melden.

### Explizit autorisiertes Apply

Erst nach Review der exakten Change-Menge wird ausserhalb dieser Anleitung ein
neues Gate fuer genau eine Operationsklasse erstellt. Es bindet IDs,
Snapshot-/Plan-/Before-/Desired-/Rollback-Hashes, Scope, Zeitfenster und
Acceptance-/Security-/Review-/Technik-Evidence.

Der Gate-Validator akzeptiert keinen leeren oder frei geformten EvidenceRoot.
Er liest exakt `operational/live-read/authority.json`, `inventory.json`,
`mutation-plan.json` und `change-set-review.json` sowie
`operational/gate-evidence/acceptance.json`, `security.json`, `review.json` und
`technical.json`. Jede Datei wird vollständig semantisch geprüft und erneut
gehasht; der komplette Satz wird unmittelbar vor jedem FakeProvider-Write neu
gelesen. Für AccountSetting bleiben `PlanPath`, `ResultPath` und
`RollbackPlanPath` drei getrennte Records. Das exakte T134-Kommando aus
`tasks.md` liefert nur bei Authority/Plan/Gate/NotInvoked-Result/Rollback-
Gleichheit `Authorized`; jede Abweichung liefert `Blocked,writes=0`.

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action apply \
  --plan .specify/runtime/copilot-review-governance/mutation-plan.json \
  --authorization .specify/runtime/copilot-review-governance/external-write-gate.json \
  --fake-provider .specify/runtime/copilot-review-governance/fake-provider.json \
  --result .specify/runtime/copilot-review-governance/mutation-result.json \
  --evidence-root .specify/runtime/copilot-review-governance/evidence
```

```powershell
pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action Apply `
    -PlanPath .specify/runtime/copilot-review-governance/mutation-plan.json `
    -AuthorizationPath .specify/runtime/copilot-review-governance/external-write-gate.json `
    -FakeProviderPath .specify/runtime/copilot-review-governance/fake-provider.json `
    -ResultPath .specify/runtime/copilot-review-governance/mutation-result.json `
    -EvidenceRoot .specify/runtime/copilot-review-governance/evidence
```

Account-, Effort-, `RulesetCreate`-, `RulesetUpdate`-, `RulesetDisable`-,
PR-Lifecycle- und manuelle Reviewoperationen brauchen getrennte Gates.
`MergeAndSync` und ein Delivery-Bypass autorisieren keine Provider-Setting-
Aenderung. Apply schreibt serialisiert, prueft vor jeder Aktion den Before-
Hash und wiederholt einen unklaren Write nie blind. Diese lokale Anleitung
zeichnet Fake-Provider-Reads, Writes, Retries, Idempotenz, Reconciliation und
TOCTOU-Blocker auf; sie ruft keinen GitHub-Endpunkt auf.

### Nachzustand und Idempotenz

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action validate-after-state \
  --desired-state scripts/config/copilot-review-governance-desired-state.json \
  --evidence-root .specify/runtime/copilot-review-governance/evidence

bash scripts/manage-copilot-review-governance.sh \
  --action preview \
  --dry-run \
  --desired-state scripts/config/copilot-review-governance-desired-state.json \
  --inventory .specify/runtime/copilot-review-governance/evidence/operational/provider-convergence/after-inventory.json \
  --output .specify/runtime/copilot-review-governance/idempotency-plan.json
```

Erwartet: exakt acht konvergente Ziele, null aktive Copilot-Nichtziele, null
Drift und null Writes im zweiten Lauf. AI Credits, Actions-Minuten und
automatische/manuelle/unbekannte Trigger erscheinen getrennt.

### Explizit autorisierter Rollback

Rollback benoetigt einen neuen `Rollback`-Gate und stoppt bei jeder neueren
Provideraenderung:

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action rollback \
  --rollback-plan .specify/runtime/copilot-review-governance/rollback.json \
  --authorization .specify/runtime/copilot-review-governance/rollback-gate.json \
  --fake-provider .specify/runtime/copilot-review-governance/fake-provider.json \
  --result .specify/runtime/copilot-review-governance/rollback-result.json \
  --evidence-root .specify/runtime/copilot-review-governance/evidence
```

```powershell
pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action Rollback `
    -RollbackPlanPath .specify/runtime/copilot-review-governance/rollback.json `
    -AuthorizationPath .specify/runtime/copilot-review-governance/rollback-gate.json `
    -FakeProviderPath .specify/runtime/copilot-review-governance/fake-provider.json `
    -ResultPath .specify/runtime/copilot-review-governance/rollback-result.json `
    -EvidenceRoot .specify/runtime/copilot-review-governance/evidence
```

Create-Rollback deaktiviert die exakte neue ID; er loescht sie nicht.

### Exitcodes

| Code | Bedeutung |
|---:|---|
| `0` | Aktion vollstaendig und verifiziert. |
| `1` | Validierungs-, Test- oder Providerfehler. |
| `2` | Eingabe-, Schema-, Pfad- oder Aufruffehler. |
| `3` | Autoritaet fehlt/ist abgelaufen oder Drift/Unsicherheit blockiert. |
| `130` | Kooperativer Stop; Evidence bleibt resumierbar. |

## English

### Prerequisites and safe order

Work in the versioned Level-0 clone. PowerShell 7/.NET is the binding product
and decision core on every platform; the macOS/Linux Bash adapter starts one
`pwsh -NoProfile` process. Git and `gh` are required. Python 3 is used only by
repository-owned test/validation helpers and makes no product decision.
Read-only GitHub permissions are sufficient for preview and validation.
Browser facts are recorded manually and redacted; never export cookies,
tokens, raw HTML, or browser profiles.

Use this order: read help, validate desired state, capture fresh read-only API
and browser inventory, preview, review hashes, finish no-write validation, and
only then apply with a new operation-specific External Write Gate. Validate
the after-state and a zero-write second pass. Rollback needs its own fresh gate.
The repository-local examples require an explicit fake-provider file and never
fall back to a live provider. Read definitions bind API version `2026-03-10`.

### Bash on macOS/Linux: preview first

```bash
bash scripts/manage-copilot-review-governance.sh --help
bash scripts/manage-copilot-review-governance.sh \
  --action preview \
  --dry-run \
  --desired-state scripts/config/copilot-review-governance-desired-state.json \
  --inventory .specify/runtime/copilot-review-governance/inventory.json \
  --output .specify/runtime/copilot-review-governance/mutation-plan.json
```

Preview must report `providerWrites: 0`, the exact set of eight targets, and
only `NoOp`, `Update`, `Create`, `Disable`, or `Blocked` actions.

### PowerShell 7 on Windows: preview first

```powershell
Get-Help ./scripts/manage-copilot-review-governance.ps1 -Full
pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 `
    -Action Preview `
    -WhatIf `
    -DesiredStatePath scripts/config/copilot-review-governance-desired-state.json `
    -InventoryPath .specify/runtime/copilot-review-governance/inventory.json `
    -OutputPath .specify/runtime/copilot-review-governance/mutation-plan.json
```

Bash and PowerShell must produce the same canonical decision hash and action
order for the same inputs.

### Browser evidence

Record personal automatic review as `Disabled`, repository review effort as
`Lite` for each exact repository ID, and manual reviewer availability. Store
only the state, semantic UI path class, UTC time, and operator/reviewer roles.
Validate the redacted record:

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action validate-browser-evidence \
  --browser-evidence .specify/runtime/copilot-review-governance/browser-evidence.json
```

### Account identity contract checks before apply

Run the no-write planning-contract checks before apply. The positive fixture
must bind `AccountSetting` to exact `accountOwner=hindermath`, the current
explicit authority record, only `BrowserManual`, only
`PersonalCopilotSettings:write`, and empty repository/ruleset/PR ID arrays.
Fixtures with a missing or different account, an authority-record mismatch,
any target ID, or `accountOwner` in a non-account operation must fail. A
cross-record check must also reject any difference among the AccountSetting
mutation plan, gate, mutation result, and account rollback.

```bash
python3 scripts/tests/test_copilot_review_governance.py \
  ExternalWriteGateAccountIdentityContractTests
```

Then rerun `ExternalWriteGateClosedWorldContractTests` for all nine operation
classes and the existing negative Delivery/provider cases. These fixture-only
checks perform no provider write. Credentials, `MergeAndSync`, and a merge
bypass never count as account authority.

### Explicitly authorized apply and rollback

The gate validator requires the exact EvidenceRoot graph described in the
German section. It validates and re-hashes current authority, inventory, plan,
change-set review, and all four gate-evidence records. Account `PlanPath`,
`ResultPath`, and `RollbackPlanPath` remain separate; the exact T134 command is
authorized only for five-record identity and hash equality.

```bash
bash scripts/manage-copilot-review-governance.sh \
  --action apply \
  --plan .specify/runtime/copilot-review-governance/mutation-plan.json \
  --authorization .specify/runtime/copilot-review-governance/external-write-gate.json \
  --fake-provider .specify/runtime/copilot-review-governance/fake-provider.json \
  --result .specify/runtime/copilot-review-governance/mutation-result.json \
  --evidence-root .specify/runtime/copilot-review-governance/evidence

bash scripts/manage-copilot-review-governance.sh \
  --action rollback \
  --rollback-plan .specify/runtime/copilot-review-governance/rollback.json \
  --authorization .specify/runtime/copilot-review-governance/rollback-gate.json \
  --fake-provider .specify/runtime/copilot-review-governance/fake-provider.json \
  --result .specify/runtime/copilot-review-governance/rollback-result.json \
  --evidence-root .specify/runtime/copilot-review-governance/evidence
```

Use the PowerShell `-Action Apply` or `-Action Rollback` equivalents shown in
the German section on Windows. Account, effort, `RulesetCreate`,
`RulesetUpdate`, `RulesetDisable`, PR lifecycle, and manual-review writes
require separate gates. A delivery bypass is not provider settings authority.
Rollback never overwrites newer drift and never deletes a created ruleset.

### Expected exit codes

| Code | Meaning |
|---:|---|
| `0` | Operation completed and verified. |
| `1` | Validation, test, or provider failure. |
| `2` | Input, schema, path, or invocation error. |
| `3` | Missing/expired authority or safe drift/uncertainty refusal. |
| `130` | Cooperative stop; evidence remains resumable. |
