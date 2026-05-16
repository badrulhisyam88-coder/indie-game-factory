# idle-base template

Minimal Godot 4 idle game. One resource, one upgrade, one auto-buyer, save/load.

## What to modify per-game

1. `project.godot` — change `config/name`
2. `main.gd` — rename resource, tune constants
3. `main.tscn` — adjust UI text/layout
4. `icon.svg` — replace with something relevant

## What NOT to modify (yet)

- Save/load logic — works as-is
- Tick timer pattern — works as-is
- UI structure — keep simple for content capture

## Test locally

Open `project.godot` in Godot 4.6.2. Press F5 to run.

## Export to web

Use `tools/build-web.sh <game-name>` from the repo root.
