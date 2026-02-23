# Runbook: HTTP 401 Diagnosis

When you see `HTTP 401` or `User not found` errors, there are TWO independent auth layers that can cause this. Test them separately.

## Layer 1: Provider API Key (OpenRouter)

**Symptom:** Agent requests fail with 401 at the provider level.

**Test:**
```bash
curl -s -o /dev/null -w '%{http_code}' \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  https://openrouter.ai/api/v1/models
```

- **200** → Key is valid. Problem is elsewhere.
- **401** → Key is invalid/expired. Replace it.

**Fix:**
1. Generate a new key at https://openrouter.ai/settings/keys
2. Update `~/.openclaw/agents/main/agent/auth-profiles.json` with the new key
3. Also update `env.OPENROUTER_API_KEY` in `~/.openclaw/openclaw.json` if set there
4. Restart gateway: `systemctl --user restart openclaw-gateway`

## Layer 2: Gateway Device Pairing

**Symptom:** TUI/client connects to gateway but gets 401 before any provider call is made.

**Test:**
```bash
openclaw gateway status
openclaw devices list
```

If status is OK but TUI still gets 401, the device token/pairing is stale.

**Fix:**
1. Remove stale device: `openclaw devices rm <device-id>`
2. Reconnect TUI — it will prompt for re-pairing
3. Approve the new device: `openclaw devices approve <device-id>`

## Key Insight

These two layers are independent. A provider key failure and a device pairing failure produce the SAME error message (`HTTP 401: User not found`). Always test both layers separately before escalating to a full reset.

## Nuclear Option (last resort)

If both layers check out and 401 persists:
1. Back up workspace: `cd ~/.openclaw/workspace && git add -A && git commit -m "pre-nuke backup" && git push`
2. Reinstall OpenClaw
3. Re-onboard
4. Restore workspace from git
5. Restore cron jobs from backup or re-create
