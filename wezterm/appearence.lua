local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	config.color_scheme = "Tokyo Night"
	config.font = wezterm.font({ family = "Fira Code" })
	config.font_size = 10

	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
end

return M
