# validate-autonomous-run-state(1)

## Name

`validate-autonomous-run-state` - prueft den wiederaufnehmbaren Zustand eines autonomen Spec-Kit-Laufs.

*`validate-autonomous-run-state` - validates resumable state for an autonomous Spec Kit run.*

## Synopsis

```bash
bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.sh \
  --state specs/NNN-feature/autonomous-run-state.json
```

```powershell
pwsh -NoProfile -File .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.ps1 `
  -State specs/NNN-feature/autonomous-run-state.json
```

Nach Dot-Sourcing steht die gleichwertige Advanced Function
`Test-AutonomousRunState` zur Verfuegung.

*After dot-sourcing, the equivalent advanced function
`Test-AutonomousRunState` is available.*

## Description

Der read-only Validator prueft Identitaet, Phase, Status, Checkpoint,
Artefakt-Hashes, Task-Zaehler, letzte Operation, naechste Aktion,
Stopp-Grenze und die Pflicht zur erneuten Berechtigungspruefung. Ein bewusst
pausierter Lauf verwendet `PausedByUser`; ein unsicher beendeter Befehl verwendet
`NeedsRevalidation`.

*The read-only validator checks identity, stage, status, checkpoint, artifact
hashes, task counters, last operation, next action, stop boundary, and required
authority revalidation. A deliberately paused run uses `PausedByUser`; an
operation without a trustworthy result uses `NeedsRevalidation`.*

## Exit Status

| Code | Bedeutung / Meaning |
|---:|---|
| `0` | Zustandsvertrag bestanden / state contract passed |
| `2` | Aufruf, JSON oder Zustandsvertrag ungueltig / invocation, JSON, or state contract invalid |

## Notes

Der Graceful Stop wirkt am naechsten sicheren Orchestrierungsgrenzpunkt. Der
Validator beendet keine Prozesse und verleiht keine Commit-, Push-, PR-, Merge-
oder Provider-Rechte.

*Graceful stop takes effect at the next safe orchestration boundary. The
validator terminates no process and grants no commit, push, pull-request, merge,
or provider authority.*
