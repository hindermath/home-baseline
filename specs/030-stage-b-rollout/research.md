# Technische Forschung: Stage-B-Rollout / Technical Research: Stage-B Rollout

## 1. Wiederverwendung der Orchestrierung / Orchestration Reuse

**Decision / Entscheidung**: Der vorhandene Python-Kern
`scripts/lib/agentic_workspace_fleet.py` bleibt alleiniger Eigentümer der
fachlichen Stage-B-Entscheidungen. Bash und PowerShell erhalten die
gleichwertige Option `--stage-b-action` beziehungsweise `-StageBAction` mit
den Werten `Preflight`, `Validate`, `Deliver`, `Resume` und `Verify`. Jeder
Wrapper startet genau einen Engine-Prozess.

**Rationale / Begründung**: Stage A besitzt bereits Manifest-, Profil-, Pfad-,
Budget-, Hash-, Retry-, Redaktions- und atomare JSON-Logik. Wiederverwendung
bewahrt semantische Parität und vermeidet eine zweite Runtime. Python startet
Git und `gh` ausschließlich als Executable plus Argumentarray mit
`shell=False`.

**Alternatives considered / Erwogene Alternativen**:

- eigene Bash-/PowerShell-Engines: verworfen wegen Entscheidungsdrift;
- neuer .NET-Dienst: verworfen als unnötige Runtime und Supply-Chain-Fläche;
- parallele Worker: verworfen, weil die fachliche Reihenfolge und der Stop vor
  dem nächsten Ziel serialisierte Writer verlangen.

## 2. Flottenidentität / Fleet Identity

**Decision / Entscheidung**: Die Stage-A-Funktion für die autoritative Union
wird wiederverwendet. Jede Zeile bindet stabile Registry-ID, normalisierte
erwartete Remote-Identität, numerische GitHub-Repository-ID, kanonischen
Provider-Slug, Sichtbarkeit und Default Branch. Manifest, Assignments,
Inventory und Rolloutplan müssen dieselbe sortierte ID-Menge enthalten.
Provider-Umbenennung oder ID-/Slug-Konflikt blockiert; er wird nicht geraten.

**Rationale / Begründung**: Die Registry-ID ist der fachliche Join-Key, die
numerische Provider-ID schützt die Remote-Mutation vor Namens- oder
Suchdrift. Der aktuelle Snapshot `1 + 47 = 48` bleibt Information, keine
Konstante. Collection-Knoten sind strukturell ausgeschlossen.

**Alternatives considered / Erwogene Alternativen**:

- Slug oder lokaler Pfad als alleinige Identität: verworfen wegen Rename- und
  Pfaddrift;
- GitHub-Suche zur automatischen Reparatur: verworfen als mehrdeutig;
- fest codierte 48 Ziele: verworfen, weil die Live-Menge autoritativ ist.

## 3. Getrennter Stage-B-Zustand und Evidence / Separate Stage-B State and Evidence

**Decision / Entscheidung**: Stage B verwendet fünf neue, einzeln versionierte
Verträge: `StageBRolloutPlan` v1.1, `StageBRunState` v1.1,
`RepositoryRolloutResult` v1.1, `StageBRulesetPlan` v1.0 und
`FleetTerminalEvidence` v1.1. Die vier v1.1-Verträge tragen die bereits
festgelegten unveränderlichen Planbindungen beziehungsweise die direkte
Repository-/PR-Head-Bindung; der in sich geschlossene Ruleset-Plan benötigt
keine solche Revision. Der allgemeine `autonomous-run-state.json` referenziert
nur Pfad und Hash. Vollständige laufende Evidence liegt im ignorierten
Run-Root; nur eine redigierte terminale Form darf versioniert werden.
Stage-A-Schemas bleiben unverändert.

**Rationale / Begründung**: Stage A beschreibt absichtlich
`remoteConverged=false`. Eine Erweiterung dieser Historie würde frühere
Evidence semantisch umdeuten. Separate Verträge erlauben Stop/Resume,
Teilkonvergenz und kausale Pre-/PostMerge-Evidence ohne Migration historischer
Daten.

**Alternatives considered / Erwogene Alternativen**:

- Stage-A-Plan in-place erweitern: verworfen wegen historischer
  Inkompatibilität;
- nur Markdown-Logs: verworfen, weil Übergänge, Hashes und Vollständigkeit
  nicht fail-closed validierbar wären;
- Rohproviderantworten speichern: verworfen wegen Secrets, privaten Pfaden und
  unnötigen Personen-/Providerdaten.

## 4. Provider- und Pull-Request-Lifecycle / Provider and PR Lifecycle

**Decision / Entscheidung**: `gh` CLI ist die GitHub-first-Oberfläche. Reads
verwenden GET, `gh pr view/checks` und `git ls-remote`. Writes verwenden feste
Argumentlisten für `git push`, `gh pr create`, `gh pr merge` und
`gh api --input`. Jeder nichtleere Git-Diff erhält einen deterministischen
laufgebundenen Branch und einen PR. Das Mergeverfahren wird vor dem PR aus den
aktuellen Providerfähigkeiten deterministisch als `merge`, sonst `squash`,
sonst `rebase` fixiert; fehlt jedes Verfahren, blockiert der Plan.

**Rationale / Begründung**: `gh` nutzt die vorhandene authentifizierte
Sitzung, ohne Token in Argumente oder Dateien zu kopieren. Der fixierte
Kandidat, die konkrete Check-Suite, reguläre Review und Mergefakten bleiben
prüfbar. Mutable Token werden unmittelbar vor der Aktion neu gelesen.

**Alternatives considered / Erwogene Alternativen**:

- direkte HTTP-Bibliothek: verworfen als neue Auth-/Dependency-Fläche;
- Provider-Sammelstatus statt konkreter Jobs: verworfen, weil ein grüner Name
  keine Runner-/Befehlsidentität beweist;
- Force-Push oder Wiederverwendung fremder Branches: verworfen, weil fremde
  Arbeit überschrieben werden könnte.

## 5. Rulesets und privater Minimal-Gate / Rulesets and Private Minimal Gate

**Decision / Entscheidung**: Für Private Governance/Scaffold wird das
Stage-A-Workflowtemplate per normalem PR nach
`.github/workflows/home-baseline-ci-minimal-gate.yml` materialisiert. Nach
Merge wird ein benannter Default-Branch-Ruleset mit PR-Pflicht, regulärer
Review, exakt `home-baseline/ci-minimal-gate`, strikter Statusprüfung und ohne
Bypass-Akteure erstellt oder minimal gepatcht. Vorzustand, numerische
Ruleset-ID und exakter Restore-Request werden vorab gebunden. Bei fehlerhafter
Post-Write-Prüfung wird höchstens dieser Restore versucht und anschließend
immer gestoppt.

**Rationale / Begründung**: Workflow per PR und Ruleset als separate
Providertransaktion entsprechen den tatsächlichen GitHub-Grenzen. Der enge
Restore reduziert Lockout-Risiko, ohne einen allgemeinen Rollbackmechanismus
oder automatische Revert-PRs einzuführen. Lokaler Hook und Serverregel bleiben
unabhängige Defense-in-Depth-Schichten.

**Alternatives considered / Erwogene Alternativen**:

- Ruleset vor Workflow-Merge aktivieren: verworfen wegen Lockout-/fehlender-
  Status-Risiko;
- Branch Protection und Ruleset gleichzeitig verwalten: verworfen wegen zwei
  konkurrierender Wahrheiten;
- pauschaler Admin-Bypass-Akteur im Ruleset: verworfen, weil der Bypass nur
  ziel- und zeitgebunden sein darf.

## 6. No-op und Idempotenz / No-op and Idempotency

**Decision / Entscheidung**: Ein No-op benötigt Gleichheit des geplanten und
aktuellen Git-Trees sowie semantische Konvergenz von Profil, Workflows, Gates
und Ruleset. Ein leerer Git-Diff kann eine notwendige Ruleset-Transaktion
besitzen; erst nach deren erfolgreicher Verifikation entsteht No-op-Evidence.
Kein Branch, Commit oder PR wird für einen leeren Diff erzeugt. Jede Aktion
hat einen stabilen Idempotency Key aus Run, Ziel, Aktion, Heads und Planhash.

**Rationale / Begründung**: Bytegleichheit allein beweist keine
Providerkonvergenz, ein leeres PR ist aber ebenfalls kein zulässiger Auditpfad.
Der Idempotency Key erlaubt Resume, ohne doppelte PRs oder Rulesets zu erzeugen.

**Alternatives considered / Erwogene Alternativen**:

- leeren PR als Marker erstellen: verworfen durch AC-SBR-006;
- nur Dateibytes vergleichen: verworfen, weil Ruleset-/Workflowsemantik fehlen
  kann;
- Zeitstempel in den Entscheidungshash aufnehmen: verworfen, weil identische
  Entscheidungen dann nicht stabil wären.

## 7. Retry, Stop und Resume / Retry, Stop, and Resume

**Decision / Entscheidung**: Read-only-Transportfehler erhalten maximal drei
Versuche mit injizierbarer Uhr/Jitter und begrenztem `Retry-After`. Mutierende
Aktionen werden nicht blind wiederholt; nach unklarem Ergebnis folgt zuerst
read-only Reconciliation über den Idempotency Key. Auth, 403, 404, Schema,
Head, Review, Gate, Ruleset, Budget und Evidence-Fehler sind nicht transient.
Der erste nicht behebbare Fehler persistiert `Stopped` vor dem nächsten Ziel.
Resume verwendet dieselbe Run-ID und revalidiert die gesamte Flotte.

**Rationale / Begründung**: Ein erneuter POST/PATCH nach Timeout könnte einen
doppelten PR oder Ruleset erzeugen. Reconciliation trennt „Antwort verloren“
von „Aktion nicht erfolgt“. Vollständige Revalidierung verhindert Fortsetzung
auf veralteter Authority oder Flottenbasis.

**Alternatives considered / Erwogene Alternativen**:

- automatischer unbegrenzter Retry: verworfen wegen Duplikaten und Hängen;
- neuer Run für Resume: verworfen, weil Teilkonvergenz und Authority-Historie
  verloren gingen;
- automatischer Revert bereits gemergter Ziele: verworfen durch Scope und
  Intake.

## 8. Budget / Budget

**Decision / Entscheidung**: Das Stage-A-Decimal-Modell wird nach jeder der
fünf Wellen mit frischen Workflow-/Laufzeitdaten neu ausgeführt. Jede
Projektion bindet Inventory-, Plan- und Vorgänger-Wellenhash. Private Actions
müssen `<500` von `3000` Minuten/Monat bleiben. Copilot-Kategorien bleiben
separat; unbekannte Werte blockieren.

**Rationale / Begründung**: Wellen können Trigger und gemessene Dauer ändern.
Nur eine neue Projektion vor der nächsten Welle schützt die bindende
Budgetgrenze. Decimal und `52/12` bewahren Plattformdeterminismus.

**Alternatives considered / Erwogene Alternativen**:

- einmalige Projektion vor Rollout: verworfen wegen durch Rollout geänderter
  Providerdaten;
- fehlende Werte als Null: verworfen als künstlich grünes Budget;
- Copilot- und Actions-Minuten summieren: normativ verboten.

## 9. Kausale Evidence und terminale Konvergenz / Causal Evidence and Terminal Convergence

**Decision / Entscheidung**: Repository-Evidence trennt PreMerge und
PostMerge. PreMerge bindet Kandidaten-Head, Tree, Diff, Gates, Review und
Authority. PostMerge bindet den normalisierten PreMerge-Hash, Provideraktion,
Merge-Commit, synchronisierten Default-Head und read-only Endprüfung. Terminale
Evidence ist die sortierte, vollständige Aggregation aller Repository-
Resultathashes plus fünf Budgetprojektionen und G4-Nichtmutationsnachweis.

**Rationale / Begründung**: Merge verändert den Head und selbstinvalidiert eine
reine Kandidatenprüfung. Eine kausale Folge zeigt, dass genau der akzeptierte
Kandidat zum beobachteten Merge führte. Die terminale Mengengleichheit
verhindert still ausgelassene Ziele.

**Alternatives considered / Erwogene Alternativen**:

- ein einziges nachträglich überschriebenes Resultat: verworfen, weil die
  Beweiskette verloren ginge;
- Evidence-only-PR je Ziel: verworfen wegen rekursiver PR-Schleife;
- Erfolg aus PR-Status ableiten: verworfen, weil Default-Sync und Ruleset-
  Endzustand fehlen.

## 10. Teststrategie und Vertical Slice / Test Strategy and Vertical Slice

**Decision / Entscheidung**: Gemeinsame Fixtures testen Verträge,
Mengengleichheit, Reihenfolge, Argumentlisten, Metazeichen, Traversal, SSRF,
Redaction, Providerfehler, PR-/Review-/Gate-Lifecycle, Ruleset-Restore,
No-op, Budget, Stop/Resume und G4-Isolation. `agent-operations-cockpit` ist der
erste Public-Canary-Slice. Ein roter Lauf muss vor jeder Mutation exakt
blockieren; der grüne Fake-Provider-Lauf muss die vollständige Transaktion und
ein duplikatfreies Resume beweisen. Erst danach ist Live-Delivery zulässig.

**Rationale / Begründung**: Ein Public Canary bildet den realen Lifecycle ab,
begrenzt aber den Radius. Deterministische Fake-Provider-Fälle beweisen
Fehlerpfade ohne Remote-Mutation; native Plattformnachweise ergänzen die
gemeinsame Semantik.

**Alternatives considered / Erwogene Alternativen**:

- zuerst vollständige Flotte liefern: verworfen wegen zu großem Fehlerradius;
- nur Unit Tests: verworfen, weil Wrapper, Provideradapter und Evidence-Kette
  unbewiesen blieben;
- Live-E2E als einziger Test: verworfen wegen Nichtdeterminismus und
  unerlaubter Testmutation.
