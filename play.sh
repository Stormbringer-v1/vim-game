#!/usr/bin/env bash
set -euo pipefail

# Check for special arguments
if [[ "${1:-}" == "reset" ]]; then
  echo "⚡ Resetting your game progress..."
  rm -f progress.log
  touch progress.log
  echo "✅ Progress has been reset! Start again from Level 1."
  exit 0
fi


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
        echo "To continue run play.sh again"
        echo "level1=completed" >> progress.log
      fi
      ;;
    2)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "NOISE_NOISE_NOISE"; then
        echo "❌  Mission failed: The noisy line is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 2!"
        echo "To continue run play.sh again"
        echo "level2=completed" >> progress.log
      fi
      ;;
    3)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "MISTAEK"; then
        echo "❌  Mission failed: The typo is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 3!"
        echo "To continue run play.sh again"
        echo "level3=completed" >> progress.log
      fi
      ;;
        4)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "FAILD"; then
        echo "❌  Mission failed: The typo is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 4!"
        echo "To continue run play.sh again"
        echo "level4=completed" >> progress.log
      fi
      ;;
        5)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "sdklfjskldfj"; then
        echo "❌  Mission failed: You didn't clean up the unwanted line."
      else
        echo "🎉  Mission accomplished! You passed Level 5!"
        echo "To continue run play.sh again"
        echo "level5=completed" >> progress.log
      fi
      ;;
    6)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "appple"; then
        echo "❌  Mission failed: Some mistakes are still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 6!"
        echo "To continue run play.sh again"
        echo "level6=completed" >> progress.log
      fi
      ;;
    7)
      if [[ -f mysecondfile.txt ]]; then
        if grep -q "This is my second file!" mysecondfile.txt; then
          echo "🎉  Mission accomplished! You passed Level 7!"
          echo "To continue run play.sh again"
           echo "level7=completed" >> progress.log
          rm mysecondfile.txt  # Clean up afterward
        else
          echo "❌  Mission failed: The new file content is wrong. Try again."
        fi
      else
        echo "❌  Mission failed: You didn't create the second file. Try again."
      fi
      ;;
8)
      if [[ -f otherside.txt ]]; then
        if grep -q "This is the other side!" otherside.txt; then
          echo "🎉  Mission accomplished! You passed Level 8!"
          echo "To continue run play.sh again"
          echo "level8=completed" >> progress.log
          rm otherside.txt  # Clean up afterward
        else
          echo "❌  Mission failed: The new split file content is wrong. Try again."
        fi
      else
        echo "❌  Mission failed: You didn't create the split file. Try again."
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
elif ! grep -q "level3=completed" progress.log; then
  run_level 3
  elif ! grep -q "level4=completed" progress.log; then
  run_level 4
elif ! grep -q "level5=completed" progress.log; then
  run_level 5
elif ! grep -q "level6=completed" progress.log; then
  run_level 6
elif ! grep -q "level7=completed" progress.log; then
  run_level 7    
elif ! grep -q "level8=completed" progress.log; then
  run_level 8  
else
  echo "🎉 Congratulations! You finished all available levels!"
  echo "If you want to start again, type './play.sh reset' "
fi