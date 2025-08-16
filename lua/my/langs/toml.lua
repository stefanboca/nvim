return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "toml" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "tombi" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        toml = { "tombi" },
      },
    },
  },
}
