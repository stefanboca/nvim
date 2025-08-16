return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "c", "cpp" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "clangd" } },
  },
}
