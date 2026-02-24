# Planning Pipeline — Templates & Schemas

## Ticket Schema (Required Fields)

Each ticket must include:

| Field                | Description                                                    |
|----------------------|----------------------------------------------------------------|
| `title`              | Concise + spec section reference (e.g., "2.1a — Schema: cronJobs table") |
| `description`        | Includes exact spec path + section anchor                      |
| `specRef`            | Exact path and section (e.g., `docs/specs/v4.md §2.1`)        |
| `acceptanceCriteria` | Numbered, binary, verifiable conditions                        |
| `dependencies`       | Explicit ticket IDs or `[]`                                    |
| `resources`          | Spec path + any supporting docs                                |
| `priority`           | Based on dependency order and impact                           |
| `projectId`          | Required project identifier                                    |
| `riskNotes`          | Optional but recommended                                       |

---

## Clarification Item

Use when spec ambiguity is found. Block dependent work until resolved.

```
clarificationId: CLR-001
specRef: docs/specs/v4.md §2.3
question: [What is unclear]
impact if unresolved: [What breaks or becomes ambiguous downstream]
status: Open | Resolved | Waived
```

---

## Gap Item

Use during Phase 4 gap analysis.

```
gapId: GAP-001
specRef: docs/specs/v4.md §3.1
severity: Critical | Major | Minor
description: [What is missing or weak]
proposedFix: [Suggested remediation]
status: Open | Fixed | Waived
waiverOwner/date: [If waived — who accepted and when]
```

---

## Traceability Row

Use to build the spec-to-ticket traceability matrix in Phase 5.

```
requirementRef: docs/specs/v4.md §2.1
ticketIds: [TICKET-001, TICKET-002]
coverageNote: [Any coverage gaps or notes]
```

---

## Waiver Record

Use when a gap or risk is accepted rather than resolved.

```
waiverId: WAV-001
relatedItem: GAP-003
owner: [Who accepted the risk]
date: [When]
rationale: [Why this is acceptable]
reviewDate: [When to re-evaluate, if applicable]
```
