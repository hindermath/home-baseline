# Statistik-Rollout v0.1.0: Abschluss / Rollout closeout

## Ergebnis und Abnahme / Outcome and acceptance

Stand: 2026-09-19. Alle sechs in [Issue #302](https://github.com/hindermath/home-baseline/issues/302)
benannten Level-2-Repositories haben den Statistik-Rollout geliefert.
Die erneute lesende Pruefung meldet beide Statistiken je Repository CURRENT,
den neuen Kontext reproduzierbar und Exitcode 0. Alle sechs Default-Branches
sind nach Fetch sauber und lokal/remote 0/0. Die operative Profilzuordnung ist
jeweils `project-statistics-fourteen-governance-presets`; globale Defaults
wurden fuer diesen Abschluss nicht veraendert.

Dieser zentrale Bericht wartet auf eigene fachliche Abnahme und Lieferung.
#302 bleibt bis dahin offen. Die bereits abgenommenen drei Piloten Home Baseline,
TinyCalc und Sandbox werden nicht erneut installiert. Ziel bleibt
**reproduzierbare Projekttransparenz**, nicht gemessene KI-Produktivitaet.

As of 2026-09-19, all six repositories have delivered the rollout. Read-only
checks return CURRENT for both statistics, reproducible for the new context,
and exit 0. Default branches are clean and synchronized after fetching.
This central report still needs separate human acceptance and delivery;
tracking remains open. Existing pilots are not reinstalled.

## Lieferkette und CI / Delivery chain and CI

[Maschinenlesbarer Nachweis](project-statistics-rollout-closeout-v010.json)
bindet volle Head-/Merge-SHAs, Review-Zeitpunkte, Paket-/Snapshot-Hashes und
einzelne Check-/Workflow-URLs. Zahlen sind ein Beobachtungsstand:
PR-Spalte = erfolgreiche / uebersprungene / abgebrochene Jobs;
Merge-Spalte = erfolgreiche / uebersprungene Workflows. Jobs und Workflows
sind unterschiedliche Einheiten; SKIPPED und CANCELLED sind keine Erfolge.

The JSON evidence binds exact revisions, review timestamps, hashes and CI
links. PR counts are successful / skipped / cancelled jobs; merge counts are
successful / skipped workflows. Counts are a dated observation, not equivalent
units or a claim that skipped and cancelled checks passed.

| Repository | Abschluss-PR / Closeout PR | Merge | PR-Jobs | Merge-Workflows |
|---|---|---|---|---|
| TinyPl0 | [PR #98](https://github.com/hindermath/TinyPl0/pull/98) | [fb308e26](https://github.com/hindermath/TinyPl0/commit/fb308e2691b3a101242229604f973fa6f1e31f68) | 36 / 3 / 0 | 9 / 1 |
| InventarWorkerService | [PR #74](https://github.com/hindermath/InventarWorkerService/pull/74) | [0adaae0f](https://github.com/hindermath/InventarWorkerService/commit/0adaae0fa93873a68f10a697d1e3e9c456ece396) | 31 / 2 / 1 | 9 / 1 |
| TuiVision | [PR #186](https://github.com/hindermath/TuiVision/pull/186) | [b8800eb2](https://github.com/hindermath/TuiVision/commit/b8800eb2f32c2a8be82615ad670c2c0a5500e221) | 38 / 2 / 0 | 11 / 0 |
| agent-operations-cockpit | [PR #58](https://github.com/hindermath/agent-operations-cockpit/pull/58) | [fb1b6e6d](https://github.com/hindermath/agent-operations-cockpit/commit/fb1b6e6db4de711361c3acc906a783a85d2fe62e) | 22 / 0 / 0 | 5 / 0 |
| cc65 | [PR #40](https://github.com/hindermath/cc65/pull/40) | [832d3553](https://github.com/hindermath/cc65/commit/832d3553e5b33c76104a3ac5b84c952a032552c6) | 19 / 1 / 0 | 7 / 3 |
| tvision | [PR #22](https://github.com/hindermath/tvision/pull/22) | [48524a80](https://github.com/hindermath/tvision/commit/48524a80a8228002944509580e07146f8c513811) | 36 / 0 / 0 | 5 / 0 |

AOC wurde mit [PR #57](https://github.com/hindermath/agent-operations-cockpit/pull/57)
installiert (Merge `99946d4ea099948e986082ffab9b64f16c350509`).
PR #58 liefert den Dokumentationsnachlauf einschliesslich AEPS-Publikationsstand;
dies ist keine neue AEPS-Promotion. Nicht mit Home Baseline PR #57 verwechseln.

Die Nutzerabnahmen wurden im Arbeitsauftrag ausdruecklich erteilt. Die
verlinkten Owner-Reviews stehen technisch auf COMMENTED, nicht APPROVED.
Bei InventarWorkerService wurde der GitHub-Review-Kommentar nach dem Merge
abgegeben; daraus wird keine vorherige GitHub-Approval behauptet.

AOC installation PR #57 precedes documentation PR #58; publication status
does not grant a new AEPS promotion. User acceptance and GitHub review state
are distinct: recorded owner reviews are COMMENTED. The InventarWorkerService
GitHub review comment postdates its merge.

### Ausnahmen und letzter Abschluss / Exceptions and final completion

- InventarWorkerService: Der zusaetzliche Windows-Native-Proof am PR-Head
  [35443873435](https://github.com/hindermath/InventarWorkerService/actions/runs/35443873435)
  wurde abgebrochen, nicht bestanden. Die projektgebundene Statistik-Pruefung
  [35444408471](https://github.com/hindermath/InventarWorkerService/actions/runs/35444408471)
  am Mergecommit ist dagegen fuer Windows und Linux erfolgreich; sie ruft
  `prove-project-statistics-context.ps1` am exakten Checkout auf.
  Der historische Abbruch wird nicht nachtraeglich umgedeutet.
- Bedingte Claude-/Pages-/Snapshot-Jobs bleiben als SKIPPED sichtbar.
  Spaetere Kommentar-Ereignisse koennen zusaetzliche Skip-Eintraege erzeugen.
- tvision: Alle fuenf Merge-Workflows sind jetzt erfolgreich:
  [Build](https://github.com/hindermath/tvision/actions/runs/35457515307),
  [Statistik](https://github.com/hindermath/tvision/actions/runs/35457515306),
  [Maintenance TUI](https://github.com/hindermath/tvision/actions/runs/35457515357),
  [Homogeneity](https://github.com/hindermath/tvision/actions/runs/35457515378),
  [PowerShell](https://github.com/hindermath/tvision/actions/runs/35457515414).
  [Abschlusskommentar](https://github.com/hindermath/tvision/pull/22#issuecomment-5743887453).

The cancelled additional Windows run remains a limitation of that historical
run. The exact-merge project proof passed on Windows and Linux. Conditional
skips remain visible. All five tvision merge workflows have now succeeded.

## Quellenbindung / Source binding

- Statistik: stabiles v0.1.0, Prioritaet 90, Paketcommit
  `7e824ca8de11212aefdc5b05d7d05637f5343dab`.
  [Tag-ZIP](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/archive/refs/tags/v0.1.0.zip):
  SHA-256 `d8ad7d5eef920f50b629121b64ba8123c22ec4f6dadd14da5cd826d1c50f420a`.
- [Zentrale Matrix](../../scripts/config/spec-kit-project-statistics-governance-presets.json):
  SHA-256 `f71224fc7c6c5e68431a9dfe507e8210f834d70c91f5dc63b85ce9f608fa6617`.
- Assurance v0.1.3, Prioritaet 15: in den ersten vier Repositories erhalten,
  in cc65 und tvision ergaenzt. Dort blieben die vorherigen zwoelf Presets
  erhalten; in den ersten vier die vorherigen dreizehn.
- Je Repository: `docs/maintenance/project-statistics-installation-v010.json`
  am verlinkten Merge bindet Paketdateien und Installation. Der JSON-Nachweis
  dieses Berichts enthaelt den SHA-256 jedes Installationsbelegs und Snapshots.

Statistics v0.1.0 and its unchanged source lock are reused. Assurance is
preserved or added according to the existing profile. No package, tag, release
status or community submission is changed by this closeout.

## Messstand / Measurement snapshot

Neuer Kontext: `docs/project-statistics/config.json`, UTC, 52 Wochen,
Stichtag 2026-09-19, Referenzszenarien ausgeschaltet.
Die bestehende Profil-2-Statistik bleibt kanonisch. Abweichende Aktivtage
durch Zeitzone/Methodik sind kein Beleg fuer Drift. Quellrevisionen liegen vor
generierten Statistik- und Merge-Commits; CURRENT wird separat geprueft.

New contexts use UTC, a 52-week window and cutoff 2026-09-19, with reference
estimates disabled. Existing Profile 2 remains authoritative. Source commits
precede generated output and merge commits; freshness is checked separately.

| Repository | Textdateien / Files | Textzeilen / Lines | Aktivtage / Days | Messquelle / Source |
|---|---:|---:|---:|---|
| TinyPl0 | 2103 | 288814 | 94 | [04af012a](https://github.com/hindermath/TinyPl0/commit/04af012a388cdf437cf52f23ed6e0b3b8751be21) |
| InventarWorkerService | 1235 | 184856 | 125 | [e1a43372](https://github.com/hindermath/InventarWorkerService/commit/e1a433727d6ff2df4ded7960a08724f536b1c619) |
| TuiVision | 3483 | 746233 | 97 | [56d2816d](https://github.com/hindermath/TuiVision/commit/56d2816d6b4d64332894f858eca5fa68706f28dc) |
| agent-operations-cockpit | 1872 | 355214 | 18 | [8193e1ba](https://github.com/hindermath/agent-operations-cockpit/commit/8193e1ba54d6529d13da68d8393296ee164735d9) |
| cc65 | 5093 | 722198 | 120 | [ffc9ea2a](https://github.com/hindermath/cc65/commit/ffc9ea2ae2a6f029ee4cfdebd1e4bb933acf1ac2) |
| tvision | 1390 | 232494 | 28 | [e68d8649](https://github.com/hindermath/tvision/commit/e68d8649ad985d202611e1e2b161eb6193821cb7) |

Diese Werte werden nicht zu einzigartiger Arbeitsleistung aufsummiert:
gemeinsam verwendete Preset-/Governance-Dateien werden mehrfach gezaehlt.
Keine Personenrangliste; keine Aussagen ueber Qualitaet, Sicherheit oder
Lernerfolg aus Zeilen und Commits.

Do not sum these inventories into unique effort: shared governance files occur
in several repositories. They are not productivity, quality or learning scores.

## Pruefungen und Findings / Checks and findings

Die repository-eigenen Rollout-Berichte und CI-Links dokumentieren exakte
14er-Matrix, Paketbindung, Lifecycle in temporaeren Kopien, LF/CRLF/BOM,
Idempotenz und lesenden Status. Dieser Abschluss wiederholt keine schreibenden
Lifecycle-Tests, sondern konsolidiert die gelieferten Nachweise und prueft
Statistikstatus/Git-Synchronisierung erneut.

- InventarWorkerService: Veraltete 13-Preset-Testannahme auf exakte 14er-Matrix
  aktualisiert; keine Abschwaechung von Eindeutigkeit, Version oder Prioritaet.
- AOC und tvision: kanonische Renderer-Korrektur fuer saubere erzeugte
  Leerzeilen uebernommen; Whitespace-Validator bleibt unveraendert streng.
- cc65: Windows-CRLF-Abweichung durch gezielte LF-Bindung der Matrix korrigiert;
  Hashvertrag nicht gelockert. tvision verwendet dieselbe LF-Vorsorge.
- tvision: Init auf schmutzigem Stand blockierte erwartungsgemaess;
  Ausfuehrung danach aus sauberer Arbeitskopie, kein Dirty-Tree-Bypass.
- cc65: Zusaetzliche lokale Produktregression mit `make -j4 bin QUIET=1`,
  `make -j4 libtest QUIET=1` und `make -j4 test QUIET=1` abgeschlossen,
  Exit 0. Isolierte Produktrevision `fa2bd14ae9b067ae9248a1bbca2ccbb8e8b29f05`;
  spaetere Aenderungen betreffen Governance/Statistik.
  [Nachweis](https://github.com/hindermath/cc65/pull/40#issuecomment-5743836318),
  Testlog SHA-256 `21e9796f3aec156cdf3e026588504e8de16823961a2eab4299747f44a173950d`.
- tvision: lokaler Release-Build mit Bibliothek/Beispielen und 39 GoogleTests
  in 12 Suites erfolgreich; kein neuer Produktlauf durch diesen Bericht.

Delivered evidence covers installation, isolated lifecycle, encoding and
read-only checks. Findings were corrected without weakening validators.
The additional cc65 regression completed successfully; tvision product proof
covers its library, examples and 39 tests. These are recorded earlier proofs,
not newly executed product tests in this documentation task.

## Grenzen und naechste Aktion / Boundaries and next action

Alle Projekte dienen primaer Ausbildung und KI-gestuetzten Ausbildungsinhalten.
C/C++-Kompatibilitaetsgrenzen von cc65/tvision bleiben bestehen; die Installation
macht sie nicht zu speichersicheren Produkten. TuiVision (.NET) und tvision
(C++) sind getrennte Projekte. Keine vollstaendige System-I/O-Ueberwachung,
keine neue Pilot-/Produkt-/Releasefreigabe, kein C5-Test und keine Konformitaets-
oder Zertifizierungsentscheidung werden behauptet. Assurance v0.1.3 wird hier
nicht zu ReleaseAccepted oder einem stabilen Release erklaert.

Snapshots bleiben an Stichtag, Konfiguration und Revision gebunden.
CI-Artefakte und lokale Testlogs koennen ablaufen; Commit-Links und Hashes
erhalten die Identitaet, ersetzen aber keine dauerhaft archivierten Logbytes.
Naechste Aktion: zentralen Dokumentations-PR fachlich abnehmen, aktuelle Checks
pruefen, liefern und synchronisieren; erst dann #302 schliessen.

These are training repositories, not production acceptance evidence. No new
release, C5, conformity, certification or assurance acceptance is granted.
Evidence is revision-bound; hashes do not replace retained log files. Accept
and deliver the central documentation PR before closing the tracking issue.

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`; Owner @hindermath. Kanonische Quelle dieses Abschlussstands:
dieser Bericht und sein JSON-Nachweis; technische Wahrheit bleibt in den
verlinkten Projekt-Commits und Workflows. Zielgruppen: Maintainer, Reviewer,
Lehrende und Lernende. Leserpfad: README -> Abschlussbericht -> Projekt-PR /
Messquelle -> Abnahme. Dokumentklasse ActiveSemantic, Deutsch zuerst/Englisch
danach im selben Bericht; README-Sprachpaar synchron. Distribution sourceOnly,
kein Home-Sync. Keine Runtime-/API-/Registry-Aenderung. Statistik-Nachlauf
aus unveraenderter Konfiguration und sauberem Inhaltscommit. Re-Evaluation
bei neuem Rollout, korrigiertem Nachweis, Profil-, Paket- oder Methodikwechsel.

`UpdateRequired`, owner @hindermath. This bilingual source-only report and
JSON consolidate evidence; project commits remain authoritative. README
language partners expose the same reader path. No runtime distribution or
home sync. Refresh statistics from unchanged configuration and a clean content
commit. Reevaluate when rollout, source evidence, package or methodology changes.
