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
 # Launch Vim differently for cursed Level 13
  if [[ "$LEVEL" == "13" ]]; then
    echo "⚠️  WARNING: CURSED LEVEL AHEAD — No Arrows, No Backspace! ⚠️"
    vim -c "set nomodeline" -c "set nocompatible" \
        -c "noremap <Up> <Nop>" \
        -c "noremap <Down> <Nop>" \
        -c "noremap <Left> <Nop>" \
        -c "noremap <Right> <Nop>" \
        -c "noremap <BS> <Nop>" \
        "$TMP_FILE"
  else
  vim "$TMP_FILE"
fi 


  # After exit, check depending on level
  case $LEVEL in
       0)
      echo "🎉  Great job! You learned how to quit Vim!"
      echo "level0=completed" >> progress.log
      ;;
   1)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "DELEETE"; then
        echo "❌  Mission failed: The mistake is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 1!"
     #   echo "To continue run play.sh again"
        echo "level1=completed" >> progress.log
      fi
      ;;
    2)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "NOISE_NOISE_NOISE"; then
        echo "❌  Mission failed: The noisy line is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 2!"
       # echo "To continue run play.sh again"
        echo "level2=completed" >> progress.log
      fi
      ;;
    3)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "MISTAEK"; then
        echo "❌  Mission failed: The typo is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 3!"
       # echo "To continue run play.sh again"
        echo "level3=completed" >> progress.log
      fi
      ;;
        4)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "FAILD"; then
        echo "❌  Mission failed: The typo is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 4!"
       # echo "To continue run play.sh again"
        echo "level4=completed" >> progress.log
      fi
      ;;
        5)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "sdklfjskldfj"; then
        echo "❌  Mission failed: You didn't clean up the unwanted line."
      else
        echo "🎉  Mission accomplished! You passed Level 5!"
      # echo "To continue run play.sh again"
        echo "level5=completed" >> progress.log
      fi
      ;;
    6)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "appple"; then
        echo "❌  Mission failed: Some mistakes are still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 6!"
       # echo "To continue run play.sh again"
        echo "level6=completed" >> progress.log
      fi
      ;;
    7)
      if [[ -f mysecondfile.txt ]]; then
        if grep -q "This is my second file!" mysecondfile.txt; then
          echo "🎉  Mission accomplished! You passed Level 7!"
       #   echo "To continue run play.sh again"
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
        #  echo "To continue run play.sh again"
          echo "level8=completed" >> progress.log
          rm otherside.txt  # Clean up afterward
        else
          echo "❌  Mission failed: The new split file content is wrong. Try again."
        fi
      else
        echo "❌  Mission failed: You didn't create the split file. Try again."
      fi
      ;;

    9)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "BAD LINE"; then
        echo "❌  Mission failed: Some BAD LINEs are still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 9!"
       # echo "To continue run play.sh again"
        echo "level9=completed" >> progress.log
      fi
      ;;
    10)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "SELECT_ME"; then
        echo "❌  Mission failed: The SELECT_ME line is still there. Try again."
      elif echo "$TASK_CONTENT" | grep -q "OOPS"; then
        echo "❌  Mission failed: The OOPS word is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 10!"
       # echo "To continue run play.sh again"
        echo "level10=completed" >> progress.log
      fi
      ;;

    boss01)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "NOISE_NOISE_NOISE"; then
        echo "❌  Mission failed: Noisy lines are still there. Try again."
      elif echo "$TASK_CONTENT" | grep -q "MISTAEK"; then
        echo "❌  Mission failed: Typos are still there. Try again."
      elif echo "$TASK_CONTENT" | grep -q "appple"; then
        echo "❌  Mission failed: Spelling mistakes are still there. Try again."
      else
        echo "🎉🎉🎉  You conquered the Vim Boss Fight! You are a true Vim Wizard!"
        echo "boss01=completed" >> progress.log
      fi
      ;;
    11)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "X"; then
        echo "❌  Mission failed: The column of X's is still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 11!"
        echo "level11=completed" >> progress.log
      fi
      ;;
    12)
      if [[ -f secondfile.txt ]]; then
        if grep -q "This is the second buffer!" secondfile.txt && grep -q "This is the first buffer!" "$TMP_FILE"; then
          echo "🎉  Mission accomplished! You passed Level 12!"
          echo "level12=completed" >> progress.log
          rm secondfile.txt  # Clean up afterwards
        else
          echo "❌  Mission failed: Content is missing or wrong. Try again."
        fi
      else
        echo "❌  Mission failed: secondfile.txt was not created. Try again."
      fi
      ;;
    13)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "Thes\|smaple\|txt\|lcuk"; then
        echo "❌  Mission failed: Some typos are still there. Try again."
      else
        echo "🎉  Mission accomplished! You survived the cursed Level 13!"
        echo "level13=completed" >> progress.log
      fi
      ;;
    14)
      if [[ -f tabfile.txt ]]; then
        if grep -q "This is a new tab!" tabfile.txt && grep -q "Back to the first tab!" "$TMP_FILE"; then
          echo "🎉  Mission accomplished! You passed Level 14!"
          echo "level14=completed" >> progress.log
          rm tabfile.txt  # Clean up afterwards
        else
          echo "❌  Mission failed: Content is missing or wrong. Try again."
        fi
      else
        echo "❌  Mission failed: tabfile.txt was not created. Try again."
      fi
      ;;
    15)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "REMOVE_ME"; then
        echo "❌  Mission failed: Some noisy lines are still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 15!"
        echo "level15=completed" >> progress.log
      fi
      ;;
     16)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      FIRST_COUNT=$(echo "$TASK_CONTENT" | grep -c "First important line")
      SECOND_COUNT=$(echo "$TASK_CONTENT" | grep -c "Second important line")

      if [[ "$FIRST_COUNT" -ge 2 && "$SECOND_COUNT" -ge 2 ]]; then
        echo "🎉  Mission accomplished! You passed Level 16!"
        echo "level16=completed" >> progress.log
      else
        echo "❌  Mission failed: You didn't paste the lines correctly. Try again."
      fi
      ;;
    17)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "bad line"; then
        echo "❌  Mission failed: Some bad lines are still there. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 17!"
        echo "level17=completed" >> progress.log
      fi
      ;;
    18)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -qv "^\[TODO\]"; then
        echo "❌  Mission failed: Some lines are still missing [TODO]. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 18!"
        echo "level18=completed" >> progress.log
      fi
      ;;






    *)
      echo "Unknown level!"
      ;;
  esac

  rm "$TMP_FILE"

# New: ask if continue
read -p "👉 Do you want to continue to the next level? (y/N): " CONTINUE
if [[ "$CONTINUE" == "y" || "$CONTINUE" == "Y" ]]; then
  :
else
  echo "👋 See you next time! Exiting..."
  exit 0
fi



}

# ── Main logic ──
while true; do
if ! grep -q "level0=completed" progress.log; then
  run_level 0
elif ! grep -q "level1=completed" progress.log; then
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
elif ! grep -q "level9=completed" progress.log; then
  run_level 9
elif ! grep -q "level10=completed" progress.log; then
  run_level 10
elif ! grep -q "boss01=completed" progress.log; then
  run_level boss01
elif ! grep -q "level11=completed" progress.log; then
  run_level 11
elif ! grep -q "level12=completed" progress.log; then
  run_level 12
elif ! grep -q "level13=completed" progress.log; then
  run_level 13
elif ! grep -q "level14=completed" progress.log; then
  run_level 14
elif ! grep -q "level15=completed" progress.log; then
  run_level 15
elif ! grep -q "level16=completed" progress.log; then
  run_level 16
elif ! grep -q "level17=completed" progress.log; then
  run_level 17
elif ! grep -q "level18=completed" progress.log; then
  run_level 18



else
  echo "🎉 Congratulations! You finished all available levels!"
  echo "If you want to start again, type './play.sh reset' "
exit 0
fi

done 