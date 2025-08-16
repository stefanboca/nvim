return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "yaml" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "yamlls" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- In progress (see https://biomejs.dev/internals/language-support/):
        -- yaml = { "biome" },
        -- use prettierd for now:
        yaml = { "prettierd" },
      },
    },
  },
}
