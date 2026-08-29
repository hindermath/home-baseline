# Architektur: GitHub-Copilot-Review-Governance

## Kontext und Schnittstellen

Das System trennt unveränderlichen Sollvertrag, frische API-Inventur, manuelle
Browser-Evidence, deterministische Planung, operationsspezifische Autorität,
Fake-/Provideradapter und Evidence-Publikation. Eingaben des Providers und des
Browsers sind nicht vertrauenswürdig. Der PowerShell-7/.NET-Kern ist die einzige
Entscheidungsinstanz; Bash ist ein Ein-Prozess-Adapter, Python nur Testhelfer.

## Building Blocks und Runtime

`copilot-review-governance-desired-state.json` bindet exakt acht Ziele.
`CopilotReviewGovernance.psm1` validiert, plant, prüft Gates, TOCTOU, Nachzustand,
Rollback, Redaction und lineare Ausgabe. Die beiden Einstiegsskripte bilden
dieselbe Oberfläche ab. Runtime-Evidence bleibt `machineLocal`; Scopeverträge
und Dokumentation sind `sourceOnly`; das Skriptpaar erfüllt `homeRuntime`, wird
in dieser Phase aber nicht synchronisiert.

## Deployment- und Providergrenze

Read-only Inventur nutzt feste Argumentarrays und begrenzte GET-Retries.
Browserzustand bleibt ein separater manueller Record. Jede Mutation bindet
Klasse, exakte Identität, Before-/Desired-/Plan-Hash, Zeitfenster und Scope.
Unklarer Providerstatus führt nur zu GET-Reconciliation, nie zu blindem Retry.

## Qualität, Risiken und Trade-offs

Determinismus, Idempotenz, Least Privilege, atomare Evidence, barrierefreie
Textausgabe und kein Löschen sind Qualitätsziele. Die manuelle Browsergrenze
vermeidet fragiles DOM-Scraping, benötigt aber attestierte Nachweise. Der
geschlossene Vertrag verhindert stilles Fleet-Wachstum, verlangt jedoch ein
bewusstes Vertragsupdate. Native Linux-/Windows-, Live- und Delivery-Proofs
bleiben bis zu ihren gerouteten Phasen offen.

Technische Schuld: Die GitHub-Oberflächen können sich ändern; Owner ist der
Provider Surface Owner, Reviewer der Architecture Reviewer. Re-Evaluation bei
API-Version, UI-Pfad, Identität, Operationsklasse, Schema oder Plattformdrift.
Die iSAQB-Sicht umfasst Kontext, Bausteine, Laufzeit, Verteilung, Querschnitt,
Qualität, Risiken und Entscheidungen; Detailentscheidung ADR-003.
