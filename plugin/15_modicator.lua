-- Sets the current line's color based on the current mode
-- Equivalent to modicator but fast
local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)
local mode_hl_groups = {
  ["n"] = "MiniStatuslineModeNormal",
  ["v"] = "MiniStatuslineModeVisual",
  ["V"] = "MiniStatuslineModeVisual",
  [CTRL_V] = "MiniStatuslineModeVisual",
  ["s"] = "MiniStatuslineModeVisual",
  ["S"] = "MiniStatuslineModeVisual",
  [CTRL_S] = "MiniStatuslineModeVisual",
  ["i"] = "MiniStatuslineModeInsert",
  ["R"] = "MiniStatuslineModeReplace",
  ["c"] = "MiniStatuslineModeCommand",
}
_G.Config.new_autocmd({ "BufEnter", "ModeChanged" }, nil, function()
  local mode = vim.api.nvim_get_mode().mode
  local mode_hl_group = mode_hl_groups[mode] or "MiniStatuslineModeOther"
  local cursorline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false, create = false })
  local hl = vim.api.nvim_get_hl(0, { name = mode_hl_group, link = false, create = false })
  hl = vim.tbl_extend("force", cursorline_hl, { fg = hl.bg, bold = true })
  vim.api.nvim_set_hl(0, "CursorLineNr", hl)
end, "Modicator")
