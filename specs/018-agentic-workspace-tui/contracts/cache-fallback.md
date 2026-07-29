# Contract: Content-Addressed Cache and Plain Fallback

## Fingerprint

SHA-256 covers sorted relative paths and raw file bytes for:

- TUI source and project files;
- both package lock files;
- verified NuGet source configuration;
- wrapper UI contract version.

The cache key also includes exactly one normalized platform:
`macos-arm64`, `macos-x64`, `linux-arm64`, `linux-x64`,
`windows-arm64`, or `windows-x64`.

## Publication

1. An exact complete cache hit may run.
2. A miss builds into a unique temporary directory.
3. Restore is locked.
4. The expected entry assembly and metadata are verified.
5. The temporary directory moves atomically to the final cache key.
6. Partial or mismatched cache content is never run.

No cache or binary output is tracked in Git.

## Fallback

Before engine start, unsupported terminal capability, missing .NET 10 SDK,
restore/build failure, corrupt cache or non-writable cache selects the Plain
assistant. The assistant preserves the same selection, conflict, summary,
confirmation and cancellation contract through line-oriented ASCII output.

After engine start, no UI or engine error may start a second engine process.
