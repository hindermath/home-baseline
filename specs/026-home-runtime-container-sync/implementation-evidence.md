# Feature 026: Home Runtime Container Sync Evidence

## Ergebnis / Result

`sync-home.sh --runtime-only` und `sync-home.ps1 -RuntimeOnly` verteilen nur
die manifestgebundene Home Runtime. Beide Oberflaechen erzwingen einen Lauf
ohne Pull, Commit, Git-Konfiguration, Git-Identitaet oder Home-Repository-
Initialisierung. Normale schreibende Laeufe nach `/home/adedev` bleiben
gesperrt. Konflikte und unsichere Ziel-Symlinks stoppen vor dem ersten
Schreibzugriff.

*The runtime-only Bash and PowerShell surfaces distribute only the
manifest-bound Home Runtime. They perform no pull, commit, Git configuration,
Git identity update, or Home repository initialization. Normal writing runs
targeting `/home/adedev` remain blocked. Conflicts and unsafe target symlinks
stop before the first write.*

## Lokale Nachweise / Local Evidence

- `bash -n scripts/sync-home.sh`
- PowerShell parser validation for `scripts/sync-home.ps1`
- `python3 -m unittest scripts.tests.test_home_sync_files scripts.tests.test_sync_home_cli -v`
- `git diff --check`

Die Sandbox-Integration, der reale Containerlauf und die SBOM werden erst nach
dem gemergten und veroeffentlichten Level-0-Release nachgewiesen.

*Sandbox integration, the real container run, and the SBOM are verified only
after the Level 0 change has merged and been published as a release.*
