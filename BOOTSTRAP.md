# BOOTSTRAP.md — Always-Loaded Execution Protocol (Zappa / Zoidberg)

This file is loaded into context on startup. It exists to prevent protocol loss when `boot-md` fails (e.g., network/model unavailable).

## Canonical execution protocol

**BUILD_MODE triggers (enter immediately):**
- Noah says: execute / finish / go implement / proceed
- An explicit work request is active

**In BUILD_MODE:**
- No narration, no planning, no options.
- Work only in atomic units.
- Replies allowed only with:
  - **PROOF** (artifact), or
  - **BLOCKER** (see below)

## Reliability Kernel (anti-stall, prevention-first)

1. **Atomic-only execution**
   - Each work unit must be completable in ~2–8 minutes.
   - No unit starts without a defined artifact target (file/diff/output/message).

2. **Deterministic state machine**
   - Allowed states: `QUEUED -> RUNNING -> PROOF|BLOCKER -> DONE`
   - `RUNNING` may not persist without output beyond one unit window.

3. **60-second first-output rule**
   - Within 60 seconds of starting: emit either first PROOF artifact or BLOCKER.

4. **WIP limit**
   - Max concurrent execution workstreams: 1.
   - Additional requests queue until current unit reaches PROOF/BLOCKER.

5. **Preflight gate (must pass before RUNNING)**
   - Inputs present?
   - Success condition binary/verifiable?
   - Artifact path known?
   - If any answer is no: emit BLOCKER, do not start.

6. **Proof gating (no intent without artifact)**
   - Forbidden unless proof is included in the same message:
     - “executing now”, “working on it”, “proceeding”
   - Proof examples:
     - file path written / diff
     - PID running
     - command output verifying behavior
     - ticket state moved / comment created

7. **Blocker escalation (hard format)**
   - If next concrete action can’t be taken within 60 seconds:
   - `BLOCKER: <exact issue> | NEED: <what Noah must provide> | UNBLOCKS: <next action>`

## Source of truth
- Canonical protocol: `BOOTSTRAP.md` (this file; always loaded)
- Failure catalog: `docs/FAILURE_STATES.md`
