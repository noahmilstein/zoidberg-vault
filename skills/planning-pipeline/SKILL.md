---
name: planning-pipeline
description: >
  Phase-gated planning workflow from idea → approved spec → executable tickets
  with mandatory human checkpoints and traceability. Use when: planning a feature,
  drafting or refining specs, performing gap analysis, generating tickets from a spec,
  scoping a new project, or designing a feature. Do NOT use for: executing existing
  tickets without planning, ad-hoc bugfixes, direct implementation, or routine tasks.
---

# Planning Pipeline

Structured workflow: idea → scope → spec → critique → gap analysis → tickets → execution.

## Global Rules

- The spec file is the **single source of truth**.
- Never generate tickets from chat summaries or memory — always read the spec file directly.
- Never skip checkpoints. Proceed only after explicit human approval token: `APPROVED: Phase N`.
- If ambiguity is found, create a Clarification Item (see references/templates.md) and block dependent work.
- If a gap/risk is accepted rather than fixed, record a Waiver with owner and date.
- If any phase reveals spec deficiencies, return to Phase 3.

---

## Phase 0: Intake *(optional but recommended)*

Establish context before scoping.

**Entry:** Human requests planning for a feature or project.
**Tasks:** Collect problem statement, business value ("why now"), constraints, non-goals, success metrics.
**Artifact:** Intake brief (markdown note).
**Exit:** Human confirms intake is accurate → `APPROVED: Phase 0`

---

## Phase 1: Scope Definition

**Entry:** Intake approved (or skipped with human consent).
**Tasks:**
- Ask clarifying questions until scope is testable and bounded.
- Identify: systems affected, in-scope behavior, out-of-scope behavior, constraints, assumptions.

**Artifact:** 2–5 sentence scope statement with explicit non-goals.
**Exit:** Scope is unambiguous enough to draft a spec → `APPROVED: Phase 1`

---

## Phase 2: Spec Drafting

**Entry:** Scope approved.
**Tasks:**
- Draft spec in `docs/specs/` (or user-specified path).
- Structure: Goal, Guardrails, Numbered sub-features (data model, API, UI/UX, migration, rollout/rollback, observability/test plan), Priority order.
- Every requirement must be specific and verifiable.
- Cross-cutting concerns included: errors, edge cases, permissions.

**Artifact:** Spec file path (e.g., `docs/specs/v4.md`).
**Exit:** Spec is complete enough for critique → `APPROVED: Phase 2`

---

## Phase 3: Critique & Revision Loop

**Entry:** Spec draft approved for review.
**Tasks:**
- Collect critique findings (internal or external reviewer).
- Triage by severity: Critical / Major / Minor.
- Resolve each finding: Fixed in spec, Deferred with rationale, or Waived with owner/date.

**Artifact:** Findings log with dispositions and spec updates.
**Exit:** No unresolved Critical findings; all Major findings resolved or explicitly waived → `APPROVED: Phase 3`

---

## Phase 4: Gap Analysis & Risk Assessment

Pre-ticket quality gate.

**Entry:** Spec critique approved.
**Tasks:**
Review approved spec for:
- Missing/weak acceptance criteria
- Ambiguity or multiple interpretations
- Error handling and edge cases
- Dependency ordering issues
- Migration/backfill gaps
- Missing UI behavior details
- Security/auth/permissions gaps
- Operational gaps (rollout, rollback, monitoring)
- Migration risk, reversibility, test strategy

**Artifact:** Gap report using Gap Item template (see references/templates.md).
**Exit:** All Critical gaps resolved; remaining gaps accepted with explicit waiver → `APPROVED: Phase 4`

---

## Phase 5: Ticket Generation

**Entry:** Gap analysis approved.
**Tasks:**
- Read spec file directly from path (never summarize).
- Create tickets per sub-feature with required schema (see references/templates.md § Ticket Schema).
- Produce a traceability matrix: every spec requirement → ≥1 ticket.

**Definition of Ready (DoR):** A ticket is ready only if:
- specRef is precise (path + section anchor)
- Acceptance criteria are numbered, binary, verifiable
- Dependencies are explicit ticket IDs or `[]`
- Unknowns are resolved or documented

**Artifacts:** Ticket manifest + Spec-to-ticket traceability matrix.
**Exit:** Every spec requirement mapped; no ticket without acceptance criteria → `APPROVED: Phase 5`

---

## Phase 6: Execution Handoff

**Entry:** Ticket list approved.
**Execution Contract** (each implementer/sub-agent must):
1. Read the spec file from `resources[0]` immediately before coding.
2. Implement the referenced section fully — not from summary.
3. Verify each acceptance criterion before marking done.
4. Record evidence for each criterion (test output, log, screenshot, or code reference).
5. Update ticket state at every transition.

**Definition of Done (DoD):** A ticket is done only if:
- All acceptance criteria satisfied with evidence.
- Required tests/checks pass.
- No open blockers remain.
- Any spec deviations documented and approved.

**Artifact:** Completion report with AC-by-AC verification.
**Exit:** Human confirms completion batch or requests rework.

---

## Anti-Patterns (Disallowed)

- Generating tickets from summarized recollection.
- Proceeding to next phase without explicit approval token.
- Tickets without acceptance criteria.
- Execution before gap analysis is approved.
- Closing tickets without criterion-by-criterion verification.
- Memory-based implementation — always re-read spec section before coding.

---

## References

- **Templates & schemas:** Read `references/templates.md` for Clarification Item, Gap Item, Traceability Row, and Ticket Schema templates.
