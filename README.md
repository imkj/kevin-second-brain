# Second Brain for Claude Code

> Turn Claude Code into your persistent AI partner — one that remembers, learns, and grows with you.

## What is this?

A framework that transforms Claude Code CLI from a stateless assistant into a **stateful AI second brain** with:

- **Persistent Memory** — remembers your preferences, projects, and lessons across conversations
- **Session Continuity** — picks up where you left off with full context
- **Multi-Channel Communication** — Telegram, LINE, and terminal
- **Self-Improvement** — learns from corrections and successes
- **Strategic Awareness** — tracks your goals, gaps, and priorities

## Architecture

```
second-brain/
├── scripts/
│   └── wakeup.sh                 # Session initialization
│
├── vault/                         # Your knowledge base (Obsidian-compatible)
│   ├── 00-Inbox/                  # Session logs & new items
│   ├── 02-SOPs/                   # Standard operating procedures
│   ├── 03-Projects/               # Active project docs
│   ├── 04-Resources/
│   │   └── Claude-Memory/         # AI memory system
│   │       ├── MEMORY.md          # Master index
│   │       ├── MEMORY-projects.md
│   │       ├── MEMORY-feedback.md
│   │       ├── MEMORY-references.md
│   │       └── MEMORY-user.md
│   ├── 06-Cortex/                 # AI state machine
│   │   ├── state/
│   │   │   ├── current.md         # Current session state
│   │   │   └── open-loops.md      # Things to track
│   │   └── strategic-loop.md      # Global priorities & gaps
│   └── CLAUDE.md                  # Boot protocol
│
├── daemon/                        # Background service (optional)
│   ├── server.js                  # Express server
│   ├── daemon.js                  # Claude CLI wrapper
│   └── ecosystem.config.js        # PM2 config
│
└── CLAUDE.md                      # Root-level boot protocol
```

## Core Concepts

### 1. Boot Protocol (`CLAUDE.md`)

Every conversation starts with an automatic initialization sequence:

```
1. Wakeup    → Gather context (time, state, memory, recent logs)
2. Deep Load → Read relevant memories based on task
3. Rules     → Apply learned behaviors and constraints
4. Session End → Update state, save memories, write session log
```

### 2. Memory System

Four types of memory, each serving a distinct purpose:

| Type | Purpose | Example |
|------|---------|---------|
| `user` | Who you are, preferences, expertise | "Senior backend engineer, new to React" |
| `feedback` | What to do / not do | "Always run tests before reporting done" |
| `project` | Active work context | "Migration deadline is March 5th" |
| `reference` | Where to find things | "API keys are in Vault, not .env files" |

Memories are stored as individual `.md` files with frontmatter:

```markdown
---
name: Always run tests first
description: Run test suite before reporting task completion
type: feedback
---

Run the full test suite before telling the user a task is complete.

**Why:** Previous incident where untested code broke production.
**How to apply:** After any code change, run tests and verify passing before reporting.
```

### 3. Cortex (State Machine)

The Cortex tracks the AI's operational state across sessions:

- **`current.md`** — What was the last session about? What's the current context?
- **`open-loops.md`** — Things mentioned but not resolved (the AI proactively follows up)
- **`strategic-loop.md`** — Big-picture health check: what's going well, what needs attention

### 4. Wakeup Script

A shell script that gathers all context needed to resume work:

```bash
#!/bin/bash
# Outputs: current time, machine info, cortex state,
# memory index, recent session log
```

### 5. Daemon (Optional)

A Node.js background service that:
- Keeps Claude CLI running as a persistent process
- Routes messages from Telegram/LINE to Claude
- Manages session continuity with `--resume`
- Queues concurrent requests

## Quick Start

### 1. Clone and customize

```bash
git clone https://github.com/poyuchen-travis/second-brain-template.git my-second-brain
cd my-second-brain
```

### 2. Edit the boot protocol

Open `CLAUDE.md` and customize:
- Your wakeup script path
- Your vault directory path
- Your behavior rules

### 3. Set up the vault

```bash
cd vault
# Edit 06-Cortex/state/current.md with your initial state
# Edit 04-Resources/Claude-Memory/MEMORY.md as empty index
```

### 4. Start using

```bash
claude  # Claude Code CLI will auto-read CLAUDE.md and boot up
```

## Memory Management

### Adding memories

The AI automatically saves memories when it learns something new. You can also explicitly say:
- "Remember that I prefer TypeScript over JavaScript"
- "Save this: deploy to UAT before production"

### Memory index

`MEMORY.md` is the master index — always loaded into context. Keep it under 200 lines. Each entry links to a detailed memory file.

### Memory hygiene

- Memories that contradict current code should be updated or removed
- Don't duplicate what's already in the codebase
- Convert relative dates to absolute dates when saving

## Multi-Channel Setup (Optional)

### Telegram

Uses the Claude Code Telegram plugin:
1. Create a Telegram bot via @BotFather
2. Configure the plugin with your bot token
3. The AI can now receive and reply to Telegram messages

### LINE Bot

Uses the daemon service:
1. Create a LINE Messaging API channel
2. Configure webhook URL pointing to your daemon
3. The daemon routes LINE messages to Claude

## Design Principles

1. **Don't ask, find it** — The AI checks memory and files before asking you
2. **QA your own work** — Verify before reporting done
3. **Small changes fast, big changes planned** — Quick tasks execute immediately; complex tasks get a plan first
4. **Secrets never in public repos** — Credentials stay in memory references, not code
5. **Time is truth** — Always verify dates with system commands, never assume

## File Naming Conventions

| Type | Pattern | Example |
|------|---------|---------|
| Project memory | `project_{name}.md` | `project_website_redesign.md` |
| Feedback memory | `feedback_{topic}.md` | `feedback_always_test_first.md` |
| Reference memory | `reference_{system}.md` | `reference_aws_credentials.md` |
| User memory | `user_{aspect}.md` | `user_communication_style.md` |
| Session log | `YYYY-MM-DD-session-log.md` | `2026-06-12-session-log.md` |
| Cortex state | `{state-name}.md` | `current.md`, `open-loops.md` |

## What's NOT included

This template intentionally excludes:
- Emotional intelligence modules (proprietary)
- Personal memory content
- API keys and credentials
- Specific project data

## License

MIT — Use it, modify it, make it yours.

## Credits

Built by [Travis Chen](https://www.instagram.com/travis.ai.engineer/) — AI Engineer, building tools that make AI actually useful.
