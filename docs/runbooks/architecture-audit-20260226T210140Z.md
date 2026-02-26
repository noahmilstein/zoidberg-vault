# Architecture Audit & Deduplication

Date (UTC): 20260226T210140Z

## Scope
- Root policy files in `/root/.openclaw/workspace`
- Duplicate policy tree in `workspace-supervisor/`
- Nested `workspace/` directory

## Findings
1. Duplicate control-plane directories existed (`workspace-supervisor/`, nested `workspace/`) inside active workspace.
2. Root policy set already contained the canonical operating rules.
3. Supervisor tree mostly contained templates/empty files; no higher-quality operational rules than root files.

## Keep / Merge / Drop Matrix

| Source file | Decision | Reason |
|---|---|---|
| `SOUL.md` (root) | KEEP | Active persona + boundaries + continuity; richer than supervisor version |
| `workspace-supervisor/SOUL.md` | MERGE (partial) | Governance emphasis reviewed; no net-new required beyond existing root guidance |
| `MEMORY.md` (root) | KEEP (future trim recommended) | Canonical durable memory; currently overloaded but active |
| `workspace-supervisor/MEMORY.md` | DROP | Only “clean slate”; no durable value |
| `TOOLS.md` (root) | KEEP | Environment-specific operational data |
| `workspace-supervisor/TOOLS.md` | DROP | Generic template; no environment specifics |
| `HEARTBEAT.md` (root) | KEEP | Canonical heartbeat policy |
| `workspace-supervisor/HEARTBEAT.md` | DROP | Duplicate of root intent |
| `IDENTITY.md` (root) | KEEP | Populated identity |
| `workspace-supervisor/IDENTITY.md` | DROP | Unfilled template |
| `workspace-supervisor/AGENTS.md` | DROP | Empty |
| `workspace-supervisor/USER.md` | DROP | Empty |
| `workspace-supervisor/STATE.md` | DROP | Empty |
| `workspace-supervisor/TASKS.md` | DROP | Empty |

## Actions Executed
1. Archived duplicate directories to `archive/20260226T210140Z/`:
   - `archive/20260226T210140Z/workspace-supervisor`
   - `archive/20260226T210140Z/workspace-nested`
2. Captured pre-cleanup markdown inventory:
   - `archive/20260226T210140Z/md-inventory-before.txt`

## Post-cleanup Source of Truth
- `AGENTS.md`
- `SOUL.md`
- `USER.md`
- `MEMORY.md`
- `BOOTSTRAP.md`
- `WORKFLOW_AUTO.md`
- `HEARTBEAT.md`
- `TOOLS.md`
- `IDENTITY.md`

## Recommended Next Pass (not yet executed)
1. Trim `MEMORY.md` to durable facts and move incident-heavy operational directives into dated memory notes.
2. Reduce protocol duplication across `BOOTSTRAP.md` + `WORKFLOW_AUTO.md` by making one authoritative and one pointer.
3. Keep one outbound integration directory (`zoidberg_outbound`) only if actively used; otherwise archive.
