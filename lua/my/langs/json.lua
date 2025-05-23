return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "jsonc", "json5" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "jsonls" } },
  },

  { "b0o/SchemaStore.nvim" },
}
