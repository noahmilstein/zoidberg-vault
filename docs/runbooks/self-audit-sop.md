# Self-Audit SOP — Markdown Hygiene & Drift Control

Date: 2026-03-02
Owner: zappa
Frequency: Weekly (via existing `weekly-architecture-md-antipattern-audit` cron)

## Purpose
Prevent documentation drift, conflicting control-plane guidance, and stale/unsafe content in workspace markdown.

## Scope
- Root markdown control files (`BOOTSTRAP.md`, `BOOT.md`, `WORKFLOW_AUTO.md`, `MEMORY.md`, `AGENTS.md`, `SOUL.md`, `USER.md`, `QUEUE.md`, `TOOLS.md`)
- `docs/**/*.md` (active docs only; exclude `archive/`)

## Audit Checks (required)
1. **Protocol consistency**
   - `BOOTSTRAP.md` remains canonical behavior protocol
   - Pointer files (`BOOT.md`, `WORKFLOW_AUTO.md`) do not duplicate full protocol text
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

## Severity Levels
- **High:** contradictions that can change runtime behavior, unsafe secret exposure
- **Medium:** duplication, stale guidance, broken indexes/references
- **Low:** formatting, readability, non-blocking structure issues

## Output Requirements
- Write report: `docs/runbooks/architecture-audit-<UTC timestamp>.md`
- Include: findings, severity, remediation steps, and “no regressions detected” when clean
- If file changes are made, commit with concise hygiene-focused message and include commit hash in summary

## Guardrails
- No destructive deletes without explicit approval
- No config/app restarts as part of this SOP
- Keep fixes minimal and reversible
