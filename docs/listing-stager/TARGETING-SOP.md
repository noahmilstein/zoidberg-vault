# Listing Stager — Targeting SOP

## Wedge Segmentation
Maintain strict pools:
- `agent`
- `brokerage`
- `photographer`

No cross-wedge imports.

## Required Lead Fields
At minimum before import:
- email
- fullName
- companyName (or brokerage/team equivalent)
- websiteDomain
- city
- state
- lastVerifiedAt

## Hard Rejections
Reject lead if:
- invalid/missing email
- critical field missing
- duplicate losing precedence rule
- suppression match

## Dedupe Precedence (locked)
1. exact email
2. normalized fullName + websiteDomain
3. normalized fullName + normalized companyName + city + state

Winner rule: highest completeness, then newest `lastVerifiedAt`.

## Source Governance
- Use only approved lead sources per wedge
- Track source attribution for every imported lead batch
- Quarantine any suspicious/low-confidence source batch
