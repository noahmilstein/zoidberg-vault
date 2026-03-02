# CAA-0067 — Lead Sourcing + Enrichment Spec (No-New-Spend)

## Goal
Produce sufficient US-only lead volume for listing-stager cold outreach using existing resources only: Instantly, Zillow, Google Maps, and Brave search.

## Constraints
- No new paid data sources.
- Geo restricted to USA only.
- Execution channel is Instantly campaigns operated via cron jobs.

## Approved Source Strategy (ranked)
1. Zillow (agent discovery)
2. Google Maps (brokerage + local business discovery)
3. Brave search (discovery + verification + long-tail coverage)
4. Instantly (campaign execution system of record for outreach state)

## Contact Priority
1. Primary: listing agents / buyer agents / agent teams
2. Secondary: brokerage owners / managing brokers / team leads
3. Tertiary: marketing directors/coordinators (only when no qualified primary/secondary contact)

## Required Enrichment Fields
- firstName
- lastName
- workEmail
- emailConfidence (enum: high|medium|low|unknown)
- companyName
- roleNormalized
- city
- state
- zip (optional when unavailable)
- metro (optional when unavailable)
- websiteDomain
- linkedInUrl (optional)
- sourceType (zillow|google_maps|brave|brokerage_site|other)
- sourceUrl
- lastVerifiedAt (ISO-8601 UTC)
- outreachStatus (new|queued|contacted|replied|bounced|unsubscribed)

## Hard QA Rejection Rules
Reject record if any are true:
- Missing or invalid workEmail
- Email appears generic mailbox (info@, support@, hello@, contact@, sales@) and person-role tie is not explicit
- Non-US location or unknown state
- Missing role/title
- Duplicate conflict unresolved by dedupe precedence
- Source URL missing or unreachable at verification time

## Dedupe Precedence
- Tier 1: exact email match
- Tier 2: normalized fullName + websiteDomain
- Tier 3: normalized fullName + normalized companyName + city + state
- Keep winner by: (1) highest field completeness, then (2) newest lastVerifiedAt

## QA Metrics (minimum to ship)
- >= 95% records with valid workEmail syntax
- <= 8% bounce rate in first campaign batch (if above, introduce verifier)
- >= 90% records with sourceUrl + lastVerifiedAt
- 100% US-state-resolved records

## Operational Notes
- Start without additional paid tools.
- Only add an email verification API later if live bounce rates exceed threshold.
- Keep suppression list synced from Instantly (bounced/unsubscribed/replied) before each batch enqueue.

## Definition of Done (CAA-0067)
- Spec captured in this file
- Ticket comment updated with approved constraints and decisions
- Ticket state moved to done when comment + spec link are recorded
