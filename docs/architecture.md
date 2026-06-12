# Second Brain — Technical Architecture

## System Overview

```
┌─────────────────────────────────────────────────────┐
│                    User (You)                        │
│                                                     │
│   Terminal    Telegram    LINE     Web               │
│      │           │         │       │                │
│      └───────────┼─────────┼───────┘                │
│                  │         │                        │
│            ┌─────▼─────────▼──────┐                 │
│            │   Daemon (optional)   │                 │
│            │   - Message routing   │                 │
│            │   - Session mgmt     │                 │
│            │   - Queue            │                 │
│            └──────────┬───────────┘                 │
│                       │                             │
│              ┌────────▼────────┐                    │
│              │  Claude Code CLI │                    │
│              │  + CLAUDE.md     │                    │
│              └────────┬────────┘                    │
│                       │                             │
│         ┌─────────────┼──────────────┐              │
│         │             │              │              │
│    ┌────▼───┐   ┌─────▼────┐  ┌─────▼─────┐       │
│    │ Memory │   │  Cortex  │  │  Scripts   │       │
│    │ System │   │  (State) │  │ (Wakeup)   │       │
│    └────────┘   └──────────┘  └───────────┘        │
│                                                     │
└─────────────────────────────────────────────────────┘
```

## Component Details

### 1. Boot Protocol (`CLAUDE.md`)

The entry point. Claude Code automatically reads this file at conversation start.

**Lifecycle:**
```
Session Start
    │
    ▼
[1] Wakeup ─── Run wakeup.sh ─── Gather context
    │
    ▼
[2] Deep Load ── Read memories relevant to task
    │
    ▼
[3] Apply Rules ── Inject feedback memories as behavior constraints
    │
    ▼
[4] Work ──────── Execute user's requests
    │
    ▼
[5] Session End ── Update state ── Save memories ── Write log
```

### 2. Memory System

**Storage:** Individual Markdown files with YAML frontmatter.

**Index:** `MEMORY.md` (always loaded) -> Sub-indices -> Individual files.

**Memory Types:**

| Type | Volatility | Example |
|------|-----------|---------|
| `user` | Low (rarely changes) | "Prefers TypeScript, 10 years experience" |
| `feedback` | Medium (grows over time) | "Don't mock databases in integration tests" |
| `project` | High (changes weekly) | "Sprint 4 ends Friday, 3 tasks remaining" |
| `reference` | Low (infra changes slowly) | "Prod DB at db.example.com:5432" |

**File Structure:**
```markdown
---
name: Descriptive title
description: One-line summary (used for relevance matching)
type: user|feedback|project|reference
---

Main content here.

**Why:** Context for why this matters.
**How to apply:** When and where to use this knowledge.
```

**Memory Lifecycle:**
```
Observation → Save → Index → Recall → Verify → Apply
                                         │
                                    (outdated?) → Update/Remove
```

### 3. Cortex (State Machine)

Three files track the AI's awareness:

**`current.md`** — Session continuity
- Last session summary
- Active projects
- Current mode/context

**`open-loops.md`** — Proactive follow-up
- Items the user mentioned but didn't resolve
- Weighted by importance
- AI asks about these when relevant

**`strategic-loop.md`** — Big picture
- Health dashboard across all areas
- Gap analysis: what's working vs. what needs attention
- Updated after milestones

### 4. Wakeup Script

**Input:** None (reads filesystem)

**Output:** Structured text with sections:
- `=== WAKEUP [timestamp] ===`
- `=== CORTEX STATE ===`
- `=== MEMORY INDEX ===`
- `=== OPEN LOOPS ===`
- `=== STRATEGIC LOOP ===`
- `=== LAST SESSION LOG ===`
- `=== WAKEUP COMPLETE ===`

**Design decisions:**
- Uses `node` for timezone (Windows `TZ` is unreliable)
- Outputs plain text (Claude parses it)
- Runs in < 1 second
- No external dependencies beyond Node.js

### 5. Daemon (Optional)

A Node.js service for multi-channel communication.

**Components:**
- **Express server** — Receives webhooks (LINE, Telegram)
- **Claude CLI wrapper** — Spawns and manages Claude processes
- **Session manager** — Maps external users to Claude sessions
- **Message queue** — Debounces rapid messages (3s merge window)

**Message Flow:**
```
External Message (LINE/Telegram)
    │
    ▼
Daemon receives webhook
    │
    ▼
Route to correct brain (owner vs. customer)
    │
    ▼
Queue message (debounce 3s)
    │
    ▼
Send to Claude CLI (--resume sessionId)
    │
    ▼
Claude processes + responds
    │
    ▼
Daemon sends reply back to channel
```

## Design Principles

### 1. Lazy Loading
Don't load all memories at startup. Load the master index, then deep-load only what's relevant to the current task.

### 2. Verify Before Trust
Memories are point-in-time observations. Always verify against current code/state before acting on a memory.

### 3. Separation of Concerns
- **Memory** = long-term knowledge (persists across sessions)
- **Cortex state** = session continuity (what happened recently)
- **Session logs** = audit trail (what was done and why)

### 4. Graceful Degradation
If wakeup.sh fails, Claude still works — just without context. Each component is optional.

### 5. Human Readable
Everything is Markdown. No databases, no binary formats. You can read, edit, and version-control everything with standard tools.

## Scaling Considerations

### Memory Growth
- Keep `MEMORY.md` under 200 lines (it's always loaded)
- Archive stale project memories
- Feedback memories are cumulative — they grow and that's OK

### Multi-Machine
- The vault can be synced via Git, Syncthing, or cloud storage
- Wakeup script auto-detects which machine it's on
- Machine-specific configs go in memory references

### Multi-Brain
- One vault per "brain" (personal, work, client-facing)
- Daemon routes to the correct brain based on message source
- Each brain has its own CLAUDE.md and memory set
