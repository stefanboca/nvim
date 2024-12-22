-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")

-- Remap macro recording to 'Q' instead of 'q'
wk.add({ "q", "<nop>", mode = "n", hidden = true })
map("n", "Q", "q", { desc = "Record macro", noremap = true })
