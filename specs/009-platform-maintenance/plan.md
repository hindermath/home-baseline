# Implementation Plan: Platformübergreifende Ein-Kommando-Wartung

**Branch**: `009-platform-maintenance` | **Date**: 2026-07-24 | **Spec**: `specs/009-platform-maintenance/spec.md`
**Input**: `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md` (archived after implementation)

## Summary

Die vorhandenen Bash- und PowerShell-Orchestratoren erhalten einen
schema-validierten Desired-State-Vertrag, kontrolliertes Clone-on-missing,
isolierte Zielentscheidungen sowie kompakte Textausgabe mit vollständigem
JSON-Bericht. Beide öffentlichen Oberflächen bleiben nativ und kompatibel.
Ein gemeinsamer Python-Standardbibliothekskern übernimmt ausschließlich die
deterministische Manifest-, Git-Entscheidungs- und Reportlogik; die bereits
verbindliche Python-CLI vermeidet dadurch doppelte sicherheitskritische Logik.

## Technical Context

**Language/Version**: Bash 3.2+ für macOS/Linux; PowerShell 7+ für Windows;
Python 3 Standardbibliothek als gemeinsamer Vertragskern und für Tests
**Primary Dependencies**: Git CLI, vorhandene Spec-Kit-CLI, bestehende
Plattform-Paketmanager; keine neue Paketabhängigkeit
**Storage**: Versionierte JSON-Manifeste und -Schemas; lokale Logs und
Run-Berichte unter `~/.home-baseline/`
**Testing**: Python-`unittest`, Bash-Syntax und Fixture-Läufe, PowerShell-
Verhaltens-Fixtures, PSScriptAnalyzer, vorhandene Homogeneity-Gates
**Target Platform**: macOS, Linux/Ubuntu und Windows
**Project Type**: Plattformübergreifende CLI-/Skript-Infrastruktur
**Performance Goals**: Ein vollständiger Soll-/Ist-Lauf skaliert linear mit
der Zielanzahl; Terminalausgabe bleibt auf eine Ergebniszeile je Ziel oder
Abschnitt begrenzt
**Constraints**: Keine Ziel-Commits oder -Pushes; keine destruktive
Driftauflösung; Bash-3.2-Kompatibilität; text-first; fortsetzbare Teilergebnisse
**Scale/Scope**: 42 aktive Git-Ziele (32 kanonische Flottenziele und zehn
Preset-Repositories), eine Collection und Level 0 über den Source-Resolver

## Constitution Check

*GATE: vor und nach dem Design bestanden.*

- **Level-2 environment**: `N/A`; implementiert wird ausschließlich Level 0.
  Level-2-Repositories sind Test- und Wartungsziele, nicht Entwicklungsumgebungen.
- **Memory-safe languages**: PowerShell/.NET ist MSL. Bash ist für die native
  Unix-Schnittstelle erforderlich und folgt `set -euo pipefail`, sicherem
  Quoting, Argumentarrays und `--`-Grenzen.
- **Secure code generation**: Pfade, Remotes, JSON und Unterprozessargumente
  werden validiert. Kein `eval`, keine dynamische Befehlszeichenkette und keine
  Secret-Ausgabe.
- **Secure architecture**: Manifest, Parser, Zielentscheidung, Ausführung und
  Bericht sind getrennte Grenzen. Unsichere Einzelziele werden fail-closed
  blockiert; unabhängige Ziele und Abschluss-Evidence bleiben verfügbar.
- **Security documentation**: Feature-lokale STRIDE/CIA-/CAPEC- und
  Supply-Chain-Evidence in `pr-evidence.md`; kein dauerhafter neuer
  `docs/security/`-Vertrag.
- **Standards**: NIST SSDF, CWE Top 25, CAPEC, SAMM und OpenSSF Scorecard sind
  anwendbar. ASVS, Zero Trust, BSI C3A/C5, NIS2, CRA, EU AI Act und DORA sind
  mangels Web-, Cloud-, Produkt- oder reguliertem Betriebs-Scope `N/A`.
  SBOM/VEX/SLSA sind ohne neue Abhängigkeit oder Release-Artefakt `N/A`.
  AI-SBOM ist `N/A`, da KI nur Entwicklungswerkzeug ist.
- **Spec-Kit presets**: Alle zehn installierten Presets sind geprüft. Intake
  Authoring und Review liefern akzeptierte Eingabe-Evidence; Autonomous Run ist
  anwendbar; Parallel Autonomous ist für den Einzellauf `N/A`.
- **Security-first**: Logs, Reports, Laufzeitstatus und Registry-Inhalte bleiben
  lokal und werden nicht als Produktartefakte getrackt.
- **Inclusion/A11Y**: CLI, Hilfe, Manpage und Reports werden text-first,
  reihenfolgestabil und ohne ausschließlich farbliche Bedeutung geprüft.
- **Bilingual delivery**: Nutzerhilfe und Manpage sind DE-first/EN-second bei
  CEFR B2. Maschinenwerte bleiben sprachneutral.
- **Statistics**: `docs/project-statistics.md` wird nach Abschluss gerendert;
  Referenzen sind 80 beziehungsweise 100 Zeilen pro Arbeitstag.
- **Agent guidance parity**: Die fünf gepflegten Agentenflächen werden gemeinsam
  nur geändert, wenn eine dauerhafte allgemeine Regel entsteht. Der aktuelle
  Feature-Vertrag allein löst keine Guidance-Änderung aus.
- **Cross-platform contract**: Bash-Skript, PowerShell-Cmdlet
  `Invoke-HBAgenticWorkspaceMaintenance`, Manpage, Hilfe und
  Paritätscheckliste werden als eine Änderung geliefert. Beide rufen denselben
  providerneutralen Vertragskern mit Argumentarrays auf.

## Project Structure

### Documentation (this feature)

```text
specs/009-platform-maintenance/
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── autonomous-run-evidence.md
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── fleet-manifest.md
│   ├── maintenance-cli.md
│   └── run-report.md
├── checklists/
│   ├── requirements.md
│   ├── maintenance-contract.md
│   ├── governance.md
│   └── plan-review.md
└── tasks.md
```

### Source Code (repository root)

```text
scripts/
├── maintain-agentic-workspace.sh
├── maintain-agentic-workspace.ps1
├── lib/agentic_workspace_fleet.py
├── config/
│   ├── agentic-workspace-fleet.json
│   ├── agentic-workspace-fleet.schema.json
│   └── script-catalog.json
└── tests/
    ├── test_maintenance_contracts.py
    └── test_agentic_workspace_maintenance.py
docs/
├── man/maintain-agentic-workspace.1.md
└── project-statistics.md
```

**Structure Decision**: Die bestehenden öffentlichen Skripte bleiben die
Produktoberfläche. Der gemeinsame Standardbibliothekskern verhindert
semantische Drift in Manifest- und Git-Entscheidungen. Neue Verträge liegen in
`scripts/config/`; deterministische Fixtures bleiben unter `scripts/tests/`.
Es entsteht kein neues Subprojekt und keine neue Produktionsabhängigkeit.

## Design Phases

### Phase 0: Research

`research.md` entscheidet Manifestauflösung, Clone-Transaktion,
Fehlerfortsetzung, Exitcode-Kompatibilität, Reportpersistenz, Plattformparität
und Testisolation.

### Phase 1: Contracts

`data-model.md` definiert FleetTarget, MaintenanceStage, RunReport und Finding.
Die drei Verträge unter `contracts/` binden Manifest, CLI und Bericht.
`quickstart.md` beschreibt ausschließlich reproduzierbare Abnahmen.

### Phase 2: Implementation

1. Vertrags- und Negativtests zuerst rot nachweisen.
2. Manifest und Schema implementieren.
3. Bash und PowerShell je Slice paarweise ändern.
4. Report, Hilfe und Manpage ergänzen.
5. Parität, Security, A11Y, Homogeneity und Remote-Gates ausführen.

## Validation Strategy

- JSON-Schema- und semantische Manifesttests, einschließlich Duplikaten,
  Traversal, Collection-Feldern und verwaisten Level-2-Zielen.
- Lokale Bare-Remote-Fixtures für Missing, Current, Behind, Ahead, Diverged,
  Dirty, Detached, PathConflict und fehlgeschlagenen temporären Klon.
- Check-only- und Preview-Nachweis ohne persistente Arbeitsdateiänderung.
- No-op-Regression unter Bash 3.2, modernem Bash und PowerShell 7.
- Berichtserzeugung trotz isoliertem Unterprozessfehler.
- Semantischer Bash-/PowerShell-Vergleich von Zielstatus, Gesamtstatus,
  Exitcodes und Berichtsfeldern.
- `git diff --check`, Bash-Syntax, PSScriptAnalyzer, Python-Fixtures,
  Secret-Scan, Homogeneity, Dokumentations- und Agent-Paritätsprüfungen.
- Providerneutrale Exact-Head-Gate-Evidence für macOS, Linux und Windows vor
  Merge; keine Zielrepository-Mutation.

## Post-Design Constitution Check

Bestanden. Der Entwurf führt weder neue Abhängigkeiten noch Cloud-, Web-,
Runtime-KI- oder Release-Artefakte ein. Die nicht-MSL Bash-Oberfläche bleibt
begründet, sicher begrenzt und durch die PowerShell-Paritätsoberfläche ergänzt.
Position-4-Folgescope wird nur vorbereitet, nicht vorweggenommen.

## Complexity Tracking

Keine unbegründete Verfassungsabweichung.
