#!/bin/bash

# ─── Настройки ────────────────────────────────────────────────────────────────
OFFSET_1="30%"   # смещение воспроизведения для монитора 0
OFFSET_2="50%"   # смещение воспроизведения для монитора 1
OFFSET_3="70%"   # смещение воспроизведения для монитора 2

SCREEN_1=0
SCREEN_2=1
SCREEN_3=2

MPV_OPTS="--vo=gpu --gpu-api=opengl --loop-file"
# ──────────────────────────────────────────────────────────────────────────────

PID_FILE="/tmp/xplay.pids"
SOCK_0="/tmp/xplay-mpv-0.sock"
SOCK_1="/tmp/xplay-mpv-1.sock"
SOCK_2="/tmp/xplay-mpv-2.sock"

if [[ -z "$1" ]]; then
    echo "Usage: xplay <video_file>" >&2
    exit 1
fi

FILE="$1"

if [[ ! -f "$FILE" ]]; then
    echo "File not found: $FILE" >&2
    exit 1
fi

if [[ -f "$PID_FILE" ]]; then
    while read -r pid; do
        kill "$pid" 2>/dev/null
    done < "$PID_FILE"
    rm -f "$PID_FILE"
fi

rm -f "$SOCK_0" "$SOCK_1" "$SOCK_2"

mpv $MPV_OPTS --screen=$SCREEN_3 --fs --mute --start=$OFFSET_3 --input-ipc-server="$SOCK_2" "$FILE" &
echo $! >> "$PID_FILE"
sleep 0.1

mpv $MPV_OPTS --screen=$SCREEN_1 --fs --mute --start=$OFFSET_1 --input-ipc-server="$SOCK_0" "$FILE" &
echo $! >> "$PID_FILE"
sleep 0.1

mpv $MPV_OPTS --screen=$SCREEN_2 --fs --mute --start=$OFFSET_2 --input-ipc-server="$SOCK_1" "$FILE" &
echo $! >> "$PID_FILE"
sleep 0.1

