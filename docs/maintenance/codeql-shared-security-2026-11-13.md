# Gemeinsame CodeQL-Befunde / Shared CodeQL findings

## Deutsch

Die Sicherheitsbasis umfasst eine vertrauliche Meldung, eine projektspezifische
SECURITY.md und CodeQL Default Setup. AI Scans und KI-Korrekturfunktionen bleiben
aus. CodeQL-Alerts sind Hinweise und keine automatische Bestätigung einer
Schwachstelle. Ein erfolgreicher Lauf belegt nur die analysierten Sprachen.

Der Homogenitäts-Workflow setzt `contents: read` ausdrücklich. Seine lokalen
Prüfungen benötigen keine GitHub-Schreibrechte und dürfen diese nicht aus einer
weiter gefassten Repository-Voreinstellung erben. Der Regressionstest weist
auch joblokale Überschreibungen durch `write-all` und Inline-Schreibrechte ab.
Trigger, native Plattformmatrix, Prüfregeln und vollständige Git-Historie
bleiben erhalten. Red/Green-Regressionsnachweis und unabhängige statische
Grenzprüfung sind vom tatsächlichen Hosted-CI-Ergebnis getrennt.

Gemeinsame Alerts werden nach Regel, Quellpfad und tatsächlichem Versionsstand
zugeordnet. Jeder ursprüngliche Alert behält ID, Revision und Beleglink.
Vorhandene Pfadkontrollen und unterstützte Aufrufer werden einzeln geprüft;
Testcode oder lokale CLI-Eingaben sind kein pauschaler Ausschlussgrund.
Ungeklärte Vertrauensgrenzen bleiben `needs_review`. Es werden keine Alerts
automatisch verworfen und keine Befundklassen durch Pfadfilter ausgeblendet.

Verteilung erfolgt nur über bestehende Manifest- und Preset-Verträge, nach
Check-only und Vorschau. Projektspezifische Ausnahmen bleiben erhalten.
Vorhandene veröffentlichte Versionen werden beibehalten, soweit kein neuer
Paketcode korrigiert werden muss; neue Korrekturen benötigen neue Versionen.
Alte Tags und historische Nachweise werden nicht verändert. Verbraucher und
kanonische Quelle erhalten getrennte PRs und exakte technische Head-Prüfungen.

## English

The security baseline combines confidential reporting, a project-specific
SECURITY.md, and CodeQL Default Setup. AI scans and AI fix features remain off.
CodeQL alerts are indications, not automatic confirmation of vulnerabilities.
A successful run establishes only the languages that were analysed.

The homogeneity workflow explicitly sets `contents: read`. Its local checks
need no GitHub write permissions and must not inherit them from broader
repository defaults. The regression also rejects job-level `write-all` and
inline write overrides. Triggers, the native platform matrix, assertions,
and full Git history remain intact. Red/green regression evidence and an
independent static boundary review are separate from actual hosted CI results.

Shared alerts are mapped by rule, source path, and actual version. Every
original alert retains its ID, revision, and evidence URL. Existing path
controls and supported callers are assessed individually; test code and local
CLI input are not blanket exclusions. Unresolved trust boundaries remain
`needs_review`. No alerts are automatically dismissed and no finding classes
are hidden through path filters.

Distribution uses existing manifest and preset contracts after check-only and
preview. Project-specific exceptions are preserved. Existing published package
versions remain where no new package-code correction is needed; new fixes
require new versions. Old tags and historical evidence are unchanged.
Consumers and canonical sources receive separate PRs and exact-head checks.

Documentation Impact: UpdateRequired. Owner: Thorsten Hindermann.
Audience: maintainers, security reviewers, and workspace users. Reader path:
Security policy -> this maintenance explanation -> source PR and CI evidence.
Canonical sources: the workflow, its regression, propagation manifests and
versioned preset matrices. Document class: ActiveSemantic. DE first / equivalent
EN, CEFR B2, applicable WCAG 2.2 AA. This workflow/test change is sourceOnly;
Home sync is required only for manifest-bound runtime payload changes.
Re-evaluate on permission overrides, changed callers, versions or rollout drift.
No new practical screen-reader or Braille acceptance is claimed.
