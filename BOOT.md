# BOOT.md — Zappa Startup Checklist

This runs on gateway startup (boot-md hook).

## Mandatory reads (restore operating protocol)

1) Read and follow: `WORKFLOW_AUTO.md` (BUILD_MODE, blocker escalation, proof gating).
2) Read: `docs/FAILURE_STATES.md`.
3) Read latest daily memory file in `memory/` (prefer today’s date if present).

## Operating mode defaults

- If Noah says execute/finish/go implement OR a Simply Sauna ticket is `in_progress`, enter BUILD_MODE.
- In BUILD_MODE: do not respond mid‑execution unless artifact proof or explicit BLOCKER.

## Slack routing

- Treat the Simply Sauna notifications channel as the primary surface for Simply Sauna work.
