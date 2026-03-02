# Self-Audit SOP — Markdown Hygiene & Drift Control

Date: 2026-03-02
Owner: zappa
Frequency: Weekly (via existing `weekly-architecture-md-antipattern-audit` cron)

## Purpose
Prevent documentation drift, conflicting control-plane guidance, and stale/unsafe content in workspace markdown.

## Scope
- Root markdown control files (`BOOTSTRAP.md`, `MEMORY.md`, `AGENTS.md`, `SOUL.md`, `USER.md`, `QUEUE.md`, `TOOLS.md`, `HEARTBEAT.md`)
- `docs/**/*.md` (active docs only; exclude `archive/`)
- Runtime reliability surface: heartbeat cadence, cron delivery health, and alert-target consistency for critical jobs

## Audit Checks (required)
1. **Protocol consistency**
   - `BOOTSTRAP.md` remains canonical behavior protocol
   - No duplicate/legacy protocol files remain in root unless explicitly required
2. **Model alias consistency**
   - No references to non-canonical model ladders in active execution docs
   - Queue/runtime docs use current aliases (`orchestrator`, `m2.5`, `mini`) or explicit provider IDs
3. **Secrets hygiene**
   - No raw API keys/tokens in tracked markdown
   - Replace with env/secret-store references
4. **Control-plane dedupe**
   - One active source-of-truth per process
   - Archive or pointerize duplicates
5. **CAA doc integrity**
   - `docs/caa-0040-index.md` links remain valid and ordered
   - Execution artifacts map cleanly: architecture → plan → KPI template → cadence SOP → weekly snapshot → experiment register
6. **Runtime reliability checks**
   - Heartbeat interval is appropriate for continuity goals (target <=15m when continuity monitoring is active)
   - Critical cron jobs use explicit delivery target (Slack DM `user:U0AFCAZF601`) instead of `last`
   - No critical cron has unresolved repeated delivery failures (`lastDeliveryStatus != delivered` or consecutiveErrors > 0)
   - If failures exist, report exact job IDs and remediation patch

## Severity Levels
- **High:** contradictions that can change runtime behavior, unsafe secret exposure, broken critical alert delivery
- **Medium:** duplication, stale guidance, broken indexes/references, heartbeat/cron reliability drift
- **Low:** formatting, readability, non-blocking structure issues

## Output Requirements
- Write report: `docs/runbooks/architecture-audit-<UTC timestamp>.md`
- Include: findings, severity, remediation steps, and “no regressions detected” when clean
- If file changes are made, commit with concise hygiene-focused message and include commit hash in summary

## Guardrails
- No destructive deletes without explicit approval
- No config/app restarts as part of this SOP
- Keep fixes minimal and reversible
