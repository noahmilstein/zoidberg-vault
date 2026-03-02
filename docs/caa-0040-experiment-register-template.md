# CAA-0040 — Experiment Register Template

Use one row per experiment. Keep this updated weekly.

| Experiment ID | Week | Lane | Funnel Stage (TOFU/MOFU/BOFU) | Hypothesis | Change Introduced | Primary Metric | Guardrail Metric(s) | Minimum Sample | Start Date | End Date | Owner | Result (Win/Loss/Inconclusive) | Observed Impact | Decision (Ship/Iterate/Kill) | Notes |
|---|---|---|---|---|---|---|---|---:|---|---|---|---|---|---|---|
| EXP-001 | 2026-W10 | B2C Rentals | MOFU | <if we change X, metric Y improves> | <specific change> | <metric> | <metrics> |  |  |  |  |  |  |  |  |

## Definitions
- **Primary Metric:** The single metric that determines experiment success.
- **Guardrail Metrics:** Metrics that must not regress materially while the test runs.
- **Minimum Sample:** Predefined number of observations required before making a decision.
- **Result:**
  - Win = primary metric improved without unacceptable guardrail regression
  - Loss = no meaningful gain or guardrail regression
  - Inconclusive = insufficient sample or noisy data
- **Decision:**
  - Ship = adopt change in production
  - Iterate = modify and retest
  - Kill = stop test and revert

## Weekly Review Checklist
- ☐ All active experiments have owners and end dates
- ☐ Every experiment has a declared minimum sample
- ☐ Every experiment maps to exactly one primary metric
- ☐ Results recorded before launching replacement tests in same lane/stage
- ☐ Shipped wins reflected in lane SOPs/assets
