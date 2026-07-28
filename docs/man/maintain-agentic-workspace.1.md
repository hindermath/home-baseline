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
3. Das versionierte Desired-State-Manifest wird validiert. Fehlende aktive
   Repositories werden ueber einen geprueften temporaeren Geschwisterklon
   bereitgestellt; bestehende sichere Repositories werden nur per Fast-forward
   aktualisiert.
4. Fehlende Registry-Eintraege werden ueber `register-level2-repository.*`
   nachgezogen.
5. Das kanonische Wartungspaket wird mit
   `propagate-agentic-toolchain-maintenance.*` geprueft.
6. Das Registry-Profil jedes Repositories wird gegen die explizit konfigurierte
   Matrix geprueft. Der Flottenpfad bindet
   `intake-sequencing-eleven-governance-presets` mit exakt elf Presets. Liegt
   der aktive Arbeitsbaum nicht exakt
   auf `origin/HEAD`, erfolgt die schreibfreie Profilpruefung in einem
   kurzlebigen detached Worktree des kanonischen Default-Branches. Drift dort
   erfordert einen eigenen Branch beziehungsweise PR.
7. Homebrew/apt oder WinGet, Required-CLI-Tools, VS-Code-Extensions und
   Required-Agenten-CLIs werden gepflegt.
8. Repository-Paritaet und Wartungspaket werden abschliessend erneut geprueft.

Die unterstuetzten Profilnamen und ihre Matrixdateien stehen zentral in
`scripts/config/spec-kit-preset-profiles.json`. Lokale Registry-Eintraege mit
unbekannten Profilen brechen weiterhin fail-closed ab.

Die portable Sollquelle steht in
`scripts/config/agentic-workspace-fleet.json`. Sie unterscheidet kanonische
Flottenziele, Preset-Repositories und reine Collections. Der gemeinsame
Python-Standardbibliothekskern validiert Pfade, Remotes, Branches und
Ahead-/Behind-Zustaende fuer beide Einstiegspunkte identisch. Registry-Aufbau
und Wartungspaket-Propagation werden auf aktive Git-Ziele der Klasse
`canonical-fleet` begrenzt. Eine Dateisystemsuche darf keine nicht
deklarierten Legacy-Repositories erneut registrieren oder propagieren.

*The portable desired state lives in
`scripts/config/agentic-workspace-fleet.json`. It distinguishes canonical
fleet targets, preset repositories, and directory-only collections. The
shared Python standard-library core validates paths, remotes, branches, and
ahead/behind states identically for both entry points. Registry maintenance
and maintenance-package propagation are restricted to active Git targets in
the `canonical-fleet` class. Filesystem discovery cannot re-register or
propagate undeclared legacy repositories.*

Im Check-only-Modus wird der manifestgesteuerte Home-Sync jetzt ebenfalls
schreibfrei ausgefuehrt. Nach einem echten Sync wiederholt die
Abschlusspruefung diesen Check, damit SHA-256-, Dateimodus- oder
Konfliktabweichungen nicht unbemerkt bleiben.

*Check-only now also runs the manifest-based Home sync check without writing.
After a real sync, final verification repeats this check so SHA-256, file-mode,
or conflict drift cannot remain unnoticed.*

*Preset validation resolves the canonical default branch through
`refs/remotes/origin/HEAD`. If the active worktree is on another or an older
commit, an isolated temporary worktree validates the exact preset matrix
without switching branches or touching untracked files. Drift on that
canonical ref requires a dedicated branch or pull request.*

Das Skript wechselt vorhandene Branches nicht, fuehrt keinen Reset aus und
commitet oder pusht keine Level-1-/Level-2-Aenderungen. Clone-on-missing ist
nur fuer aktive, vollstaendig deklarierte Git-Ziele erlaubt. Zunaechst wird
ein temporaerer Geschwisterklon geprueft; erst danach wird er atomar an den
freien Zielpfad verschoben. Bei lokalen Aenderungen, fehlendem Upstream,
Ahead-/Diverged-Zustand oder detached HEAD stoppt es fuer das betroffene
Repository. Unabhaengige Ziele werden weiter geprueft.

Pro Home-Verzeichnis verhindert ein Lock parallele Wartungslaeufe. Pro Lauf
entstehen ein vollstaendiges lokales Log unter `~/.home-baseline/logs/` und ein
JSON-Bericht unter `~/.home-baseline/reports/`. Beide verwenden dieselbe Run-ID.
Der sichtbare Abschluss und der Prozess-Exitcode werden aus genau diesem
Bericht abgeleitet. Eigene reparierte Dirty-Zwischenstaende werden nur mit
atomarer Resume-Evidence unter `~/.home-baseline/` fortgesetzt, wenn Pfade und
Nachher-Hashes exakt passen. Fremde oder teilweise passende Aenderungen
blockieren.

*Without options, the script performs full maintenance: it fast-forwards
Level-0, synchronizes the local home baseline, resolves declared active
Level-1/Level-2 repositories from the fleet manifest, maintains the local registry,
checks the canonical maintenance package and registry-selected preset profile,
maintains the platform toolchain, and verifies the final state. It never
switches an existing branch, resets worktrees, or commits/pushes target
changes. Missing declared repositories use a verified sibling clone. A
per-home lock prevents parallel runs; correlated local logs and JSON reports
are written below `~/.home-baseline/`. The visible terminal state and process
exit code are derived from that exact report. Self-created dirty intermediate
state resumes only from atomically written evidence with exact paths and
after-hashes; unknown or partial changes block.*

## OPTIONS

| Bash | PowerShell | Wirkung / Effect |
|---|---|---|
| `--check-only` | `-CheckOnly` | Nur fetchen und pruefen; keine Pulls, Datei- oder Paketupdates / Fetch and check only |
| `--dry-run` | `-WhatIf` | Schreibende Schritte als Vorschau / Preview mutating steps |
| `--scripts-only` | `-ScriptsOnly` | Maschinenpakete ueberspringen / Skip machine packages |
| `--repair-drift` | `-RepairDrift` | Wartungspaket lokal reparieren; nie committen/pushen / Repair package locally; never commit/push |
| `--include-optional` | `-IncludeOptional` | Auch optionale Maschinenpakete installieren / Install optional machine packages too |
| `--allow-admin-prompts` | `-AllowAdminPrompts` | Administratorabfragen nur fuer diesen Lauf erlauben / Allow administrator prompts for this run only |
| `--manifest PATH` | `-ManifestPath PATH` | Alternatives Fleet-Manifest / Alternative fleet manifest |
| `--home-dir PATH` | `-HomeDir PATH` | Alternatives Home fuer Tests/Profile / Alternative home for tests/profiles |
| — | `-GitRetryAttempts N` | Begrenzte Versuche nur fuer transiente Git-Netzwerkfehler / Bounded attempts for transient Git network failures only |
| — | `-GitTimeoutSeconds N` | Harte Grenze je Fetch-/Pull-Versuch / Hard limit per fetch/pull attempt |
| — | `-WinGetTimeoutSeconds N` | Harte Grenze je WinGet-Unterprozess / Hard limit per WinGet subprocess |

`--check-only` / `-CheckOnly` und Vorschau sind gegenseitig exklusiv.
Drift-Reparatur ist nur in einem echten Lauf erlaubt. Optionale Pakete sind im
`scripts-only`-Modus nicht anwendbar. Administratorinteraktion ist
standardmaessig gesperrt. Die Freigabe gilt nur fuer den aktuellen Prozess und
speichert keine Zugangsdaten.

*Check-only and preview are mutually exclusive. Drift repair is only allowed
in an actual run. Optional packages do not apply to scripts-only mode.
Administrator interaction is denied by default; the opt-in applies only to
the current process and stores no credentials. It never bypasses UAC, process
timeouts, repository safety checks, tests, or review gates.*

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---|---|
| `0` | Aktuell oder erfolgreich abgeschlossen / Current or completed successfully |
| `1` | Drift oder nicht synchroner Zustand gefunden / Drift or unsynchronized state found |
| `2` | Betriebs-, Parameter- oder Sicherheitsfehler / Operational, parameter, or safety error |
| `3` | Drift lokal repariert; separate Pruefung, Commit und Push erforderlich / Drift repaired locally; separate review, commit, and push required |

Ein nicht sicher abschliessbarer WinGet-Adminvorgang wird intern als
`DEFERRED_ADMIN_REQUIRED` klassifiziert und am Orchestrator als blockierter
Teilabschluss mit Exitcode `1` berichtet.

*A WinGet administrator operation that cannot complete safely is classified
internally as `DEFERRED_ADMIN_REQUIRED` and reported by the orchestrator as a
blocked partial result with exit code `1`.*

## EXAMPLES

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
bash scripts/maintain-agentic-workspace.sh --manifest /tmp/fleet.json --home-dir /tmp/test-home --dry-run
bash scripts/maintain-agentic-workspace.sh
bash scripts/maintain-agentic-workspace.sh --scripts-only --repair-drift
```

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf -GitRetryAttempts 3 -GitTimeoutSeconds 300 -WinGetTimeoutSeconds 1800
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -ManifestPath C:\Temp\fleet.json -HomeDir C:\Temp\TestHome -WhatIf
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -ScriptsOnly -RepairDrift
```

## SEE ALSO

`maintain-agentic-brew-apps(1)`, `maintain-agentic-winget-apps(1)`,
`propagate-agentic-toolchain-maintenance(1)`, `register-level2-repository(1)`,
`sync-home(1)`
