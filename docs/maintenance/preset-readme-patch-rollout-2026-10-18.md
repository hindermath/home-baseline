# Begrenzter 14-Preset-Rollout / Bounded fourteen-preset rollout

Documentation Impact: `UpdateRequired`. Owner: @hindermath.
Datum / Date: 2026-10-18, Europe/Berlin.

## Auftrag und Grenzen / Authority and boundaries

DE: Freigegeben sind Level 0 mit anschliessendem Home Runtime Sync sowie genau
TinyCalc, Show-CommandTui400 und absdd-image-sandbox. Lieferung repositoryweise
per MergeAndSync mit Admin-Bypass nur nach gruenen technischen Checks des exakten
Heads. Technische GSDB-/Evidence-Nachpruefung ist beauftragt; neue Produkt-,
Risiko-, Pilot-, allgemeine Release- oder Zertifizierungsentscheidungen nicht.
Keine Community-Einreichung, weitere Flotte, Toolinstallation oder Spec-Kit-Laeufe.

EN: Authority covers Level 0 followed by Home Runtime sync and exactly three
named consumers. Deliver one repository at a time using exact-head MergeAndSync
with authorized admin bypass only after successful technical gates. Technical
GSDB/evidence revalidation grants no new human/product/risk/release/certification
decision. No community submission, wider fleet, tool installation or feature run.

## Ausgangsstand und Ziel / Baseline and target

PR [#333](https://github.com/hindermath/home-baseline/pull/333) und
[#334](https://github.com/hindermath/home-baseline/pull/334) sind enthalten;
Ausgangscommit ist `c2bf93f874507aa8027f1ff2bf46a8eb7f55a869`.
Fetch bestaetigte sauberes main mit 0/0. Home Runtime war vor Beginn aktuell.
Alle vier Repositories hatten dieselben 14 bisherigen Preset-Versionen.
TinyCalcs fremde ungetrackte Datei `sheet.mcalc.json` bleibt unangetastet.

PRs #333/#334 are included; initial main and Home Runtime were current. All four
repositories had the same previous fourteen versions. Preserve unrelated files
and use a clean worktree where necessary.

Zielmatrix / Target matrix:
`scripts/config/spec-kit-project-statistics-governance-presets.json`.
[Release-, Tag-Commit- und ZIP-Hashes / Release, commit and ZIP bindings](preset-source-lock.json).
[Veroeffentlichungsnachweis / Publication record](preset-readme-patch-releases-2026-10-18.md).
Alle 14 Tags/Commits und heruntergeladenen ZIP-SHA-256 wurden erneut exakt geprueft.
Prioritaeten, Profilname und globales Acht-Preset-Default bleiben unveraendert.

## Level-0-Integration / Level-0 integration

- Installation ueber die zentrale Matrix nach Vorschau und Quellabgleich.
  / Install through the central matrix after preview and source comparison.
- Bash und PowerShell CheckOnly: exakt 14 aktivierte Versionen und Prioritaeten.
  / Both shell checks validate the exact enabled matrix.
- Das bereits akzeptierte Home-only-Overlay `TerminalAwareRunnerAdoption` bleibt
  in genau fuenf Dateien bytegleich gegen den Ausgangscommit erhalten: Runner,
  Manpage, Fixture, PowerShell-Test und Bash-Wrapper unter
  `.specify/presets/autonomous-run-governance/`. Das ist v0.4.5 plus ein explizites
  lokales Overlay, kein Claim bytegleicher Vanilla-Installation. Das Overlay wird
  nicht in die drei Verbraucher kopiert. Herkunft:
  [akzeptierte Reconciliation](../../specs/032-linked-intake-evidence/checklists/preset-v042-analysis-2026-09-10.md).
- Preserve exactly five previously accepted Home-only terminal-adoption files.
  Bind package identity separately from this unchanged local overlay; do not
  promote the project-specific extension into downstream repositories.
- Spec Kit 0.12.8 erzeugte bei der Installation fuer Claude nur einen einzelnen
  Wrapper mit unaufgeloestem `{CORE_TEMPLATE}`. Die drei Claude-Flaechen wurden
  mit dem vorhandenen `CommandRegistrar.register_commands` aus den bereits
  vollstaendig aufgeloesten `.composed/speckit.{specify,plan,tasks}.md`-Quellen
  regeneriert. Keine CLI-, Preset-, Prioritaets- oder Interfaceaenderung.
- Existing generator APIs regenerate the three Claude skills from the resolved
  command stack. The added parity regression rejects unexpanded cores, missing
  wrappers and missing C3A/C5 contracts across all five maintained surfaces.
- Generierte Markdown-Flaechen erhalten LF, Schlussnewline und keinen neuen
  Trailing-Whitespace. Cache bleibt ausgeschlossen. / Normalize generated
  Markdown only; preserve semantics and exclude cache from version control.
- Der Installed-Lock wird erst gegen den Commit mit der tatsaechlichen neuen
  Installation gebunden, nicht nur neu erzeugt, um Tests gruen zu machen.
  / Bind the installed lock to the actual installation commit, not to a failed
  test's desired output.

## Technische Evidence / Technical evidence

Neuer, getrennter Kontext / New separate context:
`docs/security/secure-development/2026-10-18-home-baseline-preset-patch-rollout/`.
Er bindet die tatsaechliche Baseline 3.3.0 und alle kontrollierten Dokumente.
Vier getrennte Reviews und Status werden in beiden Shells ausgefuehrt; rohe
Kontextdatei-Hashes muessen vorher/nachher identisch bleiben.

Historical v0.1.3 contexts are preserved. Their baseline-3.2 hash drift against
current sources was observed before installation and is not a current pass.
The new context proves document identity/integrity and the installation contract,
not implementation of every checklist control or a new ReleaseAccepted decision.
Pilot authorization, project acceptance and general release remain Open.

## Lieferstatus / Delivery status

| Ziel / Target | Stand / State | Naechste Aktion / Next action |
| --- | --- | --- |
| Level 0 | Installierter Kandidat / Installed candidate | Installed-Lock, lokale Gates, PR und exakte Lieferung / Lock, local gates, PR and exact delivery |
| Home Runtime | Noch nicht nach diesem Rollout synchronisiert / Not synced after this rollout | Erst nach Level-0-Merge Vorschau, Sync und Check-only / Preview, sync and check only after Level-0 merge |
| TinyCalc | Noch nicht begonnen / Not started | Sauberer Worktree, Installation und technische GSDB-/Evidence-Nachpruefung / Clean worktree, installation and technical evidence review |
| Show-CommandTui400 | Noch nicht begonnen / Not started | Installation und projektgerechte Regression / Installation and project-appropriate regression |
| absdd-image-sandbox | Noch nicht begonnen / Not started | Sandbox-Regeln, Sitzungsprotokoll, Installation und Nachweise / Sandbox rules, session log, installation and evidence |

Tatsaechliche Befehle, Exitcodes, PR-/Merge-/CI-Links und Synchronisierung werden
im jeweiligen Liefer-PR ergaenzt; der zentrale Abschluss aktualisiert diese Tabelle
nach den drei Verbrauchern. Ein Kandidat oder gruener Teiltest ist keine Lieferung.

Actual commands, exit codes, PR/merge/CI links and synchronization are recorded in
each delivery PR. Central closeout updates this table after the consumers. A
candidate or successful partial test is not delivered work.

[Documentation-Impact-Evidence](preset-readme-patch-rollout-2026-10-18-impact.json).
