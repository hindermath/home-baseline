# Quickstart

## Deutsch

Eine **Dokumentationsauswirkung** beschreibt, ob und warum eine Änderung
Dokumentation ändern muss. Prüfe eine Evidence-Datei so:

```bash
bash scripts/validate-documentation-impact.sh \
  --evidence specs/012-documentation-impact-governance/documentation-impact-evidence.json
```

```powershell
pwsh -NoProfile -File scripts/validate-documentation-impact.ps1 `
  -Evidence specs/012-documentation-impact-governance/documentation-impact-evidence.json
```

## English

A **documentation impact** states whether and why a change needs documentation
work. The commands above validate the same contract on all supported systems.
