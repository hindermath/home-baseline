# ADR-003: Copilot-Review-Governance-Grenzen

Status: Accepted locally, 2026-08-29.

## Kontext

Persönliche Accountautomation, Repository-Effort und Rulesets liegen auf
verschiedenen API-/Browserflächen. Credentials beweisen weder aktuelle
Identität noch Autorität. Ein unklarer Write-Ausgang kann durch Wiederholung
doppelte oder falsche Änderungen erzeugen.

## Entscheidung

Accountsteuerung bindet exakt `accountOwner=hindermath` und verbietet
Repository-, Ruleset- und PR-IDs. Repositoryoperationen binden ihre exakten IDs.
Browser- und API-Evidence bleiben getrennt. Jeder External Write ist eine
einmalige Transaktion mit frischem Read-before-Write, TOCTOU-Prüfung, atomarem
`NotInvoked`-Envelope, Nachinventur und eigenem Rollback-Gate. Unklarer Status
erlaubt nur Read-Reconciliation; Create-Rollback deaktiviert statt zu löschen.

## Alternativen

DOM-Scraping wurde wegen Instabilität und Credentialrisiko verworfen. Ein
globales Gate wurde wegen Rechteausweitung verworfen. Blindes Retry und Delete
wurden wegen Nicht-Idempotenz und Verlust der Auditidentität verworfen.

## Konsequenzen

Die Lösung ist konservativer und benötigt mehr Records, bietet dafür
reproduzierbare Identität, Least Privilege, Fail-Safe Defaults und Rollback.
Live-Providerkonvergenz kann erst mit späterer expliziter Autorität belegt werden.

## Compliance-Matrix

| Bezug | Umsetzung | Evidence |
|---|---|---|
| ISO 27001 A.5.15/A.8.2 | getrennte Operationsklassen und Mindestscope | Gate-Schema und Negativtests |
| ISO 27001 A.8.15/A.8.28 | redigierte atomare Logs, sichere Erzeugung | Security-Checkliste |
| NIST SSDF | Review, Tests, Provenance-Grenze | lokale Qualitätsmatrix |
| Zero Trust | explizite Verifikation je Transaktion | TOCTOU-/Rollbacktests |

Owner: Architecture Owner. Reviewer: Security Reviewer. Re-Evaluation bei
Account-, API-, Browser-, Gate-, Hash-, Retry- oder Rollbackänderung.
