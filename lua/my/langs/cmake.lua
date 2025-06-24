return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "cmake" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "neocmake" } },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { cmake = { "cmakelint" } },
    },
  },
}
