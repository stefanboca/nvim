return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "just" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "just" } },
  },
}
