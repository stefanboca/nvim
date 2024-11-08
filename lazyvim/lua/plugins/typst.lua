-- mostly a copy of https://github.com/LazyVim/LazyVim/pull/4042 until it's merged

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          settings = {
            formatterMode = "typstyle",
          },
          -- single_file_support = true,
          root_dir = function()
            return LazyVim.root.get()
          end,
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        typst = { "typstyle", lsp_format = "prefer" },
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview" },
    build = function(plugin)
      local typst_preview = require("typst-preview")
      typst_preview.setup(plugin.opts)
      typst_preview.update()
    end,
    keys = {
      {
        "<leader>cp",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Typst Preview",
      },
    },
    opts = {
      dependencies_bin = {
        tinymist = "tinymist",
      },
    },
  },
}
