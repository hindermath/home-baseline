# Owner-Freigabe Secure-Trader-Wartung / Secure Trader maintenance owner approval

## Deutsch

Thorsten Hindermann hat als Repository-/Workspace-Owner am 08.11.2026
ausdruecklich die konkret vorgelegte Sandbox fuer den Fetch-/Fast-forward-
Wartungslauf der 21 Secure-Trader-Repositories freigegeben. Quelle ist seine
Nachricht "Freigabe erteilt" mit Verweis auf den
[Review von PR 128](https://github.com/hindermath/absdd-image-sandbox/pull/128#pullrequestreview-5819120082).
Der live gepruefte Review von `hindermath` wurde am 08.11.2026 um 18:39:47 UTC
auf Commit `f937fefa12c2bcf20d14d8614a8e2e389072b911` veroeffentlicht und
lautet: "Gesichtet und freigegeben!". GitHub klassifiziert ihn als `COMMENTED`,
nicht als technisches `APPROVED`. Die ausdrueckliche Owner-Entscheidung und
die formale GitHub-Approval-Regel sind verschiedene Nachweise.

Die Entscheidung bindet genau diesen geprueften Stand:

- Image: `sha256:5f530d888485537c160bddf9330f56844d99e98518d97e2d842bb27a76a1391d`.
- Paketfingerabdruck: `d18fc9005b6dda4023676c8fb22a032b6a4423cee187bc47924728aed322f5e0`.
- Eingebettete Quellrevision: `b232d5881f1d75092ddd9ecb345d210b4213732a`.
- Containername: `absdd-image-sandbox_ade_1`; Benutzer: `adedev`;
  unveraenderliche Referenz: `/opt/home-baseline`.
- Workspace-Zuordnung: `SecureCaseTrackerProjects` nach
  `/secure-case-tracker-projects`, `SecureOrderDeskProjects` nach
  `/secure-order-desk-projects`, `SecureServiceHarvesterProjects` nach
  `/secure-service-harvester-projects`.
- Gueltig bis einschliesslich 31.12.2026 UTC; ab 01.01.2027 gesperrt.

Nativer ARM64-Build, CycloneDX-SBOM und isolierter vollstaendiger Toolchain-/
Dokumentations-Smoke bestanden. Der Paketnachweis pruefte 170 fuer `adedev`
nicht beschreibbare Dateien und UID 1655. Der zugehoerige Sitzungsnachweis
liegt in PR 128 unter `docs/security/agent-session-log/2026-11-08-1726.md`.
Eine SBOM ist ein Inventar, keine Schwachstellen- oder Rechtsfreigabe.

Die Freigabe ersetzt keine technische Sperre: Non-root, Capability-Drop,
`no-new-privileges`, exakte Mounts, Image- und Paketbindung gelten weiterhin.
Lokale Secure-Trader-Git-Operationen bleiben ausschliesslich in der Sandbox;
authentifizierte Downloads verwenden isolierte Bare-Repositories auf dem Host.
Keine Credentials gelangen in den Container. Nur Fast-forward-Pulls sind
erlaubt; keine Ziel-Commits, Pushes, Loeschungen, Home-Synchronisation oder
Paketpropagation. Altcontainer und Volumes bleiben als Fallback erhalten;
Auditexport und Sicherungspruefung bleiben Gates vor einem Containerwechsel.

Dies ist keine CISO-/ISB-/KIB-Freigabe, keine Produktions-, Modell-, Provider-,
Secret- oder allgemeine Datenfreigabe. Offene organisatorische Rollenfreigaben
bleiben offen. Agenten dokumentieren die reale Owner-Entscheidung; sie erteilen
keine eigene Freigabe und erweitern ihren Umfang nicht.

## English

On 8 November 2026, Thorsten Hindermann explicitly approved the exact sandbox
presented to him for fetch and fast-forward maintenance of the 21 Secure Trader
repositories. His message "Freigabe erteilt" links to the PR 128 review above.
The live-verified review by `hindermath`, submitted at 18:39:47 UTC on the exact
commit above, states "Gesichtet und freigegeben!". GitHub records it as
`COMMENTED`, not `APPROVED`. Explicit owner authority and formal GitHub approval
are distinct evidence.

Approval binds the exact image, package fingerprint, embedded source revision,
container name, non-root user, immutable reference and three workspace mappings
listed above. It remains valid through 31 December 2026 UTC and expires on
1 January 2027. Native ARM64 build, CycloneDX inventory and isolated full smoke
passed. The package proof covered 170 non-writable members and UID 1655.
The inventory is not a vulnerability assessment or legal approval.

All technical gates remain mandatory: non-root, capability drop,
no-new-privileges, exact mounts and image/package binding. Local Secure Trader
Git operations remain sandbox-only; authenticated downloads use isolated host
bare repositories without forwarding credentials. Only fast-forward pulls are
authorized, not target commits, pushes, deletions, Home sync or propagation.
Preserve the old container and volumes; audit export and backup verification
remain prerequisites before replacement.

This is no CISO/ISB/KIB approval or production, model, provider, secret or general
data authorization. Organizational role approvals remain open. Agents record
the real owner decision; they neither grant approval nor expand its scope.
