# CI-Budget-Governance / CI Budget Governance

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: iSAQB/arc42 Architecture Reviewer
**Restrisiko / Residual risk**: Stage-B-Live-Lieferung und G4 bleiben außerhalb der aktuellen `LocalImplementation`-Authority.
**Follow-up**: Stage-B-Remote-Lieferung erst ab T127 unter frisch revalidierter Authority; G4 nur nach terminaler Flottenevidence und separater Sequencing-Autorität.
**Re-Evaluation**: Bei Runtime-, Fleet-, Authority-, Workflow- oder Ruleset-Änderungen.

## Architekturstatus / Architecture Status

Die Stufe-A-Architektur ist implementiert. Sie erzeugt ausschließlich lokale
oder read-only Evidence und behauptet keine Remote-Konvergenz. Finaler
iSAQB-/arc42-Review am 2026-08-20: `Pass` für Kontextabgrenzung, Bausteine,
Laufzeit, Deployment/Stufen, Qualitätsziele, Risiken und technische Schuld.
Reviewer: iSAQB/arc42 Architecture Reviewer. Kein `Open`-Punkt verbleibt für
Stufe A.

*The Stage-A architecture is implemented. It produces local or read-only
evidence only and never claims remote convergence. The final iSAQB/arc42 review
is recorded again after all user and documentation surfaces are complete.*

## Kontext und Grenzen / Context and Boundaries

Der Level-0-Klon ist die einzige schreibbare fachliche Quelle. Fleet-Manifest,
Profil- und Pfadregistry sowie die inaktiven Workflow-/Ruleset-Templates sind
versionierte Eingaben. GitHub ist ausschließlich eine read-only
Beobachtungsgrenze. Zielrepositorys, Home Runtime, aktive Workflows, Rulesets,
Accounts, Reviewer und G4 bleiben außerhalb der Schreibgrenze.

*The Level-0 clone is the only writable business source. GitHub is a read-only
observation boundary. Target repositories, Home Runtime, active policy and G4
remain outside the write boundary.*

## Bausteine / Building Blocks

1. Bash und PowerShell validieren die Oberfläche und starten genau einen
   Python-Engine-Prozess.
2. Der Vertragskern lädt Profil- und Pfadregistry je einmal, validiert
   Referenzen und hält beide SHA-256-Grenzen getrennt.
3. Fixture- und GitHub-GET-Adapter liefern ein atomar gebundenes Inventory.
4. Pfad-, Workflow- und Kostenplaner erzeugen deterministische Stufe-A-
   Entscheidungen.
5. Der lokale Gate-Runner nutzt Argument-Arrays mit `shell=False`, bindet HEAD
   und Gate-Set-Hash doppelt und publiziert ausschließlich atomare
   Erfolgsevidence.
6. Pre-push-Hook und unabhängiger simulierter Server-Minimal-Gate bilden
   Defense in Depth.

## Laufzeit- und Deployment-Sicht / Runtime and Deployment View

```text
Wrapper -> ein Python-Prozess -> Vertragsprüfung -> Inventory/Pfadentscheidung
        -> Preview ODER lokale Gates -> HEAD/Hash-Revalidierung -> Evidence
```

Stufe A installiert oder aktiviert kein Deployment. Die beiden Templates unter
`scripts/templates/ci-budget-governance/` bleiben inaktiv. `remoteConverged`
ist in jeder Rolloutzeile konstant `false`.

## Qualitätsziele, Risiken und technische Schuld / Quality Goals, Risks and Debt

- Sicherheit: fail-closed Eingaben, sichere Pfade und keine Remote-Schreibverben.
- Nachvollziehbarkeit: getrennte Registry-Hashes, feste ID-Mengen und zehn
  hashgebundene Primary-Gates.
- Portabilität und Zugänglichkeit: identische lineare Bash-/PowerShell-Ausgabe,
  DE zuerst, EN danach, ohne Farbe.
- Risiko: Der gemeinsame Python-Kern bleibt groß. Follow-up-Owner ist der
  Architecture Owner; eine Modulaufteilung wird bei der nächsten strukturellen
  Erweiterung neu bewertet.
- Risiko: Lokale Hooks sind umgehbar. Der unabhängige Serververtrag bleibt
  deshalb zwingend und darf in Stufe B nicht abgeschwächt werden.

## Nicht ausgeführter Handoff Stufe B und G4 / Unexecuted Stage-B and G4 Handoff

Owner für eine spätere Stufe B ist der Fleet Delivery Owner. Blocker ist die
fehlende neue Remote-Mutationsautorität; der aktuelle `LocalImplementation`-
Lauf darf weder Zielrepositorys noch GitHub-Konfiguration ändern. Vor Stufe B
müssen aktueller HEAD, Intake-/Run-State, Live-Inventar, Assignment-Sichtbarkeit,
Budget und Ruleset-Semantik vollständig revalidiert werden.

G4 wurde nicht gestartet. Owner ist der Intake Series Owner. Blocker ist der
nicht abgeschlossene, separat zu autorisierende Stufe-B-Rollout. G4 darf erst
nach dokumentierter Remote-Konvergenz und erneutem Sequencing-Gate beginnen.
Diese Abschnitte sind Handoff-Evidence, keine Aktionsanweisung.

*Stage B needs fresh remote-mutation authority and complete revalidation. G4
was not started and requires separately proven Stage-B convergence plus a new
sequencing gate. This is handoff evidence, not an executed action.*

## Stage-B-Isolation und späterer G4-Handoff / Stage B Isolation and Later G4 Handoff

Stage B liefert ausschließlich die akzeptierte CI-/Budget-Control-Plane und
die seriell gebundene Flottenkonvergenz. Die aktive Intake-Serie, G4,
Copilot-Konfiguration, Account- und Subscription-Einstellungen bleiben
unverändert. Owner ist der Intake Series Owner; blockierend sind fehlende
terminale Fleet-Evidence oder fehlende separate Sequencing-Autorität. Die
nächste zulässige Aktion ist ausschließlich die Anforderung eines getrennt
autorisierten Intake-Series-Sequencing-Updates. Dieser Handoff wird bei
Änderungen an Fleet-Menge, G4-Scope, Series-Manifest oder Authority neu
bewertet.

*Stage B delivers only the accepted CI/budget control plane and serialized
fleet convergence. The active intake series, G4, Copilot configuration,
account, and subscription settings remain unchanged. The Intake Series Owner
owns the later handoff. Missing terminal fleet evidence or separate sequencing
authority blocks it. The only next action is to request a separately authorized
intake-series sequencing update. Re-evaluate when fleet identity, G4 scope,
the series manifest, or authority changes.*

## Feature 030: Stage-B-Architektur / Stage B Architecture

### Kontext und Schnittstellen / Context and Interfaces

Der Level-0-Klon ist kanonische Control-Plane-Quelle. Eingehende Schnittstellen
sind die terminale Stage-A-Evidence, beide Constitutions, Fleet-Manifest,
Environment-/Profil-/Pfadregistries, fünf Stage-B-Schemas, Gate Requirements,
aktuelle Authority und read-only Providerinventar. Ausgehende Schnittstellen
sind exakt geplante Git-Objekte, Branch/PR/Review/Merge, der getrennte
Rulesetvertrag sowie schema-validierte operative und spätere redigierte
Evidence. Home Runtime, G4, Intake-Serie, Copilot, Account und Subscription
bleiben eigene, nicht implizit betretene Grenzen.

| Schnittstelle | Vertrag / Contract | Fehlergrenze |
|---|---|---|
| Bash/PowerShell → Python | typisierte Stage-B-Aktion, Safe Mode, unveränderter Exitcode | ungültige Option oder Plattforminput endet vor Engine-Write |
| Planner → Transaction | `StageBRolloutPlan` v1.1, exakte Pfad/Mode/Blob-Liste, `firstMutation` | jede Plan-/Kandidatendrift blockiert vor Staging |
| Transaction → GitHub | feste Host-/ID-/Slug-/Endpoint-Bindung, getrennte Read-/Write-Argumentarrays | Timeout nach Write wird nur read-only reconciled |
| Workflow/PR → Ruleset | `StageBRulesetPlan` v1.0; Workflowmerge vor Ruleset; vorheriger Zustand/Restore gebunden | fehlende Post-Write-Konvergenz stoppt nach höchstens einem geplanten Restore |
| Components → Evidence | direkte Run-ID/`planSha256`, kanonisches JSON, geschlossene Schemas | Redaction-/Schemafehler publiziert keine Teildatei |

### Bausteinsicht / Building-Block View

1. `StageBFleetPreflight` bildet die dynamische, stabile Repository-ID-Menge
   und bindet Stage A, Registry, Head, Provider, Budget und Authority.
2. `StageBRolloutPlanner` erzeugt fünf feste Wellen und den unveränderlichen
   Plan ohne Fortschritts- oder Authority-Felder.
3. `StageBRunState` ist allein veränderlich und indexiert Authority, Wellen,
   Zielresultate, Budgets, Blocker und Evidence mit direkter Planbindung.
4. `ExternalWriteGate` vermittelt Scope, Run, Plan, Delivery Set, Repository-
   IDs und aktuelle Authority unmittelbar vor jeder Write-Klasse.
5. `StageBTargetTransaction` materialisiert in einem isolierten Worktree genau
   einen exakten Zielkandidaten und führt lokalen Gate-, PR-, Review-, Merge-
   und Sync-Lifecycle seriell aus.
6. `GitHubProviderAdapter` trennt Reads/Writes, validiert Host/IDs und
   reconciliert unklare Aktionen über stabile Idempotency Keys.
7. `StageBRulesetTransaction` installiert den Minimal-Gate erst nach seinem
   Workflowmerge und kennt höchstens einen exakt vorgeplanten Restore.
8. `StageBWaveCoordinator` und `StageBBudgetProjector` erlauben genau einen
   Writer und verlangen nach jeder Welle eine frische Decimal-Projektion.
9. `StageBEvidenceLedger` und `StageBTerminalVerifier` publizieren atomar,
   redigiert und kausal und verifizieren jede autoritative ID genau einmal.

### Laufzeitsicht / Runtime View

```text
Safe preview -> Fleet/authority/provider preflight -> immutable plan
             -> ExternalWriteGate closed -> no writes

Deliver/Resume -> full revalidation -> open gate for one bound action
               -> isolated exact candidate -> local gates -> PreMerge
               -> commit -> push -> one PR -> checks/review -> regular merge
               -> optional ruleset transaction -> default-head sync -> PostMerge
               -> target result -> wave result -> fresh budget -> next target/wave
               -> terminal read-only verification -> G4 handoff only
```

Bei einem nicht behebbaren Fehler persistiert der State Welle, Repository-ID,
In-flight-Aktion, letzte sichere Grenze, Blocker und nächste Aktion, bevor ein
Folgeziel startet. Resume übernimmt keine frühere Providerentscheidung:
Stage A, Fleet, Registries, Plan, Authority, Provider, Evidence und Budget
werden vollständig neu vermittelt. Bereits konvergierte Ziele werden nur
read-only bestätigt; unklare Writes werden nicht blind wiederholt.

### Deployment-Sicht / Deployment View

- **Level 0**: kanonische Source, Plan/State-Verträge, Templates und
  Orchestrator; erst regulärer Control-Plane-PR/Merge/Default-Sync.
- **Target worktree**: laufgebunden, isoliert, genau ein Repository und ein
  Kandidaten-Head; keine fremden Working-Tree-/Indexänderungen.
- **GitHub**: externe Hosting-/Actions-/PR-/Review-/Ruleset-Grenze mit
  providerabhängigen Adaptern und minimalen Permissions.
- **Machine local**: operative Truth und temporäre Primary-Snapshots unter dem
  Run-Root, niemals gestaged. Nur ausgewählte redigierte Abschlussnachweise
  werden später `sourceOnly` versioniert.
- **Home Runtime**: erst nach Level-0-Merge, Dry-Run, Konflikt- und Authority-
  Prüfung; im aktuellen T113–T123-Scope verboten.

### Qualitätsziele, Trade-offs, Risiken und technische Schuld

1. **Sicherheit vor Durchsatz**: ein serieller Writer ist langsamer als
   Parallelisierung, reduziert aber Race-, Budget-, Evidence- und
   Provider-Reconciliation-Risiken.
2. **Reproduzierbarkeit vor Komfort**: Blob-/Mode-Hashes und geschlossene
   Schemas sind aufwendiger als Patchtexte, bleiben jedoch plattformneutral
   und exakt überprüfbar.
3. **Verfügbarkeit ohne Fail-open**: Stop/Resume und bounded Reads erhalten
   Fortschritt; fehlende Daten, Quota/Billing und unklare Writes bleiben
   Blocker statt angenommener Erfolge.
4. **Providerportabilität**: Git-/JSON-Verträge sind exportierbar, PR-/Ruleset-
   Semantik bleibt bewusst im GitHub-Adapter. Ein Providerwechsel ist
   Architekturarbeit, keine Stringersetzung.
5. **Technische Schuld**: Der gemeinsame Python-Kern ist groß. Owner:
   Architecture Owner; Follow-up: Modulgrenzen erst nach terminalem Stage-B-
   Abschluss anhand stabiler Abhängigkeiten schneiden; bis dahin verhindern
   gemeinsame Invarianten eine verfrühte Aufspaltung.
6. **Externe TOCTOU-Grenze**: Providerzustand kann zwischen Read und Write
   wechseln. Unmittelbare Revalidierung und Post-Write-Reconciliation
   minimieren, beseitigen diese externe Grenze aber nicht.

### Finaler iSAQB-/arc42-Review / Final iSAQB/arc42 Review

`Pass for local implementation artifacts` am 2026-08-22. Kontext,
Schnittstellen, Bausteine, Laufzeit, Deployment, Qualitätsziele, Risiken,
Trade-offs und technische Schuld stimmen mit Spec, Plan, T001–T123-Aufteilung
und den fünf Stage-B-JSON-Schemas plus Workflow-/Ruleset-Vertrag überein.
Der Review behauptet keine Live-Providerkonvergenz, keinen T124-Vollregressions-
Pass und keinen Abschluss der Delivery-/Closeout-Tasks. Owner: Architecture
Owner. Reviewer: iSAQB/arc42 Architecture Reviewer. Re-Evaluation bei
Baustein-, Contract-, Provider-, Ruleset-, Authority-, Plattform-, Evidence-,
Deployment- oder G4-Grenzänderung.
