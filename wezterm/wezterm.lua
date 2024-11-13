local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.term = "wezterm"
config.check_for_updates = false

config.front_end = "WebGpu"

config.scrollback_lines = 10000

-- Appearence
config.color_scheme = "Tokyo Night"

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config, {
	padding = { left = 1, right = 1 },
})

config.inactive_pane_hsb = {
	brightness = 0.85,
}
config.window_background_opacity = 0.8
config.text_background_opacity = 0.5
config.font = wezterm.font({ family = "Lilex", harfbuzz_features = { "cv09", "cv10", "cv11", "ss01" } })
config.font_size = 10

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.default_cursor_style = "SteadyBlock"

-- Workspace
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.zoxide_path = "/home/doctorwho/.cargo/bin/zoxide"
config.default_workspace = "~"

-- config.unix_domains = { { name = "unix" } }

-- local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
-- wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
-- 	local workspace_state = resurrect.workspace_state
-- 	resurrect.save_state(workspace_state.get_workspace_state())
-- end)

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
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
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

	-- Workspace
	{ key = "z", mods = "LEADER", action = workspace_switcher.switch_workspace() },

	-- {
	-- 	key = "s",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.save_state(resurrect.workspace_state.get_workspace_state())
	-- 		resurrect.window_state.save_window_action()
	-- 	end),
	-- },
	-- {
	-- 	key = "r",
	-- 	mods = "LEADER",
	-- 	action = wezterm.action_callback(function(win, pane)
	-- 		resurrect.fuzzy_load(win, pane, function(id, label)
	-- 			local type = string.match(id, "^([^/]+)") -- match before '/'
	-- 			id = string.match(id, "([^/]+)$") -- match after '/'
	-- 			id = string.match(id, "(.+)%..+$") -- remove file extention
	-- 			local opts = {
	-- 				relative = true,
	-- 				restore_text = true,
	-- 				on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	-- 			}
	-- 			if type == "workspace" then
	-- 				local state = resurrect.load_state(id, "workspace")
	-- 				resurrect.workspace_state.restore_workspace(state, opts)
	-- 			elseif type == "window" then
	-- 				local state = resurrect.load_state(id, "window")
	-- 				resurrect.window_state.restore_window(pane:window(), state, opts)
	-- 			elseif type == "tab" then
	-- 				local state = resurrect.load_state(id, "tab")
	-- 				resurrect.tab_state.restore_tab(pane:tab(), state, opts)
	-- 			end
	-- 		end)
	-- 	end),
	-- },

	-- Domain
	{ key = "a", mods = "LEADER", action = act.AttachDomain("unix") },
	{ key = "d", mods = "LEADER", action = act.DetachDomain({ DomainName = "unix" }) },
}
for i = 1, 9 do
	-- <LEADER-i> to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end
-- config.debug_key_events = true

return config
