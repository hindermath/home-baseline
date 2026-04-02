# STATS.md-Dateiformat / STATS.md File Format

**FR-REV-B04** | **NFR-REV-05**

---

## Schema

```markdown
# Statistiken / Statistics

| Datum / Date | Compliance-Score | Fortschritt / Progress |
|---|---|---|
| YYYY-MM-DD HH:MM | NN% | ████████░░░░░░░░░░░░ NN% |
```

## Regeln / Rules

- **Kopfzeile / Header**: Bilingual DE first, EN second (NFR-REV-05)
- **Timestamp**: Lokale Zeit, Format `YYYY-MM-DD HH:MM` (keine Sekunden)
- **Score**: Ganzzahl 0–100, gefolgt von `%`
- **ASCII-Bar**: Exakt 20 Zeichen — `█` (U+2588) für gefüllt, `░` (U+2591) für leer
- **Runden / Rounding**: Score auf nächste 5 % für Balkendarstellung (`round(score/5)*5`)
- **Append-only**: Neue Einträge werden am **Ende** angefügt, niemals überschrieben
- **Präsenz-Check**: `check-homogeneity.sh` prüft nur, ob Datei existiert (kein Inhalts-Check)

## Vollständiges Beispiel / Complete Example

```markdown
# Statistiken / Statistics

| Datum / Date | Compliance-Score | Fortschritt / Progress |
|---|---|---|
| 2026-04-02 16:30 | 25% | █████░░░░░░░░░░░░░░░ 25% |
| 2026-04-03 09:15 | 65% | █████████████░░░░░░░ 65% |
| 2026-04-04 11:00 | 100% | ████████████████████ 100% |
```

## Dateipfade / File Paths

| Ebene / Level | Pfad / Path |
|---|---|
| Level 0 | `~/STATS.md` |
| Level 1 | `~/{workspace}/STATS.md` |
| Level 2 | `~/{workspace}/{project}/STATS.md` |

## ASCII-Bar-Berechnungsformel / Calculation Formula

```bash
filled=$(( (score + 2) / 5 ))   # round(score/5), integer division with rounding
empty=$(( 20 - filled ))
bar=$(printf '█%.0s' $(seq 1 $filled))$(printf '░%.0s' $(seq 1 $empty))
```
