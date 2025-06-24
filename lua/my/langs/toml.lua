return {
  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "tombi" } },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "toml" } },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        toml = { "tombi" },
      },
    },
  },
}
