vim.lsp.enable("bashls")

local chezmoi_pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "git_config" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
    },
  },

  -- highlighting for chezmoi files template files
  {
    "alker0/chezmoi.vim",
    event = { "BufRead " .. chezmoi_pattern, "BufNewFile " .. chezmoi_pattern },
    init = function() vim.g["chezmoi#use_tmp_buffer"] = true end,
  },
  {
    "xvzc/chezmoi.nvim",
    cmd = { "ChezmoiEdit" },
    event = { "BufRead " .. chezmoi_pattern, "BufNewFile " .. chezmoi_pattern },
    opts = {
      notifications = { on_watch = true },
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { chezmoi_pattern },
        callback = function(ev)
          vim.schedule(function() require("chezmoi.commands.__edit").watch(ev.buf) end)
        end,
      })
    end,
  },
}
