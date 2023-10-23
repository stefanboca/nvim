local M = {}

function M.apply(config)
	config.enable_wayland = false
	config.webgpu_power_preference = "HighPerformance"
end

return M
