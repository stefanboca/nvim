return {
  {
    "neovim/nvim-treesitter",
    opts = { enable = { "typst", "dot" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "tinymist" }, on_attach = { tinymist = require("my.utils.tinymist").on_attach } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters = { typstyle = { prepend_args = { "--wrap-text", "--column", "100" } } },
      formatters_by_ft = { typst = { "typstyle" } },
    },
  },
}
