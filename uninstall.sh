#!/bin/bash

BIN_DIR="$HOME/.local/bin"
SERVICE_MENU_DIR="$HOME/.local/share/kio/servicemenus"
NEMO_ACTIONS_DIR="$HOME/.local/share/nemo/actions"
APPLICATIONS_DIR="$HOME/.local/share/applications"

echo "Uninstalling XPlay..."

if [[ -f "/tmp/xplay.pids" ]]; then
    while read -r pid; do
        kill "$pid" 2>/dev/null
    done < "/tmp/xplay.pids"
    rm -f "/tmp/xplay.pids"
fi

rm -f "$BIN_DIR/xplay"
rm -f "$BIN_DIR/xplay-kill"
rm -f "$BIN_DIR/xplay-seek"
rm -f "$SERVICE_MENU_DIR/xplay.desktop"
rm -f "$NEMO_ACTIONS_DIR/xplay.nemo_action"
rm -f "$APPLICATIONS_DIR/xplay.desktop"
rm -f /tmp/xplay-mpv-{0,1,2}.sock

if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$APPLICATIONS_DIR" 2>/dev/null
fi

if command -v kbuildsycoca6 &>/dev/null; then
    kbuildsycoca6 --noincremental 2>/dev/null &
fi

echo "XPlay uninstalled."
echo ""
echo "Не забудьте вручную удалить хоткеи в:"
echo "  System Settings → Shortcuts → Custom Shortcuts"
