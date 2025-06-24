return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "java" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "jdtls" } },
  },
}
