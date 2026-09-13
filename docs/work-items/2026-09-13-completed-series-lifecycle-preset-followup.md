# Workitem: Lifecycle-Regel für abgeschlossene Intake-Serien / Completed Intake-Series Lifecycle Rule

- Status: Completed — Releases, TuiVision-Rollout und Clean-Checkout-Nachweis abgeschlossen / releases, TuiVision rollout and clean-checkout proof completed
- Owner: Maintainer von `intake-authoring-governance`,
  `intake-review-governance` und `intake-sequencing-governance`
- Datum / Date: 2026-09-13
- Ursprung / Origin: TuiVision-Serie `tui-vision-delivery`
- Entscheidung / Decision: `Promote`
- Dokumentationsauswirkung / Documentation impact: `UpdateRequired`

## Anlass / Motivation

Die TuiVision-Serie war mit zehn abgeschlossenen Features und null
ausführbaren Zielen als `Completed` gekennzeichnet. Acht zugehörige Intakes
lagen jedoch weiterhin ohne Feature-Suffix in der aktiven Sammlung. Nur die
beiden zuletzt gelieferten Intakes waren bereits korrekt archiviert. Die drei
installierten Konfigurationsvalidatoren akzeptierten diese widersprüchliche
Zuordnung, weil sie den Status der Serienmitglieder nicht gegen deren
konfigurierte Sammlung prüften.

*The TuiVision series was marked `Completed` with ten completed features and
no executable targets. Eight associated intakes still remained in the active
collection without their feature suffix, while only the two latest intakes
had been archived correctly. All three installed configuration validators
accepted this inconsistent mapping because they did not check each series
member's lifecycle status against its configured collection.*

## Feldnachweis / Field Evidence

| Feld / Field | Wert / Value |
|---|---|
| Repository | `hindermath/TuiVision` |
| Ausgangs-Head / Baseline head | `5c2c3c301afa8c9cbdba24687294e7d53ed7e417` |
| Korrekturbranch / Correction branch | `codex/completed-intake-archive-reconciliation` |
| Erster Pull Request / Initial pull request | `hindermath/TuiVision#175` |
| Erster geprüfter Head / Initial reviewed head | `d7cd2c63bc0d8925104a6a7bd0c6aadb27b1fc5f` |
| Erster Merge-Commit / Initial merge commit | `94d2d9f3ea5d079b8df1cc5bc112c2bfb807419b` |
| Clean-Checkout-Folge-PR / Clean-checkout follow-up PR | `hindermath/TuiVision#176` |
| Final geprüfter Head / Final reviewed head | `47283e9d2aa4dab50d50fba07fcc3bd8e18d734a` |
| Finaler Merge-Commit / Final merge commit | `5074a2ccd50e8a427a3e683888945191d6dae12e` |
| Serie / Series | `a73dda7c-163b-4530-97f2-fd9eea5e8986`, `tui-vision-delivery` |
| Zielmenge / Target set | Features `037` bis `046`, zehnmal `Completed` |
| Ausgangsbefund / Initial finding | acht `Completed`-Ziele unter `active`, zwei unter `archive` |
| Zielzustand / Target state | zehn `Completed`-Ziele unter `archive`, null aktive oder `Eligible`-Serienziele |
| Historische Ausgangsversionen / Historical baseline versions | Authoring `0.3.1`, Review `0.2.1`, Sequencing `0.2.3` |
| Projektnachweis / Project proof | `scripts/validate-requirements-intake-alignment.mjs` und `scripts/tests/requirements-intake-alignment-tests.mjs` |
| Preset-Nachweis / Preset proof | die drei installierten `validate-intake-governance-config.py` plus Cross-Shell-Fixtures |

Der korrigierte Manifest-Kandidat hat den normalisierten SHA-256
`268a3d3e37e279127f0fcfc099e7761df0443dc4c9625392a70441c619bdf894`.
Der read-only Statuslauf ergab in allen drei Presets sowie für Manifest und
Series-Receipt unter Bash und PowerShell bytegleiche JSON-Ausgaben. Der letzte
zusammengefasste Evidence- und Git-Status-Hash blieb vor und nach der Prüfung
`ac01d755b7628539d9dbfdb9e372709cf88d8a5e8b5ec1cd4873836edc17fead`.
Die projektspezifische Suite bestand vier Positiv- und 18 Negativfälle; alle
drei Preset-Suiten bestanden ihre positiven und negativen Fälle über beide
öffentlichen Shell-Wrapper.

Am exakten PR-Head waren 36 technische Checks erfolgreich; der ausschließlich
für `main` vorgesehene DocFX-Deploy wurde erwartungsgemäß übersprungen. Es gab
null Review-Threads. Der Copilot-Dienst lieferte auf einem älteren Head einen
Fehler statt eines Reviews und blieb deshalb als fehlender Review dokumentiert.
Der normale Merge scheiterte ausschließlich an der Human-Approval-Regel. Der
zuvor ausdrücklich begrenzt autorisierte Admin-Bypass wurde erst nach grünen
technischen Gates und der Prüfung auf umsetzbare Threads verwendet.

Der erste Statuslauf auf dem nach PR #175 frisch ausgecheckten `main` deckte
eine weitere portable Grenze auf: Git speichert das leere aktive Verzeichnis
nicht. Die drei Konfigurationsvalidatoren meldeten deshalb noch
`MigrationRequired`, obwohl Manifest, Receipt und Projektvalidator den
abgeschlossenen Zustand korrekt akzeptierten. PR #176 behebt genau diese
Abweichung. Im Modus `SeriesManifest` gilt eine fehlende aktive Collection als
Bestand null; `DirectoryStrict` verlangt das Verzeichnis weiterhin. Alle drei
Cross-Shell-Suiten enthalten nun den realen Clean-Checkout-Fall. Am finalen
Head waren 33 technische Checks grün, ein nur für `main` vorgesehener Deploy
war erwartungsgemäß übersprungen und es gab null Review-Threads. Copilot
lieferte erneut einen Dienstfehler statt eines Reviews; der enge Admin-Bypass
erfolgte erst, nachdem der normale Merge ausschließlich an Human Approval
gescheitert war.

*The corrected manifest candidate has normalized SHA-256
`268a3d3e37e279127f0fcfc099e7761df0443dc4c9625392a70441c619bdf894`.
All three preset validators plus the manifest and series-receipt validators
produced byte-identical JSON through Bash and PowerShell. The combined evidence
and Git-status hash remained unchanged at
`ac01d755b7628539d9dbfdb9e372709cf88d8a5e8b5ec1cd4873836edc17fead`
before and after status inspection. The project suite passed four positive and
18 negative cases, and all three preset
suites exercised their positive and negative cases through both public shell
wrappers. On the exact reviewed head, 36 technical checks passed, the
main-only DocFX deployment was skipped as expected, and no review thread
existed. Copilot returned a service error on an older head and therefore
remained recorded as a missing review. The narrowly authorized admin bypass was
used only after the ordinary merge was blocked solely by the human-approval
rule. The first clean-checkout status after PR #175 then exposed one remaining
portable boundary: Git does not preserve the empty active directory. PR #176
therefore permits an absent active collection to count as zero only in
`SeriesManifest` mode, while `DirectoryStrict` remains unchanged. All three
cross-shell suites now exercise the real clean-checkout case. The final head
passed 33 technical checks with one expected main-only deployment skip and no
review threads. Copilot again returned a service error; the narrow bypass was
used only after the ordinary merge was blocked solely by human approval.*

Die lokale Korrektur verschiebt die acht Dateien nach
`requirements/intakes/archive/`, versieht sie mit den Feature-Suffixen
`.037-*` bis `.044-*` und aktualisiert Manifest, Roots, Abhängigkeiten,
Series-Receipt, Operation, Review-Evidence, Run-State-Pfade und die
menschenlesbaren Reihenfolgen atomisch. Der Projektvalidator verwendet danach
eine exakte Fixture statt fest eingebauter aktiver TuiVision-Pfade.

*The local correction moves the eight files to the archive, adds feature
suffixes `.037-*` through `.044-*`, and atomically updates the manifest,
roots, dependencies, series receipt, operation, review evidence, run-state
paths, and human-readable order views. The project validator then uses an
exact fixture instead of hard-coded active TuiVision paths.*

## Providerneutrale Zielregel / Provider-Neutral Target Rule

1. Ein `Completed`-Serienmitglied muss unter der konfigurierten
   Archivsammlung liegen.
2. Ein nicht abgeschlossenes ausführbares Serienmitglied muss unter der
   konfigurierten aktiven Sammlung liegen.
3. Backlog- und History-Pfade dürfen nicht still als ausführbare
   Serienmitglieder gelten.
4. Eine aktive Serie darf archivierte `Completed`-Vorgänger und aktive
   Folgezustände gemeinsam enthalten.
5. Eine abgeschlossene Serie darf ihre vollständig abgeschlossenen Mitglieder
   im Manifest behalten und muss genau null `Eligible`-Ziele besitzen.
6. `activeIntakeCount` zählt die physische aktive Sammlung. Die Anzahl aktiver
   Serienziele ist davon getrennt, damit eigenständige, noch nicht in die
   Serie aufgenommene Intakes zulässig bleiben.
7. Ein unveränderliches Authoring-Receipt darf nach späterer Serienaufnahme
   weiterhin seine ursprüngliche Standalone-Bindung `N/A` tragen. Sein
   verschwundener aktiver Zielpfad ist nur dann gültig, wenn Manifest, Name
   und normalisierter Hash genau einen abgeschlossenen Archivnachfolger
   ergeben. Eine fremde Serienbindung bleibt ungültig.

*Completed members belong to the configured archive collection, while
non-completed executable members belong to the active collection. Active
series may combine archived predecessors with active follow-up members. A
completed series retains all completed members but exposes no eligible target.
Physical active inventory and active series membership are separate counts.
An immutable standalone authoring receipt may remain standalone after later
series adoption only when the current manifest, normalized hash, and target
name identify exactly one completed archive successor; a foreign series claim
must fail.*

## Reproduzierbare Tests / Reproducible Tests

Positive Fälle:

- aktive Serie mit einem archivierten `Completed`-Mitglied und einem aktiven
  `Eligible`-Mitglied;
- abgeschlossene Serie mit ausschließlich archivierten `Completed`-Mitgliedern
  und null `Eligible`-Zielen;
- abgeschlossene Serie ohne physisch vorhandenes, leeres aktives Verzeichnis;
- eigenständiger aktiver Intake außerhalb der Serie mit gültigem Receipt;
- historisches Standalone-Receipt mit genau einem hashgleichen archivierten
  Seriennachfolger.

Negative Fälle:

- `Completed`-Mitglied in der aktiven Sammlung;
- `Eligible`, `Pending` oder `Blocked` in der Archivsammlung;
- abgeschlossene Serie mit `Eligible`- oder nicht abgeschlossenem Mitglied;
- Serienziel in Backlog oder History;
- fehlender, doppelter oder hashabweichender Archivnachfolger;
- historisches Receipt mit einer fremden Serien-ID.

Alle Konfigurationsfälle müssen über die öffentlichen Bash- und
PowerShell-Wrapper denselben Exitcode und dieselbe Fehlerklasse liefern.
Direktes Testen nur der gemeinsamen Python-Engine reicht für den
Cross-Platform-Nachweis nicht aus.

*Every configuration fixture must run through both public Bash and PowerShell
wrappers and produce equivalent exit codes and finding classes. Testing only
the shared Python engine is insufficient for cross-platform evidence.*

## Preset-Zuschnitt / Preset Scope

`Promote`:

- Status-zu-Collection-Prüfung in allen drei Governance-Presets;
- abgeschlossene Serien mit erhaltenen archivierten Mitgliedern und null
  `Eligible`-Zielen;
- getrennte Zählung physischer aktiver Intakes und aktiver Serienziele;
- positive und negative Cross-Shell-Fixtures;
- Runbook-, Checklist-, Agent- und Manpage-Hinweise zur Lifecycle-Regel.

`RejectProjectSpecific`:

- TuiVision-Dateinamen, Feature-Nummern `037` bis `046`, zehn Ziele, fünf
  Roots, sechs Abhängigkeiten und 38 Archivdateien;
- lokale Renderer-, Review- und Run-State-Pfade;
- TuiVision-spezifische Exact-Fixture und Versionszählung.

## Berechtigungs- und Sicherheitsgrenze / Permission and Safety Boundary

Bei der Anlage war dieses Workitem ausschließlich ein Folgeauftrag ohne
Ausführungsautorität. Thorsten hat am 2026-09-13 die Umsetzung in den drei
bestehenden öffentlichen Preset-Quellen einschließlich Tests, Dokumentation,
Patch-Releases und anschließendem ersten Rollout ausschließlich auf TuiVision
ausdrücklich autorisiert. Danach hat Thorsten mit dem Auftrag
"DeliveryMode MergeAndSync mit Admin-Bypass." auch den Admin-Bypass fuer diese
Lieferung freigegeben. Technische Gates bleiben verbindlich. Weitere Verbraucher
gehoeren nicht zu diesem Auftrag. Validatoren bleiben read-only und dürfen
fehlplatzierte Dateien nicht automatisch verschieben.

*Initially this work item only recorded follow-up work. On 2026-09-13 Thorsten
explicitly authorized implementation in the three existing public preset
sources, tests, documentation, patch releases, and an initial rollout to
TuiVision only. The subsequent explicit instruction
"DeliveryMode MergeAndSync mit Admin-Bypass." authorizes admin bypass for this
delivery after technical gates. Other consumers remain outside this authority. Validators remain read-only and must not move files automatically.*

## Vorgesehene Umsetzung / Intended Implementation

1. Den Defekt in einem temporären deutsch- und englischsprachigen Projekt
   reproduzieren.
2. Die kleinste gemeinsame Lifecycle-Regel in allen drei Preset-Quellen
   implementieren.
3. Bash-/PowerShell-Parität, LF/CRLF, Manifest- und Receipt-Lifecycle sowie
   bestehende Create-, Review- und Sequencing-Fixtures prüfen.
4. Nur bei grüner Parität Patch-Versionen veröffentlichen und versionierte
   ZIP-Dateien validieren.
5. Ausschliesslich TuiVision mit der erteilten Rollout-Autoritaet aktualisieren.
   Weitere Verbraucher bleiben ausserhalb dieses Auftrags.

## Abschlusskriterien / Acceptance Criteria

- Die drei Presets lehnen Status-/Collection-Widersprüche gleich ab.
- Eine vollständig abgeschlossene archivierte Serie mit null `Eligible`
  wird akzeptiert.
- Eine laufende Serie mit archivierten Vorgängern bleibt darstellbar.
- Eigenständige aktive Intakes außerhalb der Serie bleiben zulässig.
- Cross-Shell-Fixtures beweisen positive und negative Fälle.
- Keine projektspezifische Kardinalität oder TuiVision-Pfadannahme gelangt in
  ein Preset.

Dokumentationsklasse ist `sourceOnly`; ein Home-Sync ist für dieses Workitem
nicht erforderlich. Wiedervorlage erfolgt vor der nächsten Änderung an einem
der drei Intake-Governance-Presets.

*This is source-only documentation and requires no Home sync. Re-evaluate it
before the next change to any of the three intake-governance presets.*

## Lieferung 2026-09-13 / Delivery 2026-09-13

| Preset | Release | Gemergter Quell-PR / Merged source PR |
|---|---|---|
| Authoring | [0.3.2](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.2) | [Authoring #6](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/6) |
| Review | [0.2.2](https://github.com/hindermath/spec-kit-preset-intake-review-governance/releases/tag/v0.2.2) | [Review #6](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/6) |
| Sequencing | [0.2.4](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/releases/tag/v0.2.4) | [Sequencing #7](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/7) |

Alle drei Releases enthalten die Status-/Collection-Pruefung, die Trennung
von `activeIntakeCount`, `activeSeriesTargetCount` und `seriesTargetCount`, den
Clean-Checkout-Fall sowie sprach- und shelluebergreifende Fixtures. Das
Authoring-Preset loest fehlende historische Ziel- und Repository-Quellpfade nur
ueber genau einen abgeschlossenen Archivnachfolger mit passendem Namen,
Manifest und normalisiertem Hash auf. Fremde Serienbindungen bleiben ungueltig.

Alle neun nativen Quell-Jobs bestanden an den finalen Commits auf macOS,
Linux und Windows; beide oeffentlichen Shell-Wrapper, LF/CRLF, deutsche und
englische Projekte und bestehende Domain-Regressionen wurden geprueft. Native
CI deckte Windows-Fixturefehler und die versehentliche Weitergabe erwarteter
Negativ-Exitcodes auf; diese wurden vor dem finalen gruenen Lauf korrigiert.

Die normalen Merge-Versuche wurden zunaechst allein wegen `REVIEW_REQUIRED`
abgewiesen. Erst nach Thorstens anschliessender ausdruecklicher Freigabe fuer
`MergeAndSync` mit Admin-Bypass wurden die PRs gemergt. Die Merge-Trees sind
identisch mit den technisch geprueften Quell-Trees. Dies behauptet keine
unabhaengige menschliche Review. Die historische Bypass-Freigabe aus dem
urspruenglichen Feldtest wurde nicht fuer diese Lieferung wiederverwendet.

Die veroeffentlichten Tag-ZIPs wurden heruntergeladen und alle 38/29/39 Dateien
gegen ihre Release-Commits geprueft. Die regulaere TuiVision-Arbeitskopie wurde
anschliessend gezielt aus diesen URLs installiert; ihre Dateien stimmen mit den
Paketen ueberein. Die vorherige isolierte Installationsprobe bleibt gesonderte
Evidence. Prioritaeten 64/65/66, andere Presets, Projektvalidatoren, bestehende
Intakes und Receipts bleiben erhalten. Die lokale Lifecycle-Korrektur wird
jetzt aus den drei allgemeinen Produktquellen geliefert.

[TuiVision PR #177](https://github.com/hindermath/TuiVision/pull/177) bindet die
Installationen und erweitert den bestehenden Requirements-Workflow um native
Lifecycle-/Manifest-/Receipt-Paritaet. Lokal bestanden vier positive und
18 negative Projekt-Fixtures, alle zehn Authoring-Receipts in beiden Shells
und 1028/1028 .NET-Tests. Die fuenf Pflichtassemblies erreichen 94.97, 86.96,
90.47, 83.33 und 93.93 Prozent Line-Coverage. Sechs veraltete Sicherheits-Audit-
Quellenbindungen wurden nach semantischer Revalidierung aktualisiert; die
157 Kontrolldispositionen und menschlichen Abnahmegrenzen bleiben erhalten.

TuiVision PR #177 ist gemergt und die regulaere Arbeitskopie auf main
mit origin/main synchron (ahead/behind 0/0, sauber). Gepruefter Head:
`fa8ee931747e357a52678a7793511d3fa05c221c`; Merge:
`a2bc4f99a465ea7c0c7f6772db7da10ee59c30cc`. Beide besitzen den identischen Tree
`164916b8a6cf7f8ff67f4d19cc4a55089ab92208`. Alle 39 Checks bestanden;
der nur fuer main vorgesehene DocFX-Deploy wurde erwartet uebersprungen.
Es gab null Review-Threads; Copilot lieferte einen Dienstfehler statt Review,
der Claude-Workflow war erfolgreich. Der normale Merge scheiterte an der
Branch-Policy; anschliessend wurde der aktuell autorisierte Admin-Bypass genutzt.

Der abschliessende frische Checkout des Merge-Commits enthaelt kein aktives
Verzeichnis. Trotzdem liefern alle drei Konfigurationsvalidatoren in Bash und
PowerShell identisches Aligned-JSON: zehn archivierte Completed-Mitglieder,
null aktive Intakes, null aktive Serienziele und null Eligible. Manifest,
Serien-Receipt und alle zehn Authoring-Receipts sind gueltig. Projektvalidator,
vier positive und 18 negative Fixtures bestehen. Der Checkout blieb sauber.
Damit sind saemtliche Abschlusskriterien erfuellt; das Workitem ist geschlossen.

Die [maschinenlesbare Delivery-Evidence](2026-09-13-completed-series-lifecycle-evidence.json)
bindet Source-Commits, Befehle, native Jobs, Log-/Entscheidungs-SHA-256,
veroeffentlichte ZIPs, Installationspruefung und Rollout-Evidence. Die zentrale
Standard-Achtermatrix und weitere Verbraucher bleiben unveraendert.

Dokumentationsentscheidung: `UpdateRequired`. Owner: Level-0- und
Preset-Maintainer. Zielgruppen: Maintainer, Agenten und Reviewende; Leserpfad:
Workitem → Quell-PR/Release → Lifecycle-Dokumentation → TuiVision-Rollout.
Dokumentklasse: Auftrags- und Delivery-Evidence; kanonische Produktquellen sind
die drei eigenstaendigen Preset-Repositories. Navigation: bestehender Workitem-
Pfad plus direkte PR-/Release-Links. Sprachpartner: integriertes DE/EN.
Plattformnachweis: macOS lokal, native Quell-CI auf drei Betriebssystemen;
39 erfolgreiche Rollout-Checks und finaler Clean-Checkout-Nachweis sind gebunden. Distribution: `sourceOnly`; kein
Home-Sync. Statistik wird aus ihrer kanonischen Konfiguration gerendert.
Re-Evaluation bei Aenderungen an Preset, Registry oder Lifecycle-Vertrag.

*The three existing presets are published at 0.3.2, 0.2.2 and 0.2.4 after all
nine native source jobs passed. Both wrappers, LF/CRLF, German/English fixtures
and existing domain regressions were exercised. Ordinary merges first failed
for missing human approval. The subsequent explicit MergeAndSync/admin-bypass
instruction authorized delivery after technical gates; the old field-test
bypass was not reused and independent human review is not claimed. Merge trees
match the tested trees. All 38/29/39 downloaded tag-ZIP files and installed
TuiVision files were compared. Priorities and unrelated project extensions
remain intact. PR #177 contains rollout evidence and native installed-preset
checks. Local validation passed ten immutable receipts in both shells,
4 positive/18 negative fixtures and 1028 .NET tests, with each required assembly
above 70% coverage. Six audit bindings were revalidated without changing the
157 control dispositions or human acceptance boundaries. TuiVision PR #177 passed 39 checks (one expected main-only deployment skip),
was merged under current admin authority, and main is synchronized cleanly.
The final fresh checkout, with no active directory, passed both shells for all
three configurations, ten archived members, zero active/eligible targets and
ten valid receipts; project fixtures passed and Git remained clean. All
acceptance criteria are fulfilled and the workitem is closed.
Other consumers and the central matrix remain unchanged. Documentation impact
is UpdateRequired; this bilingual source-only evidence needs no Home sync.*
