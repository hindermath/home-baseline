# Implementierungsplan: Flottenweiter Stage-B-Rollout / Implementation Plan: Fleet-Wide Stage-B Rollout

**Branch**: `030-stage-b-rollout` | **Datum / Date**: 2026-08-21 | **Spezifikation / Spec**: [spec.md](spec.md)

**Input / Eingabe**: Ready-bewertetes Stage-B-Lastenheft, abgeschlossene
Requirements-, Clarification- und Governance-Checklisten, aktiver Autonomous
Run `954ff259-ffed-44a8-883f-28742b031a9b` sowie terminal abgeschlossenes
Stage-A-Feature [029-ci-budget-governance](../029-ci-budget-governance/plan.md)

**Delivery Mode / Liefermodus**: `MergeAndSync` mit ausdrücklich autorisiertem,
ziel- und zeitgebundenem Admin-Bypass als Ausnahmeweg. Der Bypass ersetzt
niemals Acceptance-, Security-, Review- oder Gate-Evidence.

## Zusammenfassung / Summary

Stage B erweitert den vorhandenen Python-Vertragskern
`scripts/lib/agentic_workspace_fleet.py` und die gepaarten Wrapper
`scripts/maintain-agentic-workspace.sh` und
`scripts/maintain-agentic-workspace.ps1`. Neue Stage-B-Subcommands führen
einen vollständig read-only Flotten-Preflight, eine lokale Vorschau, genau
eine serialisierte Zieltransaktion und ein fail-closed Resume aus. Die Wrapper
erhalten die äquivalenten Oberflächen `--stage-b-action` und
`-StageBAction`; `Invoke-HBAgenticWorkspaceMaintenance` bleibt die genehmigte
PowerShell-Cmdlet-Oberfläche.

Die autoritative Zielmenge wird bei jedem Start und Resume dynamisch als
Vereinigung des Level-0-Self-Records `home-baseline` mit allen aktiven
`kind=git-repository`-Manifestzielen gebildet. Collection-Knoten sind
ausgeschlossen. Manifest, Profilzuordnungen, Live-Inventar und fixierter
Stage-B-Rolloutplan müssen exakt dieselbe stabile Repository-ID-Menge besitzen.
Der historische Wert `1 + 47 = 48` ist nur ein Vergleichssnapshot.

Nach erfolgreichem Level-0-Control-Plane-Merge und erneuter Revalidierung läuft
genau ein repräsentativer Public-Canary-Slice für
`agent-operations-cockpit`. Erst dessen roter und grüner Vertragsnachweis
öffnet die vollständige, lexikografisch sortierte Canary-Welle. Danach folgen
serialisiert Public Products, Private Products, Private Governance/Scaffold
und Public Presets. Das erste nicht behebbare Problem stoppt vor dem nächsten
Ziel. Nach jeder der fünf Wellen wird das private Actions-Budget neu berechnet.

## Technischer Kontext / Technical Context

**Sprachen / Language versions**: vorhandener Python-3-Kern als primäre
speichersichere Laufzeit; Bash 3.2+-kompatible Oberfläche für macOS/Linux;
PowerShell 7+ auf .NET für Windows

**Primäre Abhängigkeiten / Primary dependencies**: ausschließlich
Python-Standardbibliothek, Git, `gh` CLI für authentifizierte GitHub-Lese- und
autorisierte Schreiboperationen sowie vorhandene Repository-Validatoren; keine
neue Paketabhängigkeit

**Speicherung / Storage**: kanonische Stage-A-Registries unter
`scripts/config/`; neue installierbare Stage-B-Schemas ebenfalls dort;
maschinenlokaler Stage-B-Laufzustand unter dem aktiven `stage-b/`-Run-Pfad
und der eine versionierte Stage-B-Evidence-Root
`.specify/runtime/autonomous-routing/954ff259-ffed-44a8-883f-28742b031a9b/stage-b/evidence/v1/`;
nur redigierte, schema-validierte Abschlussnachweise werden später unter
`specs/030-stage-b-rollout/evidence/v1/` versioniert

**Tests / Testing**: Python `unittest` mit deterministischen Fixtures,
Schema-/Semantikvalidatoren, Bash-Syntax, PowerShell-Parser und
PSScriptAnalyzer, Secret Scan, Dokumentations-/A11Y-/Statistikvalidatoren,
Provider-Mutation-Spies sowie native oder hashgebundene macOS-/Linux-/Windows-
Feldnachweise

**Zielplattformen / Target platforms**: macOS und Linux über Bash, Windows
über PowerShell 7+, GitHub als providerabhängige PR-/Actions-/Ruleset-Fläche

**Projekttyp / Project type**: plattformübergreifende Level-0-CLI- und
Governance-Infrastruktur mit serieller Remote-Orchestrierung

**Leistungsziele / Performance goals**: genau ein Python-Engine-Prozess je
Wrapper-Aufruf; lineare, stabile Zielreihenfolge; höchstens drei Versuche nur
für klar transiente Leseoperationen; genau ein Mutationsversuch je
idempotentem Aktionsschlüssel; keine parallelen Zielwriter

**Grenzen / Constraints**: keine Shell-Auswertung, kein `eval` oder
`Invoke-Expression`, keine fremden Arbeitsbaumänderungen, keine unvalidierten
Provider-URLs oder IDs, keine Rohantworten in Evidence, keine Mutation nach
einem nicht behebbarem Fehler, kein G4-/Serien-/Copilot-/Account-/Subscription-
Zugriff

**Skalierung / Scale**: dynamische Flotte mit aktuell 48 Git-Repositories,
fünf Wellen einschließlich Public Canaries und genau einer Zieltransaktion zur
Zeit

**Exitcodes / Exit codes**: `0` Erfolg oder gültige mutationsfreie Vorschau;
`1` fachlicher Drift-/Gate-/Budget-/Review-Blocker; `2` Schema-, Sicherheits-,
Provider- oder Betriebsfehler; `3` vorhandener Maintenance-Reparaturvertrag;
`130` kontrollierter Stop

## Verfassungsprüfung vor Design / Pre-Design Constitution Check

*GATE: bestanden. `constitution.md` und `.specify/memory/constitution.md` sind
bytegleich, SHA-256 `00c57d51cdacca2be7499203b1a62a3b70fa72d3347866a5ced26ac332a52768`.
Die ausführbare Preset-Matrix und `specify preset list` weisen zwölf aktive
Presets aus; die kanonische Registry besitzt Autonomous Run Governance
v0.4.1. Die ältere Versionsnennung im erläuternden Constitution-Text ändert
keine Feature-Semantik; die Implementierung darf sie nicht beiläufig reparieren
und muss vor Delivery die kanonische Matrix erneut exakt validieren.*

| Prüfpunkt / Checkpoint | Entscheidung und konkrete Planung / Decision and concrete plan | Status |
|---|---|---|
| Level-0/Level-2 | Level 0 besitzt Orchestrierung und Verträge. Vor jedem Zieldiff wird die passende Environment-Registry-Zeile für Runtime, Build/Test, A11Y, Statistik und Agentenflächen gebunden. Nicht-MSL-Ziele wie `cc65` und `tvision` behalten Begründung und sichere Build-Evidence. | Pass |
| MSL und Secure Scripting | Python und PowerShell/.NET sind MSL. Bash bleibt die begründete native Unix-Paritätsoberfläche mit `set -euo pipefail`, Quotes, `--` und ohne `eval`. Neue kompilierte/runtime Komponente löst vollständige MSL-Neubewertung aus. | Pass |
| Secure Coding | Alle Prozesse werden als Executable plus Argumentliste mit festem Arbeitsverzeichnis gestartet. Eingaben, IDs, Pfade, Heads und Enumwerte werden vor Verwendung validiert. Fehlerausgaben werden begrenzt und redigiert. | Pass |
| Security / Supply Chain | Secret Scan, Dependency-/Lizenz-/CVE-/Herkunftsprüfung, SBOM/VEX/SLSA-Entscheidung, OpenSSF-Review und Security Review sind Pflicht. Keine neue Dependency ist geplant. | Pass |
| Architektur / iSAQB | Kontext-, Baustein-, Laufzeit-, Deployment-, Qualitäts-, Risiko- und Schuldensicht werden in `docs/architecture/ci-budget-governance.md` ergänzt. ADR-002 wird um Remote-Transaktion, Ruleset und Bypass erweitert. | Pass |
| Trust Boundaries | Lokale Klone, Git-Objekte, Registries, GitHub, PRs, Checks, Reviews, Rulesets, Authority, Run-State, Evidence und Home Runtime sind getrennte Vertrauens- und Transaktionsräume. STRIDE+CIA, CAPEC, Least Privilege, Defense in Depth und fail-safe defaults gelten. | Pass |
| Zero Trust / SAMM | `Applicable`; Identität, Head, Kandidat, Gate, Review, Ruleset und Ergebnis werden vor jeder abhängigen Aktion neu geprüft. Evidence in den bestehenden Security-Dokumenten. | Pass |
| BSI C3A/C5 | `Applicable`, weil GitHub als providerabhängige Hosting-, PR-, Actions- und Ruleset-Fläche real mutiert wird. Keine Zertifizierung wird behauptet. Re-Evaluation bei Providerwechsel oder Entfall der Cloudgrenze. | Pass |
| ASVS / AI-SBOM / Regulierung | ASVS und AI-SBOM bleiben begründet `N/A`: keine Web-/API-Runtime und KI nur Entwicklungswerkzeug. NIS2, CRA, EU AI Act und DORA bleiben gemäß Spec `N/A`; Trigger bleiben dokumentiert. | Pass |
| A11Y / Sprache | CLI, Reports, Manpage und Hilfe bleiben WCAG-2.2-AA-orientiert, text-first, keyboard-/Screenreader-/Braille-/Textbrowser-tauglich, DE zuerst/EN danach und ungefähr CEFR B2. | Pass |
| Cross-Platform | Bash und PowerShell werden gemeinsam geändert. `--dry-run`/`-WhatIf`, Exitcodes, JSON-Felder, Manpage, bilinguale Hilfe, genehmigtes Cmdlet und Plattformfixtures sind ein Abnahmepaket. | Pass |
| Agent Parity | Review `Applicable`; Guidance-Update `N/A`, solange keine gemeinsame Guidance-, Constitution-, Template- oder Routingsemantik geändert wird. Bei Trigger werden alle fünf gepflegten Agentenflächen plus Templates und Constitution-Mirror atomar aktualisiert. | Pass |
| Autonomous / Parallel | Autonomous Governance ist `Applicable`; Parallel Governance ist für die serielle Zielausführung `N/A`. Keine Kampagne oder Delegation wird gestartet. Phase-Result, Delivery-Set, PreMerge/PostMerge und kausaler Closeout werden geplant. | Pass |
| Documentation / Statistik | Genau eine Entscheidung `UpdateRequired`; Projektdokumentation und Statistikrenderer werden aktualisiert. Scripts sind `homeRuntime`, Design/Evidence `sourceOnly`, Rohzustand `machineLocal`. | Pass |

## Governance-Evidence-Plan / Governance Evidence Plan

Jeder anwendbare Checkpoint erhält vor Runtime-Codeänderungen eine ausgefüllte
Markdown-Evidence mit Applicability, Implementation Status, Rationale,
Evidence-Pfad, Owner, Reviewer, Restrisiko, Follow-up und Re-Evaluation. `Open`
ist im akzeptierten Plan nicht vorhanden. Security, Architecture, iSAQB, A11Y,
Cross-Platform, Agent Parity und Autonomous Run sind `Applicable`. Parallel
Autonomous, Model Routing, Intake Authoring/Review/Sequencing sind für neue
Featurearbeit `N/A`, ihre bestehenden Eingaben und Gates werden jedoch
read-only revalidiert. Owner ist der Fleet Delivery Owner; fachliche Reviewer
sind Security/Compliance, Architecture/iSAQB, A11Y, Cross-Platform,
Repository Owner und Agent-Parity Reviewer.

Geplante Evidence-Flächen:

- `specs/030-stage-b-rollout/checklists/implementation-governance.md`
- `specs/030-stage-b-rollout/checklists/cross-platform.md`
- `specs/030-stage-b-rollout/checklists/stage-b-mutation-allowlist.md`
- `specs/030-stage-b-rollout/documentation-impact-evidence.json`
- `docs/architecture/ci-budget-governance.md`
- `docs/accessibility/ci-budget-governance.md`
- Security-Dateien aus `CR-011`, einschließlich ADR-002, C3A und C5
- maschinenlokale operative Evidence unter `stage-b/evidence/v1/operational/`,
  temporäre Primary-Snapshots unter `stage-b/evidence/v1/primary/` und interne
  Routingresultate getrennt direkt unter dem aktiven Autonomous-Run-Root

### Installierte Presets / Installed Presets

| Preset | Version | Applicability | Planstatus und Re-Evaluation / Plan status and re-evaluation |
|---|---:|---|---|
| Security Governance | v0.6.2 | `Applicable` | Secure Scripting, Secret/Dependency/Supply-Chain/Threat Review und konkrete Evidence geplant; neu bei Dependency-, Auth-, Crypto- oder Trust-Boundary-Drift bewerten. |
| Architecture Governance | v0.5.2 | `Applicable` | Remote-Transaktion, Ruleset, Zero Trust, SAMM, C3A/C5, S-ADR und arc42 geplant; bei Provider-/Deploymentänderung neu bewerten. |
| iSAQB Architecture Governance | v0.2.2 | `Applicable` | Kontext-, Baustein-, Laufzeit-, Deployment-, Qualitäts-, Risiko- und Schuldensicht geplant; bei Struktur-/Runtimeänderung neu bewerten. |
| A11Y Governance | v0.4.3 | `Applicable` | Text-first, WCAG 2.2 AA, DE/EN, CEFR B2 und didaktische Kommentare geplant; bei jeder User-Output-Änderung neu bewerten. |
| Cross-Platform Governance | v0.2.2 | `Applicable` | Gepaarte Wrapper, Preview, Manpage, Hilfe, Cmdlet und Drei-Plattform-Evidence geplant; bei Plattform-/CLI-Drift neu bewerten. |
| Agent Parity Governance | v0.4.2 | `Applicable` für Review; Update `N/A` | Paritätsvalidator bleibt Gate; atomarer Fünf-Flächen-/Template-/Constitution-Trigger bei gemeinsamer Semantikänderung. |
| Model Routing Governance | v0.1.4 | `N/A` für Featureänderung | Lokales Profil hat die Phase fail-closed gestartet; keine Routingrolle oder Modellpolicy wird geändert. Re-Evaluation bei Routingdrift. |
| Intake Authoring Governance | v0.3.1 | `N/A` | Akzeptiertes Intake/Receipt bleiben unverändert. Hashdrift verlangt Stop und neue Autorität. |
| Intake Review Governance | v0.2.1 | `Applicable` als Eingabegate; neue Reviewarbeit `N/A` | Ready-Review ohne Findings wird revalidiert; Artefakt- oder Policy-Drift verlangt Re-Review. |
| Intake Sequencing Governance | v0.2.3 | `N/A` | Serie bleibt unverändert und G4 blockiert. Re-Evaluation nur bei separat erteilter Serienautorität. |
| Autonomous Run Governance | v0.4.1 | `Applicable` | Delivery Set, Phase Result, Gate Requirements, Run State, Pre/PostMerge, Closeout und Resume geplant; an jeder Phasengrenze revalidieren. |
| Parallel Autonomous Run Governance | v0.2.6 | `N/A` | Keine Kampagne, Worker oder Parallelwriter autorisiert. Re-Evaluation nur bei ausdrücklicher Kampagnenautorität. |

## Architektur und Datenfluss / Architecture and Data Flow

### Bausteine / Building Blocks

1. **StageBFleetPreflight** lädt G3-Abschluss, beide Constitutions, Fleet
   Manifest, Profil-/Pfadregistries, Environment Registry, Authority und
   Providerinventar genau einmal pro Snapshot. Er bildet die dynamische Union,
   prüft Mengengleichheit und fixiert `inputSetHash`.
2. **StageBRolloutPlanner** führt die Stage-A-Entscheidung gegen jeden aktuellen
   Ziel-HEAD erneut aus. Er erzeugt geordnete Blob-/Mode-Änderungen statt
   plattformabhängiger Patchtexte und bindet `baselineHead`, `baselineTree`,
   Profil-, Pfad-, Gate- und Ruleset-Plan-Hashes.
3. **ExternalWriteGate** validiert aktuelle `MergeAndSync`-Authority,
   Scope-Hash, Run-ID, Delivery Set und den unveränderlichen Planhash im
   veränderlichen Run-State unmittelbar vor der ersten Mutation sowie erneut
   vor jeder Providerwrite-Klasse. Vorschau und lokale Validierung können
   dieses Gate nicht öffnen.
4. **StageBTargetTransaction** verarbeitet genau ein Ziel in einer isolierten,
   laufgebundenen Worktree-Grenze. Er prüft Identität und Heads, materialisiert
   den exakten Diff, führt lokale Gates aus, committet nur die geplanten Blobs,
   pusht, erstellt den PR, prüft Remote-Gates und reguläre Review, mergt und
   synchronisiert den Default Branch.
5. **GitHubProviderAdapter** besitzt getrennte read-only und write
   Argumentlisten. Er akzeptiert nur zuvor gebundene GitHub-Repository-IDs und
   kanonische Slugs; er konstruiert keine URL aus freien Eingaben und nutzt
   keine Shell.
6. **StageBRulesetTransaction** installiert für Private Governance/Scaffold
   den Workflow per PR und danach den minimalen Ruleset. Vorheriger Zustand,
   Plan, Provideraktions-ID und ein begrenzter Restore-Request werden
   hashgebunden. Bei fehlgeschlagener Post-Write-Prüfung wird höchstens der
   exakt vorab geplante Restore versucht; danach stoppt der Lauf immer.
7. **StageBEvidenceLedger** publiziert erst nach Schema- und Redaktionsprüfung
   atomare Ziel-, Wellen-, Budget-, Terminal- und Closeout-Resultate unter dem
   operativen Evidence-Namespace. PreMerge und PostMerge werden kausal über
   Hashes, Kandidaten-Head und Merge-Commit verbunden.
8. **StageBWaveCoordinator** sortiert Ziele, erlaubt nur eine Transaktion und
   schließt eine Welle erst bei vollständiger PR-/Sync- oder No-op-Konvergenz.
9. **StageBBudgetProjector** verwendet das Stage-A-Decimal-Modell und erzeugt
   nach jeder Welle eine neue frische Projektion; fehlende Daten blockieren.
10. **StageBTerminalVerifier** vergleicht das Ledger erneut mit der live
    autoritativen Menge, prüft Providerzustand read-only und erzeugt nur den
    G4-Evidence-Handoff, keine Serien- oder G4-Mutation.

### Unveränderlicher Plan und veränderlicher Laufzustand / Immutable Plan and Mutable Run State

Die fünf neuen Verträge sind einzeln und verbindlich versioniert:
`StageBRolloutPlan` v1.1, `StageBRunState` v1.1,
`RepositoryRolloutResult` v1.1, `StageBRulesetPlan` v1.0 und
`FleetTerminalEvidence` v1.1. Eine pauschale Schema-1.0-Annahme ist unzulässig;
Validatoren wählen den Vertrag anhand Dokumenttyp und exakter Version.

`StageBRolloutPlan` Schema v1.1 ist nach seiner Fixierung unveränderlich. Sein
`planHash` umfasst ausschließlich den kanonischen Payload aus Stage-A-Referenz,
Flotten-/Inputset-Hashes, `MergeAndSync`-Liefermodus, fünf statischen
Wellenzuordnungen, Zielplänen und `firstMutation`; `createdAt` und `planHash`
selbst sind ausgeschlossen. Authority-Hash, ExternalWriteGate-Status,
Wellenstatus, Repositoryresultate, Budgetprojektionen, Blocker, nächste Aktion,
terminale Evidence und Closeout gehören ausdrücklich nicht zum Planpayload.
Delivery-Fortschritt kann den fixierten Plan deshalb nicht selbst invalidieren.

`StageBRunState` Schema v1.1 ist der einzige veränderliche Stage-B-Zustand. Er
bindet `rolloutPlanBinding.planId`, repository-relativen Planpfad und den
unveränderlichen `planSha256` an die jeweils aktuelle `authorityBinding`, den
Flottensnapshot, aktuelle Wellen-/Repositoryresultatpfade und -hashes, fünf
Budgetprojektionen sowie explizite Terminal- und Closeout-Evidence-Bindungen.
Jedes normative operative Result-/Evidence-Dokument trägt `planSha256` direkt
auf seiner eigenen obersten Ebene; insbesondere gilt dies für
`RepositoryRolloutResult`, Wellenresultat, Budgetprojektion, PreMerge,
PostMerge, `FleetTerminalEvidence` und Closeout. Der Run-State ist nur der
hashgebundene Index und keine äußere Hülle, aus der ein Dokument seine
Planbindung erben dürfte. Seine Result-/Evidence-Einträge wiederholen
`planSha256`; der Semantikvalidator verlangt Gleichheit mit
`rolloutPlanBinding.planSha256` sowie dieselbe Run-ID in Plan, State und allen
Dokumenten und Pfadeinträgen. Authority- oder Gate-Drift schließt den
Schreibzugang und wird im State revalidiert, ändert aber den Planhash nicht.
Nur Drift einer unveränderlichen Planeingabe erzeugt eine neue Planrevision.

`firstMutation` ist entweder die fixierte erste mutierende Repository-/Aktions-
und Baseline-Bindung oder exakt `N/A`. `N/A` ist nur zulässig, wenn jedes Ziel
als `NoOpCandidate` geplant ist und auch keine Ruleset-Mutation benötigt wird.
Vor jedem tatsächlichen Commit, Push, PR, Merge, Ruleset-Write oder Restore
müssen ein konkretes `firstMutation`-Objekt und ein aktuelles offenes
ExternalWriteGate im Run-State vorliegen. So bleiben SBR-015 und AC-SBR-006
für eine vollständig bereits konvergente Flotte erhalten.

### Evidence-Namespaces / Evidence Namespaces

Der eine kanonische, versionierte Stage-B-Evidence-Root lautet
`.specify/runtime/autonomous-routing/<run-id>/stage-b/evidence/v1/`; persistierte
Pfade sind stets repository-relativ und müssen `<run-id>` an `runId` binden.

- `operational/` enthält die kausale Betriebswahrheit: Repository- und
  Wellenresultate, Budgetprojektionen, Terminalnachweis und Closeout.
- `primary/` enthält temporäre, reproduzierbare AC-SBR-Primary-Snapshots des
  Aggregators. Sie referenzieren operative Hashes, sind aber nicht selbst der
  fortschreibbare Run-State.
- `.specify/runtime/autonomous-routing/<run-id>/*.result.json` bleibt der
  getrennte interne Routing-Namespace für Spec-Kit-Phasenergebnisse und liegt
  außerhalb des Stage-B-Evidence-Roots.
- `specs/030-stage-b-rollout/evidence/v1/` ist der spätere `sourceOnly`-Zielpfad
  für ausgewählte redigierte Abschlussnachweise. Kopien behalten Quellpfad und
  Quellhash; sie ersetzen niemals die operative Evidence.

### Deterministische Reihenfolge / Deterministic Order

Die Control-Plane-Lieferung des Level-0-Features wird zuerst abgeschlossen und
kausal geschlossen. Danach lautet die Zielreihenfolge:

1. Public Canaries, lexikografisch: `agent-operations-cockpit`,
   `home-baseline`, `tui-vision`;
2. Public Products, lexikografisch nach stabiler Repository-ID;
3. Private Products, lexikografisch;
4. Private Governance/Scaffold, lexikografisch;
5. Public Presets, lexikografisch.

Der Level-0-Control-Plane-Merge ist keine zusätzliche Fleet-ID. Für
`home-baseline` wird anschließend wie für jedes andere Ziel ein frischer
Stage-A-Diff berechnet; ein leerer Diff wird nur bei ebenfalls konvergenter
Providersemantik zum No-op.

### Zieltransaktion / Target Transaction

1. Provider-ID, Remote, Sichtbarkeit, Default Branch, lokaler Clean-Status,
   Remote-Head und unveränderlichen Planhash read-only neu prüfen.
2. Isolierte Worktree/Branch-ID
   `codex/stage-b-<run-id-kurz>-<repository-id>` aus dem gebundenen Baseline-
   Head erstellen. Vorhandene Branches/PRs werden nur bei exakter Run-/Head-
   Übereinstimmung wiederverwendet, sonst wird blockiert.
3. Gewünschten Zustand aus den Stage-A-Templates materialisieren. Exakte
   Änderungsliste aus Pfad, Modus, Vorher-/Nachher-Blobhash erstellen und mit
   dem fixierten Plan vergleichen.
4. Lokale profil- und projektspezifische Gates gemäß Environment Registry
   ausführen; Secret Scan und Security Review sind obligatorisch.
5. PreMerge-Evidence für den exakten Kandidaten schreiben und validieren.
6. Nur geplante Pfade stagen; Index-, Tree- und Commit-Hash gegen Plan prüfen;
   nichts Fremdes verwerfen oder übernehmen.
7. Branch pushen und PR mit Run-ID, Profil, Diffhash und Evidence-Verweisen
   erstellen oder einen exakt passenden vorhandenen PR fortsetzen.
8. Pflichtchecks über konkrete Workflow-/Job-/Runner-/Befehlsidentität und
   reguläre Review am aktuellen PR-Head prüfen. Billing/Quota, technisches
   Versagen und Pass bleiben getrennte Zustände.
9. Normalen Merge mit dem im Plan fixierten, aktuell erlaubten Verfahren
   (`merge`, sonst `squash`, sonst `rebase`) versuchen. `gh pr merge --admin`
   ist nur zulässig, wenn der normale Versuch ausschließlich an der
   Schutzregel scheitert, alle unabhängigen Nachweise bereits vollständig
   sind und die Bypass-Evidence unmittelbar vorher frisch validiert wurde.
10. Merge-Commit, Remote-Default-Head und lokale Synchronisierung prüfen;
    PostMerge-Evidence kausal an PreMerge binden. Erst dann Zielresultat
    `Converged` setzen.
11. Bei leerem Git-Diff keinen Branch/Commit/PR erzeugen. Semantische
    Profil-/Workflow-/Ruleset-Konvergenz separat prüfen; notwendige Ruleset-
    Aktionen werden vollständig auditiert. Erst danach atomare No-op-Evidence
    schreiben.

### Stop, Resume und Idempotenz / Stop, Resume, and Idempotency

Jede mutierende Aktion besitzt einen stabilen Idempotency Key aus Run-ID,
Repository-ID, Action Kind, Baseline Head, Candidate Head und unveränderlichem
Planhash. Ein
nicht behebbarer Fehler setzt Zustand `Stopped`, speichert Welle, Ziel,
letzte sichere Grenze, Blocker und nächste sichere Aktion und startet kein
weiteres Ziel. Ein bewusster Stop wird nur durch explizites Resume aufgehoben.

Resume lädt dieselbe Run-ID, validiert G3, Authority, Delivery Set, alle
Registries, Provider- und Budgetfrische neu, bestätigt bereits konvergierte
Ziele read-only und beginnt beim ersten nicht konvergierten Ziel. Drift an
einem konsumierten unveränderlichen Planeingabehash verwirft den betroffenen
Zielplan; Flotten-, Inputset- oder Profildrift verwirft den Gesamtplan.
Authority- oder Gate-Drift schließt dagegen den ExternalWriteGate und verlangt
Revalidierung im Run-State, ohne den Plan selbst umzuschreiben. Ein bereits
gemergter Erfolg wird nicht zurückgerollt und nicht erneut geliefert.

## Remote-Autoritätszuordnung / Remote Authority Mapping

| Aktion / Action | Oberfläche / Surface | Authority und Barrier | Evidence |
|---|---|---|---|
| Provider-, Git- und Budget-Reads | `gh api --method GET`, `gh pr view/checks`, `git ls-remote` | read-only Preflight; stabile ID und Head erforderlich | Fleet Snapshot / Mutable Token Record |
| Lokaler Zielcommit | `git commit` in isoliertem Worktree | aktuelles ExternalWriteGate; exakter Diff/Index/Tree | Repository PreMerge Evidence |
| Push und PR | `git push`, `gh pr create` | `MergeAndSync`, Ziel-/Planbindung, kein fremder Branch | Repository Lifecycle Evidence |
| Checks und Review | `gh pr checks`, `gh api --method GET` | read-only, exakter PR-Head | Provider-neutral gate/review evidence |
| Normaler Merge | `gh pr merge --<method>` | vollständige Acceptance/Security/Review/Gates | PreMerge + Provider Action ID |
| Admin-Bypass | `gh pr merge --admin --<method>` | nur aktueller ziel-/zeitgebundener Ausnahmebeleg nach normalem Versuch | Admin Bypass Evidence + Post-Write Verify |
| Ruleset create/update/restore | `gh api --method POST/PATCH/DELETE` mit Dateiinput und Argumentarray | `MergeAndSync`, numerische Repository-/Ruleset-ID, exakter Vorzustand; Restore nur vorgeplant | Ruleset Transaction Evidence |
| Default-Sync | `git fetch`, fast-forward lokaler Default Branch, Remote-GET | nach Merge, keine Force-Operation | PostMerge Evidence |
| Home Sync | `bash scripts/sync-home.sh --dry-run --no-pull`, danach autorisierter Lauf | nur nach Level-0-Merge, Konfliktprüfung und Authority-Revalidierung | Home-Sync Evidence |

### Validierungs-Checkpoint fuer nativen Windows-Nachweis / Validation Checkpoint for Native Windows Evidence

Wenn kein lokaler Windows-Host verfuegbar ist, darf T112 nach ausdruecklicher
aktueller `MergeAndSync`-Autoritaet genau einen vorgezogenen, nicht
mergefaehigen Validierungs-Checkpoint auf dem Feature-Branch verwenden. Der
Checkpoint enthaelt den bis T111 erreichten exakten Level-0-Stand und den
minimalen, nur durch einen Push auf `030-stage-b-rollout` ausloesbaren Workflow
`.github/workflows/stage-b-windows-proof.yml`. Vor dem Commit werden
Delivery-Set, Secret Scan, Index und aktueller Analyze-Nachweis geprueft. Der
Push oeffnet weder Pull Request noch Merge-/Providerwrite-Gate und startet
keinen Flottenrollout.

Der Workflow besitzt nur `contents: read`, reagiert ausschließlich auf den
Feature-Branch und die fuenf gebundenen Pfade und startet den Proof-Job nur bei
dem Commitmarker `[stage-b-windows-proof]`. Diese Push-Bindung ist erforderlich,
weil ein erstmalig nur auf dem Feature-Branch vorhandener `workflow_dispatch`-
Workflow kein verlaesslicher Ausloesepfad ist. Der Job laeuft auf
`windows-2022`, fuehrt
den PowerShell-7-Preflight mit `-WhatIf` aus und vergleicht den Payloadhash aus
den vier gebundenen Implementierungs-/Fixture-Dateien sowie den normalisierten
Entscheidungshash mit den bereits auf macOS und Linux belegten Werten. Nur ein
erfolgreicher Job am exakten Checkpoint-Commit darf als Windows-Token
importiert werden. Workflowname, Run-/Job-ID, Commit, Runnerlabel, ausgefuehrter
Befehl, Exitcode und beide Hashes werden im maschinenlokalen Windows-Record
gebunden. Fehlende oder abweichende Werte lassen T112 offen. Dieser eng
begrenzte Checkpoint aendert nicht die spaeteren Level-0-Review-, Acceptance-,
PreMerge-, Merge-, Default-Sync- oder Home-Sync-Gates.

## Projektstruktur / Project Structure

### Designartefakte dieses Features / Feature Design Artefacts

```text
specs/030-stage-b-rollout/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── autonomous-run-gate-requirements.json
└── contracts/
    ├── stage-b-run-state.schema.json
    ├── stage-b-rollout-plan.schema.json
    ├── repository-rollout-result.schema.json
    ├── fleet-terminal-evidence.schema.json
    ├── stage-b-ruleset-plan.schema.json
    └── workflow-ruleset-contract.md
```

### Geplante Implementierungsflächen / Planned Implementation Surfaces

```text
scripts/
├── maintain-agentic-workspace.sh
├── maintain-agentic-workspace.ps1
├── lib/agentic_workspace_fleet.py
├── config/
│   ├── stage-b-run-state.schema.json
│   ├── stage-b-rollout-plan.schema.json
│   ├── repository-rollout-result.schema.json
│   ├── fleet-terminal-evidence.schema.json
│   └── stage-b-ruleset-plan.schema.json
├── tests/
│   ├── test_stage_b_rollout.py
│   ├── run_stage_b_rollout_acceptance.py
│   └── stage-b-rollout/fixtures/
└── templates/ci-budget-governance/
    ├── private-governance-minimal-gate.yml
    └── private-governance-ruleset.json

docs/
├── man/maintain-agentic-workspace.1.md
├── scripts/
├── architecture/ci-budget-governance.md
├── accessibility/ci-budget-governance.md
├── security/
└── project-statistics.{config.json,md}
```

**Strukturentscheidung / Structure decision**: Kein neues Projekt und keine
neue Runtime. Der vorhandene Python-Kern bleibt alleiniger Eigentümer der
fachlichen Entscheidungen; Bash/PowerShell sind dünne, gleichwertige Adapter.
Designschemas werden in der Implementierung unverändert nach `scripts/config/`
abgeleitet und dort als Runtime-Verträge verwendet.

## Implementierungs- und Rolloutfolge / Implementation and Rollout Sequence

1. Vor Codeänderung Delivery Set, Run-State, Ready-Review, G3-PostMerge-
   Evidence, Preset-Matrix und alle sechs Designartefaktfamilien validieren;
   den kanonischen Evidence-Root mit getrennten `operational/`-/`primary/`-
   Namespaces und die Mutation-Allowlist anlegen.
2. Rote Vertrags-, Redaktions-, Drift-, Argumentlisten-, SSRF-/Pfad-,
   Retry-, State-Transition- und Schemafixtures erstellen.
3. Stage-B-Schemas installieren und Semantikvalidatoren implementieren.
4. Repräsentativen Canary-Slice `agent-operations-cockpit` zuerst rot
   ausführen: fehlende Stage-B-Engine muss exakt blockieren; keine Mutation.
5. Preflight, unveränderlichen Planner, veränderlichen State/Evidence Ledger,
   Provider-Read-Adapter und beide Wrapper bis zum grünen lokalen Slice
   implementieren.
6. ExternalWriteGate, Target Transaction, PR-/Review-/Gate-/Merge-/Sync-
   Lifecycle und No-op-Pfad implementieren; Mutation-Spies bleiben lokal.
7. Private-Minimal-Gate-/Ruleset-Transaktion, enges Restore und Bypass-
   Evidence implementieren.
8. Wave Coordinator, Budgetneuberechnung, Stop/Resume/Idempotenz, terminale
   Evidence und kausal gebundenen Closeout im Run-State implementieren.
9. Bash-/PowerShell-, macOS-/Linux-/Windows-, Security-, A11Y-, Docs-,
   Statistik- und vollständige Acceptance-Gates ausführen. Wenn kein lokaler
   Windows-Host verfuegbar ist, den oben definierten einmaligen
   Validierungs-Checkpoint nach frischem Analyze und exakter
   Delivery-Set-Pruefung mit dem Marker `[stage-b-windows-proof]` pushen, den
   dadurch am gebundenen Commit gestarteten `windows-2022`-Job auswerten und
   dessen unveraenderliche Run-/Job-Evidence
   importieren. Projektstatistik
   wird durch Änderung der Konfiguration und Renderer aktualisiert, nicht
   manuell im generierten Profilblock.
10. Level-0-Feature über eigenen PR regulär reviewen, Gates prüfen, mergen und
    Default Branch synchronisieren; bei selbstinvalidierenden Evidence-Fakten
    genau einen vorbenannten kausalen Closeout verwenden.
11. Manifestgebundene `scripts/` sind `homeRuntime`: Home-Sync erst nach
    Preview, Konfliktprüfung, Level-0-Merge und aktueller Authority. Reine
    Design-/Evidence-Pfade lösen keinen Sync aus.
12. Gesamten Preflight vom synchronisierten Level-0-Default-Head neu ausführen,
    fixierten Rolloutplan erzeugen und den Public-Canary-Slice autorisiert
    liefern. Erst grüne Slice-Evidence öffnet die restlichen Canaries.
13. Canaries und vier Profilwellen seriell liefern; nach jeder Welle
    Budgetprojektion und Wellengate schließen. Erster nicht behebbarer Fehler
    stoppt vor dem nächsten Ziel.
14. Terminale 100-%-Konvergenz, Redaktion und G4-Isolation prüfen. Handoff
    benennt nur das getrennte Sequencing-Follow-up; Intake-Serie und G4 bleiben
    unverändert.

## Repräsentativer vertikaler Slice / Representative Vertical Slice

Der Slice verwendet ausschließlich das Public-Canary-Fixture
`agent-operations-cockpit` mit festem Provider-Repository-ID-Fixture,
Baseline-Head, einem harmlosen Workflowdiff, Pflichtgate und Review. Der rote
Lauf beweist: unbekannter Stage-B-Vertrag blockiert vor Branch/Commit/PR und
der Mutation-Spy beobachtet null Writes. Der grüne Lauf beweist in einem
isolierten Fake-Provider: Preflight → exakter Diff → lokale Gates → Branch →
Commit → PR → Pflichtcheck → reguläre Review → Merge → Default-Sync →
PostMerge-Evidence; danach liefert ein Resume keinen zweiten PR.

Vor echter Fleet-Mutation werden dieselben Contract-Tests mit Live-Reads und
weiterhin ausgeschalteten Writes ausgeführt. Eine echte Canary-Lieferung
erfolgt erst nach Level-0-Merge und aktuellem ExternalWriteGate.

## Sicherheitsreview-Punkte / Security Review Checkpoints

1. **Vor Code**: Delivery Set, Datenklassen, Threat Model, Dependency-/SBOM-
   Entscheidung, sichere Prozessgrenzen und Evidence-Root reviewen.
2. **Vor erstem grünen Slice**: Shell-Metazeichen, führende Bindestriche, NUL,
   Zeilenumbrüche, Traversal, Symlink-Escape, SSRF-/Host-Allowlist, Output-
   Begrenzung und Secret-Redaction negativ testen.
3. **Vor Providerwrite-Code**: GET-/Write-Adaptertrennung, numerische IDs,
   mutable Heads, begrenzte Retries, idempotente Aktionsschlüssel und keine
   Retry-Schleife für Auth/403/404/Schema/Gate/Review prüfen.
4. **Vor Ruleset-Aktivierung**: Workflowpfade, exakt ein Status,
   Reviewpflicht, keine Bypass-Akteure, Default-Branch-ID, Vorzustand,
   Restore-Plan und Zugriffstest reviewen.
5. **Vor Merge**: vollständige Acceptance-, Security-, Review- und Gate-
   Evidence am exakten Kandidaten; Bypass-Evidence gegebenenfalls separat.
6. **Nach Merge**: kausale PostMerge-Bindung, Default-Sync, Ruleset- und
   Providerprüfung, Secret Scan und Redaktionsprüfung.
7. **Terminal**: Flottenmengengleichheit, Budget, C3A/C5, Zero Trust, SAMM,
   Supply Chain, A11Y, Plattformparität und G4-Nichtmutation reviewen.

## Test- und Abnahmestrategie / Test and Acceptance Strategy

`scripts/tests/run_stage_b_rollout_acceptance.py` wird der einzige Primary-
Einstieg je `AC-SBR-001` bis `AC-SBR-012`. Er führt den vollständigen Scope aus
oder validiert hashgebundene interne/native Nachweise. Jeder Primary-Befehl
enthält Gate-ID, explizite Repositorywurzel und den kanonischen
`stage-b/evidence/v1`-Root. Der Aggregator schreibt temporäre Primary-Snapshots
ausschließlich in dessen `primary/`-Namespace und referenziert die operative
Evidence in `operational/`.
`autonomous-run-gate-requirements.json` bindet die exakten Command- und
Runner-/Platform-Tokens. Positive und negative Fälle werden getrennt; ein
erwarteter Negativfall muss seinen exakten Blockercode und null unerlaubte
Writes belegen.

Vor `Completed` werden außerdem der strukturierte Phase-Result-Validator, der
Delivery-Set-Validator, PreMerge-/PostMerge-Gate-Evidence und die Run-State-
Validierung ausgeführt. Green-Aggregatnamen allein sind kein Nachweis;
Workflow, Job, Runner, Befehl, exakter Head und Ergebnis werden aus der
tatsächlichen Evidence abgeleitet.

## Dokumentationsauswirkung / Documentation Impact

**Decision / Entscheidung**: `UpdateRequired`.

- **Kanonische Quelle / Owner**: Level-0-Skripte, Registries und Verträge;
  Fleet Delivery Owner. Zielrepositorys besitzen ihre Runtime-/Buildwahrheit.
- **Zielgruppen / Leserpfad**: Fleet Delivery Owner, Maintainer,
  Repository Owner und Reviewer: README/Wartungsnavigation → sichere Preview →
  Quickstart → Manpage/PowerShell-Hilfe → Architektur/Security → Stage-B-
  Evidence → getrenntes G4-Sequencing-Follow-up.
- **Betroffene Dokumente**: README-/Skriptnavigation,
  `docs/man/maintain-agentic-workspace.1.md`, bilinguale PowerShell-Hilfe,
  `docs/scripts/`, Architektur-, Security-, A11Y-, Quickstart-, Abschluss- und
  Statistikdokumentation.
- **Navigation / Progressive Disclosure**: Einstieg zeigt Zweck,
  Voraussetzungen, Authority, Sicherheitsgrenze und genau eine Preview-Aktion;
  Detailverträge folgen verlinkt.
- **Dokumentklasse / Sprache**: versionierter Betriebs-/Security-Vertrag,
  DE zuerst/EN danach, ungefähr CEFR B2; große Partnerseiten nur synchronisiert.
- **Plattformnachweis**: Bash-Beispiel für macOS/Linux, PowerShell-Beispiel für
  Windows, gemeinsame normalisierte JSON-Evidence und lineare Textausgabe.
- **Distribution**: `scripts/` und Script-Hilfe sind `homeRuntime`; Specs,
  Designverträge und versionierte redigierte Evidence `sourceOnly`; Raw Logs,
  Tokens, lokale Pfade und Runnerprofile `machineLocal`/verboten.
- **Home Sync**: Für die Planphase `false`. Für die spätere Implementierung
  `true`, weil manifestgebundene `scripts/` geändert werden; nur nach Preview,
  Konfliktprüfung, Merge und Authority-Revalidierung.
- **Agent Guidance**: Update `N/A`, solange keine gemeinsame Semantik geändert
  wird. Trigger: Guidance-, Constitution-, Template-, Statistikmethodik- oder
  Routingrollenänderung; dann atomar alle fünf Agentenflächen.
- **Re-Evaluation**: Flotte, Profil, Authority, Bypass, Provider, Ruleset,
  Plattform, Evidence-Schema, Distribution, Zielgruppe oder G4-Grenze ändert
  sich.

## Verfassungsprüfung nach Design / Post-Design Constitution Check

- **Security und sichere Architektur**: Pass. Argumentlisten, Stable-ID-/Head-
  Bindung, Trust Boundaries, Redaction, Defense in Depth, Ruleset-Sicherheit,
  bounded retry, Stop/Resume und Security-Review-Punkte sind konkret.
- **iSAQB**: Pass. Kontext, Bausteine, Laufzeit, Deployment,
  Qualitätsattribute, Risiken, technische Schuld und ADR-Update sind geplant.
- **MSL**: Pass. Python/PowerShell sind MSL; Bash-Ausnahme ist eng begründet.
  Neue Runtime löst Re-Evaluation aus.
- **C3A/C5, Zero Trust, SAMM**: Pass und `Applicable`; Evidence-Pfade und
  Reviewer sind benannt.
- **Cross-Platform/A11Y/Bilingual**: Pass. Gepaarte Oberflächen, Manpage,
  Hilfe, genehmigtes Cmdlet, Preview-Parität, native/Fixture-Nachweise,
  text-first und CEFR B2 sind ein gemeinsames Gate.
- **Agent Parity**: Pass. Review anwendbar; Update derzeit begründet `N/A` mit
  atomarem Triggerumfang.
- **Autonomous authority**: Pass. Aktuelles `MergeAndSync` und der Bypass sind
  eng im veränderlichen Run-State abgebildet und kausal an den unveränderlichen
  Planhash gebunden; diese Planphase führt keinerlei Git-/Provider-/Home-/
  Serien- oder G4-Mutation aus.
- **Documentation/Statistics**: Pass. Genau eine `UpdateRequired`-Entscheidung,
  kanonische Quelle, Reader Paths, Distribution, Home Sync und Rendererpfad
  sind festgelegt.
- **Offene Punkte**: Keine ungelöste fachliche oder technische Entscheidung.

## Komplexitätsverfolgung / Complexity Tracking

Keine Verfassungsverletzung benötigt eine Ausnahme. Die zusätzliche
Komplexität liegt in getrennten Stage-B-Zustands- und Evidence-Verträgen sowie
der seriellen Providertransaktion. Sie ist erforderlich, weil Stage-A-Schemas
historisch unverändert bleiben und Remote-Teilkonvergenz resumierbar und
auditierbar sein muss. Eine neue Runtime, parallele Kampagne oder generische
Providerabstraktion wird bewusst nicht eingeführt.
