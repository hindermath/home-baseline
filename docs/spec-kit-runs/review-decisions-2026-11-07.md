# Registerreview: 18 Faelle / Register review: 18 cases

**Belegpruefung / Evidence review:** 2026-11-07  
**Validierung und Lieferung / Validation and delivery:** ab / from 2026-11-08  
**Owner:** Thorsten Hindermann / Statistics Maintainer  
**Auftrag / Authority:** oeffentliche Belegpruefung, Registerfortschreibung,
MergeAndSync nach gruener CI mit Admin-Bypass; danach Profilimport und
Profil-PR-Lieferung. Keine Ausfuehrung fremder Repository-Skripte oder neuer
Feature-Laeufe. / Public evidence review, registry update and delivery after
green CI, followed by profile import and profile PR delivery. No inspected
repository code or new feature runs are executed.

## Ergebnis / Result

Alle sieben Kandidaten haben konkrete, ausgearbeitete Spezifikationen und
erhalten einen Startnachweis. Sechs haben zusaetzlich substanzielle Arbeit;
drei haben einen belegten Feature-Abschluss. Die elf Nachweisaenderungen
werden nach inhaltlichem Vergleich neu gebunden. Keine Wiederaufnahme,
Lieferstufe oder Intake-Archivierung erzeugt einen weiteren Lauf.

*All seven candidates have concrete developed specifications and receive start
evidence. Six additionally have substantive execution evidence; three have
evidenced feature completion. The eleven changed proofs are rebound after
semantic comparison. Resumes, delivery stages and intake archival add no runs.*

| Oeffentliche Summen / Public totals | Vorher / Before | Nachher / After |
|---|---:|---:|
| Gestartet / Started | 94 | 101 |
| Ausgefuehrt / Executed | 94 | 100 |
| Abschluss belegt / Completion evidenced | 93 | 96 |
| Autonom seriell / Serial autonomous | 52 | 54 |
| Nicht eindeutig belegt / Unknown mode | 42 | 46 |

Manuell, autonom parallel und gemischt bleiben oeffentlich jeweils null.
Die privaten Summen bleiben bytegleich: 24/24/0, alle 24 ausgefuehrten Laeufe
parallel, Datenstand 1. November. Gemeinsam ergeben sich 125/124/96. Das sind
belegte Feature-Laeufe, keine Arbeitszeit-, Qualitaets- oder Compliance-Messung.

*Public manual, parallel and mixed counts remain zero. Private totals remain
byte-identical at 24/24/0, all 24 executed runs parallel, dated 1 November.
Combined totals are 125/124/96. These are evidenced feature runs, not a measure
of time, quality or compliance.*

## Sieben neue Entscheidungen / Seven new decisions

Die Tabellenwerte sind Start/Ausfuehrung/Abschluss, wobei 1 einen belegten
Status bedeutet. Tasks sind Hilfsbelege; eine einzelne Checkbox oder ein
Merge allein erteilt keine Produktabnahme.

*Values are start/execution/completion; 1 means evidenced. Tasks are supporting
proofs; a checkbox or merge alone does not grant product acceptance.*

| Repository / Feature | Status | Tasks erledigt/gesamt / done/total | Modus / Mode | Entscheidung / Decision |
|---|---|---:|---|---|
| agent-operations-cockpit 004 | 1/1/1 | 57/57 | seriell / serial | Completed-Run, Tasks-Hash und kausaler Closeout; Liefer-PR 53 unabhaengig bestaetigt. / Completed run, task hash and causal closeout; delivery PR 53 independently verified. |
| TuiVision 047 | 1/1/1 | 58/58 | seriell / serial | Audit und Lieferung abgeschlossen; offene Audit-Findings sind Ergebnisse, keine fehlenden Audit-Tasks. / Audit and delivery complete; open findings are audit outputs. |
| TinyCalc 006 | 1/1/1 | 83/83 | unbekannt / unknown | Produktlieferung PR 104 plus spaeterer autorisierter Verwaltungsabschluss, einschliesslich T082. Historische Stop-Passagen nicht als aktuellen Stand lesen. / Product PR 104 plus later authorised administrative closure; preserve dated cutoffs. |
| TinyCalc 007 | 1/0/0 | 0/60 | unbekannt / unknown | Spezifikation/Clarify/Planung belegt; keine Umsetzungsfreigabe oder ausgefuehrte Implementierung. / Specified and clarified; implementation not authorised or evidenced. |
| absdd-image-sandbox 004 | 1/1/0 | 52/80 | unbekannt / unknown | Substanzielle Code-/Test-/Nachweisarbeit; finaler Freeze/Coverage und unabhaengige Uebergabe offen. / Substantive implementation; final freeze/coverage and independent handoff open. |
| Show-CommandTui400 001 | 1/1/0 | 45/67 | unbekannt / unknown | Prozess-/Skript-/Migrationsarbeit und begrenzter Mac-Pilot belegt; vollstaendige LH00-Abnahme offen. / Process/script/migration work and bounded Mac pilot; full LH00 acceptance open. |
| Show-CommandTui400 002 | 1/1/0 | 53/65 | unbekannt / unknown | TUI-/Session-/Testarbeit bis T053; T054 teilweise, Zielhostlaeufe und anderes Ergebnisreview fehlen. / TUI/session/test work through T053; T054 partial, target-host runs and distinct review missing. |

Fuer die unbekannten Modi existiert kein ausreichend gepruefter positiver
Modusbeleg. Fehlende Autonomie-Dateien beweisen keine manuelle Ausfuehrung;
Parallelmarker in Tasks beweisen keine Kampagne. Fuer Cockpit 004 und
TuiVision 047 sind autonome Feature-Run-States gebunden. Das vollstaendige
oeffentliche Quelleninventar an den unten gepinnten Commits enthaelt keine
ausgefuehrte parallele Kampagnenzuordnung fuer diese Feature-/Run-Identitaeten.

*Unknown modes lack affirmative reviewed mode evidence. Missing autonomous
files do not prove manual execution; task parallelism does not prove a
campaign. Cockpit 004 and TuiVision 047 have bound autonomous feature states;
their pinned source inventories contain no executed parallel campaign
assignment for these feature/run identities.*

## Elf geaenderte Nachweise / Eleven changed proofs

| Faelle / Cases | Vergleich / Comparison | Registerentscheidung / Registry decision |
|---|---|---|
| home-baseline 029 | Neue FR-022 fordert unabhaengige Primary-Evidence. / New independent Primary-evidence requirement. | Aktuelle Spec als Startnachweis binden; historischer 93-Task-Abschluss bleibt an seiner alten Abnahmegrenze. Keine neue Primary/Pass-Behauptung. / Rebind start proof; retain historical closure, no new Primary/Pass claim. |
| home-baseline 030 | Neue SBR-025/026: nicht implementierte Executor-Aktionen blockieren und Primary-Herkunft unabhaengig pruefen. / New fail-closed executor and evidence boundaries. | Spec neu binden; Run bleibt Active, 171/194 Tasks, finalValidation und postMergeActions Pending; completed=false. / Rebind spec; completion remains false. |
| home-baseline 031 | Neue CRG-019 bis CRG-022: Read-only, Branch-Scope, Single-use Gate und Primary-Evidence. / New authority and evidence requirements. | Aktuelle Spec als Startnachweis binden; historischer 168-Task-Abschluss bleibt historisch, keine Erfuellung spaeterer Sicherheitsanforderungen behaupten. / Rebind start proof; no retrospective claim for later requirements. |
| TuiVision 037, 038, 039, 040, 041, 042, 043, 044 | Ausschliesslich acceptedArtifacts-Pfad active → archive; alle anderen State-Felder unveraendert. Acht archivierte Intakes separat geladen; ihre SHA-256-Werte sind identisch. / Archive-only relocation; all other state fields unchanged and eight archived contents independently hash-verified. | State-Proofs einschliesslich Modus an aktuellen Commit binden; doppelte State-Proofs zusammenfassen. Run-IDs, Abschluss und Anzahl unveraendert. / Rebind and deduplicate state proofs; no recount. |

Die historischen Abschluesse von 029 und 031 sind keine Aussage, dass alle
spaeter hinzugefuegten Sicherheits-/Primary-Pflichten erledigt sind. Die
Statistik prueft belegte Feature-Lieferungen, keine heutige universelle
Produkt- oder Sicherheitsabnahme. 030 benoetigt weiterhin die tatsaechlichen
operativen Executor-, Plattform-, finalen Validierungs- und Handoff-Nachweise.

*Historical completion of 029 and 031 does not discharge later security or
Primary obligations. Run statistics do not establish present universal product
or security acceptance. Feature 030 still needs actual executor, platform,
final-validation and handoff evidence.*

## Gepinnte Quellen / Pinned sources

Die [maschinenlesbaren Entscheidungen](review-decisions-2026-11-07.json)
enthalten fuer alle 18 Faelle alte und neue Proof-Referenzen, SHA-256,
Taskzahlen, Status, Modus, Begruendung sowie die acht Archivverifikationen.
Das [Register](registry.json) ist die fachliche Quelle; der neu erhobene
[Snapshot](snapshot.json) bindet genau diese Entscheidungen. In den genannten
Repositories wurde nur gelesen; keine dortigen Builds, Agenten oder Container
wurden gestartet.

*The machine-readable decisions retain old/new proof refs and hashes, task
counts, classifications, reasons and archive verification for all 18 cases.
The register is authoritative; the collected snapshot binds its decisions.
Inspected repositories were read only; no builds, agents or containers ran.*

- home-baseline: `38d70258dd3d1ff14a3a402ca5210129c10e0958`.
- agent-operations-cockpit: `1d812605b78eff2b3e4e0303e8aa570b768756ba`;
  [PR 53](https://github.com/hindermath/agent-operations-cockpit/pull/53),
  Merge `7e53a8b327410ba241d90a9c60bc286b16f7bc44`.
- TinyCalc: `14f47971026c4172f5e05e0d18863b2a95bfff4b`;
  [PR 104](https://github.com/hindermath/TinyCalc/pull/104),
  Merge `946e392151fcaba5db0d76cf2974e055ba616e66`.
- TuiVision: `9cd09387c44c1d1e7c929a26f555c269a40dd75e`;
  [PR 180](https://github.com/hindermath/TuiVision/pull/180),
  Merge `18f3387a3c9edbf9a3f133e5ffd3b3dca0c13e84`.
- absdd-image-sandbox: `9d8338a7c39c1e2a0175667f59681e7c06b6921f`.
- Show-CommandTui400: `1a9ae46177649c4b6c6d51457393928929c59a00`.

## Nachpruefung und Lieferung / Verification and delivery

Nach der semantischen Pruefung folgen Register-/Snapshot-/Privatsummen-
Validierung, die bestehende Statistik-Fixture-Suite, DE/EN-Renderer,
Warteschlangen- und README-Abgrenzung sowie Profil-2-Driftchecks. Native
PR-CI muss am exakten Liefer-Head gruen sein. Danach Level 0 mergen, Home
synchronisieren und Branch bereinigen. Anschliessend den vorhandenen
Profil-Workflow manuell starten, dessen eigenen PR samt unveraendertem MOTD
pruefen und erst nach gruener Profil-CI mergen und bereinigen.

*Validate register/snapshot/private totals, existing fixtures, bilingual
rendering, queue/README boundaries and Profile 2. Require exact-head native
CI before Level-0 merge/sync/cleanup. Then dispatch the existing profile
workflow, verify its separate PR and preserved MOTD, require green profile
CI and merge/clean up.*

Dokumentationsauswirkung, Quellen, Owner, Leserpfade und Distribution sind im
[Impact-Nachweis](review-decisions-2026-11-07-impact.json) gebunden.
*The impact record binds documentation decisions, ownership, reader paths,
sources and distribution.*
