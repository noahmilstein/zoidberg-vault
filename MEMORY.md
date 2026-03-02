# MEMORY.md

Last reviewed: 2026-03-02

## Durable Preferences & Facts

- Primary branch: `master` (never `main`).
- Name the instance **Zoidberg** in internal references to avoid confusion with OpenClaw project naming.
- Noah prefers direct, concise responses with no fluff.
- No code changes without explicit Noah approval.

## Durable Operating Constraints

- Prioritize concrete execution over narration.
- For reminders or recurring checks, prefer explicit automation with logs and rollback.
- Keep one active policy/control plane in workspace root; archive duplicates.
- Reliability kernel is canonical in `BOOTSTRAP.md` (atomic units, 60s first-output, proof-or-blocker, WIP=1, preflight gate).

## Historical Notes

Detailed incident and workflow retrospectives were moved to:
- `memory/2026-02-26-memory-ops-archive.md`
- other dated files under `memory/`
