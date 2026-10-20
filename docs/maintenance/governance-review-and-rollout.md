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

## Quartalsweiser GSDB-Review / Quarterly GSDB Review

DE: Zusätzlich zum festen jährlichen Preset-Review wird die GSDB am 10. Januar,
April, Juli und Oktober um 10:00 Europe/Berlin ausschließlich lesend geprüft.
Erste reguläre Wiedervorlage: 10.01.2027. Der Erstreview vom 19.10.2026 wird
separat dokumentiert. Anlassbezogene Prüfungen verschieben keinen festen Termin.
Der Quartalsreview umfasst die gesamte GSDB und alle im zugeordneten Profil
aktiven Presets; die Jahresprüfung vertieft die sieben oben benannten Presets.

EN: In addition to annual preset review, review the complete GSDB and every
active assigned preset on 10 January, April, July, and October at 10:00
Europe/Berlin. First regular review: 2027-01-10. Record the 2026-10-19 initial
review separately. Event-triggered reviews reset neither fixed schedule.
The annual review remains an in-depth review of the seven named presets.

DE: Owner ist Thorsten Hindermann. Die Chat-Automation
`quartalsreview-gsdb-level-0` prüft den veröffentlichten Default-Branch mit
exaktem Commit und offiziellen Quellen. Sie ändert keine Repository-Dateien,
Installationen oder Rollouts. Das Ergebnis NoChangeRequired, UpdateRequired
oder Blocked wird über die autorisierte Gmail-Verbindung an die drei vom
Owner benannten Adressen gesendet, auch wenn kein Änderungsbedarf besteht.
Empfänger und Versandautorisierung stehen in der privaten Automation, nicht
als Voraussetzung in den generischen GSDB-Dokumenten.

EN: Owner is Thorsten Hindermann. The chat automation reviews the published
default branch at an exact commit against official sources and makes no
repository, installation, or rollout changes. It mails NoChangeRequired,
UpdateRequired, or Blocked to the three owner-authorized addresses, including
no-change outcomes. Recipient details and mail authority remain in the private
automation rather than becoming generic GSDB prerequisites.

DE: Betreffmarker je Quartal: `[GSDB-REVIEW YYYY-Qn]`. Vor Versand Gesendet und
bisherige Chat-Nachweise prüfen; belegten Versand nicht wiederholen. Bei
unklarem Ergebnis nicht blind erneut senden. Fehlende Verbindung, unklaren
Versand oder Fehler im Chat melden. Keine Testmail. Rechner, App und
Netzwerkverbindungen müssen zum Termin verfügbar sein; dies ist kein
rechnerunabhängiger Zustelldienst. Gleichzeitige oder technisch unklare Läufe
werden zur manuellen Klärung gestoppt, nicht als genau-einmal zugestellt behauptet.

EN: Use one quarterly subject marker, check Sent and chat records before
sending, and never blindly retry ambiguous delivery. Report connection,
ambiguity, or sending failures in chat. Send no test message. Computer, app,
and connections must be available; this is not a server-independent delivery
service. Concurrent or ambiguous runs require manual resolution rather than
an exactly-once delivery claim.

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
