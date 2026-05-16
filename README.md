# Indie Game Factory

A solo operator's pipeline for rapidly shipping small browser games and
turning each one into social media content.

## Status

| # | Game | Status | Web | Posts |
|---|------|--------|-----|-------|
| 001 | _placeholder_ | - | - | - |

## Quick start

```bash
# Create a new game from a template
./tools/new-game.sh 001-my-first-idle idle

# Build for web (local test)
./tools/build-web.sh 001-my-first-idle

# Cut a clip from a recording
./tools/clip.sh 001-my-first-idle raw_recording.mp4 00:23 00:35
```

## Repo layout

- `concepts/` — game ideas, ranked backlog
- `games/` — one folder per game (Godot project + content + devlog)
- `templates/` — reusable starting points (Godot projects, CLAUDE.md, etc.)
- `prompts/` — your AI prompt library (the real IP)
- `tools/` — shell scripts that do the boring work
- `shared/` — assets and addons reused across games
- `.github/workflows/` — CI: build + deploy to GitHub Pages

## Method

See [METHOD.md](./METHOD.md) for the operating manual.

## Known issues (deferred)

- **CI: Godot exports succeed without a main scene.** When a game folder has
  main.gd but no main.tscn, Godot's `--export-release Web` still produces a
  5KB index.html wrapper. Our CI check `[ -s "$out" ]` treats this as success
  and adds the game to the index page, but the URL loads a broken state
  (Godot tries to run a missing main scene).

  Fix when needed: add `&& [ -f "$GITHUB_WORKSPACE/public/$game_id/index.pck" ]`
  to the success check in .github/workflows/deploy.yml. The .pck file is
  Godot's packed game data — only produced on a real export.

  Currently deferred because: as long as every committed game eventually
  gets a main.tscn, the broken state self-resolves. Only matters if we
  intentionally ship games without scenes (we don't).
