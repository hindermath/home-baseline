# SDA-FT-003: Risiko-ID-Paritaet / Accepted-risk ID parity

## Problem und Korrektur / Problem and correction

In v0.1.1 akzeptiert Bash Risiko-Evidence ohne `acceptedRisks.id`, die
PowerShell ablehnt. Die gemeinsame Risiko-Pruefung wird deshalb in beiden
Shells auf einen kanonischen, skalaren und nicht leeren Text abgesichert.
PowerShell darf dabei kein einteiliges Array stillschweigend entpacken.
Der unabhaengige Review deckte zudem auf, dass Bash mehrere JSON-Wurzeln als
Datenstrom akzeptiert. Die gemeinsame Gate-Grenze verlangt deshalb genau ein
vollstaendiges JSON-Dokument.
Gueltige IDs erhalten keine neue Format-, Trim- oder Normalisierungsvorgabe.

*Correct the shared accepted-risk ID boundary used by status and all reviews.
Require canonical nonblank scalar text and prevent singleton-array coercion.
Require exactly one JSON root so a trailing partial document cannot mask an
invalid first root.
Preserve legitimate IDs without imposing new formatting rules.*

## Umfang und Authority / Scope and authority

- Owner hat v0.1.2 ausdruecklich genehmigt; v0.1.0/v0.1.1 bleiben unveraendert.
- Kanonischer Scaffold zuerst, identische Publikationskopie und Paketquellen.
- Installationsmatrix und installierte Kopie erst nach echtem v0.1.2-Archiv.
- MergeAndSync; Admin-Bypass nur fuer formale Regeln, niemals materielle Gates.
- Keine Produkt-, Schema-, globale Helper-, Baseline- oder Schutzregelaenderung.
- TinyCalc-PR #67 wird vor RL-SE und GSDB geliefert; kein Feature startet hier.

*The approved patch preserves earlier immutable releases and all substantive
gates. Installation follows a real published archive. Product code, schemas,
global helpers and policy boundaries remain outside scope. Complete PR #67
before the two serial field-test features.*

## Validierung und Dokumentation / Validation and documentation

Beobachtetes Rot vor der Korrektur, Gruen danach. Beide Shells pruefen Status
und alle vier Gate-Reviews; neun ungueltige ID-Repraesentationen werden ohne
Erfolgsausgabe und mit Exit 2 abgelehnt. Gueltige Unicode-Texte und rohe
Read-only-Snapshots bleiben erhalten. Ein zusaetzlicher Rot-/Gruen-Nachweis
deckt zwei verkettete JSON-Wurzeln in Status und Delta-Review ab. Bestehende
Vertragsanwendung, jq-Paritaet, Runbooks und menschliche Entscheidungen bleiben
unveraendert. Keine neue
Abhaengigkeit. `UpdateRequired`, source-only, kein Home-Sync; NIST SSDF,
CWE Top 25, Supply-Chain-Provenienz und textorientierte A11Y gelten.

*Observed red/green regressions cover invalid ID representations and multiple
JSON roots while preserving valid controls, raw-byte evidence and human
boundaries. No dependency is added.
Documentation is updated in source only. Apply SSDF, CWE, provenance and text
accessibility; native platform checks and independent review remain mandatory.*

## Release-Evidence / Release evidence

Der native Paketlauf `33976340466` besteht unter Linux, macOS und Windows am
Head `cf7e18fe7dc45dca93801a8c58d19c7dfc2f4fc1`. Paket-PR #3 ist als
`02423602592ad0183454e259df628ab940436ba6` gemergt. Das unveraenderliche
v0.1.2-Tag-ZIP hat SHA-256
`4eb30804bb3c329681e0b7d44187c8daeb3e9e4f250bb6003d5b746c0ad0b656`;
alle acht daraus erzeugten Agentenoberflaechen bestehen. Die Quellinstallation
entspricht exakt der 13er-Matrix. TinyCalc-Abnahme und Feldtests bleiben offen.

*Native Linux, macOS, and Windows passed at the exact reviewed package head.
The verified provider merge backs immutable v0.1.2; its tag archive has the
recorded SHA-256 and passes all eight installed surfaces. The source install
matches the exact 13-preset matrix. TinyCalc acceptance and field tests remain
pending.*

Pruefbefehle / Validation commands:

~~~powershell
pwsh -NoProfile -File specs/spec-kit-presets/secure-development-assurance-governance/tests/test-secure-development-assurance.ps1
pwsh -NoProfile -File specs/spec-kit-presets/secure-development-assurance-governance/tests/test-installed-surfaces.ps1
~~~

Laufstand und Grenzen: [kanonischer Feldtestnachweis](maintenance/secure-development-assurance-v011-field-test.md).
