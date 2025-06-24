return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "just" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "just" } },
  },

  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { just = { "just" } } },
  },
}
