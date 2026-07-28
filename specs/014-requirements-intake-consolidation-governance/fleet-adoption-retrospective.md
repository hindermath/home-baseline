# Fleet Adoption Retrospective / Retrospektive der Flottenübernahme

## Ergebnis / Result

`PresetFollowUp`

Die Übernahme des Schema-2-Vertrags in die 26 nach dem ursprünglichen
Feature-Lauf noch nicht fachlich migrierten Repositories war erfolgreich. Alle
vorhandenen Intake-Inhalte und Produktdateien blieben unverändert. Sechs
Repositories ohne aktive Intake-Reihe verwenden jetzt den expliziten Zustand
`Idle`; 20 Repositories besitzen weiterhin ihre nachgewiesene aktive Reihe.

*The adoption of the schema-2 contract by the 26 repositories not yet
professionally migrated after the original feature run succeeded. All existing
intake content and product files remained unchanged. Six repositories without
an active intake series now use the explicit `Idle` state; 20 repositories
retain their evidenced active series.*

## Wiederverwendbare Erkenntnisse / Reusable Learning

Der Feldlauf reproduzierte zwei providerneutrale Lücken im Sequencing-Preset:

1. Ein korrekt initialisiertes Repository ohne aktive Intakes benötigte einen
   ausdrücklichen, streng leeren `Idle`-Zustand.
2. Die Index-Eindeutigkeitsprüfung eines Eltern-Repositories durfte
   `Pflichtenheft.md`-Dateien in eigenständigen verschachtelten Git-Repositories
   nicht als Duplikate zählen.

Die kleinsten portablen Korrekturen wurden als
`intake-sequencing-governance` v0.2.1 und v0.2.2 veröffentlicht. Positive und
negative Bash-/PowerShell-Fixtures belegen beide Grenzen.

*The field run reproduced two provider-neutral gaps in the sequencing preset:
an initialized repository without active intakes needed an explicit and
strictly empty `Idle` state, and a parent repository's index uniqueness check
had to exclude independently owned nested Git repositories. The smallest
portable fixes were released as v0.2.1 and v0.2.2 with positive and negative
Bash and PowerShell fixtures.*

## Remote-Grenze / Remote Boundary

GitHub Actions lehnte sämtliche Jobs der 26 PRs vor dem ersten Step ab. Lokale
Exact-Head-Prüfungen bestanden, kein PR besaß einen umsetzbaren Review-Thread,
und der genehmigte enge Admin-Bypass wurde nur für das verbleibende
Human-Approval-Gate eingesetzt. Der Provider-Ausfall wurde nicht als
technischer Erfolg umgedeutet.

*GitHub Actions rejected every job for the 26 pull requests before its first
step. Local exact-head checks passed, no pull request had an actionable review
thread, and the approved narrow Admin bypass was used only for the remaining
Human Approval gate. The provider failure was not reclassified as a technical
success.*

## Abschluss / Closeout

- Migrierte Repositories: `26/26`
- Aktive Reihen / Active series: `20`
- Leere Reihen / Idle series: `6`
- Veränderte bestehende Intakes: `0`
- Veränderte Produktdateien: `0`
- Pull Requests: `26/26` gemergt / merged
- Lokale Synchronisierung: `26/26` exakt / exact
- Preset-Endstand: `intake-sequencing-governance` v0.2.2
- Flottenprofile auf v0.2.2: `32/32`
- Ursprüngliche Pilotinstallationen auf v0.2.2: `6/6`
- Weiterer Feature-Lauf gestartet: nein / no
