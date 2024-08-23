local wezterm = require("wezterm")

local M = {}

function M.apply(config)
	config.color_scheme = "Catppuccin Macchiato"
	config.font = wezterm.font_with_fallback({ { family = "Fira Code" }, { family = "FiraCode Nerd Font" } })
	config.font_size = 10

	config.inactive_pane_hsb = {
		brightness = 0.85,
	}

	config.use_fancy_tab_bar = false
	config.tab_bar_at_bottom = true
	config.tab_and_split_indices_are_zero_based = true

	config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}

	config.default_cursor_style = "BlinkingBlock"
end

return M
