---
name: morning-standup
description: >
  Generate a daily standup summary from recent session logs and open loops.
  Trigger: user says "standup", "daily update", "morning briefing",
  "what's on my plate"
---

# Morning Standup

Generate a concise daily standup from existing data. No questions needed.

## Step 1: Get current time

```bash
node -e "console.log(new Date().toLocaleString('sv-SE',{timeZone:'YOUR_TIMEZONE'}))"
```

## Step 2: Read recent activity

Read the most recent session log from `vault/00-Inbox/`.

## Step 3: Read open loops

Read `vault/06-Cortex/state/open-loops.md` for tracked items.

## Step 4: Read strategic loop

Read `vault/06-Cortex/strategic-loop.md` for priorities.

## Step 5: Generate standup

Output format:

```
Good morning! Here's your standup for {date}:

**Yesterday:**
- [Key items from last session log]

**Today — Priorities:**
- [From open loops + strategic loop, ordered by priority]

**Blockers:**
- [High-priority open loops that are stuck]

**Heads up:**
- [Items approaching deadlines or needing attention]
```

Keep it concise — no more than 15 lines total.
