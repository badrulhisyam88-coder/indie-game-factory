# CLAUDE.md — 001-coffee-shop-idle

> This file is read by Claude (web or Code) at the start of each session
> to load project context. Keep it current as the game evolves.

## What this game is

{{ONE_LINE_PITCH}}

## Current status

- Phase: scaffolding / iterating / polishing / shipped
- Last working version: (commit hash or "not yet")
- Known issues: (list)

## Concept reference

Full concept: `../../concepts/001-coffee-shop-idle.md`

## Tech stack

- Godot 4.6.2-stable
- GDScript only (no C#)
- Single scene if possible, single script if possible
- Target: HTML5 web export
- Save format: Godot's `user://` storage, JSON

## Code conventions for this project

- All tunable numbers in a `const` block at top of main script
- No magic numbers in logic
- Function naming: `verb_noun` (e.g., `buy_upgrade`, `tick_brewers`)
- Comments only where intent isn't obvious from code
- No premature abstractions — duplicate before extracting

## Current mechanics

(Update this as you build. Claude reads this to understand what exists.)

- [ ] Main resource counter
- [ ] Manual action (click button)
- [ ] First upgrade
- [ ] Automation (auto-tick)
- [ ] Save/load
- [ ] Prestige

## Numbers in play

(Keep current — Claude tunes against these.)

| Constant | Value | Why |
|----------|-------|-----|
| `START_RESOURCE` | 0 | Standard idle start |
| `MANUAL_GAIN` | 1 | Per click |
| `UPGRADE_BASE_COST` | 10 | Cheap first upgrade |

## What NOT to add

(Anti-scope-creep list. Update as temptations arise.)

- Custom art (use shapes + text)
- Sound effects (until game proven)
- Multiple scenes
- Networked features
