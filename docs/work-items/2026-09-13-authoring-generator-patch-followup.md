# Workitem: Authoring-Generator-Kompatibilitaet veroeffentlichen / Publish authoring generator compatibility

- Status: InProgress — ReleasePublished; beide Piloten geliefert, restlicher Rollout und Katalog offen / both pilots delivered, remaining rollout and catalog pending
- Datum / Date: 2026-09-13
- Owner: Thorsten Hindermann / Preset Maintainer
- Documentation Impact: UpdateRequired
- Wiedervorlage / Re-evaluation: bei jedem Liefer-Gate; blockierte private CI fruehestens 2026-10-01 erneut auf Verfuegbarkeit pruefen / at each delivery gate; recheck blocked private CI availability no earlier than 2026-10-01

## Fortschritt 28.09.2026 / Progress 2026-09-28

Das genehmigte Folgevorhaben liefert v0.3.5 an alle bestehenden operativen
Verbraucher: zuerst Show-CommandTui400 und TinyCalc, danach die uebrigen
registrierten Level-0/1/2-Installationen. Historische Fixtures bleiben ausgenommen.
MergeAndSync mit Admin-Bypass ist nur nach bestandenen technischen Gates am
exakten Head autorisiert. Nicht gestartete CI ist kein Pass; alte Ausnahmen
gelten nicht. Die technische Installation startet keine Intakes oder Produktarbeit.

The approved follow-up covers all existing operational consumers, beginning
with Show-CommandTui400 and TinyCalc. Historical fixtures remain excluded.
MergeAndSync/admin bypass requires successful technical gates on the exact
head; unavailable CI is not a pass and previous exceptions do not carry over.
Installation starts no intake or product implementation.

- Stabiles Release / stable release: [v0.3.5](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.5).
- Release-PR / release PR: [#10](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/10), merged.
- Getesteter Head / tested head: `2ad74f88caf67bb7d8eb8292fef62baea845b9fe`.
- Tag-/Merge-Commit / tag and merge commit: `f90e707444237d768623f457f85d15a707c3476e`.
- Identischer Baum / identical tree: `a04b28ca1b461e5a45d5c4eb6d7270c39a5de50c`.
- [Native macOS-/Linux-/Windows-CI](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/actions/runs/36429748508): alle drei Jobs erfolgreich / all three jobs passed.
- Tag-ZIP SHA-256: `972b6106e9c0ecd95a90dc6bdb175e97a5cc5ef16261b84e56beca2928fa7ba8`.
- Release-ZIP SHA-256: `ed81f62f53dba7f46204ddd822b24747b55f428b9bb427cb2ea715dd56013339`.
- Alle 42 Paketdateien entsprechen dem getesteten Baum; beide Archive haben nach
  Wurzel-Normalisierung gleichen Inhalt. / All 42 package files match the tested
  tree; both archives have identical payloads after root normalization.
- Installation aus der veroeffentlichten Tag-URL und installierte Lifecycle-Suite
  einschliesslich echter Receipt-Vorlage bestanden. / Installation from the
  published tag URL and installed lifecycle suite including the shipped template passed.
- Preset-Quelle: `main` sauber, lokal/remote `0/0`. / Preset source: clean main, synchronized 0/0.

Die fuenf bestehenden optionalen Profilbindungen und der Source-Lock werden
auf v0.3.5 angeglichen; Standard-Achtermatrix, andere Presets und Prioritaeten
bleiben erhalten. Aktuelle gemeinsame Guidance und Bootstrap-Vorlagen folgen
der Versionsbindung. Historische Angaben unten beschreiben den Befund vom 13.09.

The five existing optional profiles and source lock are updated to v0.3.5,
preserving the standard eight, other presets and priorities. Current shared
guidance and bootstrap templates follow the version binding. Historical notes
below describe the September 13 finding.

Release, Verbraucher-Rollout und Community-Uebernahme werden getrennt
abgeschlossen. Katalogeinreichung erst nach beiden erfolgreichen Piloten,
ohne parallele Einreichung. / Release, consumer rollout and community acceptance
have separate completion gates. Submit after both pilots succeed, one update at a time.

### Zentrale Lieferung / Central delivery

Am 28.09.2026 wurde Authoring in der Level-0-Quelle aus dem oben gebundenen
Tag-ZIP installiert. Alle 42 Paketdateien sind archivgleich; die 13 anderen
Registry-Einträge, Priorität 64 und Aktivierung bleiben erhalten. Drei bei
der Command-Generierung entfernte finale LF wurden wiederhergestellt; die
Agenten-/Command-Inhalte bleiben unverändert. Fünf optionale Profile,
Source-Lock, Constitution-Partner, fünf Guidance-Flächen und Bootstrap-Vorlagen
sind auf die aktuelle Version gebunden. Die Standard-Achtermatrix bleibt gleich.

Documentation Impact: `UpdateRequired`. Zielgruppen: Maintainer und Integratoren.
Leserpfad: Profil/Guidance → dieser Liefernachweis → Release und Pilot-PRs.
Kanonisch: eigenständiges Preset-Repository für Paketinhalt, Level 0 für
Profilbindungen. DE/EN-Partner bleiben synchron. Paket, Quellenbindung und
Evidence werden im Klon gelesen; die geänderten Skriptkonfigurationen und
gemeinsame Guidance sind `homeRuntime` und benötigen nach Merge eine
manifestgebundene Vorschau und Home-Synchronisierung. `STATS.md`, lokale
Registrierungen und ausgeschlossene Preset-Kopien im Home-Verzeichnis bleiben
erhalten. Beide bestehenden Statistik-Kontexte werden getrennt fortgeschrieben.
Wiedervorlage: Versions-/Profil-/Quellen- oder Distributionsänderung.

Level 0 installs the exact 42-file tagged payload, retaining the other thirteen
registry entries, activation and priority 64. Restoring three generated final
newlines preserves unchanged command content. Five optional profiles, source lock,
constitution partners, shared guidance and bootstrap templates follow v0.3.5;
the standard eight remain unchanged. Documentation impact is UpdateRequired for
maintainers/integrators, linking profiles to this evidence and release/pilot PRs.
Package truth remains in the standalone repository; profile truth remains in
Level 0. Configuration and shared guidance require manifest-scoped Home runtime
preview/sync after merge. Source-only evidence and package copies stay in the
clone; machine-local files remain preserved. Statistics contexts stay separate.
Reevaluate on version/profile/source/distribution changes. Remote closeout is
recorded in the delivery PR rather than a self-referential statistics commit.

### Pilotnachweise / Pilot evidence

- Show-CommandTui400: [PR #12](https://github.com/hindermath/Show-CommandTui400/pull/12)
  gemergt, Merge `250fd24adfb3a34794a05308795543ea6f239657`, alle PR- und
  Merge-Checks erfolgreich, `main` sauber 0/0. [Abschlussnachweis / closeout](https://github.com/hindermath/Show-CommandTui400/pull/12#issuecomment-5871513571).
- TinyCalc: [PR #91](https://github.com/hindermath/TinyCalc/pull/91), geprüfter Head
  `980c783935f74e25e07809637f2adc6a080c7ede`, Merge
  `aa7b9c4a3f265adb7749a9a796e9cc8bef28bf9f`. Alle 21 PR-Head-Checks und sieben
  Merge-Workflows erfolgreich; Linux-/Windows-Build, Tests und TUI-Smoke bestanden.
  `main` sauber 0/0, beide Statistik-Kontexte CURRENT.
  [Abschluss / closeout](https://github.com/hindermath/TinyCalc/pull/91#issuecomment-5876666049).
- Der ursprüngliche `GSDB002`-Blocker wurde nach ausdrücklicher Genehmigung durch
  technische Nachprüfung behoben: zwei Quellenbindungen und exakte Versionsbindung
  aktualisiert, vier Negativfälle ergänzt. Alle 157 Kontrollzeilen, 16 externen
  Pflichten, 13 Findings und bisherigen Freigabeentscheidungen bleiben unverändert.
  Read-only-Nachweis: Matrix und 88 gebundene Quellen während der Prüfung unverändert.
  [Nachprüfung / follow-up](https://github.com/hindermath/TinyCalc/blob/main/docs/security/gsdb-intensive-review/authoring-v035-follow-up-2026-09-28.md).
- Das Pilot-Gate für die Community-Einreichung ist erfüllt; Einreichung und
  übriger operativer Rollout sind noch nicht abgeschlossen. Zentrale lokale
  Vorbereitungen sind noch keine veröffentlichte Home-Baseline-Lieferung.

Show-CommandTui400 is merged with successful PR/main checks and clean 0/0 sync.
TinyCalc is also merged, with all 21 PR-head checks and seven merge workflows
successful, including native Linux/Windows build, tests and TUI smoke. Its clean
main is synchronized 0/0 and both statistics contexts remain CURRENT. The
explicitly authorized GSDB follow-up revalidated two sources and the exact
version binding without weakening validation or changing control/risk/release
decisions; four added negatives and read-only hashes preserve that boundary.
Both pilot gates are satisfied. Remaining operational rollout and catalog
submission are still pending; local central preparations are not published
Home Baseline delivery. Per-target state is kept
in the [rollout manifest](2026-09-28-authoring-v035-rollout.json).

## Befund und vorhandene Korrektur / Finding and existing correction

Das oeffentliche Authoring-Preset 0.3.4 akzeptierte neue Schema-2-Receipts
seiner eigenen Generatorversion nicht: die feste Allowlist endete bei 0.3.2.
Die kanonische Korrektur ist in
[Authoring PR 9](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/9)
gemergt; getesteter Commit: `9ae4e1be4761e3ba8db85421907bb7eeb1f12b03`.
Native CI auf macOS, Linux und Windows besteht. Unbekannte Generatorversionen
werden weiterhin abgelehnt; historische Schemagrenzen bleiben erhalten.

TinyCalc verwendet einen genau dokumentierten Backport der zwei Wrapper und
des Lifecycle-Tests. Seine Registry bleibt auf 0.3.4; Tags und ZIPs wurden nicht
nachtraeglich geaendert. Andere Verbraucher behalten ihre bereits ausgelieferten
Versionen. Sie koennen den beschriebenen Fehler bei neuen 0.3.4-Receipts noch
ausloesen; bestehende erfolgreich gepruefte Receipts werden dadurch nicht
rueckwirkend ungueltig.

The published 0.3.4 authoring validator rejected its own schema-2 generator.
Canonical PR 9 fixes this and passed native CI on all three platforms.
TinyCalc has a documented three-file backport while retaining registry version
0.3.4. Existing tags and ZIPs remain immutable. Other consumers can still hit
this error when generating new 0.3.4 receipts; their previously valid receipts
are not retroactively invalidated.

## Folgearbeit / Follow-up

1. Naechste freie Patch-Version aus der kanonischen Quelle veroeffentlichen;
   aktuelle Generatorvorlage gegen beide Receipt-Validatoren pruefen.
2. Versioniertes ZIP und Quellbaum vergleichen; Release-/Testnachweise binden.
3. Allgemeine Verteilung gesondert festlegen und den TinyCalc-Backport beim
   Upgrade gegen den neuen Paketinhalt abgleichen.
4. Keine Standardmatrix-Erweiterung und keine Aufnahme der drei historischen
   0.1.0-Test-Repositories ohne gesonderten Auftrag.

Publish the next available canonical patch with template/validator and ZIP
proof, then separately determine wider adoption and reconcile TinyCalc's
backport. Do not expand the standard matrix or enroll historical fixtures.

## Dokumentation / Documentation

Leser / audience: Maintainer und Integratoren / maintainers and integrators.
Kanonische Quelle / canonical source: oeffentliches Authoring-Repository.
Navigation: [Fleet rollout](2026-09-13-intake-lifecycle-fleet-rollout.md).
Leserpfad / reader path: Flottenabschluss / fleet closeout → Folgearbeit /
follow-up → naechster oeffentlicher Patch mit ZIP-Nachweis / next public patch
with ZIP proof.
Distributionsklasse / distribution class: `sourceOnly`.
Dokumentklasse / class: source-only maintenance workitem. DE/EN in dieser Datei.
Home-Sync: keiner / none. Risiko / risk: neue Receipts anderer Verbraucher
koennen bis zur Aktualisierung abgewiesen werden / other consumers may reject
new receipts until updated. Dieser Eintrag ist ein offener Folgeauftrag, keine
Behauptung einer bereits erfolgten allgemeinen Patch-Verteilung.
