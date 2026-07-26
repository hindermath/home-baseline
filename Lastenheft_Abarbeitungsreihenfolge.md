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
| D1 | `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.md` | Inventarisiert Level 0 und alle registrierten Level-1-/Level-2-Repositories und prüft ihre Dokumentation read-only gegen die jeweilige Wirklichkeit. / Inventories Level 0 and every registered Level 1 and Level 2 repository and audits their documentation read-only against each repository's reality. |
| D2 | `Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Flotten-Governance.md` | Behebt zentrale Level-0-Findings, disponiert alle D1-Findings und verankert den flottenweiten Documentation-Impact-Vertrag. / Remediates central Level 0 findings, dispositions every D1 finding, and anchors the fleet documentation-impact contract. |
| D3 | `Lastenheft_Registrierte-Level-1-2-Dokumentations-Wirklichkeitsabgleich-Flotte.md` | Prüft und korrigiert alle registrierten Level-1-/Level-2-Repositories gegen ihre jeweilige Wirklichkeit und revalidiert Level 0 als Baseline. / Audits and corrects every registered Level 1 and Level 2 repository against its own reality and revalidates Level 0 as the baseline. |

*The mandatory D1–D3 preflight completes before the numbered order resumes, so
all later work uses the validated documentation-impact baseline.*

## Aktive Reihenfolge / Active Order

| Reihenfolge / Order | Lastenheft | Zweck / Purpose |
|---:|---|---|
| 1 | `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md` | Plant die Windows-Haertungsrunde fuer Python-Bootstrap, stabile WhatIf-Ermittlung, sichere Wiederaufnahme, Zehn-Preset-Registry, Git-normalisierten Drift, begrenzte GitHub-Retries und WinGet-Prozesskontrolle. / Plans the Windows hardening round for Python bootstrap, stable WhatIf discovery, safe resume, the ten-preset registry, Git-normalized drift, bounded GitHub retries, and WinGet process control. |
| 2 | `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md` | Plant die Linux-/Ubuntu-Haertung fuer stdin-sichere Homebrew-Iteration, fail-closed Required-Pruefung, korrekte Gesamt-Exitcodes und einen automatisierten Swift-Installationsweg. / Plans Linux and Ubuntu hardening for input-safe Homebrew iteration, fail-closed required checks, correct overall exit codes, and automated Swift installation. |
| 3 | `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md` | Härtet Remote-Aktualität, beliebige Default-Branches, Hard-Abort-Bereinigung, PowerShell-Verhaltensparität und Nicht-MSL-Registry-Konsistenz. / Hardens remote freshness, arbitrary default branches, hard-abort cleanup, PowerShell behavior parity, and non-MSL registry consistency. |
| 4 | `Lastenheft_Agentic-Workspace-Maintenance-TUI.md` | Plant die Spectre.Console-Wartungs-TUI; Abarbeitung ist hart gesperrt, bis Feature 009 und die aktiven Eintraege 1 bis 3 vollstaendig abgeschlossen sind. / Plans the Spectre.Console maintenance TUI; processing is hard-blocked until Feature 009 and active items 1 through 3 are fully closed. |
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

## Verbindliche Abhaengigkeiten / Binding Dependencies

Die folgende Textmatrix ist der maschinenpruefbaren Series-Evidence
gleichgestellt. Ein Pfeil bedeutet: Der linke Intake liefert eine bindende
Grundlage fuer den rechten Intake.

```text
D1 Level-0/1/2-Doku-Audit --> D2 Level-0-Remediation und Flotten-Governance
                         --> D3 Level-1/2-Flotte und Level-0-Revalidierung

D3 Doku-Baseline --+--> 1 Windows -----------\
                   +--> 2 Linux --------------+--> 4 Maintenance TUI
                   +--> 3 Preset/Branch ------/
                   +--> 5 Mitgeltende Dokumente
                   +--> 9 CI/CD
                   +--> 10 PowerShell-Cmdlets

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

```

Die einzige Root dieser Serie ist Vorlauf `D1`. Nach D3 werden die bisherigen
Roots der nummerierten Reihenfolge freigegeben: `1`, `2`, `3`, `5`, `9` und
`10`.
Feature 009 ist kein aktiver Serienknoten mehr. Sein archiviertes Lastenheft
und sein Abschluss bleiben historische Evidence fuer das TUI-Gate.

Eintrag 4 besitzt ein hartes Abschluss-Gate. Vor Feature-, Branch- oder
Spec-Kit-Artefakterstellung fuer die TUI muessen der Abschlussnachweis fuer
Feature 009 sowie die im TUI-Lastenheft definierten Nachweise fuer die aktiven
Eintraege 1 bis 3 vorliegen. Fehlt ein Nachweis, bleibt Eintrag 4 `BLOCKED`.

Position 5 liefert die gemeinsame Bewertungsgrundlage fuer 6, 7 und 13.
Position 7 liefert die Sandbox-Grundlage fuer 8. Position 10 wird vor 11
ausgefuehrt, damit neue oder geaenderte Cmdlet-Oberflaechen unmittelbar
dokumentiert werden koennen. Die Positionen 9 bis 12 liefern Eingaben fuer den
abschliessenden GSDB-Lauf. Position 13 muss deshalb zuletzt laufen.

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
