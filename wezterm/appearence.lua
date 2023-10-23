local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	config.color_scheme = "Tokyo Night Storm"
	config.font = wezterm.font({ family = "Fira Code" })
	config.font_size = 10
end

return M
