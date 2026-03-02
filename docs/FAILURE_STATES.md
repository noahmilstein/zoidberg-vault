# FAILURE_STATES.md — Anti-Stall Failure Catalog

Purpose: define known reliability failure modes and mandated countermeasures.

## F1: Silent RUNNING
- Symptom: task marked in-progress but no user-visible output.
- Prevention:
  - 60-second first-output rule.
  - Atomic unit size (2–8 min).
- Detection:
  - Missed first-output deadline.
- Response:
  - Emit BLOCKER immediately with NEED/UNBLOCKS.

## F2: Ambiguous task shape
- Symptom: broad request leads to planning loops and no concrete action.
- Prevention:
  - Preflight gate (binary success + artifact target required).
  - Auto-split into atomic units before RUNNING.
- Detection:
  - Cannot define artifact target in preflight.
- Response:
  - BLOCKER requesting only missing data.

## F3: Intent-only replies
- Symptom: “working on it” without artifact.
- Prevention:
  - Proof gating hard rule.
- Detection:
  - Any intent phrase without attached artifact.
- Response:
  - Corrective re-send as PROOF or BLOCKER.

## F4: Concurrent-context thrash
- Symptom: multiple parallel asks reduce execution throughput and cause misses.
- Prevention:
  - WIP limit = 1 execution stream.
  - Queue remaining work until PROOF/BLOCKER boundary.
- Detection:
  - Multiple active RUNNING items.
- Response:
  - Demote extras to queue and acknowledge order.

## F5: Hidden dependency blocker
- Symptom: work cannot proceed due to missing access/input but no escalation.
- Prevention:
  - 60-second blocker escalation rule.
- Detection:
  - Next concrete action unavailable within 60s.
- Response:
  - BLOCKER format with exact NEED and UNBLOCKS.

## F6: Protocol drift via file proliferation
- Symptom: multiple policy files conflict and get ignored.
- Prevention:
  - Single canonical control-plane file: `BOOTSTRAP.md`.
  - Pointer-only compatibility files; no duplicate policy logic elsewhere.
- Detection:
  - Rules diverge across files.
- Response:
  - Consolidate into BOOTSTRAP.md; reduce others to pointers/reference.
