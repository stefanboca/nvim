return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "zig" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "zls" } },
  },
}
