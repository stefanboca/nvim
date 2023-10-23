local wezterm = require("wezterm")

local config = wezterm.config_builder()

require("front_end").apply(config)
require("appearence").apply(config)
require("keys").apply(config)

return config
