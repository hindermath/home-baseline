# Codex CLI Bug Report: `/status` shows `Agents.md: <none>`

## Deutsch

Hallo OpenAI-Team,

ich moechte einen moeglichen Bug in Codex CLI melden.

### Kurzzusammenfassung

In einer laufenden Codex-Session zeigt `/status` `Agents.md: <none>` an, obwohl im aktuellen Arbeitsverzeichnis eine Datei `AGENTS.md` vorhanden ist und normal lesbar ist.

### Umgebung

- Codex CLI: `v0.120.0`
- Modell: `gpt-5.4`
- Reasoning: `high`
- Directory: `~/home-baseline-tmp`
- Session: `019d8b8d-6d90-78f2-8654-29be29c108e7`

### Beobachtetes Verhalten

- `/status` zeigt: `Agents.md: <none>`
- Im selben Verzeichnis existiert `AGENTS.md`
- `ls AGENTS.md` liefert erfolgreich:

```text
Exit code: 0
Output:
AGENTS.md
```

- Nach manuellem Einlesen der Datei durch den Agenten kann sie inhaltlich verwendet werden, aber die `/status`-Anzeige bleibt offenbar weiterhin auf `<none>`

### Erwartetes Verhalten

- Entweder sollte Codex `AGENTS.md` beim Start der Session automatisch erkennen und in `/status` anzeigen
- oder `/status` sollte sich aktualisieren, nachdem die Datei manuell eingelesen und aktiv verwendet wird

### Auswirkung

Die Anzeige ist fuer Nutzer irrefuehrend, weil unklar bleibt, ob lokale Repository-Anweisungen wirklich aktiv im Kontext sind.

### Moegliche Reproduktion

1. In ein Verzeichnis mit vorhandener `AGENTS.md` wechseln
2. Codex CLI starten
3. `/status` aufrufen
4. Beobachten, ob weiterhin `Agents.md: <none>` angezeigt wird

Wenn hilfreich, kann ich die genaue Status-Ausgabe ebenfalls nachreichen.

Viele Gruesse

Thorsten

---

## English

Hello OpenAI team,

I would like to report a possible bug in Codex CLI.

### Short summary

In an active Codex session, `/status` shows `Agents.md: <none>` even though an `AGENTS.md` file exists in the current working directory and is normally readable.

### Environment

- Codex CLI: `v0.120.0`
- Model: `gpt-5.4`
- Reasoning: `high`
- Directory: `~/home-baseline-tmp`
- Session: `019d8b8d-6d90-78f2-8654-29be29c108e7`

### Observed behavior

- `/status` shows: `Agents.md: <none>`
- `AGENTS.md` exists in the same directory
- `ls AGENTS.md` succeeds with:

```text
Exit code: 0
Output:
AGENTS.md
```

- After the file is manually read by the agent, it can be used in practice, but the `/status` display still appears to remain `<none>`

### Expected behavior

- Either Codex should detect `AGENTS.md` automatically when the session starts and show it in `/status`
- or `/status` should refresh after the file has been manually read and is actively being used

### Impact

The display is misleading for users because it is unclear whether local repository instructions are actually active in the context.

### Possible reproduction

1. Change into a directory that already contains `AGENTS.md`
2. Start Codex CLI
3. Run `/status`
4. Check whether it still shows `Agents.md: <none>`

If useful, I can also provide the exact status output.

Best regards

Thorsten
