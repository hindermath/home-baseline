# Plattformnachweis / Cross-Platform Evidence

**Applicability / Anwendbarkeit**: `Applicable`
**Implementation status / Umsetzungsstatus**: `Native platform checkpoint Passed; T125 full acceptance pending`
**Owner / Owner**: Script Owner
**Reviewer / Reviewer**: Cross-Platform Reviewer

## Verbindlicher Prüfumfang / Binding Scope

| Surface | Status | Evidence / Nachweis | Residual risk / Restrisiko | Follow-up and re-evaluation / Folgemaßnahme und Neubewertung |
|---|---|---|---|---|
| macOS Bash 3.2+ | Passed | T023, T038, T102, T110; `operational/platform/macos.json` | Nativer Preview-Exitcode 0 und hashgebundene lineare Ausgabe; T124 wiederholt den Regressionsumfang. | Bei Wrapper-, Shell-, Exitcode- oder Outputdrift erneut ausführen. |
| macOS PowerShell 7 | Passed | T024, T038, T103, T105, T110; `operational/platform/macos.json` | Nativer WhatIf-Exitcode 0 und semantisch identische Ausgabe; T124 wiederholt Analyzer/Regression. | Bei Cmdlet-, Parser-, Analyzer-, Help- oder Outputdrift erneut ausführen. |
| Linux Bash | Passed | T070 portable semantics, T111; `operational/platform/linux.json` | Nativer Linux-Lauf im netzlosen, schreibgeschützten Container stimmt payload- und entscheidungshashgenau mit macOS überein. | Bei Payload-, Container-, Wrapper- oder Plattformdrift erneut ausführen. |
| Windows PowerShell 7 | Passed | T070 portable semantics; T112; `operational/platform/windows.json`; Workflow `Stage B Windows Proof`, Run `32567141555`, Job `97017306468` | Der native `windows-2022`-Job am exakten Checkpoint `0d5144c9aa12fc069dd2dfbff6e6d247da0d30fc` führte PowerShell `7.6.5` mit `-WhatIf` aus: Exitcode `0`, Payload `1b7a4602...`, Entscheidung `70d4e65f...`, null Git-/Providerwrites. Kein PR, Merge, Home-Sync oder Fleetwrite erfolgte. | Bei Payload-, Workflow-, Runner-, PowerShell-, Befehls-, Hash- oder Branch-Head-Drift erneut ausführen; T125 führt die vollständige AC-SBR-009-Acceptance später aus. |
| Semantic parity | Passed for portable fixtures | gemeinsame Fixtures, T038, T070, T101, T110 | Bash und PowerShell liefern identische normalisierte Preview-Felder/Exitcodes; portable Fixtures ersetzen keinen nativen Token. | Bei Entscheidungs-, Exitcode- oder Felddrift erneut prüfen. |
| A11Y and bilingual output | Pending | T100, T104–T109 | Nutzertext kann driften. | Bei Outputänderung WCAG 2.2 AA, Texttools und DE/EN neu prüfen. |

Alle drei nativen Plattformtokens sind hashgebunden vorhanden. Der T112-
Checkpoint schließt ausschließlich den Windows-Nachweis; A11Y, vollständige
Regression und AC-SBR-009 bleiben bis T113–T125 offen. / All three native
platform tokens are hash-bound. The T112 checkpoint closes only Windows
evidence; A11Y, full regression, and AC-SBR-009 remain pending through T113–T125.
