# TOOLS.md - Local Notes

## Secrets Storage (Canonical "Where")

- **SSH private keys:** `~/.ssh/` with `chmod 600` (example: `~/.ssh/id_ed25519_simplysauna`)
- **Runtime API secrets for apps/agents:** environment variables at runtime (do not store raw values in markdown/docs)
- **Config references:** use env-style placeholders in docs (example: `${ENV_OPENROUTER_API_KEY}`), not literal keys
- **Repo policy:** no raw secret values committed to git-tracked files

## Host

- **Hostname:** zoidberg-crab-shell
- **OS:** Ubuntu 24.04.3 LTS (x86_64, kernel 6.8.0-90)
- **IP:** 46.225.127.41
- **Disk:** 75G total, ~68G free
- **Node:** v22.22.0
- **OpenClaw:** v2026.2.22-2 (systemd user service)

## SSH

- **Key:** ~/.ssh/id_ed25519 (ed25519, `openclaw@zoidberg`)
- **GitHub deploy key** on noahmilstein/zoidberg-vault (read/write)

## Git

- **Workspace repo:** git@github.com:noahmilstein/zoidberg-vault.git
- **Git identity:** Zoidberg <openclaw@zoidberg>

## Installed

- git, node, npm, curl, wget, python3
- **Missing:** pnpm (config references it but not installed), trash-cli

## Services

- openclaw-gateway (systemd user, active)
- gpg-agent

## CAA (CtrlAltAgnt)

- **API Base:** `https://polished-opossum-635.convex.site`
- **API Key:** `<stored in local secret/env; redacted from repo>`
- **Auth:** `Authorization: Bearer <API_KEY>`
- **App URL:** `https://ctrlaltagnt.vercel.app`
- **Repo:** `github.com/noahmilstein/ctrlaltagnt` (SSH: `github.com-caa`, key: `~/.ssh/id_ed25519_caa`)
- **Convex Dev:** `majestic-canary-968`
- **Convex Prod:** `polished-opossum-635`

### API Endpoints
- `GET /tasks` — list tasks (optional `?status=` filter)
- `POST /tasks` — create task (required: title, status, priority, createdBy)
- `GET /tasks/:id` — get single task
- `PATCH /tasks/:id` — update task fields
- `DELETE /tasks/:id` — delete task
- `GET /tasks/:id/audit` — get audit log for task
- `GET /tasks/:id/comments` — get comments
- `POST /tasks/:id/comments` — add comment (required: author, content)

### Agent Convention
When creating/updating tasks, always include:
- `actorType: "agent"`
- `actorId: "zappa"`
- `projectId` (required) — use the appropriate project ID:
  - CtrlAltAgnt: `kx7cp2zp6ha3y7f1g1fy6e9h5181rfks`
  - Zoidberg (OpenClaw instance): `kx7d7cqw7qpsgkdkzfcce4g0tn81r7eb`
  - Simply Sauna: `kx7apcfhbenk5sq1gxfw0j722n81r2g3`

## Simply Sauna

- **Repo:** `git@github.com:noahmilstein/simply-sauna-v3.git` (SSH: `github.com-simplysauna`, key: `~/.ssh/id_ed25519_simplysauna`, read-only deploy key named `zappa-read-only-simply-sauna-key`)
- **Stack:** Next.js (App Router) + Convex + Tailwind v4 + shadcn/ui + Stripe + Twilio + Mailgun + Google Maps
- **HQ:** Bedminster, NJ (07931), 60-mile service radius, NYC boroughs excluded
- **Pricing:** Day 1 = $650, additional days = $250/day; delivery ≤20mi free, 21-60mi $200
- **Business model:** Mobile sauna rentals (core) + sauna sales/install (quote-based)
- **Admin:** Auth-protected dashboard at `/admin` — reservations, calendar, CRM, leads, invoices, orders, blog, gallery, products, settings
- **CRM:** Built-in lightweight CRM with contacts, tags, smart lists, sequences, bulk sends, email templates, tasks, call logging (Vapi), Meta lead ads integration
- **Integrations:** Stripe (auth+capture), Twilio (SMS), Mailgun (email+bounces), Google Places, Meta Lead Ads, Vapi AI voice
- **Docs in repo:** `docs/PRD.md`, `docs/roadmap-*.md`, `docs/specs/feat_*.md`, `docs/design-style-guide.md`, `docs/THEME.md`
- **Local clone:** `/tmp/simply-sauna-v3` (shallow, refresh with git pull as needed)
