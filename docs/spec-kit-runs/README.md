# Spec-Kit-Läufe und Ausführungsarten / Spec Kit runs and execution modes

## Repo-Beschleunigungsfaktor, Version 3 / Repository acceleration factor, version 3

Die zusätzliche Spalte **Beschleunigungsfaktor (Repo-Schätzung)** vergleicht
den gesamten berücksichtigten Textbestand mit **80 Textzeilen pro Arbeitstag**.
Sie beschreibt Lieferdichte, keine gemessene KI-Zeitersparnis, Produktqualität
oder persönliche Arbeitszeit. Auch fremde/importierte Inhalte und Arbeit
außerhalb von Spec Kit beeinflussen sie. Repositories ohne Spec-Kit-Läufe
werden ausdrücklich einbezogen; die Laufzählregeln ändern sich nicht.

*The additional Acceleration factor (repository estimate) column compares the
entire included text stock against 80 text lines/workday. It describes delivery
density, not measured AI time savings, product quality or personal working time.
Imported content and work outside Spec Kit influence the result. Repositories
without Spec Kit runs are included; run-counting rules remain unchanged.*

`Faktor = Textbestand / (80 × Git-Aktivtage)`

Vorhandene Profil-2-Statistiken in `docs/project-statistics.md` haben Vorrang.
Der Sammler prüft Markierungen, Konfiguration, Quellrevision, Fenster und den
bereits gerundeten 80-Zeilen-Faktor gegen Textbestand und Aktivtage. Ein
Widerspruch stoppt die Erhebung. Die belegte Statistik behält ihr Datum;
erneutes Abrufen behauptet keine Neuberechnung. Nicht unterstützte Formate
oder fehlende Statistiken nutzen die ausdrücklich gekennzeichnete Ersatzberechnung.

*Existing Profile 2 statistics take precedence. The collector validates the
markers, configuration, source revision, window and rounded 80-line factor
against text stock and active days. Contradictions stop collection. Existing
statistics retain their source dates. Unsupported formats or missing statistics
use an explicitly identified fallback calculation.*

Die Ersatzberechnung liest ausschließlich GitHub-Daten am gepinnten
Default-Branch-Commit. Sie zählt Git-getrackte Textdateien (NUL-Bytes kennzeichnen
Binärdaten), ohne `STATS.md`, das Statistik-Ledger, symbolische Links und
konfigurierte Ausschlüsse. Aktivtage stammen aus relevanten Textänderungen
von Nicht-Merge-Commits im Profil-2-Fenster: aktuelle Woche plus 51 vorherige
Wochen, bis zum Datenstand. Ohne Konfiguration gilt `Europe/Berlin`.
Unvollständige Git-Bäume, Diffs oder Blob-Inhalte sind Fehler, keine Nullwerte.
Code aus untersuchten Repositories wird nie ausgeführt.

*Fallback reads GitHub data at the pinned default-branch commit. It counts
tracked text files using the Profile 2 byte definition, excluding STATS.md,
the statistics ledger, symbolic links and configured exclusions. Active days
come from relevant non-merge text changes in the current and preceding 51 weeks,
through the observation date. The default timezone is Europe/Berlin. Incomplete
trees, diffs or blobs fail; inspected repository code is never executed.*

Alle Summenzeilen verwenden `Σ Textbestand / (80 × Σ Repo-Aktivtage)`, niemals
den einfachen Mittelwert gerundeter Faktoren oder eine Gewichtung nach Laufzahl.
Gleiche Kalendertage verschiedener Repositories zählen je Repository.
Leere Repositories, null Aktivtage oder null Textbestand sind **nicht berechenbar**.
Sie bleiben in der Laufstatistik und im Abdeckungsnenner; Zähler und Nenner des
Faktors enthalten ausschließlich vollständige Zahlenpaare. Bei Teilabdeckung
zeigt die Zelle zusätzlich `N/M Repos`. `×` bedeutet Faktor.

*Totals use summed text stock divided by 80 times summed repository active days,
never the simple average of rounded factors or weighting by run count. The same
calendar date counts separately in each repository. Empty repositories, zero
active days or zero text stock are not calculable. Their run counts remain;
only complete positive pairs enter the factor. N/M Repos indicates coverage.*

Öffentliche Einzelgrundlagen, Quelltexte oder Blob-Prüfsummen stehen im
versionierten Snapshot, Quellstände und Berechnungsart in der
[Prüfwarteschlange](review-queue.md). Ersatzberechnungen speichern je Blob
Identität, SHA-256 und Zeilenzahl sowie relevante Commit-Identitäten, Datumswerte
und Änderungszahlen. Diese Eingaben erlauben identische Offline-Tabellen.
Für private Repositories bleiben diese Details im privaten CI-Repository.
Nur Referenz, Repository-/Abdeckungszahl, summierter Textbestand, summierte
Aktivtage und frühestes/spätestes Quelldatum ergänzen das öffentliche Summenobjekt.
Ein privater Gesamtfaktor ist intern reproduzierbar, öffentlich nur rechnerisch prüfbar.

*Public inputs and checksums are frozen in the snapshot; the review queue lists
source dates and calculation kind. Fallback freezes blob identities, SHA-256,
line counts and relevant commit dates/change counts for deterministic offline
rendering. Private details stay in private CI. Only the reference, coverage,
summed text stock, summed active days and oldest/newest source dates cross the
boundary. Private results are internally reproducible; public readers can verify
aggregate arithmetic only.*

Version 3 erweitert Register, Snapshot, Manifest und private Übergabe.
Versionen 1 und 2 bleiben bytegleich reproduzierbar. Gleichbleibende Zahlen und
Abdeckung erzeugen keine reinen Datums-Commits; der letzte veröffentlichte Stand
bleibt bei Fehlern erhalten. Die monatlichen CI-Termine bleiben unverändert.

*Version 3 extends the register, snapshot, manifest and private aggregate.
Versions 1 and 2 retain byte-identical replay. Unchanged numbers and coverage
do not create date-only commits. Failures retain the last publication. Monthly
CI schedules remain unchanged.*

## Regelversion 2 / Rule version 2

Version 2 ergänzt jede öffentliche Repository-Zeile um die Ausführungsarten
Manuell, Autonom seriell, Autonom parallel, Gemischt und Nicht eindeutig belegt.
Die fünf Werte teilen ausschließlich **Ausgeführt** auf; ihre Summe muss in
jeder Zeile exakt dieser Spalte entsprechen. Die Statusspalten bleiben kumulativ.

*Version 2 adds Manual, Autonomous serial, Autonomous parallel, Mixed and Not
clearly evidenced to each public repository row. These five values partition
Executed exactly. Status columns retain their cumulative meaning.*

| Art / Mode | Nachweis / Evidence |
|---|---|
| Manuell / Manual | Belegte schrittweise Benutzersteuerung; KI-Unterstützung ist möglich. / Evidenced stepwise user control; AI assistance is allowed. |
| Autonom seriell / Autonomous serial | Belegte autonome Feature-Bearbeitung mit geprüfter Einstufung außerhalb einer ausgeführten parallelen Kampagne. / Evidenced autonomous feature execution, reviewed as outside an executed parallel campaign. |
| Autonom parallel / Autonomous parallel | Belegte Ausführung als Kampagnen-Worker; zeitliche Überlappung ist nicht erforderlich. Planung allein genügt nicht. / Evidenced campaign-worker execution; temporal overlap is not required. Planning alone does not qualify. |
| Gemischt / Mixed | Mehrere Arten während substanzieller Ausführung; manuelle Vorplanung allein zählt nicht. / Multiple modes during substantive execution; manual preliminary planning alone does not qualify. |
| Nicht eindeutig belegt / Not clearly evidenced | Ausführung belegt, Modus nicht ausreichend belegt. Fehlende Autonomie-Dateien beweisen keinen manuellen Lauf. / Execution evidenced, mode insufficiently evidenced. Missing autonomy files do not prove manual execution. |

Ein Feature zählt weiterhin einmal. Kampagnenhüllen, Resume, Installationen,
Smoke-Tests und Review-Aufgaben ergeben keine zusätzlichen Feature-Läufe.
Begründungen und Modusbelege stehen im Register; zukünftige neue Belege erfordern
Review und werden nicht durch eine Textheuristik automatisch freigegeben.

*A feature still counts once. Campaign containers, resumes, installations,
smoke tests and review tasks do not add feature runs. Mode reasons and proofs
are registered; new evidence requires review rather than automatic text-heuristic approval.*

Die privaten GitHub-Repositories des Kontos werden einschließlich Level 1 und
archivierter Repos als **eine** Zeile ergänzt. Namen und Einzelbelege bleiben
privat. Öffentliche Level-2-, öffentliche Level-0-/2- und gemeinsame Gesamtsummen
bleiben ausdrücklich unterscheidbar; öffentlich bleibt das bestehende Register
maßgeblich. GitLab und fremde Organisationsrepositories sind nicht eingeschlossen.

*All private GitHub repositories owned by the account, including level 1 and
archives, contribute to one aggregate row. Names and individual proofs stay
private. Public level-2, public level-0/2 and combined totals remain distinct.
The public scope continues to follow the existing register. GitLab and other
organizations are excluded.*

Die private CI koordiniert den gemeinsamen Monatslauf am Ersten um 08:17 UTC.
Ein getrenntes Veröffentlichungs-Job erhält nur das strikt typisierte
Summenobjekt: Regel-/Schemaversion, Datenstand, acht Zahlen und Anzahl ungeprüfter
Kandidaten. Zusätzliche Felder, private Namen, Pfade oder Freitexte sind verboten.
Ein reiner Lese-App-Zugriff erhebt die Quellen; eine getrennte Herausgeber-App
darf ausschließlich den öffentlichen Level-0-Aktualisierungs-PR schreiben.
Öffentliche PR-Prüfungen erhalten keine privaten Zugangsdaten.

*Private CI coordinates the joint monthly run on day 1 at 08:17 UTC. A separate
publisher job receives only the strictly typed aggregate: rule/schema version,
data date, eight counts and unreviewed-candidate count. Extra fields and private
identities, paths or free text are rejected. A read-only collector App accesses
sources; a separate publisher App can write only the public Level-0 update PR.
Public PR checks receive no private credentials.*

Private Einzelbelege und Snapshots sind intern reproduzierbar, aber nicht
öffentlich unabhängig prüfbar. Die veröffentlichte Datei
`private-aggregate.json` enthält ausschließlich diese freigegebenen Summen.
Beide Datenstände bleiben sichtbar; unveränderte genehmigte Werte behalten ihr
Datum. API-Ausfälle oder fehlende Quellabdeckung verhindern eine neue Gesamtausgabe.
Die Profileinbindung übernimmt unverändert den gemergten Tabellenexport.

*Private individual evidence and snapshots are internally reproducible but not
independently publicly auditable. The published private-aggregate.json contains
only approved totals. Both observation dates remain visible; unchanged approved
values retain their date. API failures or missing source coverage prevent a new
combined publication. The profile imports the merged table unchanged.*

Der Renderer unterstützt weiterhin Regelversion 1 mit unveränderten Tabellenbytes.
Regelversion 2 benötigt zusätzlich das validierte private Summenobjekt; fehlende
Daten ergeben einen Fehler und niemals erfundene Nullwerte. Historische
Laufartefakte werden durch die Migration nicht verändert.

*The renderer still supports rule version 1 with unchanged table bytes. Rule
version 2 additionally requires the validated private aggregate; missing data
fails rather than inventing zeros. Migration does not rewrite historical runs.*

Diese Statistik zählt belegte Feature-Läufe in registrierten öffentlichen
GitHub-Repositories der Level 0 und 2. Sie misst weder Produktqualität noch
Arbeitszeit. Ein abgeschlossener Governance-Lauf ist keine Produktabnahme.

*This statistic counts evidenced feature runs in registered public GitHub
level-0 and level-2 repositories. It measures neither product quality nor
working time. A completed governance run is not product acceptance.*

## Daten und Nachweise / Data and evidence

- [Öffentliche Tabelle / Public table](table.md), [English table](table.en.md)
- [Repository- und Belegregister / Repository and evidence register](registry.json)
- [Vollständiger Snapshot / Complete snapshot](snapshot.json)
- [Prüfbedarf und Abschlusslücken / Review queue and completion gaps](review-queue.md)
- [Veröffentlichungsprüfsummen / Publication checksums](publication.json)

Das Register ist die fachliche Quelle. Es enthält je Feature eine begründete
Einstufung und SHA-256-gebundene öffentliche Belege für Start, Ausführung und
gegebenenfalls Abschluss. Die Kennzeichnung `hindermath-maintained-evidence-register`
benennt den gepflegten Registervertrag, keine behauptete menschliche Einzelabnahme.
Die initiale Belegprüfung und spätere Änderungen unterliegen dem Repository-Review.

*The register is the semantic source. Each feature has a reasoned classification
and SHA-256-bound public proof of start, execution and, where applicable,
completion. The register label denotes the maintained evidence contract, not a
claim of individual human approval. Initial evidence and changes undergo PR review.*

## Zählvertrag, Version 1 / Counting contract, version 1

| Spalte / Column | Bedeutung / Meaning |
|---|---|
| Gestartet / Started | Konkreter, geprüfter Feature-Startnachweis, zum Beispiel eine ausgearbeitete Spezifikation. / Concrete reviewed feature start evidence, for example a developed specification. |
| Ausgeführt / Executed | Implementierung oder fachliche Bearbeitung nachweislich begonnen. Planung oder ein Setup-Häkchen allein genügt nicht. / Implementation or substantive work demonstrably started; planning or a setup checkbox alone is insufficient. |
| Abschluss belegt / Completion evidenced | Geprüfter terminaler Zustand oder vollständige Abschlussbelegkette. Ein Merge allein genügt nicht. / Reviewed terminal state or complete closure evidence; a merge alone is insufficient. |

Die Spalten sind kumulativ: `Abschluss belegt <= Ausgeführt <= Gestartet`.
Ein Feature zählt pro Repository einmal. Resume, Wiederholungsversuche,
Abschluss-PRs, kopierte Nachweise, Vorlagen, Fixtures, Intakes, Reviews,
Preset-Installationen und technische Smoke-Tests zählen nicht zusätzlich.
Alle eingeschlossenen Repositories erscheinen auch mit Nullwerten.

*Columns are cumulative. A feature counts once per repository. Resumes, retries,
closure PRs, copied evidence, templates, fixtures, intakes, reviews, preset
installations and technical smoke tests do not add runs. Included repositories
with no reviewed runs retain zero rows.*

Die Startauswahl enthält neun explizit registrierte öffentliche Repositories.
Neue Repository-Zuordnungen und Feature-Einstufungen benötigen eine geprüfte
Registeränderung; es gibt keine kontoweite automatische Scope-Erweiterung.
CI entdeckt nummerierte `specs/<Nummer>-<Name>/spec.md` auf dem Default-Branch
und offenen PRs desselben Repositories. Fork-PRs und unveröffentlichte lokale
Arbeit sind ausgeschlossen. Branches ohne PR gehören nicht zur automatischen
Entdeckung. Ihre öffentlichen Belege können nach Prüfung ins Register aufgenommen
werden. Archivierte bereits belegte Läufe bleiben über ihre gepinnten Quellen erhalten.

*The initial scope contains nine explicitly registered public repositories.
Repository additions and feature classifications require a reviewed register change.
CI discovers numbered feature specifications on the default branch and open
same-repository PRs. Fork PRs and unpublished local work are excluded. Branches
without a PR are not automatically discovered; reviewed public evidence from them
can be registered. Accepted archived runs remain reproducible through pinned proofs.*

Neue Kandidaten stehen als `needsReview` in der Prüfwarteschlange und zählen
bis zur semantischen Prüfung in keiner Spalte. Für die Übernahme: Spezifikation,
tatsächliche Bearbeitung und Abschlussgrenze lesen; je Behauptung einen öffentlichen
Beleg mit Commit/PR und SHA-256 zuordnen; Einstufung und Begründung im Register
ergänzen; `Collect`, `Render` und Tests erneut ausführen. Kein Modell und keine
Textheuristik darf einen Abschluss autonom genehmigen.

*New candidates enter the review queue and remain excluded until semantic review.
To accept one, inspect specification, substantive execution and closure boundaries;
bind a public commit/PR and SHA-256 to each claim; update the register with the
classification and rationale; rerun collection, rendering and tests. No model or
text heuristic independently approves completion.*

Die Entscheidung kann vollständig über GitHub erfolgen: das Register auf einem
Review-Branch bearbeiten, dessen exakten Commit prüfen und den Level-0-Workflow
auf `main` mit diesem SHA als `registry_commit` starten. CI übernimmt nur die
Registerdatei, führt keinen Code aus dem Review-Branch aus und erzeugt den
zugehörigen Snapshot sowie die Tabellen im Aktualisierungs-PR. Bereits offene
manuelle Registeränderungen werden von einem normalen Monatslauf nicht überschrieben.

*Review can happen entirely in GitHub: edit the register on a review branch,
review its exact commit and dispatch the Level-0 workflow on main with that SHA
as registry_commit. CI imports only the registry, executes no review-branch code
and produces the snapshot/tables in the update PR. Ordinary monthly runs preserve
pending manual registry edits instead of overwriting them.*

Historische vollständig abgehakte Aufgabenlisten sind einzeln geprüfte Nachweise,
keine pauschale Regel für zukünftige Läufe. Für TinyCalc 003–005 und TuiVision
009/022/023/026 ergänzen spätere Delivery-/Closeout-PRs eingefrorene Aufgabenlisten.
Level-0-Feature 030 bleibt ohne belegten terminalen Abschluss: `Active/Publish`
und offene finale Prüfungen werden durch den Merge von PR #259 allein nicht ersetzt.
Die Statistik schreibt keine historischen Feature-Artefakte um.

*Historical checked task lists are individually reviewed evidence, not an automatic
rule for future runs. Later delivery/closure PRs supplement frozen task lists for
the named features. Level-0 feature 030 remains without terminal completion proof;
PR #259 alone does not supersede pending final verification. Historical feature
artifacts are never rewritten by this statistic.*

## Reproduktion / Reproduction

Der reguläre Sammler läuft auf einem GitHub-gehosteten Ubuntu-Runner, ohne
persönlichen Rechner oder lokale Agentenzustände. Nur die Erhebung benötigt
`gh` und öffentliche GitHub-Lesezugriffe. Der versionierte Snapshot enthält
die vollständigen verwendeten Quelltexte und ausgewählte Providerfelder.
Commit-gebundene, hashgeprüfte Quellen werden beim nächsten Lauf wiederverwendet;
veränderliche PR-Belege werden erneut geprüft. API-Fehler, unbekannte Zustände,
Hash-Abweichungen und abgeschnittene Git-Bäume stoppen die Veröffentlichung.
Privat gewordene Repositories werden ausgeschlossen, bevor Inhalte gelesen werden.

*Normal collection runs on a GitHub-hosted Ubuntu runner without a personal machine
or local agent state. Only collection needs gh and public GitHub reads. The snapshot
contains the full source text used and selected provider fields. Hash-checked immutable
commit sources are reused; mutable PR evidence is rechecked. API errors, unknown states,
hash drift and truncated Git trees stop publication. Private repositories are excluded
before reading their content.*

```bash
# Offline prüfen / Validate offline
bash scripts/update-public-speckit-statistics.sh --action Validate
bash scripts/update-public-speckit-statistics.sh --action Render --check-only
# Live-Vorschau / Live preview without writes
bash scripts/update-public-speckit-statistics.sh --action Collect --dry-run
# Kandidat erzeugen / Produce candidate (no commit, push or merge)
bash scripts/update-public-speckit-statistics.sh --action Collect
bash scripts/update-public-speckit-statistics.sh --action Render
```

```powershell
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Validate
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Render -CheckOnly
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Collect -WhatIf
pwsh -NoProfile -File scripts/tests/test-public-speckit-statistics.ps1
```

Exitcodes: `0` erfolgreich/aktuell, `1` Drift, `2` Fehler. Ein Snapshot mit
derselben Regelversion liefert offline dieselben Bytes. Die Hashes beweisen
Integrität, nicht die fachliche Richtigkeit einer ungeprüften Einstufung.

*Exit codes: 0 successful/current, 1 drift, 2 error. The same snapshot and rule
version reproduce the same bytes offline. Hashes establish integrity, not the
semantic correctness of an unreviewed classification.*

Die READMEs und Statistikdateien sind über `.gitattributes` auf LF gebunden;
so verändert ein Windows-Checkout weder exportierte Tabellenbytes noch deren
Prüfsummen. Ohne `--repo` verwendet das Werkzeug die gemeinsame Level-0-
Quellauflösung, auch beim Aufruf einer verteilten Home-Runtime-Kopie.

*README/statistics files use explicit LF attributes so Windows checkout conversion
does not change exported bytes or checksums. Without --repo, the tool uses the
shared Level-0 source resolver, including calls from a distributed Home Runtime copy.*

## Monatlicher Betrieb / Monthly operation

Die gemeinsame private CI erhebt am Monatsersten um 08:17 UTC. Das Profil übernimmt am zweiten
Kalendertag um 09:17 UTC ausschließlich den zuletzt gemergten Level-0-Stand.
Beide Workflows erlauben `workflow_dispatch`. GitHub kann Termine verzögern.
Offene Level-0-PRs werden nicht ins Profil übernommen; nach einem späteren Merge
kann dessen Workflow manuell gestartet werden, sonst greift der nächste Monatslauf.
Je Repository entsteht höchstens ein Aktualisierungs-PR. Kein Auto-Merge.

*Joint private CI collects on day 1 at 08:17 UTC; the profile imports the latest merged
source on day 2 at 09:17 UTC. Both support manual workflow dispatch. GitHub may
delay schedules. Pending source PRs are not imported. After a later merge, dispatch
the profile workflow manually or wait for the next month. One update PR per repo;
no automatic merge.*

Unveränderte Evidence erzeugt keinen Datums-Commit. Der sichtbare Datenstand
ist der letzte inhaltlich geänderte und veröffentlichte Snapshot, nicht eine
Behauptung täglicher Frische. Jüngere erfolgreiche Nulländerungsprüfungen sind
in den Actions-Läufen sichtbar. Fehler lassen den vorherigen Stand unverändert.
Bei zurückgehaltenen Bot-PR-Prüfungen diese vor Review/Merge freigeben.

*Unchanged evidence does not create a date-only commit. The displayed date is
the last changed and published snapshot; newer no-change checks are visible in
Actions. Failures preserve the previous publication. Release held bot-PR checks
before review/merge.*

Owner: Level-0 Maintainer. README und Skripte folgen dem bestehenden Home-Runtime-
Manifest; Dokumentation und Snapshots sind `sourceOnly`. Home-Sync erfolgt nach
separat autorisierter Lieferung, niemals als Voraussetzung oder Teil der CI-Erhebung.
Private werdende Quellen werden aus dem aktuellen Snapshot entfernt; historische
Git-Versionen bereits öffentlich veröffentlichter Daten bleiben Git-Historie.

*Owner: Level-0 maintainer. README/scripts follow the existing Home Runtime manifest;
documentation and snapshots are source-only. Home sync follows separately authorized
delivery and is never required by collection. Removing newly private sources from
the current snapshot does not erase previously public Git history.*
