# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Mission

Ship small browser-playable games fast, then convert gameplay into social media content. The constraint is intentional: no custom art, no sound until proven, single scene + single script per game, desktop browser only (v1).

**Read METHOD.md at the start of any session involving strategy or process decisions.**

## Common Commands

```bash
# Scaffold a new game from template
./tools/new-game.sh <game-id> idle
# e.g.: ./tools/new-game.sh 002-my-game idle

# Export game to HTML5
./tools/build-web.sh <game-id>
# e.g.: ./tools/build-web.sh 001-coffee-shop-idle

# Test locally after building
cd games/<game-id>/builds/web && python3 -m http.server 8000

# Cut a vertical 9:16 clip from gameplay recording
./tools/clip.sh <game-id> <input.mp4> <start> <end> [label]
# e.g.: ./tools/clip.sh 001-coffee-shop-idle raw.mp4 00:23 00:35 hook
```

CI runs on every push to `main`: installs Godot 4.6.2, builds all `games/*/`, deploys to GitHub Pages.

## Repository Layout

```
concepts/          # Ranked idea backlog; one .md per game concept
games/             # One folder per game
  NNN-game-name/
    godot/         # Godot 4.6.2 project (main.gd + main.tscn + project.godot)
    content/       # raw/, clips/, captions/
    CLAUDE.md      # Per-game context (status, mechanics, numbers, anti-scope)
    DEVLOG.md      # Iteration log + ship/kill decision
templates/
  game-types/idle-base/   # Minimal idle game (copy, don't modify)
  claude-md/new-game.md   # CLAUDE.md template for new games
prompts/library/           # Numbered reusable AI prompts (the real IP)
tools/                     # Shell scripts: new-game, build-web, clip
shared/                    # godot-addons/, assets/ (reused across games)
```

## Architecture

Each game is a **single Godot scene + single GDScript file**:

- `main.tscn` — Control node tree (VBoxContainer, Labels, Buttons, Timer)
- `main.gd` — All game logic; top section is a `CONSTANTS` block of tunable numbers

The CONSTANTS block is intentional: AI prompts adjust numbers without touching logic. When implementing mechanics, put all tunable values there.

**Template → Game flow:**
1. `new-game.sh` copies `templates/game-types/idle-base/` into `games/<id>/godot/`, updates `project.godot` display name, generates per-game CLAUDE.md/DEVLOG.md/README.md.
2. Iterate on `main.gd` + `main.tscn` only.
3. `build-web.sh` runs headless Godot export (requires Godot 4.6.2 on PATH).

## Rules (from METHOD.md)

- **Rule of Three:** hardcode twice, abstract on the third repetition.
- **No premature sharing:** a `shared/` module only exists when 3 games need it.
- **Kill at 14 days:** if a game isn't shippable by day 14, archive it and move on.
- **Max 2h on any automation script:** if it takes longer, do it manually.
- **Prompt library is the IP:** update `prompts/library/` with notes after every reuse.

## Tech Stack

| Layer | Choice |
|-------|--------|
| Engine | Godot 4.6.2 stable |
| Language | GDScript only (no C#) |
| Export | HTML5 (Web preset, Emscripten) |
| Video | ffmpeg via `tools/clip.sh` |
| CI/CD | GitHub Actions → GitHub Pages |

## Working on a Game

Always check the **per-game `CLAUDE.md`** first — it contains current status, the mechanics checklist, numbers to tune, and the anti-scope list (what is explicitly out of scope for this game). Update it as mechanics are completed.

Log every iteration in the game's **`DEVLOG.md`** with date, what changed, and what was learned.
