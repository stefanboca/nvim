local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.term = "wezterm"
config.check_for_updates = false

config.front_end = "WebGpu"

config.scrollback_lines = 10000

-- Appearence
config.color_scheme = "Tokyo Night"

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)

config.colors = {
	background = "000000",
}

config.inactive_pane_hsb = {
	brightness = 0.85,
}
config.window_background_opacity = 0.7
config.text_background_opacity = 0.5

config.font = wezterm.font_with_fallback({ { family = "Fira Code" }, { family = "FiraCode Nerd Font" } })
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
config.default_cursor_style = "SteadyBlock"

-- Keys
local act = wezterm.action
config.leader = { key = " ", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Pass <C-Space> to pane if repeated
	{ key = " ", mods = "LEADER|CTRL", action = act.SendKey({ key = " ", mods = "CTRL" }) },

	-- Open Command Palette
	{ key = ":", mods = "LEADER|SHIFT", action = act.ActivateCommandPalette },

	-- Pane Navigation
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "q", mods = "LEADER", action = act.PaneSelect },

	-- Pane Manipulation
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "o", mods = "LEADER|CTRL", action = act.RotatePanes("CounterClockwise") },
	{ key = "o", mods = "LEADER|ALT", action = act.RotatePanes("Clockwise") },
	-- Pane Splitting
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Right", top_level = true }) },
	{ key = "_", mods = "LEADER|SHIFT", action = act.SplitPane({ direction = "Down", top_level = true }) },
	{ key = "\\", mods = "LEADER", action = act.SplitPane({ direction = "Right", top_level = false }) },
	{ key = "-", mods = "LEADER", action = act.SplitPane({ direction = "Down", top_level = false }) },

	-- Tab Navigation
	{ key = "w", mods = "LEADER", action = act.ShowTabNavigator },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },

	-- Tab Manipulation
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },

	-- Fullscreen
	{ key = "F11", action = act.ToggleFullScreen },

	-- Copy mode
	{ key = "[", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "]", mods = "LEADER", action = act.PasteFrom("Clipboard") },
}
for i = 0, 9 do
	-- <LEADER-i> to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i),
	})
end
-- config.debug_key_events = true

return config
