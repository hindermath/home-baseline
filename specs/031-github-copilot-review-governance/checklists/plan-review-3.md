# Drittes Plan-Re-Review: TerminalAwareRunnerAdoption / Third Plan Re-Review: TerminalAwareRunnerAdoption

**Phase / Phase**: `plan-review-3`  
**Datum / Date**: 2026-08-29  
**Run-ID / Run ID**: `1b7788fb-81f3-4d76-8006-885d834dd454`  
**Vorgänger / Predecessor**: `plan-remediation-4`  
**Ergebnis / Outcome**: `Passed`  
**Review-Scope**: unabhängiges, hochstrenges Plan-/Research-Review; kein späteres vollständiges Tasks-Analyze  
**Offene Findings / Open findings**: `0`

## Disposition und Grenze / Disposition and Boundary

Das remediierte Plan-/Research-Design besteht. `TerminalAwareRunnerAdoption`
schließt `TA-007` im Plan-/Research-Scope durch einen exakten, fail-closed
Parent-/Child-Vertrag. Der Vertrag gilt nur für die exakte Routingphase
`implement-closeout` und erhält das heutige parent-owned Verhalten aller
normalen Phasen. Er ändert keine fachliche G4-Anforderung, keine Zielmenge,
keinen Acceptance-Gate-Befehl und keine Provider-, Delivery-, Bypass- oder
Accountautorität.

*The remediated Plan/Research design passes. `TerminalAwareRunnerAdoption`
closes `TA-007` in the Plan/Research lane with an exact fail-closed parent/child
contract. It applies only to exact `implement-closeout`, preserves normal phase
behaviour, and grants no additional provider, delivery, bypass, account, Home,
subscription, budget, cancellation, or Position-7 authority.*

Die installierte Runner-Implementierung enthält die Korrektur noch nicht. Das
ist der ausdrücklich geplante Implementierungszustand und kein offener
Planbefund: Plan Phase 0 ordnet Runner, Fixture, Tests, Hilfe und Manpage vor
jedem G4-Produktedit ein. Der aktuelle DAG führt nach diesem Review über
`tasks-remediation-6` und `analyze-4`; `/speckit.implement` darf vorher nicht
starten. Die Implementierungs- und Tasks-/Analyze-Gates bleiben daher offen,
ohne die bestandene Plan-Disposition vorzutäuschen.

## Exakte Reviewmetriken / Exact Review Metrics

| Bereich / Area | Ergebnis / Result | Evidence |
|---|---:|---|
| Feature-Artefakte vor diesem Receipt | `24/24` | Spec, Plan, Research, Data Model, Quickstart, Tasks, 8 Contracts, State, Evidence, Gate-Requirements und 7 bestehende Checklists gelesen |
| Funktionale Anforderungen | `18/18` | `CRG-001..018` unverändert |
| Übergreifende Anforderungen | `10/10` | `CR-001..010` unverändert |
| Acceptance Criteria | `10/10` | `AC-CRG-001..010` unverändert |
| Erfolgskriterien | `12/12` | `SC-001..012` unverändert |
| Exakte Repository-/Branch-Ziele | `8/8` | Desired-State-Schema und Plan |
| Validatorgebundene exakte Gate-Befehle | `10/10` | Je ein identischer vollständiger Befehl in Spec, Plan und Gate-JSON |
| Provider-Operationsklassen | `9/9` | `AccountSetting`, `EffortLevel`, drei Rulesetklassen, zwei Acceptanceklassen, `Delivery`, `Rollback` |
| Rollback-Quellklassen | `8/8` | Closed-world Enum und klassenspezifische Grenzen |
| Account-Identitäts-Vertragsfamilien | `4/4` | Mutation Plan, External Write Gate, Mutation Result, Rollback |
| Accountidentität | `4/4` | exakt `accountOwner=hindermath`; Missing/Mismatch und Fremd-IDs bleiben fail-closed |
| Tasks-Struktur | `168/168` | eindeutige, fortlaufende Checkboxen `T001..T168` |
| Tasks-Pflichtfelder | `168/168` je Feld | Trace, Gate/Authority, Evidence, Owner/Reviewer, Verify |
| Stable-Key-Abdeckung in Tasks | `50/50` | 18 CRG, 10 CR, 10 AC-CRG, 12 SC |
| Akzeptierte Artefakthashes | `10/10` | aktueller Run-State gegen Disk |
| Abgeschlossene geroutete Phasenergebnishashes | `16/16` | aktueller Run-State gegen Disk |
| Constitutions | `2/2` | bytegleich, v1.21.0, SHA-256 `1d146f90d35be75ece1f5fd41bca5cf488a8861002fe28943072195fde3f26df` |
| TA-007 Adoptionsvertragsfamilien | `12/12` | Scope, Identität, Terminalität, Tasks, Resultat, Routing, Git, Evidence, Writerverzicht, Drift, Sicherheit, Nachweise |
| Deterministische Runner-Szenarien im Plan | `6/6` | normal, exakt terminal, Mismatch, ungewisse Drift, definitiver Fehler, Catch-Drift |
| Bestehende Runner-Direkt-/Wrapper-Tests | `2/2 Passed` | PowerShell-Direkttest und Bash-Wrapper; heutiges nichtterminales Verhalten |
| Neue Findings Critical / High / Medium / Low | `0 / 0 / 0 / 0` | unabhängiges Re-Review nach Plan-Remediation 4 |
| Unaufgelöste Medium-Findings | `0` | kein Plan-/Research-Reparaturbedarf |

Aktuelle Hashbindungen:

- `plan.md`: `3a83f394f0498fb7d5f9d528a4d2ef41bb2eb22f552ea0ee850bfb913fa10986`
- `research.md`: `c6cf97dcdc0c975a0e8a70acb45364906d636516d079aaa5ed01aec2c67628d8`
- `tasks.md`: `c991192ee61422575e186989648efd588c03dd160f020dbc2e95fe60c5b425cf`
- `plan-remediation-4.result.json`: normalisiert `a2b673b1c26ec95ee0c9d43248bb8a9b4596ab5357874ceef47db468adaaac9a`; Payload ist der aktuelle Planhash.

## TerminalAwareRunnerAdoption-Vertragsprüfung / Runner Adoption Contract Review

| ID | Erforderliche Eigenschaft / Required property | Ergebnis | Exakte Evidence / Exact evidence |
|---|---|---|---|
| `TA-C01` | Nur exaktes `implement-closeout`; normale Phasen unverändert | `Pass` | `plan.md:294-299,319-325`; `research.md:296-315` |
| `TA-C02` | Exaktes Schema, Run-ID, Featurepfad, Branch und `MergeAndSync` | `Pass` | `plan.md:303-307,350-352`; aktueller State bindet Schema `1.1`, Run-ID, Featurepfad, Branch und Delivery-Modus |
| `TA-C03` | Reloaded State exakt `Completed/168/168`, alle Closeoutfelder terminal, `nextExactAction=N/A` | `Pass` | `plan.md:353-362`; State-Validator bleibt obligatorisch |
| `TA-C04` | Exakter Resultpfad/-hash, Exitcode und vollständige Routingmetadaten | `Pass` | `plan.md:314-318,363-370`; vorhandener semantischer Phase-Result-Validator wird vor Adoption ausgeführt |
| `TA-C05` | Tasksdatei, Hash, `T001..T168`, Git-Blobs und Evidence vollständig validiert | `Pass` | `plan.md:359-384`; `research.md:299-305` |
| `TA-C06` | Exakte einparentige `Active/NeedsRevalidation/167/168`-zu-`Completed/168/168`-Gitbeziehung | `Pass` | `plan.md:376-384`; normaler nicht erzwungener Fast-forward bleibt bindend |
| `TA-C07` | Nach exakter Adoption null Parent- oder Catch-Writer auf Featurepfade | `Pass` | `plan.md:324-342`; best-effort Log/Resultat bleibt ausschließlich `runnerLocal` |
| `TA-C08` | Nicht exakte Child-Drift bleibt bytegleich erhalten und endet read-only fail-closed | `Pass` | `plan.md:308-313,334-342`; deterministischer Code `TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION` |
| `TA-C09` | Definite Failure ohne Drift und normale Success-Pfade behalten heutige Semantik | `Pass` | `plan.md:308-323`; `research.md:313-315` |
| `TA-C10` | Keine alternative kanonische Statequelle, kein Result-/State-/Self-Commit-Zyklus | `Pass` | `plan.md:294-296,329-338,376-384`; `research.md:317-353`; Resultat und State behaupten keinen eigenen Terminal-Commit- oder späteren Pushfakt |
| `TA-C11` | Sichere Pfade, Symlink/Reparse-Abweisung, direkte Git-Argumentarrays, doppelte TOCTOU-Prüfung | `Pass` | `plan.md:346-393`; `research.md:329-337` |
| `TA-C12` | Tests, Help/Manpage, drei bytegleiche Quellen, macOS/Linux/Windows-Proof und Implementierungsordnung | `Pass` | `plan.md:462-505,565-605,697-713` |

## Deterministische Test- und Dokumentationsmatrix / Deterministic Test and Documentation Matrix

Der Plan verlangt sechs getrennte Assertions und verhindert einen grünen
Sammelfall:

1. normale nichtterminale Success-Phase mit heutigem Parent-Write;
2. exakte terminale Adoption mit byte- und hashgleichem Child-State nach Return;
3. Resultidentitäts-, Resultpfad- oder Resulthash-Mismatch;
4. `Active`-/`NeedsRevalidation`-Drift als ungewisser read-only Fall;
5. definitiver Child-Fehler ohne Drift mit heutiger atomarer Blocked-Semantik;
6. Exception/Catch nach Child-Drift ohne stale Overwrite.

`fixture-model-runner.ps1` erzeugt dafür State-/Tasks-/Resultprojektion sowie
lokales Git-Repository und Bare-Remote ohne Netzwerk oder Provider. Der
PowerShell-Test prüft Bytes, Hashes und Refs; der Bash-Test führt dieselbe
Matrix über die bestehende Delegation aus. PowerShell-Comment-Help und die
vorhandene Manpage werden in Installed-, Scaffold- und Repository-Quelle
zusammen aktualisiert. Ein neues Skript oder eine neue Manpage ist nicht nötig.

Die heutigen Tests wurden als Baseline ausgeführt und bestanden:

- `pwsh -NoProfile -File .specify/presets/autonomous-run-governance/tests/test-model-routing.ps1`
- `bash .specify/presets/autonomous-run-governance/tests/test-model-routing.sh`
- Bash-Syntaxprüfung beider Wrapper und PowerShell-Parserprüfung des Runners
- Bytegleichheit der geplanten Runner-, Fixture-, Test-, Wrapper- und Manpage-Flächen in allen drei lokalen Quellen

Diese Baseline beweist nicht vorzeitig die noch zu implementierende
Terminaladoption. Erst die nach Tasks-Remediation implementierte 6/6-Matrix,
PSScriptAnalyzer, Secret Scan, Run-State-Validator, `cmp`-Gates und native
Linux-/Windows-Nachweise schließen das Implementierungsgate.

## Stable Finding Closure Register

| ID | Severity | Disposition | Exakte Location / Exact location | Owner | Evidence |
|---|---|---|---|---|---|
| `PR-001` | High | `Closed, revalidated` | `spec.md`; `plan.md`; Gate-Requirements | Autonomous Gate Owner | Gate-/Befehlsübereinstimmung `10/10` |
| `PR-002` | High | `Closed, revalidated` | `spec.md`; `plan.md`; Gate-Requirements | Provider Authority Owner | Delivery bleibt von Providerautorität getrennt |
| `PR-003` | High | `Closed, revalidated` | Data Model; External-Write-/Mutation-Plan-Schemas | Contract Owner | Create/Update/Disable und `9/9` Klassen closed-world |
| `PR-004` | Medium | `Closed, revalidated` | `plan.md`; Data Model; Desired-State-/Inventory-Schemas | Architecture Owner | Selektor und Liveidentität bleiben getrennt |
| `PR-005` | High | `Closed, revalidated` | `spec.md`; `plan.md`; Gate-Requirements | Autonomous Gate Owner | zehn vollständige Primary-Befehle |
| `PR-006` | High | `Closed, revalidated` | External-Write-Gate-Schema; `plan.md`; `spec.md` | Security and Provider Authority Owner | Delivery akzeptiert keine Provider-Methoden/-Scopes |
| `PR-007` | High | `Closed, revalidated` | Mutation-Plan/-Result-/Rollback-Schemas; Data Model | Transaction and Rollback Owner | Exact-ID und Post-Inventur bleiben verpflichtend |
| `PR-008` | High | `Closed, revalidated` | `spec.md`; `plan.md`; Quickstart | Architecture Owner | PowerShell 7/.NET Kern, Bash Adapter, Python nur Testhilfe |
| `PR-009` | High | `Closed, revalidated` | Terminal-Evidence-Schema; Data Model; Gate-Requirements | Acceptance Evidence Owner | exakte Plattform-/Gate-Mengen |
| `PR-010` | Medium | `Closed, revalidated` | `plan.md`; Data Model; Desired-State-Schema | Architecture and Contract Owner | Target Selector bleibt exakt dreifeldig |
| `PR-011` | Medium | `Closed, revalidated` | Run Evidence; Run State | Autonomous Run Owner | feature-lokaler State bleibt kanonisch und validatorgültig |
| `PR-012` | Low | `Closed, revalidated` | `spec.md`; `plan.md`; Quickstart | Documentation Owner | kanonischer Produkt-Manpage-Pfad unverändert |
| `TA-006` | Critical | `Closed, revalidated` | vier Account-Vertragsfamilien | Provider Authority and Contract Owners | `accountOwner=hindermath`, `4/4` |
| `TA-007` | Critical | `Closed in Plan/Research` | `plan.md:292-408`; `research.md:294-361`; heutiger Konflikt `invoke-autonomous-model-phase.ps1:473-551` | Autonomous Run Owner / Runner Governance Owner / Repository Owner | exakter Adoptionsvertrag `12/12`; Implementierung bleibt gesondertes blockierendes Gate |

Es gibt keine neue oder wieder geöffnete Finding-ID. Die offene
Implementierungsdisposition von `TA-007` ist kein akzeptiertes Risiko und keine
Finding-Unterdrückung: Sie sperrt ausdrücklich jeden G4-Produktedit, bis Tasks,
Runner, Fixture, Tests, Help/Manpage und Analyze vollständig konvergiert sind.

## Governance- und Scope-Revalidierung / Governance and Scope Revalidation

- Beide Constitutions sind bytegleich und die MSL-, Secure-Coding-,
  Cross-Platform-, A11Y-, Dokumentations-, Statistik- und Autonomous-Regeln
  bleiben erfüllt.
- Der aktuelle Run-State-Validator meldet `PASS`, Stage `Tasks`, Status
  `Active`, Tasks `0/168`; `plan-review-3` ist die laufende Phase und
  `plan-remediation-4` ist hashgültig abgeschlossen.
- `MergeAndSync` bleibt der Git-Liefermodus. Regulärer Push/Merge kommt zuerst;
  Admin-Bypass bleibt auf denselben alten/neuen Head, `force=false` und einen
  exakten `ProtectionOnlyRefusal` begrenzt. Kein Ruleset oder Schutz wird dafür
  geändert.
- Die neun Provider-Operationsklassen, acht Rollbackquellklassen und vier
  Accountfamilien bleiben unverändert. Credentials, Delivery-Modus oder Bypass
  gelten nie als Providerautorität.
- Keine zweite kanonische Statequelle wird eingeführt. Runtime-Resultate und
  Logs sind ausschließlich maschinenlokale Evidence.
- Position 7, Provider-/GitHub-Settings, Subscription, Budgetkauf,
  Cancellation, Home-Sync und Serienzustand wurden nicht mutiert oder gestartet.

## Gate-Disposition

`Passed` für `plan-review-3`: `18/18` CRG-Anforderungen, `10/10`
Acceptance-Gates, `12/12` Erfolgskriterien, `8/8` Ziele, `10/10` exakte
Gate-Befehle, `9/9` Provider-Operationsklassen, `8/8` Rollbackquellklassen,
`4/4` Account-Identitätsfamilien und der `12/12` TA-007-Runnervertrag sind
vollständig und widerspruchsfrei. Es bestehen `0` Critical, `0` High und `0`
unaufgelöste Medium Findings. Plan oder Research benötigen keine weitere
Reparatur.

**Nächste erlaubte Phase / Next allowed phase**: ausschließlich die vom Runner
abhängig gestartete `tasks-remediation-6`; danach vollständiges `analyze-4`.
Implementierung, Delivery und Position 7 bleiben gesperrt.

**Documentation Impact**: `NoUpdateRequired` für diese ausschließlich
prüfende Phase; dieser Receipt ist die vorgeschriebene `sourceOnly`-
Review-Evidence. Die featureweite Entscheidung bleibt `UpdateRequired`.
Home-Sync ist nicht erforderlich. Re-Evaluation erfolgt bei jeder Änderung an
Plan, Research, Spec, Contracts, Tasks, Runner, Fixture, Tests, Help/Manpage,
Constitutions, Run-State, Routingprofil, Authority oder den gebundenen Hashes.
