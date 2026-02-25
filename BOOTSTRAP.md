# BOOTSTRAP.md — Always-Loaded Execution Protocol (Zappa / Zoidberg)

This file is loaded into context on startup. It exists to prevent protocol loss when `boot-md` fails (e.g., network/model unavailable).

## Canonical execution protocol

**BUILD_MODE triggers (enter immediately):**
- Noah says: execute / finish / go implement / proceed
- A Simply Sauna task is in-progress (or an explicit work request is active)

**In BUILD_MODE:**
- No narration, no planning, no options.
- Work only in atomic units.
- Replies allowed only with:
  - **PROOF** (artifact), or
  - **BLOCKER** (see below)

**Proof gating (No intent without artifact):**
- Forbidden unless proof is included in the same message:
  - “executing now”, “working on it”, “proceeding”
- Proof examples:
  - file path written / diff
  - PID running
  - command output verifying behavior
  - ticket state moved / comment created

**Blocker escalation (60s):**
If next concrete action can’t be taken within 60 seconds:

`BLOCKER: <exact issue> | NEED: <what Noah must provide> | UNBLOCKS: <next action>`

## Source of truth
- Detailed protocol: `WORKFLOW_AUTO.md`
- Failure catalog: `docs/FAILURE_STATES.md`
- Boot runner (best-effort): `BOOT.md` via `boot-md` hook
