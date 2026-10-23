# Abschlussstand: Dokumentations-Patches der 14 stabilen Presets

Stand: 23. Oktober 2026, 21:41 UTC (23:41 MESZ). **Abgeschlossen: alle 15 PRs geliefert, alle 14 regulären Patch-Releases veröffentlicht und nachgeprüft.**

## Auftrag und Grenzen

Documentation Impact: **UpdateRequired**. Owner: Thorsten Hindermann. Dieser Bericht ist ein reiner Quellen- und Veröffentlichungsnachweis (`sourceOnly`), keine Installationsmatrix und kein Installed-Lock. Kanonisch sind die 14 Preset-Repositories, ihre freigegebenen Heads, GitHub-Checks, neuen Tags und Release-Notes. Zielgruppen und Leserpfade bleiben: alle vier IHK-IT-Berufe einschließlich aller Fachinformatik-Fachrichtungen sowie Entwickelnde ohne Spezialwissen; Deutsch zuerst und gleichwertiges Englisch; B2 und anwendbare WCAG 2.2 AA.

Der Nutzer hat alle 14 Dokumentations-PRs und Assurance #10 fachlich gesichtet und Lieferung per MergeAndSync mit Admin-Bypass nach grünen Checks sowie reguläre Patch-Veröffentlichungen ausdrücklich freigegeben. Der Bypass ersetzte keine technische Prüfung. Es gab keine offenen Review-Threads. Die freigegebenen Heads blieben unverändert.

**Nicht durchgeführt:** Verbraucher-Rollout oder -Installation, Home Runtime Sync, Änderungen operativer Profile/Installed-Locks, Community-Einreichungen oder Modellaufrufe. Die abgebrochene dynamische Routing-Neuentwicklung bleibt ausgeschlossen. Bestehende Tags, ZIPs und historische Evidence wurden nicht überschrieben. Neue Prüf-Installationen erfolgten nur in Wegwerfprojekten.

## Lieferung und Pakete

| Preset | Reguläres Release | Gelieferter Dokumentations-PR | Merge-Commit |
|---|---|---|---|
| Security | [0.7.3](https://github.com/hindermath/spec-kit-preset-security-governance/releases/tag/v0.7.3) | [#10](https://github.com/hindermath/spec-kit-preset-security-governance/pull/10) | [c66cabfb](https://github.com/hindermath/spec-kit-preset-security-governance/commit/c66cabfbfdde532994bd3c0e63ebf843dadfa1c0) |
| Secure Development Assurance | [0.1.7](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.7) | [#11](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/11) | [0f47996b](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/commit/0f47996be3b613b3ab26206b606f68e3acb44c30) |
| Architecture | [0.6.4](https://github.com/hindermath/spec-kit-preset-architecture-governance/releases/tag/v0.6.4) | [#12](https://github.com/hindermath/spec-kit-preset-architecture-governance/pull/12) | [bf2261d0](https://github.com/hindermath/spec-kit-preset-architecture-governance/commit/bf2261d0d7c31e1c892dfa2b9708e5978dd28a73) |
| iSAQB Architecture | [0.2.4](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/releases/tag/v0.2.4) | [#7](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/pull/7) | [1f5529d2](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/commit/1f5529d289b90c4c302e267c14d9bccab96d5e99) |
| A11Y | [0.4.5](https://github.com/hindermath/spec-kit-preset-a11y-governance/releases/tag/v0.4.5) | [#7](https://github.com/hindermath/spec-kit-preset-a11y-governance/pull/7) | [58f02a24](https://github.com/hindermath/spec-kit-preset-a11y-governance/commit/58f02a2496094a34e95c12a6160f970f99227720) |
| Cross-Platform | [0.2.4](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/releases/tag/v0.2.4) | [#6](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/pull/6) | [14e830b7](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/commit/14e830b7625b47dbc712989502f8c5ca0e3bbf57) |
| Agent Parity | [0.4.4](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/releases/tag/v0.4.4) | [#7](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/pull/7) | [ca4e9116](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/commit/ca4e9116a68472b336450d8f03a52e0264f5beb6) |
| Model Routing | [0.1.6](https://github.com/hindermath/spec-kit-preset-model-routing-governance/releases/tag/v0.1.6) | [#9](https://github.com/hindermath/spec-kit-preset-model-routing-governance/pull/9) | [99c7c13b](https://github.com/hindermath/spec-kit-preset-model-routing-governance/commit/99c7c13b3ef2e154cf4f62f43262ade3fbe8d2a9) |
| Intake Authoring | [0.3.9](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.9) | [#18](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/18) | [33845858](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/commit/33845858eff1cc6aa766012650491d53e1a88447) |
| Intake Review | [0.2.6](https://github.com/hindermath/spec-kit-preset-intake-review-governance/releases/tag/v0.2.6) | [#13](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/13) | [4838ab54](https://github.com/hindermath/spec-kit-preset-intake-review-governance/commit/4838ab546d4f6f6c892152469cf336297e303384) |
| Intake Sequencing | [0.2.10](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/releases/tag/v0.2.10) | [#15](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/15) | [ccb6c223](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/commit/ccb6c223c51ba685f650f2ce5238299cb73b1f31) |
| Autonomous Run | [0.4.6](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.4.6) | [#25](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/25) | [130a69dc](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/commit/130a69dc483fa27e3835640c87feb40b446bf4cc) |
| Parallel Autonomous Run | [0.2.8](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.8) | [#14](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/pull/14) | [63bbf78b](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/commit/63bbf78b51fe00385b34f52cc568dbf2928954ad) |
| Project Statistics | [0.1.2](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/releases/tag/v0.1.2) | [#8](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/pull/8) | [454554ba](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/commit/454554bafda574c1153e6be319c30e9787ac3867) |

Alle 14 Preset-Repositories stehen lokal auf sauberem `main`, jeweils exakt am Remote-Merge-Commit (`0/0`). Keine fremden Arbeitsänderungen wurden übernommen oder gelöscht. Die vollständigen freigegebenen Heads, Merge-/Tag-Commits, Archiv-URLs und SHA-256-Prüfsummen stehen in der [maschinell lesbaren Release-Evidence](preset-documentation-patch-releases-2026-10-23.json) sowie in den öffentlichen Release-Notes. Diese JSON-Datei ist ausdrücklich kein operatives Profil.

### Assurance-Reihenfolge und neue Basis

1. [Assurance #10](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/10): freigegebener Head `9559c827`, neun grüne Checks, Merge `ffb85613`.
2. Dokumentations-PR #11 auf main umgestellt. Dessen neue Basis war bytegleich zum geprüften #10-Head (`git diff --exit-code` ohne Abweichung). Der freigegebene Dokumentations-Head `85f589a6` blieb unverändert. Zusätzlicher lokaler Dokumentationstest: PASS; alle zwölf PR-Checks grün.
3. #11 per exaktem Head gemergt, finaler Merge `0f47996b`. Der [Merge-Workflow](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/40026661520) ist vollständig grün unter macOS/Linux/Windows; Windows endete nach 15 Minuten und 25 Sekunden erfolgreich. Auch die Merge-CI von #10 ist vollständig erfolgreich. Erst danach wurde v0.1.7 am 23.10.2026 um 21:41:13 UTC regulär veröffentlicht und erneut samt Archiv-Hash, Latest-Status und Commit-Bindung verifiziert.

### Native Nachweise

Die 14 Dokumentations-PRs hatten zusammen **81 erfolgreiche Checks**, einschließlich aller **42 Reader-Path-Checks** unter macOS/Linux/Windows. Assurance #10 hatte separat neun erfolgreiche Checks. Aktuelle Review-/Merge-Links stehen in den PRs, die Job-Links zusätzlich in der JSON-Evidence und den Release-Notes.

Für zwölf Presets wird durch den Merge kein Push-Workflow ausgelöst; hier wird kein zusätzlicher Plattform-Pass erfunden. Der [Statistik-Merge-Workflow](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/actions/runs/40026309269) ist an `454554ba` erfolgreich, einschließlich seiner drei nativen Jobs. Assurance-Merge-CI ist oben separat ausgewiesen.

## Paket- und Installationsprüfung

- Alle 14 neuen Tags wurden erst nach fehlender Versions-/Tag-Belegung am exakt freigegebenen Merge-Commit angelegt. Kein bestehendes Tag wurde verändert.
- Tatsächliche GitHub-Tag-ZIPs heruntergeladen und SHA-256 ermittelt. **Alle 604 Git-Dateien** stimmen bytegenau mit den jeweiligen Tag-Commits überein; unerwartete oder fehlende Dateien werden zurückgewiesen.
- Manifestversion, README und beide Nutzungsleitfäden stimmen mit dem Paket überein. Die Dokumentationsregression besteht auch aus den extrahierten Archiven.
- Jedes Paket über seine tatsächliche Tag-URL in ein eigenes Wegwerfprojekt installiert; `preset list`, `preset info`, genaue Version/Priorität und installierte Dokument-/Routing-Dateien geprüft.
- **Alle 145 deklarierten Nicht-Command-Vorlagen** mit `preset resolve` geprüft, einschließlich der inline deklarierten Sequencing-Vorlagen. Frühere Teilauflösung wurde vor Abschluss auf vollständige Abdeckung erweitert.
- Gemeinsame Installation aller 14 verifizierten Archiv-Inhalte im zusätzlichen Wegwerfprojekt: 14 korrekte Registry-Einträge, Prioritäten, alle Vorlagenauflösungen und **49 stabile Command-Deklarationen** geprüft. Keine Agenten-/Modellausführung.
- Gemeinsame Dokumentationsregression nach dem Merge: **262 Assertions bestanden**, stabile Schema-1.0-Verträge ohne stilles Auslassen fehlender Kataloge.
- Alle 14 veröffentlichten Releases sind regulär und als Latest bestätigt; ihre Archive wurden nach Veröffentlichung erneut heruntergeladen und lieferten dieselben SHA-256-Prüfsummen. Tag, Remote-main und lokales main stimmen überein. Assurance wurde erst nach seiner vollständig grünen Merge-CI veröffentlicht.

Installation und Komposition wurden lokal mit Spec Kit **0.12.8** auf macOS geprüft. Die nativen CI-Nachweise gelten nur für ihre tatsächlich ausgeführten Jobs und Quellenstände; sie sind keine neuen Produkt-/Feldtestläufe.

## Inhaltliche Änderungen und Grenzen der Abnahme

Der [Sammelsichtungsbericht](preset-documentation-closeout-review-2026-10-23.md) dokumentiert die Leserpfade, konkreten Korrekturen, Versionen und historischen Grenzen. Neu sind insbesondere die paarweisen Nutzungsleitfäden, klare Command-/Starter-Erklärungen, Fehlerhilfe, wahrheitsgemäße stabile Harness-Unterstützung und gemeinsame Intake-/Runner-Beispiele. Mindestversion, Beispielkombination und tatsächlich geprüfte historische Kombination bleiben getrennt.

Assurance erhält zusätzlich den gesondert freigegebenen stabilen Rollenvertrag aus #10: Status `fast-mechanical`, Review `frontier-reasoning`, Schema 1.0, fail-closed. Direkte Validator-Aufrufe bleiben modellfrei. Authoring erhält die bereits freigegebene Generator-/Vorgängerbindung; Sequencing bindet vorhandene Generator-Metadaten an sein Paket. Keine abgebrochene Routing-Engine und keine neuen menschlichen Freigaben werden dadurch eingeführt.

Die 28 gerenderten DE/EN-Leitfäden wurden strukturell geprüft; zwei visuelle Stichproben ergänzen diesen Nachweis. Nicht durchgeführt: vollständige Screenreader-, Braille-, umfassende Zoom/Reflow- und repräsentative Nutzendentests. Statische Tests und fachliche Diff-Abnahme sind keine pauschale B2-/WCAG-AA-Zertifizierung, Produkt-, Risiko-, Rechts- oder Zertifizierungsfreigabe.

Temporäre Netzwerk-/TLS-Fehler wurden durch lesende Nachprüfung geklärt; keine Veröffentlichung oder Tag-Änderung wurde blind wiederholt, kein Workflow neu gestartet und kein Validator abgeschwächt.

## Weiteres Vorgehen

Die beauftragten Quelllieferungen und Veröffentlichungen sind abgeschlossen. Es bleiben keine offenen Liefer-/Veröffentlichungsprüfungen aus diesem Auftrag. Rollout, Home Runtime Sync und Community-Einreichungen benötigen weiterhin getrennte Aufträge. Veröffentlichte Pakete sind dadurch nicht bereits in Level 0 oder Piloten installiert und nicht automatisch im Community-Katalog aufgenommen.

Dieser Bericht und sein JSON-Nachweis liegen zunächst als lokale Level-0-Quellenartefakte vor; damit werden keine weiteren, nicht gesichteten Level-0-Änderungen gemergt. Vorhandene lokale Auditberichte bleiben unverändert. Re-Evaluation bei neuem Head, verändertem Tag-/Archiv-Hash, neuem Befund oder gesondertem Folgeauftrag.

## English summary

All fourteen documentation PRs and Assurance prerequisite #10 were merged at their accepted exact heads after green checks, using the explicitly authorized admin bypass. All fourteen preset source repositories are clean on main at local/remote 0/0. All fourteen regular patch releases are published and reverified. Assurance publication followed the successful Windows merge regression; its separate prerequisite merge CI also passed. All fourteen actual tag archives, 604 Git files, 145 template resolutions, isolated URL installs and combined fourteen-preset installation/49 stable command declarations passed. Full hashes, commits and CI links are in the JSON evidence and release notes. No consumer rollout, Home Runtime sync, operational-profile/Installed-Lock update, community submission or model call occurred. No full B2/AA, product, risk, legal or certification acceptance is implied.
