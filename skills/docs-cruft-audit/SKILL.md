---
name: docs-cruft-audit
description: Run deterministic markdown hygiene, dedupe, consolidation, and cruft/deprecation audits for the workspace docs tree. Use when scanning for duplicate control planes, stale ticket-history docs, archival candidates, and safe cleanup plans; default to non-destructive reporting unless explicit delete/archive approval is provided.
---

# Docs Cruft Audit

## Objective
Produce a reliable, low-risk docs audit that:
1. detects overlap and stale/duplicative markdown,
2. proposes canonicalization + archive/delete actions,
3. avoids destructive actions unless explicitly approved.

## Scope
- Include: `/root/.openclaw/workspace/docs/**/*.md`
- Include root markdowns: `/root/.openclaw/workspace/*.md`
- Include control files when relevant: `/root/.openclaw/workspace/{BOOTSTRAP.md,MEMORY.md,AGENTS.md,TOOLS.md,HEARTBEAT.md}`
- Exclude generated/vendor folders and non-markdown files.

## Operating mode
- Default mode: **non-destructive**.
- In default mode: write audit report + explicit proposed changes only.
- Only perform archive/delete when a human explicitly approves in-session.

## Deterministic workflow

1. **Inventory**
   - List markdown files in scope.
   - Group by domain (listing-stager, runbooks, root docs, etc.).

2. **Canonical map**
   - Identify canonical source docs per domain.
   - Mark each file as: `canonical`, `active-reference`, `historical`, `candidate-archive`, `candidate-delete`.

3. **Overlap/dedupe checks**
   - Flag high-overlap files repeating policy/gate logic.
   - Flag files superseded by newer SSOT/runbooks.
   - Flag historical ticket evidence duplicated by external SoR (CAA/Convex).

4. **Risk checks**
   - Ensure proposed cleanup does not break active cron payload references.
   - Ensure skills and active docs do not reference files proposed for deletion.
   - Audit runtime reliability surface:
     - heartbeat cadence suitability for continuity goals,
     - critical cron delivery target consistency (avoid `channel:last` for critical alerts),
     - repeated cron delivery failures requiring escalation.

5. **Output report**
   - Write: `docs/runbooks/cruft-audit-<UTC timestamp>.md`
   - Required sections:
     - Summary
     - Canonical map table
     - Overlap findings
     - Safe cleanup plan (phase-gated)
     - Breakage checks
     - Explicit approval-needed actions

6. **Optional execution (approval only)**
   - If explicit approval exists, execute approved archive/delete actions.
   - Update refs (SSOT/runbooks/skills/cron payloads) first, then move/delete.
   - Commit with concise message and include commit SHA in final report.

## Required status format
- `TASK_STATUS: <pending|in_progress|blocked|done>`
- `DOC_STATUS: <report-only|updated|archived|deleted>`
- `RISK_STATUS: <none|low|medium|high>`
- `PROOF: <report path, commit sha if any>`
- `NEXT_ACTION: <single next step>`

## Guardrails
- No destructive action without explicit approval.
- No claims of completion without artifact proof.
- Keep changes minimal, reversible, and traceable.
