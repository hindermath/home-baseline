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
| 2 | `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` | Verankert eine generische Selbstpruefung gegen Richtlinie Sichere Entwicklung, CL_01 bis CL_12, Sammelband, mitgeltende Dokumente und Presets vor spaeteren Haertungen. / Anchors a generic self-assessment against secure-development guideline, CL_01 through CL_12, compendium, related documents, and presets before later hardening. |
| 3 | `Lastenheft_Secure-Development-Container-Hardening.md` | Leitet Anforderungen fuer einen sicheren Entwicklungscontainer aus Richtlinie, Checklisten, mitgeltenden Dokumenten und Presets ab. / Derives requirements for a secure development container from the guideline, checklists, related documents, and presets. |
| 4 | `Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md` | Bereitet MSL-basierte Level-2-Repositories auf spaetere Sandbox-gestuetzte Secure-Development-Haertung vor, ohne diese Haertung zu starten. / Prepares MSL-based level-2 repositories for later sandbox-supported secure-development hardening without starting that hardening. |
| 5 | `docs/learning-units/Lastenheft_Secure-CaseTracker-Lernreihe.md` | Gesamtlandkarte für die EuFPA-Lernreihe Secure CaseTracker; nicht als einzelner großer Implementierungslauf starten. / Overall map for the EuFPA Secure CaseTracker learning series; do not start it as one large implementation run. |
| 6 | `docs/learning-units/Lastenheft_Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.md` | Bereitet pro MSL-Sprachrepo minimales Projekt, Build/Test, Secure-Development-Basis und Governance-Presets vor, ohne Fachlogik zu erzeugen. / Prepares the minimal project, build/test, secure-development baseline, and governance presets per MSL language repository without creating domain logic. |
| 7 | `docs/learning-units/Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md` | Klärt Kundenauftrag, Scope, Rollen, Akzeptanzkriterien und erste Datenschutz-/Sicherheitsannahmen. / Clarifies customer task, scope, roles, acceptance criteria, and first privacy/security assumptions. |
| 8 | `docs/learning-units/Lastenheft_Secure-CaseTracker_02_Domaenenmodell-und-Zustaende.md` | Definiert Domänenmodell, Pflichtfelder, erlaubte Zustände und verbotene Zustandswechsel. / Defines domain model, mandatory fields, allowed states, and forbidden state transitions. |
| 9 | `docs/learning-units/Lastenheft_Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.md` | Plant Trust Boundaries, Validierungsregeln, sichere Fehlermeldungen und negative Tests. / Plans trust boundaries, validation rules, safe error messages, and negative tests. |
| 10 | `docs/learning-units/Lastenheft_Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.md` | Plant datensparsames Audit-Logging, Datenschutznotiz und Log-Injection-Schutz. / Plans data-minimizing audit logging, privacy note, and log-injection protection. |
| 11 | `docs/learning-units/Lastenheft_Secure-CaseTracker_05_Rollen-und-Berechtigungen.md` | Definiert Rollenmatrix, sichere Defaults, geschützte Aktionen und Autorisierungstests. / Defines role matrix, secure defaults, protected actions, and authorization tests. |
| 12 | `docs/learning-units/Lastenheft_Secure-CaseTracker_06_Persistenz-und-Import-Export.md` | Plant sichere Persistenz, Import, Export, Pfadprüfung und sichere Deserialisierung. / Plans safe persistence, import, export, path checks, and safe deserialization. |
| 13 | `docs/learning-units/Lastenheft_Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.md` | Plant fachliche Tests, Sicherheitstests, Datenschutztests und offene Testlücken. / Plans functional tests, security tests, privacy tests, and open test gaps. |
| 14 | `docs/learning-units/Lastenheft_Secure-CaseTracker_08_Supply-Chain-und-MSL-Bewertung.md` | Bewertet Abhängigkeiten, Audit-Werkzeuge, MSL-Status und SBOM-/N/A-Entscheidungen. / Reviews dependencies, audit tools, MSL status, and SBOM/N/A decisions. |
| 15 | `docs/learning-units/Lastenheft_Secure-CaseTracker_09_Sandbox-und-Agentische-Entwicklung.md` | Plant Sandbox-Nutzung, Mounts, Schreibgrenzen, Secret-Regeln, Netzwerkannahmen und KI-Agenten-Grenzen. / Plans sandbox use, mounts, write boundaries, secret rules, network assumptions, and AI-agent boundaries. |
| 16 | `docs/learning-units/Lastenheft_Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.md` | Definiert Prozesskennzahlen, Datenqualität, Datenschutz und Grenzen der Aussagekraft. / Defines process metrics, data quality, privacy, and limits of interpretation. |
| 17 | `docs/learning-units/Lastenheft_Secure-CaseTracker_11_Spec-Kit-Review-und-Abschluss.md` | Plant Abschlussreview, Evidenzmatrix, Restrisiken, Folgeaufgaben und EuFPA-Präsentation. / Plans final review, evidence matrix, residual risks, follow-up tasks, and EuFPA presentation. |
| 18 | `docs/learning-units/Lastenheft_Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.md` | Sichert den abgeschlossenen Jahr-2-Stand als Baseline und bereitet spätere AE-/SI-/DPA-Track-Ableitungen vor. / Preserves the completed year-2 state as a baseline and prepares later AE/SI/DPA track derivations. |
| 19 | `Lastenheft_CICD_Pipeline_Konfiguration.md` | Prüft und härtet die CI/CD-Basis nach der dokumentierten Governance-Logik. / Reviews and hardens the CI/CD baseline according to the documented governance logic. |
| 20 | `Lastenheft_Script_Dokumentation.md` | Führt Skript- und Bedienungsdokumentation zusammen. / Aligns script and usage documentation. |
| 21 | `Lastenheft_PowerShell_Cmdlets.md` | Prüft PowerShell-Cmdlet-Konventionen und Windows-Parität. / Reviews PowerShell cmdlet conventions and Windows parity. |
| 22 | `Lastenheft_agentische-umgebung-pruefen-und-syncen.md` | Prüft und synchronisiert die agentische Level-0-/Level-1-/Level-2-Umgebung. / Reviews and synchronizes the agentic Level-0/Level-1/Level-2 environment. |

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
