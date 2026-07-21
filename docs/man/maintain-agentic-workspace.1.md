# maintain-agentic-workspace(1)

## NAME

`maintain-agentic-workspace` - orchestriert Repository- und Toolchain-Wartung

*Orchestrates repository and toolchain maintenance.*

## SYNOPSIS

```bash
bash scripts/maintain-agentic-workspace.sh [OPTIONEN]
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 [OPTIONEN]
```

## DESCRIPTION

Ohne Optionen fuehrt das Skript die vollstaendige Wartung aus:

1. Level-0 wird gefetcht und nur per Fast-forward aktualisiert.
2. Die kanonische Baseline wird nach `~/` synchronisiert.
3. Level-1-/Level-2-Repositories werden dynamisch aus Dateisystem und lokaler
   GSDB-Registry ermittelt, gefetcht und nur per Fast-forward aktualisiert.
4. Fehlende Registry-Eintraege werden ueber `register-level2-repository.*`
   nachgezogen.
5. Das kanonische Wartungspaket wird mit
   `propagate-agentic-toolchain-maintenance.*` geprueft.
6. Das Registry-Profil jedes Repositories wird gegen die exakte Acht-, Neun-
   oder Zehn-Preset-Matrix geprueft; Drift-Reparatur bleibt lokal und
   uncommittet.
7. Homebrew/apt oder WinGet, Required-CLI-Tools, VS-Code-Extensions und
   Required-Agenten-CLIs werden gepflegt.
8. Repository-Paritaet und Wartungspaket werden abschliessend erneut geprueft.

Im Check-only-Modus wird der manifestgesteuerte Home-Sync jetzt ebenfalls
schreibfrei ausgefuehrt. Nach einem echten Sync wiederholt die
Abschlusspruefung diesen Check, damit SHA-256-, Dateimodus- oder
Konfliktabweichungen nicht unbemerkt bleiben.

*Check-only now also runs the manifest-based Home sync check without writing.
After a real sync, final verification repeats this check so SHA-256, file-mode,
or conflict drift cannot remain unnoticed.*

Das Skript wechselt keine Branches, klont keine Repositories, fuehrt keinen
Reset aus und commitet oder pusht keine Level-1-/Level-2-Aenderungen. Bei
lokalen Aenderungen, fehlendem Upstream, Ahead-/Diverged-Zustand oder detached
HEAD stoppt es fuer das betroffene Repository. Pro Home-Verzeichnis verhindert
ein Lock parallele Wartungslaeufe. Pro Lauf entsteht ein lokales Log unter
`~/.home-baseline/logs/`.

*Without options, the script performs full maintenance: it fast-forwards
Level-0, synchronizes the local home baseline, dynamically discovers and
fast-forwards Level-1/Level-2 repositories, maintains the local registry,
checks the canonical maintenance package and registry-selected preset profile,
maintains the platform toolchain, and verifies the final state. It never switches branches, clones repositories,
resets worktrees, or commits/pushes target changes. A per-home lock prevents
parallel runs, and local logs are written below `~/.home-baseline/logs/`.*

## OPTIONS

| Bash | PowerShell | Wirkung / Effect |
|---|---|---|
| `--check-only` | `-CheckOnly` | Nur fetchen und pruefen; keine Pulls, Datei- oder Paketupdates / Fetch and check only |
| `--dry-run` | `-WhatIf` | Schreibende Schritte als Vorschau / Preview mutating steps |
| `--scripts-only` | `-ScriptsOnly` | Maschinenpakete ueberspringen / Skip machine packages |
| `--repair-drift` | `-RepairDrift` | Wartungspaket lokal reparieren; nie committen/pushen / Repair package locally; never commit/push |
| `--include-optional` | `-IncludeOptional` | Auch optionale Maschinenpakete installieren / Install optional machine packages too |
| `--home-dir PATH` | `-HomeDir PATH` | Alternatives Home fuer Tests/Profile / Alternative home for tests/profiles |

`--check-only` / `-CheckOnly` und Vorschau sind gegenseitig exklusiv.
Drift-Reparatur ist nur in einem echten Lauf erlaubt. Optionale Pakete sind im
`scripts-only`-Modus nicht anwendbar.

*Check-only and preview are mutually exclusive. Drift repair is only allowed
in an actual run. Optional packages do not apply to scripts-only mode.*

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---|---|
| `0` | Aktuell oder erfolgreich abgeschlossen / Current or completed successfully |
| `1` | Drift oder nicht synchroner Zustand gefunden / Drift or unsynchronized state found |
| `2` | Betriebs-, Parameter- oder Sicherheitsfehler / Operational, parameter, or safety error |
| `3` | Drift lokal repariert; separate Pruefung, Commit und Push erforderlich / Drift repaired locally; separate review, commit, and push required |

## EXAMPLES

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
bash scripts/maintain-agentic-workspace.sh
bash scripts/maintain-agentic-workspace.sh --scripts-only --repair-drift
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -ScriptsOnly -RepairDrift
```

## SEE ALSO

`maintain-agentic-brew-apps(1)`, `maintain-agentic-winget-apps(1)`,
`propagate-agentic-toolchain-maintenance(1)`, `register-level2-repository(1)`,
`sync-home(1)`
