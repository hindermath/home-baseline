# closure: Level-0-Feldtest / Level-0 field test

Owner: @hindermath. Modus / Mode: training. Kontext / Context: home-baseline-assurance-v013.

Vorbedingung: unverändertes v0.1.3-ZIP, Security Governance >=0.6.1 und
aktueller genehmigter Scope. Prüfe ausschließlich das Gate closure mit dem
installierten Validator. Baseline prüft die Quellbindung, Delta die Installation,
Closure die getrennten Entscheidungen, Image Impact die Nichtänderung von Images.
Vor und nach dem Lauf alle Kontextdateien einschließlich versteckter Dateien
ordinal nach relativem Pfad sortieren und rohe SHA-256 vergleichen.
Bei Drift, fehlender Evidence oder anderem Ergebnis als erwartet stoppen.
Keine Quellen, Freigaben oder Images durch einen Review ändern.

*Require the immutable archive, dependency and authorized scope. Review only
closure using the installed validator. Compare ordinal path/raw SHA-256 snapshots
before and after. Stop on drift, missing evidence or unexpected outcomes.
Review never changes sources, decisions or images.*

```bash
bash .specify/presets/secure-development-assurance-governance/scripts/validate-secure-development-assurance.sh review closure home-baseline-assurance-v013 training
```

Bash zuerst auf macOS, danach PowerShell mit Action Review, Gate closure,
ContextId home-baseline-assurance-v013, Mode training. Erwarteter Exitcode: 0; Negativfälle nur
in temporären Fixtures: 2. / *Bash first on macOS, then equivalent PowerShell.
Expected exit: 0; negative cases in temporary fixtures only: 2.*
