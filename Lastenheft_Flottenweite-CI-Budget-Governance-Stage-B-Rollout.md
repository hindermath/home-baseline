<!-- intake-authoring:begin -->
# Lastenheft: Flottenweite CI-Budget-Governance – Stage-B-Rollout

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review / Ready for Intake Review
**Version:** 1.0.0
**Stand:** 2026-08-20
**Zielgruppe:** Fleet Delivery Owner, Maintainer, Repository-Verantwortliche und Reviewer
**Vorausgesetztes Wissen:** grundlegende Git-, GitHub-Actions- und Pull-Request-Kenntnisse; keine Spec-Kit-Erfahrung
**Profil:** `home-baseline-lastenheft`
**Geplante Serienrolle:** bindender Stage-B-Abschluss zwischen G3 und G4
**Bindender Vorgänger:** abgeschlossenes G3 / Feature `029-ci-budget-governance`
**Bindender Nachfolger:** G4 GitHub-Copilot-Review-Governance
**Aktuelle Delivery Authority:** `LocalImplementation`; die spätere Remote-Ausführung verlangt eine frisch bestätigte `MergeAndSync`-Autorität

## Deutscher Vertrag

### 1. Zweck

Dieses Lastenheft schneidet den getrennten Stage-B-Rollout der in G3
entwickelten CI-Budget-Governance zu. Ein einziger, resumierbarer autonomer
Spec-Kit-Lauf soll die vorbereiteten Profil-, Pfad-, Workflow- und
Ruleset-Verträge kontrolliert in der Flotte ausrollen. G4 darf erst nach
vollständig belegter Remote-Konvergenz beginnen.

### 2. Aktueller Zustand

G3 / Feature 029 ist abgeschlossen. Stage A hat die kanonischen Profile,
Pfadverträge, lokalen Gates, atomare Evidence, den Pre-push-Schutz, inaktive
Workflow-/Ruleset-Templates, Tests, Dokumentation und einen deterministischen
Rolloutplan implementiert. Der akzeptierte Feature-HEAD ist
`e1ff2a0b5146604b2a71a20576dbd4341d618121`; der Feature-Merge ist
`b6a0d81760e9ef68a058e5d9578073b5e78b61b8`. Die Stage-A-Evidence behauptet
absichtlich für kein Ziel Remote-Konvergenz.

Die autoritative Baseline umfasst derzeit den Level-0-Self-Record plus 47
aktive `kind=git-repository`-Ziele. Die aktuelle Serienstruktur besitzt noch
die direkte Kante G3 → G4 und nennt für G3 den früheren Dateinamen. Diese
Intake-Erstellung ändert das Serienmanifest nicht.

### 3. Zielzustand

Alle beim Laufstart live ermittelten autoritativen Repositories sind entweder
über geprüfte Pull Requests auf den passenden kanonischen CI-Vertrag gebracht
oder mit einem überprüften No-op-Nachweis als bereits konvergent klassifiziert.
Jeder Default Branch ist danach lokal und remote synchron. Eine getrennte
Stage-B-Evidence belegt die Flottenkonvergenz. Erst dieser Nachweis kann ein
späteres Sequencing-Gate für G4 erfüllen.

### 4. Umfang

Der spätere Spec-Kit-Lauf umfasst:

- Revalidierung von G3-Abschluss, HEAD, Run-State, Live-Inventar,
  Repository-Sichtbarkeit, Default Branches, Profilzuordnungen, Gate Sets,
  Pfadverträgen, Budget und Ruleset-Semantik;
- Stage-B-fähige, sichere und resumierbare Rolloutsteuerung auf Level 0;
- echte Zieländerungen ausschließlich über Feature-Branch, exakten Commit,
  Push, Pull Request, erfolgreiche Gates, Review, Merge und Synchronisierung;
- Aktivierung der in Stage A nur simulierten Workflow-/Ruleset-Semantik, soweit
  das zugeordnete Profil sie verlangt;
- No-op- und Konvergenznachweise für Ziele ohne notwendigen Diff;
- deterministische Canary- und Profilwellen sowie terminale Flotten-Evidence;
- Dokumentationsauswirkung und Projektstatistik für die Level-0-Änderung.

### 5. Nicht-Ziele

Ausgeschlossen sind:

- jede Änderung an Copilot-Reviewer-, Account- oder Abonnement-Einstellungen;
- Start, Review oder Implementierung von G4;
- Self-hosted-Runner-Architektur oder zusätzliche Budgetfreigaben;
- Abschwächung von Secret Scan, Branch Protection, Pflichtreviews,
  Sicherheits-, A11Y-, Plattform- oder Produktgates;
- ein Admin-Bypass als Normalpfad oder aus dem Intake abgeleitete
  Bypass-Autorität;
- automatische Revert-PRs bereits erfolgreich gemergter Ziele;
- eine Änderung historischer Stage-A-Evidence oder ihrer Semantik;
- Änderung des aktiven Intake-Serienmanifests durch die Erstellung dieses
  Lastenhefts.

### 6. Verbindliche Anforderungen

- **SBR-001 – Frischer Gesamt-Preflight:** Vor jeder Zielmutation müssen der
  aktuelle Level-0-HEAD, der terminale G3-Run-State, die PostMerge-Evidence,
  das vollständige Live-Inventar, Repository-Remotes, Sichtbarkeit,
  Default-Branches, Profil- und Pfadregistry, Gate Sets, Budget und
  Ruleset-Semantik gemeinsam neu validiert werden.
- **SBR-002 – Autoritative Menge:** Die Zielmenge ist die live ermittelte
  Vereinigung aus `home-baseline` und allen aktiven
  `kind=git-repository`-Manifestzielen. Der aktuelle Wert `1 + 47 = 48` ist
  eine Baseline, keine hart codierte Erfolgsannahme. Collection-Knoten bleiben
  ausgeschlossen.
- **SBR-003 – Fail-closed Drift:** Fehlende, unbekannte, doppelte oder
  sichtbarkeitsinkompatible Zuordnungen, nicht auflösbare Remotes, unerwartete
  Default-Branches, schmutzige Arbeitsbäume, divergente lokale Branches und
  unvollständige Providerdaten stoppen vor der ersten betroffenen Mutation.
- **SBR-004 – Unveränderte Stage-A-Basis:** Die Stage-A-Verträge und
  historischen Snapshots bleiben unverändert. Stage B erhält eigene
  versionierte Zustands-, Rollout- und Evidence-Verträge.
- **SBR-005 – Ein resumierbarer Lauf:** Der Rollout wird durch genau einen
  autonomen Spec-Kit-Lauf orchestriert. Ein kontrollierter Stop und späteres
  Resume gehören zum selben Run und benötigen eine vollständige
  Zustandsrevalidierung.
- **SBR-006 – External-Write-Gate:** Unter `LocalImplementation` darf der Lauf
  nur planen, implementieren und lokal validieren. Vor dem ersten Commit,
  Push, PR, GitHub-Schreibzugriff, Merge oder Home-Sync muss er stoppen. Die
  Fortsetzung verlangt eine separate aktuelle `MergeAndSync`-Autorität.
- **SBR-007 – Rolloutfolge:** Nach einem flottenweiten Preflight werden die
  Repositories in dieser Reihenfolge verarbeitet: (1) Public Canaries
  `home-baseline`, `agent-operations-cockpit`, `tui-vision`; (2) Public
  Products; (3) Private Products; (4) Private Governance/Scaffold; (5) Public
  Presets. Innerhalb einer Welle gilt die lexikografische Repository-ID.
- **SBR-008 – Wellengate:** Die nächste Welle beginnt erst, wenn jedes Ziel der
  aktuellen Welle gemergt und synchronisiert oder als überprüfter No-op
  konvergent ist. Teilkonvergenz ist kein Wellenerfolg.
- **SBR-009 – Exakte Zieländerung:** Für jedes Ziel wird der Stage-A-Plan gegen
  den aktuellen Zustand neu berechnet. Nur der daraus folgende exakte Diff
  darf in einen Ziel-Commit gelangen; fremde lokale Änderungen werden weder
  übernommen noch verworfen.
- **SBR-010 – Profilvertrag:** Public Canaries und Public Products behalten
  erforderliche öffentliche CI. Private Products erhalten pfadabhängige
  Produktprüfungen ohne unbegründeten identischen Main-Rebuild. Private
  Governance/Scaffold erhält genau einen schlanken pfadabhängigen PR-Minimal-
  Gate und keine automatischen vollständigen PR-/Main-Builds. Public Presets
  erhalten keine neuen repositoriespezifischen Workflows.
- **SBR-011 – Serverseitige Sicherheitsgrenze:** Wo der private Governance-
  Vertrag gilt, verlangt der Default Branch einen Pull Request und exakt den
  erfolgreichen Status `home-baseline/ci-minimal-gate`. Direkte, Web- und
  API-Schreibpfade bleiben gesperrt. Ein lokaler Hook ersetzt diese Grenze
  nicht.
- **SBR-012 – Regulärer PR-Pfad:** Jeder nichtleere Ziel-Diff erhält einen
  eigenen Branch und Pull Request. Vor dem Merge müssen alle erforderlichen
  lokalen und entfernten Gates sowie die reguläre Reviewpflicht erfüllt sein.
- **SBR-013 – Kein impliziter Bypass:** Eine frühere oder allgemeine
  Admin-Berechtigung darf nicht wiederverwendet werden. Ist ein Bypass nötig,
  stoppt der Lauf und verlangt eine neue, ziel- und zeitgebundene Autorität.
- **SBR-014 – Stop und Resume:** Beim ersten nicht behebbaren Gate-, Review-,
  Push-, Ruleset- oder Mergefehler stoppt der Lauf. Bereits gemergte Ziele
  bleiben bestehen. Ein Resume inventarisiert die Gesamtflotte neu, bestätigt
  bereits konvergierte Ziele und beginnt beim ersten nicht konvergierten Ziel.
- **SBR-015 – Idempotenz:** Ein Lauf oder Resume darf für ein bereits
  konvergiertes Ziel keinen leeren oder semantisch identischen PR erzeugen.
  No-op-Ziele erhalten einen hash- und zeitgebundenen Nachweis.
- **SBR-016 – Provider-Schreibgrenze:** GitHub-Schreibzugriffe verwenden
  validierte Repository- und Ruleset-IDs, sichere Argumentlisten, begrenzte
  Retries und fail-closed Fehlerbehandlung. Secrets, Tokens, private Pfade und
  unbereinigte Providerantworten dürfen nicht in Evidence gelangen.
- **SBR-017 – Plattformparität:** Level-0-Steuerung und Validatoren müssen auf
  macOS/Linux über Bash und auf Windows über PowerShell 7 dieselben fachlichen
  Entscheidungen, Exitcodes und Evidence-Felder liefern.
- **SBR-018 – Barrierefreiheit:** CLI-Ausgaben und Dokumentation bleiben
  textorientiert, tastatur- und screenreadergeeignet, deutsch zuerst und
  englisch danach. Status, Blocker, Entscheidung und nächste Aktion werden nie
  allein durch Farbe oder Position vermittelt.
- **SBR-019 – Budgeterhalt:** Nach jeder Welle wird die wiederkehrende
  Actions-Projektion neu berechnet. Die geplante private Nutzung bleibt unter
  500 von 3.000 Minuten pro Monat; Copilot-Verbrauch bleibt getrennt.
- **SBR-020 – Home-Sync-Grenze:** Home-Sync ist nur erforderlich, wenn eine
  manifestgebundene `homeRuntime`-Fläche geändert wurde. Reine Source-,
  Evidence- oder Zielrepository-Änderungen lösen keinen unbegründeten
  Home-Sync aus.
- **SBR-021 – Terminale Konvergenz:** Abschluss verlangt pro Repository den
  überprüften Ziel-HEAD, PR- oder No-op-Identität, Gateergebnis, Reviewstatus,
  Merge-Commit, Default-Branch-Synchronisierung und eine abschließende
  read-only Providerprüfung.
- **SBR-022 – G4-Sperre:** Der Lauf darf G4 nicht starten oder dessen
  Konfiguration ändern. Er liefert nur die Stage-B-Konvergenz-Evidence für ein
  späteres separates Sequencing-Gate.
- **SBR-023 – Serien-Follow-up:** Nach erfolgreichem Intake Review muss die
  aktive Serie in einem getrennt autorisierten Serien-Update von G3 → G4 auf
  G3 → Stage B → G4 umgestellt und der umbenannte G3-Zielpfad reconciled
  werden. Dieses Intake führt das Update nicht aus.
- **SBR-024 – Abschlussmodus:** Fachlicher Abschluss ist `MergeAndSync` über
  alle erforderlichen Level-0- und Ziel-PRs. `PublishPR` oder verbleibende
  Teilkonvergenz halten Stage B und damit G4 blockiert.

### 7. Qualitäts- und Governance-Grenzen

Security-, Architecture-, iSAQB-, A11Y-, Cross-Platform-, Agent-Parity-, Model-
Routing-, Intake- und Autonomous-Run-Governance bleiben anwendbar. Der Plan
muss die aktuelle Level-2 Environment Registry je Ziel berücksichtigen und bei
nicht speichersicheren Primärsprachen die dokumentierte Begründung erhalten.
Secure-Coding-, Dependency-, Secret-Scan-, Branch-Protection- und Supply-Chain-
Nachweise dürfen durch die Budgetoptimierung nicht geschwächt werden.

Jede technische Änderung erhält genau eine Documentation-Impact-Entscheidung.
Nicht triviale neue Orchestrierungslogik wird auf erklärende Inline-Kommentare
für Gründe, Trade-offs und Sicherheitsgrenzen geprüft.

### 8. Abhängigkeiten, Risiken und Stop-Grenzen

- **Vorgänger:** Feature 029 muss terminal und seine PostMerge-Evidence gültig
  sein.
- **Serienabhängigkeit:** Die spätere Serienänderung ist nötig, bevor Stage B
  als bindender Vorgänger von G4 gelten kann.
- **Risiko Teilkonvergenz:** Ein Stop kann eine gemischte Flotte hinterlassen.
  Der Run-State muss diesen Zustand vollständig und resumierbar ausweisen; G4
  bleibt blockiert.
- **Risiko Ruleset-Sperre:** Eine falsche Serverregel kann Maintainer
  aussperren. Der Lauf prüft Ziel-ID, Default Branch, vorhandene Regeln und
  Rückrollinformationen vor Aktivierung und verifiziert den Zugriff danach.
- **Risiko veralteter Plan:** Jede Inventar-, Registry-, Budget- oder
  Providerdrift entwertet den betroffenen Plan und erzwingt Neuberechnung.
- **Owner:** Fleet Delivery Owner. Reviewer: Security-, Architecture-,
  Cross-Platform- und Repository-Owner gemäß Zielprofil.

### 9. Erwartete Artefakte und Evidence

Der spätere Feature-Lauf liefert mindestens:

- einen versionierten Stage-B-Run-State mit Welle, Repository und
  Resume-Grenze;
- einen getrennten Stage-B-Rollout-/Evidence-Vertrag, ohne historische
  Stage-A-Schemas umzudeuten;
- einen vor Mutation fixierten Gesamtplan und je Ziel einen exakten Diff;
- eine redigierte PR-, Gate-, Review-, Merge-, Ruleset- und Sync-Evidence;
- ein No-op-Ledger für bereits konvergierte Ziele;
- eine Kostenprojektion nach jeder Welle und einen terminalen Flottenbericht;
- Documentation-Impact-, Security-, A11Y-, Plattform- und Statistiknachweise;
- einen G4-Handoff, der keine G4-Ausführung oder Serienänderung vornimmt.

### 10. Messbare Abnahme

- **AC-SBR-001:** Der vollständige Preflight weist exakt dieselbe dynamische
  Repository-ID-Menge in Manifest, Assignment, Inventory und Rolloutplan nach;
  aktuell erwartet `1 + 47 = 48`.
- **AC-SBR-002:** Unbekannte, fehlende, doppelte oder inkompatible Zuordnungen
  sowie schmutzige oder divergente Zielzustände blockieren vor Mutation.
- **AC-SBR-003:** Die drei Public Canaries sind vollständig konvergent, bevor
  die erste Profilwelle beginnt.
- **AC-SBR-004:** Die vier folgenden Profilwellen laufen in festgelegter
  Reihenfolge; innerhalb jeder Welle entspricht die Reihenfolge der sortierten
  Repository-ID-Liste.
- **AC-SBR-005:** Für 100 % der nichtleeren Ziel-Diffs existieren exakter
  Branch, Commit, PR, erfolgreiche Pflichtgates, reguläre Reviewfreigabe,
  Merge-Commit und synchronisierter Default Branch.
- **AC-SBR-006:** Für 100 % der leeren Ziel-Diffs existiert ein gültiger
  No-op-Nachweis; kein leerer PR wurde erzeugt.
- **AC-SBR-007:** Private Governance/Scaffold besitzt genau den erforderlichen
  Minimal-Gate- und Default-Branch-Schutzvertrag; direkter, Web- und API-Bypass
  bleibt gesperrt.
- **AC-SBR-008:** Ein injizierter Fehler stoppt vor dem nächsten Ziel. Ein
  Resume bewahrt gemergte Erfolge, revalidiert die Flotte und erzeugt keine
  doppelten PRs.
- **AC-SBR-009:** Bash-/PowerShell-Parität, Secret Scan, Security-, A11Y-,
  Dokumentations-, Statistik- und betroffene Regressionstests sind grün.
- **AC-SBR-010:** Die wiederkehrende private Actions-Projektion bleibt unter
  500 von 3.000 Minuten pro Monat; Copilot-Kategorien sind getrennt.
- **AC-SBR-011:** Terminale Stage-B-Evidence weist alle autoritativen
  Repositories als geprüft konvergent aus und enthält keine Secrets oder
  privaten lokalen Pfade.
- **AC-SBR-012:** G4, Copilot-Konfiguration, Account- und Abonnementzustand sind
  unverändert; der nächste Schritt ist ausschließlich ein separates
  Sequencing-Gate beziehungsweise Serien-Update.

### 11. Annahmen und offene Fragen

- `Stage BN` aus dem Auftrag bedeutet `Stage B`.
- Der aktuelle Wert von 47 Zielrepositories wird vor Ausführung live geprüft
  und nicht festgeschrieben.
- `MergeAndSync` ist die spätere fachliche Abschlussgrenze, aber dieses Intake
  und seine Prompts erteilen keine Remote- oder Bypass-Autorität.
- Alle materiellen Entscheidungen sind beantwortet. Es bestehen keine offenen
  Intake-Authoring-Entscheidungen.

## English Contract Summary

This intake defines a separate, resumable Stage-B rollout between completed G3
and G4. One autonomous Spec Kit run first performs a complete fail-closed
preflight, then pauses at the external-write boundary until fresh
`MergeAndSync` authority exists. It processes the three Public Canaries before
ordered Public Product, Private Product, Private Governance/Scaffold, and
Public Preset waves. Repositories are handled serially by stable ID. A failed
gate stops the run; a later resume revalidates the full fleet and preserves
already merged targets.

Every non-empty change uses a dedicated branch, exact commit, pull request,
required checks, normal review, merge, and default-branch synchronization.
No-op targets receive evidence instead of empty pull requests. Stage B uses a
separate evidence contract and never rewrites historical Stage-A semantics.
Copilot, account, subscription, G4, and implicit admin-bypass changes remain
out of scope. G4 stays blocked until every authoritative repository has proven
remote convergence and a separate sequencing update has inserted Stage B
between G3 and G4.

<!-- intake-authoring:prompts -->
## Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Flottenweite-CI-Budget-Governance-Stage-B-Rollout.md` as the binding Stage-B intake after completed G3 and before G4. Specify the dynamic authoritative fleet preflight, separate Stage-B state and evidence contracts, external-write gate, three Public Canaries, ordered profile waves, exact per-repository diff and PR lifecycle, regular review and merge requirements, private minimal-gate and ruleset deployment, verified no-op handling, budget preservation, fail-closed stop and resumable continuation, terminal remote convergence, security, A11Y, platform parity, documentation impact, and the separate G4 sequencing handoff. Preserve SBR-001 through SBR-024 and AC-SBR-001 through AC-SBR-012. Do not implement, mutate a repository or GitHub, update the intake series, start G4, commit, push, merge, sync Home, or use an admin bypass.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete reviewed Spec Kit feature for `Lastenheft_Flottenweite-CI-Budget-Governance-Stage-B-Rollout.md` with deliveryAuthority=LocalImplementation. Implement and validate the Stage-B orchestration, contracts, fixtures, documentation, statistics, exact fleet preflight, rollout plan, and resumable state locally, then stop at the ExternalWriteGate before the first remote mutation. Resume this same run only after a separate current deliveryAuthority=MergeAndSync authorization. After revalidation, execute the Public Canary and ordered profile waves serially, stop on the first non-recoverable failure, preserve already merged targets, prove PR/gate/review/merge/default-branch or no-op convergence for every repository, and finish with terminal Stage-B evidence. Do not infer admin-bypass authority, modify Copilot, account or subscription settings, update the intake series, or start G4.
```

<!-- intake-authoring:end -->
