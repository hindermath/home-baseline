# Sammelsichtung: Dokumentationsabschluss der 14 stabilen Presets

Nachtrag nach fachlicher Sammelsichtung: Alle 14 Dokumentations-PRs und Assurance #10 sind freigegeben und am exakten Head gemergt. Der aktuelle Liefer-/Veröffentlichungsstand steht im [Abschlussbericht](preset-documentation-patch-releases-2026-10-23.md). Die nachfolgende Matrix bleibt als historischer Stand vor der Lieferfreigabe erhalten; ihre offenen Freigabepunkte beschreiben nicht mehr den aktuellen Auftrag.

Stand: 2026-10-23, 17:28 UTC (19:28 MESZ). **Alle 81 Checks grün; vorbereitet, nicht gemergt oder veröffentlicht.**

## Entscheidung und Scope

Documentation Impact: **UpdateRequired**. Owner: Thorsten Hindermann. Kanonische Quellen: die 14 unten genannten Preset-Repositories, jeweils Manifest, stabile Routing-Verträge, Commands, Templates und vorhandene Validatoren. Dokumentklasse: Nutzungsanleitung und Maintainer-Prüfnachweis; Distributionsklasse dieser Übersicht: `sourceOnly`. Kein Home Runtime Sync.

Verbindliche Zielgruppe: alle vier IHK-IT-Berufe einschließlich aller vier Fachinformatik-Fachrichtungen sowie Entwickelnde ohne Spezialwissen. Deutsche Leitfäden zuerst, gleichwertige englische Sprachpartner, CEFR B2 und anwendbare WCAG 2.2 AA. Fachliche B2-/AA-Abnahme ist nicht durch statische Tests ersetzt.

**Hier pausiert die Umsetzung zur vereinbarten Sammelsichtung an den exakten Heads.** Keine neue Routing-Entwicklung, funktionale Änderungen, Modellaufrufe, Rollouts, Verbraucher-Installationen, operativen Profil-/Installed-Lock-Änderungen, Home Runtime Sync oder Community-Einreichungen. Frühere Bypass-Freigaben werden nicht wiederverwendet. Veröffentlichung bleibt hinter Sichtung, Lieferfreigabe und grünen einschlägigen Checks.

## Review-Matrix

Live-Nachprüfung mit gh: Alle 14 PRs sind offen, alle exakten Heads gegenüber der Sammelvorlage unverändert. Alle 81 aktuell gemeldeten Checks sind erfolgreich abgeschlossen: 0 offen, 0 fehlgeschlagen, 0 übersprungen. Darin enthalten sind alle 42 Reader-Path-Prüfungen unter macOS, Linux und Windows. Ergebnisse sind über die verlinkten PRs im Checks-Tab einsehbar. Keine alten fehlgeschlagenen Versuche als Pass gewertet. Eine vorübergehende TLS-Zeitüberschreitung bei der Autonomous-Abfrage wurde durch erneute lesende Abfrage geklärt; kein Workflow-Rerun.

Bei der Vorbereitung waren alle 14 Arbeitsbranches sauber und gegenüber dem explizit gefetchten jeweiligen Remote-Branch 0/0. Diese Nachprüfung hat keine Branches synchronisiert oder geändert. Manche Klone fetchen absichtlich nur main; daher erfolgte damals ein expliziter Ref-Vergleich statt einer Änderung der Fetch-Konfiguration. Fachliche Sammelsichtung und Lieferfreigabe bleiben trotz grüner CI offen.

| Preset | Kandidat | PR | Exakter Head | CI: grün / offen / rot |
|---|---|---|---|---|
| Security | 0.7.3 | [#10](https://github.com/hindermath/spec-kit-preset-security-governance/pull/10) | `9f1f0a2324204ff703409c24929dd2a0257acb3c` | 6 / 0 / 0 |
| Secure Development Assurance | 0.1.7 | [#11](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/11) | `85f589a607490f6238ba4bfecaac6b47ce2e02e4` | 12 / 0 / 0 |
| Architecture | 0.6.4 | [#12](https://github.com/hindermath/spec-kit-preset-architecture-governance/pull/12) | `38f5fd4191d9f4e71bc719ccf521125c63fe7401` | 6 / 0 / 0 |
| iSAQB Architecture | 0.2.4 | [#7](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/pull/7) | `af8c3d3f105a4189787a1f0649f2a6f463e00215` | 3 / 0 / 0 |
| A11Y | 0.4.5 | [#7](https://github.com/hindermath/spec-kit-preset-a11y-governance/pull/7) | `d392b960c48b99af8d614ff4e90d6fd0e0126dbc` | 3 / 0 / 0 |
| Cross-Platform | 0.2.4 | [#6](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/pull/6) | `1f468cb560bfbf08c36a5bc3e6286315e315a14c` | 3 / 0 / 0 |
| Agent Parity | 0.4.4 | [#7](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/pull/7) | `17e774522d4d08545b35c58377f1ef35e37b0a97` | 3 / 0 / 0 |
| Model Routing | 0.1.6 | [#9](https://github.com/hindermath/spec-kit-preset-model-routing-governance/pull/9) | `cc7fc652d7adb12229dd243d6ffe66448bf50f6f` | 3 / 0 / 0 |
| Intake Authoring | 0.3.9 | [#18](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/18) | `b1a113fd8c50909719f78683d34672158692a5d6` | 9 / 0 / 0 |
| Intake Review | 0.2.6 | [#13](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/13) | `77e21a0131d131f69b2741e5f2fca7715b3bcbaf` | 6 / 0 / 0 |
| Intake Sequencing | 0.2.10 | [#15](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/15) | `026f9e7908ff64db9aa18d50c3a5de487f70bcc3` | 6 / 0 / 0 |
| Autonomous Run | 0.4.6 | [#25](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/25) | `e65ecf42d36b24082d96d5b1d939c44e2e0f5eab` | 6 / 0 / 0 |
| Parallel Autonomous Run | 0.2.8 | [#14](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/pull/14) | `36ab26a6a3985a5195399f579814eaacf51b34ac` | 6 / 0 / 0 |
| Project Statistics | 0.1.2 | [#8](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/pull/8) | `3b048577eee5c723f60bbd1a084415330d0fcdf0` | 9 / 0 / 0 |

Alle 14: Documentation Impact `UpdateRequired`; Lieferung und Veröffentlichung ausstehend.

Assurance: [PR #10](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/10) bleibt unverändert offen am Head `9559c827b9baf14ccb9e0b96c558d55cd76661dc`; separat erneut geprüft: alle neun Checks grün, Review weiterhin erforderlich. Diese neun zählen nicht zu den 81 Checks der 14 Dokumentations-PRs. Der neue Dokumentations-PR #11 hat weiterhin den Branch `codex/assurance-stable-routing-v0.1.7` als Basis. Nach gesonderter Lieferung von #10 Basis auf main umstellen und neu prüfen. Nicht den Routing-Diff unbemerkt mitliefern.

Die App konnte 13 neue PRs anhängen. Beim letzten Anhang (Assurance #11) wurde das Chat-Limit von 100 Identitäten gemeldet; der PR ist erstellt und oben direkt verlinkt. Keine vorhandenen Anhänge wurden entfernt.

## Leserpfade und sachliche Korrekturen

In jedem Repository: README → `docs/user-guide.md` / `docs/user-guide.EN.md` → Beispiel, Begriffe, eigene Command-Rollen, Fehlerhilfe und verlinkte Starter/Referenzen. Zusätzlich Hilfelinks an bestehenden Command-/Markdown-Starterflächen; technische Bezeichner und historische Nachweise bleiben erhalten.

| Preset | Befund / Korrektur |
|---|---|
| Security | Explain secure-development/regulatory evidence and safe failure help without legal or product approval claims. |
| Secure Development Assurance | Explain status versus gate review, evidence binding and human decisions. Preserve PR #10 unchanged; this PR is stacked on its exact head. Retarget to main only after that prerequisite is delivered and revalidate. |
| Architecture | Explain architecture inputs, threat/cloud starters, applicability and evidence boundaries. |
| iSAQB Architecture | Explain architecture workflow and starter selection; preserve existing composition links and historical behaviour references. |
| A11Y | Explain actual audience (including IT systems electronics), accessibility evidence versus full AA acceptance and bilingual troubleshooting. |
| Cross-Platform | Explain Bash/PowerShell responsibilities, complete example and platform evidence limits. |
| Agent Parity | Qualify drift/synchronization claims: guidance supports checks, not an automatic parity guarantee; actual role contracts take precedence. |
| Model Routing | Correct five-harness support claims against the stable resolver: automatic profile rendering for Codex/Antigravity, no invented Claude/Copilot/OpenCode renderer. Separate metadata refresh from a potentially quota-consuming later runner preflight. No routing engine changes. |
| Intake Authoring | Use the joint documentation candidate cohort Authoring 0.3.9 / Review 0.2.6 / Sequencing 0.2.10; distinguish package/schema/receipt generator versions and historical evidence. |
| Intake Review | Use the joint documentation candidate cohort Authoring 0.3.9 / Review 0.2.6 / Sequencing 0.2.10; explain independent review and freshness without execution authority. |
| Intake Sequencing | Use the joint documentation candidate cohort Authoring 0.3.9 / Review 0.2.6 / Sequencing 0.2.10; explain eligibility versus execution and the receipt metadata binding. |
| Autonomous Run | Align README, first-use reader path and compatibility page. Distinguish minimum dependency, documentation target 0.4.6 / Parallel 0.2.8 and actual historical tested pairs. |
| Parallel Autonomous Run | Align README, first-use reader path and compatibility page. Distinguish minimum dependency, documentation target Autonomous 0.4.6 / Parallel 0.2.8 and actual historical tested pairs. |
| Project Statistics | Explain reproducible transparency, not measured AI productivity; label v0.1.0 delivery/field evidence historical. |

Alle Paket- und Schema-Versionen bleiben getrennt. Neun Manifeste erhöhen ausschließlich die Paketversion; fünf bereits vorbereitete Kandidatennummern werden weiterverwendet. Bei Sequencing folgt `generator.version` im bestehenden Receipt-Starter dem Paket 0.2.10; keine neuen Felder, Schemas, Statuswerte oder Validatorlogik. Die fünf bereits bestehenden Kandidaten-Releaseberichte bleiben unverändert. Neue Dokumentations-Kandidatenberichte sind keine Release-Abnahme.

## Prüfungen

- Eigene Dokumentationstests aller 14 Quellen: PASS; Manifest/Installationszeile, Sprachpartner, lokale Links, Anker, Codeblöcke, Rollen, aktuelle/historische Versionsaussagen und Negativfälle.
- Gemeinsamer Aufruf von Security: `pwsh -NoProfile -File tests/test-documentation-closeout.ps1 -CohortRoot /Users/thorstenhindermann/SpecKitPresetProjects`: **PASS, 262 Assertions**, alle 14 Routing-Dateien, **49 Manifest-Command-Deklarationen** ohne Auslassen fehlender Verträge. Schema 1.0, bekannte Rollen, fail-closed.
- PSScriptAnalyzer: alle 14 neuen PowerShell-Tests ohne Warnung/Fehler; Diff-Whitespaceprüfung: PASS.
- Dokumentationsrunde gegenüber den erfassten Basis-Commits: keine Änderungen in ausführbaren Preset-Skripten oder stabilen Routing-JSON-Dateien.
- Neue native Dokumentations-CI für macOS 15, Ubuntu 24.04 und Windows 2022. Aktuelle Resultate/Links in den PR-Checks; Matrix oben ist ein zeitgebundener Snapshot, kein dauerhafter Pass.

### Bestehende Regressionen (lokal)

- **Security:** `pwsh -NoProfile -File tests/test-regulatory-contract.ps1`: PASS (6 reviewed-input fixtures and 9 negatives). Only the existing expected package-version literal follows the candidate; no check removed.
- **Secure Development Assurance:** `test-secure-development-assurance.ps1`, `test-installed-surfaces.ps1`, `test-release-documentation.ps1`: PASS (including Bash/PowerShell parity, unchanged human decisions, installed Claude/Copilot/OpenCode surfaces and 17 release-documentation assertions). Stable routing delta remains in prerequisite PR #10.
- **Architecture:** `python3.14 tests/test-cloud-contract.py`: 6 tests PASS. Only the existing expected package-version literal follows the candidate; no assertion removed.
- **Model Routing:** `bash tests/test-model-routing-discovery.sh`: PASS discovery/refresh/status/ambiguity fixtures. A version-only Codex shim rejects every invocation except `--version`; no native inference or personal profile access.
- **Intake Authoring:** Existing template-integrity, governance-config, authoring-validator, lifecycle and release-documentation suites: PASS. Python 3.14 is selected only in the test child environment; no system toolchain changes.
- **Intake Review:** Existing governance-config and intake-review-validator suites: PASS, including series and negative cases.
- **Intake Sequencing:** Existing template-integrity, governance-config and sequencing-validator suites: PASS, including Bash/PowerShell parity and negatives. The existing receipt starter's generator.version follows 0.2.10; schema/fields/validators are unchanged.
- **Autonomous Run:** Existing Bash model-routing/evidence-integrity and release-documentation suites: PASS. No native agent process or model preflight invoked.
- **Parallel Autonomous Run:** Existing autonomous-preset-dependency, coordinator, consolidation-v2 and release-documentation suites: PASS. Deterministic fixtures, not a new live parallel campaign.
- **Project Statistics:** Existing statistics renderer (67 assertions), release-documentation (11 assertions) and committed-HEAD disposable installed-preset lifecycle: PASS. No consumer repository installation.

Für iSAQB, A11Y, Cross-Platform und Agent Parity bestehen keine weiteren paketlokalen ausführbaren Regressionen; die neuen Quellen-/Dokumentationsprüfungen wurden ausgeführt. Keine nicht ausgeführte Produkt-/Plattformprüfung behaupten.

### Rendering und Nachweisgrenzen

Alle 28 DE/EN-Leitfäden offline mit installiertem Pandoc und vorhandenem Chrome gerendert. Prüfpunkte: `lang`, genau eine Hauptüberschrift und sechs Abschnittsüberschriften, nicht leere Links, vorhandene Fragmentziele, Tabellenüberschriften und Tastaturfokus. Kein Dokumentüberlauf bei 320 Pixeln. Visuelle Stichprobe: deutscher Routing-Leitfaden bei 320 Pixeln und englischer Autonomous-Leitfaden bei 1000 Pixeln. Kein Browser-/Paketdownload, kein angemeldetes Browserprofil, externe Seitenanforderungen beim Renderlauf blockiert.

Das ist kein Nachweis der GitHub-CSS-Darstellung und keine vollständige WCAG-AA-, B2-, Screenreader-, Braille-, umfassende Zoom/Reflow- oder repräsentative Nutzendenprüfung. Die technischen Vertiefungen behalten Fachbezeichner; die äquivalenten Sprachpartner führen durch die tägliche Nutzung, ohne vollständige Übersetzung jedes technischen Identifiers zu behaupten.

### Gefundene und behobene Prüfprobleme

- Renderer schluckte Überschriften direkt nach HTML-Ankern: Leerzeile ergänzt, eigener Negativtest hinzugefügt.
- Neue Windows-Dokumentationsprüfung verwechselte CRLF mit falschem Manifest-Schema: LF/CRLF werden nun ausdrücklich geprüft; Schema 2.0 blockiert weiterhin. Ursprünglich rote Runs bleiben als fehlgeschlagen dokumentiert.
- Bestehende Security-/Architecture-Tests enthielten die vorherige Paketversion als Literal: ausschließlich erwartete Kandidatenversion aktualisiert.
- Sequencing-Integrität verlangte aktuelle Generator-/Paketbindung: nur vorhandenen Metadatenwert aktualisiert und vollständige bestehende Tests erneut bestanden.
- Vorläufige lokale Editier-/Testfehler wurden vor Commit korrigiert und nicht als Pass gewertet; ursprüngliche Manifest-Schemata und bestehende Kandidaten-Releaseberichte sind erhalten.

## Verbleibende Schritte nach Sammelsichtung

1. Exakte Heads fachlich sichten und Lieferung ausdrücklich freigeben. Offene native CI abwarten und Review-Befunde klären. Geänderte Heads erneut sichten.
2. Assurance #10 separat liefern; Dokumentations-PR auf main umstellen, endgültige Basis und CI erneut prüfen.
3. Erst dann exakte geprüfte Heads mergen und Default-Branches sauber 0/0 synchronisieren; Schutzsperren nicht eigenmächtig umgehen.
4. Abgenommene Patch-Pakete regulär veröffentlichen. Vorher Versionsbelegung erneut live prüfen; keine existierenden Tags/ZIPs überschreiben.
5. Tatsächliche Tag-Archive herunterladen, Manifest/Dokumentation/Commit/SHA-256 prüfen und nur in Wegwerfprojekten Installation, list/info/resolve testen. Erst dann vollständiger Source-only-Abschlussbericht mit Archive-Hashes.
6. Rollout, Home Runtime Sync, Verbraucherinstallation und Community-Einreichungen bleiben ausgeschlossen.

Eine kleine Erinnerung zu vollständigen Leserpfaden und getrennten Liefer-/Veröffentlichungs-/Rollout-/Einreichungsschritten wurde auf ausdrücklichen Wunsch im vorgesehenen Memory-Erweiterungsverzeichnis abgelegt. Bestehende lokale Auditberichte und frühere Evidence wurden nicht verändert.

## English summary

All 14 stable documentation candidates are committed, pushed and open for collected exact-head human review. Live refresh: all 81 current checks passed, including 42 macOS/Linux/Windows reader-path checks; no pending, failed or skipped checks. All heads remain unchanged. Paired German/English user guides cover audience, prerequisites, bounded examples, actual roles, troubleshooting and references. Local source/regression tests passed, including all 49 command declarations. No merge, publication, model calls, operational profiles, consumer rollout, Home Runtime sync or community submission has occurred. Assurance #11 remains stacked on the unchanged #10, whose nine separate checks also passed and whose review remains required. Full B2/AA and assistive-technology acceptance remain human/explicit test boundaries. Release archives and checksums will be verified only after approved delivery and publication.
