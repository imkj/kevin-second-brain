#!/bin/bash
# Second Brain — Wakeup Script
# Gathers all context needed to resume work.
# Called automatically by CLAUDE.md at the start of each session.

# --- Config ---
VAULT_DIR="$(dirname "$0")/../vault"
CORTEX_DIR="$VAULT_DIR/06-Cortex"
MEMORY_DIR="$VAULT_DIR/04-Resources/Claude-Memory"
INBOX_DIR="$VAULT_DIR/00-Inbox"

# --- Timezone (customize this) ---
TIMEZONE="Asia/Taipei"

# --- Header ---
CURRENT_TIME=$(node -e "
  const d = new Date();
  const fmt = d.toLocaleString('zh-TW', {
    timeZone: '$TIMEZONE',
    year: 'numeric', month: '2-digit', day: '2-digit',
    weekday: 'long',
    hour: '2-digit', minute: '2-digit',
    hour12: false
  });
  console.log(fmt);
" 2>/dev/null || date)

echo "=== WAKEUP $CURRENT_TIME ==="

# --- Detect machine ---
HOSTNAME=$(hostname 2>/dev/null || echo "unknown")
USERNAME=$(whoami 2>/dev/null || echo "unknown")
echo "Machine: $HOSTNAME ($USERNAME)"
echo ""

# --- Cortex State ---
echo "=== CORTEX STATE ==="
if [ -f "$CORTEX_DIR/state/current.md" ]; then
  cat "$CORTEX_DIR/state/current.md"
else
  echo "(no state file found)"
fi
echo ""

# --- Memory Index ---
echo "=== MEMORY INDEX ==="
if [ -f "$MEMORY_DIR/MEMORY.md" ]; then
  cat "$MEMORY_DIR/MEMORY.md"
else
  echo "(no memory index found)"
fi
echo ""

# --- Open Loops ---
echo "=== OPEN LOOPS ==="
if [ -f "$CORTEX_DIR/state/open-loops.md" ]; then
  cat "$CORTEX_DIR/state/open-loops.md"
else
  echo "(no open loops)"
fi
echo ""

# --- Strategic Loop ---
echo "=== STRATEGIC LOOP ==="
if [ -f "$CORTEX_DIR/strategic-loop.md" ]; then
  cat "$CORTEX_DIR/strategic-loop.md"
else
  echo "(no strategic loop)"
fi
echo ""

# --- Last Session Log ---
echo "=== LAST SESSION LOG ==="
LAST_LOG=$(ls -t "$INBOX_DIR"/*session-log*.md 2>/dev/null | head -1)
if [ -n "$LAST_LOG" ]; then
  echo "$(basename "$LAST_LOG")"
  head -50 "$LAST_LOG"
else
  echo "(no session logs found)"
fi
echo ""

echo "=== WAKEUP COMPLETE ==="
