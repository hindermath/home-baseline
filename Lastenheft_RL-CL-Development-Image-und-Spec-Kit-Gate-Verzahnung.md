<!-- intake-authoring:begin -->
# Lastenheft: RL/CL, Development Image und Spec-Kit-Gates verzahnen

**Dokumenttyp:** Handoff / Workitem
**Status:** Discussion / Ready for Intake Review
**Stand:** 2026-08-22
**Issue:** [#249](https://github.com/hindermath/home-baseline/issues/249)
**Position:** keine zugewiesen; kein automatischer Serieneintrag
**Naechster erlaubter Schritt:** Intake Review
**Zielgruppe:** Maintainer, Security-Verantwortliche, Image-Maintainer,
Reviewer und Verantwortliche fuer Level-2-Consumer-Repositories

## 1. Zweck

Dieses Workitem beschreibt den Diskussions- und Entscheidungsbedarf fuer die
Verzahnung der `home-baseline secure-development baseline`, des
Level-0-Repositorys, des `Agentic Workspace governance overlay`, des
Development Image und der Level-2-Consumer-Repositories.

Es soll geklaert werden, wie eine inhaltliche RL-/CL-Versionsaenderung
durchgaengig bewertet, technisch gespiegelt und zusammen mit den
Spec-Kit-Laeufen eines Projekts dokumentiert wird. Der vorgesehene Vertrag
ersetzt die bisherige Konzentration auf eine spaete Abschlusspruefung durch:

1. eine Baseline vor beziehungsweise in Stufe 0;
2. risikobasierte Deltas in den Stufen 1 bis 4;
3. eine vollstaendige Abschlusspruefung in Stufe 5.

Das Workitem startet keine Umsetzung und trifft noch keine
Flottenentscheidung.

## 2. Ausgangslage und Bezugspunkte

Folgende vorhandene Intakes und Evidence bleiben eigenstaendige Quellen:

- `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md`;
- `Lastenheft_RL-SE-Checklist-Selbstpruefung.025-rl-se-self-assessment.md`;
- `Lastenheft_Secure-Development-Container-Hardening.md` auf Position 7;
- `Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md` auf
  Position 8;
- `Lastenheft_Secure-Development-Baseline-3.3-Synchronisierung.md`;
- die angrenzenden Agentic-Workspace-Initiativen #177, #161 und #162;
- der historische Handoff #212, der teilweise ueberlappt, aber durch dieses
  Workitem weder wiederaufgenommen noch automatisch geschlossen wird.

Die abgeschlossenen Ergebnisse aus Position 5 und 6 werden nicht umgedeutet.
Dieses Workitem soll nur klaeren, wie ihre Mapping- und
Selbstpruefungsgrundlagen in den kuenftigen Stufenvertrag eingehen.

## 3. Zielbild

Nach einer spaeteren, getrennt autorisierten Umsetzung soll fuer jede
anwendbare RL-/CL-Anforderung eindeutig erkennbar sein:

- welche kontrollierte Baseline-Version und welcher exakte Quellstand gelten;
- welche Entscheidung in Stufe 0 getroffen wurde;
- welche Aenderung in Stufen 1 bis 4 ein Delta ausgeloest hat;
- welche Spec-Kit-, Review-, Test- oder Betriebs-Evidence die Aussage traegt;
- welche Auswirkungen auf das Development Image geprueft wurden;
- welche Punkte in Stufe 5 erfuellt, offen, nicht anwendbar oder abweichend
  sind;
- wer offene Punkte und Ausnahmen verantwortet und wann neu bewertet wird.

Eine zentrale Evidenzmatrix soll diese Informationen verbinden. Sie ist ein
Nachweisindex und keine zweite normative Quelle.

## 4. Vorgeschlagener Stufenvertrag

| Zeitpunkt | Mindestpruefung | Erwartete Evidence | Gate-Wirkung |
|---|---|---|---|
| Vor beziehungsweise in Stufe 0 | Baseline-Versionen, Anwendbarkeit, Ausgangsrisiko, Preset-Profil und Development-Image-Bezug | Baseline-Manifest, erste Matrix, begruendete `N/A`-/`Open`-Entscheidungen, Image-Referenz | Facharbeit startet nur mit nachvollziehbarer Ausgangslage |
| Stufen 1 bis 4 | Delta gegen Baseline und letzte akzeptierte Entscheidung | geaenderte Matrixzeilen, Spec-Kit-Artefakte, Tests, Reviews, Ausnahmen und Image-Auswirkungsdelta | Nur betroffene Pruefpunkte werden erneut bewertet; Trigger und Begruendung bleiben sichtbar |
| Stufe 5 | vollstaendige Abschluss- und Konsistenzpruefung | geschlossene Matrix, Review-Evidence, Restrisiken, Ausnahmen, Image- und Liefernachweise | Kein positiver Abschluss bei fehlender Pflicht-Evidence |

Ein Delta darf nicht allein aus einem geaenderten Dateinamen abgeleitet
werden. Es braucht einen fachlichen Trigger, betroffene Pruefpunkt-IDs und
einen nachvollziehbaren Bezug zur letzten akzeptierten Entscheidung.

## 5. Verantwortungsgrenzen

### 5.1 Level 0

Das Level-0-Repository verwaltet die versionierte Secure-Development-Basis,
stabile Pruefpunkt-IDs, Regeln fuer Anwendbarkeit und Evidence sowie den
generischen Stufenvertrag. Es verwaltet keine projektspezifischen
Erfuellungsbehauptungen als normative Wahrheit.

### 5.2 Agentic Workspace governance overlay

Der Agentic Workspace governance overlay stellt Vorlagen und Pruefkommandos
fuer Baseline, Delta, Abschluss und Image-Auswirkung bereit. Installation oder
Aufloesung eines Presets beweist noch keine Anwendbarkeit, Erfuellung,
Freigabe oder Ausnahmegenehmigung.

### 5.3 Development Image

Das Development Image belegt die technische Umgebung, in der agentische
Arbeit, Build, Test und Nachweiserzeugung stattfinden. Eine relevante
RL-/CL-Aenderung soll eine explizite Entscheidung `Affected`, `NotAffected`
oder `Deferred` ausloesen.

### 5.4 Level-2-Consumer-Repositories

Level-2-Consumer-Repositories pinnen ihren verwendeten Baseline-Stand und
halten projektspezifische Anwendbarkeit, Deltas und Abschluss-Evidence. Sie
duplizieren nicht den gesamten kontrollierten Dokumentensatz und veraendern
keine zentrale normative Quelle.

### 5.5 Menschengebundene Entscheidungen

Vier-Augen-Review, Freigabe, Risikoakzeptanz und Ausnahmegenehmigung bleiben
menschengebundene Entscheidungen. Spec-Kit- oder Agentenartefakte duerfen sie
nicht als automatisch erteilt darstellen.

## 6. Development-Image-Auswirkungspruefung

Das Intake Review soll entscheiden, ob jede inhaltliche RL-/CL-
Versionsaenderung mindestens folgende Felder verlangt:

- alte und neue Baseline-Version mit exakten Quellstaenden;
- `Affected`, `NotAffected` oder `Deferred` mit Begruendung;
- betroffene Image-Anforderungen, Toolchains, Presets und Mount-Grenzen;
- Build-Referenz, unveraenderlicher Digest und Laufzeit-Haertungsnachweis;
- aktuelles Tool- und Preset-Inventar;
- SBOM sowie anwendbare Scan-, Signatur- und Provenance-Nachweise;
- Build-/Test-Feldnachweis in einem geeigneten Consumer;
- Owner, Reviewer, Datum, Restrisiko und Neubewertungs-Trigger.

`NotAffected` ist nur mit nachvollziehbarer Impact-Analyse zulaessig.
`Deferred` braucht Owner, Risiko, Frist und einen blockierenden oder
freigaberelevanten Trigger.

## 7. Spec-Kit- und Evidenzvertrag

Die vorgeschlagene zentrale Matrix enthaelt mindestens:

- stabile RL-/CL-Pruefpunkt-ID und Baseline-Version;
- Anwendbarkeit und kurze Begruendung;
- Status `Open`, `InProgress`, `Fulfilled`, `N/A`, `Exception` oder
  `FollowUp`;
- betroffene Stufe und Delta-Identifier;
- Links auf `spec.md`, `plan.md`, `tasks.md`, Analyse, Checklisten,
  Implementierung, Review und Tests;
- Development-Image-Referenz und Impact-Entscheidung, sofern betroffen;
- Owner, Reviewer, Risiko, Entscheidung, Datum und Neubewertungs-Trigger.

Spec-Kit-Artefakte koennen eine getrennte manuelle Checklistenpflege nur dann
ersetzen, wenn jede anwendbare Matrixzeile eindeutig und belastbar abgedeckt
ist. Nicht abgedeckte, nicht anwendbare und bewusst abweichende Punkte bleiben
ausdruecklich dokumentiert.

## 8. Ausloeser fuer Neusynchronisierung

Das Intake Review soll mindestens folgende Trigger bewerten:

- inhaltliche Aenderung einer RL oder CL;
- neue, entfernte oder semantisch geaenderte Pruefpunkt-ID;
- geaenderte Anwendbarkeits-, Evidence- oder Ausnahmebedingung;
- geaenderte Sandbox-, Agenten-, Toolchain-, Lieferketten- oder
  Review-Anforderung;
- geaenderter Preset-Inhalt, Prioritaet oder aufgeloestes Template;
- geaenderte Basis-Images, Tool-Pins, Mounts, Netzwerk- oder
  Berechtigungsgrenzen;
- erkannte Drift zwischen Level 0, Development Image und einem Consumer.

Reine redaktionelle Aenderungen ohne fachliche Wirkung sollen dokumentiert,
aber nicht automatisch als Image-Neubau oder Consumer-Roll-out behandelt
werden.

## 9. Beziehung zu Position 7 und 8

Der bevorzugte Diskussionsansatz ist eine Ergaenzung bestehender
Verantwortungen:

- Position 7 bewertet und belegt die Development-Image-Auswirkung des
  kontrollierten Baseline-Stands;
- Position 8 definiert die sichere, versionierte Uebergabe an
  Level-2-Consumer-Repositories;
- dieses Workitem liefert den gemeinsamen Gate- und Evidence-Vertrag, ohne
  selbst einen neuen aktiven Serienplatz zu beanspruchen.

Eine Aenderung der aktiven Reihe ist eine getrennte Entscheidung und nicht
durch dieses Dokument autorisiert.

## 10. Diskussion: moeglicher flottenweiter Roll-out

Ein flottenweiter Roll-out ist ausdruecklich nur Gegenstand der Diskussion:

- Welche kleine Pilotkohorte bildet unterschiedliche Plattformen,
  Risikoklassen und Projektarten ausreichend ab?
- Soll eine spaetere Adoption opt-in, verpflichtend oder risikobasiert sein?
- Welche Versionsabweichung und welche Uebergangsfrist sind zulaessig?
- Wo liegt die Flottenmatrix, und wer verantwortet ihre Aktualitaet?
- Wie werden `Applicable`, `N/A`, `Open`, Ausnahmen und Restrisiken pro
  Consumer getrennt?
- Wie werden schmutzige Arbeitsbaeume und nutzereigene Aenderungen geschuetzt?
- Wie werden fehlende Rechte, Kosten, Review-Kapazitaet und Rollback behandelt?
- Wie wird verhindert, dass unveraenderte Ziele Leer-PRs erhalten?
- Welche Pilot-Evidence und welche Entscheidung sind vor einem spaeteren
  Roll-out zwingend?

Diese Fragen begruenden keine Zielmenge und keine Ausfuehrungsautoritaet.

## 11. Nicht-Ziele und Autoritaetsgrenze

Dieses Workitem autorisiert nicht:

- einen Spec-Kit-Lauf oder eine Feature-Implementierung;
- eine Aenderung der aktiven Intake-Reihenfolge;
- einen Development-Image-Build, eine Registry-Aenderung oder ein Release;
- einen Roll-out oder PR-Fan-out;
- Commits, Pushes, Merges oder Admin-Bypass ausserhalb der Lieferung dieses
  reinen Handoff-Dokuments;
- Aenderungen an Level-2-Consumer-Repositories;
- eine positive RL-/CL-Konformitaetsbehauptung;
- den automatischen Abschluss menschengebundener Reviews, Freigaben oder
  Ausnahmen.

## 12. Entscheidungen fuer das Intake Review

Das Intake Review dokumentiert mindestens:

1. Owner und kanonische Quelle des Stufenvertrags;
2. verbindliche oder beratende Wirkung je Stufe;
3. Trigger und Mindestnachweise der Image-Auswirkungspruefung;
4. Speicherort, Schema und Lebenszyklus der zentralen Matrix;
5. Verhaeltnis zu Position 7, Position 8 und der geplanten
   Baseline-Synchronisierung;
6. Grenzen der Erleichterung durch Spec-Kit-Evidence;
7. Umgang mit Versionsdrift und Uebergangsfristen;
8. Entscheidung, ob und wie eine spaetere Pilotdiskussion fortgesetzt wird.

## 13. Akzeptanzkriterien fuer diesen Handoff

- Das Issue nennt `@hindermath` und fordert die offenen Entscheidungen an.
- Baseline in Stufe 0, Deltas in Stufen 1 bis 4 und Abschluss in Stufe 5 sind
  eindeutig getrennt.
- Level 0, Agentic Workspace governance overlay, Development Image und
  Level-2-Consumer-Repositories besitzen klare Verantwortungsgrenzen.
- Der Development-Image-Impact besitzt pruefbare Mindestfelder und
  fail-closed Statusregeln.
- Eine zentrale Matrix verbindet RL-/CL-Pruefpunkte mit Spec-Kit-, Review-,
  Test-, Ausnahme- und Image-Evidence, ohne eine zweite Normquelle zu werden.
- Position 7 und 8 sowie die abgeschlossenen und geplanten Vorganger sind
  referenziert, ohne ihre Evidence umzudeuten.
- Der flottenweite Roll-out bleibt eine Liste von Diskussionsfragen.
- Es gibt keinen Feature-Identifier, keinen aktiven Serienplatz und keine
  automatische Folgeausfuehrung.
- Als naechster Schritt ist ausschliesslich Intake Review erlaubt.

## 14. Validierung dieses Dokuments

- Verweise auf vorhandene Intakes und Issues pruefen;
- Deutsch-zuerst-/Englisch-danach-Struktur, CEFR B2 und textorientierte
  Lesbarkeit pruefen;
- Begriffe und Autoritaetsgrenzen gegen `AGENTS.md` pruefen;
- verbotene organisations- oder infrastrukturspezifische Bezeichner per
  Vokabular-Gate ausschliessen;
- `git diff --check` und Secret-Scan ausfuehren.

---

# Requirements: Align RL/CL, the Development Image, and Spec Kit gates

**Document type:** Handoff / work item
**Status:** Discussion / Ready for Intake Review
**As of:** 2026-08-22
**Issue:** [#249](https://github.com/hindermath/home-baseline/issues/249)
**Position:** none assigned; no automatic series entry
**Next permitted step:** Intake Review
**Audience:** maintainers, security owners, image maintainers, reviewers, and
owners of Level-2 consumer repositories

## 15. Purpose

This work item records the discussion and decisions needed to align the
`home-baseline secure-development baseline`, the Level-0 repository, the
`Agentic Workspace governance overlay`, the Development Image, and Level-2
consumer repositories.

It is intended to clarify how a material RL/CL version change is assessed,
reflected technically, and documented with a project's Spec Kit runs. The
proposed contract replaces a closure-only check with:

1. a baseline before or in stage 0;
2. risk-based deltas in stages 1 through 4;
3. a complete closure review in stage 5.

This work item starts no implementation and makes no fleet decision.

## 16. Current state and references

The following existing intakes and evidence remain independent sources:

- `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md`;
- `Lastenheft_RL-SE-Checklist-Selbstpruefung.025-rl-se-self-assessment.md`;
- `Lastenheft_Secure-Development-Container-Hardening.md` at position 7;
- `Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md` at
  position 8;
- `Lastenheft_Secure-Development-Baseline-3.3-Synchronisierung.md`;
- adjacent Agentic Workspace initiatives #177, #161, and #162;
- historical handoff #212, which partly overlaps but is neither resumed nor
  automatically closed by this work item.

Completed position-5 and position-6 results are not reinterpreted. This work
item only clarifies how their mapping and self-assessment foundations should
feed the future stage contract.

## 17. Target state

After a later and separately authorized implementation, every applicable
RL/CL requirement should show:

- the controlled baseline version and exact source revision;
- the decision made in stage 0;
- the change that triggered a delta in stages 1 through 4;
- the Spec Kit, review, test, or operational evidence supporting the claim;
- the assessed Development Image impact;
- whether the checkpoint is fulfilled, open, not applicable, or divergent at
  stage 5;
- who owns open items and exceptions and when they are reassessed.

A central evidence matrix should connect this information. It is an evidence
index and not a second normative source.

## 18. Proposed stage contract

| Point in time | Minimum assessment | Expected evidence | Gate effect |
|---|---|---|---|
| Before or in stage 0 | Baseline versions, applicability, current risk, preset profile, and Development Image relationship | Baseline manifest, initial matrix, justified `N/A` and `Open` decisions, image reference | Domain work starts only from a traceable current state |
| Stages 1 through 4 | Delta against the baseline and the last accepted decision | Changed matrix rows, Spec Kit artifacts, tests, reviews, exceptions, and image-impact delta | Only affected checkpoints are reassessed, with visible triggers and rationale |
| Stage 5 | Complete closure and consistency assessment | Closed matrix, review evidence, residual risks, exceptions, image evidence, and delivery evidence | No positive closure when mandatory evidence is missing |

A delta must not be inferred only from a changed filename. It needs a material
trigger, affected checkpoint IDs, and a traceable link to the last accepted
decision.

## 19. Responsibility boundaries

### 19.1 Level 0

The Level-0 repository owns the versioned secure-development baseline, stable
checkpoint IDs, applicability and evidence rules, and the generic stage
contract. It does not treat project-specific fulfilment claims as normative
truth.

### 19.2 Agentic Workspace governance overlay

The Agentic Workspace governance overlay supplies templates and validation
commands for baseline, delta, closure, and image impact. Installing or
resolving a preset does not prove applicability, fulfilment, approval, or an
accepted exception.

### 19.3 Development Image

The Development Image provides evidence for the technical environment in
which agentic work, builds, tests, and evidence generation run. A relevant
RL/CL change should trigger an explicit `Affected`, `NotAffected`, or
`Deferred` decision.

### 19.4 Level-2 consumer repositories

Level-2 consumer repositories pin the baseline they use and keep
project-specific applicability, deltas, and closure evidence. They do not
duplicate the entire controlled document set or modify the central normative
source.

### 19.5 Human-owned decisions

Four-eyes review, approval, risk acceptance, and exception approval remain
human-owned decisions. Spec Kit or agent artifacts must not present them as
automatically granted.

## 20. Development Image impact assessment

The Intake Review should decide whether every material RL/CL version change
requires at least:

- old and new baseline versions with exact source revisions;
- `Affected`, `NotAffected`, or `Deferred` with rationale;
- affected image requirements, toolchains, presets, and mount boundaries;
- build reference, immutable digest, and runtime-hardening evidence;
- current tool and preset inventory;
- SBOM and applicable scan, signature, and provenance evidence;
- build and test field evidence in a suitable consumer;
- owner, reviewer, date, residual risk, and reevaluation trigger.

`NotAffected` is valid only with a traceable impact analysis. `Deferred`
requires an owner, risk, due date, and a blocking or release-relevant trigger.

## 21. Spec Kit and evidence contract

The proposed central matrix contains at least:

- stable RL/CL checkpoint ID and baseline version;
- applicability and concise rationale;
- status `Open`, `InProgress`, `Fulfilled`, `N/A`, `Exception`, or `FollowUp`;
- affected stage and delta identifier;
- links to `spec.md`, `plan.md`, `tasks.md`, analysis, checklists,
  implementation, review, and tests;
- Development Image reference and impact decision where affected;
- owner, reviewer, risk, decision, date, and reevaluation trigger.

Spec Kit evidence may replace separate manual checklist duplication only when
every applicable matrix row has unambiguous and sufficient evidence. Missing,
not applicable, deliberately divergent, and excepted checkpoints remain
explicit.

## 22. Resynchronization triggers

The Intake Review should assess at least these triggers:

- a material RL or CL change;
- a new, removed, or semantically changed checkpoint ID;
- a changed applicability, evidence, or exception condition;
- a changed sandbox, agent, toolchain, supply-chain, or review requirement;
- changed preset content, priority, or resolved template;
- changed base images, tool pins, mounts, network, or permission boundaries;
- detected drift between Level 0, the Development Image, and a consumer.

Editorial changes without material effect should be recorded but should not
automatically trigger an image rebuild or consumer rollout.

## 23. Relationship to positions 7 and 8

The preferred discussion outcome is to extend existing responsibilities:

- position 7 assesses and proves the Development Image impact of the
  controlled baseline;
- position 8 owns the secure, versioned handoff to Level-2 consumer
  repositories;
- this work item supplies the shared gate and evidence contract without
  claiming a new active series position.

Changing the active order is a separate decision and is not authorized by this
document.

## 24. Discussion: possible fleet rollout

A fleet rollout is explicitly a discussion topic only:

- Which small pilot cohort sufficiently covers different platforms, risk
  classes, and project types?
- Should later adoption be opt-in, mandatory, or risk-based?
- What version skew and grace period are acceptable?
- Where should the fleet matrix live, and who owns its currency?
- How are `Applicable`, `N/A`, `Open`, exceptions, and residual risks kept
  separate per consumer?
- How are dirty worktrees and user-owned changes protected?
- How are missing permissions, cost, review capacity, and rollback handled?
- How are empty pull requests prevented for unchanged targets?
- Which pilot evidence and decision are mandatory before a later rollout?

These questions define neither a target set nor execution authority.

## 25. Non-goals and authority boundary

This work item does not authorize:

- a Spec Kit run or feature implementation;
- a change to the active intake order;
- a Development Image build, registry mutation, or release;
- a rollout or pull-request fan-out;
- commits, pushes, merges, or admin bypass outside delivery of this pure
  handoff document;
- changes to Level-2 consumer repositories;
- a positive RL/CL compliance claim;
- automated closure of human-owned reviews, approvals, or exceptions.

## 26. Decisions for Intake Review

The Intake Review records at least:

1. owner and canonical source of the stage contract;
2. mandatory or advisory effect at each stage;
3. triggers and minimum evidence for image-impact assessment;
4. location, schema, and lifecycle of the central matrix;
5. relationship to position 7, position 8, and the planned baseline
   synchronization;
6. limits of any simplification through Spec Kit evidence;
7. handling of version drift and grace periods;
8. whether and how a later pilot discussion should continue.

## 27. Acceptance criteria for this handoff

- The issue mentions `@hindermath` and requests the open decisions.
- Baseline in stage 0, deltas in stages 1 through 4, and closure in stage 5 are
  clearly separated.
- Level 0, the Agentic Workspace governance overlay, the Development Image,
  and Level-2 consumer repositories have clear responsibility boundaries.
- Development Image impact has auditable minimum fields and fail-closed
  status rules.
- A central matrix links RL/CL checkpoints to Spec Kit, review, test,
  exception, and image evidence without becoming a second normative source.
- Positions 7 and 8 and completed and planned predecessors are referenced
  without reinterpreting their evidence.
- Fleet rollout remains a list of discussion questions.
- There is no feature identifier, active series position, or automatic
  follow-on execution.
- Intake Review is the only permitted next step.

## 28. Validation of this document

- Verify links to existing intakes and issues.
- Verify German-first and English-second structure, CEFR B2, and text-oriented
  readability.
- Verify terminology and authority boundaries against `AGENTS.md`.
- Exclude forbidden organization- or infrastructure-specific identifiers with
  a vocabulary gate.
- Run `git diff --check` and the repository secret scan.

<!-- intake-authoring:end -->
