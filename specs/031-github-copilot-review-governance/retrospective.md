# Retrospektive: GitHub-Copilot-Review-Governance / Retrospective

## Ergebnis / Outcome

Der autonome Lauf hat die Providerphase bis T151 abgeschlossen: persönliche
Accountautomation ist deaktiviert, genau acht Zielrepositories besitzen aktive
dedizierte Copilot-Review-Rulesets, 16 dedizierte Nichtzielrulesets sind
deaktiviert und erhalten, alle acht Effort-Werte sind `Lite`, und der zweite
Plan meldet `drift=0`, `writes=0`. PR-Lifecycle und manuelle Review-Verfügbarkeit
bleiben wegen des bis 2026-09-01 ausgeschöpften Kontingents wahrheitsgemäß
`Supplemental/Open`; es wurden weder ein künstlicher PR noch ein wirkungsloser
Reviewer-Request oder eine Aufstockung erzeugt.

*The autonomous run completed the provider phase through T151: personal account
automation is disabled, exactly eight target repositories have active dedicated
Copilot review rulesets, 16 dedicated non-target rulesets remain present and
disabled, all eight effort values are `Lite`, and the second plan reports
`drift=0`, `writes=0`. PR lifecycle and manual-review availability remain
truthfully `Supplemental/Open` because quota is exhausted until 2026-09-01; no
synthetic PR, ineffective reviewer request, or top-up was created.*

## Wiederverwendbare Beobachtungen / Reusable Observations

| ID | Quelle / Source | Beobachtung und Grenze / Observation and boundary | Art / Kind | Vorkommen / Confidence | Providerneutrale Zielregel und Test / Provider-neutral rule and test | Entscheidung |
|---|---|---|---|---|---|---|
| `G4-RET-001` | T128; `specs/030-stage-b-rollout/retrospective.md` | macOS-first kann native Linux-/Windows-Belege über eng berechtigte CI-Runner gewinnen. Plattformproof ersetzt keine Vollregression und muss exakten Head, Run, Job, Payload und Entscheidung binden. | Runbook, Evidence structure | 2 unabhängige Features / High | Ein temporäres Fixture auf Linux und Windows ausführen; beide Records müssen denselben Head-/Payloadhash, Exit `0` und Writes `0` tragen. | `Promote` |
| `G4-RET-002` | `operational/provider-results/pr-lifecycle.json`; `manual-review.json`; Stage-B-Retrospektive | Billing-/Quota-Unverfügbarkeit ist ein eigener Provider-Refusal, niemals Testpass, Approval oder Grund für einen Kauf. Ein nicht ausführbarer Request bleibt `Supplemental/Open` und erzeugt null Writes. | Checklist, evidence structure | 2 unabhängige Features / High | Ein synthetischer `QuotaUnavailable`-Provider muss `Open`, `providerWrites=0`, `humanApprovalReplacement=false` und keinen Purchase-Pfad liefern. | `Promote` |
| `G4-RET-003` | T134-T150; After-Inventur `445e4d21f88c79d0dbcc2073be9e15876b1332d527b318323b47fafd5b208d54` | Vollpagination ist teuer, aber ein unveränderter frischer Snapshot kann mehrere strikt serialisierte, exact-ID-gebundene Gates innerhalb seines Frischefensters tragen. Jede tatsächliche Mutation oder TTL-Überschreitung erzwingt eine neue Inventur. | Runbook, script requirement | 7 Operationsklassen / High | Fake-Inventur mit TTL testen: mehrere Read-only-/NoOp-Gates teilen denselben Hash; Mutation oder Ablauf muss fail-closed re-inventarisieren. | `Promote` |
| `G4-RET-004` | T145; PR-Lifecycle-Result `3033bcfd73cf701a0a6c76d1b4f5295f9381d2ef410014d053f4f4f5a39db9b5` | Ein natürlicher Feature-PR kann gebundene Beobachtungsteilstrecken ersetzen, aber fehlende historische Draft-/Push-Ereignisse nicht nachträglich beweisen. Künstliche Lifecycle-Writes sind ohne zusätzlichen Erkenntnisgewinn unzulässig. | Checklist, evidence structure | 1 Feature / Medium | Temporärprojekt mit vorhandenem Ready-PR: Gleichwertigkeit darf nur beobachtete Teilstrecken schließen; nicht beobachtete Trigger bleiben `Open`. | `ObserveAgain` |
| `G4-RET-005` | T151; `validation-supplemental.json` `79c3283e281bb4af450ecc52926afbfa27049872bc025d1876dfa02465376129` | Breite Inventur und Vollregression sollen pro unverändertem Hash-/Frischefenster genau einmal laufen. Gezielte Validatoren schließen neue Evidence; unveränderte breite Prüfungen werden nicht ritualisiert wiederholt. | Skill, runbook | Stage B und G4 plus ausdrückliches Nutzerfeedback / High | Einen Lauf mit unverändertem Sourcehash wiederaufnehmen: genau ein Full-Matrix-Record; nach Sourceänderung genau ein neuer. | `Promote` |

## Projektspezifische Ausschlüsse / Project-Specific Exclusions

- Repository-ID `1197429411`, PR `#260`, konkrete Ruleset-IDs und der persönliche
  Accountname werden nicht in gemeinsame Regeln übernommen.
- Das Datum `2026-09-01` ist ein veränderlicher persönlicher Providerfakt, kein
  allgemeiner Vertragswert.
- Die konkrete Acht-Repository-Menge und Position 7 bleiben ausschließlich
  Bestandteil dieses Lastenhefts und seiner Intake-Serie.

*Repository and PR identities, concrete ruleset IDs, the personal quota reset
date, the eight-repository target set, and Position 7 remain project-specific.*

## Berechtigungs- und Evidenzrisiken / Permission and Evidence Risks

- Snapshot-Wiederverwendung darf niemals eine Mutation, geänderte Zielmenge,
  abgelaufene TTL oder geänderte Authority überdecken.
- `Promote` erteilt keine Provider-, Commit-, Push-, Merge-, Bypass-, Home-Sync-
  oder Fremdrepository-Autorität.
- Provider-Refusal darf weder zu `Passed` hochgestuft noch durch einen
  ungefragten kostenwirksamen Versuch „getestet“ werden.
- Natürliche PR-Gleichwertigkeit schließt nur tatsächlich beobachtete Fakten;
  Primary Acceptance bleibt bis zum exakten finalen Head und Closeout offen.

## Evidence-Bindung / Evidence Binding

- Run: `1b7788fb-81f3-4d76-8006-885d834dd454`
- PR-Lifecycle: `3033bcfd73cf701a0a6c76d1b4f5295f9381d2ef410014d053f4f4f5a39db9b5`
- Manual Review: `8d1aacb82ad1c7da743235a8a6d3473b9109e10cf2a06c423407945eca22b2e8`
- Rollback N/A: `3865d5469ce8247a212f387f7033e5e89f51a1b354d571074125a8ed244b9556`
- After-Inventur: `445e4d21f88c79d0dbcc2073be9e15876b1332d527b318323b47fafd5b208d54`
- Idempotenz: `8c711eced01f4f265fe11722597e13c9bada17a88480e9e780c4e181584f1913`
- T151: `79c3283e281bb4af450ecc52926afbfa27049872bc025d1876dfa02465376129`
- Analyze-final: `9fe0053074dd620af1a92959c052e829b694de4068f1ea8c2c926fea2a6d6639`

## Disposition und unabhängige Review / Disposition and Independent Review

`Promotion` gilt für die drei providerneutralen Regeln zu nativen
Cross-Platform-Proofs, Refusal-Klassifikation und genau einer breiten Prüfung
pro gültigem Hash-/Frischefenster. `G4-RET-004` bleibt `ObserveAgain`, bis ein
zweiter unabhängiger natürlicher PR-Lifecycle-Fall vorliegt. Es ist keine
zusätzliche Shared-Guidance-Änderung nötig: die aktuelle Feature-Implementierung,
Stage-B-Retrospektive und bestehende Cross-Platform-Guidance enthalten die
Regeln bereits; diese Retrospektive ist der portable Handoff.

Die Codex-Review gegen Analyze-final, T151, Providerresultate und die
Stage-B-Retrospektive ergab null Widersprüche und null Autoritätserweiterung.
Post-Merge-, Home-Sync- und terminale Serienfakten sind noch nicht kausal
verfügbar und werden hier nicht vorweggenommen. Re-Evaluation erfolgt bei
Provider-, TTL-, Runner-, Hash-, Scope- oder Authority-Drift.

*Promotion applies to the provider-neutral native-platform, refusal, and
single-broad-check-per-valid-hash/freshness-window rules. Natural-PR equivalence
remains `ObserveAgain`. Independent Codex review found no contradiction or
authority expansion; post-merge facts are deliberately not anticipated.*
