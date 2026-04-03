# Vim Game

**Learn Vim by playing a game in your terminal.**

Vim Game is a CLI-based interactive game that teaches you Vim through 45+ progressive levels. No slides, no videos — you learn by doing, inside real Vim. Each level focuses on one skill, and you can't move forward until you've mastered it.

Start from the universal struggle of *quitting Vim*, and work your way up to macros, visual mode, splits, buffers, sessions, and custom vimrc configuration. Boss fights appear along the way to test everything you've learned.

---

## Quick Start

```bash
git clone https://github.com/Stormbringer-v1/vim-game.git
cd vim-game
./play.sh
```

That's it. No dependencies, no installation — just Bash and Vim.

---

## Commands

```bash
./play.sh              # Start or resume from where you left off
./play.sh hint 5       # Get a hint for level 5
./play.sh replay 5     # Replay a completed level
./play.sh reset        # Reset all progress back to level 0
```

---

## What You'll Learn

The game is divided into four tiers of difficulty:

**Beginner (Levels 0-10)** — The fundamentals. Quitting Vim, inserting text, deleting lines and words, basic navigation, undo/redo. Ends with your first boss fight combining everything so far.

**Intermediate (Levels 11-20)** — Real editing power. Find and replace, visual mode selections, line operations, copying and pasting, working with multiple files and buffers.

**Advanced (Levels 21-30)** — Thinking in Vim. Global commands, macros, folds, abbreviations, spell checking, sessions, and window splits. Culminates in the Editor's Trial boss fight.

**Master (Levels 31-45)** — Full Vim proficiency. Custom vimrc configuration, autocommands, advanced multi-file workflows, tabs, sorting, and refactoring. The final boss is a comprehensive challenge that tests everything you've learned across all 45 levels.

---

## How It Works

Each level gives you a template file with a task. Vim opens, you do the work, and when you quit, the game validates your result. Pass and you move on. Fail and you try again. Hints are available if you get stuck.

Your progress is saved automatically, so you can quit and come back anytime.

---

## Requirements

- A Unix-like system (Linux, macOS, WSL)
- Bash
- Vim

---

## Contributing

PRs and ideas are welcome. If you have a level idea or find a bug, open an issue or submit a pull request.

---

## License

MIT License. See [LICENSE](LICENSE) for details.
