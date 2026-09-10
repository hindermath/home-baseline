# Preset-v0.4.2-Analyse / Preset v0.4.2 Analysis

Stand / As of: 2026-09-10

## Ergebnis / Result

Die fokussierte Analyse besteht. Es gibt keine offenen Critical-, High- oder
Medium-Befunde. Die autorisierte Reparatur, Veröffentlichung und Home-only-
Reconciliation von `autonomous-run-governance` v0.4.2 ist vor T067
ausführbar und zwischen den betroffenen aktuellen Quellen konsistent.

*The focused analysis passes. There are no unresolved Critical, High, or
Medium findings. The authorized repair, release, and Home-only reconciliation
of `autonomous-run-governance` v0.4.2 is executable before T067 and consistent
across the affected current sources.*

## Umfang und tatsächliche Prüfungen / Scope and Actual Checks

| Prüfung / Check | Ergebnis / Result |
|---|---|
| Betroffene Quellen / Affected sources | `plan.md`, `tasks.md`, `contracts/fleet-evidence-and-delivery.md`, `evidence-command-inventory.md` und `resume-audit-2026-09-10.md` stimmen über v0.4.2, Home-only-Reconciliation, T067 und die unveränderte spätere Sieben-Repository-Reihenfolge überein. / The named sources agree on v0.4.2, Home-only reconciliation, T067, and the unchanged later seven-repository sequence. |
| T067-Ausführbarkeit / T067 executability | Jeder der drei historischen Berichte ist in T067 ein eigener `--intended`-Pfad und besitzt im Plan ein eigenes `--allow-historical-whitespace PATH=RAW_SHA256`-Argument. Die Rohhashes stimmen: `3688723e515ece9740da349ca918d3160767e26816a04db5e7cdee4dcf254ff7`, `0d8861b6e6d945b2131a2746e82a21ab2c008339983d854f8e257fa213e2c80b`, `7be7d164a2985943b88b7fa2e1e45f3a6600b15746402a686408be51ef11733d`. Die Dateien enthalten weiterhin 4, 3 und 3 historische Zeilen mit nachlaufendem Whitespace. / Each historical report is passed separately as intended and as an exact raw-hash allowance; all three hashes and the existing 4/3/3 trailing-whitespace lines match. |
| Fail-closed-Vertrag / Fail-closed contract | Die installierte Cross-Shell-Evidence-Integrity-Suite bestand. Isolierte echte Aufrufe bestätigten: Standardablehnung `AEI007`; malformed, falscher Hash, doppelter Eintrag, nicht beabsichtigter Pfad, Hash-/Content-Drift und unnötige Freigabe jeweils Exit 2 mit `AEI009`. / The installed cross-shell suite passed; focused executions confirmed default `AEI007` and `AEI009` for every listed invalid or unnecessary allowance. |
| Keine Umgehung / No bypass | Validator und Quellen enthalten keine breite Musterfreigabe oder Cached-Diff-Ausnahme. T067 verlangt `git diff --cached --check` ohne Pfadausschluss. Die drei historischen Rohbytes stimmen mit den gebundenen Hashes überein. / No broad pattern, cached-diff exclusion, or historical-byte edit was introduced. |
| Home-Liefersatz / Home delivery set | Der akzeptierte Parent-Nachweis und der fokussierte Wiederholungslauf ergeben `Pass`, exakt 3 verwendete Freigaben, 0 fremde Untracked-Pfade und Indextree `f1d27382bd349a11320eb1e252b88fdfdd35ea48`. Der unveränderliche Originalindex hatte vor und nach der Prüfung denselben SHA-256 `1cd6c28138965c99d1f882cba2a0e28342ae00f1eadeb60e5451bb3736757303`. / Accepted parent evidence and the focused rerun show three allowances, zero unrelated untracked paths, the expected tree, and unchanged original index bytes. |
| Veröffentlichung / Publication | Plan, Resume-Audit und akzeptierter Run-State binden PR #18 an den genehmigten Head `116c9a25c8ebd0feb0c228f2c2e76f2c99e62af6`, Merge/Tag v0.4.2 an `0ffddde77aa2d4e90e56643731887b156815a171` und das tatsächliche Archiv an SHA-256 `1ca01e2f868b6591127a6cb0d07be6c9b326015961a726450bc2d72b6a25249c`. / The three accepted current sources bind the exact approved PR head, merge/tag commit, and actual archive hash. |
| Preset-Reconciliation | Alle sechs aktiven Profilmatrizen 8–13 referenzieren Autonomous Run v0.4.2; das 13-Preset-Profil referenziert zusätzlich Assurance v0.1.3. Registry und installierte `preset.yml` melden dieselben Versionen. `install-spec-kit-governance-presets.sh --check-only` bestand mit exakt 13 Presets. / All active 8–13 profile matrices use Autonomous Run v0.4.2; the 13-preset profile also uses Assurance v0.1.3, matching registry and installed metadata, and exact CheckOnly passed. |
| Lokales Overlay / Local overlay | Der akzeptierte Reconciliation-Nachweis erhält die fünf inventarisierten Terminal-Adoption-Dateien bytegleich und bestätigt 52 installierte Dateien als v0.4.2-Paket plus dieses Overlay. / Accepted reconciliation evidence preserves the five inventoried Terminal-Adoption files byte-for-byte and binds all 52 installed files to the v0.4.2 package plus that overlay. |
| Tasks und akzeptierte Artefakte / Tasks and accepted artifacts | `tasks.md` enthält 169 eindeutige, lückenlose IDs T001–T169, genau 66 gesetzte Checkboxen und den gebundenen normalisierten SHA-256 `9686d0e7f2580c55792ebfa3967652f436f39f1143144cd828e59c15938883d2`. Der PowerShell-Parent-Validator bestand; alle acht akzeptierten Artefakte wurden zusätzlich gegen ihre aktuellen normalisierten SHA-256 geprüft: 8/8 Match. / Tasks are unique, contiguous, 66/169 complete, and hash-bound; the parent validator passed and all eight current artifact hashes match. |

## Befunde / Findings

| Severity | Anzahl / Count | Bewertung / Assessment |
|---|---:|---|
| Critical | 0 | Keine / None |
| High | 0 | Keine / None |
| Medium | 0 | Keine / None |
| Low | 1 | Der Bash-State-Validator verwirft den vom PowerShell-Parent geschriebenen gültigen UTC-Zeitstempel mit sieben Nachkommastellen, während der gebundene PowerShell-Parent-Validator besteht. Das betrifft weder die v0.4.2-Delivery-Regel noch T067 und bleibt ein separater Paritäts-Follow-up. / The Bash state validator rejects the valid seven-digit UTC fraction emitted by the PowerShell parent, while the bound PowerShell parent validator passes. This does not affect the v0.4.2 delivery rule or T067 and remains a separate parity follow-up. |

## Autoritäts- und Liefergrenze / Authority and Delivery Boundary

Diese Phase änderte keine Planungs-, Produkt-, Run-State-, Git-, Provider-,
Home-Sync-, Downstream- oder Fleet-Fläche. Sie startete T067 nicht und erfand
keine native, Review-, Delivery-, Statistik- oder Human-Evidence. Die bereits
genehmigte enge Constitution-Prozedur für AOC, InventarWorkerService und
`absdd-image-sandbox` bleibt unverändert; spätere Vergleiche verwenden v0.4.2,
ohne aus dem Home-Abgleich eine Installation oder Promotion abzuleiten.

*This phase changed no planning, product, run-state, Git, provider, Home-sync,
downstream, or fleet surface. It did not start T067 or fabricate future native,
review, delivery, statistics, or human evidence. The approved narrow
Constitution procedure remains unchanged, and later comparisons use v0.4.2
without inferring installation or promotion from the Home reconciliation.*

Dokumentationsauswirkung / Documentation impact: `NoUpdateRequired`. Dieser
zweisprachige Analysebeleg ist `sourceOnly`, benötigt keinen Sprachpartner,
keine Navigation und keinen Home-Sync; Owner ist der Autonomous Run Owner.

## Nächste Aktion / Next Action

Der Parent darf die Phase als bestanden übernehmen, den Stage auf `Implement`
zurückstellen und anschließend exakt T067 ausführen. / The parent may accept
this passing phase, restore stage `Implement`, and then execute exactly T067.
