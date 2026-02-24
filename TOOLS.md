# TOOLS.md - Local Notes

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
- **API Key:** `5c34492531f38e471c1ffb89159ebbd1daf1203f2fc0eaf3ca50422eea19367a`
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
  - OpenClaw: `kx7d7cqw7qpsgkdkzfcce4g0tn81r7eb`
