# Sicherheits-Querschnittskonzepte / Security Cross-Cutting Concepts

**Stand / State**: 2026-08-01

## Leitprinzipien / Principles

1. **Fail-safe defaults:** Dry-run ist vorausgewählt; Update-Bestätigung ist
   standardmäßig Nein.
2. **Least privilege:** UI-Auswahl erteilt nur Autorität für genau einen
   lokalen Engine-Prozess.
3. **Complete mediation:** Routing, Kombinationen, Eventzeilen,
   Cachemetadaten und Abschlussquellen werden bei jeder Nutzung geprüft.
4. **Separation of concerns:** C# präsentiert, Bash/PowerShell warten,
   Python validiert gemeinsame Datenverträge.
5. **Defense in depth:** Typed Arguments, striktes JSON, Markup-Escaping,
   SHA-256, atomare Veröffentlichung und Exact-Head-CI wirken gemeinsam.

## Sicherheitsrelevante Bausteine / Security-Relevant Building Blocks

| Baustein | Eingabe | Sicherheitsausgabe |
|---|---|---|
| Invocation Router | TTY-Fakten und UI-Schalter | Enhanced, Plain oder Headless |
| Selection Validator | typisierte Modusauswahl | gültige Kombination oder Exit 2/130 |
| Command Builder | Auswahl und Plattform | Argumentliste plus reine Textdarstellung |
| Event Reader | vollständige JSONL-Zeilen | validierter Live-Status oder dauerhafte Degradation |
| Result Reconciler | Prozess, vorgebundener Bericht, optionales Abschlussereignis | Status oder `RESULT_MISMATCH` |
| UI Cache | Quellen, Lockfiles, Plattform | vollständiger atomarer Build oder Plain-Fallback |

## Betriebsgrenzen / Operational Boundaries

Die bestehenden Freshness-, Mutation-, Cleanup-, Admin- und
Zielrepository-Grenzen aus Features 015 bis 017 bleiben unverändert. Die TUI
besitzt keinen Bypass. NIS2, CRA, EU AI Act, DORA, BSI C3A und BSI C5 sind für
den lokalen internen Helfer nicht ausgelöst. Neu bewerten bei Marktfreigabe,
reguliertem Dienst, Cloudbetrieb oder KI-Laufzeit.

Der Berichtspfad wird vor Prozessstart an Home-Verzeichnis und Run-ID gebunden.
Die TUI durchsucht kein Verzeichnis nach einer vermeintlich neuesten Datei.
Ein fehlendes Live-Abschlussereignis schwächt diese Bindung nicht; ein
widersprechendes vorhandenes Ereignis bleibt ein Integritätsfehler.

*Existing safety barriers remain unchanged and the UI has no bypass. Cloud,
regulated-service, market-release, and AI-runtime controls are re-evaluated
only when such a boundary enters scope. The report path is bound to home
directory and run ID before process start; no newest-file scan is allowed. A
missing live completion event does not weaken this binding, while a present
contradictory event remains an integrity failure.*

<!-- EN: docs/security/arc42-security.md
[DE-Zusammenfassung: Sichere Querschnittsprinzipien und Bausteine der Wartungs-TUI.]
-->

## Feature 029: Sichere CI-Bausteine / Secure CI Building Blocks

Die Bash-/PowerShell-Adapter validieren nur Optionen und starten einen
Python-Kern. Der Kern trennt Registry-Validierung, GET-only-Inventory,
Pfad-/Kostenplanung, Kindprozess-Gates und atomare Evidence-Publikation. Der
Hook konsumiert Evidence; er erzeugt keine Remote-Autorität. Inaktive
Workflow-/Ruleset-Templates sind eine getrennte Server-Policy-Simulation.

Sicherheitsgrenzen: sichere Argument-Arrays, Arbeitsverzeichnis-Containment,
Timeouts, sanitierte Diagnose, doppelte HEAD-/Hash-Prüfung, `os.replace`,
restriktive Dateirechte, exakte Assignment-/Sichtbarkeitsmenge und konstantes
`remoteConverged=false`. Deployment bleibt Stufe A lokal; Stufe B und G4 sind
nicht ausgeführt.

## Feature 030: arc42 Abschnitt 8 – Querschnitt / Cross-Cutting Concepts

Stage B erweitert die lokale Stufe A um eine ausdrücklich autorisierte, aber
streng seriell vermittelte Remote-Transaktion. Der unveränderliche
`StageBRolloutPlan` beschreibt nur Zielzustand und erste Mutation; der
veränderliche `StageBRunState` enthält Authority, Fortschritt, Blocker und
hashgebundene Evidence-Indizes. Diese Trennung verhindert, dass Fortschritt
den eigenen Planhash invalidiert.

| Querschnitt | Entscheidung / Decision |
|---|---|
| Trust Boundaries | Local clone, isolated worktree, Git object database, GitHub API, PR/check/review, ruleset, authority, run state, evidence and Home Runtime are mediated separately. |
| Remote transaction | Genau ein Zielwriter; exakter Diff; lokales Gate vor Commit; Providerzustand vor jedem Write erneut lesen; keine Shellauswertung. |
| Ruleset | Workflow per regulärem PR; Ruleset erst danach; numerische ID, vorheriger Zustand und höchstens ein exakt geplanter Restore sind hashgebunden. |
| Bypass | Kein Normalpfad. Nur nach protection-only Refusal, grünen unabhängigen Gates/Review und frischer scope-/head-/zeitgebundener Ausnahme-Evidence. |
| Stop/Resume | Erster nicht behebbarer Fehler wird atomar persistiert; Resume revalidiert Fleet, Plan, Authority, Provider, Evidence und Budget und wiederholt keinen unklaren Write blind. |
| Evidence | Operational truth and temporary acceptance snapshots remain separate; publish only schema-valid, redacted, run-/plan-bound records. |

Defense in Depth, Least Privilege, Complete Mediation, Fail-Safe Defaults,
Attack Surface Reduction und Separation of Concerns bleiben bindend. Ein
lokaler oder eng begrenzter Plattformnachweis beweist nur seinen gebundenen
Befehl und darf nicht als vollständiger Regressionspass ausgewiesen werden.
G4, Intake-Serie, Copilot, Account und Subscription bleiben außerhalb der
Stage-B-Transaktion.

Owner: Architecture Owner. Reviewer: Security/iSAQB Reviewer. Restrisiko:
Live-Provider- und Schutzregelzustände sind zeitabhängig. Re-Evaluation bei
Provider-, Deployment-, Ruleset-, Authority-, Evidence- oder Resume-Drift.
