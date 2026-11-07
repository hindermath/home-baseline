# PR 348: Statistikabgleich / Statistics reconciliation

## Umfang / Scope

DE: Die monatliche Statistik-Branch wird mit `main` nach PR 361 abgeglichen.
Der einzige Merge-Konflikt betrifft das Projektstatistik-Ledger. Dessen
aktuelle Main-Fassung bleibt erhalten; Profil 2 wird nach dem Inhaltscommit
neu gerendert. Beide README-Sprachpartner behalten ausserhalb des markierten
Spec-Kit-Statistikblocks die Main-Inhalte.

EN: The monthly statistics branch is reconciled with `main` after PR 361.
The only merge conflict concerns the project-statistics ledger. Its current
Main version is preserved; Profile 2 is regenerated after the content commit.
Both README language partners preserve Main content outside the marked
Spec Kit statistics block.

## Review-Grenze / Review boundary

DE: Das versionierte Belegregister bleibt die fachliche Quelle. Die Pruefung
kontrolliert dessen Bindung an den Snapshot, die SHA-256-gebundenen Nachweise,
eindeutige Feature-/Run-Identitaeten, Abschlussstatus und Ausfuehrungsarten.
Entdeckte Spezifikationen allein erhalten keine neue Zaehlfreigabe. Offene
Kandidaten bleiben aus allen Laufzahlen ausgeschlossen. Geaenderte aktuelle
Dateien bestehender Laeufe ersetzen deren historische, bereits gebundene
Nachweise nicht stillschweigend. Der fehlende Abschlussbeleg fuer Feature 030
bleibt sichtbar; ein PR-Merge ist kein Ersatz fuer dessen Abschlussnachweis.

EN: The versioned evidence register remains the semantic source. Review checks
its snapshot binding, SHA-256-bound proofs, unique feature/run identities,
completion states and execution modes. Discovered specifications alone receive
no new counting approval. Pending candidates remain excluded from all run
counts. Changed current files do not silently replace the pinned historical
proofs of existing runs. The missing completion proof for Feature 030 remains
visible; a PR merge does not replace its completion evidence.

DE: Oeffentliche Belege werden ueber die bestehende read-only GitHub-Erhebung
beobachtet und offline validiert. Private Einzelbelege werden nicht gelesen
oder veroeffentlicht. Das strikt typisierte private Summenobjekt aus dem
gemeinsamen Monatslauf behaelt seinen Datenstand vom 1. November 2026.
Oeffentliche und private Datenstaende stehen getrennt in beiden Tabellen.
Repo-Beschleunigung bleibt eine Schaetzung aus Textbestand und Git-Aktivtagen,
keine gemessene Arbeitszeit oder Produktabnahme.

EN: Public evidence is observed through the existing read-only GitHub collector
and validated offline. Private individual evidence is neither read nor
published. The strictly typed private aggregate from the joint monthly run
retains its 1 November 2026 observation date. Public/private dates remain
separate in both tables. Repository acceleration remains an estimate from text
stock and Git active days, not measured working time or product acceptance.

## Pruefergebnis / Review result

DE: Oeffentlicher Snapshot: `2026-11-07T18:53:30Z`; private Summen:
`2026-11-01T08:22:54Z`. Zehn oeffentliche Repositories ergeben unveraendert
94 gestartete und 94 ausgefuehrte Laeufe, davon 93 mit Abschlussbeleg.
Ausfuehrungsarten: 52 autonom seriell und 42 nicht eindeutig belegt. Privat
bleiben 24 ausgefuehrte parallele Laeufe ohne Abschlussbeleg enthalten.
Die gewichtete gemeinsame Repo-Schaetzung ist 63,2x bei 44/122 abgedeckten
Repositories; sie ist keine Laufbeschleunigung oder Zeitmessung.

EN: Public snapshot: `2026-11-07T18:53:30Z`; private aggregate:
`2026-11-01T08:22:54Z`. Ten public repositories retain 94 started and executed
runs, with completion evidenced for 93. Modes: 52 serial autonomous and 42
unknown. Private totals retain 24 executed parallel runs without completion
evidence. The weighted combined repository estimate is 63.2x with coverage of
44/122 repositories; it is not run acceleration or a time measurement.

DE: Sieben Kandidaten bleiben ausgeschlossen: Cockpit 004, TinyCalc 006/007,
TuiVision 047, Sandbox 004 und Show-CommandTui400 001/002. Elf bestehende
historische Laeufe haben geaenderte aktuelle Nachweisdateien: home-baseline
029/030/031 und TuiVision 037 bis 044. Ihre bereits gebundenen historischen
Klassifikationen bleiben bestehen; die Warteschlange benoetigt vor einem
spaeteren Repinning einen eigenen Nachweisreview. Feature 030 bleibt der eine
gezaehlte Lauf ohne Abschlussbeleg. Offene Tasks und `finalValidation: Pending`
in Main bestaetigen diese Grenze. Register und private Summen sind gegen ihre
Ausgangsdateien unveraendert; die Warteschlange deckt alle 18 offenen
Kandidaten-/Nachweisfaelle ab.

EN: Seven candidates remain excluded: Cockpit 004, TinyCalc 006/007, TuiVision
047, Sandbox 004 and Show-CommandTui400 001/002. Eleven historical runs have
changed current evidence files: home-baseline 029/030/031 and TuiVision 037
through 044. Their pinned historical classifications remain; repinning needs
a separate evidence review. Feature 030 remains the one counted run without
completion proof, consistent with open tasks and `finalValidation: Pending`
on Main. The register and private aggregate remain unchanged against their
input files; the queue covers all 18 pending candidate/evidence cases.

## Dokumentationsauswirkung / Documentation impact

`GeneratedUpdate`: Kanonische Quellen sind
`docs/spec-kit-runs/registry.json`, der validierte oeffentliche Snapshot und
`docs/spec-kit-runs/private-aggregate.json`. Renderer:
`bash scripts/update-public-speckit-statistics.sh --action Collect`, danach
`--action Render`. README-Sprachpartner, Tabellen, Review-Warteschlange und
Veroeffentlichungshashes werden gemeinsam erzeugt. Profil 2 stammt aus
`docs/project-statistics.config.json`, Git-Historie und getrackten Texten;
Renderer: `bash scripts/render-project-statistics.sh`.

DE: Owner: Thorsten Hindermann / Statistics Maintainer. Zielgruppen: Leser der
oeffentlichen Statistik und Maintainer. Leserpfad: README → Methodik → Register,
Snapshot und Review-Warteschlange. Dokumentklasse: Generated / Wartungsnachweis;
DE/EN gemeinsam, Tabellen mit DE/EN-Sprachpartner, Navigation unveraendert.
Nachweise: 75 deterministische macOS-Assertions, Snapshot-/Privatsummen-
Validierung, Renderer-Driftchecks, README-Abgrenzung und native PR-CI.
Die Home-README ist `homeRuntime`; Statistikquellen und dieser Nachweis sind
`sourceOnly`. Home-Sync nach Merge. Erneut pruefen bei Registerentscheidungen,
Zaehlregeln, Quellen-/Privatsummen-Aenderungen oder Distributionsaenderungen.

EN: Owner: Thorsten Hindermann / Statistics Maintainer. Audiences: public
statistics readers and maintainers. Reader path: README → methodology →
register, snapshot and review queue. Class: Generated / maintenance evidence;
German/English together, paired tables, navigation unchanged. Evidence:
75 deterministic macOS assertions, snapshot/private aggregate validation,
renderer drift checks, README boundary checks and native PR CI. The Home README
is `homeRuntime`; statistics sources and this record are `sourceOnly`. Sync Home
after merge. Reevaluate on registry decisions, counting rules, source/private
aggregate changes or distribution changes.
