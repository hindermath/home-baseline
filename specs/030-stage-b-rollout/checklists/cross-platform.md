# Plattformnachweis / Cross-Platform Evidence

**Applicability / Anwendbarkeit**: `Applicable`
**Implementation status / Umsetzungsstatus**: `Native platform checkpoint, full T124 regression and T125 acceptance Passed`
**Owner / Owner**: Script Owner
**Reviewer / Reviewer**: Cross-Platform Reviewer

## Verbindlicher Prüfumfang / Binding Scope

| Surface | Status | Evidence / Nachweis | Residual risk / Restrisiko | Follow-up and re-evaluation / Folgemaßnahme und Neubewertung |
|---|---|---|---|---|
| macOS Bash 3.2+ | Passed | T023, T038, T102, T110, T124; `operational/platform/macos.json`; Run `32587448948` | Nativer Preview-Exitcode 0 und Vollregression am Head `8ae4ef2`. | Bei Wrapper-, Shell-, Exitcode-, Head- oder Outputdrift erneut ausführen. |
| macOS PowerShell 7 | Passed | T024, T038, T103, T105, T110, T124; `operational/platform/macos.json`; Run `32587448948` | Nativer WhatIf-Exitcode 0, semantisch identische Ausgabe und grüne Analyzer-/Vollregression. | Bei Cmdlet-, Parser-, Analyzer-, Help-, Head- oder Outputdrift erneut ausführen. |
| Linux Bash | Passed | T070 portable semantics, T111, T124; `operational/platform/linux.json`; Run `32587448948` | Der isolierte Preview stimmt payload- und entscheidungshashgenau mit macOS überein; der Ubuntu-22.04-Vollregressionsjob ist am Head `8ae4ef2` grün. | Bei Payload-, Container-, Wrapper-, Head- oder Plattformdrift erneut ausführen. |
| Windows PowerShell 7 | Passed | T070 portable semantics; T112; T124–T125; `operational/platform/windows.json`; Workflow `Maintenance TUI`, Run `32587448948`, Job `97065888986`; `primary/AC-SBR-009.json` | Der native `windows-2022`-Job am exakten Head `8ae4ef289d8dd42080a0b69ea374bde2881f6fb2` führte PowerShell `7.6.5` und exakt `python -m unittest discover -s scripts/tests -p 'test_*.py'` aus: 225 Tests, Exitcode `0`, 44 Skips und keine Restricted-Ausgabe. Das Token war auf `contents: read` und `metadata: read` begrenzt; AC-SBR-009 bindet `macOS,Linux,Windows`. Kein PR, Merge, Home-Sync oder Fleetwrite erfolgte. | Bei Workflow-, Runner-, PowerShell-, Befehls-, Head-, ACL-, Permission- oder Payloaddrift erneut ausführen. |
| Semantic parity | Passed for portable fixtures | gemeinsame Fixtures, T038, T070, T101, T110 | Bash und PowerShell liefern identische normalisierte Preview-Felder/Exitcodes; portable Fixtures ersetzen keinen nativen Token. | Bei Entscheidungs-, Exitcode- oder Felddrift erneut prüfen. |
| A11Y and bilingual output | Passed locally and aggregated | T100, T104–T109, T124–T125; `primary/AC-SBR-009.json` | Nutzertext kann nach dem geprüften Head driften. | Bei Outputänderung WCAG 2.2 AA, Texttools und DE/EN neu prüfen. |

Alle drei nativen Plattformtokens sind hashgebunden vorhanden. Die vollständige
T124-Regression ist am gemeinsamen Head `8ae4ef2` auf macOS, Ubuntu und Windows
grün; T125 bindet die drei Tokens im bestandenen AC-SBR-009-Primary-Snapshot. /
All three native platform tokens are hash-bound. The full T124 regression is
green on macOS, Ubuntu, and Windows at the shared head `8ae4ef2`; T125 binds all
three tokens in the passing AC-SBR-009 Primary snapshot.
