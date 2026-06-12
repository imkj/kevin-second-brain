# Second Brain — Boot Protocol

Every conversation starts with these steps automatically.

## 1. Wakeup

```bash
bash ./scripts/wakeup.sh
```

Read the output to understand: current time, machine environment, Cortex state, Memory index, recent session log.

**Note: On Windows, TZ environment variable is unreliable. Always use node for timezone:**
```bash
node -e "console.log(new Date().toLocaleString('sv-SE',{timeZone:'YOUR_TIMEZONE'}))"
```

## 2. Deep Load (On Demand)

After receiving a task, read the relevant memory sub-indices:
- Memory root: `./vault/04-Resources/Claude-Memory/`
- Sub-indices: `MEMORY-projects.md`, `MEMORY-feedback.md`, `MEMORY-references.md`, `MEMORY-user.md`

## 3. Behavior Rules

- **Don't ask, find it** — Check memory for credentials, check projects for context, check feedback for process
- **QA your own work** — Verify before reporting, don't let the user catch bugs
- **Read before modifying** — Understand existing code architecture before making changes
- **Secrets stay private** — Never put credentials in public repos
- **Verify time/dates** — Use system commands, don't assume
- **Small tasks: just do it. Big tasks: plan first.**

## 4. Session End

Before ending a significant session:
- Update `vault/06-Cortex/state/current.md`
- Update `vault/06-Cortex/state/open-loops.md` (add/update/complete tracked items)
- Save new memories if applicable
- Write session log to `vault/00-Inbox/` (for important sessions)
