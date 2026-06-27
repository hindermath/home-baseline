# Präsentationen / Presentations

**DE:** Dieses Verzeichnis enthält Markdown-Präsentationen zur Secure-CaseTracker-Lernreihe. Die Markdown-Dateien sind die gepflegte Quelle und können später mit Pandoc in PowerPoint-Dateien umgewandelt werden.

**EN:** This directory contains Markdown presentations for the Secure CaseTracker learning series. The Markdown files are the maintained source and can later be converted to PowerPoint files with Pandoc.

## Dateien / Files

| Datei / File | Zweck / Purpose |
|---|---|
| `Praesentation-Secure-CaseTracker-Lernreihe.md` | DE-first-Einführung in EuFPA, Secure CaseTracker, MSL, Sandbox, Spec Kit und manuelle Level-2-Läufe. |
| `Praesentation-Secure-CaseTracker-Lernreihe.en.md` | English companion version of the Secure CaseTracker introduction. |

## Pandoc

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Lernreihe.md \
  -o Secure-CaseTracker-Lernreihe.pptx
```

**DE:** Erzeugte `.pptx`-Dateien sind Ausgabeartefakte und werden nicht automatisch versioniert.

**EN:** Generated `.pptx` files are output artifacts and are not automatically versioned.
