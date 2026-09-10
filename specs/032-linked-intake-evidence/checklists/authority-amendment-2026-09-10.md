# Autoritätsgebundene Planänderung 2026-09-10 / Authority-Bounded Planning Amendment 2026-09-10

## Ergebnis / Result

**Deutsch:** Die begrenzte Feature-032-Planungseinheit ist abgeschlossen. Der
bestehende Plan, die bestehenden Aufgaben, der Fleet-Evidence-Vertrag und die
betroffenen Checklisten bilden die zwei am 2026-09-10 genehmigten Ausnahmen
ausführbar ab. Sie erteilen keine weitergehende Autorität und belegen keine
zukünftige Umsetzung vorab.

**English:** The bounded Feature 032 planning unit is complete. The existing
plan, tasks, fleet-evidence contract, and affected checklists now make the two
exceptions approved on 2026-09-10 executable. They grant no broader authority
and do not claim that future implementation has already occurred.

## Begrenzte Disposition / Bounded disposition

| Bereich / Area | Planergebnis / Planning result |
|---|---|
| Produktversionen / Product versions | TinyPl0 `1.6.569.80`, TinyCalc `1.5.7.26`, InventarWorkerService `1.2.8.66` und TuiVision `1.46.835.521` erhalten für Feature 032 ausschließlich eine repository-lokale Nulländerungs-Evidence für `Version`, `AssemblyVersion`, `FileVersion`, Dateihash und manuellen Buildzähler, auch über erforderliche `dotnet`-Gates. Die Versionsdateien bleiben nicht beschreibbar. / For Feature 032 only, the four repositories require repository-local zero-change evidence across the version fields, file hash, and manual build counter, including required `dotnet` gates. The version files remain non-writable. |
| Constitution-Presetspiegel / Constitution preset mirrors | AOC in T079/T080, InventarWorkerService in T113/T121 und `absdd-image-sandbox` in T140/T148 vergleichen zuerst konfigurierte, installierte und gespiegelte `autonomous-run-governance`-Versionen. Nur verbleibende aktuelle Versionsreferenzen dürfen in beiden Constitution-Spiegeln gemeinsam nach lokaler Patchversions-/Datumsprozedur korrigiert werden; Prinzipien und historische Releasefakten bleiben erhalten. Lokale abhängige Agent-/Templateflächen werden atomar geprüft oder begründet `N/A`. Kein Preset-Install, keine Promotion, keine Produkt-/Runtimeänderung. / The three serial repository slots compare configured, installed, and mirrored versions first, then may correct only remaining stale current-version references in both Constitution mirrors, with atomic local parity review or justified `N/A`. No preset install, promotion, product, or runtime change is authorized. |
| Home-Incoming / Home incoming change | Vor den bestehenden finalen Home-Gates und dem Source-Checkpoint integriert T067–T071 exakt die 23 Pfade von Basis `2d1dc80065817426b97c13eeba8387f653b8cc41` bis `91e9c7e5919063388dcc22da7616b3dd878acd19` (PR 279), ohne Reset, Stash, Force oder verlorene Feature-/Untracked-Bytes. Katalogquelle vor `docs/scripts/reference.md`, ehrlicher Statistikstatus bis zum sauberen Renderer, eingehende LF-Attribute und Home-Sync-`sourceOnly` bleiben erhalten. Historische Analyze-Payloads erhalten nur bei Bedarf zwei literale exakte Pfadattribute, keine breite Whitespace-Ausnahme. / T067–T071 integrate the exact 23-path base-to-main delta before the existing final Home gates and source checkpoint, preserving all local bytes, source-first generation, honest statistics state, incoming LF attributes, and the Home Sync `sourceOnly` rule. Any historical Analyze exception is limited to two literal paths. |
| AOC-Lifecycle-Auflösung / AOC lifecycle resolution | T079 entdeckt und belegt repository-lokal die tatsächliche Zuordnung historischer logischer Intake-Pfade zu aktuellen archivierten/gestempelten Dateien einschließlich META-LH-03; T080 verwendet diese Zuordnung ohne Pfadraten oder kanonische Lifecycle-Änderung. Vor T078 ist keine AOC-Mutation zulässig. / T079 records the actual repository-local logical-to-archived/stamped mapping, including META-LH-03; T080 consumes it without guessing paths or changing canonical lifecycle state. No AOC mutation is allowed before T078. |

## Read-only Nachweis / Read-only evidence

- Repository: Branch `032-linked-intake-evidence`, HEAD
  `f3f6954cdde5603bc550c5792483dd6b5033fcf3`; die angegebene Basis ist
  Vorfahr von HEAD und Remote-Main. `origin/main` ist
  `91e9c7e5919063388dcc22da7616b3dd878acd19`.
- Incoming-Delta: exakt 23 Pfade; kein Delta in `AGENTS.md`, beiden
  Constitution-Spiegeln, `.specify/presets` oder Feature-032-Artefakten.
- Akzeptierte Artefakte: 8/8 Hashes unverändert. Level-0-Lock: 28/28
  normalisierte Hashes unverändert.
- Aufgaben: 169 eindeutige, lückenlose IDs T001–T169; 49 bestehende
  Checkboxen abgeschlossen; keine neue ID und keine Checkbox-Änderung.
- Root-Constitution-Spiegel: beide
  `3f42271416eabe70d19769cf58cd3849f745d35bcf45342bd7addd8fa0ce9346`.
- Historische Evidence blieb unverändert: Analyze-Payloads vom 2026-09-08
  `3688723e515ece9740da349ca918d3160767e26816a04db5e7cdee4dcf254ff7`
  und `0d8861b6e6d945b2131a2746e82a21ab2c008339983d854f8e257fa213e2c80b`;
  US2-Ergebnis
  `ee1d0d426068d562b85cb4772d904fe9370232cdb9cef1062b2668ca6efe5f04`
  mit Payload
  `dbb43b7d3959cc29be61f004d4d03d7d5e5318652b9c5f6c751ec84dc6281b02`.
- Der parent-eigene `autonomous-run-state.json` wurde nicht editiert; sein
  beobachteter SHA-256 blieb
  `dc8e69674704659acccb7e52ce122a344683b29d5e16b3ce000b3c2fc65fb806`.
  Der Index blieb leer. Es liefen weder Setup-Plan noch Renderer, US2-Suiten,
  Staging, Commit, Push, Merge, Downstream-Write, Home-Sync, Preset-Installation,
  Model-Refresh oder eine andere Modellphase.

**English evidence summary:** The accepted 8-artifact set, all 28 contract-lock
members, historical Analyze/US2 evidence, parent-owned state, task IDs, and 49
completed checkboxes remained unchanged. The incoming comparison used the
specified base rather than `HEAD..origin/main`; no protected governance or
accepted Feature 032 input changed. No prohibited write or unrelated test phase
was performed.

## Gate und nächste Phase / Gate and next phase

Für diese Planungseinheit sind 1/1 Aufgabe und ihre begrenzten Gates erfüllt.
Die geplanten Repository-Änderungen und deren Delivery-Gates bleiben offen.
Die nächste Phase ist ein separates `speckit.analyze`, keine Retrospektive.

For this planning unit, 1/1 task and its bounded gates are satisfied. The
planned repository changes and their delivery gates remain open. The next
phase is a separate `speckit.analyze`, not a retrospective.

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`: Kanonische Quellen sind der bestehende Feature-032-Plan, die
Aufgaben und der Fleet-Evidence-Vertrag; die vier geänderten Checklisten bilden
die Leserpfade für Governance, Mutation, Delivery und Plattformnachweis. Owner
ist der Feature-032-Run-Owner, Reviewer sind Governance-, Intake- und jeweilige
Repository-Owner. Die Änderung ist `sourceOnly`, zweisprachig in diesem Bericht
zusammengefasst, benötigt keinen Home-Sync und wird nach dem separaten Analyze
sowie vor jeder betroffenen Adoption erneut bewertet.

`UpdateRequired`: The existing Feature 032 plan, tasks, and fleet-evidence
contract are canonical; the four amended checklists provide the governance,
mutation, delivery, and platform reader paths. Ownership remains with the run
owner and relevant governance, intake, and repository reviewers. This is a
`sourceOnly` change, requires no Home Sync, and must be reevaluated by the
separate Analyze phase and before each affected adoption.
