#!/usr/bin/env bash
# clip.sh — cut a vertical 9:16 clip from a recording
# Usage: ./tools/clip.sh <game-id> <input-file> <start> <end> [label]
#   start/end: HH:MM:SS or MM:SS
#   label: optional, becomes part of output filename

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib/common.sh"

require_cmd ffmpeg

[ "$#" -ge 4 ] || die "Usage: $0 <game-id> <input-file> <start> <end> [label]"

GAME_ID="$1"
INPUT="$2"
START="$3"
END="$4"
LABEL="${5:-clip}"

GAME_DIR="$REPO_ROOT/games/$GAME_ID"
[ -d "$GAME_DIR" ] || die "Game not found: $GAME_ID"

OUT_DIR="$GAME_DIR/content/clips"
mkdir -p "$OUT_DIR"

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
OUTPUT="$OUT_DIR/${TIMESTAMP}-${LABEL}.mp4"

log "Cutting $INPUT [$START → $END] to vertical 9:16..."

# - cut to range
# - scale to 1080 height keeping aspect, then pad/crop to 1080x1920
# - re-encode for compatibility
ffmpeg -y -ss "$START" -to "$END" -i "$INPUT" \
  -vf "scale=-2:1920,crop=1080:1920:(iw-1080)/2:0,setsar=1" \
  -c:v libx264 -preset medium -crf 20 \
  -c:a aac -b:a 128k \
  -movflags +faststart \
  "$OUTPUT" 2>&1 | tail -5

ok "Wrote $OUTPUT"
