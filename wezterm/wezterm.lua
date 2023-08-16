local wezterm = require("wezterm")
local vim = require("vim")

local keys = {
    -- { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
}

vim.setup(keys)

-- TODO: each module exports an object containing some config, which all get merged
local config = {
    font = wezterm.font {
        family = "Fira Code",
    },
    font_size = 10,
    color_scheme = "Lunar",
    color_schemes = require("color_schemes"),
    keys = keys,
}

-- for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
--     if gpu.backend == 'Vulkan' and gpu.device_type == 'DiscreteGpu' then
--         config.webgpu_preferred_adapter = gpu
--         config.front_end = 'WebGpu'
--         break
--     end
-- end

return config
