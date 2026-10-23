# Begrenzter stabiler Preset-Rollout / Bounded stable preset rollout

Owner: @hindermath. Documentation Impact: `UpdateRequired`.
Status: Level-0-Arbeitskandidat; fachliche Sichtung des Rollout-PRs steht aus.

## Auftrag und nächster sicherer Schritt / Authority and next safe step

DE: Die beauftragte Reihenfolge ist Level 0, Host Home Runtime, TinyCalc,
absdd-image-sandbox und Show-CommandTui400. Vor jedem Merge wird der konkrete
Rollout-Head fachlich gesichtet. Erst nach grüner Merge-CI folgt das nächste
Ziel. Die Paketfreigaben ersetzen diese Sichtung nicht. Aktuell wird nur der
Level-0-Kandidat vorbereitet; kein Home-Sync und keine Pilotinstallation.

EN: Deliver Level 0, host Home Runtime, TinyCalc, absdd-image-sandbox and
Show-CommandTui400 in that order. Each rollout head requires human review;
only successful merge CI unlocks the next target. Package-source approval
does not replace rollout review. Only the Level-0 candidate is being prepared;
no Home sync or pilot installation has occurred in this rollout.

Keine Modellaufrufe, Produktläufe, Toolchain-Wartung, Community-Einreichung
oder weitere Flotte. Persönliche Routing-Profile bleiben unverändert. Die
abgebrochene Routing-Neuentwicklung bleibt ausgeschlossen. / No model calls,
product runs, toolchain maintenance, catalog submissions or wider fleet.
Personal routing profiles and the cancelled dynamic-routing work stay out.

## Verbindliche Quellen / Authoritative sources

- [Veröffentlichungen und Paketnachweise / Releases and package evidence](preset-documentation-patch-releases-2026-10-23.md)
- [Tag-, Commit- und Archivbindungen / Tag, commit and archive bindings](preset-source-lock.json)
- [Explizites 14er-Profil / Explicit fourteen-preset profile](../../scripts/config/spec-kit-project-statistics-governance-presets.json)
- [Geprüfte Installationsbindung / Verified installed-state binding](preset-installed-lock.json)
- [Installation, Vorgänger und lokale Prüfungen / Installation, predecessors and local checks](stable-preset-rollout-2026-10-24-installation.json)
- [Dokumentationsauswirkung / Documentation impact](stable-preset-rollout-2026-10-24-impact.json)

Ausgangspunkt / Starting commit: `d98983568d6ac234dbecb50c2fee0873e83804a4`.
Alle 14 regulären Releases, Remote-Tags und erneut geladenen ZIP-SHA-256
stimmen mit dem Veröffentlichungsnachweis überein. Profile 8 bis 14 erhalten
dieselben neuen Paketbindungen; Namen, Prioritäten und Acht-Preset-Default
bleiben unverändert. Das 14er-Profil wird ausdrücklich ausgewählt.

All fourteen regular releases, remote tags and freshly downloaded ZIP hashes
match the publication evidence. Profiles eight through fourteen receive the
same new bindings; names, priorities and the eight-preset default do not change.
The fourteen-preset profile remains an explicit selection.

## Level-0-Installation / Level-0 installation

Nach Bash-Dry-Run und PowerShell-WhatIf wurden ausschließlich die 14 gebundenen
Pakete installiert. 599 Paketdateien stimmen nach der bestehenden Markdown-
Whitespace-Normalisierung mit den ZIPs überein. Die fünf ausdrücklich
erhaltenen Home-only-Dateien sind bytegleich mit dem Ausgangsstand: Runner,
Manpage, Fixture sowie Bash-/PowerShell-Routingtests unter
`.specify/presets/autonomous-run-governance/`. Sie werden nicht in Piloten kopiert.

Only the fourteen bound packages were installed after both previews. After
the existing Markdown whitespace normalization, 599 package files match the
ZIPs. The five accepted Home-only runner/manpage/fixture/routing-test files
retain their original bytes and must not propagate to pilots.

Der Installed-Lock bindet zusätzlich die drei erzeugten `.composed`-Dateien:
insgesamt 607 installierte Dateien. Preset-Caches bleiben ausgeschlossen.
The installed-state lock additionally binds the three generated `.composed`
files, for 607 installed files in total. Preset caches remain excluded.

Spec Kit 0.12.8 erzeugte bei Claude drei unvollständige Wrapper. Der vorhandene
`CommandRegistrar` hat Specify, Plan und Tasks aus den vollständig aufgelösten
Security-`.composed`-Dateien erneut erzeugt. Keine CLI-, Command-Quell- oder
Validatoränderung. Der zentrale Statistik-Profiltest bindet weiterhin exakt
eine Version: jetzt das beauftragte v0.1.2 statt v0.1.1.

Spec Kit 0.12.8 generated three incomplete Claude wrappers. Its existing
`CommandRegistrar` re-rendered Specify, Plan and Tasks from the complete
Security `.composed` files. No CLI, command source or validator was patched.
The central statistics-profile test still pins exactly one authorized version,
now v0.1.2 instead of v0.1.1.

## Prüfnachweise / Verification evidence

- Exakte aktive Matrix: Bash und PowerShell `CheckOnly` erfolgreich.
- 604 Archivdateien: 599 Paketdateien geprüft, fünf Home-only-Ausnahmen bytegleich.
- Gemeinsamer stabiler Routing-/Dokumentationsvertrag: 238 Assertions und
  vollständige 49 Command-Deklarationen erfolgreich; keine Modellaufrufe.
- Assurance-Dokumentationsprüfung: 68 Assertions erfolgreich.
- Alle 14 installierten Dokumentationsregressionen erfolgreich.
- Alle neun Agenten-Paritätstests einschließlich Installed-Lock erfolgreich.
- Routing-Discovery-, Intake-Review-, Sequencing- und Parallel-Koordinator-
  Fixtures erfolgreich. Ausschließlich temporäre lokale Zustände.
- PSScriptAnalyzer erfolgreich; Secret-Scan: keine hohen Befunde. Der bekannte
  mittlere Hinweis betrifft private Claude-Einstellungen, die nicht geliefert werden.
- Skriptreferenz neu erzeugt und in Bash/PowerShell driftfrei geprüft:
  152 kanonische und 130 eingebettete Skripte.
- Home-only-Overlay: je 18 Szenarien unter Bash und PowerShell erfolgreich;
  ausschließlich lokale Fixtures, keine Modell- oder Provideraufrufe.
- Assurance-Mindestkombination: 44 Assertions gegen Routing v0.1.5 und
  Autonomous v0.4.5 erfolgreich. Dieser veröffentlichte Test verlangt genau
  diese alten Versionsmetadaten. Ein Aufruf mit den neuen Versionen wurde
  erwartungsgemäß zurückgewiesen und nicht als Pass gezählt. Die kanonischen
  Routing-/Autonomous-Skripte sind zwischen den jeweiligen alten und neuen
  Tags unverändert; neue Command-Abdeckung wird oben separat geprüft.
- Neuer [technischer Assurance-Kontext](../security/secure-development/2026-10-24-home-baseline-stable-preset-rollout/evidence-matrix.md):
  Status und vier getrennte Gates in beiden Shells erfolgreich. Alle zehn
  Prüfungen erhalten denselben Rohbyte-Evidence-Digest; siehe
  [Read-only-Prüfnachweis](stable-preset-rollout-2026-10-24-gates.json).
- Unveränderte GSDB-3.4.4-Manifestbindung und 30 darin separat gebundene
  Dokumente hashgeprüft. Historische Evidence bleibt unverändert.
- Vollständiger Quellen-/Profiltest erfolgreich: 14 Tag-/Commit-/ZIP-Bindungen,
  alle Profile 8 bis 14, gemeinsame Intake-Konfiguration, sechs Architektur-
  Vertragstests, Assurance mit 47 neu gebundenen Metadaten-Negativfällen je
  Shell und Statistik-Lifecycle im Wegwerfprojekt (Installation, Resolve,
  Disable/Enable, Remove und erneute Installation).
- Authoring-Validator samt Normalisierung, Negativfällen und Command-Grenzen
  erfolgreich. `preset list`, alle 14 `preset info`, relevante Resolve-Aufrufe
  und `specify check` erfolgreich. Noch kein nativer CI-Pass des PRs behauptet.

The exact matrix passed in both shells. Archive verification covers 599 files
plus five byte-preserved overlay files. The combined stable routing/document
contract passed 238 assertions covering all 49 declarations. Assurance document
checks passed 68 assertions. The unchanged GSDB 3.4.4 manifest and its thirty
separate document bindings passed hash verification. The full source/profile
test passed all fourteen tag/commit/archive bindings, profiles eight through
fourteen, shared Intake configuration, six architecture tests, Assurance
including 47 rebound metadata negatives per shell, and the isolated statistics
lifecycle. Authoring validation, normalization, negative cases and command
boundaries passed too. Listing, all fourteen package-info calls, relevant
template resolutions and `specify check` passed. Exact-head native CI remains
separate; no CI pass is inferred.

All fourteen installed documentation regressions and all nine agent-parity
tests passed, including the installed-state lock bound to installation commit
`f59d2ce2`. The Home-only overlay passed eighteen fixture scenarios per shell.
The new technical Assurance context passed status and four separate gates in
both shells with identical before/after raw-evidence digests. Human pilot,
project and general-release decisions remain open.

Routing discovery, Intake Review, Sequencing and parallel-coordinator fixtures
passed using temporary local states. PSScriptAnalyzer passed. Secret scanning
reported no high findings; its known medium notice concerns private Claude
settings excluded from delivery. The regenerated script reference is current
in both shells: 152 canonical and 130 embedded scripts.

The published Assurance minimum-combination test passed 44 assertions using
Routing v0.1.5 and Autonomous v0.4.5. It explicitly pins those predecessor
metadata; an invocation with newer versions was rejected and not counted as
passing. The canonical executable scripts are unchanged between those old
and new tags. Current command coverage is verified separately above; no
published package test was locally loosened.

## Lieferübersicht / Delivery overview

| Ziel / Target | Stand / State | Freigabegate / Approval gate |
|---|---|---|
| Level 0 | 14 Zielpakete im Arbeitskandidaten / target packages in candidate | Rollout-PR-Sichtung offen / review pending |
| Host Home Runtime | Unverändert / unchanged | Level-0-Merge und Merge-CI / merge and merge CI |
| TinyCalc | Vorgängerversionen / predecessor versions | Home Runtime abgeschlossen / complete |
| absdd-image-sandbox | Vorgängerversionen / predecessor versions | TinyCalc geliefert; vollständiger Diff vor Commit / delivered; diff before commit |
| Show-CommandTui400 | Vorgängerversionen / predecessor versions | Sandbox geliefert / delivered |

## Grenzen / Boundaries

Technische Nachprüfung ist keine Pilot-, Projekt-, Risiko-, Rechts-, Release-
oder Zertifizierungsfreigabe. Statische Dokumentationsprüfungen belegen keine
vollständige B2-/WCAG-2.2-AA-Abnahme. Keine neuen Hilfsmitteltests ausgeführt.
Native Plattformresultate gelten nur für tatsächlich ausgeführte Jobs.

Technical verification grants no pilot, project, risk, legal, release or
certification approval. Static documentation checks do not establish full
B2/WCAG 2.2 AA acceptance. No new assistive-technology tests were performed.
Native results apply only to jobs actually executed.

Wiedervorlage bei Paket-, Quellen-, Konfigurations-, Evidence- oder
Berechtigungsdrift. Vor Home-Sync Syntaxprüfung, Vorschau und CheckOnly;
Konflikte stoppen den Lauf. Kein pauschales Force und kein allgemeiner
Container-Home-Sync. / Re-evaluate on package, source, configuration, evidence
or authority drift. Before Home sync, check syntax, preview and CheckOnly.
Conflicts stop execution; no blanket force or general container Home sync.
