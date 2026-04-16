# Reply Draft for OpenAI Support

## Suggested subject

```text
Re: Codex CLI `/status` shows `Agents.md: <none>` although `AGENTS.md` exists
```

## Suggested reply body

```text
Hello,

here are the requested investigation details for the Codex CLI `AGENTS.md` status mismatch:

1) OS and filesystem case sensitivity
- OS: macOS
- Filesystem behavior for this path: case-insensitive

2) Exact `/status` output block

OpenAI Codex (v0.120.0)

Visit https://chatgpt.com/codex/settings/usage for up-to-date
information on rate limits and credits

 Model:                gpt-5.4 (reasoning high, summaries auto)
 Directory:            ~/home-baseline-tmp
 Permissions:          Custom (workspace-write, on-request)
 Agents.md:            <none>
 Account:              hindermath@googlemail.com (Plus)
 Collaboration mode:   Default
 Session:              019d8b8d-6d90-78f2-8654-29be29c108e7

3) Output of `pwd` and `ls -la` for the directory

$ pwd
/Users/thorstenhindermann/home-baseline-tmp

$ ls -la
total 864
drwxr-xr-x   37 thorstenhindermann  staff    1184 Apr 16 08:29 .
drwxr-x---+ 114 thorstenhindermann  staff    3648 Apr 16 07:26 ..
drwxr-xr-x    4 thorstenhindermann  staff     128 Apr  6 17:13 .agents
drwxr-xr-x    4 thorstenhindermann  staff     128 Apr 12 23:07 .claude
drwxr-xr-x    3 thorstenhindermann  staff      96 Apr  6 17:13 .gemini
drwxr-xr-x   17 thorstenhindermann  staff     544 Apr 16 08:32 .git
-rw-r--r--    1 thorstenhindermann  staff     213 Apr 10 17:02 .gitconfig
drwxr-xr-x    6 thorstenhindermann  staff     192 Apr 12 22:40 .github
-rw-r--r--@   1 thorstenhindermann  staff    2257 Apr 12 22:40 .gitignore
-rw-r--r--@   1 thorstenhindermann  staff      19 Apr 15 08:41 .release-please-manifest.json
drwxr-xr-x    6 thorstenhindermann  staff     192 Apr  6 17:13 .specify
drwxr-xr-x@   3 thorstenhindermann  staff      96 Apr  8 22:52 .vscode
-rw-r--r--    1 thorstenhindermann  staff       0 Apr 10 08:21 1
-rw-r--r--@   1 thorstenhindermann  staff   15797 Apr 13 15:15 AGENTS.md
-rw-r--r--@   1 thorstenhindermann  staff   25949 Apr 15 08:41 CHANGELOG.md
-rw-r--r--@   1 thorstenhindermann  staff   12253 Apr 13 15:15 CLAUDE.md
-rw-r--r--@   1 thorstenhindermann  staff   10808 Apr 13 15:17 GEMINI.md
-rw-r--r--    1 thorstenhindermann  staff    1083 Apr  6 17:13 LICENSE
-rw-r--r--    1 thorstenhindermann  staff   15639 Apr 10 17:02 Lastenheft_CICD_Pipeline_Konfiguration.md
-rw-r--r--    1 thorstenhindermann  staff   16871 Apr 11 17:06 Lastenheft_GitLab_Support.006-gitlab-support.md
-rw-r--r--    1 thorstenhindermann  staff   19177 Apr 11 17:06 Lastenheft_Git_Config_Scope.003-git-config-scope.md
-rw-r--r--    1 thorstenhindermann  staff    3921 Apr 12 22:40 Lastenheft_PowerShell_Cmdlets.md
-rw-r--r--    1 thorstenhindermann  staff    4176 Apr 12 22:40 Lastenheft_Script_Dokumentation.md
-rw-r--r--    1 thorstenhindermann  staff   17329 Apr 10 17:02 Lastenheft_Workspace_Migration.md
-rw-r--r--    1 thorstenhindermann  staff   18474 Apr 11 17:06 Lastenheft_Workspace_Teardown.005-workspace-teardown.md
-rw-r--r--    1 thorstenhindermann  staff   19068 Apr  6 17:13 Lastenheft_workspace-homogeneity-guardian-revision.002-homogeneity-guardian-revision.md
-rw-r--r--    1 thorstenhindermann  staff   37271 Apr  6 17:13 Lastenheft_workspace-homogeneity-guardian.001-workspace-homogeneity-guardian.md
-rw-r--r--@   1 thorstenhindermann  staff  143946 Apr 15 19:15 README.md
-rw-r--r--@   1 thorstenhindermann  staff     513 Apr 13 13:05 STATS.md
-rw-r--r--@   1 thorstenhindermann  staff   13557 Apr 13 15:14 constitution.md
drwxr-xr-x    5 thorstenhindermann  staff     160 Apr 16 08:29 docs
-rw-r--r--    1 thorstenhindermann  staff    2162 Apr  6 18:30 linux-test-output.txt
-rw-r--r--    1 thorstenhindermann  staff    1885 Apr  6 18:30 mac-test-output.txt
-rw-r--r--    1 thorstenhindermann  staff     580 Apr  6 17:13 release-please-config.json
drwxr-xr-x   40 thorstenhindermann  staff    1280 Apr 13 13:02 scripts
drwxr-xr-x    7 thorstenhindermann  staff     224 Apr 11 16:53 specs
-rw-r--r--    1 thorstenhindermann  staff    2215 Apr  6 18:30 windows-test-output.txt

4) Whether `AGENTS.md` existed before starting the Codex session

`AGENTS.md` already existed in `~/home-baseline-tmp` before the affected Codex session started. It was not created during the session.

If useful, I can also provide the two local reference files I created for this report:
- a concise bug report
- a separate evidence file with the same captured output

Best regards
Thorsten Hindermann
```
