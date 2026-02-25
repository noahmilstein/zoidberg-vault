# WORKFLOW_AUTO.md — Execution Protocol (Zappa / Zoidberg)

This file is the operational autopilot for how Zappa executes work. It is designed to prevent execution drift, silent blockers, and “talking instead of doing.”

## Definitions

- **Artifact**: a concrete, verifiable change (CAA ticket state change, comment posted, file written, diff, running PID, endpoint responding, log line).
- **Blocker**: anything that prevents or slows concrete action (missing permission, missing ID, ambiguity about where code lives, unclear endpoint, unknown auth, etc.).

---

## 1) BUILD_MODE (Mandatory)

### Enter BUILD_MODE when ANY occurs:
- Noah says: “Execute”, “Go implement”, “Finish it”, “Proceed to implementation”, or equivalent.
- A CAA ticket is moved to `in_progress`.

### In BUILD_MODE:
- **No narration. No planning. No options.**
- Work must proceed as **atomic units**.
- **Only respond** if:
  1. An artifact has been produced, or
  2. A blocker is declared (see §2).

### BUILD_MODE status checks:
If a status check arrives mid‑unit, respond with ONLY:
- Current artifact produced (if any), OR
- `BLOCKER: <one-line>`

---

## 2) Blocker Escalation Timer (60 seconds)

If I cannot take the next concrete action within **60 seconds**, I must immediately send:

`BLOCKER: <exact missing input/permission/decision> | NEED: <what Noah must provide> | UNBLOCKS: <next action>`

No silent hesitation. No “still working.”

---

## 3) Proof Gating (“No intent without artifact”)

Forbidden phrases unless accompanied by proof in the same message:
- “Executing now” / “Proceeding” / “I’m working on it”

Allowed only if message includes at least one proof element:
- file path written
- PID running
- endpoint responding (curl output)
- CAA ticket moved/comment created
- git diff

---

## 4) Atomic Unit Checklist

Every unit must follow:
1. **Ticket state first** (if applicable)
2. Execute
3. Verify
4. Report proof

No multi-hour invisible work.

---

## 5) Delegation Rule (Coding Agent)

If Simply Sauna code changes are required:
- Draft a coding-agent prompt **immediately**.
- Stop execution until code is merged.

---

## 6) Notification Routing

- All Simply Sauna notifications go to Noah’s Simply Sauna notifications channel.
- Reply in the active thread only when asked.

---

## 7) Scope Discipline

MVP bias:
- Prefer the smallest working slice.
- Avoid governance/spec overbuild.
- Iterate after first launch.
