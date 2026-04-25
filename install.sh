#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
SERVICE_MENU_DIR="$HOME/.local/share/kio/servicemenus"
NEMO_ACTIONS_DIR="$HOME/.local/share/nemo/actions"
APPLICATIONS_DIR="$HOME/.local/share/applications"

echo "Installing XPlay..."

mkdir -p "$BIN_DIR" "$SERVICE_MENU_DIR" "$NEMO_ACTIONS_DIR" "$APPLICATIONS_DIR"

install -m 755 "$SCRIPT_DIR/xplay.sh"      "$BIN_DIR/xplay"
install -m 755 "$SCRIPT_DIR/xplay-kill.sh" "$BIN_DIR/xplay-kill"
install -m 755 "$SCRIPT_DIR/xplay-seek.sh" "$BIN_DIR/xplay-seek"

if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo "  Note: add $HOME/.local/bin to your PATH (e.g. in ~/.bashrc or ~/.profile)"
fi

cat > "$SERVICE_MENU_DIR/xplay.desktop" << EOF
[Desktop Entry]
Type=Service
X-KDE-ServiceTypes=KonqPopupMenu/Plugin
MimeType=video/*;
Actions=xplay_open
X-KDE-StartupNotify=false
X-KDE-Priority=TopLevel

[Desktop Action xplay_open]
Name=Play on 3 Monitors (XPlay)
Icon=video-display
Exec=$BIN_DIR/xplay %F
EOF
chmod +x "$SERVICE_MENU_DIR/xplay.desktop"

cat > "$NEMO_ACTIONS_DIR/xplay.nemo_action" << EOF
[Nemo Action]
Name=Play on 3 Monitors (XPlay)
Comment=Play video on 3 monitors simultaneously
Exec=$BIN_DIR/xplay %F
Icon-Name=video-display
Selection=Any
Mimetypes=video/*;
EOF

cat > "$APPLICATIONS_DIR/xplay.desktop" << EOF
[Desktop Entry]
Type=Application
Name=XPlay
Comment=Play video on 3 monitors simultaneously
Exec=$BIN_DIR/xplay %F
Icon=video-display
Categories=AudioVideo;Video;Player;
MimeType=video/*;
Terminal=false
NoDisplay=false
EOF

if command -v update-desktop-database &>/dev/null; then
    update-desktop-database "$APPLICATIONS_DIR" 2>/dev/null
fi

if command -v kbuildsycoca6 &>/dev/null; then
    kbuildsycoca6 --noincremental 2>/dev/null &
fi

echo ""
echo "XPlay installed successfully!"
echo ""
echo "Dolphin:  ПКМ по видео → 'Play on 3 Monitors (XPlay)'"
echo "Nemo:     ПКМ по видео → 'Play on 3 Monitors (XPlay)'"
echo "Открыть с помощью: XPlay появится в списке приложений рядом с mpv"
echo ""
echo "─── Настройте глобальные хоткеи вручную ──────────────────────────────"
echo "  System Settings → Shortcuts → Custom Shortcuts → Edit → New → Command"
echo ""
echo "  Действие            Команда"
echo "  ─────────────────────────────────────────────────────────────────────"
echo "  Kill all instances  $BIN_DIR/xplay-kill"
echo "  Seek forward  +60s  $BIN_DIR/xplay-seek 60"
echo "  Seek backward -60s  $BIN_DIR/xplay-seek -60"
echo "──────────────────────────────────────────────────────────────────────"
