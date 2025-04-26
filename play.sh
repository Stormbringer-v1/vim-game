#!/usr/bin/env bash
set -euo pipefail

# Helper function to run a level
run_level() {
  local LEVEL=$1
  local TEMPLATE="levels/level$LEVEL/template.txt"
  local TMP_FILE
  TMP_FILE="$(mktemp -t vimlevel${LEVEL}.XXXXXX)"

  cp "$TEMPLATE" "$TMP_FILE"
  vim "$TMP_FILE"

  # After exit, check depending on level
  case $LEVEL in
    1)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "DELEETE"; then
        echo "❌  Mission failed: The mistake is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 1!"
        echo "level1=completed" >> progress.log
      fi
      ;;
    2)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "NOISE_NOISE_NOISE"; then
        echo "❌  Mission failed: The noisy line is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 2!"
        echo "level2=completed" >> progress.log
      fi
      ;;
    *)
      echo "Unknown level!"
      ;;
  esac

  rm "$TMP_FILE"
}

# ── Main logic ──
if ! grep -q "level1=completed" progress.log; then
  run_level 1
elif ! grep -q "level2=completed" progress.log; then
  run_level 2
else
  echo "🎉 Congratulations! You finished all available levels!"
fi