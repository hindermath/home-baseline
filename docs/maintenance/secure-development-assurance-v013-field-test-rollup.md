# Secure Development Assurance v0.1.3: Feldtestkonsolidierung / Field-Test Roll-up

Stand / State: 2026-09-08

## Ergebnis / Outcome

Alle fünf vorgesehenen Level-2-Feldtests sind abgeschlossen. Jeder
projektbezogene Bericht empfiehlt `ReleaseAccepted` für die technische
Funktionsfähigkeit des unveränderten Presets
`secure-development-assurance-governance` v0.1.3. Dieses 5/5-Ergebnis ist noch
keine zentrale v0.1.3-Preset-Abnahme: Sie wartet auf das Ergebnis der offenen
Community-Einreichung
[github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455) und wird
danach als gesonderte Prüfung mit genau einer Empfehlung dokumentiert.

*All five intended Level-2 field tests are complete. Each project report
recommends `ReleaseAccepted` for the technical behavior of the unchanged
`secure-development-assurance-governance` v0.1.3 preset. This 5/5 result is not
yet the central v0.1.3 preset acceptance: that decision waits for the outcome
of the open community submission
[github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455) and will
then be documented as a separate review with exactly one recommendation.*

## Unveränderliche Paketbindung / Immutable Package Binding

| Feld / Field | Wert / Value |
|---|---|
| Release | `v0.1.3`, Pre-Release |
| Tag-Commit | `0d03aa9ebe8f74a26e331815bca5609fb48d7a14` |
| ZIP SHA-256 | `9023b442b4d82e25bee5a7fe9b73efb7f591a4f265f54061ae6e4a56b9b5c75f` |
| Profil | 13 Presets; Assurance Priorität 15, Security Governance Priorität 10 |
| Test-Owner und technischer Reviewer | `@hindermath` |
| Delivery | `MergeAndSync`; Admin-Bypass nur für die formale Reviewer-Hürde nach grünen technischen Checks |

## Projekt-Evidence / Project Evidence

| Ziel / Target | Kontext / Context | Bericht / Report | Geprüfte Lieferung / Verified delivery | Ergebnis / Result |
|---|---|---|---|---|
| TinyCalc | `2026-09-05-tinycalc-rl-se-self-assessment` | [v0.1.3-Feldbericht](https://github.com/hindermath/TinyCalc/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #74](https://github.com/hindermath/TinyCalc/pull/74), Merge `1aa45a86d8fd310bb2a848d96c8ce10bf5a7d9f7` | `ReleaseAccepted` |
| TinyPl0 | `2026-08-30-tinypl0-hardening` | [v0.1.3-Feldbericht](https://github.com/hindermath/TinyPl0/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #92](https://github.com/hindermath/TinyPl0/pull/92), Merge `a988d6418aeddf3e8979edb3f1e25275661bdf2a` | `ReleaseAccepted` |
| InventarWorkerService | `2026-08-30-secure-development-hardening` | [v0.1.3-Feldbericht](https://github.com/hindermath/InventarWorkerService/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #67](https://github.com/hindermath/InventarWorkerService/pull/67), Merge `73ceab5a9057afded9abc3b47f1b5ea2b1ddef96` | `ReleaseAccepted` |
| absdd-image-sandbox | `2026-08-30-gsdb-baseline-assessment` | [v0.1.3-Feldbericht](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #60](https://github.com/hindermath/absdd-image-sandbox/pull/60), Merge `d3731df24649cf189e3d97412c9285d3170c082a` | `ReleaseAccepted` |
| TuiVision | `2026-08-30-rl-se-checklist-self-review`; `2026-08-30-gsdb-spec-kit-intensive-review` | [v0.1.3-Feldbericht](https://github.com/hindermath/TuiVision/blob/main/docs/maintenance/secure-development-assurance-v013-field-test.md) | [PR #171](https://github.com/hindermath/TuiVision/pull/171), Merge `a58c202668209b3b0cf116bcc8a0b0c5d6ac5d9b` | `ReleaseAccepted` |

Alle fünf Repositories waren nach dem Merge auf ihrem lokalen `main` sauber
und gegenüber `origin/main` bei `0/0`. Die jeweiligen Pull Requests sind die
autoritative Quelle für Exact-Head-Checks, Reviewverlauf und den finalen
Merge-Commit.

*After merge, all five repositories had a clean local `main` at `0/0` against
`origin/main`. Their pull requests are authoritative for exact-head checks,
review history, and final merge commits.*

## Gemeinsamer Prüfstand / Common Verification State

- Exakte 13-Preset-Installation und `CheckOnly` unter Bash und PowerShell.
- `preset list`, `preset info`, Auflösung des Evidence-Vertrags und
  `specify check`.
- Positiver Status sowie vier getrennte Gate-Reviews je aktivem Kontext.
- Geforderte Negativfälle mit sicherer Blockierung und Exitcode 2; vollständige
  Negativsuite jeweils erfolgreich mit Exitcode 0.
- LF-, CRLF- und BOM-Parität sowie unveränderte rohe Evidence-Hashes nach
  Status- und Reviewläufen.
- Temporäre Kompositionsprüfung mit Disable, Enable, Remove, gültigem
  12-Preset-Profil und Wiederinstallation aus dem unveränderlichen Tag-ZIP.
- Repositoryeigene Restore-, Build-, Test-, Dokumentations-, Secret- und
  Supply-Chain-Gates entsprechend dem jeweiligen Projektumfang.

*The common verification covers the exact 13-preset profile in Bash and
PowerShell, list/info/contract resolution/check, positive status and four
separate gate reviews per active context, fail-closed negative cases, line
ending/BOM parity, read-only hash proof, isolated composition, immutable ZIP
reinstallation, and each repository's applicable product and governance CI.*

## Findings und begrenzte Korrekturen / Findings and Bounded Corrections

- TinyCalc wurde von v0.1.3 zunächst korrekt blockiert, weil der historische
  Verzeichnisname nicht der vollständigen `contextId` entsprach. Der
  projektgeführte Kontext und seine Bindungen wurden korrigiert; der
  Preset-Validator blieb unverändert.
- TuiVision erkannte nach der regulatorischen Scope-Aktualisierung einen
  veralteten EVD-038-Hash. Nur diese technische Bindung und ihre abhängigen
  Hashnachweise wurden mit Alt-/Neu-Provenienz erneuert; die 157 historischen
  Kontrollbewertungen und menschlichen Entscheidungen blieben unverändert.
- Externe Review-Provider waren bei einzelnen PRs zeitweise nicht verfügbar.
  Admin-Bypass wurde gemäß Autorisierung ausschließlich nach grünen
  Exact-Head-Technikchecks und dokumentierter Befundprüfung für die formale
  Reviewer-Hürde verwendet; er ersetzte keinen technischen Check.

*TinyCalc exposed and corrected a project-owned context-directory mismatch;
TuiVision exposed and narrowly rebound stale EVD-038 provenance. Neither case
required a preset patch or changed historical control ratings or human
decisions. Intermittent external review-provider failures were not treated as
technical success; the authorized admin bypass covered only the formal review
barrier after green exact-head checks and documented finding review.*

## Gemeinsame Grenzen und Termine / Shared Boundaries and Dates

- Alle aktiven Kontexte: Baseline, Delta, Closure und Image Impact `Ready`;
  `technicalValidation=Fulfilled`.
- Technische Evidence-Wiedervorlage: `2027-09-08`.
- C5: `N/A` für den aktuellen nichtkommerziellen Ausbildungs- und
  Beispielscope. GitHub, CI und Artefakthosting sind Entwicklungsinfrastruktur,
  keine Cloud-Produktlaufzeit der Beispielprogramme.
- CRA und formale Produktkonformität: `N/A` für den aktuellen Scope.
  Regulatorische Scope-Wiedervorlage: `2026-12-31`, früher nur bei
  kommerzieller Nutzung, Marktbereitstellung, Kundenübergabe,
  Supportvertrag, relevantem Cloud-Scope oder geänderter Hersteller- bzw.
  Steward-Rolle.
- `pilotAuthorization`, `projectAcceptance` und `generalRelease`: `Open`.
- Keine Projekt-, Produkt-, Image-, Risiko-, C5-, Konformitäts-, Testat- oder
  Zertifizierungsentscheidung wird aus dem Projekturteil abgeleitet.

*All active contexts have four `Ready` gates and
`technicalValidation=Fulfilled`; technical evidence review is due on
`2027-09-08`. C5, CRA, and formal product conformity are `N/A` for the current
non-commercial educational/example scope, with regulatory scope review due on
`2026-12-31` or earlier only after a listed scope-changing event. Human pilot,
project, and general-release decisions remain `Open`; no wider approval is
inferred.*

## Zentrale Entscheidungsgrenze / Central Decision Boundary

Die Live-Prüfung am 2026-09-08 ergab für
[github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455) den
Status `OPEN` ohne Maintainer-Kommentar. Deshalb gilt zentral:

- Projekt-Feldtests: `5/5 ReleaseAccepted` für Preset v0.1.3.
- Zentrale Preset-Empfehlung: noch nicht erstellt.
- Nächster Schritt: Upstream-Ergebnis abwarten und danach eine gesonderte
  v0.1.3-Preset-Prüfung durchführen.
- Nicht ausgeführt: Änderung des Pre-Release-Status, weitere
  Community-Einreichung, Maintainer-Kommentar oder Zertifizierungsbehauptung.

*At the 2026-09-08 live check, upstream issue #4455 was `OPEN` without a
maintainer comment. Project field tests are therefore 5/5 `ReleaseAccepted`,
while the central preset recommendation remains uncreated pending the upstream
outcome. No pre-release mutation, duplicate submission, maintainer message, or
certification claim is part of this roll-up.*

## Dokumentationsauswirkung / Documentation Impact

Entscheidung: `UpdateRequired`. Dieser `sourceOnly`-Bericht und der zentrale
Rollout-Tracker sind die kanonische 5/5-Navigation für Maintainer, technische
Reviewer und Lernende. Es gibt keine Runtime-Verteilung und keinen Home-Sync.
Neu zu bewerten ist bei Änderung von Preset/Tag/Archiv, Projektbericht,
Merge-Evidence, Scope, Entscheidungsstatus, Prüftermin oder Issue #4455.

*Decision: `UpdateRequired`. This source-only report and the central rollout
tracker provide the canonical 5/5 path for maintainers, technical reviewers,
and learners. No runtime distribution or Home sync is required. Re-evaluate
when the package, project evidence, scope, decision state, review date, or
issue #4455 changes.*
