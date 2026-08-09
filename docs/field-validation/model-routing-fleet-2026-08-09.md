# Modell-Routing-Flottennachweis / Model Routing Fleet Evidence

Datum / Date: 2026-08-09  
Ergebnis / Result: `Completed`

## Zweck / Purpose

Dieser Nachweis schließt die providerneutrale Modell-Routing-Einführung in der
registrierten Level-1-/Level-2-Flotte ab. Konkrete Modellnamen und lokale
Verfügbarkeit bleiben maschinenlokal; Repository-Evidence enthält nur Rollen,
Verträge, Paketversionen und reproduzierbare Prüfergebnisse.

*This evidence closes the provider-neutral model-routing adoption across the
registered Level-1/Level-2 fleet. Concrete model names and local availability
remain machine-local; repository evidence contains only roles, contracts,
package versions, and reproducible validation results.*

## Verbindliche Releases / Binding Releases

| Paket / Package | Version | GitHub-ZIP SHA-256 |
|---|---:|---|
| Model Routing Governance | `0.1.4` | `c9e04d29983a12743b1f465cd1d44e647076bd5edd19e4e439919de7b1c1aed7` |
| Autonomous Run Governance | `0.3.6` | `c0397c39ba0cb432801e8ae091e4020aa282da122fabf80d2a545e01ca413b30` |
| Parallel Autonomous Run Governance | `0.2.6` | `cb25cdedeca41e902ca9d88a921c1a989556d38ccf6a4f1c0c01abad90ca55e4` |

Level 0 wurde über PRs `#216`, `#217`, `#219` und `#221` gehärtet. Der
endgültige Quellstand ist mindestens Merge-Commit `9454b29269b8205b5142c4080f1e01e3f7e896f9`.

## Validierung / Validation

- Alle 33 Ziel-Repositories bestanden die exakte Zwölf-Preset-Matrix.
- Bash und PowerShell bestanden in allen 33 Repositories den deterministischen
  Model-Discovery-Test.
- Jede Agentenoberfläche enthält genau einen Status- und einen Refresh-Skill.
- Die Guidance verwendet zuerst das Top-Level-Verzeichnis `scripts` und nur
  danach die installierte Preset-Kopie.
- Bilinguale Sidecars funktionieren mit `.md`, `.MD`, `.en.md` und `.EN.MD`.
- Die Top-Level-Manpage ist Deutsch zuerst und Englisch danach.
- `git diff --check` und der Gitleaks-Diff-Scan bestanden für alle gelieferten
  Änderungen.
- Auf den abschließenden Heads blieben null umsetzbare Review-Threads offen.

*All 33 targets passed the exact twelve-preset matrix and both discovery
implementations. Agent surfaces are unique, script resolution matches the
repository layout, bilingual filename variants are covered, and no actionable
review thread remained.*

## Providergrenze / Provider Boundary

Von 328 abschließenden Head-Checks waren 130 erfolgreich. GitHub wies 193 Jobs
vor dem ersten Schritt ab: leere `steps`, leerer Runnername und kein
Repository-Code wurden ausgeführt. Drei Claude-Reviews liefen zweimal, endeten
aber jeweils sofort mit `is_error:true` und ohne Kommentar. Ein
TuiVision-Copilot-Review endete beim Provider mit `Prompt too big` und war nicht
wiederholbar. Diese vier Reviews gelten als fehlend, nicht als bestanden.

Der eng begrenzte Admin-Bypass wurde nur nach grünen lokalen technischen Gates,
belegter Provider-Zero-Step-Abweisung, null umsetzbaren Threads und ausschließlich
verbleibender Schutzregel verwendet. `cc65` wurde erst nach grünen nativen
Linux- und Windows-Builds gemergt.

*Provider failures were not reported as successful reviews. The narrow bypass
was used only after local technical gates passed, zero-step rejection was
proven, no actionable thread remained, and the remaining protection boundary
matched the granted authority.*

### Post-Merge- und Mail-Abgleich / Post-Merge and Mail Reconciliation

Die Default-Branch-Läufe wurden getrennt von den PR-Head-Prüfungen erneut über
die GitHub-API ausgewertet. Auf den 33 dokumentierten Merge-Commits liefen 151
Workflows: 47 endeten erfolgreich oder neutral, 104 fehlgeschlagene Workflows
enthielten null Workflow-Schritte und null ausgeführte Schritte. Es gab keinen
tatsächlich ausgeführten fehlgeschlagenen Workflow.

Die Gmail-Abfrage nach ungelesenen GitHub-Fehlermeldungen ergab exakt dieselben
104 Merge-Commit-Fehler aus 26 Repositories. Die übrigen sieben Repositories
hatten keine passende ungelesene Nachricht; daraus wird weder Erfolg noch
Fehlschlag abgeleitet. GitHub-Run- und Jobdaten bleiben die kanonische Evidence.
Die Mails wurden bei diesem read-only Abgleich weder gelabelt noch als gelesen
markiert.

| Workflow | Zero-Step-Mails |
|---|---:|
| Maintenance TUI | 26 |
| PowerShell Static Analysis | 25 |
| Release Please | 20 |
| Homogeneity Check | 26 |
| .NET Quality | 1 |
| Go Quality | 1 |
| Java CI | 1 |
| Python Scaffold Quality | 1 |
| Swift Scaffold | 1 |
| Gitleaks | 1 |
| Agent Secret Scan | 1 |

*The default-branch runs were reconciled separately from the PR-head checks.
Across 151 workflows, 47 succeeded or were neutral and 104 provider-rejected
workflows contained zero workflow steps. The 104 matching unread Gmail
notifications are an operational view, not the source of technical truth.*

## Merge-Evidence

| Repository | PR | Merge-Commit |
|---|---:|---|
| `c64-baseline` | `#28` | `f68d25c0cdec02c18a16a36643d7c91f5fe0f525` |
| `cc65` | `#26` | `efc904c496cce09c35dae5be7cd30de855fa371b` |
| `datagrip-baseline` | `#29` | `9708f0c95c8b7f0c85018cfdae902ce6c63b3b0c` |
| `InventarDb` | `#28` | `5c08a62e7fb29bc6c5977f062ea4042fec4072da` |
| `rider-baseline` | `#29` | `f5f6dfcf09cf83b0a12af0dd5962ea1245f51ce5` |
| `agent-operations-cockpit` | `#17` | `aa451d9a8ac488c9eee80d24b229ee8d9de8317c` |
| `InventarWorkerService` | `#51` | `0a81cf8c5a212b02e506213863e95c264be43220` |
| `TinyCalc` | `#48` | `0c7f38bd923095c1d7b5ee49ff4b74eb471fcf80` |
| `TinyPl0` | `#59` | `018d95133ab926eb62984f922371df7821ff9d7f` |
| `TuiVision` | `#141` | `01c4759ca9883b78914affecfd8cfb224789654b` |
| `secure-casetracker-baseline` | `#26` | `75c5186fb9e8509a35c03a719411e7f10513efc9` |
| `securecasetracker-csharp` | `#32` | `60fc231d2a67e02578f6d58b490a118c8e007103` |
| `securecasetracker-go` | `#31` | `edb3c3ca3313299f1c425bdad23ab141e5371cc7` |
| `securecasetracker-java` | `#31` | `779d71966a0053d406bce7760a85a25ebb861fc1` |
| `securecasetracker-python` | `#32` | `e5ae56a98d979e9a35010ef4c36dae9c056d2c32` |
| `securecasetracker-rust` | `#31` | `8415e260ed7965dc31af1a2fe6cc064d9c87ac72` |
| `securecasetracker-swift` | `#31` | `b32fbf705b882b32a30ca9c8f17e03619e6c708e` |
| `secure-orderdesk-baseline` | `#26` | `952be640ff9cb6e910e4fec4d6f1e3999e9c718e` |
| `secureorderdesk-csharp` | `#27` | `57b211f554f7bce0d0a0b2af4cbecb91b6807a9f` |
| `secureorderdesk-go` | `#26` | `dd0109de9a1f958dcb4d50d8465cbf36e5ded19f` |
| `secureorderdesk-java` | `#26` | `f7a0f1cace8717902c22a91143cd0a23e567bec9` |
| `secureorderdesk-python` | `#26` | `0bf3508a6f03668d4295f90548e2c27cf62b237c` |
| `secureorderdesk-rust` | `#26` | `f53a248bd76f4b4ef03f5d8cd6a90c9a53c95e47` |
| `secureorderdesk-swift` | `#26` | `b965ecb47c793c7b3d468662784e1aed686db985` |
| `secure-serviceharvester` | `#26` | `bd3ff23b8518973575f503988fc9a82ac45cfdc9` |
| `secureserviceharvester-csharp` | `#27` | `90f19575a1f32f9f58cd2f34b9df8efd5cec40cc` |
| `secureserviceharvester-go` | `#26` | `60cf1271255a89ffb3fcd57aa1368a1f020328da` |
| `secureserviceharvester-java` | `#26` | `11c08459c786a68dd78b9225dc207fbe0e2fec7b` |
| `secureserviceharvester-python` | `#26` | `36d233fc4fadadf46def3c166b1b13e5083c72f3` |
| `secureserviceharvester-rust` | `#26` | `edf344cb0e4cc7450f62b50189f553b1789e18b4` |
| `secureserviceharvester-swift` | `#26` | `20fbcf3e50192993664355e873b076b0b80bfb22` |
| `container-images` | `#26` | `3ce1f882a4cde6c7502fd7411ef60590959f6899` |
| `absdd-image-sandbox` | `#35` | `7eb76f83e82c104d57e33bd898bb35d4fcd1e606` |

## Follow-up-Grenze / Follow-up Boundary

Der skriptbezogene Routing- und `--scripts-only`-Pfad ist grün. Der vollständige
Ein-Kommando-Check besitzt getrennt davon einen reproduzierbaren JSON-Eingabe-
Fehler, wenn erwartete Toolchain-Reportdateien fehlen oder leer sind. Dieser
Befund verändert den Modell-Routing-Vertrag nicht und wird als eigenes
Wartungsskript-Follow-up behandelt; er wird hier weder verschwiegen noch als
erfolgreich klassifiziert.

*The script-only routing path is green. A separate full-maintenance JSON-input
defect remains a dedicated maintenance-script follow-up and does not change the
model-routing contract.*

## OpenCode-Paritätsbefund / OpenCode Parity Finding

Ein nachgelagerter, pfadbewusster Vergleich von Level 0 und allen 33
Ziel-Repositories zeigte genau eine Intake-Sequencing-Paritätslücke. Die Registry
deklariert überall sechs OpenCode-Series-Kommandos. 30 Ziel-Repositories tracken
sie im weiterhin unterstützten Pfad `.opencode/command/`; `cc65`, Agent
Operations Cockpit und die Secure-OrderDesk-Baseline verwenden den aktuellen
Pfad `.opencode/commands/`. Level 0 verwendet ebenfalls den Singularpfad; nur
dort fehlten genau diese sechs Dateien. Sie wurden durch eine Neuinstallation
von Intake Sequencing Governance v0.2.3 reproduzierbar erzeugt. Der alte
Hardening-Worktree wird nicht zusammengeführt, weil seine übrigen Änderungen
durch aktuelle Releases und Merge-Commits abgelöst sind.

*A later path-aware comparison found exactly one Intake Sequencing parity gap.
Thirty target repositories track the commands under the supported singular
path; three use the current plural path. Level 0 also uses the singular path,
where those six files were missing. Reinstalling v0.2.3 reproduced them; the
remaining stale worktree changes are superseded.*
