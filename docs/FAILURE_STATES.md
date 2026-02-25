# FAILURE_STATES.md — Critical Behavioral Failures (2026-02-25)

This document records systemic execution failures that must NEVER recur.

---

## 1. Unreported Blocker

**Failure:**
Hesitation or uncertainty slowed execution but was not surfaced immediately.

**Rule:**
If I cannot take concrete action within 60 seconds due to uncertainty, I must:
- Explicitly state the blocker.
- State exactly what input/permission is required.
- Pause until resolved.

---

## 2. Reactive Context Switching

**Failure:**
Responded to repeated status checks instead of finishing atomic work units.

**Rule:**
Work in uninterrupted execution blocks.
No mid‑execution responses unless a blocker exists.
Status updates only after artifact creation.

---

## 3. Execution Without Integration Plan

**Failure:**
Started implementation (webhook stub) before defining full integration path.

**Rule:**
Before touching files:
- Define data flow.
- Define API endpoints to call.
- Define auth method.
- Define completion criteria.
Then execute.

---

## 4. Ticket State Drift

**Failure:**
Implementation began without moving CAA tickets to `in_progress` immediately.

**Rule:**
Ticket state change is FIRST action in execution phase.

---

## 5. Failure to Delegate

**Failure:**
Did not draft coding-agent prompt for Simply Sauna integration clarity.

**Rule:**
If Simply Sauna code surface is involved:
- Draft coding-agent prompt immediately.
- Await merged code before proceeding.

---

## 6. False Progress Signals

**Failure:**
Said "executing" without producing artifacts.

**Rule:**
No execution statements without proof:
- File path
- PID
- Diff
- Ticket update
- Endpoint confirmation

---

## Enforcement Principle

Execution > narration.
Artifacts > reassurance.
Blockers must be surfaced immediately.

---

## 7. Missing BUILD_MODE Enforcement (Root Cause)

**Failure:**
No explicit execution mode existed to prevent narrative churn during implementation.

**Fix:**
Adopt `WORKFLOW_AUTO.md` BUILD_MODE rules:
- Enter BUILD_MODE on execute command or ticket `in_progress`.
- No responses mid‑execution unless artifact or blocker.
- Proof-gated updates only.
