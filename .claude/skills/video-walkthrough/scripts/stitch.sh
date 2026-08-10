#!/bin/bash
# stitch.sh — crossfade-concatenate N video clips into one output.
#
# Usage: stitch.sh <crossfade_seconds> <output.mp4> <clip1> <clip2> [clip3 ...]
#
# Reads each clip's ACTUAL duration via ffprobe and computes the xfade
# offsets from that, so clips don't need to be the same length.
# Video-only (no audio track) — add background music as a separate
# step after stitching (see reference.md).
set -e

if [ "$#" -lt 4 ]; then
  echo "Usage: $0 <crossfade_seconds> <output.mp4> <clip1> <clip2> [clip3 ...]" >&2
  exit 1
fi

XFADE="$1"
OUT="$2"
shift 2
CLIPS=("$@")
N=${#CLIPS[@]}

INPUTS=()
for c in "${CLIPS[@]}"; do
  INPUTS+=(-i "$c")
done

FILTER=""
PREV="0:v"
RUNNING=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "${CLIPS[0]}")

for ((i = 1; i < N; i++)); do
  DUR=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "${CLIPS[$i]}")
  OFFSET=$(awk -v r="$RUNNING" -v x="$XFADE" 'BEGIN { printf "%.6f", r - x }')
  NEXT="v$i"
  if [ "$i" -eq $((N - 1)) ]; then
    NEXT="vout"
  fi
  FILTER+="[$PREV][$i:v]xfade=transition=fade:duration=$XFADE:offset=$OFFSET[$NEXT];"
  PREV="$NEXT"
  RUNNING=$(awk -v r="$RUNNING" -v d="$DUR" -v x="$XFADE" 'BEGIN { printf "%.6f", r + d - x }')
done

FILTER=${FILTER%;}

ffmpeg -y "${INPUTS[@]}" -filter_complex "$FILTER" -map "[vout]" \
  -c:v libx264 -pix_fmt yuv420p -crf 18 -preset medium "$OUT" -loglevel error

echo "Stitched $N clips -> $OUT"
ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$OUT"
