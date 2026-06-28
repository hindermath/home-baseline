# Präsentationen / Presentations

**DE:** Dieses Verzeichnis enthält Markdown-Präsentationen zu den Lernreihen. Die Markdown-Dateien sind die gepflegte Quelle und können später mit Pandoc in PowerPoint-Dateien umgewandelt werden.

**EN:** This directory contains Markdown presentations for the learning series. The Markdown files are the maintained source and can later be converted to PowerPoint files with Pandoc.

## Dateien / Files

| Datei / File | Zweck / Purpose |
|---|---|
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

## Pandoc

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

**DE:** Erzeugte `.pptx`-Dateien sind Ausgabeartefakte und werden nicht automatisch versioniert.

**EN:** Generated `.pptx` files are output artifacts and are not automatically versioned.
