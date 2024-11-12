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
          single_file_support = true,
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
    -- build = function()
    -- _G.t1 = _G.c == true
    -- require("typst-preview.config").opts.dependencies_bin["tinymist"] = "tinymist"
    -- require("typst-preview").update()
    -- _G.t2 = _G.c == true
    -- end,
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
        -- tinymist = "tinymist",
      },
    },
    -- config = function(_, opts)
    --   _G.c = false
    --   require("typst-preview").setup(opts)
    --   _G.c = true
    -- end,
  },
}
