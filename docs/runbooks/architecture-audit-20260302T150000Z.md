# Architecture & Markdown Hygiene Audit

Date: 2026-03-02T15:00:00Z
Owner: zappa
Scope: active markdown files in workspace (exclude archive/) per docs/runbooks/self-audit-sop.md

Summary:
- Performed protocol consistency, model alias, secrets hygiene, control-plane duplication, and CAA index integrity checks across active markdown per SOP.

Findings:

1) High — Secrets hygiene: embedded private key in repo metadata
- Evidence: identity/device.json contains a PEM private key (-----BEGIN PRIVATE KEY-----). File is tracked in repository root.
- Impact: exposure of a private key in repo is a high-severity secret leak risk.
- Remediation:
  - Immediate: remove identity/device.json from version control (git rm --cached) and add to .gitignore; rotate the exposed key immediately.
  - Medium-term: move any keys into OS-level protected files (e.g., /root/.ssh or secrets manager) and reference via environment or memory notes that do not include raw values.
  - Owner: Noah

2) High — Secrets hygiene: plaintext API key placeholders and local notes referencing storage locations
- Evidence: multiple files reference API keys or Bearer placeholders (CAA-V0-SPEC.md, QUEUE.md, TOOLS.md, model-architecture.md show example variables like OPENROUTER_API_KEY/OPENAI_API_KEY). Some backup config files show REDACTED but presence of sample keys and guidance to store in .env or host noted.
- Impact: likely lower than a raw secret but messier: ensure no actual live API keys are tracked in markdown.
- Remediation:
  - Verify none of these files contain real keys. If found, redact and rotate.
  - Update docs to use explicit env/secret-store references only (e.g., ${ENV_OPENROUTER_API_KEY}).
  - Owner: zappa/Noah

3) Medium — Model alias drift / inconsistency
- Evidence: docs/model-architecture.md contains mixed provider strings: `openai/gpt-5.2-chat` used in multiple places as orchestrator; AGENTS.md and memory notes specify canonical orchestrator `openrouter/openai/gpt-5.2-chat` and canonical aliases `orchestrator`, `m2.5`, `mini`. Queue and other docs reference aliases in some places and direct provider IDs in others.
- Impact: Medium — could cause confusion and accidental use of direct provider strings (unexpected auth requirements) or inconsistent spawn behavior.
- Remediation:
  - Normalize active docs to use canonical aliases (orchestrator, m2.5, mini) per self-audit SOP and include one short paragraph in docs/model-architecture.md stating canonical mapping and policy not to use direct provider tokens unless explicit provider credentials are configured.
  - Replace explicit `openai/*` provider references in active docs with `openrouter/...` provider names or aliases where appropriate.
  - Owner: zappa

4) Medium — Control-plane duplication: protocol text present outside BOOTSTRAP.md
- Evidence: docs/FAILURE_STATES.md includes execution protocol language and BUILD_MODE rules that partly duplicate BOOTSTRAP.md/WORKFLOW_AUTO.md content. WORKFLOW_AUTO.md and BOOT.md are pointer-style (correct).
- Impact: Medium — duplication increases risk of drift and contradictory guidance.
- Remediation:
  - Edit docs/FAILURE_STATES.md to remove full protocol text and replace with pointer that references BOOTSTRAP.md for authoritative behavior. Keep only enforcement examples if needed.
  - Owner: zappa

5) Low — CAA index integrity: OK, links valid
- Evidence: docs/caa-0040-index.md presents canonical read order and references the expected files; links resolved locally and read order matches SOP.
- Impact: Low — no immediate action.
- Remediation: None.

6) Low — Minor framing issues in docs/runbooks/content-hygiene-audit-20260302T0316Z.md
- Evidence: earlier hygiene audit recommends redaction; keep as-is but implement remediations above.

Actions taken under SOP (minimal, non-destructive):
- No automatic redactions or file edits applied. Secrets removal or key rotation require owner approval and out-of-band execution per Guardrails.

Recommendations (priority order):
1. Rotate the private key found in identity/device.json immediately and remove the file from VCS; add to .gitignore. (High)
2. Audit any other non-markdown tracked files for embedded secrets (openclaw.json backups, config backups) and redact/rotate as needed. (High)
3. Normalize model alias usage across active docs: prefer aliases (orchestrator/m2.5/mini) and `openrouter/*` provider strings. Update docs/model-architecture.md and AGENTS.md to match. (Medium)
4. Remove protocol duplication from docs/FAILURE_STATES.md, leaving pointer to BOOTSTRAP.md. (Medium)
5. Replace example API key placeholders with explicit env references (${ENV_*}) and add a short section in TOOLS.md explaining where to store secrets safely. (Medium)

Conclusion:
- Current state: regressions detected (secrets leak + model alias drift + control-plane duplication). No file changes applied automatically per Guardrails.

Next steps / Owner actions required:
- Noah: rotate the exposed private key and approve removal from git. Confirm when done.
- zappa: after approval, apply minimal edits (git rm --cached identity/device.json; add .gitignore entry; update docs/model-architecture.md and docs/FAILURE_STATES.md). Commit will be made with a concise hygiene message and hash included in an updated audit summary.

Source notes:
- Memory & AGENTS files: AGENTS.md, memory/2026-02-24.md
- Model docs: docs/model-architecture.md
- Protocol docs: BOOTSTRAP.md, WORKFLOW_AUTO.md, BOOT.md, docs/FAILURE_STATES.md
- Secrets evidence: identity/device.json, openclaw.json.bak*, openclaw-config-backup.json

End of report.
