# Profilstatistik: Barrierearme Darstellung / Profile statistics: accessible presentation

Owner: Thorsten Hindermann. Documentation Impact: `GeneratedUpdate`.
Leserpfad: Level-0-/Profil-README → Methodik → eingefrorene Belege und Replay.
*Reader path: Level-0/profile README → method → frozen evidence and replay.*

Die kanonische Quelle ist `scripts/lib/public-speckit-statistics.psm1` mit dem
vorhandenen Register, Snapshot und freigegebenen privaten Aggregat. `Render`
erzeugt DE/EN, README-Blöcke und SHA-256-Manifest. Die zusätzliche
Darstellungskennung `accessible-html-v1` verändert weder Schema 3 noch Zahlen,
Modusklassifikationen, Faktoren, Abdeckung, Quellstände oder historische Belege.
Es wird keine neue private/öffentliche Sammlung gestartet.

*The module and existing register, snapshot and sanitized aggregate remain
canonical. Render generates both languages, README blocks and checksums.
The new presentation identifier changes no data/rule schema, counts, modes,
estimates, coverage, source dates or historical evidence. No collection starts.*

Die HTML-Tabelle besitzt einen nach GitHub-Sanitization erhaltenen Namen,
Sprachmarkierungen sowie explizite Zeilen-/Spaltenüberschriften. Alle Zahlen
bleiben echte Textzellen. Der bisherige Markdown-Renderer bleibt als expliziter
Replay verfügbar. Der Profilimport muss vor der neuen Publikation kompatibel
ausgeliefert sein; nach Level-0-Merge übernimmt der manuelle Import den Block.

*The HTML table preserves its accessible name, language and row/column headers
after GitHub sanitization. Numeric values remain actual text. Historical
Markdown replay is explicit. Deploy compatible profile import first, publish
Level 0 next, and then import the merged German export.*

Deterministische Evidence: 84 Statistik-Assertions einschließlich historischer
Replays, Nullzeilen, Modi, gewichteter Faktoren, Privatheitsgrenzen und neuer
HTML-Semantik. Hinzu kommen Bash-/PowerShell-Render-CheckOnly, idempotentes
Rendering, DOM-Abgleich aller Textzellen und unveränderte Quelldateihashes.
Native CI prüft macOS, Linux und Windows vor Merge.

*Deterministic evidence covers 84 assertions, legacy replay, zero rows, modes,
weighted factors, privacy and HTML semantics; rendering is checked in both
shells, compared by cell text and repeated for idempotency. Native CI verifies
macOS, Linux and Windows before merge.*

Diese technischen Prüfungen sind keine vollständige WCAG-2.2-AA-Abnahme.
Praktische Profilprüfung und Grenzen stehen im Profilrepository unter
`docs/accessibility.md`. NVDA/Braille, nicht verfügbare praktische Tests und die
GitHub-eigene Oberfläche bleiben getrennt und werden nicht als bestanden gezählt.
Re-Evaluation: Renderer-/Importer-/GitHub-Sanitization- oder Tabellenänderung.
Distribution: `homeRuntime` für die manifestgebundenen Skripte/README; übrige
Dokumentation `sourceOnly`. Nach Lieferung manifestgebundener Home-Sync, keine
Level-2-Verteilung.

*These checks do not establish full WCAG conformance. The profile accessibility
record distinguishes practical evidence, unavailable tests and GitHub-owned UI.
Reassess after renderer/importer/sanitizer/table changes. Sync only manifest-bound
Home Runtime after delivery; no Level-2 distribution.*
