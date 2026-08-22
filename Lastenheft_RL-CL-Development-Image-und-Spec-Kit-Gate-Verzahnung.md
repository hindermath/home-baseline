<!-- intake-authoring:begin -->
# Lastenheft: RL/CL, Development Image und Spec-Kit-Gates verzahnen

**Dokumenttyp:** Handoff / Workitem
**Status:** Discussion / Ready for Intake Review
**Stand:** 2026-08-23
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

1. ein Baseline-Gate vor der ersten geregelten Arbeit und nach relevanter
   RL-/CL- oder Image-Aenderung;
2. ein Delta-Gate bei materiellen Aenderungen oder festgelegten
   Qualitaets-/Lebenszyklus-Checkpoints;
3. ein Abschluss-Gate vor Merge, Release oder Uebergabe;
4. ein Image-Impact-Gate bei relevanter Baseline-Aenderung.

Produktstufen duerfen diese Gates lokal abbilden. Die Stufennummern werden
nicht Bestandteil des generischen Vertrags.

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
Selbstpruefungsgrundlagen in den kuenftigen Gate-Vertrag eingehen.

### 2.1 Belegter HOSK-Feldpilot

Der HOSK-Feldpilot ist Consumer-Evidence und keine normative Level-0-Quelle.
Seit Erstellung des ersten Drafts wurden folgende Staende menschlich reviewt,
gemergt und synchronisiert:

- RL-SE-001 v2.13.0 und Sammelband v1.15.0: [MR !6](https://gitlab-ce.gwdg.de/ausbildung/thorsten/RL_Sichere-Entwicklung/-/merge_requests/6),
  Merge-Commit `ee33f27c1175a3c86502421b1456bee7f666dd01`;
- RL-/CL-Governance-Overlay v0.2.0: [MR !1](https://gitlab-ce.gwdg.de/ausbildung/thorsten/spec-kit-preset-gwdg-rl-cl-governance/-/merge_requests/1),
  Merge-Commit `5c169249bc96ef3919675ad6a13ae48664cfa9c2`;
- Development-Image-Integration [MR !57](https://gitlab-ce.gwdg.de/agentic-coding/ade-dev-sandbox/-/merge_requests/57)
  und nachgelagerte Merge-Evidence [MR !58](https://gitlab-ce.gwdg.de/agentic-coding/ade-dev-sandbox/-/merge_requests/58):
  `efe962366151c8e95d48c93c6f64877c90f9330e` und
  `96bca383cf9f93eb35d1bffe51e91208d7f7af5d`;
- HOSK-Integration [MR !3](https://gitlab-ce.gwdg.de/thinder/SysInfoToolHOSK/-/merge_requests/3)
  und nachgelagerte Merge-Evidence [MR !4](https://gitlab-ce.gwdg.de/thinder/SysInfoToolHOSK/-/merge_requests/4):
  `0a0a9de8d0a2f07d15c399d2e529aff17e6dd5ad` und
  `8350dba400c94f93a6fe19ea885c106a972083aa`.

Das technisch validierte Image
`localhost/ade-dev-sandbox-ade:rl-cl-2.13.0` ist auf Digest
`sha256:676ef75a1122b639d8e38d755ab96ed5ec92b2e0004b4e836f71a49bbca61580`
gepinnt. Der Nachweis umfasst 13 Presets, fuenf RL-/CL-Kommandos, elf
Runbook-Validator-Tests, SBOM und Laufzeithaertung. Die HOSK-Matrix enthaelt
163 eindeutige Pruefpunkte. `CL_01-13` und `CL_10-18` sind fuer diese
Integration erfuellt; `CL_12-13` bleibt bis zum ersten echten Delta-Lauf
`not fulfilled`.

Fuer den gesamten HOSK-Proof-of-Concept sind Produktstufen 0 bis 5 und ein
Gesamtsystemtest vor dem voraussichtlich im November 2026 stattfindenden
Audit als Pilotumfang bestaetigt. Eine nicht vertrauliche QMS-/DMS-Referenz,
Auflagen und Re-Review-Trigger muessen in der Consumer-Evidence stehen. Diese
umfangsbegrenzte Nutzung ist keine allgemeine Sandbox-, Produktiv- oder
Flottenfreigabe.

Produktstufe 1 ist vorbereitet, aber noch nicht ausgefuehrt. Erwartet werden
`docs/security/rl-cl/deltas/yaml-export-format.json` und
`docs/runbooks/rl-cl/delta-yaml-export-format.md`. Ein lokales
Ausfuehrungsrunbook bleibt eine ungetrackte Arbeitshilfe und ist keine
Auditnachweis.

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

## 4. Vorgeschlagener ereignisbezogener Gate-Vertrag

| Ereignis | Mindestpruefung | Erwartete Evidence | Gate-Wirkung |
|---|---|---|---|
| Vor erster geregelter Arbeit oder nach relevanter RL-/CL-Aenderung | Baseline-Versionen, Anwendbarkeit, Ausgangsrisiko, Preset-Profil und Development-Image-Bezug | Baseline-Manifest, erste Matrix, begruendete `N/A`-/`Open`-Entscheidungen, Image-Referenz | Facharbeit startet nur mit nachvollziehbarer Ausgangslage |
| Materielle Aenderung oder definierter Checkpoint | Delta gegen Baseline und letzte akzeptierte Entscheidung | geaenderte Matrixzeilen, Spec-Kit-Artefakte, Tests, Reviews, Ausnahmen und gegebenenfalls Image-Auswirkungsdelta | Nur betroffene Pruefpunkte werden erneut bewertet; Trigger und Begruendung bleiben sichtbar |
| Vor Merge, Release oder Uebergabe | vollstaendige Abschluss- und Konsistenzpruefung | gueltige Baseline und Deltas, Matrix, Review-Evidence, Restrisiken, Ausnahmen, Image- und Liefernachweise | Kein positiver Abschluss bei fehlender Pflicht-Evidence |
| Relevante Baseline- oder Image-Aenderung | technische Auswirkung auf Image, Presets, Werkzeuge und Betriebsgrenzen | Impact-Entscheidung, Build-/Testnachweis, Digest, SBOM und Laufzeithaertung | Betroffene Consumer starten erst mit kontrolliertem Image-Bezug |

Ein Delta darf nicht allein aus einem geaenderten Dateinamen abgeleitet
werden. Es braucht einen fachlichen Trigger, betroffene Pruefpunkt-IDs und
einen nachvollziehbaren Bezug zur letzten akzeptierten Entscheidung.

HOSK bildet Stufe 0 lokal auf die Baseline, Stufen 1 bis 4 auf definierte
Delta-Checkpoints und Stufe 5 auf den Abschluss der Schulungsserie ab. Ein
frueherer Merge-, Release- oder Uebergabeanlass kann das Abschluss-Gate bereits
vor Stufe 5 ausloesen.

## 5. Verantwortungsgrenzen

### 5.1 Level 0

Das Level-0-Repository verwaltet die versionierte Secure-Development-Basis,
stabile Pruefpunkt-IDs, Regeln fuer Anwendbarkeit und Evidence sowie den
generischen Gate-Vertrag. Es verwaltet keine projektspezifischen
Erfuellungsbehauptungen als normative Wahrheit.

### 5.2 Agentic Workspace governance overlay

Der Agentic Workspace governance overlay stellt Vorlagen, Validatoren und
Pruefkommandos fuer Baseline, Delta, Abschluss, Image-Auswirkung und
Gate-Runbooks bereit. Installation oder Aufloesung eines Presets beweist noch
keine Anwendbarkeit, Erfuellung, Freigabe oder Ausnahmegenehmigung.

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

### 5.6 Getrennte Autorisierungsebenen

Mindestens vier Entscheidungen werden getrennt dokumentiert:

1. technische Image-Validierung mit Digest und technischen Nachweisen;
2. umfangsbegrenzte Nutzungsfreigabe fuer einen Consumer oder Pilot mit
   QMS-/DMS-Referenz, Auflagen und Re-Review-Trigger;
3. projektbezogene Gate-, Review- und Abnahmeentscheidungen;
4. allgemeine Sandbox-, Produktiv- oder Flottenfreigabe.

Eine niedrigere Ebene erteilt keine hoehere Autorisierung. Insbesondere ist
ein technisch validiertes Image noch nicht allgemein freigegeben, und eine
Pilotfreigabe autorisiert keinen Flotten-Roll-out.

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

Auditnachweise liegen standardmaessig unter `docs/security/rl-cl/`:

- `baseline.json`;
- `evidence-matrix.md`;
- `deltas/<change-id>.json`;
- `closure.json`;
- `development-image-impact.json`.

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

Ist eine gemergte Baseline unveraendert und stimmen Quellstand, Presets und
Image-Digest exakt, wird sie vor einem Feature fail-closed und read-only
geprueft. Sie wird nicht fuer jedes Feature neu erzeugt. Drift oder eine
relevante Aenderung startet einen getrennten, reviewten Baseline- und
gegebenenfalls Image-Impact-Lauf.

Gate-Runbooks sind getrennte, bilinguale Arbeitshilfen unter
`docs/runbooks/rl-cl/<gate>-<context-id>.md`. Ein festes `runbook.md` ist nicht
zulaessig. Fuer Ausbildungsprofile und gemischte Teams sind Runbooks
verpflichtend; reine Entwicklungsteams duerfen sie bei begruendeter
Projektregel optional verwenden. Jedes Runbook nennt Rollen, Status,
Stopbedingungen und genau eine naechste Aktion.

Ein faelliges Runbook wird explizit vor dem Gate erzeugt oder aktualisiert und
auf Status `Current` validiert. Das Delta oder der Abschluss verweist danach
auf das Runbook, zaehlt es aber nicht als Auditnachweis. Lokale
Ausfuehrungsrunbooks koennen ungetrackt bleiben; kontrollierte Gate-Runbooks
und Auditnachweise werden bewusst getrennt gestaged.

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
- Reicht ein HOSK-Pilot, oder welche weiteren Plattform-, Risiko- und
  Projektprofile muessen vor einer Flottenentscheidung vertreten sein?
- Muessen die HOSK-Deltas aus Stufe 1 bis 4, der Abschluss aus Stufe 5 und der
  Gesamt-Systemtest vor dem voraussichtlichen Audit im November 2026
  vollstaendig reviewt sein, bevor eine Roll-out-Entscheidung vorbereitet wird?
- Wie werden technische Validierung, umfangsbegrenzte Pilotfreigabe und
  allgemeine Flottenfreigabe in einer Flottenmatrix getrennt?

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

1. Owner und kanonische Quelle des Gate-Vertrags;
2. verbindliche oder beratende Wirkung je Gate und lokaler Stufenabbildung;
3. Trigger und Mindestnachweise der Image-Auswirkungspruefung;
4. Speicherort, Schema und Lebenszyklus der zentralen Matrix;
5. Verhaeltnis zu Position 7, Position 8 und der geplanten
   Baseline-Synchronisierung;
6. Grenzen der Erleichterung durch Spec-Kit-Evidence;
7. Umgang mit Versionsdrift und Uebergangsfristen;
8. Entscheidung, ob und wie eine spaetere Pilotdiskussion fortgesetzt wird;
9. Trennung technischer Validierung, umfangsbegrenzter Nutzung und allgemeiner
   Freigabe;
10. Mindestnachweise des HOSK-Gesamtlaufs vor Audit- und Roll-out-Diskussion.

## 13. Akzeptanzkriterien fuer diesen Handoff

- Das Issue nennt `@hindermath` und fordert die offenen Entscheidungen an.
- Baseline, Delta, Abschluss und Image-Impact sind ereignisbezogen getrennt;
  die HOSK-Stufen 0 bis 5 sind nur eine lokale Abbildung.
- Level 0, Agentic Workspace governance overlay, Development Image und
  Level-2-Consumer-Repositories besitzen klare Verantwortungsgrenzen.
- Der Development-Image-Impact besitzt pruefbare Mindestfelder und
  fail-closed Statusregeln.
- Eine zentrale Matrix verbindet RL-/CL-Pruefpunkte mit Spec-Kit-, Review-,
  Test-, Ausnahme- und Image-Evidence, ohne eine zweite Normquelle zu werden.
- Auditnachweise und dynamisch benannte Gate-Runbooks sind getrennt; Runbooks
  werden explizit erzeugt, auf `Current` geprueft und nicht als Evidence
  gezaehlt.
- Technische Image-Validierung, umfangsbegrenzte Pilotnutzung,
  projektbezogene Gates und allgemeine Freigabe werden nicht gleichgesetzt.
- Der HOSK-Pilot nennt Stufen 0 bis 5, Gesamtsystemtest, den erwarteten
  Auditzeitraum und die noch offenen Delta-/Abschlussnachweise.
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
**As of:** 2026-08-23
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

1. a baseline gate before the first governed work and after a relevant RL/CL
   or image change;
2. a delta gate at a material change or defined quality or lifecycle
   checkpoint;
3. a closure gate before merge, release, or handover;
4. an image-impact gate after a relevant baseline change.

Product stages may map to these gates locally. Stage numbers do not become
part of the generic contract.

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
feed the future gate contract.

### 16.1 Evidenced HOSK field pilot

The HOSK field pilot is consumer evidence, not a normative Level-0 source.
Since the first draft was created, the following revisions have been reviewed
by a human, merged, and synchronized:

- RL-SE-001 v2.13.0 and checklist compendium v1.15.0: [MR !6](https://gitlab-ce.gwdg.de/ausbildung/thorsten/RL_Sichere-Entwicklung/-/merge_requests/6),
  merge commit `ee33f27c1175a3c86502421b1456bee7f666dd01`;
- RL/CL governance overlay v0.2.0: [MR !1](https://gitlab-ce.gwdg.de/ausbildung/thorsten/spec-kit-preset-gwdg-rl-cl-governance/-/merge_requests/1),
  merge commit `5c169249bc96ef3919675ad6a13ae48664cfa9c2`;
- Development Image integration [MR !57](https://gitlab-ce.gwdg.de/agentic-coding/ade-dev-sandbox/-/merge_requests/57)
  and downstream merge evidence [MR !58](https://gitlab-ce.gwdg.de/agentic-coding/ade-dev-sandbox/-/merge_requests/58):
  `efe962366151c8e95d48c93c6f64877c90f9330e` and
  `96bca383cf9f93eb35d1bffe51e91208d7f7af5d`;
- HOSK integration [MR !3](https://gitlab-ce.gwdg.de/thinder/SysInfoToolHOSK/-/merge_requests/3)
  and downstream merge evidence [MR !4](https://gitlab-ce.gwdg.de/thinder/SysInfoToolHOSK/-/merge_requests/4):
  `0a0a9de8d0a2f07d15c399d2e529aff17e6dd5ad` and
  `8350dba400c94f93a6fe19ea885c106a972083aa`.

The technically validated image
`localhost/ade-dev-sandbox-ade:rl-cl-2.13.0` is pinned to digest
`sha256:676ef75a1122b639d8e38d755ab96ed5ec92b2e0004b4e836f71a49bbca61580`.
Evidence covers 13 presets, five RL/CL commands, eleven runbook-validator
tests, an SBOM, and runtime hardening. The HOSK matrix contains 163 unique
checkpoints. `CL_01-13` and `CL_10-18` are fulfilled for this integration;
`CL_12-13` remains `not fulfilled` until the first actual delta run.

The confirmed pilot scope covers HOSK product stages 0 through 5 and a whole-
system test before the audit expected in November 2026. A non-confidential
QMS/DMS reference, conditions, and reevaluation triggers must be recorded in
consumer evidence. This scoped use approval is not general sandbox,
production, or fleet approval.

Product stage 1 is prepared but has not started. Expected artifacts are
`docs/security/rl-cl/deltas/yaml-export-format.json` and
`docs/runbooks/rl-cl/delta-yaml-export-format.md`. A local execution runbook
remains an untracked working aid and is not audit evidence.

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

## 18. Proposed event-driven gate contract

| Event | Minimum assessment | Expected evidence | Gate effect |
|---|---|---|---|
| Before first governed work or after a relevant RL/CL change | Baseline versions, applicability, current risk, preset profile, and Development Image relationship | Baseline manifest, initial matrix, justified `N/A` and `Open` decisions, image reference | Domain work starts only from a traceable current state |
| Material change or defined checkpoint | Delta against the baseline and the last accepted decision | Changed matrix rows, Spec Kit artifacts, tests, reviews, exceptions, and image-impact delta where needed | Only affected checkpoints are reassessed, with visible triggers and rationale |
| Before merge, release, or handover | Complete closure and consistency assessment | Valid baseline and deltas, matrix, review evidence, residual risks, exceptions, image evidence, and delivery evidence | No positive closure when mandatory evidence is missing |
| Relevant baseline or image change | Technical impact on image, presets, tools, and operational boundaries | Impact decision, build and test evidence, digest, SBOM, and runtime hardening | Affected consumers start only with a controlled image reference |

A delta must not be inferred only from a changed filename. It needs a material
trigger, affected checkpoint IDs, and a traceable link to the last accepted
decision.

HOSK maps stage 0 locally to the baseline, stages 1 through 4 to defined delta
checkpoints, and stage 5 to training-series closure. An earlier merge, release,
or handover event may trigger closure before stage 5.

## 19. Responsibility boundaries

### 19.1 Level 0

The Level-0 repository owns the versioned secure-development baseline, stable
checkpoint IDs, applicability and evidence rules, and the generic gate
contract. It does not treat project-specific fulfilment claims as normative
truth.

### 19.2 Agentic Workspace governance overlay

The Agentic Workspace governance overlay supplies templates, validators, and
validation commands for baseline, delta, closure, image impact, and gate
runbooks. Installing or resolving a preset does not prove applicability,
fulfilment, approval, or an accepted exception.

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

### 19.6 Separate authorization layers

At least four decisions are recorded separately:

1. technical image validation with digest and technical evidence;
2. scope-limited use approval for a consumer or pilot, including QMS/DMS
   reference, conditions, and reevaluation trigger;
3. project-specific gate, review, and acceptance decisions;
4. general sandbox, production, or fleet approval.

A lower layer grants no higher authorization. A technically validated image is
not generally approved, and pilot approval does not authorize fleet rollout.

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

Audit evidence lives under `docs/security/rl-cl/` by default:

- `baseline.json`;
- `evidence-matrix.md`;
- `deltas/<change-id>.json`;
- `closure.json`;
- `development-image-impact.json`.

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

When a merged baseline is unchanged and source revision, presets, and image
digest match exactly, it is checked fail-closed and read-only before a feature.
It is not regenerated for every feature. Drift or a relevant change starts a
separate, reviewed baseline and, where needed, image-impact run.

Gate runbooks are separate bilingual working aids under
`docs/runbooks/rl-cl/<gate>-<context-id>.md`. A fixed `runbook.md` is not
allowed. Runbooks are mandatory for training profiles and mixed teams; pure
development teams may make them optional under a justified project rule. Each
runbook states roles, status, stop conditions, and exactly one next action.

A due runbook is explicitly created or updated before its gate and validated
as `Current`. The delta or closure then references the runbook but does not
count it as audit evidence. Local execution runbooks may remain untracked;
controlled gate runbooks and audit evidence are staged deliberately and
separately.

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
- Is one HOSK pilot sufficient, or which additional platform, risk, and project
  profiles must be represented before a fleet decision?
- Must HOSK deltas from stages 1 through 4, stage-5 closure, and the whole-
  system test be fully reviewed before the audit expected in November 2026 and
  before a rollout decision is prepared?
- How does a fleet matrix keep technical validation, scoped pilot approval,
  and general fleet approval separate?

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

1. owner and canonical source of the gate contract;
2. mandatory or advisory effect of each gate and local stage mapping;
3. triggers and minimum evidence for image-impact assessment;
4. location, schema, and lifecycle of the central matrix;
5. relationship to position 7, position 8, and the planned baseline
   synchronization;
6. limits of any simplification through Spec Kit evidence;
7. handling of version drift and grace periods;
8. whether and how a later pilot discussion should continue;
9. separation of technical validation, scoped use, and general approval;
10. minimum HOSK whole-run evidence before audit and rollout discussion.

## 27. Acceptance criteria for this handoff

- The issue mentions `@hindermath` and requests the open decisions.
- Baseline, delta, closure, and image impact are separated by event; HOSK
  stages 0 through 5 are only a local mapping.
- Level 0, the Agentic Workspace governance overlay, the Development Image,
  and Level-2 consumer repositories have clear responsibility boundaries.
- Development Image impact has auditable minimum fields and fail-closed
  status rules.
- A central matrix links RL/CL checkpoints to Spec Kit, review, test,
  exception, and image evidence without becoming a second normative source.
- Audit evidence and dynamically named gate runbooks are separated; runbooks
  are created explicitly, validated as `Current`, and not counted as evidence.
- Technical image validation, scoped pilot use, project gates, and general
  approval are not treated as equivalent.
- The HOSK pilot records stages 0 through 5, the whole-system test, expected
  audit period, and still-open delta and closure evidence.
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
