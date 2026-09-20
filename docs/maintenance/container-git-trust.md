# Prozessgebundenes Git-Vertrauen / Process-scoped Git trust

## Verhalten / Behaviour

Die Wartung benötigt keine dauerhafte `safe.directory`-Liste im Container.
Nach der bestehenden Prüfung von Owner-Freigabe, Ablaufdatum, tatsächlichen
Mounts, Containerbenutzer, Container-ID und Quellbindung setzt jeder lokale
Git-Aufruf seine exakte Freigabe per `git -c`. Die delegierten Phasen erhalten
die geprüfte Zielmenge über `GIT_CONFIG_COUNT` für ihren Prozess und seine
Kindprozesse. Vorherige prozessbezogene Git-Konfiguration wird in diesem
isolierten Worker ersetzt und beim Verlassen wiederhergestellt. System- und
Benutzerkonfigurationen werden nicht verändert; deren übrige Einstellungen
bleiben nutzbar. Eine erste leere `safe.directory`-Angabe setzt deren eventuell
breitere Vertrauensliste für diesen Prozess zurück.

Unbekannte Ziele, Pfade außerhalb der freigegebenen Wurzel, symbolische Links,
Wildcard-Pfade und fehlende Git-Verzeichnisse werden abgewiesen. Die Freigabe
ist keine neue Sandbox-Zulassung und verlängert keine Owner-Freigabe.
Interaktive Shells und andere Agenten erhalten keine zusätzliche Berechtigung.

Nach einer Container-Neuerzeugung läuft dieselbe Prüfung erneut. Auf anderen
Systemen müssen der dortige Ausführungsvertrag und das Flottenmanifest die
tatsächlichen Mounts und Repositories beschreiben. Keine Hostpfade werden aus
diesem Nachweis übernommen. Eine fehlende oder abgelaufene Freigabe blockiert
weiterhin; es gibt keinen Host-Fallback.

*Maintenance no longer depends on a persistent container `safe.directory`
list. Existing approval, expiry, mount, user, container identity and source
checks remain mandatory. Local Git uses exact command-scope trust; delegated
workers pass their validated target set to child processes using
`GIT_CONFIG_COUNT`. Previous process-level Git configuration is replaced in
the isolated worker and restored on exit. System/user files remain unchanged
and their unrelated settings remain available. An initial empty trust entry
resets broader inherited trust for this process. Unknown, escaped, symlinked,
wildcard or missing Git targets are rejected. This grants no new sandbox
approval, interactive-shell permission or approval extension. Recreated
containers repeat validation; other systems need matching local execution and
fleet contracts. Missing or expired approval blocks without host fallback.*

## Prüfung und Aktivierung / Verification and activation

25 Delegationstests bestanden, einschließlich leerer Benutzerkonfiguration
vor/nach simulierter Neuerzeugung, Pfaden mit Leerzeichen, Zurücksetzen einer
geerbten Wildcard, unbekannter Ziele sowie Wiederherstellung nach Fehlern.
Die neue Worker-Logik bestand zusätzlich die Prüfung aller 21 Ziele in der
laufenden Linux-Sandbox unter Podman auf macOS mit abgeschalteter
System-/Benutzer-Git-Konfiguration.
Native Windows-/Linux-Hostabnahme ist damit nicht behauptet.

Die Quelländerung muss vor regulärer Nutzung veröffentlicht und im
Sandbox-Image gepinnt werden. Danach Image bauen und mit unveränderten Volumes
aktivieren, Home-Runtime/Paketbindung aktualisieren und den Wartungs-Check
ausführen. Ein Test durch Einspeisen der neuen Logik ersetzt diese Aktivierung
nicht. Bestehende manuelle Git-Einträge werden nicht gelöscht.

*The 25 delegation tests pass, including empty user configuration across
simulated recreation, spaces, inherited wildcard reset, undeclared targets and
environment restoration after errors. The new worker logic also passed all
21 targets inside the running Linux sandbox on macOS Podman with system/user
Git config disabled; this is not native Windows/Linux-host acceptance. Publish and pin
the source change before normal use, build and activate the image while
retaining volumes, refresh runtime/package bindings and run maintenance
check-only. Injecting the new logic for testing does not replace activation.
Existing manual Git entries are not deleted.*

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`. Owner: Workspace-Maintainer. Zielgruppe: Wartungsoperatoren.
Leserpfad: Wartungs-Manpage → diese Betriebsanleitung. Kanonisch sind die
beiden Module `maintenance_execution_context.py` und
`maintenance_container_worker.py`; keine Änderung der gemeinsamen Guidance.
DE zuerst/EN danach, textorientiert; keine separate Sprachpartnerdatei.
Dokumentation `sourceOnly`, Code Paket/Runtime und Image; Home-Sync nach
Lieferung erforderlich. Re-Evaluation bei Mount-, Freigabe- oder Git-Änderung.

*Decision: UpdateRequired. Owner: workspace maintainer; readers: maintenance
operators through the maintenance manpage. Both named modules are canonical;
shared guidance is unchanged. German first, English second, text-only without
a separate language file. Documentation is source-only; code needs package,
runtime and image delivery, followed by Home sync. Reevaluate on mount,
approval or Git changes.*
