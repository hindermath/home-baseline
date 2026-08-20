# Implementierungs-Governance / Implementation Governance

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: Autonomous Stage-A Reviewer
**Restrisiko / Residual risk**: Ein offener oder unbelegter Gate-Eintrag blockiert den Abschluss.
**Follow-up**: T090 schließt alle zwölf Presets sowie CBG-001..021 und AC-CBG-001..010.
**Re-Evaluation**: Bei Preset-, Verfassungs-, Authority- oder Evidence-Drift.

## Implementierungsstatus / Implementation Status

Completed for Stage A / `LocalImplementation`. Alle 93 Tasks besitzen einen
ausgeführten Nachweis oder einen expliziten Abschlussvertrag. Die Live-Inventur
vom 20. August 2026 bestätigte 48 Repositories und führte nach manueller,
fail-closed Prüfung zu den Sichtbarkeitskorrekturen `absdd-image-sandbox` →
`Public Product` und `inventar-db` → `Private Product`; die neu berechnete
Matrix ist `3/6/7/20/12`. Keine automatische Umklassifizierung fand statt.

## Preset-Abschlussmatrix / Preset Closeout Matrix

| Preset | Disposition | Implementation status and evidence | Owner / Reviewer | Residual risk, follow-up, re-evaluation |
|---|---|---|---|---|
| `security-governance` | Applicable | Passed: Threat Model, Security Checklist, S-ADR, Secret-Scan und `security-final-macos.json`. | Feature Owner / Security Reviewer | Lokaler Hook bleibt umgehbar; Serververtrag erst mit neuer Stage-B-Autorität anwenden; neu bewerten bei Auth-, Secret-, Crypto-, Dependency- oder Trust-Boundary-Änderung. |
| `architecture-governance` | Applicable | Passed: `docs/architecture/ci-budget-governance.md`, ADR-002 und Stufe-A-Mutationsbarriere. | Architecture Owner / Architecture Reviewer | Defense-in-Depth-Grenze kann bei neuer Runtime oder Delivery-Fläche driften; dann Architektur und ADR neu prüfen. |
| `isaqb-architecture-governance` | Applicable | Passed: Kontext-, Baustein-, Laufzeit-, Deployment-, Qualitäts-, Risiko- und Schuldenreview sind im Architekturnachweis geschlossen. | Architecture Owner / iSAQB-oriented Peer | Gemeinsamer Python-Kern kann wachsen; Modulgrenzen bei struktureller Änderung neu bewerten. |
| `a11y-governance` | Applicable | Passed: `docs/accessibility/ci-budget-governance.md`, lineare textbasierte Ausgaben und `PlatformParityAccessibilityTests`. | Feature Owner / A11Y Reviewer | Plattformtexte können driften; jede nutzerseitige Ausgabe erneut gegen WCAG 2.2 AA und Textwerkzeuge prüfen. |
| `cross-platform-governance` | Applicable | Passed: Bash-/PowerShell-Hilfe, Manpage, Strict-Mode-/Quoting-Verträge, manuelle macOS-Nachweise und semantische macOS-/Linux-/Windows-Fixtures. | Script Owner / Cross-Platform Reviewer | Kein Linux-/Windows-Runner wurde behauptet; bei Plattform- oder CLI-Vertragsänderung manuelle Ziel-OS-Nachweise erneuern. |
| `agent-parity-governance` | Applicable | Passed review; update disposition `NoUpdateRequired`. Fünf Agentenflächen, Constitution, Memory und Templates blieben semantisch unverändert; Paritätstest grün. | Governance Owner / Agent-Parity Reviewer | Bei erster Shared-Guidance-Änderung alle Flächen atomar aktualisieren und erneut validieren. |
| `model-routing-governance` | N/A | Closed: keine Provider-, Modell-, Rollen- oder Routingpolicy wurde geändert; bestehender Runner-Preflight blieb bindend. | Run Owner / Routing Validator | Lokale Profilbindung kann driften; bei Routingrollen oder Modellpolicy neu bewerten. |
| `intake-authoring-governance` | N/A | Closed: akzeptiertes Intake und Receipt wurden weder erzeugt noch geändert. | Intake Owner / Intake Governance | Bei Intake-Hashdrift stoppen und Authoring-/Review-Kette erneut ausführen. |
| `intake-review-governance` | N/A | Closed: Ready-Review `694b6579-3443-4c9e-8017-8c7b285dae0f` blieb unverändert und bindend. | Intake Owner / Review Owner | Freshness bei akzeptiertem Artefaktwechsel neu prüfen. |
| `intake-sequencing-governance` | N/A | Closed: Serienmanifest, Receipt und DAG-Position blieben unverändert; G4 startete nicht. | Series Owner / Sequencing Validator | Bei Manifest-, Kanten- oder Eligibility-Änderung Zustand revalidieren. |
| `autonomous-run-governance` | Applicable | Passed: zehn aktuelle Primary-, null Supplemental-Zeilen in `final-gate-evidence.json`, Schema 2.0, HEAD-Bindung und Validator grün. | Run Owner / Autonomous Stage-A Reviewer | Uncommitted Candidate wird durch T091 separat gebunden; bei HEAD-, Authority-, Requirements- oder Evidence-Hashdrift neu aggregieren. |
| `parallel-autonomous-run-governance` | N/A | Closed: keine Kampagne, Worker-Delegation oder Konsolidierung wurde autorisiert oder ausgeführt. | Run Owner / Governance Reviewer | Nur bei ausdrücklicher Kampagnenautorität neu bewerten. |

## CBG-Rückverfolgbarkeit / CBG Traceability

| Verträge | Implementation status | Evidence |
|---|---|---|
| CBG-001–CBG-002 | Passed | Autoritative 1+47-Menge, manuell geprüftes Mapping, Live-Matrix `3/6/7/20/12`, negative Inventur-Fixtures. |
| CBG-003–CBG-009 | Passed | Fünf Profilpolicies, Private-Governance-Minimal-Gate, sechs CaseTracker-Jobs, Release-Please-/Swift-/Canary-/Preset-Sonderfälle. |
| CBG-010–CBG-014 | Passed | Evidence-Schema, atomare Publikation, HEAD-/Gate-Set-/Hook-Bindung, installierte Hook-Pass-/Block-Fixtures und Serververtrags-Negativtests. |
| CBG-015–CBG-016 | Passed | Pfadunion, Workflow-Rationalisierung, Decimal-Kostenprojektion und getrennte Copilot-Kategorie. |
| CBG-017 | Passed | Bash-/PowerShell-Parität, PSScriptAnalyzer, A11Y, Dokumentation, Statistik und Regressionen. |
| CBG-018–CBG-019 | Passed | Deterministische Rolloutpläne, `mutationsPerformed=false`, `remoteConverged=false` für alle 48 Einträge und exakte Stufe-A-Diff-Grenze. |
| CBG-020–CBG-021 | Passed | Security-/Architektur-/Betriebsnachweise, LocalImplementation-only, keine Remote-, Home-, Zielrepo-, Delivery- oder G4-Mutation. |

## Acceptance-Abschluss / Acceptance Closeout

| Gate | Primary status | Bound evidence |
|---|---|---|
| AC-CBG-001 | Pass | `primary/AC-CBG-001.json`: 48er-Menge, Canaries, Sichtbarkeit und Drift-Fixtures. |
| AC-CBG-002 | Pass | `primary/AC-CBG-002.json`: Private-Governance-Minimalvertrag und unabhängige Servergrenze. |
| AC-CBG-003 | Pass | `primary/AC-CBG-003.json`: höchstens sechs deduplizierte CaseTracker-Produktjobs. |
| AC-CBG-004 | Pass | `primary/AC-CBG-004.json`: wiederkehrende private Last und Bedarfs-Gates getrennt. |
| AC-CBG-005 | Pass | `primary/AC-CBG-005.json`: unter 500/3000 Minuten, Copilot-Kategorien ausgeschlossen. |
| AC-CBG-006 | Pass | `primary/AC-CBG-006.json`: deterministische Entscheidungen, Hashes, Reihenfolge und Exitcodes. |
| AC-CBG-007 | Pass | `primary/AC-CBG-007.json`: Hook-/Evidence-/Ruleset-Pass- und Blockmatrix mit installiertem Hook-Hash. |
| AC-CBG-008 | Pass | `primary/AC-CBG-008.json`: Bash, PowerShell, Analyzer, Parität, Secret, A11Y, Doku, Workflow, Statistik und Regression. |
| AC-CBG-009 | Pass | `primary/AC-CBG-009.json`: Mutation-Spy und Stufe-A-Allowlist ohne Verstoß. |
| AC-CBG-010 | Pass | `primary/AC-CBG-010.json`: getrennte GET-only Live-Inventur und 48 lokale Rollout-Einträge ohne Konvergenzbehauptung. |

Alle Dispositionen sind geschlossen. Follow-ups erweitern weder die aktuelle
Authority noch den Stage-A-Scope; sie werden nur bei ihrem jeweiligen
Re-Evaluation-Trigger aktiv.

## Quickstart-Abschluss / Quickstart Closeout

- Vertrags-/Schema-Parsing, Ignore-Gate und die vollständige
  `test_ci_budget_governance.py`-Suite: Pass.
- Bash `--ci-gate --dry-run` und PowerShell `-CiGate -WhatIf`: Pass; Status vor
  und nach beiden Vorschauen bytegleich.
- Fixture-Plan: 48 Einträge, `stage=A`, `LocalImplementation`,
  `mutationsPerformed=false` und null `remoteConverged=true`.
- Kontrollierte Live-Inventur: 48 ausschließlich lesende `gh api --method GET`-
  Ergebnisse in `internal/live-inventory-read-only-macos.json`; der Python-
  Kindprozess war durch die Seatbelt-Netzwerkgrenze gesperrt, daher wurden die
  identischen minimierten GETs einzeln vom Orchestrator ausgeführt und danach
  durch `ci-budget-plan --adapter fixture` gegen denselben Produktionsvertrag
  validiert. Keine Schreibmethode wurde aufgerufen.
- Echter lokaler Gate: Pass mit drei fortlaufenden Ergebniszeilen unter
  `internal/quickstart-local-gate/home-baseline/039784a55ae3c06e206035c9b850de3c8490311f.json`;
  der maschinenlokale Override blieb im ignorierten Run-Verzeichnis.
- Hook-Installer gemäß Resume-Auftrag nicht erneut ausgeführt. Stattdessen
  bindet `internal/ac-cbg-007-008-hook-installation-macos.json` den installierten
  Pass-/Block-Lauf; abschließendes `cmp` und beide SHA-256-Werte bestätigten
  weiterhin `0982e1c3b51f1adc080e27662c1648554a4563f6e80fdeaa824b09ec0f5358ee`.
- Hook-/Serververtrags-Fixtures und Secret-Scan: Pass. Abschließender
  Statusvergleich: unverändert; kein Commit, Push, Merge, Home-Sync,
  Zielrepository-, GitHub-Schreib-, Ruleset-, Reviewer-, Copilot- oder G4-Pfad.
