-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")

-- Remap diagnostic jumps to not open float and not wrap
local diagnostic_goto = function(next, severity)
  local opts = {
    count = next and 1 or -1,
    severity = vim.diagnostic.severity[severity],
    wrap = false,
    float = false,
  }
  return function()
    vim.diagnostic.jump(opts)
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Remap macro recording to 'Q' instead of 'q'
wk.add({ "q", "<nop>", mode = "n", hidden = true })
map("n", "Q", "q", { desc = "Record macro", noremap = true })
