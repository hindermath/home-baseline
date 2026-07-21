# OpenAI Codex Feature Request Draft: Repository-Aware Task Handoff

Status: Draft for explicit approval; not submitted

## What variant of Codex are you using?

Codex App and Codex CLI on macOS. The requested state contract should be shared
across both variants.

## What feature would you like to see?

### Summary

Add a repository-aware, sanitized task handoff that can move the useful context
of an existing Codex task into a new task associated with another workspace or
Git repository.

The handoff should transfer a compact, user-reviewable operational summary, not
replay or duplicate the complete session history. The destination task must
re-read its repository instructions and revalidate its filesystem, sandbox,
Git, and remote authority before taking action.

### Problem

Long-running engineering work often starts in one repository and produces a
follow-up that belongs in another repository. Today, users can manually fork or
resume a task with a different working directory, but this creates several
risks:

- the copied history can be very large and contain irrelevant tool output;
- source-repository assumptions can be mistaken for current destination state;
- `AGENTS.md` and other destination instructions may not receive sufficient
  priority;
- filesystem and remote permissions can appear to carry over implicitly;
- forks duplicate historical messages, which complicates later analysis;
- private paths, task identifiers, logs, or secrets may be copied unnecessarily.

In one anonymized local workflow, 27 sessions contained 563 deduplicated user
requests, 25 interruptions, and about 0.38 GiB of JSONL history. Two session
forks duplicated prior history. This is manageable as raw storage, but it is not
a good handoff protocol or a reliable system of record.

### Proposed behavior

Provide an App action such as **Hand off to repository...** and a matching CLI
operation, for example:

```text
codex handoff --to /path/to/destination
```

Before creating the destination task, show a sanitization preview containing:

- current goal and acceptance criteria;
- accepted decisions and rejected approaches;
- completed work and open work;
- known blockers and the exact next safe action;
- user-selected artifact references;
- source task identifier and a new handoff identifier.

Raw tool output, secrets, credentials, absolute private paths, unrelated
conversation history, and full JSONL replay should be excluded by default.
Users should be able to remove individual fields before confirming.

The destination task should then:

1. bind itself to the selected workspace and resolved Git root;
2. read destination instructions such as `AGENTS.md` before acting;
3. inspect branch, worktree, remotes, and current repository state;
4. label imported information as historical context until locally verified;
5. request new filesystem, execution, remote-write, PR, or merge authority;
6. preserve the source task unchanged and link both tasks for audit and return.

If the destination path conflicts with the selected workspace, the handoff must
stop for confirmation rather than silently changing repositories.

### Safety and privacy properties

- No implicit inheritance of remote or merge authority.
- No write before destination instructions and Git state are checked.
- User-visible redaction preview before handoff creation.
- Local-only handoff package by default.
- Versioned, integrity-checked handoff schema.
- Clear distinction between imported history and verified current facts.
- Source task remains recoverable and unchanged.

## Additional information

This request complements, rather than replaces, existing requests:

- #12464 proposes changing the current working directory inside one session.
- #28218 proposes automatic checkpointing and interrupted-session recovery.
- #29356 addresses operational continuity during context compaction.
- #31245 requests warnings for prompt/workspace conflicts.
- #33814 reports inconsistent CWD metadata after a managed-worktree handoff.

The proposed feature focuses on an intentional transition between repository
contexts with minimum necessary context, explicit sanitization, instruction
reload, and renewed authority. It should not be implemented as a silent `/cwd`
change or a complete session-history copy.
