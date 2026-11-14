# Owner-Freigabe Secure-Trader-Wartung / Secure Trader maintenance owner approval

## Deutsch

Thorsten Hindermann hat als Repository- und Workspace-Owner am 14.11.2026 auf die exakte Kandidatenfrage mit „Freigabe erteilt.“ geantwortet. Die Frage nannte die vollständige Image-ID `sha256:f7cade21c421c19ee7ecfcbb1f4a44870be87b3dc4d1a851417993b359f43df2` und den Paketfingerabdruck `40d302d05a0596a3593bad069a12d80755f77bc32ce30f049ed468059547e71f` sowie die Fast-forward-Wartung der 21 Secure-Trader-Repos bis 31.12.2026. Diese Entscheidung gilt nur für diesen Kandidaten und diesen Zweck. Die frühere Freigabe des laufenden Images `12359cbf…` wird nicht auf andere Images übertragen.

Der native ARM64-`all`-Build aus `absdd-image-sandbox` HEAD `09afaab7649c2d8233e8fe998d24f46b93149359` mit einzig geändertem `home-baseline.lock.json`-Pin `816efa2222f3d2054fb80ac945cea116e657b99a` bestand. CycloneDX-1.7-SBOM: 34.285 Komponenten, SHA-256 `a336a527b6539141aefb9df3a53a765fc38206b65bc4abdd3993eedd126249ce`. Ein isolierter Non-root-Test ohne Projekt-Volumes bestätigte UID 1655, die eingebettete Quellrevision und 172 nicht beschreibbare, hashgebundene Paketdateien. Vollständiger Toolchain-/Dokumentations-Smoke ohne Netzwerk und mit Capability-Drop und `no-new-privileges`: Exit 0. Der Nachweis steht in `absdd-image-sandbox/docs/security/agent-session-log/2026-11-14-1751-image-candidate.md` und der zugehörigen lokalen SBOM.

Freigegeben ist ausschließlich die Fast-forward-Wartung der drei Secure-Trader-Level-1-Workspaces und ihrer 18 Level-2-Repositories in der technisch geprüften Sandbox. Authentifizierte Downloads bleiben in isolierten Bare-Repositories auf dem Host; lokale Ziel-Git-Operationen laufen ausschließlich im Container. Keine Ziel-Commits, Pushes, Löschungen, Paketpropagation oder Home-Synchronisation aus diesem Auftrag. Vor dem Containerwechsel sind Metadaten-Auditexport, Sicherungsprüfung und die exakte Prüfung von Image, Benutzer, Capability-Drop, `no-new-privileges`, Mounts und Paketbindung verbindlich. Vorhandene Volumes bleiben erhalten.

Diese Owner-Entscheidung ist keine CISO-/ISB-/KIB-Freigabe und keine Produktions-, Modell-, Provider-, Secret- oder allgemeine Datenfreigabe. Organisatorische Rollenfreigaben bleiben offen. Das Ablaufdatum ist 31.12.2026 einschließlich UTC; ab 01.01.2027 ist der Wartungsvertrag gesperrt.

## English

On 14 November 2026, Thorsten Hindermann, as repository and workspace owner, replied “Freigabe erteilt.” to the exact candidate question identifying image `sha256:f7cade21c421c19ee7ecfcbb1f4a44870be87b3dc4d1a851417993b359f43df2`, package fingerprint `40d302d05a0596a3593bad069a12d80755f77bc32ce30f049ed468059547e71f`, and fast-forward maintenance of the 21 Secure Trader repositories through 31 December 2026. The decision applies only to that candidate and scope. Earlier approval of the running image does not transfer to other images.

The native ARM64 all-profile build from the stated sandbox source with only the Home Baseline lock pin changed passed. Its CycloneDX 1.7 inventory has 34,285 components with the SHA-256 above. An isolated non-root test without project volumes verified UID 1655, embedded source and 172 immutable package members. The complete offline toolchain/documentation smoke passed with dropped capabilities and no-new-privileges. The candidate session record and local SBOM hold the evidence.

Only bounded fast-forward maintenance of the three Secure Trader Level 1 workspaces and 18 Level 2 repositories is authorized. Authenticated downloads remain in isolated host bare repositories, while local target Git operations remain inside the sandbox. No target commits, pushes, deletions, package propagation or Home sync are authorized by this decision. Metadata audit export, backup verification and exact image/user/security/mount/package checks remain mandatory before replacement. Existing volumes are preserved.

This is no CISO/ISB/KIB, production, model, provider, secret or general data approval. Organizational role approvals remain open. The contract expires after 31 December 2026 UTC.
