#Requires -Version 7.0
<#
.SYNOPSIS
    Verwaltet GitHub-Copilot-Review-Governance sicher und reproduzierbar.

    Safely and reproducibly manages GitHub Copilot review governance.

.DESCRIPTION
    DE: Validiert Sollzustand, Inventur, Preview, operationsspezifische
    External-Write-Gates, Nachzustand und Rollback. Providerdaten gelten als
    nicht vertrauenswuerdige Eingabe. Ohne frisches Gate, exakte IDs und
    Hashbindung bleibt jede Mutation blockiert. In der lokalen
    Implementierungsphase arbeiten Apply und Rollback nur mit einem expliziten
    FakeProviderPath und deterministischem ResultPath; ein Live-Fallback
    existiert nicht. Ausgabe ist linear, textorientiert und farbunabhaengig.

    EN: Validates desired state, inventory, preview, operation-specific
    external-write gates, after-state, and rollback. Provider data is untrusted
    input. Every mutation remains blocked without a fresh gate, exact IDs, and
    hash binding. During local implementation Apply and Rollback work only with
    an explicit FakeProviderPath and deterministic ResultPath; no live fallback
    exists. Output is linear, text-first, and independent of colour.

.PARAMETER Action
    ValidateDesiredState, Validate, Preview, Inventory, ValidateInventory,
    ValidateBrowserEvidence, ValidateExternalWriteGate, Apply,
    ValidateAfterState, Rollback oder ValidateUsage.

.PARAMETER DesiredStatePath
    Pfad zum unveraenderlichen Acht-Ziel-Sollvertrag.

.PARAMETER InventoryPath
    Pfad zu einer vollstaendigen frischen oder Fixture-Inventur.

.PARAMETER AuthorizationPath
    Pfad zum aktuellen operationsspezifischen External-Write-Gate.

.PARAMETER RollbackPlanPath
    Separater Pfad zum gebundenen Rollbackrecord. Er ersetzt PlanPath niemals
    und erteilt keine Autoritaet.

.PARAMETER ResultPath
    Exakter Pfad fuer das deterministische Apply-/Rollback-Ergebnis.

.PARAMETER FakeProviderPath
    Explizite lokale Fake-Provider-Transaktionsdatei. Es gibt keinen stillen
    Fallback auf einen Live-Provider.

.PARAMETER EvidenceRoot
    Restriktiver maschinenlokaler Evidence-Root mit aktueller Authority,
    Inventory, Mutation Plan, Change-Set-Review und vier Gate-Evidenceklassen.

.PARAMETER ReadOnly
    Erzwingt eine mutationsfreie Inventur-/Validierungsoberflaeche.

.PARAMETER DryRun
    Erzwingt Preview/Read-only und null reale Providerwrites. Fake-Provider-
    Transaktionen bleiben nur mit explizitem FakeProviderPath moeglich.

.OUTPUTS
    Kanonisches JSON. Exitcodes: 0 Erfolg, 1 Validierungs-/Providerfehler,
    2 Eingabe-/Schema-/Pfadfehler, 3 fehlende Autoritaet oder Drift, 130 Stop.

.EXAMPLE
    pwsh -NoProfile -File scripts/manage-copilot-review-governance.ps1 -Action Preview -WhatIf -DesiredStatePath scripts/config/copilot-review-governance-desired-state.json -InventoryPath scripts/tests/copilot-review-governance/fixtures/vertical-slice/home-baseline-green.json -OutputPath /tmp/copilot-review-plan.json
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory)]
    [ValidateSet('ValidateDesiredState', 'Validate', 'Preview', 'Inventory', 'ValidateInventory', 'ValidateBrowserEvidence', 'ValidateExternalWriteGate', 'Apply', 'ValidateAfterState', 'Rollback', 'ValidateUsage')]
    [string] $Action,

    [string] $DesiredStatePath = '',
    [string] $InventoryPath = '',
    [string] $OutputPath = '',
    [string] $BrowserEvidencePath = '',
    [string] $AuthorizationPath = '',
    [string] $PlanPath = '',
    [string] $RollbackPlanPath = '',
    [string] $ResultPath = '',
    [string] $FakeProviderPath = '',
    [string] $EvidenceRoot = '',
    [string] $OperationClass = '',
    [switch] $ReadOnly,
    [switch] $DryRun,
    [ValidateSet('Json', 'Text')]
    [string] $OutputFormat = 'Json'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Set-HBCopilotReviewGovernance {
    <#
    .SYNOPSIS
        Fuehrt eine validierte Copilot-Review-Governance-Aktion aus.

        Executes one validated Copilot review-governance action.
    #>
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory)][string] $Action,
        [string] $DesiredStatePath = '',
        [string] $InventoryPath = '',
        [string] $OutputPath = '',
        [string] $BrowserEvidencePath = '',
        [string] $AuthorizationPath = '',
        [string] $PlanPath = '',
        [string] $RollbackPlanPath = '',
        [string] $ResultPath = '',
        [string] $FakeProviderPath = '',
        [string] $EvidenceRoot = '',
        [string] $OperationClass = '',
        [switch] $ReadOnly,
        [switch] $DryRun
    )

    $modulePath = Join-Path $PSScriptRoot 'modules/CopilotReviewGovernance.psm1'
    Import-Module $modulePath -Force
    $effectiveDryRun = $DryRun -or [bool] $WhatIfPreference
    return Invoke-HBCopilotReviewGovernance `
        -Action $Action `
        -DesiredStatePath $DesiredStatePath `
        -InventoryPath $InventoryPath `
        -OutputPath $OutputPath `
        -BrowserEvidencePath $BrowserEvidencePath `
        -AuthorizationPath $AuthorizationPath `
        -PlanPath $PlanPath `
        -RollbackPlanPath $RollbackPlanPath `
        -ResultPath $ResultPath `
        -FakeProviderPath $FakeProviderPath `
        -EvidenceRoot $EvidenceRoot `
        -OperationClass $OperationClass `
        -ReadOnly:$ReadOnly `
        -DryRun:$effectiveDryRun
}

try {
    $result = Set-HBCopilotReviewGovernance `
        -Action $Action `
        -DesiredStatePath $DesiredStatePath `
        -InventoryPath $InventoryPath `
        -OutputPath $OutputPath `
        -BrowserEvidencePath $BrowserEvidencePath `
        -AuthorizationPath $AuthorizationPath `
        -PlanPath $PlanPath `
        -RollbackPlanPath $RollbackPlanPath `
        -ResultPath $ResultPath `
        -FakeProviderPath $FakeProviderPath `
        -EvidenceRoot $EvidenceRoot `
        -OperationClass $OperationClass `
        -ReadOnly:$ReadOnly `
        -DryRun:$DryRun `
        -WhatIf:$WhatIfPreference
    if ($OutputFormat -eq 'Json') { $result | ConvertTo-Json -Depth 40 }
    else {
        Write-Output "Aktion / Action: $Action"
        Write-Output "Ergebnis / Result: $($result.status)"
        Write-Output "Providerwrites / Provider writes: $($result.writes)"
        Write-Output 'Naechste sichere Aktion / Next safe action: Evidence pruefen und nur mit aktueller Autoritaet fortsetzen.'
    }
    exit 0
} catch {
    $message = $_.Exception.Message
    [Console]::Error.WriteLine($message)
    if ($message -match '(?i)AUTORITAET_BLOCKIERT|External-Write-Gate fehlt|Gate ist nicht|Drift|TERMINAL_STATE_DRIFT') {
        if ($OutputFormat -eq 'Json') {
            [ordered]@{ status = 'Blocked'; writes = 0; reason = $message } | ConvertTo-Json -Depth 10
        }
        exit 3
    }
    if ($message -match '(?i)JSON|Pfad|Path|schema|Absolute|Traversal|Symlink|parameter') { exit 2 }
    exit 1
}
