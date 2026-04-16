# Codex CLI Status Output Evidence

This file preserves the exact relevant session output for the `AGENTS.md` status mismatch report.

## Captured `/status` output

The block below is the exact `/status` output provided by the user from the affected Codex CLI session.

```text
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
```

## Captured shell verification

The block below is the exact shell output provided by the user from the same context.

```text
$ ls AGENTS.md
AGENTS.md
```

## Why this matters

The mismatch is that `/status` reports `Agents.md: <none>` while a local `AGENTS.md` file clearly exists in the active working directory.
