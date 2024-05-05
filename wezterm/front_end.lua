local M = {}

function M.apply(config)
	config.front_end = "WebGpu"
	config.enable_wayland = true
	config.webgpu_power_preference = "HighPerformance"
end

return M
