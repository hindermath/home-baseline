# Sicherheits-Querschnittskonzepte / Security Cross-Cutting Concepts

**Stand / State**: 2026-07-29

## Leitprinzipien / Principles

1. **Fail-safe defaults:** Dry-run ist vorausgewählt; Update-Bestätigung ist
   standardmäßig Nein.
2. **Least privilege:** UI-Auswahl erteilt nur Autorität für genau einen
   lokalen Engine-Prozess.
3. **Complete mediation:** Routing, Kombinationen, Eventzeilen,
   Cachemetadaten und Abschlussquellen werden bei jeder Nutzung geprüft.
4. **Separation of concerns:** C# präsentiert, Bash/PowerShell warten,
   Python validiert gemeinsame Datenverträge.
5. **Defense in depth:** Typed Arguments, striktes JSON, Markup-Escaping,
   SHA-256, atomare Veröffentlichung und Exact-Head-CI wirken gemeinsam.

## Sicherheitsrelevante Bausteine / Security-Relevant Building Blocks

| Baustein | Eingabe | Sicherheitsausgabe |
|---|---|---|
| Invocation Router | TTY-Fakten und UI-Schalter | Enhanced, Plain oder Headless |
| Selection Validator | typisierte Modusauswahl | gültige Kombination oder Exit 2/130 |
| Command Builder | Auswahl und Plattform | Argumentliste plus reine Textdarstellung |
| Event Reader | vollständige JSONL-Zeilen | validierter Live-Status oder dauerhafte Degradation |
| Result Reconciler | Prozess, Bericht, Abschlussereignis | Status oder `RESULT_MISMATCH` |
| UI Cache | Quellen, Lockfiles, Plattform | vollständiger atomarer Build oder Plain-Fallback |

## Betriebsgrenzen / Operational Boundaries

Die bestehenden Freshness-, Mutation-, Cleanup-, Admin- und
Zielrepository-Grenzen aus Features 015 bis 017 bleiben unverändert. Die TUI
besitzt keinen Bypass. NIS2, CRA, EU AI Act, DORA, BSI C3A und BSI C5 sind für
den lokalen internen Helfer nicht ausgelöst. Neu bewerten bei Marktfreigabe,
reguliertem Dienst, Cloudbetrieb oder KI-Laufzeit.

*Existing safety barriers remain unchanged and the UI has no bypass. Cloud,
regulated-service, market-release, and AI-runtime controls are re-evaluated
only when such a boundary enters scope.*

<!-- EN: docs/security/arc42-security.md
[DE-Zusammenfassung: Sichere Querschnittsprinzipien und Bausteine der Wartungs-TUI.]
-->
