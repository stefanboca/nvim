local wezterm = require("wezterm")

local config = wezterm.config_builder()

local modules = {
	"front_end",
	"appearence",
	"keys",
}

for _, module in ipairs(modules) do
	require(module).apply(config)
end

config.debug_key_events = true

return config
