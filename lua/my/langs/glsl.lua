return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "glsl" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "glsl_analyzer" } },
  },
}
