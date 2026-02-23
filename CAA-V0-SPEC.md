# CtrlAltAgnt (CAA) — V0 Spec

**Status:** DRAFT — awaiting Noah's approval before implementation.

---

## 1. What It Is

A mission control dashboard for OpenClaw agents. Tracks tasks, status, and agent activity. API-first, with Slack as the notification/comms layer.

Think: bespoke ticketing system built for agent-driven workflows.

## 2. V0 Scope (Ruthlessly Minimal)

### In Scope
- **Tasks** — create, view, update, close
- **Task fields:** title, description, status, priority, assignee, Slack thread link, timestamps (created, updated)
- **Status flow:** `backlog` → `in_progress` → `done` (plus `blocked`)
- **Priority:** `low` | `medium` | `high` | `urgent`
- **Assignee:** agent name or human name (string for now, no user system yet)
- **Web UI:** list/board view of tasks, detail view, create/edit form
- **Agent API:** Convex HTTP actions for CRUD — agents interact directly
- **Slack notifications:** post to a designated channel when tasks are created, move status, or are completed

### Out of Scope (future iterations)
- Cron job tracking/management
- Agent performance metrics / activity logs
- Multi-workspace / multi-team
- Full auth system (OAuth, RBAC)
- Comments / conversation threads on tasks
- File attachments
- Search / filtering beyond basic status filter
- Custom fields

## 3. Data Model (Convex Schema)

```typescript
// convex/schema.ts
import { defineSchema, defineTable } from "convex/server";
import { v } from "convex/values";

export default defineSchema({
  tasks: defineTable({
    title: v.string(),
    description: v.optional(v.string()),
    status: v.union(
      v.literal("backlog"),
      v.literal("in_progress"),
      v.literal("done"),
      v.literal("blocked")
    ),
    priority: v.union(
      v.literal("low"),
      v.literal("medium"),
      v.literal("high"),
      v.literal("urgent")
    ),
    assignee: v.optional(v.string()),
    slackThreadUrl: v.optional(v.string()),
    createdBy: v.string(),
    completedAt: v.optional(v.number()),
  })
    .index("by_status", ["status"])
    .index("by_assignee", ["assignee"])
    .index("by_priority", ["priority"]),
});
```

Convex auto-provides `_id` and `_creationTime`. `completedAt` is set when status → `done`.

## 4. API Surface (Convex HTTP Actions)

All endpoints live at the HTTP actions URL. Auth via a shared API key in the `Authorization` header for v0.

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| POST | `/tasks` | Create a task |
| GET | `/tasks` | List tasks (optional `?status=` filter) |
| GET | `/tasks/:id` | Get single task |
| PATCH | `/tasks/:id` | Update task fields |
| DELETE | `/tasks/:id` | Delete a task |

### Example: Create Task
```json
POST /tasks
Authorization: Bearer <API_KEY>
Content-Type: application/json

{
  "title": "Set up CAA repo",
  "description": "Initialize Next.js project with Convex",
  "status": "backlog",
  "priority": "high",
  "assignee": "Zappa",
  "createdBy": "Noah"
}
```

### Example: Update Status
```json
PATCH /tasks/<id>
Authorization: Bearer <API_KEY>
Content-Type: application/json

{
  "status": "in_progress"
}
```

## 5. Slack Integration

### Notifications (Slack → Channel)
A designated Slack channel (e.g., `#caa-feed` or existing DM) receives notifications when:
- Task created → "🆕 **Task created:** [title] — assigned to [assignee] (priority: [priority])"
- Status changed → "🔄 **Status update:** [title] moved to [new_status]"
- Task completed → "✅ **Done:** [title]"

### Implementation
Convex action calls Slack's `chat.postMessage` via the existing bot token. No new Slack app needed — we use Zappa's existing bot credentials.

**Slack manifest changes needed:** None for v0. The current scopes (`chat:write`, `channels:history`) are sufficient. If we want slash commands later, we add those then.

## 6. Web UI (Next.js)

### Pages
- `/` — Board view: columns for each status, tasks as cards. Drag-and-drop is a nice-to-have, not v0.
- `/tasks/[id]` — Task detail/edit page

### Stack
- Next.js 15 (App Router)
- Convex React client (real-time subscriptions)
- Tailwind CSS
- No component library — keep it lean. Raw Tailwind.

### Design
- Dark theme (matches the agent/dev aesthetic)
- Minimal chrome. Dense information display.
- Mobile-responsive but desktop-first.

## 7. Tech Stack Summary

| Layer | Tool |
|-------|------|
| Database + API | Convex |
| Frontend | Next.js 15 (App Router) |
| Styling | Tailwind CSS |
| Hosting | Vercel |
| Comms | Slack (existing Zappa bot) |
| Repo | github.com/noahmilstein/ctrlaltagnt |

## 8. Implementation Plan

### Phase 1 — Scaffold (Codex task)
1. Init Next.js project with Convex + Tailwind
2. Define Convex schema
3. Implement Convex functions (mutations, queries)
4. Push to GitHub

### Phase 2 — API Layer (Codex task)
1. Implement HTTP actions (REST endpoints)
2. Add API key auth middleware
3. Test endpoints

### Phase 3 — Web UI (Codex task)
1. Board view (task list by status columns)
2. Task detail/edit page
3. Create task form

### Phase 4 — Slack Integration (Codex task)
1. Convex action to post Slack notifications
2. Wire into mutation hooks (task create, status change, complete)

### Phase 5 — Deploy & Connect
1. Noah creates Vercel project
2. Deploy
3. Zappa gets API key, starts using it for task management

## 9. Open Questions

1. **Slack channel for notifications** — Dedicated `#caa-feed` channel, or post to our existing DM?
2. **API key provisioning** — I'll need a Convex deploy key and we'll need to set a shared API secret as a Convex environment variable for the HTTP auth. Ready to set those up when we start Phase 2.
3. **Codex routing** — I can only spawn sub-agents as `main` (no dedicated Codex agent configured). We should set up a Codex agent in OpenClaw config, or I can write detailed implementation specs and you run Codex separately. Your call on workflow.

---

**Next step:** Noah reviews and approves this spec. Then we build.
