# Plattformnachweis / Cross-Platform Evidence

**Applicability / Anwendbarkeit**: `Applicable`
**Implementation status / Umsetzungsstatus**: `Pending`
**Owner / Owner**: Script Owner
**Reviewer / Reviewer**: Cross-Platform Reviewer

## Verbindlicher Prüfumfang / Binding Scope

| Surface | Status | Evidence / Nachweis | Residual risk / Restrisiko | Follow-up and re-evaluation / Folgemaßnahme und Neubewertung |
|---|---|---|---|---|
| macOS Bash 3.2+ | Passed | T023, T038, T102, T110; `operational/platform/macos.json` | Nativer Preview-Exitcode 0 und hashgebundene lineare Ausgabe; T124 wiederholt den Regressionsumfang. | Bei Wrapper-, Shell-, Exitcode- oder Outputdrift erneut ausführen. |
| macOS PowerShell 7 | Passed | T024, T038, T103, T105, T110; `operational/platform/macos.json` | Nativer WhatIf-Exitcode 0 und semantisch identische Ausgabe; T124 wiederholt Analyzer/Regression. | Bei Cmdlet-, Parser-, Analyzer-, Help- oder Outputdrift erneut ausführen. |
| Linux Bash | Passed | T070 portable semantics, T111; `operational/platform/linux.json` | Nativer Linux-Lauf im netzlosen, schreibgeschützten Container stimmt payload- und entscheidungshashgenau mit macOS überein. | Bei Payload-, Container-, Wrapper- oder Plattformdrift erneut ausführen. |
| Windows PowerShell 7 | Open | T070 portable semantics; T112; `operational/platform/windows.json` | Der vorhandene native Bericht vom 6. April 2026 liegt vor Stage B und ist nicht an Payload `1b7a4602...` gebunden; kein Windows-Token wird behauptet. Thorsten hat am 22. August 2026 den eng begrenzten GitHub-Actions-Ausweg genehmigt. | Owner: Windows Platform Owner. Aktuellen Payload auf `windows-2022` durch den branch-/pfadgebundenen Push des exakten, nicht mergefaehigen Validierungs-Checkpoints mit Marker `[stage-b-windows-proof]`, PowerShell 7 und unmittelbarer Exitcode-/Hashpruefung ausführen, unveraenderliche Run-/Job-Evidence importieren und bei T112 fortsetzen. |
| Semantic parity | Passed for portable fixtures | gemeinsame Fixtures, T038, T070, T101, T110 | Bash und PowerShell liefern identische normalisierte Preview-Felder/Exitcodes; portable Fixtures ersetzen keinen nativen Token. | Bei Entscheidungs-, Exitcode- oder Felddrift erneut prüfen. |
| A11Y and bilingual output | Pending | T100, T104–T109 | Nutzertext kann driften. | Bei Outputänderung WCAG 2.2 AA, Texttools und DE/EN neu prüfen. |

`Open` ist kein zulässiger Abschluss. Jeder fehlende native Plattformnachweis
bleibt `Pending` mit Owner und blockiert die zugehörige Acceptance. / `Open`
is not a completion state. Missing native platform evidence remains `Pending`
with an owner and blocks the related acceptance gate.
