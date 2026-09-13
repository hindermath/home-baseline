# Workitem: Authoring-Generator-Kompatibilitaet veroeffentlichen / Publish authoring generator compatibility

- Status: Open
- Datum / Date: 2026-09-13
- Owner: Thorsten Hindermann / Preset Maintainer
- Documentation Impact: UpdateRequired
- Wiedervorlage / Re-evaluation: vor dem naechsten Authoring-Release, spaetestens 2026-09-20 / before the next authoring release, no later than 2026-09-20

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
Dokumentklasse / class: source-only maintenance workitem. DE/EN in dieser Datei.
Home-Sync: keiner / none. Risiko / risk: neue Receipts anderer Verbraucher
koennen bis zur Aktualisierung abgewiesen werden / other consumers may reject
new receipts until updated. Dieser Eintrag ist ein offener Folgeauftrag, keine
Behauptung einer bereits erfolgten allgemeinen Patch-Verteilung.
