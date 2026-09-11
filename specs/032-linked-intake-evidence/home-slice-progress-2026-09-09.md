# Feature 032 – HOME-Vertikalscheibe T028–T038

## Ergebnis / Result

Die wiederaufgenommene Phase `implement-foundation` hat die HOME-Vertikalscheibe
T028 bis T038 abgeschlossen. Zusammen mit den bereits akzeptierten und
unverändert erhaltenen Tasks T004 bis T027 sind damit alle 35 Tasks T004–T038
vollständig evidenziert. T039 und spätere Tasks wurden nicht begonnen.

The resumed `implement-foundation` phase completed the HOME vertical slice T028
through T038. Together with the already accepted and preserved tasks T004
through T027, all 35 tasks T004–T038 now have complete evidence. T039 and later
tasks were not started.

## TDD-Nachweis / TDD evidence

- Red zuerst: Bash und PowerShell 7 liefen am 2026-09-09 um 19:07:55 UTC gegen
  die unveränderten alten Vier-Spalten-Renderer. Beide Läufe endeten erwartbar
  mit Exitcode 1 und denselben neun fehlgeschlagenen Vertragsassertionen. Die
  Syntaxprüfungen waren grün, und der Write-Count war 0.
- Die damaligen Renderer-Hashes waren
  `69a056b09c144eab9dcd9ac89d5235d7093ddf4562a301a00288d8013af0be28`
  für Bash und
  `be331e0c87799af702ea6a7b476a1d90d01cb5ea16eb0c345f3c80616a821229`
  für PowerShell.
- Nach der Implementierung bestanden beide Vertragstests sowie Bash-Syntax,
  der eingegrenzte Bash-Dry-Run und das eingegrenzte PowerShell-WhatIf mit
  Exitcode 0. Die Safe Modes hatten identische Vorher-/Nachher-Inventarhashes
  und Write-Count 0.
- Maschinenlesbare Evidence:
  `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/repositories/home-baseline/tdd-red.json`
  und `us1-macos.json` im selben Verzeichnis.

Red was observed before renderer changes. Both final contract tests, Bash
syntax, the scoped Bash dry run, and scoped PowerShell WhatIf then passed with
exit code 0 and no Safe Mode writes.

## Fachliche Projektion / Business projection

- Kanonische Quelle:
  `requirements/intakes/series/home-baseline-delivery/manifest.json`
- Erzeugte View: exakt fünf Spalten, 33 Targets und 33 Zeilen.
- Sichtbare Positionsfolge: `39,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38`.
- Direkte eingehende Abhängigkeiten: 37 von 37; Roots: 3 von 3 mit exaktem
  Root-Fallback.
- Relative Intake- und Dependency-Links: 70 von 70 auflösbar, 100 Prozent
  innerhalb des Home-Repositories, keine absolute oder private URI.
- Für alle 33 aktuellen Targets gilt mangels eindeutiger expliziter
  Feature-Evidence der vertragliche Kein-Feature-Nachweis. Ein Feature-Link
  wird nur bei genau einem expliziten Proof erzeugt.
- `AC-LAF-002` bis `AC-LAF-006` sind bestanden. Details stehen in
  `business-semantics.json` und `links.json` im oben genannten Evidencepfad.

The generated projection preserves manifest semantics, visible intake
positions, direct incoming edge direction, literal `kind` and `binding`, safe
view-relative links, and the exact feature-proof fallback.

## Vertragssperre / Contract lock

`specs/032-linked-intake-evidence/level0-contract-lock.json` bindet Renderer,
Tests, positive Fixtures und View mit dem normalisierten Vertragshash
`ca67bb915393bce829272bf1a963bf609700d968955dbb7ccebf49d4067af7e8`.
Jede spätere Änderung eines gebundenen Quellhashes invalidiert noch nicht
abgeschlossene Downstream-Adoptionen.

All ten locked sources, the canonical manifest, four gate-evidence files, and
the following eight accepted artifacts were revalidated without changing the
accepted artifacts:

| Akzeptiertes Artefakt / Accepted artifact | Normalized SHA-256 |
|---|---|
| `Lastenheft_Verlinkte-Abarbeitungsreihenfolgen-und-Spec-Kit-Feature-Nachweise.md` | `d9e066a4f2ae58a3706495c0c60919c47fd802b353ecd6939c8b65ad1cbd7983` |
| `specs/intake-authoring-receipts/verlinkte-abarbeitungsreihenfolgen-und-spec-kit-feature-nachweise.json` | `9f2040364c76722a2116f85209aedf8c4c67c72554069679901beec67a8dda57` |
| `specs/verlinkte-abarbeitungsreihenfolgen-und-spec-kit-feature-nachweise-intake-review/intake-review-request.json` | `955a66c2273e7977e6004d89f189eccb0087543af469aef3e237339f7f439ab2` |
| `specs/verlinkte-abarbeitungsreihenfolgen-und-spec-kit-feature-nachweise-intake-review/intake-review-result.json` | `5f9d07587bbc4d079ad564b7b6b5a128a690a860ebfa6e50a7934845274b9426` |
| `specs/verlinkte-abarbeitungsreihenfolgen-und-spec-kit-feature-nachweise-intake-review/intake-review-report.md` | `6c60d1e2e9b31273f150136f1f85af50e00d513ee65526d0f837759f465708bc` |
| `requirements/intakes/series/home-baseline-delivery/manifest.json` | `6d179988520f93e086b4a22d522e3ad26ecee5a94091dd72c016b0066835c907` |
| `requirements/intakes/series/home-baseline-delivery/receipt.json` | `b14e2b1bdc26f674e5d798b93ffd860f12e4c74b66014e0874fb8145e88604cf` |
| `requirements/intakes/series/home-baseline-delivery/operations/7fe67a1c-4838-41a6-8a90-229726fd89cc.json` | `5a53c43c03d1bfa485470ab29d02129960d969091b429a5dab47be92ca519b1f` |

## Dokumentation und Statistik / Documentation and statistics

Die Dokumentationsentscheidung lautet `GeneratedUpdate`. Kanonische Renderer-
und Katalogquellen erzeugen den owned Marker und die Skriptreferenz. Die
Skripte gehören zu `homeRuntime`; Feature-Evidence und Dokumentation sind
`sourceOnly`. Es wurde kein Home-Sync ausgeführt.

Für Statistik-Slot 79 werden 1.117 Nettozeilen aus den 12 in dieser Phase neu
erstellten oder geänderten Implementierungs- und Dokumentationspfaden erfasst.
Task-, Report-, Evidence- und Statistik-Buchhaltung sind darin nicht enthalten.
Der deterministische Statistikrenderer wird nur im Check-Modus ausgeführt; die
Ledger-Erzeugung bleibt wegen des bestehenden Dirty-Tree-Gates bis zu einer
autorisierten sauberen Integration offen. Slot 78 bleibt unverändert erhalten.
Der Check-only-Lauf meldete erwartungsgemäß `DRIFT` mit Exitcode 1,
`changed=true`, Methodik 2, 654.704 Textzeilen und 105 sichtbaren Aktivtagen;
der Clean-Tree-Schutz wurde nicht umgangen.

The documentation impact is `GeneratedUpdate`. No Home sync was performed. The
statistics source records the reproducible phase delta while the generated
ledger remains pending behind its clean-tree gate.

## Grenzen und nächster Schritt / Limits and next step

- Die frische 753-Dateien-Baseline vom 2026-09-09 wurde vollständig geprüft:
  keine Datei fehlt. Abweichungen beschränken sich auf die fünf gebundenen
  Implementierungs-/View-Pfade dieser Slice und die bewusst aktualisierte
  Statistikquelle; alle übrigen Baseline-Dateien sind unverändert.
- PowerShell wurde auf macOS gegengeprüft; native Windows- und Linux-Evidence
  sowie die Exact-Head-Konsolidierung bleiben dem späteren Gate T071 vorbehalten.
- Negative Verträge ab T039, Downstream-Repositories und Provider-/Image-Arbeit
  liegen außerhalb dieser Phase und wurden nicht verändert.
- Es erfolgten kein Commit, Staging, Push, PR, Merge, Preset-Installation oder
  Fleet-Re-Inventar.
- Der Parent kann dieses Phasenergebnis gegen den autonomen Run-State
  reconciliieren. Eine spätere Implementierungsphase beginnt frühestens mit
  T039.

PowerShell was cross-checked on macOS; native platform and exact-head evidence
remain pending at T071. The next implementation slice starts no earlier than
T039.
