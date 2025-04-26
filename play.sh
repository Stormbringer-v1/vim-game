#!/usr/bin/env bash
set -euo pipefail

LEVEL_DIR="levels/level1"
TEMPLATE="$LEVEL_DIR/template.txt"
TMP_FILE="$(mktemp /tmp/vimlevel1.XXXX.txt)"

cp "$TEMPLATE" "$TMP_FILE"

vim -u NONE "$TMP_FILE"

# Check if the word was corrected
if grep -q "DELEETE" "$TMP_FILE"; then
  echo "❌  Mission failed: The mistake is still there. Try again."
else
  echo "🎉  Mission accomplished! You passed Level 1!"
  echo "level1=completed" >> progress.log
fi

rm "$TMP_FILE"