# Präsentationen / Presentations

**DE:** Dieses Verzeichnis enthält Markdown-Präsentationen zu den Lernreihen. Die Markdown-Dateien sind die gepflegte Quelle und können später mit Pandoc in PowerPoint-Dateien umgewandelt werden.

**EN:** This directory contains Markdown presentations for the learning series. The Markdown files are the maintained source and can later be converted to PowerPoint files with Pandoc.

## Dateien / Files

| Datei / File | Zweck / Purpose |
|---|---|
| `Praesentation-Spec-Kit-SDD-Auftakt.md` | Neutrale DE-first-Auftaktinformation zu Spec-Driven Development mit Spec Kit ohne Organisationsbezüge. |
| `Praesentation-Spec-Kit-SDD-Auftakt.en.md` | English companion version of the neutral Spec Kit SDD kickoff. |
| `Praesentation-Secure-CaseTracker-Lernreihe.md` | DE-first-Einführung in EuFPA, Secure CaseTracker, MSL, Sandbox, Spec Kit und manuelle Level-2-Läufe. |
| `Praesentation-Secure-CaseTracker-Lernreihe.en.md` | English companion version of the Secure CaseTracker introduction. |
| `Praesentation-Secure-CaseTracker-v2-Lernreihe.md` | DE-first-Einführung in Secure CaseTracker v2 für Architektur, Persistenz, Service-Verträge, Betrieb und MSL-Vergleich. |
| `Praesentation-Secure-CaseTracker-v2-Lernreihe.en.md` | English companion version of the Secure CaseTracker v2 introduction. |
| `Praesentation-Secure-InventoryHub-Lernreihe.md` | DE-first-Einführung in Secure InventoryHub für Inventar, Softwarestände, Rollen, Patch-/Wartungsstatus und SBOM-Bezug. |
| `Praesentation-Secure-InventoryHub-Lernreihe.en.md` | English companion version of the Secure InventoryHub introduction. |
| `Praesentation-Secure-CaseTracker-Application-Track-Lernreihe.md` | DE-first-Einführung in den AE Application Track ab dem 3. Lehrjahr. |
| `Praesentation-Secure-CaseTracker-Application-Track-Lernreihe.en.md` | English companion version of the Application Track introduction. |
| `Praesentation-Secure-CaseTracker-Operations-Track-Lernreihe.md` | DE-first-Einführung in den SI Operations Track ab dem 3. Lehrjahr. |
| `Praesentation-Secure-CaseTracker-Operations-Track-Lernreihe.en.md` | English companion version of the Operations Track introduction. |
| `Praesentation-Secure-CaseTracker-Data-Process-Track-Lernreihe.md` | DE-first-Einführung in den DPA Data & Process Track ab dem 3. Lehrjahr. |
| `Praesentation-Secure-CaseTracker-Data-Process-Track-Lernreihe.en.md` | English companion version of the Data & Process Track introduction. |
| `Praesentation-Secure-CaseTracker-Digital-Networking-Track-Lernreihe.md` | DE-first-Einführung in den DV Digital Networking Track ab dem 3. Lehrjahr. |
| `Praesentation-Secure-CaseTracker-Digital-Networking-Track-Lernreihe.en.md` | English companion version of the Digital Networking Track introduction. |
| `Praesentation-Secure-ServiceHarvester-Lernreihe.md` | DE-first-Einführung in die Secure-ServiceHarvester-Basis (1. Lehrjahr): plattformübergreifender Sammel-/Worker-Dienst, MSL, Sandbox, Spec Kit und agentische KI. |
| `Praesentation-Secure-ServiceHarvester-Lernreihe.en.md` | English companion version of the Secure ServiceHarvester base introduction. |
| `Praesentation-Secure-ServiceHarvester-v2-Lernreihe.md` | DE-first-Einführung in Secure ServiceHarvester v2 (2. Lehrjahr): Architektur, Dienst-Hosting, Backend-Abstraktion, Harvester, API und Betrieb. |
| `Praesentation-Secure-ServiceHarvester-v2-Lernreihe.en.md` | English companion version of the Secure ServiceHarvester v2 introduction. |
| `Praesentation-Secure-ServiceHarvester-Application-Track-Lernreihe.md` | DE-first-Einführung in den AE Application Track des ServiceHarvester ab dem 3. Lehrjahr. |
| `Praesentation-Secure-ServiceHarvester-Application-Track-Lernreihe.en.md` | English companion version of the ServiceHarvester Application Track introduction. |
| `Praesentation-Secure-ServiceHarvester-Operations-Track-Lernreihe.md` | DE-first-Einführung in den SI Operations Track des ServiceHarvester ab dem 3. Lehrjahr. |
| `Praesentation-Secure-ServiceHarvester-Operations-Track-Lernreihe.en.md` | English companion version of the ServiceHarvester Operations Track introduction. |
| `Praesentation-Secure-ServiceHarvester-Data-Process-Track-Lernreihe.md` | DE-first-Einführung in den DPA Data & Process Track des ServiceHarvester ab dem 3. Lehrjahr. |
| `Praesentation-Secure-ServiceHarvester-Data-Process-Track-Lernreihe.en.md` | English companion version of the ServiceHarvester Data & Process Track introduction. |
| `Praesentation-Secure-ServiceHarvester-Digital-Networking-Track-Lernreihe.md` | DE-first-Einführung in den DV Digital Networking Track des ServiceHarvester ab dem 3. Lehrjahr. |
| `Praesentation-Secure-ServiceHarvester-Digital-Networking-Track-Lernreihe.en.md` | English companion version of the ServiceHarvester Digital Networking Track introduction. |

## Sprachtrennung / Language Split

**DE:** Die Folien nutzen bewusst getrennte Sprachdateien: `Praesentation-*.md` enthaelt die deutsche
Fassung, `Praesentation-*.en.md` die englische. Folientitel sind deshalb einsprachig. Dies ist eine
dokumentierte Ausnahme von der `DE / EN`-Ueberschriftenregel und keine Barrierefreiheitsverletzung; jede
Sprache bleibt in sich vollstaendig und mit Screenreader/Braille nutzbar.

**EN:** The slides deliberately use separate language files: `Praesentation-*.md` holds the German version,
`Praesentation-*.en.md` the English one. Slide titles are therefore single-language. This is a documented
exception to the `DE / EN` heading rule and not an accessibility violation; each language stays complete on
its own and usable with screen reader and Braille display.

## Pandoc / Pandoc

```bash
pandoc docs/learning-units/presentations/Praesentation-Spec-Kit-SDD-Auftakt.md \
  -o Spec-Kit-SDD-Auftakt.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Lernreihe.md \
  -o Secure-CaseTracker-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Application-Track-Lernreihe.md \
  -o Secure-CaseTracker-Application-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Operations-Track-Lernreihe.md \
  -o Secure-CaseTracker-Operations-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Data-Process-Track-Lernreihe.md \
  -o Secure-CaseTracker-Data-Process-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Digital-Networking-Track-Lernreihe.md \
  -o Secure-CaseTracker-Digital-Networking-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-ServiceHarvester-Lernreihe.md \
  -o Secure-ServiceHarvester-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-ServiceHarvester-v2-Lernreihe.md \
  -o Secure-ServiceHarvester-v2-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-ServiceHarvester-Application-Track-Lernreihe.md \
  -o Secure-ServiceHarvester-Application-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-ServiceHarvester-Operations-Track-Lernreihe.md \
  -o Secure-ServiceHarvester-Operations-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-ServiceHarvester-Data-Process-Track-Lernreihe.md \
  -o Secure-ServiceHarvester-Data-Process-Track-Lernreihe.pptx
```

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-ServiceHarvester-Digital-Networking-Track-Lernreihe.md \
  -o Secure-ServiceHarvester-Digital-Networking-Track-Lernreihe.pptx
```

**DE:** Erzeugte `.pptx`-Dateien sind Ausgabeartefakte und werden nicht automatisch versioniert.

**EN:** Generated `.pptx` files are output artifacts and are not automatically versioned.
