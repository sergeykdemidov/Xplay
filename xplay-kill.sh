#!/bin/bash

PID_FILE="/tmp/xplay.pids"

if [[ ! -f "$PID_FILE" ]]; then
    exit 0
fi

while read -r pid; do
    kill "$pid" 2>/dev/null
done < "$PID_FILE"

rm -f "$PID_FILE"
