# Secure-Development-Evidence-Vertrag / Evidence Contract

Ein Kontext liegt unter docs/security/secure-development/<datum>-<context-id>/
und enthält baseline.json, mindestens eine Datei unter deltas/, closure.json,
image-impact.json und evidence-matrix.md.

Jede Gate-Datei verwendet genau eine Anwendbarkeit aus Applicable, N/A, Open,
genau eine Umsetzung aus Fulfilled, Partly Fulfilled, Not Fulfilled,
Not Assessed und genau ein Ergebnis aus Ready, ReadyWithAcceptedRisks,
NeedsRemediation, Blocked.

Die vier Entscheidungen technicalValidation, pilotAuthorization,
projectAcceptance und generalRelease bleiben getrennt. Nur benannte
menschliche Authority darf die letzten drei freigeben. HOSK/GWDG darf nur als
ExternalComparison geführt werden.

## English

Each context contains the four gate artifacts and a text evidence matrix.
Applicability and implementation are separate axes. Technical success never
implies pilot, project, product, sandbox, or fleet authorization.
