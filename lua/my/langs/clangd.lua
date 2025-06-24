return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "c", "cpp" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "clangd" } },
  },
}
