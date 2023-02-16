local wezterm = require("wezterm");
return {
    font = wezterm.font {
        family = "Fira Code",
    },
    font_size = 11,
    color_scheme = "Lunar",
    color_schemes = require("color_schemes"),
    keys = {
        { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
    },
    enable_wayland = false,
    front_end = "WebGpu",
}
