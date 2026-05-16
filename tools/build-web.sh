#!/usr/bin/env bash
# build-web.sh — export a game to HTML5 (web) using headless Godot
# Usage: ./tools/build-web.sh <game-id>
#
# Requires: GODOT_BIN env var pointing to a headless Godot 4.6 binary,
# OR godot in PATH.

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

[ "$#" -eq 1 ] || die "Usage: $0 <game-id>"

GAME_ID="$1"
GAME_DIR="$REPO_ROOT/games/$GAME_ID"
[ -d "$GAME_DIR/godot" ] || die "No godot project at $GAME_DIR/godot"

GODOT="${GODOT_BIN:-godot}"
command -v "$GODOT" >/dev/null 2>&1 || die "Godot binary not found. Set GODOT_BIN or install godot."

OUT_DIR="$GAME_DIR/builds/web"
mkdir -p "$OUT_DIR"

log "Exporting $GAME_ID to web..."

cd "$GAME_DIR/godot"

# First run: import assets headlessly (Godot 4 needs this on a fresh checkout)
"$GODOT" --headless --import 2>&1 | tail -20 || true

# Export — note: requires an export_presets.cfg in the project with a "Web" preset.
# We'll handle the preset in the next phase; for now this will fail loudly if missing.
"$GODOT" --headless --export-release "Web" "$OUT_DIR/index.html"

ok "Built to $OUT_DIR"
log "Test locally: cd $OUT_DIR && python3 -m http.server 8000"
