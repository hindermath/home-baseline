# Native Home-Baseline-Pilotnachweise / Native Home Baseline pilot evidence

Historischer Nachweis vom 2026-09-16. Die beauftragte Fortschreibung vom
2026-09-18 steht im [Liefernachweis](../project-statistics-pilot/delivery-refresh.md).
Historical evidence; see the linked delivery refresh for the later candidate.

## Ergebnis und naechster Schritt / Result and next step

2026-09-16: Der gesichtete Home-Baseline-Statistikpilot ist auf macOS, Ubuntu
und Windows technisch nachgeprueft. Beide nativen CI-Jobs sind erfolgreich:
[Workflow-Lauf 35064661581](https://github.com/hindermath/home-baseline/actions/runs/35064661581).
Dies ergaenzt den [lokalen Pilotnachweis](../project-statistics-pilot/README.md),
dessen noch offene native Nachweise damit fuer den unten gebundenen Stand
erbracht sind. Keine vollstaendige Preset-/Releasefreigabe oder Community-Einreichung.

Der naechste Schritt ist die geregelte PR-Vorbereitung: Messung und bestehende
Projektstatistik gegen den dann vollstaendigen Lieferstand fortschreiben,
neue Messwerte sichten und anschliessend PR/Checks/Review liefern.
Die native Pruefung des alten Messstands ersetzt diese Aktualisierung nicht.
Kein PR oder Merge in diesem Nachweisschritt.

The reviewed pilot passed local macOS and native Ubuntu/Windows verification.
This supplements the earlier local record for the exact dataset below, not
a full preset/release approval or community submission. Next, refresh the
pilot and legacy statistics against the completed delivery candidate, review
the new measurements and perform governed PR delivery. No PR or merge here.

## Drei getrennte Revisionen / Three distinct revisions

| Bindung / Binding | Commit |
| --- | --- |
| Ausgefuehrter Workflow / executed workflow | `0c3cc713b49fe74d70dd9a6c302539257d6dc3d7` |
| Gesichtet und nativ geprueft / reviewed pilot | `af78a4accdaea059728a53e6b113d543e35fb030` |
| Gespeicherte Messrevision / stored measurement | `e1d6d36e444cc252a0321572e70da8874de81fe3` |

Workflow: `.github/workflows/project-statistics-pilot-native-proof.yml`.
Er verwendet einen isolierten Worktree am festen Pilotcommit, prueft dessen
Abstammung und alle 26 installierten Preset-Dateihashes. Der vollstaendige
Checkout liefert die benoetigten Git-Objekte. `contents: read`, keine
persistierten Checkout-Credentials, keine automatische Reparatur oder Lieferung.

The workflow creates an isolated worktree at the reviewed commit and checks
ancestry and all 26 installed package hashes. Full history supplies required
Git objects. Read-only GitHub permissions and no persisted checkout credentials;
no automatic repair or delivery.

## Plattformmatrix / Platform matrix

| Plattform / Platform | PowerShell | Suite-Assertions | Statusparitaet / status parity | Rohblobs / raw blobs |
| --- | --- | ---: | ---: | ---: |
| macOS 26.6.2, lokal / local | 7.6.6 | 67 | 8 | 6 |
| Ubuntu 24.04.5 LTS, ubuntu-24.04 | 7.6.5 | 67 | 8 | 6 |
| Windows Server, windows-2022 (10.0.20348) | 7.6.5 | 61 | 4 | 6 |

Alle aufgelisteten Befehle Exit 0. Linux und macOS pruefen Bash und PowerShell;
Windows prueft nativ PowerShell. Die sechs weniger Assertions unter Windows
entsprechen den im unveraenderten Produkttest ausgeschlossenen Bash-/Unix-
Faellen, einschliesslich des Unix-Symlink-Falls; keine Windows-Abdeckung dieser
Faelle behauptet. Keine nachtraeglich angepassten Erwartungszahlen.

All listed commands exited 0. Linux/macOS run both entrypoints; Windows runs
native PowerShell. The unchanged product suite excludes six Bash/Unix assertions
on Windows, including the Unix symlink case. No Windows coverage is claimed
for those cases and expected assertion counts were not adjusted after execution.

Die Paritaetsmatrix prueft LF/CRLF jeweils ohne/mit UTF-8-BOM fuer Konfiguration,
Bericht und Snapshot. Jede Entscheidung: `CURRENT`, `reproducible=true`,
`current=true`, `changed=false`, Messstichtag 2026-09-16. Hashes von sechs
geschuetzten Dateien und Git-Status bleiben pro Statusaufruf unveraendert.
Rohblob-Faelle verwenden `--no-filters`: vier verschiedene Zweizeilen-Blobs
ergeben je 2, leer und BOM-only je 0 Zeilen. Fixture-Schreibvorgaenge sind
erwartet; diese Nachweise behaupten keine vollstaendige I/O-Aufzeichnung.

Parity covers four newline/BOM variants of configuration, report and snapshot.
Every decision is current and reproducible with no changes, at cutoff 2026-09-16.
Six checked file hashes and Git status are preserved per status call. Raw blob
tests bypass clean filters and verify two-line, empty and BOM-only cases.
Fixtures intentionally write test data; no full system I/O trace is claimed.

## Evidence und Hashpruefung / Evidence and hash verification

Artefakte im verlinkten Lauf: `statistics-pilot-ubuntu-24.04` und
`statistics-pilot-windows-2022`. Beide wurden heruntergeladen; jede
`native-evidence.json`, ihr Suite-Log und alle Entscheidungsdateien wurden
gegen Quellenbindungen, Payload-Hashes und enthaltene SHA-256-Werte geprueft.
Lokale Originaldownloads: `/tmp/home-statistics-ci.D8pn16/linux/` und `windows/`.
GitHub-Artefakte und lokale Temp-Dateien haben keine zugesicherte Daueraufbewahrung.
Die folgenden Hashes binden die originalen heruntergeladenen Bytes.

Both run artifacts were downloaded. Source bindings, payload hashes, suite logs
and every decision digest were verified. Hashes below bind original downloaded
bytes; GitHub artifacts and local temporary copies are not permanent archives.

| Originaldatei / Original file | SHA-256 |
| --- | --- |
| Linux native-evidence.json | `c964661388997dbf3031cae5032d0164a082e6727424277461681c11620cd0b2` |
| Linux fixtures.log | `0b8fec349f21465227a8d9de3c875161354f78e518789b16fdbd4ba865357b05` |
| Windows native-evidence.json | `ce8ac6079a3bf9c0bc1f9d1e93a3d12b253f8eb1d4085b0a0bf0092573ea1b57` |
| Windows fixtures.log | `8a7dceae88c68f717d7f7b1185381433fa29eb774b96e8a65cb657fd1dee2e0c` |
| Workflow | `c1482099cbe34a23180b3ce7faef95da3d1a76914099ac04a9b49c34233c8f2d` |
| Installierte Suite / installed suite | `6c3f215e53b7724f6c37d8422d10d51043c3cc2c4afb0d0af0cd73757b4e7d1a` |

Windows erzeugt seine Evidence-JSON mit plattformeigenen Zeilenenden; daher
weichen Entscheidungsdatei-Hashes ab. Die vier semantischen Ergebnisse stimmen
ueberein; unterschiedliche rohe JSON-Hashes sind hier kein Messdrift.
Windows evidence JSON has platform-specific line endings. Its raw decision
hashes differ while all four semantic results agree; this is not measurement drift.

## Aktualitaetsgrenze / Freshness boundary

Der unveraenderte Messbericht enthaelt 3234 Textdateien, 696425 Textzeilen und
110 Aktivtage. Er ist weiterhin reproduzierbar. Gegen den um den Workflow
erweiterten Branch-Head meldet der Status aber korrekt `DRIFT`, Exit 1,
`reproducible=true`, `current=false`. Neue CI-/Dokumentationsdateien sind
zusaetzlicher Git-Bestand. `CURRENT` gilt deshalb fuer den gebundenen Pilot-
Worktree, nicht fuer den gesamten erweiterten Lieferbranch. Weder Snapshot
noch Ausschluesse wurden angepasst, um diese Grenze zu verbergen.

The unchanged measurement remains reproducible: 3234 text files, 696425 lines,
110 active days. Against the newer workflow-bearing branch, status correctly
reports DRIFT, exit 1, reproducible true and current false. New CI/documentation
files are additional measured inputs. CURRENT describes the pinned pilot
worktree, not the expanded delivery branch. Neither snapshot nor exclusions
were changed to conceal this boundary.

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`. Owner: Thorsten Hindermann. Zielgruppen: Maintainer, Lernende,
Pruefende; Leserpfad: Pilotuebersicht -> dieser native Nachweis -> lokaler
Messbericht / CI-Artefakte. Quelle: gebundener Workflow, Git-Objekte und
ausgefuehrte native Jobs. ActiveSemantic, DE zuerst/EN danach, `sourceOnly`;
kein Home-Sync, keine globale Profil- oder Runtime-Aenderung. Gemeinsame
Constitution/Agentenregeln bleiben unveraendert. Re-Evaluation bei Aenderung
von Workflow, Paket, Pilotcommit, Messdaten oder Runner. Der gesamte Schritt 4
bleibt bis zur geregelten Lieferung und den weiteren Piloten offen; Statistik-
Fortschreibung gehoert zur naechsten PR-Vorbereitung, nicht zu einer verdeckten
Aenderung dieses bereits gesichteten Messstands.

UpdateRequired; owner Thorsten Hindermann. The reader path links pilot overview,
native evidence and measured data/CI artifacts. Bilingual source-only evidence,
no Home sync or global/runtime changes. Reevaluate when workflow, package,
pilot inputs or runner changes. Step 4 remains open pending governed delivery
and the other pilots; refresh statistics explicitly during PR preparation.
