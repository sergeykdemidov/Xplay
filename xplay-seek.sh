#!/usr/bin/env python3
import socket, json, sys, os

SOCKETS = [
    "/tmp/xplay-mpv-0.sock",
    "/tmp/xplay-mpv-1.sock",
    "/tmp/xplay-mpv-2.sock",
]

if len(sys.argv) < 2:
    print("Usage: xplay-seek <seconds>", file=sys.stderr)
    sys.exit(1)

amount = int(sys.argv[1])
cmd = json.dumps({"command": ["seek", amount]}).encode() + b"\n"

for path in SOCKETS:
    if not os.path.exists(path):
        continue
    try:
        s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        s.settimeout(1)
        s.connect(path)
        s.sendall(cmd)
        s.close()
    except Exception:
        pass
