# Memory System — Deep Dive

## How Memory Works

The memory system gives Claude persistent knowledge across conversations. Without it, every conversation starts from zero. With it, Claude remembers your preferences, learns from mistakes, and understands your projects.

## Memory Flow

```
Conversation
    │
    ├── Claude learns something new
    │       │
    │       ▼
    │   Save memory file (e.g., feedback_no_mocks.md)
    │       │
    │       ▼
    │   Add entry to MEMORY.md index
    │
    ├── Claude needs context
    │       │
    │       ▼
    │   Read MEMORY.md (always loaded)
    │       │
    │       ▼
    │   Read relevant sub-index (e.g., MEMORY-feedback.md)
    │       │
    │       ▼
    │   Read specific memory files as needed
    │
    └── Session ends
            │
            ▼
        Update/create memories based on what was learned
```

## Writing Good Memories

### User Memories
**Good:** "Senior Go developer, 10 years experience, new to React — frame frontend concepts using backend analogies"
**Bad:** "Uses Go" (too vague to be actionable)

### Feedback Memories
**Good:** "Integration tests must hit a real database, not mocks. **Why:** Last quarter, mocked tests passed but prod migration failed. **How to apply:** Any test file that touches the DB layer."
**Bad:** "Don't use mocks" (no context for when/why)

### Project Memories
**Good:** "Auth middleware rewrite driven by legal/compliance (session token storage). **Why:** Legal flagged it, not tech debt. **How to apply:** Scope decisions should favor compliance over ergonomics."
**Bad:** "Working on auth" (no actionable context)

### Reference Memories
**Good:** "Pipeline bugs tracked in Linear project 'INGEST'. When opening a bug, check INGEST first."
**Bad:** "We use Linear" (doesn't help locate anything specific)

## What NOT to Save

| Don't Save | Why | Alternative |
|-----------|-----|-------------|
| Code patterns | They change; read the code | `grep` / `read` the file |
| Git history | `git log` is authoritative | Use git commands |
| Fix recipes | The fix is in the code | Read the commit |
| File paths | They change | Use glob/grep to find |
| Temporary state | Only useful now | Use tasks or plans |

## Index Management

`MEMORY.md` is the master index. Rules:
- Always loaded into context (every conversation)
- Keep under 200 lines
- Each entry: `- [Title](file.md) — one-line description`
- Organize by topic, not chronology
- Critical items at the top

## Memory Hygiene Checklist

- [ ] Remove memories that contradict current code
- [ ] Update project memories when milestones are hit
- [ ] Convert relative dates to absolute dates
- [ ] Merge duplicate memories
- [ ] Archive completed project memories
- [ ] Verify reference memories still point to valid resources
