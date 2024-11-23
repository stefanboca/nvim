-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("typst"),
  pattern = { "typst" },
  callback = function(event)
    local bufnr = event.buf
    vim.bo[bufnr].textwidth = 80

    local pairs = require("mini.pairs")
    pairs.map_buf(bufnr, "i", " ", { action = "open", pair = "  ", neigh_pattern = "%$%$" })
    pairs.map_buf(bufnr, "i", "$", { action = "closeopen", pair = "$$" })
  end,
})
