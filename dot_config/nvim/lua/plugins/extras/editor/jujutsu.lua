local function wk_desc(buf)
  local wk = require("which-key")
  wk.add({
    { "<localleader><CR>", desc = "Accept changeset" },
    { "<localleader>e", desc = "Focus tree" },
    buffer = buf,
  })
end

return {
  {
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
        on_tree_mount = function(context) wk_desc(context.buf) end,
        on_diff_mount = function(context) wk_desc(context.buf) end,
      },
    },
  },

  {
    "avm99963/vim-jjdescription",
    ft = { "jj", "jjdescription" },
  },
}
