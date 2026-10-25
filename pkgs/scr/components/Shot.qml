import QtQuick
import Quickshell
import Quickshell.Io

// Runs grim, then copies the file it wrote to the clipboard. One capture at a
// time; screenshots are named by timestamp.
QtObject {
    id: shot

    property string saveDir
    property bool busy: false

    signal captured(string path)
    signal failed(string message)

    property string pendingPath: ""

    readonly property Process grim: Process {
        stderr: StdioCollector {
            id: grimError
        }

        onExited: (code, status) => {
            if (code !== 0) {
                const message = grimError.text.trim();
                shot.fail(message !== "" ? message : "grim exited with " + code);
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
            shot.finish();
            if (code !== 0) {
                const message = clipboardError.text.trim();
                shot.failed(message !== "" ? "clipboard copy failed: " + message : "clipboard copy failed: wl-copy exited with " + code);
            }
        }
    }

    readonly property Timer watchdog: Timer {
        interval: 10000
        onTriggered: shot.fail("capture did not finish")
    }

    function captureFullscreen(screenName: string): void {
        shot.run(["-o", screenName]);
    }

    function captureRegion(x: int, y: int, width: int, height: int): void {
        shot.run(["-g", x + "," + y + " " + width + "x" + height]);
    }

    function run(args: var): void {
        if (shot.busy)
            return;

        shot.busy = true;
        shot.pendingPath = shot.targetPath();
        shot.watchdog.restart();
        shot.grim.exec(["grim"].concat(args).concat([shot.pendingPath]));
    }

    function finish(): void {
        shot.watchdog.stop();
        shot.busy = false;
        shot.captured(shot.pendingPath);
    }

    function fail(message: string): void {
        shot.watchdog.stop();
        shot.busy = false;
        shot.failed(message);
    }

    function targetPath(): string {
        return shot.saveDir + "/screenshot-" + Qt.formatDateTime(new Date(), "yyyy-MM-dd_HH-mm-ss.zzz") + ".png";
    }
}