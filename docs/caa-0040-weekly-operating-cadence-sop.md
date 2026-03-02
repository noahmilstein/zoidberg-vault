# CAA-0040 — Weekly Operating Cadence SOP

Date: 2026-03-02
Owner: zappa
Scope: Simply Sauna 4-lane growth engine operating rhythm

## Purpose
Run a fixed weekly decision loop that converts lane KPI data into concrete execution changes.

## Inputs (required before Monday review)
- Prior-week KPI scorecard for all 4 lanes
- Spend + booked revenue + gross margin by lane
- Top 3 win reasons + top 3 loss reasons by lane
- Capacity constraints for next 14 days (fleet, install bandwidth)

## Weekly Cadence

### Monday — Scorecard + Lane Ranking (45 min)
1. Review KPI scorecard lane-by-lane:
   - B2C Rentals
   - B2B Rentals
   - B2C Sales+Install
   - B2B Sales+Install
2. Rank lanes by:
   - Contribution margin
   - Payback speed
   - Lead quality stability
3. Assign lane state:
   - SCALE
   - HOLD
   - REDUCE
4. Record 1 primary bottleneck per lane.

**Output:** lane ranking table + lane states + bottlenecks.

### Tuesday — Messaging/Offer Iterations (60 min)
1. For each SCALE/HOLD lane, choose exactly one conversion lever to test:
   - Headline/value prop
   - Offer framing
   - CTA/booking friction
2. Define test spec:
   - Hypothesis
   - Success metric
   - Minimum sample
   - Stop condition
3. Publish implementation tasks.

**Output:** weekly experiment register.

### Wednesday — Channel Operations Checks (45 min)
1. Paid channels:
   - Tracking integrity (UTM + campaign_id)
   - Budget pacing vs lane state
2. Outbound:
   - Deliverability
   - Reply rate
   - Meeting conversion
3. Partner pipeline:
   - New partner adds
   - Active referral throughput

**Output:** ops health checklist + remediation tasks.

### Friday — Capacity + Margin Gate (30 min)
1. Validate next-week capacity against projected demand.
2. Confirm minimum margin thresholds remain intact.
3. Freeze or throttle any lane violating margin or delivery constraints.
4. Lock next-week priorities and owners.

**Output:** next-week operating plan.

## Decision Thresholds
- **SCALE** when margin is positive, payback is within target, and quality is stable.
- **HOLD** when margin is positive but quality/capacity volatility is unresolved.
- **REDUCE** when quality is poor and margin trend is negative for 2 consecutive weeks.

## Artifacts to Maintain Weekly
- `docs/caa-0040-kpi-scorecard-template.md` (template baseline)
- Weekly scorecard snapshot (date-stamped)
- Weekly experiment register (date-stamped)
- Lane state decision log (date-stamped)

## Escalation Rules
Escalate immediately if any of the following is true:
- Attribution capture is incomplete for paid traffic
- Fleet utilization exceeds safe operating threshold for 2+ consecutive weeks
- Sales+Install cycle length expands while close rate falls for 2+ consecutive weeks
- Any lane shows negative contribution margin for 2 consecutive weeks

## Definition of Done (weekly cycle)
- All 4 cadence meetings executed
- Lane state assigned for all lanes
- At least 1 high-impact test shipped for each SCALE/HOLD lane
- Capacity + margin gate passed and next-week priorities locked
