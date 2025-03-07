vim.bo.textwidth = 80

-- add autopairs
local success, pairs = pcall(require, "mini.pairs")
if success then
  pairs.map_buf(0, "i", " ", { action = "open", pair = "  ", neigh_pattern = "%$%$" })
  pairs.map_buf(0, "i", "$", { action = "closeopen", pair = "$$" })
  pairs.map_buf(0, "i", "`", { action = "closeopen", pair = "``" })

  -- * and _ are not autopaired because they can be used in math equations
end

vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<localleader>s",
  "<cmd>TypstPreviewSyncCursor<cr>",
  { desc = "Typst Preview Sync Cursor" }
)
