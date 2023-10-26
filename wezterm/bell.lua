local M = {}

function M.apply(config)
	config.audible_bell = "SystemBeep"
	config.visual_bell = {
		fade_in_duration_ms = 0,
		fade_out_duration_ms = 0,
		fade_in_function = "Constant",
		fade_out_function = "Constant",
		target = "BackgroundColor",
	}
end

return M
