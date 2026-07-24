# Plan Review Checklist

- [x] PRV-001 Technischer Ansatz deckt FR-001 bis FR-030 ab.
  Hinweis: Manifest, CLI, Bericht, Tests und Scope-Grenzen gegen die Spec mappen.
- [x] PRV-002 Keine ungeklärte Technologie- oder Abhängigkeitsentscheidung bleibt.
  Hinweis: `research.md` auf Alternativen und Entscheidung prüfen.
- [x] PRV-003 Öffentliche Bash-/PowerShell-Verträge sind paarig.
  Hinweis: Optionen, Status, Exitcodes und Hilfe zeilenweise vergleichen.
- [x] PRV-004 Teststrategie ist remote- und destruktionsfrei.
  Hinweis: Nur temporäre HOME-Verzeichnisse und lokale Bare-Remotes zulassen.
- [x] PRV-005 Security- und A11Y-Nachweise sind konkrete Gates.
  Hinweis: Gate-Datei auf Befehls- und Plattformtokens prüfen.
- [x] PRV-006 Position-4-Folgescope bleibt außerhalb.
  Hinweis: Keine globale Fetch-Barriere oder Worktree-Bereinigung versprechen.
- [x] PRV-007 Implementierungsreihenfolge beginnt test-first.
  Hinweis: Negative Fixtures müssen vor breiter Produktänderung rot sein.
- [x] PRV-008 Shared Guidance wird nicht unnötig geändert.
  Hinweis: Nur eine dauerhafte generische Regel löst fünf Flächen aus.
- [x] PRV-009 Remote-Closeout besitzt Exact-Head-Evidence.
  Hinweis: Provider-Evidence temporär halten und vor Merge validieren.
- [x] PRV-010 Kein Critical-, High- oder offener Medium-Planbefund bleibt.
  Hinweis: Analyze nach Tasks wiederholen und jeden Medium-Befund disponieren.
