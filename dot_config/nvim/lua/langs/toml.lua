vim.lsp.enable("taplo")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "toml" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "taplo" } },
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
