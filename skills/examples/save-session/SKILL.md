---
name: save-session
description: >
  Save session progress. Auto-summarize what was done, errors encountered,
  decisions made, and remaining TODOs. Writes to Obsidian inbox + updates
  Cortex state.
  Trigger: user says "save session", "save progress", "log this session",
  "record what we did"
---

# Save Session

When triggered, execute the full save workflow without asking questions.

## Step 1: Get current time

```bash
node -e "console.log(new Date().toLocaleString('sv-SE',{timeZone:'Asia/Taipei'}))"
```

Use the output date as the filename prefix (format `YYYY-MM-DD`).

## Step 2: Summarize session content

Review the entire conversation and organize into four categories:

1. **Completed tasks** — Everything that was finished, with technical details
2. **Errors & lessons** — Errors encountered, how they were fixed (most valuable learning material)
3. **Decisions & discoveries** — Important decisions made, new information discovered
4. **TODOs** — Unfinished work, things to continue next time

## Step 3: Write session log

Write to `vault/00-Inbox/{date}-session-log.md`:

```markdown
---
tags: [session-log, daily]
date: {date}
---

# {date} Session Log

## Completed Tasks
- ...

## Errors & Lessons
- ...

## Decisions & Discoveries
- ...

## TODOs
- ...
```

## Step 4: Update Cortex state

Update `vault/06-Cortex/state/current.md`:
- Current mode/context
- Last session summary
- Active projects

## Step 5: Update open loops

Update `vault/06-Cortex/state/open-loops.md`:
- Add new items mentioned but not resolved
- Mark completed items
- Update status of existing items

## Step 6: Save new memories

If anything was learned that should persist across sessions:
- Create new memory files in `vault/04-Resources/Claude-Memory/`
- Update the relevant sub-index
