# Windows-Podman-Mountpfade / Windows Podman mount paths

## Umfang / Scope

Owner-Auftrag: den Windows-Pfadvergleich gezielt korrigieren, ohne die
Sandbox-Pruefung abzuschwaechen, danach Windows-Flottenwartung fortsetzen.
macOS bleibt primaer; Windows und Ubuntu/WSL sind Kompatibilitaetsplattformen.
Die separate WSL-Sandbox und deren Arbeitskopien werden nicht veraendert.

The owner authorized a bounded Windows path-comparison correction followed
by Windows fleet maintenance. macOS remains primary; Windows and Ubuntu/WSL
are compatibility platforms. The separate WSL sandbox stays unchanged.

## Vertrag und Nachweis / Contract and evidence

Podman meldet Windows-Bind-Mounts aus seiner Linux-VM als `/mnt/<laufwerk>/...`.
Der Vergleich akzeptiert nur auf Windows die exakt aus dem vertraglichen
absoluten Laufwerkspfad abgeleitete Form. Keine Suffixsuche, keine alternative
Mountwurzel, keine UNC-Uebersetzung und keine Gross-/Kleinschreibungsfaltung
des Linux-Pfads. Native Windows-Pfade bleiben moeglich; macOS/Linux unveraendert.
Container-ID, Image, non-root-Benutzer, Mounttyp, Schreibmodus, Owner-Freigabe,
Ablaufdatum und Quellhashbindung bleiben eigenstaendige Pflichtpruefungen.

Podman's VM reports Windows bind sources as `/mnt/<drive>/...`. Only Windows
accepts that exact spelling derived from the contracted absolute drive path.
No suffix matching, alternate root, UNC translation or Linux case folding is
introduced. Native Windows paths remain supported; macOS/Linux are unchanged.
All existing container, user, mount, approval and immutable-source gates remain.

Regressionen in `test_maintenance_execution_context.py` pruefen passende
Windows-/VM-Pfade sowie falsche Laufwerke, Benutzer, Nachbar-/Unterverzeichnisse,
Traversal, Gross-/Kleinschreibung, relative Pfade, UNC, falschen Mounttyp und
Read-only-Mounts. Bestehende Container-Identitaets- und Quellpruefungen bleiben.

Regression fixtures cover matching paths and rejection of wrong drives, users,
siblings, children, traversal, case, relative paths, UNC, mount type and mode.
The existing container-identity and immutable-source tests remain in place.

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`; kanonisch: Transportmodul und Tests; Owner: Script Maintainer.
Zielgruppe: Betreiber/Maintainer; Leserpfad: Manpage, Sandbox-Vorpruefung,
gezielte Fehleranalyse. Dokumentklasse: Betriebsnachweis; bestehende Navigation
ueber die Manpage, DE/EN inline. Modul: homeRuntime/Wartungspaket; diese Notiz:
sourceOnly. Home-Sync und gepruefter Image-Pin folgen der Lieferung; keine
Quellhash-Ausnahme. Plattformnachweise werden im PR getrennt ausgewiesen.
Re-Evaluation bei Podman-Pfadformat- oder Mountvertrag-Aenderungen.

Canonical sources are the transport module and tests, owned by the Script
Maintainer. This bilingual source-only record supports the operator path from
the manual to sandbox preflight diagnosis. Runtime delivery requires Home sync
and a reviewed image pin, never a hash exception. Reevaluate when Podman's path
format or the mount contract changes; distinguish platform evidence in the PR.
