# Secure Development Assurance v0.1.3: Feldtestkonsolidierung / Field-Test Roll-up

Stand / State: 2026-09-09.

## Ergebnis und Prüfgrenze / Outcome and proof boundary

Die Feldtestgruppe umfasst jetzt **sieben Repositories**: fünf bisherige
Level-2-Projekte, die Level-0-Quelle home-baseline und AOC als weiteres
Level-2-Projekt. Alle sieben projektbezogenen Feldberichte empfehlen
`ReleaseAccepted` für das unveränderte Preset v0.1.3 in ihrem ausdrücklich
begrenzten Scope. Dies ist **keine zentrale Preset-Abnahme** und keine
Produktfreigabe.

*The group now comprises seven repositories: the five original Level-2
projects, the Level-0 source and AOC. All seven scoped project reports recommend
`ReleaseAccepted` for unchanged preset behavior, not central preset acceptance
or product release.*

Die ersten fünf Ergebnisse bleiben historische, projektbezogene Nachweise.
Level 0 und AOC prüfen neu Installation, Baseline-Integrität und Governance-
Gate-Verarbeitung. Ihre 30 Dokumentbindungen bedeuten nicht, dass alle 157
Sicherheitsmaßnahmen umgesetzt sind. Level 0 ist zugleich Preset-Quelle und
Anwender: sein Selbsttest ist kein unabhängiger externer Feldnachweis.
AOC besitzt keinen freigegebenen Produkt-Scaffold; eine Produkt-Laufzeitabnahme
wird nicht behauptet.

*The original five reports remain historical project evidence. The two new
contexts test installation, source integrity and gate semantics; thirty
document bindings do not attest implementation of all 157 controls. Level 0
is both developer and consumer; AOC has no approved product scaffold.*

## Gemeinsamer Ausbildungszweck / Shared educational purpose

Alle sieben Repositories sind **nichtproduktive, nichtkommerzielle Ausbildungs-
und Referenzprojekte** für KI-gestützte sichere Entwicklung. Primäre Zielgruppen:

- Fachinformatiker*innen einschließlich aller vier Fachrichtungen;
- IT-System-Elektroniker*innen;
- Kaufleute für IT-System-Management;
- Kaufleute für Digitalisierungsmanagement.

Sicherheit beginnt ab Lehrjahr 1: Eingaben prüfen, Geheimnisse schützen,
Agentenrechte begrenzen, KI-Änderungen verstehen, Tests ausführen und
menschliche Freigaben begründen. Die didaktische Tiefe wächst mit dem Lernstand.
DE zuerst, EN danach, CEFR B2, Tastatur-/Screenreader- und Texttauglichkeit
bleiben die Basis. Ausbildungszweck reduziert keinen Schutz für reale Dateien,
Zugangsdaten oder Entwicklungsumgebungen. Das Angebot ergänzt, ersetzt aber
nicht Ausbildungsordnung, Berufsschule, betriebliche Ausbildung oder
Ausbilderentscheidung.

*All seven are non-production, non-commercial educational/reference projects
for the four IT training occupations, including all four IT specialist tracks.
Secure AI-assisted work starts in year one: validate inputs, protect secrets,
bound agent permissions, understand changes, test and justify human decisions.
Explanatory depth grows; accessible German-first/English-second material and
protection of real data remain mandatory. These resources supplement formal
and workplace training, not replace them.*

Die fünf vorhandenen Berichte wurden am 2026-09-09 erneut mit GitHub-main
verglichen und blieben byteidentisch; sie nennen den Ausbildungs-/Beispielscope
bereits ausdrücklich. Kein nachträgliches Umschreiben ihrer Abnahmen.
[Vergleichsnachweis](assurance-v013-seven-repository-verification.json).

*The original five reports were compared with GitHub main on 2026-09-09 and
matched exactly. They already state their educational/example scope; no
historical acceptance was rewritten.*

## Unveränderliche Paketbindung / Immutable package binding

| Feld / Field | Wert / Value |
|---|---|
| Release | [v0.1.3](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.3), Pre-Release |
| Tag-Commit | `0d03aa9ebe8f74a26e331815bca5609fb48d7a14` |
| ZIP SHA-256 | `9023b442b4d82e25bee5a7fe9b73efb7f591a4f265f54061ae6e4a56b9b5c75f` |
| Profil / Profile | 13 Presets; Assurance 15, Security Governance 10 |
| Owner / designated human technical reviewer | @hindermath |
| Neue technische Ausführung / New technical execution | Codex; no inferred human sign-off |

## Projekt-Evidence / Project evidence

| Ziel / Target | Kontext / Context | Bericht / Report | Geprüfte Lieferung / Verified delivery | Ergebnis / Result |
|---|---|---|---|---|
| TinyCalc | `2026-09-05-tinycalc-rl-se-self-assessment` | [v0.1.3-Feldbericht](https://github.com/hindermath/TinyCalc/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #74](https://github.com/hindermath/TinyCalc/pull/74), Merge `1aa45a86d8fd310bb2a848d96c8ce10bf5a7d9f7` | `ReleaseAccepted` |
| TinyPl0 | `2026-08-30-tinypl0-hardening` | [v0.1.3-Feldbericht](https://github.com/hindermath/TinyPl0/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #92](https://github.com/hindermath/TinyPl0/pull/92), Merge `a988d6418aeddf3e8979edb3f1e25275661bdf2a` | `ReleaseAccepted` |
| InventarWorkerService | `2026-08-30-secure-development-hardening` | [v0.1.3-Feldbericht](https://github.com/hindermath/InventarWorkerService/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #67](https://github.com/hindermath/InventarWorkerService/pull/67), Merge `73ceab5a9057afded9abc3b47f1b5ea2b1ddef96` | `ReleaseAccepted` |
| absdd-image-sandbox | `2026-08-30-gsdb-baseline-assessment` | [v0.1.3-Feldbericht](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #60](https://github.com/hindermath/absdd-image-sandbox/pull/60), Merge `d3731df24649cf189e3d97412c9285d3170c082a` | `ReleaseAccepted` |
| TuiVision | `2026-08-30-rl-se-checklist-self-review`; `2026-08-30-gsdb-spec-kit-intensive-review` | [v0.1.3-Feldbericht](https://github.com/hindermath/TuiVision/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #171](https://github.com/hindermath/TuiVision/pull/171), Merge `a58c202668209b3b0cf116bcc8a0b0c5d6ac5d9b` | `ReleaseAccepted` |
| home-baseline (Level 0) | `2026-09-09-home-baseline-assurance-v013` | [Level-0-Feldbericht](secure-development-assurance-v013-level0-field-test.md) | [PR #277](https://github.com/hindermath/home-baseline/pull/277), Merge `e0168c7dbd9510650cc4e4304f8efc46898cb425` | `ReleaseAccepted` |
| Agent Operations Cockpit | `2026-09-09-aoc-assurance-v013` | [AOC-Feldbericht](https://github.com/hindermath/agent-operations-cockpit/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #44](https://github.com/hindermath/agent-operations-cockpit/pull/44), Merge `49bfa60c4c74cc3225b49c308e80ef777827bdf6` | `ReleaseAccepted` |

Der [historische 5/5-Bericht vom 08.09.2026](https://github.com/hindermath/home-baseline/blob/8f6a6e626d1bdef617697f623257d058946a2b64/docs/maintenance/secure-development-assurance-v013-field-test-rollup.md)
bleibt einschließlich damaliger Findings und Liefernachweise erhalten.

*The immutable historical five-project report retains its findings and delivery
evidence. This extension adds two scoped consumers rather than replacing their
historical assessments.*

## Prüfungen, Findings und Lieferung / Checks, findings and delivery

Beide neuen Installationen sind bytegleich zum hashgeprüften ZIP. Exakte
13-Preset-Matrix in Bash/PowerShell, list/info/resolve/check, Status, vier
getrennte Gate-Reviews und rohe Vorher-/Nachher-Hashes bestehen. Die vollständige
installierte Runbook-Negativsuite, LF/CRLF/BOM-Parität und acht generierte
Befehlsoberflächen bestehen; negative Fixtures liefern erwartungsgemäß 2,
erfolgreiche Suites 0. Isolierte Disable/Enable/Remove-/Zwölf-Preset-/
Wiederinstallationsprüfungen sind in den Einzelberichten gebunden.

*Both new installations match the verified archive. Matrix, command resolution,
context/gate parity, raw-byte read-only proof, negative fixtures and generated
surface tests pass. Expected negative exits are 2, successful suites exit 0.
Composition checks use temporary copies.*

- Level 0: 29 erfolgreiche Checks auf Head
  `535b005d19336d3c46f6c1145cd5d6a23bbbf634`, einschließlich nativer
  Assurance-Regressionsprüfungen auf Linux/macOS/Windows. Vier Copilot-Hinweise
  zu fehlenden PowerShell-Beispielen behoben und erneut ausgeführt.
- Ein temporärer Git-Aufräumfehler in einem Wartungstest und der dadurch
  abgebrochene Matrix-Job bestanden Wiederholungen auf unverändertem Head.
  Kein technischer Bypass.
- AOC: 18 erfolgreiche Checks auf Head
  `6a4fb6a68573a8434b875c81e5709c123475779a`. Authoring-Vertrag,
  12 Authoring-Tests, sechs Gate-Invariantentests und die globale
  14-Intake-Bindung bestehen. Produktprüfungen bleiben mangels Scaffold N/A.
- AOC-Skriptreferenz nach Installation mit dem bestehenden Renderer aktualisiert.
  Copilots OpenCode-Hinweis wurde anhand der isolierten Fixture und des
  erfolgreichen Tests begründet verworfen; das Paket blieb unverändert.
- Beide temporären Kompositionstests bestätigen die bekannte CLI-Grenze:
  zwei Claude-Skills bleiben nach Remove zurück. Vollständige Deinstallation
  wird nicht behauptet; Wiederinstallation besteht. Kein CLI-Patch.
- Beide Merges nutzten den ausdrücklich genehmigten Bypass nur für formale
  Reviewer-Zustimmung nach erfolgreicher Technik-/Befundprüfung. Menschliche
  Pilot-/Projekt-/Releasefreigaben wurden nicht erteilt.
- Beide neuen Ziel-Repositories wurden nach Merge sauber auf main bei 0/0
  synchronisiert. Level-0-Home-Sync übertrug 15 manifestgebundene Dateien,
  einschließlich zuvor ausstehender kanonischer Guidance; Abschlusscheck
  meldete aktuell. Keine Evidence-/Preset-Quellen nach Home kopiert.
- AOCs lokaler Registereintrag verwendet jetzt das 13-Preset-Profil.
  Kein flottenweiter Profilwechsel oder Produktlauf.

*Level 0 passed 29 exact-head checks; AOC passed 18. Documentation findings
were addressed, a fixture-path false positive was adjudicated with executable
evidence, and temporary cleanup/cancellation failures passed reruns. The known
orphan-skill removal limit is retained. Only formal review approval was bypassed,
never technical gates. Both new targets were clean and synchronized; manifest
Home synchronization and AOC's scoped local profile registration completed.
No fleet-wide change or product run occurred.*

## Termine und Entscheidungsgrenzen / Dates and decision boundaries

| Bereich / Area | Festlegung / Rule |
|---|---|
| Bisherige fünf technische Feldtests / Original five | Wiedervorlage / review due `2027-09-08` bleibt erhalten / retained |
| Level 0 und AOC / New two | Ein Jahr nach Prüfung / one year after test: `2027-09-09` |
| Scope aller sieben / Scope review for all seven | `2026-12-31`, früher bei relevanter Änderung / earlier after material scope change |
| C5-Test / C5 testing | N/A im genehmigten Ausbildungs-Scope / outside approved educational scope |
| Menschliche Pilot-, Projekt- und allgemeine Freigabe / Human approvals | `Open`, keine Ableitung aus technischen Ergebnissen / never inferred |
| Regulatorische Aussagen / Regulatory claims | Keine neue rechtliche Freistellung oder Zertifizierungsbehauptung / no new legal exemption or certification claim |

Die genannten aktuellen Feldtest-Kontexte haben vier Ready-Gates und
technicalValidation=Fulfilled. Das gilt nicht pauschal für sämtliche
historischen Security-Kontexte eines Repositories. Frühere offene fachliche
Bewertungen bleiben offen; keine umfassende Risikofreiheit wird behauptet.

*The named current field-test contexts have four Ready gates and technical
validation fulfilled. This does not blanket-approve every historical security
context or resolve unrelated open findings.*

## Zentrale Entscheidungsgrenze / Central decision boundary

Die Community-Einreichung [github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455)
ist beim Abgleich am 2026-09-09 offen, mit `preset-submission`,
`triage-must-have` und `validation-passed`.
Die Katalog-PR-Erstellung ist laut
[Workflow-Bericht #4484](https://github.com/github/spec-kit/issues/4484)
durch eine Upstream-PR-Grenze blockiert. Das ist weder Ablehnung noch Aufnahme.

- Projektbezogene Feldtest-Empfehlungen: **7/7 ReleaseAccepted** im jeweiligen Scope.
- Zentrale Preset-Empfehlung: **noch nicht erstellt**.
- Nächste Aktion: Upstream-Ergebnis abwarten; erst dann gesondert die zentrale
  v0.1.3-Preset-Prüfung durchführen. Sie erhält genau eine Empfehlung:
  ReleaseAccepted, PatchRequired oder Blocked.
- Unverändert: Pre-Release, Community-Issue und Maintainer-Kommunikation.
  Kein automatischer Folgeauftrag oder geplanter Überwachungsjob.

*Seven scoped project recommendations do not decide central acceptance.
Upstream submission remains open with successful validation; its catalog PR
automation reports a PR-limit blockage. Await the upstream outcome before a
separate central review with one recommendation. No release mutation,
community message or automatic follow-up job is created.*

## Dokumentationsauswirkung / Documentation impact

UpdateRequired, sourceOnly. Kanonisch sind dieser Bericht, die Einzelberichte
und der [Rollout-Tracker](assurance-level2-rollout-2026-09-06.md).
Owner @hindermath; Leserpfad für Lernende, Maintainer und Reviewer:
Tracker -> Bericht -> konkreter Kontext/Runbook -> Prüfnachweise.
Deutsch zuerst, Englisch danach, textorientierte Tabellen und Links.
Diese abschließende Konsolidierung ändert keine Runtime; kein zusätzlicher
Home-Sync nötig. Statistik über den bestehenden Renderer.
[Tracking Level 0 #276](https://github.com/hindermath/home-baseline/issues/276)
und [AOC #43](https://github.com/hindermath/agent-operations-cockpit/issues/43)
werden erst nach Merge dieser Konsolidierung geschlossen.

*UpdateRequired, sourceOnly, with descriptive text-first navigation. This
final consolidation does not change runtime and requires no additional Home
sync. Close both tracking issues only after consolidation merges. Reassess
after package, source, evidence, scope, authority, date or upstream changes.*
