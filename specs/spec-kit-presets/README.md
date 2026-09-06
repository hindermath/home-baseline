# Spec Kit Preset-Produktquellen / Product Sources

Die 13 oeffentlichen GitHub-Repositories sind die alleinigen Produktquellen.
Entwicklung erfolgt direkt in ihren eigenstaendigen Git-Klonen. Die doppelten
Home-Baseline-Scaffolds wurden am 2026-09-06 entfernt. Bestehende Installationen,
Prioritaeten, Aktivierungszustaende und Profilzuordnungen bleiben unveraendert.
Ueber jede weitere Verteilung des 13. Presets entscheidet Thorsten separat.

The 13 public GitHub repositories are the sole product sources. Develop in
their own Git clones. Duplicate Home Baseline scaffolds were retired on
2026-09-06. Existing installations, priorities, enabled states, and profile
assignments remain unchanged. Thorsten decides further distribution of preset 13.

## Verifizierte Quellen / Verified Sources

| Preset | Tag | Produktquelle / Product source |
|---|---|---|
| security-governance | v0.6.2 | [GitHub](https://github.com/hindermath/spec-kit-preset-security-governance/tree/v0.6.2) |
| secure-development-assurance-governance | v0.1.2 | [GitHub](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/tree/v0.1.2) |
| architecture-governance | v0.5.2 | [GitHub](https://github.com/hindermath/spec-kit-preset-architecture-governance/tree/v0.5.2) |
| isaqb-architecture-governance | v0.2.2 | [GitHub](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/tree/v0.2.2) |
| a11y-governance | v0.4.3 | [GitHub](https://github.com/hindermath/spec-kit-preset-a11y-governance/tree/v0.4.3) |
| cross-platform-governance | v0.2.2 | [GitHub](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/tree/v0.2.2) |
| agent-parity-governance | v0.4.2 | [GitHub](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/tree/v0.4.2) |
| model-routing-governance | v0.1.4 | [GitHub](https://github.com/hindermath/spec-kit-preset-model-routing-governance/tree/v0.1.4) |
| intake-authoring-governance | v0.3.1 | [GitHub](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/tree/v0.3.1) |
| intake-review-governance | v0.2.1 | [GitHub](https://github.com/hindermath/spec-kit-preset-intake-review-governance/tree/v0.2.1) |
| intake-sequencing-governance | v0.2.3 | [GitHub](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/tree/v0.2.3) |
| autonomous-run-governance | v0.4.1 | [GitHub](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/tree/v0.4.1) |
| parallel-autonomous-run-governance | v0.2.6 | [GitHub](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/tree/v0.2.6) |

Assurance v0.1.2 wurde als [#4455](https://github.com/github/spec-kit/issues/4455)
eingereicht. Die Feldtests sind mit `ReleaseAccepted` abgeschlossen; GitHub
kennzeichnet v0.1.2 weiterhin als Prerelease. Der konkrete Tag bleibt massgeblich,
auch wenn `Latest` v0.1.0 anzeigt. Einreichung bedeutet noch keine Katalogaufnahme.

Assurance v0.1.2 passed its field tests as `ReleaseAccepted` and was submitted
in #4455. It remains a GitHub prerelease; the explicit tag takes precedence over
the older `Latest` label. Submission does not establish catalog acceptance.

## Nachweise und Wartung / Evidence and Maintenance

- [Quellenbindung: Tags, Commits und ZIP-SHA-256 / Source lock](../../docs/maintenance/preset-source-lock.json)
- [Bereinigung und bekannte Abweichungen / Cleanup and known differences](../../docs/maintenance/preset-source-cleanup.md)
- [Vollstaendiger Dateivergleich / Full file comparison](../../docs/maintenance/preset-source-audit-2026-09-06.json)

Die bestehenden Matrizen unter `scripts/config/` bleiben die Installationsprofile.
Diese Quellenuebersicht ist kein Rollout-Auftrag. `.specify/presets/` bleibt
die installierte Projektkopie; generierte Agentenbefehle sind deren Ableitungen.
C5-bezogene Evidence ersetzt weder eine vollstaendige C5-Pruefung noch ein Testat.

Existing matrices under `scripts/config/` remain the installation profiles.
This source index does not authorise rollout. `.specify/presets/` remains the
installed project copy; generated agent commands are derived from it.
C5-related evidence is neither a complete C5 assessment nor an attestation.
