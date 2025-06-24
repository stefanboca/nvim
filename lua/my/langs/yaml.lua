return {
  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "yamlls" } },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enable = { "yaml" } },
  },

  { "b0o/SchemaStore.nvim" },
}
