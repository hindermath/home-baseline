# Threat Model: Home Baseline–ABSDD Gate Integration

## Schutzgüter

- Integrität von Richtlinie, Checklisten, Intakes, Receipts und Serienzustand;
- Herkunft von Image, Toolchain, OCI-Digest und SBOM;
- Secret-, Mount- und Netzwerkgrenzen;
- menschliche Freigabe- und Projekt-Authority;
- verständliche, textorientierte Evidence für Lernende und Reviewer.

## Vertrauensgrenzen und Bedrohungen

| Grenze | Bedrohung | Kontrolle |
|---|---|---|
| Referenz → lokale Policy | Externe Texte werden ungeprüft normativ | Exact-head-Bindung; lokale Authority nur aus Issue #263 |
| Home Baseline → ABSDD | Generische Dateien überschreiben Projektnachweise | Delta-Klassifikation; project evidence wins |
| CI/Test → Freigabe | Technischer Erfolg wird als Freigabe ausgegeben | Vier getrennte Decision-Felder |
| Build → Image | Tagdrift oder fehlende Provenienz | OCI-Digest, SBOM und Toolchain-Evidence |
| Host → Sandbox | Secrets, breite Mounts oder unkontrolliertes Netzwerk | CL_12, negative Tests, fail-closed image-impact |
| HOSK/GWDG → lokale Evidence | Fremder Kontext wird als lokaler Nachweis genutzt | ExternalComparison-only |

## Restrisiko

Der aktuelle Handoff baut oder ändert kein ABSDD-Image. Deshalb bleiben
Build/Compose, OCI-Digest, SBOM, Secrets, Mounts, Netzwerk und CI für Position
17 Not Assessed. Diese Offenheit ist ein Gate, keine Freigabe.

## English

The primary threats are authority confusion, evidence drift, project evidence
loss, and unsafe image provenance. The current delivery intentionally leaves
the later ABSDD image checks unassessed.
