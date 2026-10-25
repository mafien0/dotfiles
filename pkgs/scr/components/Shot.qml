// MADE BY CLANKER
import QtQuick
import Quickshell
import Quickshell.Io

// Capture backend. Two paths share one pipeline:
//   * fullscreen: grim grabs the screen straight into the output file;
//   * region: grim freezes the screen into a temporary frame first, the picker
//     shows that frame, and magick crops the selection back out of it, so the
//     screenshot always matches what was on screen while selecting.
// The finished file is copied to the clipboard. One capture at a time;
// screenshots are named by timestamp.
QtObject {
    id: shot

    property string saveDir
    property bool busy: false
    // Set once a frozen full-screen frame is on disk and waiting for a
    // selection; empty otherwise.
    property string frozenPath: ""

    signal captured(string path)
    signal failed(string message)
    signal frozenReady(string path)

    property string pendingPath: ""
    // Frame grim is still writing for an in-flight freeze.
    property string pendingFreeze: ""

    readonly property string runtimeDir: Quickshell.env("XDG_RUNTIME_DIR") ?? "/tmp"

    readonly property bool frozen: frozenPath !== ""

    // Freezes the screen for the region picker.
    readonly property Process freezeProcess: Process {
        stderr: StdioCollector {
            id: freezeError
        }

        onExited: (code, status) => {
            shot.watchdog.stop();
            shot.busy = false;

            const path = shot.pendingFreeze;
            shot.pendingFreeze = "";
            if (code !== 0) {
                shot.remove(path);
                const message = freezeError.text.trim();
                shot.failed(message !== "" ? message : "grim exited with " + code);
                return;
            }

            shot.frozenPath = path;
            shot.frozenReady(path);
        }
    }

    // Writes the file that ends up on disk: grim for fullscreen, magick for a
    // crop of the frozen frame.
    readonly property Process producer: Process {
        stderr: StdioCollector {
            id: producerError
        }

        onExited: (code, status) => {
            if (code !== 0) {
                const message = producerError.text.trim();
                shot.fail(message !== "" ? message : "capture tool exited with " + code);
                return;
            }
            shot.clipboard.exec(["bash", "-c", "exec wl-copy --type image/png < \"$1\"", "bash", shot.pendingPath]);
        }
    }

    readonly property Process clipboard: Process {
        stderr: StdioCollector {
            id: clipboardError
        }

        onExited: (code, status) => {
            const path = shot.pendingPath;
            shot.reset();
            if (code !== 0) {
                const message = clipboardError.text.trim();
                shot.failed(message !== "" ? message : "clipboard copy failed: wl-copy exited with " + code);
                return;
            }
            shot.notify(path);
            shot.captured(path);
        }
    }

    // Fire and forget: a missing notification daemon must not fail the capture.
    readonly property Process notifier: Process {
        stderr: StdioCollector {
            id: notifyError
        }

        onExited: (code, status) => {
            if (code === 0)
                return;
            const message = notifyError.text.trim();
            console.warn("screenshot: notification failed: " + (message !== "" ? message : "notify-send exited with " + code));
        }
    }

    readonly property Process cleanup: Process {}

    readonly property Timer watchdog: Timer {
        interval: 10000
        onTriggered: shot.fail("capture did not finish")
    }

    function captureFullscreen(screenName: string): void {
        if (shot.busy || shot.frozen)
            return;

        shot.busy = true;
        shot.pendingPath = shot.targetPath();
        shot.watchdog.restart();
        shot.producer.exec(["grim", "-o", screenName, shot.pendingPath]);
    }

    function freeze(screenName: string): void {
        if (shot.busy || shot.frozen)
            return;

        shot.busy = true;
        shot.pendingFreeze = shot.runtimeDir + "/scr-freeze-" + Date.now() + ".png";
        shot.watchdog.restart();
        shot.freezeProcess.exec(["grim", "-o", screenName, shot.pendingFreeze]);
    }

    // x/y/width/height are in the frozen frame's pixels.
    function cropRegion(x: int, y: int, width: int, height: int): void {
        const source = shot.frozenPath;
        if (source === "" || shot.busy)
            return;

        shot.busy = true;
        shot.pendingPath = shot.targetPath();
        shot.watchdog.restart();
        shot.producer.exec(["magick", source, "-crop", width + "x" + height + "+" + x + "+" + y, "+repage", shot.pendingPath]);
    }

    function notify(path: string): void {
        shot.notifier.exec(["notify-send", "-a", "scr", "-i", path, "Screenshot saved", path]);
    }

    function discardFreeze(): void {
        shot.reset();
    }

    function reset(): void {
        const stale = [shot.pendingFreeze, shot.frozenPath];
        shot.watchdog.stop();
        shot.busy = false;
        shot.pendingFreeze = "";
        shot.frozenPath = "";
        for (const path of stale)
            shot.remove(path);
    }

    function fail(message: string): void {
        shot.reset();
        shot.failed(message);
    }

    function remove(path: string): void {
        if (path !== "")
            shot.cleanup.exec(["rm", "-f", path]);
    }

    function targetPath(): string {
        return shot.saveDir + "/screenshot-" + Qt.formatDateTime(new Date(), "yyyy-MM-dd_HH-mm-ss.zzz") + ".png";
    }
}
