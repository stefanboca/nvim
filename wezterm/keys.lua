local wezterm = require("wezterm")

local M = {}

function M.apply(config)
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

		-- Clears the scrollback, then sends CTRL-L to ask the shell to redraw its prompt
		{
			key = "l",
			mods = "CTRL",
			action = act.Multiple({
				act.ClearScrollback("ScrollbackOnly"),
				act.SendKey({ key = "L", mods = "CTRL" }),
			}),
		},
	}

	for i = 0, 9 do
		-- <LEADER-i> to activate that tab
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = act.ActivateTab(i),
		})
	end
end

return M
