# npm-Agent-Proben: Ausfuehrungsgrenze / npm agent probes: execution boundary

## Deutsch

Documentation Impact: `UpdateRequired`. Owner: Thorsten Hindermann. Zielgruppe:
Workspace-Betreibende und Sicherheitspruefende. Leserpfad: Registry, Wartungsskript,
dieser Nachweis. Die kanonische Quelle sind die Bash- und PowerShell-Skripte sowie
die versionierte npm-Agent-Registry. Skripte sind `homeRuntime`; dieser Nachweis
ist `sourceOnly`. Navigation und Produkt-API aendern sich nicht. Erneut pruefen,
wenn die Registry, der Probevertrag oder ein Aufrufer geaendert wird.

Die npm-Agent-Registry ist Eingabe und kann nicht als Ausfuehrungsberechtigung
gelten. Zuvor konnten ihre Felder `command` und `args` auch bei `--compare-only`
und `--dry-run` einen beliebigen lokalen Prozess starten. Die Bash-Version
prueft den exakten, im Code festgelegten Befehl und dessen Argumente nun vor
jeder npm-Agent-Probe. Bei Ablehnung wird auch keine Installation als Ersatz
gestartet. Die PowerShell-Version benutzt vor der Probe denselben bestehenden
Codevertrag. Eine einteilige Argumentliste bleibt dabei eine Liste.

Der allgemeine begrenzte Prozessaufruf bleibt fuer andere ausdruecklich
vorgesehene Wartungspruefungen erhalten. Ein kontrollierter lokaler Negativfall
startete vor der Korrektur ein harmloses Markerskript und danach nicht mehr;
die drei kanonischen `--version`-Proben und der Fall eines fehlenden kanonischen
Werkzeugs bleiben zulaessig. Die gezielten Bash- und PowerShell-Tests decken
Vergleich, Vorschau und Normalbetrieb ab. Die Paketkennung und andere
Registry-Felder bilden eine getrennte Vertrauensgrenze und werden hier nicht
als geprueft ausgewiesen. Ein erfolgreicher Test behauptet keine allgemeine
Befundfreiheit. Praktische Screenreader- und Braille-Pruefungen wurden fuer
diesen textorientierten Nachweis nicht wiederholt.

## English

Documentation Impact: `UpdateRequired`. Owner: Thorsten Hindermann. Audience:
workspace maintainers and security reviewers. Reader path: registry, maintenance
script, this record. The canonical sources are the Bash and PowerShell scripts
and the versioned npm agent registry. Scripts are `homeRuntime`; this record is
`sourceOnly`. Navigation and the product API do not change. Review again when
the registry, probe contract or a caller changes.

The npm agent registry is input, not permission to run a process. Previously,
its `command` and `args` fields could start an arbitrary local process even in
`--compare-only` and `--dry-run`. Bash now checks the exact code-owned command
and arguments before every npm agent probe. A rejected probe cannot trigger an
installation fallback. PowerShell applies the same existing code contract
before probing. A one-item argument list remains a list.

The general bounded process runner remains available for other maintenance
checks that intentionally use it. A controlled local negative case ran a
harmless marker script before the change and did not run it afterwards. The
three canonical `--version` probes and a missing canonical tool remain valid.
Focused Bash and PowerShell tests cover comparison, preview and normal modes.
Package names and other registry fields form a separate trust boundary; this
record does not claim they were verified. Passing tests do not establish that
all findings are resolved. Practical screen-reader and Braille checks were not
repeated for this text-oriented record.
