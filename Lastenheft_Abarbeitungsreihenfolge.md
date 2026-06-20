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
| 1 | `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md` | Verzahnt Richtlinie, Checklisten, Sammelband, mitgeltende Dokumente und Governance-Presets, damit spaetere Spec-Kit-Laeufe dieselbe Bewertungslogik nutzen. / Aligns guideline, checklists, compendium, related documents, and governance presets so later Spec Kit runs use the same assessment logic. |
| 2 | `Lastenheft_Secure-Development-Container-Hardening.md` | Leitet Anforderungen fuer einen sicheren Entwicklungscontainer aus Richtlinie, Checklisten, mitgeltenden Dokumenten und Presets ab. / Derives requirements for a secure development container from the guideline, checklists, related documents, and presets. |
| 3 | `Lastenheft_CICD_Pipeline_Konfiguration.md` | Prueft und haertet die CI/CD-Basis nach der dokumentierten Governance-Logik. / Reviews and hardens the CI/CD baseline according to the documented governance logic. |
| 4 | `Lastenheft_Script_Dokumentation.md` | Fuehrt Skript- und Bedienungsdokumentation zusammen. / Aligns script and usage documentation. |
| 5 | `Lastenheft_PowerShell_Cmdlets.md` | Prueft PowerShell-Cmdlet-Konventionen und Windows-Paritaet. / Reviews PowerShell cmdlet conventions and Windows parity. |
| 6 | `Lastenheft_agentische-umgebung-pruefen-und-syncen.md` | Prueft und synchronisiert die agentische Level-0-/Level-1-/Level-2-Umgebung. / Reviews and synchronizes the agentic Level-0/Level-1/Level-2 environment. |

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
