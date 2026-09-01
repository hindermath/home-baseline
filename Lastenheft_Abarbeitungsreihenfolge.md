# Lastenheft-Abarbeitungsreihenfolge fuer spaetere Spec-Kit-Laeufe

Dieses Dokument legt die sichtbare Reihenfolge fuer spaetere Spec-Kit-Laeufe im
`home-baseline`-Repository fest. Es startet keinen Spec-Kit-Lauf, erzeugt keinen
Feature-Branch und ersetzt keine fachliche Freigabe. Es dient als Intake- und
Orientierungsdokument fuer Menschen und KI-Agenten.

*This document defines the visible processing order for later Spec Kit runs in
the `home-baseline` repository. It does not start a Spec Kit run, create a
feature branch, or replace functional approval. It is an intake and orientation
document for humans and AI agents.*

## Regeln / Rules

- Nur Dateien nach dem Suchmuster `Lastenheft*.md` werden betrachtet.
- Diese Reihenfolgedatei selbst ist kein normaler Intake-Punkt.
- Lastenhefte mit Feature-Branch-Kennung im Dateinamen werden nicht erneut
  ausgefuehrt. Beispiele: `001-workspace-homogeneity-guardian`,
  `002-homogeneity-guardian-revision`, `003-git-config-scope`.
- Historische Lastenhefte bleiben als Kontext, Nachweis und Begruendung wichtig.
- Neue Lastenhefte ohne Feature-Branch-Kennung werden in die aktive Reihenfolge
  aufgenommen, sobald sie fachlich eingeordnet sind.

*Only files matching `Lastenheft*.md` are considered. This order file itself is
not a normal intake item. Lastenhefte with a feature-branch marker in the file
name are not executed again. Historical Lastenhefte remain useful as context,
evidence, and rationale. New Lastenhefte without a feature-branch marker are
added to the active order once they have been assessed.*

## Begriffe fuer den Einstieg / Terms for Getting Started

Diese Begriffe helfen Auszubildenden ab dem ersten Ausbildungsjahr,
Fachinformatikerinnen und Fachinformatikern sowie Kaufleuten fuer
IT-System-Management und Digitalisierungsmanagement:

- Ein **Lastenheft** oder **Intake** beschreibt das fachliche Problem, die
  Grenzen und die Abnahme. Es ist noch keine Implementierung.
- Die **sichtbare Position** ist die bevorzugte serielle Lieferreihenfolge. Sie
  verhindert unnoetige Konflikte an gemeinsam genutzten Dateien.
- Eine **Root** ist ein Intake ohne bindenden Vorgaenger innerhalb dieser
  aktiven Serie. Eine Root darf dennoch allgemeine Projekt-Gates besitzen.
- Ein **bindender Vorgaenger** muss fachlich abgeschlossen sein, bevor die
  abhaengige Arbeit beginnen darf.
- Ein **hartes Abschluss-Gate** blockiert bereits Feature-, Branch- oder
  Spec-Kit-Artefakte, solange der geforderte Abschlussnachweis fehlt.
- Eine **Assessment Baseline** liefert die Bewertungsgrundlage fuer eine
  spaetere Pruefung.
- Eine **Sandbox Baseline** liefert die Sicherheitsgrundlage fuer eine
  spaetere Sandbox-Anbindung.
- Eine **Surface Baseline** liefert Code- oder Dokumentationsflaechen, die ein
  spaeterer Lauf prueft.
- Ein **Final Audit** ist die letzte unabhaengige Kontrolle. Es wird nicht
  vorgezogen, weil sonst noch nicht gelieferte Aenderungen fehlen wuerden.

*A Lastenheft or intake defines the problem, boundaries, and acceptance, but
does not implement anything. The visible position is the preferred serial
delivery order. A root has no binding predecessor inside this active series.
Binding predecessors and hard completion gates must be satisfied before
dependent work starts. Assessment, sandbox, and surface baselines provide
review input. A final audit runs last so it can assess all intended changes.*

## Verbindlicher Dokumentationsvorlauf / Mandatory Documentation Preflight

Dieser Vorlauf wird einmal vollständig abgeschlossen, bevor die bestehende
nummerierte Reihenfolge fortgesetzt wird. Dadurch verwenden alle späteren
Änderungen bereits die geprüfte Documentation-Impact-Regel.

| Vorlauf | Lastenheft | Zweck / Purpose |
|---:|---|---|
| D1 (abgeschlossen / completed) | `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.011-documentation-reality-audit.md` | Feature 011 und PR #126 inventarisierten Level 0 und alle registrierten Level-1-/Level-2-Repositories read-only. Die 15 mittleren Findings sind D3 zugeordnet; ein zentraler Level-0-Remediation-Bedarf entstand nicht. / Feature 011 and PR #126 audited Level 0 and every registered Level 1 and Level 2 repository read-only. Its 15 medium findings are assigned to D3; no central Level 0 remediation need was found. |
| D2 (abgeschlossen / completed) | `Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Flotten-Governance.012-documentation-impact-governance.md` | Feature 012 und PR #128 bestaetigten null zentrale Level-0-Remediation-Findings, disponierten alle 15 D1-Findings nach D3 und verankerten den flottenweiten Documentation-Impact-Vertrag. / Feature 012 and PR #128 confirmed zero central Level 0 remediation findings, assigned all 15 D1 findings to D3, and established the fleet-wide Documentation Impact contract. |
| D3 (abgeschlossen / completed) | `Lastenheft_Registrierte-Level-1-2-Dokumentations-Wirklichkeitsabgleich-Flotte.013-documentation-reality-remediation-fleet.md` | Feature 013 und PR #131 lieferten die Documentation-Impact-Baseline über 32 nicht leere Repository-PRs aus, schlossen `DOC001` bis `DOC015` und revalidierten Level 0. / Feature 013 and PR #131 delivered the Documentation Impact baseline through 32 non-empty repository PRs, closed `DOC001` through `DOC015`, and revalidated Level 0. |

*The mandatory D1–D3 preflight completes before the numbered order resumes, so
all later work uses the validated documentation-impact baseline.*

## Abgeschlossenes Requirements-Gate / Completed Requirements Gate

Feature 014 war der verbindliche, einmalige Vorlauf vor allen sechs bisherigen
Roots. Es machte Dateinamen nicht zu einer technischen Voraussetzung, sondern
führte sprachneutrale Artefaktrollen, kontrollierte Namensprofile und einen
atomaren Migrationsvertrag für die drei vorhandenen Intake-Presets ein.

| Gate | Lastenheft | Zustand und Wirkung / State and Effect |
|---:|---|---|
| G1 (abgeschlossen / completed) | `Lastenheft_Requirements-Intake-Konsolidierungs-Governance.014-requirements-intake-consolidation-governance.md` | Feature 014 und PR #136 lieferten die drei koordinierten Preset-Releases, sieben Feldmigrationen und die flottenweite Schema-2-Aktualisierung. Die früheren Roots 1, 2, 3, 5, 9 und 10 sind wieder freigegeben. / Feature 014 and PR #136 delivered the three coordinated preset releases, seven field migrations, and the fleet-wide schema-2 update. The previous roots 1, 2, 3, 5, 9, and 10 are available again. |

Das Gate veränderte die fachliche Reihenfolge der vorhandenen Intakes nicht.
G1 ist archiviert und aus der aktiven Series entfernt. Die sechs früheren
Roots wurden durch G1 wieder freigegeben. Mit der später ergänzten
Dokumentationskette D4 bis D7 besitzt die bisherige Position 5 nun erneut einen
bindenden Vorgänger. Position 1 wurde als Feature 015 über PR #142 und
Position 2 als Feature 016 über PR #146 und Position 3 als Feature 017 über
PR #153 abgeschlossen und archiviert. Position 4 wurde als Feature 018 über
PR #160 abgeschlossen und als
`Lastenheft_Agentic-Workspace-Maintenance-TUI.018-agentic-workspace-tui.md`
archiviert. R-TUI wurde als Feature 019 über PR #192 abgeschlossen und als
`Lastenheft_Agentic-Workspace-Wartungs-TUI-und-Wrapper-Regressionshaertung.019-agentic-workspace-regression-hardening.md`
archiviert. D4 wurde als Feature 020 über PR #194 abgeschlossen und als
`Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.020-documentation-architecture-audit.md`
archiviert. Der Audit lieferte genau `DIA001` an D5 und keine D6-/D7-Findings.
D5 wurde als Feature 021 über PR #197 umgesetzt und als
`Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.021-level0-documentation-architecture.md`
archiviert. Der Lauf schloss `DIA001`, lieferte das Root-Portal und vier
Leserpfade und erzeugte keinen neuen D6-/D7-Remediation-Befund. D6 wurde als
Feature 022 über PR #199 umgesetzt und als
`Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.022-agentic-workspace-efficiency-guide.md`
archiviert. Der Lauf lieferte einen bilingualen Leitfaden, vier Leserpfade und
17 hashgebundene Claims ohne Runtime-Änderung. D7 wurde als Feature 023 über
PR #201 umgesetzt und als
`Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.023-registered-doc-architecture-adoption.md`
archiviert. Der Lauf lieferte 32 finale Repository-Adoptionen über 33 nicht
leere PRs; ein nutzereigener schmutziger Worktree blieb bewusst unverändert.
Position 5 wurde als Feature 024 ueber PR #208 abgeschlossen und als
`Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md`
archiviert. Der Lauf haertete die vorhandene Abbildung von zwoelf Checklisten,
157 Pruefpunkten, 15 mitgeltenden Dokumenten und dem Acht-plus-drei-Presetprofil.
Position 6 wurde als Feature 025 ueber PR #214 abgeschlossen und als
`Lastenheft_RL-SE-Checklist-Selbstpruefung.025-rl-se-self-assessment.md`
archiviert. Der Lauf lieferte je Sprachhaelfte 159 eindeutige Entscheidungen
und 21 Evidence-Eintraege. Die 149 konkreten Remediation-Kandidaten wurden
nicht umgesetzt; sie benoetigen gepruefte, nicht leere Folge-Intakes und neue
Ausfuehrungsautoritaet. Position 7 war nach diesem Closeout der einzige
deklarierte `Eligible`-Kandidat. Das spaeter eingefuegte G2-Gate wurde mit
Feature 028 und PR #243 abgeschlossen und archiviert; damit gilt diese Auswahl
wieder. Der Closeout startet weder Position 7 noch eine Remediation.

*The gate did not reorder the existing domain work. G1 is archived and removed
from the active series. It released the six previous roots; the later D4-D7
documentation chain now provides a new binding predecessor for former item 5.
Item 1 completed as Feature 015 through PR #142, item 2 as Feature 016 through
PR #146, and item 3 as Feature 017 through PR #153; all three are archived.
Item 4 completed as Feature 018 through PR #160 and is archived. R-TUI
completed as Feature 019 through PR #192 and is archived. D4 completed as
Feature 020 through PR #194 and is archived. It handed exactly `DIA001` to D5
and no findings to D6 or D7. D5 completed as Feature 021 through PR #197,
closed `DIA001`, and is archived. D6 completed as Feature 022 through PR #199
and is archived. It delivered a bilingual guide, four reader paths, and 17
hash-bound claims without runtime changes. D7 completed as Feature 023 through
PR #201 and is archived. It delivered 32 final repository adoptions through 33
non-empty pull requests while leaving one user-owned dirty worktree unchanged.
Item 5 completed as Feature 024 through PR #208 and is archived. It hardened
the existing mapping of twelve checklists, 157 review points, 15 related
   documents, and the eight-plus-three preset profile. Item 6 completed as
   Feature 025 through PR #214 and is archived. It delivered 159 unique
   decisions and 21 evidence records per language half. Its 149 concrete
   remediation candidates require reviewed, non-empty follow-up intakes and
   new execution authority. Item 7 became the sole declared `Eligible`
   candidate after that closeout. Feature 028 and PR #243 completed and
   archived the later G2 gate, so this selection applied again until the
   current G3/G4 cost-governance insertion. The closeout started neither item
   7 nor remediation.*

## Abgeschlossenes Evidence-Integrity-Gate / Completed Evidence Integrity Gate

Die providerneutralen Findings aus TuiVision Feature 038 werden vor weiteren
autonomen Fachlaeufen in zwei getrennten Schritten gehaertet. G2A erstellt und
prueft einen unveroeffentlichten Preset-Kandidaten. G2B validiert ihn in einem
unabhaengigen Home-Baseline-Feldlauf und darf Release und Flottenauslieferung
nur nach vollstaendig gruener Evidence ausloesen.

| Gate | Lastenheft | Zustand und Wirkung / State and Effect |
|---:|---|---|
| G2A (`Completed`, archiviert / archived) | `Lastenheft_Autonomous-Evidence-Integrity-Hardening.027-autonomous-evidence-integrity-hardening.md` | Feature 027 und PR #241 haerteten Liefermenge, semantische Phasenvervollstaendigung und Pre-/Post-Merge-Evidence als unveroeffentlichten Kandidaten. / Feature 027 and PR #241 hardened delivery sets, semantic phase completion, and pre/post-merge evidence as an unreleased candidate. |
| G2B (`Completed`, archiviert / archived) | `Lastenheft_Autonomous-Evidence-Integrity-Field-Validation-and-Rollout.028-autonomous-evidence-integrity-field-validation.md` | Feature 028 und PR #243 validierten drei unabhaengige Feldfaelle, veroeffentlichten v0.4.1 und rollten es kontrolliert an 36 Consumer aus. / Feature 028 and PR #243 validated three independent field cases, published v0.4.1, and rolled it out to 36 consumers under controlled conditions. |

Beide Gate-Knoten sind aus der aktiven Serie entfernt. Damit war der zuvor
belegte Vertrag mit 32 Zielen, drei Roots und 36 Abhaengigkeiten wiederhergestellt;
Position 7 war der einzige bevorzugte `Eligible`-Kandidat. Dieser Zustand ist
als Supersession-Vorstand archiviert und wird nun durch G3 und G4 erweitert.

*Both gate nodes have been removed from the active series. This restored the
previously evidenced contract with 32 targets, three roots, and 36 dependencies;
item 7 was the sole preferred `Eligible` candidate. That state is archived as
the superseded predecessor and is now extended by G3 and G4.*

## Aktive Kosten-Gates / Active Cost Gates

G3 reduzierte private GitHub-Actions-Minuten durch registrybasierte CI-Profile,
lokale Pflicht-Gates und HEAD-gebundene Evidence. Feature 029, PR #247 und der
anschliessende Stage-B-Flottenrollout mit den PRs #258 und #259 sind
abgeschlossen. G4 ist fachlich freigegeben, wird durch die ausdrueckliche
Umbuchung von Position 39 jedoch als `Pending` hinter den neuen bevorzugten
Kandidaten gestellt. G4 reduziert spaeter automatische GitHub-Copilot-Reviews
auf acht benannte Public-Repositories und genau ein Lite-Review pro
qualifizierendem Pull Request.

*G3 reduced private GitHub Actions minutes through registry-based CI profiles,
mandatory local gates, and HEAD-bound evidence. Feature 029, PR #247, and the
subsequent Stage B fleet rollout through PRs #258 and #259 are complete. G4 is
functionally unblocked, but the explicit promotion of item 39 places it back
into `Pending` behind the new preferred candidate. G4 later limits automatic
GitHub Copilot review to eight named public repositories and one Lite review
per qualifying pull request.*

```text
G3 Actions-Budget und Stage B [abgeschlossen / completed]
39 Verlinkte Abarbeitungsreihenfolgen [Eligible, vorgezogen / promoted]
  - - [PreferredSerialOrder, nicht bindend / advisory] - ->
G4 Copilot-Review-Governance [Pending]
  -- [CopilotReviewGovernanceBaseline, bindend / binding] -->
7 Container-Haertung [Blocked]
```

Der `Eligible`-Status von Position 39 erteilt keine Start-, GitHub-Schreib-,
Commit-, Push-, Merge- oder Bypass-Autoritaet.

*Item 39's `Eligible` lifecycle state grants no start, GitHub-write, commit,
push, merge, or bypass authority.*

## Aktive Reihenfolge / Active Order

Der aktuelle maschinenpruefbare Vertrag umfasst 34 Ziele, drei Roots und
38 bindende oder beratende Abhaengigkeiten. Genau ein Ziel ist im
Manifest als bevorzugtes `Eligible` deklariert.

*The current machine-verifiable contract contains 34 targets, three roots, and
38 binding or advisory dependencies. Exactly one target is
declared as the preferred `Eligible` candidate in the manifest.*

Die stabilen sichtbaren Kennungen bleiben erhalten. Position 39 wird als
`vorgezogen / promoted` zuerst ausgefuehrt und steht deshalb auf aktivem
Manifestplatz 1; die nachfolgenden Nummern werden nicht umbenannt.

*Stable visible identifiers remain unchanged. Item 39 is promoted for the next
execution and therefore occupies active manifest position 1; later visible
identifiers are not renamed.*

| Reihenfolge / Order | Lastenheft | Zweck / Purpose |
|---:|---|---|
| D5 (abgeschlossen / completed) | `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.021-level0-documentation-architecture.md` | Feature 021 und PR #197 schlossen `DIA001`, ersetzten die monolithische Root-README durch DE-/EN-Portale und verankerten vier Leserpfade sowie einen streng validierten Documentation-Impact-Vertrag. / Feature 021 and PR #197 closed `DIA001`, replaced the monolithic root README with DE/EN portals, and established four reader paths plus a strictly validated Documentation Impact contract. |
| D6 (abgeschlossen / completed) | `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.022-agentic-workspace-efficiency-guide.md` | Feature 022 und PR #199 lieferten den bilingualen Betriebsleitfaden, vier Leserpfade und 17 hashgebundene Claims ohne Runtime-, Preset-, Registry- oder Flottenänderung. / Feature 022 and PR #199 delivered the bilingual operating guide, four reader paths, and 17 hash-bound claims without runtime, preset, registry, or fleet changes. |
| D7 (abgeschlossen / completed) | `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.023-registered-doc-architecture-adoption.md` | Feature 023 und PR #201 übernahmen portable Dokumentationsregeln in 32 finale Ziel-Repositories. Die 45-Ziel-Matrix hielt einen nutzereigenen schmutzigen Worktree und zwölf nicht anwendbare Ziele getrennt; unveränderte Ziele erhielten keinen Leer-PR. / Feature 023 and PR #201 adopted portable documentation rules into 32 final target repositories. The 45-target matrix kept one user-owned dirty worktree and twelve inapplicable targets separate; unchanged targets received no empty pull request. |
| 5 (abgeschlossen / completed) | `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md` | Feature 024 und PR #208 haerteten die bestehende Mapping-Oberflaeche mit deterministischem Proof fuer zwoelf Checklisten, 157 Punkte, 15 Dokumente und das Acht-plus-drei-Profil. / Feature 024 and PR #208 hardened the existing mapping surface with deterministic proof for twelve checklists, 157 points, 15 documents, and the eight-plus-three profile. |
| 6 (abgeschlossen / completed) | `Lastenheft_RL-SE-Checklist-Selbstpruefung.025-rl-se-self-assessment.md` | Feature 025 und PR #214 lieferten je Sprachhaelfte 159 eindeutige Entscheidungen und 21 Evidence-Eintraege. Die 149 Remediation-Kandidaten bleiben getrennte Folgearbeit. / Feature 025 and PR #214 delivered 159 unique decisions and 21 evidence records per language half. The 149 remediation candidates remain separate follow-up work. |
| G3 (abgeschlossen / completed) | `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.029-ci-budget-governance.md` und `Lastenheft_Flottenweite-CI-Budget-Governance-Stage-B-Rollout.030-stage-b-rollout.md` | Feature 029, PR #247 sowie der Stage-B-Flottenrollout über PRs #258 und #259 lieferten die Actions-Budget-Baseline und konvergierten 48 von 48 Repositories. / Feature 029, PR #247, and the Stage B fleet rollout through PRs #258 and #259 delivered the Actions budget baseline and converged all 48 repositories. |
| 39 (`Eligible`, vorgezogen / promoted) | `Lastenheft_Verlinkte-Abarbeitungsreihenfolgen-und-Spec-Kit-Feature-Nachweise.md` | Harmonisiert als naechster bevorzugter Intake verlinkte Intake-Dateien, typisierte Abhaengigkeiten und abgeschlossene Spec-Kit-Feature-Nachweise in sieben Herzensprojekt-Repositories. Der Status erteilt keine Implementierungs- oder Delivery-Autoritaet. / As the next preferred intake, harmonizes linked intake files, typed dependencies, and completed Spec Kit feature evidence across seven passion-project repositories. The status grants no implementation or delivery authority. |
| G4 (`Pending`, beratend nach Position 39 / advisory after item 39) | `Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.031-github-copilot-review-governance.md` | Reduziert nach abgeschlossenem G3 und Stage B automatische Copilot-Reviews auf acht Repositories und ein Lite-Review ohne Draft-/Push-Wiederholung. / After completed G3 and Stage B, limits automatic Copilot review to eight repositories and one Lite review without draft/push repetition. |
| 7 (`Blocked`) | `Lastenheft_Secure-Development-Container-Hardening.md` | Leitet Anforderungen fuer einen sicheren Entwicklungscontainer ab und wartet bindend auf G4. / Derives requirements for a secure development container and is binding-blocked by G4. |
| 8 | `Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md` | Bereitet MSL-basierte Level-2-Repositories auf spaetere Sandbox-gestuetzte Secure-Development-Haertung vor, ohne diese Haertung zu starten. / Prepares MSL-based level-2 repositories for later sandbox-supported secure-development hardening without starting that hardening. |
| 9 | `Lastenheft_CICD_Pipeline_Konfiguration.md` | Prüft und härtet die CI/CD-Basis nach der dokumentierten Governance-Logik. / Reviews and hardens the CI/CD baseline according to the documented governance logic. |
| 10 | `Lastenheft_PowerShell_Cmdlets.md` | Prüft PowerShell-Cmdlet-Konventionen und Windows-Parität und liefert damit eine Oberfläche für die nachfolgende Dokumentation. / Reviews PowerShell cmdlet conventions and Windows parity and provides a surface for the following documentation work. |
| 11 | `Lastenheft_Script_Dokumentation.md` | Führt Skript- und Bedienungsdokumentation zusammen, nachdem die Cmdlet-Oberflächen feststehen. / Aligns script and usage documentation after the cmdlet surfaces are known. |
| 12 | `Lastenheft_Didactic-Script-and-Config-Comment-Hardening.md` | Prüft didaktische Kommentare in Skript- und Konfigurationslogik inklusive JSONC-Migrationskandidaten. / Reviews didactic comments in script and configuration logic, including JSONC migration candidates. |
| 13 | `Lastenheft_Script-and-Config-GSDB-Pruefung.md` | Prüft Skript-, JSON/JSONC-, YAML- und Workflow-Flächen fokussiert gegen die GSDB. / Reviews script, JSON/JSONC, YAML, and workflow surfaces against the GSDB. |
| 14 | `Lastenheft_Secure-Development-RL-CL-Preset-Gap-Audit.md` | Prüft Richtlinie, zwölf Checklisten, Sammelband, Manifest, mitgeltende Dokumente, Presets und ABSDD read-only auf belegte Assurance-Lücken. / Audits the guideline, twelve checklists, compendium, manifest, related documents, presets, and ABSDD for evidenced assurance gaps without changing them. |
| 15 | `Lastenheft_Preset-Secure-Development-Assurance-Governance.md` | Produktisiert ausschließlich bestätigte Audit-Findings als optionales Assurance-Preset auf Priorität 15. / Productizes only confirmed audit findings as an optional assurance preset at priority 15. |
| 16 | `Lastenheft_Secure-Development-Baseline-3.3-Synchronisierung.md` | Synchronisiert die projektgeführte Dokumentfamilie evidenzbasiert auf Baseline 3.3.0 und ergänzt das Zwölferprofil. / Synchronizes the project-owned document family to baseline 3.3.0 based on evidence and adds the twelve-preset profile. |
| 17 | `Lastenheft_ABSDD-Secure-Development-Assurance-Adoption.md` | Adoptiert Baseline und Assurance-Preset kontrolliert in `absdd-image-sandbox` und liefert den ersten Feldnachweis. / Adopts the baseline and assurance preset into `absdd-image-sandbox` under controlled conditions and produces the first field validation. |
| 18 | `Lastenheft_KDM-KITSM-Lernreihen-Gap-Audit.md` | Prüft die bisherige Integration der beiden kaufmännischen IT-Berufe read-only gegen Rahmenlehrplan, Ausbildungsordnungen, BIBB-Quellen, Lernmaterialien und C#-/SQL-Nachweise. / Audits the current integration of both commercial IT occupations against official sources, learning materials, and C#/SQL evidence without remediation. |
| 19 | `Lastenheft_KDM-KITSM-Lernarchitektur-und-Kompetenzmodell.md` | Definiert Jahr-1-Retrofit, gemeinsamen Jahr-2-Kern, getrennte Jahr-3-Reihen, C# als Referenzsprache und den vollständigen Dokument- und Evidence-Vertrag. / Defines the year-1 retrofit, shared year-2 core, separate year-3 series, C# reference language, and complete document/evidence contract. |
| 20 | `Lastenheft_KDM-KITSM-Jahr1-Retrofit.md` | Ergänzt vollständige KDM-/KITSM-Pfade in den vorhandenen Secure-Trader-Grundreihen für LF1 bis LF5, ohne FI-Inhalte oder Produktcode zu ersetzen. / Adds complete KDM/KITSM paths to the existing LF1-LF5 Secure Trader base series without replacing FI content or product code. |
| 21 | `Lastenheft_KDM-KITSM-Kaufmaennischer-Kern-Jahr2.md` | Erstellt den gemeinsamen achtteiligen Jahr-2-Kern für Service, C#-/SQL-Projekt, Tests, Beschaffung, Netzwerk, Einführung und Abnahme. / Creates the shared eight-unit year-2 core for service, a C#/SQL project, tests, procurement, networking, introduction, and acceptance. |
| 22 | `Lastenheft_KITSM-Professional-Jahr3.md` | Erstellt die achtteilige KITSM-Reihe für Kundenauftrag, IT-Lösung, Kosten, Beschaffung, Vertrag, Marketing, Netzwerk und Service. / Creates the eight-unit KITSM series for customer orders, IT solutions, costing, procurement, contracts, marketing, networking, and service. |
| 23 | `Lastenheft_KDM-Professional-Jahr3.md` | Erstellt die achtteilige KDM-Reihe für Prozesse, Daten, C#-/SQL-Integration, Kennzahlen, Wirtschaftlichkeit, Geschäftsmodelle und Veränderung. / Creates the eight-unit KDM series for processes, data, C#/SQL integration, metrics, economics, business models, and change. |
| 24 | `Lastenheft_KDM-KITSM-CSharp-Lernreihen-Rollout.md` | Verteilt die gemergten Lernmaterialien kontrolliert in drei Level-1- und drei C#-Referenzrepositories; andere MSL-Pfade und Produktcode bleiben unverändert. / Rolls out the merged materials to three Level-1 and three C# reference repositories while leaving other MSL paths and product code unchanged. |
| 25 | `Lastenheft_KDM-KITSM-Lernreihen-Closure.md` | Revalidiert Lernfelder, 24 Einheiten, Dokumentpakete, C#-/SQL-Proofs und sechs Rolloutziele unabhängig und ohne Remediation. / Independently revalidates learning fields, 24 units, document packages, C#/SQL proof, and six rollout targets without remediation. |
| 26 | `Lastenheft_ITSE-Lernreihen-Gap-Audit.md` | Prüft die vorhandene ITSE-Abdeckung read-only gegen amtliche Quellen und alle vier FI-Fachrichtungen; KITSM und KDM liefern eine ergänzende Vergleichsperspektive. / Audits current ITSE coverage against official sources and all four IT-specialist tracks; KITSM and KDM provide a secondary comparison. |
| 27 | `Lastenheft_ITSE-Lernarchitektur-und-Kompetenzmodell.md` | Definiert die eigenständige ITSE-Progression, Wiederverwendung aus FI-Reihen, C#-Referenzgrenzen sowie sichere Praxis-, Simulations- und Agentenkontexte. / Defines the dedicated ITSE progression, FI-series reuse, C# reference boundaries, and safe practical, simulation, and agent contexts. |
| 28 | `Lastenheft_ITSE-Jahr1-Retrofit.md` | Ergänzt ITSE-Pfade für LF1 bis LF5 in vorhandenen Grundreihen, ohne gemeinsame FI-Inhalte zu duplizieren. / Adds ITSE paths for LF1 through LF5 to existing base series without duplicating shared FI content. |
| 29 | `Lastenheft_ITSE-Technischer-Kern-Jahr2.md` | Erstellt den technischen ITSE-Kern für LF6 bis LF9 mit SI-/DV-Schwerpunkt und sichtbaren AE-/DPA-Beiträgen. / Creates the technical ITSE core for LF6 through LF9 with an SI/DV emphasis and visible AE/DPA contributions. |
| 30 | `Lastenheft_ITSE-Professional-Jahr3.md` | Erstellt eine achtteilige ITSE-Professional-Reihe für Energieversorgung, vernetzte Systeme, Betriebssicherheit und Instandhaltung. / Creates an eight-unit ITSE professional series for power supply, networked systems, operational safety, and maintenance. |
| 31 | `Lastenheft_ITSE-CSharp-Lernreihen-Rollout.md` | Verteilt freigegebene ITSE-Materialien kontrolliert in drei Level-1- und drei C#-Level-2-Repositories; ServiceHarvester ist der vollständige Referenzkontext. / Rolls accepted ITSE material out to three Level-1 and three C# Level-2 repositories; ServiceHarvester is the complete reference context. |
| 32 | `Lastenheft_ITSE-Lernreihen-Closure.md` | Revalidiert die ITSE-Reihe, LF1 bis LF12, Prüfungsbezug, Evidence, Sicherheitsgrenzen und sechs Rolloutziele unabhängig und read-only. / Independently revalidates the ITSE series, LF1 through LF12, examination relation, evidence, safety boundaries, and six rollout targets without remediation. |
| 33 | `Lastenheft_Lernreihen-Konsistenz-und-KI-Kompetenz-Gap-Audit.md` | Prüft read-only, ob die vorhandenen Lernreihen auf drei Ebenen konsistent sind und ob acht berufsübergreifende KI-Kompetenzen nachvollziehbar abgedeckt werden. / Audits without remediation whether the existing learning series are consistent on three levels and traceably cover eight cross-occupational AI competencies. |
| 34 | `Lastenheft_Preset-Intake-Review-Drei-Ebenen-Konsistenz.md` | Erweitert das allgemeine Intake Review um die universellen Prüfdimensionen „in sich“, „an sich“ und „insgesamt“, ohne lernreihenspezifische Fachlogik vorwegzunehmen. / Extends general Intake Review with the universal dimensions internal, normative, and ecosystem consistency without pre-empting learning-series-specific domain logic. |
| 35 | `Lastenheft_Preset-Learning-Series-Governance.md` | Produktisiert nur bestätigte Audit-Findings als optionales `learning-series-governance`-Preset für Lernreihen, Ausbildungsprofile, Lernbegleiter und KI-Handlungskompetenz. / Productizes only confirmed audit findings as an optional `learning-series-governance` preset for learning series, training profiles, learner guidance, and applied AI competence. |
| 36 | `Lastenheft_Learning-Series-Governance-IHK-Pilot.md` | Validiert das neue Preset an sieben bestehenden IT-Ausbildungsprofilen und zwei begrenzten synthetischen Nicht-IT-Profilen, ohne Lernmaterial automatisch zu verändern. / Validates the new preset against seven existing IT training profiles and two bounded synthetic non-IT profiles without automatically changing learning content. |
| 37 | `Lastenheft_Lernreihen-Gesamtkonsistenz-Closure.md` | Prüft abschließend jede Reihe in sich, gegen ihre normativen Quellen und alle Reihen gemeinsam auf konsistente Lernziele, Evidence, KI-Kompetenz und Sicherheitsgrenzen. / Finally checks every series internally, against its normative sources, and across all series for consistent learning goals, evidence, AI competence, and safety boundaries. |
| 38 (`Pending`, beratend / advisory) | `Lastenheft_Level-0-Checkout-und-Public-Template-Erstellung.md` | Bereitet die getrennte, bilinguale Dokumentation des bestehenden Level-0-Checkouts und der Erstellung eines eigenen Repositorys aus dem GitHub Public Template vor. Die Position bleibt nicht dringend und erhält keine Startautorität. / Prepares separate bilingual guidance for checking out the existing Level 0 source and creating a separate repository from the GitHub public template. The item remains non-urgent and grants no start authority. |

Der deklarierte Status `Eligible` markiert genau einen bevorzugten Kandidaten;
der Validator weist daneben alle Ziele ohne unvollständige bindende Vorgänger
rechnerisch aus. Die
Source-/Home-Runtime-Verfeinerung hat die früheren Einzelreviews D4 bis D7 und
frühere Series-Reviews hashbedingt archiviert. Der aktuelle
Schema-1.1-Series-Review belegt den archivierten Vorstand mit 32 Zielen, drei
Roots und 36 Abhängigkeiten. Das aktuelle Manifest umfasst nach dem
G3-/Stage-B-Abschluss 34 Ziele, drei Roots und 38 Abhängigkeiten und deklariert
Position 39 als einzigen bevorzugten `Eligible`-Kandidaten. Vor einem später ausdrücklich autorisierten
Lauf werden zuerst `$speckit-intake-series-status` und der zum ausgewählten
Ziel gehörende `$speckit-intake-review` ausgeführt.

*The declared `Eligible` lifecycle marks exactly one preferred candidate; the
validator separately reports every target without incomplete binding
predecessors as computationally eligible. The schema-1.1 Series review covers
the archived predecessor with 32 targets, three roots, and 36 dependencies.
The current manifest contains 34 targets, three roots, and 38 dependencies
after G3 and Stage B completion and declares item 39 as the sole preferred Eligible
candidate. Before any later
explicitly authorized run, execute `$speckit-intake-series-status` and the
Intake Review for the selected target.*

## Verbindliche Abhaengigkeiten / Binding Dependencies

Die folgende Textmatrix ist der maschinenpruefbaren Series-Evidence
gleichgestellt. Ein Pfeil bedeutet: Der linke Intake liefert eine bindende
Grundlage fuer den rechten Intake.

```text
D1 Level-0/1/2-Doku-Audit [abgeschlossen / completed]
  |
  +--> D2 Level-0-Remediation und Flotten-Governance
         |
         +--> D3 Level-1/2-Flotte und Level-0-Revalidierung

D4 Informationsarchitektur-Audit [abgeschlossen / completed]
D5 Level-0-Architektur und Sprache [abgeschlossen / completed]

              D6 Workspace-Effizienzleitfaden [abgeschlossen / completed]

              D7 Level-1/2-Flottenadoption [abgeschlossen / completed]
                             |
                             v
              5 Mitgeltende Dokumente [abgeschlossen / completed]

6 RL-SE-Selbstpruefung [abgeschlossen / completed]
G3 Actions-Budget und Stage B [abgeschlossen / completed]
G4 Copilot-Review [Eligible]
  |
  v
7 Container-Haertung [Blocked] --> 8 Level-2-Sandbox
9 CI/CD [Root]
10 PowerShell-Cmdlets [Root]

10 PowerShell-Cmdlets --> 11 Skript-Dokumentation
9 CI/CD -----------\
10 Cmdlets ----------+--> 12 Didaktische Kommentare
11 Dokumentation ---/
9 CI/CD ------------\
10 Cmdlets -----------+--> 13 Abschliessendes GSDB-Audit
11 Dokumentation -----+
12 Kommentare -------/

13 GSDB-Audit --> 14 Assurance-Gap-Audit
14 Gap-Audit ------------------> 15 Assurance-Preset
15 Assurance-Preset --\
14 Gap-Audit ----------+-------> 16 Baseline 3.3
15 Assurance-Preset --\
16 Baseline 3.3 --------+------> 17 ABSDD-Adoption

17 ABSDD-Adoption
  |
  v
18 KDM/KITSM Gap-Audit
  |
  v
19 Lernarchitektur und Kompetenzmodell
  |
  v
20 Jahr-1-Retrofit
  |
  v
21 Gemeinsamer kaufmaennischer Kern Jahr 2
  |
  v
22 KITSM Professional Jahr 3
  |
  v
23 KDM Professional Jahr 3
  |
  v
24 C#-Lernreihen-Rollout
  |
  v
25 KDM/KITSM Closure
  |
  v
26 ITSE Gap-Audit
  |
  v
27 ITSE Lernarchitektur
  |
  v
28 ITSE Jahr 1
  |
  v
29 ITSE Technischer Kern Jahr 2
  |
  v
30 ITSE Professional Jahr 3
  |
  v
31 ITSE C#-Lernreihen-Rollout
  |
  v
32 ITSE Closure
  |
  v
33 Lernreihen-/KI-Kompetenz-Gap-Audit
  |
  v
34 Intake-Review-Drei-Ebenen-Konsistenz
  |
  v
35 Learning-Series-Governance-Preset
  |
  v
36 IHK-Pilot
  |
  v
37 Lernreihen-Gesamtkonsistenz-Closure

```

### Beratende Reihenfolge / Advisory Order

Die folgenden Kanten bewahren die sichtbare Reihenfolge, sind aber keine
fachlichen oder technischen Startbedingungen:

*The following edges preserve visible order but are not functional or
technical start prerequisites:*

```text
37 Lernreihen-Gesamtkonsistenz-Closure
  - - [PreferredSerialOrder, nicht bindend / advisory] - ->
38 Level-0-Checkout und Public-Template-Erstellung [Pending]

39 Verlinkte Abarbeitungsreihenfolgen und Feature-Nachweise
   [Eligible, vorgezogen / promoted]
  - - [PreferredSerialOrder, nicht bindend / advisory] - ->
G4 Copilot-Review-Governance [Pending]
```

Die Positionen 38 und 39 besitzen deshalb keinen unvollständigen bindenden
Vorgänger und können vom Validator rechnerisch als unblocked erscheinen.
Position 39 ist ausdrücklich als einziger bevorzugter `Eligible`-Kandidat
deklariert. Dieser Status und die sichtbare Position erteilen keine Start- oder
Delivery-Autorität; Position 38 und G4 bleiben `Pending`.

*Items 38 and 39 have no incomplete binding predecessor and may therefore
appear as computationally unblocked. Item 39 is the sole declared preferred
Eligible candidate. This status and visible order grant no start or delivery
authority; item 38 and G4 remain Pending.*

Nach dem Abschluss von Feature 025 waren die aktiven Roots `7`, `9` und `10`.
Feature 028 und PR #243 schlossen das spaeter eingefuegte G2-Gate mit
nachgewiesenem Release und Rollout ab und stellten diese drei Roots wieder her.
Der abgeschlossene G3-/Stage-B-Strang gab G4 zunaechst als Root frei. Durch die
Umbuchung ersetzt Position 39 G4 als `Primary`-Root; die Roots 9 und 10 bleiben
`Pending`. G4 ist beratend nach Position 39 eingeordnet, und Position 7 ist
weiterhin bindend durch G4 blockiert.
Die Positionen 5 und 6 sind archiviert; ihre Bewertungsgrundlagen bleiben als
historische Evidence erhalten. G1 und seine sechs
`RequirementsGovernanceGate`-Kanten bleiben in der archivierten
Schema-1.1-Review-Evidence nachweisbar. Position 39 ist als naechster serieller
Kandidat ausgewaehlt; dieser Status startet den Lauf nicht und erteilt keine
Release- oder Delivery-Autoritaet. Die weiteren Roots starten nicht automatisch. Die abgeschlossenen
Features 009 sowie 015 bis 025 sind keine aktiven Serienknoten mehr. Ihre archivierten Lastenhefte
und Abschluesse bleiben historische Evidence fuer die weitere Reihenfolge.

Eintrag 4 besaß ein hartes Abschluss-Gate und ist als Feature 018
abgeschlossen. R-TUI wurde als Feature 019 abgeschlossen und lieferte D4s
bindende Dokumentationsoberfläche. D4 wurde als Feature 020 abgeschlossen. Der
Feature-020-Closeout entfernte D4 und gab D5 mit genau `DIA001` frei. D5 wurde
als Feature 021 abgeschlossen. D6 wurde als Feature 022 abgeschlossen. Der
Feature-022-Closeout entfernte D6 samt seinen zwei ausgehenden Kanten und gab
D7 frei. Der Feature-023-Closeout entfernte D7 samt seiner ausgehenden Kante
und gab Position 5 frei. Der Feature-024-Closeout archivierte Position 5,
entfernte ihre vier ausgehenden Kanten und gab Position 6 frei. Der aktuelle
Feature-025-Closeout archiviert Position 6; da sie keine ausgehende Series-Kante
besass, blieben damals alle 36 Abhaengigkeiten erhalten. Das spaetere G2-Update
ergaenzte vier bindende Kanten und markierte zunaechst G2A als einzigen
bevorzugten Kandidaten. Feature 027 und PR #241 schlossen G2A ab. Feature 028
und PR #243 archivierten beide G2-Knoten und stellten Position 7 als einzigen
bevorzugten `Eligible`-Kandidaten wieder her. Das G3/G4-Update archivierte
diesen Vorstand und setzte G3 vor G4 sowie G4 vor Position 7. Der aktuelle
Closeout archiviert G3 samt Stage-B-Nachweis, entfernt die abgeschlossene
G3-zu-G4-Kante und machte G4 zunaechst zum einzigen bevorzugten
`Eligible`-Kandidaten. Die aktuelle Umbuchung verschiebt Position 39 an den
Anfang der aktiven Serie, ersetzt die beratende Kante von Position 38 durch
eine beratende Kante zu G4 und macht Position 39 zum einzigen bevorzugten
`Eligible`-Kandidaten. Diese Einordnung erteilt keine Start- oder
Delivery-Autoritaet fuer einen Folgelauf.

Die abgeschlossene Position 5 bleibt historische Bewertungsgrundlage fuer 6,
7, 13 und 14. G3 und Stage B lieferten die abgeschlossene
Actions-Budget-Grundlage fuer G4; G4 liefert die
Copilot-Review-Grundlage fuer Position 7. Position 7 liefert danach die
Sandbox-Grundlage fuer 8. Position 10 wird vor 11
ausgefuehrt, damit neue oder geaenderte Cmdlet-Oberflaechen unmittelbar
dokumentiert werden koennen. Die Positionen 9 bis 12 liefern Eingaben fuer den
abschliessenden GSDB-Lauf. Position 13 muss deshalb zuletzt laufen.

D4 bis D7 bilden einen neuen, bindenden Dokumentationsarchitektur-Strang nach
Position 4. D4 auditierte ohne Remediation. D5 setzte genau das bestätigte
Level-0-Finding `DIA001` um. D6 dokumentiert das nun stabile Betriebsverhalten und
lieferte zusätzlich eine bindende Oberfläche für Position 11. D7 übernahm nur
portable Regeln in die registrierte Flotte und gab danach Position 5 frei.
Feature 024 haertete die gemeinsame Bewertungsgrundlage und gab danach Position
6 frei. Feature 025 bewertete die gesamte RL-SE-/Checklist-Oberflaeche und gibt
nach ihrem Abschluss Position 7 frei.
Keiner dieser Läufe startet seinen Nachfolger automatisch.

Die Kette behandelt die Workspace-Grenze ausdrücklich kausal: D4 inventarisierte
und bewertete die bestehende Trennung von `~/home-baseline-source`,
manifestgesteuerter Home-Baseline Runtime und `machineLocal`-Zustand; D5
verankerte das akzeptierte Finding in Navigation und Dokumentationsvertrag; D6
erklärt Inhalt, Vorteile, Änderungsort, Einweg-Sync und Authority für den
täglichen Betrieb; D7 übernahm nur portable Entscheidungsregeln und erweiterte
weder Level-0-Pfade noch die technische Propagationszielmenge stillschweigend.

*D4 through D7 form a new binding documentation-architecture track after item
4. D4 audited without remediation, D5 implemented the accepted Level 0 finding, D6
documents the stable operating surface and also feeds item 11, and D7 adopted
portable rules across the registered fleet before releasing item 5. Feature
024 hardened that shared assessment baseline and then released item 6. Feature
025 assessed the complete RL-SE/checklist surface and releases item 7 only
through this closeout. No run starts its successor automatically.*

*The chain treats the workspace boundary causally: D4 inventoried and evaluated
the existing separation between `~/home-baseline-source`, the manifest-managed
Home Baseline Runtime, and `machineLocal` state; D5 anchored the accepted
finding in navigation and the documentation contract; D6 explains contents,
benefits, edit location, one-way sync, and authority for daily operation; and
D7 adopted only portable decision rules without silently expanding Level 0
paths or the technical propagation target set.*

*Item 4 was a hard dependency rather than an ordering recommendation and is
now completed as Feature 018. R-TUI completed as Feature 019 and provided
D4's binding documentation-surface baseline. D4 completed as Feature 020 and
handed exactly `DIA001` to D5. D5 completed as Feature 021 and closed `DIA001`.
D6 completed as Feature 022 and is archived. D7 completed as Feature 023 and
is archived. Item 5 completed as Feature 024 and is archived. Item 6 completed
   as Feature 025 and is archived. Feature 028 and PR #243 completed and
   archived the later G2 gate and temporarily restored roots 7, 9, and 10. The
   G3/G4 update replaced root 7 with G3 and blocked G4 and item 7. The current
   closeout archives completed G3 and Stage B and removes their active edge.
   The current rebooking promotes item 39 as the sole preferred `Eligible`
   candidate and places G4 behind it through an advisory edge. This status
   grants no authority to start, release, or deliver any target. G4, item 7, and item
   10 provide binding baselines for their successors. Items 9 through 12 feed the final GSDB audit,
so item 13 must run last.*

„Abschließend“ bei Position 13 bezieht sich auf den bestehenden
Skript-/Konfigurationsstrang der Positionen 9 bis 12. Die Positionen 14 bis 17
bilden danach einen eigenen Assurance-Strang. Position 14 darf erst starten,
wenn die abgeschlossene Dokumentverzahnung aus Position 5 und das GSDB-Audit
aus Position 13 nachgewiesen sind. Position 15 übernimmt nur bestätigte portable
Findings. Position 16 benötigt den Audit und das veröffentlichte Preset.
Position 17 benötigt zusätzlich die gemergte Baseline 3.3.0. Keine dieser
Positionen startet ihren Nachfolger automatisch.

*“Final” at item 13 refers to the existing script and configuration track from
items 9 through 12. Items 14 through 17 form a separate assurance track. The
gap audit requires items 5 and 13; productization requires item 14; baseline
synchronization requires items 14 and 15; and ABSDD adoption requires items 15
and 16. No item starts its successor automatically.*

Die Positionen 18 bis 25 bilden danach einen seriellen KDM-/KITSM-
Lernreihenstrang. Position 18 beginnt erst nach der ABSDD-Adoption, damit
Audit, Lernarchitektur und Lernmaterialien die dann gültige
Secure-Development-Baseline verwenden. Positionen 18 und 25 sind read-only
Audits. Positionen 19 bis 23 ändern ausschließlich kanonisches
Level-0-Lernmaterial. Erst Position 24 verteilt die gemergten Inhalte in drei
Level-1- und drei C#-Level-2-Referenzrepositories. C# ist vorerst die
verbindliche Referenzsprache; Go, Java, Python, Rust und Swift bleiben
unverändert. Kein Lauf startet seinen Nachfolger automatisch.

*Items 18 through 25 form a serial KDM/KITSM learning-series track after the
assurance adoption. Audits remain read-only, learning documents are prepared
at Level 0 first, and only item 24 rolls merged material out to three Level-1
and three C# Level-2 reference repositories. Other MSL paths remain unchanged,
and no run starts its successor automatically.*

Die Positionen 26 bis 32 bilden danach den eigenständigen ITSE-Strang. Der
Gap-Audit vergleicht zuerst mit allen vier FI-Fachrichtungen; SI und DV sind
fachlich besonders nah, AE und DPA bleiben als Software-, Daten- und
Diagnoseperspektiven sichtbar. KITSM und KDM liefern nur einen ergänzenden
Vergleich. Position 31 verteilt erst nach den drei Lehrjahresstufen in dieselben
drei Level-1- und drei C#-Level-2-Referenzrepositories. Position 32 schließt
ITSE read-only ab.

*Items 26 through 32 form the dedicated ITSE track. The initial audit compares
ITSE with all four IT-specialist tracks; SI and DV are especially close, while
AE and DPA remain visible as software, data, and diagnostic perspectives.
KITSM and KDM provide secondary comparison only. Item 31 performs the
controlled C# rollout, and item 32 closes ITSE read-only.*

Die Positionen 33 bis 37 bilden eine eigene Governance-Kette. Position 33
prüft zunächst ohne Änderungen, ob FI-, ITSE-, KITSM- und KDM-Lernreihen
**in sich**, **an sich** und **insgesamt** konsistent sind. Dabei bedeutet
„in sich“ die Übereinstimmung innerhalb einer Reihe, „an sich“ den Abgleich
mit offiziellen Ausbildungsgrundlagen und Level-0-Regeln und „insgesamt“ den
widerspruchsfreien Zusammenhang aller Reihen. Der Audit bewertet zusätzlich
acht KI-Kompetenzen von Grundlagen und sicherer Werkzeugnutzung bis zu
agentischer Planung, Verifikation und verantwortlicher Reflexion.

Position 34 verankert nur die drei allgemeinen Konsistenzebenen im bestehenden
Intake Review. Position 35 erstellt daraus ausschließlich bei bestätigtem
Bedarf das optionale Lernreihen-Preset; Position 36 prüft dessen Übertragbarkeit
an realen IT-Profilen und begrenzten synthetischen Nicht-IT-Fixtures. Erst
Position 37 darf den Gesamtschluss ziehen. Offizielle Vorgaben, durch Quellen
gestützte Lernziele, bewusste Projektergänzungen und ausdrücklich als
Zukunftskompetenz angenommene KI-Inhalte bleiben dabei unterscheidbar.
Berufsspezifische Unterschiede werden dokumentiert, nicht eingeebnet. Kein
Lauf startet seinen Nachfolger automatisch.

*Items 33 through 37 form a separate governance chain. Item 33 first audits the
FI, ITSE, KITSM, and KDM learning series for internal, normative, and ecosystem
consistency and maps eight AI competencies. Item 34 adds only the universal
three-level consistency model to Intake Review. Item 35 creates the optional
learning-series preset only from confirmed findings, item 36 validates its
portability, and item 37 performs the final closure. Official requirements,
source-supported goals, project supplements, and explicit future-skill
assumptions remain distinguishable. Intentional occupation-specific
differences are documented rather than removed, and no run starts its
successor automatically.*

Position 38 bildet anschließend einen eigenständigen, nicht dringlichen
Dokumentations-Follow-up. Die beratende Kante von Position 37 bewahrt seine
sichtbare Einordnung am Ende, behauptet aber keine fachliche Abhängigkeit von
der Lernreihen-Closure. Weitere Befunde dürfen vor dem Intake Review nur über
einen ausdrücklich autorisierten `$speckit-intake-update` ergänzt werden; der
dadurch geänderte Zielhash wird anschließend begrenzt in der Series nachgeführt.

*Item 38 is a separate, non-urgent documentation follow-up. Its advisory edge
from item 37 preserves the visible final position without claiming a functional
dependency on the learning-series closure. Later findings use an explicitly
authorized Intake Update followed by a bounded series hash refresh.*

Position 39 hält die repositoryübergreifende Idee für verlinkte
Abarbeitungsreihenfolgen in sieben Herzensprojekten fest. Seine stabile
sichtbare Kennung bleibt erhalten; als `vorgezogen / promoted` steht es jedoch
auf aktivem Manifestplatz 1. Die frühere beratende Kante von Position 38 ist
durch eine beratende Kante zu G4 ersetzt. TuiVision gehört zum Scope; seine
zehn abgeschlossenen Intakes, sechs vorhandenen Abhängigkeiten und der
getrennte `DeferredOptional`-Backlog bleiben fachlich unverändert.

*Item 39 records the cross-repository linked-order-view idea for seven passion
projects. Its stable visible identifier remains unchanged, but promotion moves
it to active manifest position 1. The former advisory edge from item 38 is
replaced by an advisory edge to G4. TuiVision is in scope while its ten
completed intakes, six existing dependencies, and separate DeferredOptional
backlog retain their meaning.*

Der Vorlauf D1 bis D3 bildet den Dokumentations-Wirklichkeitsabgleich. D1 prüft
Level 0 und jedes aktuell registrierte Level-1-/Level-2-Repository zunächst
ohne fachliche Korrekturen. D2 darf nur bestätigte zentrale Level-0-Findings
beheben, disponiert alle übrigen Findings und verankert die dauerhafte
Documentation-Impact-Regel. Erst diese gemergte Baseline darf D3 in alle
registrierten Level-1-/Level-2-Repositories übernehmen; Level 0 wird dabei vor
und nach der Flottenauslieferung revalidiert. D3 ist das harte
Dokumentations-Gate für die bisherigen Roots 1, 2, 3, 5, 9 und 10. Ein neues
portables Preset wird nicht vorab unterstellt; ein solcher Follow-up braucht
einen reproduzierbaren Befund aus D1 oder D2.

*Preflight D1 through D3 is the documentation-reality track. D1 audits Level 0
and every registered Level 1 and Level 2 repository without remediation. D2
remediates confirmed central Level 0 findings and establishes the durable
documentation-impact rule. D3 applies that merged baseline to all registered
Level 1 and Level 2 repositories, revalidates Level 0, and gates the former
roots. A new portable preset requires reproducible evidence and is not assumed
in advance.*

## Serielle Ausfuehrung und native Systeme / Serial Delivery and Native Systems

Windows- und Linux-/Ubuntu-Haertung duerfen fachlich auf dem jeweiligen nativen
System geprueft werden. Die sichtbare Reihenfolge bleibt trotzdem erhalten:
Jeder Lauf beginnt auf dem aktuellen Default-Branch und uebernimmt nur
nachweislich gemergte Vorgaenger. Git-Lieferungen werden seriell abgeschlossen,
wenn mehrere Laeufe gemeinsame Evidence-, Workflow-, Agent-, Statistik- oder
Registry-Dateien beruehren.

Die sichtbare Reihenfolge allein ist kein technisches Startverbot. Ein Start ist
jedoch verboten, wenn eine oben dokumentierte Graphkante oder ein allgemeines
Projekt-Gate noch offen ist. Vor jedem Lauf muessen Intake-Hash,
Review-Freshness, Branch, Remote-Stand und aktuelle Benutzerautoritaet erneut
geprueft werden.

*Windows and Linux/Ubuntu validation may run on their respective native
systems. Delivery still follows the visible order and starts from the current
default branch. Runs that touch shared evidence, workflow, agent, statistics,
or registry files are merged serially. The visible order is guidance unless a
documented graph edge or project gate makes it binding.*

Die zuvor auf den Positionen 5 bis 18 gefuehrten
Secure-CaseTracker-Lernreihen-Intakes bleiben unter `docs/learning-units/`
erhalten, sind aber nicht mehr Teil dieser zentralen aktiven Reihenfolge.

*The Secure CaseTracker learning-series intakes previously listed as items 5
through 18 remain under `docs/learning-units/`, but are no longer part of this
central active order.*

## Historisch / Nicht erneut ausfuehren

Diese Lastenhefte enthalten bereits eine Feature-Branch-Kennung im Dateinamen
und werden nicht als neue Spec-Kit-Laeufe eingeplant:

*These Lastenhefte already contain a feature-branch marker in the file name and
are not scheduled as new Spec Kit runs:*

- `Lastenheft_workspace-homogeneity-guardian.001-workspace-homogeneity-guardian.md`
- `Lastenheft_workspace-homogeneity-guardian-revision.002-homogeneity-guardian-revision.md`
- `Lastenheft_Git_Config_Scope.003-git-config-scope.md`
- `Lastenheft_Workspace_Teardown.005-workspace-teardown.md`
- `Lastenheft_GitLab_Support.006-gitlab-support.md`
- `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md`
- `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.015-windows-maintenance-hardening.md`
- `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.016-linux-maintenance-hardening.md`
- `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.017-preset-profile-worktree-hardening.md`

## Kontext ohne Feature-Branch-Kennung

`Lastenheft_Workspace_Migration.md` bleibt als fachlicher Kontext erhalten. Vor
einem spaeteren Lauf muss geprueft werden, ob der Inhalt noch eigenstaendig
offen ist oder bereits durch spaetere Homogeneity-, Migration- oder
Secure-Development-Arbeiten ueberholt wurde.

*`Lastenheft_Workspace_Migration.md` remains available as functional context.
Before a later run, check whether it is still independently open or has already
been superseded by later homogeneity, migration, or secure-development work.*

`Lastenheft_agentische-umgebung-pruefen-und-syncen.md` bleibt als historischer
Vorgaenger der plattformuebergreifenden Ein-Kommando-Wartung erhalten. Es wird
nicht mehr als eigener aktiver Spec-Kit-Lauf eingeplant.

*`Lastenheft_agentische-umgebung-pruefen-und-syncen.md` remains as the
historical predecessor of cross-platform one-command maintenance. It is no
longer scheduled as a separate active Spec Kit run.*
