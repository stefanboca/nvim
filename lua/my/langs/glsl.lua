return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "glsl" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "glsl_analyzer" } },
  },
}
