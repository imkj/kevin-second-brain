# Skills System — Deep Dive

## What are Skills?

Skills are reusable instruction modules that extend your AI's capabilities. Think of them as "muscle memory" — specialized knowledge and workflows the AI can activate on demand.

Each skill is a Markdown file (`SKILL.md`) that teaches the AI how to handle a specific type of task.

## How Skills Work

```
User says trigger phrase (e.g., "save session")
    │
    ▼
Claude Code matches it to a skill
    │
    ▼
SKILL.md instructions are loaded into context
    │
    ▼
AI executes the skill's workflow
```

## Skill Structure

```
skills/
├── save-session/
│   └── SKILL.md          # Session logging skill
├── deploy/
│   ├── SKILL.md          # Deployment workflow
│   └── scripts/
│       └── deploy.sh     # Supporting scripts
├── qa-runner/
│   ├── SKILL.md          # QA automation
│   └── scripts/
│       ├── test_api.py
│       └── config.py
└── content-writer/
    └── SKILL.md           # Content creation
```

## SKILL.md Format

```markdown
---
name: skill-name
description: >
  One paragraph description. Include trigger phrases so Claude Code
  knows when to activate this skill.
  Trigger: user says "deploy", "push to production", "ship it"
---

# Skill Title

Instructions for the AI when this skill is activated.

## Step 1: Do something
Detailed instructions...

## Step 2: Do something else
More instructions...

## Rules
- Always do X
- Never do Y
```

## Skill Categories

### Workflow Skills
Automate multi-step processes:
- **save-session** — Auto-save session progress to Obsidian + update Cortex
- **deploy** — Build, test, deploy with environment-specific steps
- **code-review** — Structured review checklist

### Knowledge Skills
Domain-specific expertise:
- **backend-engineer** — Node.js/Python patterns, DB best practices
- **qa-runner** — Test automation, coverage analysis
- **seo-optimizer** — SEO analysis and fixes

### Training Skills
Interactive learning modules:
- **frontend-trainer** — Teach backend devs to read frontend code
- **architecture-trainer** — System design exercises
- **data-analysis-trainer** — Data interpretation skills

### Creative Skills
Content and design:
- **content-writer** — Blog posts, social media, marketing copy
- **presentation-maker** — Generate slide decks
- **brand-voice** — Maintain consistent brand tone

## Writing Good Skills

### 1. Clear Triggers
```markdown
description: >
  Deploy to production. Trigger: user says "deploy",
  "push to prod", "ship it", "上線", "部署"
```

### 2. Step-by-Step Instructions
Don't be vague. Write exactly what the AI should do:

```markdown
## Step 1: Run tests
Run the full test suite:
\`\`\`bash
npm test
\`\`\`
If any test fails, STOP and report the failure. Do NOT proceed.

## Step 2: Build
\`\`\`bash
npm run build
\`\`\`
Check for TypeScript errors. Zero errors required.
```

### 3. Include Guardrails
Tell the AI what NOT to do:

```markdown
## Rules
- NEVER deploy to production without running tests first
- NEVER skip the staging environment
- If the build fails, do NOT retry silently — report the error
```

### 4. Support Scripts
For complex skills, include helper scripts:

```
skills/qa-runner/
├── SKILL.md
└── scripts/
    ├── test_api.py      # API test suite
    ├── test_stats.py    # Statistical validation
    └── config.py        # Test configuration
```

Reference them in SKILL.md:
```markdown
Run the QA suite:
\`\`\`bash
python skills/qa-runner/scripts/test_api.py
\`\`\`
```

## Skill Composition

Skills can reference other skills:
```markdown
After deployment is complete, run the `/save-session` skill
to log what was deployed.
```

## Installing Skills

### Claude Code CLI
Place skill folders in `~/.claude/skills/`:
```bash
cp -r skills/save-session ~/.claude/skills/
```

### Project-level Skills
Place in `.claude/skills/` within your project:
```bash
cp -r skills/save-session .claude/skills/
```

Project-level skills override global skills with the same name.

## Example: Minimal Skill

```markdown
---
name: morning-standup
description: >
  Generate a daily standup summary. Trigger: user says
  "standup", "daily update", "what did I do yesterday"
---

# Morning Standup

## Step 1: Check recent activity
Read the last session log from `vault/00-Inbox/`.

## Step 2: Check open loops
Read `vault/06-Cortex/state/open-loops.md`.

## Step 3: Generate standup
Format:
- **Yesterday:** [from session log]
- **Today:** [from open loops + user input]
- **Blockers:** [from open loops, high priority items]
```
