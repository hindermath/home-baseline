# Statistik-Fortschreibung und PR / Statistics refresh and PR

## Auftrag und Quellen / Authority and sources

2026-09-18: ausdruecklicher Auftrag zur Fortschreibung der Pilotmessung und
der bestehenden Statistik sowie PR-Vorbereitung. Kein Mergeauftrag.
Der [native Nachweis](../maintenance/project-statistics-home-native-proof-v010.md)
bleibt historisch an `af78a4accdaea059728a53e6b113d543e35fb030` gebunden.
Der Snapshot darin misst `e1d6d36e444cc252a0321572e70da8874de81fe3` zum 2026-09-16.
Die neuen Zahlen umfassen auch neue CI-/Dokumentationsdateien. Keine neue
Produktfunktion, Zeitersparnis- oder Produktivitaetsaussage.

Explicit authority covers statistics refresh and PR preparation, not merge.
Historical native evidence retains its original pilot and measurement revisions.
New figures include CI/documentation additions, not new product features or
measured productivity/time savings.

## Vorgehen / Procedure

Inhaltsaenderungen zuerst committen; anschliessend Pilot mit Vorschau und
Stichtag `2026-09-18` rendern, Messartefakte separat committen. Dann die
kanonische Profil-2-Statistik mit Vorschau rendern und separat committen.
Beide Konfigurationen bleiben unveraendert. Status/CheckOnly pruefen den
fertigen Stand ohne Reparatur. Der native Workflow erhaelt einen zusaetzlichen
Status-Gate fuer den aktuellen Checkout; historische Nachweise bleiben getrennt.

Commit authored changes first, preview and render the pilot at cutoff 2026-09-18,
then commit its artifacts. Preview/render and commit the canonical legacy ledger
afterward. Keep both configurations unchanged and verify the final state read-only.
CI separately checks current delivery freshness and historical native evidence.

## Ergebnis / Result

Beide Renderer sind ausgefuehrt, jeweils nach Vorschau auf sauberem Git-Stand.
Quellrevision: `e2767650c263ea0076ec37709e7a2c94d70045ff`.
Pilot-Ausgaben wurden in `04a39bcc`, das Profil-2-Rendering in `183e4cae`
separat committed. Ein nachfolgender reiner Ergebnisnachtrag im ausgeschlossenen
Pilotkontext veraendert diese Eingabeidentitaet nicht.
Both renderers ran after previews on clean trees. Separate output commits bind
the shared authored source above; a result supplement in the excluded pilot
context does not change that measured input identity.

| Kennzahl / Metric | Erster Pilot / first pilot | Lieferpilot / delivery pilot |
| --- | ---: | ---: |
| Stichtag / Cutoff | 2026-09-16 | 2026-09-18 |
| Textdateien / Text files | 3234 | 3236 |
| Textzeilen / Text lines | 696425 | 696778 |
| Aktivtage UTC / UTC active days | 110 | 111 |

Delta: zwei Dateien und 353 Netto-Textzeilen. Die erzeugten Kategorien weisen
152 zusaetzliche Dokumentationszeilen und 201 Konfigurationszeilen aus;
keine Aenderung an Production, Tests oder Scripts. Der vorhandene Profil-2-
Vertrag ergibt denselben Bestand, aber 113 Aktivtage mit Europe/Berlin statt
UTC. Die Aktivtagswerte verschiedener Vertraege/Zeitzonen nicht gleichsetzen.
Referenzmodellrechnungen bleiben im Pilot aus; bisherige Legacy-Referenzen
werden weder entfernt noch als neue Produktivitaetsmessung ausgegeben.

The delta is two files and 353 net text lines: 152 documentation and 201
configuration lines, with Production/Tests/Scripts unchanged. Legacy Profile 2
has the same inventory and 113 Europe/Berlin active days. Do not equate activity
counts across contracts/time zones. Pilot reference estimates remain off;
legacy reference settings stay unchanged and are not new productivity measurements.

| Ausgefuehrte Pruefung / Executed check | Exit | Ergebnis / Result |
| --- | ---: | --- |
| Pilot Bash Update --dry-run / Update, Stichtag 2026-09-18 | 0 / 0 | DRY_RUN / UPDATED |
| Pilot Bash Status | 0 | CURRENT, reproducible=true, current=true |
| Pilot PowerShell Status | 0 | CURRENT, reproducible=true, current=true |
| Profil 2 Bash --dry-run / Rendering | 0 / 0 | DRY_RUN / UPDATED |
| Profil 2 Bash und PowerShell CheckOnly | 0 / 0 | CURRENT |
| Workflow-YAML / eingebettete PowerShell-Analyse | 0 / 0 | Gueltig, keine Error/Warning-Funde / valid, no findings |
| Beide Konfigurationen gegen Auftragseingang `71905fa0` | 0 | Unveraendert / unchanged |

Gebundene Ausgabedateien / Bound output file SHA-256:

- Pilot-Snapshot: `1728809b0b988d68bb7362fd10a8e806b9f1c700fed0da42d5d7c8bd136c8563`
- Pilot-Bericht / report: `4ede4b80b23b2df6056bf81e6de18b602bcfaac04f63299dfc97aaf000d61330`
- Kanonischer Ledger / canonical ledger: `0608b2f1a147873e969ad30e12cc7d899e61dbf74b63241464244e2599693011`

Die neue CI-Pruefung muss auf dem PR-Stand zusaetzlich bestehen. Der alte
native Lauf belegt nicht automatisch diese fortgeschriebenen Messdateien.
PR-URL, aktuelle Check-Ergebnisse und Review-Status werden im PR gepflegt;
keine weiteren Commits allein fuer selbstreferenzielle Head-/Statusangaben.
The new CI gate still needs to pass on the PR candidate. Historical native
success does not automatically cover these refreshed outputs. Keep live PR,
check and review status in the PR, without self-referential status commits.

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`; Owner: Thorsten Hindermann. Zielgruppen: Maintainer,
Lernende und Pruefende. Leserpfad: Pilotuebersicht -> dieser Liefernachweis ->
Messbericht/Snapshot/PR. Quellen: Git-Objekte und unveraenderte Konfigurationen;
Renderer liefern die markierten Ableitungen. ActiveSemantic, DE/EN,
`sourceOnly`, kein Home-Sync. Kein Preset-/Runtime-/Profilwechsel; gemeinsame
Constitution und Agentenregeln bleiben unberuehrt. Wiedervorlage bei neuen
Quellen, Konfigurationen, Messwerten oder CI-Befunden. Feldtestabschluss aller
drei Projekte und zentrale Freigabe sind nicht Teil dieses PR-Schritts.

UpdateRequired; owner Thorsten Hindermann. Bilingual source-only evidence links
overview, measurements and PR. Git and unchanged configurations are authoritative;
renderers maintain generated blocks. No Home sync, runtime, preset or shared-rule
change. Reevaluate on source/configuration/measurement changes or CI findings.
This does not close all project pilots or grant central release acceptance.
