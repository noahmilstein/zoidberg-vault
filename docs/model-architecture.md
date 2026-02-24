# Supervisor / Orchestrator + Workers — Model Architecture

## 1. Architecture Summary

### Roles

| Role | Model | What it does | What it does NOT do |
|------|-------|-------------|-------------------|
| **Orchestrator** | `openai/gpt-5.2-chat` | Plans, decomposes tasks, routes to workers, enforces constraints, composes final human-facing response, maintains voice consistency | Generate bulk text, do heavy research synthesis, or run repetitive extraction |
| **Worker A** (drafting/rewriting) | `openrouter/minimax/minimax-m2.5` | Drafts long-form text, rewrites content, produces bulk output | Make routing decisions, talk to humans directly |
| **Worker B** (summarization/extraction) | `openrouter/openai/gpt-5-mini` | Summarizes docs, extracts action items, parses structured data | Planning, voice/tone decisions |
| **Worker C** (classification/tagging) | `openrouter/openai/gpt-5-mini` | Labels, categorizes, tags, triages | Long-form generation |
| **Worker D** (research synthesis) | `openrouter/minimax/minimax-m2.5` | Lightweight web research compilation, source comparison | Deep reasoning, architecture decisions |

### Routing Rules

- **Orchestrator writes directly** when: response is short (<500 words), requires consistent voice, or is a planning/decision output.
- **Orchestrator delegates** when: task requires bulk text (>500 words), repetitive extraction, classification of many items, or research across multiple sources.
- **Workers NEVER** talk to the human directly. All worker output flows back to the orchestrator for final packaging.

---

## 2. Model Ladder

| Tier | Model ID | Alias | Role | Cost Profile |
|------|----------|-------|------|-------------|
| Orchestrator | `openai/gpt-5.2-chat` | `orchestrator` | Primary brain, planning, routing, final assembly | Premium (but short outputs) |
| Worker | `openrouter/minimax/minimax-m2.5` | `m2.5` | Drafting, rewriting, research synthesis | Cheap |
| Worker | `openrouter/openai/gpt-5-mini` | `mini` | Summarization, extraction, classification, tagging | Cheapest |
| Heartbeat | `openrouter/openai/gpt-5-mini` | `mini` | Periodic checks | Cheapest |

**No escalation tier beyond orchestrator.** If orchestrator can't handle it, escalate to human.

---

## 3. Token/Cost Containment

### Short Orchestrator
- Orchestrator output capped to planning + routing + final assembly.
- Bulk text generation always delegated to workers.
- Orchestrator messages should rarely exceed 1000 tokens output.

### Worker Controls
- Workers receive tightly scoped tasks with explicit output format and length constraints.
- Max output per worker call: defined in task prompt (e.g., "summarize in ≤300 words").

### Retry Policy
- Max **1 worker retry** per task. If still failing, orchestrator writes a fallback or escalates to human.
- No retry loops. Fail fast.

### Stop Conditions
- Missing data or ambiguous scope → stop and ask human.
- Worker produces garbage → orchestrator writes fallback, flags for human review.
- Cost threshold exceeded → halt and report.

---

## 4. OpenClaw Configuration

### Proposed `openclaw.json` changes

```json
{
  "env": {
    "OPENROUTER_API_KEY": "<existing-key>",
    "OPENAI_API_KEY": "<openai-api-key-required>"
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "openai/gpt-5.2-chat",
        "fallbacks": ["openrouter/minimax/minimax-m2.5"]
      },
      "models": {
        "openai/gpt-5.2-chat": {
          "alias": "orchestrator"
        },
        "openrouter/minimax/minimax-m2.5": {
          "alias": "m2.5"
        },
        "openrouter/openai/gpt-5-mini": {
          "alias": "mini"
        }
      },
      "maxConcurrent": 4,
      "heartbeat": {
        "model": "openrouter/openai/gpt-5-mini"
      },
      "subagents": {
        "model": "openrouter/openai/gpt-5-mini",
        "maxConcurrent": 8,
        "maxSpawnDepth": 2,
        "maxChildrenPerAgent": 5,
        "runTimeoutSeconds": 900
      }
    }
  }
}
```

### How it works

- **Main session** (human-facing chat): runs on `openai/gpt-5.2-chat` (orchestrator). This is the brain that plans, routes, and assembles final responses.
- **Sub-agents** (workers): default to `openrouter/openai/gpt-5-mini`. When spawning, orchestrator can override per-task with `model: "openrouter/minimax/minimax-m2.5"` for drafting/research tasks.
- **`maxSpawnDepth: 2`**: enables the orchestrator pattern. Main → orchestrator sub-agent → worker sub-sub-agents. Per OpenClaw docs: depth-1 gets `sessions_spawn` + `subagents` tools; depth-2 is leaf (no further spawning).
- **Heartbeats**: cheap model (`gpt-5-mini`) for periodic checks.
- **Fallback**: if `openai/gpt-5.2-chat` fails, falls back to `minimax-m2.5` (degraded but functional).

### Auth requirement

OpenAI direct API key is required for `openai/gpt-5.2-chat`. This is NOT routed through OpenRouter — it hits OpenAI directly via the `openai` provider prefix.

```bash
openclaw onboard --openai-api-key "$OPENAI_API_KEY"
# or add to openclaw.json env block
```

Source: [OpenClaw OpenAI provider docs](/usr/lib/node_modules/openclaw/docs/providers/openai.md)

---

## 5. Example Workflows

### Workflow 1: "Write an internal SOP"

```
Human → Orchestrator: "Write an SOP for Simply Sauna lead follow-up process"
Orchestrator (plans):
  - Identifies sections needed: purpose, scope, steps, escalation, review cadence
  - Spawns Worker A (m2.5): "Draft SOP sections: [list]. Max 800 words total. Format: markdown with headers."
Worker A → Orchestrator: returns draft sections
Orchestrator (assembles):
  - Reviews for voice consistency, adds any missing governance notes
  - Delivers final SOP to human
```

### Workflow 2: "Summarize a long doc + extract action items"

```
Human → Orchestrator: "Summarize this doc and pull out action items" [attaches doc]
Orchestrator (plans):
  - Spawns Worker B (mini): "Summarize in ≤300 words. Then list action items as bullet points."
Worker B → Orchestrator: returns summary + bullets
Orchestrator (packages):
  - Light edit for clarity/voice
  - Delivers to human as: Summary + Action Items
```

### Workflow 3: "Ops/admin: create a checklist + email draft + follow-up tasks"

```
Human → Orchestrator: "Prep Monday ops: checklist for Simply Sauna week, draft email to team, follow-up tasks"
Orchestrator (plans):
  - Spawns Worker A (m2.5): "Draft ops checklist for Simply Sauna. Max 10 items."
  - Spawns Worker B (mini): "Draft brief team email. Subject + body. Max 200 words."
  - Spawns Worker B (mini): "List 5 follow-up tasks with owners and deadlines."
Workers → Orchestrator: return checklist, email, tasks
Orchestrator (assembles):
  - Merges into single briefing document
  - Delivers to human
```

---

## 6. Key Differences from Current Setup

| Current | New |
|---------|-----|
| `openrouter/auto` as primary (cheap router, inconsistent model) | `openai/gpt-5.2-chat` as orchestrator (consistent, high-fidelity) |
| Workers default to `openrouter/auto` (unpredictable) | Workers pinned to `gpt-5-mini` or `m2.5` (predictable, cheap) |
| No formal orchestrator/worker separation | Explicit role separation with routing rules |
| `maxSpawnDepth: 1` (flat) | `maxSpawnDepth: 2` (orchestrator pattern enabled) |
| No output length controls | Orchestrator keeps short; workers get explicit caps |
| No retry/stop policy | 1 retry max; fail fast to human |

---

## Next Actions

1. **Obtain OpenAI API key** for direct `openai/gpt-5.2-chat` access (not OpenRouter-routed). Add to `openclaw.json` env block or run `openclaw onboard --openai-api-key`.
2. **Apply config changes** to `/root/.openclaw/openclaw.json` per the snippet in Section 4.
3. **Restart gateway**: `openclaw gateway restart`
4. **Verify model resolution**: `openclaw models status` — confirm primary shows `openai/gpt-5.2-chat`.
5. **Test sub-agent spawn**: send a test task via Slack DM, confirm worker spawns on `gpt-5-mini` and orchestrator assembles.
6. **Update MEMORY.md** with new model architecture (replace old Model Configuration SOP section).
7. **Update TOOLS.md** with OpenAI API key reference and new model ladder.
8. **Delete old model config references** in MEMORY.md (the `openrouter/openrouter/auto` section is now obsolete).
