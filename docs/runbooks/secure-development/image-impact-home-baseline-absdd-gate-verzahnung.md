# Runbook: Image-Impact-Gate

Kontext: home-baseline-absdd-gate-verzahnung
Modi: training, mixed, development

1. Arbeite ausschließlich in der freigegebenen absdd-image-sandbox.
2. Binde Source-Commit, Build-Konfiguration und resultierende OCI-Digest.
3. Prüfe Build/Compose, Toolchain, SBOM, Secrets, Mounts, Netzwerk und CI
   einzeln mit positiver und negativer Evidence.
4. Bewahre projektspezifische Evidence; kopiere keine generische Baseline blind.
5. Stoppe bei fehlender ABSDD-Authority, Drift oder produktionsnaher Wirkung.
6. Trenne technische Image-Validierung von Projekt- und Flottenfreigabe.

## English

Validate build/compose, toolchain, OCI digest, SBOM, secrets, mounts, network,
and CI in the authorized sandbox. Never treat this as project or fleet release.
