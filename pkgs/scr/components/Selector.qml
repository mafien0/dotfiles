import QtQuick
import Quickshell
import Quickshell.Wayland

// Region picker: layer-shell surface showing the frozen frame taken before the
// picker appeared, so the selection cannot drift from what gets captured.
// Everything outside the selection is dimmed, the selection keeps a border and
// a size readout. Press, drag, release selects; right-click or Escape cancels
// (like slurp). Colors come from the config, see components/Config.qml.
PanelWindow {
    id: selector

    signal selected(real x, real y, real width, real height)
    signal cancelled()

    property color borderColor: "#7aa2f7"
    property int borderWidth: 2
    property color dimColor: "#000000"
    property real dimOpacity: 0.45
    property color readoutColor: "#eaeaf0"
    property color readoutBackground: "#cc17171c"

    // URL of the frozen frame this picker draws over the screen.
    property string frozenSource: ""

    readonly property int minimumSelection: 4

    // Pixel size of the frozen frame; the caller uses it to map the selection
    // back onto the captured image.
    readonly property real frozenWidth: frozenFrame.sourceSize.width
    readonly property real frozenHeight: frozenFrame.sourceSize.height
    readonly property bool frozenReady: frozenFrame.status === Image.Ready

    property rect selection: Qt.rect(0, 0, 0, 0)

    onFrozenSourceChanged: selector.selection = Qt.rect(0, 0, 0, 0)

    readonly property rect selectionArea: Qt.rect(
        Math.round(selector.selection.x),
        Math.round(selector.selection.y),
        Math.round(selector.selection.width),
        Math.round(selector.selection.height))

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }
    // -1 keeps the surface out of the way of other exclusive zones,
    // so its origin matches the top left corner of the screen.
    exclusiveZone: -1
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.namespace: "scr-select"
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    Item {
        id: layer

        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: selector.cancelled()

        // The freeze: the picker draws the captured frame instead of the live
        // screen. Stretched to the surface, so selection coordinates map onto
        // the frame with a plain scale factor.
        Image {
            id: frozenFrame

            anchors.fill: parent
            source: selector.frozenSource
            fillMode: Image.Stretch
            cache: false

            onStatusChanged: {
                if (frozenFrame.status === Image.Error && selector.visible) {
                    console.error("screenshot: cannot display the frozen frame");
                    selector.cancelled();
                }
            }
        }

        Rectangle {
            x: 0
            y: 0
            width: layer.width
            height: Math.max(0, selector.selectionArea.y)
            color: selector.dimColor
            opacity: selector.dimOpacity
        }

        Rectangle {
            x: 0
            y: selector.selectionArea.y + selector.selectionArea.height
            width: layer.width
            height: Math.max(0, layer.height - selector.selectionArea.y - selector.selectionArea.height)
            color: selector.dimColor
            opacity: selector.dimOpacity
        }

        Rectangle {
            x: 0
            y: selector.selectionArea.y
            width: selector.selectionArea.x
            height: selector.selectionArea.height
            color: selector.dimColor
            opacity: selector.dimOpacity
        }

        Rectangle {
            x: selector.selectionArea.x + selector.selectionArea.width
            y: selector.selectionArea.y
            width: Math.max(0, layer.width - selector.selectionArea.x - selector.selectionArea.width)
            height: selector.selectionArea.height
            color: selector.dimColor
            opacity: selector.dimOpacity
        }

        Rectangle {
            id: rectangle

            visible: selector.selectionArea.width > 0 && selector.selectionArea.height > 0
            x: selector.selectionArea.x
            y: selector.selectionArea.y
            width: selector.selectionArea.width
            height: selector.selectionArea.height
            color: "transparent"
            border.color: selector.borderColor
            border.width: selector.borderWidth
        }

        Rectangle {
            id: sizeBox

            visible: rectangle.visible
            x: Math.min(selector.selectionArea.x, layer.width - width - 8)
            y: Math.min(selector.selectionArea.y + selector.selectionArea.height + 6, layer.height - height - 8)
            width: sizeText.implicitWidth + 16
            height: sizeText.implicitHeight + 8
            radius: 4
            color: selector.readoutBackground

            Text {
                id: sizeText
                anchors.centerIn: parent
                color: selector.readoutColor
                font.pixelSize: 13
                text: selector.selectionArea.width + "x" + selector.selectionArea.height
            }
        }

        MouseArea {
            id: mouse

            anchors.fill: parent
            enabled: selector.frozenReady
            cursorShape: Qt.CrossCursor
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            property real originX: 0
            property real originY: 0
            property bool dragging: false

            onPressed: (event) => {
                if (event.button === Qt.RightButton) {
                    selector.cancelled();
                    return;
                }
                mouse.originX = event.x;
                mouse.originY = event.y;
                mouse.dragging = true;
                selector.selection = Qt.rect(0, 0, 0, 0);
            }

            onPositionChanged: (event) => {
                if (mouse.dragging)
                    selector.selection = selector.normalize(mouse.originX, mouse.originY, event.x, event.y);
            }

            onReleased: (event) => {
                if (!mouse.dragging)
                    return;
                mouse.dragging = false;

                const area = selector.normalize(mouse.originX, mouse.originY, event.x, event.y);
                if (area.width < selector.minimumSelection || area.height < selector.minimumSelection) {
                    selector.cancelled();
                    return;
                }
                selector.selected(area.x, area.y, area.width, area.height);
            }
        }
    }

    function normalize(x1: real, y1: real, x2: real, y2: real): rect {
        return Qt.rect(Math.min(x1, x2), Math.min(y1, y2), Math.abs(x2 - x1), Math.abs(y2 - y1));
    }
}
