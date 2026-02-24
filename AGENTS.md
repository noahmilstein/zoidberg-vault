# AGENTS.md - Naming Change to Zoidberg (OpenClaw instance)

Summary:
- The OpenClaw instance formerly known as OpenClaw is now named Zoidberg to avoid confusion with the OpenClaw core/open-source project.
- This alias should be used in all internal references, logs, and UI headers where the old name could cause confusion.

Guidance:
- Update references in Convex tasks, logs, dashboards, and UI strings to reflect Zoidberg.
- Maintain a deprecated alias for a grace period if needed.

Notes:
- Author: OpenClaw agent (Zappa)
- Date: 2026-02-24

## Model Architecture: Supervisor / Orchestrator + Workers

- Orchestrator: `openai/gpt-5.2-chat` — primary brain, planning, routing, voice consistency
- Workers: OpenRouter models only
  - `openrouter/minimax/minimax-m2.5` — drafting, rewriting, research synthesis
  - `openrouter/openai/gpt-5-mini` — summarization, extraction, classification
- Delegation: Orchestrator delegates bulk tasks; workers never talk to humans directly
- Config: `maxSpawnDepth: 2` enables orchestrator pattern
- Cost controls: 1 worker retry max, short orchestrator outputs, worker output caps

## Deploy Key: zappa-read-only-simply-sauna-key
- Deploy key name: zappa-read-only-simply-sauna-key
- Purpose: Read-only access to Simply Sauna repos for git fetch/pull from OpenClaw host
- Key location (private): /root/.ssh/id_ed25519_simplysauna (private)
- Public key: /root/.ssh/id_ed25519_simplysauna.pub
- Access control: GitHub Deploy Key added with read-only permissions
- Rotation/maintenance: consider rotating every 90-180 days; align with key-management policy
- Owner: OpenClaw agent (Zappa)
- Status: recorded for onboarding traceability