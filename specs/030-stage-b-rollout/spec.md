# Feature-Spezifikation: Flottenweiter Stage-B-Rollout / Feature Specification: Fleet-Wide Stage-B Rollout

**Feature Branch**: `030-stage-b-rollout`
**Created / Erstellt**: 2026-08-21
**Status**: Draft / Entwurf
**Input / Eingabe**: Bindendes, mit `Ready` bewertetes Lastenheft `Lastenheft_Flottenweite-CI-Budget-Governance-Stage-B-Rollout.md`
**Delivery Mode / Liefermodus**: `MergeAndSync` mit ausdrücklich autorisiertem Admin-Bypass als Ausnahmeweg / with explicitly authorized admin bypass as an exception path
**Audience / Zielgruppe**: Fleet Delivery Owner, Maintainer, Repository-Verantwortliche und Reviewer
**Prior Knowledge / Vorwissen**: Grundlegende Git-, GitHub-Actions- und Pull-Request-Kenntnisse; keine Spec-Kit-Erfahrung
**Language and Accessibility / Sprache und Barrierefreiheit**: Deutsch zuerst, Englisch danach; CEFR B2; WCAG 2.2 AA, soweit anwendbar; textorientierte Darstellung

## Nutzungsszenarien und Tests / User Scenarios & Testing *(mandatory)*

### User Story 1 - Flotte vor jeder Mutation vollständig prüfen / Validate the Fleet Before Every Mutation (Priority: P1)

Als Fleet Delivery Owner möchte ich G3-Abschluss, aktuelle Level-0-Quelle,
Live-Inventar, Remotes, Sichtbarkeit, Default Branches, Profile, Pfadverträge,
Gate Sets, Budget und Ruleset-Semantik gemeinsam prüfen, damit kein Ziel auf
Grund veralteter oder widersprüchlicher Daten verändert wird.

*As Fleet Delivery Owner, I want G3 completion, the current Level-0 source,
live inventory, remotes, visibility, default branches, profiles, path
contracts, gate sets, budget, and ruleset semantics validated together so that
no target is changed from stale or contradictory data.*

**Why this priority / Warum diese Priorität**: Der Gesamt-Preflight ist die
Sicherheits- und Korrektheitsgrenze vor dem ersten externen Schreibzugriff.

**Independent Test / Unabhängiger Test**: Gültige und absichtlich driftende
Inventar-, Registry-, Remote-, Branch-, Budget- und Provider-Fixtures werden
ohne Mutation ausgewertet. Nur der vollständig gültige Fall erzeugt einen
fixierten Rolloutplan; jeder Negativfall stoppt vorher.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** G3 ist terminal abgeschlossen und alle aktuellen Quellen stimmen überein, **When / Wenn** der Gesamt-Preflight läuft, **Then / Dann** enthalten Manifest, Assignment, Inventory und Rolloutplan exakt dieselbe dynamisch ermittelte Repository-ID-Menge; der aktuelle Wert `1 + 47 = 48` ist nur ein revalidierter Snapshot.
2. **Given / Angenommen** eine Zuordnung ist unbekannt, fehlt, ist doppelt oder sichtbarkeitsinkompatibel, **When / Wenn** der Preflight läuft, **Then / Dann** stoppt er vor der ersten Mutation und nennt Blocker sowie nächste sichere Aktion.
3. **Given / Angenommen** ein Remote, Default Branch oder Providerdatensatz ist nicht eindeutig auflösbar oder ein Arbeitsbaum ist schmutzig beziehungsweise divergent, **When / Wenn** das betroffene Ziel geprüft wird, **Then / Dann** findet keine Zielmutation statt.
4. **Given / Angenommen** der Preflight ist erfolgreich, **When / Wenn** der Rolloutplan fixiert wird, **Then / Dann** bindet er Eingabehashes, dynamische Zielmenge, genaue Wellenreihenfolge und den ersten zulässigen Mutationspunkt.

---

### User Story 2 - Canaries und Profilwellen geordnet konvergieren / Converge Canaries and Profile Waves in Order (Priority: P1)

Als Repository-Verantwortliche*r möchte ich, dass zuerst die drei öffentlichen
Canaries und danach vier klar getrennte Profilwellen verarbeitet werden,
damit Fehler einen kleinen Radius behalten und Teilkonvergenz nicht als
Wellenerfolg gilt.

*As a repository owner, I want the three public canaries processed first and
then four clearly separated profile waves so that failures keep a small blast
radius and partial convergence is never reported as wave success.*

**Why this priority / Warum diese Priorität**: Canary- und Wellengates begrenzen
das Risiko eines flottenweiten Workflow- oder Ruleset-Fehlers.

**Independent Test / Unabhängiger Test**: Eine vollständige Fixture-Flotte mit
gemischten Profilen wird mehrfach verarbeitet. Die beobachtete Reihenfolge
muss stets Public Canaries, Public Products, Private Products, Private
Governance/Scaffold und Public Presets entsprechen; innerhalb jeder Welle gilt
die lexikografische Repository-ID.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** der Preflight ist gültig, **When / Wenn** die Canary-Welle beginnt, **Then / Dann** werden ausschließlich `home-baseline`, `agent-operations-cockpit` und `tui-vision` verarbeitet und vollständig konvergent nachgewiesen.
2. **Given / Angenommen** mindestens ein Canary ist weder gemergt und synchronisiert noch als No-op konvergent, **When / Wenn** die erste Profilwelle angefordert wird, **Then / Dann** bleibt sie blockiert.
3. **Given / Angenommen** alle Canaries sind konvergent, **When / Wenn** die Profilwellen laufen, **Then / Dann** folgen Public Products, Private Products, Private Governance/Scaffold und Public Presets in dieser Reihenfolge und je Welle lexikografisch nach stabiler Repository-ID.
4. **Given / Angenommen** ein Ziel einer Welle scheitert, **When / Wenn** das Wellengate bewertet wird, **Then / Dann** startet kein späteres Ziel und keine spätere Welle.

---

### User Story 3 - Exakte Änderungen regulär liefern / Deliver Exact Changes Through the Regular Path (Priority: P1)

Als Maintainer möchte ich für jeden nichtleeren Zieldiff einen eigenen Branch,
exakten Commit, Pull Request, erfolgreiche Pflichtgates, reguläre Review,
Merge und Default-Branch-Synchronisierung erhalten, damit Budgetoptimierung
weder fremde Änderungen übernimmt noch Sicherheits- oder Reviewgrenzen
abschwächt.

*As a maintainer, I want every non-empty target diff delivered through its own
branch, exact commit, pull request, successful mandatory gates, regular review,
merge, and default-branch synchronization so that budget optimization neither
captures unrelated work nor weakens security or review boundaries.*

**Why this priority / Warum diese Priorität**: Der reguläre Pull-Request-Pfad
ist der fachliche Normalweg und liefert die notwendige Auditierbarkeit.

**Independent Test / Unabhängiger Test**: Ein isoliertes Ziel mit einem
bekannten exakten Diff wird bis zur simulierten beziehungsweise autorisierten
Remote-Konvergenz verfolgt. Fremde Dateien, fehlende Gates, fehlende Review,
abweichende Commits und nicht synchronisierte Default Branches müssen die
Abnahme blockieren.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** der neu berechnete Stage-B-Plan enthält einen nichtleeren Diff, **When / Wenn** das Ziel geliefert wird, **Then / Dann** enthält der Ziel-Commit ausschließlich diesen Diff und keine fremde lokale Änderung.
2. **Given / Angenommen** ein Pull Request ist geöffnet, **When / Wenn** ein Pflichtgate oder die reguläre Review fehlt, **Then / Dann** darf kein erfolgreicher Merge- oder Konvergenzstatus entstehen.
3. **Given / Angenommen** ein Private-Governance-/Scaffold-Ziel gilt, **When / Wenn** Workflow und Ruleset aktiviert werden, **Then / Dann** verlangt der Default Branch einen Pull Request und exakt den erfolgreichen Status `home-baseline/ci-minimal-gate`; direkte, Web- und API-Schreibpfade bleiben gesperrt.
4. **Given / Angenommen** der reguläre Pfad ist vollständig erfolgreich, **When / Wenn** der Merge erfolgt, **Then / Dann** wird der passende Default Branch lokal und remote synchronisiert und anschließend read-only verifiziert.
5. **Given / Angenommen** ein Admin-Bypass ist ausnahmsweise erforderlich, **When / Wenn** die aktuelle ausdrückliche Autorität genutzt wird, **Then / Dann** bleibt die Nutzung ziel- und zeitgebunden, begründet und vollständig belegt; Acceptance-, Security-, Review- und Gate-Evidence muss unabhängig bereits vollständig sein.

---

### User Story 4 - No-op, Stop und Resume sicher behandeln / Handle No-op, Stop, and Resume Safely (Priority: P1)

Als Operator*in möchte ich bei leeren Diffs einen geprüften No-op-Nachweis und
bei Fehlern einen fail-closed Stop mit sicherem Resume erhalten, damit keine
leeren oder doppelten Pull Requests entstehen und bereits gemergte Erfolge
erhalten bleiben.

*As an operator, I want verified no-op evidence for empty diffs and a
fail-closed stop with safe resume after failures so that no empty or duplicate
pull requests are created and already merged successes are preserved.*

**Why this priority / Warum diese Priorität**: Ein flottenweiter Remote-Rollout
kann teilweise konvergieren; sein Zustand muss jederzeit korrekt und
fortsetzbar bleiben.

**Independent Test / Unabhängiger Test**: Ein Fehler wird nach einem bereits
konvergierten Ziel injiziert. Das Resume revalidiert die gesamte Flotte,
bestätigt den bisherigen Erfolg und beginnt genau beim ersten nicht
konvergierten Ziel, ohne einen zweiten Pull Request zu erzeugen.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** ein neu berechneter Zieldiff ist leer, **When / Wenn** das Ziel bewertet wird, **Then / Dann** entsteht hash- und zeitgebundene No-op-Evidence und kein Branch, Commit oder Pull Request.
2. **Given / Angenommen** ein Gate-, Review-, Push-, Ruleset- oder Mergefehler ist nicht behebbar, **When / Wenn** er auftritt, **Then / Dann** stoppt der Lauf vor dem nächsten Ziel und speichert Welle, Ziel, letzte sichere Grenze, Blocker und nächste Aktion.
3. **Given / Angenommen** bereits gemergte Ziele existieren, **When / Wenn** der Lauf fortgesetzt wird, **Then / Dann** werden sie read-only neu bestätigt und weder zurückgerollt noch erneut geliefert.
4. **Given / Angenommen** Inventar, Registry, Budget, Authority oder Providerzustand ist seit dem Stop gedriftet, **When / Wenn** Resume revalidiert, **Then / Dann** wird der betroffene Plan neu berechnet oder der Lauf bleibt blockiert.

---

### User Story 5 - Budget und terminale Konvergenz beweisen / Prove Budget and Terminal Convergence (Priority: P2)

Als Reviewer möchte ich nach jeder Welle eine getrennte Kostenprojektion und
am Ende einen vollständigen flottenweiten Konvergenzbericht sehen, damit der
Rollout das CI-Budget bewahrt und G4 erst auf belastbarer Evidence aufbauen
kann.

*As a reviewer, I want a separate cost projection after every wave and a
complete fleet convergence report at the end so that the rollout preserves the
CI budget and G4 can only build on reliable evidence.*

**Why this priority / Warum diese Priorität**: Remote-Erfolg ohne Budget- und
Zielvollständigkeitsnachweis erfüllt den Stage-B-Zweck nicht.

**Independent Test / Unabhängiger Test**: Ein gemischtes Ledger aus
PR- und No-op-Zielen wird gegen die dynamische autoritative Menge geprüft. Der
terminale Bericht darf nur bestehen, wenn jede ID genau einmal konvergent ist,
alle Evidence-Felder vollständig sind und die private Actions-Projektion unter
dem Grenzwert bleibt.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** eine Welle ist vollständig konvergent, **When / Wenn** das Wellengate schließt, **Then / Dann** wird die wiederkehrende private Actions-Projektion neu berechnet und bleibt unter 500 von 3.000 Minuten pro Monat; Copilot-Verbrauch bleibt getrennt.
2. **Given / Angenommen** alle Wellen sind abgeschlossen, **When / Wenn** terminale Evidence erzeugt wird, **Then / Dann** besitzt jedes autoritative Repository Ziel-HEAD, PR- oder No-op-Identität, Gateergebnis, Reviewstatus, Merge-Commit oder begründetes `N/A`, Default-Branch-Synchronisierung und abschließende read-only Providerprüfung.
3. **Given / Angenommen** ein Ziel- oder Evidence-Feld fehlt, **When / Wenn** der Abschluss bewertet wird, **Then / Dann** bleiben Stage B und G4 blockiert.
4. **Given / Angenommen** terminale Konvergenz ist vollständig, **When / Wenn** der G4-Handoff geschrieben wird, **Then / Dann** enthält er nur Evidence und die nächste getrennte Sequencing-Aktion; er startet G4 nicht.

---

### User Story 6 - Plattformgleich, barrierearm und nachvollziehbar arbeiten / Work with Platform Parity, Accessibility, and Traceability (Priority: P2)

Als Nutzer*in unter macOS, Linux oder Windows möchte ich dieselben fachlichen
Entscheidungen, Exitcodes, Evidence-Felder und verständlichen Statusangaben
erhalten, damit Plattform oder assistive Technologie die Aussage des Rollouts
nicht verändert.

*As a user on macOS, Linux, or Windows, I want the same business decisions,
exit codes, evidence fields, and understandable status information so that the
platform or assistive technology does not change the rollout meaning.*

**Why this priority / Warum diese Priorität**: Plattform- und
Barrierefreiheitsparität sind verbindliche Abnahmekriterien für die
Level-0-Orchestrierung.

**Independent Test / Unabhängiger Test**: Gemeinsame positive und negative
Fixtures werden über Bash und PowerShell ausgewertet. Normalisierte
Entscheidungen und Evidence stimmen überein; die lineare Textausgabe bleibt
ohne Farbe oder räumliche Bedeutung vollständig verständlich.

**Acceptance Scenarios / Abnahmeszenarien**:

1. **Given / Angenommen** identische Eingaben, **When / Wenn** Bash und PowerShell den Preflight, die Vorschau oder einen Resume-Schritt bewerten, **Then / Dann** stimmen Entscheidung, Exitcode, Evidence-Felder und nächste Aktion fachlich überein.
2. **Given / Angenommen** `--dry-run` oder `-WhatIf`, **When / Wenn** Stage B aufgerufen wird, **Then / Dann** werden Zielmenge, Reihenfolge, genaue geplante Änderungen, Provideraktionen und Evidence-Ziele angezeigt, aber weder Repository noch GitHub, Home Runtime oder Intake-Serie verändert.
3. **Given / Angenommen** Farbe, Unicode-Symbole oder Cursorposition fehlen, **When / Wenn** Ausgabe und Dokumentation linear gelesen werden, **Then / Dann** bleiben Welle, Repository, Status, Entscheidung, Blocker und nächste Aktion vollständig erkennbar.
4. **Given / Angenommen** die Implementierung ist abnahmebereit, **When / Wenn** Governance geprüft wird, **Then / Dann** sind Security-, Architecture-, iSAQB-, A11Y-, Plattform-, Agentenparitäts-, Dokumentations- und Statistiknachweise vollständig oder ausdrücklich mit begründetem `N/A` bewertet.

### Randfälle / Edge Cases

- Die dynamische Zielmenge ist nicht `48`; die gültige Live-Menge ersetzt den historischen Snapshot, ohne Collection-Knoten einzuschließen.
- G3-HEAD, PostMerge-Evidence oder terminaler Run-State ist nicht mehr belegbar; Stage B stoppt vor der ersten Mutation.
- Ein Repository ist archiviert, gelöscht, umbenannt, als Fork eingeschränkt oder seine Sichtbarkeit hat sich geändert; das Ziel wird nicht geraten oder automatisch umklassifiziert.
- Eine Remote-URL löst nicht zur erwarteten Repository-ID auf oder ein Repository besitzt mehrere widersprüchliche Remotes; die Zielmutation stoppt.
- Ein Arbeitsbaum enthält fremde Änderungen; sie werden weder gestaged noch verworfen und das Ziel bleibt blockiert.
- Default Branch, Ruleset-ID, Pull-Request-HEAD oder Pflichtstatus ändert sich zwischen Plan und Aktion; der veraltete Plan wird verworfen und neu berechnet.
- Ein Ziel ist semantisch konvergent, aber dateibyteweise anders; No-op darf nur nach fachlicher Vertragsprüfung behauptet werden.
- Ein Pull Request ist leer oder wird durch einen konkurrierenden Merge leer; er wird nicht als erfolgreiche Zieländerung weitergeführt.
- Ein Gate-Name ist grün, aber Workflow, Job, Runner, Plattform oder exakter Befehl stimmt nicht mit dem erwarteten Gate überein; der Nachweis gilt nicht.
- Ein Provider meldet Billing-/Quota-Ablehnung statt technischer Gateausführung; dies ist ein Blocker und weder ein fehlgeschlagenes noch ein bestandenes Gate.
- Eine Review stammt vom falschen Commit oder erfüllt die reguläre Pflicht nicht; ein Admin-Bypass darf sie nicht ersetzen.
- Die aktuelle Bypass-Autorität ist nach Stop, Scope-Drift oder Zielwechsel nicht mehr frisch; die Ausnahme bleibt blockiert, bis sie revalidiert ist.
- Ein Merge gelingt, aber lokale oder remote Default-Branch-Synchronisierung scheitert; das Ziel bleibt teilkonvergent und die Welle stoppt.
- Ein Resume findet einen bereits gemergten Pull Request mit unerwartetem Merge-Commit; der Zustand wird nicht stillschweigend übernommen.
- Ein bereits konvergiertes Ziel erhält durch Provider- oder Registrydrift einen neuen erforderlichen Diff; es wird wieder nicht konvergent und neu geplant.
- Die Budgetprojektion fehlt, ist veraltet oder vermischt Copilot-Kategorien; die nächste Welle startet nicht.
- Home-Runtime-Dateien wurden nicht geändert; ein Home-Sync wäre unbegründet und bleibt aus.
- Eine manifestgebundene `homeRuntime`-Fläche wurde geändert; Sync bleibt bis zur vorgesehenen Vorschau, Konfliktprüfung und autorisierten Post-Merge-Grenze gesperrt.
- Evidence enthält Token, Credential, unbereinigte Providerantwort, privaten lokalen Pfad oder unnötige Personendaten; Veröffentlichung und Abschluss blockieren.
- Ein optionales oder Pflichtfeld wird als Farbe, Symbol oder Tabellenposition ohne Text dargestellt; die A11Y-Abnahme schlägt fehl.
- Die Intake-Serie besitzt weiterhin G3 → G4; Stage B ändert sie nicht und meldet den getrennt autorisierten Follow-up statt einer stillen Mutation.
- Alle Ziele sind konvergent, aber G4 oder Copilot-/Accountkonfiguration wurde verändert; Stage-B-Abnahme schlägt fehl.

## Anforderungen / Requirements *(mandatory)*

### Funktionale Anforderungen / Functional Requirements

- **SBR-001 (FR-001) – Frischer Gesamt-Preflight / Fresh Full Preflight**: Vor jeder Zielmutation MÜSSEN aktueller Level-0-HEAD, terminaler G3-Run-State, G3-PostMerge-Evidence, vollständiges Live-Inventar, Remotes, Sichtbarkeit, Default Branches, Profil- und Pfadregistry, Gate Sets, Budget und Ruleset-Semantik gemeinsam neu validiert werden. Unvollständige oder veraltete Evidence DARF keine Mutation freigeben.
  *Before any target mutation, the current Level-0 HEAD, terminal G3 run state, G3 PostMerge evidence, complete live inventory, remotes, visibility, default branches, profile and path registries, gate sets, budget, and ruleset semantics MUST be revalidated together. Incomplete or stale evidence MUST NOT authorize mutation.*
- **SBR-002 (FR-002) – Autoritative Menge / Authoritative Set**: Die Zielmenge MUSS live als Vereinigung des Level-0-Self-Records `home-baseline` mit allen aktiven `kind=git-repository`-Manifestzielen ermittelt werden. Der aktuelle Wert `1 + 47 = 48` ist eine revalidierbare Baseline und DARF nicht hart codiert werden; Collection-Knoten bleiben ausgeschlossen.
  *The target set MUST be discovered live as the union of the Level-0 `home-baseline` self record and every active `kind=git-repository` manifest target. The current `1 + 47 = 48` value is a revalidated baseline and MUST NOT be hard-coded; collection nodes remain excluded.*
- **SBR-003 (FR-003) – Fail-closed Drift / Fail-Closed Drift**: Fehlende, unbekannte, doppelte oder sichtbarkeitsinkompatible Zuordnungen, nicht auflösbare Remotes, unerwartete Default Branches, schmutzige Arbeitsbäume, divergente lokale Branches und unvollständige Providerdaten MÜSSEN vor der ersten betroffenen Mutation stoppen.
  *Missing, unknown, duplicate, or visibility-incompatible assignments, unresolved remotes, unexpected default branches, dirty worktrees, divergent local branches, and incomplete provider data MUST stop before the first affected mutation.*
- **SBR-004 (FR-004) – Unveränderte Stage-A-Basis / Immutable Stage-A Baseline**: Stage-A-Verträge und historische Snapshots MÜSSEN unverändert bleiben. Stage B MUSS eigene versionierte Zustands-, Rollout- und Evidence-Verträge verwenden und DARF historische Stage-A-Semantik nicht umdeuten.
  *Stage-A contracts and historical snapshots MUST remain unchanged. Stage B MUST use separate versioned state, rollout, and evidence contracts and MUST NOT reinterpret historical Stage-A semantics.*
- **SBR-005 (FR-005) – Ein resumierbarer Lauf / One Resumable Run**: Genau ein autonomer Spec-Kit-Lauf MUSS den Rollout orchestrieren. Kontrollierter Stop und späteres Resume gehören zu derselben Run-ID und erfordern vor Fortsetzung eine vollständige Zustandsrevalidierung.
  *Exactly one autonomous Spec Kit run MUST orchestrate the rollout. A controlled stop and later resume belong to the same run ID and require complete state revalidation before continuation.*
- **SBR-006 (FR-006) – External-Write-Gate / External Write Gate**: Unter `LocalImplementation` DÜRFEN nur Planung, Implementierung und lokale Validierung erfolgen; vor Commit, Push, Pull Request, GitHub-Schreibzugriff, Merge oder Home-Sync MUSS der Lauf stoppen. Eine Fortsetzung verlangt aktuelle `MergeAndSync`-Autorität. Für diesen Run ist `MergeAndSync` ausdrücklich erteilt; die Specify-Phase selbst bleibt trotzdem auf `spec.md`, Qualitätscheckliste und maschinenlesbares Phasenergebnis begrenzt.
  *Under `LocalImplementation`, only planning, implementation, and local validation are allowed; the run MUST stop before commit, push, pull request, GitHub write, merge, or Home sync. Continuation requires current `MergeAndSync` authority. This run explicitly has `MergeAndSync`; the Specify phase itself nevertheless remains limited to the specification, quality checklist, and machine-readable phase result.*
- **SBR-007 (FR-007) – Rolloutfolge / Rollout Order**: Nach flottenweitem Preflight MUSS die Reihenfolge Public Canaries `home-baseline`, `agent-operations-cockpit`, `tui-vision`; Public Products; Private Products; Private Governance/Scaffold; Public Presets lauten. Innerhalb jeder Welle MUSS die lexikografische stabile Repository-ID gelten.
  *After the fleet-wide preflight, the order MUST be the Public Canaries `home-baseline`, `agent-operations-cockpit`, and `tui-vision`; Public Products; Private Products; Private Governance/Scaffold; and Public Presets. Stable repository IDs MUST be lexicographically ordered within each wave.*
- **SBR-008 (FR-008) – Wellengate / Wave Gate**: Eine nächste Welle DARF erst beginnen, wenn jedes Ziel der aktuellen Welle entweder gemergt und synchronisiert oder durch gültige No-op-Evidence als konvergent nachgewiesen ist. Teilkonvergenz DARF nicht als Wellenerfolg gelten.
  *A later wave MUST NOT start until every target in the current wave is either merged and synchronized or proven convergent by valid no-op evidence. Partial convergence MUST NOT count as wave success.*
- **SBR-009 (FR-009) – Exakte Zieländerung / Exact Target Change**: Der Stage-A-Plan MUSS für jedes Ziel gegen den aktuellen Zustand neu berechnet werden. Nur der daraus folgende exakte Diff DARF in den Ziel-Commit gelangen; fremde lokale Änderungen DÜRFEN weder übernommen noch verworfen werden.
  *The Stage-A plan MUST be recomputed for each target against current state. Only the resulting exact diff MAY enter the target commit; unrelated local changes MUST be neither captured nor discarded.*
- **SBR-010 (FR-010) – Profilvertrag / Profile Contract**: Public Canaries und Public Products MÜSSEN erforderliche öffentliche CI bewahren. Private Products MÜSSEN pfadabhängige Produktprüfungen ohne unbegründeten identischen Main-Rebuild erhalten. Private Governance/Scaffold MUSS genau einen schlanken pfadabhängigen PR-Minimal-Gate und keine automatischen vollständigen PR-/Main-Builds erhalten. Public Presets DÜRFEN keine neuen repositoriespezifischen Workflows erhalten.
  *Public Canaries and Public Products MUST preserve required public CI. Private Products MUST receive path-aware product checks without an unjustified identical main rebuild. Private Governance/Scaffold MUST receive exactly one lean path-aware PR minimal gate and no automatic full PR/main builds. Public Presets MUST NOT receive new repository-specific workflows.*
- **SBR-011 (FR-011) – Serverseitige Sicherheitsgrenze / Server-Side Security Boundary**: Für Private Governance/Scaffold MUSS der Default Branch einen Pull Request und exakt den erfolgreichen Status `home-baseline/ci-minimal-gate` verlangen. Direkte, Web- und API-Schreibpfade MÜSSEN gesperrt bleiben; ein lokaler Hook DARF diese unabhängige Grenze nicht ersetzen.
  *For Private Governance/Scaffold, the default branch MUST require a pull request and exactly the successful `home-baseline/ci-minimal-gate` status. Direct, web, and API write paths MUST remain blocked; a local hook MUST NOT replace this independent boundary.*
- **SBR-012 (FR-012) – Regulärer PR-Pfad / Regular PR Path**: Jeder nichtleere Ziel-Diff MUSS einen eigenen Branch und Pull Request erhalten. Vor Merge MÜSSEN alle erforderlichen lokalen und entfernten Gates sowie die reguläre Reviewpflicht erfüllt und an den exakten Kandidaten gebunden sein.
  *Every non-empty target diff MUST receive its own branch and pull request. Before merge, all required local and remote gates and the regular review requirement MUST be fulfilled and bound to the exact candidate.*
- **SBR-013 (FR-013) – Kein impliziter Bypass / No Implicit Bypass**: Frühere oder allgemeine Admin-Berechtigung DARF nicht wiederverwendet werden. Die aktuelle ausdrückliche Bypass-Autorität gilt ausschließlich als Ausnahme innerhalb dieses Runs; jede tatsächliche Nutzung MUSS vor der Aktion an Ziel, Zeitpunkt, Grund und Scope gebunden werden. Fehlende Frische oder Scope-Drift MUSS stoppen und neue ausdrückliche Autorität verlangen. Der Bypass DARF fehlende Acceptance-, Security-, Review- oder Gate-Evidence niemals ersetzen.
  *Earlier or general administrator permission MUST NOT be reused. The current explicit bypass authority applies only as an exception within this run; every actual use MUST be bound before action to the target, time, reason, and scope. Missing freshness or scope drift MUST stop and require new explicit authority. The bypass MUST never replace missing acceptance, security, review, or gate evidence.*
- **SBR-014 (FR-014) – Stop und Resume / Stop and Resume**: Beim ersten nicht behebbaren Gate-, Review-, Push-, Ruleset- oder Mergefehler MUSS der Lauf vor dem nächsten Ziel stoppen. Bereits gemergte Ziele bleiben bestehen. Resume MUSS die Gesamtflotte neu inventarisieren, frühere Konvergenz bestätigen und beim ersten nicht konvergierten Ziel beginnen.
  *At the first non-recoverable gate, review, push, ruleset, or merge failure, the run MUST stop before the next target. Already merged targets remain. Resume MUST re-inventory the full fleet, confirm previous convergence, and start at the first non-converged target.*
- **SBR-015 (FR-015) – Idempotenz / Idempotency**: Ein Lauf oder Resume DARF für ein bereits konvergiertes Ziel keinen leeren oder semantisch identischen Pull Request erzeugen. No-op-Ziele MÜSSEN einen hash- und zeitgebundenen Nachweis erhalten.
  *A run or resume MUST NOT create an empty or semantically identical pull request for an already converged target. No-op targets MUST receive hash- and time-bound evidence.*
- **SBR-016 (FR-016) – Provider-Schreibgrenze / Provider Write Boundary**: GitHub-Schreibzugriffe MÜSSEN validierte Repository- und Ruleset-IDs, sichere Argumentlisten, begrenzte Retries und fail-closed Fehlerbehandlung verwenden. Secrets, Tokens, private Pfade und unbereinigte Providerantworten DÜRFEN nicht in Evidence gelangen. Provider-/Billing-Ablehnung, technischer Gatefehler und bestandener Gate MÜSSEN getrennte Zustände bleiben.
  *GitHub writes MUST use validated repository and ruleset IDs, safe argument lists, bounded retries, and fail-closed error handling. Secrets, tokens, private paths, and unsanitized provider responses MUST NOT enter evidence. Provider or billing refusal, technical gate failure, and a passed gate MUST remain distinct states.*
- **SBR-017 (FR-017) – Plattformparität / Platform Parity**: Level-0-Steuerung und betroffene Validatoren MÜSSEN auf macOS/Linux über Bash und auf Windows über PowerShell 7 dieselben fachlichen Entscheidungen, Exitcodes und Evidence-Felder liefern.
  *Level-0 orchestration and affected validators MUST deliver the same business decisions, exit codes, and evidence fields through Bash on macOS/Linux and PowerShell 7 on Windows.*
- **SBR-018 (FR-018) – Barrierefreiheit / Accessibility**: CLI-Ausgaben und Dokumentation MÜSSEN textorientiert, tastatur- und screenreadergeeignet, Deutsch zuerst und Englisch danach sein. Status, Blocker, Entscheidung und nächste Aktion DÜRFEN nie allein durch Farbe oder Position vermittelt werden.
  *CLI output and documentation MUST be text-oriented, keyboard- and screen-reader-usable, German first and English second. Status, blocker, decision, and next action MUST never be conveyed by color or position alone.*
- **SBR-019 (FR-019) – Budgeterhalt / Budget Preservation**: Nach jeder Welle MUSS die wiederkehrende private Actions-Projektion neu berechnet werden. Sie MUSS unter 500 von 3.000 Minuten pro Monat bleiben; Copilot-Verbrauch MUSS getrennt bleiben und fehlende Daten DÜRFEN nicht als null gewertet werden.
  *After each wave, the recurring private Actions projection MUST be recomputed. It MUST remain below 500 of 3,000 minutes per month; Copilot consumption MUST remain separate and missing data MUST NOT be treated as zero.*
- **SBR-020 (FR-020) – Home-Sync-Grenze / Home Sync Boundary**: Home-Sync ist nur erforderlich, wenn eine manifestgebundene `homeRuntime`-Fläche geändert wurde. Reine Source-, Evidence- oder Zielrepository-Änderungen DÜRFEN keinen unbegründeten Home-Sync auslösen. Jeder erforderliche Sync MUSS nach Vorschau, Konfliktprüfung, Merge und erneuter Autoritätsprüfung erfolgen.
  *Home sync is required only when a manifest-bound `homeRuntime` surface changed. Source-only, evidence-only, or target-repository changes MUST NOT trigger an unjustified Home sync. Any required sync MUST occur after preview, conflict review, merge, and authority revalidation.*
- **SBR-021 (FR-021) – Terminale Konvergenz / Terminal Convergence**: Abschluss MUSS pro Repository den überprüften Ziel-HEAD, PR- oder No-op-Identität, Gateergebnis, Reviewstatus, Merge-Commit oder begründetes `N/A`, Default-Branch-Synchronisierung und eine abschließende read-only Providerprüfung nachweisen.
  *Completion MUST prove for every repository the verified target HEAD, pull-request or no-op identity, gate result, review status, merge commit or justified `N/A`, default-branch synchronization, and a final read-only provider check.*
- **SBR-022 (FR-022) – G4-Sperre / G4 Block**: Der Lauf DARF G4 weder starten noch konfigurieren. Er DARF ausschließlich Stage-B-Konvergenz-Evidence für ein späteres getrenntes Sequencing-Gate liefern. Copilot-, Account- und Abonnementzustände MÜSSEN unverändert bleiben.
  *The run MUST neither start nor configure G4. It MAY only provide Stage-B convergence evidence for a later separate sequencing gate. Copilot, account, and subscription state MUST remain unchanged.*
- **SBR-023 (FR-023) – Serien-Follow-up / Series Follow-up**: Die aktive Serie MUSS später durch ein getrennt autorisiertes Serien-Update von G3 → G4 auf G3 → Stage B → G4 umgestellt und der umbenannte G3-Zielpfad reconciled werden. Dieses Feature DARF die Intake-Serie nicht ändern.
  *The active series MUST later be changed by a separately authorized series update from G3 → G4 to G3 → Stage B → G4, and the renamed G3 target path must be reconciled. This feature MUST NOT change the intake series.*
- **SBR-024 (FR-024) – Abschlussmodus / Completion Mode**: Fachlicher Abschluss MUSS `MergeAndSync` über alle erforderlichen Level-0- und Ziel-Pull-Requests sein. `PublishPR` oder verbleibende Teilkonvergenz MÜSSEN Stage B und damit G4 blockiert halten.
  *Business completion MUST be `MergeAndSync` across every required Level-0 and target pull request. `PublishPR` or remaining partial convergence MUST keep Stage B and therefore G4 blocked.*

### Verfassungsanforderungen / Constitution Requirements *(mandatory)*

- **CR-001 – Level-Kontext / Level Context**: Dieses Feature ist Level-0-Orchestrierung mit autorisierten Änderungen an Level-0-, Level-1- und Level-2-Zielen. Vor jedem Zieldiff MUSS die passende Zeile des Level-2 Project Environment Registry beziehungsweise der gleichwertige lokale Projektkontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen bindend ausgewertet werden. Nicht-MSL-Ziele wie `C64Projects/cc65` und `CLionProjects/tvision` MÜSSEN ihre dokumentierte Begründung und sichere Build-Evidence bewahren.
- **CR-002 – A11Y**: CLI, Fehlertexte, Status-/Kostenberichte, Evidence-Zusammenfassungen, Manpage und Hilfe MÜSSEN WCAG 2.2 AA berücksichtigen, soweit anwendbar, und vollständig text-first bleiben. Abhängigkeit, Status, Entscheidung, Blocker und nächste Aktion DÜRFEN nicht visuell allein vermittelt werden.
- **CR-003 – Sprache und Lernzugang / Language and Learning Access**: Nutzerseitige Inhalte MÜSSEN Deutsch zuerst und Englisch danach bei ungefähr CEFR B2 liefern, Fachbegriffe beim ersten Gebrauch erklären und keine Spec-Kit-Erfahrung voraussetzen. Überschriften verwenden `DE / EN`, sofern kein Eigenname vorliegt.
- **CR-004 – Statistik und Agentenflächen / Statistics and Agent Surfaces**: `docs/project-statistics.md` und seine kanonische Konfiguration MÜSSEN nach abgeschlossener Implementierung aktualisiert werden. Gemeinsame Agentenführung MUSS über die im Agent-Parity-Abschnitt genannten Flächen synchron bleiben; konkrete Provider- oder Modellnamen sind keine Feature-Anforderung.
- **CR-005 – Sprachen und Speichersicherheit / Languages and Memory Safety**: Der bestehende gemeinsame Orchestrierungskern verwendet Python als primäre speichersichere Sprache; Bash bleibt die erforderliche native macOS-/Linux-Oberfläche und PowerShell 7+ die Windows-Oberfläche auf einer speichersicheren .NET-Runtime. Bash ist nicht auf der MSL-Allowlist und bleibt ausschließlich wegen des bestehenden Unix-Paritätsvertrags begründet. Bash-Eingaben MÜSSEN validiert und gequotet werden; `eval` ist verboten. PowerShell MUSS Strict Mode, validierte Parameter und sichere Prozessaufrufe verwenden. Jede zielrepository-spezifische Primärsprache folgt ihrer bindenden Registry-Zeile und ihrer Secure-Coding-Begründung.
- **CR-006 – Sicherheitsstandards / Security Standards**: Die Standardsmatrix im Security-Abschnitt ist bindend. `NIST SSDF`, `CWE Top 25`, `SBOM`, `VEX`, `SLSA`, `OpenSSF Scorecard`, `CAPEC`, `Zero Trust`, `OWASP SAMM`, `BSI C3A` und `BSI C5` sind für die betroffenen ausführbaren, öffentlichen, CI-, Provider- oder Vertrauensgrenzen `Applicable`; jede `N/A`-Entscheidung ist begründet.
- **CR-007 – ASVS**: `OWASP ASVS` ist `N/A`, weil Stage B keinen Web-, API-, HTTP-, Session- oder Authentifizierungsdienst erzeugt oder ändert. Re-Evaluation: eine solche Runtimeoberfläche kommt in Scope.
- **CR-008 – Supply Chain**: Distributable Skripte, Workflows, Ruleset-Verträge und veröffentlichte Quelländerungen MÜSSEN in `docs/security/supply-chain-evidence.md` mit SBOM-/VEX-Entscheidung und Provenance-/SLSA-Ziel dokumentiert werden. Neue Abhängigkeiten benötigen vor Aufnahme CVE-, Lizenz-, Herkunfts- und Wartbarkeitsprüfung.
- **CR-009 – KI-Klassifikation / AI Classification**: KI wird ausschließlich als Entwicklungswerkzeug verwendet und ist keine veröffentlichte oder betriebene Runtime-/Produktkomponente. `AI-SBOM` ist `N/A`. Re-Evaluation: Modell, KI-Dienst, Dataset, Inferenzinfrastruktur oder KI-Runtime wird ausgeliefert oder betrieben.
- **CR-010 – Vertrauensgrenzen / Trust Boundaries**: Lokale Arbeitsbäume, Git-Metadaten, Registry-/Providerdaten, Pull Requests, Gates, Reviews, Rulesets, Default Branches, Run-State und Evidence bilden geänderte Vertrauensgrenzen. STRIDE+CIA, relevante CAPEC-Muster und Zero-Trust-Prinzipien MÜSSEN bewertet werden.
- **CR-011 – Security Evidence**: Mindestens `docs/security/threat-model.md`, `docs/security/arc42-security.md`, `docs/security/security-checklist.md`, `docs/security/security-quality-scenarios.md`, `docs/security/dependency-audit.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`, `docs/security/cloud-autonomy-applicability.md`, `docs/security/cloud-compliance-assurance.md`, `docs/security/regulatory-applicability.md` und `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md` MÜSSEN Stage B abdecken. `docs/security/asvs-verification.md` hält die begründete N/A-Entscheidung aktuell.
- **CR-012 – Governance Presets**: Anwendbar ist die installierte Acht-Preset-Matrix: Security, Architecture, iSAQB Architecture, A11Y, Cross-Platform, Agent Parity, Autonomous Run und Parallel Autonomous Run Governance. Model Routing sowie Intake Authoring, Review und Sequencing bleiben operative Zusatzpresets; sie erweitern weder Scope noch Provider- oder Bypassrechte.
- **CR-013 – Documentation Impact**: Die einzige Entscheidung ist `UpdateRequired`; der vollständige Vertrag steht im Abschnitt Dokumentationsauswirkung.

### Schlüsseldaten / Key Entities

- **Authoritative Fleet Snapshot / Autoritativer Flottensnapshot**: Dynamische Menge stabiler Repository-IDs mit Sichtbarkeit, Remote, Default Branch, Profil, Pfadvertrag und gebundenen Eingabehashes.
- **Stage-B Run State / Stage-B-Laufzustand**: Versionierter Zustand mit Run-ID, Authority, aktueller Welle, aktuellem Ziel, letzter sicherer Grenze, Stop-/Resume-Daten und unveränderlicher Referenz auf Stage A.
- **Wave / Welle**: Geordnete Gruppe `Public Canary`, `Public Product`, `Private Product`, `Private Governance/Scaffold` oder `Public Preset` mit vollständigem Wellengate.
- **Target Change Plan / Zieländerungsplan**: Neu berechneter exakter Diff eines Repositorys einschließlich Profil-, Gate-, Ruleset-, Budget- und Plattformentscheidung.
- **Pull Request Lifecycle Evidence / Pull-Request-Lebenszyklus-Evidence**: Branch, exakter Commit, Pull Request, lokale und entfernte Gates, reguläre Review, Merge-Commit, Default-Branch-Synchronisierung und abschließende Providerprüfung.
- **No-op Evidence / No-op-Evidence**: Hash- und zeitgebundener Nachweis semantischer Konvergenz ohne Branch, Commit oder Pull Request.
- **Admin Bypass Evidence / Admin-Bypass-Evidence**: Ausnahmebeleg mit aktueller Autoritätsquelle, Ziel, Zeitpunkt, Grund, Scope, regulärem Vorversuch, vollständiger unabhängiger Acceptance-/Security-/Review-/Gate-Evidence, Provideraktions-ID, Ergebnis und Post-Write-Verifikation; Secrets und unnötige Personendaten sind verboten.
- **Budget Projection / Budgetprojektion**: Pro Welle aktualisierte private Actions-Projektion mit getrennten Copilot-Kategorien, Datenfrische und begründeten Abweichungen.
- **Terminal Fleet Evidence / Terminale Flotten-Evidence**: Vollständiges Ledger aller autoritativen IDs mit PR- oder No-op-Konvergenz und finaler read-only Bestätigung.
- **G4 Handoff / G4-Übergabe**: Reiner Evidence-Verweis für das spätere getrennte Sequencing-Gate; enthält keine G4-Ausführung und keine Serienmutation.

**Data classes / Datenklassen**: Öffentliche Repository-IDs, Workflow- und
Ruleset-Verträge sind `public`; private Sichtbarkeit, PR-/Review-Metadaten und
Budgetprojektionen sind minimierte `internal`-Daten; Credentials, Tokens,
private lokale Pfade, unbereinigte Providerantworten und unnötige
personenbezogene Daten sind `restricted` und dürfen nicht in versionierte
Evidence gelangen.

## Erfolgskriterien / Success Criteria *(mandatory)*

### Messbare Ergebnisse / Measurable Outcomes

- **AC-SBR-001**: Der vollständige Preflight weist exakt dieselbe dynamische Repository-ID-Menge in Manifest, Assignment, Inventory und Rolloutplan nach; aktuell wird `1 + 47 = 48` erwartet, aber live statt hart codiert geprüft.
- **AC-SBR-002**: Unbekannte, fehlende, doppelte oder inkompatible Zuordnungen sowie schmutzige oder divergente Zielzustände blockieren in 100 % der Negativfälle vor Mutation.
- **AC-SBR-003**: Die drei Public Canaries sind vollständig gemergt und synchronisiert oder als No-op konvergent, bevor die erste Profilwelle beginnt.
- **AC-SBR-004**: Die vier folgenden Profilwellen laufen in der festgelegten Reihenfolge; innerhalb jeder Welle entspricht die beobachtete Reihenfolge zu 100 % der sortierten Repository-ID-Liste.
- **AC-SBR-005**: Für 100 % der nichtleeren Ziel-Diffs existieren exakter Branch, Commit, Pull Request, erfolgreiche Pflichtgates, reguläre Reviewfreigabe, Merge-Commit und synchronisierter Default Branch. Eine Bypass-Nutzung ändert keine dieser Nachweispflichten.
- **AC-SBR-006**: Für 100 % der leeren Ziel-Diffs existiert gültige No-op-Evidence; die Zahl leerer Pull Requests beträgt `0`.
- **AC-SBR-007**: Jedes Private-Governance-/Scaffold-Ziel besitzt genau den erforderlichen Minimal-Gate- und Default-Branch-Schutzvertrag; direkte, Web- und API-Schreibpfade bleiben gesperrt.
- **AC-SBR-008**: Ein injizierter Fehler stoppt vor dem nächsten Ziel. Ein Resume bewahrt 100 % der bereits gemergten Erfolge, revalidiert die Gesamtflotte und erzeugt `0` doppelte Pull Requests.
- **AC-SBR-009**: Bash-/PowerShell-Parität, Secret Scan, Security-, A11Y-, Dokumentations-, Statistik- und alle betroffenen Regressionstests sind grün; keine Plattform liefert bei identischen Eingaben einen abweichenden fachlichen Ausgang.
- **AC-SBR-010**: Die nach jeder Welle aktualisierte wiederkehrende private Actions-Projektion bleibt unter 500 von 3.000 Minuten pro Monat; Copilot-Verbrauch wird in jeder Projektion getrennt ausgewiesen.
- **AC-SBR-011**: Terminale Stage-B-Evidence weist 100 % der dynamisch autoritativen Repositories als geprüft konvergent aus und enthält `0` Secrets, Tokens, private lokale Pfade oder unbereinigte Providerantworten.
- **AC-SBR-012**: G4, Copilot-Konfiguration, Account- und Abonnementzustand weisen `0` Änderungen auf; die einzige nächste Aktion ist ein getrenntes Sequencing-Gate beziehungsweise Serien-Update.

### Rückverfolgbarkeit der Anforderungen / Requirement Traceability

| Intake-ID | Primäre Story / Primary Story | Abnahme / Acceptance |
|---|---|---|
| `SBR-001` | Story 1 | `AC-SBR-001`, `AC-SBR-002` |
| `SBR-002` | Story 1 | `AC-SBR-001`, `AC-SBR-011` |
| `SBR-003` | Story 1 | `AC-SBR-002` |
| `SBR-004` | Story 1, Story 5 | `AC-SBR-001`, `AC-SBR-011` |
| `SBR-005` | Story 4 | `AC-SBR-008`, `AC-SBR-011` |
| `SBR-006` | Story 1, Story 3 | `AC-SBR-002`, `AC-SBR-005`, `AC-SBR-012` |
| `SBR-007` | Story 2 | `AC-SBR-003`, `AC-SBR-004` |
| `SBR-008` | Story 2 | `AC-SBR-003`, `AC-SBR-004` |
| `SBR-009` | Story 3 | `AC-SBR-005`, `AC-SBR-006` |
| `SBR-010` | Story 2, Story 3 | `AC-SBR-004`, `AC-SBR-007`, `AC-SBR-010` |
| `SBR-011` | Story 3 | `AC-SBR-007` |
| `SBR-012` | Story 3 | `AC-SBR-005` |
| `SBR-013` | Story 3 | `AC-SBR-005`, `AC-SBR-011` |
| `SBR-014` | Story 4 | `AC-SBR-008` |
| `SBR-015` | Story 4 | `AC-SBR-006`, `AC-SBR-008` |
| `SBR-016` | Story 3, Story 5 | `AC-SBR-005`, `AC-SBR-011` |
| `SBR-017` | Story 6 | `AC-SBR-009` |
| `SBR-018` | Story 6 | `AC-SBR-009` |
| `SBR-019` | Story 5 | `AC-SBR-010` |
| `SBR-020` | Story 3, Story 5 | `AC-SBR-009`, `AC-SBR-012` |
| `SBR-021` | Story 5 | `AC-SBR-005`, `AC-SBR-006`, `AC-SBR-011` |
| `SBR-022` | Story 5, Story 6 | `AC-SBR-012` |
| `SBR-023` | Story 5 | `AC-SBR-012` |
| `SBR-024` | Story 3, Story 5 | `AC-SBR-005`, `AC-SBR-011`, `AC-SBR-012` |

### Rückverfolgbarkeit der Abnahme / Acceptance Traceability

| Abnahme-ID | Bindende Anforderungen / Binding Requirements |
|---|---|
| `AC-SBR-001` | `SBR-001`, `SBR-002`, `SBR-004` |
| `AC-SBR-002` | `SBR-001`, `SBR-003`, `SBR-006` |
| `AC-SBR-003` | `SBR-007`, `SBR-008` |
| `AC-SBR-004` | `SBR-007`, `SBR-008`, `SBR-010` |
| `AC-SBR-005` | `SBR-006`, `SBR-009`, `SBR-012`, `SBR-013`, `SBR-016`, `SBR-021`, `SBR-024` |
| `AC-SBR-006` | `SBR-009`, `SBR-015`, `SBR-021` |
| `AC-SBR-007` | `SBR-010`, `SBR-011` |
| `AC-SBR-008` | `SBR-005`, `SBR-014`, `SBR-015` |
| `AC-SBR-009` | `SBR-017`, `SBR-018`, `SBR-020` |
| `AC-SBR-010` | `SBR-010`, `SBR-019` |
| `AC-SBR-011` | `SBR-002`, `SBR-004`, `SBR-005`, `SBR-013`, `SBR-016`, `SBR-021`, `SBR-024` |
| `AC-SBR-012` | `SBR-006`, `SBR-020`, `SBR-022`, `SBR-023`, `SBR-024` |

## Annahmen und Abhängigkeiten / Assumptions and Dependencies

- Das `Ready`-Review ist bindend und enthält keine Findings, offenen Fragen, akzeptierten Risiken oder Operator-Ausnahmen.
- Der aktuelle Autonomous Run State ist aktiv, an `specs/030-stage-b-rollout` gebunden und enthält aktuelle `MergeAndSync`-Autorität einschließlich des ausdrücklich autorisierten Bypass-Ausnahmewegs.
- Der Bypass ist durch den aktuellen Auftrag auf diesen Run und seine dynamisch autoritative Flotte begrenzt. Jede konkrete Nutzung erhält zusätzlich Ziel- und Zeitbindung; Scope- oder Frischeverlust stoppt fail-closed.
- G3 Feature 029 bleibt terminal abgeschlossen. Sein akzeptierter Feature-HEAD, Merge-Commit und seine PostMerge-Evidence werden vor Remote-Arbeit neu geprüft, nicht neu geschrieben.
- Die aktuelle Flottenzahl `48` und jede Profilkardinalität sind datierte Baselines. Nur die live revalidierte Menge ist fachlich bindend.
- Stabile Registry-IDs sind die einzige zulässige Rolloutidentität. Namen, lokale Pfade oder Provider-Suchergebnisse allein reichen nicht.
- Der reguläre Reviewpfad ist der bevorzugte und verpflichtende Normalweg. Ein Admin-Bypass ist nur eine nachrangige, belegte Ausnahme und hebt keine Reviewpflicht auf.
- Providerdaten können sich zwischen zwei Aktionen ändern; mutable Token werden unmittelbar vor der konsumierenden Aktion revalidiert.
- Keine neue externe Laufzeitabhängigkeit ist fachlich vorausgesetzt. Jede vorgeschlagene Abhängigkeit benötigt Security-, Lizenz-, CVE-, Herkunfts- und Wartbarkeitsprüfung.
- Die Implementierungs- und Rolloutphasen dürfen innerhalb der aktuellen Authority die notwendigen Level-0- und Ziel-Pull-Requests liefern; diese Specify-Phase führt keine solche Aktion aus.
- Das aktive Intake-Serienmanifest bleibt unverändert. Ein späteres Serien-Update ist eine getrennt autorisierte Operation.
- G4 und alle Copilot-, Account- oder Abonnementflächen bleiben vollständig außerhalb des Features.

## Autonomous-Run-Anwendbarkeit / Autonomous-Run Applicability

- **Authority / Autorität**: Der aktuelle Benutzerauftrag und `specs/030-stage-b-rollout/autonomous-run-state.json` erteilen `MergeAndSync` für diesen Stage-B-Lauf einschließlich ausdrücklich autorisiertem Admin-Bypass als Ausnahmeweg. Die Authority ist kein Ersatz für Gate-Evidence und erweitert nicht die Nicht-Ziele.
- **Accepted inputs / Akzeptierte Eingaben**: Lastenheft SHA-256 `4bb7e52b8edeb24898c44d1227c7535ac5d44521585ce5811163ac60e97e72ab`, Review-Result SHA-256 `132ba8e631ca930778b36d3d96b91fe974a3c126a4f9e9dbaf5b1b21b8c5ec69`, Review-Report SHA-256 `1eff4e4343801a56d4573806af79e5f61c75e71a96e82a450ebe934be186b52d`, Review-Request SHA-256 `d7d7736f01de4032bd9e296d940e2b60371eae6bbe2415147920be68f4b848c5` und Authoring-Receipt SHA-256 `39e70d970593987b405932c31ff18e321daf1e6f58d592981fc9f9073a0a2e56`.
- **Feature identity / Feature-Identität**: Featurepfad `specs/030-stage-b-rollout`, Branch `030-stage-b-rollout`, Run-State `specs/030-stage-b-rollout/autonomous-run-state.json`. Stage-A-Evidence bleibt eine akzeptierte, unveränderliche Vorgängergrenze.
- **Delivery-set and evidence lifecycle / Delivery-Set und Evidence-Lebenszyklus**: `Applicable`; Stage B führt getrennte Zustands-, Zieltransaktions-, Bypass-, No-op-, Wellen- und terminale Evidence ein. Neue Lieferentscheidungen verwenden die aktuelle Schema-2.0-Governance; historische Schema-1.0- oder Stage-A-Daten bleiben reine Audit-Evidence.
- **Hard boundary / Harte Grenze**: Die Gesamtlieferung darf später die autorisierte Remote-Konvergenz ausführen. Diese Specify-Phase darf nur `spec.md`, `checklists/requirements.md` und das Runner-Phasenergebnis schreiben; kein Commit, Push, Pull Request, Merge, GitHub-/Zielrepository-Schreibzugriff, Home-Sync, Serien-Update, Copilot-/Account-/Abonnement-Update oder G4-Start ist zulässig.
- **Mutable validation tokens / Veränderliche Validierungstoken**: `Applicable`; Level-0- und Ziel-HEAD, Registry-/Pfad-/Gate-Set-Hashes, Repository- und Ruleset-ID, Default Branch, Pull-Request-HEAD, Check-Suite/-Run, Reviewentscheidung, Merge-Commit, Budgetzeitpunkt und Provider-Frische sind vor der jeweils abhängigen Aktion neu zu prüfen.
- **Admin bypass / Admin-Bypass**: `Applicable` ausschließlich als Ausnahmeweg. Evidence bindet aktuelle Autoritätsquelle, Ziel, Zeitpunkt, Grund, Scope, normalen Vorversuch, vollständige Acceptance-/Security-/Review-/Gate-Nachweise, Provideraktions-ID, Ergebnis und Post-Write-Prüfung. Ein grüner Bypass-Status allein ist kein technischer Nachweis.
- **Causal closeout / Kausaler Abschluss**: `Applicable`, weil mehrere externe Pull Requests, Merges, Rulesets und Synchronisierungen einen kausalen Abschluss über exakten Kandidaten, PreMerge-Evidence, Mergefakten, Default-Branch-Sync, PostMerge-Evidence und terminale Flottenprüfung benötigen. Ein Evidence-only-Folgeabschluss darf keine unendliche PR-Rekursion erzeugen.
- **Run state / Laufzustand**: Ein bewusster Stop wird an sicherer Grenze dokumentiert und nur über autorisiertes Resume fortgesetzt. Eine unerwartete Unterbrechung verlangt vollständige Drift-, Hash-, Branch-, Authority-, Provider-, Gate-, Review-, Budget- und Evidence-Revalidierung. Resume erzeugt keine neue Authority und überspringt keinen offenen Blocker.
- **Retrospective boundary / Retrospektivgrenze**: Wiederverwendbare Erkenntnisse dürfen portable Governance-, Transaktions-, A11Y-, Test- und Evidence-Muster enthalten. Providercredentials, private Pfade, personenbezogene Rohdaten, maschinenlokale Profile und implizite Remote- oder Bypassrechte bleiben ausgeschlossen.
- **G4 boundary / G4-Grenze**: Die portable Übergabe endet bei Stage-B-Konvergenz-Evidence und einer textlichen nächsten Sequencing-Aktion. G4-Ausführung und Serienmutation sind nicht Teil dieses Runs.

### Specify-Phasengates / Specify Phase Gates

| Gate-ID | Anwendbarkeit / Applicability | Scope und prüfbarer Token / Scope and Verifiable Token | Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|
| `SPEC-GATE-001` | `Applicable` | Genau `spec.md` und `checklists/requirements.md` sind die zwei erwarteten Tasks; beide sind vorhanden und nicht leer. | Aktueller Featurepfad | Änderung des erwarteten Taskumfangs |
| `SPEC-GATE-002` | `Applicable` | `SBR-001` bis `SBR-024` und `AC-SBR-001` bis `AC-SBR-012` sind lückenlos in Anforderungen, Abnahme und beiden Traceability-Tabellen vorhanden. | Diese Spezifikation | Hash- oder Inhaltsdrift des akzeptierten Lastenhefts |
| `SPEC-GATE-003` | `Applicable` | Keine ungelöste Klarstellungsmarkierung; jede Qualitätschecklistenposition ist wahrheitsgemäß bestanden. | `checklists/requirements.md` | Neue offene Reviewfrage oder Qualitätsfehler |
| `SPEC-GATE-004` | `Applicable` | `MergeAndSync`, regulärer Reviewnormalweg, eng begrenzter Bypass-Ausnahmeweg und alle Specify-Verbote sind ausdrücklich enthalten. | SBR-006, SBR-012, SBR-013 und Autonomous-Run-Grenze | Authority-, Scope- oder Bypass-Drift |
| `SPEC-GATE-005` | `Applicable` | Security, Architecture, iSAQB, A11Y, Cross-Platform und Agent Parity besitzen Disposition, Begründung, Evidence-Pfad und Re-Evaluation-Trigger. | Governance-Abschnitte | Governance- oder Preset-Drift |
| `SPEC-GATE-006` | `Applicable` | Normalisierter lowercase SHA-256 bindet den finalen Spezifikationspayload im Phasenergebnis. | Runner-Ausgabedatei `specify.result.json` | Jede Änderung an `spec.md` |

Owner aller Specify-Gates ist der Fleet Delivery Owner; Reviewer ist der
nachfolgende Spec-Kit-Phasenreview. Restrisiko ist spätere Drift bindender
Intake-, Authority- oder Governance-Artefakte. Follow-up ist dann ein
fail-closed Stop mit neuer Bewertung, keine stille Anpassung.

### Spätere Acceptance-Gates / Later Acceptance Gates

| Gate-ID | State | Required scope | Command token | Runner / Platform | Rationale | Re-Evaluation Trigger |
|---|---|---|---|---|---|---|
| `G-SBR-001` | `Applicable` | Dynamische Flottenidentität, G3-Evidence und vollständiger Preflight | `StageBPreflight` | macOS plus Provider read-only | Keine Mutation ohne frische Gesamtbasis | Inventar-, Registry-, G3- oder Providerdrift |
| `G-SBR-002` | `Applicable` | Getrennte Stage-B-Schemas, Zustandsübergänge und unveränderte Stage-A-Historie | `StageBContractValidation` | macOS, Linux, Windows fixtures | Historische Semantik darf nicht umgedeutet werden | Schema- oder Migrationsänderung |
| `G-SBR-003` | `Applicable` | Drei Public Canaries vollständig konvergent | `StageBCanaryConvergence` | Provider plus Zielplattformen | Canary-Grenze begrenzt den Fehlerradius | Canary-Menge oder Profil ändert sich |
| `G-SBR-004` | `Applicable` | Vier Profilwellen und lexikografische Reihenfolge | `StageBWaveConvergence` | Provider plus Zielplattformen | Teilkonvergenz ist kein Wellenerfolg | Profil- oder Reihenfolgeänderung |
| `G-SBR-005` | `Applicable` | Exakter Branch-/Commit-/PR-/Gate-/Review-/Merge-/Sync-Vertrag | `StageBRegularDelivery` | Je Ziel gemäß Registry | Regulärer PR-Pfad ist Normalweg | Branch-, Gate-, Review- oder Mergevertrag ändert sich |
| `G-SBR-006` | `Applicable` | Ziel-/zeitgebundene Bypass-Evidence ohne Ersatz technischer Nachweise | `StageBAdminBypassEvidence` | Provider | Ausnahmepfad benötigt strengere Audit-Evidence | Authority-, Scope- oder Provideränderung |
| `G-SBR-007` | `Applicable` | Private Minimal-Gate- und Ruleset-Sicherheitsgrenze | `StageBPrivateRuleset` | Private Governance targets | Lokaler Hook ist keine Servergrenze | Statusname oder Rulesetmodell ändert sich |
| `G-SBR-008` | `Applicable` | No-op, Stop, Resume, Idempotenz und Fehler-Injektion | `StageBResumeIdempotency` | macOS, Linux, Windows fixtures | Teilrollout muss sicher fortsetzbar bleiben | Zustands- oder Retrymodell ändert sich |
| `G-SBR-009` | `Applicable` | Bash-/PowerShell-Parität, Regression, Security und A11Y | `StageBQualityParity` | macOS, Linux, Windows | Kritische script-shaped Oberfläche | Plattform, Wrapper oder Validator ändert sich |
| `G-SBR-010` | `Applicable` | Budgetprojektion nach jeder Welle, Copilot getrennt | `StageBBudgetPreservation` | Provider read-only | Budget ist bindende Liefergrenze | Budget-, Billing- oder Zeitannahme ändert sich |
| `G-SBR-011` | `Applicable` | 100 % terminale Flottenkonvergenz und redigierte Evidence | `StageBTerminalConvergence` | Provider plus lokaler Sync | G4 braucht vollständige belegte Konvergenz | Zielmenge oder Evidence-Felder ändern sich |
| `G-SBR-012` | `Applicable` | G4, Copilot, Account, Subscription und Intake-Serie unverändert | `StageBScopeIsolation` | Repository-/Provider-Diff | Nicht-Ziele dürfen nicht still erweitert werden | Separate neue Autorität wird erteilt |

Die konkreten ausführbaren Befehlsfolgen, Evidence-Roots und exakten
Runnerbindungen werden in Plan und Gate-Requirements festgelegt. Die stabilen
Command Tokens oben sind fachliche Gate-Identitäten und dürfen nicht durch
einen grünen Sammelnamen oder einen Bypass ersetzt werden.

## Governance-Anwendbarkeit / Governance Applicability

| Checkpoint | Anwendbarkeit / Applicability | Umsetzungsstatus in Specify / Implementation Status | Begründung / Rationale | Geplante Evidence / Planned Evidence | Re-Evaluation Trigger |
|---|---|---|---|---|---|
| Security Governance | `Applicable` | `Not Assessed` | Providerwrites, Rulesets, Pull Requests, Reviews, Evidence, Secrets und Bypass-Ausnahme verändern Sicherheitsgrenzen. | Security-Dateien gemäß CR-011, Gate-Evidence und redigiertes Flottenledger | Feature wird rein redaktionell oder neue Auth-/Secret-/Crypto-Fläche entsteht |
| Architecture Governance | `Applicable` | `Not Assessed` | Resumierbare Remote-Transaktionen, Wellengates, Trust Boundaries und kausaler Closeout ändern Laufzeit- und Deploymentverhalten. | `docs/architecture/ci-budget-governance.md`, Threat Model, arc42, S-ADR | Remote- oder Deploymentgrenze entfällt beziehungsweise ändert sich |
| iSAQB Architecture Governance | `Applicable` | `Not Assessed` | Kontext, Schnittstellen, Building Blocks, Runtime, Deployment, Qualitätsattribute, Risiken und technische Schuld sind betroffen. | Architekturdatei, Security Quality Scenarios, ADR-Review | Nur noch rein redaktionelle Änderung ohne Architekturwirkung |
| A11Y Governance | `Applicable` | `Not Assessed` | CLI, Fehler, Status, Kosten-/Konvergenzbericht, Manpage und Hilfe sind nutzerseitig. | `docs/accessibility/ci-budget-governance.md`, A11Y-/Sprachfixtures | Entfernung aller nutzerseitigen Artefakte oder neue GUI/Medienfläche |
| Cross-Platform Governance | `Applicable` | `Not Assessed` | Das Feature ändert kritische script-shaped Orchestrierung für macOS/Linux/Windows. | Bash-/PowerShell-Parität, Manpage, Hilfe, Syntax-, Analyzer- und Regressionsevidence | Nachweis technischer Unmöglichkeit einer Plattform; derzeit nicht gegeben |
| Agent Parity Governance | `Applicable` | `Not Assessed` | Gemeinsame Betriebsführung, Templates und agentenneutrale Autonomiegrenzen müssen gemeinsam geprüft werden. | Paritätsdiff, Agent-Surface-Validator, Documentation Impact | Plan beweist keine Guidance-/Templateänderung; Update bleibt dann begründet `N/A`, Review bleibt anwendbar |

Owner aller sechs Checkpoints ist der Fleet Delivery Owner; Reviewer sind die
jeweiligen Security-, Architecture-/iSAQB-, A11Y-, Cross-Platform- und
Agent-Parity-Reviewer. Der Specify-Umsetzungsstatus bleibt `Not Assessed`, weil
die Implementierungsevidence später entsteht. Fehlende applicable Evidence
blockiert Planfreigabe, Implementierungsabnahme und Remote-Closeout.

## Plattformübergreifende Anwendbarkeit / Cross-Platform Applicability

- **Script-shaped tool**: `Applicable`; `scripts/maintain-agentic-workspace.sh` und `scripts/maintain-agentic-workspace.ps1` werden für Stage-B-Orchestrierung funktional gleichwertig geändert.
- **Platforms / Plattformen**: macOS und Linux über Bash; Windows über PowerShell 7+; gemeinsame normalisierte Fixtures und native Zielplattformnachweise prüfen Parität.
- **Interfaces / Oberflächen**: Die bestehende Wartungsoberfläche erhält einen eindeutigen Stage-B-Rolloutmodus mit Preflight, Vorschau, Start und Resume. Die konkrete Schalterbenennung wird im Plan festgelegt; sie MUSS auf beiden Varianten semantisch gleichwertig sein.
- **Cmdlet**: `Invoke-HBAgenticWorkspaceMaintenance` bleibt die genehmigte PowerShell-Cmdlet-Oberfläche; `Invoke` ist ein genehmigtes Verb. Neue Funktionen MÜSSEN ebenfalls genehmigte `Verb-Noun`-Namen verwenden.
- **Preview / Vorschau**: Bash `--dry-run` und PowerShell `-WhatIf` zeigen dynamische Zielmenge, Welle, Reihenfolge, exakten geplanten Diff, Provideraktionen, Budget und Evidence-Ziele. Sie schreiben keine Evidence und mutieren weder Repository, GitHub, Home Runtime noch Intake-Serie.
- **Documentation / Dokumentation**: `docs/man/maintain-agentic-workspace.1.md` wird als Unix-Manpage aktualisiert; `scripts/maintain-agentic-workspace.ps1` erhält vollständige bilinguale Comment-based Help, Deutsch zuerst und Englisch danach.
- **Validators / Validatoren**: `Applicable` sind mindestens Bash-Syntax, PowerShell-Parser, PSScriptAnalyzer, bestehende Maintenance-Regressionen, CI-Budget-Vertrags-/Wrappertests, Stage-B-Zustands-/Rollout-/Evidence-Schemavalidierung, Provider-Argument-/Retrytests, Stop-/Resume-/No-op-Fixtures, Workflow-/Rulesettests, Secret Scan, Documentation Impact, A11Y, Statistik und Bash-/PowerShell-Parität.
- **N/A decisions**: Keine Plattformvariante ist `N/A`. Re-Evaluation: Zielplattform, Wartungsoberfläche, Engine-Prozessgrenze oder Paritätsvertrag ändern sich.

## Barrierefreiheitsanwendbarkeit / Accessibility Applicability

- **Affected artefacts / Betroffene Artefakte**: CLI-Ausgabe, Fehlertexte, Status-/Budget-/Konvergenzberichte, Evidence-Zusammenfassungen, Dokumentation, Manpage, PowerShell-Hilfe, Changelog-/Handoff-Texte und didaktische Inline-Kommentare für nicht triviale Orchestrierungslogik.
- **WCAG 2.2 AA**: `Applicable` sind insbesondere 1.3.1 Information und Beziehungen, 1.4.1 Verwendung von Farbe, 2.1.1 Tastatur, 2.4.6 Überschriften und Beschriftungen, 3.3.1 Fehlererkennung, 3.3.2 Beschriftungen oder Anweisungen und robuste textuelle Struktur. GUI-, Pointer-, Drag-and-drop-, Audio- und Videokriterien sind `N/A`, weil keine solche Oberfläche entsteht. Re-Evaluation: GUI, HTML, Medien oder Zeigerinteraktion kommt in Scope.
- **Language / Sprache**: Deutsch zuerst, Englisch danach, CEFR B2, Fachbegriffe beim ersten Gebrauch, `DE / EN`-Überschriften. Spec-Kit-Vorwissen wird nicht vorausgesetzt.
- **Text-first**: Welle, Repository-ID, Profil, Entscheidung, Status, Blocker und nächste Aktion stehen in stabiler linearer Reihenfolge. Bedeutung hängt nicht von Farbe, Symbol, Cursorposition oder Tabellenposition ab. Diagramme erhalten kurze DE-/EN-Textalternativen; Codeblöcke erhalten Sprachkennzeichnung.
- **Didactic comments / Didaktische Kommentare**: `Applicable` für nicht triviale Logik zu Trust Boundaries, Transaktionsgrenzen, Bypass-Ausnahme, Hash-Bindung, Wellengates, fail-closed Stop, Idempotenz und kausalem Closeout. Kommentare erklären Warum, Trade-off oder Proof-Grenze.
- **Evidence / Nachweis**: `docs/accessibility/ci-budget-governance.md`, A11Y-/Sprachfixtures und native lineare Ausgabebeispiele. Owner: Fleet Delivery Owner; Reviewer: A11Y Reviewer. Restrisiko: native Plattformausgabe kann driften. Re-Evaluation: jede Änderung nutzerseitiger Ausgabe, Interaktion oder Sprache.

## Architekturanwendbarkeit / Architecture Applicability

- **Disposition**: `Applicable`; Stage B verändert Kontext, Schnittstellen, Building Blocks, Laufzeit, Deployment, Qualitätsattribute und technische Schuld.
- **Architecture goals / Architekturziele**: Fail-closed Korrektheit, begrenzter Fehlerradius, resumierbare Remote-Transaktionen, idempotente Konvergenz, Defense in Depth, Least Privilege, deterministische Auditierbarkeit, Budgeterhalt, Plattformparität und verständliche Bedienung.
- **Affected views / Betroffene Sichten**: Systemkontext zwischen Level 0, Flottenregistry, lokalen Zielklonen und GitHub; Schnittstellen der Wartungssteuerung; Building Blocks für Preflight, Plan, Welle, Zieltransaktion, No-op, Bypass-Evidence, Resume, Budget und Closeout; Laufzeitfolge bis zur terminalen Providerprüfung; Deployment über Pull Requests und Rulesets.
- **Quality scenarios / Qualitätsszenarien**: Drift stoppt vor Mutation; ein Canary-Fehler sperrt Profilwellen; ein Fehler nach Merge bleibt sicher resumierbar; Bypass ersetzt keinen Gate; identische Inputs liefern plattformgleich dieselbe Entscheidung; ein No-op erzeugt keinen PR; Budgetüberschreitung sperrt die nächste Welle.
- **Evidence / Nachweis**: `docs/architecture/ci-budget-governance.md` wird aktualisiert. `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md` wird für den realisierten Serververtrag und die Bypass-Ausnahme fortgeschrieben; zusätzliche ADRs sind nur bei einer weiteren architektonisch signifikanten Entscheidung nötig.
- **Technical debt / Technische Schuld**: Stage-A-Simulation, implizite Teilkonvergenz und manuelle Zielverfolgung werden durch getrennte Stage-B-Verträge ersetzt. Historische Stage-A-Evidence bleibt bewusst unverändert.
- **Re-Evaluation**: Änderungen an Flottenprofil, Remote-Transaktion, Ruleset, Review-/Bypassmodell, Deployment, Zielplattform, Closeout oder Authority.

## Sichere Architekturanwendbarkeit / Architecture Governance Applicability

- **Runtime/hardware constraint**: Der gemeinsame Python-Kern und PowerShell/.NET sind speichersicher. Bash bleibt wegen der bestehenden nativen Unix-Oberfläche begründet. Zielrepositorys folgen ihrer Registry-Runtime; Non-MSL-Ausnahmen und sichere Build-Evidence bleiben erhalten.
- **Trust boundaries / Vertrauensgrenzen**: Nicht vertrauenswürdige Registry-, Git-, Provider-, Pull-Request-, Gate-, Review- und Rulesetdaten überqueren die Orchestrierungsgrenze. Lokale Zielklone, GitHub, Run-State, Evidence und Home Runtime sind getrennte Transaktions- und Vertrauensräume.
- **Data flows / Datenflüsse**: Öffentliche und interne IDs/Metadaten fließen read-only in den Preflight; ausschließlich validierte, minimierte Aktionsparameter fließen zum Provider; redigierte Ergebnisse fließen in Evidence. Restricted Daten dürfen die Provider-/Evidence-Grenze nicht überschreiten.
- **Threat modeling**: STRIDE+CIA und CAPEC sind `Applicable`, besonders CAPEC-115 Authentication Bypass, CAPEC-15 Command Delimiters, CAPEC-126 Path Traversal und CAPEC-23 File Content Injection sowie Manipulation von HEAD, Review, Gate, Ruleset und Resume-State. Evidence: `docs/security/threat-model.md`.
- **S-ADR and arc42**: Update von ADR-002 und `docs/security/arc42-security.md` ist `Applicable`; Authentisierung, Autorisierung, Eingabevalidierung, Fehlerbehandlung, Logging, Abhängigkeiten und Deployment-Sicherheit werden bewertet.
- **Zero Trust**: `Applicable`; lokale Klone, Netzstandort, gespeicherte IDs, Hooks, Reviews und Bypassstatus genießen kein implizites Vertrauen. Identität, Ziel, Kandidat, Gate, Review und Ergebnis werden fortlaufend verifiziert. Evidence: `docs/security/zero-trust-applicability.md`.
- **OWASP SAMM**: `Applicable` für den langlebigen Level-0-Workspace und die flottenweite Delivery-Praxis. Evidence: `docs/security/samm-assessment.md`.
- **BSI C3A**: `Applicable`, weil Stage B GitHub als providerabhängige Workflow-, Pull-Request-, Ruleset- und Hostingfläche real nutzt. Evidence muss Providerabhängigkeit, Portabilität, Exit-Optionen und Autonomierisiko in `docs/security/cloud-autonomy-applicability.md` bewerten.
- **BSI C5**: `Applicable` als Cloud-Assurance-Review für GitHub-Hosting und Actions/Ruleset-Betrieb. Evidence muss Assurance-Scope, Shared Responsibility, Provider-/Subprocessorabhängigkeit, Datenstandort, Logging, Backup und Incident-Evidence in `docs/security/cloud-compliance-assurance.md` bewerten, ohne eine nicht belegte Zertifizierung zu behaupten.
- **Re-Evaluation**: Provider, Hosting, Identity, Ruleset, Datenklasse, Remote-Write-Oberfläche, Cloud-Assurance-Anforderung oder Zielruntime ändert sich.

## Sicherheitsgovernance-Anwendbarkeit / Security Governance Applicability

| Standard / Check | Anwendbarkeit / Applicability | Begründung und Evidence / Rationale and Evidence | Re-Evaluation Trigger |
|---|---|---|---|
| NIST SSDF | `Applicable` | Produktionsnahe Orchestrierung, CI-/Ruleset-Delivery und Vulnerability-Response benötigen Prepare/Protect/Produce/Respond-Evidence in Plan, Tasks und Security Checklist. | Feature wird rein redaktionell |
| CWE Top 25 | `Applicable` | Nicht vertrauenswürdige Eingaben, Pfade, Prozess-/Provideraufrufe, Autorisierung und Evidence-Integrität benötigen relevante CWE-Prüfung. | Keine ausführbare Eingabe-, I/O- oder Authority-Fläche mehr |
| OWASP ASVS | `N/A` | Kein Web/API/HTTP/Auth-Service wird erstellt oder verändert; N/A bleibt in `docs/security/asvs-verification.md`. | Web-, API-, HTTP-, Session- oder Auth-Runtime kommt in Scope |
| SBOM | `Applicable` | Skripte, Workflows, Rulesets und Quelllieferungen sind distributable Artefakte; Evidence in `docs/security/supply-chain-evidence.md`. | Keine auslieferbaren oder releasefähigen Artefakte mehr |
| VEX | `Applicable` | Bekannte Findings in ausgelieferten oder bewerteten Komponenten benötigen Status in Supply-Chain-Evidence und Dependency Audit. | Keine ausgelieferten oder bewerteten Komponenten mehr |
| AI-SBOM | `N/A` | KI ist nur Entwicklungswerkzeug; kein Modell, Dataset, KI-Dienst, Inferenzsystem oder KI-Runtime ist Teil der Lieferung. | KI-Komponente wird ausgeliefert oder betrieben |
| SLSA | `Applicable` | CI-/veröffentlichte Artefakte und flottenweite Lieferkette benötigen Provenance- und Buildintegritätsziel. | Keine CI-/Publikationsartefakte mehr |
| OpenSSF Scorecard | `Applicable` | Level 0, Public Canaries, Public Products und Public Presets sind öffentliche OSS-/Distributionsflächen. | Keine öffentliche oder hochwirksame Abhängigkeitsfläche mehr |
| CAPEC | `Applicable` | Providerwrite, Bypass, Ruleset, Pfad und Evidence besitzen materielle Angriffswege im Threat Model. | Trust Boundaries entfallen |
| Zero Trust | `Applicable` | Remoteverwaltete, providerabhängige Zieltransaktionen benötigen fortlaufende Verifikation statt Netz- oder Accountvertrauen. | Remote-/Providergrenze entfällt |
| OWASP SAMM | `Applicable` | Langlebiger Level-0-Workspace und wiederholbare Delivery-Praxis benötigen Verbesserungsevidence. | Workspace ist nicht mehr langlebig/operativ |
| BSI C3A | `Applicable` | GitHub-abhängige PR-, Workflow-, Ruleset- und Hostingentscheidungen benötigen Cloud-Autonomie-Review. | Providerabhängige Hosting-/Deploymentfläche entfällt |
| BSI C5 | `Applicable` | GitHub-Hosting und Actions/Rulesets benötigen Cloud-Assurance- und Shared-Responsibility-Review. | Keine Cloud-Assurance- oder Providerbetriebsfläche mehr |
| Regulatory NIS2 | `N/A` | Dieses private Workspace-/OSS-Rolloutfeature betreibt keinen als wesentlich oder wichtig eingeordneten Dienst und bedient keinen nachgewiesenen regulierten Kunden. | Regulierte Organisation, Dienst oder Lieferkettenrolle entsteht |
| Regulatory CRA | `N/A` | Stage B platziert mit diesem Feature kein neues digitales Produkt wirtschaftlich auf dem EU-Markt; SBOM und sichere Lieferpraxis bleiben unabhängig anwendbar. | Marktbereitstellung, Kundenübergabe oder wirtschaftliche Produktdistribution entsteht |
| Regulatory EU AI Act | `N/A` | Keine KI-Runtime oder Produktkomponente wird ausgeliefert oder betrieben. | KI-Runtime/-Produktkomponente kommt in Scope |
| Regulatory DORA | `N/A` | Kein Finanzunternehmen und kein nachgewiesener IKT-Drittservice im DORA-Scope. | Finanzsektorrolle oder regulierter IKT-Kunde entsteht |

Owner der Standardsentscheidungen ist der Fleet Delivery Owner; Reviewer ist
der Security and Compliance Reviewer. Umsetzungsstatus bleibt in Specify
`Not Assessed`. Restrisiko sind neue Provider-, Dependency-, Auth- oder
Regulatory-Grenzen. Follow-up ist vollständige Evidence vor der ersten
betroffenen Remote-Mutation und erneut vor terminalem Closeout.

## Agenten-Parität / Agent Parity Applicability

- **Applicability / Anwendbarkeit**: `Applicable` für gemeinsame Betriebsführung, agentenneutrale Autonomie-/Authority-Grenzen, Spec-Kit-Templates und flottenweite Delivery-Evidence.
- **Maintained surfaces / Gepflegte Flächen**: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md` werden gemeinsam geprüft und bei einer gemeinsamen Guidance-Änderung atomar aktualisiert.
- **Constitution/templates**: `constitution.md`, `.specify/memory/constitution.md`, `.specify/templates/` und relevante `scripts/templates/` werden nur geändert, wenn die Implementierung einen gemeinsamen Grundsatz oder Spec-Kit-Vertrag ändert. Der Specify-Stand verlangt keine Verfassungsänderung.
- **Project templates / Projektvorlagen**: Die kanonischen CI-Budget-Workflow-/Ruleset-Templates und die Stage-B-Evidence-Verträge sind betroffen; sie müssen agenten- und providercredential-neutral bleiben. Konkrete lokale Modellnamen sind verboten.
- **Current update decision / Aktuelle Updateentscheidung**: Eine Änderung der fünf Agenten-Guidance-Dateien ist in Specify `N/A`, weil die Spezifikation keine gemeinsame Betriebsregel ändert. Die Paritätsprüfung bleibt `Applicable`. Re-Evaluation: Plan oder Implementierung ändert gemeinsame Guidance, Statistikmethodik, Constitution, Templates oder Routingrollen.
- **Intentional deviations / Absichtliche Abweichungen**: Keine. Jede später notwendige Abweichung benötigt Begründung und Paritätsevidence in derselben Änderung.
- **Evidence / Nachweis**: Agent-Surface-Paritätsvalidator, vollständiger Diff, Documentation-Impact-Evidence und gegebenenfalls synchronisierte Guidance-/Template-Dateien. Owner: Fleet Delivery Owner; Reviewer: Agent Parity Reviewer.

## Dokumentationsauswirkung / Documentation Impact

- **Decision / Entscheidung**: `UpdateRequired` — die einzige Documentation-Impact-Entscheidung dieses Features.
- **Audiences and reader paths / Zielgruppen und Leserpfade**: Fleet Delivery Owner, Maintainer, Repository-Verantwortliche und Reviewer beginnen bei Zweck, Voraussetzungen, Authority-/Sicherheitsgrenze und sicherem Preview; danach folgen Preflight, Wellen, Zieltransaktion, No-op, Stop/Resume, Bypass-Ausnahme, Budget, terminale Evidence und G4-Handoff. Kanonischer Leserpfad: Lastenheft → Ready-Review → Spezifikation → Quickstart/Plan → Manpage beziehungsweise PowerShell-Hilfe → Stage-B-Evidence → getrenntes Sequencing-Follow-up.
- **Canonical source and owner / Kanonische Quelle und Owner**: Level 0 besitzt Orchestrierungs-, Profil-, Workflow-/Ruleset- und Stage-B-Evidence-Verträge; Owner ist der Fleet Delivery Owner. Jedes Zielrepository bleibt Owner seiner Runtime-, Build-/Test-, Security-, A11Y- und Agentenwahrheit gemäß Registry.
- **Affected documentation families / Betroffene Dokumentfamilien**: README-/Betriebsnavigation, `docs/scripts/`, `docs/man/maintain-agentic-workspace.1.md`, bilinguale PowerShell-Hilfe, `docs/architecture/ci-budget-governance.md`, Security-Dateien gemäß CR-011, `docs/accessibility/ci-budget-governance.md`, Stage-B-Quickstart/Evidence, Changelog beziehungsweise Abschlussnotiz und `docs/project-statistics.md` mit Konfiguration.
- **Navigation impact / Navigation**: Der Stage-B-Betrieb muss aus der bestehenden Wartungs-/CI-Budget-Navigation erreichbar sein. Einstiegsseiten zeigen Zweck, Voraussetzungen, Sicherheitsgrenze und genau eine sichere Preview-Aktion vor Detailreferenzen.
- **Document class / Dokumentklasse**: Versionierter Betriebs-, Sicherheits- und Governance-Vertrag mit deterministischen maschinenlesbaren Evidence-Artefakten. Semantische Review bleibt Pflicht und wird nicht durch Schema- oder Hashvalidierung ersetzt.
- **Language strategy and partner / Sprachstrategie und Partner**: Deutsch zuerst, Englisch danach, CEFR B2. Kurze Betriebsflächen sind inline bilingual; große normative Seiten nutzen nur bei besserer Orientierung synchronisierte `.en.md`-Partner.
- **Platform/example proof / Plattform-/Beispielnachweis**: Mindestens ein Bash-Preview-/Resume-Beispiel für macOS/Linux, ein PowerShell-`-WhatIf`-/Resume-Beispiel für Windows und native beziehungsweise normalisierte Paritätsevidence. Ausgaben bleiben ohne Farbe verständlich.
- **Distribution class / Distributionsklasse**: Spezifikation, Plan, Dokumentation, Verträge und versionierte Evidence sind `sourceOnly`; geänderte manifestgebundene Wartungsskripte sind `homeRuntime`; Credentials, lokale Providerprofile und temporäre Rohlogs sind `machineLocal` und nicht Git-getrackt. Zielrepository-Änderungen gehören zur jeweiligen Zielquelle, nicht zur Level-0-Home-Runtime.
- **Home-sync need / Home-Sync-Bedarf**: In Specify `false`. Für den späteren Lauf nur `true`, wenn der finale akzeptierte Diff tatsächlich manifestgebundene `homeRuntime` ändert; dann erst nach Preview, Konfliktprüfung, Merge, aktueller Authority und mit abschließender Prüfung. Reine Source-, Evidence- oder Zieländerungen bleiben `false`.
- **Evidence / Nachweis**: `specs/030-stage-b-rollout/spec.md`, `specs/030-stage-b-rollout/checklists/requirements.md`, später `specs/030-stage-b-rollout/documentation-impact-evidence.json`, Stage-B-Gate-/Rollout-/Terminal-Evidence sowie aktualisierte Architektur-, Security-, A11Y-, Skript-, Manpage-, Hilfe- und Statistiknachweise.
- **Re-evaluation trigger / Re-Evaluation**: Änderung von Zielgruppe, Flottenmenge, Profil, Authority, Bypass-Scope, Review-/Gatevertrag, Provider, Skriptoberfläche, Zielplattform, Evidence-Schema/-pfad, Dokumentklasse, Distribution, Home-Runtime oder G4-/Seriengrenze.

## Englische Vertragszusammenfassung / English Contract Summary

The German-first sections above and their English counterparts form one
binding specification. The normative identifiers `SBR-001` through `SBR-024`
and `AC-SBR-001` through `AC-SBR-012` are preserved without renumbering.
Stage B revalidates the authoritative fleet, converges the three Public
Canaries, then processes four ordered profile waves. Every non-empty change
uses an exact branch, commit, pull request, mandatory gates, regular review,
merge, and default-branch synchronization; every empty change receives no-op
evidence. Failures stop before the next target, and resume revalidates the full
fleet without duplicate pull requests.

The current run has explicit `MergeAndSync` authority and explicit admin-bypass
authority. Bypass remains a target- and time-bound exception and never replaces
acceptance, security, review, or gate evidence. Terminal completion requires
redacted proof for every authoritative repository and a private Actions
projection below 500 of 3,000 minutes per month. G4, Copilot configuration,
account and subscription settings, and the intake series remain unchanged.
This Specify phase itself writes only the specification, its quality checklist,
and the runner phase result; it performs no remote, Git, Home-sync, series, or
G4 mutation.
