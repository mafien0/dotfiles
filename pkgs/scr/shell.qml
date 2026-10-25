//@ pragma AppId scr

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import "components"

// Background instance: `./screenshot start` brings it up, the modes are
// triggered over IPC (`./screenshot fullscreen`, `./screenshot region`).
// Region mode freezes the screen into a frame first, the picker draws that
// frame, and the saved screenshot is a crop of it.
ShellRoot {
    id: root

    property ShellScreen targetScreen: null
    property bool selecting: false
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
        if (root.selecting || shot.busy || shot.frozen)
            return;

        const screen = root.focusedScreen();
        if (!screen) {
            console.error("screenshot: no screen to capture");
            return;
        }

        root.targetScreen = screen;

        if (mode === "fullscreen")
            shot.captureFullscreen(screen.name);
        else
            shot.freeze(screen.name);
    }

    // The selection is screen-local and logical, the frozen frame is in
    // physical pixels: scale before cropping.
    function commitRegion(x: real, y: real, width: real, height: real): void {
        const screen = root.targetScreen;
        const imageWidth = selector.frozenWidth;
        const imageHeight = selector.frozenHeight;
        root.selecting = false;

        if (!screen || imageWidth <= 0 || imageHeight <= 0) {
            console.error("screenshot: frozen frame is not ready");
            shot.discardFreeze();
            return;
        }

        const scaleX = imageWidth / screen.width;
        const scaleY = imageHeight / screen.height;
        const cropX = Math.min(Math.max(0, Math.round(x * scaleX)), imageWidth - 1);
        const cropY = Math.min(Math.max(0, Math.round(y * scaleY)), imageHeight - 1);
        const cropWidth = Math.min(Math.round(width * scaleX), imageWidth - cropX);
        const cropHeight = Math.min(Math.round(height * scaleY), imageHeight - cropY);

        if (cropWidth < 1 || cropHeight < 1) {
            shot.discardFreeze();
            return;
        }

        shot.cropRegion(cropX, cropY, cropWidth, cropHeight);
    }

    function cancelRegion(): void {
        root.selecting = false;
        shot.discardFreeze();
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

        function onFrozenReady(path) {
            root.selecting = true;
        }

        function onCaptured(path) {
            console.info("screenshot: " + path);
        }

        function onFailed(message) {
            console.error("screenshot: " + message);
        }
    }

    Selector {
        id: selector

        screen: root.targetScreen
        visible: root.selecting && root.targetScreen !== null
        frozenSource: shot.frozenPath === "" ? "" : "file://" + shot.frozenPath

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
