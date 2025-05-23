return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "git_config" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "bashls", "fish_lsp" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      linters_by_ft = { fish = { "fish" } },
    },
  },
}
