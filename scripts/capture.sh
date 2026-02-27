#!/usr/bin/env bash
# Created by Claude Opus 4.6 on 2026-02-27 10:56am EAT: ADB capture script for WIRING traces
# Usage:
#   ./capture.sh live          — Stream WIRING logs in real-time (Ctrl+C to stop)
#   ./capture.sh snapshot 200  — Grab last 200 WIRING lines from buffer
#   ./capture.sh clear         — Clear logcat buffer before a fresh run

set -euo pipefail

TRACES_DIR="$(dirname "$0")/../traces"
mkdir -p "$TRACES_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTFILE="$TRACES_DIR/trace_${TIMESTAMP}.log"

MODE="${1:-live}"
LINES="${2:-500}"

case "$MODE" in
  live)
    echo "▶ Streaming WIRING logs to: $OUTFILE"
    echo "  Press Ctrl+C to stop."
    adb logcat -s WIRING:V *:S | tee "$OUTFILE"
    ;;
  snapshot)
    echo "▶ Capturing last $LINES WIRING lines → $OUTFILE"
    adb logcat -d -s WIRING:V *:S | tail -n "$LINES" | tee "$OUTFILE"
    echo "✓ Saved $(wc -l < "$OUTFILE") lines to $OUTFILE"
    ;;
  clear)
    echo "▶ Clearing logcat buffer..."
    adb logcat -c
    echo "✓ Buffer cleared. Ready for a fresh capture."
    ;;
  *)
    echo "Usage: $0 {live|snapshot [N]|clear}"
    exit 1
    ;;
esac
