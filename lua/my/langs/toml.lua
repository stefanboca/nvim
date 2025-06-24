return {
  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "tombi" } },
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
