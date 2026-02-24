# MEMORY.md

_Clean slate. CAA project deprecated 2026-02-20._

## Git conventions
- Primary branch: `master` (never `main`)
- Noah is firm on this — do not deviate

## 2026-02-23 — Recovery from nuke

- VPS was nuked and rebuilt due to persistent dual-layer 401 errors (stale OpenRouter key + stale device pairing)
- Restored from GitHub backup (noahmilstein/zoidberg-vault)
- Consolidated from 2-agent setup (Zappa supervisor + unnamed main) → single agent
- Zappa's SOUL.md preserved as foundation — to be evolved from governance-only into a full assistant persona
- Telegram channel deprecated and removed
- SECURITY.md sandbox directives carried forward

## CAA Workflow Rules (MANDATORY — Noah was firm about this repeatedly on 2026-02-23/24)

### Ticket State Management
- **Ticket state changes are the FIRST action, not an afterthought.**
- Before spawning a sub-agent: move ticket to `in_progress` FIRST, then spawn.
- When a sub-agent completes: move ticket to `done` FIRST, then report/continue.
- NEVER let ticket state drift. If a sub-agent is done, the ticket is done. Period.

### Pipeline Continuity
- **NEVER stop mid-queue.** When a sub-agent completes and there are remaining backlog tickets:
  1. Update completed ticket to `done`
  2. Move next ticket to `in_progress`
  3. Spawn next sub-agent
  4. Send Slack status update (non-blocking — do NOT wait for response)
- Do NOT treat completion announcements as "pause and wait for human input."
- Only stop the pipeline if: (a) you need input/credentials from Noah, (b) all tickets are done, or (c) a failure requires human decision.

### Reporting
- Status updates to Noah via Slack are fire-and-forget. Send them, keep working.
- If Noah asks "status?" it means you failed to keep him informed. Proactively update.

### Sub-Agent Model Assignment
- **Assign models to sub-agents based on task complexity.** Do not blindly default or blindly override.
  - **Routine/rote tasks** (file ops, simple CRUD, schema additions, config changes): gpt-5-mini (default)
  - **Moderate tasks** (standard code gen, API endpoints, UI pages following existing patterns): Sonnet
  - **Complex tasks** (architecture, debugging, multi-step reasoning, security review): Opus
- On 2026-02-24, I burned through 10+ Opus sub-agents at 50-150K tokens each on tasks that were mostly pattern-following. This was expensive and unnecessary.
- The model hierarchy we configured (gpt-5-mini default for sub-agents) exists for a reason. Only escalate when the task genuinely requires it.

### Sub-Agent Task Quality
- **NEVER paraphrase specs in sub-agent tasks.** Tell the sub-agent to READ the spec file directly. Example: "Read docs/specs/v3.md section 3.2 and implement everything listed."
- Compressing spec into a summary loses critical detail. Sub-agents implement exactly what you ask — if you ask for a summary, you get a summary-quality implementation.
- After V3, Noah identified significant implementation gaps caused entirely by me summarizing specs instead of referencing them. This rule prevents that from ever happening again.

### Why This Matters
- Noah had to prompt me 4+ times on 2026-02-23/24 to resume work and update tickets. This is unacceptable. These rules exist to prevent that from ever happening again.
