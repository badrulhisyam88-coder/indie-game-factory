# Devlog — 002-kakak-jagung-melaka

## 2026-05-16 — scaffolding started

Built from scratch (Path B), not via new-game.sh template copy.
Reason: game has structural differences from idle-base template
(7 flavor unlocks, two upgrade types, no separate "auto-buyer" concept).

## 2026-05-16 — deferred until scene build

The following are intentionally not implemented in this commit. They depend
on main.tscn (the scene file) existing, which is the next phase.

- Dynamic unlock buttons: `unlock_buttons_container` is wired as a node
  reference but `refresh_ui()` doesn't populate it. After main.tscn is
  built, refresh_ui() needs to clear and repopulate the container with one
  Button per locked-but-affordable flavor, connecting each to on_unlock_flavor.

- Win screen node paths: show_win_screen() calls win_screen.get_node("VBox/MadeLabel")
  etc. These must exist in main.tscn with matching paths or the game will
  crash on win. Verify when building the scene.

## What I tried

(append entries as you iterate)

## What I learned

(fill in at end / postmortem)

## Ship or kill decision

(date + reason)
