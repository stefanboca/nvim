return {
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
