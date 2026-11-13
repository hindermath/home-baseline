# Intake Authoring 0.3.14: Quellenbindung / Source binding

## Deutsch

Der beauftragte Rollout hat einen gemeinsamen Kompatibilitaetsfehler gezeigt:
Ein eigenstaendig abgeschlossenes Intake ausserhalb einer Serie konnte seine
unveraenderte Archivdatei nicht aufloesen. Das neue Patch 0.3.14 korrigiert
diese Suche, ohne eine vorhandene gleichnamige Manifestbindung zu umgehen.
Physische Verzeichnisgrenzen, Dateiname, normalisierter Inhalts-Hash und ein
eindeutiger Treffer bleiben Pflicht. Seriengebundene Receipts bleiben an ihre
Serie gebunden; historische Receipts und Tags bleiben erhalten.

[Quell-PR 28](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/28) wurde am exakten Head
`53d302ccc9515612254d7b6034797a0107ba9391` nach zwoelf erfolgreichen technischen Checks mit
Merge-Commit `aaf8da25c7545a2e69ca120d5147a0159c3a1caf` geliefert. Der
[Release v0.3.14](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.14) ist veroeffentlicht; alle 72
ZIP-Dateien wurden byteweise gegen diesen Commit geprueft.
ZIP SHA-256: `b70b73e6e096e2bb2e0ccfda63704938d4a9ec4ff815b134c8a892f302d5fc79`.

Die bestehenden Profile behalten IDs, Prioritaeten und ihre Standardauswahl.
Die Level-0-Installation bleibt bei vierzehn Presets; nur Intake Authoring
wechselt von 0.3.13 auf 0.3.14. Vorhandene Projektvorlagen bleiben erhalten.
Quellen- und Istbindungen sind getrennt dokumentiert. Das neue Paket ergaenzt
0.3.13 als bekannte Generatorversion und aendert kein Schema oder Lifecycle.

## English

The authorised rollout exposed a shared compatibility error: an independently
completed intake outside a series could not resolve its unchanged archive.
Patch 0.3.14 fixes lookup without bypassing an existing same-name manifest
binding. Physical directory boundaries, file name, normalized content hash
and exactly one match remain mandatory. Series-bound receipts remain bound
to their series; historical receipts and tags are preserved.

[Source PR 28](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/28) was delivered at exact head
`53d302ccc9515612254d7b6034797a0107ba9391` after twelve successful technical checks, using
merge commit `aaf8da25c7545a2e69ca120d5147a0159c3a1caf`. The
[release v0.3.14](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.14) is published; all 72 ZIP files
were compared byte by byte against that commit.
ZIP SHA-256: `b70b73e6e096e2bb2e0ccfda63704938d4a9ec4ff815b134c8a892f302d5fc79`.

Existing profile IDs, priorities and default selection remain. Level 0 keeps
fourteen installed presets; only Intake Authoring changes from 0.3.13 to
0.3.14. Existing project templates remain. Source and installed-state bindings
are separate. The package additionally accepts generator 0.3.13; no schema
or lifecycle change is introduced.

## Nachweise / Evidence

[Quellnachweis / source record](intake-authoring-v0314-source.json),
[Quellenbindung / source lock](preset-source-lock.json),
[Istbindung / installed lock](preset-installed-lock.json),
[urspruengliche Lieferung / initial delivery](preset-security-patch-rollout-2026-11-13.md).

Documentation Impact: UpdateRequired. Owner: Thorsten Hindermann.
Readers: maintainers and preset users -> README -> this record -> exact source
PR, native CI and immutable release/archive. Canonical source: reviewed source
package, pinned matrices and separate locks. DE first, equivalent EN, CEFR B2
and applicable WCAG 2.2 AA. Scripts/guidance are manifest-bound homeRuntime;
evidence and installed preset sources are sourceOnly. Home sync follows
technical delivery; only the nine already authorised Level-2 consumers.
No practical screen-reader/Braille acceptance, new model call, Spec Kit feature
execution, blanket alert dismissal or finding-free claim. Re-evaluate after
caller, source, archive, matrix or installed-state changes.
