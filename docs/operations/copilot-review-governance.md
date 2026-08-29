# Betrieb: Copilot-Review-Governance

## Sicherer Ablauf / Safe operation

Beginne mit der [Manpage](../man/manage-copilot-review-governance.1.md) und dem
[Quickstart](../../specs/031-github-copilot-review-governance/quickstart.md).
Validiere Desired State und frische Inventur, führe Preview aus und prüfe
Blocker sowie Entscheidungshash. Apply benötigt später ein neues, enges Gate;
die lokale Implementierungsphase erlaubt nur Fake-Provider und null Writes.

## Rollback

Stoppe bei Drift. Erfasse den aktuellen After-Hash, prüfe Quellklasse und exakte
Identität und fordere ein eigenes Rollback-Gate an. Create wird deaktiviert,
nicht gelöscht. Wiederhole keinen unklaren Write.

## Incident

Bei unbekanntem Providerstatus, Identitäts-, Hash-, Schema-, Redaction- oder
Evidencefehler: keine weitere Mutation, lokale Logs schützen, nur exakte GET-
Reconciliation ausführen und Security/Provider Surface Owner informieren.
Geheimnisse, Cookies, HTML und private Pfade dürfen nicht publiziert werden.

## Usage

AI Credits, Actions-Minuten und automatische, manuelle oder unbekannte Trigger
bleiben getrennte Werte mit Quelle, Zeitraum, Einheit und Freshness. Fehlende
Daten sind `Unknown`, nie null oder ein Festpreis. / Keep credits, minutes, and
trigger classes separate; missing data stays unknown.
