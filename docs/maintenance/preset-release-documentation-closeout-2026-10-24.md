# Veröffentlichungsstatus und Verbesserungen der 14 stabilen Presets

Stand / As of: 2026-10-24T12:07:14.5458540+00:00. Documentation Impact: UpdateRequired. Owner: Thorsten Hindermann.

## Ergebnis und sichere nächste Aktion / Result and next safe action

Alle 14 genannten Pakete sind regulär veröffentlicht; Tag-Commits und frisch heruntergeladene Archive stimmen mit den bisherigen SHA-256-Nachweisen überein. Die Quellenkorrekturen trennen diesen Stand von historischen Kandidatentexten und neuen Dokumentations-PRs. Alle 14 PRs sind für die gesammelte fachliche Sichtung vorbereitet; kein Merge und keine erneute Veröffentlichung durch diesen Auftrag.

<div lang="en">

All fourteen packages are regular published releases. Tag commits and freshly downloaded archives match the existing SHA-256 evidence. Source corrections separate publication from historical candidate text and new documentation PRs. Fourteen PRs are prepared for collected human review; this task merges or republishes nothing.

</div>

[#342: Veröffentlichungsstatus](https://github.com/hindermath/home-baseline/issues/342) und [#343: Verbesserungsprofile](https://github.com/hindermath/home-baseline/issues/343). [JSON-Nachweis / JSON evidence](preset-release-documentation-closeout-2026-10-24.json).

Leserpfad / Reader path: [README](../../README.md) → Übersicht → einzelnes Verbesserungsprofil → unveränderliche Quellen → exakter neuer PR-Head. Ein Beleg (Evidence) ist ein überprüfbarer Nachweis, keine automatische Freigabe.

Zielgruppe: alle vier IHK-IT-Berufe einschließlich aller vier Fachinformatik-Fachrichtungen sowie Entwickelnde ohne Spezialwissen. Deutsch zuerst, gleichwertiges Englisch; CEFR B2 und anwendbare WCAG 2.2 AA sind Ziele für die Sichtung, keine automatische Abnahme.

<div lang="en">

Audience: all four IHK IT occupations, all four IT specialist disciplines, and non-specialist developers. German first and equivalent English. B2 and applicable WCAG 2.2 AA remain review targets, not automatic acceptance. Follow the overview, individual profile, immutable sources and exact new PR head.

</div>

## Gemeinsamer Dokumentationsvertrag / Shared documentation contract

- candidate_status = HistoricalCandidate: ursprünglicher Vorbereitungsstand; alte Aussagen und Prüfgrenzen bleiben im abgegrenzten historischen Abschnitt erhalten.
- release_status = Published: tatsächliches reguläres GitHub Release mit Tag-/Commit-Bindung. Tagexistenz ohne Release-Nachweis ist TagOnly mit offener Evidence, kein vollständiger Abschluss.
- Archivstatus Verified verlangt echten SHA-256-Nachweis und Prüfdatum. Fehlende Archiv-Evidence bleibt offen; sie wird nicht mit dem Veröffentlichungsstatus verwechselt.
- Der historische Text wird gegen den wirklichen Tag-Blob geprüft, nicht nur gegen einen frei änderbaren Text-Hash. LF/CRLF/BOM werden nach dem dokumentierten Normalisierungsvertrag behandelt.
- Neue main-Dokumentation verändert das veröffentlichte ZIP nicht. Paketversionen, Schema-/Generatorversionen, Katalogaufnahme und Consumer-Installation bleiben getrennt.

<div lang="en">

candidate_status records historical preparation only. release_status records evidenced publication; a tag alone is TagOnly with open evidence. Archive verification is separate and needs an actual hash/date. Historical text is checked against the tag blob. New main documentation changes no published archive. Package, schema/generator, catalogue and consumer states remain separate.

</div>

## PR- und Abschlussmatrix / PR and completion matrix

CI-Werte sind zeitgebundene Beobachtungen am angegebenen Head, keine menschliche Abnahme. Vollständige Heads und Check-Links stehen im JSON. Neuer Merge-Commit bleibt Open, bis eine gesondert freigegebene Lieferung erfolgt.

CI states are observations at the listed heads, not human acceptance. Full heads and check links are in the JSON; new merge commits remain Open until separately approved delivery.

| Preset | Paket / Package | Dokumentations-PR / Documentation PR | Head | Neue CI / New CI | Neuer Merge / New merge |
|---|---|---|---|---|---|
| Security | 0.7.3, Published | [#11](https://github.com/hindermath/spec-kit-preset-security-governance/pull/11) | 2017c36b5e47 | Passed | Open |
| Secure Development Assurance | 0.1.7, Published | [#12](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/12) | 16c29d3ece1f | Passed | Open |
| Architecture | 0.6.4, Published | [#13](https://github.com/hindermath/spec-kit-preset-architecture-governance/pull/13) | 85fc7ba8095b | Passed | Open |
| iSAQB Architecture | 0.2.4, Published | [#8](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/pull/8) | 1b396cb68ad6 | Passed | Open |
| A11Y | 0.4.5, Published | [#8](https://github.com/hindermath/spec-kit-preset-a11y-governance/pull/8) | 3900e4afa2bf | Passed | Open |
| Cross-Platform | 0.2.4, Published | [#7](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/pull/7) | a0e75e63fea0 | Passed | Open |
| Agent Parity | 0.4.4, Published | [#8](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/pull/8) | 14ba10bc5b4c | Passed | Open |
| Model Routing | 0.1.6, Published | [#10](https://github.com/hindermath/spec-kit-preset-model-routing-governance/pull/10) | 67f9ac8b77dc | Passed | Open |
| Intake Authoring | 0.3.9, Published | [#19](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/19) | 96feada71992 | Passed | Open |
| Intake Review | 0.2.6, Published | [#14](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/14) | e3dc5402d2dd | Passed | Open |
| Intake Sequencing | 0.2.10, Published | [#16](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/16) | 488db2eaaee5 | Passed | Open |
| Autonomous Run | 0.4.6, Published | [#26](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/26) | dcab1677c90f | Passed | Open |
| Parallel Autonomous Run | 0.2.8, Published | [#15](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/pull/15) | 965018d48e9e | Passed | Open |
| Project Statistics | 0.1.2, Published | [#9](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/pull/9) | 4f0207b3ac2a | Passed | Open |

## Verbesserungsprofile / Improvement profiles

Fachlicher Vertrag, Validatorverhalten, Kompatibilität/Integration, Dokumentation/Bedienbarkeit, Regression und Feldnachweis werden getrennt bewertet. Der letzte Dokumentationspatch erhält keine pauschale Zuschreibung aller früheren Änderungen.

Professional contracts, validator behavior, compatibility/integration, usability, regression and field evidence are assessed separately. Earlier changes are not all attributed to the latest documentation patch.

### Security v0.6.2 → v0.7.3

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-security-governance/compare/1b5e9e309d86b09aa74f036f3d7ed5829f34257b...c66cabfbfdde532994bd3c0e63ebf843dadfa1c0); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-security-governance/blob/2017c36b5e47ecd4fc16ca1e2cf5ae7a3dedf3d7/docs/release-0.7.3-validation.md).

Ausgang / from: 1b5e9e309d86b09aa74f036f3d7ed5829f34257b. Release / to: c66cabfbfdde532994bd3c0e63ebf843dadfa1c0. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-security-governance/releases/tag/v0.7.3). Archiv-SHA-256 / archive SHA-256: e43fdbc3af2334182ded8908f160313dc085882faf96532f29bfffbb7cfd8f9d.

- v0.7.0 [ProfessionalContract]: Regulatorische Fragen brauchten getrennte Anwendbarkeits- und Zuständigkeitsnachweise. DS-GVO, KI-VO, CRA, NIS2 und DORA werden nach Produkt, Entwicklungswerkzeug und Organisation getrennt eingeordnet; offene Fragen bleiben sichtbar. Nutzen: Lernende können begründen, was gilt und wer entscheiden muss; Ausbildung ist keine pauschale Ausnahme.
- v0.7.1 [Compatibility]: Der Installationsbefehl war nicht direkt als eine Zeile auswertbar. Installationszeile und passende Dokumentationsprüfung wurden abgestimmt; 0.7.2 präzisierte den Einstieg weiter. Nutzen: Ein kopierbarer Einstieg vermeidet Formatierungsfehler, ohne Sicherheitsergebnisse vorwegzunehmen.
- v0.7.3 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.7.0 [ProfessionalContract]: Regulatory questions needed separate applicability and ownership evidence. GDPR, AI Act, CRA, NIS2 and DORA are assessed separately for product, development tooling and organisation; open questions stay visible. Benefit: Learners can explain applicability and who must decide; education is not a blanket exemption.
- v0.7.1 [Compatibility]: The installation command was not directly usable on one line. The install line and its documentation test were aligned; 0.7.2 further clarified the entry point. Benefit: A copyable entry point avoids formatting errors without claiming security acceptance.
- v0.7.3 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Secure Development Assurance v0.1.3 → v0.1.7

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/compare/0d03aa9ebe8f74a26e331815bca5609fb48d7a14...0f47996be3b613b3ab26206b606f68e3acb44c30); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/blob/16c29d3ece1f040f69b0f76f22e4fedeb5bd9b5c/docs/release-0.1.7-validation.md).

Ausgang / from: 0d03aa9ebe8f74a26e331815bca5609fb48d7a14. Release / to: 0f47996be3b613b3ab26206b606f68e3acb44c30. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.7). Archiv-SHA-256 / archive SHA-256: 0b1352fad73970c6bc12d77bc4b687dde8db36a02ee1f73ed97289bb16134b35.

- v0.1.5 [ValidatorRuntime]: Aktive Dokumentmetadaten mussten von historischen oder rein erzählenden Angaben unterschieden werden. Aktive Versions-/Quellenbindungen werden strenger geprüft. Unpassende aktuelle Metadaten blockieren; historische Aussagen bleiben begrenzt. Nutzen: Veraltete aktuelle Evidence wird nicht versehentlich als passend behandelt.
- v0.1.7 [Integration]: Die zwei Assurance-Commands hatten keinen ausdrücklich registrierten stabilen Routing-Vertrag. Schema 1.0 bindet Status an fast-mechanical und Review an frontier-reasoning, mit fail-closed und isolierten Kompositionstests. Die Vorbereitung 0.1.6 in PR #9 erhielt keinen eigenen Tag; sie ist in 0.1.7 enthalten. Nutzen: Agentenarbeit kann den stabilen gemeinsamen Vertrag auflösen; direkte Validatoren bleiben modellfrei und erteilen keine menschliche Freigabe.
- v0.1.7 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.1.5 [ValidatorRuntime]: Active document metadata needed to be distinguished from historical or narrative text. Active version/source bindings are checked more strictly. Mismatched current metadata blocks; historical statements retain their scope. Benefit: Stale active evidence is not accidentally accepted.
- v0.1.7 [Integration]: The two Assurance commands lacked an explicitly registered stable routing contract. Schema 1.0 binds status to fast-mechanical and review to frontier-reasoning, with fail-closed behavior and isolated composition tests. The 0.1.6 preparation in PR #9 received no separate tag; it is included in 0.1.7. Benefit: Agent work can resolve the shared stable contract; direct validators remain model-free and grant no human approval.
- v0.1.7 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Architecture v0.5.2 → v0.6.4

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-architecture-governance/compare/45b7cd667e25d3ec22a14fc9f17a085b507b7bfe...bf2261d0d7c31e1c892dfa2b9708e5978dd28a73); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-architecture-governance/blob/85fc7ba8095bc4f9fce9d0343d5bd20965bcb659/docs/release-0.6.4-validation.md).

Ausgang / from: 45b7cd667e25d3ec22a14fc9f17a085b507b7bfe. Release / to: bf2261d0d7c31e1c892dfa2b9708e5978dd28a73. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-architecture-governance/releases/tag/v0.6.4). Archiv-SHA-256 / archive SHA-256: 020349ca49db89c655762b1cc1ce86d5f40ea0e4b2f598aac443ed6e0dbdc6e4.

- v0.6.0 [ProfessionalContract]: Cloud-Autonomie und Provider-Nachweise waren nicht gleich präzise strukturiert. C3A-Kriterien und C5-Evidence wurden explizit; Zeitpunkt, Prüfzeitraum und Wirksamkeit werden getrennt. Nutzen: Architekturentscheidungen lassen sich an konkrete Kriterien und echte Provider-Evidence binden.
- v0.6.1 [ProfessionalContract]: Datenschutz- und Resilienzfragen benötigten klarere Entscheidungsgrenzen. Vorlagen und Architekturhinweise ergänzen Datenschutz, Resilienz und begrenzte Nachweisaussagen; 0.6.2 korrigierte den Installationsbefehl. Nutzen: Offene Architekturfragen werden benannt, statt eine bestandene Provider- oder Produktprüfung zu behaupten.
- v0.6.4 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.6.0 [ProfessionalContract]: Cloud autonomy and provider evidence lacked equally precise structure. C3A criteria and C5 evidence became explicit; as-of-date, review period and effectiveness remain distinct. Benefit: Architecture decisions can be linked to concrete criteria and actual provider evidence.
- v0.6.1 [ProfessionalContract]: Privacy and resilience needed clearer decision boundaries. Templates and guidance add privacy, resilience and bounded evidence claims; 0.6.2 corrected the install command. Benefit: Open architecture questions remain visible instead of implying provider or product acceptance.
- v0.6.4 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### iSAQB Architecture v0.2.2 → v0.2.4

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/compare/55431d0059946a978ea6c3a5f0c866f187117378...1f5529d289b90c4c302e267c14d9bccab96d5e99); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/blob/1b396cb68ad6d01de453a5bd300db10d41272bd7/docs/release-0.2.4-validation.md).

Ausgang / from: 55431d0059946a978ea6c3a5f0c866f187117378. Release / to: 1f5529d289b90c4c302e267c14d9bccab96d5e99. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/releases/tag/v0.2.4). Archiv-SHA-256 / archive SHA-256: ad9802cb23ea2ef604098bea1b0e297cbaf0badcd56ba87541706d45910605ba.

- v0.2.3 [DocumentationUsability]: Automatische Ergänzungen und bewusst auszuwählende Starter waren schwer auseinanderzuhalten. Acht Architektur-Starter, der Ablauf Specify–Plan–Tasks und ein Beispiel asynchroner Verarbeitung werden erklärt; Kombination und Prioritäten sind sichtbar. Nutzen: Lernende wählen eine passende Vorlage ausdrücklich, statt automatische Vorlagenauswahl oder Architekturabnahme zu erwarten.
- v0.2.4 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.2.3 [DocumentationUsability]: Automatic addenda and explicitly selected starters were hard to distinguish. Eight architecture starters, Specify–Plan–Tasks and an asynchronous-processing example are explained; composition and priorities are visible. Benefit: Learners explicitly choose a suitable starter rather than expecting automatic template selection or architecture acceptance.
- v0.2.4 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### A11Y v0.4.3 → v0.4.5

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-a11y-governance/compare/c8e0352f30c7e060b03d55cd112755c01cf58bb3...58f02a2496094a34e95c12a6160f970f99227720); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-a11y-governance/blob/3900e4afa2bff9e85fbd8578734765e1a2fc1f2d/docs/release-0.4.5-validation.md).

Ausgang / from: c8e0352f30c7e060b03d55cd112755c01cf58bb3. Release / to: 58f02a2496094a34e95c12a6160f970f99227720. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-a11y-governance/releases/tag/v0.4.5). Archiv-SHA-256 / archive SHA-256: 764823f359f0071a165020e3b19957cc48ea8a815764bc0df3ed0c64a4cf699d.

- v0.4.4 [DocumentationUsability]: Einstieg, Komposition und menschliche A11Y-Entscheidungen waren nicht hinreichend getrennt erklärt. Der Einstieg wurde präzisiert; 0.4.5 ergänzt DE-/EN-Leserpfade, passende Beispiele und Dokumentationsregressionen. Nutzen: Anwendende können Prüfungen vorbereiten, ohne automatische WCAG-Konformität oder Zertifizierung zu erwarten.
- v0.4.5 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.4.4 [DocumentationUsability]: Entry points, composition and human accessibility decisions needed clearer explanation. The entry point was clarified; 0.4.5 adds DE/EN reader paths, examples and documentation regressions. Benefit: Users can prepare checks without expecting automatic WCAG conformance or certification.
- v0.4.5 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Cross-Platform v0.2.2 → v0.2.4

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/compare/a4aa280b417cb37afd64795294f3fcd67c9e546b...14e830b7625b47dbc712989502f8c5ca0e3bbf57); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/blob/a0e75e63fea0a11fbb78012aec6466281b126390/docs/release-0.2.4-validation.md).

Ausgang / from: a4aa280b417cb37afd64795294f3fcd67c9e546b. Release / to: 14e830b7625b47dbc712989502f8c5ca0e3bbf57. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/releases/tag/v0.2.4). Archiv-SHA-256 / archive SHA-256: 0dfa8cfaeb317f1847462c48a3a1d83389e668256abd6f508ee6d89e452d5456.

- v0.2.3 [DocumentationUsability]: Shell-Parität und tatsächlich native Plattformnachweise waren leicht zu verwechseln. Die Anleitung wurde präzisiert; 0.2.4 ergänzt gleichwertige Leserpfade, Beispielhilfe und CRLF-tolerante Dokumentationsprüfungen. Nutzen: Bash-/PowerShell-Parität wird nicht als Nachweis einer ungeprüften Plattform ausgegeben.
- v0.2.4 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.2.3 [DocumentationUsability]: Shell parity and actual native platform evidence were easy to confuse. Guidance was clarified; 0.2.4 adds equivalent reader paths, example help and CRLF-tolerant documentation tests. Benefit: Bash/PowerShell parity is not presented as proof of an untested platform.
- v0.2.4 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Agent Parity v0.4.2 → v0.4.4

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/compare/fe9e8e175c2974ca95a700cb70dfa82fc6b24cb0...ca4e9116a68472b336450d8f03a52e0264f5beb6); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/blob/14ba10bc5b4c40313757d997e70b013110a9f59a/docs/release-0.4.4-validation.md).

Ausgang / from: fe9e8e175c2974ca95a700cb70dfa82fc6b24cb0. Release / to: ca4e9116a68472b336450d8f03a52e0264f5beb6. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/releases/tag/v0.4.4). Archiv-SHA-256 / archive SHA-256: 2c752eea241b359c0dce808c95cf750bd0116fe2470e2bce6edfb1aff1a8d020.

- v0.4.3 [DocumentationUsability]: Gemeinsame Guidance und agentenspezifische Metadaten brauchten klarere Anwendungshinweise. Anwendung und Komposition werden verständlicher; 0.4.4 ergänzt DE-/EN-Leserpfade und entsprechende Dokumentationsregression. Nutzen: Eine gleiche Vertragsgrundlage wird von unterschiedlicher Agenten-Darstellung getrennt; Installation startet keine Arbeit.
- v0.4.4 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.4.3 [DocumentationUsability]: Shared guidance and agent-specific metadata needed clearer usage guidance. Usage and composition become clearer; 0.4.4 adds DE/EN reader paths and matching documentation regression. Benefit: A shared contract is distinguished from different agent presentation; installation starts no work.
- v0.4.4 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Model Routing v0.1.4 → v0.1.6

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-model-routing-governance/compare/6e000cce39aebc9ff2b8a4e401080a13f461f830...99c7c13b3ef2e154cf4f62f43262ade3fbe8d2a9); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-model-routing-governance/blob/67f9ac8b77dc8cbffc11baad7b8698acd2ee4f3e/docs/release-0.1.6-validation.md).

Ausgang / from: 6e000cce39aebc9ff2b8a4e401080a13f461f830. Release / to: 99c7c13b3ef2e154cf4f62f43262ade3fbe8d2a9. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-model-routing-governance/releases/tag/v0.1.6). Archiv-SHA-256 / archive SHA-256: 94648588b4e6ec8c839da579d7321026821fa2cf4378db05c6ad3cdd4dc05dad.

- v0.1.6 [DocumentationUsability]: Policy-Namen konnten als vollständig implementierte Harness-Adapter missverstanden werden. Der stabile Stand erklärt automatische Profile nur für Codex und Antigravity. Claude, Copilot und OpenCode haben damit noch keinen automatischen Adapterpfad. Status, Refresh und möglicher späterer Runner-Preflight sind getrennt. Nutzen: Grenzen und möglicher Kontingentverbrauch sind sichtbar; keine neue dynamische Auswahl oder Modellwechselgarantie wird behauptet.
- v0.1.6 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.1.6 [DocumentationUsability]: Policy names could be mistaken for fully implemented harness adapters. The stable release explains automatic profiles only for Codex and Antigravity. Claude, Copilot and OpenCode do not thereby gain an automatic adapter path. Status, refresh and a possible later runner preflight are distinct. Benefit: Limits and possible quota use are visible; no new dynamic selection or model-switch guarantee is claimed.
- v0.1.6 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Intake Authoring v0.3.5 → v0.3.9

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/compare/f90e707444237d768623f457f85d15a707c3476e...33845858eff1cc6aa766012650491d53e1a88447); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/blob/96feada7199245c581a98515d50a7060af719906/docs/release-0.3.9-validation.md).

Ausgang / from: f90e707444237d768623f457f85d15a707c3476e. Release / to: 33845858eff1cc6aa766012650491d53e1a88447. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.9). Archiv-SHA-256 / archive SHA-256: 5fdec1175224a30f4c2e10f549351fe71bfd06722f4390596625d45ed4733ffb.

- v0.3.6 [ValidatorRuntime]: Idle, laufende Serien ohne weiteren Kandidaten und verschachtelte Git-Repositories mussten einheitlich behandelt werden. Der gemeinsame Validator und positive/negative Fixtures stimmen diese Zustände ab. Mehrdeutigkeit, ungültige Pfade, Hashes und Zustände bleiben blockiert. Nutzen: Zusammen installierte Intake-Presets bewerten denselben Projektzustand konsistent; es startet kein nachgelagerter Lauf.
- v0.3.9 [Compatibility]: Die bekannten 0.3.8-Receipts fehlten in der ausdrücklichen Vorgängerfreigabe. Beide Validatoren akzeptieren bekannte Schema-2-Receipts von 0.3.8 zusätzlich. Die neue Vorlage bindet 0.3.9; unbekannte Versionen bleiben blockiert. Nutzen: Bestehende gültige Receipts bleiben nutzbar. Dies ist eine echte Kompatibilitätskorrektur in 0.3.9, nicht nur ein Textupdate.
- v0.3.9 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.3.6 [ValidatorRuntime]: Idle, running series with no additional candidate and nested Git repositories needed consistent handling. The shared validator and positive/negative fixtures align these states. Ambiguity and invalid paths, hashes or states remain blocked. Benefit: Combined Intake presets assess the same project state consistently; they start no downstream run.
- v0.3.9 [Compatibility]: Known 0.3.8 receipts were missing from the explicit predecessor allowlist. Both validators explicitly retain known schema-2 receipts from 0.3.8. The new template binds 0.3.9; unknown versions still block. Benefit: Existing valid receipts stay usable. This is an actual 0.3.9 compatibility correction, not merely a text update.
- v0.3.9 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Intake Review v0.2.3 → v0.2.6

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-intake-review-governance/compare/91462b4f47e64b9585c0f7d440a80449d7eb64c0...4838ab546d4f6f6c892152469cf336297e303384); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-intake-review-governance/blob/e3dc5402d2dd5fc32572766c11589ac7abcd13e3/docs/release-0.2.6-validation.md).

Ausgang / from: 91462b4f47e64b9585c0f7d440a80449d7eb64c0. Release / to: 4838ab546d4f6f6c892152469cf336297e303384. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-intake-review-governance/releases/tag/v0.2.6). Archiv-SHA-256 / archive SHA-256: fa02a2fa1ed44b2041ecd209f0ad1f96ec32b40bf5f3a867e58fd7012e3aa90b.

- v0.2.4 [ValidatorRuntime]: Idle, laufende Serien ohne weiteren Kandidaten und verschachtelte Git-Repositories mussten einheitlich behandelt werden. Der gemeinsame Validator und positive/negative Fixtures stimmen diese Zustände ab. Mehrdeutigkeit, ungültige Pfade, Hashes und Zustände bleiben blockiert. Nutzen: Zusammen installierte Intake-Presets bewerten denselben Projektzustand konsistent; es startet kein nachgelagerter Lauf.
- v0.2.6 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.2.4 [ValidatorRuntime]: Idle, running series with no additional candidate and nested Git repositories needed consistent handling. The shared validator and positive/negative fixtures align these states. Ambiguity and invalid paths, hashes or states remain blocked. Benefit: Combined Intake presets assess the same project state consistently; they start no downstream run.
- v0.2.6 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Intake Sequencing v0.2.6 → v0.2.10

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/compare/8aa137fcc95faf4e145ee408a1ee3790cac1873a...ccb6c223c51ba685f650f2ce5238299cb73b1f31); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/blob/488db2eaaee5f9c3c855cf23e7c138d45efe9319/docs/release-0.2.10-validation.md).

Ausgang / from: 8aa137fcc95faf4e145ee408a1ee3790cac1873a. Release / to: ccb6c223c51ba685f650f2ce5238299cb73b1f31. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/releases/tag/v0.2.10). Archiv-SHA-256 / archive SHA-256: 0da5d751a89b9ae68a75c2f590b449599d98d4a0ed7fe4c2bcd935e90a197678.

- v0.2.7 [ValidatorRuntime]: Idle, laufende Serien ohne weiteren Kandidaten und verschachtelte Git-Repositories mussten einheitlich behandelt werden. Der gemeinsame Validator und positive/negative Fixtures stimmen diese Zustände ab. Mehrdeutigkeit, ungültige Pfade, Hashes und Zustände bleiben blockiert. Nutzen: Zusammen installierte Intake-Presets bewerten denselben Projektzustand konsistent; es startet kein nachgelagerter Lauf.
- v0.2.10 [Compatibility]: Paket-, Generator- und Schema-Versionen durften nicht verwechselt werden. Die ausgelieferte Receipt-Vorlage nennt Generator 0.2.10. Frühere Releases 0.2.7 bis 0.2.9 banden ihre eigenen Generatorstände; das ist keine neue Schema-Version. Nutzen: Die Herkunft neuer Receipts bleibt überprüfbar, ohne historische Receipts umzuschreiben.
- v0.2.10 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.2.7 [ValidatorRuntime]: Idle, running series with no additional candidate and nested Git repositories needed consistent handling. The shared validator and positive/negative fixtures align these states. Ambiguity and invalid paths, hashes or states remain blocked. Benefit: Combined Intake presets assess the same project state consistently; they start no downstream run.
- v0.2.10 [Compatibility]: Package, generator and schema versions must not be confused. The shipped receipt template names generator 0.2.10. Earlier releases 0.2.7–0.2.9 bound their own generator versions; this introduces no new schema. Benefit: New receipt provenance is verifiable without rewriting historical receipts.
- v0.2.10 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Autonomous Run v0.4.4 → v0.4.6

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/compare/f718c00d405260706709be2fd64f59aadfac9312...130a69dc483fa27e3835640c87feb40b446bf4cc); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/blob/dcab1677c90f9b9b14e5a191916a1041ae94ef63/docs/release-0.4.6-validation.md).

Ausgang / from: f718c00d405260706709be2fd64f59aadfac9312. Release / to: 130a69dc483fa27e3835640c87feb40b446bf4cc. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.4.6). Archiv-SHA-256 / archive SHA-256: db7450ff1e1fcf26aae4a98fac3504464a2fa1e9bf7db23ffdbe1b89c5ec8b04.

- v0.4.5 [Regression]: Routing-Tests durften nicht von privaten Profilen oder echten Modellzugängen abhängen. Isolierte Routing-Fixtures und verständlichere Bedienhinweise wurden ergänzt; in 0.4.6 wurden Erstlauf und Kompatibilität konsistent gemacht. Nutzen: Tests sind besser reproduzierbar. Runner-Verhalten und Ausführungsautorität bleiben im Vergleich unverändert.
- v0.4.6 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.4.5 [Regression]: Routing tests must not depend on private profiles or real model access. Isolated routing fixtures and clearer usage guidance were added; 0.4.6 aligned first-run and compatibility guidance. Benefit: Tests are more reproducible. Runner behavior and execution authority remain unchanged in this comparison.
- v0.4.6 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Parallel Autonomous Run v0.2.6 → v0.2.8

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/compare/0139ceeac5240db831c544331f8f181a4721709e...63bbf78b51fe00385b34f52cc568dbf2928954ad); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/blob/965018d48e9eaa03fcf74fe1b9a90eb0d946dbdd/docs/release-0.2.8-validation.md).

Ausgang / from: 0139ceeac5240db831c544331f8f181a4721709e. Release / to: 63bbf78b51fe00385b34f52cc568dbf2928954ad. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.8). Archiv-SHA-256 / archive SHA-256: 36598b775b14fe070dc50700409b3e6cec8fc06b9fb2f80cf1906af1ac3560b7.

- v0.2.8 [DocumentationUsability]: Erstlaufbeispiele und aktuelle Kombinationen mit Autonomous Run konnten unterschiedliche Stände suggerieren. 0.2.7 verbesserte den Einstieg; 0.2.8 stimmt Erstlauf und Kompatibilität ab und ergänzt Dokumentationsregressionen. Nutzen: Mindestvoraussetzung, Beispielkombination und geprüfte Kombination bleiben unterscheidbar; keine neue Scheduler-Funktion oder Remote-Autorität.
- v0.2.8 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.2.8 [DocumentationUsability]: First-run examples and current Autonomous Run combinations could suggest inconsistent versions. 0.2.7 improved entry guidance; 0.2.8 aligns first-run and compatibility guidance and adds documentation regressions. Benefit: Minimum requirement, example combination and tested combination remain distinct; no new scheduler feature or remote authority.
- v0.2.8 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

### Project Statistics v0.1.0 → v0.1.2

[Exakter Vergleich / exact comparison](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/compare/7e824ca8de11212aefdc5b05d7d05637f5343dab...454554bafda574c1153e6be319c30e9787ac3867); [neuer Quellnachweis / new source record](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/blob/4f0207b3ac2a54c04f5f2c27d9f8b590704f0a35/docs/release-0.1.2-validation.md).

Ausgang / from: 7e824ca8de11212aefdc5b05d7d05637f5343dab. Release / to: 454554bafda574c1153e6be319c30e9787ac3867. [Reguläres Release / regular release](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/releases/tag/v0.1.2). Archiv-SHA-256 / archive SHA-256: 6cc233b56033b4b7dc0abd831666a6f3b0f5b70b0c9b9a395c8dc78c9549bb95.

- v0.1.1 [FieldEvidence]: Der ursprüngliche Paketstand enthielt noch nicht die spätere zusammengeführte Feldtestdokumentation. Native Linux-/Windows-Feldnachweise für v0.1.0 und LF/CRLF/BOM-Varianten wurden gesammelt; sie sind historische Evidence für genau diesen Scope. Nutzen: Anwendende können Messgrenzen und Plattformnachweise nachlesen; dies beweist keinen neuen Feldtest für 0.1.2. Die Messmethodik bleibt unverändert.
- v0.1.2 [DocumentationUsability]: Archivprüfung und Paketversion mussten klar vom historischen Messformat getrennt werden. Kopierbare Download-/SHA-256-Schritte erklären die externe Prüfung. Paket 0.1.2 ändert nicht automatisch das historische Formatfeld im Snapshot. Nutzen: Die Prüfung bleibt nachvollziehbar, ohne einen selbstreferenziellen ZIP-Hash oder gemessene KI-Produktivität zu behaupten.
- v0.1.2 [DocumentationUsability]: Ein kurzer README-Einstieg erklärte die vollständigen Leserpfade und Grenzen noch nicht gleichwertig. Deutsch-/Englisch-Leitfäden, Command-/Vorlagen-Erklärungen und Dokumentationsregressionen wurden ergänzt. Frühere Einstiegsverbesserungen und der letzte Patch werden getrennt ausgewiesen. Nutzen: Lernende finden Voraussetzungen, Beispiel, Ergebnis und Fehlerhilfe. Neue Textklarheit ist keine neue Runtime-Funktion oder menschliche Abnahme.

<div lang="en">

- v0.1.1 [FieldEvidence]: The original package did not yet contain the later consolidated field-test documentation. Native Linux/Windows field evidence for v0.1.0 and LF/CRLF/BOM variants was consolidated; it remains historical evidence for that exact scope. Benefit: Users can inspect measurement limits and platform evidence; this does not prove a new field test for 0.1.2. Measurement methodology is unchanged.
- v0.1.2 [DocumentationUsability]: Archive verification and package version needed clearer separation from the historical measurement format. Copyable download/SHA-256 steps explain external verification. Package 0.1.2 does not automatically change the historical snapshot format field. Benefit: Verification is inspectable without implying a self-referential ZIP hash or measured AI productivity.
- v0.1.2 [DocumentationUsability]: The short README entry did not yet explain the complete reader journey and limits equally. German/English guides, command/template explanations and documentation regressions were added. Earlier entry-point improvements and the final patch are reported separately. Benefit: Learners can find prerequisites, an example, its result and troubleshooting. Clearer text is not a new runtime feature or human acceptance.

</div>

Grenzen / Limits: verlinkte Testimplementierung, historische tatsächlich ausgeführte Checks und neue CI bleiben getrennt. Kein neuer Feldtest, keine Produkt-, Risiko-, Rechts-, Konformitäts- oder Zertifizierungsabnahme. / Linked test implementation, actual historical checks and new CI stay separate; no new field test or product, risk, legal, compliance or certification acceptance.

## Prüfnachweise und Korrekturen / Validation and corrections

Lokal bestehen alle 14 Dokumentationssuites einschließlich Status-, Historien-, Negativ- und CRLF-Fixtures. Die gemeinsame Kohorte behält 49 stabile Command-Deklarationen. Einschlägige bestehende fachliche Regressionen wurden erneut ausgeführt; exakte Befehle, Exitcodes, bereinigte Ausgabenauszüge und Log-Digests stehen je Preset im JSON. Diese lokalen Fachtests liefen vor dem letzten reinen CRLF-/BOM-Testnachlauf; ihre Runtime- und Leserpfad-Eingaben blieben dabei unverändert. Aktuelle native Head-Nachweise sind separat ausgewiesen. Die Assurance-Mindestkombination besteht 44 Assertions mit kanonischen Tag-Quellen ohne Modellprozesse.

42 aktuelle Leserpfade wurden offline mit Pandoc und vorhandenem Chrome geprüft: Sprache, eine H1-Überschrift, aussagekräftige Linktexte, Tabellenköpfe, Alt-Attribute und semantische Textausgabe. Die Prüfung gilt für diese lokale Darstellung, nicht für GitHub. Screenreader, Braille, umfassender Zoom/Reflow und repräsentative Nutzendentests wurden nicht durchgeführt; keine vollständige B2-/WCAG-AA-Abnahme.

Die ersten Windows-Läufe fanden einen Fehler im neuen CRLF-Fixture-Aufbau: ein bereits CRLF-materialisiertes Dokument wurde erneut umgestellt. Der korrigierte Test normalisiert vor der Fixture-Erzeugung und belegt deren Idempotenz. Die Statistik-CI verlangt eine BOM für Unicode-PowerShell; die neue Testdatei erfüllt diese Vorgabe. Keine Regel wurde unterdrückt und kein fachlicher Validator abgeschwächt. Frühere fehlgeschlagene Läufe bleiben Fehlversuche, keine nachträglichen Passes.

Ein erster lokaler HTML-Prüflauf enthielt einen vom Renderer zusätzlich erzeugten Titel; die lokale Projektion verwendet nun pagetitle statt eines zweiten Inhalts-Titels. Eine erste Routing-Mindestprüfung verwies auf ein entferntes temporäres Verzeichnis; die erfolgreiche Prüfung verwendet neu extrahierte kanonische Tags. Diese beiden Erstversuche wurden nicht als erfolgreich gezählt.

<div lang="en">

All fourteen local documentation suites and the shared 49-command cohort pass. Existing professional regressions were rerun; commands, exits, sanitized summaries and log digests are recorded per preset. The stable Assurance minimum combination passes 44 assertions using canonical sources without model processes.

Forty-two pages passed local Pandoc/Chrome semantic smoke checks. This is not GitHub rendering, screenreader/Braille, complete zoom/reflow or representative-user acceptance. Initial Windows CRLF fixtures and the Unicode BOM requirement were corrected without suppressing rules or weakening validators. Initial renderer-title and retired-fixture-path attempts were not counted as passes.

</div>

## Dokumentationsauswirkung, Lieferung und offene Grenzen / Impact, delivery and limits

UpdateRequired für aktuelle Leserpfade und diesen source-only-Nachweis; GeneratedUpdate ausschließlich für den vorhandenen Statistikblock. Kanonische Quellen sind die 14 Preset-Repositories, unveränderliche Tags, echte GitHub Releases, geprüfte Archive und tatsächlich ausgeführte Tests. Historische Berichte vom 18./23. Oktober bleiben unverändert und werden nicht rückwirkend aufgewertet.

Alle neuen PR-Heads benötigen die vereinbarte gesammelte fachliche Sichtung. Keine früheren Bypass-Freigaben übertragen. Keine neuen Releases, Tags, ZIPs, funktionalen Schnittstellen, Rollen, Prioritäten, operativen Profile/Installed-Locks, Consumer-Installationen, Home-Synchronisierung oder Fortsetzung des Pilot-Rollouts. Vorhandene CI-Installationsprüfungen laufen ausschließlich in isolierten Testprojekten. Community-Einreichungen bleiben im getrennten Auftrag. Wiederprüfung bei Quellen-, Tag-, Release-, Evidence-, Scope- oder Head-Drift.

#342 und #343 bleiben offen, bis die erforderlichen Lieferfreigaben, Merge-Commits, technischen Checks und Abnahmekriterien vollständig belegt sind. Der Head dieses Level-0-Berichts wird im PR und Chat ausgewiesen, nicht selbstreferenziell in seine eigene Statistik eingebettet.

<div lang="en">

UpdateRequired applies to current reader paths and this source-only evidence; GeneratedUpdate applies only to the existing statistics block. Historical reports remain unchanged. Collected human review of exact new heads is required; earlier bypass authority is not inherited. No new release, archive, runtime interface, operational state, consumer installation, Home sync, resumed pilot or community submission. Existing CI installation checks use isolated test projects only. Local professional regressions preceded the final test-only portability follow-up, with unchanged runtime/reader inputs; current-head native checks remain separate. Re-evaluate on source/evidence/head drift. Keep #342/#343 open until approved delivery and acceptance evidence is complete. This report records its own head in the PR/chat, not through a self-referential statistics loop.

</div>
