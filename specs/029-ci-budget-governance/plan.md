# Implementierungsplan: Flottenweite CI-Budget-Governance / Implementation Plan: Fleet-Wide CI Budget Governance

**Branch**: `029-ci-budget-governance` | **Datum / Date**: 2026-08-19 | **Spezifikation / Spec**: [spec.md](spec.md)

**Input / Eingabe**: Akzeptierte Feature-Spezifikation unter `specs/029-ci-budget-governance/spec.md`

**Delivery Mode / Liefermodus**: `LocalImplementation`, ausschließlich Stufe A / Stage A only

## Zusammenfassung / Summary

Stufe A erweitert den vorhandenen gemeinsamen Vertragskern
`scripts/lib/agentic_workspace_fleet.py` um eine deterministische
CI-Budget-Planung und einen lokalen CI-Gate. Die bestehenden Wrapper
`scripts/maintain-agentic-workspace.sh` und
`scripts/maintain-agentic-workspace.ps1` erhalten die gleichwertigen
Oberflächen `--ci-gate` und `-CiGate`; die genehmigte Cmdlet-Oberfläche
`Invoke-HBAgenticWorkspaceMaintenance` bleibt erhalten. Jeder Aufruf startet
genau einen Engine-Prozess. Gate-Befehle werden als validierte
Argument-Arrays, niemals durch Shell-Auswertung, ausgeführt.

Eine versionierte Level-0-Registry ordnet jede ID der autoritativen
Repository-Menge genau einem der fünf CI-Profile zu. Diese Menge ist die
Vereinigung aus dem Level-0-Self-Record `home-baseline`, dessen Remote aus dem
ausführenden Level-0-Repository und dessen konfiguriertem `origin` aufgelöst
wird, und allen aktiven `kind=git-repository`-Zielen des Fleet Manifest. Das
Manifest dupliziert Level 0 absichtlich nicht; der aktive Collection-Knoten
`spec-kit-preset-projects` ist kein Repository und bleibt ausgeschlossen. Ein
read-only Adapter liest aktuellen
GitHub-Zustand, ein Fixture-Adapter liefert dieselbe Form für deterministische
Tests. Der Kern stoppt bei Inventar-, Profil-, Sichtbarkeits-, HEAD-,
Gate-Set-, Hook- oder Evidence-Drift fail-closed. Erfolgreiche Gate-Evidence
wird erst nach einer zweiten HEAD-Prüfung in derselben Dateisystemgrenze
atomar veröffentlicht. Workflow- und Ruleset-Verträge werden in Stufe A nur
als Level-0-Templates simuliert. Die 47 Zielrepositories, GitHub-Konfiguration,
Home Runtime und G4 werden nicht verändert.

Jeder Inventory-Snapshot besitzt `source` und `sourceRevision` genau einmal an
der Wurzel des `InventoryRolloutPlan`; beide Werte binden atomar alle
Repository-Beobachtungen des Snapshots. Repository-Einträge behalten ihren
eigenen Beobachtungszeitpunkt, aber keine eigene Quelle oder Revision.
Teilaktualisierte oder aus mehreren Quellen gemischte Snapshots sind verboten.

Pfadverträge besitzen genau eine Laufzeitquelle:
`scripts/config/ci-budget-path-contracts.json`. Die Profilregistry besitzt nur
Profile, Assignments, Gate Sets und Budgetannahmen und enthält kein
`pathContracts`. Der Engine-Prozess lädt und schema-validiert beide Registries
jeweils genau einmal, prüft danach Gate- und Produktjob-Referenzen
dateiübergreifend und blockiert unbekannte Referenzen oder eine zweite
eingebettete Pfadvertragsquelle. `profileRegistryHash` und `pathContractHash`
bleiben getrennte kanonische SHA-256-Werte.

## Technischer Kontext / Technical Context

**Sprachen / Language versions**: vorhandenes Bash 3.2+-kompatibles Skript für macOS/Linux; PowerShell 7+ auf .NET für Windows; vorhandener Python-3-Vertragskern

**Primäre Abhängigkeiten / Primary dependencies**: Python-Standardbibliothek, Git, vorhandene `gh` CLI ausschließlich für authentifizierte REST-GET-Lesezugriffe, vorhandene Repo-Validatoren; keine neue Paketabhängigkeit

**Speicherung / Storage**: getrennte versionierte Profil- und Pfadregistry-
JSON-/JSON-Schema-Quellen in Git; Pfadverträge ausschließlich in
`scripts/config/ci-budget-path-contracts.json`;
betriebliche CI-Gate- und Live-Rollout-Evidence ausschließlich unter
`~/.home-baseline/evidence/`; autonome Lauf-Acceptance-Evidence ausschließlich
unter
`.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence`;
temporäre atomare Dateien jeweils im Zielverzeichnis

**Tests / Testing**: Python `unittest` mit `tempfile`-Fixtures, Bash-Syntaxprüfung, PSScriptAnalyzer, vorhandene Maintenance-/Hook-/Secret-/A11Y-/Dokumentations-/Statistikvalidatoren, manuelle Plattformprüfung

**Zielplattformen / Target platforms**: macOS und Linux über Bash; Windows über PowerShell 7+; GitHub nur read-only während Stufe A

**Projekttyp / Project type**: plattformübergreifende CLI- und Governance-Infrastruktur auf Level 0

**Leistungsziele / Performance goals**: ein Engine-Prozess je Aufruf; lineare Verarbeitung in stabiler Repository- und Gate-Reihenfolge; höchstens drei begrenzte Live-Abfragen je transient fehlgeschlagener Operation; keine unbeschränkte Parallelität

**Grenzen / Constraints**: keine Shell-Auswertung, keine automatische Profilableitung, keine erfolgreiche Evidence vor stabiler HEAD-Prüfung, keine GitHub-Schreiboperation, kein Zielrepository-Edit, kein Commit/Push/Merge/Home-Sync/G4

**Skalierung / Scale**: aktuell 48 autoritative Git-Repositories = ein
Level-0-Self-Record `home-baseline` + 47 aktive Manifest-Ziele mit
`kind=git-repository`; der zusätzliche aktive Collection-Knoten
`spec-kit-preset-projects` bleibt ausgeschlossen. Live-Kardinalitäten ersetzen
den datierten Snapshot; Null-/Einzel-/Mehrfachfixtures sind bindend

**Exitcodes / Exit codes**: `0` erfolgreich oder mutationsfreie gültige Vorschau; `1` fachlicher Gate-/Drift-Blocker; `2` Betriebs-, Schema-, Sicherheits- oder Live-Inventory-Fehler; `130` kontrollierter Abbruch; `3` bleibt für den vorhandenen Maintenance-Reparaturvertrag reserviert

## Verfassungsprüfung vor Design / Pre-Design Constitution Check

*GATE: bestanden vor Phase-0-Research. `constitution.md` und
`.specify/memory/constitution.md` sind byte-identisch (Version 1.20.2).*

| Prüfpunkt / Checkpoint | Entscheidung und Plan / Decision and plan | Status |
|---|---|---|
| Level-2-Umgebung | `N/A`: Level-0-Feature, keine einzelne Level-2-Runtime. Registry-IDs und Plattformdaten bleiben read-only Planungsinput. Re-Evaluation bei autorisierter Stufe B. | Pass |
| MSL | `N/A` für eine neue Runtime: Das Feature erweitert vorhandene Bash-/PowerShell-Infrastruktur und den vorhandenen Python-Kern. Bash ist wegen der nativen Unix-Oberfläche gerechtfertigt; PowerShell/.NET und Python sind speichersicher. Re-Evaluation bei neuer kompilierter oder ausgelieferter Runtime-Komponente. | Pass |
| Sichere Code-Erzeugung | Bash: `set -euo pipefail`, gequotete Variablen, `--`, kein `eval`. PowerShell: Strict Mode, validierte Parameter, kein `Invoke-Expression`, `${Name}` vor Interpunktion. Python: validierte Grenzen, Argument-Arrays, eingeschränkte Pfade, keine dynamische Ausführung. | Pass |
| Sichere Architektur | Trust Boundaries für Manifest/Registry, Git/GitHub-Livezustand, Gate-Prozesse, Evidence und Hook; Defense in Depth durch lokalen Gate plus unabhängigen simulierten Server-Gate; Least Privilege und fail-safe defaults. | Pass |
| Security-Dokumentation | Updates an `docs/security/threat-model.md`, `arc42-security.md`, `security-checklist.md`, `security-quality-scenarios.md`, `dependency-audit.md`, `supply-chain-evidence.md`, `zero-trust-applicability.md`, `samm-assessment.md` sowie neue S-ADR `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md`. | Pass |
| Standards | NIST SSDF, CWE Top 25, SBOM, VEX, SLSA, CAPEC, Zero Trust, SAMM und OpenSSF Scorecard `Applicable`. ASVS, AI-SBOM, BSI C3A/C5 sowie NIS2/CRA/EU AI Act/DORA `N/A` mit den in `spec.md` definierten Triggern. OWASP Cheat Sheets/Proactive Controls dienen als Implementierungshilfe. | Pass |
| Supply Chain | Keine neue Abhängigkeit. Skripte, Hook und Templates werden in Dependency- und Supply-Chain-Evidence erfasst; SBOM/VEX-Entscheidung und SLSA-/Provenance-Ziel werden aktualisiert. | Pass |
| Presets | Die installierte Acht-Preset-Matrix ist vollständig anwendbar. Autonomous und Parallel Autonomous liefern nur Governance; es wird keine Kampagne oder Stufe B gestartet. Model-Routing- und Intake-Presets bleiben operative Zusatzflächen. | Pass |
| Security-first | Keine Credentials, Logs, Agentzustände, History, SQLite- oder private Billingdaten in Git/Evidence. Secret Scan und Mutation-Barriere sind Abnahmegates. | Pass |
| Manual-first / Hook | Jede Änderung an `scripts/hooks/pre-push` wird unmittelbar mit `bash scripts/install-hooks.sh` installiert; Byte-/SHA-256-Gleichheit sowie direkter Pass-/Block-Aufruf des installierten Hooks mit sicheren Fixtures und ohne Push sind Pflicht. Evidence liegt im benannten lauflokalen internen Record. | Pass |
| A11Y/Inklusion | CLI, Fehler, Reports, Templates, Manpage und Hilfe bleiben text-first, ohne farb-/positionsabhängige Aussage, keyboard-/screenreader-/Braille-/textbrowser-tauglich und WCAG-2.2-AA-orientiert. | Pass |
| Bilingual/Lernzugang | Nutzertexte Deutsch zuerst, Englisch danach, ungefähr CEFR B2; Begriffe beim Erstgebrauch; keine Spec-Kit-Erfahrung vorausgesetzt. | Pass |
| Cross-Platform | Bash und PowerShell werden als eine Arbeitseinheit geändert. Manpage, vollständige bilinguale PowerShell-Hilfe, `Invoke-HBAgenticWorkspaceMaintenance`, Paritätscheckliste und mindestens ein manueller Nachweis je Variante sind Pflicht; für diesen Lauf werden beide Varianten auf macOS ausgeführt, portable Fixtures belegen die semantische Drei-Plattform-Normalisierung. | Pass |
| Statistik | `docs/project-statistics.config.json` ist die kanonische Quelle; Renderer aktualisiert `docs/project-statistics.md`. Referenzen: 80 und 100 Zeilen/Arbeitstag, 7,8 Stunden. | Pass |
| Agenten-Parität | Review `Applicable`; Update-Entscheidung `N/A` / `NoUpdateRequired`, weil das Feature keine gemeinsame Agentenregel, Constitution oder Spec-Kit-Template-Semantik ändert. Der Paritätsvalidator bleibt Pflicht-Gate. Re-Evaluation bei jeder solchen Änderung; dann atomar alle fünf Agentenflächen, Templates und `.specify/memory/constitution.md`. | Pass |
| Documentation Impact | Genau eine Entscheidung: `UpdateRequired`; vollständiger Vertrag unten. | Pass |

## Governance-Evidence-Plan / Governance Evidence Plan

`Plan: Fulfilled` bedeutet, dass Anwendbarkeit, konkrete Arbeit und Evidence
vollständig geplant sind. Ausführbare Implementierungsevidence bleibt bis zur
Implementierungsphase `Not Assessed`.

| Preset/Checkpoint | Applicability | Plan / Implementation | Rationale, Evidence, Owner/Reviewer | Restrisiko, Follow-up und Re-Evaluation |
|---|---|---|---|---|
| Security Governance | `Applicable` | `Fulfilled / Not Assessed` | Secure scripting, verpflichtende Hook-Reinstallation samt installierter Pass-/Block-Prüfung, Secret Scan, Dependency-/Supply-Chain-Review, STRIDE+CIA/CAPEC, Mutation Barrier und Security Review. Evidence im benannten lauflokalen Hook-Record, den `docs/security/`-Dateien und Tests. Owner: Feature-Owner; Reviewer: Security Reviewer. | Restrisiko: neue Eingabe-/Dependency-Fläche. Follow-up: alle Security-Gates vor Abschluss. Re-Evaluation bei Dependency, Secret-, Crypto-, Auth- oder Trust-Boundary-Änderung. |
| Architecture Governance | `Applicable` | `Fulfilled / Not Assessed` | Kontext, Trust Boundaries, Building Blocks, Laufzeit, Defense in Depth und S-ADR in `docs/architecture/ci-budget-governance.md` und `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md`. Owner: Feature-Owner; Reviewer: Architecture/Security Reviewer. | Restrisiko: Hook fälschlich als Alleingrenze. Follow-up: Serververtrags-Negativfixtures. Re-Evaluation bei Integrations-, Prozess- oder Delivery-Grenze. |
| iSAQB Architecture Governance | `Applicable` | `Fulfilled / Not Assessed` | Qualitätsziele, Szenarien, Risiken und Schulden sowie Kontext-, Baustein-, Laufzeit- und Deployment-/Stufensicht sind geplant. Owner: Architecture Owner; Reviewer: iSAQB-orientierter Peer. | Restrisiko: wachsender gemeinsamer Kern. Follow-up: Modulgrenzen im Review. Re-Evaluation bei struktureller/runtime Änderung. |
| A11Y Governance | `Applicable` | `Fulfilled / Not Assessed` | Text-first CLI, stabile lineare Reihenfolge, WCAG 2.2 AA, keyboard/screenreader/Braille/textbrowser, CEFR B2, DE-first/EN-second und A11Y-Fixtures. Owner: Feature-Owner; Reviewer: A11Y Reviewer. | Restrisiko: Plattformtextdrift. Follow-up: normalisierte und manuelle Ausgabeprüfung. Re-Evaluation bei jeder nutzerseitigen Ausgabe. |
| Cross-Platform Governance | `Applicable` | `Fulfilled / Not Assessed` | Paired Bash/PowerShell, `--ci-gate`/`-CiGate`, genehmigtes Cmdlet, Manpage, bilinguale Hilfe, Strict/Quoting/NoProfile, `checklists/cross-platform.md`, manuell mindestens ein Ziel-OS je Variante. Dieser Lauf verwendet macOS für beide Varianten und behauptet keinen Linux-/Windows-Runner; Fixtures belegen deren semantische Normalisierung. Owner: Script Owner; Reviewer: Cross-Platform Reviewer. | Restrisiko: Shell-/Exitcode-Drift. Follow-up: gemeinsame Fixtures plus manuelle Plattformbelege. Re-Evaluation bei Plattform oder CLI-Vertrag. |
| Agent Parity Governance | `Applicable` | `Fulfilled / Not Assessed` | Governance-Review und `scripts/tests/test_spec_kit_agent_surface_parity.py` bleiben verpflichtend. Die aktuelle Update-Entscheidung ist `N/A` / `NoUpdateRequired`, weil keine gemeinsame Agent-Guidance-, Constitution-, Spec-Kit-Template- oder Routingsemantik geplant ist; kein künstlicher Churn. Owner: Governance Owner; Reviewer: Agent-Parity Reviewer. | Restrisiko: spätere Implementierung erweitert Guidance. Follow-up: bei erstem solchen Diff atomar `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, beide Copilot-Dateien, Templates und `.specify/memory/constitution.md`. Re-Evaluation bei jeder dieser Pfad-/Semantikänderungen. |
| Autonomous Run Governance | `Applicable` | `Fulfilled / Not Assessed` | Zehn Acceptance-Gates mit stabilen Tokens in `autonomous-run-gate-requirements.json`; Phase bleibt `LocalImplementation`. Owner: Run Owner; Reviewer: nachfolgende Analyze-/Gate-Prüfung. | Restrisiko: HEAD-/Artefaktdrift. Follow-up: exact-head Gate Evidence vor Abschluss. Re-Evaluation bei State-, Hash-, Authority- oder Gate-Set-Änderung. |
| Parallel Autonomous Run Governance | `N/A` | `Fulfilled / Not Assessed` | Keine parallele Kampagne, Worker-Delegation oder Konsolidierung ist autorisiert/geplant. Owner: Run Owner; Reviewer: Governance Reviewer. | Restrisiko: keines im aktuellen seriellen Plan. Follow-up: keines. Re-Evaluation nur bei ausdrücklicher Kampagnenautorität. |
| Model Routing Governance | `N/A` | `Fulfilled / Not Assessed` | Runner hat die Phase bereits über eine lokale ignorierte Profilbindung gestartet; Feature fügt keine Provider-/Modellanforderung oder Routingrolle hinzu. Owner: Run Owner; Reviewer: Routing Validator. | Restrisiko: lokale Profil-Drift. Follow-up: vorhandener fail-closed Preflight. Re-Evaluation bei Routingrollen oder Modellpolicy. |
| Intake Authoring Governance | `N/A` | `Fulfilled / Not Assessed` | Das akzeptierte Intake und hashgebundene Receipt sind unverändert; Plan erstellt/ändert kein Intake. Owner: Intake Owner; Reviewer: Intake Governance. | Restrisiko: Intake-Hashdrift. Follow-up: Stop und Re-Review. Re-Evaluation bei Intake-Änderung. |
| Intake Review Governance | `N/A` | `Fulfilled / Not Assessed` | Ready-Review `694b6579-3443-4c9e-8017-8c7b285dae0f` ist bindend, ohne Findings/Fragen/Risiken/Ausnahmen; Plan führt keinen neuen Review aus. Owner: Intake Owner; Reviewer: Review Owner. | Restrisiko: Review-Freshness. Follow-up: fail-closed Re-Review bei Hashdrift. Re-Evaluation bei akzeptiertem Artefaktwechsel. |
| Intake Sequencing Governance | `N/A` | `Fulfilled / Not Assessed` | Serienmanifest/-receipt sind akzeptierte Inputs; Plan ändert keine DAG-Position und startet G4 nicht. Owner: Series Owner; Reviewer: Sequencing Validator. | Restrisiko: Series-Drift. Follow-up: Zustandsrevalidierung. Re-Evaluation bei Manifest-/Kanten-/Eligibility-Änderung. |

### Standardsdisposition / Standards Disposition

| Standard | Applicability | Evidence/Follow-up | Re-Evaluation |
|---|---|---|---|
| NIST SSDF, CWE Top 25 | `Applicable` | Security Checklist, Threat Model, sichere Implementierungs-/Reviewgates | Feature wird rein redaktionell |
| SBOM, VEX, SLSA, OpenSSF Scorecard | `Applicable` | `dependency-audit.md`, `supply-chain-evidence.md`; keine neue Dependency, Distributionsartefakte neu bewerten | Artefakte werden nicht mehr verteilt oder Dependency/Release-Scope ändert sich |
| CAPEC, Zero Trust, OWASP SAMM | `Applicable` | Threat Model, S-ADR, Zero-Trust-Notiz, SAMM-Assessment | Trust Boundaries oder langlebiger Workspace-Scope entfallen |
| OWASP ASVS | `N/A` | Kein Web/API/HTTP/Auth-Service; N/A-Aktualität prüfen | Eine solche Oberfläche kommt hinzu |
| AI-SBOM | `N/A` | KI nur Entwicklungswerkzeug, keine ausgelieferte Runtime/Komponente | Modell, Dataset, Inferenzdienst oder KI-Runtime wird ausgeliefert/betrieben |
| BSI C3A, BSI C5 | `N/A` | GitHub nur generische read-only Entwicklungsinfrastruktur; keine Cloud-Runtime/-Auswahl | Cloud-Service, Hosting oder providerabhängiges Deployment kommt hinzu |
| NIS2, CRA, EU AI Act, DORA | `N/A` | Private Workspace-Infrastruktur ohne Marktprodukt, regulierten Dienst, AI-Runtime oder Finanzsektorrolle; `regulatory-applicability.md` auf Aktualität prüfen | Markt-/Kundenübergabe, regulierter Betrieb, AI-Runtime oder Finanzsektorrolle |

## Architektur und Datenfluss / Architecture and Data Flow

### Bausteine / Building blocks

1. **Dünne Wrapper** validieren ausschließlich Optionen, bestimmen Plattform
   und Repositorywurzel und ersetzen sich dann durch genau einen Aufruf des
   Python-Kerns. `--ci-gate --dry-run` beziehungsweise `-CiGate -WhatIf`
   verwenden denselben Engine-Einstieg ohne Evidence-Schreibrecht.
2. **Gemeinsamer Vertragskern** lädt Fleet Manifest, Profilregistry und deren
   Schema sowie die alleinige Pfadregistry und deren Schema jeweils genau
   einmal. Er schema-validiert jede Quelle einmal, lehnt ein zweites
   `pathContracts` in der Profilregistry ab und validiert anschließend jede
   Gate-Referenz gegen die Gate Sets und jede Produktjob-Referenz gegen die
   Workflow-Templates. Erst danach normalisiert er Werte und führt
   Klassifikation, Gate-Auswahl, Simulation, Kostenrechnung und
   Evidence-Publikation aus.
3. **Inventory-Adapter** implementieren dieselbe interne Form: `fixture` liest
   nur eingecheckte Testdaten; `github-read-only` führt ausschließlich
   typisierte `gh api --method GET`-REST-Abfragen aus. Ein Schreibverb ist weder
   konfigurierbar noch im Adapter vorhanden. Der ausgewählte Adapter erzeugt
   genau ein Wurzelpaar `source`/`sourceRevision` für den vollständigen
   Snapshot; ein partieller Refresh oder Quellenmix blockiert.
4. **Lokaler Gate-Runner** startet geordnete, validierte Executable- plus
   Argument-Arrays als Kindprozesse. Der sichtbare Befehlsstring ist nur eine
   maskierte Darstellung und wird nie ausgeführt.
5. **Evidence Publisher** bindet Repository-ID, Start-/End-HEAD,
   Gate-Set-Hash, Plattform und Einzelergebnisse. Nur `Passed` nach stabilem
   End-HEAD wird per temporärer Datei, Flush und `os.replace` veröffentlicht.
6. **Pre-push Consumer** ergänzt den bestehenden Secret-Scan-Hook um eine
   vorhersehbare Evidence-Prüfung für private Profile. Der Hook bleibt eine
   lokale Komfortgrenze; Workflow-/Ruleset-Simulation beweist die unabhängige
   Servergrenze.
7. **Serialisierte Hook-Installation und Verhaltensprüfung** folgt unmittelbar
   auf die Änderung von `scripts/hooks/pre-push`: `bash scripts/install-hooks.sh`
   installiert den Hook neu, ein Byte-/SHA-256-Vergleich bestätigt
   `.git/hooks/pre-push` als neue Version, und der installierte Hook wird direkt
   mit sicheren Fixture-Remote-/Ref-Eingaben für einen erlaubten und einen
   blockierten Fall aufgerufen. Es findet kein `git push` statt. Das Ergebnis
   wird maschinenlokal unter
   `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/ac-cbg-007-008-hook-installation-macos.json`
   erfasst. Dieser Verfassungspflichtschritt ist kein optionaler Spec-Kit-
   Git-Commit-Hook; solche optionalen Hooks bleiben nicht autorisiert.

### Sequenz / Sequence

```text
Wrapper -> genau ein Python-Engine-Prozess
        -> Manifest + Profilregistry genau einmal laden/validieren
        -> Pfadregistry genau einmal laden/validieren
        -> zweite Pfadquelle sowie unbekannte Gate-/Produktjob-Referenz blockieren
        -> profileRegistryHash und pathContractHash getrennt kanonisch bilden
        -> Assignment validieren, profileId in Inventory kopieren und Gleichheit prüfen
        -> Repository-ID und HEAD H0 bestimmen
        -> geänderte Pfade -> geordnetes Gate-Set -> kanonischer SHA-256
        -> bei Vorschau: Plan linear ausgeben, ohne Evidence/Mutation beenden
        -> bestehende finale Evidence für denselben Zielpfad entwerten
        -> Gate-Argument-Arrays nacheinander ausführen
        -> HEAD H1 und Gate-Set erneut bestimmen
        -> H0 == H1 und Hash stabil und alle Einzelgates Passed?
        -> Schema-validierte Erfolgsdatei im Zielverzeichnis atomar publizieren
        -> Pre-push prüft repo-id + HEAD + Gate-Set + Hook-Version
```

Die Implementierungs- und Verfassungsprüfung des Hooks ist davon getrennt und
streng serialisiert:

```text
scripts/hooks/pre-push ändern
  -> bash scripts/install-hooks.sh
  -> .git/hooks/pre-push byte- und SHA-256-gleich zur Quelle verifizieren
  -> installierten Hook direkt mit sicherem Pass-Fixture aufrufen (kein Push)
  -> installierten Hook direkt mit sicherem Block-Fixture aufrufen (kein Push)
  -> internen macOS-Nachweis schreiben und in AC-CBG-007/008 hashbinden
  -> erst danach weitere Abnahme
```

## Projektstruktur / Project Structure

### Designartefakte dieses Features / Feature design artefacts

```text
specs/029-ci-budget-governance/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── autonomous-run-gate-requirements.json
├── documentation-impact-evidence.json            # geplant in Implementierung
├── checklists/cross-platform.md                   # geplante Paritätsevidence
└── contracts/
    ├── ci-budget-profile-registry.schema.json
    ├── ci-budget-path-contracts.schema.json
    ├── ci-gate-evidence.schema.json
    ├── ci-inventory-rollout-plan.schema.json
    └── workflow-ruleset-contract.md

.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/
└── acceptance-evidence/                            # ignoriert, machineLocal
    └── internal/
        └── ac-cbg-007-008-hook-installation-macos.json
```

### Vertragsinventar / Contract inventory

| Designvertrag / Design contract | Eigentum / Ownership | Geplante Laufzeitfläche / Planned runtime surface |
|---|---|---|
| `contracts/ci-budget-profile-registry.schema.json` | Profile, Assignments, Gate Sets, Budgetannahmen; keine Pfadverträge | `scripts/config/ci-budget-profiles.schema.json` + `ci-budget-profiles.json` |
| `contracts/ci-budget-path-contracts.schema.json` | Einzige Pfadvertragsregistry für sechs Kategorien, Include/Exclude sowie Gate-/Produktjob-Referenzen | `scripts/config/ci-budget-path-contracts.schema.json` + `ci-budget-path-contracts.json` |
| `contracts/ci-gate-evidence.schema.json` | Atomare lokale Erfolgsevidence | Validator im gemeinsamen Engine-Kern |
| `contracts/ci-inventory-rollout-plan.schema.json` | Atomarer Inventory-/Rolloutplan mit getrennten Registry-Hashes und Pflicht-`profileId` | Validator im gemeinsamen Engine-Kern |
| `contracts/workflow-ruleset-contract.md` | Inaktive Workflow-/Ruleset-Simulationssemantik und Produktjob-Referenzziele | `scripts/templates/ci-budget-governance/` |

Jeder JSON-Designvertrag wird in der Planabnahme geparst. Der neue
Pfadregistry-Vertrag wird in Quickstart, Laufzeitstruktur und Implementierungs-
folge geführt; kein anderer Vertrag besitzt ein `pathContracts`-Feld.

### Geplante Implementierungsflächen / Planned implementation surfaces

```text
.gitignore                                         # .specify/runtime/ machineLocal ausschließen

scripts/
├── maintain-agentic-workspace.sh                 # --ci-gate, genau ein Engine-Prozess
├── maintain-agentic-workspace.ps1                # -CiGate, Cmdlet bleibt erhalten
├── hooks/pre-push                                # private Evidence-Verifikation + Secret Scan
├── lib/agentic_workspace_fleet.py                # gemeinsamer CI-Plan/Gate/Evidence-Kern
├── config/
│   ├── ci-budget-profiles.json                   # kanonische fünf Profile + ID-Zuordnung
│   ├── ci-budget-profiles.schema.json            # installierbarer Laufzeitvertrag
│   ├── ci-budget-path-contracts.json             # einzige Pfadquelle: sechs Kategorien + Referenzen
│   ├── ci-budget-path-contracts.schema.json      # installierbarer Pfadregistry-Vertrag
│   ├── agentic-toolchain-maintenance-files.json  # Propagationsinventar, falls betroffen
│   ├── home-sync-manifest.json                   # nur Source-Eintrag prüfen; kein Sync
│   └── script-catalog.json                       # bestehende Skripte/Doku-Zuordnung prüfen
├── templates/ci-budget-governance/
│   ├── private-governance-minimal-gate.yml       # inaktiv, nur kanonisches Stufe-A-Template
│   └── private-governance-ruleset.json           # inaktiv, nur kanonisches Stufe-A-Template
└── tests/
    ├── test_ci_budget_governance.py              # unittest Contract/Integration/Mutation
    ├── test_agentic_workspace_maintenance.py     # Wrapper/Engine-Regression
    ├── test_maintenance_contracts.py             # Registry/Parität/Vertragsregression
    └── ci-budget-governance/fixtures/             # positiv/negativ, null/eins/mehrere

docs/
├── scripts/reference.md                           # Hook-/Installer-/Bedienpfad aktualisieren
├── man/install-hooks.1.md                         # Reinstallation und direkte Verhaltensprüfung
├── man/maintain-agentic-workspace.1.md            # --ci-gate, Exitcodes, Evidence
├── architecture/ci-budget-governance.md          # Kontext, Bausteine, Laufzeit, Deployment
├── accessibility/ci-budget-governance.md         # text-first/A11Y/Sprachparität
├── security/
│   ├── adr/ADR-002-ci-gate-defense-in-depth.md
│   ├── threat-model.md
│   ├── arc42-security.md
│   ├── security-checklist.md
│   ├── security-quality-scenarios.md
│   ├── dependency-audit.md
│   ├── supply-chain-evidence.md
│   ├── zero-trust-applicability.md
│   └── samm-assessment.md
├── project-statistics.config.json                # kanonische Statistikquelle
└── project-statistics.md                          # nur durch Renderer aktualisiert

.github/workflows/                                 # aktive Workflows nur validieren, nicht aktivieren
```

**Strukturentscheidung / Structure decision**: Es entsteht kein neues
`src/`-Projekt. Die CI-Domänenlogik erweitert den vorhandenen Python-Kern; die
beiden Skripte bleiben Plattformadapter. Portierbare Fixtures liegen wie die
vorhandenen Wartungstests unter `scripts/tests/`. Workflow-/Ruleset-Dateien
liegen bewusst unter `scripts/templates/` und nicht unter aktiven
`.github/workflows/`- oder GitHub-Ruleset-Flächen.

## Implementierungsfolge / Implementation Sequence

1. **Verträge zuerst**: Laufzeitschemas aus den Designverträgen ableiten,
   `ci-budget-profiles.json` mit genau fünf Profilen, dem `home-baseline`-Self-
   Record, stabilen IDs, Sichtbarkeit und geordneten Argument-Arrays anlegen;
   die Datei darf kein `pathContracts` besitzen.
   `ci-budget-path-contracts.json` ist die einzige Pfadquelle für Build,
   Security, Governance, Dependency, Product und Documentation und wird mit dem
   installierbaren `ci-budget-path-contracts.schema.json` gepaart. Der Engine-
   Prozess lädt und validiert jede Registry genau einmal, bildet getrennt
   `profileRegistryHash` und `pathContractHash` und prüft danach unbekannte
   Gate-/Produktjob-Referenzen sowie jede zweite Pfadquelle fail-closed. Erst
   nach erfolgreicher Assignment- und Sichtbarkeitsvalidierung wird `profileId`
   in jeden Inventory-Eintrag kopiert; Abweichung zu Assignment oder Rollout
   blockiert vor Planung. Schema- und Semantikvalidatoren müssen
   die exakte Union aus Self-Record und 47 aktiven Git-Zielen sowie alle
   Driftklassen prüfen; Collections bleiben ausgeschlossen. Vor dem ersten
   Acceptance-Input wird `.specify/runtime/` explizit in `.gitignore`
   ausgeschlossen und `git check-ignore` muss den vollständig aufgelösten
   Acceptance-Evidence-Pfad bestätigen.
2. **Vertikaler Slice**: Eine private Fixture-Repository-ID über Wrapper ->
   einen Engine-Prozess -> ein harmloses Gate -> stabilen HEAD -> atomare
   maschinenlokale Evidence führen. Dry-run, Gate-Fehler, HEAD-Wechsel und
   Metazeichenfixture werden gleichzeitig negativ geprüft.
3. **Fleet-Planung**: Fixture- und GitHub-read-only-Adapter, vollständige
   Eins-zu-eins-Klassifikation der autoritativen Repository-Union,
   einmalig geladene Pfadregistry, dateiübergreifend validierte Gate-/Produktjob-
   Referenzen, wertgleiche denormalisierte Inventory-`profileId`, Workflow-/Ruleset-Simulation,
   deterministische Rollout-Einträge und getrenntes Kostenmodell ergänzen.
4. **Defense in Depth**: `scripts/hooks/pre-push` liest nur passende
   erfolgreiche Evidence; Template-Simulation verlangt zusätzlich PR und genau
   einen schlanken statuspflichtigen Minimal-Gate. Hook-Version und Gate-Set-
   Hash werden gebunden; Hook-Bypass-Fixtures müssen serverseitig blockieren.
5. **Verpflichtende Hook-Reinstallation und manuelle Prüfung**: Unmittelbar
   nach Schritt 4 und vor jeder weiteren Abnahme serialisiert
   `bash scripts/install-hooks.sh` ausführen, dann
   `scripts/hooks/pre-push` und `.git/hooks/pre-push` bytegleich und per
   SHA-256 vergleichen. Den tatsächlich installierten Hook anschließend direkt
   mit sicheren Fixture-Remote-/Ref-Eingaben und passender beziehungsweise
   fehlender/inkonsistenter CI-Gate-Evidence aufrufen: der Pass-Fall endet `0`,
   der Block-Fall ungleich `0`; kein `git push`. Befehl, Quell-/Zielhash,
   Fixture-Identitäten und Exitcodes werden in
   `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/ac-cbg-007-008-hook-installation-macos.json`
   erfasst. Optionale Spec-Kit-Git-Commit-Hooks bleiben übersprungen.
6. **Cross-Platform/A11Y**: Bash und PowerShell in derselben Änderung,
   genehmigtes Cmdlet, Manpage, bilinguale Hilfe, stabile Statusreihenfolge
   `Profil -> Entscheidung -> Status -> Blocker -> nächste Aktion`, identische
   Exitcodes und normalisierte Fixtures.
7. **Governance-Dokumente**: Architektur- und S-ADR-Entscheidung, STRIDE+CIA/
   CAPEC, Zero Trust, SAMM, Dependency/SBOM/VEX/SLSA, A11Y und
   Documentation-Impact-Evidence aktualisieren. Agent-Guidance bleibt
   unverändert und wird durch Paritätsprüfung abgesichert.
8. **Abnahme/Statistik**: komplette Regressionen, Mutation-Barriere,
   Secret-Scan, je ein manueller Lauf beider Varianten auf mindestens einem
   Ziel-OS; für diesen `LocalImplementation`-Lauf liefert macOS sowohl Bash-
   als auch PowerShell-7-Evidence. Portable Fixtures belegen die semantische
   macOS-/Linux-/Windows-Normalisierung, ohne einen nicht ausgeführten Linux-
   oder Windows-Runner zu behaupten. Danach nur die Statistik-Konfiguration
   aktualisieren und den Renderer
   im Update- und Check-Modus ausführen. Kein Home-Sync und keine Remote-Aktion.

## Vertikaler Slice / Vertical Slice

Der erste ausführbare Slice verwendet `private-governance-fixture` mit einem
festen HEAD, einem Gate-Set aus zwei harmlosen Fixture-Kommandos und einem
temporären Home-Verzeichnis. Bash `--ci-gate` und PowerShell `-CiGate` müssen
denselben Gate-Set-Hash, dieselbe Feldreihenfolge und denselben Exitcode liefern.
Der Test zählt genau einen Start von `agentic_workspace_fleet.py`. Erst nach
zwei gleichen HEAD-Lesungen und zwei erfolgreichen Einzelergebnissen darf eine
schema-gültige Datei am finalen Evidence-Pfad erscheinen. Ein HEAD-Wechsel
zwischen den Gates, ein nicht nuller Exitcode oder `--dry-run`/`-WhatIf` lässt
keine finale Erfolgsdatei zurück. Dieser Slice beweist CBG-010 bis CBG-013,
CBG-017 und CBG-019, bevor Live-Inventur oder Kostenlogik hinzukommen.

## Sicherheitsreview-Punkte / Security Review Checkpoints

1. **Nach Vertragserstellung**: Parse aller JSON-Schemas; Schema-Review für
   zusätzliche Eigenschaften, alleinige Pfadregistry-Eigentümerschaft,
   getrennte Registry-Hashes, unbekannte Gate-/Produktjob-Referenzen,
   denormalisierte `profileId`-Gleichheit, Pfadtraversal, Symlinks,
   Repository-ID-Injektion, Executable-Allowlist,
   Argumentgrenzen und verbotene Daten. Evidence: Security Checklist und
   Dependency Audit.
2. **Nach vertikalem Slice**: Prozesszählung, kein `eval`/`Invoke-Expression`,
   keine Shell-Strings, stabile HEAD-Doppelprüfung, sichere Evidence-Wurzel,
   atomare Publikation, Signal-/Fehlerbereinigung. Evidence: negative Fixtures,
   Threat Model, S-ADR.
3. **Nach Inventory/Simulation**: ausschließlich REST-GET-read-only,
   Datenminimierung, Rate-Limit-Fail-closed, Sichtbarkeitsdrift, keinerlei
   Ruleset-/Accountmutation. Evidence: Adapter-Spy und Mutation-Barriere.
4. **Unmittelbar nach Hook-Edit**: `bash scripts/install-hooks.sh`, Byte- und
   SHA-256-Gleichheit von Quelle und `.git/hooks/pre-push`, danach direkter
   Pass-/Block-Aufruf des installierten Hooks mit sicheren Fixture-Remotes und
   Evidence ohne Push. Evidence:
   `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/ac-cbg-007-008-hook-installation-macos.json`.
5. **Vor Abnahme**: Secret Scan, CWE-/SSDF-Prüfung, SBOM/VEX/SLSA-/Scorecard-
   Disposition, CAPEC/STRIDE+CIA, Zero Trust, SAMM und unabhängiger Review der
   Hook-plus-Server-Gate-Grenze. Kein technisches Gate darf durch Autorität oder
   Bypass ersetzt werden.

## Test- und Abnahmestrategie / Test and Acceptance Strategy

| AC | Geplanter Beweis / Planned proof |
|---|---|
| AC-CBG-001 | Positive und vier negative Mapping-/Sichtbarkeitsfixtures belegen die exakte Union aus `home-baseline` plus aktiven Manifest-Git-Zielen, aktuell 1 + 47 = 48; `spec-kit-preset-projects` ist ausgeschlossen, die drei Pflicht-Canaries stimmen und die Live-Kardinalität wird neu berechnet. |
| AC-CBG-002 | Private-Governance-Simulation: 0 Full PR/Main Builds, maximal 1 Minimal-Gate; lokaler Evidence- und Serververtrag getrennt. |
| AC-CBG-003 | Sechs CaseTracker-Pfadfixtures aus der einzigen Pfadregistry ergeben nach erfolgreicher dateiübergreifender Produktjob-Referenzprüfung höchstens sechs eindeutige Produktjobs. |
| AC-CBG-004 | Dezimales Kostenfixture trennt etwa 22 wiederkehrende Jobs/Woche von Bedarfsgates und erklärt Abweichung. |
| AC-CBG-005 | Monatsprojektion bleibt unter 500/3000 Actions-Minuten; Copilot-Kategorien sind ausgeschlossen und separat. |
| AC-CBG-006 | Null/eins/mehrere, wiederholte Läufe und feste Fixture-Uhr liefern bytegleich normalisierte Entscheidungen; `profileRegistryHash` und `pathContractHash` bleiben getrennt, Timestamp bleibt außerhalb des Entscheidungshashs. |
| AC-CBG-007 | Evidence-/Hook-Negativmatrix blockiert; passende Evidence erlaubt; serverseitige Simulation blockiert Hook-Bypass. Nach dem Hook-Edit belegen Neuinstallation, Quellen-/Installationshash und direkte Pass-/Block-Aufrufe des installierten Hooks mit sicheren Fixture-Remotes ohne Push die Verfassungsanforderung. |
| AC-CBG-008 | Bash-/PowerShell-Normalisierung, Maintenance-Regression, Syntax/PSScriptAnalyzer, Secret, A11Y, Doku, Workflow und Statistik grün; manuell je Variante auf mindestens einem Ziel-OS. Der macOS-Nachweis konsumiert zusätzlich die fail-closed validierte interne Hook-Installations-/Verhaltensdatei. |
| AC-CBG-009 | Spy-Adapter und Git-Diff-Allowlist beweisen null GitHub-Schreibverben, aktive Rulesets, Copilot-/G4-/Accountpfade und Zielrepository-Edits. Die Allowlist enthält die notwendige `.gitignore`-Regel für `.specify/runtime/`, aber keine Lauf-Acceptance-Datei. |
| AC-CBG-010 | Read-only Live-Inventur plus vollständiges Fleet-Fixture erzeugen genau einen geordneten lokalen Eintrag je Repository der autoritativen Union, `remoteConverged=false`; Collection zählt nicht. |

Die maschinenlesbaren Gate-Tokens stehen in
[`autonomous-run-gate-requirements.json`](autonomous-run-gate-requirements.json).
Jedes AC besitzt genau einen ausführbaren Primary-Aggregator. Der vollständig
aufgelöste Befehl für `AC-CBG-NNN`, wobei `NNN` die jeweilige ID `001` bis `010`
ist, lautet exakt:

`python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-NNN --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence`

Der Aggregator führt den vollständigen Gate-Scope selbst aus oder validiert
seine internen maschinenlokalen Bash-, PowerShell-, manuellen und Fixture-
Eingabedateien fail-closed. Er berechnet deren normalisierte SHA-256-Werte und
nimmt Pfad plus Hash in sein eigenes Ergebnis auf; fehlende, unerwartete,
ungültige oder hashgedriftete Inputs blockieren. Diese internen Dateien sind
keine autonomen Gate-Evidence-Zeilen und besitzen kein `supplementalFor`.

Das finale Schema-2.0-Acceptance-Artefakt dieses `LocalImplementation`-Laufs
enthält exakt zehn Zeilen: je eine `Primary`-Zeile für `AC-CBG-001` bis
`AC-CBG-010` und null `Supplemental`-Zeilen. Jede Primary-Zeile zeichnet den
tatsächlich ausgeführten, oben vollständig bestimmten Aggregatorbefehl mit der
passenden AC-ID und `runnerOrPlatform="macOS"` auf.

Für `AC-CBG-008` orchestriert der Aggregator Bash-Syntax,
PowerShell/PSScriptAnalyzer, Paritätsfixtures, Secret Scan, A11Y,
Dokumentation, Workflow und Statistik. `AC-CBG-009` umfasst Mutation-Spy und
die exakte Stufe-A-Git-Diff-Allowlist. `AC-CBG-010` umfasst vollständige
Fixtures sowie den getrennt kontrollierten read-only Live-Inventurnachweis.
Implementierungsevidence darf `Completed` erst melden, wenn jedes anwendbare
AC genau einen aktuellen Primary-Nachweis, keine Supplemental-Zeile und ein
Aggregatorresultat mit vollständig validierten internen Input-Hashes besitzt.

## Risiken und technische Schuld / Risks and Technical Debt

| Risiko / Risk | Disposition |
|---|---|
| GitHub-Live-API oder Rate Limit nicht verfügbar | Fail-closed, keine alte Datei als live bezeichnen; begrenzter Retry nur für transient klassifizierte Fehler. |
| Level-0-Self-Record, Registry und Fleet Manifest driften | Vor Kosten/Rollout exakte Gleichheit mit der autoritativen Union aus `home-baseline` und aktiven Manifest-Git-Zielen sowie vollständige Sichtbarkeitsgleichheit; keine Namens-/Pfadheuristik. |
| Lokaler Hook wird umgangen | Akzeptierte Schuld: Hook ist nicht alleinige Grenze; unabhängiger PR-/Minimal-Statusvertrag bleibt zwingend und wird in Stufe A simuliert. |
| Vorhandener Python-Kern wächst | Bewusst akzeptiert, weil ein zweiter Engine-Prozess oder eine neue Runtime mehr Drift erzeugt. Domänenfunktionen bleiben rein/testbar; Re-Evaluation bei unübersichtlicher Modulgröße. |
| Live-Dauer-/Copilot-Daten fehlen | Kategorie sichtbar blockieren, nicht schätzen oder mit Actions-Minuten vermischen. |
| Stufe-B-Rollout bleibt offen | Kein technischer Schuldenpunkt in Stufe A, sondern ausdrücklich nicht autorisierter Folge-Scope mit neuer Authority- und Live-Revalidation. |

## Dokumentationsauswirkung / Documentation Impact

**Entscheidung / Decision**: `UpdateRequired` — einzige Feature-weite
Dokumentationsentscheidung.

- **Zielgruppen und Leserpfade / Audiences and reader paths**: Maintainer,
  Flotten-Operator*innen, Repository-Owner und Reviewer starten bei Zweck,
  Voraussetzungen, Stufe-A-Sicherheitsgrenze und einer sicheren Vorschau;
  danach folgen Profile, Gate/Evidence, Fehlerbehebung, Kosten, Architektur,
  Security/A11Y und der ausdrücklich nicht ausgeführte Stufe-B-Handoff.
- **Kanonische Quelle und Owner / Canonical source and owner**: Level 0 besitzt
  `scripts/config/ci-budget-profiles.json` für Profile/Assignments/Gate Sets/
  Budgetannahmen, ausschließlich `scripts/config/ci-budget-path-contracts.json`
  für Pfadverträge, dazu Skript-/Hook-Vertrag und Templates; Owner
  ist der `home-baseline` Feature-Owner. Live-Zustand und maschinenlokale
  Evidence sind keine Git-Quelle.
- **Betroffene Dokumente / Affected documents**: README-/Wartungsnavigation,
  `docs/scripts/reference.md`, `docs/man/maintain-agentic-workspace.1.md`,
  `docs/man/install-hooks.1.md`, PowerShell-Hilfe,
  `docs/architecture/ci-budget-governance.md`, die genannten Security-Dateien,
  `docs/accessibility/ci-budget-governance.md`, Workflow-/Ruleset-Erklärung,
  der verpflichtende Hook-Reinstallations-/Pass-/Block-Nachweis,
  Documentation-Impact-Evidence und Projektstatistik.
- **Dokumentklasse und Navigation / Document class and navigation**:
  versionierter Betriebs-/Governance-Vertrag; Einstieg nach Progressive
  Disclosure, Detailseiten aus bestehender Skript-/Wartungsnavigation verlinkt.
- **Sprachstrategie / Language strategy**: kurze Flächen inline Deutsch zuerst
  und Englisch danach; große Partnerdatei nur nach dokumentierter
  Wartbarkeitsprüfung. CEFR B2 und Begriffserklärung sind Pflicht.
- **Plattformnachweis / Platform proof**: ausführbare Bash- und
  PowerShell-Beispiele; in diesem Lauf werden beide Varianten manuell auf
  macOS ausgeführt. Normalisierte Fixtures belegen zusätzlich die semantische
  macOS-/Linux-/Windows-Parität, ohne fremde Runner-Ausführung zu behaupten.
- **Distribution**: Quellen und Design `sourceOnly`; manifestgebundene Wrapper,
  Hook und Runtime-Konfiguration nach späterer autorisierter Lieferung
  `homeRuntime`; Gate-, Inventory- und Rollout-Evidence `machineLocal` und nie
  Git-getrackt.
- **Home-Sync / Home sync**: `false` in dieser Stufe A. Nur ein später
  ausdrücklich autorisierter, vorher geprüfter Runtime-Sync darf verteilen.
- **Generated statistics**: Die Feature-Entscheidung bleibt `UpdateRequired`;
  für Statistik wird ausschließlich `docs/project-statistics.config.json`
  geändert und `render-project-statistics.*` erzeugt/verifiziert die Ableitung.
- **Evidence und Re-Evaluation**: Documentation-Impact-Record, Link-/A11Y-/
  Sprach-/Plattform-/Rendererchecks. Re-Evaluation bei Profil-, Flotten-,
  Sicherheits-, Authority-, Schema-, Plattform-, Distributions- oder
  Zielgruppenänderung.

## Verfassungsprüfung nach Design / Post-Design Constitution Check

- **Security/Architecture**: Pass. Das Design benennt Assets, Trust Boundaries,
  Defense in Depth, Least Privilege, Fail-closed, Mutation Barrier, STRIDE+CIA,
  CAPEC, S-ADR, Zero Trust, SAMM, genau eine Pfadvertragsquelle, getrennte
  Registry-Hashes und konkrete Evidence-Pfade.
- **Manual-first/Hook**: Pass. Nach dem Edit von `scripts/hooks/pre-push` folgen
  serialisiert `bash scripts/install-hooks.sh`, Quell-/Installationshash und
  direkte Pass-/Block-Fixtures des installierten Hooks ohne Push; AC-CBG-007
  und AC-CBG-008 binden den internen macOS-Record fail-closed.
- **iSAQB**: Pass. Qualitätsziele sind Korrektheit, Determinismus,
  Auditierbarkeit, Kostenkontrolle, Portabilität, A11Y und Nichtmutation;
  Kontext-, Baustein-, Laufzeit- und Deployment-/Stufen-Sicht werden in
  `docs/architecture/ci-budget-governance.md` aktualisiert. Risiken und
  Schulden sind disponiert.
- **Cloud C3A/C5**: `N/A`, weil keine Cloud-Runtime, Hosting-Auswahl oder
  Providerabhängigkeit hinzukommt; Re-Evaluation bei solcher Abhängigkeit.
- **MSL**: `N/A` für neue Runtime, sichere Skriptbegründung vollständig;
  Re-Evaluation bei neuer kompilierter/runtime Komponente.
- **Cross-Platform/A11Y/Bilingual**: Pass. Beide Wrapper, Manpage,
  PowerShell-Hilfe, Cmdlet, Plattformmanuals, stabile lineare Ausgabe und
  DE-first/EN-second sind gemeinsam geplant. Jeder native Befehl in den
  PowerShell-Quickstart-Blöcken prüft `$LASTEXITCODE` unmittelbar, bevor der
  nächste Befehl ausgeführt wird.
- **Agent Parity**: Review `Applicable`; Update `N/A` / `NoUpdateRequired`,
  weil keine Shared-Guidance-Semantik geändert wird. Der Pflichtvalidator,
  atomare Update-Umfang und Re-Evaluation-Trigger sind ausdrücklich festgelegt.
- **Autonomous authority**: Pass. Alle sechs Plan-Artefaktfamilien liegen in
  der Feature-Quelle; keine Implementierung, kein optionaler Commit-Hook und
  keine Stufe-B-Handlung wurde ausgeführt.
- **Offene Punkte**: Keine ungeklärte Anforderung und keine offene Gate- oder
  Governance-Entscheidung.

## Komplexitätsverfolgung / Complexity Tracking

Keine Verfassungsverletzung erfordert eine Ausnahme. Der vorhandene
Python-Vertragskern wird wiederverwendet; ein zweiter Engine-Prozess, eine neue
Runtime oder eine aktive GitHub-Konfigurationsfläche wird ausdrücklich nicht
eingeführt.
