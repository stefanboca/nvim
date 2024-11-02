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
  {
    "willothy/flatten.nvim",
    opts = {},
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },

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
        on_tree_mount = function(context)
          M.wk_desc(context.buf)
        end,
        on_diff_mount = function(context)
          M.wk_desc(context.buf)
        end,
      },
    },
  },

  {
    "avm99963/vim-jjdescription",
    ft = { "jj", "jjdescription" },
  },

  {
    "Cretezy/neo-tree-jj.nvim",
    enabled = false,
    dependencies = {
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          if require("neo-tree.sources.jj.utils").get_repository_root() then
            -- Register the source
            table.insert(opts.sources, "jj")
          end
        end,
      },
    },
  },
}
