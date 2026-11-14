# Owner-Freigabe Secure-Trader-Wartung / Secure Trader maintenance owner approval

## Deutsch

Thorsten Hindermann hat als Repository- und Workspace-Owner am 15.11.2026 auf die konkrete Kandidatenfrage mit „Ja, exakt dieses Image freigeben“ geantwortet. Freigegeben sind ausschließlich Image `sha256:53830cee3164a5112067a3681095e7d26f58ce930f452c7f9114592b0e1edb49` und Level-0-Paketfingerabdruck `37dee3bcbdb81874ba890110e7a7c4bcab0564e3d0a5f464ea5a62ec2f0ba3fd` für die Fast-forward-Wartung der 21 Secure-Trader-Repositories bis einschließlich 31.12.2026 UTC. Die Freigabe vom 14.11.2026 bleibt historische Evidenz für das frühere Image und wird nicht auf dieses übertragen.

Der native ARM64-`all`-Build aus `absdd-image-sandbox` Commit `79274dcb26a64bba1f982cbdcd517dbc87456f9d` mit ausschließlich geändertem `home-baseline.lock.json`-Pin auf `a56d19cea928edb8048589428828727b76c51d6f` bestand. Die CycloneDX-SBOM enthält 34.285 Komponenten (SHA-256 `ffbc1217387f5abfc3c060b4177414f71db8e517bf4215f3a89466b4d025301a`). Ein isolierter Non-root-Container ohne Netzwerk bestätigte 172 hashgebundene, nicht beschreibbare Level-0-Paketdateien. Der Offline-Toolchain- und Dokumentations-Smoke mit Capability-Drop und `no-new-privileges` bestand (SHA-256 des Logs `c70ac1b6b158796f5f287a776c27e13c4269ed4957334da6c85b7210d3103115`). Die lokale SBOM und der Sandbox-Sitzungsnachweis halten die technischen Belege fest.

Authentifizierte Downloads bleiben in isolierten Bare-Repositories auf dem Host; lokale Git-Operationen für geschützte Ziele laufen ausschließlich im Container. Keine Ziel-Commits, Pushes, Löschungen, Paketpropagation oder allgemeine Datenfreigabe sind von dieser Owner-Entscheidung gedeckt. Vor dem Containerwechsel sind Metadaten-Auditexport, Sicherungsprüfung und die exakte Prüfung von Image, Benutzer, Capability-Drop, `no-new-privileges`, Mounts und Paketbindung verbindlich. Bestehende Volumes bleiben erhalten.

Diese Entscheidung ist keine CISO-/ISB-/KIB-Freigabe und keine Produktions-, Modell-, Provider- oder Secret-Freigabe. Organisatorische Rollenfreigaben bleiben offen.

## English

On 15 November 2026, Thorsten Hindermann, as repository and workspace owner, answered “Ja, exakt dieses Image freigeben” to the exact candidate question. Only image `sha256:53830cee3164a5112067a3681095e7d26f58ce930f452c7f9114592b0e1edb49` and Level 0 package fingerprint `37dee3bcbdb81874ba890110e7a7c4bcab0564e3d0a5f464ea5a62ec2f0ba3fd` are approved for fast-forward maintenance of the 21 Secure Trader repositories through 31 December 2026 UTC. The 14 November approval remains historical evidence for the earlier image and does not transfer to this candidate.

The native ARM64 all-profile build from the stated sandbox commit with only the Home Baseline lock pin changed to `a56d19cea928edb8048589428828727b76c51d6f` passed. Its CycloneDX SBOM contains 34,285 components and has the SHA-256 stated above. An isolated non-root, offline container verified 172 immutable package members. The offline toolchain and documentation smoke passed with dropped capabilities and no-new-privileges. The local SBOM and sandbox session record retain technical evidence.

Authenticated downloads remain in isolated host bare repositories, while local Git operations for protected targets run only inside the container. This decision does not authorize target commits, pushes, deletion, package propagation or general data use. A verified metadata audit export, backup, exact image, user, security, mount and package checks are required before replacement. Existing volumes remain intact. Formal CISO/ISB/KIB and production, model, provider and secret approvals remain separate and open.
