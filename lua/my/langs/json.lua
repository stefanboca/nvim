return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "json", "jsonc", "json5" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "jsonls" } },
  },

  { "b0o/SchemaStore.nvim" },
}
