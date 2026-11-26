# Freigabe des Sandbox-Wechsels / Sandbox replacement approval

## Deutsch

Der Workspace-Owner hat am 26.11.2026 nach Vorlage der Image-ID und des
Paketfingerabdrucks den lokalen Wechsel für Secure-Trader freigegeben.
Die Freigabe gilt für das native ARM64-Profil `all` und behält die sechs
persistenten Volumes bei. Die bestehende Vertragsfrist bleibt 31.12.2026 UTC.

- Sandbox-Quellcommit `abe3f1006952dfdd7ddd165f373726f505d7a02c`
- Image-ID `sha256:d471f5e7287d10b2f12a3a77bf87a7951073d2368509bfc68da3404004acec3f`
- Home-Baseline-Commit `a56d19cea928edb8048589428828727b76c51d6f`
- Paketfingerabdruck `37dee3bcbdb81874ba890110e7a7c4bcab0564e3d0a5f464ea5a62ec2f0ba3fd`

Der Preflight liest für Secure-Trader die Paketdateien aus dem gebundenen
Git-Commit und vergleicht sie mit der schreibgeschützten Image-Kopie. Die
Offline-Toolchain- und Dokumentationsproben bestanden. Die Freigabe umfasst
diesen lokalen Wechsel und die zugehörige Ressourcenbereinigung.

## English

On 26 November 2026, the workspace owner approved the local Secure-Trader
replacement after reviewing the exact image ID and package fingerprint above.
The approval covers the native ARM64 `all` profile and retains all six
persistent volumes. The existing contract expiry is 31 December 2026 UTC.
The Secure-Trader preflight reads package files from the bound Git commit and
compares them with the read-only image copy. Offline toolchain and
documentation smoke tests passed. Approval covers the local replacement and
associated resource cleanup.
