-- mostly a copy of https://github.com/LazyVim/LazyVim/pull/4042 until it's merged

return {
  -- recommended = function()
  --   return LazyVim.extras.wants({
  --     ft = { "typst" },
  --   })
  -- end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "tinymist",
      },
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
        ["tinymist"] = "tinymist",
      },
    },
  },
}
