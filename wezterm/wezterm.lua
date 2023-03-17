local wezterm = require("wezterm")
local vim = require("vim")

local keys = {
    -- { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
}

vim.setup(keys)

-- TODO: each module exports an object containing some config, which all get merged
return {
    font = wezterm.font {
        family = "Fira Code",
    },
    font_size = 10,
    color_scheme = "Lunar",
    color_schemes = require("color_schemes"),
    keys = keys,
}
