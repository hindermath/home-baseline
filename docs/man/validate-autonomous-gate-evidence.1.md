# validate-autonomous-gate-evidence(1)

## Name

`validate-autonomous-gate-evidence` - prueft exakte Head- und Gate-Evidence fuer autonome Spec-Kit-Laeufe.

*`validate-autonomous-gate-evidence` - validates exact-head gate evidence for autonomous Spec Kit runs.*

## Synopsis

```bash
bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.sh \
  --requirements FILE --evidence FILE --head SHA
```

```powershell
pwsh -NoProfile -File .specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.ps1 `
  -Requirements FILE -Evidence FILE -Head SHA
```

Nach Dot-Sourcing steht die gleichwertige Advanced Function
`Test-AutonomousGateEvidence` zur Verfuegung.

*After dot-sourcing, the equivalent advanced function
`Test-AutonomousGateEvidence` is available.*

## Description

Der read-only Validator vergleicht vorab akzeptierte Gate-Anforderungen mit
aus Workflow-Definitionen oder Job-Logs abgeleiteter Ausfuehrungsevidence. Er
prueft den Requirements-Hash, den vollstaendigen Git-Head, Gate-Abdeckung,
`Applicable`/`N/A`, benoetigte Befehls- und Runner-Tokens sowie genau eine
Primaerevidence pro Gate. Ein erfolgreicher Lauf verleiht keine Remote-Rechte.

*The read-only validator compares acceptance gates declared in advance with
execution evidence derived from workflow definitions or job logs. It checks the
requirements hash, full Git head, gate coverage, `Applicable`/`N/A`, required
command and runner tokens, and exactly one Primary entry per gate. A successful
run grants no remote authority.*

## Exit Status

| Code | Bedeutung / Meaning |
|---:|---|
| `0` | Vertrag bestanden / contract passed |
| `1` | Evidence unvollstaendig oder widerspruechlich / evidence incomplete or contradictory |
| `2` | Aufruf oder Abhaengigkeit ungueltig / invocation or dependency invalid |

## Notes

Die Bash-Variante benoetigt `python3` oder `python`. Vor einem Merge bleibt die
exakte Provider-Evidence temporaer, weil ein Commit einen neuen Head erzeugt und
den Nachweis selbst ungueltig machen wuerde.

*The Bash variant requires `python3` or `python`. Exact provider evidence remains
temporary before merge because committing it creates a new head and invalidates
its own claim.*
