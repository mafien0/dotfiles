//@ pragma AppId scr

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import "components"

// Background instance: `./screenshot start` brings it up, the modes are
// triggered over IPC (`./screenshot fullscreen`, `./screenshot region`).
ShellRoot {
    id: root

    // Let the compositor unmap the picker before grim reads the screen back.
    readonly property int unmapDelay: 160

    property ShellScreen targetScreen: null
    property bool selecting: false
    property bool pendingRegion: false
    property var pendingRegionRect: null
    property string queuedMode: ""

    function focusedScreen(): ShellScreen {
        const monitor = Hyprland.focusedMonitor;
        if (monitor) {
            for (const screen of Quickshell.screens) {
                if (screen.name === monitor.name)
                    return screen;
            }
        }
        return Quickshell.screens[0] ?? null;
    }

    function request(mode: string): void {
        if (!config.ready) {
            root.queuedMode = mode;
            return;
        }
        root.trigger(mode);
    }

    function trigger(mode: string): void {
        const screen = root.focusedScreen();
        if (!screen) {
            console.error("screenshot: no screen to capture");
            return;
        }

        root.targetScreen = screen;

        if (mode === "fullscreen")
            shot.captureFullscreen(screen.name);
        else
            root.selecting = true;
    }

    function commitRegion(x: real, y: real, width: real, height: real): void {
        const screen = root.targetScreen;
        root.selecting = false;

        const region = [
            Math.round(screen.x + x),
            Math.round(screen.y + y),
            Math.round(width),
            Math.round(height)
        ];
        if (region[2] < 1 || region[3] < 1)
            return;

        root.pendingRegionRect = region;
        unmapTimer.restart();
    }

    function cancelRegion(): void {
        root.selecting = false;
        console.info("screenshot: selection cancelled");
    }

    Config {
        id: config
    }

    Connections {
        target: config

        function onResolved() {
            if (root.queuedMode === "")
                return;
            const mode = root.queuedMode;
            root.queuedMode = "";
            root.trigger(mode);
        }
    }

    Shot {
        id: shot
        saveDir: config.saveDir
    }

    Connections {
        target: shot

        function onCaptured(path) {
            console.info("screenshot: " + path);
        }

        function onFailed(message) {
            console.error("screenshot: " + message);
        }
    }

    Timer {
        id: unmapTimer
        interval: root.unmapDelay
        onTriggered: {
            const region = root.pendingRegionRect;
            root.pendingRegionRect = null;
            if (region)
                shot.captureRegion(region[0], region[1], region[2], region[3]);
        }
    }

    Selector {
        id: selector

        screen: root.targetScreen
        visible: root.selecting && root.targetScreen !== null

        borderColor: config.borderColor
        borderWidth: config.borderWidth
        dimColor: config.dimColor
        dimOpacity: config.dimOpacity
        readoutColor: config.readoutColor
        readoutBackground: config.readoutBackground

        onSelected: (x, y, width, height) => root.commitRegion(x, y, width, height)
        onCancelled: root.cancelRegion()
    }

    IpcHandler {
        target: "screenshot"

        function fullscreen(): void {
            root.request("fullscreen");
        }

        function region(): void {
            root.request("region");
        }

        function quit(): void {
            Qt.quit();
        }
    }
}
