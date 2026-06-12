# Second Brain — Boot Protocol

> This file is automatically loaded by Claude Code at the start of every conversation.
> It tells the AI how to initialize, where to find things, and how to behave.

Every conversation starts with these steps automatically. No user action needed.

## 1. Wakeup

```bash
bash ./scripts/wakeup.sh
```

Read the output to understand:
- **Current time** (your timezone)
- **Machine environment** (which computer, which user)
- **Cortex state** (what happened last session, what mode you're in)
- **Memory index** (what the AI knows about you, your projects, your rules)
- **Open loops** (things mentioned but not resolved — follow up proactively)
- **Strategic loop** (big-picture priorities and gaps)
- **Last session log** (what was done most recently)

**Note: On Windows, TZ environment variable is unreliable. Always use node for timezone:**
```bash
node -e "console.log(new Date().toLocaleString('sv-SE',{timeZone:'YOUR_TIMEZONE'}))"
```

## 2. Deep Load (On Demand)

After receiving a task, read the relevant memory sub-indices based on the topic:

- **Memory root:** `./vault/04-Resources/Claude-Memory/`
- **Sub-indices:**
  - `MEMORY-user.md` — Who you are, preferences, expertise
  - `MEMORY-projects.md` — Active projects, deadlines, stakeholders
  - `MEMORY-feedback.md` — Learned rules: what to do, what to avoid
  - `MEMORY-references.md` — Where to find credentials, servers, tools

## 3. Vault Structure

Know where everything lives:

| Directory | Purpose |
|-----------|---------|
| `vault/00-Inbox/` | Session logs, new items to process |
| `vault/02-SOPs/` | Standard operating procedures, runbooks |
| `vault/03-Projects/` | Active project documentation |
| `vault/04-Resources/Claude-Memory/` | AI memory system (4 types: user, feedback, project, reference) |
| `vault/05-Archive/` | Completed or paused items |
| `vault/06-Cortex/state/` | AI state machine (current.md, open-loops.md) |
| `vault/06-Cortex/strategic-loop.md` | Global priorities, health dashboard, gap analysis |
| `vault/06-Cortex/logs/` | Monthly Cortex evolution logs |

## 4. Skills System

Skills are reusable instruction modules in `skills/`. Each skill has a `SKILL.md` that teaches the AI a specific workflow.

- Skills activate when the user says a trigger phrase (defined in each SKILL.md)
- Each skill contains step-by-step instructions the AI follows
- Skills can include supporting scripts in a `scripts/` subfolder
- See `docs/skills-system.md` for how to write new skills

**Built-in examples:**
- `save-session` — Auto-save session progress to Obsidian + update Cortex state
- `morning-standup` — Generate daily standup from recent logs + open loops

## 5. Behavior Rules

- **Don't ask, find it** — Check memory for credentials, check projects for context, check feedback for process. Don't ask the user for things you can look up.
- **QA your own work** — Verify before reporting. Run tests, check the result, confirm it works. Don't let the user catch your bugs.
- **Read before modifying** — Understand existing code architecture before making changes. Don't blindly edit files.
- **Secrets stay private** — Never put credentials in public repos. Store them in memory references.
- **Verify time/dates** — Use system commands to get the current time. Don't assume or guess dates.
- **Small tasks: just do it. Big tasks: plan first.** — Simple changes execute immediately. Complex work gets a plan before implementation.

## 6. Session End

Before ending a significant session, update state so the next session can pick up:

1. **Update Cortex state** — `vault/06-Cortex/state/current.md`
   - What was this session about?
   - What's the current mode/context?
   - What are the active projects?

2. **Update open loops** — `vault/06-Cortex/state/open-loops.md`
   - Add new items that were mentioned but not resolved
   - Mark completed items as done
   - Update status of existing items

3. **Save new memories** (if applicable)
   - Create memory files in `vault/04-Resources/Claude-Memory/`
   - Add entries to the relevant sub-index (MEMORY-*.md)
   - Update the main index (MEMORY.md) if needed

4. **Write session log** — `vault/00-Inbox/{date}-session-log.md`
   - What was completed
   - Errors and lessons learned
   - Decisions made
   - Remaining TODOs
