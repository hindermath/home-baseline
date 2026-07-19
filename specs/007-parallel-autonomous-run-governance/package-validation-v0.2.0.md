# Paketvalidierung v0.2.0

## Deutsch

### Freigabeidentitaet

- Preset: `parallel-autonomous-run-governance`
- Release: `v0.2.0`
- Release-URL:
  `https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.0`
- Tag-, Release- und `main`-Commit:
  `e39aaa5fc36bd13b20860c98f58eab5210c8f87a`
- GitHub-Quellarchiv:
  `https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/archive/refs/tags/v0.2.0.zip`
- ZIP-Groesse: `76281` Byte
- ZIP-SHA-256:
  `77859364fe33f35633373b86bd95fcab4ed3263d3a97b8e9d948803b146abcef`
- Validierungsplattform: macOS
- Spec Kit CLI: `specify 0.12.11`

### Isolierter Test

Die Pruefung lief in einem neu initialisierten, remote-freien Git-Repository.
Der zentrale Installer installierte die acht freigegebenen Presets mit den
Prioritaeten `10` bis `80` aus ihren exakten Tags.

| Pruefung | Ergebnis |
|---|---|
| ZIP-Integritaet mit `unzip -t` | Bestanden |
| Entpacktes ZIP gegen den oeffentlichen `v0.2.0`-Stand | Keine Abweichung |
| `specify preset list` | Acht aktive Presets |
| `specify preset info parallel-autonomous-run-governance` | Version `0.2.0`, Prioritaet `80` |
| `specify preset resolve parallel-autonomous-agent-guidance-addendum-template` | Aufloesung aus `parallel-autonomous-run-governance v0.2.0` |
| Zweiter Installer-Lauf | Unveraendert |
| Remove und Reinstall aus dem exakten Tag-ZIP | Bestanden |

Der Gesamt-Hash aller installierten Preset-Dateien war vor und nach dem
idempotenten zweiten Installer-Lauf identisch:

`5ec92047e8c017c9ee45fddf068b40d555fe93c5a643f1460b46b52ac61521d8`

Der Hash nur des Parallel-Autonomous-Presets war vor dem Entfernen und nach der
Neuinstallation ebenfalls identisch:

`949e66d0dca81d14d7a3d3c39e187dd508ea61312fa5b70cd5e2635bf66715f5`

## English

### Release identity

- Preset: `parallel-autonomous-run-governance`
- Release: `v0.2.0`
- Release URL:
  `https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.0`
- Tag, release, and `main` commit:
  `e39aaa5fc36bd13b20860c98f58eab5210c8f87a`
- GitHub source archive:
  `https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/archive/refs/tags/v0.2.0.zip`
- ZIP size: `76281` bytes
- ZIP SHA-256:
  `77859364fe33f35633373b86bd95fcab4ed3263d3a97b8e9d948803b146abcef`
- Validation platform: macOS
- Spec Kit CLI: `specify 0.12.11`

### Isolated test

Validation ran in a newly initialized Git repository without a remote. The
central installer installed all eight released presets from their exact tags
with priorities `10` through `80`.

| Check | Result |
|---|---|
| ZIP integrity with `unzip -t` | Passed |
| Extracted ZIP against the public `v0.2.0` state | No difference |
| `specify preset list` | Eight active presets |
| `specify preset info parallel-autonomous-run-governance` | Version `0.2.0`, priority `80` |
| `specify preset resolve parallel-autonomous-agent-guidance-addendum-template` | Resolved from `parallel-autonomous-run-governance v0.2.0` |
| Second installer run | Unchanged |
| Remove and reinstall from the exact tagged ZIP | Passed |

The aggregate hash of all installed preset files remained identical before and
after the idempotent second installer run:

`5ec92047e8c017c9ee45fddf068b40d555fe93c5a643f1460b46b52ac61521d8`

The hash of the Parallel Autonomous preset alone was also identical before
removal and after reinstallation:

`949e66d0dca81d14d7a3d3c39e187dd508ea61312fa5b70cd5e2635bf66715f5`
