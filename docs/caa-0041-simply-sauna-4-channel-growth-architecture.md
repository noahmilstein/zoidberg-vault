# CAA-0041 — Simply Sauna 4-Channel Growth Architecture

Date: 2026-02-27
Owner: zappa

## Objective
Design an acquisition system for four revenue lanes:
1. B2B Rentals
2. B2B Sales + Install
3. B2C Rentals
4. B2C Sales + Install

Target geography constraints: HQ Bedminster NJ; 60-mile service radius; NYC boroughs excluded.

---

## Channel 1: B2B Rentals

### ICP
- Luxury hotels/resorts
- Wedding/event venues
- Corporate retreat operators
- High-end gyms/wellness clubs

### Offer
- 1–3 day mobile sauna activation packages
- Premium add-ons: branded towels, cold plunge pairing, staffed concierge setup

### Acquisition Mechanics
- Outbound: curated venue list + owner/GM outreach (email + phone)
- Partnership: event planners + hospitality consultants
- Inbound: venue-focused landing page + case studies + ROI framing (guest upsell / occupancy boost)

### Positioning
- "Premium wellness amenity without capex"
- Fast deployment, white-glove logistics, no permanent buildout

### Revenue Model
- Event-based package pricing + repeat venue contracts
- Upsell recurring seasonal activations

### Channel Constraints
- Setup windows and venue access rules
- Commercial COI / liability requirements
- Local permit constraints by municipality

---

## Channel 2: B2B Sales + Install

### ICP
- Boutique hotels / spas
- Fitness clubs
- Real estate developers / luxury property managers
- Wellness businesses opening new locations

### Offer
- Sauna unit sale + site assessment + install orchestration
- Optional maintenance and support plan

### Acquisition Mechanics
- High-intent SEO pages ("commercial sauna installation NJ")
- Consultant/referral network (architects, GCs, designers)
- Account-based outbound to qualified facilities

### Positioning
- "Commercial-grade sauna deployment with one accountable partner"

### Revenue Model
- One-time high-ticket sale + install margin + optional support retainer

### Channel Constraints
- Long sales cycle and multi-stakeholder approvals
- Electrical/ventilation/compliance dependencies
- Financing/procurement friction

---

## Channel 3: B2C Rentals

### ICP
- Affluent homeowners in service radius
- Hosts planning milestone events (birthdays, wellness weekends)
- Cold-plunge / performance / wellness enthusiasts

### Offer
- Mobile sauna day rental + extra-day extensions
- Add-ons: cold plunge pairing, robe/towel package, guided protocol

### Acquisition Mechanics
- Meta/Instagram local creative + UGC
- Google local search + maps + reviews
- Referral loop: post-rental incentive + neighbor offer

### Positioning
- "Luxury backyard wellness experience delivered to your home"

### Revenue Model
- Core rental pricing + add-ons + multi-day extension

### Channel Constraints
- Delivery logistics by radius and route density
- Weather sensitivity and rescheduling policy
- Weekend demand spikes / fleet capacity limits

---

## Channel 4: B2C Sales + Install

### ICP
- Homeowners with discretionary budget for permanent wellness upgrade
- New custom home builds / major renovations

### Offer
- Design consult + unit selection + install management
- Optional service/maintenance plans

### Acquisition Mechanics
- Search intent pages (home sauna install, outdoor sauna NJ)
- Content funnel: buyer guides, comparisons, install timelines
- Partnerships: high-end contractors, designers, pool builders

### Positioning
- "End-to-end premium home sauna install, from plan to first session"

### Revenue Model
- High-ticket sale + install + optional aftercare

### Channel Constraints
- Permit/electrical/site constraints
- Longer consideration cycle
- Trust/proof requirements (portfolio, testimonials, warranties)

---

## System Design (Cross-Channel)

## Funnel Architecture
- TOFU: geo-targeted paid + local SEO + referral partners
- MOFU: qualification, consult booking, offer fit by lane
- BOFU: quote/proposal, close sequence, financing/terms where needed

## Routing Logic
- Lead form captures intent: rental vs purchase, business vs consumer
- Auto-route to one of 4 lanes + lane-specific follow-up sequence

## KPI Framework
- By lane: CPL, qualified rate, close rate, CAC payback
- Rentals: utilization rate, repeat booking rate, add-on attach rate
- Sales/install: proposal-to-close rate, cycle length, gross margin

## 90-Day Execution Priority
1. B2C Rentals (fastest feedback and cashflow)
2. B2B Rentals (partnership leverage)
3. B2C Sales+Install (content + consult engine)
4. B2B Sales+Install (ABM + referral partnerships)

## Decision Rules
- Scale channels with strongest contribution margin and shortest payback
- Keep strict geo-fit; reject NYC borough leads outside policy
- Maintain lane-specific messaging to avoid mixed-intent conversion drag
