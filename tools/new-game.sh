#!/usr/bin/env bash
# new-game.sh — scaffold a new game from a template
# Usage: ./tools/new-game.sh <game-id> <template>
#   game-id:  e.g., 002-bug-farm
#   template: idle | tycoon | sim   (currently only "idle" exists)

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

[ "$#" -eq 2 ] || die "Usage: $0 <game-id> <template>"

GAME_ID="$1"
TEMPLATE="$2"

[[ "$GAME_ID" =~ ^[0-9]{3}-[a-z0-9-]+$ ]] || die "game-id must look like '002-bug-farm'"

TEMPLATE_DIR="$REPO_ROOT/templates/game-types/${TEMPLATE}-base"
[ -d "$TEMPLATE_DIR" ] || die "Template not found: $TEMPLATE_DIR"

GAME_DIR="$REPO_ROOT/games/$GAME_ID"
[ -d "$GAME_DIR" ] && die "Game already exists: $GAME_DIR"

log "Creating game: $GAME_ID (from template: $TEMPLATE)"

mkdir -p "$GAME_DIR/godot"
mkdir -p "$GAME_DIR/content/raw"
mkdir -p "$GAME_DIR/content/clips"
mkdir -p "$GAME_DIR/content/captions"

# Copy template (excluding template README)
cp -r "$TEMPLATE_DIR/." "$GAME_DIR/godot/"
rm -f "$GAME_DIR/godot/README.md"

# Update project name in project.godot
sed -i.bak "s|config/name=.*|config/name=\"$GAME_ID\"|" "$GAME_DIR/godot/project.godot"
rm -f "$GAME_DIR/godot/project.godot.bak"

# Create CLAUDE.md from template
CLAUDE_TEMPLATE="$REPO_ROOT/templates/claude-md/new-game.md"
if [ -f "$CLAUDE_TEMPLATE" ]; then
  sed "s|{{GAME_NAME}}|$GAME_ID|g; s|{{CONCEPT_FILE}}|$GAME_ID|g" \
    "$CLAUDE_TEMPLATE" > "$GAME_DIR/CLAUDE.md"
fi

# Create DEVLOG.md
cat > "$GAME_DIR/DEVLOG.md" <<DEVLOG_EOF
# Devlog — $GAME_ID

## $(date +%Y-%m-%d) — created

Scaffolded from template: $TEMPLATE.

## What I tried

(append entries here as you iterate)

## What I learned

(fill in at end / postmortem)

## Ship or kill decision

(date + reason)
DEVLOG_EOF

# Create per-game README
cat > "$GAME_DIR/README.md" <<README_EOF
# $GAME_ID

Status: scaffolding
Template: $TEMPLATE

## Links

- Concept: \`../../concepts/$GAME_ID.md\`
- Live build: _not yet deployed_
- itch.io: _not yet uploaded_
- Posts: _none_

## Dev

Open \`godot/project.godot\` in Godot 4.6.2.
README_EOF

ok "Created $GAME_DIR"
log "Next steps:"
echo "  1. Open $GAME_DIR/godot/project.godot in Godot"
echo "  2. Update CLAUDE.md with concept details"
echo "  3. Use prompts/library/01-scaffold-idle.md with Claude"
echo "  4. Commit when you have something runnable"
