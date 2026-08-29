# Skriptparitaet / Script Parity

| Pruefung / Check | Applicability | Status | Evidence | Owner / Reviewer | Restrisiko | Follow-up / Trigger |
|---|---|---|---|---|---|---|
| Runner drei Quellen | Applicable | Fulfilled 6/6 | TA-007 `cmp`-Matrix | Script Owner / Cross-Platform Reviewer | Keine lokal | Bei Quelldrift |
| Direkter PowerShell-Test | Applicable | Fulfilled 18/18 zweimal | adversariale Byte-/SHA-/Pfad-/Ref-/Index-/Worktree-/Log-Records in `green-direct.json` | Test Owner / Autonomous Reviewer | Keine lokal | Bei Runner-/Fixtureaenderung |
| Bash-Wrapperdelegation | Applicable | Fulfilled 18/18 zweimal | gleiche ausführbare Beobachtungen in `green-wrapper.json` | Test Owner / Cross-Platform Reviewer | Keine lokal | Bei Wrapperaenderung |
| G4 Bash/PowerShell Aktionen | Applicable | Fulfilled | `operational/platform/adapter-parity.json` | Script Owner / Cross-Platform Reviewer | Keine lokal | Bei Aktions-/Parameteraenderung |
| macOS | Applicable | Fulfilled | `operational/platform/macos.json` | Cross-Platform Owner / Reviewer | Keine lokal | Bei Head-/Runtimeaenderung |
| Linux nativ | Applicable | Open | CI-Record | CI Owner / Cross-Platform Reviewer | Kein lokaler Teilproof als Vollpass | T126-T128 |
| Windows nativ | Applicable | Open | CI-Record | CI Owner / Cross-Platform Reviewer | Kein lokaler Teilproof als Vollpass | T126-T128 |
