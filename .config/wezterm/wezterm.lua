local wezterm = require("wezterm");
return {
    font = wezterm.font {
        family = "Fira Code",
    },
    enable_wayland = false,
    front_end = "WebGpu",
    color_scheme = "Lunar",
    color_schemes = {
        ["Lunar"] = {
            foreground = "#c0caf5",
            background = "#1a1b26",

            cursor_bg = "#c0caf5",
            cursor_fg = "#1a1b26",

            cursor_border = "#c0caf5",

            ansi = {
                "#000000",
                "#db4b4b",
                "#41a6b5",
                "#e0af68",
                "#7dcfff",
                "#9d7cd8",
                "#0db9d7",
                "#a9b1d6",
            },
            brights = {
                "#000000",
                "#f7768e",
                "#73daca",
                "#ff9e64",
                "#89ddff",
                "#bb9af7",
                "#2AC3DE",
                "#c0caf5",
            },
        }
    }
}
