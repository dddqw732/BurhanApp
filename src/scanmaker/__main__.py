"""Allow running the package with ``python -m scanmaker``."""

import sys
from PySide6.QtWidgets import QApplication
from PySide6.QtCore import qInstallMessageHandler, QtMsgType
from .qt_app import BurhanApp


def _qt_message_handler(mode, context, message):
    """Suppress harmless Qt font warnings."""
    if "Point size" in message and "must be greater than 0" in message:
        return
    if mode == QtMsgType.QtWarningMsg:
        print(f"Qt Warning: {message}")
    elif mode == QtMsgType.QtCriticalMsg:
        print(f"Qt Critical: {message}")
    elif mode == QtMsgType.QtFatalMsg:
        print(f"Qt Fatal: {message}")


def main():
    qInstallMessageHandler(_qt_message_handler)
    app = QApplication(sys.argv)
    app.setApplicationName("BurhanApp")
    app.setDesktopFileName("BurhanApp")
    window = BurhanApp()
    window.show()
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
