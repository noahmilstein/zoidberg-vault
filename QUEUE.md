# Queue Processor Instructions

When you receive a queue processing trigger, follow these steps exactly:

## Step 1: Check for in-progress work
```
GET https://polished-opossum-635.convex.site/tasks?status=in_progress
Authorization: Bearer <CAA_API_KEY from TOOLS.md>
```
If any tasks are in_progress, STOP. Do not start new work while something is running. Reply with: "Queue check: [N] tasks in progress. Skipping."

## Step 2: Find next backlog ticket
```
GET https://polished-opossum-635.convex.site/tasks?status=backlog
Authorization: Bearer <CAA_API_KEY from TOOLS.md>
```
Sort by priority (urgent > high > medium > low). Pick the first one.

If no backlog tickets exist, reply with: "Queue check: backlog empty. Nothing to process."

## Step 3: Check if ticket is self-executable
A ticket is self-executable if:
- It has a clear description of what to implement
- It does NOT require human input, credentials, or decisions
- It is NOT tagged with "needs-discussion" or "blocked"

If the ticket requires human input, skip it and try the next one. If all remaining tickets need input, reply with: "Queue check: [N] backlog tickets, all need human input."

## Step 4: Execute the ticket
1. Move the ticket to `in_progress` via PATCH
2. Read the ticket description and any linked spec files (resources field)
3. Determine model complexity:
   - Routine (file ops, config, simple CRUD): use default (gpt-5-mini)
   - Moderate (standard code gen, UI following patterns): use Sonnet
   - Complex (architecture, debugging, multi-step reasoning): use Opus
4. Spawn a sub-agent with the task, passing the spec file path for it to read directly
5. When sub-agent completes, move ticket to `done`
6. If sub-agent fails, move ticket to `blocked` with the error as blockedReason

## Step 5: Chain to next ticket
After completing a ticket, go back to Step 1 and repeat. Keep processing until the backlog is empty or all remaining tickets need human input.
