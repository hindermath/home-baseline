# Implementation Plan: Preset-Profil-, Default-Branch- und Worktree-Härtung

**Branch**: `017-preset-profile-worktree-hardening` | **Date**: 2026-07-29 |
**Spec**: `specs/017-preset-profile-worktree-hardening/spec.md`

## Summary

Der vorhandene Python-Flottenkern wird zur verbindlichen
Remote-Freshness-Barriere für Level 0 und alle aktiven Manifestziele
weiterentwickelt. Er aktualisiert erreichbare Remotes auch bei schmutzigen
Arbeitsbäumen, löst den kanonischen Default-Branch ohne Namensraten auf,
klassifiziert ausschließlich sichere Fast-forward-Pulls und liefert geordnete
Operations-Evidence. Bash und PowerShell verschieben Home-Sync, Registry,
Propagation, Preset-Reparatur und Toolchain hinter diese Barriere.

Temporäre Preset-Prüf-Worktrees erhalten maschinenlokale, pfad- und
prozessgebundene Leases. Nur nachweislich eigene verwaiste Worktrees werden
idempotent bereinigt. Profilauflösung bleibt kataloggesteuert; bekannte
Widersprüche zwischen Sprache und MSL-Status werden als Governance-Befund
gemeldet, nicht automatisch geändert.

## Technical Context

**Language/Version**: Python 3 Standardbibliothek für strukturierte Flotten-,
Git- und Lease-Verträge; Bash 3.2+ und PowerShell 7 als öffentliche
plattformgerechte Orchestratoren
**Primary Dependencies**: vorhandene Git-CLI, JSON-Konfigurationen, Bash,
PowerShell 7 und Python 3; keine neue Paket- oder Repository-Abhängigkeit
**Storage**: atomare lokale Run-Reports und Lease-Dateien unter dem
reservierten `.home-baseline`-State; getrackte Konfiguration, Tests,
Dokumentation und Feature-Evidence
**Testing**: Python `unittest` mit isolierten lokalen Git-Remotes und
Worktrees, Bash-Syntax, PowerShell-Parser/PSScriptAnalyzer, macOS-/Linux-/
Windows-CI, Homogeneity, Dokumentations- und Statistikgates
**Target Platform**: macOS und Linux über Bash; Windows über PowerShell 7
**Project Type**: lokale CLI-/Skript-Infrastruktur
**Performance Goals**: jeder Netzwerkversuch besitzt konfigurierbare,
begrenzte Retries und Timeouts; Flottenverarbeitung bleibt linear zur
Zielzahl; keine unbeschränkte Prozess- oder Netzwerkwarteschleife
**Constraints**: keine breite Checkout-Bereinigung, kein Reset/Stash/Rebase,
kein Namensraten, keine Registry-Selbstreparatur, keine Ziel-Commits oder
Providerwrites, keine privaten Pfade in veröffentlichbarer Evidence
**Scale/Scope**: Level 0 plus 43 aktive Manifest-Git-Ziele, eine getrennte
Collection und ein dynamischer Preset-Profilkatalog mit aktuell elf Presets

## Constitution Check

- **Level-2 environment**: Produktcode der Level-2-Repositories bleibt
  unverändert. Die zentrale Registry und das Desired-State-Manifest sind
  Eingabegrenzen des Level-0-Wartungsprodukts.
- **Memory-safe languages**: Python 3 ist MSL und übernimmt strukturierte
  Git-, State-, Evidence- und Lease-Entscheidungen. Bash bleibt an der
  vorhandenen macOS-/Linux-Prozessgrenze; PowerShell 7 bleibt die
  Windows-Oberfläche. Quoting, Argumentlisten, kein `eval`, Pfadcontainment und
  fail-closed Ergebnisse begrenzen die Shell-Ausnahme.
- **Secure code generation**: Remote-, Branch-, Pfad-, PID-, Zeit- und
  Registry-Eingaben werden validiert. Netzwerkoperationen erhalten Timeout,
  Retry und eindeutige Fehlerklassen. Untrusted Werte werden nie als Shellcode
  interpretiert.
- **Secure architecture**: Trust Boundaries sind Manifest, Registry, lokale
  Checkouts, `origin`, Git-Prozesse, temporäre Worktrees, Leases und lokale
  Reports. Defense in Depth besteht aus Manifestvalidierung, Freshness,
  Default-Ref-/Commit-Bindung, Zustandsklassifikation,
  Folgeaktionsbarriere und Exact-Head-Gate.
- **Threat model**: STRIDE/CIA/CAPEC werden in `research.md` auf Stale-Ref,
  Pfadtausch, PID-Wiederverwendung, Remote-Manipulation, Race und
  Evidence-Spoofing angewendet. Feature-lokale S-ADR-Entscheidungen und eine
  arc42-Sicht stehen ebenfalls dort.
- **Security standards**: NIST SSDF, CWE Top 25, SAMM und sichere
  Datei-/Netzwerk-/Prozessgrenzen sind anwendbar. ASVS, SBOM, VEX, AI-SBOM,
  SLSA, OpenSSF Scorecard, NIS2, CRA, EU AI Act und DORA sind ohne
  Webanwendung, Abhängigkeits-/Releaseänderung oder regulierten Dienst `N/A`.
- **Cloud/Zero Trust**: BSI C3A, BSI C5 und Zero Trust sind ohne Cloud-,
  Identitäts- oder Providerarchitektur `N/A`. Git-Hosting allein löst diese
  Kontrollen nicht aus.
- **Architecture evidence**: Das Feature verändert die Sequenz und
  Fehlergrenze des Orchestrators. `research.md`, `data-model.md` und die
  Verträge sind deshalb anwendbar; dauerhafte allgemeine ADR-/arc42-Dateien
  sind nicht nötig, solange kein neuer Service oder Deploymentkontext entsteht.
- **A11Y and learners**: CLI, Help, Manpage und Evidence sind Deutsch zuerst,
  Englisch danach, ungefähr CEFR B2, textorientiert und ohne farbabhängige
  Bedeutung. Fachbegriffe werden bei erster Verwendung erklärt.
- **Cross-platform**: Bash und PowerShell erhalten semantisch gleiche
  Barrieren, Default-Ref-Entscheidungen, Leases, Preview-Grenzen,
  Statusklassen und Exitcodes. PowerShell-Funktionen behalten
  `Verb-Noun`-Namen; `--check-only`, `--dry-run` und `-WhatIf` bleiben
  nicht mutierend.
- **Documentation Impact**: `UpdateRequired` für beide Hilfen,
  `docs/man/maintain-agentic-workspace.1.md`, Skriptreferenz,
  Wartungsdokumentation, Feature-Evidence und Projektstatistik.
  Shared Agent Guidance wird gemeinsam geprüft; ohne neue dauerhafte
  Agentenregel lautet die Entscheidung `NoUpdateRequired`.
- **Preset composition**: Security, Architecture, iSAQB, A11Y,
  Cross-Platform, Agent Parity, Intake Authoring, Intake Review, Intake
  Sequencing und Autonomous sind anwendbar. Parallel Autonomous ist ohne
  Kampagne `N/A`. Das Profil bleibt dynamisch; elf ist nur der aktuelle Stand.
- **Autonomous governance**: Gate-Anforderungen bestehen vor
  Implementierungsänderungen. `MergeAndSync` autorisiert nur Feature 017 im
  Level-0-Repository. Ziel-Repositories und ein Folgefeature erhalten keine
  Remote-Autorität.
- **Statistics**: `docs/project-statistics.md` wird nach Abschluss über den
  kanonischen Profil-2-Renderer aktualisiert.

## Project Structure

```text
specs/017-preset-profile-worktree-hardening/
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── autonomous-run-evidence.md
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── fleet-freshness-barrier.md
│   ├── default-branch-and-pull.md
│   ├── worktree-lease.md
│   └── profile-registry-evidence.md
├── checklists/
│   ├── requirements.md
│   ├── governance.md
│   ├── fleet-safety.md
│   └── plan-review.md
└── tasks.md

scripts/
├── maintain-agentic-workspace.sh
├── maintain-agentic-workspace.ps1
├── lib/agentic_workspace_fleet.py
├── config/
│   ├── agentic-workspace-fleet.json
│   ├── agentic-workspace-fleet.schema.json
│   └── spec-kit-preset-profiles.json
└── tests/
    ├── test_agentic_workspace_maintenance.py
    ├── test_maintenance_contracts.py
    ├── test_windows_maintenance_hardening.py
    └── test_linux_maintenance_hardening.py

docs/
├── man/maintain-agentic-workspace.1.md
├── scripts/
└── project-statistics.md
```

**Structure Decision**: Der Python-Flottenkern bleibt die gemeinsame,
direkt testbare Entscheidungsstelle. Bash und PowerShell behalten
plattformgerechte öffentliche Oberflächen und delegieren Flottenklassifikation
und Reportpersistenz an denselben Kern. Lease-Erzeugung und -Prüfung werden im
gemeinsamen Kern modelliert; Shells verwalten nur Prozess-Lifecycle und
Aufrufreihenfolge.

## Design and Delivery Phases

1. Negative Fixtures für Dirty-before-Fetch, `trunk`, Remote-HEAD-Drift,
   unsichere Pull-Zustände, unvollständige Flotteninventur und Mutation vor
   Barriere zuerst fehlschlagen lassen.
2. Freshness-Attempt, Default-Ref-Evidence, Pull-Klassifikation und
   Operationsreihenfolge im gemeinsamen Kern implementieren.
3. Bash- und PowerShell-Orchestrierung so ordnen, dass Home-Sync, Registry,
   Propagation, Preset-Reparatur und Toolchain erst nach der vollständigen
   Flottenbarriere laufen.
4. Lease-, Hard-Abort-, PID-Reuse-, Pfadcontainment- und exakte
   Cleanup-Autorisierungsfixtures zuerst rot nachweisen; danach gemeinsamen
   Lease-Vertrag und idempotente Recovery integrieren.
5. Dynamische Profiltests und nicht mutierende MSL-Registry-Konsistenz
   schließen; Feature-015/016-Regressionssuiten vollständig halten.
6. Hilfe, Manpage, Skriptinventur, Dokumentationswirkung, A11Y,
   Agentenparität und Projektstatistik aktualisieren.
7. Exakten gestagten Kandidaten lokal und auf Pflicht-Runnern prüfen, PR-Head
   und Reviews konvergieren, regelkonform mergen und `main` synchronisieren.
8. Intake und Series nur über einen kausalen Closeout aktualisieren, falls
   Post-Merge-Fakten nicht wahrheitsgemäß im geprüften Feature-Head stehen
   können. Position 4 wird nicht gestartet.

## Validation Strategy

- Lokale Git-Remote-Fixtures verwenden ausschließlich temporäre
  Bare-Repositories, Checkouts, Tracking-Refs und Fake-Netzwerkgrenzen.
- Eine Operationsliste beweist, dass alle Fetch-Versuche vor jeder
  Domainmutation liegen; ein früher Fehler unterdrückt keine späteren Ziele.
- Default-Ref-Matrix für lokalen symbolischen HEAD, read-only Remote-HEAD,
  `trunk`, fehlenden Ref, Commit-Drift, Remote-Ausfall und Mehrdeutigkeit.
- Pull-Matrix für Current, Behind-only, Dirty, Ahead, Diverged, Detached,
  Branch-Mismatch, Missing-Upstream und Remote-Mismatch.
- Lease-Matrix für normalen Exit, simulierten Hard Abort, aktiven Owner,
  verwaisten Owner, PID-Reuse, fremdes Repository, manipulierten Pfad,
  State-Path-Escape und idempotenten Zweitlauf.
- Cleanup-Fixture erzeugt nach Zustandsänderung einen zusätzlichen
  unversionierten Pfad und verlangt eine neue exakte Freigabe.
- Profilmatrix verwendet das reale Elf-Preset-Profil und eine synthetische
  Erweiterung ohne Codeänderung.
- Registry-Matrix umfasst widersprüchliche und korrekte MSL-/Nicht-MSL-Werte
  und vergleicht Vorher-/Nachher-Hash.
- Vollständige Regression: alle Python-Wartungstests,
  `bash -n`, PowerShell-Parser, PSScriptAnalyzer, Homogeneity,
  Dokumentations-/Statistikrenderer, `git diff --check`, Secret-Scan und
  `specify check`.
- Providerneutrale Exact-Head-Evidence bindet Linux-, macOS- und
  Windows-Ausführung an genau den geprüften PR-Head.

## Post-Design Constitution Check

Bestanden. Das Design führt keine Abhängigkeit, keinen Cloud- oder
Produktdienst und keine neue Remote-Autorität ein. Strukturierte
Sicherheitsentscheidungen bleiben im gemeinsamen Python-Kern; die Shells
werden nicht zur zweiten, abweichenden Policy-Implementierung.

## Complexity Tracking

Keine Verfassungsabweichung. Die zusätzliche Lease-Entität ist erforderlich,
weil ein Hard Abort sonst keinen beweisbaren Eigentums- und
Wiederanlaufvertrag besitzt.
