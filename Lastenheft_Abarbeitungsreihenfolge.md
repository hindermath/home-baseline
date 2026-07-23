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

## Aktive Reihenfolge / Active Order

| Reihenfolge / Order | Lastenheft | Zweck / Purpose |
|---:|---|---|
| 1 | `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md` | Plant eine fortsetzbare Ein-Kommando-Wartung mit Desired-State-Flotte, sicherem Clone-on-missing, Plattformparität und kompaktem JSON-Abschlussbericht. / Plans resumable one-command maintenance with a desired-state fleet, safe clone-on-missing, platform parity, and a compact JSON closeout report. |
| 2 | `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md` | Plant die Windows-Haertungsrunde fuer Python-Bootstrap, stabile WhatIf-Ermittlung, sichere Wiederaufnahme, Zehn-Preset-Registry, Git-normalisierten Drift, begrenzte GitHub-Retries und WinGet-Prozesskontrolle. / Plans the Windows hardening round for Python bootstrap, stable WhatIf discovery, safe resume, the ten-preset registry, Git-normalized drift, bounded GitHub retries, and WinGet process control. |
| 3 | `Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md` | Plant die Linux-/Ubuntu-Haertung fuer stdin-sichere Homebrew-Iteration, fail-closed Required-Pruefung, korrekte Gesamt-Exitcodes und einen automatisierten Swift-Installationsweg. / Plans Linux and Ubuntu hardening for input-safe Homebrew iteration, fail-closed required checks, correct overall exit codes, and automated Swift installation. |
| 4 | `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md` | Härtet Remote-Aktualität, beliebige Default-Branches, Hard-Abort-Bereinigung, PowerShell-Verhaltensparität und Nicht-MSL-Registry-Konsistenz. / Hardens remote freshness, arbitrary default branches, hard-abort cleanup, PowerShell behavior parity, and non-MSL registry consistency. |
| 5 | `Lastenheft_Agentic-Workspace-Maintenance-TUI.md` | Plant die Spectre.Console-Wartungs-TUI; Abarbeitung ist hart gesperrt, bis die Eintraege 1 bis 4 vollstaendig implementiert, validiert und gemaess ihrer jeweiligen Delivery Authority abgeschlossen sind. / Plans the Spectre.Console maintenance TUI; processing is hard-blocked until items 1 through 4 are fully implemented, validated, and closed out under their respective delivery authority. |
| 6 | `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md` | Verzahnt Richtlinie, Checklisten, Sammelband, mitgeltende Dokumente und Governance-Presets, damit spaetere Spec-Kit-Laeufe dieselbe Bewertungslogik nutzen. / Aligns guideline, checklists, compendium, related documents, and governance presets so later Spec Kit runs use the same assessment logic. |
| 7 | `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` | Verankert eine generische Selbstpruefung gegen Richtlinie Sichere Entwicklung, CL_01 bis CL_12, Sammelband, mitgeltende Dokumente und Presets vor spaeteren Haertungen. / Anchors a generic self-assessment against secure-development guideline, CL_01 through CL_12, compendium, related documents, and presets before later hardening. |
| 8 | `Lastenheft_Secure-Development-Container-Hardening.md` | Leitet Anforderungen fuer einen sicheren Entwicklungscontainer aus Richtlinie, Checklisten, mitgeltenden Dokumenten und Presets ab. / Derives requirements for a secure development container from the guideline, checklists, related documents, and presets. |
| 9 | `Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md` | Bereitet MSL-basierte Level-2-Repositories auf spaetere Sandbox-gestuetzte Secure-Development-Haertung vor, ohne diese Haertung zu starten. / Prepares MSL-based level-2 repositories for later sandbox-supported secure-development hardening without starting that hardening. |
| 10 | `Lastenheft_CICD_Pipeline_Konfiguration.md` | Prüft und härtet die CI/CD-Basis nach der dokumentierten Governance-Logik. / Reviews and hardens the CI/CD baseline according to the documented governance logic. |
| 11 | `Lastenheft_Script_Dokumentation.md` | Führt Skript- und Bedienungsdokumentation zusammen. / Aligns script and usage documentation. |
| 12 | `Lastenheft_PowerShell_Cmdlets.md` | Prüft PowerShell-Cmdlet-Konventionen und Windows-Parität. / Reviews PowerShell cmdlet conventions and Windows parity. |
| 13 | `Lastenheft_Didactic-Script-and-Config-Comment-Hardening.md` | Prüft didaktische Kommentare in Skript- und Konfigurationslogik inklusive JSONC-Migrationskandidaten. / Reviews didactic comments in script and configuration logic, including JSONC migration candidates. |
| 14 | `Lastenheft_Script-and-Config-GSDB-Pruefung.md` | Prüft Skript-, JSON/JSONC-, YAML- und Workflow-Flächen fokussiert gegen die GSDB. / Reviews script, JSON/JSONC, YAML, and workflow surfaces against the GSDB. |

Eintrag 5 ist eine harte Abhaengigkeit und kein nur empfohlener
Reihenfolgehinweis. Vor Feature-, Branch- oder Spec-Kit-Artefakterstellung fuer
die TUI muessen die im TUI-Lastenheft und in dieser Reihenfolgedatei definierten
Abschlussnachweise fuer die Eintraege 1 bis 4 vorliegen. Fehlt ein Nachweis,
bleibt Eintrag 5 `BLOCKED`.

*Item 5 is a hard dependency rather than an ordering recommendation. Evidence
for all four predecessor items must pass before any TUI feature, branch, or
Spec Kit artifact is created; otherwise item 5 remains `BLOCKED`.*

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
