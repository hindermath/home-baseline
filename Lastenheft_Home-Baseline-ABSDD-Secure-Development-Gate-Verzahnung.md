<!-- intake-authoring:begin -->
# Lastenheft: Home Baseline–ABSDD Secure-Development-Gate-Verzahnung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-08-29
**Delivery Mode:** PublishPR
**GitHub-Issue:** #263
**Referenzen:** Issue #249 und Draft-PR #250 am Head
a8a0fb4a2597f2497972417aa940df3ad357056c

## 1. Zweck / Purpose

Dieses Lastenheft überträgt den fachlichen Kern aus Issue #249 und Draft-PR
#250 auf die lokalen Gegebenheiten von Home Baseline und
absdd-image-sandbox. Die Referenzen bleiben unverändert; lokale Authority
stammt ausschließlich aus Issue #263 und dem genehmigten Plan.

Ziel ist ein prüfbarer Secure-Development-Vertrag, der Richtlinie,
Checklisten, Presets, Intakes, Sandbox-Evidence und Freigaben verbindet, ohne
technische Validierung mit menschlichen Freigaben zu verwechseln.

*This intake maps the reference issue and Draft PR to Home Baseline and ABSDD.
It introduces a traceable four-gate evidence contract while keeping human
approval boundaries independent.*

## 2. Bindende Ausgangslage

- Home Baseline: origin/main
  3f17f8789cc1ff058079046c64af2a73154f6e10, Baseline 3.2.0.
- ABSDD: 7adaeac18ca259726468a2fe1d1fd028b895e09c,
  Secure-Development-Baseline 3.1.0 und Zwölfer-Preset-Profil.
- Lokale Grundlagen: Richtlinie Sichere Entwicklung,
  Leitlinie Sichere Entwicklungs-Sandbox, CL_12, Baseline-Manifest.
- Betroffene aktive Intakes: Positionen 7, 8 und 14 bis 17.
- HOSK/GWDG: nur ExternalComparison, niemals lokale Authority oder Evidence.

## 3. Gate- und Statusvertrag

Jeder Kontext liegt unter
docs/security/secure-development/<datum>-<context-id>/ und besitzt:

- baseline.json;
- mindestens ein Delta unter deltas/;
- closure.json;
- image-impact.json;
- evidence-matrix.md.

Die vier Gates heißen exakt baseline, delta, closure und image-impact.
Anwendbarkeit verwendet Applicable, N/A oder Open. Umsetzung verwendet
Fulfilled, Partly Fulfilled, Not Fulfilled oder Not Assessed. Zulässige
Ergebnisse sind Ready, ReadyWithAcceptedRisks, NeedsRemediation oder Blocked.

Ready ist bei Open, einem nicht vollständig erfüllten anwendbaren Pflichtpunkt,
fehlender Evidence oder abgelaufenem Review unzulässig. N/A benötigt
Begründung und Re-Evaluation-Trigger. Akzeptierte Risiken benötigen Owner,
Reviewer, Restrisiko und Wiedervorlage.

## 4. Freigabegrenzen

Vier Entscheidungen bleiben technisch und organisatorisch getrennt:

1. technische Validierung;
2. Freigabe eines begrenzten Piloten;
3. Projektabnahme;
4. allgemeine Sandbox-, Produkt- oder Flottenfreigabe.

Nur die jeweils benannte menschliche Authority darf die Punkte 2 bis 4
erteilen. Kein Agent, Test, CI-Lauf, Image-Digest oder SBOM ersetzt diese
Entscheidungen.

## 5. Befehle und Dreizehner-Profil

Das optionale Preset secure-development-assurance-governance v0.1.0 besitzt
Priorität 15 und stellt genau folgende zwei Befehle bereit:

- $speckit-secure-development-status [<evidence-dir>]
- $speckit-secure-development-review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>

Das Dreizehner-Assurance-Profil ergänzt das bestehende Zwölfer-Profil. Das
öffentliche Acht-Preset-Profil und die optionalen Profile 9 bis 12 bleiben
unverändert.

## 6. Abbildung der aktiven Reihe

- Position 7: technische absdd-image-sandbox-Baseline einschließlich
  Build/Compose, Toolchain, OCI-Digest, SBOM, Secrets, Mounts, Netzwerk und CI.
- Position 8: kontrollierte Übertragung des Vertrags auf Level-2-Projekte.
- Position 14: read-only Gap-Audit; keine Policy-, Preset- oder ABSDD-Änderung.
- Position 15: Dreizehner-Assurance-Profil und die exakt zwei Befehle.
- Position 16: Baseline 3.3.0, S-ADR und aktualisiertes Threat Model.
- Position 17: kontrollierte ABSDD-Adoption mit getrennten Freigaben.

Die bestehenden Intake-IDs, Reihenfolge, Kanten, Rootzahl, Zielzahl und
Lifecycle-Status bleiben erhalten. Alte Ziele und Receipts werden bytegenau
archiviert; alte Review-Evidence wird wegen Hashdrift ausdrücklich
invalidiert.

## 7. Dokumentation und Distribution

Dokumentationswirkung ist GeneratedUpdate. Die kanonische Statistikquelle wird
aktualisiert und der Profil-2-Block reproduzierbar gerendert. Source-only-
Änderungen lösen keinen Home-Sync aus. Training und mixed benötigen ein
Runbook; development benötigt ein Runbook oder eine begründete N/A-Entscheidung.

## 8. Validierung

Die Lieferung prüft:

- Intake-Receipts und Serie mit Bash und PowerShell;
- unveränderte Serieninvarianten und neue Hashbindungen;
- Dokumentation, Links, Secrets, DE/EN, Accessibility und Preset-Fixtures;
- Profile 8 bis 13 und Agentenflächen;
- für die spätere ABSDD-Phase Build/Compose, Toolchain, OCI-Digest, SBOM,
  Secrets, Mounts, Netzwerk und CI.

Die aktuelle Lieferung verändert ABSDD nicht, baut kein Image, erteilt keine
Freigabe, merged keinen PR und startet keinen nachgelagerten Spec-Kit-Lauf.

## 9. Akzeptanzkriterien

- AC-HAS-001: Alle vier Gates und Statuswerte sind maschinenlesbar validierbar.
- AC-HAS-002: Die zwei Befehle erscheinen je unterstützter Agentenfläche genau
  einmal.
- AC-HAS-003: Profile 8 bis 12 bleiben unverändert; Profil 13 ergänzt nur das
  Assurance-Preset auf Priorität 15.
- AC-HAS-004: Die sechs Intakes behalten ihre Intake-IDs und besitzen
  bytegenaue Vorgängerarchive, neue Receipts und Hashes.
- AC-HAS-005: Die aktive Serie behält 33 Ziele, 3 Roots, 37 Kanten, Reihenfolge
  und Lifecycle-Status.
- AC-HAS-006: Technische Validierung erzeugt keine implizite menschliche
  Freigabe.
- AC-HAS-007: HOSK/GWDG erscheint ausschließlich als ExternalComparison.
- AC-HAS-008: GeneratedUpdate und Statistik sind reproduzierbar; Home-Sync
  bleibt aus.

<!-- intake-authoring:prompts -->
## 10. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review Lastenheft_Home-Baseline-ABSDD-Secure-Development-Gate-Verzahnung.md against Issue #263, reference Issue #249, Draft PR #250 at head a8a0fb4a2597f2497972417aa940df3ad357056c, the local Secure Development baseline, all six superseded intakes, and ABSDD commit 7adaeac18ca259726468a2fe1d1fd028b895e09c. Verify the four gates, exact status vocabularies, thirteen-preset profile, separate approvals, ExternalComparison boundary, GeneratedUpdate, no Home sync, and unchanged series invariants. Do not change files or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use Lastenheft_Home-Baseline-ABSDD-Secure-Development-Gate-Verzahnung.md as the binding intake. Preserve AC-HAS-001 through AC-HAS-008, all source bindings, exact commands, four gates, two-axis statuses, outcomes, decision boundaries, Positions 7, 8, and 14 through 17, HOSK/GWDG ExternalComparison-only, GeneratedUpdate, NoHomeSync, accessibility, and fail-closed behavior. Do not modify ABSDD or start another feature.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute Lastenheft_Home-Baseline-ABSDD-Secure-Development-Gate-Verzahnung.md with deliveryAuthority=PublishPR only after a fresh Intake Review and separate current delivery authorization. Create at most a Draft PR; do not merge, sync Home, modify ABSDD, build or publish an image, grant a pilot/project/fleet approval, or start Positions 14 through 17.
```

<!-- intake-authoring:end -->
