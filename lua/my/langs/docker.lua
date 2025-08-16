return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "dockerfile" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "docker-language-server" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { docker = { "dockerfmt" } },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { dockerfile = { "hadolint" } },
    },
  },
}
