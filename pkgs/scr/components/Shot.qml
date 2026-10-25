import QtQuick
import Quickshell
import Quickshell.Io

// Runs grim. One capture at a time; screenshots are named by timestamp.
QtObject {
    id: shot

    property string saveDir
    property bool busy: false

    signal captured(string path)
    signal failed(string message)

    readonly property Process grim: Process {
        stderr: StdioCollector {
            id: grimError
        }

        onExited: (code, status) => {
            shot.watchdog.stop();
            shot.busy = false;
            if (code === 0) {
                shot.captured(shot.pendingPath);
            } else {
                const message = grimError.text.trim();
                shot.failed(message !== "" ? message : "grim exited with " + code);
            }
        }
    }

    readonly property Timer watchdog: Timer {
        interval: 10000
        onTriggered: {
            shot.busy = false;
            shot.failed("grim did not finish");
        }
    }

    property string pendingPath: ""

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

    function targetPath(): string {
        return shot.saveDir + "/screenshot-" + Qt.formatDateTime(new Date(), "yyyy-MM-dd_HH-mm-ss.zzz") + ".png";
    }
}
