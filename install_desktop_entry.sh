#!/bin/bash
set -e

# Directory where BurhanApp is located
APP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_PATH="$APP_DIR/BurhanApp"
ICON_SRC="$APP_DIR/assets/BurhanApp_Icon_256.png"

if [ ! -f "$ICON_SRC" ]; then
    ICON_SRC="$APP_DIR/BurhanApp_Icon_256.png"
fi

if [ ! -f "$ICON_SRC" ]; then
    ICON_SRC="$APP_DIR/assets/BurhanApp_Icon.png"
fi

DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
ICON_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons/hicolor/256x256/apps"

mkdir -p "$DESKTOP_DIR"
mkdir -p "$ICON_DIR"

if [ -f "$ICON_SRC" ]; then
    cp "$ICON_SRC" "$ICON_DIR/burhanapp.png"
fi

cat > "$DESKTOP_DIR/burhanapp.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=BurhanApp
GenericName=PDF Annotation & Scan Tool
Comment=A modern PDF annotation and scan-generation tool
Exec="$BIN_PATH" %U
Icon=burhanapp
Terminal=false
Categories=Office;Graphics;Viewer;
MimeType=application/pdf;image/png;image/jpeg;
StartupWMClass=BurhanApp
EOF

chmod +x "$DESKTOP_DIR/burhanapp.desktop"

if command -v update-desktop-database > /dev/null 2>&1; then
    update-desktop-database "$DESKTOP_DIR"
fi

echo "=========================================================="
echo "BurhanApp has been integrated into your applications menu!"
echo "You can now launch BurhanApp from your application launcher"
echo "or run: $BIN_PATH"
echo "=========================================================="
