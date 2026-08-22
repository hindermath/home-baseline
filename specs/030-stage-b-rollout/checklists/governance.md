# Requirements-Governance Checklist: Fleet-Wide Stage-B Rollout / Anforderungs-Governance-Checkliste: Flottenweiter Stage-B-Rollout

**Purpose / Zweck**: Formales Pre-plan-Gate für Vollständigkeit, Klarheit, Konsistenz, Messbarkeit und Szenarioabdeckung der bindenden Stage-B-Anforderungen
**Created / Erstellt**: 2026-08-21
**Feature / Feature**: [spec.md](../spec.md)
**Audience and timing / Zielgruppe und Zeitpunkt**: Fleet Delivery Owner, Maintainer und Peer Reviewer vor der Planung
**Depth / Prüftiefe**: High rigor / Hohe Prüftiefe
**Scope boundary / Umfangsgrenze**: Prüfung der Anforderungsqualität; Implementierungs- und Ausführungstests sind ausdrücklich nicht Bestandteil dieser Checkliste

**Note / Hinweis**: Diese Checkliste wurde durch `/speckit-checklist` als „Unit Tests for Requirements Writing“ erzeugt und anschließend vollständig gegen die aktuelle Spezifikation ausgewertet.

## Requirement Completeness / Anforderungsvollständigkeit

- [x] CHK001 Sind Quelle, Vereinigungsregel, Ausschlüsse und Driftverhalten der dynamisch autoritativen Repository-ID-Menge vollständig dokumentiert? [Completeness, Spec §SBR-001–SBR-003, §AC-SBR-001–AC-SBR-002]
- [x] CHK002 Ist der terminale G3-Abschluss einschließlich aktuellem HEAD, PostMerge-Evidence und Run-State als zwingende Voraussetzung vor der ersten Stage-B-Mutation vollständig festgelegt? [Completeness, Spec §SBR-001, §Randfälle, §G-SBR-001]
- [x] CHK003 Sind Stage-B-Zustand und -Evidence vollständig von unveränderlicher Stage-A-Historie getrennt, einschließlich Versionierung und eigener Vertragsidentitäten? [Completeness, Spec §SBR-004–SBR-005, §Schlüsseldaten, §G-SBR-002]
- [x] CHK004 Sind ExternalWriteGate, `LocalImplementation`, aktuelle `MergeAndSync`-Autorität und die schreibgeschützte Checklist-Phasengrenze vollständig voneinander abgegrenzt? [Completeness, Spec §SBR-006, §Autonomous-Run-Anwendbarkeit]
- [x] CHK005 Sind alle drei Public Canaries und alle vier nachfolgenden Profilwellen einschließlich vollständiger Wellengates und innerer Sortierung lückenlos benannt? [Completeness, Spec §SBR-007–SBR-008, §AC-SBR-003–AC-SBR-004]

## Requirement Clarity / Anforderungsklarheit

- [x] CHK006 Ist eindeutig, dass stabile Registry-IDs die Rolloutidentität bilden, `1 + 47 = 48` nur ein revalidierbarer Snapshot ist und Collection-Knoten ausgeschlossen bleiben? [Clarity, Spec §SBR-002, §Annahmen und Abhängigkeiten]
- [x] CHK007 Ist die Reihenfolge „Public Canaries → Public Products → Private Products → Private Governance/Scaffold → Public Presets“ ohne interpretierbare Parallel- oder Übersprungspfade formuliert? [Clarity, Spec §SBR-007–SBR-008, §G-SBR-003–G-SBR-004]
- [x] CHK008 Ist der reguläre Lebenszyklus jedes nichtleeren Zieldiffs mit eigenem Branch, exaktem Commit, PR, lokalen und entfernten Gates, regulärer Review, Merge und Default-Branch-Synchronisierung präzise definiert? [Clarity, Spec §SBR-009, §SBR-012, §SBR-021, §AC-SBR-005]
- [x] CHK009 Ist die Admin-Bypass-Ausnahme präzise an aktuelle Autorität, Ziel, Zeitpunkt, Grund, Scope, regulären Vorversuch und unabhängige Acceptance-, Security-, Review- und Gate-Evidence gebunden? [Clarity, Spec §SBR-013, §Admin-Bypass-Evidence, §G-SBR-006]
- [x] CHK010 Ist der private Minimalvertrag mit genau einem pfadabhängigen PR-Gate, dem exakten Status `home-baseline/ci-minimal-gate` und gesperrten direkten, Web- und API-Schreibpfaden eindeutig? [Clarity, Spec §SBR-010–SBR-011, §AC-SBR-007]

## Requirement Consistency / Anforderungskonsistenz

- [x] CHK011 Stimmen allgemeine `MergeAndSync`-Autorität, ExternalWriteGate und die engeren Schreibverbote dieser Checklist-Phase widerspruchsfrei überein? [Consistency, Spec §SBR-006, §Autonomous-Run-Anwendbarkeit]
- [x] CHK012 Bleibt die reguläre Reviewpflicht in Stories, Anforderungen, Annahmen und Abnahme konsistent der Normalweg, den ein Admin-Bypass niemals ersetzt? [Consistency, Spec §User Story 3, §SBR-012–SBR-013, §AC-SBR-005]
- [x] CHK013 Sind Wellenreihenfolge, Profilverträge und Budgetneuberechnung so aufeinander abgestimmt, dass eine nächste Welle weder bei Teilkonvergenz noch ohne frische Budgetprojektion beginnen kann? [Consistency, Spec §SBR-007–SBR-010, §SBR-019, §AC-SBR-010]
- [x] CHK014 Bleiben Stage-A-Verträge, historische Snapshots und G3-Evidence in allen Anforderungen und Edge Cases unverändert, während ausschließlich Stage-B-Verträge neue Entscheidungen tragen? [Consistency, Spec §SBR-004, §Randfälle, §Autonomous-Run-Anwendbarkeit]
- [x] CHK015 Stimmen G4-Sperre, Copilot-/Account-/Subscription-Isolation, unveränderte Intake-Serie und getrennt autorisiertes Serien-Follow-up ohne Scope-Konflikt überein? [Consistency, Spec §SBR-022–SBR-024, §AC-SBR-012]

## Acceptance Criteria Quality / Qualität der Abnahmekriterien

- [x] CHK016 Sind dynamische Mengengleichheit und fail-closed Negativfälle objektiv mit identischen ID-Mengen beziehungsweise `100 %` Blockierung vor Mutation messbar? [Measurability, Spec §AC-SBR-001–AC-SBR-002]
- [x] CHK017 Sind Canary- und Wellenabschluss mit vollständiger Konvergenz, fester Reihenfolge und `100 %` Übereinstimmung zur sortierten ID-Liste objektiv bewertbar? [Measurability, Spec §AC-SBR-003–AC-SBR-004]
- [x] CHK018 Sind für jeden nichtleeren Diff sämtliche verpflichtenden Lifecycle-Evidence-Felder und die Unwirksamkeit des Bypass auf diese Pflichten messbar festgelegt? [Measurability, Spec §AC-SBR-005, §SBR-021]
- [x] CHK019 Sind No-op und Resume durch `100 %` Evidence, `0` leere beziehungsweise doppelte PRs und den Erhalt aller bereits gemergten Erfolge quantifiziert? [Measurability, Spec §AC-SBR-006, §AC-SBR-008]
- [x] CHK020 Sind Budget, terminale Flottenabdeckung, Evidence-Redaktion und G4-Isolation mit exakten Schwellen beziehungsweise Null-/Hundert-Prozent-Kriterien messbar? [Measurability, Spec §AC-SBR-010–AC-SBR-012]

## Scenario Coverage / Szenarioabdeckung

- [x] CHK021 Decken die Primärszenarien den vollständigen Weg von frischem Fleet-Preflight über Canaries und Profilwellen bis zur terminalen Konvergenz-Evidence ab? [Coverage, Spec §User Story 1–User Story 5]
- [x] CHK022 Ist der alternative No-op-Pfad für leere oder semantisch bereits konvergente Änderungen ohne Branch, Commit oder PR vollständig beschrieben? [Coverage, Spec §User Story 4, §SBR-015, §No-op-Evidence]
- [x] CHK023 Sind Exception-Flows für Drift, Gate, Review, Push, Ruleset, Merge, Provider/Billing, Synchronisierung, Budget und Evidence-Verschmutzung ausdrücklich fail-closed erfasst? [Coverage, Spec §Randfälle, §SBR-003, §SBR-014, §SBR-016]
- [x] CHK024 Ist der Recovery-Pfad nach bewusstem Stop oder unerwarteter Unterbrechung mit gleicher Run-ID, vollständiger Revalidierung und Fortsetzung am ersten nicht konvergierten Ziel vollständig? [Coverage, Spec §SBR-005, §SBR-014–SBR-015, §Run state]
- [x] CHK025 Ist die eng begrenzte Admin-Bypass-Nutzung als eigener Exception-Flow nach regulärem Vorversuch dokumentiert, ohne Acceptance-, Security-, Review- oder Gate-Lücken zu legitimieren? [Coverage, Spec §SBR-013, §Admin bypass, §G-SBR-006]

## Edge Case Coverage / Randfallabdeckung

- [x] CHK026 Sind Driftfälle für HEADs, Registry-/Pfad-/Gate-Hashes, IDs, Default Branch, PR-HEAD, Checks, Review, Merge, Budget und Provider-Frische mit Revalidierungszeitpunkt abgedeckt? [Edge Cases, Spec §Randfälle, §Mutable validation tokens]
- [x] CHK027 Sind semantische statt byteidentische Konvergenz, leer gewordene PRs und konkurrierende Merges so beschrieben, dass kein unbelegter No-op oder falscher Erfolg entsteht? [Edge Cases, Spec §Randfälle, §SBR-015]
- [x] CHK028 Sind Provider-/Billing-Ablehnung, technischer Gatefehler und bestandener Gate als getrennte, nicht verwechselbare Zustände definiert? [Edge Cases, Spec §SBR-016, §Randfälle]
- [x] CHK029 Ist ein erfolgreicher Merge mit fehlgeschlagener lokaler oder entfernter Default-Branch-Synchronisierung ausdrücklich als teilkonvergent und wellenblockierend geregelt? [Edge Cases, Spec §Randfälle, §SBR-008, §SBR-021]
- [x] CHK030 Sind Secrets, Tokens, private Pfade, unbereinigte Providerantworten und unnötige Personendaten als Abschluss- und Veröffentlichungsblocker vollständig klassifiziert? [Edge Cases, Spec §SBR-016, §Datenklassen, §AC-SBR-011]

## Non-Functional Requirements / Nichtfunktionale Anforderungen

- [x] CHK031 Sind Security, Trust Boundaries, sichere Prozess-/Provideraufrufe, Supply Chain und die erforderlichen Security-Evidence-Familien mit Disposition und Re-Evaluation festgelegt? [Completeness, Spec §CR-005–CR-012, §Sicherheitsgovernance-Anwendbarkeit]
- [x] CHK032 Ist Plattformparität für macOS/Linux-Bash und Windows-PowerShell über fachliche Entscheidungen, Exitcodes, Evidence-Felder, Preview und Resume präzise definiert? [Clarity, Spec §SBR-017, §AC-SBR-009, §Plattformübergreifende Anwendbarkeit]
- [x] CHK033 Sind A11Y-Anforderungen für text-first, Tastatur, Screenreader, Farbe/Position, lineare Statusinformation, DE/EN und CEFR B2 über alle betroffenen Artefakte vollständig? [Completeness, Spec §SBR-018, §CR-002–CR-003, §Barrierefreiheitsanwendbarkeit]
- [x] CHK034 Ist genau eine Documentation-Impact-Entscheidung `UpdateRequired` mit Zielgruppen, Leserpfad, Quelle, Owner, Navigation, Sprachpartner, Plattformnachweis, Distribution, Home-Sync und Re-Evaluation dokumentiert? [Completeness, Spec §CR-013, §Dokumentationsauswirkung]
- [x] CHK035 Sind Statistikfortschreibung, Agentenflächen-Parität, MSL-/Non-MSL-Begründungen und Governance-Reviewer so definiert, dass spätere Abnahme keine stillen Ausnahmen zulässt? [Completeness, Spec §CR-001, §CR-004–CR-005, §Governance-Anwendbarkeit]

## Dependencies, Assumptions, and Phase Boundaries / Abhängigkeiten, Annahmen und Phasengrenzen

- [x] CHK036 Sind Ready-Intake, akzeptierte Artefakthashes, aktiver Run-State, aktuelle `MergeAndSync`-Authority und Bypass-Ausnahme als bindende, driftanfällige Inputs dokumentiert? [Assumption, Spec §Annahmen und Abhängigkeiten, §Accepted inputs]
- [x] CHK037 Ist die Abhängigkeit von terminalem G3 so formuliert, dass Stage B G3 weder neu schreibt noch bei fehlender oder veralteter Evidence fortsetzt? [Dependency, Spec §SBR-001, §Annahmen und Abhängigkeiten]
- [x] CHK038 Sind Budgetannahmen und Datenfrische so begrenzt, dass fehlende Werte nicht als null gelten und Copilot-Kategorien die private Actions-Projektion nicht verfälschen? [Assumption, Spec §SBR-019, §Budget Projection]
- [x] CHK039 Ist Home-Sync ausschließlich für tatsächlich geänderte manifestgebundene `homeRuntime` nach Preview, Konfliktprüfung, Merge und Authority-Revalidierung zulässig? [Dependency, Spec §SBR-020, §Dokumentationsauswirkung]
- [x] CHK040 Ist die terminale Stage-B-Grenze vollständig von G4-Start, G4-Konfiguration, Serienmutation sowie Copilot-/Account-/Subscription-Änderungen isoliert und auf einen reinen Evidence-Handoff begrenzt? [Consistency, Spec §SBR-022–SBR-024, §G4 boundary, §G-SBR-012]

## Notes and Accepted Dispositions / Notizen und akzeptierte Dispositionen

- **Evaluation / Auswertung**: `40/40 PASS`; alle Positionen wurden gegen den unveränderten Spezifikationshash `c06fccb514bb1d949b10db556e581a83c3518eadb0f564f81ddb2ef0c56e2652` ausgewertet und nur bei bestandener Anforderungsqualität markiert.
- **Traceability / Rückverfolgbarkeit**: `40/40` Positionen (`100 %`) besitzen mindestens eine präzise Spec-Sektion/-ID oder einen zulässigen Traceability-Marker; Mindestanforderung: `80 %`.
- **Open dispositions / Offene Dispositionen**: `0`; es gibt keine ungeprüfte Position und keinen akzeptierten Follow-up innerhalb dieses Gates. Owner: Fleet Delivery Owner; Peer Review vor Planung.
- **Specification repair / Spezifikationsreparatur**: `NoUpdateRequired`; kein materieller Qualitätsfehler und keine neue semantische Entscheidung wurden gefunden, daher blieb `spec.md` unverändert.
- **Prerequisite disposition / Prerequisite-Disposition**: Der vorgeschriebene Aufruf `.specify/scripts/bash/check-prerequisites.sh --json` wurde ausgeführt und meldete erwartungsgemäß fehlende `plan.md`. Der aktive Run-State ordnet `checklist` ausdrücklich vor `plan` ein; Featurepfad, Ready-Review, akzeptierte Hashes sowie die abgeschlossenen Abhängigkeiten `specify` und `clarify` wurden separat revalidiert. Für dieses formale Pre-plan-Gate ist die generische Plan-Voraussetzung daher nicht anwendbar. Owner: Fleet Delivery Owner.
- **Scope / Umfang**: Diese Auswertung bewertet ausschließlich die schriftlichen Anforderungen. Implementierungs-, Provider- und Ausführungstests bleiben den späteren Plan-, Implementierungs- und Acceptance-Gates vorbehalten.
- **Phase isolation / Phasenisolation**: Kein Commit, Push, PR, Merge, Home-Sync, GitHub- oder Zielrepository-Schreibzugriff, Intake-Serienupdate, Copilot-/Account-/Subscription-Update oder G4-Start gehört zu diesem Checklist-Gate.
- **Documentation Impact / Dokumentationsauswirkung**: Die Feature-Entscheidung bleibt genau einmal `UpdateRequired` gemäß `spec.md`; diese neue Governance-Checkliste ist Gate-Evidence innerhalb des dort festgelegten Leserpfads. Owner: Fleet Delivery Owner. Home-Sync-Bedarf: `false`. Re-Evaluation bei Spec-, Intake-, Authority-, G3-, Flotten-, Profil-, Gate-, Budget- oder G4-Grenzdrift.
