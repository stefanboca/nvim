local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- config.term = "wezterm"
config.check_for_updates = false

local modules = {
	"front_end",
	"appearence",
	"bell",
	"keys",
}

for _, module in ipairs(modules) do
	require(module).apply(config)
end

-- config.debug_key_events = true

return config
