# Content Hygiene Audit — 2026-03-02T03:16Z

Scope: workspace markdown files (excluding `archive/`) for drift, contradiction, and cruft.

## Executive Summary
- Files reviewed: 33 markdown files
- High-risk drift items: 2
- Medium-risk hygiene items: 4
- Recommendation: keep protocol hierarchy, fix model-routing drift, tighten queue execution policy, and move secrets out of tracked notes.

## Findings

### H-1 — Model routing drift across canonical docs
- **Where:** `AGENTS.md` vs `docs/model-architecture.md`
- **Issue:**
  - `AGENTS.md` states orchestrator = `openrouter/openai/gpt-5.2-chat`
  - `docs/model-architecture.md` states orchestrator = `openai/gpt-5.2-chat` (direct OpenAI provider)
- **Risk:** inconsistent runtime assumptions and wrong model override instructions.
- **Action:** choose one canonical provider path and align both files.

### H-2 — Queue execution policy references non-canonical model ladder
- **Where:** `QUEUE.md`
- **Issue:** complexity mapping references `Sonnet` and `Opus`, which are not in current model aliases/instructions.
- **Risk:** invalid routing behavior for autonomous queue runs.
- **Action:** replace with current aliases (`orchestrator`, `m2.5`, `mini`) and explicit spawn policy.

### M-1 — Security hygiene: secrets in local notes
- **Where:** `TOOLS.md`
- **Issue:** contains live-looking API key and infrastructure details.
- **Risk:** accidental disclosure via commits, logs, or copy/paste.
- **Action:** redact sensitive values and move to env/secret store references.

### M-2 — Protocol duplication (controlled but still drift-prone)
- **Where:** `BOOTSTRAP.md`, `WORKFLOW_AUTO.md`, `docs/FAILURE_STATES.md`
- **Issue:** protocol language appears in multiple files; `WORKFLOW_AUTO.md` is pointer-only now (good), but `FAILURE_STATES.md` still re-states parts of execution protocol.
- **Risk:** future wording drift.
- **Action:** keep only enforcement examples in `FAILURE_STATES.md`; point behavior rules to `BOOTSTRAP.md`.

### M-3 — CAA planning docs lack single index
- **Where:** `docs/caa-0040-*`, `docs/caa-0041-*`
- **Issue:** execution artifacts exist but no index doc links architecture → plan → cadence → templates.
- **Risk:** discoverability friction and duplicate future docs.
- **Action:** add one `docs/caa-0040-index.md` with ordered reading + ownership.

### M-4 — Memory/governance references not date-bound
- **Where:** `MEMORY.md` operating constraints
- **Issue:** durable rules are clear, but no “last reviewed” timestamp.
- **Risk:** stale constraints surviving context changes.
- **Action:** add `Last reviewed:` field and lightweight monthly review reminder.

## Keep (healthy patterns)
- `BOOT.md` and `WORKFLOW_AUTO.md` are pointer-style, reducing competing protocols.
- New CAA-0040 execution artifacts are structured and operationally usable.
- Naming transition to **Zoidberg** is consistently documented in root context files.

## Proposed Cleanup Sequence (safe)
1. Normalize model architecture references (`AGENTS.md` + `docs/model-architecture.md`).
2. Update `QUEUE.md` model routing language to current aliases.
3. Redact/relocate secrets from `TOOLS.md`.
4. Add CAA-0040 index doc linking architecture/plan/SOP/templates.
5. Add `Last reviewed` stamp to `MEMORY.md`.

## Status
Audit complete. No destructive changes made.
