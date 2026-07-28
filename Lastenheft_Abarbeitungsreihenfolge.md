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
Position 2 als Feature 016 über PR #146 abgeschlossen und archiviert.
Position 3,
`Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md`, ist jetzt
der einzige Kandidat `Eligible`. Dieser Closeout startet den nächsten Lauf
nicht.

*The gate did not reorder the existing domain work. G1 is archived and removed
from the active series. It released the six previous roots; the later D4-D7
documentation chain now provides a new binding predecessor for former item 5.
Items 1 and 2 completed as Features 015 and 016 through PRs #142 and #146 and
are archived. Preset, default-branch, and worktree hardening at item 3 is now
the only declared `Eligible` candidate. This closeout does not start it.*

## Aktive Reihenfolge / Active Order

| Reihenfolge / Order | Lastenheft | Zweck / Purpose |
|---:|---|---|
| 3 | `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md` | Härtet Remote-Aktualität, beliebige Default-Branches, Hard-Abort-Bereinigung, PowerShell-Verhaltensparität und Nicht-MSL-Registry-Konsistenz. / Hardens remote freshness, arbitrary default branches, hard-abort cleanup, PowerShell behavior parity, and non-MSL registry consistency. |
| 4 | `Lastenheft_Agentic-Workspace-Maintenance-TUI.md` | Plant die Spectre.Console-Wartungs-TUI; Abarbeitung ist hart gesperrt, bis Feature 009, die archivierten Positionen 1 und 2 sowie die aktive Position 3 vollständig abgeschlossen sind. / Plans the Spectre.Console maintenance TUI; processing is hard-blocked until Feature 009, archived items 1 and 2, and active item 3 are fully closed. |
| D4 | `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md` | Prüft nach Position 4 die gesamte Git-getrackte Level-0-Dokumentation read-only auf Informationsarchitektur, Leserpfade, Sprachstrategie und gestufte Tiefe. / Audits all Git-tracked Level 0 documentation after item 4 for information architecture, reader paths, language strategy, and progressive depth without remediation. |
| D5 | `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.md` | Setzt ausschließlich bestätigte D4-Findings um und verankert Einstiegspunkte, Sprachpartner und den dauerhaften Dokumentationsarchitektur-Vertrag. / Implements only accepted D4 findings and establishes entry pages, language pairs, and the durable documentation-architecture contract. |
| D6 | `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` | Dokumentiert das nach Position 4 stabile Wartungsverhalten für Lernende, Nutzende, Maintainer/KI-Agenten und Audit, ohne Skriptverhalten zu ändern. / Documents the stable post-item-4 maintenance behavior for learners, operators, maintainers/AI agents, and audit without changing script behavior. |
| D7 | `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.md` | Übernimmt nur belegte portable Regeln repository-spezifisch in die registrierte Level-1-/Level-2-Flotte; unveränderte Repositories erhalten keinen Leer-PR. / Adopts only proven portable rules per repository across the registered Level 1/2 fleet; unchanged repositories receive no empty pull request. |
| 5 | `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md` | Verzahnt Richtlinie, Checklisten, Sammelband, mitgeltende Dokumente und Governance-Presets, damit spaetere Spec-Kit-Laeufe dieselbe Bewertungslogik nutzen. / Aligns guideline, checklists, compendium, related documents, and governance presets so later Spec Kit runs use the same assessment logic. |
| 6 | `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` | Verankert eine generische Selbstpruefung gegen Richtlinie Sichere Entwicklung, CL_01 bis CL_12, Sammelband, mitgeltende Dokumente und Presets vor spaeteren Haertungen. / Anchors a generic self-assessment against secure-development guideline, CL_01 through CL_12, compendium, related documents, and presets before later hardening. |
| 7 | `Lastenheft_Secure-Development-Container-Hardening.md` | Leitet Anforderungen fuer einen sicheren Entwicklungscontainer aus Richtlinie, Checklisten, mitgeltenden Dokumenten und Presets ab. / Derives requirements for a secure development container from the guideline, checklists, related documents, and presets. |
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
| 33 | `Lastenheft_Lernreihen-Gesamtkonsistenz-Closure.md` | Prüft abschließend jede Reihe in sich, gegen ihre normativen Quellen und alle Reihen gemeinsam auf konsistente Lernziele, Evidence und Sicherheitsgrenzen. / Finally checks every series internally, against its normative sources, and across all series for consistent learning goals, evidence, and safety boundaries. |

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

3 Preset/Branch -----> 4 Maintenance TUI
                             |
                             v
              D4 Informationsarchitektur-Audit
                             |
                             v
              D5 Level-0-Architektur und Sprache
                             |
                             v
              D6 Workspace-Effizienzleitfaden ----------> 11 Skript-Dokumentation
                             |
                             v
              D7 Level-1/2-Flottenadoption
                             |
                             v
              5 Mitgeltende Dokumente

5 Mitgeltende Dokumente --> 6 RL-SE-Selbstpruefung
5 Mitgeltende Dokumente --> 7 Container-Haertung --> 8 Level-2-Sandbox
5 Mitgeltende Dokumente --------------------------------> 13 GSDB-Audit

10 PowerShell-Cmdlets --> 11 Skript-Dokumentation
9 CI/CD -----------\
10 Cmdlets ----------+--> 12 Didaktische Kommentare
11 Dokumentation ---/
9 CI/CD ------------\
10 Cmdlets -----------+--> 13 Abschliessendes GSDB-Audit
11 Dokumentation -----+
12 Kommentare -------/

5 Mitgeltende Dokumente --\
13 GSDB-Audit -------------+--> 14 Assurance-Gap-Audit
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
33 Lernreihen-Gesamtkonsistenz-Closure

```

Nach dem Abschluss der Features 015 und 016 sind die aktiven Roots `3`, `9`
und `10`. Die bisherige Position 5 ist kein Root, weil D7 ihre bindende
Dokumentationsarchitektur-Basis liefert. G1 und seine sechs
`RequirementsGovernanceGate`-Kanten bleiben in der archivierten
Schema-1.1-Review-Evidence nachweisbar. Position 3 ist als nächster serieller
Kandidat ausgewählt; die anderen Roots bleiben fachlich verfügbar, starten
aber nicht automatisch. Die abgeschlossenen Features 009, 015 und 016 sind
keine aktiven Serienknoten mehr. Ihre archivierten Lastenhefte und Abschlüsse
bleiben historische Evidence für das TUI-Gate.

Eintrag 4 besitzt ein hartes Abschluss-Gate. Vor Feature-, Branch- oder
Spec-Kit-Artefakterstellung für die TUI müssen die Abschlussnachweise für
Feature 009 sowie die Positionen 1 und 2 und der im TUI-Lastenheft definierte
Nachweis für die aktive Position 3 vorliegen. Fehlt ein Nachweis, bleibt
Eintrag 4 `BLOCKED`.

Position 5 liefert die gemeinsame Bewertungsgrundlage fuer 6, 7 und 13.
Position 7 liefert die Sandbox-Grundlage fuer 8. Position 10 wird vor 11
ausgefuehrt, damit neue oder geaenderte Cmdlet-Oberflaechen unmittelbar
dokumentiert werden koennen. Die Positionen 9 bis 12 liefern Eingaben fuer den
abschliessenden GSDB-Lauf. Position 13 muss deshalb zuletzt laufen.

D4 bis D7 bilden einen neuen, bindenden Dokumentationsarchitektur-Strang nach
Position 4. D4 auditiert ohne Remediation. D5 setzt nur bestätigte
Level-0-Findings um. D6 dokumentiert das dann stabile Betriebsverhalten und
liefert zusätzlich eine bindende Oberfläche für Position 11. D7 übernimmt nur
portable Regeln in die registrierte Flotte und gibt danach Position 5 frei.
Keiner dieser Läufe startet seinen Nachfolger automatisch.

*D4 through D7 form a new binding documentation-architecture track after item
4. D4 audits without remediation, D5 implements accepted Level 0 findings, D6
documents the stable operating surface and also feeds item 11, and D7 adopts
portable rules across the registered fleet before releasing item 5. No run
starts its successor automatically.*

*Item 4 is a hard dependency rather than an ordering recommendation. Evidence
for Feature 009 and all three active predecessor items must pass before any TUI
feature, branch, or Spec Kit artifact is created; otherwise item 4 remains
`BLOCKED`. Items 5, 7, and 10 provide binding baselines for their successors.
Items 9 through 12 feed the final GSDB audit, so item 13 must run last.*

„Abschließend“ bei Position 13 bezieht sich auf den bestehenden
Skript-/Konfigurationsstrang der Positionen 9 bis 12. Die Positionen 14 bis 17
bilden danach einen eigenen Assurance-Strang. Position 14 darf erst starten,
wenn die aktuelle Dokumentverzahnung aus Position 5 und das GSDB-Audit aus
Position 13 abgeschlossen sind. Position 15 übernimmt nur bestätigte portable
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
ITSE read-only ab. Position 33 prüft anschließend die FI-, ITSE-, KITSM- und
KDM-Lernreihen in sich, gegen ihre normativen Grundlagen und insgesamt
zueinander. Absichtliche berufsspezifische Unterschiede werden dokumentiert,
nicht eingeebnet. Kein Lauf startet seinen Nachfolger automatisch.

*Items 26 through 32 form the dedicated ITSE track. The initial audit compares
ITSE with all four IT-specialist tracks; SI and DV are especially close, while
AE and DPA remain visible as software, data, and diagnostic perspectives.
KITSM and KDM provide secondary comparison only. Item 31 performs the
controlled C# rollout, item 32 closes ITSE read-only, and item 33 then checks
the FI, ITSE, KITSM, and KDM learning series internally, against their
normative sources, and together. Intentional occupation-specific differences
are documented rather than removed. No run starts its successor
automatically.*

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
