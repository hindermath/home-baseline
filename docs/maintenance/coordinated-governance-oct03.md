# Koordinierter Governance-Zielstand / Coordinated governance target

Stand / Date: 2026-10-03. Owner: Thorsten Hindermann.
Documentation Impact: `UpdateRequired`.

## Umfang und Quellen / Scope and sources

DE: Fuenf stabile Preset-Releases und die Wartungsdateien aus Home Baseline
[#317](https://github.com/hindermath/home-baseline/pull/317) werden zentral
gebunden und gezielt fuer Show-CommandTui400 und TinyCalc integriert.
Andere Profile behalten IDs, Prioritaeten und unveraenderte Presets; der
Flottenstandard bleibt acht Presets. Produktimplementierung, allgemeine
Toolchain-Wartung und Community-Einreichung sind nicht Teil dieser Lieferung.

EN: Bind five stable releases and PR #317 maintenance files centrally, then
integrate the explicit Show-CommandTui400 and TinyCalc pilots. Preserve IDs,
priorities and other presets. The fleet default stays eight presets.
This delivery starts no product feature, blanket maintenance or catalog submission.

| Preset | Stable target | Source proof |
| --- | --- | --- |
| Security Governance | v0.7.0, priority 10 | [PR #5](https://github.com/hindermath/spec-kit-preset-security-governance/pull/5), regulatory contract and Copilot corrections |
| Architecture Governance | v0.6.1, priority 20 | [PR #7](https://github.com/hindermath/spec-kit-preset-architecture-governance/pull/7), preserves previous #4/#5 fixes |
| Intake Authoring Governance | v0.3.6, priority 64 | [PR #12](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/12), [parity #13](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/13) |
| Intake Review Governance | v0.2.4, priority 65 | [PR #9](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/9), [parity #10](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/10) |
| Intake Sequencing Governance | v0.2.7, priority 66 | [PR #11](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/11) |

Immutable tag, commit and tag-ZIP SHA-256 are in
[preset-source-lock.json](preset-source-lock.json); release notes distinguish
the separately hashed release assets. All archive files were compared with
the released source tree, not just the manifest.

## Konsistenz und Grenzen / Consistency and boundaries

DE: Die drei Intake-Konfigurationsvalidatoren sind bytegleich. Active mit
Active-Mitglied ohne Folge-Kandidat ist gueltig, Ready braucht einen Kandidaten,
Idle ist leer, und Indizes verschachtelter Git-Repositories bleiben getrennt.
Gewoehnliche Duplikate, ungueltige Pfade, Hashes und Abhaengigkeiten blockieren.
Authoring akzeptiert bekannte historische Generatoren einschliesslich 0.3.5;
historische Receipts und Serien werden nicht umgeschrieben.

EN: Shared Intake validators are byte-identical. Active/no-next-candidate,
Ready/exactly-one, empty Idle and nested-index ownership compose consistently.
Integrity and negative gates remain fail-closed; historical evidence is preserved.

DE: Architecture trennt C5 Typ 1, Typ 2 und Unknown und erfasst alle 30 C3A-
Gruppen mit C/AC/SI-Kennungen aus BSI v1.0. Security Governance v0.7.0
delegiert diese Architektur-Evidence ohne widerspruechliche Typ-Aussage.
Vorlagen und Wrapper ersetzen keine Providerpruefung, kein Testat und keine
Projektfreigabe. Ausbildungs-/Entwicklungsinfrastruktur kann begruendet N/A bleiben.

EN: Architecture separates C5 report semantics and maps 30 C3A groups.
Security v0.7.0 delegates architecture evidence without a conflicting report-type
claim. Structural checks are not provider audits, certificates or product approval.
Justified N/A remains available for education/development-only infrastructure.

Source CI: all final exact-head jobs passed on macOS/Linux/Windows:
[Architecture](https://github.com/hindermath/spec-kit-preset-architecture-governance/actions/runs/37116447562),
[Authoring](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/actions/runs/37116753252),
[Review](https://github.com/hindermath/spec-kit-preset-intake-review-governance/actions/runs/37116752424),
[Sequencing](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/actions/runs/37116381387).
Native proof is separate from local macOS tests. Published templates and
historical source context remain distinct.

## Wartungspaket / Maintenance package

Source merge: `3b3abecdcad7395b97948f4d42578b4a83502cbb` (#317).
Do not reimplement it. Propagate only declared maintenance files to the two
pilots, using preview and exact drift checks. Pandoc and Typst are required;
VS Code's `myriad-dreamin.tinymist` extension is required, standalone Tinymist
is optional. Real tool installation and native platform acceptance are
separate from file delivery. PDF smoke is not accessibility conformance.

## Vor dem Produktlauf / Before a product run

DE: Unmittelbar vor dem beauftragten Lauf erneut Git-Stand, fachlichen Scope,
Intake-Review-Frische, Serienstatus und bevorzugten Kandidaten, harnesslokales
Modell-Routing sowie aktuelle Delivery-Autoritaet pruefen. Neue zwingende
Governance-Regeln minimal mit vorhandenem Plan/Tasks/Checklist abgleichen;
keine historische Evidence neu schreiben. Benoetigte Werkzeuge vorab
installieren/pruefen. Bei unklarer oder veralteter Evidence nicht starten.

EN: Immediately before an authorized run, recheck Git state, scope, review
freshness, series/candidate, harness-local routing and current delivery authority.
Reconcile mandatory new rules minimally with accepted plan/tasks/checklists.
Do not rewrite history. Required tools must be ready; stale/unclear gates block.

Show-CommandTui400 does not need to wait for TinyCalc, the remaining fleet
or community acceptance once its own installation, delivery and start gates
are satisfied. Neither pilot installation constitutes an implementation-start
or product-acceptance decision.

## Nachweis und Restumfang / Evidence and remaining scope

Target installation evidence and delivery PRs are tracked in
[the coordinated rollout manifest](../work-items/2026-10-03-coordinated-governance-pilots.json).
Remaining work after pilots: repository-wise fleet preflight/delivery,
serial community updates, and final rollout closeout.
The earlier Authoring v0.3.5 manifest remains historical; its inventory is
a starting set, not proof that every Architecture consumer was enumerated.

Reader path: README DE/EN -> this report -> immutable source lock and pilot PRs.
Canonical sources: standalone preset repositories and #317; Home Baseline
owns integration only. Language partner is inline DE-first/EN-second.
Distribution: source plus selected runtime guidance/scripts; Home sync only
for manifest-declared runtime paths, with preview and check-only proof.
NIST SSDF/CWE-oriented negative tests and package provenance apply.
No ASVS product audit, AI-runtime inventory or C5 certification is claimed.
