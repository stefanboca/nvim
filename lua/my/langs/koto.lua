vim.filetype.add({ extension = { koto = "koto" } })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "koto" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "koto" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters = { koto = { command = "koto", args = { "--format" } } },
      formatters_by_ft = { koto = { "koto" } },
    },
  },
}
