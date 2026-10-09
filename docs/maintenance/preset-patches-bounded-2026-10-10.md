# Drei Preset-Patches: begrenzter Rollout / Three preset patches: bounded rollout

Stand / Date: 2026-10-10. Owner: Thorsten Hindermann.
Documentation Impact: `UpdateRequired`.

## Auftrag und Grenzen / Authority and boundaries

DE: Der ausdruecklich genehmigte Auftrag umfasst Home Baseline, betroffene
manifestgebundene Home Runtime sowie TinyCalc, Show-CommandTui400 und
absdd-image-sandbox. MergeAndSync mit Admin-Bypass gilt ausschliesslich nach
gruenen technischen Checks am exakten Head. TinyCalc darf die technischen
GSDB-Versions-/Hashbindungen gezielt erneuern, ohne Findings, fachliche
Statuswerte oder menschliche Produkt-, Risiko- und Releaseentscheidungen neu
zu bewerten. Die weitere public Level-2-Flotte und die restliche Flotte bleiben
ausdruecklich ausserhalb dieses Auftrags. Es startet kein Spec-Kit-Produktlauf.

EN: Explicit authority covers Home Baseline, affected manifest-bound Home
Runtime and exactly TinyCalc, Show-CommandTui400 and absdd-image-sandbox.
Admin delivery requires successful exact-head technical checks. TinyCalc may
refresh technical GSDB version/hash bindings without changing findings,
professional states or human product/risk/release decisions. All other public
Level-2 repositories and the remaining fleet stay outside scope. No product
Spec Kit run is started.

## Eingefrorene Quellen / Frozen sources

| Preset | Version | Priority | Source commit | Tag ZIP SHA-256 |
| --- | --- | --- | --- | --- |
| Security | 0.7.1 | 10 | `7204bccbdf3565d4dd22424c7fa7a15c6a6e0eb3` | `c85a4b924e741a3981dc369adc6233b6f323013fb1d46735555038d322cda18a` |
| Architecture | 0.6.2 | 20 | `017e91a24a685e23f176e98c07c9ac8d81487cbb` | `ebea0ede13e6d72b8d65ae56b08ae28e07b3814aca3f8e9563b6590d0c88a082` |
| Intake Sequencing | 0.2.8 | 66 | `be69290486175fc8256338200b342bf0e33cbb09` | `07dbd79f76927136494fe0742b0e8044d7cb2625c9d5d8f61fbe05b1e8d980ac` |

DE: Die drei Patches korrigieren die direkt auswertbaren README-
Installationsbefehle und Versionsmetadaten samt Regressionstests. Die
fachlichen Regeln, Runtime-Validatoren, Schemas und Prioritaeten bleiben
gegenueber Security 0.7.0, Architecture 0.6.1 und Sequencing 0.2.7 erhalten.
Die uebrigen elf Presets bleiben unveraendert. Historische Berichte, Tags,
Archive, Intake-Receipts und Jahresreview-Ergebnisse werden nicht umgeschrieben.

EN: These patches fix directly parseable README installation commands and
version metadata with regression coverage. Normative rules, runtime validators,
schemas and priorities remain unchanged from the preceding patches. The other
eleven presets, historical evidence, tags, archives, intake receipts and annual
review outcomes are preserved.

## Pruef- und Lieferfolge / Validation and delivery order

DE: Zuerst zentrale Profile, Source-Lock, aktuelle Guidance und Templates
gemeinsam aktualisieren und nur die drei betroffenen Pakete neu installieren.
Danach vollstaendiges 14er-Profil in Bash und PowerShell, Quellen-/Kompositions-
und installierte Pakettests, Dokumentation, Homogeneity und Statistik pruefen.
Native PR-Checks, Review-Threads und exakten Head vor Merge pruefen; anschliessend
main 0/0 sowie Home-Sync mit Vorschau und CheckOnly nachweisen. Erst danach
die drei Ziel-Repositories einzeln pruefen und liefern. Abschlusslinks und
Merge-/Sync-Resultate werden im PR-Closeout dokumentiert, nicht vorweggenommen.

EN: Update central profiles, source lock, current guidance and templates
together, reinstalling only the three changed packages. Verify the complete
fourteen-preset profile in both shells, source/composition and installed tests,
documentation, homogeneity and statistics. Require native PR checks, review
thread inspection and exact-head merge, followed by main 0/0 and previewed,
check-only-verified Home sync. Deliver the three targets only after central
completion. Record actual merge/sync links in PR closeout rather than claiming
completion in advance.

## Dokumentationsvertrag / Documentation contract

Audience / Zielgruppe: Maintainer, KI-Agenten und Pilot-Reviewer.
Reader path / Leserpfad: README DE/EN -> this report -> source lock -> delivery PRs.
Canonical source: standalone preset tags; matrices and source lock bind integration.
Owner: repository maintainer. Class: integration evidence, not product assurance.
Languages: inline DE first / EN second; README language partners stay aligned.
Distribution: this report and provenance are sourceOnly; guidance, matrices and
selected generated surfaces are homeRuntime. Home sync is explicitly requested.
Platform proof: local macOS checks plus native CI; no unexecuted host/platform
acceptance is claimed. Documentation and security boundaries remain text-readable.
Reevaluation: source/hash drift, next preset patch or a delivery-gate failure.
Statistics retain their methodology; visible Git activity is not AI productivity.
