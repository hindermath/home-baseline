# Arbeitsnotiz: sprachbewusste Requirements- und Intake-Konsolidierung

Status: offen / open  
Owner: Level-0 Spec-Kit-Preset-Maintainer  
Datum: 2026-07-27  
Quellen: `hindermath/TuiVision`, `hindermath/TinyCalc`,
`hindermath/TinyPl0`

## Anlass / Motivation

TuiVision, TinyCalc und TinyPl0 haben ihre zuvor verteilten Pflichtenhefte,
Lastenhefte und Reihenfolgedokumente in ein gemeinsames Requirements- und
Intake-Modell überführt. Die drei Feldfälle unterscheiden sich deutlich in
Umfang und Historie. Trotzdem verwenden sie dieselben fachlichen Rollen:
schlanker Anforderungsindex, unveränderliche Baselines, getrennte
Intake-Zustände, kanonische Reihenfolge und prüfbare Receipts.

*TuiVision, TinyCalc, and TinyPl0 consolidated previously distributed
requirements specifications, intake files, and ordering documents into one
requirements and intake model. The three field cases differ significantly in
size and history. However, they use the same domain roles: a slim requirements
index, immutable baselines, separate intake states, canonical ordering, and
verifiable receipts.*

Die aktuelle Preset-Familie behandelt `Lastenheft*.md` bereits nur als ein
unterstütztes Profil. Mehrere Repository-Oberflächen und lokale
Migrationsskripte verwenden die deutschen Namen aber noch als technische
Vorgabe. Diese Arbeitsnotiz übergibt deshalb sowohl die bestätigte
Konsolidierungsstruktur als auch eine sprachbewusste Weiterentwicklung an die
zuständigen Presets.

*The current preset family already treats `Lastenheft*.md` as one supported
profile rather than the universal format. Several repository surfaces and
local migration scripts still use the German names as a technical requirement.
This work item therefore hands both the validated consolidation structure and
a language-aware evolution to the responsible presets.*

## Verifizierte Feldnachweise / Verified Field Evidence

Alle genannten Merge-Commits liegen auf dem jeweiligen synchronisierten
`main`-Branch. Die Pull Requests sind am 2026-07-27 als `MERGED` verifiziert
worden.

*All listed merge commits are present on the corresponding synchronized
`main` branch. The pull requests were verified as `MERGED` on 2026-07-27.*

| Repository | Reconciliation | Consolidation | Ergebnis / Result |
|---|---|---|---|
| `hindermath/TuiVision` | [PR #127](https://github.com/hindermath/TuiVision/pull/127), `664304a89b85b8d7c8f119bd2867580d51759852` | [PR #128](https://github.com/hindermath/TuiVision/pull/128), `38e0c1cb271322302742c1c0b70420e3c2cb3441` | schlanker Index, umfangreiche aktive/archivierte/backlog Historie |
| `hindermath/TinyCalc` | [PR #39](https://github.com/hindermath/TinyCalc/pull/39), `7a485268cdf2ad716acd309c8d8064ab2a9e5b16` | [PR #40](https://github.com/hindermath/TinyCalc/pull/40), `71148636c191b0a70203a0286d270a4d9f694660` | eine Baseline, neun aktive Intakes, keine archivierten Intakes |
| `hindermath/TinyPl0` | [PR #51](https://github.com/hindermath/TinyPl0/pull/51), `f18d89ced41a4e6f1aae62884e3ad479ef90c324` | [PR #52](https://github.com/hindermath/TinyPl0/pull/52), `38488d30c5c109f0bacc01879573594ea83e42d0` | drei Baselines, 14 aktive und zwei archivierte Intakes, historische Abhängigkeiten |

Die drei Repositories blieben bei der Erstellung dieser Arbeitsnotiz
unverändert. Ihre lokalen Alignment-Skripte sind Evidence, aber noch keine
gemeinsame Preset-Quelle.

*The three repositories remained unchanged while this work item was created.
Their local alignment scripts are evidence, but they are not yet a shared
preset source.*

## Bestätigtes Zielmodell / Confirmed Target Model

Das portable Modell besteht aus folgenden Regeln:

1. Ein schlanker kanonischer Anforderungsindex verweist auf Baselines, aktive
   Intakes, Status und bevorzugte Reihenfolge.
2. Historische Produktgrundlagen bleiben unveränderlich unter
   `requirements/baseline/`.
3. Aktive, archivierte, zurückgestellte und historische Intakes bleiben
   getrennt.
4. Das Serienmanifest unter `requirements/intakes/series/` ist die
   kanonische Quelle für Reihenfolge, Abhängigkeiten und Zustände.
5. Genau ein ausführbarer Kandidat darf den Zustand `Eligible` besitzen.
6. `Eligible` bezeichnet nur den bevorzugten nächsten Intake und erteilt
   keine Implementierungs-, Remote-, Push-, PR- oder Merge-Berechtigung.
7. Jeder aktive Intake besitzt einen normalisierten Hash, ein Receipt und
   genau einen Eintrag in der kanonischen Serie.
8. Lesbare Reihenfolgedokumente sind abgeleitete Ansichten und dürfen dem
   Manifest nicht widersprechen.

*The portable model uses a slim canonical requirements index, immutable
historical baselines, separated intake states, and one canonical series
manifest. Exactly one executable candidate may be `Eligible`. This state only
identifies the preferred next intake and grants no implementation or remote
authority. Every active intake has a normalized hash, a receipt, and exactly
one canonical series entry. Human-readable order views must agree with the
manifest.*

## Sprachneutrale Artefaktrollen / Language-Neutral Artifact Roles

Preset-Verträge sollen nicht von deutschen Dateinamen abhängen. Sie verwenden
stabile fachliche Rollen:

| Rollen-ID / Role ID | Bedeutung / Meaning |
|---|---|
| `requirements-index` | kanonischer Einstieg in Anforderungen und Intake-Zustand |
| `requirements-intake` | einzelner prüf- und ausführbarer Anforderungsumfang |
| `intake-order` | lesbare, aus der Serie abgeleitete Reihenfolge |
| `requirements-baseline` | unveränderliche historische Produktgrundlage |

*Preset contracts must not depend on German file names. Stable domain role IDs
identify the requirements entry point, one reviewable intake, the rendered
order view, and an immutable historical baseline.*

Verzeichnisse wie `requirements/baseline/`,
`requirements/intakes/active/` und `requirements/intakes/series/` bleiben
sprachneutral. Ein Namensprofil löst nur die sichtbaren Artefaktnamen auf.

*Directories such as `requirements/baseline/`,
`requirements/intakes/active/`, and `requirements/intakes/series/` remain
language-neutral. A naming profile resolves only the visible artifact names.*

## Kontrollierte Namensprofile / Controlled Naming Profiles

Die ersten portablen Profile sind Deutsch und Englisch:

| Dokumentationssprache | Index | Intake | Reihenfolge |
|---|---|---|---|
| `de-DE` | `Pflichtenheft.md` | `Lastenheft_<slug>.md` | `Lastenheft_Abarbeitungsreihenfolge.md` |
| `en` | `RequirementsIndex.md` | `RequirementsIntake_<slug>.md` | `RequirementsIntakeOrder.md` |

Die englischen Namen sind rollenbasiert. Sie vermeiden eine scheinbar exakte
Übersetzung deutscher Vertragsbegriffe, deren Bedeutung außerhalb des
deutschen Beschaffungsmodells uneindeutig sein kann.

*The English names are role-based. They avoid presenting German procurement
terms as if they had one exact contractual translation in every context.*

Ein vorgeschlagener portabler Konfigurationsausschnitt lautet:

```json
{
  "documentationLanguage": "en",
  "artifactNaming": {
    "profile": "en",
    "canonicalIndex": "RequirementsIndex.md",
    "intakePattern": "RequirementsIntake_<slug>.md",
    "orderView": "RequirementsIntakeOrder.md"
  }
}
```

Für ein deutschsprachiges Repository gilt entsprechend:

```json
{
  "documentationLanguage": "de-DE",
  "artifactNaming": {
    "profile": "de",
    "canonicalIndex": "Pflichtenheft.md",
    "intakePattern": "Lastenheft_<slug>.md",
    "orderView": "Lastenheft_Abarbeitungsreihenfolge.md"
  }
}
```

Explizite Feldwerte überschreiben ein Standardprofil. Manifest, Receipts und
Validatoren verwenden die aufgelösten Pfade, nicht fest eingebaute deutsche
Suchmuster.

*Explicit field values override a standard profile. Manifests, receipts, and
validators use resolved paths rather than hard-coded German patterns.*

## Erkennung der Dokumentationssprache / Documentation Language Detection

Die Dokumentationssprache ist nicht die Programmiersprache. Sie wird in dieser
Reihenfolge bestimmt:

1. explizites `documentationLanguage` in Repository- oder Intake-Policy;
2. explizite Regel in Constitution oder Agent-Guidance;
3. dominante Sprache der kanonischen Anforderungsdokumente;
4. andernfalls `Undetermined`.

*Documentation language is not implementation language. Resolve an explicit
repository policy first, then constitution or agent guidance, then the dominant
language of canonical requirements documents. Use `Undetermined` when these
sources do not provide a reliable result.*

Zusätzliche Grenzen:

- Sprachwerte verwenden BCP-47-Codes wie `de-DE` oder `en`.
- Programmiersprache, Betriebssystem-Locale und Benutzer-Locale sind keine
  gültigen Erkennungsquellen.
- Bei ausdrücklich bilingualen Dokumenten ist die zuerst genannte Sprache die
  primäre Dokumentationssprache.
- Automatische Erkennung dokumentiert Quelle und Vertrauenswert.
- Unterhalb der festgelegten Vertrauensgrenze wird kein neues lokalisiertes
  Artefakt erzeugt und keine Datei umbenannt.
- Eine erkannte, aber noch nicht unterstützte Sprache benötigt vor
  schreibenden Operationen ein explizites Namensprofil.
- Dateinamen werden nicht frei oder nicht-deterministisch durch ein
  Sprachmodell übersetzt.

*Use BCP-47 codes and record the source and confidence of automatic detection.
Implementation language and operating-system locale are invalid signals. A
bilingual policy uses its first language as primary. Low-confidence or
unsupported results require explicit configuration before a write operation.
Artifact names are never translated freely or non-deterministically by a
language model.*

## Migration und Rückwärtskompatibilität / Migration and Compatibility

TuiVision, TinyCalc und TinyPl0 behalten zunächst ihre deutschen Namen. Die
Erkennung einer anderen Dokumentationssprache löst niemals automatisch eine
Umbenennung aus.

*TuiVision, TinyCalc, and TinyPl0 initially keep their German names. Detecting a
different documentation language never triggers an automatic rename.*

Eine spätere Migration benötigt:

1. ausdrückliche Schreib- und Scope-Autorität;
2. einen konfliktfreien Zielnamen;
3. atomare Aktualisierung von Manifest, Receipts, Review-Evidence, Prompts,
   Agent-Guidance und Dokumentationslinks;
4. neue normalisierte Hashes und nachvollziehbare Migrations-Evidence;
5. Rollback- oder Reparaturgrenze bei einem Teilfehler.

*A later migration requires explicit write authority, conflict-free target
names, atomic reference updates, refreshed hashes, migration evidence, and a
defined repair boundary for partial failure.*

Historische und archivierte Dateien müssen nicht rückwirkend umbenannt werden.
Begrenzte `legacyArtifactNames` dürfen bestehende Namen lesen. Neue Intakes
müssen nach einer ausdrücklich abgeschlossenen Migration das aktive Profil
verwenden. Mehrere kanonische Indizes oder gemischte neue Präfixe sind
unzulässig.

*Historical and archived files do not require retrospective renaming. Bounded
legacy aliases may read existing names. New intakes use the active profile
after an explicitly completed migration. Multiple canonical indexes and mixed
new prefixes are invalid.*

## Preset-Zuordnung / Preset Allocation

| Preset | Aktueller Stand / Current Version | Folgeumfang / Follow-up Scope |
|---|---:|---|
| `intake-authoring-governance` | `0.2.1` | Dokumentationssprache, Namensprofil und Erzeugung neuer Artefakte |
| `intake-review-governance` | `0.1.2` | Sprach-, Namens-, Herkunfts- und Konsistenzprüfung |
| `intake-sequencing-governance` | `0.1.1` | aufgelöste Pfade in Manifest, Reihenfolge und Receipts |

Diese Arbeitsnotiz erhöht keine Preset-Version und verändert weder Scaffold
noch Publikationskopie.

*This work item does not increase a preset version and changes neither a
scaffold nor a publication copy.*

## Entscheidungen / Decisions

### `Promote`

- Sprachneutrale Artefaktrollen werden ein portabler Preset-Vertrag.
- `documentationLanguage` wird von der Implementierungssprache getrennt.
- Kontrollierte deutsche und englische Namensprofile werden vorgesehen.
- Pfade werden aus Konfiguration und Profil aufgelöst, nicht aus fest
  eingebauten `Pflichtenheft`-/`Lastenheft`-Mustern.
- Ein gemeinsamer Alignment-Vertrag prüft Index, Baselines, Intake-Zustände,
  Serie, Receipts und genau einen `Eligible`-Eintrag.
- Review-Evidence prüft, ob Sprache, Profil und reale Dateinamen
  zusammenpassen.

*Promote language-neutral roles, explicit documentation language, controlled
German and English profiles, configuration-based path resolution, and one
portable alignment contract.*

### `ObserveAgain`

- Automatische dominante Spracherkennung und Vertrauensgrenze benötigen
  weitere Feldfälle.
- Ein atomisches Migrationskommando wird erst nach einem kontrollierten
  Rename-Feldtest entworfen.
- Renderer und Validatoren werden nicht direkt übernommen. Die drei lokalen
  Implementierungen besitzen unterschiedliche Hashes und unterschiedliche
  Anforderungen; TuiVision besitzt noch keine gemeinsame
  `intake-governance-config.json`.
- Erst ein reproduzierbarer Bedarf entscheidet, ob Migration und dauerhafte
  Validierung ein Werkzeug oder getrennte Commands werden.

*Observe automatic language detection, confidence handling, and atomic rename
migration again. Do not copy the three divergent local renderers and validators
directly into a preset.*

### `RejectProjectSpecific`

- konkrete Intake-, Baseline- und Abhängigkeitsanzahlen;
- konkrete Slugs und bevorzugte nächste Intakes;
- TuiVision-spezifische Beispiel-, DocFX- und Feature-Historie;
- TinyCalc- und TinyPl0-spezifische Worklogs und Produktnamen;
- freie KI-Übersetzung von Artefaktnamen.

*Reject repository-specific counts, names, histories, worklogs, and free-form
AI translation as preset content.*

## Positive Prüffälle / Positive Test Cases

1. Ein deutsches Repository löst die drei sichtbaren Artefaktnamen aus dem
   Profil `de` auf.
2. Ein englisches Repository erzeugt `RequirementsIndex.md`,
   `RequirementsIntake_<slug>.md` und `RequirementsIntakeOrder.md`.
3. Ein bilinguales Repository verwendet die ausdrücklich zuerst genannte
   Sprache.
4. Ein explizites benutzerdefiniertes Profil überschreibt nur die benannten
   Felder.
5. Bestehende deutsche Namen bleiben ohne Migrationsautorität unverändert.
6. Manifest, Receipt und lesbare Reihenfolge zeigen nach einer autorisierten
   Migration auf dieselben aufgelösten Pfade.

*Positive tests cover German and English profiles, declared bilingual order,
explicit overrides, no-change compatibility, and atomic path agreement after
an authorized migration.*

## Negative Prüffälle / Negative Test Cases

1. Die Programmiersprache wird fälschlich als Dokumentationssprache verwendet.
2. Die Spracherkennung ist mehrdeutig oder unterschreitet die
   Vertrauensgrenze.
3. Eine erkannte Sprache besitzt kein Profil und keine expliziten Namen.
4. Neue Intakes mischen deutsche und englische Präfixe.
5. Eine Umbenennung wird ohne ausdrückliche Autorität angefordert.
6. Zielnamen existieren bereits oder unterscheiden sich nur in
   Dateisystem-Groß-/Kleinschreibung.
7. Manifest, Receipt, Prompt oder Link verweist nach einer Migration auf den
   alten Pfad.
8. Mehr als ein kanonischer Index oder mehr als ein `Eligible`-Eintrag ist
   vorhanden.

*Negative tests reject implementation-language inference, ambiguous or
unsupported detection, mixed prefixes, unauthorized or conflicting renames,
stale references, duplicate indexes, and multiple eligible entries.*

## Dokumentationsauswirkung / Documentation Impact

Entscheidung: `UpdateRequired`

- Source of truth: diese Arbeitsnotiz.
- Owner: Level-0 Spec-Kit-Preset-Maintainer.
- Aktualisierte Dokumente: diese Arbeitsnotiz und der deterministisch
  gerenderte Projektstatistik-Nachweis.
- Evidence: die sechs verifizierten Pull Requests, ihre Merge-Commits und die
  lokalen Requirements-Strukturen der drei Repositories.
- Follow-up-Grenze: Preset-Implementierung, Release, Flottenadoption und
  automatisierte Migration sind nicht Teil dieses Handoffs.

*Decision: `UpdateRequired`. This work item is the source of truth. The level-0
Spec Kit preset maintainer owns the follow-up. Preset implementation, release,
fleet adoption, and automated migration remain outside this handoff.*

## Abschlusskriterien / Completion Criteria

- Die sechs Pull Requests und Merge-Commits sind erreichbar und gemergt.
- Die drei Konsumenten-Repositories bleiben unverändert.
- Wiederverwendbare Regeln und projektspezifische Details sind getrennt.
- Die drei zuständigen Presets besitzen konkrete, begründete
  Folgeentscheidungen.
- Deutsch und Englisch besitzen deterministische rollenbasierte Profile.
- Bestehende Artefakte werden ohne ausdrückliche Migration nicht umbenannt.
- Keine Preset-Version oder Preset-Datei wurde durch diesen Handoff geändert.
- Projektstatistik, Whitespace-, Markdown-, Pfad-, Link- und Secret-Prüfungen
  sind abgeschlossen.

*Completion requires verified field evidence, unchanged consumer repositories,
clear portable boundaries, deterministic German and English profiles, no
implicit rename, no preset-version change, and passing documentation and
repository checks.*
