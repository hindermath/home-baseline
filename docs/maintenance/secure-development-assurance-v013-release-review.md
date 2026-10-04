# Assurance v0.1.3: zentrale Release-Prüfung / Central release review

Stand / Date: 2026-10-04. Owner und menschlicher Reviewer / human reviewer: @hindermath.

## Ergebnis und Freigabegrenze / Outcome and approval boundary

**Zentrale technische Empfehlung: `ReleaseAccepted`.** Alle unten benannten
Pflichtprüfungen sind abgeschlossen. Dieser Bericht bereitet die
gesonderte menschliche Abnahme des unveränderten Presets vor. Fachliche Abnahme,
Dokumentations-Lieferfreigabe und stabile Veröffentlichung bleiben **Open**.

*Central technical recommendation: ReleaseAccepted; all listed required checks
are complete. Human acceptance, documentation delivery and
stable publication remain Open; technical results do not grant these decisions.*

Die sieben Feldtestprojekte sind nichtproduktive, nichtkommerzielle Ausbildungs-
und Referenzprojekte für die vier IHK-IT-Ausbildungsberufe. Dieser Bericht erteilt
keine Produkt-, Image-, Pilot-, Projekt-, Risiko-, Rechts-, C5-, Konformitäts-
oder Zertifizierungsfreigabe. Keine produktiven Daten oder Secrets werden benötigt.

*The seven projects are non-production educational references. This review does
not approve products, images, pilots, projects, risks, legal applicability,
conformity or certification. No production data or secrets are required.*

## Unveränderliche Quelle / Immutable source

| Bindung / Binding | Wert / Value |
|---|---|
| Preset | `secure-development-assurance-governance` v0.1.3 |
| Tag-Commit | `0d03aa9ebe8f74a26e331815bca5609fb48d7a14` |
| Tag-ZIP SHA-256 | `9023b442b4d82e25bee5a7fe9b73efb7f591a4f265f54061ae6e4a56b9b5c75f` |
| Aktuelle Level-0-Quelle / current source | `999a4e3e5c8771b2012e4d07438ca401304abde1` |
| Historisches 13er-Profil / historical profile | `e0168c7dbd9510650cc4e4304f8efc46898cb425`, Security v0.6.2 |
| Aktuelles 14er-Profil / current profile | Security v0.7.0, Architecture v0.6.1, Intake 0.3.6/0.2.4/0.2.7, Statistics v0.1.0 |
| Frische lokale Umgebung / fresh local environment | macOS arm64; Spec Kit 0.12.8; PowerShell 7.6.6; Apple jq 1.7.1 |

`git ls-remote` bestätigt den Tag-Commit. Der frisch heruntergeladene
[Tag-ZIP](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.3.zip)
hat exakt den zentral gebundenen SHA-256; `unzip -tq` beendet erfolgreich.
Die erneute Installation in beiden Kompositionskopien erhält alle ursprünglichen
Paketdateien bytegleich. Keine Quellen, Tags oder Assets wurden geändert.

*The live tag and freshly downloaded archive match the source lock. Archive
integrity passes, and original package files match after both reinstalls.
No source, tag or release asset was changed.*

## Ausführbare Prüfungen / Executable checks

Alle Installationen und Lifecycle-Operationen erfolgen in isolierten temporären
Git-Kopien; bestehende Anwenderprojekte und Home Runtime bleiben unverändert.
Der maschinenlesbare Nachweis wird in
[release-review-evidence.json](secure-development-assurance-v013-release-review-evidence.json)
veröffentlicht. Suite-Erfolg bedeutet, dass ihre Exitcode-/Hash-Assertions
bestanden sind; er ist kein menschlicher Gate-Review eines Anwenderprojekts.

*All installation and lifecycle operations use temporary Git copies. Suite
success proves its assertions, not human acceptance of a consumer project.*

| Prüfung / Check | Ergebnis / Result |
|---|---|
| Unveränderte `tests/test-secure-development-assurance.ps1` | Exit 0 |
| Unveränderte `tests/test-installed-surfaces.ps1 -ArchiveUrl <tag-zip>` | Exit 0; acht Flächen, beide Validatorpfade, fehlende Evidence jeweils Exit 2 |
| Positiver Kontext, vier getrennte Gate-Reviews | Bash/PowerShell Exit 0; gleiche Statusausgabe; menschliche Entscheidungen unverändert |
| Alle Runbook-Negativkategorien | Bash/PowerShell jeweils Exit 2 mit Ursache |
| v0.1.3-Kontext-/Risikotyp-Regressionsfälle | Exit 2 bei Suffix/Mehrdeutigkeit, falscher ID/Betriebsart und unzulässigen Risikotypen |
| Rohhash-Snapshots einschließlich versteckter Dateien | Gleiche geordnete Pfade/Hashes vor und nach Status und Gate-Reviews; Änderung/Ergänzung/Löschung/Umbenennung erkannt |
| LF und kombinierte BOM/CRLF-Fixture | Unveränderte Suite: Bash/PowerShell gleiche Ergebnisart und Exit 0; echte Inhaltsdrift blockiert |
| Separate CRLF- und BOM-Fixtures | Beide Zusatzläufe Exit 0; jeweils LF-Kontrolle und separate Encoding-Fixture unter Bash/PowerShell |
| Historisches 13er-Profil und aktuelles 14er-Profil | CheckOnly unter Bash und PowerShell, List/Info/Resolve/Check, Disable/Enable/Remove/Reinstall: Exit 0 |
| Historische Profile 8 bis 12 nach Entfernung | Je exakt passende Zielmenge, Matrixcheck und `specify check`: Exit 0 |

Die Negativkategorien umfassen Manifest-/Dokument-/Sammelbanddrift, fehlende oder
doppelte Checklisten, Versionsabweichung, offene Pflichtpunkte bei Ready,
unbegründetes N/A, abgelaufene Reviews, unvollständige akzeptierte Risiken,
fehlende Security-Voraussetzung/Runbooks/Image-Felder und unzulässige
Zertifizierungsbehauptungen. Die Suite prüft zusätzlich Risiko-IDs,
mehrere JSON-Wurzeln und jq-Ausgabeverhalten. Fachliche Review-Fristen werden
nicht verändert, um diese Prüfungen bestehen zu lassen.

*Negative cases cover the complete runbook failure categories plus context,
risk IDs/types, JSON roots and jq behavior. No real review deadline or evidence
is changed to manufacture success.*

Separate Encoding-Läufe verwenden ausschließlich temporäre Kopien der
veröffentlichten Testsuite; nur der abschließende Fixture-Encoding-Schalter
wird auf CRLF ohne BOM beziehungsweise BOM mit LF begrenzt. Der ursprüngliche
Test und das veröffentlichte Paket bleiben unverändert.

*Supplemental runs change only the final fixture encoding in temporary test
copies. The original suite and published archive remain unchanged.*

### Native Plattformnachweise / Native platform evidence

[Regression-Run 34059720402](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/actions/runs/34059720402)
ist live erfolgreich und an exakt den Tag-Commit gebunden. Die Jobs für
`ubuntu-22.04`, `windows-2022` und `macos-14` einschließlich des Schritts
"Validate contracts and generated commands" sind erfolgreich. Diese historischen
nativen Nachweise ergänzen die neue macOS-Ausführung; es wird keine neue lokale
Linux-/Windows-Ausführung und kein aktueller nativer 14er-Flottentest behauptet.

*Successful historical native jobs bind to the exact tag commit. Fresh local
execution is macOS only; PowerShell on macOS is not native Windows evidence.*

## Feldberichte und Community / Field reports and community

Alle sieben Referenzen und Merge-Commits der
[Siebener-Konsolidierung](secure-development-assurance-v013-field-test-rollup.md#projekt-evidence--project-evidence)
wurden live abgeglichen: TinyCalc #74, TinyPl0 #92, InventarWorkerService #67,
absdd-image-sandbox #60, TuiVision #171, home-baseline #277 und AOC #44 sind
gemergt. Die Berichte enthalten weiterhin `ReleaseAccepted` für v0.1.3 in ihrem
begrenzten Scope; ihre historischen Pre-Release-/Community-Hinweise sind keine
neuen Blockierungen. Keine erneute Feldtestabnahme oder Flotteninstallation.

Die Community-Aufnahme ist abgeschlossen: [Issue #4455](https://github.com/github/spec-kit/issues/4455)
geschlossen, [PR #4513](https://github.com/github/spec-kit/pull/4513) am
2026-09-10 gemergt, Merge `7cb2c7dfc5b7bb5cc1154a16c5eedab370b6941b`.
Der live geprüfte Community-Katalog enthält v0.1.3. Das ersetzt nicht die
gesonderte zentrale Release-Entscheidung.

*All seven scoped reports and merge references were checked live. Community
acceptance is complete but does not grant central release approval.*

## Findings und nächste Entscheidung / Findings and next decision

- **CLI-REMOVE-01:** Spec Kit 0.12.8 lässt in beiden temporären Profilen zwei
  Claude-Skills nach Remove zurück. Vollständige Deinstallation wird nicht
  behauptet. Wiederinstallation und Paketgleichheit bestehen; kein CLI-Patch.
  Begrenzte externe CLI-Einschränkung, kein neuer Preset-Vertragsfehler.
- **HARNESS-01:** Der erste Versuch prüfte einen verbleibenden 12er-Bestand
  gegen eine 8er-Matrix; der unveränderte Validator blockierte korrekt mit
  Exit 1 wegen zusätzlicher IDs. Danach wurden die Profile 8 bis 11 in eigenen
  Kopien auf die exakte Zielmenge reduziert und erfolgreich geprüft. Der
  erste Fehlversuch bleibt nachvollziehbar; keine Abschwächung des Validators.
- **Proof-Grenze:** Synthetische Fixtures plus begrenzte Ausbildungsfeldtests
  sind keine unabhängige Zertifizierung oder pauschale Sicherheitsgarantie.
  Bestehende menschliche Entscheidungen und Projektfindings werden nicht geschlossen.

*Known CLI removal residue and the corrected test-harness setup are recorded
separately. No validator was weakened and no wider approval is inferred.*

Nach erfolgreicher Technik entscheidet @hindermath ausdrücklich über Bericht,
Dokumentationslieferung und stabile Veröffentlichung. Erst danach werden die
Release-Notes auf den gemergten Bericht verweisen und der Pre-Release-Schalter
entfernt. Version, Tag, Commit, Assets und ZIP-SHA-256 bleiben unverändert.
Bei `PatchRequired` oder `Blocked` bleibt das Release ein Pre-Release; notwendige
Paketänderungen benötigen eine neue Version. Wiedervorlage spätestens
2027-10-03 gemäß zentralem Jahresreview, früher bei Paket-/Vertrags-/CLI-Drift
oder neuen Findings. Bestehende Projektfristen bleiben unverändert.

*Human acceptance precedes delivery and stable publication. The existing
archive is never replaced. Reevaluate at the annual review or earlier on drift;
individual project deadlines are unchanged.*

Documentation Impact: `UpdateRequired`; `sourceOnly`; kein Home-Sync.
Leserpfad: Konsolidierung → zentrale Prüfung → Evidence → menschliche Abnahme.
DE zuerst, EN danach; keine Diagramme oder farbabhängigen Statussignale.
