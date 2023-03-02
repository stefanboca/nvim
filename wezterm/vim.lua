local M = {}
local wezterm = require("wezterm")

local direction_wez_to_vim = {
    Left = "h",
    Down = "j",
    Up = "k",
    Right = "l",
}

M.keys = {
    { key = "h", mods = "CTRL", action = wezterm.action({ EmitEvent = "MoveLeft" }) },
    { key = "l", mods = "CTRL", action = wezterm.action({ EmitEvent = "MoveRight" }) },
    { key = "k", mods = "CTRL", action = wezterm.action({ EmitEvent = "MoveUp" }) },
    { key = "j", mods = "CTRL", action = wezterm.action({ EmitEvent = "MoveDown" }) },
}

M.is_vim = function(pane)
    return pane:get_foreground_process_name():find('n?vim') ~= nil
end

M.move = function(window, pane, direction)
    if M.is_vim(pane) then
        window:perform_action(
            wezterm.action.SendKey({ key = direction_wez_to_vim[direction], mods = 'CTRL' }),
            pane
        )
    else
        window:perform_action(wezterm.action({ ActivatePaneDirection = direction }), pane)
    end
end

-- TODO: resize

M.setup = function(keys)
    for direction, _ in pairs(direction_wez_to_vim) do
        wezterm.on("Move" .. direction, function(window, pane)
            M.move(window, pane, direction)
        end)
    end

    for _, v in pairs(M.keys) do
        table.insert(keys, v)
    end
end

return M
