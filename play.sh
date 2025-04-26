#!/usr/bin/env bash
set -euo pipefail

LEVEL_DIR="levels/level1"
TEMPLATE="$LEVEL_DIR/template.txt"
TMP_FILE="$(mktemp -t vimlevel1.XXXXXX)"   # always unique

cp "$TEMPLATE" "$TMP_FILE"
vim "$TMP_FILE"

# ── check only the task block ─────────────────────────
TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

if echo "$TASK_CONTENT" | grep -q "DELEETE"; then
  echo "❌  Mission failed: the typo is still there. Try again."
else
  echo "🎉  Mission accomplished!  You passed Level 1!"
  echo "level1=completed" >> progress.log
fi

rm "$TMP_FILE"