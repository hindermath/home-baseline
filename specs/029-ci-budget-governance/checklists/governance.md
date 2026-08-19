# Requirements-Governance-Checkliste: Flottenweite CI-Budget-Governance / Requirements Governance Checklist: Fleet-Wide CI Budget Governance

**Purpose / Zweck**: Formales, hochrigoroses Pre-Plan-Gate für Qualität, Vollständigkeit, Konsistenz und Messbarkeit der bindenden Governance-Anforderungen / Formal high-rigor pre-plan gate for the quality, completeness, consistency, and measurability of the binding governance requirements
**Created / Erstellt**: 2026-08-19
**Feature / Feature**: [spec.md](../spec.md)
**Audience and timing / Zielgruppe und Zeitpunkt**: Maintainer und Peer-Reviewer vor der Planungsphase / Maintainer and peer reviewer before planning

**Note / Hinweis**: Diese Checkliste bewertet ausschließlich die Qualität der geschriebenen Anforderungen. Implementierungs- und Ausführungstests sind ausdrücklich nicht Gegenstand dieses Gates. / This checklist evaluates only the quality of the written requirements. Implementation and execution testing are explicitly outside this gate.

## Anforderungsvollständigkeit / Requirement Completeness

- [x] CHK001 Sind alle fünf CI-Profile, ihre exakten Namen und ihre zulässigen Sichtbarkeiten vollständig und ohne implizite Restklasse definiert? [Completeness, Spec §CBG-002/FR-002]
  *Are all five CI profiles, their exact names, and their permitted visibility classes fully defined without an implicit catch-all class?*
- [x] CHK002 Sind Live-Inventur, stabile Identität, Klassifikation, Gate-/Evidence-Vertrag, Kostenmodell und Rollout-Planung als zusammenhängende fachliche Anforderungskette dokumentiert? [Completeness, Spec §CBG-001–CBG-021; §Key Entities]
  *Are live inventory, stable identity, classification, gate/evidence contract, cost model, and rollout planning documented as one coherent requirements chain?*
- [x] CHK003 Sind Pflichtfelder und verbotene Daten der maschinenlokalen Evidence vollständig benannt, einschließlich Schema-Version, Repository-ID, HEAD, Profil, Gate-Set-Hash, Plattform, Zeitstempel und geordneten Einzelergebnissen? [Completeness, Spec §CBG-012/FR-012]
  *Are required and prohibited machine-local evidence data fully named, including schema version, repository ID, HEAD, profile, gate-set hash, platform, timestamp, and ordered individual results?*
- [x] CHK004 Sind die Anforderungen für private Governance-, private Produkt-, öffentliche Produkt-/Canary- und öffentliche Preset-Repositories jeweils vollständig abgegrenzt? [Completeness, Spec §CBG-003–CBG-009]
  *Are requirements for private governance, private product, public product/canary, and public preset repositories each fully bounded?*
- [x] CHK005 Sind alle 21 Intake-Anforderungen und alle zehn Abnahmekriterien lückenlos in beide Richtungen rückverfolgbar? [Traceability, Spec §Requirement Traceability; §Acceptance Traceability]
  *Are all 21 intake requirements and all ten acceptance criteria completely traceable in both directions?*

## Sicherheits- und Autoritätsgrenzen / Security and Authority Boundaries

- [x] CHK006 Ist eindeutig festgelegt, dass der lokale Pre-push-Hook keine alleinige Sicherheitsgrenze ist und Hook-Fehlen oder -Umgehung die unabhängige serverseitige PR-/Statuspflicht nicht aufhebt? [Clarity, Spec §CBG-003/FR-003; §CBG-014/FR-014; §AC-CBG-007]
  *Is it unambiguous that the local pre-push hook is not the sole security boundary and that a missing or bypassed hook does not remove the independent server-side PR/status requirement?*
- [x] CHK007 Ist der unabhängige serverseitige Gate-Vertrag als genau ein schlanker, pfadabhängiger, erfolgreicher und später ruleset-verpflichtender PR-Gate messbar beschrieben? [Measurability, Spec §CBG-003/FR-003; §AC-CBG-002]
  *Is the independent server-side gate contract measurably defined as exactly one lean, path-aware, successful, later ruleset-required PR gate?*
- [x] CHK008 Sind direkte, Web- und API-Schreibpfade zum Default-Branch sowie Admin-Bypass als unzulässige Umgehungspfade ausdrücklich erfasst? [Coverage, Spec §CBG-018/FR-018]
  *Are direct, web, and API default-branch write paths plus admin bypass explicitly covered as prohibited bypass paths?*
- [x] CHK009 Bleiben Secret-Scanning, Branch-Schutz, Mutation Barriers, Reviewpflichten und sonstige Gates trotz Kostenoptimierung normativ geschützt? [Consistency, Spec §CBG-018/FR-018]
  *Do secret scanning, branch protection, mutation barriers, review obligations, and other gates remain normatively protected despite cost optimization?*
- [x] CHK010 Ist Stage A unter `LocalImplementation` positiv und abschließend auf Level-0-eigene Profile, lokale Gates/Evidence, Hook-Logik, Templates, Simulationen, Tests, Statistik, Dokumentation und Rollout-Evidence begrenzt? [Clarity, Spec §CBG-021/FR-021; §English Contract Summary]
  *Is Stage A under `LocalImplementation` positively and exhaustively limited to Level-0-owned profiles, local gates/evidence, hook logic, templates, simulations, tests, statistics, documentation, and rollout evidence?*
- [x] CHK011 Sind Commit, Push, Merge, Home-Sync, GitHub-Schreibzugriff, aktive Ruleset-/Accountmutation, Admin-Bypass, G4-Start und Zielrepository-Edits als Stage-A-Hard-Stops konsistent aufgeführt? [Consistency, Spec §CBG-019/FR-019; §Autonomous-Run Applicability; §English Contract Summary]
  *Are commit, push, merge, Home sync, GitHub writes, active ruleset/account mutation, admin bypass, G4 start, and target-repository edits consistently listed as Stage A hard stops?*
- [x] CHK012 Ist jede tatsächliche Änderung oder Konvergenz der 47 Zielrepositories eindeutig Stage B zugewiesen und an neue ausdrückliche Autorität sowie Revalidierung gebunden? [Clarity, Spec §CBG-021/FR-021; §Assumptions; §AC-CBG-010]
  *Is every actual mutation or convergence of the 47 target repositories clearly assigned to Stage B and bound to new explicit authority and revalidation?*

## Profilklassifikation und Drift / Profile Classification and Drift

- [x] CHK013 Ist die stabile Registry-ID als einzige zulässige Klassifikationsidentität definiert, ohne Ableitung allein aus Name oder Pfad? [Clarity, Spec §CBG-002/FR-002; §Assumptions]
  *Is the stable registry ID defined as the only permitted classification identity, without derivation solely from name or path?*
- [x] CHK014 Sind fehlende, unbekannte, doppelte und sichtbarkeitsinkompatible Zuordnungen vollständig als fail-closed Driftklassen mit geprüftem Mapping-Update beschrieben? [Coverage, Spec §CBG-002/FR-002; §AC-CBG-001]
  *Are missing, unknown, duplicate, and visibility-incompatible assignments fully defined as fail-closed drift classes requiring a reviewed mapping update?*
- [x] CHK015 Ist automatische Umklassifizierung ausdrücklich verboten und damit eine stille Budget- oder Sicherheitsentscheidung ausgeschlossen? [Clarity, Spec §CBG-002/FR-002; §AC-CBG-001]
  *Is automatic reclassification explicitly prohibited, thereby excluding silent budget or security decisions?*
- [x] CHK016 Ist festgelegt, dass Live-Kardinalitäten neu berechnet werden, Collection-Knoten nicht als Repository zählen und der datierte Snapshot nicht als feste Soll-Kardinalität dient? [Consistency, Spec §User Story 1 Acceptance 4; §Edge Cases; §AC-CBG-001]
  *Is it specified that live cardinalities are recomputed, collection nodes are not counted as repositories, and the dated snapshot is not a fixed target cardinality?*
- [x] CHK017 Sind Ausfall und zeitliche Drift des read-only GitHub-Livezustands so beschrieben, dass unbelegte oder veraltete Daten keine aktuelle Evidence werden können? [Exception Coverage, Spec §CBG-001/FR-001; §Edge Cases]
  *Are failure and temporal drift of read-only GitHub live state defined so that unsupported or stale data cannot become current evidence?*

## Evidence-, Determinismus- und Budgetabnahme / Evidence, Determinism, and Budget Acceptance

- [x] CHK018 Ist der Evidence-Pfad maschinenlokal und pro Repository-ID sowie HEAD eindeutig festgelegt, ohne Git-Tracking oder Remote-Publikation zu implizieren? [Clarity, Spec §CBG-011/FR-011; §Documentation Impact—Distribution class]
  *Is the evidence path unambiguously machine-local and keyed by repository ID and HEAD without implying Git tracking or remote publication?*
- [x] CHK019 Sind Erfolgspublikation, Abbruch und Fehler so spezifiziert, dass nur vollständig erfolgreiche Gates eine Evidence erzeugen und keine erfolgreiche Restdatei verbleibt? [Recovery Coverage, Spec §CBG-011/FR-011; §Edge Cases]
  *Are success publication, interruption, and failure specified so that only fully successful gates create evidence and no successful residual file remains?*
- [x] CHK020 Sind HEAD-, Gate-Set-, Einzelgate-, Evidence- und Hook-Frischebedingungen vollständig und widerspruchsfrei als Gültigkeitsgrenzen beschrieben? [Consistency, Spec §CBG-013/FR-013; §CBG-014/FR-014; §Autonomous-Run Applicability]
  *Are HEAD, gate-set, individual-gate, evidence, and hook-freshness conditions fully and consistently defined as validity boundaries?*
- [x] CHK021 Ist Determinismus für Null-, Einzel- und Mehrfachrepository-Fälle anhand geordneter Ergebnisse und Exitcodes messbar, während zulässige Zeitstempelvariation die Entscheidung und Hash-Bindung nicht verändert? [Measurability, Spec §AC-CBG-006; §Assumptions]
  *Is determinism measurable for zero-, single-, and multi-repository cases through ordered results and exit codes while permitted timestamp variation does not alter decisions or hash binding?*
- [x] CHK022 Sind Pfadverträge als versionierte Anforderungen für Build-, Security-, Governance-, Abhängigkeits- und Produktflächen vollständig definiert, einschließlich Mehrfachtreffern und reinen Dokumentationsänderungen? [Coverage, Spec §CBG-015/FR-015; §Edge Cases]
  *Are path contracts fully defined as versioned requirements for build, security, governance, dependency, and product surfaces, including multiple matches and documentation-only changes?*
- [x] CHK023 Sind wiederkehrende private Jobs, bedarfsabhängige Minimal-Gates, private Actions-Minuten und Copilot-Review-Runnerverbrauch als getrennte, nachvollziehbare Kategorien definiert? [Clarity, Spec §Key Entities—Cost Model; §CBG-016/FR-016; §AC-CBG-004–AC-CBG-005]
  *Are recurring private jobs, demand-driven minimal gates, private Actions minutes, and Copilot review runner consumption defined as separate, auditable categories?*
- [x] CHK024 Sind die Budgetgrenzen von ungefähr 22 wiederkehrenden privaten Jobs pro Woche und weniger als 500 von 3.000 privaten Actions-Minuten einschließlich Abweichungsbegründung objektiv abnehmbar? [Measurability, Spec §AC-CBG-004–AC-CBG-005]
  *Are the budget limits of about 22 recurring private jobs per week and fewer than 500 of 3,000 private Actions minutes objectively acceptable, including an explanation of deviations?*

## Szenario- und Randfallabdeckung / Scenario and Edge-Case Coverage

- [x] CHK025 Decken die Anforderungen passende, fehlende, veraltete und fehlgeschlagene Evidence sowie einen fehlenden oder umgangenen Hook vollständig ab? [Exception Coverage, Spec §User Story 2; §CBG-013–CBG-014; §AC-CBG-007]
  *Do the requirements fully cover matching, missing, stale, and failed evidence plus a missing or bypassed hook?*
- [x] CHK026 Sind HEAD-Wechsel während des Gate-Laufs, Gate-Set-Wechsel bei gleichem HEAD und ein unsicherer Evidence-Pfad als fail-closed Randfälle definiert? [Edge Case Coverage, Spec §Edge Cases; §CBG-011–CBG-013]
  *Are a HEAD change during a gate run, a gate-set change at the same HEAD, and an unsafe evidence path defined as fail-closed edge cases?*
- [x] CHK027 Sind sicherheitskritische Eingaben mit Leerzeichen, führenden Bindestrichen, Zeilenumbrüchen oder Shell-Metazeichen sowie das Verbot dynamischer Ausführung ausdrücklich abgedeckt? [Security Coverage, Spec §Edge Cases; §CR-005]
  *Are security-critical inputs containing spaces, leading hyphens, newlines, or shell metacharacters plus the prohibition of dynamic execution explicitly covered?*
- [x] CHK028 Sind Swift-, Release-Please-, CaseTracker-, Canary- und Public-Preset-Sonderfälle mit klaren Trigger-, Jobzahl- und Erhaltungsgrenzen beschrieben? [Scenario Coverage, Spec §CBG-005–CBG-009; §User Story 3]
  *Are Swift, Release Please, CaseTracker, canary, and public preset scenarios defined with clear trigger, job-count, and preservation boundaries?*

## Plattform, Barrierefreiheit und Verständlichkeit / Platform, Accessibility, and Understandability

- [x] CHK029 Sind Bash `--ci-gate`, PowerShell `-CiGate` und das bestehende Cmdlet mit genehmigtem `Verb-Noun` als gleichwertige, verbindliche Oberflächen festgelegt? [Consistency, Spec §CBG-010/FR-010; §Cross-Platform Applicability]
  *Are Bash `--ci-gate`, PowerShell `-CiGate`, and the existing cmdlet with its approved `Verb-Noun` defined as equivalent binding interfaces?*
- [x] CHK030 Ist fachliche Parität für macOS, Linux und Windows anhand identischer Profile, Entscheidungen, Evidence-Felder, Exitcodes und semantisch gleicher Ausgaben messbar? [Measurability, Spec §CBG-017/FR-017; §AC-CBG-008]
  *Is business parity across macOS, Linux, and Windows measurable through identical profiles, decisions, evidence fields, exit codes, and semantically equivalent output?*
- [x] CHK031 Sind `--dry-run` und `-WhatIf` eindeutig als mutations- und evidencefreie Vorschau mit sichtbarer Auswahl, Gate-Set, Einzelschritten und Evidence-Ziel definiert? [Clarity, Spec §User Story 5 Acceptance 2; §Cross-Platform Applicability]
  *Are `--dry-run` and `-WhatIf` clearly defined as mutation- and evidence-free previews showing selection, gate set, individual steps, and evidence target?*
- [x] CHK032 Sind WCAG-2.2-AA-Anwendbarkeit, text-first Ausgabe, stabile lineare Reihenfolge, Bedienbarkeit ohne Farbe sowie deutsche und englische Textalternativen vollständig spezifiziert? [Accessibility Coverage, Spec §CR-002–CR-003; §Accessibility Applicability]
  *Are WCAG 2.2 AA applicability, text-first output, stable linear order, use without color, and German/English text alternatives fully specified?*

## Dokumentation, Governance und Annahmen / Documentation, Governance, and Assumptions

- [x] CHK033 Ist genau eine Feature-weite Documentation-Impact-Entscheidung als `UpdateRequired` mit Zielgruppen, Leserpfaden, Quelle, Owner, Navigation, Dokumentklasse, Sprachstrategie, Plattformnachweis, Distribution, Home-Sync-Bedarf, Evidence und Re-Evaluation dokumentiert? [Completeness, Spec §CBG-020/FR-020; §Documentation Impact]
  *Is exactly one feature-wide Documentation Impact decision recorded as `UpdateRequired` with audiences, reader paths, source, owner, navigation, document class, language strategy, platform proof, distribution, Home-sync need, evidence, and re-evaluation?*
- [x] CHK034 Sind Security-, Architecture-, iSAQB-, A11Y-, Cross-Platform- und Agent-Parity-Governance jeweils mit Anwendbarkeit, Specify-Status, Owner/Reviewer, geplanter Evidence und Re-Evaluation versehen? [Governance Completeness, Spec §Governance Applicability]
  *Are Security, Architecture, iSAQB, A11Y, Cross-Platform, and Agent Parity governance each supplied with applicability, Specify status, owner/reviewer, planned evidence, and re-evaluation?*
- [x] CHK035 Sind anwendbare und nicht anwendbare Security-/Supply-Chain-Standards einschließlich NIST SSDF, CWE, SBOM, VEX, SLSA, CAPEC, Zero Trust, SAMM, Scorecard, ASVS, AI-SBOM und Regulierung begründet und mit Re-Evaluation versehen? [Governance Clarity, Spec §CR-006–CR-011; §Security Governance Applicability]
  *Are applicable and non-applicable security/supply-chain standards—including NIST SSDF, CWE, SBOM, VEX, SLSA, CAPEC, Zero Trust, SAMM, Scorecard, ASVS, AI-SBOM, and regulation—justified with re-evaluation triggers?*
- [x] CHK036 Ist die Bash-Nicht-MSL-Ausnahme begründet und sind sichere Bash-/PowerShell-Eingabe-, Quoting-, Strict-Mode- und Prozessgrenzen normativ festgelegt? [Security Clarity, Spec §CR-005]
  *Is the Bash non-MSL exception justified and are secure Bash/PowerShell input, quoting, strict-mode, and process boundaries normatively defined?*
- [x] CHK037 Sind fehlende neue Abhängigkeiten, die Prüfung jeder später vorgeschlagenen Abhängigkeit und das Verbot von Provider-/Modellanforderungen als explizite Annahmen beziehungsweise Grenzen dokumentiert? [Assumption, Spec §Assumptions; §CR-008; §CR-012]
  *Are the absence of required new dependencies, review of every later proposed dependency, and the prohibition of provider/model requirements documented as explicit assumptions or boundaries?*
- [x] CHK038 Sind Agentenflächen, Constitution-/Template-Re-Evaluation und das Verbot agentenspezifischer Provider-/Modellnamen konsistent mit dem Feature-Scope beschrieben? [Consistency, Spec §Agent Parity Applicability; §CR-012]
  *Are agent surfaces, constitution/template re-evaluation, and the prohibition of agent-specific provider/model names described consistently with the feature scope?*

## Auswertung und Disposition / Evaluation and Disposition

- Alle 38 Anforderungenstests wurden gegen die aktuelle Spezifikation ausgewertet und bestanden; es verbleibt kein ungeprüfter oder nicht disponierter Punkt. / All 38 requirements tests were evaluated against the current specification and passed; no unchecked or undisposed item remains.
- Es war keine Reparatur der Spezifikation und keine neue semantische Entscheidung erforderlich. / No specification repair or new semantic decision was required.
- Implementierungsprüfung bleibt außerhalb dieses Pre-Plan-Gates und beginnt mit dieser Checkliste nicht. / Implementation testing remains outside this pre-plan gate and is not started by this checklist.
- **Documentation Impact**: `NoUpdateRequired` für diesen angeforderten Phasennachweis; die einzige Feature-weite Entscheidung in der Spezifikation bleibt `UpdateRequired`. Owner ist der Feature-Owner, Evidence ist diese Checkliste, Re-Evaluation erfolgt bei Änderung der Spezifikation oder Lieferautorität. / `NoUpdateRequired` for this requested phase evidence; the specification's sole feature-wide decision remains `UpdateRequired`. The feature owner owns this decision, this checklist is the evidence, and re-evaluation occurs when the specification or delivery authority changes.
