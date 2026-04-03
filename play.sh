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

if [[ "${1:-}" == "replay" ]]; then
  if [[ -z "${2:-}" ]]; then
    echo "Usage: ./play.sh replay <level>"
    echo "Example: ./play.sh replay 5"
    exit 1
  fi
  REPLAY_LEVEL="$2"
  if [[ ! -d "levels/level${REPLAY_LEVEL}" ]]; then
    echo "❌ Level ${REPLAY_LEVEL} does not exist."
    exit 1
  fi
  echo "🔄 Replaying Level ${REPLAY_LEVEL}..."
fi

if [[ "${1:-}" == "hint" ]]; then
  if [[ -z "${2:-}" ]]; then
    echo "Usage: ./play.sh hint <level>"
    echo "Example: ./play.sh hint 5"
    exit 1
  fi
  HINT_FILE="levels/level${2}/hint.txt"
  if [[ -f "$HINT_FILE" ]]; then
    echo "💡 Hint for Level ${2}:"
    cat "$HINT_FILE"
  else
    echo "No hint available for Level ${2}."
  fi
  exit 0
fi


# Show hint suggestion on failure
show_hint_tip() {
  local LEVEL=$1
  local HINT_FILE="levels/level${LEVEL}/hint.txt"
  if [[ -f "$HINT_FILE" ]]; then
    echo "💡 Need help? Run: ./play.sh hint $LEVEL"
  fi
}

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
    19)
      if [[ -f mysession.vim && -f workfile.txt ]]; then
        if grep -q "This file is in the session!" workfile.txt; then
          echo "🎉  Mission accomplished!  You passed Level 19!"
          echo "level19=completed" >> progress.log
          rm mysession.vim workfile.txt   # clean-up
        else
          echo "❌  Mission failed: workfile.txt has wrong content. Try again."
        fi
      else
        echo "❌  Mission failed: session or file missing. Try again."
      fi
      ;;
    20)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      if echo "$TASK_CONTENT" | grep -q "NOISE_NOISE_NOISE"; then
        echo "❌  Mission failed: noisy lines still exist. Try again."
      elif echo "$TASK_CONTENT" | grep -q "\bteh\b"; then
        echo "❌  Mission failed: the word 'teh' is still present. Try again."
      elif echo "$TASK_CONTENT" | grep -q "X[[:space:]]*$"; then
        echo "❌  Mission failed: the X column is still there. Try again."
      else
        echo "🎉🎉  Mini-Boss defeated! You passed Level 20!"
        echo "level20=completed" >> progress.log
      fi
      ;;
    21)
      # Detect any existing manual folds in file: look for {{{ or fold markers
      if vim -es -u NONE -c 'set nomore' \
           -c 'silent! %foldexpr' -c 'set foldmethod=manual' \
           -c 'echo foldclosed(1)' -c 'qa!' "$TMP_FILE" | grep -q '^[0-9]\+'; then
        echo "❌  Mission failed: a fold is still present.  Try again."
      else
        echo "🎉  Mission accomplished!  You passed Level 21!"
        echo "level21=completed" >> progress.log
      fi
      ;;
    22)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -q "TODO"; then
        echo "❌  Mission failed: at least one TODO is still present.  Try again."
      else
        echo "🎉  Mission accomplished!  You passed Level 22!"
        echo "level22=completed" >> progress.log
      fi
      ;;
    23)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      if echo "$TASK_CONTENT" | grep -q '"OLD"'; then
        echo "❌  Mission failed: \"OLD\" is still present. Try again."
      elif echo "$TASK_CONTENT" | grep -q "(remove me)"; then
        echo "❌  Mission failed: the parenthesised phrase is still there. Try again."
      elif ! echo "$TASK_CONTENT" | grep -q '"NEW"'; then
        echo "❌  Mission failed: \"NEW\" not found. Try again."
      else
        echo "🎉  Mission accomplished! You passed Level 23!"
        echo "level23=completed" >> progress.log
      fi
      ;;
    24)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      
      if echo "$TASK_CONTENT" | grep -q "First important place" && \
         echo "$TASK_CONTENT" | grep -q "Second important place"; then
        echo "🎉  Mission accomplished! You passed Level 24!"
        echo "level24=completed" >> progress.log
      else
        echo "❌  Mission failed: Important lines are missing. Try again."
      fi
      ;;
      25) if grep -q '^:vsplit$' "$TMP_FILE"; then :; fi   # no-op, keep shell happy
      echo "🎉  Mission accomplished! You passed Level 25!"
      echo "level25=completed" >> progress.log
      ;;
      26)
      if [[ -f file1.txt && -f file2.txt ]] && cmp -s file1.txt file2.txt
      then
        echo "🎉  Mission accomplished! You passed Level 26!"
        echo "level26=completed" >> progress.log
        rm file1.txt file2.txt
      else
        echo "❌  Mission failed: file1.txt and file2.txt are not identical."
      fi
      ;;
    27)
      if grep -q 'LEVEL27_OK' "$TMP_FILE"; then
        echo "🎉  Mission accomplished! You passed Level 27!"
        echo "level27=completed" >> progress.log
      else
        echo "❌  Mission failed: echo output not found. Try again."
      fi
      ;;
      28)
      if grep -q '^set\ number' ~/.vimrc; then
        echo "🎉  Mission accomplished! You passed Level 28!"
        echo "level28=completed" >> progress.log
      else
        echo "❌  Mission failed: ‘set number’ not found in ~/.vimrc."
      fi
      ;;
    29)
      # List of words that *must not* be present anywhere in the buffer
      BADWORDS=(paragraf mispelled wird alsso twoo errorss thiss linee bee afterr themm)

      FAILED=0
      for w in "${BADWORDS[@]}"; do
        # \b isn't POSIX for grep; use \< and \> to mark word-boundaries
        if grep -qi "\<$w\>" "$TMP_FILE"; then
          FAILED=1
          break
        fi
      done

      if [[ $FAILED -eq 0 ]]; then
        echo "🎉  Mission accomplished! You passed Level 29!"
        echo "level29=completed" >> progress.log
      else
        echo "❌  Mission failed: at least one misspelling is still present."
      fi
      ;;

    30)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      if echo "$TASK_CONTENT" | grep -q 'TODO_DELETE'; then
        echo "❌  Mission failed: TODO_DELETE lines still present."
      elif echo "$TASK_CONTENT" | grep -q '\bteh\b'; then
        echo "❌  Mission failed: the word “teh” is still present."
      elif echo "$TASK_CONTENT" | grep -q '▶[[:space:]]*$'; then
        echo "❌  Mission failed: the ▶ column is still there."
      elif echo "$TASK_CONTENT" | grep -Ei '\b(paragraf|qick|errr|Speling|errorss)\b'; then
        echo "❌  Mission failed: spelling errors remain."
      else
        echo "🎉🎉  Editor’s Trial defeated — Level 30 clear!"
        echo "level30=completed" >> progress.log
      fi
      ;;
    31)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      # 1. No TODO: must remain
      if echo "$TASK_CONTENT" | grep -q 'TODO:'; then
        echo "❌  Mission failed: at least one TODO: still present."
      # 2. All lines must start with "- [ ]"
      elif ! echo "$TASK_CONTENT" | grep -c '^- \[ \]' | grep -q '^5$'; then
        echo "❌  Mission failed: not all lines were converted to - [ ]."
      else
        echo "🎉  Mission accomplished! You passed Level 31!"
        echo "level31=completed" >> progress.log
      fi
      ;;
    32)
      if [[ -f fileA.txt && -f fileB.txt && -f fileC.txt ]]; then
        if grep -q 'WRONG' fileA.txt || grep -q 'WRONG' fileB.txt || grep -q 'WRONG' fileC.txt
        then
          echo "❌  Mission failed: at least one WRONG is still present."
        else
          echo "🎉  Mission accomplished! You passed Level 32!"
          echo "level32=completed" >> progress.log
          rm fileA.txt fileB.txt fileC.txt         # tidy up
        fi
      else
        echo "❌  Mission failed: one or more files are missing."
      fi
      ;;
    33)
      if [[ -f alpha.txt && -f beta.txt && -f gamma.txt ]]; then
        if grep -q 'OLD' alpha.txt || grep -q 'OLD' beta.txt || grep -q 'OLD' gamma.txt
        then
          echo "❌  Mission failed: at least one file still contains “OLD”."
        else
          echo "🎉  Mission accomplished! You passed Level 33!"
          echo "level33=completed" >> progress.log
          rm alpha.txt beta.txt gamma.txt
        fi
      else
        echo "❌  Mission failed: one or more files are missing."
      fi
      ;;
    34)
      if [[ -f .vimrc_level34 ]]; then
        if grep -q 'iabbrev[[:space:]]\+btw[[:space:]]\+by the way' .vimrc_level34 &&
           grep -q 'nnoremap[[:space:]]\+<F5>[[:space:]]\+:echo "LEVEL34_OK"' .vimrc_level34
        then
          echo "🎉  Mission accomplished! You passed Level 34!"
          echo "level34=completed" >> progress.log
          rm .vimrc_level34                         # ← clean-up
        else
          echo "❌  Mission failed: abbrev or mapping line missing / incorrect."
        fi
      else
        echo "❌  Mission failed: .vimrc_level34 not found."
      fi
      ;;
    35)
      if [[ -f .vimrc_level35 && -f log.txt ]]; then
        if tail -n1 log.txt | grep -q '^# SAVED$' &&
           grep -q 'autocmd BufWritePost log.txt' .vimrc_level35
        then
          echo "🎉  Mission accomplished! You passed Level 35!"
          echo "level35=completed" >> progress.log
          rm .vimrc_level35 log.txt
        else
          echo "❌  Mission failed: either autocommand missing or log.txt not updated."
        fi
      else
        echo "❌  Mission failed: .vimrc_level35 or log.txt not found."
      fi
      ;;
    36)
      if [[ -f win.txt ]]; then
        first_line=$(head -n1 win.txt)
        if [[ "$first_line" == "# WINDOW MAGIC" ]]; then
          echo "🎉  Mission accomplished! You passed Level 36!"
          echo "level36=completed" >> progress.log
          rm win.txt
        else
          echo "❌  Mission failed: win.txt does not start with '# WINDOW MAGIC'."
        fi
      else
        echo "❌  Mission failed: win.txt not found."
      fi
      ;;
    37)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      expected=$(printf "apple\nbanana\nkiwi\norange\npear")
      if [[ "$TASK_CONTENT" == "$expected" ]]; then
        echo "🎉  Mission accomplished! You passed Level 37!"
        echo "level37=completed" >> progress.log
      else
        echo "❌  Mission failed: the lines are not sorted alphabetically."
      fi
      ;;
    38)
      if [[ -f .vimrc_level38 && -f header.txt ]]; then
        first_line=$(head -n1 header.txt)
        if [[ "$first_line" == "# HEADER" ]] && \
           grep -q 'command! InsertHeader' .vimrc_level38
        then
          echo "🎉  Mission accomplished! You passed Level 38!"
          echo "level38=completed" >> progress.log
          rm .vimrc_level38 header.txt
        else
          echo "❌  Mission failed: either command missing or header.txt not updated."
        fi
      else
        echo "❌  Mission failed: .vimrc_level38 or header.txt not found."
      fi
      ;;
    39)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      if echo "$TASK_CONTENT" | grep -q '^>>>'; then
        echo "❌  Mission failed: at least one “>>>” prefix remains."
      else
        echo "🎉  Mission accomplished! You passed Level 39!"
        echo "level39=completed" >> progress.log
      fi
      ;;
    40)
      files=(main.py utils.py readme.txt)
      OK=1

      is_sorted() { sort -c "$1" 2>/dev/null; }

      for f in "${files[@]}"; do
        [[ -f $f ]] || { echo "❌  $f missing."; OK=0; break; }

        if grep -q 'DEBUG_PRINT' "$f"; then
          echo "❌  DEBUG_PRINT still present in $f."; OK=0; break;
        fi
        if grep -q '\bTODO\b' "$f"; then
          echo "❌  TODO still present in $f."; OK=0; break;
        fi
        if ! is_sorted "$f"; then
          echo "❌  $f is not sorted alphabetically."; OK=0; break;
        fi
      done

      if [[ $OK -eq 1 ]]; then
        echo "🎉🎉  Mini-Boss #4 defeated — Level 40 clear!"
        echo "level40=completed" >> progress.log
        rm -f "${files[@]}"
      else
        echo "⚠️  Fix the issues above and try again."
      fi
      ;;
    41)
      if [[ -f source.txt && -f dest.txt ]]; then
        expected=$(printf "COPY_ME one\nCOPY_ME two\nCOPY_ME three")
        if diff <(echo "$expected") <(head -n3 dest.txt) >/dev/null; then
          echo "🎉  Mission accomplished! You passed Level 41!"
          echo "level41=completed" >> progress.log
          rm source.txt dest.txt
        else
          echo "❌  Mission failed: dest.txt does not contain the required lines."
        fi
      else
        echo "❌  Mission failed: source.txt or dest.txt is missing."
      fi
      ;;
    42)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      # Must have one comma, one space, and no remaining plain names.
      if echo "$TASK_CONTENT" | grep -q '^[A-Za-z]\+ [A-Za-z]\+'; then
        echo "❌  Mission failed: at least one name is still FirstName LastName."
      elif echo "$TASK_CONTENT" | grep -vq '^[A-Za-z]\+, [A-Za-z]\+$'; then
        echo "❌  Mission failed: lines are not all in “Last, First” form."
      else
        echo "🎉  Mission accomplished! You passed Level 42!"
        echo "level42=completed" >> progress.log
      fi
      ;;
    43)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")
      if echo "$TASK_CONTENT" | grep -vq '^- '; then
        echo "❌  Mission failed: at least one line is missing the bullet “- ”."
      else
        echo "🎉  Mission accomplished! You passed Level 43!"
        echo "level43=completed" >> progress.log
      fi
      ;;
    44)
      TASK_CONTENT=$(awk '/<<TASK>>/{flag=1;next}/<<END>>/{flag=0}flag' "$TMP_FILE")

      # Fail if any TODO: prefix remains
      if echo "$TASK_CONTENT" | grep -q '^TODO:'; then
        echo "❌  Mission failed: at least one TODO: line still present."
      # Fail if any checkbox line is missing
      elif ! echo "$TASK_CONTENT" | grep -q '^- \[ \] '; then
        echo "❌  Mission failed: no checkbox lines found."
      # Success
      else
        echo "🎉  Mission accomplished! You passed Level 44!"
        echo "level44=completed" >> progress.log
      fi
      ;;
    45)
      # helper: test sorted bullet list
      bullet_list=$(awk '/^## Tasks/{flag=1;next}/^##/{flag=0}flag' "$TMP_FILE" | sed -n '/^- /p')
      sorted_list=$(echo "$bullet_list" | sort -f)

      clean() { echo "❌  Mission failed: $1" ; return 1; }

      first_line=$(head -n1 "$TMP_FILE")
      [[ "$first_line" == "# Final Report" ]] || clean "missing header '# Final Report'." || break

      grep -q 'DEBUG'      "$TMP_FILE" && clean "DEBUG still present."      && break
      grep -q '\bTODO\b'   "$TMP_FILE" && clean "TODO still present."       && break
      grep -qi '\bteh\b'   "$TMP_FILE" && clean "typo 'teh' still present." && break
      grep -q '\t'        "$TMP_FILE" && clean "tab character still present." && break
      grep -q '[[:space:]]$' "$TMP_FILE" && clean "trailing spaces remain." && break
      grep -q -E '^[[:space:]]*$\n^[[:space:]]*$' "$TMP_FILE" && clean "multiple blank lines remain." && break
      diff <(echo "$bullet_list") <(echo "$sorted_list") >/dev/null || { clean "bullet list not alphabetical." ; break; }

      echo "🏆  FINAL BOSS DEFEATED — You are a Vim Grand Master!"
      echo "level45=completed" >> progress.log
      ;;





    *)
      echo "Unknown level!"
      ;;
  esac

  rm "$TMP_FILE"

  # Show hint tip if the level was not completed
  local KEY
  if [[ "$LEVEL" == boss* ]]; then
    KEY="${LEVEL}=completed"
  else
    KEY="level${LEVEL}=completed"
  fi
  if ! grep -q "$KEY" progress.log; then
    show_hint_tip "$LEVEL"
  fi

# New: ask if continue
read -p "👉 Do you want to continue to the next level? (y/N): " CONTINUE
if [[ "$CONTINUE" == "y" || "$CONTINUE" == "Y" ]]; then
  :
else
  echo "👋 See you next time! Exiting..."
  exit 0
fi



}

# ── Level order ──
LEVEL_ORDER=(
  0 1 2 3 4 5 6 7 8 9 10
  boss01
  11 12 13 14 15 16 17 18 19 20
  21 22 23 24 25 26 27 28 29 30
  31 32 33 34 35 36 37 38 39 40
  41 42 43 44 45
)

# Helper: get the progress key for a level
progress_key() {
  local lvl=$1
  if [[ "$lvl" == boss* ]]; then
    echo "${lvl}=completed"
  else
    echo "level${lvl}=completed"
  fi
}

# ── Main logic ──

# Handle replay mode: run one level and exit
if [[ -n "${REPLAY_LEVEL:-}" ]]; then
  run_level "$REPLAY_LEVEL"
  exit 0
fi

while true; do
  FOUND=0
  for LVL in "${LEVEL_ORDER[@]}"; do
    if ! grep -q "$(progress_key "$LVL")" progress.log; then
      run_level "$LVL"
      FOUND=1
      break
    fi
  done

  if [[ $FOUND -eq 0 ]]; then
    echo "🎉 Congratulations! You finished all available levels!"
    echo "If you want to start again, type './play.sh reset' "
    exit 0
  fi
done 