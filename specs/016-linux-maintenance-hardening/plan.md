# Implementation Plan: Linux-/Ubuntu-Härtung der Ein-Kommando-Wartung

**Branch**: `016-linux-maintenance-hardening` | **Date**: 2026-07-28 |
**Spec**: `specs/016-linux-maintenance-hardening/spec.md`

## Summary

Die bestehende macOS-/Linux-Toolchain-Wartung erhält stdin-entkoppelte,
vollständig bilanzierte Registry-Schleifen, strukturierte begrenzte
CLI-Funktionsproben, fail-closed Required-Abschlüsse und einen
prüfsummengebundenen Swiftly-Pfad für unterstützte Ubuntu-Profile.
Der Unix-Orchestrator übernimmt den echten Toolchain-Exitcode und finalisiert
seinen run-korrelierten JSON-Bericht bei Erfolg, Fehler, `INT` und `TERM`
atomar. Bash bleibt auf Prozess-, Paketmanager- und Admin-Grenzen beschränkt;
die vorhandene Python-3-Standardbibliothekskomponente übernimmt strukturierte
Ergebnis- und Berichtslogik.

## Technical Context

**Language/Version**: Bash 3.2+-kompatible öffentliche Oberfläche, Python 3
Standardbibliothek; PowerShell 7 nur für die Paritätsprüfung gemeinsamer
Verträge  
**Primary Dependencies**: vorhandene Git-, Homebrew-/apt-, curl-, tar-,
SHA-256-, GnuPG- und Swiftly-/Swift-Oberflächen; keine neue
Repository-Abhängigkeit  
**Storage**: temporäre Registry-, Download-, Probe- und Reportdateien; atomare
lokale JSON-Evidence unter `~/.home-baseline/`; getrackte JSON-Verträge und
Feature-Evidence  
**Testing**: Python `unittest`, isolierte Bash-/PATH-Fixtures, `bash -n`,
PowerShell-Paritätsprüfungen, vorhandene Wartungs-, Statistik-, Secret- und
Homogeneity-Gates  
**Target Platform**: Linux mit Ubuntu 22.04 oder 24.04 auf `x86_64` oder
`aarch64`; Ubuntu 20.04 endet für die gepinnte Swift-6.3.3-Toolchain
fail-closed als nicht unterstützt; gemeinsame Homebrew-Logik bleibt auf macOS
kompatibel  
**Project Type**: CLI-/Skript-Infrastruktur  
**Performance Goals**: CLI-Proben enden standardmäßig nach fünf Sekunden;
Probe-Evidence bleibt auf 2 KiB begrenzt; Registry-Verarbeitung bleibt linear
zur Eintragszahl; Reportfinalisierung erfolgt einmal pro Lauf  
**Constraints**: kein `curl | sh`, kein `eval`, kein technischer
Admin-/Capability-/Paketmanager-Bypass, keine Paketmutation in Tests, keine
Shell-Profiländerung durch Swiftly, keine Secrets oder privaten absoluten Pfade
in getrackter Evidence  
**Scale/Scope**: Level 0; bestehende Homebrew-Formeln/Casks, Required- und
Optional-CLI-Einträge, 44 Flottenziele sowie exakt zehn installierte
Governance-Presets

## Constitution Check

- **Level-2 environment**: `N/A`; implementiert wird ausschließlich Level 0.
  Eine Registry-Zeile wird erst bei Änderungen eines Level-2-Projekts
  verbindlich.
- **Memory-safe languages**: Python 3 ist MSL und übernimmt strukturierte
  Probe-/Reportlogik. Bash ist an der vorhandenen Paketmanager- und
  Prozessgrenze technisch vorgegeben und nicht MSL; sichere Quoting-,
  Argumentlisten-, Temp-Datei- und Optionsende-Regeln begrenzen diese
  Ausnahme.
- **Secure code generation**: Registry- und Plattformwerte werden validiert
  und nie evaluiert. Argumente bleiben Arrays, Pfade gequotet, Downloads
  TLS- und SHA-256-gebunden, Fehlerausgabe begrenzt und bereinigt.
- **Secure software architecture**: Trust Boundaries sind Registry/JSON,
  `stdin`, `PATH`, externe Prozesse, Paketquellen, Downloads, temporäre
  Dateien, Admin-Prompts und Reportpfade. Vorprüfung plus Integritätsprüfung,
  Nutzbarkeitsprobe plus Required-Abschluss und temporäre Reportdatei plus
  atomarer Austausch bilden Defense in Depth. Mutationen erfolgen mit
  minimalen Rechten und scheitern fail-closed.
- **Security documentation**: Ein feature-lokales Threat-/Risikomodell liegt
  in `research.md`, Verträge und Checklisten in diesem Feature-Verzeichnis.
  Neue dauerhafte `docs/security/`-Artefakte, S-ADR und arc42-Erweiterung sind
  mangels neuer Repository-Architektur `N/A`.
- **Security standards applicability**: NIST SSDF, CWE Top 25, CAPEC,
  OWASP SAMM, OWASP Cheat Sheets/Proactive Controls und eine
  OpenSSF-Quellenprüfung für Swiftly sind anwendbar. ASVS ist ohne Web/API
  `N/A`. SBOM, VEX, SLSA und AI-SBOM sind ohne neue Abhängigkeit,
  Release-Artefakt oder Produkt-KI `N/A`; Trigger ist eine entsprechende
  Scope-Erweiterung.
- **Cloud/regulatory applicability**: NIST Zero Trust, BSI C3A/C5, NIS2,
  CRA, EU AI Act und DORA sind ohne Cloud-Runtime, Marktprodukt oder
  regulierten Dienst `N/A`; generisches GitHub-Hosting ändert diese
  Entscheidung nicht.
- **AI-SBOM applicability**: KI ist nur Entwicklungswerkzeug, kein ausgelieferter
  oder betriebener Runtime-Bestandteil; daher `N/A`.
- **Supply chain**: Der Swiftly-Bootstrap `1.1.2` stammt von der offiziellen
  Swift.org-API/Domain, wird versions- und architekturbezogen ausgewählt und
  vor Extraktion per gepflegtem SHA-256 geprüft. Swift `6.3.3` ist für Ubuntu
  22.04/24.04 auf beiden Zielarchitekturen offiziell gelistet. Swiftly
  verifiziert nachgelagerte Swift-Toolchains über die offizielle
  Swift-Infrastruktur. Änderungen an URL, Version, Architekturmatrix oder Hash
  erfordern einen neuen Review.
- **Spec-Kit presets**: Das für Level 0 registrierte Profil
  `intake-authoring-ten-governance-presets` ist exakt installiert:
  Security, Architecture, iSAQB, A11Y, Cross-Platform, Intake Authoring,
  Intake Review, Agent Parity, Autonomous Run und Parallel Autonomous.
  Authoring/Review/Autonomous sind für diesen Lauf anwendbar; Parallel
  Autonomous ist `N/A`.
- **Security-first**: Es werden keine Credentials, Agentensitzungen, Logs,
  History- oder SQLite-Zustände getrackt. Sanitized Evidence enthält keine
  privaten absoluten Pfade.
- **Inclusion/A11Y**: CLI, Hilfe, Manpage und README bleiben linear,
  text-first, ohne farbabhängige Bedeutung und für Screenreader,
  Braille-Zeilen und Textbrowser nutzbar.
- **Bilingual delivery / learner baseline**: Nutzertexte sind DE-first,
  Dokumentation DE-first/EN-second und ungefähr CEFR B2. Begriffe wie
  `DEFERRED_ADMIN_REQUIRED`, Funktionsprobe und Sollzustand werden bei erster
  Verwendung erklärt; Spec-Kit-Vorwissen wird nicht vorausgesetzt.
- **Statistics**: `docs/project-statistics.md` wird nach Abschluss mit Profil 2
  gerendert; Referenzen sind 80 beziehungsweise 100 Zeilen pro Arbeitstag.
- **Agent guidance parity**: Eine neue dauerhafte Agentenregel ist nicht
  geplant. Alle fünf gepflegten Agentenflächen werden geprüft und bleiben bei
  `N/A` unverändert.
- **Documentation Impact**: `UpdateRequired` für Hilfe,
  `docs/man/maintain-agentic-brew-apps.1.md`,
  `docs/man/maintain-agentic-workspace.1.md`, README, Skriptinventur,
  Feature-Evidence und Projektstatistik.
- **Autonomous governance**: Serieller Autonomous Run ist anwendbar;
  Gate-Anforderungen und Evidence werden vor dem ersten Produktionsedit
  angelegt. `MergeAndSync` erlaubt Commit, Push, PR, policy-konformen
  Admin-Merge und Default-Branch-Sync, aber keinen technischen Bypass und
  keinen Folgelauf.

## Project Structure

```text
specs/016-linux-maintenance-hardening/
├── autonomous-run-state.json
├── autonomous-run-gate-requirements.json
├── autonomous-run-evidence.md
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── cli-probe-result.md
│   ├── registry-item-result.md
│   ├── run-finalization.md
│   └── swift-install-contract.md
├── checklists/
│   ├── requirements.md
│   └── governance.md
└── tasks.md

scripts/
├── maintain-agentic-brew-apps.sh
├── maintain-agentic-workspace.sh
├── lib/
│   ├── agentic_workspace_fleet.py
│   └── linux-maintenance-hardening.py
├── config/required-cli-tools-registry.json
└── tests/test_linux_maintenance_hardening.py

docs/
├── man/maintain-agentic-brew-apps.1.md
├── man/maintain-agentic-workspace.1.md
├── scripts/
└── project-statistics.md
```

**Structure Decision**: Die öffentlichen Skripte und Registry bleiben
bestehen. Der neue interne Python-3-Helfer stellt nur testbare Linux-Verträge
für Registry-Auswertung, begrenzte Proben, Swift-Plattformauflösung und
strukturierte Ergebnisse bereit; Paketmanager- und Privilegienaufrufe bleiben
in Bash. Der Flottenkern bleibt für atomare Run-Reports zuständig.

## Design and Delivery Phases

1. Negativtests für stdin-Konsum, vollständige Ergebniszuordnung,
   Required-/Optional-Exitcodes, Probe-Klassen und Reportfinalisierung zuerst
   rot nachweisen.
2. Registry- und CLI-Probe-Verträge als erste vertikale Scheibe implementieren
   und bis zum Bash-Abschluss integrieren.
3. Swiftly-Bootstrap, Plattform-/Architekturmatrix, Integritätsprüfung,
   aktuelle Shell-Aktivierung und autorisierten Post-Install-Pfad
   implementieren.
4. Orchestrator-Exitcode, Deferred-Status sowie einmalige atomare
   Fehler-/Signal-/Erfolgsfinalisierung integrieren.
5. macOS-/PowerShell-Parität, Dokumentation, Propagation, A11Y,
   Sicherheitsprüfung und Statistik schließen.
6. Exakten gestagten Kandidaten lokal und auf Pflicht-Runnern prüfen,
   PR-Head und Reviews konvergieren, regelkonform mergen, `main` sowie
   Home-Runtime synchronisieren und die Intake-Serie genau einmal
   fortschreiben. Kein Folgefeature starten.

## Validation Strategy

- Test-first mit temporären Registry-, HOME-, PATH-, Log- und Report-Fixtures;
  kein reales Netzwerk, Homebrew, apt, sudo oder Swift in Tests.
- Ein Fake-Homebrew liest beim ersten `install` stdin bis EOF und muss dennoch
  drei geordnete, jeweils einmalige Endresultate ergeben.
- Matrix für Required leer/nicht leer, ausschließlich Optional-Drift,
  Dry-run, Compare-only, idempotenten Zweitlauf, Integritätsfehler,
  unbekannte Plattform/Architektur, Installationsfehler und Admin-Deferred.
- Begrenzte Launcher-Fixtures für `Missing`, `Unusable`, `TimedOut` und
  `CapabilityBlocked`, einschließlich Snap-/Container-Fehlermuster.
- Separater Prozess-Harness für späten Fehler, `INT` und `TERM`; genau eine
  atomare Finalisierung und identische Report-/Prozess-Exitcodes.
- `bash -n`, fokussierte `unittest`-Suiten, vorhandene Wartungsverträge,
  JSON-Validierung, PowerShell-Parität soweit der gemeinsame Vertrag betroffen
  ist, PSScriptAnalyzer bei PowerShell-Berührung, Dokumentations- und
  Statistikrenderer, `git diff --check`, Secret-Scan und Homogeneity.
- Providerneutrale Exact-Head-Evidence für Linux, macOS, Windows und lokale
  Policy-Gates vor dem Merge.

## Post-Design Constitution Check

Bestanden. Das Design führt weder neue Dienste noch Repository-Abhängigkeiten,
Release-Artefakte, Cloud-Grenzen oder Produkt-KI ein. Die Shell-Grenze bleibt
minimal, die Swift-Lieferkette ist versions- und hashgebunden, Privilegien
bleiben opt-in, und alle nicht erfolgreichen Endzustände sind fail-closed.

## Complexity Tracking

Keine Verfassungsabweichung.
