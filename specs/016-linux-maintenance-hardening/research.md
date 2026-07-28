# Research: Linux Maintenance Hardening

## Decision 1: stdin-isolierte Registry-Snapshots

Jede ausgewählte Registry-Menge wird vor der ersten Mutation in ein
temporäres, zeilenbasiertes Snapshot geschrieben. Schleifen lesen über einen
eigenen Dateideskriptor; jeder gestartete Paketmanager erhält stdin von
`/dev/null`. Dadurch kann ein interaktiver Kindprozess keine folgenden
Registry-Zeilen konsumieren. Prozesssubstitution allein genügt nicht, weil ihr
Deskriptor weiterhin vererbt werden kann.

## Decision 2: Ein Resultat je Registry-Eintrag

Die Wartung erzeugt für jeden ausgewählten Eintrag genau eine finale
Resultatzeile in Registry-Reihenfolge. Der Status ist
`Present | Installed | Planned | Failed | StillMissing`; Scope und Versuch
bleiben erhalten. Abschlussprüfung reduziert diese Resultate, statt
nicht-strukturierte Konsolenausgabe erneut zu interpretieren.

## Decision 3: Strukturierte, begrenzte CLI-Proben

Ein Python-3-Helfer startet Argumentlisten ohne Shell, mit neuer Prozessgruppe,
fünf Sekunden Standardtimeout und maximal 2 KiB bereinigter kombinierter
Fehler-Evidence. Timeout beendet erst die Gruppe mit `TERM`, danach bei Bedarf
mit `KILL`. Rückgabeklassen sind `Available`, `Missing`, `Unusable`,
`TimedOut` und `CapabilityBlocked`; bekannte `snap-confine`-/Capability-Muster
werden nicht als bloßes Missing verschleiert.

## Decision 4: Required ist fail-closed

Nach allen sicheren Installationsversuchen werden Required- und
Optional-Scope separat geprüft. Eine nicht leere Required-Menge liefert
Exitcode `1`; ein Betriebs-/Vertragsfehler liefert `2`; ausschließlich
optionaler Drift bleibt Exitcode `0` mit Warnstatus. Dry-run und Compare-only
mutieren nicht, melden Required-Drift aber ebenfalls mit Exitcode `1`.

## Decision 5: Offizielles Swiftly als Linux-Installationsgrenze

Swift.org beschreibt Swiftly als offiziellen Linux-/macOS-Toolchainmanager und
stellt einen unbeaufsichtigten Ablauf bereit. Der Repository-Vertrag pinnt
Swiftly `1.1.2` und Swift `6.3.3`. Die offizielle Swift-Release-API listet
Swift `6.3.3` für Ubuntu 22.04 und 24.04 auf `x86_64` und `aarch64`; genau
diese Matrix wird unterstützt. Ubuntu 20.04 und alle anderen Kombinationen
enden vor Download oder Mutation mit einer Upgrade-/Support-Aktion.

Gepinnte Swiftly-Bootstrap-Artefakte:

| Architektur | URL | SHA-256 |
|---|---|---|
| `x86_64` | `https://download.swift.org/swiftly/linux/swiftly-1.1.2-x86_64.tar.gz` | `21ad3d6376af0b423435f1f7295364add66c7173ea342654f4ae536c20ae88ba` |
| `aarch64` | `https://download.swift.org/swiftly/linux/swiftly-1.1.2-aarch64.tar.gz` | `cb53dfea98f23a2bf62e89c2abbbf2f331ba5ad8ebc4a68a37e918b964848627` |

Die Werte wurden am 2026-07-28 gegen vollständige, erfolgreich lesbare
Archive der offiziellen Download-Domain geprüft. Die offizielle
`swiftly.json`-API bleibt die Versionsquelle; ein neuer Pin benötigt erneut
vollständigen Download-, Archiv- und Hashnachweis.

Der Ablauf ist:

1. `/etc/os-release` und `uname -m` als Daten validieren.
2. Version, URL und Hash aus dem Registry-Vertrag auswählen.
3. In ein enges Temp-Verzeichnis laden und SHA-256 vor Extraktion prüfen.
4. `swiftly init --assume-yes --no-modify-profile --skip-install
   --platform=<ubuntuNNNN>` ausführen.
5. Die von Swiftly erzeugte `env.sh` im aktuellen Bash-Prozess laden.
6. Eine gepinnte Swift-Version mit `--post-install-file` installieren und
   aktivieren.
7. Einen notwendigen Post-Install-Schritt nur mit aktueller
   Admin-Prompt-Autorität ausführen.
8. `swift --version` im selben Prozesskontext erneut begrenzt prüfen.

Swiftly verifiziert die nachgelagerte Swift-Toolchain über die offizielle
Swift-Infrastruktur. Der zusätzliche Bootstrap-Hash schützt die erste
Ausführung. Eine mutable „latest“-URL ohne gepflegten Hash wird nicht
verwendet.

## Decision 6: Admin-Autorität bleibt eigener Zustand

`maintain-agentic-brew-apps.sh` erhält denselben expliziten
`--allow-admin-prompts`-Schalter wie der Orchestrator. Der Orchestrator reicht
ihn nur für den aktuellen Aufruf weiter. Fehlt er, werden sudo-/apt- und
Swift-Post-Install-Mutationen nicht gestartet; Required-Drift endet als
`DEFERRED_ADMIN_REQUIRED` mit Exitcode `1`, Restliste und nächster Aktion.

## Decision 7: Einmalige Finalisierung

Der Orchestrator registriert getrennte Handler für `EXIT`, `INT` und `TERM`.
Eine Guard-Variable erlaubt exakt eine Finalisierung. Vor jeder Stufe wird die
aktuelle Stage ID gespeichert; jeder Pfad schreibt Status, echte Exitcodes,
Signal und nächste Aktion über den atomaren Python-Reportvertrag. Ein
vorausgehender Success-Stand wird dabei ersetzt.

## Decision 8: TDD und plattformneutrale Regression

Alle Fehlerklassen werden über lokale Fixtures reproduziert. Fake-Binaries,
temporäre Registries und ein isoliertes HOME verhindern Netzwerk-,
Paketmanager-, Profil- oder Privilegienmutation. Die gemeinsame Homebrew-Logik
wird auf Linux simuliert und auf macOS durch CI revalidiert; Windows prüft nur
gemeinsam veränderte Registry-/Statusverträge.

## Threat and Risk Model

| Grenze / Risiko | Angriff oder Fehler | Mitigation | Restrisiko |
|---|---|---|---|
| Registry → Shell | Argument-/Optionsinjektion | JSON-Validierung, Arrays, Quoting, kein `eval`, `--` wo unterstützt | Externe Tools können eigene Semantik ändern; Tests und Versionsreview |
| Schleifen-stdin → Kindprozess | spätere Einträge werden konsumiert | Snapshot-FD plus `/dev/null` für Mutationen | Plattformtools können TTY verlangen; dann expliziter Fehler |
| PATH → Launcher | Shadowing, defekter Snap-Launcher | begrenzte Funktionsprobe, Klassen und bereinigte Evidence | neue Fehlermuster zunächst `Unusable` statt spezifischer Klasse |
| Swift.org → Bootstrap | manipuliertes oder ausgetauschtes Archiv | HTTPS, versionierte URL, gepflegter SHA-256 vor Extraktion | legitimes Update erfordert Registry-/Hash-Review |
| Swiftly → Toolchain | kompromittierte Toolchain | offizielle API und Swiftly-Signaturprüfung | upstream Signatur-/Key-Risiko bleibt Lieferantenrestrisiko |
| Post-Install → sudo | ungeprüfte privilegierte Mutation | explizite Autorität, verifizierte Quelle, kein automatischer Bypass | Nutzer muss sichtbaren Admin-Schritt zulassen |
| Reportpfad → Abschluss | alter Erfolg überlebt Fehler/Signal | Run ID, aktuelle Stage, einmaliger Handler, atomarer Austausch | Hardware-/Dateisystemausfall kann letzte vollständige Evidence bewahren |

## Rejected Alternatives

- `brew install </dev/null` allein: schützt nur einen Aufruf, beweist aber
  keine vollständige Ergebnisbilanz und nicht alle Schleifen.
- `curl | sh`: verletzt die Integritäts- und Review-Grenze.
- Nur `command -v`: erkennt Capability-, Timeout- und defekte Launcher nicht.
- Report nur am normalen Ende schreiben: lässt späte Fehler und Signale ohne
  wahrheitsgetreue Evidence.
- Admin-Bypass für Paketmanager oder Post-Install: ausdrücklich außerhalb der
  Autorität und des Sicherheitsvertrags.
