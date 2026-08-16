# Workitem: Feature-038-Folgearbeit für autonome Evidence-Integrität / Feature 038 Autonomous Evidence Integrity Follow-up

- Status: umgesetzt in `autonomous-run-governance` v0.4.1 / implemented in `autonomous-run-governance` v0.4.1
- Owner: Maintainer von `autonomous-run-governance`
- Datum / Date: 2026-08-09
- Ursprung / Origin: TuiVision Feature 038, Portfolio-Conformance-Audit
- Entscheidung / Decision: `Promote`
- Dokumentationsauswirkung / Documentation impact: `FollowUp`

## Umsetzungsabschluss / Implementation Closeout

Feature 028 hat alle drei providerneutralen Befunde unabhängig reproduziert,
in Bash und PowerShell validiert und in Version 0.4.1 produktisiert. Die
öffentlichen Preset-PRs
[#16](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/16)
und
[#17](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/17)
sind gemergt. Das Release `v0.4.1` ist über die versionierte GitHub-ZIP
installierbar; deren geprüfte SHA-256 lautet
`3b12b0415ff5da5187620f4f420689c7cb2d6421527dc0d56fcae6a600519f6e`.

Die unabhängigen Feldnachweise stehen unter
`specs/028-autonomous-evidence-integrity-field-validation/`. Die dynamische
Flottenauslieferung erreichte Home Baseline und 35 anwendbare Level-1/2-
Verbraucher ohne Produktcodeänderung. Der Community-Katalog-Folgeprozess wurde
seriell über [github/spec-kit#4153](https://github.com/github/spec-kit/issues/4153)
angestoßen; dessen externer Abschluss ist keine lokale Abschlussbedingung.

*Feature 028 independently reproduced all three provider-neutral findings,
validated them in Bash and PowerShell, and productized them in version 0.4.1.
Public preset PRs #16 and #17 are merged. The versioned GitHub ZIP is
installable and has the verified SHA-256 shown above. Field evidence lives
under the Feature 028 directory, and the serial community-catalog follow-up is
tracked in github/spec-kit#4153 without blocking local completion.*

## Zweck und Berechtigungsgrenze / Purpose and Authority Boundary

Dieses Workitem übergibt drei reproduzierbare, providerneutrale Erkenntnisse
aus einem realen `MergeAndSync`-Lauf an Home Baseline. Es autorisiert weder
eine Preset-Implementierung noch Versionsänderung, Veröffentlichung, Release,
Katalogänderung, Merge, Admin-Bypass oder Änderung eines Konsumenten-
Repositories. Diese Aktionen benötigen einen eigenen Auftrag und neue
Authority-Evidence.

*This work item hands three reproducible, provider-neutral findings from a real
`MergeAndSync` run to Home Baseline. It authorizes no preset implementation,
version change, publication, release, catalog update, merge, admin bypass, or
consumer-repository change. Those actions require a separate instruction and
fresh authority evidence.*

## Unveränderliche Feldnachweise / Immutable Field Evidence

| Evidence | Wert / Value |
|---|---|
| TuiVision Feature | `038-example-portfolio-conformance-audit` |
| Feature-PR und exakter Head / Feature PR and exact head | [TuiVision #144](https://github.com/hindermath/TuiVision/pull/144), `ca0cdf413187efd4710a6bf6436f1863c67bcdcd` |
| Feature-Merge / Feature merge | `b59a3fe46e3868728be3557df7f367b8ab832db1` |
| Guard-Voraussetzung / Guard prerequisite | [TuiVision #145](https://github.com/hindermath/TuiVision/pull/145), Merge `92efcf6f2db832b33026ef83077c3e6d361abd79` |
| Kausaler Closeout / Causal closeout | [TuiVision #146](https://github.com/hindermath/TuiVision/pull/146), Head `ab5c3bd5b5db420dae5300332428f5546a1451c4`, Merge `6f589f3e8808e4728b9839dd9179336e8e87ef1e` |
| Retrospektive / Retrospective | `6f589f3e8808e4728b9839dd9179336e8e87ef1e:specs/038-example-portfolio-conformance-audit/retrospective.md`, Git-Blob `c1f5db4e6b45ec0dd4e8a6ca5339406e0ea789b0` |
| Delivery-Closeout | `6f589f3e8808e4728b9839dd9179336e8e87ef1e:specs/038-example-portfolio-conformance-audit/delivery-closeout.md`, Git-Blob `0729fb0d9ffbfd8a9ee27a02c52a13666a1cb7aa` |
| PR-Evidence | `6f589f3e8808e4728b9839dd9179336e8e87ef1e:specs/038-example-portfolio-conformance-audit/pr-evidence.md`, Git-Blob `0822dfbe04f7d853489dde09d9d93b5a2125699f` |
| Exact-Head-Gate-Evidence | 11/11 Primary-Gates unter Bash und PowerShell; temporäre Evidence SHA-256 `1e51f860a7a81ad416665e2fbee2e5545a77f672eb66adc7bbbeb4bf43966481` |
| Laufabschluss / Run completion | `Retrospective`, `Completed`, 225/225 Tasks, `nextExactAction: N/A` |

Der Closeout-PR hatte 31 erfolgreiche technische Check-Einträge, einen
erwartet übersprungenen Pages-Deploy-Job, null Fehler oder offene Checks und
null Review-Threads. Der genehmigte enge Admin-Bypass ersetzte ausschließlich
Human Approval. Diese Provider-Fakten sind Feldnachweis, aber keine
fortdauernde Berechtigung für Home Baseline.

*The closeout PR had 31 successful technical check entries, one expected
skipped Pages deploy job, no failure or pending check, and no review thread.
The authorized narrow admin bypass replaced only Human Approval. These
provider facts are field evidence, not continuing authority for Home Baseline.*

## AR-038-01: Unversionierte Lieferdateien im Whitespace-Gate / Untracked Delivery Files in the Whitespace Gate

| Feld / Field | Bewertung / Assessment |
|---|---|
| Beobachtung / Observation | Gewöhnliches `git diff --check` meldete Erfolg, obwohl eine beabsichtigte unversionierte Lieferdatei nachgestellte Leerzeichen enthielt. Die pfadweise No-Index-Prüfung fand denselben Fehler deterministisch. / Ordinary `git diff --check` passed while an intended untracked delivery file contained trailing whitespace. A path-wise no-index check found it deterministically. |
| Artefaktart / Artifact kind | Validierungsskript, Runbook, Evidence- und Readiness-Checklist / validation script, runbook, evidence and readiness checklist |
| Providerneutrale Zielregel / Provider-neutral target rule | Vor einem positiven Whitespace- oder Scope-Gate die beabsichtigte Liefermenge read-only und deterministisch ermitteln. Getrackte Änderungen und jeder aufzunehmende unversionierte Pfad werden geprüft; ignorierte Laufzeit-Evidence bleibt ausgeschlossen. / Determine the intended delivery set read-only and deterministically before a positive whitespace or scope gate. Validate tracked changes and every untracked path intended for delivery while excluding ignored runtime evidence. |
| Projektspezifische Ausschlüsse / Project-specific exclusions | TuiVision-Allowlist, Feature-038-Pfade, Portfoliozahlen und konkrete Git-Dateinamen. / TuiVision allowlists, Feature 038 paths, portfolio counts, and concrete Git filenames. |
| Auftreten und Konfidenz / Occurrences and confidence | Ein deterministischer Feldfund / one deterministic field occurrence; `High` |
| Berechtigungsrisiko / Permission risk | Die Ermittlung darf keine Datei automatisch stagen, ändern, löschen oder als beabsichtigte Lieferung annehmen. Der Agent benötigt weiterhin ausdrückliche Commit-/Delivery-Autorität. / Discovery must not stage, modify, delete, or silently classify a file as intended delivery. Explicit commit and delivery authority remains required. |
| Reproduzierbarer Test / Reproducible test | Temporäres Git-Projekt mit einer sauberen getrackten Änderung, einer unversionierten Datei mit Whitespace-Fehler und einem ignorierten Evidence-Pfad. Gewöhnliches `git diff --check` bleibt als Kontrollwert grün; der neue Validator muss genau die beabsichtigte unversionierte Datei ablehnen und nach Korrektur bestehen. Bash und PowerShell müssen dieselben Pfade und Exitklassen liefern. / Use a temporary Git project with a clean tracked change, one untracked delivery file containing whitespace, and one ignored evidence path. The new validator must reject only the intended untracked file, then pass after correction, with Bash/PowerShell parity. |
| Entscheidung / Decision | `Promote` |

## AR-038-02: Semantische Phasenvervollständigung / Semantic Phase Completion

| Feld / Field | Bewertung / Assessment |
|---|---|
| Beobachtung / Observation | Ein gerouteter Modellprozess endete mit Exitcode 0, obwohl seine content-addressed Ausgabe ausdrücklich `Blocked`, 210/225 Tasks und keine Delivery-Aktion meldete. Der Wrapper setzte die Phase dennoch auf `Completed`. / A routed model process exited zero while its content-addressed output explicitly reported `Blocked`, 210/225 tasks, and no delivery action. The wrapper still marked the phase `Completed`. |
| Artefaktart / Artifact kind | Runner-Vertrag, strukturiertes Phasenergebnis, State-Validator, Resume-Runbook und negative Fixtures / runner contract, structured phase result, state validator, resume runbook, and negative fixtures |
| Providerneutrale Zielregel / Provider-neutral target rule | Exitcode 0 bleibt notwendig, aber nicht hinreichend. `Completed` benötigt zusätzlich ein versioniertes maschinenlesbares Ergebnis mit Outcome, erwarteten und abgeschlossenen Tasks, Blocked-Grund, Gate-Aussage, Ergebnis-Hash und eindeutigem Completion-Predicate. / Exit code zero remains necessary but insufficient. `Completed` also requires a versioned machine-readable result containing outcome, expected and completed tasks, blocked reason, gate assertion, result hash, and an unambiguous completion predicate. |
| Projektspezifische Ausschlüsse / Project-specific exclusions | TuiVision-Taskzahlen, Codex-Modellkennung, konkrete Resultattexte und Repository-Gates. / TuiVision task counts, Codex model identifier, concrete result wording, and repository gates. |
| Auftreten und Konfidenz / Occurrences and confidence | Ein content-addressed Feldfund mit rekonstruierbarem Resume / one content-addressed field occurrence with reconstructable resume; `High` |
| Berechtigungsrisiko / Permission risk | Ein falsches `Completed` kann nachfolgende Commit-, Push-, PR- oder Merge-Schritte zu früh freigeben. Das neue Predicate darf umgekehrt keinen erfolgreichen Lauf aus freiem Text erraten oder blockierende Ergebnisse überschreiben. / A false `Completed` can release later commit, push, PR, or merge work too early. The predicate must not infer success from free text or overwrite a blocking result. |
| Reproduzierbarer Test / Reproducible test | Ein temporärer Runner liefert Prozess-Exitcode 0 mit strukturiertem `Blocked` und unvollständigem Task-Zähler. Der Wrapper muss `NeedsRevalidation` oder `Blocked`, nie `Completed`, persistieren. Positive Fixture: Exitcode 0 plus vollständiges gültiges Ergebnis. Negative Fixtures: fehlendes, leeres, abgeschnittenes, hashfremdes, schemafremdes und widersprüchliches Ergebnis. / A temporary runner returns exit zero with structured `Blocked` and an incomplete task count. The wrapper must persist `NeedsRevalidation` or `Blocked`, never `Completed`. Cover valid, missing, empty, truncated, hash-mismatched, schema-mismatched, and contradictory results. |
| Entscheidung / Decision | `Promote` |

## AR-038-03: Lebenszyklusgebundene Exact-Head-Evidence / Lifecycle-Bound Exact-Head Evidence

| Feld / Field | Bewertung / Assessment |
|---|---|
| Beobachtung / Observation | Eine einzige Gate-Evidence-Datei verlangte zugleich Pre-Merge-Providerfakten und Post-Merge-Fakten. Ein ehrlicher Pre-Merge-Snapshot konnte deshalb das vollständige Schema nicht bestehen, obwohl die verfügbaren technischen Gates grün waren. / One gate evidence file required both pre-merge provider facts and post-merge facts. An honest pre-merge snapshot could therefore not satisfy the full schema even when all then-available technical gates passed. |
| Artefaktart / Artifact kind | Gate-Schema, Evidence-Template, Validatoren, Delivery-Runbook und Closeout-Contract / gate schema, evidence template, validators, delivery runbook, and closeout contract |
| Providerneutrale Zielregel / Provider-neutral target rule | Pre-Merge- und Post-Merge-Evidence erhalten getrennte Lifecycle-Snapshots mit Typ, Reviewed Head, Requirements-Hash, Zeit, Providerreferenz und SHA-256. Der Post-Merge-Snapshot bindet den akzeptierten Pre-Merge-Hash und ergänzt nur kausal später verfügbare Fakten. / Pre-merge and post-merge evidence use separate lifecycle snapshots with type, reviewed head, requirements hash, time, provider reference, and SHA-256. The post-merge snapshot binds the accepted pre-merge hash and adds only causally later facts. |
| Projektspezifische Ausschlüsse / Project-specific exclusions | GATE-038-IDs, TuiVision-PR-Nummern, Merge-Hashes und konkrete Checknamen. / GATE-038 IDs, TuiVision PR numbers, merge hashes, and concrete check names. |
| Auftreten und Konfidenz / Occurrences and confidence | Ein reproduzierter temporärer Gate-Test und ein realer MergeAndSync-Closeout / one reproduced temporary gate test and one real MergeAndSync closeout; `High` |
| Berechtigungsrisiko / Permission risk | Ein Pre-Merge-Snapshot darf keinen Merge behaupten oder autorisieren. Ein Post-Merge-Snapshot darf kein neues Produktdelta aufnehmen und keine rekursive Closeout-Kette erzwingen. / A pre-merge snapshot must not claim or authorize a merge. A post-merge snapshot must add no product delta and must not require recursive closeouts. |
| Reproduzierbarer Test / Reproducible test | Temporäres Repository mit einem grünen Pre-Merge-Head: Pre-Merge-Validator akzeptiert nur verfügbare Gates und lehnt Merge-Behauptungen ab. Danach bindet ein Post-Merge-Snapshot exakt dessen Hash und den tatsächlichen Merge. Negative Fixtures: falscher Head, falscher Requirements-Hash, fehlender Pre-Merge-Hash, geänderte frühere Evidence, Merge vor technischem Pass und rekursiver Closeout. Bash und PowerShell bleiben äquivalent. / Use a temporary repository with a green pre-merge head, then bind its exact snapshot hash from a post-merge snapshot. Reject wrong heads, wrong requirements hashes, missing or mutated pre-merge evidence, premature merge claims, and recursive closeout. |
| Entscheidung / Decision | `Promote` |

## Abgelehnte Projektdetails / Rejected Project-Specific Details

- Der TuiVision-Guard für sieben Serienziele plus einen separat authorisierten
  Intake bleibt projektspezifisch.
- Die zwei DocFX-Verzeichnislinks aus PR #143 bleiben TuiVision-Pflege.
- Portfolio-Kardinalitäten wie 37 Einträge, 46 Fixtures, 138 Sources und 128
  Evidence-Knoten werden nicht in ein Preset übernommen.
- Provider-, Modell-, Branch-, PR- und Gate-Kennungen aus Feature 038 sind nur
  Feldnachweis, keine Preset-Defaults.

*The TuiVision intake guard, DocFX link repair, portfolio cardinalities, and
concrete provider, model, branch, PR, or gate identifiers remain project-
specific evidence and must not become preset defaults.*

## Vorgesehene spätere Produktisierung / Intended Later Productization

Eine getrennt autorisierte Folgearbeit soll zuerst einen minimalen
providerneutralen Contract entwerfen und in temporären Git-Projekten testen.
Skriptänderungen benötigen Bash-/PowerShell-Parität. Erst nach grünen
synthetischen Tests, vorhandenen Preset-Regressionen, Stop-/Status-/Resume-
Regressionen und einem realen unabhängigen `MergeAndSync`-Feldlauf darf über
eine neue Preset-Version entschieden werden.

*A separately authorized follow-up should first design a minimal provider-
neutral contract and validate it in temporary Git projects. Script changes
require Bash/PowerShell parity. A preset version decision may follow only after
green synthetic tests, existing preset regressions, stop/status/resume
regressions, and an independent real `MergeAndSync` field run.*

## Dokumentationsvertrag / Documentation Contract

- Kanonische Quelle und Owner: dieses Workitem bis zur Annahme eines späteren
  Preset-Plans; danach die versionierten Preset-Verträge und Maintainer.
- Zielgruppen: Preset-Maintainer, Runner-Autoren und autonome Operatoren;
  Lernende benötigen nur die späteren sicheren Bedienpfade.
- Sprache und A11Y: German-first/English-second, CEFR-B2, textorientierte
  Status- und Fehlerpfade ohne farbabhängige Bedeutung.
- Distribution: vorerst `sourceOnly`; kein Home-Sync, keine Consumer-Adoption
  und keine Katalogänderung.
- Re-Evaluation: bei geändertem Runner-Ergebnisvertrag, neuem Delivery-Modus,
  neuem Gate-Lifecycle oder vor jeder Preset-Promotion.

*This work item is the canonical source until a later preset plan is accepted.
It remains source-only, requires no Home sync, and must be re-evaluated when
runner results, delivery modes, gate lifecycle, or promotion scope changes.*

## Abnahme dieses Handoffs / Handoff Acceptance

- Alle drei Regeln sind an unveränderliche TuiVision-Evidence gebunden.
- Projektspezifische Werte sind ausdrücklich ausgeschlossen.
- Für jede Regel sind Fehlergrenze, Permission-Risiko und reproduzierbare
  positive und negative Tests dokumentiert.
- Die ursprüngliche Entscheidung lautete dreimal `Promote`; Feature 028 hat
  diese drei Entscheidungen vollständig umgesetzt.
- Dieses Workitem bleibt als unveränderliche Herkunfts- und
  Abschlussreferenz erhalten; die eigentlichen Oberflächenänderungen sind an
  Feature 028, die öffentlichen Preset-PRs und das Release gebunden.

*All three rules remain bound to immutable evidence and exclude
project-specific values. Feature 028 completed their implementation; this
work item remains the provenance and closeout reference rather than the source
of the delivered surface changes.*
