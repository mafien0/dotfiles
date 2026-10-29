import QtQuick
import Quickshell
import Quickshell.Io

// Location parser: reads `~/.config/scr/config.toml` (flat `key = value` pairs)
// and makes sure the save directory exists. The file itself is created by the
// `screenshot` launcher.
QtObject {
    id: config

    signal resolved()

    readonly property string homeDir: Quickshell.env("HOME") ?? "/home"
    readonly property string configPath: (Quickshell.env("XDG_CONFIG_HOME") ?? config.homeDir + "/.config") + "/scr/config.toml"

    readonly property string defaultSaveDir: config.homeDir + "/Pictures/Screenshots"
    readonly property color defaultBorderColor: "#7aa2f7"
    readonly property int defaultBorderWidth: 2
    readonly property color defaultDimColor: "#000000"
    readonly property real defaultDimOpacity: 0.45
    readonly property color defaultReadoutColor: "#eaeaf0"
    readonly property color defaultReadoutBackground: "#cc17171c"

    property bool ready: false
    property string saveDir: config.defaultSaveDir
    property color borderColor: config.defaultBorderColor
    property int borderWidth: config.defaultBorderWidth
    property color dimColor: config.defaultDimColor
    property real dimOpacity: config.defaultDimOpacity
    property color readoutColor: config.defaultReadoutColor
    property color readoutBackground: config.defaultReadoutBackground
    property string createdDir: ""

    readonly property FileView file: FileView {
        path: config.configPath
        preload: true
        watchChanges: true
        printErrors: false

        onLoaded: config.apply()
        onLoadFailed: (error) => config.apply()
        onFileChanged: config.apply()
    }

    readonly property Process mkdir: Process {
        onExited: (code, status) => {
            if (code !== 0)
                console.error("screenshot: cannot create " + config.saveDir);
        }
    }

    function apply(): void {
        const values = config.parse(config.file.text());

        config.saveDir = config.expandHome(config.textValue(values, "save_dir", config.defaultSaveDir));
        config.borderColor = config.colorValue(values, "border_color", config.defaultBorderColor);
        config.borderWidth = Math.max(0, Math.round(config.numberValue(values, "border_width", config.defaultBorderWidth)));
        config.dimColor = config.colorValue(values, "dim_color", config.defaultDimColor);
        config.dimOpacity = Math.min(1, Math.max(0, config.numberValue(values, "dim_opacity", config.defaultDimOpacity)));
        config.readoutColor = config.colorValue(values, "readout_color", config.defaultReadoutColor);
        config.readoutBackground = config.colorValue(values, "readout_background", config.defaultReadoutBackground);

        if (config.saveDir !== config.createdDir) {
            config.createdDir = config.saveDir;
            config.mkdir.exec(["mkdir", "-p", config.saveDir]);
        }

        config.ready = true;
        config.resolved();
    }

    function textValue(values: var, key: string, fallback: string): string {
        const raw = values[key];
        return (raw === undefined || raw === "") ? fallback : raw;
    }

    function numberValue(values: var, key: string, fallback: real): real {
        const raw = values[key];
        if (raw === undefined || raw === "")
            return fallback;
        const parsed = Number(raw);
        if (isNaN(parsed)) {
            console.error("screenshot: " + key + " is not a number: " + raw);
            return fallback;
        }
        return parsed;
    }

    function colorValue(values: var, key: string, fallback: color): color {
        const raw = values[key];
        if (raw === undefined || raw === "")
            return fallback;
        if (!/^(#[0-9a-fA-F]{3,8}|[a-zA-Z]+)$/.test(raw)) {
            console.error("screenshot: " + key + " is not a color: " + raw);
            return fallback;
        }
        return raw;
    }

    function expandHome(path: string): string {
        if (path === "~")
            return config.homeDir;
        if (path.startsWith("~/"))
            return config.homeDir + path.slice(1);
        return path;
    }

    function stripComment(line: string): string {
        let quote = "";
        for (let i = 0; i < line.length; i++) {
            const c = line[i];
            if (quote !== "") {
                if (c === "\\")
                    i++;
                else if (c === quote)
                    quote = "";
            } else if (c === "\"" || c === "'") {
                quote = c;
            } else if (c === "#") {
                return line.slice(0, i);
            }
        }
        return line;
    }

    function unquote(value: string): string {
        const v = value.trim();
        if (v.length >= 2) {
            const first = v[0];
            const last = v[v.length - 1];
            if ((first === "\"" && last === "\"") || (first === "'" && last === "'"))
                return v.slice(1, -1);
        }
        return v;
    }

    function parse(text: string): var {
        const values = {};
        for (const raw of text.split("\n")) {
            const line = config.stripComment(raw).trim();
            const eq = line.indexOf("=");
            if (eq <= 0)
                continue;
            values[line.slice(0, eq).trim()] = config.unquote(line.slice(eq + 1));
        }
        return values;
    }
}
