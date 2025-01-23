local function wk_desc(buf)
  local wk = require("which-key")
  wk.add({
    { "<localleader><CR>", desc = "Accept changeset" },
    { "<localleader>e", desc = "Focus tree" },
    buffer = buf,
  })
end

local saved_terminal = nil

return {
  -- Un-nest neovim instances
  {
    "willothy/flatten.nvim",
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 50001,
    opts = {
      window = {
        open = "alternate",
      },
      block_for = {
        jj = true,
        jjdescription = true,
      },
      nest_if_no_args = true,
      hooks = {
        pre_open = function()
          saved_terminal, _ = Snacks.terminal.get(nil, { cwd = LazyVim.root(), create = false })
        end,
        post_open = function(opts)
          if opts.is_blocking and saved_terminal then
            saved_terminal:hide()
          else
            vim.api.nvim_set_current_win(opts.winnr)
          end
        end,
        block_end = vim.schedule_wrap(function()
          if saved_terminal then
            saved_terminal:show()
          end
          saved_terminal = nil
        end),
      },
    },
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
          wk_desc(context.buf)
        end,
        on_diff_mount = function(context)
          wk_desc(context.buf)
        end,
      },
    },
  },

  {
    "avm99963/vim-jjdescription",
    ft = { "jj", "jjdescription" },
  },
}
