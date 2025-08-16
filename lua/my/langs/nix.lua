return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "nix" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "nil_ls" } },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "alejandra" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { nix = { "deadnix", "statix" } },
    },
  },
}
