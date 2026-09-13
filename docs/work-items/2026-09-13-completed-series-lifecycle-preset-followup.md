# Workitem: Lifecycle-Regel für abgeschlossene Intake-Serien / Completed Intake-Series Lifecycle Rule

- Status: offen / open
- Owner: Maintainer von `intake-authoring-governance`,
  `intake-review-governance` und `intake-sequencing-governance`
- Datum / Date: 2026-09-13
- Ursprung / Origin: TuiVision-Serie `tui-vision-delivery`
- Entscheidung / Decision: `Promote`
- Dokumentationsauswirkung / Documentation impact: `FollowUp`

## Anlass / Motivation

Die TuiVision-Serie war mit zehn abgeschlossenen Features und null
ausführbaren Zielen als `Completed` gekennzeichnet. Acht zugehörige Intakes
lagen jedoch weiterhin ohne Feature-Suffix in der aktiven Sammlung. Nur die
beiden zuletzt gelieferten Intakes waren bereits korrekt archiviert. Die drei
installierten Konfigurationsvalidatoren akzeptierten diese widersprüchliche
Zuordnung, weil sie den Status der Serienmitglieder nicht gegen deren
konfigurierte Sammlung prüften.

*The TuiVision series was marked `Completed` with ten completed features and
no executable targets. Eight associated intakes still remained in the active
collection without their feature suffix, while only the two latest intakes
had been archived correctly. All three installed configuration validators
accepted this inconsistent mapping because they did not check each series
member's lifecycle status against its configured collection.*

## Feldnachweis / Field Evidence

| Feld / Field | Wert / Value |
|---|---|
| Repository | `hindermath/TuiVision` |
| Ausgangs-Head / Baseline head | `5c2c3c301afa8c9cbdba24687294e7d53ed7e417` |
| Korrekturbranch / Correction branch | `codex/completed-intake-archive-reconciliation` |
| Pull Request | `hindermath/TuiVision#175` |
| Geprüfter Head / Reviewed head | `d7cd2c63bc0d8925104a6a7bd0c6aadb27b1fc5f` |
| Merge-Commit | `94d2d9f3ea5d079b8df1cc5bc112c2bfb807419b` |
| Serie / Series | `a73dda7c-163b-4530-97f2-fd9eea5e8986`, `tui-vision-delivery` |
| Zielmenge / Target set | Features `037` bis `046`, zehnmal `Completed` |
| Ausgangsbefund / Initial finding | acht `Completed`-Ziele unter `active`, zwei unter `archive` |
| Zielzustand / Target state | zehn `Completed`-Ziele unter `archive`, null aktive oder `Eligible`-Serienziele |
| Installierte Versionen / Installed versions | Authoring `0.3.1`, Review `0.2.1`, Sequencing `0.2.3` |
| Projektnachweis / Project proof | `scripts/validate-requirements-intake-alignment.mjs` und `scripts/tests/requirements-intake-alignment-tests.mjs` |
| Preset-Nachweis / Preset proof | die drei installierten `validate-intake-governance-config.py` plus Cross-Shell-Fixtures |

Der korrigierte Manifest-Kandidat hat den normalisierten SHA-256
`268a3d3e37e279127f0fcfc099e7761df0443dc4c9625392a70441c619bdf894`.
Der read-only Statuslauf ergab in allen drei Presets sowie für Manifest und
Series-Receipt unter Bash und PowerShell bytegleiche JSON-Ausgaben. Der letzte
zusammengefasste Evidence- und Git-Status-Hash blieb vor und nach der Prüfung
`45e2fde80422c8bef5eabf1fb39e5c3d9727345bfd91f998d2153a7a310e7667`.
Die projektspezifische Suite bestand vier Positiv- und 18 Negativfälle; alle
drei Preset-Suiten bestanden ihre positiven und negativen Fälle über beide
öffentlichen Shell-Wrapper.

Am exakten PR-Head waren 36 technische Checks erfolgreich; der ausschließlich
für `main` vorgesehene DocFX-Deploy wurde erwartungsgemäß übersprungen. Es gab
null Review-Threads. Der Copilot-Dienst lieferte auf einem älteren Head einen
Fehler statt eines Reviews und blieb deshalb als fehlender Review dokumentiert.
Der normale Merge scheiterte ausschließlich an der Human-Approval-Regel. Der
zuvor ausdrücklich begrenzt autorisierte Admin-Bypass wurde erst nach grünen
technischen Gates und der Prüfung auf umsetzbare Threads verwendet.

*The corrected manifest candidate has normalized SHA-256
`268a3d3e37e279127f0fcfc099e7761df0443dc4c9625392a70441c619bdf894`.
All three preset validators plus the manifest and series-receipt validators
produced byte-identical JSON through Bash and PowerShell. The combined evidence
and Git-status hash remained unchanged at
`45e2fde80422c8bef5eabf1fb39e5c3d9727345bfd91f998d2153a7a310e7667`
before and after status inspection. The project suite passed four positive and
18 negative cases, and all three preset
suites exercised their positive and negative cases through both public shell
wrappers. On the exact reviewed head, 36 technical checks passed, the
main-only DocFX deployment was skipped as expected, and no review thread
existed. Copilot returned a service error on an older head and therefore
remained recorded as a missing review. The narrowly authorized admin bypass was
used only after the ordinary merge was blocked solely by the human-approval
rule.*

Die lokale Korrektur verschiebt die acht Dateien nach
`requirements/intakes/archive/`, versieht sie mit den Feature-Suffixen
`.037-*` bis `.044-*` und aktualisiert Manifest, Roots, Abhängigkeiten,
Series-Receipt, Operation, Review-Evidence, Run-State-Pfade und die
menschenlesbaren Reihenfolgen atomisch. Der Projektvalidator verwendet danach
eine exakte Fixture statt fest eingebauter aktiver TuiVision-Pfade.

*The local correction moves the eight files to the archive, adds feature
suffixes `.037-*` through `.044-*`, and atomically updates the manifest,
roots, dependencies, series receipt, operation, review evidence, run-state
paths, and human-readable order views. The project validator then uses an
exact fixture instead of hard-coded active TuiVision paths.*

## Providerneutrale Zielregel / Provider-Neutral Target Rule

1. Ein `Completed`-Serienmitglied muss unter der konfigurierten
   Archivsammlung liegen.
2. Ein nicht abgeschlossenes ausführbares Serienmitglied muss unter der
   konfigurierten aktiven Sammlung liegen.
3. Backlog- und History-Pfade dürfen nicht still als ausführbare
   Serienmitglieder gelten.
4. Eine aktive Serie darf archivierte `Completed`-Vorgänger und aktive
   Folgezustände gemeinsam enthalten.
5. Eine abgeschlossene Serie darf ihre vollständig abgeschlossenen Mitglieder
   im Manifest behalten und muss genau null `Eligible`-Ziele besitzen.
6. `activeIntakeCount` zählt die physische aktive Sammlung. Die Anzahl aktiver
   Serienziele ist davon getrennt, damit eigenständige, noch nicht in die
   Serie aufgenommene Intakes zulässig bleiben.
7. Ein unveränderliches Authoring-Receipt darf nach späterer Serienaufnahme
   weiterhin seine ursprüngliche Standalone-Bindung `N/A` tragen. Sein
   verschwundener aktiver Zielpfad ist nur dann gültig, wenn Manifest, Name
   und normalisierter Hash genau einen abgeschlossenen Archivnachfolger
   ergeben. Eine fremde Serienbindung bleibt ungültig.

*Completed members belong to the configured archive collection, while
non-completed executable members belong to the active collection. Active
series may combine archived predecessors with active follow-up members. A
completed series retains all completed members but exposes no eligible target.
Physical active inventory and active series membership are separate counts.
An immutable standalone authoring receipt may remain standalone after later
series adoption only when the current manifest, normalized hash, and target
name identify exactly one completed archive successor; a foreign series claim
must fail.*

## Reproduzierbare Tests / Reproducible Tests

Positive Fälle:

- aktive Serie mit einem archivierten `Completed`-Mitglied und einem aktiven
  `Eligible`-Mitglied;
- abgeschlossene Serie mit ausschließlich archivierten `Completed`-Mitgliedern
  und null `Eligible`-Zielen;
- abgeschlossene Serie ohne physisch vorhandenes, leeres aktives Verzeichnis;
- eigenständiger aktiver Intake außerhalb der Serie mit gültigem Receipt;
- historisches Standalone-Receipt mit genau einem hashgleichen archivierten
  Seriennachfolger.

Negative Fälle:

- `Completed`-Mitglied in der aktiven Sammlung;
- `Eligible`, `Pending` oder `Blocked` in der Archivsammlung;
- abgeschlossene Serie mit `Eligible`- oder nicht abgeschlossenem Mitglied;
- Serienziel in Backlog oder History;
- fehlender, doppelter oder hashabweichender Archivnachfolger;
- historisches Receipt mit einer fremden Serien-ID.

Alle Konfigurationsfälle müssen über die öffentlichen Bash- und
PowerShell-Wrapper denselben Exitcode und dieselbe Fehlerklasse liefern.
Direktes Testen nur der gemeinsamen Python-Engine reicht für den
Cross-Platform-Nachweis nicht aus.

*Every configuration fixture must run through both public Bash and PowerShell
wrappers and produce equivalent exit codes and finding classes. Testing only
the shared Python engine is insufficient for cross-platform evidence.*

## Preset-Zuschnitt / Preset Scope

`Promote`:

- Status-zu-Collection-Prüfung in allen drei Governance-Presets;
- abgeschlossene Serien mit erhaltenen archivierten Mitgliedern und null
  `Eligible`-Zielen;
- getrennte Zählung physischer aktiver Intakes und aktiver Serienziele;
- positive und negative Cross-Shell-Fixtures;
- Runbook-, Checklist-, Agent- und Manpage-Hinweise zur Lifecycle-Regel.

`RejectProjectSpecific`:

- TuiVision-Dateinamen, Feature-Nummern `037` bis `046`, zehn Ziele, fünf
  Roots, sechs Abhängigkeiten und 38 Archivdateien;
- lokale Renderer-, Review- und Run-State-Pfade;
- TuiVision-spezifische Exact-Fixture und Versionszählung.

## Berechtigungs- und Sicherheitsgrenze / Permission and Safety Boundary

Dieses Workitem autorisiert keine Preset-Implementierung, Versionsänderung,
Veröffentlichung, Installation, Flottenverteilung oder Änderung eines
Konsumenten-Repositories. Eine spätere Umsetzung erfolgt in den drei
öffentlichen Preset-Quellrepositories mit eigenem Auftrag. Validatoren bleiben
read-only und dürfen fehlplatzierte Dateien nicht automatisch verschieben.

*This work item authorizes no preset implementation, version change, release,
installation, fleet rollout, or consumer-repository change. A later change
must be implemented in the three public preset source repositories under
separate authority. Validators remain read-only and must not move misplaced
files automatically.*

## Vorgesehene Umsetzung / Intended Implementation

1. Den Defekt in einem temporären deutsch- und englischsprachigen Projekt
   reproduzieren.
2. Die kleinste gemeinsame Lifecycle-Regel in allen drei Preset-Quellen
   implementieren.
3. Bash-/PowerShell-Parität, LF/CRLF, Manifest- und Receipt-Lifecycle sowie
   bestehende Create-, Review- und Sequencing-Fixtures prüfen.
4. Nur bei grüner Parität Patch-Versionen veröffentlichen und versionierte
   ZIP-Dateien validieren.
5. TuiVision und ausgewählte Verbraucher erst mit gesonderter
   Rollout-Autorität aktualisieren.

## Abschlusskriterien / Acceptance Criteria

- Die drei Presets lehnen Status-/Collection-Widersprüche gleich ab.
- Eine vollständig abgeschlossene archivierte Serie mit null `Eligible`
  wird akzeptiert.
- Eine laufende Serie mit archivierten Vorgängern bleibt darstellbar.
- Eigenständige aktive Intakes außerhalb der Serie bleiben zulässig.
- Cross-Shell-Fixtures beweisen positive und negative Fälle.
- Keine projektspezifische Kardinalität oder TuiVision-Pfadannahme gelangt in
  ein Preset.

Dokumentationsklasse ist `sourceOnly`; ein Home-Sync ist für dieses Workitem
nicht erforderlich. Wiedervorlage erfolgt vor der nächsten Änderung an einem
der drei Intake-Governance-Presets.

*This is source-only documentation and requires no Home sync. Re-evaluate it
before the next change to any of the three intake-governance presets.*
