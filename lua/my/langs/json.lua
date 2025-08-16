return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "json", "jsonc", "json5" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "jsonls" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "biome" },
        jsonc = { "biome" },
        json5 = { "biome" },
      },
    },
  },
}
