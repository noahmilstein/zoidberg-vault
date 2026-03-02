# TOOLS.md - Local Ops Notes (Zoidberg)

## Purpose
Operational reference for this host + connected systems.

## Not this file's job
- Not an authoritative list of OpenClaw runtime tool permissions.
- Not a replacement for system prompt/tool policy.
- Not a place for raw secrets.

## Secrets Storage (Canonical)
- SSH private keys: `~/.ssh/` with `chmod 600`
- Runtime API secrets: environment variables / secret store only
- Docs/config: env placeholders only (e.g., `${ENV_OPENROUTER_API_KEY}`)
- Never commit raw tokens/keys

## Host
- Hostname: `zoidberg-crab-shell`
- OS: Ubuntu 24.04.3 LTS (x86_64)
- Node: v22.22.0
- OpenClaw: running as systemd user service

## Git Repos + Access

### 1) Zoidberg Vault (workspace)
- Local: `/root/.openclaw/workspace`
- Remote: `git@github.com:noahmilstein/zoidberg-vault.git`
- Access: SSH key `~/.ssh/id_ed25519`

### 2) CtrlAltAgnt
- Local: (not guaranteed cloned in workspace; use API as primary SoR)
- Remote: `git@github.com-caa:noahmilstein/ctrlaltagnt.git`
- Access: SSH key `~/.ssh/id_ed25519_caa`
- App URL: `https://ctrlaltagnt.vercel.app`
- API Base: `https://polished-opossum-635.convex.site`

### 3) Simply Sauna v3
- Local: `/tmp/simply-sauna-v3`
- Remote: `git@github.com-simplysauna:noahmilstein/simply-sauna-v3.git`
- Access: SSH key `~/.ssh/id_ed25519_simplysauna` (read-only deploy key)

### 4) Virtual Staging v2
- Local: `/tmp/virtual-staging-v2`
- Remote: `git@github.com:noahmilstein/virtual-staging-v2.git`
- Access: host default SSH key unless overridden

## External Systems in Use
- CAA / Convex (task SoR)
- Slack (primary operator surface)
- Instantly (listing-stager campaign execution surface)

## CAA API Endpoints (reference)
- `GET /tasks`
- `POST /tasks`
- `GET /tasks/:id`
- `PATCH /tasks/:id`
- `DELETE /tasks/:id`
- `GET /tasks/:id/audit`
- `GET /tasks/:id/comments`
- `POST /tasks/:id/comments`

## Agent Convention for CAA writes
- `actorType: "agent"`
- `actorId: "zappa"`
- `projectId` required:
  - CtrlAltAgnt: `kx7cp2zp6ha3y7f1g1fy6e9h5181rfks`
  - Zoidberg: `kx7d7cqw7qpsgkdkzfcce4g0tn81r7eb`
  - Simply Sauna: `kx7apcfhbenk5sq1gxfw0j722n81r2g3`

## Maintenance expectation
During internal audits, this file must be checked for:
- stale repo/access records
- stale system URLs
- missing key connected systems
- secret hygiene violations
