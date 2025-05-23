return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "toml" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "taplo" } },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        toml = { "taplo" },
      },
    },
  },
}
