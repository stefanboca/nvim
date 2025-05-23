return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typst" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "tinymist" } },
  },

  {
    "stevearc/conform.nvim",
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters = {
        typstyle = {
          prepend_args = { "--wrap-text", "--column", "100" },
        },
      },
      formatters_by_ft = {
        typst = { "typstyle" },
      },
    },
  },

  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        typst = { "// %s", "/* %s */" },
      },
    },
  },
}
