# Öffentliche Spec-Kit-Läufe / Public Spec Kit runs

Diese Statistik zählt belegte Feature-Läufe in registrierten öffentlichen
GitHub-Repositories der Level 0 und 2. Sie misst weder Produktqualität noch
Arbeitszeit. Ein abgeschlossener Governance-Lauf ist keine Produktabnahme.

*This statistic counts evidenced feature runs in registered public GitHub
level-0 and level-2 repositories. It measures neither product quality nor
working time. A completed governance run is not product acceptance.*

## Daten und Nachweise / Data and evidence

- [Öffentliche Tabelle / Public table](table.md), [English table](table.en.md)
- [Repository- und Belegregister / Repository and evidence register](registry.json)
- [Vollständiger Snapshot / Complete snapshot](snapshot.json)
- [Prüfbedarf und Abschlusslücken / Review queue and completion gaps](review-queue.md)
- [Veröffentlichungsprüfsummen / Publication checksums](publication.json)

Das Register ist die fachliche Quelle. Es enthält je Feature eine begründete
Einstufung und SHA-256-gebundene öffentliche Belege für Start, Ausführung und
gegebenenfalls Abschluss. Die Kennzeichnung `hindermath-maintained-evidence-register`
benennt den gepflegten Registervertrag, keine behauptete menschliche Einzelabnahme.
Die initiale Belegprüfung und spätere Änderungen unterliegen dem Repository-Review.

*The register is the semantic source. Each feature has a reasoned classification
and SHA-256-bound public proof of start, execution and, where applicable,
completion. The register label denotes the maintained evidence contract, not a
claim of individual human approval. Initial evidence and changes undergo PR review.*

## Zählvertrag, Version 1 / Counting contract, version 1

| Spalte / Column | Bedeutung / Meaning |
|---|---|
| Gestartet / Started | Konkreter, geprüfter Feature-Startnachweis, zum Beispiel eine ausgearbeitete Spezifikation. / Concrete reviewed feature start evidence, for example a developed specification. |
| Ausgeführt / Executed | Implementierung oder fachliche Bearbeitung nachweislich begonnen. Planung oder ein Setup-Häkchen allein genügt nicht. / Implementation or substantive work demonstrably started; planning or a setup checkbox alone is insufficient. |
| Abschluss belegt / Completion evidenced | Geprüfter terminaler Zustand oder vollständige Abschlussbelegkette. Ein Merge allein genügt nicht. / Reviewed terminal state or complete closure evidence; a merge alone is insufficient. |

Die Spalten sind kumulativ: `Abschluss belegt <= Ausgeführt <= Gestartet`.
Ein Feature zählt pro Repository einmal. Resume, Wiederholungsversuche,
Abschluss-PRs, kopierte Nachweise, Vorlagen, Fixtures, Intakes, Reviews,
Preset-Installationen und technische Smoke-Tests zählen nicht zusätzlich.
Alle eingeschlossenen Repositories erscheinen auch mit Nullwerten.

*Columns are cumulative. A feature counts once per repository. Resumes, retries,
closure PRs, copied evidence, templates, fixtures, intakes, reviews, preset
installations and technical smoke tests do not add runs. Included repositories
with no reviewed runs retain zero rows.*

Die Startauswahl enthält neun explizit registrierte öffentliche Repositories.
Neue Repository-Zuordnungen und Feature-Einstufungen benötigen eine geprüfte
Registeränderung; es gibt keine kontoweite automatische Scope-Erweiterung.
CI entdeckt nummerierte `specs/<Nummer>-<Name>/spec.md` auf dem Default-Branch
und offenen PRs desselben Repositories. Fork-PRs und unveröffentlichte lokale
Arbeit sind ausgeschlossen. Branches ohne PR gehören nicht zur automatischen
Entdeckung. Ihre öffentlichen Belege können nach Prüfung ins Register aufgenommen
werden. Archivierte bereits belegte Läufe bleiben über ihre gepinnten Quellen erhalten.

*The initial scope contains nine explicitly registered public repositories.
Repository additions and feature classifications require a reviewed register change.
CI discovers numbered feature specifications on the default branch and open
same-repository PRs. Fork PRs and unpublished local work are excluded. Branches
without a PR are not automatically discovered; reviewed public evidence from them
can be registered. Accepted archived runs remain reproducible through pinned proofs.*

Neue Kandidaten stehen als `needsReview` in der Prüfwarteschlange und zählen
bis zur semantischen Prüfung in keiner Spalte. Für die Übernahme: Spezifikation,
tatsächliche Bearbeitung und Abschlussgrenze lesen; je Behauptung einen öffentlichen
Beleg mit Commit/PR und SHA-256 zuordnen; Einstufung und Begründung im Register
ergänzen; `Collect`, `Render` und Tests erneut ausführen. Kein Modell und keine
Textheuristik darf einen Abschluss autonom genehmigen.

*New candidates enter the review queue and remain excluded until semantic review.
To accept one, inspect specification, substantive execution and closure boundaries;
bind a public commit/PR and SHA-256 to each claim; update the register with the
classification and rationale; rerun collection, rendering and tests. No model or
text heuristic independently approves completion.*

Historische vollständig abgehakte Aufgabenlisten sind einzeln geprüfte Nachweise,
keine pauschale Regel für zukünftige Läufe. Für TinyCalc 003–005 und TuiVision
009/022/023/026 ergänzen spätere Delivery-/Closeout-PRs eingefrorene Aufgabenlisten.
Level-0-Feature 030 bleibt ohne belegten terminalen Abschluss: `Active/Publish`
und offene finale Prüfungen werden durch den Merge von PR #259 allein nicht ersetzt.
Die Statistik schreibt keine historischen Feature-Artefakte um.

*Historical checked task lists are individually reviewed evidence, not an automatic
rule for future runs. Later delivery/closure PRs supplement frozen task lists for
the named features. Level-0 feature 030 remains without terminal completion proof;
PR #259 alone does not supersede pending final verification. Historical feature
artifacts are never rewritten by this statistic.*

## Reproduktion / Reproduction

Der reguläre Sammler läuft auf einem GitHub-gehosteten Ubuntu-Runner, ohne
persönlichen Rechner oder lokale Agentenzustände. Nur die Erhebung benötigt
`gh` und öffentliche GitHub-Lesezugriffe. Der versionierte Snapshot enthält
die vollständigen verwendeten Quelltexte und ausgewählte Providerfelder.
Commit-gebundene, hashgeprüfte Quellen werden beim nächsten Lauf wiederverwendet;
veränderliche PR-Belege werden erneut geprüft. API-Fehler, unbekannte Zustände,
Hash-Abweichungen und abgeschnittene Git-Bäume stoppen die Veröffentlichung.
Privat gewordene Repositories werden ausgeschlossen, bevor Inhalte gelesen werden.

*Normal collection runs on a GitHub-hosted Ubuntu runner without a personal machine
or local agent state. Only collection needs gh and public GitHub reads. The snapshot
contains the full source text used and selected provider fields. Hash-checked immutable
commit sources are reused; mutable PR evidence is rechecked. API errors, unknown states,
hash drift and truncated Git trees stop publication. Private repositories are excluded
before reading their content.*

```bash
# Offline prüfen / Validate offline
bash scripts/update-public-speckit-statistics.sh --action Validate
bash scripts/update-public-speckit-statistics.sh --action Render --check-only
# Live-Vorschau / Live preview without writes
bash scripts/update-public-speckit-statistics.sh --action Collect --dry-run
# Kandidat erzeugen / Produce candidate (no commit, push or merge)
bash scripts/update-public-speckit-statistics.sh --action Collect
bash scripts/update-public-speckit-statistics.sh --action Render
```

```powershell
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Validate
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Render -CheckOnly
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Collect -WhatIf
pwsh -NoProfile -File scripts/tests/test-public-speckit-statistics.ps1
```

Exitcodes: `0` erfolgreich/aktuell, `1` Drift, `2` Fehler. Ein Snapshot mit
derselben Regelversion liefert offline dieselben Bytes. Die Hashes beweisen
Integrität, nicht die fachliche Richtigkeit einer ungeprüften Einstufung.

*Exit codes: 0 successful/current, 1 drift, 2 error. The same snapshot and rule
version reproduce the same bytes offline. Hashes establish integrity, not the
semantic correctness of an unreviewed classification.*

## Monatlicher Betrieb / Monthly operation

Level 0 erhebt am Monatsersten um 08:17 UTC. Das Profil übernimmt am zweiten
Kalendertag um 09:17 UTC ausschließlich den zuletzt gemergten Level-0-Stand.
Beide Workflows erlauben `workflow_dispatch`. GitHub kann Termine verzögern.
Offene Level-0-PRs werden nicht ins Profil übernommen; nach einem späteren Merge
kann dessen Workflow manuell gestartet werden, sonst greift der nächste Monatslauf.
Je Repository entsteht höchstens ein Aktualisierungs-PR. Kein Auto-Merge.

*Level 0 collects on day 1 at 08:17 UTC; the profile imports the latest merged
source on day 2 at 09:17 UTC. Both support manual workflow dispatch. GitHub may
delay schedules. Pending source PRs are not imported. After a later merge, dispatch
the profile workflow manually or wait for the next month. One update PR per repo;
no automatic merge.*

Unveränderte Evidence erzeugt keinen Datums-Commit. Der sichtbare Datenstand
ist der letzte inhaltlich geänderte und veröffentlichte Snapshot, nicht eine
Behauptung täglicher Frische. Jüngere erfolgreiche Nulländerungsprüfungen sind
in den Actions-Läufen sichtbar. Fehler lassen den vorherigen Stand unverändert.
Bei zurückgehaltenen Bot-PR-Prüfungen diese vor Review/Merge freigeben.

*Unchanged evidence does not create a date-only commit. The displayed date is
the last changed and published snapshot; newer no-change checks are visible in
Actions. Failures preserve the previous publication. Release held bot-PR checks
before review/merge.*

Owner: Level-0 Maintainer. README und Skripte folgen dem bestehenden Home-Runtime-
Manifest; Dokumentation und Snapshots sind `sourceOnly`. Home-Sync erfolgt nach
separat autorisierter Lieferung, niemals als Voraussetzung oder Teil der CI-Erhebung.
Private werdende Quellen werden aus dem aktuellen Snapshot entfernt; historische
Git-Versionen bereits öffentlich veröffentlichter Daten bleiben Git-Historie.

*Owner: Level-0 maintainer. README/scripts follow the existing Home Runtime manifest;
documentation and snapshots are source-only. Home sync follows separately authorized
delivery and is never required by collection. Removing newly private sources from
the current snapshot does not erase previously public Git history.*
