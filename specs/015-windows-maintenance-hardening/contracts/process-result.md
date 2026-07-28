# Contract: Bounded Process Result

Every bounded external operation records status, exitcode, attempt count,
duration, cleanup state and a sanitized summary. Timeout kills the complete
spawned process tree and waits for process exit. Authentication and repository
state errors are never classified as transient. Admin interaction is never
technically bypassed.
