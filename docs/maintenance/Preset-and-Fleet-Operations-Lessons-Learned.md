# Erkenntnisse fuer Preset-Entwicklung und Flottenbetrieb

## Zweck

Dieses Dokument verdichtet wiederkehrende Erkenntnisse aus lokalen Spec-Kit-,
Preset- und Flottenlaeufen. Es ist ein Betriebsvertrag, kein Ersatz fuer die
Evidence eines einzelnen Features oder einer Kampagne.

*This document consolidates recurring lessons from local Spec Kit, preset, and
fleet runs. It is an operating contract, not a replacement for feature- or
campaign-specific evidence.*

## Evidenzbasis

Die Ausgangsanalyse umfasste 27 lokale Codex-Sessions mit 563 deduplizierten
Nutzerauftraegen, 25 unerwarteten oder absichtlichen Abbruechen und rund
0,38 GiB gespeicherter JSONL-Historie. Forks kopieren historische Inhalte und
duerfen deshalb nicht als unabhaengige Beobachtungen gezaehlt werden.

Die Werte dienen nur als anonymisierte Prozess-Evidence. Prompts, private Pfade,
Repository-Namen, Task-IDs und Toolausgaben werden daraus nicht publiziert.

*The source analysis covered 27 local Codex sessions with 563 deduplicated user
requests, 25 unexpected or intentional interruptions, and about 0.38 GiB of
stored JSONL history. Forks copy prior history and must not be counted as
independent observations. The figures are anonymized process evidence only.*

## Preset-Entwicklung

1. **Repository-Zustand vor Chat-Erinnerung:** Tasks, Autoritaet, Artefakthashes,
   Evidence und naechste Aktion werden versioniert oder in validiertem lokalen
   Run-State gehalten. Chat-Historie ist kein System of Record.
2. **Getrennte Lebenszyklusbefehle:** Start, Stop, Status, Resume,
   Retrospektive und Delivery haben getrennte Verantwortlichkeiten. Status ist
   immer read-only; Resume revalidiert Drift und Autoritaet.
3. **Unklare Operationen nicht erraten:** Nach Abbruch erhalten nicht
   nachweisbar abgeschlossene Schritte `NeedsRevalidation`. Nachweisbar
   abgeschlossene Arbeit wird nicht wiederholt.
4. **Konvergenz statt Endlosschleife:** Wiederholte Clarify-, Checklist-,
   Review- und Analyze-Paesse enden an dokumentierten Kriterien. Bereits
   akzeptierte Low-Funde werden nicht ohne neue Evidence erneut eingebracht.
5. **Intake vor Implementierung:** Ein Intake-Review prueft Reihenfolge,
   Abgrenzung, Nachweise und Entscheidungsbedarf vor dem autonomen Lauf.
   Remediation entsteht aus Findings, nicht aus vermuteten Fehlern.
6. **Providerstatus bleibt ehrlich:** Quota, Zahlungsgrenzen und nicht
   verfuegbare Reviewer sind `ProviderUnavailable` oder offene Evidence, nie
   `Pass`. Ein Admin-Bypass ersetzt kein technisches Gate.
7. **Exact-Head und Autoritaet:** Commit, Push, PR und Merge pruefen aktuellen
   Head, sauberen Arbeitsbaum, offene Threads und explizite Remote-Autoritaet.
8. **Promotion braucht Wiederholbarkeit:** Nur reproduzierbare,
   providerneutrale Defekte werden in ein Preset uebernommen. Sonst gilt
   `NoPromotion`; es entsteht kein Leer-Branch und kein Leer-PR.
9. **Portable Nachweise:** Bash- und PowerShell-Pfade, negative Fixtures,
   fail-closed Validatoren und textorientierte Evidence sind Release-Gates.
10. **Lernbarkeit ist Qualitaet:** Bedienungsbeispiele, A11Y, CEFR-B2-Erklaerung
    und didaktische Kommentare werden mit der technischen Funktion geprueft.
11. **Upstream-Katalog bleibt seriell:** Community-Preset-Updates fuer
    `github/spec-kit` werden exakt einzeln eingereicht und aktiviert. Erst wenn
    der erzeugte PR geprueft und gemergt sowie das zugehoerige Issue
    abgeschlossen ist, wird das naechste Issue eingereicht beziehungsweise bei
    einer bereits vorhandenen Warteschlange als naechster Label-Kandidat
    benannt. Mehrere gleichzeitige Issues oder Label-Anfragen erhoehen das
    Verwechslungsrisiko im Maintainer-Review. Diese Regel folgt dem
    [Maintainer-Hinweis in `github/spec-kit#3679`](https://github.com/github/spec-kit/issues/3679#issuecomment-5060400721).

*Upstream community catalog updates for `github/spec-kit` are submitted and
activated strictly one at a time. Wait until the generated PR is reviewed and
merged and its issue is complete before filing the next issue or, for an
existing queue, naming the next label candidate. This follows the maintainer's
guidance and avoids ordering mistakes during review.*

## Flottenbetrieb

1. Kampagnen verwenden gepinnte Baselines, deklarative Manifeste, begrenzte
   Parallelitaet und unveraenderliche Worker-Handoffs.
2. Worker liefern strukturierte Evidence. Der Koordinator leitet keinen Erfolg
   aus einer blossen Agentenmeldung ab.
3. Gemeinsame Writer fuer Statistik, Version, Guidance, Workflow und
   Konsolidierung werden serialisiert.
4. Stop und Resume arbeiten an sicheren Kampagnengrenzen. Konsolidierung und
   Delivery bleiben eigenstaendige, wiederaufnehmbare Phasen.
5. Ein Worker darf seine lokale Berechtigung nicht in Remote-, Merge- oder
   Admin-Autoritaet umdeuten.
6. Nach Merge werden Branch, Remotes, lokaler `main`, sauberer Arbeitsbaum und
   `HEAD == origin/main` erneut bewiesen.
7. Retrospektiven trennen `FeatureSpecific`, `RunbookClarification`,
   `SkillCorrection`, `TemplateCorrection`, `AgentPolicyCorrection`,
   `ValidationAutomation`, `PresetFollowUp` und `NoPromotion`.

## Standardisierung

- Normative Regeln leben in Constitution, Preset-Templates, Commands,
  Validatoren und Agent-Guidance.
- Feldbeobachtungen leben zuerst in Evidence oder Workitems und erhalten
  Auftretenszahl, Vertrauensgrad, reproduzierbaren Test und Promotion-Entscheid.
- Effizienzbeobachtungen werden erst nach mindestens zwei unabhaengigen Laeufen
  verallgemeinert. Korrektheits-, Sicherheits- und Evidence-Fehler duerfen
  sofort korrigiert werden.
- Session-Historie wird fuer Auswertungen streaming-basiert gelesen und anhand
  stabiler Ereignis- oder Call-IDs dedupliziert. Rohe JSONL-Dateien werden nicht
  in Repositories kopiert.

*Normative rules belong in constitutions, preset templates, commands,
validators, and agent guidance. Field observations first become evidence or
work items with occurrence count, confidence, a reproducible test, and a clear
promotion decision.*
