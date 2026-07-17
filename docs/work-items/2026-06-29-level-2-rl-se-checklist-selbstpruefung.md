# Arbeitsnotiz: Level-2-RL-SE-/Checklist-Selbstpruefung als Spec-Kit-Intake vorbereiten

Status: in Umsetzung in Level-0 ueberfuehrt
Quelle: `absdd-image-sandbox`
Quelle-Kontext: Vorbereitung eines spaeteren RL-SE-/CL-Prueflaufs gegen die Secure-Development-Basis
Datum: 2026-06-29

## Anlass

Die Secure-Development-Basis in `docs/secure-development/` ist inzwischen als
generische, auditfaehige Grundlage fuer Richtlinie, Checklisten,
Checklistensammelband, mitgeltende Dokumente und Spec-Kit-Governance-Presets
verfuegbar. Mehrere Level-2-Repositories sollen spaeter nicht nur gehaertet
werden, sondern auch nachvollziehbar gegen diese Basis geprueft werden.

Dieses Workitem haelt dafuer eine wiederverwendbare Arbeitsvorlage fest. Es
startet keinen Spec-Kit-Lauf und aendert kein Zielrepository.

## Ziel

Fuer ein Zielrepository `TARGET_REPO` soll ein spaeterer Spec-Kit-Lauf eine
projektspezifische RL-SE-/Checklist-Selbstpruefung vorbereiten oder ausfuehren.
Der Lauf bewertet die anwendbaren Punkte aus:

- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`
- `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`
- `docs/secure-development/checklisten/CL_01_Standards-Anwendbarkeit.md` bis
  `docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`
- `docs/secure-development/mitgeltende-dokumente/`
- `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`
- die sechs Spec-Kit-Governance-Presets

## Gewuenschtes Ergebnis im Zielrepo

- Ein repo-spezifisches Lastenheft oder eine Feature-Spezifikation fuer die
  RL-SE-/CL-Selbstpruefung.
- Eine Evidenzmatrix mit `Applicable`, `N/A` und `Open`.
- Pro relevantem Pruefpunkt: Begruendung, Evidenzpfad oder Open-Markierung,
  Owner, Follow-up und Re-Evaluation-Trigger.
- Sichtbare Abgrenzung fuer Human-only-Punkte wie formale Freigabe,
  Plattformregeln, QISMS-Eintraege, Secrets, Provider und Modelle.
- Klare Aussage, ob die Secure-Development-Basis im Zielrepo lokal vorhanden
  ist, synchronisiert werden muss oder nur referenziert wird.

## Primaere Bearbeitungsorte im Zielrepo

Je nach Repository-Struktur typischerweise:

- `Lastenheft_Abarbeitungsreihenfolge.md`
- ein neues `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`
- `docs/security/`
- `README.md`
- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`
- `.specify/` und bestehende `specs/`

## Inhaltliche Anforderungen

- Statuslogik immer mit `Applicable`, `N/A` und `Open` fuehren.
- `N/A` nur mit konkreter technischer oder fachlicher Begruendung verwenden.
- `Open` immer mit Owner, Follow-up und Re-Evaluation-Trigger erfassen.
- Security-Anforderungen nicht abschwaechen, sondern projektspezifisch
  einordnen.
- Agentische Entwicklungswerkzeuge von ausgelieferten oder betriebenen
  KI-Komponenten trennen; AI-SBOM bleibt konditional.
- Fuer Ausbildungsrepos Begriffe in alltagstauglicher Sprache erklaeren oder
  auf vorhandene Lern-/Glossarabschnitte verweisen.

## Abgrenzung

- Kein Sammellauf ueber alle Repositories.
- Keine automatische Haertung des Zielrepos.
- Keine formale Freigabe erfinden.
- Keine Repo-Sichtbarkeit aendern.
- Keine Secrets, Provider, Modelle oder Plattformregeln konfigurieren.
- Keine externe PDF- oder Binaerartefakt-Kopie ohne Lizenz- und
  Public-Readiness-Pruefung uebernehmen.

## Kopierbarer Prompt fuer ein Zielrepo

```text
/speckit-specify Nutze das repo-spezifische Lastenheft_RL-SE-Checklist-Selbstpruefung.md als verbindliche Eingabedatei. Erstelle die Feature-Spezifikation fuer eine RL-SE-/Checklist-Selbstpruefung von TARGET_REPO.

Ziel: Pruefe TARGET_REPO gegen die generische Secure-Development-Basis aus docs/secure-development/ beziehungsweise aus dem Level-0-Repo ~/home-baseline-tmp/docs/secure-development/. Beruecksichtige Richtlinie_Sichere-Entwicklung.md, Checklistensammelband_Sichere-Entwicklung.md, CL_01 bis CL_12, mitgeltende Dokumente, Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md und die sieben Governance-Presets.

Erzeuge eine projektspezifische Evidenz- und Anwendbarkeitslogik mit `Applicable`, `N/A` und `Open`. Jeder relevante Pruefpunkt braucht Begruendung, Evidenzpfad oder Open-Markierung, Owner, Follow-up und Re-Evaluation-Trigger. Human-only-Punkte wie formale Freigabe, QISMS-Eintraege, Plattform-Branch-Protection, Secrets, Provider und Modellfreigaben duerfen nicht als erledigt behauptet werden.

Technische Einordnung: Dokumentations-/Governance-Feature. Starte keinen Container-Build, aendere keine Repo-Sichtbarkeit und konfiguriere keine Secrets, Provider oder Modelle.
```

## Validierung fuer spaetere Uebernahme

- Im Zielrepo `git diff --check` ausfuehren.
- Suchlauf auf private Pfade, interne URLs und ueberzogene Freigabe-,
  Provider-, Rechts- oder Public-Release-Claims durchfuehren.
- Pruefen, dass jeder `Open`-Punkt Owner, Follow-up und Re-Evaluation-Trigger
  enthaelt.
- Wenn Compose betroffen ist, im Zielrepo die dort dokumentierte statische
  Compose-Pruefung nutzen.

## Entscheidung

Level-0 soll dieses Workitem als wiederverwendbare Vorlage fuer spaetere
repo-spezifische RL-SE-/Checklist-Selbstpruefungen fuehren. Die konkrete
Abarbeitung erfolgt erst in einem Zielrepo nach ausdruecklichem Start des
jeweiligen Spec-Kit-Laufs.

## Umsetzung / Implementation Note

Dieses Workitem wird in Level 0 ueberfuehrt durch:

- `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`
- `scripts/templates/rl-se-checklist-selbstpruefung-lastenheft.md`
- `scripts/prepare-rl-se-checklist-selbstpruefung.sh`
- `scripts/prepare-rl-se-checklist-selbstpruefung.ps1`

Die Vorbereitung bleibt ein Intake- und Ordnungsworkflow. Sie startet keinen
Spec-Kit-Lauf und befuellt keine projektspezifischen `docs/security/`-Nachweise.
