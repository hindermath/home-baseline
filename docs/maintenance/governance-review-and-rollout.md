# Governance-Pruefung und gestufte Lieferung / Governance review and staged delivery

Owner: Thorsten Hindermann. Documentation Impact: UpdateRequired.
Canonical source: this policy and governance-review-register.json.
Audience: maintainers and agents. Reader path: README -> policy -> register -> delivery evidence.
Language: DE first / EN second. Distribution: sourceOnly; normative guidance is homeRuntime.

## Feste Jahrespruefung / Fixed annual review

DE: Security, Architecture, iSAQB, A11Y, Cross-Platform, Agent-Parity und
Secure Development Assurance werden jedes Jahr am 3. Oktober geprueft.
Naechste Wiedervorlage: 2027-10-03, 10:00 Europe/Berlin. Anlassbezogene
Pruefungen bei Rechts-, Standard-, Preset- oder relevanten Fehleraenderungen
bleiben Pflicht und verschieben den festen Jahrestermin nicht.
EN: Review these seven presets every 3 October. Next review: 2027-10-03 at
10:00 Europe/Berlin. Event-triggered reviews remain additional and never reset
the fixed annual schedule.

DE: Je Preset Version, einschlaegige offizielle Quellen/Fassung, Pruefdatum,
Reviewer, Befunde, Evidence und Folgeaufgaben dokumentieren. Ergebnisse sind
NoChangeRequired, UpdateRequired oder Blocked; PendingReview ist kein Ergebnis.
Die Erstpruefung im aktuellen Vorhaben ist erst abgeschlossen, wenn alle sieben
Records echte Evidence besitzen. Unzugängliche Quellen und Rechtsfragen bleiben
offen; keine Konformitaets-, Zertifizierungs- oder Produktfreigabe ableiten.
EN: Record version, relevant official source/version, date, reviewer, findings,
evidence and follow-up per preset. NoChangeRequired, UpdateRequired and Blocked
are outcomes; PendingReview is not. Initial review is incomplete until all seven
records have evidence. Inaccessible sources and legal uncertainty remain open.

DE: Die jaehrliche Automation arbeitet ausschliesslich lesend und berichtet.
Sie installiert nichts, aendert keine Dateien, Issues, Kommentare, Releases oder
Rollouts und erteilt keine Freigabe. Kein Befund bedeutet keine neue Version.
EN: The annual automation reads and reports only. It installs nothing and
changes no files, issues, comments, releases or rollouts. No finding requires no
artificial version bump. Owner decisions stay separate.

## Vier Lieferstufen / Four delivery stages

| Stage | Targets | Authority |
| --- | --- | --- |
| A | Home Baseline and affected Home Runtime surfaces | Current central delivery request |
| B | Exactly two named public Level-2 pilots | Named in the current request |
| C | Remaining affected public Level-2 consumers | Separate later request required |
| D | Remaining affected registered fleet | Another separate later request required |

DE: Vor Ausfuehrung konkrete Ziele, Hosting-Sichtbarkeit, Profile, Versionen,
Quellenrevisionen und ZIP-SHA-256 einfrieren. Pro Aenderung zwei passende
Piloten benennen; aktuell Show-CommandTui400 und TinyCalc. Ein altes Inventar
ist kein aktueller Vollstaendigkeitsnachweis. Nur betroffene Verbraucher
installieren; Preset-Quellen sind keine pauschalen Installationsziele.
EN: Freeze exact targets, hosting visibility, profiles, versions, source commits
and ZIP hashes before execution. Name two suitable pilots per change; currently
Show-CommandTui400 and TinyCalc. Historical inventory is not current completeness
evidence. Install only affected consumers, not every preset source repository.

DE: Kein Stufenuebergang ohne abgeschlossene vorherige Evidence. C und D bleiben
WaitingAuthorization, bis ein neuer Auftrag vorliegt. Technische Fehler stoppen
die betroffene Lieferung; Admin-Bypass ersetzt nie fehlgeschlagene oder nicht
gestartete Checks. Exakten Head pruefen, mergen und Default-Branch 0/0 belegen.
EN: Require prior-stage completion evidence. C and D stay WaitingAuthorization
until separately commissioned. Technical failure stops affected delivery; admin
bypass never replaces failed or unstarted checks. Validate and merge the exact
head, then prove default-branch synchronization at 0/0.

DE: Home-Sync verteilt nur betroffene manifestgebundene homeRuntime-Flächen,
nach Vorschau und Konfliktpruefung. Reine sourceOnly-Aenderungen brauchen keinen
Sync. Allgemeine Wartung, Werkzeuginstallation, Produktlaeufe, Community-Katalog
und menschliche Risiko-/Releasefreigaben sind keine impliziten Nebenwirkungen.
EN: Preview Home sync and distribute only affected manifest-bound runtime
surfaces. Source-only changes need no sync. Tool installation, product runs,
community submissions and human risk/release approvals remain separate.

## Nachweise / Evidence

- Source delivery: PR/head, checks, reviewer authority, merge, immutable tag and hashes.
- Central/pilot delivery: exact profile, resolves, shell checks, project regression,
  Documentation Impact, statistics, PR/merge and synchronization.
- Readiness before product implementation: fresh intake review, series/candidate,
  local model routing, required tools and current delivery authority.
- Report partial completion honestly: central/pilots done is not fleet done.

Reevaluation: each governance change and each fixed annual review.
