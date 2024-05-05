local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	config.color_scheme = "Tokyo Night"
	config.font = wezterm.font({ family = "Fira Code" })
	config.font_size = 10

	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.tab_and_split_indices_are_zero_based = true

	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
end

return M
