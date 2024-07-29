local M = {}

function M.wk_desc(buf)
  local wk = require("which-key")
  wk.add({
    { "<localleader><CR>", desc = "Accept changeset" },
    { "<localleader>e", desc = "Focus tree" },
    buffer = buf,
  })
end

return {
  "julienvincent/hunk.nvim",
  cmd = { "DiffEditor" },
  opts = {
    keys = {
      global = {
        accept = { "<localleader><CR>" },
        focus_tree = { "<localleader>e" },
      },
    },
    hooks = {
      on_tree_mount = function(context)
        M.wk_desc(context.buf)
      end,
      on_diff_mount = function(context)
        M.wk_desc(context.buf)
      end,
    },
  },
}
